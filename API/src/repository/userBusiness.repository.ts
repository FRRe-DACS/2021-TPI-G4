//Import user model
import UserBusiness, { IUserBusiness } from "../models/users.business.models";

//Import jwt
import jwt from "jsonwebtoken";

//Import variables de entorno
import * as Variable from "../config/config";

// Service class users
export default class userService {
  //Registro
  async userSignup(user: IUserBusiness) {
    
    const data = await UserBusiness.findOne({ email: user.email });

    if (!data) {
      //Create user
      const newUserBusiness = new UserBusiness(user);
      //Encriptando password
      newUserBusiness.password = await newUserBusiness.encriptarPassword(
        newUserBusiness.password
      );
      //Saved user
      const saveNewUserBusiness = await newUserBusiness.save();
      //Create token
      const token: string = jwt.sign(
        { _id: saveNewUserBusiness._id },
        `${Variable.default.TOKEN_SECRET}`
      );
      return token;
    } else {
      throw new Error(
        "¡El Correo Electronico ya existe, pruebe iniciando sesion!"
      );
    }
  }
  //Inicio sesion
  async userLogin(user: IUserBusiness) {
    //Consulto con la BD
    const dataUserBusiness = await UserBusiness.findOne({ email: user.email });
    //Si no coincide el correo
    if (!dataUserBusiness){
        throw new Error(
            "¡El correo electronico no es valido!"
          );
    } 
    //Si coincide valido password
    const password: boolean = await dataUserBusiness.validatePassword(
      user.password
    );
    //Si no coinciden las contraseñas
    if (!password) {
        throw new Error(
            "¡Password Invalida!"
          );
    }
    //Si pasa todos los controles puedo ya generar un token
    const token: string = jwt.sign(
      { _id: dataUserBusiness._id },
      `${Variable.default.TOKEN_SECRET}`,
      {
        expiresIn: 60 * 60 * 24, //Expira en 24hs
      }
    );
    return token;
  }
}
