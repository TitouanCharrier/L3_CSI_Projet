-- Création de la base de données
CREATE DATABASE Hopital;
USE Hopital;

-- Table Hopital
CREATE TABLE Hopital (
    id_hop INT PRIMARY KEY,
    nom_hop VARCHAR(100),
    adresse VARCHAR(255)
);

-- Table Personne
CREATE TABLE Personne (
    id_per INT PRIMARY KEY,
    nom_per VARCHAR(100),
    prenom VARCHAR(100),
    naissance DATETIME
);

-- Table Personnel (Hérite de Personne)
CREATE TABLE Personnel (
    id_pers INT PRIMARY KEY,
    embauche DATETIME,
    finContrat DATETIME,
    salaire INT,
    hopital_id INT,
    FOREIGN KEY (id) REFERENCES Personne(id),
    FOREIGN KEY (hopital_id) REFERENCES Hopital(id)
);

-- Tables spécialisées (Medecin, Infirmier, AgentEntretient, Administratif)
CREATE TABLE Medecin (
    id_med INT PRIMARY KEY,
    specialite VARCHAR(100),
    FOREIGN KEY (id) REFERENCES Personnel(id)
);

CREATE TABLE Infirmier (
    id_inf INT PRIMARY KEY,
    service VARCHAR(100),
    FOREIGN KEY (id) REFERENCES Personnel(id)
);

CREATE TABLE AgentEntretient (
    id_agent INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Personnel(id)
);

CREATE TABLE Administratif (
    id_admin INT PRIMARY KEY,
    service VARCHAR(100),
    FOREIGN KEY (id) REFERENCES Personnel(id)
);

-- Table Patient (Hérite de Personne)
CREATE TABLE Patient (
    id_pat INT PRIMARY KEY,
    antecedentsMedicaux TEXT,
    raisonAccueil TEXT,
    dateEntree DATE,
    dateSortiePrevisionnelle DATE,
    dateSortieReelle DATE,
    FOREIGN KEY (id) REFERENCES Personne(id)
);

-- Table VisiteMedicale
CREATE TABLE VisiteMedicale (
    id_vis INT PRIMARY KEY,
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
    id_com INT PRIMARY KEY,
    date DATE,
    examens TEXT,
    commentaires TEXT,
    visite_id INT,
    FOREIGN KEY (visite_id) REFERENCES VisiteMedicale(id)
);

-- Table Soin
CREATE TABLE Soin (
    id_soi INT PRIMARY KEY,
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
    id_reu INT PRIMARY KEY,
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
    id_serv INT PRIMARY KEY,
    nom VARCHAR(100),
    responsableAdministratif_id INT,
    medecinReferent_id INT,
    FOREIGN KEY (responsableAdministratif_id) REFERENCES Administratif(id),
    FOREIGN KEY (medecinReferent_id) REFERENCES Medecin(id)
);

-- Table Chambre
CREATE TABLE Chambre (
    numero INT PRIMARY KEY,
    etage INT,
    capacite INT,
    service_id INT,
    PRIMARY KEY (numero, service_id),
    FOREIGN KEY (service_id) REFERENCES Service(id)
);

-- Table Lit
CREATE TABLE Lit (
    id_lit INT PRIMARY KEY,
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

-- Insertion dans la table Hopital
INSERT INTO Hopital (id, nom, adresse) VALUES
(a, b, c);

-- Insertion dans la table Personne
INSERT INTO Personne (id, nom, prenom, naissance) VALUES
(a, b, c, d);

-- Insertion dans la table Personnel
INSERT INTO Personnel (id, embauche, finContrat, salaire, hopital_id) VALUES
(a, b, c, d, e);

-- Insertion dans la table Medecin
INSERT INTO Medecin (id, specialite) VALUES
(a, b);

-- Insertion dans la table Infirmier
INSERT INTO Infirmier (id, service) VALUES
(a, b);

-- Insertion dans la table Patient
INSERT INTO Patient (id, antecedentsMedicaux, raisonAccueil, dateEntree, dateSortiePrevisionnelle, dateSortieReelle) VALUES
(a, b, c, d, e, f);

-- Insertion dans la table VisiteMedicale
INSERT INTO VisiteMedicale (id, date, examens, commentaires, medecin_id, patient_id) VALUES
(a, b, c, d, e, f);

-- Insertion dans la table CompteRendu
INSERT INTO CompteRendu (id, date, examens, commentaires, visite_id) VALUES
(a, b, c, d, e);

-- Insertion dans la table Soin
INSERT INTO Soin (id, dateHeure, description, medicaments, quantite, infirmier_id, patient_id) VALUES
(a, b, c, d, e, f, g);

-- Insertion dans la table Reunion
INSERT INTO Reunion (id, dateHeure) VALUES
(a, b);

-- Insertion dans la table Participant_Reunion
INSERT INTO Participant_Reunion (personnel_id, reunion_id) VALUES
(a, b);

-- Insertion dans la table Service
INSERT INTO Service (id, nom, responsableAdministratif_id, medecinReferent_id) VALUES
(a, b, c, d);

-- Insertion dans la table Chambre
INSERT INTO Chambre (numero, etage, capacite, service_id) VALUES
(a, b, c, d);

-- Insertion dans la table Lit
INSERT INTO Lit (id, numero, chambre_numero, service_id, occupant_id, dateDernierAgentEntretient, nettoyeur_id) VALUES
(a, b, c, d, e, f, g);
