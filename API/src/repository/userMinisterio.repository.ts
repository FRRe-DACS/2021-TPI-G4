//Import user model
import UserMinisterio, {
  IUserMinisterio,
} from "../models/user.ministerio.models";

export default class userService {
  //Registro
  async userSignup(user: IUserMinisterio) {
    const data = await UserMinisterio.findOne({ email: user.email });

    if (!data) {
      //Create user
      const newUserMinisterio = new UserMinisterio(user);
      //Encriptando password
      newUserMinisterio.password = await newUserMinisterio.encriptarPassword(
        newUserMinisterio.password
      );
      //Saved user
      const saveNewUserMinisterio = await newUserMinisterio.save();

      return "Registro Correcto";
    } else {
      throw new Error(
        "¡El Correo Electronico ya existe, pruebe iniciando sesion!"
      );
    }
  }
  //Inicio sesion
  async userLogin(user: IUserMinisterio) {
    //Consulto con la BD
    const dataUserMinisterio = await UserMinisterio.findOne({
      email: user.email,
    });
    //Si no coincide el correo
    if (!dataUserMinisterio) {
      throw new Error("¡El correo electronico no es valido!");
    }
    //Si coincide valido password
    const password: boolean = await dataUserMinisterio.validatePassword(
      user.password
    );
    //Si no coinciden las contraseñas
    if (!password) {
      throw new Error("¡Password Invalida!");
    }

    return "Bienvenido";
  }
}
