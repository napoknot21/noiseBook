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

-- Main entities corresponding to Playlist
DROP TABLE IF EXISTS Playlist CASCADE;