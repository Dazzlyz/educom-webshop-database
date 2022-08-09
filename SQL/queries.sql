1.1 : SELECT * FROM mhl_cities;
1.2 : SELECT DISTINCT * FROM mhl_cities;
1.3 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers;
2.1 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE city_ID = 104;
2.2 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE membertype = 1 OR membertype = 2 OR membertype = 3 OR membertype = 8;
2.3 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE city_ID = 104 AND NOT p_city_ID = 104;
2.4 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE city_ID = 104 OR p_city_ID = 172;
2.5 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE huisnr BETWEEN 10 AND 20;
2.6 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE huisnr BETWEEN 10 AND 20 OR huisnr > 100;
2.7 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE name LIKE '''t%';
2.8 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE name LIKE '%handel';
2.9 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE name LIKE '%groothandel%';


2.10 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE name REGEXP "&[^\s]*;"


3.1 : SELECT * FROM mhl_cities ORDER BY name;
3.2 : SELECT * FROM mhl_suppliers ORDER BY membertype, city_ID, postcode;
3.3 : SELECT * FROM mhl_hitcount ORDER BY year, month ASC, hitcount DESC;
4.1 : SELECT mhl_suppliers.name, straat, postcode, huisnr FROM mhl_suppliers 
JOIN mhl_cities ON (mhl_cities.id=mhl_suppliers.city_ID) WHERE mhl_cities.name = 'amsterdam'
4.2 : SELECT mhl_suppliers.name, straat, postcode, huisnr FROM mhl_suppliers 
JOIN mhl_cities ON (mhl_suppliers.city_ID=mhl_cities.id) 
JOIN mhl_communes ON (mhl_communes.id = mhl_cities.commune_ID)
WHERE mhl_communes.name = 'steenwijkerland'
4.3 : SELECT mhl_suppliers.name, straat, postcode, huisnr FROM mhl_suppliers
JOIN mhl_cities ON (mhl_cities.id=mhl_suppliers.city_ID) 
JOIN mhl_suppliers_mhl_rubriek_view ON mhl_suppliers.id=mhl_suppliers_mhl_rubriek_view.mhl_suppliers_ID
JOIN mhl_rubrieken ON mhl_suppliers_mhl_rubriek_view.mhl_rubriek_view_ID=mhl_rubrieken.id
WHERE mhl_cities.name = 'amsterdam' AND (mhl_rubrieken.name = 'drank' OR mhl_rubrieken.parent = 235)
ORDER BY mhl_rubrieken.name, mhl_suppliers.name
4.4 : SELECT mhl_suppliers.name, straat, postcode, huisnr FROM mhl_suppliers
JOIN mhl_yn_properties ON mhl_suppliers.id=mhl_yn_properties.supplier_ID
JOIN mhl_propertytypes ON mhl_yn_properties.propertytype_ID=mhl_propertytypes.id
WHERE mhl_propertytypes.name = 'specialistische leverancier' OR mhl_propertytypes.name = 'ook voor particulieren'
4.5 : SELECT mhl_suppliers.name, straat, postcode, huisnr, pc_lat_long.lat, pc_lat_long.lng FROM mhl_suppliers 
JOIN pc_lat_long ON mhl_suppliers.postcode=pc_lat_long.pc6 
ORDER BY pc_lat_long.lat DESC LIMIT 5
4.6 : SELECT mhl_hitcount.hitcount, mhl_suppliers.name, mhl_cities.name, mhl_communes.name, mhl_districts.name FROM mhl_suppliers
JOIN mhl_hitcount ON mhl_suppliers.id=mhl_hitcount.supplier_ID
JOIN mhl_cities ON  mhl_suppliers.city_ID=mhl_cities.id
JOIN mhl_communes ON mhl_cities.commune_ID=mhl_communes.id
JOIN mhl_districts ON mhl_communes.district_ID=mhl_districts.id
WHERE mhl_hitcount.year = '2014' AND mhl_hitcount.month = 01 
AND (mhl_districts.name = 'zeeland' OR mhl_districts.name = 'noord-brabant' OR mhl_districts.name = 'limburg')
4.7: SELECT name, id, commune_id FROM mhl_cities
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY mhl_cities.name
4.8 : SELECT mhl_cities.name, mhl_cities.id, mhl_cities.commune_id, mhl_communes.name FROM mhl_cities
JOIN mhl_communes ON mhl_cities.commune_ID=mhl_communes.id
WHERE commune_ID != 0
GROUP BY mhl_cities.name
HAVING COUNT(*) > 1
ORDER BY mhl_cities.name
5.1 : SELECT name, commune_ID FROM mhl_cities WHERE commune_ID = 0
5.2 : SELECT mhl_cities.name, IFNULL(mhl_communes.name, 'INVALID') AS 'Commune name' 
FROM mhl_cities
LEFT JOIN mhl_communes ON mhl_communes.id = mhl_cities.commune_ID
5.3 : 

SELECT e.id, e.name AS 'hoofdrubriek', IF(IFNULL(m.name, '')'') AS 'subbriek'
FROM mhl_rubrieken e
INNER JOIN mhl_rubrieken m ON e.id = m.parent

// losse rubrieken met NULL nog? 


5.4: SELECT DISTINCT mhl_suppliers.name, IFNULL(mhl_propertytypes.name, 'NOT SET') 
FROM mhl_propertytypes 
JOIN mhl_yn_properties ON mhl_yn_properties.propertytype_ID = mhl_propertytypes.id 
JOIN mhl_suppliers ON mhl_yn_properties.supplier_ID = mhl_suppliers.id 
JOIN mhl_cities ON mhl_suppliers.city_ID = mhl_cities.id 
WHERE mhl_cities.name = 'amsterdam';

// lege velden als 'NOT SET' weergeven.




6.1 : SELECT MAX(hitcount) AS 'max', MIN(hitcount) AS 'min', COUNT(hitcount) AS 'total', SUM(hitcount) AS 'total hits', AVG(hitcount) AS 'avg'
FROM mhl_hitcount
6.2 : SELECT DISTINCT year , MAX(hitcount) AS 'max', MIN(hitcount) AS 'min', COUNT(hitcount) AS 'total', SUM(hitcount) AS 'total hits', AVG(hitcount) AS 'avg' 
FROM mhl_hitcount
GROUP BY year
6.3: SELECT DISTINCT year , MAX(hitcount) AS 'max', MIN(hitcount) AS 'min', COUNT(hitcount) AS 'total', SUM(hitcount) AS 'total hits', AVG(hitcount) AS 'avg' 
FROM mhl_hitcount
GROUP BY year, month


6.4: 

SELECT mhl_suppliers.name, SUM(mhl_hitcount.hitcount) AS 'NUMHITS', COUNT(mhl_hitcount.month) AS 'NUMMONTHS', COUNT(mhl_hitcount.hitcount)
FROM mhl_hitcount
JOIN mhl_suppliers ON mhl_suppliers.id = mhl_hitcount.supplier_id
WHERE hitcount > 100
GROUP BY mhl_suppliers.name
ORDER BY NUMHITS DESC








7.1 : SELECT mhl_suppliers.name AS 'leverancier', 
mhl_contacts.name AS 'contactpersoon', 
CASE 
	WHEN mhl_suppliers.p_address, mhl_suppliers.p_postcode, mhl_suppliers.p_city_ID 
	THEN CONCAT(mhl_suppliers.p_address, mhl_suppliers.huisnr) AS 'straat', 
	mhl_suppliers.p_postcode, 
	mhl_suppliers.p_city_ID
	ELSE 
	CONCAT(mhl_suppliers.straat, mhl_suppliers.huisnr) AS 'straat', 
	mhl_suppliers.postcode , 
	mhl_cities.name AS 'stad'
	
END
mhl_communes.name AS 'gemeente' 
FROM mhl_suppliers
JOIN mhl_cities ON mhl_suppliers.city_ID=mhl_cities.id
JOIN mhl_contacts ON mhl_contacts.supplier_ID=mhl_suppliers.id
JOIN mhl_communes ON mhl_communes.id=mhl_cities.commune_ID
JOIN mhl_communes ON mhl_communes.id=mhl_suppliers.p_city_ID


mhl_contacts.department=3 = directie


9.1 : 

SELECT year, month, COUNT(DISTINCT supplier_ID), SUM(hitcount)
FROM mhl_hitcount
ORDER BY year DESC, month ASC

9.2 : SELECT {nederlandse}gemeentenaam, mhl_suplliers.name, {totaal van leverancier}SUM(hitcount), {verschil van hitcount ten opzichte van gemiddelde in gemeente/ 
enkel positieve resultaten van boven het gemiddelde}
