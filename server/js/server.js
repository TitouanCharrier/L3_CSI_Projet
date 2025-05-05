"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const sqlite3_1 = __importDefault(require("sqlite3"));
const app = (0, express_1.default)();
const port = 3000;
app.use(express_1.default.json());
//Ouverture de la base de donnée ----------------------------------------------------------------
const db = new sqlite3_1.default.Database('database.db', (err) => {
    if (err) {
        console.error('Erreur lors de l\'ouverture de la base de données:', err);
    }
    else {
        //console.log('Base de données ouverte');
    }
});
// Création table
db.run(`
CREATE TABLE IF NOT EXISTS test (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nom TEXT NOT NULL,
  age INTEGER NOT NULL
)
`);
// Endpoint pour envoyer les données au serveur 
app.post('/update', (req, res) => {
    const { nom, age } = req.body;
    try {
        db.run('INSERT INTO test (nom, age) VALUES (?, ?)', [nom, age]);
        res.status(201).json({ success: true });
    }
    catch (err) {
        res.status(500).json({ error: 'Erreur lors de l\'insertion' });
    }
});
// Endpoint pour récupérer toutes les données
app.get('/getdata', (req, res) => {
    db.all('SELECT * FROM test', [], (err, rows) => {
        if (err) {
            res.status(500).json({ error: 'Erreur lors de la récupération des données' });
        }
        else {
            res.status(200).json(rows);
        }
    });
});
app.listen(port, () => {
    console.log(`Serveur en écoute sur http://localhost:${port}`);
});
