-- Analisis de muestras ambientales
-- Empresa: Planta lechera 

-- 1. Mostrar todas las muestras de salida de la PTAR
SELECT *
FROM muestras_ambientales
WHERE punto_muestreo = 'Salida_PTAR';

-- 2. Mostrar los resultados que no cumplen
SELECT *
FROM muestras_ambientales
WHERE estado = 'No_cumple';

-- 3. Contar muestras por parametro
SELECT parametro, COUNT(*) AS cantidad_resultados
FROM muestras_ambientales
GROUP BY parametro;
