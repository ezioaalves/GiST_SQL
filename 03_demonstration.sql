-- FASE 1: A PROVA DA INEFICIÊNCIA (CONSULTA SEM ÍNDICE)

EXPLAIN ANALYZE
SELECT count(*)
FROM entregadores
WHERE localizacao && ST_MakeEnvelope(
    -46.82, -23.70, -- Longitude/Latitude do ponto sudoeste (São Paulo)
    -46.36, -23.35, -- Longitude/Latitude do ponto nordeste (São Paulo)
    4326
);


-- FASE 2: A SOLUÇÃO (CRIAÇÃO DO ÍNDICE GIST)

CREATE INDEX idx_entregadores_localizacao_gist ON entregadores USING GIST (localizacao);


-- FASE 3: A PROVA DA SUPERIORIDADE (CONSULTA COM ÍNDICE)

EXPLAIN ANALYZE
SELECT count(*)
FROM entregadores
WHERE localizacao && ST_MakeEnvelope(
    -46.82, -23.70, -- Longitude/Latitude do ponto sudoeste (São Paulo)
    -46.36, -23.35, -- Longitude/Latitude do ponto nordeste (São Paulo)
    4326
);
