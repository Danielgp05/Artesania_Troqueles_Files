-- CREACIÓN DE TABLAS

CREATE TABLE CLIENTE (
    cliente_id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    dirección TEXT NOT NULL,
    teléfono VARCHAR(20) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE TROQUEL (
    troquel_id INT PRIMARY KEY,
    num_troquel VARCHAR(50) NOT NULL,
    ubicación TEXT,
    formato VARCHAR(50),
    descripción TEXT NOT NULL,
    medida_caja_montada VARCHAR(50) NOT NULL,
    cliente_id INT NOT NULL,
    imagen TEXT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTE(cliente_id)
);

CREATE TABLE POSES (
    poses_id INT PRIMARY KEY,
    material VARCHAR(100) NOT NULL,
    medida_alto DECIMAL(10,2) NOT NULL,
    medida_ancho DECIMAL(10,2) NOT NULL,
    troquel_id INT NOT NULL,
    imagen TEXT NOT NULL,
    FOREIGN KEY (troquel_id) REFERENCES TROQUEL(troquel_id)
);

CREATE TABLE USUARIO (
    user_id INT PRIMARY KEY,
    usuario VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    FCM_token TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE ROL (
    rol_id INT PRIMARY KEY,
    nombre_rol VARCHAR(100) UNIQUE NOT NULL,
    descripción TEXT
);

CREATE TABLE USUARIO_ROL (
    user_id INT,
    rol_id INT,
    PRIMARY KEY (user_id, rol_id),
    FOREIGN KEY (user_id) REFERENCES USUARIO(user_id),
    FOREIGN KEY (rol_id) REFERENCES ROL(rol_id)
);

CREATE TABLE FASES (
    fases_id INT PRIMARY KEY,
    nombre_fase VARCHAR(100) NOT NULL
);

CREATE TABLE TRABAJADOR (
    trabajador_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE PEDIDO (
    pedido_id INT PRIMARY KEY,
    num_pedido VARCHAR(50) UNIQUE NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_entrega DATE NOT NULL,
    cliente_id INT NOT NULL,
    materiales TEXT,
    cantidad INT NOT NULL,
    descripcion TEXT NOT NULL,
    documento_pdf LONGBLOB,
    notas TEXT,
    fase_id INT NOT NULL,
    trabajador_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTE(cliente_id)
    FOREIGN KEY (fase_id) REFERENCES FASES(fase_id)
    FOREIGN KEY (trabajador_id) REFERENCES TRABAJADOR(trabajador_id)
);

CREATE TABLE PEDIDO_FASES (
    pedido_id INT NOT NULL,
    fase_id INT NOT NULL,
    trabajador_id INT NOT NULL,
    fecha_llegada TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (pedido_id, fase_id),
    FOREIGN KEY (pedido_id) REFERENCES PEDIDO(pedido_id),
    FOREIGN KEY (fase_id) REFERENCES FASES(fases_id),
    FOREIGN KEY (trabajador_id) REFERENCES TRABAJADOR(trabajador_id)
);

CREATE TABLE PEDIDO_TROQUEL (
    pedido_id INT,
    troquel_id INT,
    PRIMARY KEY (pedido_id, troquel_id),
    FOREIGN KEY (pedido_id) REFERENCES PEDIDO(pedido_id),
    FOREIGN KEY (troquel_id) REFERENCES TROQUEL(troquel_id)
);

CREATE TABLE TINTAS (
    tintas_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    hexadecimal VARCHAR(7) NOT NULL,
    cantidad INT NOT NULL
);

CREATE TABLE PEDIDO_TINTAS (
    pedido_id INT,
    tintas_id INT,
    PRIMARY KEY (pedido_id, tintas_id),
    FOREIGN KEY (pedido_id) REFERENCES PEDIDO(pedido_id),
    FOREIGN KEY (tintas_id) REFERENCES TINTAS(tintas_id)
);

