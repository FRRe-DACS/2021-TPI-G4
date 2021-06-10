import { RequestHandler } from "express";
import reportsClass from "../repository/reports.repository";

//Instancion la clases reportsService
const instacereports = new reportsClass();

//Obtener Reportes
export const getreports: RequestHandler = async (req, res) => {
  try {
    //Paso el id que devuelve el token (id de usuario empresa)
    const reports = await instacereports.readreports(req.userId);
    res.status(200).send(reports);
  } catch (error) {
    res.status(500).send(error);
  }
};

//Crear un nuevo Reporte
export const createreports: RequestHandler = async (req, res) => {
  try {
    const datareports = req.body;
    //Llamo a la instancia de servicios de reportes, paso por parametro el reporte y el id del usuario
    const response = await instacereports.createreports(datareports, req.userId);
    res.status(200).send(response);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

//Borrar un Reporte
export const deletereports: RequestHandler = async (req, res) => {
  try {
    const id_report = req.params._id;
    const response = await instacereports.deletereports(id_report);
    res.status(200).send(response);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

//Actualizar un Reporte
export const updatereports: RequestHandler = async (req, res) => {
  try {
    const id_report = req.params._id;
    const products = req.body;
    const response = await instacereports.updatereports(id_report, products);
    res.status(200).send(response);
  } catch (error) {
    res.status(500).send(error.message);
  }
};
