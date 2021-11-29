CREATE VIEW projet_resume AS
	SELECT p.id AS id_projet,
		ph.url_photo,
		p.titre,
		CONCAT(SUBSTRING(p.description, 0, 197), '...'),
		l.localite,
		pp.tot,
		p.cout_du_projet
	FROM projet p
	LEFT JOIN photo ph
	 ON ph.id_projet = p.id AND ph.est_publique = true
	LEFT JOIN localisation l
	 ON p.id_localisation = l.id
	JOIN
		(
			SELECT pp.id_projet, SUM(pp.contribution) tot
			FROM projet_participant pp
			GROUP BY pp.id_projet
		)
		pp
		ON p.id = pp.id_projet
	LIMIT 1

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
	LEFT JOIN photo ph
	 ON ph.id_projet = p.id AND ph.est_publique = true
	LEFT JOIN localisation l
	 ON p.id_localisation = l.id
	JOIN
		(
			SELECT pp.id_projet, SUM(pp.contribution) tot
			FROM projet_participant pp
			GROUP BY pp.id_projet
		)
		pp
		ON p.id = pp.id_projet