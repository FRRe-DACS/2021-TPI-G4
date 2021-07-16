//Import Schema model and Document
import {Schema, model, Document} from 'mongoose'
//Import bcrypt
import bcrypt from 'bcryptjs'


//Interface 
export interface IUserMinisterio extends Document{
    cuit : number;
    apellidoynombre : string;
    email : string; 
    password : string;
    encriptarPassword(password : string) : Promise<string>;
    validatePassword(password : string) : Promise<boolean>; 
   
}

//Schema
const userMinisterioSchema = new Schema<IUserMinisterio> ({
    cuit : {
        type : Number,
        unique : true,
        trim: true,
        require: true,
        min : [11, 'El CUIT debe tener 11 digitos']
    },
    apellidoynombre : {
        type : String,
        require : true,
        trim: true,
    },
    
    email : {
        type : String,
        unique : true,
        require : true,
        trim: true,
    },
    password : {
        type : String,
        require : true,
        trim : true,
        minLength : [6, '¡La constraseña debe tener al menos 6 caracteres!']
    }
})

//Encripto contraseña
userMinisterioSchema.methods.encriptarPassword = async (password : string) : Promise<string> =>{
    const salt = await bcrypt.genSalt(10)
    return bcrypt.hash(password, salt)
};

//Valido contraseña
userMinisterioSchema.methods.validatePassword = async function(password : string): Promise<boolean> {
    return await bcrypt.compare(password, this.password)
}


export default model<IUserMinisterio>('UserMinisterio', userMinisterioSchema)