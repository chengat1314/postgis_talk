WITH fam_city AS(
	SELECT name, geom FROM geo.cities_ne c WHERE c.name = 'New Orleans' 
	OR c.name = 'Blacksburg' OR c.name = 'Seattle'
)

SELECT c.name || ', ' || c.adm1name AS loc, ST_DISTANCE(c.geom, 
	(SELECT ST_CENTROID(
		(SELECT ST_UNION(f.geom) FROM fam_city f))
	), true) * 0.000621371 AS distance_miles
	
FROM geo.cities_ne c
ORDER BY ST_DISTANCE(c.geom, (SELECT ST_CENTROID(
		(SELECT ST_UNION(f.geom) FROM fam_city f)	
	)), true)