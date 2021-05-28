import morgan from "morgan";
import express from "express";
import cors from "cors";

//MiddleWares Definitions

//Morgan
export const getMorgan = morgan("dev");

//Json
export const json = express.json(); // Is a built express middleware that convert request body to JSON.

//Cors
export const serverConnection = cors();

//URLencoded
export const url = express.urlencoded({ extended: false }); //converting form-data to JSON
