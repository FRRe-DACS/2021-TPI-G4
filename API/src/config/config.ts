import dotenv from 'dotenv'
dotenv.config();

export default {
    PORT : process.env.PORT || 3000,    
    MONGO_DB : process.env.MONGO_DB || 'reports',
    MONGO_HOST : process.env.MONGO_HOST || 'localhost',
    MONGO_USER : process.env.MONGO_USER || 'Admin',
    MONGO_PASS : process.env.MONGO_PASS || 'admin',
    TOKEN_SECRET : process.env.TOKEN_SECRET || 'grupo4'
}