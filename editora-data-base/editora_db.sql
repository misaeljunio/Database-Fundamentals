begin;
DROP TABLE IF EXISTS editoras CASCADE;
DROP TABlE IF EXISTS autores CASCADE;
DROP TABlE IF EXISTS livros CASCADE;
DROP TABlE IF EXISTS livros_autores CASCADE;
create table editoras(
	Id INT NOT NULL,
	Nome VARCHAR (50) NOT NULL,
	PRIMARY KEY(Id));

create table autores(
	Id INT NOT NULL,
	Nome VARCHAR (50) NOT NULL,
	PRIMARY KEY(Id));

create table livros(
	Isbn CHAR(13),
    Titulo VARCHAR(50),
    Ano_publicacao INT,
    Qtd_estoque INT,
    Valor DECIMAL(10,2),
    Id_editora INT,
    PRIMARY KEY(Isbn),
    FOREIGN KEY(Id_editora) REFERENCES editoras(id));

create table livros_autores(
	Isbn CHAR(13),
    Id_autor INT,
    FOREIGN KEY(Isbn) REFERENCES livros(Isbn),
    FOREIGN KEY(Id_autor) REFERENCES autores(Id));

insert into editoras values
    (1,'Ática'),
    (2,'FTD'),
    (3,'Melhoramentos'),
    (4,'Novatec'),
    (5,'Bookman');

insert into autores values
    (1,'João'),
    (2,'Maria'),
    (3,'José'),
    (4,'Lúcia'),
    (5,'Carlos'),
    (6,'Pedro'),
    (7,'Ana');

insert into livros values
    (213,'Banco de Dados',2011,2,40.00,4),
    (425,'Sistemas Operacionais',2010,3,80.00,3),
    (732,'Lógica de Programação',2009,1,60.00,2),
    (441,'Programação Orientada a Objetos',2012,1,70.00,1),
    (659,'Java para Nerds',2010,3,100.00,NULL),
    (863,'Engenharia de Software',2010,2,40.00,2),
    (376,'Redes de Computadores',2008,1,100.00,3);

insert into livros_autores values
	(732,1),
	(425,3),
	(659,4),
	(441,2),
	(659,1),
    (425,5),
    (213,3);	

commit;
