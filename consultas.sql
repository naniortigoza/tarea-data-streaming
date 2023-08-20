CREATE STREAM trades_stream (symbol STRING, price DOUBLE, volume DOUBLE, timestamp STRING) WITH (kafka_topic='finn_trades', value_format='json');

-- 1 - ¿Cuál fue el promedio ponderado de precio de una unidad por cada uno de los símbolos procesados? 
CREATE TABLE promedio_ponderado AS
SELECT symbol,
       AVG(price) AS avg_price
FROM trades_stream
GROUP BY symbol
EMIT CHANGES;
-- 2 - ¿Cuántas transacciones se procesaron por símbolo?
CREATE TABLE transacciones AS
SELECT symbol,
       COUNT(symbol) AS transaction
FROM trades_stream
GROUP BY symbol
EMIT CHANGES;

-- 3 - ¿Cuál fue el máximo precio registrado por símbolo?
CREATE TABLE precio_maximo AS
SELECT symbol,
       MAX(price) AS max_price
FROM trades_stream
GROUP BY symbol
EMIT CHANGES;

-- 4 - ¿Cuál fue el mínimo precio registrado por símbolo?
CREATE TABLE precio_minimo AS
SELECT symbol,
       MIN(price) AS min_price
FROM trades_stream
GROUP BY symbol
EMIT CHANGES;

select * from promedio_ponderado;
SELECT * FROM transacciones;
select * from precio_maximo;
select * from precio_minimo;