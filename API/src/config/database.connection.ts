import mongoose from "mongoose";
import config from "./config";

//Conecction to DB REPORTS
async function connections() {
  try {
    const db = await mongoose.connect(`${config.MONGO_URI}`, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
      useFindAndModify: false
    
    });
    console.log(db.connection.name);
  } catch (error) {
      console.log(error)
  }
}

export default { connections };
