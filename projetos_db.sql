begin;
DROP TABLE IF EXISTS Fornecedor CASCADE;
DROP TABlE IF EXISTS Peca CASCADE;
DROP TABlE IF EXISTS Projetos CASCADE;
DROP TABlE IF EXISTS FornPecaProj CASCADE;

create table Fornecedor(
	Fid INT NOT NULL,
	Fnome VARCHAR(15) NOT NULL,
	Cidade VARCHAR(15),
	PRIMARY KEY(Fid));

create table Peca(
	Pid INT NOT NULL,
	Pnome VARCHAR(15) NOT NULL,
	Cor VARCHAR(15),
	PRIMARY KEY (Pid));
	
create table Projetos(
	Jid INT NOT NULL,
	Jnome VARCHAR(15) NOT NULL,
	Cidade VARCHAR(15) NOT NULL,
	PRIMARY KEY (Jid));

create table FornPecaProj(
	Fid INT NOT NULL,
	Pid INT NOT NULL,
	Jid INT NOT NULL,
	Qtd INT NOT NULL,
	FOREIGN KEY(Fid) REFERENCES Fornecedor(Fid),
	FOREIGN KEY(Pid) REFERENCES Peca(Pid),
	FOREIGN KEY(Jid) REFERENCES Projetos(Jid));

INSERT INTO Fornecedor VALUES
	(135,'Volkswagen','Munique'),
	(136,'Chevrolet','Detroit'),
	(137,'Toyota','Tokyo'),
	(138,'Hyundai','Seoul'),
	(139, 'Mercedes','Berlin');

INSERT INTO Peca VALUES
	(08796,'escapamento','preto'),
	(06475,'porta','cinza'),
	(07789,'motor','preto'),
	(06854,'volante','grafite');

INSERT INTO Projetos VALUES
	(1,'Concessionária','Quixadá'),
	(2,'Oficina','São Paulo'),
	(3,'Pesquisa','Fortaleza'),
	(4,'Reciclagem','Blumenau');

INSERT INTO FornPecaProj VALUES
	(135,07789,1,34),
	(138,08796,3,15),
	(137,06854,4,11),
	(136,06475,1,10),
	(137,06854,2,46),
	(135,08796,4,21);

commit;