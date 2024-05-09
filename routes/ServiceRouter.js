import Express, { Router } from "express";
import { Prisma, PrismaClient} from "@prisma/client";

const router = Express.Router();
const prisma = new PrismaClient();

prisma.user.create()

export default router;