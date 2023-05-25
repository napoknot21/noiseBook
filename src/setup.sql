-- Sub entities (corresponding to 'Utilisateur')
DROP TABLE IF EXISTS Utilisateur CASCADE;
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
DROP TABLE IF EXISTS interaction CASCADE;
DROP TABLE IF EXISTS pl_belongs CASCADE ; -- The songs track belong to the PlayList
DROP TABLE IF EXISTS relation_ta CASCADE;
DROP TABLE IF EXISTS follow CASCADE;
DROP TABLE IF EXISTS amitie CASCADE;
--

-- Users sub entities --

CREATE TABLE Utilisateur (
    id_user SERIAL PRIMARY KEY NOT NULL,
    name_assoc VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
);

CREATE TABLE Groupe (
    status_g BOOLEAN NOT NULL
) INHERITS (Utilisateur);


-- Place Entity --

CREATE TABLE Lieu (
    id_place SERIAL PRIMARY KEY,
    name_p VARCHAR NOT NULL,
    city_p VARCHAR NOT NULL,
    cp_p INTEGER NOT NULL -- code Postal
);


-- Event sub Entities --

CREATE TABLE Evenement_Passe (
    id_event SERIAL PRIMARY KEY,
    id_p INTEGER NOT NULL,
    date_ep DATE NOT NULL,
    name_ep VARCHAR NOT NULL,
    kids_ep BOOLEAN NOT NULL,
    ext_ep BOOLEAN NOT NULL,
    mult_ep TEXT NOT NULL,
    FOREIGN KEY (id_p) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Evenement_Futur (
    id_event SERIAL PRIMARY KEY,
    id_p INTEGER NOT NULL,
    date_ef DATE NOT NULL,
    name_ef VARCHAR NOT NULL,
    kids_ef BOOLEAN NOT NULL,
    ext_ef BOOLEAN NOT NULL,
    FOREIGN KEY (id_p) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Morceau (
    id_s SERIAL PRIMARY KEY,
    id_g INTEGER NOT NULL,
    album TEXT NOT NULL,
    n_order INTEGER NOT NULL,
    FOREIGN KEY (id_g) REFERENCES Groupe (id_user) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Playlist Entity --

CREATE TABLE Playlist (
    id_pl SERIAL PRIMARY KEY,
    name_pl VARCHAR NOT NULL,
    desc_pl VARCHAR

);


-- Opinion sub entities --

CREATE TABLE Avis (
    id_avis SERIAL PRIMARY KEY
);

CREATE TABLE Avis_Groupe (
    id_user INTEGER NOT NULL,
    id_grp INTEGER NOT NULL
    commentary VARCHAR(50),
    note_g INTEGER NOT NULL,
    CONSTRAINT note_min CHECK (note_g >= 0),
    CONSTRAINT note_max CHECK (note_g <= 5),
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_grp) -- the user can only rate the band once 
) INHERITS (Avis);

CREATE TABLE Avis_Morceau (
    id_user INTEGER NOT NULL,
    id_song INTEGER NOT NULL,
    commentary VARCHAR(50) NOT NULL,
    note_song INTEGER NOT NULL,
    CONSTRAINT note_min CHECK (note_song >= 0),
    CONSTRAINT note_max CHECK (note_song <= 5),
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_song) REFERENCES Morceau (id_song) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_song) -- the user can only rate the band once 
) INHERITS (Avis);

CREATE TABLE Avis_Evenement (
    id_user INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    commentary VARCHAR(50),
    note_event INTEGER NOT NULL,
    CONSTRAINT note_min CHECK(note_event >= 0),
	CONSTRAINT note_max CHECK(note_event <= 5),
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement_Passe (id_event) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_event)
) INHERITS (Avis);

CREATE TABLE Avis_Lieu (
    id_user INTEGER NOT NULL,
    id_place INTEGER NOT NULL,
    commentary VARCHAR(50) NOT NULL,
    note_p INTEGER NOT NULL,
	CONSTRAINT note_min CHECK(note_p >= 0),
	CONSTRAINT note_max CHECK(note_p <= 5),
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_place)
) INHERITS (Avis);



-- Tag Entities --

CREATE TABLE Tag (
    id_tag SERIAL PRIMARY KEY NOT NULL,
);

CREATE TABLE Tag_General (
    text TEXT NOT NULL,
    UNIQUE(id_tag, text)
) INHERITS (Tag);

CREATE TABLE Tag_Lieu(
    id_p INTEGER NOT NULL,
    FOREIGN KEY (id_p) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_tag, id_p)
) INHERITS (Tag);

CREATE TABLE Tag_Groupe (
    id_grp INTEGER NOT NULL,
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_tag, id_grp)
) INHERITS (Tag);



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
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement_Futur (id_event) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE organise (
    id_user INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    PRIMARY KEY (id_event, id_user),
    FOREIGN KEY (id_user) REFERENCES Association (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement_Futur (id_event) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE status (
    id_p INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    status_s TEXT IN ('INTERESSESTED', 'PARTICIPATE', 'NOT_INTERESTED'),
    PRIMARY KEY (id_p, id_event),
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement_Futur (id_event) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE follows (
    -- id_f SERIAL PRIMARY KEY,
    id_userFollows INTEGER NOT NULL,
    id_userFollowed INTEGER NOT NULL,
    FOREIGN KEY (id_userFollows) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_userFollowed) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (id_userFollows, id_userFollowed)
);

CREATE TABLE amitie (
    id_userA INTEGER NOT NULL,
    id_userB INTEGER NOT NULL,
    FOREIGN KEY (id_userA) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_userB) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (id_userA, id_userB)
    -- CREATE SYMENTRIC KEY
);

CREATE TABLE pl_belongs (
    id_s INTEGER NOT NULL,
    id_pl INTEGER NOT NULL,
    FOREIGN KEY (id_s) REFERENCES Morceau (id_s) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_pl) REFERENCES PlayList (id_pl) ON DELETE CASCADE ON UPDATE CASCADE
    -- check for entering values
    -- trigger

);

CREATE TABLE relation_ta (
    id_t INTEGER NOT NULL,
    id_avis INTEGER NOT NULL,
    FOREIGN KEY (id_t) REFERENCES Tag (id_tag) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_avis) REFERENCES Avis (id_avis) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE derive_g (
    id_gp INTEGER NOT NULL,
    id_ge INTEGER NOT NULL,
    FOREIGN KEY (id_gp) REFERENCES Genre (id_g) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ge) REFERENCES Genre (id_g) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (id_gp, id_ge)
)