import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

export const deleteDatabase = async (): Promise<void> => {
	console.log("Deleting Modules in Database...")
	await prisma.module.deleteMany()
	console.log("Modules Deleted")
}
