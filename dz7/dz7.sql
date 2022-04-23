SELECT name
FROM users
WHERE id IN (SELECT user_id 
from orders)


select name,
	(SELECT name FROM catalogs WHERE id = products.catalog_id) as Cat
FROM products


use fligths;

SELECT (SELECT name FROM cities WHERE label = flights.from) as 'Откуда',
		(SELECT name FROM cities WHERE label = flights.to) as 'Куда'
FROM flights
