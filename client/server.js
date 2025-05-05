var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import express from 'express';
import mysql from 'mysql2/promise';
import { config } from './config.js';
const app = express();
const PORT = process.env.PORT || 3000;
app.use(express.json());
// Connexion à la base de données
const connectDB = () => __awaiter(void 0, void 0, void 0, function* () {
    const connection = yield mysql.createConnection(config.db);
    console.log('Connecté à la base de données MySQL');
    return connection;
});
// Exemple de route pour récupérer des données
app.get('/api/data', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const connection = yield connectDB();
    const [rows] = yield connection.query('SELECT * FROM votre_table');
    res.json(rows);
    yield connection.end();
}));
app.listen(PORT, () => {
    console.log(`Serveur en cours d'exécution sur le port ${PORT}`);
});
