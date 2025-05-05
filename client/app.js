"use strict";
var _a;
(_a = document.getElementById('loginForm')) === null || _a === void 0 ? void 0 : _a.addEventListener('submit', function (event) {
    event.preventDefault();
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    // Simuler une vérification de connexion
    if (username === 'admin' && password === 'password') {
        document.getElementById('message').textContent = 'Connexion réussie !';
        document.getElementById('message').style.color = 'green';
    }
    else if (username === 'medecin' && password === 'medecin') {
        document.getElementById('message').textContent = 'Connexion réussie medecin !';
        document.getElementById('message').style.color = 'green';
        window.location.href = './medecin/accueil.html';
    }
    else if (username === 'admin' && password === 'admin') {
        document.getElementById('message').textContent = 'Connexion réussie admin !';
        document.getElementById('message').style.color = 'green';
    }
    else if (username === 'cleaning' && password === 'cleaning') {
        document.getElementById('message').textContent = 'Connexion réussie cleaning !';
        document.getElementById('message').style.color = 'green';
    }
    else {
        document.getElementById('message').textContent = 'Nom d\'utilisateur ou mot de passe incorrect.';
        document.getElementById('message').style.color = 'red';
    }
});
