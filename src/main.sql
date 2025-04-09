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
    commentaires TEXT,
    id_reu INT,
    FOREIGN KEY (id_reu) REFERENCES Reunion(id_reu)
);

-- Table Medicament
CREATE TABLE Medicament (
    id_medica INT PRIMARY KEY,
    nom_medica TEXT
);

-- Table Ordonnance
CREATE TABLE Ordonnance (
    id_medica INT PRIMARY KEY,
    id_soin INT PRYMARY KEY,
    FOREIGN KEY (id_medica) REFERENCES Medicament (id_medica)
    FOREIGN KEY (id_soin) REFERENCES Soin (id_soin)
);

-- Table Soin
CREATE TABLE Soin (
    id_soin INT PRIMARY KEY,
    dateHeure DATETIME,
    description TEXT,
    id_medica INT,
    infirmier_id INT,
    patient_id INT,
    FOREIGN KEY (infirmier_id) REFERENCES Infirmier(infirmier_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
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

-- Insertion de données dans la table Hopital
INSERT INTO Hopital (id_hop, nom_hop, adresse)
VALUES
(1, 'Hôpital Central', '123 Rue de la Santé, Paris'),
(2, 'Clinique Verte', '456 Avenue des Soins, Lyon');

-- Insertion de données dans la table Personne
INSERT INTO Personne (id_per, nom_per, prenom, naissance)
VALUES
(1, 'Dupont', 'Jean', '1970-05-15'),
(2, 'Martin', 'Sophie', '1980-08-22'),
(3, 'Lefevre', 'Pierre', '1975-11-30'),
(4, 'Durand', 'Marie', '1985-03-10'),
(5, 'Chevalier', 'Luc', '1990-07-20'),
(6, 'Moreau', 'Anne', '1982-09-12'),
(7, 'Garnier', 'Paul', '1978-04-25'),
(8, 'Rousseau', 'Julie', '1988-06-18'),
(9, 'Leroy', 'Claire', '1981-10-05'),
(10, 'Bernard', 'Marc', '1983-12-30'),
(11, 'Dubois', 'Paul', '1985-05-15'),
(12, 'Fontaine', 'Marie', '1990-08-22'),
(13, 'Simon', 'Luc', '1978-11-30');

-- Insertion de données dans la table Personnel
INSERT INTO Personnel (id_pers, embauche, finContrat, salaire, hopital_id)
VALUES
(1, '2000-01-15', NULL, 5000, 1),
(2, '2005-03-20', NULL, 4500, 1),
(3, '2002-07-30', NULL, 5200, 2),
(4, '2010-05-10', NULL, 3500, 1),
(5, '2012-09-20', NULL, 3800, 2),
(6, '2008-04-12', NULL, 3700, 1),
(7, '2006-06-25', NULL, 3000, 2),
(8, '2011-08-18', NULL, 3200, 2),
(9, '2003-10-05', NULL, 4000, 1),
(10, '2007-12-30', NULL, 4200, 1);

-- Insertion de données dans la table Medecin
INSERT INTO Medecin (id_med, specialite)
VALUES
(1, 'Cardiologie'),
(2, 'Pédiatrie'),
(3, 'Neurologie');

-- Insertion de données dans la table Infirmier
INSERT INTO Infirmier (id_inf, service)
VALUES
(4, 'Urgences'),
(5, 'Pédiatrie');

-- Insertion de données dans la table AgentEntretient
INSERT INTO AgentEntretient (id_agent)
VALUES
(7),
(8);

-- Insertion de données dans la table Administratif
INSERT INTO Administratif (id_admin, service)
VALUES
(9, 'Administration'),
(10, 'Ressources Humaines');

-- Insertion de données dans la table Patient
INSERT INTO Patient (id_pat, antecedentsMedicaux, raisonAccueil, dateEntree, dateSortiePrevisionnelle, dateSortieReelle)
VALUES
(11, 'Aucun', 'Opération', '2023-09-25', '2023-10-05', NULL),
(12, 'Diabète', 'Suivi', '2023-09-28', '2023-10-07', NULL),
(13, 'Hypertension', 'Contrôle', '2023-10-01', '2023-10-10', NULL);

-- Insertion de données dans la table VisiteMedicale
INSERT INTO VisiteMedicale (id_vis, date, examens, commentaires, medecin_id, patient_id)
VALUES
(1, '2023-10-01', 'Électrocardiogramme', 'Résultats normaux', 1, 11),
(2, '2023-10-02', 'Radiographie', 'Fracture détectée', 2, 12);

-- Insertion de données dans la table CompteRendu
INSERT INTO CompteRendu (id_com, date, examens, commentaires, visite_id)
VALUES
(1, '2023-10-01', 'Électrocardiogramme', 'Résultats normaux', 1),
(2, '2023-10-02', 'Radiographie', 'Fracture détectée', 2);

-- Insertion de données dans la table Soin
INSERT INTO Soin (id_soi, dateHeure, description, medicaments, quantite, infirmier_id, patient_id)
VALUES
(1, '2023-10-01 08:00:00', 'Administration de médicaments', 'Paracétamol', 2, 4, 11),
(2, '2023-10-02 09:00:00', 'Changement de pansement', 'Ibuprofène', 0, 5, 12);

-- Insertion de données dans la table Reunion
INSERT INTO Reunion (id_reu, dateHeure)
VALUES
(1, '2023-09-30 10:00:00'),
(2, '2023-10-01 11:00:00');

-- Insertion de données dans la table Participant_Reunion
INSERT INTO Participant_Reunion (personnel_id, reunion_id)
VALUES
(1, 1),
(2, 1),
(4, 2),
(5, 2);

-- Insertion de données dans la table Service
INSERT INTO Service (id_serv, nom, responsableAdministratif_id, medecinReferent_id)
VALUES
(1, 'Cardiologie', 9, 1),
(2, 'Pédiatrie', 10, 2);

-- Insertion de données dans la table Chambre
INSERT INTO Chambre (numero, etage, capacite, service_id)
VALUES
(101, 1, 2, 1),
(102, 1, 2, 1),
(201, 2, 4, 2);

-- Insertion de données dans la table Lit
INSERT INTO Lit (id_lit, numero, chambre_numero, service_id, occupant_id, dateDernierAgentEntretient, nettoyeur_id)
VALUES
(1, 1, 101, 1, 11, '2023-10-01', 7),
(2, 2, 101, 1, NULL, '2023-10-02', 8),
(3, 1, 201, 2, 12, '2023-10-03', 7);
