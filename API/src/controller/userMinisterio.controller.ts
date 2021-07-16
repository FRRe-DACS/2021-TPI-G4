import { RequestHandler } from "express";

//Import class userService
import userService from "../repository/userMinisterio.repository";
//Instancio userService
const instanceUserService = new userService();

//Controlador Logout
export const userMinisterioSignup: RequestHandler = async (req, res) => {
  try {
    //Obtengo datos del request
    const dataUserMinisterio = req.body;
    // Le paso los datos a la instancia de clase con el metodo userLogout
    const responseServiceMinisterio = await instanceUserService.userSignup(
      dataUserMinisterio
    );
    //respondo lo que retorne esa clase
    res.status(200).send(responseServiceMinisterio);
  } catch (error: any) {
    res.status(500).json(error.message);
  }
};

//Controlador Login
export const userMinisterioLogin: RequestHandler = async (req, res) => {
  try {
    //Obtengo datos del request
    const dataUserMinisterio = req.body;
    //Paso los datos a la instacia de la clase con el metodo login
    const responseServiceMinisterio = await instanceUserService.userLogin(
      dataUserMinisterio
    );

    res.status(200).send(responseServiceMinisterio);
  } catch (error: any) {
    res.status(500).json(error.message);
  }
};
