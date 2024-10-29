create database streaming;
use streaming;
create table genero(
id_genero int,
nome varchar(50),
primary key (id_genero)
);
create table usuario(
id_usuario int,
nome varchar(50),
email varchar(50),
senha varchar(8),
dt_ultimo_acesso timestamp,
ativo int,
primary key (id_usuario)
);
create table ator_atriz(
id_ator_atriz int,
nome varchar(50),
primary key (id_ator_atriz)
);