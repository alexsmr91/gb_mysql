SELECT u2.firstname, u2.lastname
FROM messages m 
	JOIN users u ON u.id = m.to_user_id
		JOIN users u2 on u2.id = m.from_user_id 
WHERE u.id = 53
GROUP BY m.from_user_id
ORDER BY COUNT(*) DESC
LIMIT 1
;


SELECT COUNT(*) AS 'Likes < 10 Y' 
FROM likes l 
	JOIN profiles p ON l.user_id = p.user_id
WHERE TIMESTAMPDIFF(YEAR,p.birthday, NOW())<10
;


SELECT IF(p.gender = 'f','Женщины','Мужчины') as Gen
FROM likes l 
	JOIN profiles p ON l.user_id = p.user_id 
GROUP BY Gen
ORDER BY COUNT(*) DESC
LIMIT 1
;