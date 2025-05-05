import express, { Request, Response } from 'express';
import sqlite3 from 'sqlite3';

const app = express();
const port = 3000;
app.use(express.json());

//Ouverture de la base de donnée ----------------------------------------------------------------
const db = new sqlite3.Database('database.db', (err) => {
  if (err) {
    console.error('Erreur lors de l\'ouverture de la base de données:', err);
  } else {
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
app.post('/update', (req: Request, res: Response) => {
  const { nom, age } = req.body;
  try {
      db.run('INSERT INTO test (nom, age) VALUES (?, ?)', [nom, age]);
      res.status(201).json({ success: true });
    } catch (err) {
      res.status(500).json({ error: 'Erreur lors de l\'insertion' });
    }

});

// Endpoint pour récupérer toutes les données
app.get('/getdata', (req: Request, res: Response) => {
  db.all('SELECT * FROM test', [], (err, rows) => {
    if (err) {
      res.status(500).json({ error: 'Erreur lors de la récupération des données' });
    } else {
      res.status(200).json(rows);
    }
  });
});

app.listen(port, () => {
console.log(`Serveur en écoute sur http://localhost:${port}`);
});

