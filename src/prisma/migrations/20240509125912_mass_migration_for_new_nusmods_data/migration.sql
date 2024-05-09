/*
  Warnings:

  - The values [SPECIAL_TERM_1,SPECIAL_TERM_2] on the enum `Semester` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `name` on the `Module` table. All the data in the column will be lost.
  - You are about to drop the column `prerequisiteTree` on the `Module` table. All the data in the column will be lost.
  - You are about to drop the `Exemption` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MCExemption` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ModuleExemption` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `RawLesson` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `description` on table `Module` required. This step will fail if there are existing NULL values in that column.
  - Made the column `faculty` on table `Module` required. This step will fail if there are existing NULL values in that column.
  - Made the column `canSU` on table `Module` required. This step will fail if there are existing NULL values in that column.
  - Made the column `moduleCode` on table `Module` required. This step will fail if there are existing NULL values in that column.
  - Made the column `title` on table `Module` required. This step will fail if there are existing NULL values in that column.
  - Made the column `moduleCredit` on table `Module` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Semester_new" AS ENUM ('SEMESTER_1', 'SEMESTER_2');
ALTER TABLE "Module" ALTER COLUMN "semesterOffered" TYPE "Semester_new"[] USING ("semesterOffered"::text::"Semester_new"[]);
ALTER TABLE "SemesterData" ALTER COLUMN "semester" TYPE "Semester_new" USING ("semester"::text::"Semester_new");
ALTER TYPE "Semester" RENAME TO "Semester_old";
ALTER TYPE "Semester_new" RENAME TO "Semester";
DROP TYPE "Semester_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "Corequisite" DROP CONSTRAINT "Corequisite_coreqModId_fkey";

-- DropForeignKey
ALTER TABLE "Corequisite" DROP CONSTRAINT "Corequisite_currentModId_fkey";

-- DropForeignKey
ALTER TABLE "MCExemption" DROP CONSTRAINT "MCExemption_exemptionId_fkey";

-- DropForeignKey
ALTER TABLE "ModuleExemption" DROP CONSTRAINT "ModuleExemption_exemptionId_fkey";

-- DropForeignKey
ALTER TABLE "ModuleExemption" DROP CONSTRAINT "ModuleExemption_moduleId_fkey";

-- DropForeignKey
ALTER TABLE "Preclusion" DROP CONSTRAINT "Preclusion_currentModuleId_fkey";

-- DropForeignKey
ALTER TABLE "Preclusion" DROP CONSTRAINT "Preclusion_precludeModuleId_fkey";

-- DropForeignKey
ALTER TABLE "Prerequisite" DROP CONSTRAINT "Prerequisite_currentModId_fkey";

-- DropForeignKey
ALTER TABLE "Prerequisite" DROP CONSTRAINT "Prerequisite_prereqModId_fkey";

-- DropForeignKey
ALTER TABLE "RawLesson" DROP CONSTRAINT "RawLesson_moduleId_fkey";

-- AlterTable
ALTER TABLE "Corequisite" ALTER COLUMN "currentModId" DROP NOT NULL,
ALTER COLUMN "coreqModId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Module" DROP COLUMN "name",
DROP COLUMN "prerequisiteTree",
ALTER COLUMN "description" SET NOT NULL,
ALTER COLUMN "faculty" SET NOT NULL,
ALTER COLUMN "canSU" SET NOT NULL,
ALTER COLUMN "moduleCode" SET NOT NULL,
ALTER COLUMN "title" SET NOT NULL,
ALTER COLUMN "moduleCredit" SET NOT NULL;

-- AlterTable
ALTER TABLE "Preclusion" ALTER COLUMN "currentModuleId" DROP NOT NULL,
ALTER COLUMN "precludeModuleId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Prerequisite" ALTER COLUMN "currentModId" DROP NOT NULL,
ALTER COLUMN "prereqModId" DROP NOT NULL;

-- DropTable
DROP TABLE "Exemption";

-- DropTable
DROP TABLE "MCExemption";

-- DropTable
DROP TABLE "ModuleExemption";

-- DropTable
DROP TABLE "RawLesson";

-- AddForeignKey
ALTER TABLE "Prerequisite" ADD CONSTRAINT "Prerequisite_currentModId_fkey" FOREIGN KEY ("currentModId") REFERENCES "Module"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prerequisite" ADD CONSTRAINT "Prerequisite_prereqModId_fkey" FOREIGN KEY ("prereqModId") REFERENCES "Module"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Corequisite" ADD CONSTRAINT "Corequisite_currentModId_fkey" FOREIGN KEY ("currentModId") REFERENCES "Module"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Corequisite" ADD CONSTRAINT "Corequisite_coreqModId_fkey" FOREIGN KEY ("coreqModId") REFERENCES "Module"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Preclusion" ADD CONSTRAINT "Preclusion_currentModuleId_fkey" FOREIGN KEY ("currentModuleId") REFERENCES "Module"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Preclusion" ADD CONSTRAINT "Preclusion_precludeModuleId_fkey" FOREIGN KEY ("precludeModuleId") REFERENCES "Module"("id") ON DELETE SET NULL ON UPDATE CASCADE;
