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
DROP TABLE IF EXISTS Tag_General CASCADE;
DROP TABLE IF EXISTS Tag_Lieu CASCADE;
DROP TABLE IF EXISTS Tag_Groupe CASCADE;
DROP TABLE IF EXISTS Tag_Concert CASCADE;
DROP TABLE IF EXISTS Tag_Genre CASCADE;
DROP TABLE IF EXISTS Tag_Association CASCADE;

-- Main entity corresponding to the place where the event/concert takes place
DROP TABLE IF EXISTS Lieu CASCADE;

-- Main entity corresponding to a band's (or bands') song
DROP TABLE IF EXISTS Morceau CASCADE;

-- Main entity corresponding to a gender group, song, etc.
DROP TABLE IF EXISTS Genre CASCADE;

-- Main entities corresponding to Playlist
DROP TABLE IF EXISTS Playlist CASCADE;

-- Some relational associations
DROP TABLE IF EXISTS concert CASCADE; -- group and event associated
DROP TABLE IF EXISTS organise CASCADE; -- association and event associated


-- Users sub entities --

CREATE TABLE Association (
    id_assoc SERIAL INTEGER PRIMARY KEY NOT NULL,
    name_assoc VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,

);

CREATE TABLE Personne (
    id_user SERIAL INTEGER PRIMARY KEY NOT NULL,
    name_user VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE
);

CREATE TABLE Groupe (
    id_grp SERIAL INTEGER PRIMARY KEY NOT NULL,
    name_grp VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE
);


-- Place Entity --

CREATE TABLE Lieu (
    id_place SERIAL INTEGER PRIMARY KEY,
    name_p VARCHAR NOT NULL,
    city_p VARCHAR NOT NULL,
    cp_p INTEGER NOT NULL -- code Postal
);


-- Event sub Entities --

CREATE TABLE Evenement_Passe (
    id_event SERIAL INTEGER PRIMARY KEY,
    id_p INTEGER NOT NULL,
    date_ep DATE NOT NULL,
    name_ep VARCHAR NOT NULL,
    kids_ep BOOLEAN NOT NULL,
    ext_ep BOOLEAN NOT NULL,
    mult_ep TEXT NOT NULL,
    FOREIGN KEY (id_p) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Evenement_Futur (
    id_event SERIAL INTEGER PRIMARY KEY,
    id_p INTEGER NOT NULL,
    date_ef DATE NOT NULL,
    name_ef VARCHAR NOT NULL,
    kids_ef BOOLEAN NOT NULL,
    ext_ef BOOLEAN NOT NULL,
    FOREIGN KEY (id_p) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Morceau (
    id_s SERIAL INTEGER PRIMARY KEY,
    id_g INTEGER NOT NULL,
    album TEXT NOT NULL,
    n_order INTEGER NOT NULL
    FOREIGN KEY (id_g) REFERENCES Groupe (id_grp) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Playlist Entity --

CREATE TABLE Playlist (
    id_pl SERIAL INTEGER PRIMARY KEY,
    name_pl VARCHAR NOT NULL,
    desc_pl VARCHAR,

);


-- Opinion sub entities --

CREATE TABLE Avis_Groupe (
    id_avis SERIAL INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    id_grp INTEGER NOT NULL
    commentary VARCHAR(50),
    note_g INTEGER NOT NULL,
    CONSTRAINT note_min CHECK (note_g >= 0),
    CONSTRAINT note_max CHECK (note_g <= 5),
    FOREIGN KEY (id_user) REFERENCES Personne (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_grp) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_grp) -- the user can only rate the band once 
);

CREATE TABLE Avis_Morceau (
    id_avis SERIAL INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    id_song INTEGER NOT NULL,
    commentary VARCHAR(50) NOT NULL,
    note_song INTEGER NOT NULL,
    CONSTRAINT note_min CHECK (note_song >= 0),
    CONSTRAINT note_max CHECK (note_song <= 5),
    FOREIGN KEY (id_user) REFERENCES Personne (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_song) REFERENCES Morceau (id_song) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_song) -- the user can only rate the band once 
);

CREATE TABLE Avis_Evenement (
    id_avis SERIAL INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    commentary VARCHAR(50),
    note_event INTEGER NOT NULL,
    CONSTRAINT note_min CHECK(note_event >= 0),
	CONSTRAINT note_max CHECK(note_event <= 5),
    FOREIGN KEY (id_user) REFERENCES Personne (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement_Passe (id_event) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_event)
);

CREATE TABLE Avis_Lieu (
    id_avis SERIAL INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    id_place INTEGER NOT NULL,
    commentary VARCHAR(50) NOT NULL,
    note_p INTEGER NOT NULL,
	CONSTRAINT note_min CHECK(note_p >= 0),
	CONSTRAINT note_max CHECK(note_p <= 5),
    FOREIGN KEY (id_user) REFERENCES Personne (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_place)
);



-- Tag Entities --

CREATE TABLE Tag_General (
    id_tag SERIAL INTEGER PRIMARY KEY NOT NULL,
    text TEXT NOT NULL
);

CREATE TABLE Tag_Lieu(
    id_tp SERIAL INTEGER PRIMARY KEY NOT NULL,
    id_p INTEGER NOT NULL,
    FOREIGN KEY (id_p) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_tp, id_p)
);

CREATE TABLE Tag_Groupe (
    id_tg SERIAL INTEGER PRIMARY KEY NOT NULL,
    id_grp INTEGER NOT NULL,
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_grp) ON DELETE CASCADE ON UPDATE CASCADE
);



-- Gender entity --

CREATE TABLE Genre (
    id_g SERIAL PRIMARY KEY,
    name_g VARCHAR PRIMARY KEY NOT NULL,
    UNIQUE (id_g, name_g)
);



-- -Associations- --

CREATE TABLE concert (
    id_grp INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    PRIMARY KEY (id_event, id_grp),
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_grp) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement_Futur (id_event) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE organise (
    id_assoc INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    PRIMARY KEY (id_event, id_lieu),
    FOREIGN KEY (id_assoc) REFERENCES Association (id_assoc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement_Futur (id_event) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE status (
    id_p INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    status_s TEXT IN ('INTERESSESTED', 'PARTICIPATE', 'NOT_INTERESTED'),
    PRIMARY KEY (id_p, id_event),
    FOREIGN KEY (id_assoc) REFERENCES Association (id_assoc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement_Futur (id_event) ON DELETE CASCADE ON UPDATE CASCADE
);

/*
CREATE TABLE follows (
    id_
)
*/