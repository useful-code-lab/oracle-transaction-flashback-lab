-- Явно фиксируем момент начала транзакции (Advanced способ)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 

-- Шаг 1: Читаем (транзакция уже считается открытой в системе)
SELECT balance FROM test_accounts WHERE acc_id = 1;

-- [ПАУЗА: тут делаем Update + Commit во второй вкладке]

-- Шаг 3: Снова читаем
SELECT balance FROM test_accounts WHERE acc_id = 1;
-- Вы увидите, что данные изменились.

COMMIT; -- Закрываем транзакцию
