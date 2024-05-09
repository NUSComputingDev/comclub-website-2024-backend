/* Below Typings are based off NusMods API */
export interface NusModsModuleAcademicOrganisation {
	Code: string
	Description: string
}

export interface NusModsModuleAttributeEntry {
	CourseAttributeValue: string
	CourseAttribute: string
}

export interface NusModsModuleAcademicGroup {
	Code: string
	Description: string
}

export interface NusModsModuleInfo {
	Term: string
	AcademicOrganisation: NusModsModuleAcademicOrganisation
	AcademicGroup: NusModsModuleAcademicGroup
	WorkLoadHours: string
	EffectiveDate: string
	CourseId: string // Internal ID used to connect dual-coded modules
	CourseOfferNumber: string // Usually 1, can be 2 or more for dual-coded modules
	Preclusion: string
	PreclusionRule: string

	PrintCatalog: 'Y' | 'N'
	YearLong: 'Y' | 'N'
	GradingBasisDesc: string

	CourseTitle: string
	AdditionalInformation: string
	CoRequisite: string
	CoRequisiteRule: string
	Description: string
	ModularCredit: string
	PreRequisite: string
	PreRequisiteRule: string
	PreRequisiteAdvisory: string
	Subject: string // The letter prefix part of the module code
	CatalogNumber: string // The number and suffix part of the module code

	ModuleAttributes?: NusModsModuleAttributeEntry[]
}

export interface NusModsModuleInfoV2 {
	moduleCode: string
	title: string
	description: string
	moduleCredit: string
	department: string
	faculty: string
	workload: number[]
	gradingBasisDescription: string
	semesterData: SemesterData[]
}

interface SemesterData {
	semester: number
	covidZones: string[]
}

export interface NusModsModule {
	moduleCode: string
	title: string
	semesters: number[]
}

/* This should be the JSON Response that we should target */
/* Aim to Target the following module prefixees */

export interface NusModsSpecificModuleInfo {
	acadYear: string
	description: string
	title: string
	additionalInformation: string
	department: string
	faculty: string
	workload: number[]
	gradingBasisDescription: string
	prerequisite: string
	prerequisiteRule: string
	moduleCredit: string
	moduleCode: string
	attributes: NusModsModuleAttributes
	semesterData: NusModsSemesterData[]
	prereqTree: NusModsPrerequisiteTree
	fulfillRequirements: string[]
}

interface NusModsModuleAttributes {
	mpes1?: boolean
	mpes2?: boolean
	su?: boolean
}

interface NusModsSemesterData {
	semester: number
	timetable: NusModsTimetableEntry[]
	covidZones: string[]
	examDate: string
	examDuration: number
}

interface NusModsTimetableEntry {
	classNo: string
	startTime: string
	endTime: string
	weeks: number[]
	venue: string
	day: string
	lessonType: string
	size: number
	covidZone: string
}

/* nOF stands for number of */
// if nOf's number = 2, means at least 2 out of the basket of mods must be fulfilled to fulfill this condition
interface NusModsPrerequisiteTree {
	and?: Array<string | NusModsPrerequisiteCondition>
	or?: Array<string | NusModsPrerequisiteCondition>
	nOf?: [number, Array<string | NusModsPrerequisiteCondition>]
}

interface NusModsPrerequisiteCondition extends NusModsPrerequisiteTree {}
