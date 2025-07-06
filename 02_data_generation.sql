INSERT INTO entregadores (codigo_entregador, localizacao)
SELECT
    'ENT-' || substr(md5(random()::text), 1, 10),
    ST_SetSRID(
        ST_MakePoint(
            random() * (-34 - (-74)) + (-74),
            random() * (5 - (-34)) + (-34)
        ),
        4326
    )
FROM generate_series(1, 5000000);
