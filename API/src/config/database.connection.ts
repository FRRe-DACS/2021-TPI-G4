import mongoose from "mongoose";
import config from "./config";

//Conecction to DB REPORTS
async function connections() {
  try {
    const db = await mongoose.connect(`mongodb://${config.MONGO_USER}:${config.MONGO_PASS}@${config.MONGO_HOST}/${config.MONGO_DB}`, {
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
