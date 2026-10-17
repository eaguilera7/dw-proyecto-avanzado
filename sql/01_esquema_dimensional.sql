-- 1. CREACION DE TABLAS DE DIMENSIONES CON CLAVES SUSTITUTAS
CREATE TABLE Dim_Estudiante (
    SK_Estudiante SERIAL PRIMARY KEY,
    ID_Estudiante_NK INT NOT NULL,
    Nombre_Estudiante VARCHAR(100) NOT NULL,
    Programa_Academico VARCHAR(100) NOT NULL
);

CREATE TABLE Dim_Asignatura (
    SK_Asignatura SERIAL PRIMARY KEY,
    ID_Asignatura_NK INT NOT NULL,
    Nombre_Asignatura VARCHAR(100) NOT NULL,
    Creditos INT NOT NULL
);

CREATE TABLE Dim_Tiempo (
    SK_Tiempo INT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Anio INT NOT NULL,
    Mes INT NOT NULL,
    Nombre_Mes VARCHAR(20) NOT NULL,
    Dia INT NOT NULL
);

-- 2. CREACION DE LA TABLA DE HECHOS CON GRANULARIDAD FINA
CREATE TABLE Fact_Rendimiento_Academico (
    SK_Estudiante INT NOT NULL,
    SK_Asignatura INT NOT NULL,
    SK_Tiempo INT NOT NULL,
    Calificacion_Final NUMERIC(5, 2) NOT NULL,
    Asistencia_Porcentaje NUMERIC(5, 2) NOT NULL,
    Cantidad_Intentos INT DEFAULT 1,
    CONSTRAINT FK_Fact_Estudiante FOREIGN KEY (SK_Estudiante) REFERENCES Dim_Estudiante(SK_Estudiante),
    CONSTRAINT FK_Fact_Asignatura FOREIGN KEY (SK_Asignatura) REFERENCES Dim_Asignatura(SK_Asignatura),
    CONSTRAINT FK_Fact_Tiempo FOREIGN KEY (SK_Tiempo) REFERENCES Dim_Tiempo(SK_Tiempo)
);

-- 3. CREACION DE INDICES PARA OPTIMIZACION DE CONSULTAS
CREATE INDEX IX_Fact_Rendimiento_Tiempo ON Fact_Rendimiento_Academico(SK_Tiempo);
CREATE INDEX IX_Fact_Rendimiento_Estudiante ON Fact_Rendimiento_Academico(SK_Estudiante);