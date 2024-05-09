import { Module } from '@prisma/client'
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()
const getAllModules = async (): Promise<Module[]> => {
	const allModules: Module[] = await prisma.module.findMany()
	return allModules
}

const ModuleService = {
	getAllModules
}

export default ModuleService
