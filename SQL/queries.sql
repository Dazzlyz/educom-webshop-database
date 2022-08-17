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

SELECT e.id, e.name AS 'hoofdrubriek', if(m.name='', e.name, m.name)  AS 'subbriek'
FROM mhl_rubrieken e
INNER JOIN mhl_rubrieken m ON e.id = m.parent;

// losse rubrieken met NULL nog? 


5.4: SELECT DISTINCT mhl_suppliers.name, mhl_propertytypes.name, IFNULL(mhl_yn_properties.content, "NOT SET") as 'value'
FROM mhl_propertytypes 
JOIN mhl_yn_properties ON mhl_yn_properties.propertytype_ID = mhl_propertytypes.id 
JOIN mhl_suppliers ON mhl_yn_properties.supplier_ID = mhl_suppliers.id 
JOIN mhl_cities ON mhl_suppliers.city_ID = mhl_cities.id 
WHERE mhl_cities.name = 'amsterdam' AND mhl_propertytypes.proptype="A"

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

SELECT mhl_suppliers.name, SUM(mhl_hitcount.hitcount) AS 'numhits', COUNT(mhl_hitcount.month) AS 'NUMMONTHS', ROUND(AVG(mhl_hitcount.hitcount)) AS 'avg'
FROM mhl_hitcount
JOIN mhl_suppliers ON mhl_suppliers.id = mhl_hitcount.supplier_id

GROUP BY mhl_suppliers.name
ORDER BY avg DESC

Conditie voor hitcount > 100 schrijven


7.1 : SELECT DISTINCT mhl_suppliers.name AS 'leverancier', 
CASE
	WHEN mhl_departments.name = 'directie' THEN mhl_contacts.name
    ELSE 't.a.v. de directie'
END AS 'contactpersoon',
CASE 
	WHEN mhl_suppliers.p_address != '' THEN mhl_suppliers.p_address
    ELSE mhl_suppliers.straat
END AS 'straat',
CASE
	WHEN mhl_suppliers.p_address != '' THEN mhl_suppliers.p_postcode
    ELSE mhl_suppliers.postcode
END AS 'postcode',
mhl_cities.name AS 'stad',
mhl_districts.name AS 'provincie' 
FROM mhl_suppliers

JOIN mhl_cities ON 
	CASE WHEN mhl_suppliers.p_address != '' THEN mhl_suppliers.p_city_ID=mhl_cities.id
    ELSE mhl_suppliers.city_ID=mhl_cities.id
END

JOIN mhl_contacts ON mhl_contacts.supplier_ID=mhl_suppliers.id
JOIN mhl_communes ON mhl_communes.id=mhl_cities.commune_ID
JOIN mhl_departments ON mhl_contacts.department = mhl_departments.id
JOIN mhl_districts ON mhl_districts.id = mhl_communes.district_ID  
ORDER BY `leverancier` ASC
7.2: 

SELECT mhl_cities.name AS 'stad', 
COUNT(mhl_suppliers.membertype) AS 'gold', 
COUNT(mhl_suppliers.membertype) AS 'silver', 
COUNT(mhl_suppliers.membertype) AS 'bronze', 
COUNT(mhl_suppliers.membertype) AS 'other' 
FROM mhl_suppliers
JOIN mhl_cities ON mhl_suppliers.city_id = mhl_cities.id

GROUP BY mhl_suppliers.membertype, mhl_cities.name
ORDER BY gold DESC, silver DESC, bronze DESC, other DESC;

// 1 membertype en juiste type per column

7.3: 
SELECT mhl_hitcount.year, 
hitcount AS 'eerste kwartaal',
hitcount AS 'tweede kwartaal',
hitcount AS 'derde kwartaal',
hitcount AS 'vierde kwartaal',
SUM(hitcount) AS 'total'
FROM mhl_hitcount 
GROUP BY year

// grouperen op kwartalen 

8.1: CREATE VIEW directie AS
SELECT mhl_contacts.supplier_ID, 
mhl_contacts.name AS 'contact',
mhl_contacts.contacttype AS 'functie',
mhl_departments.name AS 'department'
FROM mhl_contacts 
JOIN mhl_departments ON mhl_departments.id = mhl_contacts.department
WHERE mhl_contacts.department = 3 OR mhl_contacts.contacttype LIKE '%directeur%'
8.2: CREATE VIEW verzendlijst AS 
SELECT mhl_suppliers.id,
CASE 
	WHEN mhl_suppliers.p_address != '' THEN mhl_suppliers.p_address
    ELSE CONCAT(mhl_suppliers.straat, mhl_suppliers.huisnr)
END AS 'adres',
CASE
	WHEN mhl_suppliers.p_address != '' THEN mhl_suppliers.p_postcode
    ELSE mhl_suppliers.postcode
END AS 'postcode',
mhl_cities.name AS 'stad'
FROM mhl_suppliers
JOIN mhl_cities ON 
	CASE 
    WHEN mhl_suppliers.p_address != '' THEN mhl_suppliers.p_city_ID=mhl_cities.id
    ELSE mhl_suppliers.city_ID=mhl_cities.id
END 
8.3: SELECT mhl_suppliers.name,
IF(contact='', 't.a.v. directie', contact) AS contact,
adres, 
verzendlijst.postcode, 
stad
FROM verzendlijst
JOIN directie ON verzendlijst.id = directie.supplier_ID
JOIN mhl_suppliers ON verzendlijst.id = mhl_suppliers.id

9.1 : SELECT year, 
CASE 
	WHEN month = 1 THEN 'januari'
    WHEN month = 2 THEN 'febrauri'
    WHEN month = 3 THEN 'maart'
    WHEN month = 4 THEN 'april'
    WHEN month = 5 THEN 'mei'
    WHEN month = 6 THEN 'juni'
    WHEN month = 7 THEN 'juli'
    WHEN month = 8 THEN 'augustus'
    WHEN month = 9 THEN 'september'
    WHEN month = 10 THEN 'oktober'
    WHEN month = 11 THEN 'november'
    WHEN month = 12 THEN 'december'
 END AS 'maand', 
COUNT(DISTINCT supplier_ID) AS 'aantal leveranciers', 
SUM(hitcount) AS 'total aantal hits'
FROM mhl_hitcount
GROUP BY year, month
ORDER BY year DESC, month ASC
9.2 : 

SELECT mhl_communes.name,
mhl_suppliers.name,
SUM(mhl_hitcount.hitcount) AS 'total',
AVG(mhl_hitcount.hitcount)
FROM mhl_suppliers
JOIN mhl_cities ON mhl_suppliers.city_ID = mhl_cities.id
JOIN mhl_communes ON mhl_cities.commune_ID = mhl_communes.id
JOIN mhl_hitcount ON mhl_suppliers.id = mhl_hitcount.supplier_ID
JOIN mhl_districts ON mhl_communes.district_ID = mhl_districts.id
JOIN mhl_countries ON mhl_districts.country_ID = mhl_countries.id

WHERE mhl_countries.name = 'Nederland'
GROUP BY mhl_suppliers.name
ORDER BY mhl_communes.name, total DESC, mhl_suppliers.name

// opdracht nog een keer goed wat er precies bedoeld word voor 4de column//
// column maken die gemiddelde berekend van hitcount in de gemeente, verschil checkt met de hitcount van de supplier en dan positieve vergelijkingen terugeeft. 


9.3: 

SELECT mhl_rubrieken.name,
COUNT(mhl_rubrieken.name)
FROM mhl_rubrieken e
JOIN mhl_suppliers_mhl_rubriek_view ON mhl_suppliers_mhl_rubriek_view.mhl_rubriek_view_ID = mhl_rubrieken.id
JOIN mhl_suppliers ON mhl_suppliers.id = mhl_suppliers_mhl_rubriek_view.mhl_suppliers_ID
INNER JOIN mhl_rubrieken m ON e.id = m.parent
GROUP BY mhl_rubrieken.name

// zorgen dat rubriek en subrubiek samen in column komen indien van toepassing volgens voorbeeld. 

9.4: 

SELECT mhl_rubrieken.name AS 'name', 
IFNULL(SUM(mhl_hitcount.hitcount), 'Geen hits')
FROM mhl_rubrieken
JOIN mhl_suppliers_mhl_rubriek_view ON mhl_suppliers_mhl_rubriek_view.mhl_rubriek_view_ID = mhl_rubrieken.id
JOIN mhl_hitcount ON mhl_suppliers_mhl_rubriek_view.mhl_suppliers_ID = mhl_hitcount.hitcount
GROUP BY mhl_rubrieken.name;

// zorgen dat deel van 9.3 werkt en dan kijken naar uitwerking 

10.1: 

SELECT mhl_suppliers.name, 
mhl_suppliers.huisnr AS 'JOINDATE'
FROM mhl_suppliers
WHERE JOINDATE IS IN <7 DAGEN FROM END OF month

// joindate? + query fixen om leverancier met joindate 7 dagen voor eind van de maand weer te geven. 







11.1: SELECT name,
CONCAT(UPPER(SUBSTRING(name, 1, 1)), SUBSTRING(name, 2, 100)) AS 'nice_name'
FROM mhl_cities  
ORDER BY `mhl_cities`.`name` ASC;
11.2: 

SELECT name,
REPLACE(name)
FROM mhl_suppliers
WHERE name REGEXP "&[^\s]*;"
LIMIT 25

// manier vinden om juiste decode te gebruiken? 




