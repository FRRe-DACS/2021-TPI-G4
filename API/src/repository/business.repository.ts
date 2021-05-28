import Business, { IBusiness } from "../models/business.models";

export default class businessService {
  //Buscar una empresa por CUIT
  async readBusiness(business: IBusiness) {
    const data = await Business.findOne({ cuit: business.cuit });
    return data;
  }
}
