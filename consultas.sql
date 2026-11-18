-- Analisis de muestras ambientales
-- Empresa: Planta lechera 



-- 1. Resultados del vertimiento final
SELECT *
FROM muestras_ambientales
WHERE punto_muestreo = 'Salida_PTAR';


-- 2. Parametros que no cumplen
SELECT parametro, resultado, unidad, limite_maximo, estado
FROM muestras_ambientales
WHERE punto_muestreo = 'Salida_PTAR'
  AND estado = 'No_cumple';


-- 3. Cantidad de parametros que cumplen y no cumplen
SELECT
    estado,
    COUNT(*) AS cantidad_parametros
FROM muestras_ambientales
WHERE punto_muestreo = 'Salida_PTAR'
GROUP BY estado;


-- 4. Porcentaje de cumplimiento
SELECT
    estado,
    COUNT(*) AS cantidad_parametros,
    ROUND(
        COUNT(*) * 100.0 / (
            SELECT COUNT(*)
            FROM muestras_ambientales
            WHERE punto_muestreo = 'Salida_PTAR'
        ),
        2
    ) AS porcentaje
FROM muestras_ambientales
WHERE punto_muestreo = 'Salida_PTAR'
GROUP BY estado;


-- 5. Promedio, minimo y maximo por parametro
SELECT
    parametro,
    ROUND(AVG(resultado), 2) AS promedio,
    MIN(resultado) AS minimo,
    MAX(resultado) AS maximo
FROM muestras_ambientales
WHERE punto_muestreo = 'Salida_PTAR'
GROUP BY parametro
ORDER BY parametro;


-- 6. Comparacion entre la entrada y la salida de la PTAR
SELECT
    punto_muestreo,
    parametro,
    ROUND(AVG(resultado), 2) AS promedio
FROM muestras_ambientales
WHERE punto_muestreo IN ('Entrada_PTAR', 'Salida_PTAR')
GROUP BY punto_muestreo, parametro
ORDER BY parametro, punto_muestreo;


-- 7. Porcentaje de reduccion del tratamiento
WITH promedios AS (
    SELECT
        parametro,
        AVG(CASE
            WHEN punto_muestreo = 'Entrada_PTAR' THEN resultado
        END) AS promedio_entrada,
        AVG(CASE
            WHEN punto_muestreo = 'Salida_PTAR' THEN resultado
        END) AS promedio_salida
    FROM muestras_ambientales
    WHERE parametro IN ('DBO5', 'DQO', 'SST', 'Grasas_aceites')
    GROUP BY parametro
)
SELECT
    parametro,
    ROUND(promedio_entrada, 2) AS promedio_entrada,
    ROUND(promedio_salida, 2) AS promedio_salida,
    ROUND(
        (promedio_entrada - promedio_salida) * 100.0
        / promedio_entrada,
        2
    ) AS porcentaje_reduccion
FROM promedios;


-- 8. Parametros con mayor cantidad de incumplimientos
SELECT
    parametro,
    COUNT(*) AS cantidad_incumplimientos
FROM muestras_ambientales
WHERE punto_muestreo = 'Salida_PTAR'
  AND estado = 'No_cumple'
GROUP BY parametro
ORDER BY cantidad_incumplimientos DESC;
