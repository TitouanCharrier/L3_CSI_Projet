"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mysql2_1 = require("mysql2");
const pool = (0, mysql2_1.createPool)({
    host: 'localhost', // ou l'adresse de votre base de données
    user: '-uroot',
    password: '',
    database: 'mydb',
    waitForConnections: true,
    connectionLimit: 10,
});
exports.default = pool;
pool.query(`select * from Personne;`, (err, res) => {
    return console.log(res);
});
