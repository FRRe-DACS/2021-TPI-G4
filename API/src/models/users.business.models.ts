//Import Schema model and Document
import {Schema, model, Document} from 'mongoose'
//Import bcrypt
import bcrypt from 'bcryptjs'


//Interface 
export interface IUserBusiness extends Document{
    cuit : Number;
    razon_social : string;
    industria : string;
    email : string; 
    tel : Number;
    ciudad : string;
    password : string;
    encriptarPassword(password : string) : Promise<string>;
    validatePassword(password : string) : Promise<boolean>; 
   
}

//Schema
const userBusinessSchema = new Schema<IUserBusiness> ({
    cuit : {
        type : Number,
        unique : true,
        trim: true,
        require: true,
        min : [11, 'El CUIT debe tener 11 digitos']
    },
    razon_social : {
        type : String,
        require : true,
        trim: true,
    },
    industria : {
        type: String,
        require: true,
        trim: true,
    },
    email : {
        type : String,
        unique : true,
        require : true,
        trim: true,
    },
    tel : {
        type : Number,
        unique :true,
        trim : true,
    },
    ciudad : {
        type : String,
        require : true,
        trim : true,
    },
    password : {
        type : String,
        require : true,
        trim : true,
        minLength : [6, '¡La constraseña debe tener al menos 6 caracteres!']
    }
})

//Encripto contraseña
userBusinessSchema.methods.encriptarPassword = async (password : string) : Promise<string> =>{
    const salt = await bcrypt.genSalt(10)
    return bcrypt.hash(password, salt)
};

//Valido contraseña
userBusinessSchema.methods.validatePassword = async function(password : string): Promise<boolean> {
    return await bcrypt.compare(password, this.password)
}


export default model<IUserBusiness>('UserBusiness', userBusinessSchema)