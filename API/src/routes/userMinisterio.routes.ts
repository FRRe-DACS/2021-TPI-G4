import { Router } from "express";
import * as CtrlUserMinisterio from "../controller/userMinisterio.controller";
//Instancio router
const router = Router();

//Registrar Usuario
router.post(
  "/api/signupMinisterio",

  CtrlUserMinisterio.userMinisterioSignup
);

//Iniciar sesion usuario
router.post(
  "/api/loginMinisterio",

  CtrlUserMinisterio.userMinisterioLogin
);

export default router;
