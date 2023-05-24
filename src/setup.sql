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

-- Main entity corresponding to the place where the evenment/concert takes place
DROP TABLE IF EXISTS Lieu CASCADE;

-- Main entity corresponding to a band's (or bands') song
DROP TABLE IF EXISTS Morceau CASCADE;

-- Main entities corresponding to Playlist
DROP TABLE IF EXISTS Playlist CASCADE;


-- Users Entity
/*
CREATE TABLE Utilisateur (
    id_user SERIAL INTEGER PRIMARY KEY NOT NULL,
    nom VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE
);
*/

-- Users sub entities
CREATE TABLE Association (
    id_assoc SERIAL INTEGER PRIMARY KEY NOT NULL,
    nom VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE
); -- -INHERITS (Utilisateur);

CREATE TABLE Personne (
    id_user SERIAL INTEGER PRIMARY KEY NOT NULL,
    nom VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE
);-- INHERITS (Utilisateur);

CREATE TABLE Groupe (
    id_grp SERIAL INTEGER PRIMARY KEY NOT NULL,
    nom VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE
); --INHERITS (Utilisateur);



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


-- Event Entity --

-- Sub Event Entity
CREATE TABLE Evenement_Passe (
    id_event INTEGER PRIMARY KEY,
    date_e DATE NOT NULL,
    name_e VARCHAR NOT NULL,
    kids_e BOOLEAN NOT NULL,
    ext_e BOOLEAN NOT NULL
);


-- Place Entity
CREATE TABLE Lieu (
    id_place SERIAL INTEGER PRIMARY KEY,
    name_p VARCHAR NOT NULL,
    city_p VARCHAR NOT NULL,
    code_postal INTEGER NOT NULL
);


-- Playlist Entity
CREATE TABLE Playlist (
    id INTEGER PRIMARY KEY,
    nom VARCHAR NOT NULL,
    description VARCHAR
);


-- Opinions Entity
/*
CREATE TABLE Avis (
    id_avis INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    commentaire VARCHAR NOT NULL,
    PRIMARY KEY (id_avis, id_user),
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user)
);
*/

-- Sub Opinions entities
CREATE TABLE Avis_Groupe (
    id_avis SERIAL INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    id_grp INTEGER NOT NULL
    commentary VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_user) REFERENCES Personne (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_grp) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_grp) -- the user can only rate the band once 
);

CREATE TABLE Avis_Morceau (
    id_avis SERIAL INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    id_song INTEGER NOT NULL,
    commentary VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_user) REFERENCES Personne (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_song) REFERENCES Morceau (id_song) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_song) -- the user can only rate the band once 
);

-- TODO: check for the id_event references (if it refers to a passed event or to a future one)
CREATE TABLE Avis_Evenement (
    id_avis SERIAL INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    commentary VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_user) REFERENCES Personne (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    --FOREIGN KEY (id_event) REFERENCES Evenement_Passe (id_event) ON DELETE CASCADE ON UPDATE CASCADE,
    --FOREIGN KEY (id_event) REFERENCES Evenement_Futur (id_event) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_event)
);

CREATE TABLE Avis_Lieu (
    id_avis SERIAL INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    id_place INTEGER NOT NULL,
    commentary VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_user) REFERENCES Personne (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_place)
);


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
