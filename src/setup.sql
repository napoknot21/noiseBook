DROP TABLE IF EXISTS concert CASCADE;
DROP TABLE IF EXISTS participe CASCADE;
DROP TABLE IF EXISTS performe CASCADE;
DROP TABLE IF EXISTS organise CASCADE;

-- Sub entities (corresponding to 'Utilisateur')
DROP TABLE IF EXISTS Association CASCADE;
DROP TABLE IF EXISTS Personne CASCADE;
DROP TABLE IF EXISTS Groupe CASCADE;

-- Sub entities (corresponding to 'Evenement')
DROP TABLE IF EXISTS Evenement_Passe CASCADE;
DROP TABLE IF EXISTS Evenement_Future CASCADE;

-- Sub entities (corresponding to 'Avis')
DROP TABLE IF EXISTS Avis_Groupe CASCADE;
DROP TABLE IF EXISTS Avis_Association CASCADE;
DROP TABLE IF EXISTS Avis_Morceau CASCADE;
DROP TABLE IF EXISTS AviS_Lieu CASCADE;
DROP TABLE IF EXISTS Avis_Evenement CASCADE;
DROP TABLE IF EXISTS Avis_Playlist CASCADE;

-- Sub entities (corresponding to 'Tag')
DROP TABLE IF EXISTS Tag_Lieu CASCADE;
DROP TABLE IF EXISTS Tag_Groupe CASCADE;
DROP TABLE IF EXISTS Tag_Concert CASCADE;
DROP TABLE IF EXISTS Tag_Genre CASCADE;
DROP TABLE IF EXISTS Tag_Association CASCADE;

DROP TABLE IF EXISTS Genre CASCADE;
DROP TABLE IF EXISTS Sous_Genre CASCADE;

DROP TABLE IF EXISTS Concert CASCADE;
DROP TABLE IF EXISTS Concert_passe CASCADE;

DROP TABLE IF EXISTS Lieu CASCADE;

DROP TABLE IF EXISTS Playlist CASCADE;


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


-- Evenemenment Entity --

-- Sub Evenement Entity
CREATE TABLE Evenement_Passe (
    id_even INTEGER PRIMARY KEY,
    date_h DATE NOT NULL,
    nom VARCHAR NOT NULL,
    enfants BOOLEAN NOT NULL,
    exterieur BOOLEAN NOT NULL
);


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
CREATE TABLE Tag_Groupe () INHERITS (Tag);

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
