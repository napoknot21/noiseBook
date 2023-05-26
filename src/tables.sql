-- Main entity: User (Utilisateur) --
-- Table to store user data. Each user has a unique id, name, and email.
CREATE TABLE Utilisateur (
    id_user SERIAL PRIMARY KEY NOT NULL, -- unique identifier for the user
    name_user VARCHAR NOT NULL, -- user's name
    email VARCHAR NOT NULL UNIQUE, -- user's email address
    UNIQUE (email)
);

-- Users sub entities (Groupe) --
-- Table to represent user groups. Each group is also a user and inherits from the User table.
CREATE TABLE Groupe (
    id_user SERIAL PRIMARY KEY NOT NULL, -- unique identifier for the group, also a user id
    status_g BOOLEAN NOT NULL -- indicates whether the group is 'checked' or not checked
) INHERITS (Utilisateur);


-- Song entity (Morceau) --
-- Table to store song data. Each song has a unique id, and is associated with a group and an album.
CREATE TABLE Morceau (
    id_s SERIAL PRIMARY KEY NOT NULL, -- unique identifier for the song
    name_s TEXT NOT NULL,
    id_g INTEGER NOT NULL, -- id of the group that the song belongs to
    album TEXT NOT NULL, -- name of the album that the song belongs to
    n_order INTEGER NOT NULL, -- order of the song in the album
    FOREIGN KEY (id_g) REFERENCES Groupe (id_user) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Place entity (Lieu) --
-- Table to store data about places. Each place has a unique id, name, city and zip code.
CREATE TABLE Lieu (
    id_place SERIAL PRIMARY KEY, -- unique identifier for the place
    name_p VARCHAR NOT NULL, -- name of the place
    city_p VARCHAR NOT NULL, -- city where the place is located
    cp_p INTEGER NOT NULL -- zip code of the place
);



-- Main entities: Past Event (Evenement_Passe) and Future Event (Evenement_Futur) --
-- Table to store data about events. Each event has a unique id and is associated with a place.
CREATE TABLE Evenement (
    id_event SERIAL PRIMARY KEY, -- unique identifier for the event
    id_p INTEGER NOT NULL, -- id of the place where the event will be held
    kids BOOLEAN NOT NULL, -- whether the event is suitable for kids
    price_e INTEGER NOT NULL, -- price of the event
    ext BOOLEAN NOT NULL, -- external or internal event
    FOREIGN KEY (id_p) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Sub-table for past events. Inherits from Event table.
CREATE TABLE Evenement_Passe (
    id_event SERIAL PRIMARY KEY, -- unique identifier for the event, also an event id
    date_ep DATE NOT NULL, -- date of the event
    name_ep VARCHAR NOT NULL, -- name of the event
    mult_ep TEXT NOT NULL -- multimedia attribute
) INHERITS (Evenement);

-- Sub-table for future events. Inherits from Event table.
CREATE TABLE Evenement_Futur (
    id_event SERIAL PRIMARY KEY, -- unique identifier for the event, also an event id
    date_ef DATE NOT NULL, -- date of the event
    name_ef VARCHAR NOT NULL -- name of the event
) INHERITS (Evenement);


-- Gender entity (Genre) --
-- Table to store data about music genres. Each genre has a unique id and name.
CREATE TABLE Genre (
    id_g SERIAL PRIMARY KEY, -- unique identifier for the genre
    name_genre VARCHAR NOT NULL, -- name of the genre
    UNIQUE (name_genre) -- the genre name is unique
);


-- Main entity: Playlist --
-- Table to store data about playlists. Each playlist has a unique id, a name and a description.
CREATE TABLE Playlist (
    id_pl SERIAL PRIMARY KEY, -- unique identifier for the playlist
    name_pl VARCHAR NOT NULL, -- name of the playlist
    desc_pl VARCHAR -- description of the playlist
);


-- Opinion sub entities (Avis) --
-- Main table for storing reviews. Each review has a unique id.
CREATE TABLE Avis (
    id_avis SERIAL PRIMARY KEY -- unique identifier for the review
);

-- Sub-table for reviews about groups. Inherits from Review table.
CREATE TABLE Avis_Groupe (
    id_avis SERIAL PRIMARY KEY NOT NULL, -- unique identifier for the review, also a review id
    id_user INTEGER NOT NULL, -- id of the user who wrote the review
    id_grp INTEGER NOT NULL, -- id of the group the review is about
    commentary VARCHAR(50), -- the review itself
    note_g INTEGER NOT NULL, -- the rating the user gave
    CONSTRAINT note_min CHECK (note_g >= 0),
    CONSTRAINT note_max CHECK (note_g <= 5),
    FOREIGN KEY (id_avis) REFERENCES Avis (id_avis) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_grp) -- the user can only rate the band once
) INHERITS (Avis);

CREATE TABLE Avis_Morceau (
    id_avis SERIAL PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    id_song INTEGER NOT NULL,
    commentary VARCHAR(50),
    note_m INTEGER NOT NULL,
    CONSTRAINT note_min CHECK (note_m >= 0),
    CONSTRAINT note_max CHECK (note_m <= 5),
    FOREIGN KEY (id_avis) REFERENCES Avis (id_avis) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_song) REFERENCES Morceau (id_s) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_song) -- the user can only rate the song once
) INHERITS (Avis);

CREATE TABLE Avis_Evenement (
    id_avis SERIAL PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    commentary VARCHAR(50),
    note_event INTEGER NOT NULL,
    CONSTRAINT note_min CHECK(note_event >= 0),
	CONSTRAINT note_max CHECK(note_event <= 5),
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement (id_event) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_event)
) INHERITS (Avis);

CREATE TABLE Avis_Lieu (
    id_avis SERIAL PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    id_place INTEGER NOT NULL,
    commentary VARCHAR(50),
    note_l INTEGER NOT NULL,
    CONSTRAINT note_min CHECK (note_l >= 0),
    CONSTRAINT note_max CHECK (note_l <= 5),
    FOREIGN KEY (id_avis) REFERENCES Avis (id_avis) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_place) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_user, id_place) -- the user can only rate the place once
);


-- Tag Entities --

CREATE TABLE Tag (
    id_tag SERIAL PRIMARY KEY NOT NULL
);

CREATE TABLE Tag_General (
    id_tag SERIAL PRIMARY KEY NOT NULL,
    text TEXT NOT NULL,
    UNIQUE(id_tag, text)
) INHERITS (Tag);

CREATE TABLE Tag_Lieu(
    id_tag SERIAL PRIMARY KEY NOT NULL,
    id_p INTEGER NOT NULL,
    FOREIGN KEY (id_p) REFERENCES Lieu (id_place) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_tag, id_p)
) INHERITS (Tag);

CREATE TABLE Tag_Groupe (
    id_tag SERIAL PRIMARY KEY NOT NULL,
    id_grp INTEGER NOT NULL,
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_tag, id_grp)
) INHERITS (Tag);

CREATE TABLE Tag_Genre (
    id_tag SERIAL PRIMARY KEY NOT NULL,
    id_g INTEGER NOT NULL,
    FOREIGN KEY (id_g) REFERENCES Genre (id_g) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (id_tag, id_g)
) INHERITS (Tag);


-- -Associations- --

CREATE TABLE concert (
    id_grp INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    PRIMARY KEY (id_event, id_grp),
    FOREIGN KEY (id_grp) REFERENCES Groupe (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement (id_event) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE organise (
    id_user INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement (id_event) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (id_event, id_user)
);

CREATE TYPE interaction_status AS ENUM ('INTERESTED', 'PARTICIPATE', 'NOT_INTERESTED');

CREATE TABLE interaction (
    id_i SERIAL PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    status_s interaction_status NOT NULL,
    FOREIGN KEY (id_user) REFERENCES Utilisateur (id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_event) REFERENCES Evenement (id_event) ON DELETE CASCADE ON UPDATE CASCADE
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
);

CREATE OR REPLACE FUNCTION ensure_symmetric_amitie() RETURNS TRIGGER AS $friends$
    BEGIN
    -- Check if the reverse relationship already exists
    IF NOT EXISTS (SELECT 1 FROM amitie WHERE id_userA = NEW.id_userB AND id_userB = NEW.id_userA) THEN
        -- If not, insert it
        INSERT INTO amitie (id_userA, id_userB) VALUES (NEW.id_userB, NEW.id_userA);
    END IF;
    RETURN NEW;
    END;
$friends$ LANGUAGE plpgsql;

CREATE TRIGGER amitie_trigger
AFTER INSERT ON amitie
FOR EACH ROW EXECUTE FUNCTION ensure_symmetric_amitie();


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
    id_gp INTEGER NOT NULL, --id of the gender parent
    id_ge INTEGER NOT NULL, --id of the gender child
    CONSTRAINT not_equal CHECK (id_gp <> id_ge),
    FOREIGN KEY (id_gp) REFERENCES Genre (id_g) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ge) REFERENCES Genre (id_g) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (id_gp, id_ge)
);