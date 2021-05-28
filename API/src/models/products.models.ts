import { Schema, model, Document } from "mongoose";

export interface IProduct extends Document {
    denominacion: String;
    codigo_ean: Number;
    precio_unidad: Number;
    unidad_medida: String;
    cantidad_prod: Number;
    cantidad_vend: Number;
    report : any
  }
  //Schema PRODUCTS
  //trim clean white
  const productsSchema = new Schema<IProduct>({
    denominacion: {
      type: String,
      require: true,
      trim: true,
    },
    codigo_ean: {
      type: Number,
      require: true,
      trim: true,
    },
    precio_unidad: {
      type: Number,
      require: true,
      trim: true,
    },
    unidad_medida: {
      type: String,
      require: true,
      trim: true,
    },
    cantidad_prod: {
      type: Number,
      require: true,
      trim: true,
    },
    cantidad_vend: {
        type: Number,
        require: true,
        trim: true,
      },
      report: {
        type: Schema.Types.ObjectId,
        ref: "Report",
      }
  });


export default model<IProduct>("Products", productsSchema);