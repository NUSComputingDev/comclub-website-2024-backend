import Express from "express";
import ModuleControler from "../controllers/moduleController";


const router = Express.Router();

router.get("/", ModuleControler.GetAllModules)

export { router as default };