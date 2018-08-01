
CREATE SEQUENCE employe_id_seq;

CREATE TABLE Employe (
                id INTEGER NOT NULL DEFAULT nextval('employe_id_seq'),
                nom VARCHAR(50) NOT NULL,
                prenom VARCHAR(50) NOT NULL,
                CONSTRAINT employe_pk PRIMARY KEY (id)
);


ALTER SEQUENCE employe_id_seq OWNED BY Employe.id;

CREATE TABLE Livreur (
                employe_id INTEGER NOT NULL,
                immatriculation_scooter VARCHAR(50) NOT NULL,
                CONSTRAINT livreur_pk PRIMARY KEY (employe_id)
);


CREATE SEQUENCE client_id_seq_1;

CREATE TABLE Client (
                id INTEGER NOT NULL DEFAULT nextval('client_id_seq_1'),
                nom VARCHAR(50) NOT NULL,
                prenom VARCHAR(50) NOT NULL,
                adresse VARCHAR(150) NOT NULL,
                email VARCHAR(50) NOT NULL,
                motdepasse VARCHAR(50) NOT NULL,
                CONSTRAINT client_pk PRIMARY KEY (id)
);


ALTER SEQUENCE client_id_seq_1 OWNED BY Client.id;

CREATE SEQUENCE etablissement_id_seq;

CREATE TABLE Etablissement (
                id INTEGER NOT NULL DEFAULT nextval('etablissement_id_seq'),
                nom VARCHAR(100) NOT NULL,
                adresse VARCHAR(200) NOT NULL,
                CONSTRAINT etablissement_pk PRIMARY KEY (id)
);


ALTER SEQUENCE etablissement_id_seq OWNED BY Etablissement.id;

CREATE TABLE Vendeur (
                employe_id INTEGER NOT NULL,
                etablissement_id INTEGER NOT NULL,
                CONSTRAINT vendeur_pk PRIMARY KEY (employe_id)
);


CREATE TABLE Preparateur (
                employe_id INTEGER NOT NULL,
                etablissement_id INTEGER NOT NULL,
                CONSTRAINT preparateur_pk PRIMARY KEY (employe_id)
);


CREATE SEQUENCE ingredient_id_seq;

CREATE TABLE Ingredient (
                id INTEGER NOT NULL DEFAULT nextval('ingredient_id_seq'),
                nom VARCHAR(100) NOT NULL,
                poids INTEGER NOT NULL,
                CONSTRAINT ingredient_pk PRIMARY KEY (id)
);


ALTER SEQUENCE ingredient_id_seq OWNED BY Ingredient.id;

CREATE TABLE Stock (
                etablissement_id INTEGER NOT NULL,
                ingredient_id INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT stock_pk PRIMARY KEY (etablissement_id, ingredient_id)
);


CREATE TABLE Pizza (
                nom VARCHAR(50) NOT NULL,
                prix INTEGER NOT NULL,
                CONSTRAINT pizza_pk PRIMARY KEY (nom)
);


CREATE TABLE Recette (
                nom_pizza VARCHAR(50) NOT NULL,
                ingredient_id INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT recette_pk PRIMARY KEY (nom_pizza, ingredient_id)
);


CREATE SEQUENCE commande_numero_commande_seq;

CREATE TABLE Commande (
                numero_commande INTEGER NOT NULL DEFAULT nextval('commande_numero_commande_seq'),
                date DATE NOT NULL,
                statut VARCHAR(50) NOT NULL,
                nom_pizza VARCHAR(50) NOT NULL,
                client_id INTEGER NOT NULL,
                preparateur_id INTEGER NOT NULL,
                livreur_id INTEGER NOT NULL,
                vendeur_id INTEGER,
                CONSTRAINT commande_pk PRIMARY KEY (numero_commande)
);


ALTER SEQUENCE commande_numero_commande_seq OWNED BY Commande.numero_commande;

CREATE SEQUENCE facture_numero_facture_seq;

CREATE TABLE Facture (
                numero_facture INTEGER NOT NULL DEFAULT nextval('facture_numero_facture_seq'),
                montant_total INTEGER NOT NULL,
                type_paiement VARCHAR(50) NOT NULL,
                numero_commande INTEGER NOT NULL,
                CONSTRAINT facture_pk PRIMARY KEY (numero_facture)
);


ALTER SEQUENCE facture_numero_facture_seq OWNED BY Facture.numero_facture;

ALTER TABLE Preparateur ADD CONSTRAINT employ__preparateur_fk
FOREIGN KEY (employe_id)
REFERENCES Employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Livreur ADD CONSTRAINT employ__livreur_fk
FOREIGN KEY (employe_id)
REFERENCES Employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Vendeur ADD CONSTRAINT employ__vendeur_fk
FOREIGN KEY (employe_id)
REFERENCES Employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Commande ADD CONSTRAINT livreur_commande_fk
FOREIGN KEY (livreur_id)
REFERENCES Livreur (employe_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (client_id)
REFERENCES Client (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Preparateur ADD CONSTRAINT etablissement_preparateur_fk
FOREIGN KEY (etablissement_id)
REFERENCES Etablissement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Vendeur ADD CONSTRAINT etablissement_vendeur_fk
FOREIGN KEY (etablissement_id)
REFERENCES Etablissement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Stock ADD CONSTRAINT etablissement_stock_fk
FOREIGN KEY (etablissement_id)
REFERENCES Etablissement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Commande ADD CONSTRAINT vendeur_commande_fk
FOREIGN KEY (vendeur_id)
REFERENCES Vendeur (employe_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Commande ADD CONSTRAINT preparateur_commande_fk
FOREIGN KEY (preparateur_id)
REFERENCES Preparateur (employe_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Stock ADD CONSTRAINT ingredients_stock_fk
FOREIGN KEY (ingredient_id)
REFERENCES Ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Recette ADD CONSTRAINT ingredients_recette_fk
FOREIGN KEY (ingredient_id)
REFERENCES Ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Commande ADD CONSTRAINT pizza_commande_fk
FOREIGN KEY (nom_pizza)
REFERENCES Pizza (nom)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Recette ADD CONSTRAINT pizza_recette_fk
FOREIGN KEY (nom_pizza)
REFERENCES Pizza (nom)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Facture ADD CONSTRAINT commande_facture_fk
FOREIGN KEY (numero_commande)
REFERENCES Commande (numero_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
