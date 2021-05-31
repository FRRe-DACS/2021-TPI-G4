import Products from "../models/products.models";

export default class productsService {
  //Crear productos
  async createproducts(data_products: any, reporte: any) {
    data_products.forEach(async function (producto: any) {
      const newProduct = new Products(producto);
      reporte.listaRegistro.push(newProduct._id);
      newProduct.report = reporte._id;
      await newProduct.save();
    });
 
    return reporte;
  }
   //Borro lista de productos que se encuentran asociado a un reporte
   async deleteProduct(data_products : any){
    return await Products.deleteMany({ _id: { $in: data_products } })
  }
}
