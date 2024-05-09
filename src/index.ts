import cors from 'cors'
import * as dotenv from 'dotenv'
import express, { Express } from 'express'

import { query } from './database/index'

dotenv.config()

const app: Express = express()
app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const startServer = async () => {
    try {
        // Test Database Connection
        await new Promise((resolve, reject) => {
            query('SELECT version();', (err, res) => {
                if (err) {
                    console.error('Connection error', err.stack);
                    reject(err); 
                } else {
                    console.log('Connected to PostgreSQL:', res.rows[0]);
                    resolve(res);
                }
            });
        });

        // Start the server only if the database connection is successful
        const port: number = process.env.PORT ? parseInt(process.env.PORT) : 8000;
        app.listen(port, () => {
            console.log(`Server is listening on port ${port}`);
        });
    } catch (error) {
        console.error('Unable to connect to the database:', error);
        process.exit(1);
    }
};

startServer()

/* Routers */
// app.use("/me", UserRouter);
// app.use("/modules", ModuleRouter);
// app.use("/courses", CourseRouter);
