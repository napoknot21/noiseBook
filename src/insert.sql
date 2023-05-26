\copy Utilisateur(name_user, email) FROM './data/utilisateur_data.csv' DELIMITER ',' CSV
--\copy Groupe(name_user,email,status_g) FROM './data/groupe_data.csv' DELIMITER ',' CSV
\copy Lieu(name_p,city_p,cp_p) FROM './data/lieux_data.csv' DELIMITER ',' CSV
