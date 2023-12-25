// imports
import connection from "./connection.js"

const mountRoutes = (app) => {
    app.use("/connection", connection) // example route
}

export default mountRoutes;