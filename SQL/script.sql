DROP TABLE IF EXISTS fournit; 
DROP TABLE IF EXISTS contenu;
DROP TABLE IF EXISTS ligne_commande; 
DROP TABLE IF EXISTS panier;
DROP TABLE IF EXISTS commande; 
DROP TABLE IF EXISTS user; 
DROP TABLE IF EXISTS peinture; 
DROP TABLE IF EXISTS etat; 
DROP TABLE IF EXISTS couleur; 
DROP TABLE IF EXISTS aspect;
DROP TABLE IF EXISTS type_conteneur; 
DROP TABLE IF EXISTS type_peinture; 
DROP TABLE IF EXISTS fournisseur;

CREATE TABLE IF NOT EXISTS user (
    user_id INT AUTO_INCREMENT,
    username VARCHAR(50), 
    password VARCHAR(200), 
    role VARCHAR(20),  
    est_actif INT, 
    pseudo VARCHAR(15), 
    email VARCHAR(30),
    PRIMARY KEY(user_id)
)CHARACTER SET 'utf8';

CREATE TABLE IF NOT EXISTS etat (
    idEtat INT AUTO_INCREMENT,
    libelleEtat VARCHAR(50),
    PRIMARY KEY(idEtat)
)CHARACTER SET 'utf8';

CREATE TABLE IF NOT EXISTS commande(
    idCommande INT AUTO_INCREMENT,
    dateAchat DATE,
    idUser INT,
    idEtat INT,
    PRIMARY KEy(idCommande),
    CONSTRAINT fk_user_commande FOREIGN KEY (idUser) REFERENCES user(user_id),
    CONSTRAINT fk_etat_commande FOREIGN KEY (idEtat) REFERENCES etat(idEtat)
)CHARACTER SET 'utf8';


CREATE TABLE IF NOT EXISTS couleur(
    idCouleur INT AUTO_INCREMENT,
    libelleCouleur VARCHAR(50),
    PRIMARY KEY(idCouleur)
)CHARACTER SET 'utf8';


CREATE TABLE IF NOT EXISTS aspect(
    idAspect INT AUTO_INCREMENT,
    libelleAspect VARCHAR(50),
    PRIMARY KEY(idAspect)
)CHARACTER SET 'utf8';

CREATE TABLE IF NOT EXISTS type_conteneur(
    idConteneur INT AUTO_INCREMENT,
    libelleConteneur VARCHAR(50),
    volume NUMERIC(10,2),
    PRIMARY KEY(idConteneur)
)CHARACTER SET 'utf8';


CREATE TABLE IF NOT EXISTS type_peinture(
    idType INT AUTO_INCREMENT,
    libelleType VARCHAR(50),
    supportDestination VARCHAR(50),
    tempsSechage INT,
    PRIMARY KEY(idType)
)CHARACTER SET 'utf8';


CREATE TABLE IF NOT EXISTS peinture(
    idPeinture INT AUTO_INCREMENT,
    nomPeinture VARCHAR(50),
    prix NUMERIC(5,2),
    stock INT,
    image VARCHAR(100),
    idAspect INT,
    idType INT,
    PRIMARY KEY(idPeinture),
    CONSTRAINT fk_aspect_peinture FOREIGN KEY (idAspect) REFERENCES aspect(idAspect),
    CONSTRAINT fk_type_peinture_peinture FOREIGN KEY (idType) REFERENCES type_peinture(idType)
)CHARACTER SET 'utf8';


CREATE TABLE IF NOT EXISTS panier(
    idPanier INT AUTO_INCREMENT,
    dateAjout DATE,
    quantite INT,
    idUser INT,
    idPeinture INT,
    PRIMARY KEy(idPanier),
    CONSTRAINT fk_user_panier FOREIGN KEY (idUser) REFERENCES user(user_id),
    CONSTRAINT fk_peinture_panier FOREIGN KEY (idPeinture) REFERENCES peinture(idPeinture)
)CHARACTER SET 'utf8';

CREATE TABLE IF NOT EXISTS fournisseur(
    idFournisseur INT AUTO_INCREMENT,
    nomFournisseur VARCHAR(50),
    pays VARCHAR(50),
    PRIMARY KEY(idFournisseur)
)CHARACTER SET 'utf8';


CREATE TABLE IF NOT EXISTS ligne_commande(
    idCommande INT,
    idPeinture INT,
    prixUnit NUMERIC(5,2),
    quantite INT,
    PRIMARY KEY(idCommande, idPeinture),
    CONSTRAINT fk_commande_ligne_commande FOREIGN KEY (idCommande) REFERENCES commande(idCommande),
    CONSTRAINT fk_peinture_commande_ligne FOREIGN KEY (idPeinture) REFERENCES peinture(idPeinture)
)CHARACTER SET 'utf8';

CREATE TABLE IF NOT EXISTS contenu(
   idPeinture INT,
   idConteneur INT,
   PRIMARY KEY(idPeinture, idConteneur),
   CONSTRAINT fk_peinture_contenu FOREIGN KEY(idPeinture) REFERENCES peinture(idPeinture),
   CONSTRAINT fk_conteneur_contenu FOREIGN KEY(idConteneur) REFERENCES type_conteneur(idConteneur)
)CHARACTER SET 'utf8';

CREATE TABLE IF NOT EXISTS fournit(
   idPeinture INT
   , idFournisseur INT
   , PRIMARY KEY(idPeinture, idFournisseur)
   , CONSTRAINT fk_peinture_fournit 
   FOREIGN KEY(idPeinture) 
   REFERENCES peinture(idPeinture)
   , CONSTRAINT fk_fournisseur_fournit 
   FOREIGN KEY(idFournisseur) 
   REFERENCES fournisseur(idFournisseur)
)CHARACTER SET 'utf8';


INSERT INTO user (user_id, email, username, password, role,  est_actif) VALUES 
(null, 'admin@admin.fr', 'admin', 'sha256$pBGlZy6UukyHBFDH$2f089c1d26f2741b68c9218a68bfe2e25dbb069c27868a027dad03bcb3d7f69a', 'ROLE_admin', 1);
INSERT INTO user (user_id, email, username, password, role,  est_actif) VALUES 
(null, 'client@client.fr', 'client', 'sha256$Q1HFT4TKRqnMhlTj$cf3c84ea646430c98d4877769c7c5d2cce1edd10c7eccd2c1f9d6114b74b81c4', 'ROLE_client',   1);
INSERT INTO user (user_id, email, username, password, role, est_actif) VALUES 
(null, 'client2@client2.fr', 'client2', 'sha256$ayiON3nJITfetaS8$0e039802d6fac2222e264f5a1e2b94b347501d040d71cfa4264cad6067cf5cf3', 'ROLE_client',   1);
INSERT INTO user (user_id, email, username, password, role, est_actif) VALUES 
(null,'aurelienguillou92@gmail.com','a','sha256$y0NWuYk5$bffafd929aebd1a4a5d8c8b0eab73c8b9f789e68ff4ae5740550e2feec8ce3b7','ROLE_client', 1 );


INSERT INTO etat (libelleEtat) VALUES ('en cours de traitement');
INSERT INTO etat (libelleEtat) VALUES ('expedié');

LOAD DATA LOCAL INFILE 'tpeinture.csv' INTO TABLE type_peinture CHARACTER SET utf8 FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'aspect.csv' INTO TABLE aspect CHARACTER SET utf8 FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'peinture.csv' INTO TABLE peinture CHARACTER SET utf8 FIELDS TERMINATED BY ',';
SHOW WARNINGS;
LOAD DATA LOCAL INFILE 'conteneur.csv' INTO TABLE type_conteneur CHARACTER SET utf8 FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'couleur.csv' INTO TABLE couleur CHARACTER SET utf8 FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'FOURNISSEUR.csv' INTO TABLE fournisseur CHARACTER SET utf8 FIELDS TERMINATED BY ';';
LOAD DATA LOCAL INFILE 'contenu.csv' INTO TABLE contenu CHARACTER SET utf8 FIELDS TERMINATED BY ',';
SHOW WARNINGS;
LOAD DATA LOCAL INFILE 'fournit.csv' INTO TABLE fournit CHARACTER SET utf8 FIELDS TERMINATED BY ',';
SHOW WARNINGS;

-- SELECT * FROM user;
-- SELECT * FROM commande;
-- SELECT * FROM ligne_commande;
-- SELECT * FROM panier;
-- SELECT * FROM etat;
-- SELECT * FROM fournit;
-- SELECT * FROM peinture;
-- SELECT * FROM couleur;
-- SELECT * FROM type_conteneur;
-- SELECT * FROM type_peinture;
-- SELECT * FROM aspect;
-- SELECT * FROM fournisseur;
