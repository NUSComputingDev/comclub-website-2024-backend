import pg from "pg";
import * as dotenv from "dotenv";
dotenv.config()

const { Pool } = pg;

const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
});

export const query = async (text, params, callback) => pool.query(text, params, callback);