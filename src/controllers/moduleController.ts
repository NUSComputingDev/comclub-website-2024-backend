import { Module } from '@prisma/client'
import { Request, Response } from 'express'

import ModuleService from '../services/moduleService'

const GetAllModules = async (req: Request, res: Response) => {
	try {
		const nusModules: Module[] = await ModuleService.getAllModules()
		res.json(nusModules)
	} catch (err) {
		res.status(500).json({ message: err.message })
	}
}

const ModuleControler = {
	GetAllModules
}

export default ModuleControler
