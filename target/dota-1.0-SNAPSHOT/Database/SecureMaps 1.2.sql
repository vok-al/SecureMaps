DROP DATABASE IF EXISTS SECUREMAPS;
CREATE DATABASE SECUREMAPS;
USE SECUREMAPS;

/*===========TABLAS=============*/

CREATE TABLE USUARIO 
	(USERNAME VARCHAR(15) PRIMARY KEY,
     NOMBRE VARCHAR(15),
	 CORREO	VARCHAR(30),
	 PSW VARCHAR(30));
     
INSERT INTO USUARIO VALUES('gran', 'Lucifer', "grand@ioso.dot", "grande");
     
CREATE TABLE PASOS
	(IDPASOS INT AUTO_INCREMENT PRIMARY KEY, 
     NUMPASOS INT, 
     FECHA DATETIME,
     IDUSUARIO VARCHAR(15),
     FOREIGN KEY(IDUSUARIO) REFERENCES USUARIO(USERNAME));
     
CREATE TABLE DIRECCION
	(IDDIRECCION INT AUTO_INCREMENT PRIMARY KEY,
     NUMERO VARCHAR(5),
     CALLE VARCHAR(20),
     COLONIA VARCHAR(20),
     DELEGACION VARCHAR(20),
     LAT DOUBLE,
     LNG DOUBLE);
     
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
     IDUSUARIO VARCHAR(15),
     IDDIRECUSU INT,
     FOREIGN KEY(IDUSUARIO) REFERENCES USUARIO(USERNAME),
     FOREIGN KEY(IDDIRECUSU) REFERENCES DIRECCION(IDDIRECCION));
     
CREATE TABLE VISITA
	(IDVISITA INT AUTO_INCREMENT PRIMARY KEY, 
     FECHA DATE,
     IDLUGAR INT, 
     IDUSUARIO VARCHAR(15),
     FOREIGN KEY(IDLUGAR) REFERENCES LUGAR(IDLUGAR),
     FOREIGN KEY(IDUSUARIO) REFERENCES USUARIO(USERNAME));
     
CREATE TABLE REVIEW
	(IDREVIEW INT AUTO_INCREMENT PRIMARY KEY, 
     PUNTUACION INT,
     COMENTARIO NVARCHAR(250),
     FECHAREVIEW DATETIME,
     IDLUGAR INT,
     IDUSUARIO VARCHAR(15),
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
     IDUSUARIO VARCHAR(15),
     FOREIGN KEY(IDLUGAR) REFERENCES LUGAR(IDLUGAR),
     FOREIGN KEY(IDUSUARIO) REFERENCES USUARIO(USERNAME));

CREATE TABLE SEGURIDAD
	(IDZONA INT AUTO_INCREMENT PRIMARY KEY,
     LAT DOUBLE,
     LNG DOUBLE,
	 NIVEL VARCHAR(5),
     NOMBRE VARCHAR(50),
     MUERTES VARCHAR(5));

/*===============VISTAS================*/
SELECT * FROM USUARIO;

/*===========MÉTODOS=============*/
DELIMITER $$
CREATE PROCEDURE REGISTRAR (IN usu VARCHAR(15) ,IN nom VARCHAR(15), 
IN cor VARCHAR(30), IN ps VARCHAR(30))
BEGIN
INSERT INTO USUARIO VALUES(usu, nom, cor, ps);
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

CREATE PROCEDURE cambiar_contra (IN usern VARCHAR(10), contri VARCHAR(30))
BEGIN
UPDATE USUARIO SET PSW= contri WHERE USERNAME= usern;
END;
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

INSERT INTO VISITA (FECHA, IDLUGAR, IDUSUARIO) VALUES
	('2020-12-17', 4, 'gran'),
	('2021-05-03', 5, 'gran'),
	('2021-08-10', 1, 'gran'),
	('2021-09-17', 2, 'gran'),
	('2021-10-20', 3, 'gran');
    
INSERT INTO SEGURIDAD VALUES
	(1, 19.391246, -99.184655, "1", "San Pedro de los Pinos", "93"), 
    (2, 19.412462, -99.091326, "1", "Ignacio Zaragoza", "87"),
    (3, 19.353501, -99.997096, "1", "Lomas de Zaragoza", "74"), 
    (4, 19.475193, -99.116793, "1", "Estrella", "81"),
    (5, 19.310624, -99.152690, "1", "Pedregal de Santa Ursula I", "92"), 
    (6, 19.447127, -99.184231, "1", "Anahuac Los Manzanos", "71"),
    (7, 19.456191, -99.188509, "1", "Tacuba", "68"), 
    (8, 19.464527, -99.175222, "1", "Obrero Popular", "65"),
    (9, 19.294442, -99.164528, "1", "Toriello Guerra", "58"), 
    (10, 19.301090, -99.043009, "1", "Pueblo Santiago Zapotitlan", "66"),
    (11, 19.331858, -99.269187, "2", "Pueblo San Bartolo Ameyalco", "48"), 
    (12, 19.430837, -99.111985, "2", "7 de julio", "43"),
    (13, 19.306681, -99.073703, "2", "Barrio San Antonio", "49"), 
    (14, 19.501489, -99.124162, "2", "Residencial Zacatenco", "41"),
    (15, 19.325214, -99.157977, "2", "Ajusco II", "35"), 
    (16, 19.449372, -99.218022, "2", "Periodista", "32"),
    (17, 19.257928, -99.034970, "2", "Pueblo San Luis Tlaxialtemalco", "39"), 
    (18, 19.447675, -99.133217, "2", "Peralvillo I", "21"),
    (19, 19.497640, -99.177569, "2", "Pueblo Santa Barbara", "17"), 
    (20, 19.217299, -99.994159, "2", "Pueblo San Antonio Tecomitl", "16"),
    (21, 19.379221, -99.215500, "3", "Lomas de Capula", "11"), 
    (22, 19.432461, -99.093971, "3", "Moctezuma 2a Seccion III", "9"),
    (23, 19.364020, -99.106515, "3", "Granjas San Antonio", "8"), 
    (24, 19.483317, -99.114094, "3", "Villa", "9"),
    (25, 19.312183, -99.152947, "3", "Pedregal de Santa Ursula II", "7"),
    (26, 19.387067, -99.177919, "3", "Ampliacion Napoles", "5"), 
    (27, 19.440682, -99.192721, "3", "Granada", "4"),
    (28, 19.401098, -99.132725, "3", "Viaducto Piedad", "3"), 
    (29, 19.193015, -99.023837, "4", "Villa Milpalta", "150"),
    (30, 19.496629, -99.151460, "4", "Vallejo II", "154"), 
    (31, 19.299809, -99.077431, "4", "Valle de San Lorenzo I", "168"),
    (32, 19.330485, -99.248604, "4", "Torres de Potrero", "117"), 
    (33, 19.268333, -99.003347, "4", "San Pedro Tlahuac", "189"),
    (34, 19.394213, -99.128963, "4", "San Pedro Iztacalco", "192"), 
    (35, 19.316831, -99.164372, "4", "Ajusco II", "135"),
    (36, 19.331481, -99.217430, "4", "Independencia San Ramon", "141");