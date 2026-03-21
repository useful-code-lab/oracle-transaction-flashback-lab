-- Шаг 2: Изменяем данные «под носом» у первой сессии
UPDATE test_accounts 
SET balance = balance - 500 
WHERE acc_id = 1;

COMMIT; -- Фиксируем изменения
