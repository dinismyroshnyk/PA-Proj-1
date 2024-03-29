/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     06/03/2024 17:45:02                          */
/*==============================================================*/

drop database if exists projeto;
CREATE DATABASE projeto;
USE projeto;

SET GLOBAL event_scheduler = ON;

/*==============================================================*/
/* Event: FREE_USER_CREDENTIALS                                 */
/*==============================================================*/
CREATE EVENT FREE_USER_CREDENTIALS
ON SCHEDULE EVERY 2 MINUTE
STARTS CURRENT_DATE
DO
   UPDATE UTILIZADORES
   SET USERNAME = NULL, PASSWORD = NULL, SALT = NULL,
         EMAIL = NULL, TIPO = NULL, CONTRIBUINTE = NULL,
         TELEFONE = NULL, MORADA = NULL, ESTILO_LITERARIO = NULL,
         DATA_INICIO = NULL, AREA_ESPECIALIZACAO = NULL,
         FORMACAO_ACADEMICA = NULL
   WHERE ESTADO = 'deleted';

drop table if exists ANOTACAO;

drop table if exists LICENCA;

drop table if exists OBRAS;

drop table if exists REVISAO;

drop table if exists UTILIZADORES;

/*==============================================================*/
/* Table: ANOTACAO                                              */
/*==============================================================*/
create table ANOTACAO
(
   ID_ANOTACAO          int not null AUTO_INCREMENT,
   ID_REVISAO           int,
   DESCRICAO            text not null,
   PAGINA               int not null,
   PARAGRAFO            int not null,
   DATA                 date not null,
   primary key (ID_ANOTACAO)
);

/*==============================================================*/
/* Table: LICENCA                                               */
/*==============================================================*/
create table LICENCA
(
   ID_LICENCA           int not null AUTO_INCREMENT,
   NUMERO               text not null,
   DATA_INICIO          date not null,
   DATA_FIM             date not null,
   N_UTILIZACAO         int not null,
   primary key (ID_LICENCA)
);

/*==============================================================*/
/* Table: OBRAS                                                 */
/*==============================================================*/
create table OBRAS
(
   ID_OBRA              int not null AUTO_INCREMENT,
   ID_UTILIZADORES      int not null,
   ID_LICENCA           int not null,
   TITULO               varchar(50) not null,
   SUBTITULO            varchar(60) not null,
   ESTILO_LITERARIO     varchar(30) not null,
   TIPO_PUBLICACAO      text not null,
   N_PAGINAS            int not null,
   N_PALAVRAS           int not null,
   CODIGO_ISBN          int not null,
   N_EDICAO             int not null,
   DATA_SUBMICAO        date not null,
   DATA_APROVACAO       date not null,
   primary key (ID_OBRA)
);

/*==============================================================*/
/* Table: REVISAO                                               */
/*==============================================================*/
create table REVISAO
(
   ID_REVISAO           int not null AUTO_INCREMENT,
   ID_OBRA              int not null,
   ID_UTILIZADORES      int not null,
   N_SERIE              text not null,
   DATA_REALIZACAO      date not null,
   TEMPO_RECORRIDO      time not null,
   CUSTO                decimal(2,2) not null,
   R_ESTADO             varchar(8) not null,
   primary key (ID_REVISAO)
);

/*==============================================================*/
/* Table: UTILIZADORES                                          */
/*==============================================================*/
create table UTILIZADORES
(
   ID_UTILIZADORES      int not null AUTO_INCREMENT,
   NOME                 varchar(100) not null,
   USERNAME             varchar(20),
   PASSWORD             varchar(60),
   SALT                 varbinary(16),
   ESTADO               ENUM('active', 'inactive', 'pending-activation', 'pending-deletion', 'deleted') not null,
   EMAIL                varchar(100),
   TIPO                 ENUM('manager', 'author', 'reviewer'),
   CONTRIBUINTE         varchar(9),
   TELEFONE             varchar(9),
   MORADA               varchar(100),
   ESTILO_LITERARIO     varchar(20),
   DATA_INICIO          date,
   AREA_ESPECIALIZACAO  varchar(20),
   FORMACAO_ACADEMICA   varchar(100),
   primary key (ID_UTILIZADORES)
);

alter table ANOTACAO add constraint FK_REVISAO_ANOTACAO foreign key (ID_REVISAO)
   references REVISAO (ID_REVISAO) on delete restrict on update restrict;

alter table OBRAS add constraint FK_OBRAS_LICENCA foreign key (ID_LICENCA)
   references LICENCA (ID_LICENCA) on delete restrict on update restrict;

alter table OBRAS add constraint FK_UTILIZADORES_OBRAS foreign key (ID_UTILIZADORES)
   references UTILIZADORES (ID_UTILIZADORES) on delete restrict on update restrict;

alter table REVISAO add constraint FK_OBRAS_REVISAO foreign key (ID_OBRA)
   references OBRAS (ID_OBRA) on delete restrict on update restrict;

alter table REVISAO add constraint FK_UTILIZADORES_REVISAO foreign key (ID_UTILIZADORES)
   references UTILIZADORES (ID_UTILIZADORES) on delete restrict on update restrict;

