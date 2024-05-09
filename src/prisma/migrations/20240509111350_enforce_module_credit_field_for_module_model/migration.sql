/*
  Warnings:

  - You are about to drop the column `code` on the `Module` table. All the data in the column will be lost.
  - You are about to drop the column `credit` on the `Module` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[moduleCode]` on the table `Module` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "Module_code_key";

-- AlterTable
ALTER TABLE "Module" DROP COLUMN "code",
DROP COLUMN "credit",
ADD COLUMN     "moduleCredit" INTEGER;

-- CreateIndex
CREATE UNIQUE INDEX "Module_moduleCode_key" ON "Module"("moduleCode");
