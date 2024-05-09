import { PrismaClient, Module } from '@prisma/client'

import ApiController from '../controllers/apiController'
import { NusModsModule } from '../models/modules'
import ApiService from '../services/apiService'
import ModuleService from '../services/moduleService'

const prisma = new PrismaClient()

export const seedDatabase = async (): Promise<void> => {
	const modules: Module[] = await ModuleService.getAllModules()
	if (Array.isArray(modules) && modules.length == 0) {
		console.log('No Modules Found in Database...')
		const nusModsRespData: NusModsModule[] = await ApiService.getNusModsAllModules()
		if (nusModsRespData.length > 0) {
			console.log('Seeding Data from NUSMODS Api...')
			// extracting target modules
			const targetModuleCodes: string[] = ApiController.extractTargetModules(nusModsRespData)
			const modulesArr = await ApiController.convertNusModsModuleToComClub(targetModuleCodes)
			await prisma.module.createMany({
				data: [...modulesArr]
			})
			console.log('Seeding Completed')
		}
	}
}
