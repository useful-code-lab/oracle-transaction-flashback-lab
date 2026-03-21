-- 1. Создаем таблицу для тестирования "Lost Update" и "Non-repeatable Read"
CREATE TABLE test_accounts (
    acc_id      NUMBER PRIMARY KEY,
    owner_name  VARCHAR2(100),
    balance     NUMBER(15, 2),
    version_id  NUMBER DEFAULT 1 -- Для реализации Optimistic Locking позже
) 
INITRANS 10; -- Резервируем слоты транзакций для параллельного доступа

-- 2. Создаем таблицу для тестирования "Write Skew" (Аномалия Serializable)
CREATE TABLE room_reservations (
    res_id    NUMBER PRIMARY KEY,
    room_no   NUMBER,
    doctor_id NUMBER,
    shift     VARCHAR2(10),
    CONSTRAINT chk_shift CHECK (shift IN ('DAY', 'NIGHT'))
);

-- 3. Создаем таблицу с историей для Flashback Query
CREATE TABLE audit_log (
    log_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    op_type    VARCHAR2(10),
    old_val    NUMBER,
    new_val    NUMBER,
    changed_at TIMESTAMP DEFAULT SYSTIMESTAMP
);

-- 4. Наполняем тестовыми данными (03_seed_data.sql можно объединить сюда)
INSERT INTO test_accounts (acc_id, owner_name, balance) VALUES (1, 'Alice', 1000);
INSERT INTO test_accounts (acc_id, owner_name, balance) VALUES (2, 'Bob', 1000);

INSERT INTO room_reservations (res_id, room_no, doctor_id, shift) VALUES (1, 101, 501, 'NIGHT');

COMMIT;
