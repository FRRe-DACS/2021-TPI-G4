//Import Routers
import { Router } from 'express';
//Import fuctions Routes
import * as reportsCtrl from '../controller/reports.controller';
//Metodh Router
const router = Router();

//Import Validate Token
import { validateToken } from "../Middlewares/userBusinessValidate";
import {
  validatePostReports,
  validatePutReports,
  errorsValidate,
} from "../Middlewares/reportsValidate";


//Categorias de swagger
/**
 * @swagger
 * tags:
 *  name: Reportes
 *  description: Documentación de reportes.
 */

//componentes reutilizables
/**
 *  @swagger
 *  components:
 *      schemas:
 *          Registros:
 *              type: array
 *              items:
 *                  type: object
 *                  properties:
 *                          denominacion:
 *                              type: string
 *                              description: denominacion del producto
 *                              example: Roe - Flying Fish
 *                          codigo_ean:
 *                              type: integer
 *                              description: Codigo EAN del producto
 *                              example: 1234567890123
 *                          precio_unidad:
 *                              type: integer
 *                              description: El precio del producto
 *                              example: 421
 *                          unidad_medida:
 *                              type: string
 *                              description: Unidad de medida del producto
 *                              example: L
 *                          cantidad_prod:
 *                              type: integer
 *                              description: Cantidad de unidades producidas del producto
 *                              example: 21
 *                          cantidad_vend:
 *                              type: integer
 *                              description: Cantidad de unidades vendidas del producto
 *                              example: 20
 *          Reportes:
 *              type: object
 *              properties:
 *                  infoEmpresa:
 *                      type: object
 *                      properties:
 *                          cuit:
 *                              type: integer
 *                              description: Numero entero de 11 digitos
 *                              example: 20304050605
 *                          razon_social:
 *                              type: string
 *                              description: Razon social de la empresa
 *                              example: Osinski-Jast
 *                  listaRegistro:
 *                      type: array
 *                      items:
 *                          type: object
 *                          properties:
 *                              denominacion:
 *                                  type: string
 *                                  description: denominacion del producto
 *                                  example: Roe - Flying Fish
 *                              codigo_ean:
 *                                  type: integer
 *                                  description: Codigo EAN del producto
 *                                  example: 1234567890123
 *                              precio_unidad:
 *                                  type: integer
 *                                  description: El precio del producto
 *                                  example: 421
 *                              unidad_medida:
 *                                  type: string
 *                                  description: Unidad de medida del producto
 *                                  example: L
 *                              cantidad_prod:
 *                                  type: integer
 *                                  description: Cantidad de unidades producidas del producto
 *                                  example: 21
 *                              cantidad_vend:
 *                                  type: integer
 *                                  description: Cantidad de unidades vendidas del producto
 *                                  example: 20
 *                  periodo:
 *                      type: object
 *                      properties:
 *                          year:
 *                              type: string
 *                              description: Año de carga
 *                              example: 2020
 *                          month:
 *                              type: string
 *                              description: mes de carga
 *                              example: 09
 *              required:
 *                  - infoEmpresa
 *                  - listaRegistro
 *                  - periodo
 * 
 *          Reporte No Encontrado:
 *              type: object
 *              properties:
 *                  msg:
 *                      type: string
 *                      description: Un mensaje para el reporte no encontrado
 *                      example: El reporte no pudo ser encontrado!
 *
 *      parameters:
 *          idReportes:
 *              in: path
 *              name: id
 *              required: true
 *              schema:
 *                  type: string
 *              descripcion: id de reportes
 */

//-----------------------------------------------------------------------------------------------
//Routes
//GET: Obtener
router.get('/api/reports', validateToken, reportsCtrl.getreports); //Obtener Reportes
/**
 * @swagger
 * /api/reports:
 *  get:
 *      summary: Obtiene todos los reportes asociados a la empresa autenticada.
 *      tags: [Reportes]
 *      security:
 *          - ApiKeyAuth: []
 *      responses:
 *          200:
 *              description: Devuelve los reportes encontrados de esa empresa.
 */

//-----------------------------------------------------------------------------------------------
//POST: Agregar
router.post(
  "/api/reports",
  validatePostReports,
  errorsValidate,
  validateToken,
  reportsCtrl.createreports
); //Alta de Reporte

/**
 *  @swagger
 *  /api/reports:
 *      post:
 *          summary: Crea un nuevo reporte para la empresa autenticada.
 *          tags: [Reportes]
 *          security:
 *              - ApiKeyAuth: []
 *          requestBody:
 *              required: true
 *              content:
 *                  application/json:
 *                      schema:
 *                          $ref: '#/components/schemas/Reportes'
 *          responses:
 *              200:
 *                  description: El reporte fue creado con exito.
 *                  content:
 *                      application/json:
 *                          schema:
 *                              $ref: '#/components/schemas/Reportes'
 */

//-----------------------------------------------------------------------------------------------
//PUT: Actualizar
router.put(
  "/api/reports/:_id",
  validatePutReports,
  errorsValidate,
  validateToken,
  reportsCtrl.updatereports
); //Actualizar Reporte, por parametro paso ID


/**
 * @swagger
 * /api/reports/{id}:
 *  put:
 *      summary: Actualiza un reporte de la empresa autenticada buscandolo con un id, se considera que se puede enviar uno o varios productos mas.
 *      tags: [Reportes]
 *      security:
 *          - ApiKeyAuth: []
 *      parameters:
 *          - $ref: '#/components/parameters/idReportes'
 *      requestBody:
 *          required: true
 *          content:
 *              application/json:
 *                  schema:
 *                      $ref: '#/components/schemas/Registros'
 *      responses:
 *          200:
 *              description: El reporte fue actualizado correctamente.
 *              content:
 *                  application/json:
 *                      schema:
 *                          $ref: '#/components/schemas/Registros'
 *          404:
 *              description: El reporte no fue encontrado.
 *              content:
 *                  application/json:
 *                      schema:
 *                          $ref: '#/components/schemas/Reporte No Encontrado'
 */

//-----------------------------------------------------------------------------------------------
//DELETE: Borrar
router.delete('/api/reports/:_id', validateToken, reportsCtrl.deletereports); //Borrar Reporte, por parametro paso ID
/**
 * @swagger
 * /api/reports/{id}:
 *  delete:
 *      summary: Elimina un reporte de la empresa autenticada buscandolo por id.
 *      tags: [Reportes]
 *      security:
 *          - ApiKeyAuth: []
 *      parameters:
 *          - $ref: '#/components/parameters/idReportes'
 *      responses:
 *          200:
 *              description: El reporte fue eliminado correctamente.
 *              content:
 *                  application/json:
 *                      schema:
 *                          $ref: '#/components/schemas/Reportes'
 *          404:
 *              description: El reporte no fue encontrado.
 *              content:
 *                  application/json:
 *                      schema:
 *                          $ref: '#/components/schemas/Reporte No Encontrado'
 */

export default router;
