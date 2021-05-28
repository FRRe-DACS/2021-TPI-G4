//Import express validator
import { body, validationResult, check } from "express-validator";
//Import RequestHandler
import { RequestHandler } from "express";
//Import Schema Products
import Product from "../models/products.models";
//Valido reportes en POST
export const validatePostReports = [
  body("infoEmpresa.cuit").notEmpty().withMessage("¡El CUIT es requerido!"),
  body("infoEmpresa.cuit")
    .isLength({ min: 11, max: 11 })
    .withMessage("¡El CUIT debe tener 11 digitos!"),
  body("infoEmpresa.razon_social")
    .notEmpty()
    .withMessage("¡La Razon Social es requerida!"),
  body("listaRegistro.*.denominacion")
    .notEmpty()
    .withMessage("¡La Denominacion es requerida!"),
  body("listaRegistro.*.codigo_ean")
    .notEmpty()
    .withMessage("¡El codigo EAN es requerido!"),
  body("listaRegistro.*.codigo_ean")
    .isLength({ min: 13, max: 13 })
    .withMessage("¡El codigo EAN debe tener 13 caracteres!"),
  body("listaRegistro.*.precio_unidad")
    .notEmpty()
    .withMessage("¡El precio es requerido!"),
  body("listaRegistro.*.unidad_medida")
    .notEmpty()
    .withMessage("¡La unidad de medida es requerida!"),
  body("listaRegistro.*.cantidad_prod")
    .notEmpty()
    .withMessage("¡La cantidad producida es requerida!"),
  body("listaRegistro.*.cantidad_vend")
    .notEmpty()
    .withMessage("¡La cantidad vendida es requerida!"),
  body("listaRegistro.*.codigo_ean").custom((cod_ean, { req }) => {
    return Product.findOne({ codigo_ean: cod_ean }).then((product) => {
      if (product !== null) {
        return Promise.reject("¡El codigo EAN ya existe!");
      }
    });
  }),
];

//Valido reportes en PUT
export const validatePutReports = [
  body("*.denominacion")
    .notEmpty()
    .withMessage("¡La Denominacion es requerida!"),
  body("*.codigo_ean").notEmpty().withMessage("¡El codigo EAN es requerido!"),
  body("*.codigo_ean")
    .isLength({ min: 13, max: 13 })
    .withMessage("¡El codigo EAN debe tener 13 caracteres!"),
  body("*.precio_unidad").notEmpty().withMessage("¡El precio es requerido!"),
  body("*.unidad_medida")
    .notEmpty()
    .withMessage("¡La unidad de medida es requerida!"),
  body("*.cantidad_prod")
    .notEmpty()
    .withMessage("¡La cantidad producida es requerida!"),
  body("*.cantidad_vend")
    .notEmpty()
    .withMessage("¡La cantidad vendida es requerida!"),
  body("*.codigo_ean").custom((cod_ean, { req }) => {
    return Product.findOne({ codigo_ean: cod_ean }).then((product) => {
      if (product !== null) {
        return Promise.reject("¡El codigo EAN ya existe!");
      }
    });
  }),
];

//Manejo Errores
export const errorsValidate: RequestHandler = (req, res, next) => {
  const error = validationResult(req);
  console.log(error);
  if (!error.isEmpty()) {
    res.status(500).json({ errors: error.array() });
  } else {
    next();
  }
};
