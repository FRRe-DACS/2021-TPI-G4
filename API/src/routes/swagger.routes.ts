//Import Swagger
import swaggerUI from "swagger-ui-express";
import swaggerJsDoc from "swagger-jsdoc";

//Import Routers
import { Router } from "express";

//Metodh Router
const router = Router();

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "Reports API",
      version: "1.0.0",
      description: "Swagger Grupo N°4",
    },
    servers: [
      {
        url: "http://localhost:3000",
      },
    ],
  },
  apis: ["./src/routes/*.ts"],
};

//Swagger
const specs = swaggerJsDoc(options);
//Swagger Docs
router.use("/api/docs", swaggerUI.serve, swaggerUI.setup(specs));

export default router;
