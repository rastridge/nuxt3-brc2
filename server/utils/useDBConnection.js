import mysql from 'mysql2/promise'

export default function useDBConnection() {
	async function getConnection() {
		const CONFIG = useRuntimeConfig()

		const conn = await mysql.createPool({
			host: CONFIG.DB_HOST,
			user: CONFIG.DB_USER,
			password: CONFIG.DB_PASSWORD,
			database: CONFIG.DB_DATABASE,
		})
		return conn
	}
	return {
		getConnection,
	}
}