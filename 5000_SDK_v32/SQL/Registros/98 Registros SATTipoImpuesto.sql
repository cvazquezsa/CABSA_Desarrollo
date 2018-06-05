SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/******************* Cat�logo de Tipo de Impuesto SAT ***********/
TRUNCATE TABLE SATTipoImpuesto
GO
INSERT INTO SATTipoImpuesto(Clave, Descripcion) SELECT '001', 'ISR'
INSERT INTO SATTipoImpuesto(Clave, Descripcion) SELECT '002', 'IVA'
INSERT INTO SATTipoImpuesto(Clave, Descripcion) SELECT '003', 'IEPS'
INSERT INTO SATTipoImpuesto(Clave, Descripcion) SELECT '999', 'OTROS'
GO


/******************* Cat�logo de R�gimen Fiscal SAT ***********/
TRUNCATE TABLE FiscalRegimen
GO
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '601', 'General de Ley Personas Morales', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '603', 'Personas Morales con Fines no Lucrativos', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '605', 'Sueldos y Salarios e Ingresos Asimilados a Salarios', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '606', 'Arrendamiento', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '608', 'Dem�s ingresos', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '609', 'Consolidaci�n', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '610', 'Residentes en el Extranjero sin Establecimiento Permanente en M�xico', 1
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '611', 'Ingresos por Dividendos (socios y accionistas)', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '612', 'Personas Fisicas con Actividades Empresariales y Profesionales', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '614', 'Ingresos por intereses', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '616', 'Sin obligaciones fiscales', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '620', 'Sociedades Cooperativas de Producci�n que optan por diferir sus ingresos', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '621', 'Incorporaci�n Fiscal', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '622', 'Actividades Agr�colas, Ganaderas, Silv�colas y Pesqueras', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '623', 'Opcional para Grupos de Sociedades', 0
INSERT INTO FiscalRegimen(FiscalRegimen, Descripcion, Extranjero) SELECT '624', 'Coordinados', 0
GO

/******************* Cat�logo de M�todo de Pago SAT ***********/

if exists(select * from SysTabla where SysTabla = 'SATMetodoPago')
	BEGIN
		DELETE FROM SATMetodoPago
		ALTER TABLE SATMetodoPago DROP CONSTRAINT priSATMetodoPago
		EXEC spALTER_TABLE  'SATMetodoPago', 'IDClave','varchar(5) NOT NULL'
		ALTER TABLE SATMetodoPago ADD CONSTRAINT priSATMetodoPago PRIMARY KEY CLUSTERED(IDClave)
	END
GO

if exists(select * from SysTabla where SysTabla = 'SATMetodoPago')
BEGIN
	INSERT INTO SATMetodoPago(IDClave,Clave) VALUES('PUE','Pago en una sola exhibici�n')
	INSERT INTO SATMetodoPago(IDClave,Clave) VALUES('PPD','Pago en parcialidades o diferido')
	INSERT INTO SATMetodoPago(IDClave,Clave) VALUES('PIP','Pago inicial y parcialidades')
END
GO

/******************* Cat�logo de Monedas SAT ***********/
TRUNCATE TABLE SATMoneda
GO
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'AED', 'Dirham de EAU', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'AFN', 'Afghani', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ALL', 'Lek', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'AMD', 'Dram armenio', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ANG', 'Flor�n antillano neerland�s', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'AOA', 'Kwanza', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ARS', 'Peso Argentino', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'AUD', 'D�lar Australiano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'AWG', 'Aruba Florin', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'AZN', 'Azerbaijanian Manat', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BAM', 'Convertibles marca', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BBD', 'D�lar de Barbados', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BDT', 'Taka', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BGN', 'Lev b�lgaro', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BHD', 'Dinar de Bahrein', 3
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BIF', 'Burundi Franc', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BMD', 'D�lar de Bermudas', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BND', 'D�lar de Brunei', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BOB', 'Boliviano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BOV', 'Mvdol', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BRL', 'Real brasile�o', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BSD', 'D�lar de las Bahamas', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BTN', 'Ngultrum', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BWP', 'Pula', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BYR', 'Rublo bielorruso', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'BZD', 'D�lar de Belice', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CAD', 'Dolar Canadiense', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CDF', 'Franco congole�o', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CHE', 'WIR Euro', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CHF', 'Franco Suizo', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CHW', 'Franc WIR', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CLF', 'Unidad de Fomento', 4
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CLP', 'Peso chileno', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CNY', 'Yuan Renminbi', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'COP', 'Peso Colombiano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'COU', 'Unidad de Valor real', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CRC', 'Col�n costarricense', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CUC', 'Peso Convertible', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CUP', 'Peso Cubano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CVE', 'Cabo Verde Escudo', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'CZK', 'Corona checa', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'DJF', 'Franco de Djibouti', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'DKK', 'Corona danesa', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'DOP', 'Peso Dominicano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'DZD', 'Dinar argelino', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'EGP', 'Libra egipcia', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ERN', 'Nakfa', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ETB', 'Birr et�ope', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'EUR', 'Euro', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'FJD', 'D�lar de Fiji', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'FKP', 'Libra malvinense', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'GBP', 'Libra Esterlina', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'GEL', 'Lari', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'GHS', 'Cedi de Ghana', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'GIP', 'Libra de Gibraltar', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'GMD', 'Dalasi', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'GNF', 'Franco guineano', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'GTQ', 'Quetzal', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'GYD', 'D�lar guyan�s', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'HKD', 'Dolar De Hong Kong', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'HNL', 'Lempira', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'HRK', 'Kuna', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'HTG', 'Gourde', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'HUF', 'Flor�n', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'IDR', 'Rupia', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ILS', 'Nuevo Shekel Israel�', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'INR', 'Rupia india', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'IQD', 'Dinar iraqu�', 3
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'IRR', 'Rial iran�', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ISK', 'Corona islandesa', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'JMD', 'D�lar Jamaiquino', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'JOD', 'Dinar jordano', 3
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'JPY', 'Yen', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'KES', 'Chel�n keniano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'KGS', 'Som', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'KHR', 'Riel', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'KMF', 'Franco Comoro', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'KPW', 'Corea del Norte gan�', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'KRW', 'Won', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'KWD', 'Dinar kuwait�', 3
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'KYD', 'D�lar de las Islas Caim�n', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'KZT', 'Tenge', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'LAK', 'Kip', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'LBP', 'Libra libanesa', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'LKR', 'Rupia de Sri Lanka', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'LRD', 'D�lar liberiano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'LSL', 'Loti', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'LYD', 'Dinar libio', 3
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MAD', 'Dirham marroqu�', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MDL', 'Leu moldavo', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MGA', 'Ariary malgache', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MKD', 'Denar', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MMK', 'Kyat', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MNT', 'Tugrik', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MOP', 'Pataca', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MRO', 'Ouguiya', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MUR', 'Rupia de Mauricio', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MVR', 'Rupia', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MWK', 'Kwacha', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MXN', 'Peso Mexicano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MXV', 'M�xico Unidad de Inversi�n (UDI)', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MYR', 'Ringgit malayo', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'MZN', 'Mozambique Metical', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'NAD', 'D�lar de Namibia', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'NGN', 'Naira', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'NIO', 'C�rdoba Oro', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'NOK', 'Corona noruega', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'NPR', 'Rupia nepal�', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'NZD', 'D�lar de Nueva Zelanda', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'OMR', 'Rial oman�', 3
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'PAB', 'Balboa', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'PEN', 'Nuevo Sol', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'PGK', 'Kina', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'PHP', 'Peso filipino', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'PKR', 'Rupia de Pakist�n', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'PLN', 'Zloty', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'PYG', 'Guaran�', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'QAR', 'Qatar Rial', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'RON', 'Leu rumano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'RSD', 'Dinar serbio', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'RUB', 'Rublo ruso', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'RWF', 'Franco ruand�s', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SAR', 'Riyal saud�', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SBD', 'D�lar de las Islas Salom�n', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SCR', 'Rupia de Seychelles', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SDG', 'Libra sudanesa', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SEK', 'Corona sueca', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SGD', 'Dolar De Singapur', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SHP', 'Libra de Santa Helena', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SLL', 'Leona', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SOS', 'Chel�n somal�', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SRD', 'D�lar de Suriname', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SSP', 'Libra sudanesa Sur', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'STD', 'Dobra', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SVC', 'Colon El Salvador', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SYP', 'Libra Siria', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'SZL', 'Lilangeni', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'THB', 'Baht', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'TJS', 'Somoni', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'TMT', 'Turkmenist�n nuevo manat', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'TND', 'Dinar tunecino', 3
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'TOP', 'Pa''anga', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'TRY', 'Lira turca', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'TTD', 'D�lar de Trinidad y Tobago', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'TWD', 'Nuevo d�lar de Taiw�n', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'TZS', 'Shilling tanzano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'UAH', 'Hryvnia', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'UGX', 'Shilling de Uganda', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'USD', 'Dolar americano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'USN', 'D�lar estadounidense (d�a siguiente)', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'UYI', 'Peso Uruguay en Unidades Indexadas (URUIURUI)', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'UYU', 'Peso Uruguayo', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'UZS', 'Uzbekist�n Sum', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'VEF', 'Bol�var', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'VND', 'Dong', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'VUV', 'Vatu', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'WST', 'Tala', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XAF', 'Franco CFA BEAC', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XAG', 'Plata', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XAU', 'Oro', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XBA', 'Unidad de Mercados de Bonos Unidad Europea Composite (EURCO)', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XBB', 'Unidad Monetaria de Bonos de Mercados Unidad Europea (UEM-6)', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XBC', 'Mercados de Bonos Unidad Europea unidad de cuenta a 9 (UCE-9)', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XBD', 'Mercados de Bonos Unidad Europea unidad de cuenta a 17 (UCE-17)', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XCD', 'D�lar del Caribe Oriental', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XDR', 'DEG (Derechos Especiales de Giro)', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XOF', 'Franco CFA BCEAO', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XPD', 'Paladio', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XPF', 'Franco CFP', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XPT', 'Platino', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XSU', 'Sucre', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XTS', 'C�digos reservados espec�ficamente para prop�sitos de prueba', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XUA', 'Unidad ADB de Cuenta', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'XXX', 'Los c�digos asignados para las transacciones en que intervenga ninguna moneda', 0
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'YER', 'Rial yemen�', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ZAR', 'Rand', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ZMW', 'Kwacha zambiano', 2
INSERT INTO SATMoneda(Clave, Descripcion, Decimales) SELECT 'ZWL', 'Zimbabwe D�lar', 2
GO


/******************* Cat�logo de Unidades de Medida SAT ***********/
TRUNCATE TABLE SATUnidadAduana
GO
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '01','KILO'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '02','GRAMO'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '03','METRO LINEAL'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '04','METRO CUADRADO'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '05','METRO CUBICO'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '06','PIEZA'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '07','CABEZA'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '08','LITRO'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '09','PAR'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '10','KILOWATT'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '11','MILLAR'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '12','JUEGO'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '13','KILOWATT/HORA'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '14','TONELADA'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '15','BARRIL'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '16','GRAMO NETO'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '17','DECENAS'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '18','CIENTOS'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '19','DOCENAS'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '20','CAJA'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '21','BOTELLA'
INSERT INTO SATUnidadAduana(Clave, Descripcion) SELECT  '99','SERVICIO'
GO


/******************* Cat�logo de Tipo N�mina SAT ***********/
TRUNCATE TABLE SATTipoNomina
GO
INSERT INTO SATTipoNomina(Clave, Descripcion) SELECT 'O', 'Sueldos y salarios (n�mina ordinaria)'
INSERT INTO SATTipoNomina(Clave, Descripcion) SELECT 'E', 'Pagos extraordinarios (n�mina extraordinaria, jubilaci�n, indemnizaci�n, etc.)'
GO