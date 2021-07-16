import { Schema, model, Document } from "mongoose";

export interface IReport extends Document {
  infoEmpresa: any;
  listaRegistro: any;
  periodo: any;
}


//Schema Reports
//trim clean white
const reporteSchema = new Schema<IReport>({
  infoEmpresa: {
    type: Schema.Types.ObjectId,
    ref: "Business",
  },
  listaRegistro: {
    type: [
      {
        type: Schema.Types.ObjectId,
        ref: "Products",
      },
    ],
  },
  date_upload : {
      type : Date,
      default : Date.now()
  },
  day_limit : {
      type : Number,
      default : 10
  },
  periodo: {
    
    year: {
      type: String,
      require: true,
      trim: true,
    },
    month: {
      type: String,
      require: true,
      trim: true,
    },
  },
});

export default model<IReport>("Report", reporteSchema);
