import axios from 'axios'
import { AxiosResponse } from 'axios'
import * as dotenv from 'dotenv'

import { NusModsModule, NusModsModuleInfoV2, NusModsSpecificModuleInfo } from '../models/modules'

dotenv.config()

const getNusModsAllModules = async (): Promise<NusModsModule[]> => {
	const res: AxiosResponse = await axios.get<NusModsModule>(
		`${process.env.NUS_MODS_BASE_PATH}2023-2024/moduleList.json`
	)
	if (res.status === 200) {
		return res.data
	} else {
		return []
	}
}

const getNusModsAllModulesInfo = async (): Promise<NusModsModuleInfoV2[]> => {
	const res: AxiosResponse = await axios.get<NusModsModuleInfoV2>(
		`${process.env.NUS_MODS_BASE_PATH}2023-2024/moduleInfo.json`
	)
	if (res.status === 200) {
		return res.data
	} else {
		return []
	}
}

const getNusModSpecificMod = async (
	moduleCode: string
): Promise<NusModsSpecificModuleInfo | null> => {
	const res: AxiosResponse = await axios.get<NusModsSpecificModuleInfo>(
		`${process.env.NUS_MODS_BASE_PATH}2023-2024/modules/${moduleCode}.json`
	)
	if (res.status === 200) {
		return res.data
	} else {
		return null
	}
}

const ApiService = {
	getNusModsAllModules,
	getNusModsAllModulesInfo,
	getNusModSpecificMod
}

export default ApiService
