--QUITAR COMENTARIOS DEL SIGUIENTE BLOQUE SI SE NECESITA LA CREACIÓN DE LA BASE DE DATOS, Y ADAPTARLO SEGÚN SE NECESITE
/*
USE master
GO

CREATE DATABASE TPC_DW ON PRIMARY ( NAME =
'TPC_DW_Data',
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL17\MSSQL\DATA\TPC_DW_Data.mdf' ,
SIZE = 86528KB ,
MAXSIZE = UNLIMITED,
FILEGROWTH = 16384KB )
LOG ON ( NAME = 'TPC_DW_Log',FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL17\MSSQL\DATA\TPC_DW_Log.ldf' ,
SIZE = 2048KB ,
MAXSIZE = 2048GB ,
FILEGROWTH = 16384KB )
GO

USE TPC_DW
GO
*/

/*
 * ER/Studio 8.0 SQL Code Generation
 * Company :      BDA
 * Project :      Model1.DM1
 * Author :       Beto
 *
 * Date Created : Wednesday, October 30, 2019 16:27:02
 * Target DBMS : Microsoft SQL Server 2008
 */

/* 
 * TABLE: DimAlmacen 
 */

CREATE TABLE DimAlmacen(
    AlmacenKey    int         NOT NULL,
    Nombre        char(10)    NULL,
    Calle1        char(20)    NULL,
    Calle2        char(20)    NULL,
    Ciudad        char(20)    NULL,
    Provincia     char(2)     NULL,
    Zip           char(9)     NULL,
    CONSTRAINT PK8 PRIMARY KEY CLUSTERED (AlmacenKey)
)
go



IF OBJECT_ID('DimAlmacen') IS NOT NULL
    PRINT '<<< CREATED TABLE DimAlmacen >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimAlmacen >>>'
go

/* 
 * TABLE: DimCliente 
 */

CREATE TABLE DimCliente(
    ClienteKey          int             NOT NULL,
    Desde               datetime        NULL,
    Data                char(500)       NULL,
    Entregas            smallint        NULL,
    CantidadPagos       smallint        NULL,
    PagoHastaLaFecha    money           NULL,
    Credito             char(2)         NULL,
    CreditoLim          money           NULL,
    Balance             money           NULL,
    Calle1              char(20)        NULL,
    Calle2              char(20)        NULL,
    Ciudad              char(20)        NULL,
    Nombre              char(16)        NULL,
    Apellido            char(16)        NULL,
    FechaNacimiento     datetime        NULL,
    Sexo                nvarchar(1)     NULL,
    Email               nvarchar(50)    NULL,
    Movil               nvarchar(20)    NULL,
    Cp                  char(9)         NULL,
    Telefono            char(16)        NULL,
    Provincia           char(2)         NULL,
    Municipio           nvarchar(50)    NULL,
    CONSTRAINT PK5 PRIMARY KEY CLUSTERED (ClienteKey)
)
go



IF OBJECT_ID('DimCliente') IS NOT NULL
    PRINT '<<< CREATED TABLE DimCliente >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimCliente >>>'
go

/* 
 * TABLE: DimDistrito 
 */

CREATE TABLE DimDistrito(
    DistritoKey    tinyint     NOT NULL,
    Nombre         char(10)    NULL,
    Calle1         char(20)    NULL,
    Calle2         char(20)    NULL,
    Ciudad         char(20)    NULL,
    Provincia      char(2)     NULL,
    Zip            char(9)     NULL,
    CONSTRAINT PK14 PRIMARY KEY NONCLUSTERED (DistritoKey)
)
go



IF OBJECT_ID('DimDistrito') IS NOT NULL
    PRINT '<<< CREATED TABLE DimDistrito >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimDistrito >>>'
go

/* 
 * TABLE: DimProducto 
 */

CREATE TABLE DimProducto(
    ProductoKey    int           NOT NULL,
    Nombre         char(24)      NULL,
    Precio         smallmoney    NULL,
    Imagen_id      int           NULL,
    Descripcion    char(50)      NULL,
    CONSTRAINT PK6 PRIMARY KEY CLUSTERED (ProductoKey)
)
go



IF OBJECT_ID('DimProducto') IS NOT NULL
    PRINT '<<< CREATED TABLE DimProducto >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimProducto >>>'
go

/* 
 * TABLE: DimTiempo 
 */

CREATE TABLE DimTiempo(
    NombreMes              nvarchar(30)    NULL,
    NombreDiaDeLaSemana    nvarchar(30)    NULL,
    Dia                    tinyint         NULL,
    Mes                    tinyint         NULL,
    Cuatrimestre           tinyint         NULL,
    Anio                   char(4)         NULL,
    NumeroDiaDelAnio       smallint        NULL,
    NumeroSemanaDelAnio    tinyint         NULL,
    NumeroDiaDeLaSemana    tinyint         NULL,
    TiempoKey              date            NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY CLUSTERED (TiempoKey)
)
go



IF OBJECT_ID('DimTiempo') IS NOT NULL
    PRINT '<<< CREATED TABLE DimTiempo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimTiempo >>>'
go

/* 
 * TABLE: FactVentas 
 */

CREATE TABLE FactVentas(
    TiempoKey                  date        NOT NULL,
    ClienteKey                 int         NOT NULL,
    ProductoKey                int         NOT NULL,
    AlmacenKey                 int         NOT NULL,
    NumeroOrdenDeVenta         int         NOT NULL,
    NumeroLineaOrdenDeVenta    tinyint     NOT NULL,
    Cantidad                   smallint    NULL,
    PrecioUnitario             money       NULL,
    TotalCosto                 money       NULL,
    MontoVenta                 money       NULL,
    Impuesto                   money       NULL,
    DistritoKey                tinyint     NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY CLUSTERED (ClienteKey, ProductoKey, DistritoKey, TiempoKey, NumeroOrdenDeVenta, NumeroLineaOrdenDeVenta, AlmacenKey)
)
go



IF OBJECT_ID('FactVentas') IS NOT NULL
    PRINT '<<< CREATED TABLE FactVentas >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE FactVentas >>>'
go

/* 
 * TABLE: FactVentas 
 */

ALTER TABLE FactVentas ADD CONSTRAINT RefDimTiempo2 
    FOREIGN KEY (TiempoKey)
    REFERENCES DimTiempo(TiempoKey)
go

ALTER TABLE FactVentas ADD CONSTRAINT RefDimCliente3 
    FOREIGN KEY (ClienteKey)
    REFERENCES DimCliente(ClienteKey)
go

ALTER TABLE FactVentas ADD CONSTRAINT RefDimProducto4 
    FOREIGN KEY (ProductoKey)
    REFERENCES DimProducto(ProductoKey)
go

ALTER TABLE FactVentas ADD CONSTRAINT RefDimDistrito16 
    FOREIGN KEY (DistritoKey)
    REFERENCES DimDistrito(DistritoKey)
go

ALTER TABLE FactVentas ADD CONSTRAINT RefDimAlmacen17 
    FOREIGN KEY (AlmacenKey)
    REFERENCES DimAlmacen(AlmacenKey)
go


