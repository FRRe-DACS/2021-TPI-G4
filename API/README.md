### Despliegue en HEROKU 
_Se proporciona el endpoint al Swagger de la API, ahi podran apreciar las demas rutas_

_[SWAGGER](https://ministeriodesarrolloproductivo.herokuapp.com/api/docs/)_
### API REST - Ministerio de Desarrollo Productivo 📋

_Por medio de los servicios expuestos por este ministerio, las diferentes Empresas del Sector Comercio podran enviar reportes mensuales de sus productos. De la misma manera, la Secreteria de Comercio Interior podra pedir reportes de una empresa en particular para poder cumplir con sus funciones de avisar a esta, de posibles incumplimientos_

## Comenzando 🚀

_1. Clone el repositorio en su equipo_

```git
git clone https://github.com/FRRe-DACS/2021-TPI-G4.git
```

### Pre-requisitos 📋

_El proyecto requiere [Node.JS](https://nodejs.org/es/) y [MongoDB](https://www.mongodb.com/es) instalado para ejecutarse. Por favor, instale y continue._

### Instalación 🔧
_Ubicados en la carpeta raiz del proyecto relice las siguientes acciones._
_1. Instale las dependencias_

```
npm install
```
_2. Corra MongoDB_

```
mongod
```
_3. Corra el servidor_

```
npm run dev
```
## Rutas y Peticiones ⚙
- **Swagger**
    - ```GET localhost:3000/api/docs```
- **Reportes**
    - ```GET localhost:3000/api/reports```
    - ```POST localhost:3000/api/reports```
    - ```PUT localhost:3000/api/reports/:_id```
    - ```DELETE localhost:3000/api/reports/:_id```
- **Autenticacion de Empresas**
    - ```POST localhost:3000/api/signup```
    - ```POST localhost:3000/api/login```
## Ejecutando las pruebas ⚙️

_Para ejecutar las pruebas puede hacer una peticion GET a la ruta ```localhost:3000/api/docs```. Ahi encontrara toda la informacion necesaria para probar las rutas de autenticacion de empresas y reportes._



## Autores ✒️

_Grupo N° 4_

* Imfeld, Facundo Nicolas ([imfeld59@gmail.com](mailto:imfeld59@gmail.com))
* Lopez, William Juan Jose ([lopezwilliam177@gmail.com](mailto:lopezwilliam177@gmail.com))
* Nasir, Khalil Abdul ([kanasir28@gmail.com](mailto:kanasir28@gmail.com))
* Stride, Eric ([strideeric94@gmail.com](mailto:strideeric94@gmail.com))
* Troncoso, Clarise ([sclariset@gmail.com](mailto:sclariset@gmail.com))

***

By: [Grupo N° 4](https://github.com/FRRe-DACS/2021-TPI-G4.git)
