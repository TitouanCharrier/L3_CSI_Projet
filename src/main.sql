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
    id_hop INT,
    FOREIGN KEY (id_pers) REFERENCES Personne(id_per),
    FOREIGN KEY (id_hop) REFERENCES Hopital(id_hop)
);

-- Tables spécialisées (Medecin, Infirmier, AgentEntretient, Administratif)
CREATE TABLE Medecin (
    id_med INT PRIMARY KEY,
    specialite VARCHAR(100),
    FOREIGN KEY (id_med) REFERENCES Personnel(id_pers)
);

CREATE TABLE Infirmier (
    id_inf INT PRIMARY KEY,
    service VARCHAR(100),
    FOREIGN KEY (id_inf) REFERENCES Personnel(id_pers)
);

CREATE TABLE AgentEntretient (
    id_agent INT PRIMARY KEY,
    FOREIGN KEY (id_agent) REFERENCES Personnel(id_pers)
);

CREATE TABLE Administratif (
    id_admin INT PRIMARY KEY,
    service VARCHAR(100),
    FOREIGN KEY (id_admin) REFERENCES Personnel(id_pers)
);

-- Table Patient (Hérite de Personne)
CREATE TABLE Patient (
    id_pat INT PRIMARY KEY,
    antecedentsMedicaux TEXT,
    raisonAccueil TEXT,
    dateEntree DATE,
    dateSortiePrevisionnelle DATE,
    dateSortieReelle DATE,
    FOREIGN KEY (id_pat) REFERENCES Personne(id_per)
);

-- Table VisiteMedicale
CREATE TABLE VisiteMedicale (
    id_vis INT PRIMARY KEY,
    date DATE,
    examens TEXT,
    commentaires TEXT,
    id_med INT,
    id_pat INT,
    FOREIGN KEY (id_med) REFERENCES Medecin(id_med),
    FOREIGN KEY (id_pat) REFERENCES Patient(id_pat)
);

-- Table Medicament
CREATE TABLE Medicament (
    id_medica INT PRIMARY KEY,
    nom_medica TEXT
);

-- Table Soin
CREATE TABLE Soin (
    id_soin INT PRIMARY KEY,
    dateHeure DATETIME,
    description TEXT,
    id_inf INT,
    id_pat INT,
    FOREIGN KEY (id_inf) REFERENCES Infirmier(id_inf),
    FOREIGN KEY (id_pat) REFERENCES Patient(id_pat)
);

-- Table Ordonnance
CREATE TABLE Ordonnance (
    id_medica INT,
    id_soin INT,
    quantite INT,
    PRIMARY KEY (id_medica, id_soin),
    FOREIGN KEY (id_medica) REFERENCES Medicament (id_medica),
    FOREIGN KEY (id_soin) REFERENCES Soin (id_soin)
);

-- Table Reunion
CREATE TABLE Reunion (
    id_reu INT PRIMARY KEY,
    dateHeure DATETIME
);

-- Table CompteRendu
CREATE TABLE CompteRendu (
    id_com INT PRIMARY KEY,
    date DATE,
    commentaires TEXT,
    id_reu INT,
    FOREIGN KEY (id_reu) REFERENCES Reunion(id_reu)
);

-- Table Participant_Reunion (Relation n-n entre Personnel et Reunion)
CREATE TABLE Participant_Reunion (
    id_pers INT,
    id_reu INT,
    PRIMARY KEY (id_pers, id_reu),
    FOREIGN KEY (id_pers) REFERENCES Personnel(id_pers),
    FOREIGN KEY (id_reu) REFERENCES Reunion(id_reu)
);

-- Table Service
CREATE TABLE Service (
    id_serv INT PRIMARY KEY,
    nom VARCHAR(100),
    id_admin INT,
    id_med_ref INT,
    FOREIGN KEY (id_admin) REFERENCES Administratif(id_admin),
    FOREIGN KEY (id_med_ref) REFERENCES Medecin(id_med)
);

-- Table Etage
CREATE TABLE Etage (
    id_eta INT PRIMARY KEY,
    id_serv INT,
    FOREIGN KEY (id_serv) REFERENCES Service(id_serv)
);

-- Table Chambre
CREATE TABLE Chambre (
    numero_cha INT PRIMARY KEY,
    etage INT,
    capacite INT,
    id_serv INT,
    FOREIGN KEY (id_serv) REFERENCES Service(id_serv)
);

-- Table Lit
CREATE TABLE Lit (
    id_lit INT PRIMARY KEY,
    numero_cha INT,
    id_pat INT,
    dateDernierEntretient DATE,
    id_agent INT,
    FOREIGN KEY (numero_cha) REFERENCES Chambre(numero_cha),
    FOREIGN KEY (id_pat) REFERENCES Patient(id_pat),
    FOREIGN KEY (id_agent) REFERENCES AgentEntretient(id_agent)
);

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
INSERT INTO Personnel (id_pers, embauche, finContrat, salaire, id_hop)
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
INSERT INTO VisiteMedicale (id_vis, date, examens, commentaires, id_med, id_pat)
VALUES
(1, '2023-10-01', 'Électrocardiogramme', 'Résultats normaux', 1, 11),
(2, '2023-10-02', 'Radiographie', 'Fracture détectée', 2, 12);

--Insertion de données dans la table Medicament
INSERT INTO Medicament (id_medica, nom_medica)
VALUES
(1, 'Paracetamol'),
(2, 'Ibuprofene');

-- Insertion de données dans la table Soin
INSERT INTO Soin (id_soin, dateHeure, description, id_inf, id_pat)
VALUES
(1, '2023-10-01 08:00:00', 'Administration de médicaments', 4, 11),
(2, '2023-10-02 09:00:00', 'Changement de pansement', 5, 12);

-- Insertion de données dans la table Ordonnance
INSERT INTO Ordonnance (id_medica, id_soin, quantite)
VALUES
(1, 1, 2),
(2, 1, 1);

-- Insertion de données dans la table Reunion
INSERT INTO Reunion (id_reu, dateHeure)
VALUES
(1, '2023-09-30 10:00:00'),
(2, '2023-10-01 11:00:00');

-- Insertion de données dans la table CompteRendu
INSERT INTO CompteRendu (id_com, date, commentaires, id_reu)
VALUES
(1, '2023-10-01', 'RAS', 1),
(2, '2023-10-02', 'RAS', 2);

-- Insertion de données dans la table Participant_Reunion
INSERT INTO Participant_Reunion (id_pers, id_reu)
VALUES
(1, 1),
(2, 1),
(4, 2),
(5, 2);

-- Insertion de données dans la table Service
INSERT INTO Service (id_serv, nom, id_admin, id_med_ref)
VALUES
(1, 'Cardiologie', 9, 1),
(2, 'Pédiatrie', 10, 2);

-- Insertion de données dans la table Etage
INSERT INTO Etage (id_eta, id_serv)
VALUES
(1, 1),
(2, 2);

-- Insertion de données dans la table Chambre
INSERT INTO Chambre (numero_cha, etage, capacite)
VALUES
(1, 1, 2),
(2, 1, 2),
(3, 2, 4);

-- Insertion de données dans la table Lit
INSERT INTO Lit (id_lit, numero_cha, id_pat, dateDernierEntretient, id_agent)
VALUES
(1, 1, 11, '2023-10-01', 7),
(2, 2, 12, '2023-10-02', 8),
(3, 1, 13, '2023-10-03', 7);
