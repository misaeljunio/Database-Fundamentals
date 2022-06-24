-- a
SELECT DISTINCT p.sigla, SUM(v.numero_votos) as numero_votos
FROM (candidatos ca RIGHT OUTER JOIN partidos p ON p.numero = ca.numero_partido AND ca.cargo_id=1)
    LEFT OUTER JOIN votos v ON ca.numero_cand = v.numero_cand AND ca.localidade_id = v.localidade_id
GROUP BY p.sigla
ORDER BY numero_votos DESC;


-- b
-- View
CREATE VIEW descricao_cand AS
SELECT ca.nome, ca.numero_cand, c.descricao, p.sigla, l.nome AS localizacao, v.numero_votos
FROM candidatos ca, votos v, partidos p, cargos c, localidades l
WHERE ca.numero_cand = v.numero_cand
    AND ca.localidade_id = v.localidade_id
    AND ca.numero_partido = p.numero
    AND ca.cargo_id = c.id
    AND v.localidade_id = l.id;

-- Query
SELECT d1.nome
FROM descricao_cand d1
WHERE d1.numero_votos > (
    SELECT AVG(d.numero_votos)
    FROM descricao_cand d
    WHERE d.descricao = d1.descricao
        AND d.localizacao = d1.localizacao
);


-- c
SELECT c.descricao, (
    SELECT SUM(v.numero_votos) as id_localidade_1
    FROM votos v, candidatos ca
    WHERE c.id = ca.cargo_id
        AND ca.numero_cand = v.numero_cand
        AND v.localidade_id = 1
        AND ca.localidade_id = v.localidade_id
), (
    SELECT SUM(v.numero_votos) as id_localidade_2
    FROM votos v, candidatos ca
    WHERE c.id = ca.cargo_id
        AND ca.numero_cand = v.numero_cand
        AND v.localidade_id = 2
        AND ca.localidade_id = v.localidade_id
)
FROM cargos c;


-- d
SELECT ca.nome 
FROM candidatos ca 
WHERE EXISTS (
    SELECT *
    FROM votos v 
    WHERE v.localidade_id = ca.localidade_id AND v.localidade_id = 2
);


-- e
SELECT ca.nome, v.numero_votos
FROM candidatos ca, votos v
WHERE v.turno = 1
    AND ca.localidade_id = v.localidade_id
    AND v.numero_cand = ca.numero_cand
    AND v.numero_votos >= (
        SELECT MAX(v2.numero_votos)
        FROM votos v2
    );

SELECT ca.nome, v.numero_votos
FROM candidatos ca, votos v
WHERE v.turno = 1
    AND ca.localidade_id = v.localidade_id
    AND v.numero_cand = ca.numero_cand
    AND v.numero_votos >= ALL (
        SELECT v2.numero_votos
        FROM votos v2
    );


-- f
SELECT ca.nome, (
    SELECT ((AVG(numero_votos) / AVG(numero_votantes)) * 100) AS media
    FROM votos v, localidades l
    WHERE ca.numero_cand = v.numero_cand
        AND v.localidade_id = l.id
        AND v.localidade_id = ca.localidade_id
)
FROM candidatos ca
ORDER BY media DESC;


-- g
SELECT p.sigla
FROM partidos p
WHERE NOT EXISTS (
    SELECT *
    FROM candidatos ca
    WHERE p.numero = numero_partido
        AND cargo_id = 1
)
ORDER BY p.sigla;
