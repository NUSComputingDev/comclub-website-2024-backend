import express from "express";
import * as dotenv from "dotenv";
import cors from "cors";
import mountRoutes from "./routes/index.js";
import { query } from "./db/index.js";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Mount the individual routers into the main application
mountRoutes(app);

export const startServer = async () => {
  try {

    // Test Database Connection
    query("SELECT version();", (err, res) => {
      if (err) {
        console.error("Connection error", err.stack);
      } else {
        console.log("Connected to PostgreSQL:", res.rows[0]);
      }
    });

    // Start the server
    app.listen(process.env.PORT || 8000, () => {
      console.log(`Server is listening on port ${process.env.PORT || 8000}`);
    });
  } catch (error) {
    console.error("Unable to connect to the database:", error);
  }
};

startServer();
