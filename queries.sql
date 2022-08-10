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

2.10 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE name LIKE '%&xxxx;%'; ?!?!?!? Standard/ reguliere expressies. 

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
JOIN mhl_suppliers_mhl_rubriek_view 
JOIN 
WHERE mhl_cities.name = 'amsterdam' AND mhl_rubrieken.id = 235 OR mhl_rubrieken.parent = 235
ORDER BY mhl_rubrieken.name, mhl_suppliers.name

rubbriek 235 of parent 235
	

