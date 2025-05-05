import { createPool } from 'mysql2';

const pool = createPool({
  host: 'localhost', // ou l'adresse de votre base de données
  user: '-uroot',
  password: '',
  database: 'mydb',
  waitForConnections: true,
  connectionLimit: 10,
});

export default pool;

pool.query(`select * from Personne;`, (err, res) => {
  return console.log(res);
})

