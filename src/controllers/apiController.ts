import { Module, Semester } from '@prisma/client'

import { TARGET_MOD_PREFIX, TARGET_MOD_PREFIX_ARR } from '../_shared/enums'
import { NusModsModule, NusModsModuleInfoV2, NusModsSpecificModuleInfo } from '../models/modules'
import ApiService from '../services/apiService'

/* Extract all Computing-Related Modules */
const extractTargetModules = (data: NusModsModule[]): string[] => {
	const targetModArr: NusModsModule[] = data.reduce<NusModsModule[]>((prev, current) => {
		const isTargetMod: boolean = TARGET_MOD_PREFIX_ARR.some((targetCode) =>
			current.moduleCode.includes(targetCode)
		)
		if (isTargetMod) {
			return [...prev, current]
		} else return prev
	}, [])

	const targetModuleCodeArr: string[] = targetModArr.map((targetMod) => targetMod.moduleCode)
	console.log(targetModuleCodeArr)
	console.log(targetModuleCodeArr.length)
	return targetModuleCodeArr
}

const convertNusModsModuleToComClub = async (data: string[]) => {
	const promiseArr: Promise<NusModsSpecificModuleInfo | null>[] = data.map((moduleCode) => {
		return new Promise(async (resolve, reject) => {
			const specifcModResp: NusModsSpecificModuleInfo =
				await ApiService.getNusModSpecificMod(moduleCode)
			if (!!specifcModResp) {
				resolve(specifcModResp)
			} else {
				reject(new Error('No Module Code found'))
			}
		})
	})

	// await all promises
	console.log('Pulling Specific Module Data from NUSMods API')
	const specificModArr: NusModsSpecificModuleInfo[] = await Promise.all(promiseArr)

	return specificModArr.map((nusMod: NusModsSpecificModuleInfo) => {
		const {
			moduleCode,
			moduleCredit,
			title,
			department,
			faculty,
			semesterData,
			attributes,
			description
		} = nusMod

		// retrieve semester details
		const semesterOffered: Semester[] = semesterData
			.map((semester) => {
				switch (semester.semester) {
					case 1:
						return Semester.SEMESTER_1
					case 2:
						return Semester.SEMESTER_2
					default:
						return undefined
				}
			})
			.filter((semester): semester is Semester => semester !== undefined)

		// retrieve SU details
		const canSU: boolean = attributes?.su ?? false

		return {
			moduleCode,
			moduleCredit,
			title,
			description,
			department,
			faculty,
			semesterOffered,
			aliases: [],
			canSU
		}
	})
}

const ApiController = {
	extractTargetModules,
	convertNusModsModuleToComClub
}

export default ApiController
