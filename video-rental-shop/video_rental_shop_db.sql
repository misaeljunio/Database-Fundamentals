begin;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS classes CASCADE;
DROP TABLE IF EXISTS distribuidores CASCADE;
DROP TABLE IF EXISTS filmes CASCADE;
DROP TABLE IF EXISTS locacoes CASCADE;
CREATE TABLE clientes(
        Id INT,
        Nome VARCHAR(50),
        Cpf CHAR(11),
        Data_cadastro DATE,
        Cidade VARCHAR(50),
        Uf CHAR(2),
        PRIMARY KEY(Id)
        UNIQUE(Cpf));
CREATE TABLE categorias(
        Id INT,
        Nome VARCHAR(20),
        PRIMARY KEY(Id));
CREATE TABLE classes(
        Id INT,
        Nome VARCHAR(20),
        Preco DECIMAL(10,2),
        PRIMARY KEY(Id));
CREATE TABLE distribuidores(
        Id INT,
        Nome VARCHAR(50),
        PRIMARY KEY(Id));
CREATE TABLE filmes(
        Id INT,
        Titulo VARCHAR(50),
        Id_distribuidor INT,
        Ano_lancamento INT,
        Id_categoria INT,
        Id_classe INT,
        PRIMARY KEY(Id),
        FOREIGN KEY(Id_distribuidor) REFERENCES distribuidores(Id),
        FOREIGN KEY(Id_categoria) REFERENCES categorias(Id),
        FOREIGN KEY(Id_classe) REFERENCES classes(Id));
CREATE TABLE locacoes(
        Id INT,
        Id_cliente INT,
        Id_filme INT,
        Dt_locacao DATE,
        Dt_devolucao_prevista DATE,
        Dt_devolucao DATE,
        Valor DECIMAL(10,2),
        PRIMARY KEY(Id),
        FOREIGN KEY(Id_cliente) REFERENCES clientes(Id),
        FOREIGN KEY(Id_filme) REFERENCES filmes(Id));

INSERT INTO clientes VALUES
        (5678,'Alan','25489673354','2011-11-23','Quixadá','CE'),
        (4982,'Turing','56778435981','2013-06-12','Catalão','GO'),
        (6987,'Linus','66547201251','2014-08-22','Valparaíso de Goiás','GO'),
        (2368,'Torvalds','02456872251','2010-09-11','Bagé','RS');

INSERT INTO categorias VALUES
        (1,'Terror'),
        (2,'Aventura'),
        (3,'Documentário'),
        (4,'Drama'),
        (5,'Comédia');

INSERT INTO classes VALUES
        (1,'A',4.5),
        (2,'B',3.5),
        (3,'C',2.5);

INSERT INTO distribuidores VALUES
        (100,'Warner Bros'),
        (200,'Disney'),
        (300,'Universal'),
        (400,'WingNut Films');

INSERT INTO filmes VALUES
        (1000,'Imitation Game',100,2014,4,1),
        (1001,'The Lord of the Rings: The Fellowship of the Ring',400,2001,2,2),
        (1002,'Monsters, Inc',200,2001,5,3);

INSERT INTO locacoes VALUES
        (1358,6987,1001,'2022-05-02','2022-05-04',NULL,3.5),
        (1295,2368,1002,'2022-04-28','2022-04-30','2022-04-30',2.5),
        (1248,4982,1000,'2022-04-02','2022-04-04','2022-04-04',4.5);
commit;
