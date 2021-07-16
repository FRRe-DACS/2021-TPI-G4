//Import express
import { RequestHandler }from 'express'
//import estadisticas
import Estadisticas from '../repository/estadisticas.repository'
//Instancio estadisticas 
const Est = new Estadisticas()


export const estadisticas : RequestHandler = async (req, res) => {
try {
	const year = req.query.year
	const response = await Est.getEstadistica(year)
	res.status(200).send(response)
} catch (error : any) {
	res.status(500).send(error.message)
}

}