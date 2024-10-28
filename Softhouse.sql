#criação do banco de dados:
CREATE DATABASE if not exists SOFTHOUSE
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

#uso do banco de dados e criação de tabelas:
USE Softhouse;
CREATE TABLE if not exists Aluno(
ALUNO_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ALUNO_Nome VARCHAR(60) NOT NULL ,
ALUNO_Endereco VARCHAR(60) NOT NULL ,
ALUNO_Sexo ENUM('M','F') NOT NULL ,
ALUNO_Email VARCHAR(60) NOT NULL ,
ALUNO_Telefone VARCHAR(20) NOT NULL DEFAULT '0000-0000',
PRIMARY KEY (ALUNO_ID)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE if not exists Instrutor(
INSTRUTOR_ID INT UNSIGNED NOT NULL AUTO_INCREMENT ,
INSTRUTOR_Nome VARCHAR(60) NOT NULL ,
INSTRUTOR_Sexo ENUM('M','F') NOT NULL ,
INSTRUTOR_Telefone VARCHAR(60) NOT NULL ,
INSTRUTOR_Email VARCHAR(60) NOT NULL ,
PRIMARY KEY (INSTRUTOR_ID)
)ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE if not exists Tipo(
TIPO_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
TIPO_Descricao VARCHAR(60) NOT NULL,
PRIMARY KEY (TIPO_ID)
)ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE if not exists Pedido(
PEDIDO_ID INT UNSIGNED NOT NULL AUTO_INCREMENT ,
PEDIDO_Data DATE NOT NULL ,
PEDIDO_Hora TIME NOT NULL ,
ALUNO_ID INT UNSIGNED NOT NULL ,
PRIMARY KEY (PEDIDO_ID),
INDEX FK_ALUNO(ALUNO_ID),
FOREIGN KEY (ALUNO_ID) REFERENCES Aluno (ALUNO_ID)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE if not exists Curso(
CURSO_ID INT UNSIGNED NOT NULL AUTO_INCREMENT ,
CURSO_Nome VARCHAR(60) NOT NULL ,
TIPO_ID INT UNSIGNED NOT NULL ,
INSTRUTOR_ID INT UNSIGNED NOT NULL ,
CURSO_VALOR DECIMAL(7,2) NOT NULL ,
PRIMARY KEY (CURSO_ID),
INDEX FK_TIPO(TIPO_ID),
INDEX FK_INSTRUTOR(INSTRUTOR_ID),
FOREIGN KEY (TIPO_ID) REFERENCES Tipo (TIPO_ID),
FOREIGN KEY (INSTRUTOR_ID) REFERENCES Instrutor (INSTRUTOR_ID)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE if not exists Pedido_Detalhe(
PEDIDO_ID INT UNSIGNED NOT NULL ,
CURSO_ID INT UNSIGNED NOT NULL ,
PEDIDO_Valor DECIMAL(7,2) NOT NULL ,
PRIMARY KEY (PEDIDO_ID, CURSO_ID),
INDEX FK_CURSO(CURSO_ID),
INDEX FK_PEDIDO(PEDIDO_ID),
FOREIGN KEY (CURSO_ID) REFERENCES Curso (CURSO_ID),
FOREIGN KEY (PEDIDO_ID) REFERENCES Pedido (PEDIDO_ID)
)ENGINE = InnoDB DEFAULT CHARSET = utf8;

#alteração de tabela
ALTER TABLE ALUNO ADD DATA_NASCIMENTO VARCHAR(10);
ALTER TABLE ALUNO CHANGE DATA_NASCIMENTO ALUNO_Nascimento DATE NULL;
ALTER TABLE ALUNO ADD INDEX INDEX_NomeAluno(ALUNO_Nome);
#ALTER TABLE INSTRUTOR ADD PROFISSAO VARCHAR(30);
ALTER TABLE CURSO ADD INDEX INDEX_NomeCurso(CURSO_Nome);
#ALTER TABLE INSTRUTOR DROP INSTRUTOI_Email;

#Exercício 1: Inserção de dados nas tabelas:
#tbTipo
INSERT INTO TIPO VALUES(1,"Banco de dados");
INSERT INTO TIPO VALUES(2,"Programação");
INSERT INTO TIPO VALUES(3,"Modelagem de dados");
#tbInstrutor
INSERT INTO INSTRUTOR VALUES(1,"André Milani",'M',"1111-1111","andre@softhouse.com.br");
INSERT INTO INSTRUTOR VALUES(2,"Carlos Tosin",'M',"1234-1456","jose@softhouse.com.br");
INSERT INTO INSTRUTOR VALUES(3,"Marcos Batista",'M',"1231-1456","marcos@softhouse.com.br");
INSERT INTO INSTRUTOR VALUES(4,"Maria da Silva",'F','7681-4556','maria@softhouse.com.br');
#tbCurso
INSERT INTO CURSO VALUES(1,'Java Fundamentos',2,2,270);
INSERT INTO CURSO VALUES(2,'Java Avançado',2,2,330);
INSERT INTO CURSO VALUES(3,'SQL Completo',1, 1,170);
INSERT INTO CURSO VALUES(4,'Php Básico',2,1,270);
#tbAlunos
INSERT INTO ALUNO
	(ALUNO_ID,ALUNO_Nome,ALUNO_Endereco,ALUNO_Email) 
VALUES
	(1,'José','Rua XV de Novembro 72','jose@softhouse.com.br'),
	(2,'Wagner','Av. Paulista','wagner@softhouse.com.br'),
	(3,'Emílio','Rua Lajes 103, ap: 701','emilio@softhouse.com.br'),
	(4,'Cris','Rua Tauney 22','cris@softhouse.com.br'),
	(5,'Regina','Rua Salles 305','regina@softhouse.com.br'),
	(6,'Fernando','Av. Central 30','fernando@softhouse.com.br');
#tbPedido
INSERT INTO PEDIDO
	(PEDIDO_ID,PEDIDO_Data,PEDIDO_Hora,ALUNO_ID)
VALUES
	(1,'2010-04-15',"11:23:32",2),
	(2,'2010-04-15',"14:36:21",2),
	(3,'2010-04-16',"11:17:45",3),
	(4,'2010-04-17',"14:27:22",4),
	(5,'2010-04-18',"11:18:19",5),
	(6,'2010-04-19',"13:47:35",6),
	(7,"2010-04-20",'18:13:44',6);
#tbPedido_detalhe
INSERT INTO PEDIDO_DETALHE
	(PEDIDO_ID,CURSO_ID,PEDIDO_Valor)
VALUES
	(1, 1, 270),
	(1, 2, 330),
	(2, 1, 270),
	(2, 2, 330),
	(2, 3, 170),
	(3, 4, 270),
	(4, 2, 330),
	(4, 4, 270),
	(5, 3, 170),
	(6, 3, 170),
	(7, 4, 270);

#Exercício 2: Seleção de registros das tabelas
#01
SELECT * FROM ALUNO;
#02
SELECT CURSO_NOME FROM CURSO;
#03
SELECT CURSO_NOME,CURSO_VALOR FROM CURSO WHERE CURSO_VALOR>200;
#04
SELECT CURSO_NOME,CURSO_VALOR FROM CURSO WHERE CURSO_VALOR>200 AND CURSO_VALOR<300;
#05
SELECT CURSO_NOME,CURSO_VALOR FROM CURSO WHERE CURSO_VALOR BETWEEN 200 AND 300;
#06
SELECT * FROM PEDIDO WHERE PEDIDO_DATA>='2010-04-15' AND PEDIDO_DATA<='2010-04-18';
#07
SELECT * FROM PEDIDO WHERE PEDIDO_DATA BETWEEN'2010-04-15' AND '2010-04-18';
#08
SELECT * FROM PEDIDO WHERE PEDIDO_DATA='2010-04-15';

#Exercício 3: Atualização de registros em tabelas
#01
UPDATE ALUNO
SET ALUNO_Endereco='Av. Brasil, 778'
WHERE ALUNO_ID=1;
#02
UPDATE ALUNO
SET ALUNO_Email='cristiana@gmail.com'
WHERE ALUNO_ID=4;
#03
UPDATE PEDIDO_DETALHE
SET PEDIDO_VALOR=PEDIDO_VALOR*1.1
WHERE PEDIDO_VALOR<300;
#04
UPDATE CURSO
SET CURSO_NOME='Php Fundamento'
WHERE CURSO_ID=4;

#Exercício 4: Views e Joins
#01
select CURSO_Nome,TIPO_descricao from curso c inner join tipo t on c.tipo_id=t.tipo_id;
#02
select curso_nome, tipo_descricao, instrutor_nome, instrutor_telefone from ((curso c inner join tipo t on c.tipo_id=t.tipo_id) inner join instrutor i on c.instrutor_id=i.instrutor_id);
#03
select p.pedido_id,pedido_data,pedido_hora,curso_id from pedido as p inner join pedido_detalhe as d on p.pedido_id=d.pedido_id;
#04
select d.pedido_id,pedido_data,pedido_hora,curso_nome from ((pedido_detalhe as d inner join pedido as p on d.pedido_id=p.pedido_id) inner join curso as c on d.curso_id=c.curso_id);
#05
select d.pedido_id,pedido_data,pedido_hora,aluno_nome,curso_nome from ((pedido_detalhe as d inner join pedido as p on d.pedido_id=p.pedido_id)inner join aluno as a on p.aluno_id=a.aluno_id inner join curso as c on d.curso_id=c.curso_id);
#06
create view Preços_dos_cursos_de_Programação as select curso_nome,curso_valor from curso where tipo_id=2;
select * from Preços_dos_cursos_de_Programação;
#07
create view Informação_dos_cursos as select curso_nome,tipo_descricao,instrutor_nome from ((curso as c inner join tipo as t on c.tipo_id=t.tipo_id) inner join instrutor i on c.instrutor_id=i.instrutor_id);
select * from Informação_dos_cursos;
#08
create view Pedidos_realizados as select aluno_nome,pedido_data,pedido_id from aluno as a inner join pedido as p on a.aluno_id=p.aluno_id;
select * from Pedidos_realizados;