DROP DATABASE IF EXISTS SECUREMAPS;
CREATE DATABASE SECUREMAPS;
USE SECUREMAPS;

/*===========TABLAS=============*/

CREATE TABLE USUARIO 
	(USERNAME INT AUTO_INCREMENT PRIMARY KEY,
     NOMBRE VARCHAR(15),
	 CORREO	VARCHAR(30),
	 PSW VARCHAR(30));
     
INSERT INTO USUARIO VALUES("gran", 'Lucifer', "grand@ioso.dot", "grande");
     
CREATE TABLE PASOS
	(IDPASOS INT AUTO_INCREMENT PRIMARY KEY, 
     NUMPASOS INT, 
     FECHA DATETIME,
     IDUSUARIO INT,
     FOREIGN KEY(IDUSUARIO) REFERENCES USUARIO(USERNAME));
     
CREATE TABLE DIRECCION
	(IDDIRECCION INT AUTO_INCREMENT PRIMARY KEY,
     NUMERO VARCHAR(5),
     CALLE VARCHAR(20),
     COLONIA VARCHAR(20),
     DELEGACION VARCHAR(20),
     DMAPA NVARCHAR(100));
     
CREATE TABLE LUGAR
	(IDLUGAR INT AUTO_INCREMENT PRIMARY KEY,
     NOMBRE VARCHAR(60),
     IMAGEN LONGTEXT,
     TIPO VARCHAR(30),
     DESCRIPCIÓN NVARCHAR(255),
     IDDIRECCION INT,
     FOREIGN KEY(IDDIRECCION) REFERENCES DIRECCION(IDDIRECCION));
     
CREATE TABLE DIRECUSUARIO
	(ACTIVO BOOL,
     IDUSUARIO INT,
     IDDIRECUSU INT,
     FOREIGN KEY(IDUSUARIO) REFERENCES USUARIO(USERNAME),
     FOREIGN KEY(IDDIRECUSU) REFERENCES DIRECCION(IDDIRECCION));
     
CREATE TABLE VISITA
	(IDVISITA INT AUTO_INCREMENT PRIMARY KEY, 
     FECHA DATE,
     IDLUGAR INT, 
     IDUSUARIO INT,
     FOREIGN KEY(IDLUGAR) REFERENCES LUGAR(IDLUGAR),
     FOREIGN KEY(IDUSUARIO) REFERENCES USUARIO(USERNAME));
     
CREATE TABLE REVIEW
	(IDREVIEW INT AUTO_INCREMENT PRIMARY KEY, 
     PUNTUACION INT,
     COMENTARIO NVARCHAR(250),
     FECHAREVIEW DATETIME,
     IDLUGAR INT,
     IDUSUARIO INT,
     FOREIGN KEY(IDUSUARIO) REFERENCES USUARIO(USERNAME),
     FOREIGN KEY(IDLUGAR) REFERENCES LUGAR(IDLUGAR));
     
CREATE TABLE TRAYECTO
	(IDTRAYECTO INT AUTO_INCREMENT PRIMARY KEY,
     IDLUGAR INT,
     IDDIRECUSU INT,
     FOREIGN KEY(IDLUGAR) REFERENCES LUGAR(IDLUGAR),
     FOREIGN KEY(IDDIRECUSU) REFERENCES DIRECCION(IDDIRECCION));
     
CREATE TABLE HORARIO
	(IDHORARIO INT AUTO_INCREMENT PRIMARY KEY,
     DIA VARCHAR(10),
     APERTURA TIME,
     CIERRE TIME,
     IDLUGAR INT,
     FOREIGN KEY(IDLUGAR) REFERENCES LUGAR(IDLUGAR));     
     
CREATE TABLE HISTBUSQUEDA
	(IDHISTBUS INT AUTO_INCREMENT PRIMARY KEY,
     FECHA DATETIME,
     IDLUGAR INT,
     IDUSUARIO INT,
     FOREIGN KEY(IDLUGAR) REFERENCES LUGAR(IDLUGAR),
     FOREIGN KEY(IDUSUARIO) REFERENCES USUARIO(USERNAME));

/*===============VISTAS================*/
SELECT * FROM USUARIO;

/*===========MÉTODOS=============*/
DELIMITER $$
CREATE PROCEDURE REGISTRAR (IN NOMBRE VARCHAR(15), 
IN CORREO VARCHAR(30), IN PSW VARCHAR(30))
BEGIN
INSERT INTO USUARIO VALUES(NOMBRE, CORREO, PSW);
END;
$$

CREATE PROCEDURE CONSULTAR_USUARIO (IN USERt VARCHAR(30))
BEGIN
SELECT * FROM USUARIO WHERE USERNAME= USERt;
END
$$

CREATE PROCEDURE DIREC_USU (IN USERt VARCHAR(30))
BEGIN
SELECT * FROM DIREC_USU WHERE IDUSUARIO= USERt;
END
$$

/*===============INFORMACIÓN================*/
DELIMITER ;
INSERT INTO LUGAR VALUES
	(1, 'Monumento a la Revolución', 'https://i2.wp.com/blog.vivaaerobus.com/wp-content/uploads/2020/03/Monumento-de-la-Revolucion.jpg?resize=700%2C393&ssl=1', 'Monumento',
    'El Monumento a la Revolución es una obra arquitectónica y un mausoleo dedicado a la conmemoración de la Revolución mexicana. Es obra del arquitecto Carlos Obregón Santacilia.', null),
	(2, 'Museo Soumaya','https://cdn2.dineroenimagen.com/media/dinero/lugares-turisticos-cdmx-2.jpg', 'Museo',
    'Institución cultural sin fines de lucro fundada en 1994 que cuenta con tres recintos en la Ciudad de México: Plaza Loreto, Plaza Carso y la Casa Museo Guillermo Tovar de Teresa.', null),
	(3, 'Terraza Piso Cuatro','https://i0.wp.com/foodandpleasure.com/wp-content/uploads/2020/08/piso-cuatro-food-and-pleasure-2.jpg?w=1620&ssl=1', 'Restaurante',
	'Su cocina abierta te permitirá probar cada bocado con la confianza de que están siendo preparados bajo los estándares más altos de limpieza y calidad, hacen de cada visita un recuerdo inolvidable.', null),
	(4, 'Parque Masayoshi Ohira','https://www.lamudi.com.mx/journal/wp-content/uploads/2021/06/shutterstock_1706933719-1.jpg', 'Parque',
    'Inaugurado en 1942 por el entonces Regente del Distrito Federal, Javier Rojo Gómez como símbolo de amistad y paz entre ambos países, este parque de estilo japonés fue testigo de películas mexicanas de gran relevancia.', null),
	(5, 'Forum Buenavista','https://www.hotel-casablanca.com.mx/cache/88/0a/880a0f10078d4a6f890ba7e05e4d8c13.jpg', 'Centro Comercial',
    'Este lugar tiene muchas tiendas de ropa, restaurantes, cine, área de comida y hasta pista de hielo. Está muy bien ubicada dentro del centro de la Ciudad de México y es una de las entradas a la estación de tren suburbano.', null);

INSERT INTO VISITA VALUES
	(1, '2020-12-17', 4, 'gran'),
	(2, '2021-05-03', 5, 'gran'),
	(3, '2021-08-10', 1, 'gran'),
	(4, '2021-09-17', 2, 'gran'),
	(5, '2021-10-20', 3, 'gran');