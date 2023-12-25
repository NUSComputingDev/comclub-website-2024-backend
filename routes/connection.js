import Router from "express-promise-router";
import { query } from "../db/index.js";

const router = new Router();

// THIS IS JUST A ROUTE TO CHECK THE DB CONNECTION / CHECK WHETHER ROUTES ARE WORKING
router.get("/", async (req, res) => {
  const { rows } = await query("SELECT version();");

  console.log("Connected to PostgreSQL:", rows[0]);

  res.send(rows[0]);
});

export default router;
