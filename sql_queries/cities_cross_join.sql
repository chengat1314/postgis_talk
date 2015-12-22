SELECT 
	c1.name || ', ' || c1.adm0name AS city1, 
	c2.name || ', ' || c2.adm0name AS city2, 
	ST_Distance(c1.geom, c2.geom, true) * 0.000621371 AS distance_miles
	
FROM geo.cities_ne c1
CROSS JOIN geo.cities_ne c2
WHERE c1.scalerank < 3 AND c2.scalerank < 3 --Limit the run time of the query by focusing on bigger cities
ORDER BY ST_Distance(c1.geom, c2.geom, true) DESC
LIMIT 10