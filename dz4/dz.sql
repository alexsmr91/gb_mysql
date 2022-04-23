-- Задание 2
SELECT DISTINCT firstname FROM users ORDER BY firstname ASC

-- Задание 3
ALTER TABLE profiles ADD COLUMN is_active BOOL DEFAULT True;
UPDATE profiles SET is_active = 0 WHERE DATEDIFF(CURRENT_DATE(),birthday)/365 < 18

-- Задание 4
DELETE FROM messages WHERE DATEDIFF(CURRENT_DATE(),created_at)<0