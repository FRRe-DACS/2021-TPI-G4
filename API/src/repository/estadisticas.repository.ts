//Import Report
import Report, { IReport } from "../models/reports.models";
//Import Business
import Business from "../models/users.business.models";
//Import empresas collection
import Empresas from "../models/business.models";
//Import products
import Productos from "../models/products.models";

export default class estadisticas {
  //Cantidad Producida y cantidad vendida por ano por sector
  async getEstadistica(year: any) {
    //Traigo todos los reportes

    const reportes = await Report.find();
    //Obtengo los sectores de cada empresa con sus  respectivas cantidades vendidas y producidas
    const reportYearpromises = reportes.map(async (report) => {
      if (report.periodo.year == year) {
        const business = await Empresas.findById(report.infoEmpresa);
        const industriaReport = await Business.findOne({
          cuit: business?.cuit,
        });
        var sector = {
          nombre: industriaReport?.industria,
          cantV: 0,
          cantP: 0,
        };
        for await (const Product of report.listaRegistro.map(
          async (idProduct: any) => {
            const product = await Productos.findById(idProduct);
            return product;
          }
        )) {
          sector.cantV = sector.cantV + Product.cantidad_vend;
          sector.cantP = sector.cantP + Product.cantidad_prod;
        }

        return sector;
      }
    });
    //Espero que se resuelvan las promesas
    const sectores = await Promise.all(reportYearpromises);
    const sectoresFilter = sectores.filter(
      (notUndefined) => notUndefined !== undefined
    );
    //Fusiono sectores repetidos
    var response: any = [];
    sectoresFilter.forEach((sector) => {
      if (!response.find((sect: any) => sect.nombre == sector?.nombre)) {
        var ind = {
          nombre: sector?.nombre,
          cantV: sector?.cantV,
          cantP: sector?.cantP,
        };
        response.push(ind);
      } else {
        const sectorRep = response.find(
          (sect: any) => sect.nombre == sector?.nombre
        );
        sectorRep.cantV = sectorRep.cantV + sector?.cantV;
        sectorRep.cantP = sectorRep.cantP + sector?.cantP;
      }
    });
    return response;
  }
}
