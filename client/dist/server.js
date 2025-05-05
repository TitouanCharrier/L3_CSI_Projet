"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const config_js_1 = __importDefault(require("./config.js"));
const app = (0, express_1.default)();
const PORT = 3000;
config_js_1.default.getConnection((err, connection) => {
    if (err) {
        console.error('Erreur de connexion à la base de données:', err);
        return;
    }
    console.log('Connecté à la base de données MySQL');
    // Libérer la connexion après utilisation
    connection.release();
});
app.listen(PORT, () => {
    console.log(`Serveur en cours d'exécution sur le port ${PORT}`);
});
