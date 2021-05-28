import { RequestHandler } from "express";
//Import jwt
import jwt from "jsonwebtoken";
//Import variable de entorno
import * as Validate from "../config/config";

//Import express validator
import { body, validationResult } from "express-validator";

//Interface payload
interface IPayload {
  _id: string;
  iat: number;
  exp: number;
}

//Valido si viene con token
export const validateToken: RequestHandler = (req, res, next) => {
  const token = req.header("token");
  if (!token) return res.status(500).json("Por favor envie su autorizacion!");
  const payload = jwt.verify(
    token,
    `${Validate.default.TOKEN_SECRET}`
  ) as IPayload;
  req.userId = payload._id;

  next();
};

//Valido Registro
export const validateSingup = [
  body("email").notEmpty().withMessage("¡El Correo Electronico es requerido!"),
  body("email").isEmail().withMessage("¡El Correo Electronico no es valido!"),
  body("password").notEmpty().withMessage("¡La contraseña es requerida!"),
  body("password")
    .isLength({ min: 6 })
    .withMessage("¡La contraseña debe tener al menos 6 caracteres!"),
];

//Valido Inicio de sesion
export const validateLogin = [
  body("email").notEmpty().withMessage("¡El Correo Electronico es requerido!"),
  body("email").isEmail().withMessage("¡El Correo Electronico no es valido!"),
  body("password").notEmpty().withMessage("¡La contraseña es requerida!"),
];

//Manejo Errores
export const errorsValidate: RequestHandler = (req, res, next) => {
  const error = validationResult(req);
  if (!error.isEmpty()) {
    res.status(500).json({ errors: error.array() });
  } else {
    next();
  }
};
