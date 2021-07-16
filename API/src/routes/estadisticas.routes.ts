//Import Router from express
import {Router} from 'express'

//Import controller
import * as Est from '../controller/estadisticas.controller'

//Instancio router
const router = Router()


router.get('/api/estadisticas', Est.estadisticas)

export default router;