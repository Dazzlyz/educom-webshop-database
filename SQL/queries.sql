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
4.6 : SELECT mhl_hitcount.hitcount, mhl_suppliers.name, mhl_cities.name, 
mhl_communes.name, mhl_districts.name FROM mhl_suppliers
JOIN mhl_hitcount ON mhl_suppliers.id=mhl_hitcount.supplier_ID
JOIN mhl_cities ON  mhl_suppliers.city_ID=mhl_cities.id
JOIN mhl_communes ON mhl_cities.commune_ID=mhl_communes.id
JOIN mhl_districts ON mhl_communes.district_ID=mhl_districts.id
WHERE mhl_hitcount.year = '2014' AND mhl_hitcount.month = 01 
AND (mhl_districts.name = 'zeeland' OR mhl_districts.name = 'noord-brabant' 
OR mhl_districts.name = 'limburg')
4.7: SELECT name, id, commune_id FROM mhl_cities
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY mhl_cities.name
4.8 : SELECT mhl_cities.name, mhl_cities.id, mhl_cities.commune_id, 
mhl_communes.name FROM mhl_cities
JOIN mhl_communes ON mhl_cities.commune_ID=mhl_communes.id
WHERE commune_ID != 0
GROUP BY mhl_cities.name
HAVING COUNT(*) > 1
ORDER BY mhl_cities.name
5.1 : SELECT name, commune_ID FROM mhl_cities WHERE commune_ID = 0
5.2 : SELECT mhl_cities.name, IFNULL(mhl_communes.name, 'INVALID') 
AS 'Commune name' 
FROM mhl_cities
JOIN mhl_communes ON mhl_communes.id = mhl_cities.commune_ID
5.3 : SELECT m.id, 
IFNULL(e.name, m.name) AS 'hoofdrubriek', 
IF(ISNULL(e.name), '', m.name) AS 'subrubriek'
FROM mhl_rubrieken e
RIGHT OUTER JOIN  mhl_rubrieken m ON m.parent = e.id
ORDER BY hoofdrubriek, subrubriek
5.4: SELECT mhl_suppliers.name, 
mhl_propertytypes.name,
IFNULL(mhl_yn_properties.content, 'NOT SET') 
FROM mhl_suppliers
CROSS JOIN mhl_propertytypes
LEFT JOIN mhl_yn_properties ON mhl_yn_properties.supplier_ID = mhl_suppliers.id
AND  mhl_propertytypes.id=mhl_yn_properties.propertytype_ID
JOIN mhl_cities ON mhl_suppliers.city_ID = mhl_cities.id 
WHERE mhl_cities.name = 'amsterdam' AND mhl_propertytypes.proptype="A"
6.1 : SELECT MAX(hitcount) AS 'max', MIN(hitcount) AS 'min', COUNT(hitcount) AS 'total', SUM(hitcount) AS 'total hits', AVG(hitcount) AS 'avg'
FROM mhl_hitcount
6.2 : SELECT DISTINCT year , MAX(hitcount) AS 'max', MIN(hitcount) AS 'min', COUNT(hitcount) AS 'total', SUM(hitcount) AS 'total hits', AVG(hitcount) AS 'avg' 
FROM mhl_hitcount
GROUP BY year
6.3: SELECT DISTINCT year , MAX(hitcount) AS 'max', MIN(hitcount) AS 'min', COUNT(hitcount) AS 'total', SUM(hitcount) AS 'total hits', AVG(hitcount) AS 'avg' 
FROM mhl_hitcount
GROUP BY year, month
6.4: SELECT mhl_suppliers.name, 
SUM(IFNULL(mhl_hitcount.hitcount, -1)) AS 'numhits', 
COUNT(mhl_hitcount.hitcount) AS 'NUMMONTHS', 
ROUND(AVG(mhl_hitcount.hitcount)) AS 'avg'
FROM mhl_hitcount
JOIN mhl_suppliers ON mhl_suppliers.id = mhl_hitcount.supplier_id
GROUP BY mhl_suppliers.ID
ORDER BY avg DESC
7.1 ?: SELECT DISTINCT mhl_suppliers.name AS 'leverancier', 
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
7.2: SELECT mhl_cities.name AS 'stad', 
COUNT(IF(mhl_suppliers.membertype = 1, 1, NULL)) Gold,
COUNT(IF(mhl_suppliers.membertype = 2, 1, NULL)) Silver,
COUNT(IF(mhl_suppliers.membertype = 3, 1, NULL)) 'Bronze',
COUNT(IF (mhl_suppliers.membertype NOT IN (1,2,3), 1, NULL)) 'Other'
FROM mhl_suppliers
JOIN mhl_cities ON mhl_suppliers.city_id = mhl_cities.id

GROUP BY mhl_cities.name
ORDER BY gold DESC, silver DESC, bronze DESC, other DESC;
7.3: SELECT mhl_hitcount.year, 
SUM(CASE
        WHEN month = '1' THEN hitcount
        WHEN month = '2' THEN hitcount
        WHEN month = '3' THEN hitcount
        ELSE 0
    END) AS 'Eerste kwartaal',
SUM(CASE
        WHEN month = '4' THEN hitcount
        WHEN month = '5' THEN hitcount
        WHEN month = '6' THEN hitcount
        ELSE 0
    END) AS 'Tweede kwartaal',
SUM(CASE
        WHEN month = '7' THEN hitcount
        WHEN month = '8' THEN hitcount
        WHEN month = '9' THEN hitcount
        ELSE 0
    END) AS 'Derde kwartaal',
    SUM(CASE
        WHEN month = '10' THEN hitcount
        WHEN month = '11' THEN hitcount
        WHEN month = '12' THEN hitcount
        ELSE 0
    END) AS 'Vierde kwartaal',
SUM(hitcount) AS 'total'
FROM mhl_hitcount 
GROUP BY year
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
9.1 ? : SELECT year, 
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
9.2 :SELECT a.gemeente, b.leverancier, b.total_hitcount, a.average_hitcount 
FROM 
(
    	SELECT 
        	g.id,
        	l.name AS leverancier, 
        	SUM(h.hitcount) AS total_hitcount
    	FROM
    		mhl_suppliers l
    	INNER JOIN mhl_cities p ON l.city_ID=p.id
    	INNER JOIN mhl_communes g ON p.commune_ID=g.id
    	INNER JOIN mhl_districts d ON g.district_ID=d.id
    	INNER JOIN mhl_hitcount h ON h.supplier_ID=l.id
    	WHERE d.country_ID= (
        	SELECT id
        	FROM mhl_countries
        	WHERE name='Nederland'
    	)
    	GROUP BY g.id, l.name
) AS b
INNER JOIN 
(
    SELECT 
    	g.id, 
    	SUM(h.hitcount)/COUNT(DISTINCT(h.supplier_ID)) AS average_hitcount, 
    	g.name AS gemeente 
    	FROM mhl_hitcount h
	    INNER JOIN mhl_suppliers l ON h.supplier_ID=l.id
    	INNER JOIN mhl_cities p ON l.city_ID=p.id
    	INNER JOIN mhl_communes g ON p.commune_ID=g.id
    	INNER JOIN mhl_districts d ON g.district_ID=d.id 
    	WHERE d.country_ID = (
	        SELECT id
    	    FROM mhl_countries
        	WHERE name='Nederland'
    	)
    	GROUP BY g.id
) AS a
ON a.id=b.id
GROUP BY a.id, b.leverancier
HAVING b.total_hitcount > a.average_hitcount
ORDER BY a.gemeente, (b.total_hitcount-a.average_hitcount) DESC
9.3: SELECT
    r.name AS rubriek,
    COUNT(srv.mhl_suppliers_ID) AS aantal_leveranciers
FROM
    mhl_rubrieken r
LEFT JOIN
    mhl_suppliers_mhl_rubriek_view srv ON r.parent = srv.mhl_rubriek_view_ID
GROUP BY
    rubriek
9.4: SELECT mhl_rubrieken.name AS 'name', 
IFNULL(SUM(mhl_hitcount.hitcount), 'Geen hits') AS 'total hitcount' 
FROM mhl_rubrieken
LEFT JOIN mhl_suppliers_mhl_rubriek_view ON mhl_suppliers_mhl_rubriek_view.mhl_rubriek_view_ID = mhl_rubrieken.parent
LEFT JOIN mhl_hitcount ON mhl_suppliers_mhl_rubriek_view.mhl_suppliers_ID = mhl_hitcount.supplier_ID
GROUP BY mhl_rubrieken.name;
10.1: SELECT mhl_suppliers.id, 
DATE_FORMAT(mhl_suppliers.joindate, GET_FORMAT(DATE,'EUR')) AS 'joindate'
FROM mhl_suppliers
WHERE DAYOFMONTH(LAST_DAY(joindate))-DAYOFMONTH(joindate) <= 7
10.2:SELECT mhl_suppliers.id, 
mhl_suppliers.joindate AS 'joindate',
TO_DAYS(CURDATE())-TO_DAYS(joindate) AS `dagen lid`
FROM mhl_suppliers
ORDER BY `dagen lid` ASC
10.3: SELECT DAYNAME(joindate) AS 'dag van de week',
COUNT(EXTRACT(DAY FROM joindate))AS 'Aantal aanmeldingen'
FROM mhl_suppliers
GROUP BY DAYNAME(joindate), DAYOFWEEK(joindate)
ORDER BY DAYOFWEEK(joindate) 
10.4: SELECT EXTRACT(YEAR FROM joindate) AS 'years',
EXTRACT(MONTH FROM joindate) AS 'months',
COUNT(mhl_suppliers.id)
FROM mhl_suppliers 
GROUP BY years, months
11.1: SELECT name,
CONCAT(UPPER(SUBSTRING(name, 1, 1)), SUBSTRING(name, 2, 100)) AS 'nice_name'
FROM mhl_cities  
ORDER BY `mhl_cities`.`name` ASC;
11.2: SELECT name,
REPLACE (
  REPLACE (
   REPLACE (
    REPLACE (
     REPLACE (
      REPLACE (
       REPLACE(name, '&eacute;', 'é'),
      '&ouml;', 'ö'),
     '&Uuml;', 'Ü'),
    '&euml;', 'ë'),
   '&egrave;', 'è'),
  '&iuml;','ï'),    
 '&acirc;', 'â')  
AS nicename
FROM mhl_suppliers
WHERE name REGEXP "&[^\s]*;"
LIMIT 25

