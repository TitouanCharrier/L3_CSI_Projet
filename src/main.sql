-- Création de la base de données
CREATE DATABASE Hopital;
USE Hopital;

-- Table Hopital
CREATE TABLE Hopital (
    id INT PRIMARY KEY,
    nom VARCHAR(100),
    adresse VARCHAR(255)
);

-- Table Personne
CREATE TABLE Personne (
    id INT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    naissance DATETIME
);

-- Table Personnel (Hérite de Personne)
CREATE TABLE Personnel (
    id INT PRIMARY KEY,
    embauche DATETIME,
    finContrat DATETIME,
    salaire INT,
    hopital_id INT,
    FOREIGN KEY (id) REFERENCES Personne(id),
    FOREIGN KEY (hopital_id) REFERENCES Hopital(id)
);

-- Tables spécialisées (Medecin, Infirmier, AgentEntretient, Administratif)
CREATE TABLE Medecin (
    id INT PRIMARY KEY,
    specialite VARCHAR(100),
    FOREIGN KEY (id) REFERENCES Personnel(id)
);

CREATE TABLE Infirmier (
    id INT PRIMARY KEY,
    service VARCHAR(100),
    FOREIGN KEY (id) REFERENCES Personnel(id)
);

CREATE TABLE AgentEntretient (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Personnel(id)
);

CREATE TABLE Administratif (
    id INT PRIMARY KEY,
    service VARCHAR(100),
    FOREIGN KEY (id) REFERENCES Personnel(id)
);

-- Table Patient (Hérite de Personne)
CREATE TABLE Patient (
    id INT PRIMARY KEY,
    antecedentsMedicaux TEXT,
    raisonAccueil TEXT,
    dateEntree DATE,
    dateSortiePrevisionnelle DATE,
    dateSortieReelle DATE,
    FOREIGN KEY (id) REFERENCES Personne(id)
);

-- Table VisiteMedicale
CREATE TABLE VisiteMedicale (
    id INT PRIMARY KEY,
    date DATE,
    examens TEXT,
    commentaires TEXT,
    medecin_id INT,
    patient_id INT,
    FOREIGN KEY (medecin_id) REFERENCES Medecin(id),
    FOREIGN KEY (patient_id) REFERENCES Patient(id)
);

-- Table CompteRendu
CREATE TABLE CompteRendu (
    id INT PRIMARY KEY,
    date DATE,
    examens TEXT,
    commentaires TEXT,
    visite_id INT,
    FOREIGN KEY (visite_id) REFERENCES VisiteMedicale(id)
);

-- Table Soin
CREATE TABLE Soin (
    id INT PRIMARY KEY,
    dateHeure DATETIME,
    description TEXT,
    medicaments TEXT,
    quantite INT,
    infirmier_id INT,
    patient_id INT,
    FOREIGN KEY (infirmier_id) REFERENCES Infirmier(id),
    FOREIGN KEY (patient_id) REFERENCES Patient(id)
);

-- Table Reunion
CREATE TABLE Reunion (
    id INT PRIMARY KEY,
    dateHeure DATETIME
);

-- Table Participant_Reunion (Relation n-n entre Personnel et Reunion)
CREATE TABLE Participant_Reunion (
    personnel_id INT,
    reunion_id INT,
    PRIMARY KEY (personnel_id, reunion_id),
    FOREIGN KEY (personnel_id) REFERENCES Personnel(id),
    FOREIGN KEY (reunion_id) REFERENCES Reunion(id)
);

-- Table Service
CREATE TABLE Service (
    id INT PRIMARY KEY,
    nom VARCHAR(100),
    responsableAdministratif_id INT,
    medecinReferent_id INT,
    FOREIGN KEY (responsableAdministratif_id) REFERENCES Administratif(id),
    FOREIGN KEY (medecinReferent_id) REFERENCES Medecin(id)
);

-- Table Chambre
CREATE TABLE Chambre (
    numero INT,
    etage INT,
    capacite INT,
    service_id INT,
    PRIMARY KEY (numero, service_id),
    FOREIGN KEY (service_id) REFERENCES Service(id)
);

-- Table Lit
CREATE TABLE Lit (
    id INT PRIMARY KEY,
    numero INT,
    chambre_numero INT,
    service_id INT,
    occupant_id INT,
    dateDernierAgentEntretient DATE,
    nettoyeur_id INT,
    FOREIGN KEY (occupant_id) REFERENCES Patient(id),
    FOREIGN KEY (nettoyeur_id) REFERENCES AgentEntretient(id),
    FOREIGN KEY (chambre_numero, service_id) REFERENCES Chambre(numero, service_id)
);
