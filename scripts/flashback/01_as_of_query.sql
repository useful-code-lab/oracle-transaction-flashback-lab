-- 1. Сначала проверяем текущее время (чтобы знать точку отсчета)
SELECT SYSTIMESTAMP FROM DUAL;

-- 2. Допустим, сейчас баланс 1000. Мы его ломаем:
UPDATE test_accounts SET balance = 0 WHERE acc_id = 1;
COMMIT;

-- 3. Теперь balance = 0. Но нам нужно узнать, что там было 1 минуту назад.
-- Используем магию AS OF TIMESTAMP
SELECT balance 
FROM test_accounts 
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '1' MINUTE)
WHERE acc_id = 1;

-- РЕЗУЛЬТАТ: Вы увидите 1000, хотя в самой таблице уже 0!
