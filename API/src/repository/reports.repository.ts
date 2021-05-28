import Reports from "../models/reports.models";
import Product from '../models/products.models'
import Business from "../models/business.models";
import UserBusiness from "../models/users.business.models";
import productClass from "./products.repository";
import businessClass from "./business.repository";

const instanceBusiness = new businessClass();
const instanceProduct = new productClass();

export default class reportsService {
  //Obtengo todos los reportes asociados a un id de usuario
  async readreports(id: string) {
    try {
      const dataUsersBusiness = await UserBusiness.findById(id);
      if (dataUsersBusiness) {
        const dataBusinees = await Business.find(
          {
            cuit: dataUsersBusiness.cuit,
          },
          {
            razon_social: 0,
            cuit: 0,
            __v: 0,
          }
        ).populate({
          path: "report",
          model: "Report",
          select: { __v: 0 },
          populate: [
            {
              path: "listaRegistro",
              model: "Products",
              select: { _id: 0, __v: 0, report: 0 },
            },
            {
              path: "infoEmpresa",
              model: "Business",
              select: { _id: 0, report: 0, __v: 0 },
            },
          ],
        });
        return dataBusinees;
      }
    } catch (error) {
      return error;
    }
  }

  //Creo un nuevo reporte
  async createreports(data_reports: any, idUser: string) {
    const dataUserBusiness = await UserBusiness.findById(idUser);
    //Verifico que el  reporte que este mandando la emprese este asociada a ella efectivamente
    if (data_reports.infoEmpresa.cuit == dataUserBusiness?.cuit) {
      var newReports = new Reports(data_reports); //Creo un nuevo reporte
      newReports.listaRegistro = []; //A la lista de registros del nuevo reporte le asigno array vacio para empezar a cargar los productos
      //Cargo los productos al reporte al mismo tiempo que los voy guardando en la coleccion Product
      newReports = await instanceProduct.createproducts(
        data_reports.listaRegistro,
        newReports
      );
      //Veo si ya existe la misma empresa
      const dataBusinees = await instanceBusiness.readBusiness(
        data_reports.infoEmpresa
      );
      //Si no existe la creo
      if (!dataBusinees) {
        const newBusiness = new Business(data_reports.infoEmpresa); //Creo una nueva empresa
        newReports.infoEmpresa = newBusiness._id; //Hago referencia a que ese reporte pertenece a esa empresa
        newBusiness.report.push(newReports._id); //Hago referencia a que la empresa pertenece al reporte
        await newBusiness.save(); //Guardo la empresa en la coleccion Business
      } else {
        //Si existe actualizo los reportes asociados
        newReports.infoEmpresa = dataBusinees._id; //Hago referencia a que ese reporte pertenece a esa empresa
        dataBusinees.report.push(newReports._id); //Hago referencia a que la empresa pertenece al reporte
        dataBusinees.save();
      }

      const responseReport = await newReports.save(); //Guardo el reporte en la coleccion reports
      return responseReport; //Retorno el reporte cargado
    } else {
      throw new Error(
        "¡Por favor cargue un reporte asociado al CUIT de su empresa!"
      );
    }
  }

  //Borro un reporte
  async deletereports(id_report: any) {
    const report = await Reports.findById(id_report);
    await instanceProduct.deleteProduct(report?.listaRegistro);
    await Reports.findByIdAndDelete(id_report);
    //const deletedProductsReports = await Product.deleteMany({ _id: { $in: report?.listaRegistro } })
    return "Reporte eliminado correctamente";
  }

  //Actualizo un reporte
  async updatereports(id_report: any, paramsUpdatereports: any) {
    var report = await Reports.findById(id_report);
    report = await instanceProduct.createproducts(paramsUpdatereports, report);
    if (report) report = await report.save();
    return report;
  }
}
