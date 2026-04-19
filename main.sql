CREATE TABLE HashTable (
    id INT PRIMARY KEY,
    key VARCHAR(255),
    value VARCHAR(255)
);

CREATE TABLE CustomHashTable (
    id INT PRIMARY KEY,
    key VARCHAR(255),
    value VARCHAR(255)
);

CREATE PROCEDURE InsertIntoHashTable(@key VARCHAR(255), @value VARCHAR(255))
AS
BEGIN
    INSERT INTO HashTable (key, value)
    VALUES (@key, @value);
END;

CREATE PROCEDURE InsertIntoCustomHashTable(@key VARCHAR(255), @value VARCHAR(255))
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM CustomHashTable WHERE key = @key)
    BEGIN
        INSERT INTO CustomHashTable (key, value)
        VALUES (@key, @value);
    END
    ELSE
    BEGIN
        UPDATE CustomHashTable
        SET value = @value
        WHERE key = @key;
    END
END;

CREATE FUNCTION GetFromHashTable(@key VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @value VARCHAR(255);
    SELECT @value = value
    FROM HashTable
    WHERE key = @key;
    RETURN @value;
END;

CREATE FUNCTION GetFromCustomHashTable(@key VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @value VARCHAR(255);
    SELECT @value = value
    FROM CustomHashTable
    WHERE key = @key;
    RETURN @value;
END;

CREATE PROCEDURE DeleteFromHashTable(@key VARCHAR(255))
AS
BEGIN
    DELETE FROM HashTable
    WHERE key = @key;
END;

CREATE PROCEDURE DeleteFromCustomHashTable(@key VARCHAR(255))
AS
BEGIN
    DELETE FROM CustomHashTable
    WHERE key = @key;
END;

CREATE TABLE HashTableIndices (
    id INT PRIMARY KEY,
    index_key VARCHAR(255),
    hash_table_id INT,
    FOREIGN KEY (hash_table_id) REFERENCES HashTable(id)
);

CREATE PROCEDURE InsertIntoHashTableIndices(@index_key VARCHAR(255), @hash_table_id INT)
AS
BEGIN
    INSERT INTO HashTableIndices (index_key, hash_table_id)
    VALUES (@index_key, @hash_table_id);
END;

CREATE FUNCTION GetHashTableIndex(@index_key VARCHAR(255))
RETURNS INT
AS
BEGIN
    DECLARE @hash_table_id INT;
    SELECT @hash_table_id = hash_table_id
    FROM HashTableIndices
    WHERE index_key = @index_key;
    RETURN @hash_table_id;
END;

INSERT INTO HashTable (id, key, value) VALUES (1, 'key1', 'value1');
INSERT INTO HashTable (id, key, value) VALUES (2, 'key2', 'value2');
INSERT INTO HashTable (id, key, value) VALUES (3, 'key3', 'value3');

INSERT INTO CustomHashTable (id, key, value) VALUES (1, 'key1', 'value1');
INSERT INTO CustomHashTable (id, key, value) VALUES (2, 'key2', 'value2');
INSERT INTO CustomHashTable (id, key, value) VALUES (3, 'key3', 'value3');

INSERT INTO HashTableIndices (id, index_key, hash_table_id) VALUES (1, 'index_key1', 1);
INSERT INTO HashTableIndices (id, index_key, hash_table_id) VALUES (2, 'index_key2', 2);
INSERT INTO HashTableIndices (id, index_key, hash_table_id) VALUES (3, 'index_key3', 3);

SELECT * FROM HashTable;
SELECT * FROM CustomHashTable;
SELECT * FROM HashTableIndices;