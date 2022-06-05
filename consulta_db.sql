-- Obter o(s) título(s) do(s) livro(s) que possuem o valor mais alto.
SELECT Titulo
FROM livros
WHERE valor IN (
    SELECT MAX(valor)
    FROM livros
);


-- Obter o(s) nome(s) do(s) autor(es) que publicaram o livro mais barato. 
SELECT nome
FROM autores, livros_autores
WHERE id = Id_autor AND isbn IN (
    SELECT Isbn
    FROM livros l1
    WHERE l1.valor IN (
        SELECT MIN(l2.valor)
        FROM livros l2
    )
);


-- Listar os autores que publicaram livros cujo valor esteja acima da média
-- de preço de livros. Mostrar os resultados em ordem alfabética
-- pelo nome do autor.
SELECT nome 
FROM autores, livros_autores
WHERE Id_autor = id AND isbn IN (
    SELECT isbn 
    FROM livros
    WHERE valor > (
        SELECT AVG(valor)
        FROM livros 
    )
)
ORDER BY nome;


-- Exibir os títulos dos livros e o valor total existente em estoque
-- para cada título. Somente os livros com mais de um exemplar em estoque
-- devem ser exibidos. Os livros devem ser exibidos em ordem decrescente
-- pelo seu valor total em estoque.
SELECT Titulo, Qtd_estoque
FROM livros
WHERE Qtd_estoque > 1
ORDER BY Qtd_estoque DESC;


-- Listar os nomes dos autores e quantos livros cada um deles escreveu.
-- Inclusive autores que não publicaram livros devem ser exibidos.
-- Ordenar do autor que escreveu mais livros até o autor
-- que escreveu menos livros.
SELECT nome, COUNT(*)
FROM autores LEFT OUTER JOIN livros_autores ON Id_autor = Id
GROUP BY nome
ORDER BY COUNT(*) DESC;


-- Listar os nomes das editoras cujo maior valor unitário
-- de livro é maior que R$ 30,00.
SELECT nome
FROM editoras, livros
WHERE id_editora = id 
GROUP BY nome
HAVING MAX(valor) > 30;


-- Listar os nomes das editoras que possuem mais de um livro.
SELECT nome
FROM editoras, livros
WHERE id_editora = id 
GROUP BY nome
HAVING COUNT(*) > 1;


-- Listar os nomes dos autores que publicaram
-- livros pela editora ‘Melhoramentos’.
SELECT a.nome 
FROM autores a, livros l, editoras e, livros_autores la 
WHERE e.nome = 'Melhoramentos'
    AND e.id = id_editora
    AND l.isbn = la.Isbn
    AND Id_autor = a.id;


-- Listar somente os nomes dos autores que não possuem livros publicados.
SELECT Nome
FROM autores
WHERE NOT EXISTS (
    SELECT *
    FROM livros_autores la, livros l
    WHERE l.isbn = la.isbn
    AND Id_autor = id
);


-- Listar os títulos de livros com valor unitário maior ou igual
-- ao maior valor unitário de livro. Nesta questão, escreva duas consultas.
-- Uma delas usando função agregada e a outra sem o uso de função agregada.

-- Usando função agregada
SELECT Titulo
FROM livros
WHERE valor >= (
    SELECT MAX(VALOR)
    FROM livros
);

-- Sem o uso de função agregada
SELECT Titulo
FROM livros
WHERE valor >= ALL (
    SELECT Valor
    FROM livros
);


-- Listar título do livro, nome do autor e nome da editora.
-- A listagem deve exibir inclusive livros sem editora, livros sem autor,
-- autores sem livro e editoras sem livro.
SELECT l.titulo, e.nome, a.nome
FROM (livros l FULL OUTER JOIN editoras e ON id_editora = e.id)
     FULL OUTER JOIN livros_autores la ON l.isbn = la.isbn
     FULL OUTER JOIN autores a ON Id_autor = a.id;
