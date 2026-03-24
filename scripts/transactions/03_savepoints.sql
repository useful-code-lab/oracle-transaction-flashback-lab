-- Начало большой транзакции
UPDATE test_accounts SET balance = balance - 100 WHERE acc_id = 1; -- Списали за товар

-- Создаем "точку возврата"
SAVEPOINT sp_delivery_paid;

-- Пробуем списать за доставку (допустим, денег не хватило или ошибка в адресе)
UPDATE test_accounts SET balance = balance - 500 WHERE acc_id = 1; 

-- ОЙ! Ошибка. Мы не хотим отменять оплату ТОВАРА, только ДОСТАВКУ.
ROLLBACK TO SAVEPOINT sp_delivery_paid;

-- Теперь оплата товара (100) все еще в транзакции, а списание за доставку (500) стерто.
COMMIT; 

-- РЕЗУЛЬТАТ: Баланс уменьшился только на 100.
SELECT balance FROM test_accounts WHERE acc_id = 1;
