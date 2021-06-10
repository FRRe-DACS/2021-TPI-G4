import { Schema, model, Document } from "mongoose";

export interface IBusiness extends Document {
  cuit: Number;
  razon_social: String;
  report: any;
}

//Schema BUSINESS
//trim clean white
const businessSchema = new Schema<IBusiness>({
  cuit: {
    type: Number,
    require: true,
    trim: true,
  },
  razon_social: {
    type: String,
    require: true,
    trim: true,
  },
  report: {
    type: [
      {
        type: Schema.Types.ObjectId,
        ref: "Report",
      },
    ],
  },
});

export default model<IBusiness>("Business", businessSchema);
