DROP TABLE IF EXISTS concert;
DROP TABLE IF EXISTS participe;
DROP TABLE IF EXISTS performe;

DROP TABLE IF EXISTS Association;
DROP TABLE IF EXISTS Personne;
DROP TABLE IF EXISTS Groupe;

DROP TABLE IF EXISTS Evenement_Passe;

DROP TABLE IF EXISTS Avis_equipe;
DROP TABLE IF EXISTS Avis_Morceau;
DROP TABLE IF EXISTS AviS_Lieu;
DROP TABLE IF EXISTS Avis_Evenement;

DROP TABLE IF EXISTS Tag_Lieu;
DROP TABLE IF EXISTS Tag_Groupe;
DROP TABLE IF EXISTS Tag_Concert;

DROP TABLE IF EXISTS Sous_Genre;
DROP TABLE IF EXISTS Genre;

DROP TABLE IF EXISTS Utilisateur CASCADE;
DROP TABLE IF EXISTS Avis;
DROP TABLE IF EXISTS Evenement;
DROP TABLE IF EXISTS Concert;
DROP TABLE IF EXISTS Concert_passe;
DROP TABLE IF EXISTS Lieu;
DROP TABLE IF EXISTS Playlist;

-- Users Entity
CREATE TABLE Utilisateur (
    id_user INTEGER PRIMARY KEY NOT NULL,
    nom VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE
);

-- Users sub entities
CREATE TABLE Association () INHERITS (Utilisateur);
CREATE TABLE Personne () INHERITS (Utilisateur);
CREATE TABLE Groupe () INHERITS (Utilisateur);


-- CREATE TABLE concert (
--    heure DATETIME PRIMARY KEY,
--    line_up VARCHAR,
--   nb_places INTEGER,
--    volontaires INTEGER,
--    cause TYPE,
--   espace_ext BOOLEAN,
--    enfants BOOLEAN NOT NULL,
--    heure DATETIME
--);


-- Evenment Entity
CREATE TABLE Evenement (
    id_even INTEGER PRIMARY KEY,
    date_h DATE NOT NULL,
    nom VARCHAR NOT NULL,
    enfants BOOLEAN NOT NULL,
    exterieur BOOLEAN NOT NULL
);

-- Sub Evenement Entity
CREATE TABLE Evenement_Passe () INHERITS (Evenement);


-- Place Entity
CREATE TABLE Lieu (
    id_lieu INTEGER PRIMARY KEY NOT NULL,
    nom VARCHAR NOT NULL,
    ville VARCHAR NOT NULL,
    code_postal INTEGER NOT NULL
);


-- Playlist Entity
CREATE TABLE Playlist (
    id INTEGER PRIMARY KEY,
    nom VARCHAR NOT NULL,
    description VARCHAR
);


-- Opinions Entity
CREATE TABLE Avis (
    id_avis INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    commentaire VARCHAR NOT NULL,
    PRIMARY KEY (id_avis, id_user),
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user)
);

-- Sub Opinions entities
CREATE TABLE Avis_equipe () INHERITS (Avis);
CREATE TABLE Avis_Morceau () INHERITS (Avis);
CREATE TABLE Avis_Evenement () INHERITS (AviS);
CREATE TABLE AviS_Lieu () INHERITS (Avis);


-- Tag Entity
CREATE TABLE Tag ();

-- Sub Tags entities
CREATE TABLE Tag_Lieu() INHERITS (Tag);
CREATE TABLE Tag_Concert () INHERITS (Tag);
CREATE TABLE Tag_Groupe () INHERITS (Tags);

CREATE TABLE Genre (
    nom VARCHAR PRIMARY KEY NOT NULL
) INHERITS (Tag);

CREATE TABLE Sous_Genre (
    nom VARCHAR PRIMARY KEY NOT NULL
) INHERITS (Genre);

-- -Associations- --

CREATE TABLE concert (
    id_even INTEGER NOT NULL,
    id_lieu INTEGER NOT NULL,
    PRIMARY KEY (id_even, id_lieu),
    FOREIGN KEY (id_even) REFERENCES Evenement(id_even),
    FOREIGN KEY (id_lieu) REFERENCES Lieu(id_lieu)
);

CREATE TABLE participe (
    id_even INTEGER NOT NULL
);

CREATE TABLE organise (

);

CREATE TABLE performe (

);
