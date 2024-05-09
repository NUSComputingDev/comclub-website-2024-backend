-- DropForeignKey
ALTER TABLE "Module" DROP CONSTRAINT "Module_coreId_fkey";

-- DropForeignKey
ALTER TABLE "Module" DROP CONSTRAINT "Module_electiveId_fkey";

-- DropForeignKey
ALTER TABLE "Module" DROP CONSTRAINT "Module_universityLevelRequirementId_fkey";

-- AlterTable
ALTER TABLE "Module" ADD COLUMN     "moduleCode" TEXT,
ALTER COLUMN "academicYear" DROP NOT NULL,
ALTER COLUMN "code" DROP NOT NULL,
ALTER COLUMN "name" DROP NOT NULL,
ALTER COLUMN "credit" DROP NOT NULL,
ALTER COLUMN "faculty" DROP NOT NULL,
ALTER COLUMN "department" DROP NOT NULL,
ALTER COLUMN "canSU" DROP NOT NULL,
ALTER COLUMN "coreId" DROP NOT NULL,
ALTER COLUMN "electiveId" DROP NOT NULL,
ALTER COLUMN "universityLevelRequirementId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Module" ADD CONSTRAINT "Module_coreId_fkey" FOREIGN KEY ("coreId") REFERENCES "CoreRequirement"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Module" ADD CONSTRAINT "Module_electiveId_fkey" FOREIGN KEY ("electiveId") REFERENCES "ElectiveRequirement"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Module" ADD CONSTRAINT "Module_universityLevelRequirementId_fkey" FOREIGN KEY ("universityLevelRequirementId") REFERENCES "UniversityLevelRequirement"("id") ON DELETE SET NULL ON UPDATE CASCADE;
