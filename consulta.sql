-- Encontre os fornecedores que só fornecem
-- peças para projetos em Quixadá
SELECT Fnome
FROM FornPecaProj f1, Fornecedor f2, projetos p
WHERE p.cidade = 'Quixadá' 
    AND p.jid = f1.jid
    AND f1.fid = f2.fid;

-- Encontre as peças que não são fornecidas nem pelo
-- fornecedor ‘João Silva’ nem pela ‘Maria Silva’
SELECT Pnome
FROM fornecedor f, Peca p, FornPecaProj fp
WHERE p.pid = fp.pid 
    AND f.fid = fp.fid 
    AND fnome <> 'João Silva'
    AND fnome <> 'Maria Silva';

-- Encontre para cada peça, a quantidade total
-- em que ela é fornecida considerando todos os projetos
SELECT pnome, (
    SELECT sum(fpj.qtd) 
    FROM fornpecaproj fpj 
    WHERE fpj.pid=p.pid
)
FROM peca p;

-- Encontre os fornecedores que fornecem peças usadas no projeto ‘J1’
SELECT Fnome 
FROM fornecedor f, projetos p, fornpecaproj fp
WHERE p.jid = 1
    AND p.jid = fp.jid
    AND f.fid = fp.fid;

-- Retorne as peças fornecidas pelo fornecedor ‘F1’
SELECT Pnome
FROM fornecedor f, peca p, fornpecaproj fp
WHERE f.fid = 135
    AND f.fid = fp.fid
    AND p.pid = fp.pid;

-- Encontre para cada peça fornecida: o nome da peça, a quantidade máxima
-- e quantidade mínima em que esta peça é fornecida, excluindo
-- as entregas feitas pelo fornecedor ‘F1’
SELECT Pnome, MAX(qtd), MIN(qtd)
FROM peca p, fornpecaproj fp
WHERE p.pid = fp.pid
    AND fid <> 135
GROUP BY Pnome;

-- Encontre o número de todas as peças
-- que são fornecidas por mais de um fornecedor
SELECT fpj.pid
FROM fornpecaproj fpj
GROUP BY fpj.pid
HAVING COUNT(DISTINCT fpj.fid)>1;

-- Encontre a quantidade total de peças fornecidas por cada fornecedor.
-- Nessa relação deve constar mesmo os fornecedores que não fornecem
-- para nenhum projeto
SELECT fnome, SUM(qtd)
FROM fornecedor f LEFT OUTER JOIN fornpecaproj fpj ON f.fid = fpj.fid
GROUP BY fnome;