-- TAREA #1
-- NOMBRE: INCAIVI BRANDON LAZO MARTINEZ
-- CUENTA: 20191001993.
-- ASIGNATURA - SECCION: BASE DE DATOS II - 0800.
-- DOCENTE: ING. CINDY LOURDES EUCEDA GARCIA.

--------------------------------------------------------------------------------------------------------------------------------

--Ejecutar el Codigo Paso por Paso

-- Crear la Base de Datos:
CREATE DATABASE Tarea1_BDII

-- Comando USE:
USE Tarea1_BDII 


--Crear la tabla Hotel:
CREATE TABLE HOTEL
(
Codigo            VARCHAR(50) NOT NULL CONSTRAINT Codigo UNIQUE,
NombreHotel       VARCHAR(30) NOT NULL,
Direccion         VARCHAR(80) NOT NULL,

CONSTRAINT PK_HOTEL PRIMARY KEY (Codigo)
)

--Agregando Inserts para la tabla HOTEL:

INSERT INTO HOTEL VALUES('1122334455','Hotel Angel','Colonia 3 de Mayo');
INSERT INTO HOTEL VALUES('1234567832','Hotel Clarion','Colonia Torocagua');
INSERT INTO HOTEL VALUES('8765432421','Hotel Maya','Colonia Espiritu Santo');

--Select para tabla Hotel_

Select*from HOTEL
----------------------------------------------------------------------------------------------------------------

--Crear la tabla cliente:

create table CLIENTE(

Identidad          VARCHAR(20) NOT NULL CONSTRAINT Identidad UNIQUE,
NombreCliente      VARCHAR(50) NOT NULL,
Telefono           VARCHAR(30) NOT NULL CONSTRAINT Telefono  UNIQUE,

CONSTRAINT PK_CLIENTE PRIMARY KEY (Identidad)

)

--Agregar Inserts para la tabla CLIENTE:

INSERT INTO CLIENTE VALUES ('080119924372','Brandon Lazo','11223344');
INSERT INTO CLIENTE VALUES ('070119903823','Alma Martinez','44332211');
INSERT INTO CLIENTE VALUES ('060119924372','Marlon Rubio','554466332');

--Select para la tabla Cliente:

SELECT*FROM CLIENTE

---------------------------------------------------------------------------------------------------------------------------------------

--Crear la Tabla Reserva que es una relacion muchos a muchos entre las entidades Hotel y Cliente

create table RESERVA(

Codigo      VARCHAR(50) NOT NULL,
Identidad   VARCHAR(20) NOT NULL,
Fecha_in    DATE ,
Fecha_out   DATE ,
Cantidad_Personas  INTEGER NOT NULL DEFAULT 0,

CONSTRAINT PK_RESERVA1 PRIMARY KEY (Codigo,Identidad),
CONSTRAINT FK_RESERVA1 FOREIGN KEY (Codigo) REFERENCES HOTEL(Codigo),
CONSTRAINT FK_RESERVA2 FOREIGN KEY (Identidad) REFERENCES CLIENTE(Identidad),
)

--Agregando Inserts para la tabla Reserva:

INSERT INTO RESERVA VALUES ('1122334455','080119924372','2022-05-18','2022-08-13',1);
INSERT INTO RESERVA VALUES ('1234567832','070119903823','2022-05-20','2022-07-11',2);
INSERT INTO RESERVA VALUES ('8765432421','060119924372','2022-06-25','2022-09-16',3);

-- SELECT para la tabla RESERVA:

SELECT*FROM RESERVA

----------------------------------------------------------------------------------------------------------------------------------

--Crear la Tabla Aerolinea:

create table AEROLINEA(

CodigoAerolinea    Varchar(20) not null,
Descuento          integer,

CONSTRAINT PK_AEROLINEA PRIMARY KEY (CodigoAerolinea),
CONSTRAINT CHK_AEROLINEA1 CHECK (Descuento>=10),

)

--Agregando Inserts para la tabla Aerolinea
INSERT INTO AEROLINEA VALUES ('1234556',10);
INSERT INTO AEROLINEA VALUES ('2136454',15);
INSERT INTO AEROLINEA VALUES ('1222457',18);

--Select para la tabla Aerolinea:

SELECT*FROM AEROLINEA

-------------------------------------------------------------------------------------------------------------------------------------
--Crear la Tabla Boleto:

create table BOLETO (

CodigoBoleto     VARCHAR(30) NOT NULL,
No_Vuelo         INTEGER NOT NULL,
Fecha            DATE NOT NULL,
Destino          VARCHAR (40) NOT NULL,
Identidad        VARCHAR (20) NOT NULL,
CodigoAerolinea  VARCHAR (20) NOT NULL,

CONSTRAINT PK_BOLETO PRIMARY KEY (CodigoBoleto),
CONSTRAINT CHK_BOLETO CHECK (Destino in ('Mexico','Guatemala','Panama')),
CONSTRAINT FK_BOLETO1 FOREIGN KEY (Identidad) REFERENCES CLIENTE(Identidad),
CONSTRAINT FK_BOLETO2 FOREIGN KEY (CodigoAerolinea) REFERENCES AEROLINEA(CodigoAerolinea)

)

--Agregando Inserts para la tabla BOLETO:

INSERT INTO BOLETO VALUES('19827364',12,'2022-12-3','Mexico','080119924372','1234556');
INSERT INTO BOLETO VALUES('12442364',23,'2022-11-20','Guatemala','060119924372','2136454');
INSERT INTO BOLETO VALUES('36726777',23,'2022-11-20','Panama','070119903823','1222457');


--Select para la tabla BOLETO:

Select*from BOLETO












