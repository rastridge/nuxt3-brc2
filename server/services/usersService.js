﻿import mysql from 'mysql2/promise'
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
const { EE_API_KEY } = useRuntimeConfig()
const { sendEmail } = useEmail()
const { doDBQuery } = useQuery()
const { getConnection } = useDBConnection()

// import querystring from 'querystring'
// import https from 'https'
const config = useRuntimeConfig()

export const usersService = {
	authenticate,
	getAll,
	getOne,
	addOne,
	editOne,
	getApps,
	getAppPerms,
	_setPerms,
	// initPerms,
	resetRequest,
	resetPassword,
	deleteOne,
	changeStatus,
}

/***************************************** */
/*              _setPerms                  */
/*                                         */
/***************************************** */
async function _setPerms(aPerms, id) {
	const sql = `DELETE
            FROM
                inbrc_admin_perms
            WHERE
                admin_user_id = ${id}`

	await doDBQuery(sql)

	// loop through permissions array
	aPerms.forEach(myFunction)

	// add new permission record
	async function myFunction(value, index) {
		const sql = `INSERT
								INTO inbrc_admin_perms
										(
												admin_user_id,
												admin_app_id,
												admin_perm
										) values (
												${value.admin_user_id},
												${value.admin_app_id},
												${value.admin_perm}
										)`
		await doDBQuery(sql)
	}
	return true
}
/***************************************** */
/*              _getPerms                  */
/***************************************** */

async function _getPerms(id) {
	// need this to include app name in perms
	const sql = `SELECT
								p.admin_perm_id, a.admin_app_id, a.admin_app_name, p.admin_perm, u.admin_user_id
							FROM
								inbrc_admin_perms p, inbrc_admin_apps a, inbrc_admin_users u
							WHERE
								a.admin_app_id = p.admin_app_id
								AND
								u.admin_user_id = p.admin_user_id
								AND
								p.admin_user_id  = ${id}
								ORDER BY a.admin_app_name ASC`

	const perms = await doDBQuery(sql)

	return perms
}
/***************************************** */
/*              authenicate                */
/***************************************** */
async function authenticate({ username, password }) {
	const lc_admin_user_name = username.toLowerCase()
	const sql = `SELECT *
								FROM inbrc_admin_users
								WHERE deleted = 0`

	const users = await doDBQuery(sql)

	let user = users.find((u) => {
		let match = false

		/* 		console.log(
			'compare ',
			password,
			u.admin_user_pass,
			bcrypt.compareSync(password, u.admin_user_pass)
		)
		console.log(
			'compare ',
			u.admin_user_name,
			lc_admin_user_name,
			u.admin_user_name === lc_admin_user_name
		) */

		if (
			u.admin_user_name === lc_admin_user_name &&
			bcrypt.compareSync(password, u.admin_user_pass)
		) {
			match = true
		} else {
			match = false
		}
		return match
	})

	if (user) {
		user.match = true

		// there is a user with matching username and password
		// add permissions to user
		const perms = await _getPerms(user.admin_user_id)
		user.perms = perms
		const token = await jwt.sign(user.admin_user_id, config.apiSecret)
		user.token = token
	} else {
		user = { match: false }
	}
	// console.log('IN authenticate user.match = ', user.match)
	return user
}
/***************************************** */
/*              getAll                     */
/***************************************** */

async function getAll() {
	const sql = `select
									admin_user_name as title,
									modified_dt as dt,
									admin_user_id as id,
									STATUS as status
								from inbrc_admin_users
								where deleted = 0`
	const users = await doDBQuery(sql)

	return users
}
/***************************************** */
/*              getOne                     */
/***************************************** */
async function getOne(id) {
	const sql = `SELECT *
								FROM inbrc_admin_users
								WHERE admin_user_id = ${id}`

	const user = await doDBQuery(sql)
	const perms = await _getPerms(id)
	let jsObj2 = perms
	let jsObj = user[0]
	jsObj.perms = jsObj2
	return jsObj
}

async function deleteOne(id) {
	const sql =
		`UPDATE inbrc_admin_users
								SET deleted=1, deleted_dt= NOW()
								WHERE admin_user_id=` + id

	const user = await doDBQuery(sql)

	return user
}
/***************************************** */
/*              addOne                     */
/***************************************** */
async function addOne({ admin_user_name, password, admin_user_email, perms }) {
	try {
		const conn = await getConnection()
		await conn.query('START TRANSACTION')

		// check for existing username or email
		let sql = `select *
							from inbrc_admin_users
							where deleted = 0`
		const [rows, fields] = await conn.execute(sql)
		const users = rows

		const lc_admin_user_name = admin_user_name.toLowerCase()
		const lc_admin_user_email = admin_user_email.toLowerCase()

		let user = users.find(
			(u) =>
				u.admin_user_name === lc_admin_user_name ||
				u.admin_user_email === lc_admin_user_email
		)

		if (!user) {
			// no other users with same username or email
			// hash password
			const saltRounds = 10
			const salt = bcrypt.genSaltSync(saltRounds)
			const hashedpassword = bcrypt.hashSync(password, salt)
			// inser new user
			let sql = `INSERT INTO
										inbrc_admin_users
									SET
										admin_user_name  = ?,
										admin_user_pass  = ?,
										admin_user_email  = ?,
										status = 1,
										created_dt = NOW(),
										modified_dt = NOW()`

			let inserts = []
			inserts.push(lc_admin_user_name, hashedpassword, lc_admin_user_email)
			sql = mysql.format(sql, inserts)
			console.log('INSert INTO inbrc_admin_users sql = ', sql)
			const [rows, fields] = await conn.execute(sql)
			user = rows
			// save id of new user
			const id = user.insertId
			console.log('1 user.insertId = ', user.insertId)

			// initial permissions with view only

			for (let p of perms) {
				sql = `INSERT INTO 
									inbrc_admin_perms
								SET
									admin_user_id = ?,
									admin_app_id = ?,
									admin_perm = ?`

				inserts = []
				inserts.push(id, p.admin_app_id, p.admin_perm)
				sql = mysql.format(sql, inserts)
				// console.log('INSERT INTO inbrc_admin_perms sql= ', sql)

				await conn.execute(sql)
				console.log(
					'INSERT INTO inbrc_admin_perms id, p.admin_app_id, p.admin_perm= ',
					id,
					p.admin_app_id,
					p.admin_perm
				)
			}

			const msg =
				'An account for user ' +
				lc_admin_user_name +
				'  has been created, password = ' +
				password +
				' email = ' +
				lc_admin_user_email
			const emaildata = {
				from: config.FROM,
				fromName: config.FROM_NAME,
				to: 'ron.astridge@me.com',
				subject: 'Buffalo Rugby Club Admin Account Modification',
				body_text: '',
				body_html: '<h3>' + msg + '</h3>',
			}
			// console.log('4 emaildata= ', emaildata)
			sendEmail(emaildata)
		} else {
			const msg =
				'A user with username ' +
				lc_admin_user_name +
				' or email ' +
				lc_admin_user_email +
				' already exists'

			user = { message: msg }
			console.log('EXISTS ', msg)

			const emaildata = {
				from: config.FROM,
				fromName: config.FROM_NAME,
				to: 'ron.astridge@me.com',
				subject: 'Buffalo Rugby Club Admin Account Modification',
				body_text: '',
				body_html: '<h3>' + msg + '</h3>',
			}

			sendEmail(emaildata)
		}

		await conn.query('COMMIT')
		await conn.end()
		console.log('userservice addOne COMMIT')
		return user
	} catch (e) {
		await conn.query('ROLLBACK')
		await conn.end()
		console.log('userservice addOne ROLLBACK')
	}
}
/***************************************** */
/*              editOne                    */
/***************************************** */

async function editOne(info) {
	const {
		admin_user_id,
		admin_user_name,
		admin_user_email,
		admin_user_pass,
		perms,
		password,
	} = info

	try {
		const conn = await getConnection()
		await conn.query('START TRANSACTION')

		// check for existing admin_user_name or admin_user_email
		let sql = `SELECT *
							FROM inbrc_admin_users
							WHERE
								deleted = 0 AND admin_user_id !=  ${admin_user_id}`
		const [rows, fields] = await conn.execute(sql)
		const users = rows

		const lc_admin_username = admin_user_name.toLowerCase()
		const lc_admin_user_email = admin_user_email.toLowerCase()

		let user = users.find((u) => {
			return (
				u.admin_user_name == lc_admin_username ||
				u.admin_user_email == lc_admin_user_email
			)
		})

		// if no other users with proposed username or email
		if (!user) {
			sql = `UPDATE inbrc_admin_users
							SET
									admin_user_name = ?,
									admin_user_email = ?,
									admin_user_pass = ?,
									modified_dt= NOW()
							WHERE
									admin_user_id = ?`

			// If user has reset password
			let inserts = []
			if (password.length > 0) {
				const salt = bcrypt.genSaltSync(10)
				const new_admin_user_pass = bcrypt.hashSync(password, salt)

				inserts.push(
					lc_admin_username,
					lc_admin_user_email,
					new_admin_user_pass,
					admin_user_id
				)
			} else {
				inserts.push(
					lc_admin_username,
					lc_admin_user_email,
					admin_user_pass,
					admin_user_id
				)
			}

			sql = mysql.format(sql, inserts)
			const [rows, fields] = await conn.execute(sql)
			user = rows

			// update user perms by deleting records - creating new
			sql = `DELETE
						FROM
							inbrc_admin_perms
						WHERE
							admin_user_id = ${admin_user_id}`

			await conn.execute(sql)

			// update perms
			// loop through existing perms array
			for (let p of perms) {
				sql = `INSERT
							INTO inbrc_admin_perms
								(
									admin_user_id,
									admin_app_id,
									admin_perm
								) values (
									${p.admin_user_id},
									${p.admin_app_id},
									${p.admin_perm}
								)`
				await conn.execute(sql)
			}
			const msg =
				'The account for admin user ' +
				lc_admin_username +
				'  has been modified, password = ' +
				password +
				' email = ' +
				lc_admin_user_email

			const emaildata = {
				from: config.FROM,
				fromName: config.FROM_NAME,
				to: 'ron.astridge@me.com',
				subject: 'BRC Member Account Modification',
				body_text: '',
				body_html: '<h3>' + msg + '</h3>',
			}
			sendEmail(emaildata)
		} else {
			const msg = 'A user with this username or email already exists'
			user = { message: msg }
			const emaildata = {
				from: config.FROM,
				fromName: config.FROM_NAME,
				to: 'ron.astridge@me.com',
				subject: 'BRC Member Account Modification',
				body_text: '',
				body_html: '<h3>' + msg + '</h3>',
			}
			// console.log(emaildata)
			console.log('EXISTS ', msg)

			sendEmail(emaildata)
		}

		await conn.query('COMMIT')
		await conn.end()
		console.log('userservice editOne COMMIT ')
		return user
	} catch (e) {
		await conn.query('ROLLBACK')
		await conn.end()
		console.log('userservice editOne ROLLBACK ')
	}
}
/***************************************** */
/*              changeStatus               */
/*                                         */
/***************************************** */
async function changeStatus({ id, status }) {
	const sql =
		`UPDATE inbrc_admin_users SET STATUS = "` +
		status +
		`" WHERE admin_user_id  = ` +
		id
	const user = await doDBQuery(sql)

	return user
}
/***************************************** */
/*              getApps                    */
/*                                         */
/***************************************** */
async function getApps() {
	const sql = `SELECT
                    admin_app_id,
                    admin_app_name
                FROM inbrc_admin_apps
                ORDER BY
                    admin_app_name`

	// console.log('in getApps sql = ', sql)
	const apps = await doDBQuery(sql)
	// console.log('in getApps after query apps = ', apps)

	return apps
}
/***************************************** */
/*              initPerms                  */
/*                                         */
/***************************************** */
/* async function initPerms() {
	const sql = `SELECT
								admin_app_id,
								admin_app_name
							FROM
								inbrc_admin_apps
							WHERE 1 
							ORDER BY
                    admin_app_id`

	const perms = await doDBQuery(sql)

	return perms
}
 */ /***************************************** */
/*              getAppPerms                */
/*                                         */
/***************************************** */
async function getAppPerms() {
	const sql = `SELECT
								admin_perm,
								admin_app_name,
								u.admin_user_id
							FROM
								inbrc_admin_apps as a,
								inbrc_admin_perms as p,
								inbrc_admin_users as u
							WHERE
								a.admin_app_id = p.admin_app_id
								AND
								p.admin_user_id = u.admin_user_id`

	const perms = await doDBQuery(sql)

	return perms
}
/***************************************** */
/*              resetRequest               */
/*                                         */
/***************************************** */
async function resetRequest({ username }) {
	// Find out if matching username exists
	const sql = `SELECT
								COUNT(*) as cnt,
								admin_user_email
							FROM
								inbrc_admin_users
							WHERE
								admin_user_name = '${username}'`

	const rows = await doDBQuery(sql)

	const cnt = rows[0].cnt
	const admin_user_email = rows[0].admin_user_email
	// if username exists
	if (cnt) {
		/* const msg =
			'To reset your user admin password <a href="http://localhost:58117/reset/' +
			username +
			'">Click here</a>' */
		const msg =
			'To reset your user admin password <a href="https://lustrous-halva-085afc.netlify.app/reset/' +
			username +
			'">Click here</a>'

		const email_data = {
			from: config.FROM,
			fromName: config.FROM_NAME,
			to: admin_user_email,
			subject: 'BRC Admin User Password Reset',
			body_text: '',
			body_html: '<h3>' + msg + '</h3>',
		}
		sendEmail(email_data)
	}
	return username
}

async function resetPassword({ username, password }) {
	// console.log('IN userservice resetPassword ', username, password)
	// update user password
	let sql = `UPDATE inbrc_admin_users
					SET
						admin_user_pass = ?,
						modified_dt= NOW()
					WHERE
						admin_user_name = ?`

	const hashedpassword = await bcrypt.hashSync(password, 10)
	let inserts = []
	inserts.push(hashedpassword, username)
	const result = await doDBQuery(sql, inserts)

	const email_data = {
		from: config.FROM,
		fromName: config.FROM_NAME,
		to: 'ron.astridge@me.com',
		subject: 'BRC Member Account Modification',
		body_text: '',
		body_html: `<h3>The password has been changed for ${username}. The new password is "${password}"</h3>`,
	}

	console.log(' IN resetpassword email_data = ', email_data)

	const sc = sendEmail(email_data)

	return 'Probably sent ok'
}
