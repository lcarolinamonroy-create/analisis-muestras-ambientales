CREATE TABLE IF NOT EXISTS parametros_normativos (
    parametro TEXT PRIMARY KEY,
    limite_minimo REAL,
    limite_maximo REAL,
    unidad TEXT,
    referencia TEXT
);

INSERT OR IGNORE INTO parametros_normativos
(parametro, limite_minimo, limite_maximo, unidad, referencia)
VALUES
('pH', 6.0, 9.0, 'pH', 'Referencia educativa Resolución 0631 de 2015'),
('DBO5', 0.0, 400.0, 'mg/L', 'Referencia educativa Resolución 0631 de 2015'),
('DQO', 0.0, 600.0, 'mg/L', 'Referencia educativa Resolución 0631 de 2015'),
('SST', 0.0, 200.0, 'mg/L', 'Referencia educativa Resolución 0631 de 2015'),
('Grasas_aceites', 0.0, 20.0, 'mg/L', 'Referencia educativa Resolución 0631 de 2015');
