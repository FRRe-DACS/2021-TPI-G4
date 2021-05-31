//Import router
import { Router } from 'express';
import * as CtrlUserBusiness from '../controller/userBusiness.controller';
//Instancio router
const router = Router();
import { errorsValidate, validateSingup, validateLogin } from '../Middlewares/userBusinessValidate';
//Routes
/**
 * @swagger
 * tags:
 *  name: Autenticacion de empresas
 *  description: Documentacion de la autenticacion.
 */
//componentes reutilizables
/**
 *  @swagger
 *  components:
 *      schemas:
 *          Login:
 *              type: object
 *              properties:
 *                  email:
 *                      type: string
 *                      description: direccion email de la empresa
 *                      example: example@gmail.com
 *                  password:
 *                      type: string
 *                      description: contraseña de la empresa
 *                      example: password
 *          SignUp:
 *              type: object
 *              properties:
 *                  cuit:
 *                      type: integer
 *                      description: Cuit de la empresa
 *                      example: 20304050605
 *                  razon_social:
 *                      type: string
 *                      description: Razon social de la empresa
 *                      example: SANCOR SA
 *                  Industria:
 *                      type: string
 *                      description: Sector industrial al cual esta orientado
 *                      example: Lacteos
 *                  email:
 *                      type: string
 *                      description: email de la empresa
 *                      example: example@gmail.com
 *                  tel:
 *                      type: integer
 *                      description: Numero de telefono de la empresa
 *                      example: 3482668855
 *                  password:
 *                      type: string
 *                      description: Contraseña de la cuenta
 *                      example: password
 *                  ciudad:
 *                      type: string
 *                      description: Ciudad donde esta ubicada la empresa
 *                      example: Resistencia
 *      securitySchemes:
 *          ApiKeyAuth:
 *              type: apiKey
 *              in: header
 *              name: token
 *      security:
 *          - ApiKeyAuth: []
 */

//-------------------------------------------------------------------------------------------------------------------------
//Registrar Usuario
router.post('/api/signup', validateSingup, errorsValidate, CtrlUserBusiness.userBusinessSignup);
/**
 * @swagger
 * /api/signup:
 *  post:
 *      summary: Registro para las empresas
 *      tags: [Autenticacion de empresas]
 *      requestBody:
 *          required: true
 *          content:
 *              application/json:
 *                  schema:
 *                      $ref: '#/components/schemas/SignUp'
 *      responses:
 *          200:
 *              description: El registro fue exitoso.
 *              content:
 *                  application/json:
 *                      schema:
 *                          $ref: '#/components/schemas/SignUp'
 *          404:
 *              description: Registro fallido.
 *              content:
 *                  application/json:
 *                      schema:
 *                          type: object
 *                          properties:
 *                              msg:
 *                                  type: string
 *                                  description: Un mensaje para error en el registro
 *                                  example: Registro fallido!
 */

//-------------------------------------------------------------------------------------------------------------------------
//Iniciar sesion usuario
router.post('/api/login', validateLogin, errorsValidate, CtrlUserBusiness.userBusinessLogin);
/**
 * @swagger
 * /api/login:
 *  post:
 *      summary: Inicio de Sesion para las empresas
 *      tags: [Autenticacion de empresas]
 *      requestBody:
 *          required: true
 *          content:
 *              application/json:
 *                  schema:
 *                      $ref: '#/components/schemas/Login'
 *      responses:
 *          200:
 *              description: Empresa Autorizada.
 *              content:
 *                  application/json:
 *                      schema:
 *                          $ref: '#/components/schemas/Login'
 *              requestBody:
 *                  required: true
 *                  content:
 *                      application/json:
 *                          schema:
 *                              $ref: '#/components/schemas/Login'
 *          404:
 *              description: Autenticacíon fallida.
 *              content:
 *                  application/json:
 *                      schema:
 *                          type: object
 *                          properties:
 *                              msg:
 *                                  type: string
 *                                  description: Un mensaje para error en el logeo
 *                                  example: Autenticación fallida!
 */

export default router;
