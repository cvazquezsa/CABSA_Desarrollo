/********** CURPLetraValor ***********/
if not exists (select * from sysobjects WHERE id = object_id('dbo.CURPLetraValor') and type = 'U') 
CREATE TABLE CURPLetraValor (
        Letra char (1),  
        Valor int )
GO
DELETE CURPLetraValor
GO
INSERT CURPLetraValor(Letra,  Valor) VALUES('0',   0)
INSERT CURPLetraValor(Letra,  Valor) VALUES('1',   1)
INSERT CURPLetraValor(Letra,  Valor) VALUES('2',   2)
INSERT CURPLetraValor(Letra,  Valor) VALUES('3',   3)
INSERT CURPLetraValor(Letra,  Valor) VALUES('4',   4)
INSERT CURPLetraValor(Letra,  Valor) VALUES('5',   5)
INSERT CURPLetraValor(Letra,  Valor) VALUES('6',   6)
INSERT CURPLetraValor(Letra,  Valor) VALUES('7',   7)
INSERT CURPLetraValor(Letra,  Valor) VALUES('8',   8)
INSERT CURPLetraValor(Letra,  Valor) VALUES('9',   9)
INSERT CURPLetraValor(Letra,  Valor) VALUES('A',  10)
INSERT CURPLetraValor(Letra,  Valor) VALUES('B',  11)
INSERT CURPLetraValor(Letra,  Valor) VALUES('C',  12)
INSERT CURPLetraValor(Letra,  Valor) VALUES('D',  13)
INSERT CURPLetraValor(Letra,  Valor) VALUES('E',  14)
INSERT CURPLetraValor(Letra,  Valor) VALUES('F',  15)
INSERT CURPLetraValor(Letra,  Valor) VALUES('G',  16)
INSERT CURPLetraValor(Letra,  Valor) VALUES('H',  17)
INSERT CURPLetraValor(Letra,  Valor) VALUES('I',  18)
INSERT CURPLetraValor(Letra,  Valor) VALUES('J',  19)
INSERT CURPLetraValor(Letra,  Valor) VALUES('K',  20)
INSERT CURPLetraValor(Letra,  Valor) VALUES('L',  21)
INSERT CURPLetraValor(Letra,  Valor) VALUES('M',  22)
INSERT CURPLetraValor(Letra,  Valor) VALUES('N',  23)
INSERT CURPLetraValor(Letra,  Valor) VALUES('Ñ',  24)
INSERT CURPLetraValor(Letra,  Valor) VALUES('O',  25)
INSERT CURPLetraValor(Letra,  Valor) VALUES('P',  26)
INSERT CURPLetraValor(Letra,  Valor) VALUES('Q',  27)
INSERT CURPLetraValor(Letra,  Valor) VALUES('R',  28)
INSERT CURPLetraValor(Letra,  Valor) VALUES('S',  29)
INSERT CURPLetraValor(Letra,  Valor) VALUES('T',  30)
INSERT CURPLetraValor(Letra,  Valor) VALUES('U',  31)
INSERT CURPLetraValor(Letra,  Valor) VALUES('V',  32)
INSERT CURPLetraValor(Letra,  Valor) VALUES('W',  33)
INSERT CURPLetraValor(Letra,  Valor) VALUES('X',  34)
INSERT CURPLetraValor(Letra,  Valor) VALUES('Y',  35)
INSERT CURPLetraValor(Letra,  Valor) VALUES('Z',  36)
GO


/********** PaisEstado ***********/
GO
if (select version from version)<=2771
begin
  UPDATE PaisEstado SET ClaveCurp = 'AS' WHERE Estado='AGUASCALIENTES' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'AGUASCALIENTES',   'AS')

  UPDATE PaisEstado SET ClaveCurp = 'MS' WHERE Estado='MORELOS' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'MORELOS', 'MS')

  UPDATE PaisEstado SET ClaveCurp = 'BC' WHERE Estado='BAJA CALIFORNIA NORTE' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'BAJA CALIFORNIA NORTE', 'BC')

  UPDATE PaisEstado SET ClaveCurp = 'NT' WHERE Estado='NAYARIT' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'NAYARIT', 'NT')

  UPDATE PaisEstado SET ClaveCurp = 'BS' WHERE Estado='BAJA CALIFORNIA SUR' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'BAJA CALIFORNIA SUR', 'BS')

  UPDATE PaisEstado SET ClaveCurp = 'NL' WHERE Estado='NUEVO LEON' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'NUEVO LEON', 'NL')

  UPDATE PaisEstado SET ClaveCurp = 'CC' WHERE Estado='CAMPECHE' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'CAMPECHE', 'CC')

  UPDATE PaisEstado SET ClaveCurp = 'OC' WHERE Estado='OAXACA' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'OAXACA', 'OC')

  UPDATE PaisEstado SET ClaveCurp = 'CS' WHERE Estado='CHIAPAS' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'CHIAPAS', 'CS')

  UPDATE PaisEstado SET ClaveCurp = 'PL' WHERE Estado='PUEBLA' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'PUEBLA', 'PL')

  UPDATE PaisEstado SET ClaveCurp = 'CH' WHERE Estado='CHIHUAHUA' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'CHIHUAHUA', 'CH')

  UPDATE PaisEstado SET ClaveCurp = 'QT' WHERE Estado='QUERETARO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'QUERETARO', 'QT')

  UPDATE PaisEstado SET ClaveCurp = 'CL' WHERE Estado='COAHUILA' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'COAHUILA', 'CL')

  UPDATE PaisEstado SET ClaveCurp = 'QR' WHERE Estado='QUINTANA ROO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'QUINTANA ROO', 'QR')

  UPDATE PaisEstado SET ClaveCurp = 'CM' WHERE Estado='COLIMA' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'COLIMA', 'CM')

  UPDATE PaisEstado SET ClaveCurp = 'SP' WHERE Estado='SAN LUIS POTOSI' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'SAN LUIS POTOSI', 'SP')

  UPDATE PaisEstado SET ClaveCurp = 'DF' WHERE Estado='DISTRITO FEDERAL' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'DISTRITO FEDERAL', 'DF')

  UPDATE PaisEstado SET ClaveCurp = 'SL' WHERE Estado='SINALOA' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'SINALOA', 'SL')

  UPDATE PaisEstado SET ClaveCurp = 'DG' WHERE Estado='DURANGO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'DURANGO', 'DG')

  UPDATE PaisEstado SET ClaveCurp = 'SR' WHERE Estado='SONORA' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'SONORA', 'SR')

  UPDATE PaisEstado SET ClaveCurp = 'GT' WHERE Estado='GUANAJUATO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'GUANAJUATO', 'GT')

  UPDATE PaisEstado SET ClaveCurp = 'TC' WHERE Estado='TABASCO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'TABASCO', 'TC')

  UPDATE PaisEstado SET ClaveCurp = 'GR' WHERE Estado='GUERRERO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'GUERRERO', 'GR')

  UPDATE PaisEstado SET ClaveCurp = 'TS' WHERE Estado='TAMAULIPAS' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'TAMAULIPAS', 'TS')

  UPDATE PaisEstado SET ClaveCurp = 'HG' WHERE Estado='HIDALGO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'HIDALGO', 'HG')

  UPDATE PaisEstado SET ClaveCurp = 'TL' WHERE Estado='TLAXCALA' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'TLAXCALA', 'TL')

  UPDATE PaisEstado SET ClaveCurp = 'JC' WHERE Estado='JALISCO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'JALISCO', 'JC')

  UPDATE PaisEstado SET ClaveCurp = 'VZ' WHERE Estado='VERACRUZ' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'VERACRUZ', 'VZ')

  UPDATE PaisEstado SET ClaveCurp = 'MC' WHERE Estado='ESTADO DE MEXICO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'ESTADO DE MEXICO', 'MC')

  UPDATE PaisEstado SET ClaveCurp = 'MC' WHERE Estado='MEXICO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'MEXICO', 'MC')

  UPDATE PaisEstado SET ClaveCurp = 'YN' WHERE Estado='YUCATAN' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'YUCATAN', 'YN')

  UPDATE PaisEstado SET ClaveCurp = 'MN' WHERE Estado='MICHOACAN' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'MICHOACAN', 'MN')

  UPDATE PaisEstado SET ClaveCurp = 'ZS' WHERE Estado='ZACATECAS' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'ZACATECAS', 'ZS')

  UPDATE PaisEstado SET ClaveCurp = 'NE' WHERE Estado='EXTRANJERO' 
  IF @@ROWCOUNT =0 INSERT PaisEstado(Pais, Estado,  ClaveCURP) VALUES('Mexico', 'EXTRANJERO', 'NE')
end
GO

/********** RFCAnexoI ***********/
if not exists (select * from sysobjects WHERE id = object_id('dbo.RFCAnexoI') and type = 'U') 
CREATE TABLE RFCAnexoI (
        Letra char (1),  
        Valor char(2) )
GO
DELETE RFCAnexoI
GO
INSERT RFCAnexoI(Letra,  Valor) VALUES(' ', '00')
INSERT RFCAnexoI(Letra,  Valor) VALUES('0', '00')
INSERT RFCAnexoI(Letra,  Valor) VALUES('1', '01')
INSERT RFCAnexoI(Letra,  Valor) VALUES('2', '02')
INSERT RFCAnexoI(Letra,  Valor) VALUES('3', '03')
INSERT RFCAnexoI(Letra,  Valor) VALUES('4', '04')
INSERT RFCAnexoI(Letra,  Valor) VALUES('5', '05')
INSERT RFCAnexoI(Letra,  Valor) VALUES('6', '06')
INSERT RFCAnexoI(Letra,  Valor) VALUES('7', '07')
INSERT RFCAnexoI(Letra,  Valor) VALUES('8', '08')
INSERT RFCAnexoI(Letra,  Valor) VALUES('9', '09')
INSERT RFCAnexoI(Letra,  Valor) VALUES('&', '10')
INSERT RFCAnexoI(Letra,  Valor) VALUES('A', '11')
INSERT RFCAnexoI(Letra,  Valor) VALUES('B', '12')
INSERT RFCAnexoI(Letra,  Valor) VALUES('C', '13')
INSERT RFCAnexoI(Letra,  Valor) VALUES('D', '14')
INSERT RFCAnexoI(Letra,  Valor) VALUES('E', '15')
INSERT RFCAnexoI(Letra,  Valor) VALUES('F', '16')
INSERT RFCAnexoI(Letra,  Valor) VALUES('G', '17')
INSERT RFCAnexoI(Letra,  Valor) VALUES('H', '18')
INSERT RFCAnexoI(Letra,  Valor) VALUES('I', '19')
INSERT RFCAnexoI(Letra,  Valor) VALUES('J', '21')
INSERT RFCAnexoI(Letra,  Valor) VALUES('K', '22')
INSERT RFCAnexoI(Letra,  Valor) VALUES('L', '23')
INSERT RFCAnexoI(Letra,  Valor) VALUES('M', '24')
INSERT RFCAnexoI(Letra,  Valor) VALUES('N', '25')
INSERT RFCAnexoI(Letra,  Valor) VALUES('O', '26')
INSERT RFCAnexoI(Letra,  Valor) VALUES('P', '27')
INSERT RFCAnexoI(Letra,  Valor) VALUES('Q', '28')
INSERT RFCAnexoI(Letra,  Valor) VALUES('R', '29')
INSERT RFCAnexoI(Letra,  Valor) VALUES('S', '32')
INSERT RFCAnexoI(Letra,  Valor) VALUES('T', '33')
INSERT RFCAnexoI(Letra,  Valor) VALUES('U', '34')
INSERT RFCAnexoI(Letra,  Valor) VALUES('V', '35')
INSERT RFCAnexoI(Letra,  Valor) VALUES('W', '36')
INSERT RFCAnexoI(Letra,  Valor) VALUES('X', '37')
INSERT RFCAnexoI(Letra,  Valor) VALUES('Y', '38')
INSERT RFCAnexoI(Letra,  Valor) VALUES('Z', '39')
INSERT RFCAnexoI(Letra,  Valor) VALUES('Ñ', '40')
GO
/********** RFCAnexoII ***********/

if not exists (select * from sysobjects WHERE id = object_id('dbo.RFCAnexoII') and type = 'U') 
CREATE TABLE RFCAnexoII (
        Numero int,  
        Valor  char(1) )
GO
DELETE RFCAnexoII
GO

INSERT RFCAnexoII(Numero,  Valor) VALUES( 0, '1')
INSERT RFCAnexoII(Numero,  Valor) VALUES( 1, '2')
INSERT RFCAnexoII(Numero,  Valor) VALUES( 2, '3')
INSERT RFCAnexoII(Numero,  Valor) VALUES( 3, '4')
INSERT RFCAnexoII(Numero,  Valor) VALUES( 4, '5')
INSERT RFCAnexoII(Numero,  Valor) VALUES( 5, '6')
INSERT RFCAnexoII(Numero,  Valor) VALUES( 6, '7')
INSERT RFCAnexoII(Numero,  Valor) VALUES( 7, '8')
INSERT RFCAnexoII(Numero,  Valor) VALUES( 8, '9')
INSERT RFCAnexoII(Numero,  Valor) VALUES( 9, 'A')
INSERT RFCAnexoII(Numero,  Valor) VALUES(10, 'B')
INSERT RFCAnexoII(Numero,  Valor) VALUES(11, 'C')
INSERT RFCAnexoII(Numero,  Valor) VALUES(12, 'D')
INSERT RFCAnexoII(Numero,  Valor) VALUES(13, 'E')
INSERT RFCAnexoII(Numero,  Valor) VALUES(14, 'F')
INSERT RFCAnexoII(Numero,  Valor) VALUES(15, 'G')
INSERT RFCAnexoII(Numero,  Valor) VALUES(16, 'H')
INSERT RFCAnexoII(Numero,  Valor) VALUES(17, 'I')
INSERT RFCAnexoII(Numero,  Valor) VALUES(18, 'J')
INSERT RFCAnexoII(Numero,  Valor) VALUES(19, 'K')
INSERT RFCAnexoII(Numero,  Valor) VALUES(20, 'L')
INSERT RFCAnexoII(Numero,  Valor) VALUES(21, 'M')
INSERT RFCAnexoII(Numero,  Valor) VALUES(22, 'N')
INSERT RFCAnexoII(Numero,  Valor) VALUES(23, 'P')
INSERT RFCAnexoII(Numero,  Valor) VALUES(24, 'Q')
INSERT RFCAnexoII(Numero,  Valor) VALUES(25, 'R')
INSERT RFCAnexoII(Numero,  Valor) VALUES(26, 'S')
INSERT RFCAnexoII(Numero,  Valor) VALUES(27, 'T')
INSERT RFCAnexoII(Numero,  Valor) VALUES(28, 'U')
INSERT RFCAnexoII(Numero,  Valor) VALUES(29, 'V')
INSERT RFCAnexoII(Numero,  Valor) VALUES(30, 'W')
INSERT RFCAnexoII(Numero,  Valor) VALUES(31, 'X')
INSERT RFCAnexoII(Numero,  Valor) VALUES(32, 'Y')
INSERT RFCAnexoII(Numero,  Valor) VALUES(33, 'Z')
GO


/********** RFCAnexoIII ***********/

if not exists (select * from sysobjects WHERE id = object_id('dbo.RFCAnexoIII') and type = 'U') 
CREATE TABLE RFCAnexoIII (
        Letra char (1),  
        Valor char(2) )
GO
DELETE RFCAnexoIII
GO
INSERT RFCAnexoIII(Letra,  Valor) VALUES('0', '00')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('1', '01')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('2', '02')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('3', '03')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('4', '04')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('5', '05')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('6', '06')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('7', '07')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('8', '08')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('9', '09')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('A', '10')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('B', '11')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('C', '12')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('D', '13')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('E', '14')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('F', '15')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('G', '16')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('H', '17')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('I', '18')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('J', '19')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('K', '20')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('L', '21')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('M', '22')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('N', '23')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('&', '24')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('O', '25')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('P', '26')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('Q', '27')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('R', '28')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('S', '29')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('T', '30')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('U', '31')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('V', '32')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('W', '33')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('X', '34')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('Y', '35')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('Z', '36')
INSERT RFCAnexoIII(Letra,  Valor) VALUES(' ', '37')
INSERT RFCAnexoIII(Letra,  Valor) VALUES('Ñ', '38')
go

/********** RFCAnexoIV ***********/


if not exists (select * from sysobjects WHERE id = object_id('dbo.RFCAnexoIV') and type = 'U') 
CREATE TABLE RFCAnexoIV (
        Palabra Varchar (4) )
GO
DELETE RFCAnexoIV
GO
INSERT RFCAnexoIV(Palabra ) Values ('BUEI')
INSERT RFCAnexoIV(Palabra ) Values ('CACA')
INSERT RFCAnexoIV(Palabra ) Values ('CAGA')
INSERT RFCAnexoIV(Palabra ) Values ('CAKA')
INSERT RFCAnexoIV(Palabra ) Values ('COGE')
INSERT RFCAnexoIV(Palabra ) Values ('COJE')
INSERT RFCAnexoIV(Palabra ) Values ('COJO')
INSERT RFCAnexoIV(Palabra ) Values ('FETO')
INSERT RFCAnexoIV(Palabra ) Values ('JOTO')
INSERT RFCAnexoIV(Palabra ) Values ('KACO')
INSERT RFCAnexoIV(Palabra ) Values ('KAGO')
INSERT RFCAnexoIV(Palabra ) Values ('KOJO')
INSERT RFCAnexoIV(Palabra ) Values ('KULO')
INSERT RFCAnexoIV(Palabra ) Values ('MAMO')
INSERT RFCAnexoIV(Palabra ) Values ('MEAS')
INSERT RFCAnexoIV(Palabra ) Values ('MION')
INSERT RFCAnexoIV(Palabra ) Values ('MULA')
INSERT RFCAnexoIV(Palabra ) Values ('PEDO')
INSERT RFCAnexoIV(Palabra ) Values ('PUTA')
INSERT RFCAnexoIV(Palabra ) Values ('QULO')
INSERT RFCAnexoIV(Palabra ) Values ('RUIN')
INSERT RFCAnexoIV(Palabra ) Values ('BUEY')
INSERT RFCAnexoIV(Palabra ) Values ('CACO')
INSERT RFCAnexoIV(Palabra ) Values ('CAGO')
INSERT RFCAnexoIV(Palabra ) Values ('CAKO')
INSERT RFCAnexoIV(Palabra ) Values ('COJA')
INSERT RFCAnexoIV(Palabra ) Values ('COJI')
INSERT RFCAnexoIV(Palabra ) Values ('CULO')
INSERT RFCAnexoIV(Palabra ) Values ('GUEY')
INSERT RFCAnexoIV(Palabra ) Values ('KACA')
INSERT RFCAnexoIV(Palabra ) Values ('KAGA')
INSERT RFCAnexoIV(Palabra ) Values ('KOGE')
INSERT RFCAnexoIV(Palabra ) Values ('KAKA')
INSERT RFCAnexoIV(Palabra ) Values ('MAME')
INSERT RFCAnexoIV(Palabra ) Values ('MEAR')
INSERT RFCAnexoIV(Palabra ) Values ('MEON')
INSERT RFCAnexoIV(Palabra ) Values ('MOCO')
INSERT RFCAnexoIV(Palabra ) Values ('PEDA')
INSERT RFCAnexoIV(Palabra ) Values ('PENE')
INSERT RFCAnexoIV(Palabra ) Values ('PUTO')
INSERT RFCAnexoIV(Palabra ) Values ('RATA')
GO


/********** spQuitaPreposicionesArticulos ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spQuitaPreposicionesArticulos' and type = 'P') DROP PROCEDURE spQuitaPreposicionesArticulos
go
CREATE PROCEDURE spQuitaPreposicionesArticulos  @Texto             varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN

  DECLARE @Palabra varchar(255),  @Texto2 varchar(255)  
  SELECT @Texto2='', @Palabra=''
  EXEC spExtraerDato @Texto OUTPUT,  @Palabra OUTPUT , ' '
  WHILE Len(@Palabra)>0
  BEGIN
  IF @Palabra NOT IN('a',  'ante',  'bajo',  'cabe',  'con',  'contra',  'de',  'desde',  'en',  'entre',  'hacia',  'hasta',  
                     'para',  'por',  'segun',  'sin',  'so',  'sobre',  'tras',   'el',  'la',  'los',  'la',  'al',  'del',         
                     'Y', 'un', 'uno',  'unos',  'una',  'unas',  'u',  'e',  'que', 'sino','Van', 'Von', 'Der', 'Mc')
    SELECT @Texto2= @Texto2 + @Palabra + ' '

  EXEC spExtraerDato @Texto OUTPUT,  @Palabra OUTPUT , ' '
  END
  SELECT @Texto = RTRIM(LTRIM(@Texto2))
END
GO
/*
Declare @text varchar(100) select @Text='Ana Lorena de la O'  EXEC spQuitaPreposicionesArticulos @Text OUTPUT Select @text
*/


/********** spRFCClaveHomonima ***********/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spRFCClaveHomonima' and type = 'P') DROP PROCEDURE spRFCClaveHomonima
go
CREATE PROCEDURE spRFCClaveHomonima
                                   @NombreCompleto             varchar(255), 
                                   @Palabra                    varchar(2) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Linea varchar(100), 
          @C     int, 
          @Total int

  SELECT @C = 1,  @Linea = '0',  @Total = 0, @Palabra = ''
  WHILE @C <= LEN(@NombreCompleto)
  BEGIN
    SELECT @Linea= @Linea +( Select Valor from RFCAnexoI WHERE ASCII(Letra) = ASCII(SUBSTRING(@NombreCompleto,  @c,  1)))
    SELECT @C = @C + 1 
  END 
  SELECT @C = 1,  @Linea = LTRIM(RTRIM(@Linea))
  WHILE @C < LEN(@Linea)
  BEGIN
    SELECT @Total = @Total + CONVERT(int,  SUBSTRING(@Linea,  @C,  2))  *  CONVERT(int,  RIGHT(SUBSTRING(@Linea,  @C , 2),  1))
    SELECT @C = @C + 1 
  END 

  SELECT @Palabra = Valor FROM RFCAnexoII WHERE Numero = CONVERT(int,  RIGHT(RTRIM(CONVERT(VARCHAR,  @Total)),  3)) / 34
  SELECT @Palabra = @Palabra + Valor FROM RFCAnexoII WHERE Numero = CONVERT(int,  RIGHT(RTRIM(CONVERT(VARCHAR,  @Total)),  3)) % 34
END
GO


/********** spCURPDigitoVerificador ************/
IF EXISTS(SELECT * FROM sysobjects  WHERE name = 'spCURPDigitoVerificador' and type = 'P')   DROP PROCEDURE spCURPDigitoVerificador
GO
CREATE PROCEDURE spCURPDigitoVerificador
                                   @CURP            varchar(20), 
                                   @Digito         char(2) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Linea varchar(100), 
    @C     int, 
    @Total int
  SELECT @CURP=UPPER(@CURP)
  SELECT @C = 1,  @Linea = '',  @Total = 0

  IF LEN(@CURP) >= 17 SELECT @CURP = LEFT(@CURP, 17)-- para quitarle el digito

  WHILE @C <= LEN(@CURP)
  BEGIN
    SELECT @Total = @Total +( SELECT Valor * (18 -(@C -1)) FROM CURPLetraValor WHERE ASCII(Letra) = ASCII(SUBSTRING(@CURP,  @C,  1)))
    SELECT @C = @C + 1 
  END

  SELECT @Total = @Total % 10

  IF @Total=0 
    SELECT @Digito='0'
  ELSE
    SELECT @Digito =  CONVERT(varchar, (10 - @Total) )

  SELECT @Digito = RIGHT(RTRIM(@Digito), 1) 
END
GO

/********** spRFCDigitoVerificador ************/
IF EXISTS(SELECT * FROM sysobjects  WHERE name = 'spRFCDigitoVerificador' and type = 'P')   DROP PROCEDURE spRFCDigitoVerificador
GO
CREATE PROCEDURE spRFCDigitoVerificador
                                   @RFC            varchar(20), 
                                   @Digito         char(2) OUTPUT
--//WITH ENCRYPTION
AS BEGIN

  DECLARE 
    @Linea varchar(100), 
    @C     int, 
    @Total int

  SELECT @C = 1, @Linea = '', @Total = 0

  IF LEN(@RFC) = 13 SELECT @RFC = LEFT(@RFC, 12) -- para quitarle el digito

  WHILE @C <= LEN(@RFC)
  BEGIN
    SELECT @Total = @Total +( SELECT  Valor * (13 -(@C -1)) FROM RFCAnexoIII WHERE ASCII(Letra) = ASCII(SUBSTRING(@RFC,  @C,  1)))
    SELECT @C = @C + 1 
  END

  SELECT @Total = @Total % 11

  IF @Total = 0 
    SELECT @Digito = '0' 
  ELSE BEGIN
    SELECT @Digito =  Convert(varchar, (11 - @Total) )
    IF @Digito = '10'  
      SELECT @Digito = 'A'
  END
  SELECT @Digito = RIGHT(RTRIM(@Digito) ,1)   
END
GO

---  DECLARE @PALABRA varchar(10) EXEC spRFCDigitoVerificador 'SESD691213GV',  @Palabra OUTPUT SELECT @PALABRA
---  DECLARE @PALABRA varchar(10) EXEC spRFCDigitoVerificador 'aca8812032N',  @Palabra OUTPUT SELECT @PALABRA  
---  DECLARE @PALABRA varchar(10) EXEC spRFCDigitoVerificador 'AAPR63032122',  @Palabra OUTPUT SELECT @PALABRA 

/********** spRegistroSugerir ************/

IF EXISTS(SELECT * FROM sysobjects  WHERE name = 'spRegistroSugerir' and type = 'P')   DROP PROCEDURE spRegistroSugerir
go
CREATE PROCEDURE spRegistroSugerir
                                   @Cual             varchar(20), 
                                   @Registro         varchar(20), 
                                   @Nombre           varchar(50), 
                                   @Paterno          varchar(50), 
                                   @Materno          varchar(50), 
                                   @Nacimiento       datetime,  
                                   @Sexo             varchar(50) = NULL,    
                                   @Estado varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
  
  DECLARE @A  int, 
          @UnNombre varchar(50),  
          @Palabra varchar(50), 
          @NombreCompleto  varchar(255), 
          @CPaterno        char(1), 
          @CMaterno        char(1), 
          @CNombre         char(1)

  SELECT @CPaterno = '',  @CMaterno ='',   @CNombre = ''
  SELECT @Registro         = UPPER(NULLIF(NULLIF(RTRIM(@Registro),  '0'),  ''))
  SELECT @Paterno          = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(UPPER(NULLIF(NULLIF(RTRIM(@Paterno),   '0'),  '')), 'Á', 'A'), 'É','E'), 'Í', 'I'), 'Ó', 'O'), 'Ú','U'), 'Ñ','X')
  SELECT @Materno          = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(UPPER(NULLIF(NULLIF(RTRIM(@Materno),   '0'),  '')), 'Á', 'A'), 'É','E'), 'Í', 'I'), 'Ó', 'O'), 'Ú','U'), 'Ñ','X')
  SELECT @Nombre           = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(UPPER(NULLIF(NULLIF(RTRIM(@Nombre),    '0'),  '')), 'Á', 'A'), 'É','E'), 'Í', 'I'), 'Ó', 'O'), 'Ú','U')  
  SELECT @Sexo             = UPPER(NULLIF(NULLIF(RTRIM(@Sexo),    '0'),  ''))
  SELECT @Estado           = UPPER(NULLIF(NULLIF(RTRIM(@Estado),    '0'),  ''))
  SELECT @NombreCompleto = LTRIM(RTRIM(@Nombre + ' ' + @Paterno + ' ' + @Materno))
  EXEC spQuitaPreposicionesArticulos @Paterno OUTPUT
  EXEC spQuitaPreposicionesArticulos @Materno OUTPUT
  EXEC spQuitaPreposicionesArticulos @Nombre  OUTPUT

  IF (@Cual='RFC' OR @Cual = 'CURP')  AND  @Nacimiento > '01-01-1910'
  BEGIN
    IF CHARINDEX(' ', @Nombre) > 0 -- tiene mas de un nombre se aplica regla 6
    BEGIN
      SELECT  @UnNombre = @Nombre
      EXEC SPExtraerDato @UnNombre OUTPUT,  @Palabra OUTPUT,  ' '
      IF @Palabra NOT IN('JOSE',  'MARIA') 
         SELECT @Nombre = @Palabra 
      ELSE  BEGIN
         EXEC SPExtraerDato @UnNombre OUTPUT,  @Palabra OUTPUT,  ' '
         SELECT @Nombre = @Palabra 
      END
    END
    IF LEN(@Paterno) = 0 OR LEN(@Materno) = 0 -- Si tiene solo un apellido aplica la regla 7
      SELECT @Registro = SUBSTRING(@Paterno,  1,  2) +  SUBSTRING(@Materno,  1,  2) +  SUBSTRING(@Nombre,   1,  2) 
                         + RIGHT(LTRIM(RTRIM( YEAR(@Nacimiento))) , 2) +  RIGHT('0' + LTRIM(MONTH(@Nacimiento))  , 2) 
                         + RIGHT('0' + LTRIM(  DAY(@Nacimiento))  , 2)
    ELSE BEGIN
      IF LEN(@Paterno) < 3 -- si tiene una o dos letras el paterno se aplica la regla 4
        SELECT @Registro = SUBSTRING(@Paterno,  1,  1) + SUBSTRING(@Materno,  1,  1) + SUBSTRING(@Nombre,   1,  2)
                           + RIGHT(LTRIM(RTRIM(YEAR(@Nacimiento))) , 2) + RIGHT('0' + LTRIM(MONTH(@Nacimiento)) , 2)
                           + RIGHT('0' + LTRIM(DAY(@Nacimiento)) , 2)
      ELSE
        IF  LEN(ISNULL(@Nombre, '')) > 0  AND LEN(ISNULL(@Registro, '')) < 10 
        BEGIN
          SELECT @A=2
          
          WHILE (SUBSTRING(@Paterno, @A, 1) not in('A', 'E', 'I', 'O', 'U')  AND @A < LEN(ISNULL(@Paterno, ''))+1)   
            SELECT @A=@A+1      
          SELECT @REGISTRO =    SUBSTRING(LTRIM(@Paterno), 1, 1)
                             +  SUBSTRING(LTRIM(@Paterno), @A, 1) 
                             +  SUBSTRING(LTRIM(@Materno), 1, 1) 
                             +  SUBSTRING(LTRIM(@Nombre), 1, 1) 
                             +  RIGHT(LTRIM(RTRIM(YEAR(@Nacimiento))), 2)
                             +  RIGHT('0' + LTRIM(MONTH(@Nacimiento)), 2)
                             +  RIGHT('0' + LTRIM(DAY(@Nacimiento)), 2)
        END
    END 
  END    

  IF EXISTS( SELECT * FROM RFCAnexoIV WHERE Palabra = SUBSTRING(@Registro,  1,  4))
    SELECT @Registro = SUBSTRING(@Registro,  1,  3) + 'X' + SUBSTRING(@Registro, 5,  99) 

  IF @Cual = 'RFC' AND LEN(@registro) <=10 -- Si ya tenia algo lo dejo como esta
  BEGIN    
    SELECT @Palabra = ''
    SELECT @Registro = LEFT(@Registro, 10)
    EXEC spRFCClaveHomonima @NombreCompleto,  @Palabra OUTPUT    
    SELECT @Registro = @Registro + @Palabra
    EXEC spRFCDigitoVerificador @Registro,  @Palabra OUTPUT    
    SELECT @Registro = @Registro + @Palabra
  END

  IF @Cual = 'CURP' AND LEN(@Registro) <= 10 -- Si ya tenia algo lo dejo como esta
  BEGIN
    IF @Sexo = 'Masculino' SELECT @Registro = @Registro + 'H' ELSE SELECT @Registro = @Registro + 'M'
    SELECT @Registro = @Registro + (SELECT MIN(ISNULL(ClaveCURP,'')) FROM PaisEstado WHERE Estado LIKE ('%' + @Estado + '%'))
    SELECT @A = 2
    WHILE @A <= LEN(@Paterno) AND @CPaterno =''
    BEGIN
      IF SUBSTRING(@Paterno, @A, 1) not in('A',  'E',  'I',  'O',  'U')  SELECT @CPaterno = REPLACE(SUBSTRING(@Paterno, @A, 1), 'Ñ','X')
      SELECT @A = @A + 1
    END
    SELECT @A = 2
    WHILE @A <= LEN(@Materno)AND @CMaterno =''
    BEGIN
      IF SUBSTRING(@Materno, @A, 1) not in('A', 'E', 'I', 'O', 'U') SELECT @CMaterno = REPLACE(SUBSTRING(@Materno,  @A,  1), 'Ñ','X')
      SELECT @A = @A + 1
    END
    SELECT @A = 2
    WHILE @A <= LEN(@Nombre) AND @CNombre=''
    BEGIN
      IF SUBSTRING(@Nombre, @A, 1) not in('A', 'E', 'I', 'O', 'U')  SELECT @CNombre = REPLACE(SUBSTRING(@Nombre,  @A,  1), 'Ñ','X')
      SELECT @A = @A + 1
    END
    IF @CPaterno = '' SELECT @CPaterno = 'X'
    IF @CMaterno = '' SELECT @CMaterno = 'X'
    IF @CNombre  = '' SELECT @CNombre  = 'X'

 
    SELECT @Registro = @Registro + @CPaterno + @CMaterno + @CNombre + '0'
    SELECT @Palabra  = ''
    EXEC spCURPDigitoVerificador @Registro,  @Palabra OUTPUT    
    SELECT @Registro = @Registro + @Palabra
  END
  
  SELECT "Registro" = @Registro
  RETURN
END
GO

/********** RFCValidos ************/
IF not exists(SELECT  * FROM SysTabla WHERE SysTabla = 'RFCValidos')   --drop table RFCValidos
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('RFCValidos', 'Maestro')
IF not exists (SELECT * FROM sysobjects WHERE type = 'u' AND id =object_id('dbo.RFCValidos')) -- DROP TABLE RFCValidos
  CREATE TABLE RFCValidos(
    ID		int identity(1,1),
    Valor	varchar(20),
    Tipo	varchar(10),
  CONSTRAINT priRFCValidos PRIMARY KEY(Valor,Tipo))
GO

/********** spRegistroOk ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spRegistroOk' and type = 'P') DROP PROCEDURE spRegistroOk
GO
CREATE PROCEDURE spRegistroOk
                       @Cual            varchar(20), 
                       @Registro        varchar(20), 
              	       @Empresa		char(5) = NULL,
		               @EnSilencio	bit	= 0,
            		   @Ok		bit 	= 1	OUTPUT  -- 1= esta bien  0= esta mal
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Largo                     int, 
    @Digito                    varchar(1)
  
  IF (SELECT ValidarRegistros FROM EmpresaGral WHERE Empresa = @Empresa) = 0  
    IF @EnSilencio = 0 
    BEGIN
      SELECT "Ok" = @Ok
      RETURN
    END

  SELECT @Ok = 1
  SELECT @Registro = NULLIF(NULLIF(RTRIM(@Registro),  '0'),  '')
  IF @Cual='RFC' AND LEN(ISNULL(@REGISTRO, '')) > 0
  BEGIN
    SELECT @Largo=LEN(ISNULL(@Registro, ''))
    IF (@Largo < 9 AND @Largo <>0) SELECT @Ok=0   
    IF @Largo=10 OR @Largo=13                 --para rfc de personas fisicas
    BEGIN
	  IF dbo.fnEsNumerico(SUBSTRING(@Registro, 7, 2)) < 1 or dbo.fnEsNumerico(SUBSTRING(@Registro, 7, 2)) > 12 SELECT @OK=0
      IF dbo.fnEsNumerico(SUBSTRING(@Registro, 9, 2)) < 1 or dbo.fnEsNumerico(SUBSTRING(@Registro, 9, 2)) > 31 SELECT @OK=0   
      IF dbo.fnEsNumerico(SUBSTRING(@Registro, 1, 1))<>0 OR dbo.fnEsNumerico(SUBSTRING(@Registro, 2, 1))<>0 OR 
         dbo.fnEsNumerico(SUBSTRING(@Registro, 3, 1))<>0 OR dbo.fnEsNumerico(SUBSTRING(@Registro, 4, 1))<>0 OR 
         dbo.fnEsNumerico(SUBSTRING(@Registro, 5, 6))<>1 SELECT @OK=0     
      IF @LARGO = 13
      BEGIN
        EXEC spRFCDigitoVerificador @Registro,  @Digito OUTPUT          
          
        IF RIGHT(RTRIM(@REGISTRO), 1) <> @Digito 
        BEGIN
--Valida RFC
          IF NOT EXISTS(SELECT Valor FROM RFCValidos WHERE Valor = @Registro AND Tipo = @Cual)
            SELECT @OK=0 
        END
      END
    END ELSE IF @Largo=9 OR @Largo=12         --para rfc de personas Morales(Empresas)
    BEGIN
	  IF dbo.fnEsNumerico(SUBSTRING(@Registro, 6, 2)) < 1 OR dbo.fnEsNumerico(SUBSTRING(@Registro, 6, 2)) > 12 SELECT @OK=0
      IF dbo.fnEsNumerico(SUBSTRING(@Registro, 8, 2)) < 1 OR dbo.fnEsNumerico(SUBSTRING(@Registro, 8, 2)) > 31 SELECT @OK=0      
      IF dbo.fnEsNumerico(SUBSTRING(@Registro, 1, 1))<>0 OR dbo.fnEsNumerico(SUBSTRING(@Registro, 2, 1))<>0 OR    
         dbo.fnEsNumerico(SUBSTRING(@Registro, 3, 1))<>0 OR dbo.fnEsNumerico(SUBSTRING(@Registro, 4, 6))<>1 SELECT @OK=0    
    END ELSE SELECT @OK=0
  END  ELSE
  IF @Cual='IMSS' AND LEN(ISNULL(@REGISTRO, ''))>0
  BEGIN
    EXEC spNominaVerDigitoIMSS @Registro, @Digito OUTPUT
    IF @Digito=SUBSTRING(RTRIM(@Registro), 11, 1) AND LEN(RTRIM(LTRIM(ISNULL(@Registro, ''))))=11
      SELECT  @OK=1
    ELSE
    BEGIN
--Valida IMSS
      IF NOT EXISTS(SELECT Valor FROM RFCValidos WHERE Valor = @Registro AND Tipo = @Cual)
        SELECT @OK=0 
    END
  END
  
  IF @Cual='CURP' AND LEN(ISNULL(@REGISTRO, ''))>0
  BEGIN
    EXEC spCURPDigitoVerificador @Registro,  @Digito OUTPUT
    IF RIGHT(RTRIM(@REGISTRO), 1) <> @Digito 
    BEGIN
--Valida CURP
      IF NOT EXISTS(SELECT Valor FROM RFCValidos WHERE Valor = @Registro AND Tipo = @Cual)
        SELECT @OK=0 
    END
  END

  IF @EnSilencio = 0 
    SELECT "Ok" = @Ok
  RETURN
END
GO
/********** spRFCValidos ************/
--PATRICIA ALICIA MUÑUZURI CORTES nacida el 01/03/1963  el sistema crea como RFC: MUCP630301M21 pero el SAT otrogo el de MUCP630301ME5
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spRFCValidos' and type = 'P') DROP PROCEDURE spRFCValidos
GO
CREATE PROCEDURE spRFCValidos
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
    @ID			int,
	@Cual		varchar(20), 
    @Registro	varchar(20), 
    @Largo		int, 
	@Ok			bit -- 1 = esta bien 0 = esta mal
  
  SELECT @Ok = 1
  SELECT @Registro = NULLIF(NULLIF(RTRIM(LTRIM(@Registro)),  '0'),  '')
  DECLARE crRFCValidos CURSOR FOR
    SELECT ID
     FROM RFCValidos
     ORDER BY ID

  OPEN crRFCValidos
  FETCH NEXT FROM crRFCValidos INTO @ID
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok = 1
    BEGIN
      SELECT @Registro = NULL,@Cual = NULL
      SELECT @Registro = Valor,@Cual = Tipo FROM RFCValidos WHERE ID = @ID
      IF @Cual = 'RFC' AND LEN(ISNULL(@Registro, '')) > 0
      BEGIN       
        EXEC spRegistroOk @Cual,@Registro,@Ok=@Ok
        RETURN       
      END
      ELSE
      IF @Cual = 'IMSS' AND LEN(RTRIM(LTRIM(ISNULL(@Registro, '')))) <> 11
        SELECT  @Ok = 0
      ELSE
      IF @Cual = 'CURP' AND LEN(ISNULL(@REGISTRO, '')) <= 0
        SELECT  @Ok = 0
      ELSE
      IF ISNULL(NULLIF(@Cual,''),'') = ''
        SELECT  @Ok = 0 
    END
    FETCH NEXT FROM crRFCValidos INTO @ID
  END
  CLOSE crRFCValidos
  DEALLOCATE crRFCValidos

  IF @Ok = 0 AND ISNULL(NULLIF(@Cual,''),'') <> ''
  BEGIN
    SELECT @Registro = @Registro
  END
  ELSE  
  IF @Ok = 0 AND ISNULL(NULLIF(@Cual,''),'') = ''
    SELECT @Registro = 'TIPO'
  ELSE
    SELECT @Registro = ''

  SELECT @Ok
  RETURN
END
GO


-- SELECT * from paisestado 
-- spRegistroOk 'RFC',  'GPA040608MG8',  'DEMO'
--- spRegistroOk 'imss', ''
-- spRegistroSugerir 'RFC',  'AUVJ610311DR4',  'JORGE SERGIO',  'AGUIRRE',  'VILLALON',  '03/11/1961 00:00:00'
--  spRegistroSugerir 'RFC',  '0',  'Jorge SERGIO',  'AGUIRRE',  'VILLALON',  '03/11/1961'
--  spRegistroSugerir 'RFC',  '0', 'Jose Ricardo', 'ALAMAN',  'PEREZ LOPEZ', 	 '03/21/1963'
--  spRegistroSugerir 'CURP',  '0', 'Daniel', 'Sepulveda',  'Sanchez de la barquera', 	 '12/13/1969'
--  spRegistroSugerir 'RFC',  '0',  '0',  '0',  '0',  '18991230 00:00:00.000'
--  0141125191523003215273423351514110032112513181539001415002311001211292834152911
--   DECLARE @PALABRA varchar(10) EXEC spRFCDigitoVerificador 'SESD691213GV',  @Palabra OUTPUT SELECT @PALABRA 

--select * from cte
--exec spRFCValidos

/********** spNominaVerDigitoIMSS ************/

IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spNominaVerDigitoIMSS' and type = 'P') DROP PROCEDURE spNominaVerDigitoIMSS
go
CREATE PROCEDURE spNominaVerDigitoIMSS  @RegistroIMSS        varchar(20) ,@digito Varchar(1) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @A int, @Numeros Varchar(30),@Predigito int
  SELECT @A=1,@Numeros=''
  WHILE 11 > @A
  BEGIN
    SELECT @Numeros=@Numeros +  Convert(varchar, convert(int,substring(@RegistroIMSS,@A,1)) * (2-(@A % 2)))
    SELECT @A=@A+1
  END

  SELECT @A=1,  @Predigito =0
  WHILE LEN(ISNULL(@Numeros,'')) + 1 > @A
  BEGIN
    SELECT @Predigito = @Predigito +  CONVERT(int,SUBSTRING( @Numeros ,@A,1))
    SELECT @A=@A+1
  END
  
  SELECT @Digito=RIGHT((FLOOR(@Predigito/10)+1)*10-@Predigito,1)
  RETURN
END
go
--spNominaVerDigitoIMSS  '16897187635'


