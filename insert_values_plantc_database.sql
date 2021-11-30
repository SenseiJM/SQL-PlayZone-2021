INSERT INTO adresse(ligne_adresse_1, numero, code_postal, localite, pays) VALUES
	('rue du jambon', '54', '4200', 'bruges', 'belgique'),
	('rue du test', '106', '4825', 'test', 'belgique')
;

INSERT INTO localisation(id_adresse, localite, code_postal, latitude, longitude) VALUES
	(1, 'namur', '5000', 10.1011012, 10.1011012),
	(2, 'test', '4825', 10.5245646, 10.4879653)
;

INSERT INTO projet(id_localisation, reference, titre, description, infrastructure, nb_arbre, tonnes_co2, heures_travail, cout_du_projet) VALUES
	(1, 'ROLLY1', 'Reboisement test', 'lorem ipsum', 'foret', 65, 45000, 2, 47000),
	(2, 'TEST1', 'Miscanthus everywhere', 'lorem ipsum', 'miscanthus', 242, 12500, 0.8, 1425)
;

INSERT INTO photo(id_projet, url_photo) VALUES
	(1, 'test1.png'),
	(1, 'test2.png'),
	(1, 'test3.png'),
	(2, 'misc1.png'),
	(2, 'misc2.png'),
	(2, 'misc3.png')
;

INSERT INTO participant(fonction, nom, prenom, mail, telephone, salt, mdp_client) VALUES
	('citoyen', 'ly', 'khun', 'khun.ly@test.com', '0495123456', '123456789', 'test1234='),
	('citoyen', 'test', 'test', 'test.test@test.com', '0495143426', '123456789', 'test1234=')
;

INSERT INTO projet_participant(id_projet, id_participant, contribution) VALUES
	(1, 1, 50),
	(1, 2, 125),
	(2, 1, 50)
;

INSERT INTO tag(nom) VALUES
	('foret'),
	('miscanthus'),
	('maillage ecologique'),
	('energie renouvelable')
;

INSERT INTO projet_tag(id_projet, id_tag) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 2),
	(2, 3)
;