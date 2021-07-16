//Import Express
import express from "express";
//Import Config
import config from "./config/config";
//Import MiddleWare
import * as middleware from "./Middlewares/middlewares";
//Import Routes
import reportsRoutes from "./routes/reports.routes";
import userBusinesRoutes from "./routes/usersBusiness.routes";
import swaggerRoutes from "./routes/swagger.routes";
import estRoutes from './routes/estadisticas.routes'
import userMinRoutes from './routes/userMinisterio.routes'
//Import Database
import * as db from "./config/database.connection";

//Metodh Express
const app = express();

//Settings
app.set("port", config.PORT);

//Database Connection
db.default.connections();

//MiddleWares
app.use(middleware.getMorgan);
app.use(middleware.serverConnection);
app.use(middleware.json);
app.use(middleware.url);
//Routers
app.use(swaggerRoutes);
app.use(userBusinesRoutes);
app.use(reportsRoutes);
app.use(estRoutes)
app.use(userMinRoutes)
export default app;
