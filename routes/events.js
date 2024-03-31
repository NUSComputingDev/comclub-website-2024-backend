import Router from "express-promise-router";
import { query } from "../db/index.js";

const router = new Router();

router.get("/", async (req, res) => {
  const { rows } = await query("SELECT * FROM events;");

  res.send(rows);
});

export default router;