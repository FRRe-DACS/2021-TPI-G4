import { RequestHandler } from "express";

//Import class userService
import userService from "../repository/userBusiness.repository";
//Instancio userService
const instanceUserService = new userService();

//Controlador Logout
export const userBusinessSignup: RequestHandler = async (req, res) => {
  try {
    //Obtengo datos del request
    const dataUserBusiness = req.body;
    // Le paso los datos a la instancia de clase con el metodo userLogout
    const responseServiceBusiness = await instanceUserService.userSignup(
      dataUserBusiness
    );
    //respondo lo que retorne esa clase
    res
      .header("token", responseServiceBusiness)
      .status(200)
      .json("¡Registro Correcto!");
  } catch (error) {
    res.status(500).json(error.message);
  }
};

//Controlador Login
export const userBusinessLogin: RequestHandler = async (req, res) => {
  try {
    //Obtengo datos del request
    const dataUserBusiness = req.body;
    //Paso los datos a la instacia de la clase con el metodo login
    const responseServiceBusiness = await instanceUserService.userLogin(
      dataUserBusiness
    );
    res
      .header("token", responseServiceBusiness)
      .status(200)
      .json("¡Bienvenido!");
  } catch (error) {
    res.status(500).json(error.message);
  }
};
