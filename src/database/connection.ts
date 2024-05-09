import Express from 'express'

import { query } from '../database/index'

const router = Express.Router()

// THIS IS JUST A ROUTE TO CHECK THE DB CONNECTION / CHECK WHETHER ROUTES ARE WORKING
router.get('/', async (req, res) => {
	const { rows } = await query('SELECT version();')

	console.log('Connected to PostgreSQL:', rows[0])

	res.send(rows[0])
})

export default router
