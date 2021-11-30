CREATE TABLE adresse(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ligne_adresse_1 VARCHAR(50) NOT NULL,
	ligne_adresse_2 VARCHAR(50),
	numero VARCHAR(10) NOT NULL,
	code_postal VARCHAR(10) NOT NULL,
	localite VARCHAR(50) NOT NULL,
	pays VARCHAR(50) NOT NULL
);

CREATE TABLE localisation(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_adresse INT NOT NULL,
	localite VARCHAR(50) NOT NULL,
	code_postal VARCHAR(10) NOT NULL,
	latitude DECIMAL(10,7) NOT NULL CHECK(latitude BETWEEN -180 AND 180),
	longitude DECIMAL(10,7) NOT NULL CHECK(longitude BETWEEN -180 AND 180),
	CONSTRAINT fk_id_adresse FOREIGN KEY(id_adresse)
	 REFERENCES adresse(id)
);

CREATE TABLE projet(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_localisation INT NOT NULL,
	reference VARCHAR(50) NOT NULL,
	titre VARCHAR(50) NOT NULL,
	description VARCHAR NOT NULL,
	infrastructure VARCHAR(50) NOT NULL,
	nb_arbre INT CHECK (nb_arbre > 0),
	nb_fruits INT CHECK(nb_fruits > 0),
	metre INT CHECK(metre > 0),
	hectare DECIMAL(7,2) CHECK(hectare > 0),
	tonnes_co2 DECIMAL(7,2) NOT NULL CHECK(tonnes_co2 > 0),
	heures_travail DECIMAL(7,2) NOT NULL CHECK(heures_travail > 0),
	cout_du_projet DECIMAL(7,2) NOT NULL,
	date_creation DATE NOT NULL DEFAULT CURRENT_DATE,
	CONSTRAINT fk_id_localisation FOREIGN KEY(id_localisation)
	 REFERENCES localisation(id)
);

CREATE TABLE photo(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_projet INT NOT NULL,
	est_publique BOOL NOT NULL DEFAULT FALSE,
	url_photo VARCHAR(255) NOT NULL,
	est_principale BOOL NOT NULL DEFAULT FALSE,
	CONSTRAINT fk_id_projet FOREIGN KEY(id_projet)
	 REFERENCES projet(id)
);

CREATE TYPE fonction AS ENUM ('citoyen', 'entreprise', 'beneficiaire');

CREATE TYPE user_level AS ENUM ('admin', 'user');

CREATE TABLE participant(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_adresse INT,
	fonction fonction NOT NULL,
	nom_entreprise VARCHAR(50),
	bce VARCHAR(10),
	nom VARCHAR(50) NOT NULL,
	prenom VARCHAR(50) NOT NULL,
	mail VARCHAR(50) NOT NULL,
	telephone VARCHAR(15) NOT NULL,
	salt VARCHAR(50) NOT NULL,
	mdp_client VARCHAR NOT NULL,
	user_level user_level NOT NULL DEFAULT 'user',
	CONSTRAINT fk_id_adresse FOREIGN KEY(id_adresse)
	 REFERENCES adresse(id)
);

CREATE TABLE projet_participant(
	id_projet INT NOT NULL,
	id_participant INT NOT NULL,
	contribution DECIMAL(7,2) NOT NULL,
	date_contribution DATE NOT NULL DEFAULT CURRENT_DATE,
	est_favori BOOL DEFAULT FALSE,
	PRIMARY KEY(id_projet, id_participant),
	CONSTRAINT fk_id_projet FOREIGN KEY(id_projet)
	 REFERENCES projet(id),
	CONSTRAINT fk_id_participant FOREIGN KEY(id_participant)
	 REFERENCES participant(id)
);

CREATE TABLE tag(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nom VARCHAR(30) NOT NULL
);

CREATE TABLE projet_tag(
	id_projet INT NOT NULL,
	id_tag INT NOT NULL,
	PRIMARY KEY(id_projet, id_tag),
	CONSTRAINT fk_id_projet FOREIGN KEY(id_projet)
	 REFERENCES projet(id),
	CONSTRAINT fk_id_tag FOREIGN KEY(id_tag)
	 REFERENCES tag(id)
);