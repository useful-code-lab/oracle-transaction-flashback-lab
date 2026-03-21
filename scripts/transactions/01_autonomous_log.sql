-- Имитируем логгер, который ДОЛЖЕН записать попытку, даже если оплата не прошла
CREATE OR REPLACE PROCEDURE log_attempt(p_msg VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION; -- МАГИЯ: отдельная сессия внутри текущей
BEGIN
    INSERT INTO audit_log (op_type, new_val) VALUES ('ATTEMPT', 0);
    COMMIT; -- Фиксирует ТОЛЬКО инсерт в лог, не трогая основную транзакцию
END;
/

-- ТЕСТ:
UPDATE test_accounts SET balance = balance - 100 WHERE acc_id = 1;
EXEC log_attempt('User tried to pay');
ROLLBACK; -- Отменяем списание денег

-- РЕЗУЛЬТАТ: В таблице audit_log запись ОСТАЛАСЬ, а деньги НЕ списались.
SELECT * FROM audit_log;
