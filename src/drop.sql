-- Sub entities (corresponding to 'Utilisateur')
DROP TABLE IF EXISTS Utilisateur CASCADE;
DROP TABLE IF EXISTS Groupe CASCADE;

-- Main entity corresponding to a band's (or bands') song
DROP TABLE IF EXISTS Morceau CASCADE;

-- Sub entities (corresponding to 'Evenement')
DROP TABLE IF EXISTS Evenement_Passe CASCADE;
DROP TABLE IF EXISTS Evenement_Futur CASCADE;
DROP TABLE IF EXISTS Evenement CASCADE;

-- Sub entities (corresponding to 'Avis')
DROP TABLE IF EXISTS Avis CASCADE;
DROP TABLE IF EXISTS Avis_Groupe CASCADE;
DROP TABLE IF EXISTS Avis_Morceau CASCADE;
DROP TABLE IF EXISTS AviS_Lieu CASCADE;
DROP TABLE IF EXISTS Avis_Evenement CASCADE;
DROP TABLE IF EXISTS Avis_Playlist CASCADE;

-- Sub entities (corresponding to 'Tag')
DROP TABLE IF EXISTS Tag CASCADE;
DROP TABLE IF EXISTS Tag_General CASCADE;
DROP TABLE IF EXISTS Tag_Lieu CASCADE;
DROP TABLE IF EXISTS Tag_Groupe CASCADE;
DROP TABLE IF EXISTS Tag_Concert CASCADE;
DROP TABLE IF EXISTS Tag_Genre CASCADE;

-- Main entity corresponding to the place where the event/concert takes place
DROP TABLE IF EXISTS Lieu CASCADE;

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
DROP TABLE IF EXISTS derive_g CASCADE;
DROP TABLE IF EXISTS follows CASCADE;
DROP TABLE IF EXISTS amitie CASCADE;