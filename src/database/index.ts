import * as dotenv from 'dotenv'
import pg from 'pg'

dotenv.config()

const { Pool } = pg

const pool: pg.Pool = new Pool({
	user: process.env.DB_USER,
	host: process.env.DB_HOST,
	database: process.env.DB_NAME,
	password: process.env.DB_PASSWORD,
	port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : undefined
})

export const query = async (text: string, callback?: any) => pool.query(text, callback)
