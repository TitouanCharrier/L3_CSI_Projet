import express from 'express';
import pool from './config.js';
import sqlite3 from 'sqlite3';

const app = express();
const PORT = 3000;

async function main() {

    
}


app.listen(PORT, () => {
  console.log(`Serveur en cours d'exécution sur le port ${PORT}`);
});
