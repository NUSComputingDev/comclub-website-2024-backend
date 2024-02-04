-- CreateEnum
CREATE TYPE "Day" AS ENUM ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY');

-- CreateEnum
CREATE TYPE "Semester" AS ENUM ('SEMESTER_1', 'SEMESTER_2', 'SPECIAL_TERM_1', 'SPECIAL_TERM_2');

-- CreateEnum
CREATE TYPE "LessonType" AS ENUM ('LECTURE', 'TUTORIAL', 'LABORATORY', 'SEMINAR');

-- CreateEnum
CREATE TYPE "CourseType" AS ENUM ('COMPUTER_SCIENCE', 'BUSINESS_ANALYTICS', 'INFORMATION_SYSTEMS', 'INFORMATION_SECURITY', 'COMPUTER_ENGINEERING');

-- CreateTable
CREATE TABLE "CompletionRequirement" (
    "id" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,
    "cumulativeCreditRequirements" INTEGER NOT NULL,

    CONSTRAINT "CompletionRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CoreRequirement" (
    "id" TEXT NOT NULL,
    "doubleCountingModules" INTEGER NOT NULL,

    CONSTRAINT "CoreRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ElectiveRequirement" (
    "id" TEXT NOT NULL,

    CONSTRAINT "ElectiveRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UniversityLevelRequirement" (
    "id" TEXT NOT NULL,

    CONSTRAINT "UniversityLevelRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "userEmail" VARCHAR(255) NOT NULL,
    "userName" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "courseId" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Course" (
    "id" TEXT NOT NULL,
    "courseType" "CourseType" NOT NULL,
    "creditsRequirement" INTEGER NOT NULL,

    CONSTRAINT "Course_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Module" (
    "id" TEXT NOT NULL,
    "academicYear" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "credit" INTEGER NOT NULL,
    "faculty" TEXT NOT NULL,
    "department" TEXT NOT NULL,
    "canSU" BOOLEAN NOT NULL,
    "aliases" TEXT[],
    "semesterOffered" "Semester"[],
    "prerequisiteTree" JSONB,
    "coreId" TEXT NOT NULL,
    "electiveId" TEXT NOT NULL,
    "universityLevelRequirementId" TEXT NOT NULL,

    CONSTRAINT "Module_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Prerequisite" (
    "id" TEXT NOT NULL,
    "currentModId" TEXT NOT NULL,
    "prereqModId" TEXT NOT NULL,

    CONSTRAINT "Prerequisite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Corequisite" (
    "id" TEXT NOT NULL,
    "currentModId" TEXT NOT NULL,
    "coreqModId" TEXT NOT NULL,

    CONSTRAINT "Corequisite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Preclusion" (
    "id" TEXT NOT NULL,
    "currentModuleId" TEXT NOT NULL,
    "precludeModuleId" TEXT NOT NULL,

    CONSTRAINT "Preclusion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RawLesson" (
    "id" TEXT NOT NULL,
    "moduleId" TEXT NOT NULL,
    "semester" INTEGER NOT NULL,
    "classNo" TEXT NOT NULL,
    "day" "Day" NOT NULL,
    "startTime" TEXT NOT NULL,
    "endTime" TEXT NOT NULL,
    "lessonType" "LessonType" NOT NULL,
    "venue" TEXT NOT NULL,
    "weeks" INTEGER[],
    "size" INTEGER
);

-- CreateTable
CREATE TABLE "SemesterData" (
    "moduleId" TEXT NOT NULL,
    "semester" "Semester" NOT NULL,
    "examDate" TIMESTAMP(3),
    "examDuration" INTEGER,

    CONSTRAINT "SemesterData_pkey" PRIMARY KEY ("moduleId","semester")
);

-- CreateTable
CREATE TABLE "Exemption" (
    "id" TEXT NOT NULL,
    "exemptionName" TEXT NOT NULL,

    CONSTRAINT "Exemption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ModuleExemption" (
    "exemptionId" TEXT NOT NULL,
    "moduleId" TEXT NOT NULL,

    CONSTRAINT "ModuleExemption_pkey" PRIMARY KEY ("exemptionId")
);

-- CreateTable
CREATE TABLE "MCExemption" (
    "exemptionId" TEXT NOT NULL,
    "exemptionNumber" INTEGER NOT NULL,

    CONSTRAINT "MCExemption_pkey" PRIMARY KEY ("exemptionId")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_userEmail_key" ON "User"("userEmail");

-- CreateIndex
CREATE UNIQUE INDEX "Module_code_key" ON "Module"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Prerequisite_currentModId_prereqModId_key" ON "Prerequisite"("currentModId", "prereqModId");

-- CreateIndex
CREATE UNIQUE INDEX "Corequisite_currentModId_coreqModId_key" ON "Corequisite"("currentModId", "coreqModId");

-- CreateIndex
CREATE UNIQUE INDEX "Preclusion_currentModuleId_precludeModuleId_key" ON "Preclusion"("currentModuleId", "precludeModuleId");

-- CreateIndex
CREATE UNIQUE INDEX "RawLesson_moduleId_classNo_semester_key" ON "RawLesson"("moduleId", "classNo", "semester");

-- AddForeignKey
ALTER TABLE "CompletionRequirement" ADD CONSTRAINT "CompletionRequirement_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoreRequirement" ADD CONSTRAINT "CoreRequirement_id_fkey" FOREIGN KEY ("id") REFERENCES "CompletionRequirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ElectiveRequirement" ADD CONSTRAINT "ElectiveRequirement_id_fkey" FOREIGN KEY ("id") REFERENCES "CompletionRequirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UniversityLevelRequirement" ADD CONSTRAINT "UniversityLevelRequirement_id_fkey" FOREIGN KEY ("id") REFERENCES "CompletionRequirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Module" ADD CONSTRAINT "Module_coreId_fkey" FOREIGN KEY ("coreId") REFERENCES "CoreRequirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Module" ADD CONSTRAINT "Module_electiveId_fkey" FOREIGN KEY ("electiveId") REFERENCES "ElectiveRequirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Module" ADD CONSTRAINT "Module_universityLevelRequirementId_fkey" FOREIGN KEY ("universityLevelRequirementId") REFERENCES "UniversityLevelRequirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prerequisite" ADD CONSTRAINT "Prerequisite_currentModId_fkey" FOREIGN KEY ("currentModId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prerequisite" ADD CONSTRAINT "Prerequisite_prereqModId_fkey" FOREIGN KEY ("prereqModId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Corequisite" ADD CONSTRAINT "Corequisite_currentModId_fkey" FOREIGN KEY ("currentModId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Corequisite" ADD CONSTRAINT "Corequisite_coreqModId_fkey" FOREIGN KEY ("coreqModId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Preclusion" ADD CONSTRAINT "Preclusion_currentModuleId_fkey" FOREIGN KEY ("currentModuleId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Preclusion" ADD CONSTRAINT "Preclusion_precludeModuleId_fkey" FOREIGN KEY ("precludeModuleId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RawLesson" ADD CONSTRAINT "RawLesson_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SemesterData" ADD CONSTRAINT "SemesterData_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModuleExemption" ADD CONSTRAINT "ModuleExemption_exemptionId_fkey" FOREIGN KEY ("exemptionId") REFERENCES "Exemption"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModuleExemption" ADD CONSTRAINT "ModuleExemption_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MCExemption" ADD CONSTRAINT "MCExemption_exemptionId_fkey" FOREIGN KEY ("exemptionId") REFERENCES "Exemption"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
