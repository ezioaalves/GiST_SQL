CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE entregadores (
    id BIGSERIAL PRIMARY KEY,
    codigo_entregador VARCHAR(100) NOT NULL,
    localizacao GEOMETRY(Point, 4326) NOT NULL
