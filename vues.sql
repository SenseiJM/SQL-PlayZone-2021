CREATE VIEW projet_resume AS
	SELECT p.id AS id_projet,
		p.titre,
		CONCAT(SUBSTRING(p.description, 0, 197), '...') AS description,
		l.localite,
		ph.url_photo,
		pp.tot,
		p.cout_du_projet
	FROM projet p
	-- LEFT JOIN photo ph
	--  ON ph.id_projet = p.id AND ph.est_publique = true
	LEFT JOIN
		(
			SELECT ph.url_photo url_photo, ph.id_projet, ph.est_publique, ph.est_principale
			FROM photo ph
			WHERE ph.est_principale = TRUE
		)
		ph
	 ON p.id = ph.id_projet AND ph.est_publique = true
	LEFT JOIN localisation l
	 ON p.id_localisation = l.id
	LEFT JOIN
		(
			SELECT pp.id_projet, SUM(pp.contribution) tot
			FROM projet_participant pp
			GROUP BY pp.id_projet
		)
		pp
		ON p.id = pp.id_projet;

CREATE VIEW projet_details AS
	SELECT p.id AS id_projet,
		ph.url_photo,
		p.titre,
		p.description,
		l.localite,
		p.tonnes_co2,
		pp.tot,
		p.cout_du_projet
	FROM projet p
	LEFT OUTER JOIN photo ph
	 ON ph.id_projet = p.id AND ph.est_publique = true
	LEFT JOIN localisation l
	 ON p.id_localisation = l.id
	LEFT JOIN
		(
			SELECT pp.id_projet, SUM(pp.contribution) tot
			FROM projet_participant pp
			GROUP BY pp.id_projet
		)
		pp
		ON p.id = pp.id_projet;

CREATE VIEW localisation_zip AS (
	SELECT id, localite, code_postal
	FROM localisation
	ORDER BY code_postal
);

CREATE VIEW Marqueurs AS (
	SELECT latitude, longitude, infrastructure, p.id
	FROM projet p
	JOIN localisation ON p.id_localisation = localisation.id
);