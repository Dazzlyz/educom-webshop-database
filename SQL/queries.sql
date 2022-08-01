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
4.1 : SELECT name, straat, huisnr, postcode FROM mhl_suppliers WHERE city_ID IN (SELECT id FROM mhl_cities WHERE name='amsterdam');
INNER JOIN FIX?




SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;

SELECT DISTINCT mhl_cities.id, mhl_suppliers.city_ID, mhl_cities.name
FROM mhl_cities
INNER JOIN mhl_cities ON city_ID FROM mhl_cities WHERE name='amsterdam';

SELECT * FROM mhl_suppliers WHERE city_ID IN (SELECT id FROM mhl_cities WHERE name='amsterdam');
SELECT id FROM mhl_cities WHERE name='amsterdam';


INNER JOIN mhl_cities ON mhl_suppliers.city_ID =  mhl_cities.id;
