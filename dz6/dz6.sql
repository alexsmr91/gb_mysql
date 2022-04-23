SELECT
	(SELECT firstname FROM users WHERE messages.from_user_id = users.id) as 'Name',
	(SELECT lastname FROM users WHERE messages.from_user_id = users.id) as 'Lastname'
FROM messages
WHERE to_user_id = 53
GROUP BY from_user_id
ORDER BY COUNT(*) DESC
LIMIT 1;


SELECT COUNT(*) AS 'Likes < 10 Y' 
FROM likes
WHERE user_id IN 
(SELECT user_id
FROM profiles
WHERE TIMESTAMPDIFF(YEAR,birthday, NOW())<10)
;


SELECT Gen
FROM (SELECT (SELECT IF(gender = 'f','Женщины','Мужчины') FROM profiles WHERE profiles.user_id = likes.user_id) as Gen
	FROM likes) AS GG
GROUP BY Gen
ORDER BY COUNT(*) DESC
LIMIT 1
;
