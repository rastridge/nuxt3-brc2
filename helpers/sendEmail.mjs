// const querystring = require('querystring')
// const https = require('https')
const { EE_API_KEY } = useRuntimeConfig()

// const EE_API_KEY =
// 	'AC23582ABAD91D02E56C1F489129EFDED49D96139F826C1A718B9E807FE3BB412703FAF0D18D26767D0D46D4E8760B01'
import querystring from 'querystring'
import https from 'https'

export default function sendEmail(email) {
	// Single email - script from ElasticEmail
	const post_data = querystring.stringify({
		api_key: EE_API_KEY,
		subject: email.subject,
		from: email.from,
		from_name: email.from_name,
		to: email.to,
		// to: "rfa@me.com",
		body_html: email.body_html,
		body_text: email.body_text,
		isTransactional: true,
	})

	const post_options = {
		hostname: 'api.elasticemail.com',
		path: '/v2/email/send',
		port: '443',
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'Content-Length': post_data.length,
		},
	}

	let result = ''
	const post_req = https.request(post_options, function (res) {
		res.setEncoding('utf8')
		res.on('data', function (chunk) {
			result = chunk
			const { statusCode, statusMessage, headers } = res
		})
		res.on('error', function (e) {
			result = 'Error: ' + e.message
		})
	})

	post_req.write(post_data)
	post_req.end()
}
