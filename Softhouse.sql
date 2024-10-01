#criação do banco de dados:#
CREATE DATABASE if not exists SOFTHOUSE
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

#uso do banco de dados e criação de tabelas:#
USE Softhouse;
CREATE TABLE if not exists Aluno(
ALUNO_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ALUNO_Nome VARCHAR(60) NOT NULL ,
ALUNO_Endereco VARCHAR(60) NOT NULL ,
ALUNO_Sexo ENUM('M','F') NOT NULL ,
ALUNO_Email VARCHAR(60) NOT NULL ,
ALUNO_Telefone VARCHAR(20) NOT NULL ,
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
ALTER TABLE ALUNO CHANGE DATA_NASCIMENTO NASCIMENTO DATE NULL;
ALTER TABLE ALUNO ADD INDEX INDEX_NomeAluno(ALUNO_Nome);
#ALTER TABLE INSTRUTOR ADD PROFISSAO VARCHAR(30);
ALTER TABLE CURSO ADD INDEX INDEX_NomeCurso(CURSO_Nome); 
#inserção de dados nas tabelas:
#tbTipo
insert into tipo values(1,"Banco de dados");
insert into tipo values(2,"Programação");
insert into tipo values(3,"Modelagem de dados");
#tbInstrutor
insert into instrutor values(1,"André Milani",'M',"1111-1111","andre@softhouse.com.br");
insert into instrutor values(2,"Carlos Tosin",'M',"1234-1456","jose@softhouse.com.br");
insert into instrutor values(3,"Marcos Batista",'M',"1231-1456","marcos@softhouse.com.br");
insert into instrutor values(4,"Maria da Silva",'F','7681-4556','maria@softhouse.com.br');
#tbCurso
insert into curso values(1,'Java Fundamentos',2,2,270);
insert into curso values(2,'Java Avançado',2,2,330);
insert into curso values(3,'SQL Completo',1, 1,170);
insert into curso values(4,'Php Básico',2,1,270);

 
