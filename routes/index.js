// imports
import connection from "./connection.js"
import events from "./events.js"

const mountRoutes = (app) => {
    app.use("/connection", connection) // example route
    app.use("/events", events)
}

export default mountRoutes;