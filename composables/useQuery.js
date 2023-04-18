import mysql from 'mysql2/promise'
const CONFIG = useRuntimeConfig()

export default function useQuery() {
	async function doDBQuery(sql, inserts) {
		// console.log('IN dbquery sql = ', sql)

		const CONN = await mysql.createPoo({
			host: CONFIG.DB_HOST,
			user: CONFIG.DB_USER,
			password: CONFIG.DB_PASSWORD,
			database: CONFIG.DB_DATABASE,
		})
		if (inserts) {
			const sqlFinal = mysql.format(sql, inserts)
		}

		// console.log('IN dbquery sqlFinal = ', sqlFinal)
		const [rows, fields] = await CONN.execute(sqlFinal)
		await CONN.end()
		return rows
	}
	return {
		doDBQuery,
	}
}
