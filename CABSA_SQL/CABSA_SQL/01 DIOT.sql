SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
SET NOCOUNT ON
GO

/******************************     NIVEL DE COMPATIBILIDAD     ***********************************/
if not exists (select * from sysobjects where id = object_id('tmpNivel') and type = 'U') 
BEGIN
  CREATE TABLE tmpNivel(
    Nivel   		int)
END
GO
/************************************     XSD DIOT     ********************************************/
if not substring(@@version, 1, 25) in ('Microsoft SQL Server 2000')
BEGIN
    DECLARE 
        @SQL varchar(200),
        @Nivel int,
        @Database varchar(256)
    
    SELECT @SQL = 'ALTER DATABASE ['+DB_NAME()+'] SET TRUSTWORTHY ON;'
    EXEC(@SQL)

    SELECT @Nivel = compatibility_level
    FROM sys.databases WHERE name = DB_NAME();
    DELETE tmpNivel
    INSERT tmpNivel(Nivel)VALUES(@Nivel)

    IF @Nivel <90
    BEGIN
        if substring(@@version, 1, 25) in ('Microsoft SQL Server 2005')
        BEGIN
          SET @Database = DB_NAME()
          EXEC dbo.sp_dbcmptlevel @Database, 90
        END
        if not substring(@@version, 1, 25) in ('Microsoft SQL Server 2000','Microsoft SQL Server 2005')
        BEGIN
          SELECT @SQL = 'ALTER DATABASE ['+DB_NAME()+'] SET COMPATIBILITY_LEVEL = 90;'
          EXEC(@SQL)
        END
  
    END
END
GO
IF EXISTS(SELECT xml_collection_id FROM sys.xml_schema_collections WHERE name = 'DPIVA')
	BEGIN
		IF NOT EXISTS(SELECT xml_collection_id FROM sys.xml_schema_collections WHERE name = 'DPIVA')
		BEGIN
			DECLARE 
			@XSDv1	AS VARCHAR(max)
			
			SELECT @XSDv1 = CAST(xml_schema_namespace(N'dbo',N'DPIVA') AS VARCHAR(max))
			
			CREATE XML SCHEMA COLLECTION DPIVA AS @XSDv1
		END

		DROP XML SCHEMA COLLECTION DPIVA
	END
BEGIN TRY 
DECLARE @XSD VARCHAR(MAX)
SET @XSD = REPLACE('<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:DPIVA="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/TipoDPIVA/1" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cat="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/1/Catalogos" targetNamespace="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/TipoDPIVA/1" elementFormDefault="qualified" attributeFormDefault="unqualified">
	<xs:import namespace="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/1/Catalogos" schemaLocation="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/1/Catalogos/CatDoctoDigital.xsd"/>
	<xs:element name="DPIVA">
		<xs:annotation>
			<xs:documentation>Estándar del tipo del documento digital declaración proveedores IVA a través de internet</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence>
				<xs:element name="Totales">
					<xs:annotation>
						<xs:documentation>Nodo obligatorio que indica los totales del tipo del documento declaración proveedores IVA a través de internet.</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="TotOperac" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el total de operaciones que relaciona en la DPIVA.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:int">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="7"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="TotActPagTas15o16IVA" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - valor de los actos o actividades pagados a la tasa del 15 ó 16% de IVA.  En caso de que no existan datos, colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="TotActPagTas15IVA" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - valor de los actos o actividades pagados a la tasa del 15% de IVA.  En caso de que no existan datos, colocar cero. Aplicable solo cuando el ejercicio a declarar es 2010, el tipo de periodicidad es mensual y el periodo es enero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotIVAPagNoAcrTas15o16" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - monto del IVA pagado no acreditable a la tasa del 15 ó 16% (correspondiente en la proporción de las deducciones autorizadas). En caso de que no existan datos, colocar cero</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotActPagTas10u11IVA" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - valor de los actos o actividades pagados a la tasa del 10 u 11% de IVA.  En caso de que no existan datos, colocar cero. Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotActPagTas10IVA" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - valor de los actos o actividades pagados a la tasa del 10% de IVA.  En caso de que no existan datos, colocar cero. Aplicable solo cuando el ejercicio a declarar es 2010, el tipo de periodicidad es enero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotIVAPagNoAcrTas10u11" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - monto del IVA pagado no acreditable a la tasa del 10 u 11% (correspondiente en la proporción de las deducciones autorizadas).  En caso de que no existan datos, colocar cero. Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotActPagImpBySTas15o16IVA" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - valor de los actos o actividades pagados en la importación de bienes y servicios a la tasa del 15 ó 16% de IVA.  En caso de que no existan datos, colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotIVAPagNoAcrImpTas15o16" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - monto del IVA pagado no acreditable por la importación a la tasa del 15 ó 16% (correspondiente en la proporción de las deducciones autorizadas).  En caso de que no existan datos, colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotActPagImpBySTas10u11IVA" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - valor de los actos o actividades pagados en la importación de bienes y servicios a la tasa del 10 u 11% de IVA.  En caso de que no existan datos, colocar cero. Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotIVAPagNoAcrImpTas10u11" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  - monto del IVA pagado no acreditable por la importación a la tasa del 10 u 11% (correspondiente en la proporción de las deducciones autorizadas).  En caso de que no existan datos, colocar cero. Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotActPagImpBySNoPagIVA" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  -valor de los actos o actividades pagados en la importación de bienes y servicios por los que no se pagará el IVA (exentos).  En caso de que no existan datos, colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotDemActPagTas0IVA" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  -valor de los demás actos o actividades pagados a la tasa del 0% de IVA.  En caso de que no existan datos, colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotActPagNoPagIVA" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  -valor de los actos o actividades pagados por los que no se pagará el IVA  (exentos).  En caso de que no existan datos, colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotIVARetCont" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  -IVA retenido por el contribuyente.  En caso de que no existan datos, colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotIVADevDescyBonifComp" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el valor total de los datos registrados en  -IVA correspondiente a las devoluciones, descuentos y bonificaciones sobre compras.  En caso de que no existan datos, colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotIVATraslContExcImpByS" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el total de IVA trasladado al contribuyente excepto importaciones de bienes y servicios (pagado).  En caso de que no existan datos, colocar cero. Aplicable cuando el ejercicio a declarar es 2010 y posteriores (= (total de los actos o actividades pagados a la tasa del 15 ó 16% de IVA * 0.16) + (total de los actos o actividades pagados a la tasa del 10 u 11% de IVA * 0.11) + (total de los actos o actividades pagados a la tasa del 15% de IVA *  0.15) + (total de los actos o actividades pagados a la tasa del 10% de IVA *  0.10)), cuando el ejercicio a declarar es 2007, 2008 ó 2009 (=(total de los actos o actividades pagados a la tasa del 15 ó 16% de IVA * 0.15) + (total de los actos o actividades pagados a la tasa del 10 u 11% de IVA *  0.10)).  Importante:  El resultado no presenta decimales (de .01 a .50 se ajustará a la unidad inmediata inferior  y  de .51 a .99 se ajustará a la unidad inmediata superior) </xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="TotIVAPagImpByS" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el total de IVA pagado en las importaciones de bienes y servicios.  En caso de que no existan datos, colocar cero. Aplicable cuando el ejercicio a declarar es 2010 y posteriores (=(total de los actos o actividades pagados en la importación de bienes y servicios  a la tasa del 15 ó 16% de IVA * 0.16) + (total de los actos o actividades pagados en la importación de bienes y servicios  a la tasa del 10 u 11% de IVA * 0.11)), cuando el ejercicio a declarar es 2007, 2008 ó 2009 (=(total de los actos o actividades pagados en la importación de bienes y servicios  a la tasa del 15 ó 16% de IVA * 0.15) + (total de los actos o actividades pagados en la importación de bienes y servicios  a la tasa del 10 u 11% de IVA * 0.10)).  Importante:  El resultado no presenta decimales (de .01 a .50 se ajustará a la unidad inmediata inferior  y  de .51 a .99 se ajustará a la unidad inmediata superior) </xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="14"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="ProvNacional" minOccurs="0" maxOccurs="unbounded">
					<xs:annotation>
						<xs:documentation>Nodo opcional que indica el detalle de las operaciones realizadas con proveedores nacionales.</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="TipoOperac" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido que indica el tipo de operación que se declara, donde el valor 03 = Prestación de Servicios Profesionales, 06 = Arrendamiento de Inmuebles y 85 = Otros</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:enumeration value="03"/>
									<xs:enumeration value="06"/>
									<xs:enumeration value="85"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="RFCProv" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para incorporar la clave en el Registro Federal de Contribuyentes del Proveedor, sin guiones o espacios.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="12"/>
									<xs:maxLength value="13"/>
									<xs:whiteSpace value="collapse"/>
									<xs:pattern value="[A-ZÑ]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z0-9][A-Z0-9][0-9A]"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas15o16IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor   de los actos o actividades pagados a la tasa del 15 ó 16% de IVA.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="ValActPagTas15IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados a la tasa del 15% de IVA.  Aplicable solo cuando el ejercicio a declarar es 2010, el tipo de periodicidad es mensual y el periodo es enero.  Se puede colocar cero. (Este campo se utilizará únicamente para efectos de declarar enajenación de bienes, prestación de servicios o el otorgamiento del uso o goce temporal de bienes celebrados con anterioridad al ejercicio 2010, así como de conformidad con lo establecido en las disposiciones transitorias de la ley del impuesto al valor agregado)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrTas15o16" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable a la tasa del 15 ó 16% (correspondiente en la proporción de las deducciones autorizadas).  Se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas10u11IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados a la tasa del 10 u 11% de IVA.  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas10IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados a la tasa del 10% de IVA.  Aplicable solo cuando el ejercicio a declarar es 2010, el tipo de periodicidad es mensual y el periodo es enero.  Se puede colocar cero. (Se utilizará únicamente para efectos de declarar enajenación de bienes, prestación de servicios o el otorgamiento del uso o goce temporal de bienes celebrados con anterioridad al ejercicio 2010, así como de conformidad con lo establecido en las disposiciones transitorias de la ley del impuesto al valor agregado).</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrTas10u11" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable a la tasa del 10 u 11% (correspondiente en la proporción de las deducciones autorizadas).  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas0IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los demás actos o actividades pagados a la tasa del 0% de IVA.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagNoIVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados por los que no se pagará el IVA  (exentos).  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="IVARetCont" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el IVA retenido por el contribuyente.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="IVADevDescyBonifComp" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el IVA correspondiente a las devoluciones, descuentos y bonificaciones sobre compras.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="ProvExtranjero" minOccurs="0" maxOccurs="unbounded">
					<xs:annotation>
						<xs:documentation>Nodo opcional que indica el detalle de las operaciones realizadas con proveedores extranjeros.</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="TipoOperac" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido que indica el tipo de operación que se declara, donde el valor 03 = Prestación de Servicios Profesionales y 85 = Otros</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:enumeration value="03"/>
									<xs:enumeration value="85"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="RFCProv" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para incorporar la clave en el Registro Federal de Contribuyentes del proveedor, sin guiones o espacios.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="12"/>
									<xs:maxLength value="13"/>
									<xs:whiteSpace value="collapse"/>
									<xs:pattern value="[A-ZÑ]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z0-9][A-Z0-9][0-9A]"/>
								</xs:restriction>
							</xs:simpleType>								
						</xs:attribute>
						<xs:attribute name="NumIDFiscal" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para expresar el identificador fiscal del proveedor extranjero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="40"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="NombExtranjero" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido que permite expresar el nombre del proveedor extranjero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="43"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="PaisResidencia" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar el país de residencia del proveedor extranjero de acuerdo al catálogo publicado en la página de internet del SAT.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:length value="2"/>
									<xs:enumeration value="AD"/>
									<xs:enumeration value="AE"/>
									<xs:enumeration value="AF"/>
									<xs:enumeration value="AG"/>
									<xs:enumeration value="AI"/>
									<xs:enumeration value="AL"/>
									<xs:enumeration value="AM"/>
									<xs:enumeration value="AO"/>
									<xs:enumeration value="AQ"/>
									<xs:enumeration value="AR"/>
									<xs:enumeration value="AS"/>
									<xs:enumeration value="AT"/>
									<xs:enumeration value="AU"/>
									<xs:enumeration value="AW"/>
									<xs:enumeration value="AX"/>
									<xs:enumeration value="AZ"/>
									<xs:enumeration value="BA"/>
									<xs:enumeration value="BB"/>
									<xs:enumeration value="BD"/>
									<xs:enumeration value="BE"/>
									<xs:enumeration value="BF"/>
									<xs:enumeration value="BG"/>
									<xs:enumeration value="BH"/>
									<xs:enumeration value="BI"/>
									<xs:enumeration value="BJ"/>
									<xs:enumeration value="BL"/>
									<xs:enumeration value="BM"/>
									<xs:enumeration value="BN"/>
									<xs:enumeration value="BO"/>
									<xs:enumeration value="BQ"/>
									<xs:enumeration value="BR"/>
									<xs:enumeration value="BS"/>
									<xs:enumeration value="BT"/>
									<xs:enumeration value="BV"/>
									<xs:enumeration value="BW"/>
									<xs:enumeration value="BY"/>
									<xs:enumeration value="BZ"/>
									<xs:enumeration value="CA"/>
									<xs:enumeration value="CC"/>
									<xs:enumeration value="CD"/>
									<xs:enumeration value="CF"/>
									<xs:enumeration value="CG"/>
									<xs:enumeration value="CH"/>
									<xs:enumeration value="CI"/>
									<xs:enumeration value="CK"/>
									<xs:enumeration value="CL"/>
									<xs:enumeration value="CM"/>
									<xs:enumeration value="CN"/>
									<xs:enumeration value="CO"/>
									<xs:enumeration value="CR"/>
									<xs:enumeration value="CU"/>
									<xs:enumeration value="CV"/>
									<xs:enumeration value="CW"/>
									<xs:enumeration value="CX"/>
									<xs:enumeration value="CY"/>
									<xs:enumeration value="CZ"/>
									<xs:enumeration value="DE"/>
									<xs:enumeration value="DJ"/>
									<xs:enumeration value="DK"/>
									<xs:enumeration value="DM"/>
									<xs:enumeration value="DO"/>
									<xs:enumeration value="DZ"/>
									<xs:enumeration value="EC"/>
									<xs:enumeration value="EE"/>
									<xs:enumeration value="EG"/>
									<xs:enumeration value="EH"/>
									<xs:enumeration value="ER"/>
									<xs:enumeration value="ES"/>
									<xs:enumeration value="ET"/>
									<xs:enumeration value="FI"/>
									<xs:enumeration value="FJ"/>
									<xs:enumeration value="FK"/>
									<xs:enumeration value="FM"/>
									<xs:enumeration value="FO"/>
									<xs:enumeration value="FR"/>
									<xs:enumeration value="GA"/>
									<xs:enumeration value="GB"/>
									<xs:enumeration value="GD"/>
									<xs:enumeration value="GE"/>
									<xs:enumeration value="GF"/>
									<xs:enumeration value="GG"/>
									<xs:enumeration value="GH"/>
									<xs:enumeration value="GI"/>
									<xs:enumeration value="GL"/>
									<xs:enumeration value="GM"/>
									<xs:enumeration value="GN"/>
									<xs:enumeration value="GP"/>
									<xs:enumeration value="GQ"/>
									<xs:enumeration value="GR"/>
									<xs:enumeration value="GS"/>
									<xs:enumeration value="GT"/>
									<xs:enumeration value="GU"/>
									<xs:enumeration value="GW"/>
									<xs:enumeration value="GY"/>
									<xs:enumeration value="HK"/>
									<xs:enumeration value="HM"/>
									<xs:enumeration value="HN"/>
									<xs:enumeration value="HR"/>
									<xs:enumeration value="HT"/>
									<xs:enumeration value="HU"/>
									<xs:enumeration value="ID"/>
									<xs:enumeration value="IE"/>
									<xs:enumeration value="IL"/>
									<xs:enumeration value="IM"/>
									<xs:enumeration value="IN"/>
									<xs:enumeration value="IO"/>
									<xs:enumeration value="IQ"/>
									<xs:enumeration value="IR"/>
									<xs:enumeration value="IS"/>
									<xs:enumeration value="IT"/>
									<xs:enumeration value="JE"/>
									<xs:enumeration value="JM"/>
									<xs:enumeration value="JO"/>
									<xs:enumeration value="JP"/>
									<xs:enumeration value="KE"/>
									<xs:enumeration value="KG"/>
									<xs:enumeration value="KH"/>
									<xs:enumeration value="KI"/>
									<xs:enumeration value="KM"/>
									<xs:enumeration value="KN"/>
									<xs:enumeration value="KP"/>
									<xs:enumeration value="KR"/>
									<xs:enumeration value="KW"/>
									<xs:enumeration value="KY"/>
									<xs:enumeration value="KZ"/>
									<xs:enumeration value="LA"/>
									<xs:enumeration value="LB"/>
									<xs:enumeration value="LC"/>
									<xs:enumeration value="LI"/>
									<xs:enumeration value="LK"/>
									<xs:enumeration value="LR"/>
									<xs:enumeration value="LS"/>
									<xs:enumeration value="LT"/>
									<xs:enumeration value="LU"/>
									<xs:enumeration value="LV"/>
									<xs:enumeration value="LY"/>
									<xs:enumeration value="MA"/>
									<xs:enumeration value="MC"/>
									<xs:enumeration value="MD"/>
									<xs:enumeration value="ME"/>
									<xs:enumeration value="MF"/>
									<xs:enumeration value="MG"/>
									<xs:enumeration value="MH"/>
									<xs:enumeration value="MK"/>
									<xs:enumeration value="ML"/>
									<xs:enumeration value="MM"/>
									<xs:enumeration value="MN"/>
									<xs:enumeration value="MO"/>
									<xs:enumeration value="MP"/>
									<xs:enumeration value="MQ"/>
									<xs:enumeration value="MR"/>
									<xs:enumeration value="MS"/>
									<xs:enumeration value="MT"/>
									<xs:enumeration value="MU"/>
									<xs:enumeration value="MV"/>
									<xs:enumeration value="MW"/>
									<xs:enumeration value="MX"/>
									<xs:enumeration value="MY"/>
									<xs:enumeration value="MZ"/>
									<xs:enumeration value="NA"/>
									<xs:enumeration value="NC"/>
									<xs:enumeration value="NE"/>
									<xs:enumeration value="NF"/>
									<xs:enumeration value="NG"/>
									<xs:enumeration value="NI"/>
									<xs:enumeration value="NL"/>
									<xs:enumeration value="NO"/>
									<xs:enumeration value="NP"/>
									<xs:enumeration value="NR"/>
									<xs:enumeration value="NU"/>
									<xs:enumeration value="NZ"/>
									<xs:enumeration value="OM"/>
									<xs:enumeration value="PA"/>
									<xs:enumeration value="PE"/>
									<xs:enumeration value="PF"/>
									<xs:enumeration value="PG"/>
									<xs:enumeration value="PH"/>
									<xs:enumeration value="PK"/>
									<xs:enumeration value="PL"/>
									<xs:enumeration value="PM"/>
									<xs:enumeration value="PN"/>
									<xs:enumeration value="PR"/>
									<xs:enumeration value="PS"/>
									<xs:enumeration value="PT"/>
									<xs:enumeration value="PW"/>
									<xs:enumeration value="PY"/>
									<xs:enumeration value="QA"/>
									<xs:enumeration value="RE"/>
									<xs:enumeration value="RO"/>
									<xs:enumeration value="RS"/>
									<xs:enumeration value="RU"/>
									<xs:enumeration value="RW"/>
									<xs:enumeration value="SA"/>
									<xs:enumeration value="SB"/>
									<xs:enumeration value="SC"/>
									<xs:enumeration value="SD"/>
									<xs:enumeration value="SE"/>
									<xs:enumeration value="SG"/>
									<xs:enumeration value="SH"/>
									<xs:enumeration value="SI"/>
									<xs:enumeration value="SJ"/>
									<xs:enumeration value="SK"/>
									<xs:enumeration value="SL"/>
									<xs:enumeration value="SM"/>
									<xs:enumeration value="SN"/>
									<xs:enumeration value="SO"/>
									<xs:enumeration value="SR"/>
									<xs:enumeration value="SS"/>
									<xs:enumeration value="ST"/>
									<xs:enumeration value="SV"/>
									<xs:enumeration value="SX"/>
									<xs:enumeration value="SY"/>
									<xs:enumeration value="SZ"/>
									<xs:enumeration value="TC"/>
									<xs:enumeration value="TD"/>
									<xs:enumeration value="TF"/>
									<xs:enumeration value="TG"/>
									<xs:enumeration value="TH"/>
									<xs:enumeration value="TJ"/>
									<xs:enumeration value="TK"/>
									<xs:enumeration value="TL"/>
									<xs:enumeration value="TM"/>
									<xs:enumeration value="TN"/>
									<xs:enumeration value="TO"/>
									<xs:enumeration value="TR"/>
									<xs:enumeration value="TT"/>
									<xs:enumeration value="TV"/>
									<xs:enumeration value="TW"/>
									<xs:enumeration value="TZ"/>
									<xs:enumeration value="UA"/>
									<xs:enumeration value="UG"/>
									<xs:enumeration value="UM"/>
									<xs:enumeration value="US"/>
									<xs:enumeration value="UY"/>
									<xs:enumeration value="UZ"/>
									<xs:enumeration value="VA"/>
									<xs:enumeration value="VC"/>
									<xs:enumeration value="VE"/>
									<xs:enumeration value="VG"/>
									<xs:enumeration value="VI"/>
									<xs:enumeration value="VN"/>
									<xs:enumeration value="VU"/>
									<xs:enumeration value="WF"/>
									<xs:enumeration value="WS"/>
									<xs:enumeration value="YE"/>
									<xs:enumeration value="YT"/>
									<xs:enumeration value="ZA"/>
									<xs:enumeration value="ZM"/>
									<xs:enumeration value="ZW"/>
									<xs:enumeration value="ZZ"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="Nacionalidad" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para indicar la nacionalidad del proveedor extranjero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="40"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="ValActPagTas15o16IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor   de los actos o actividades pagados a la tasa del 15 ó 16% de IVA.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas15IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados a la tasa del 15% de IVA.  Aplicable solo cuando el ejercicio a declarar es 2010, el tipo de periodicidad es mensual y el periodo es enero.  Se puede colocar cero. (Este campo se utilizará únicamente para efectos de declarar enajenación de bienes, prestación de servicios o el otorgamiento del uso o goce temporal de bienes celebrados con anterioridad al ejercicio 2010, así como de conformidad con lo establecido en las disposiciones transitorias de la ley del impuesto al valor agregado)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrTas15o16" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable a la tasa del 15 ó 16% (correspondiente en la proporción de las deducciones autorizadas).  Se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas10u11IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados a la tasa del 10 u 11% de IVA.  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas10IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados a la tasa del 10% de IVA.  Aplicable solo cuando el ejercicio a declarar es 2010, el tipo de periodicidad es mensual y el periodo es enero. Se puede colocar cero. (Se utilizará únicamente para efectos de declarar enajenación de bienes, prestación de servicios o el otorgamiento del uso o goce temporal de bienes celebrados con anterioridad al ejercicio 2010, así como de conformidad con lo establecido en las disposiciones transitorias de la ley del impuesto al valor agregado).</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrTas10u11" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable a la tasa del 10 u 11% (correspondiente en la proporción de las deducciones autorizadas).  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagImpBySTas15o16IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados en la importación de bienes y servicios a la tasa del 15 ó 16% de IVA.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrImpTas15o16" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable por la importación a la tasa del 15 ó 16% (correspondiente en la proporción de las deducciones autorizadas).  En caso de registrar se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagImpBySTas10u11IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados en la importación de bienes y servicios a la tasa del 10 u 11% de IVA.  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero. </xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrImpTas10u11" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable por la importación a la tasa del 10 u 11% (correspondiente en la proporción de las deducciones autorizadas).  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagImpBySNoIVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados en la importación de bienes y servicios por los que no se pagará el IVA (exentos).  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas0IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los demás actos o actividades pagados a la tasa del 0% de IVA.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagNoIVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados por los que no se pagará el IVA  (exentos).  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="IVARetCont" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el IVA retenido por el contribuyente.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="IVADevDescyBonifComp" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el IVA correspondiente a las devoluciones, descuentos y bonificaciones sobre compras.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="ProvGlobal" minOccurs="0" maxOccurs="unbounded">
					<xs:annotation>
						<xs:documentation>Nodo opcional que indica el detalle de las operaciones realizadas con proveedores globales.</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="TipoOperac" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido que indica el tipo de operación que se declara, donde el valor 03 = Prestación de Servicios Profesionales, 06 = Arrendamiento de Inmuebles y 85 = Otros</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:enumeration value="03"/>
									<xs:enumeration value="06"/>
									<xs:enumeration value="85"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="ValActPagTas15o16IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor   de los actos o actividades pagados a la tasa del 15 ó 16% de IVA.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas15IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados a la tasa del 15% de IVA. . Aplicable solo cuando el ejercicio a declarar es 2010, el tipo de periodicidad es mensual y el periodo es enero. Se puede colocar cero. (Este campo se utilizará únicamente para efectos de declarar enajenación de bienes, prestación de servicios o el otorgamiento del uso o goce temporal de bienes celebrados con anterioridad al ejercicio 2010, así como de conformidad con lo establecido en las disposiciones transitorias de la ley del impuesto al valor agregado)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrTas15o16" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable a la tasa del 15 ó 16% (correspondiente en la proporción de las deducciones autorizadas).  Se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas10u11IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados a la tasa del 10 u 11% de IVA.  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas10IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados a la tasa del 10% de IVA. Aplicable solo cuando el ejercicio a declarar es 2010, el tipo de periodicidad es mensual y el periodo es enero. Se puede colocar cero. (Se utilizará únicamente para efectos de declarar enajenación de bienes, prestación de servicios o el otorgamiento del uso o goce temporal de bienes celebrados con anterioridad al ejercicio 2010, así como de conformidad con lo establecido en las disposiciones transitorias de la ley del impuesto al valor agregado)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrTas10u11" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable a la tasa del 10 u 11% (correspondiente en la proporción de las deducciones autorizadas).  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagImpBySTas15o16IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados en la importación de bienes y servicios a la tasa del 15 ó 16% de IVA.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrImpTas15o16" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable por la importación a la tasa del 15 ó 16% (correspondiente en la proporción de las deducciones autorizadas).  En caso de registrar se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagImpBySTas10u11IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados en la importación de bienes y servicios a la tasa del 10 u 11% de IVA.  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero. </xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="MonIVAPagNoAcrImpTas10u11" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el monto del IVA pagado no acreditable por la importación a la tasa del 10 u 11% (correspondiente en la proporción de las deducciones autorizadas).  Aplicable solo cuando el ejercicio a declarar es menor o igual a 2013 o si es 2014 con el tipo de periodicidad  mensual y el periodo es enero.  Se puede colocar cero. (En las deducciones parcialmente deducibles se indicara el monto que no sea deducible para efectos del ISR; ejemplo: en un gasto donde el 80% es deducible y el 20% no es deducible, el IVA que se anotara en este campo es el que corresponda al 20%)</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagImpBySNoIVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados en la importación de bienes y servicios por los que no se pagará el IVA (exentos).  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagTas0IVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los demás actos o actividades pagados a la tasa del 0% de IVA.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="ValActPagNoIVA" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el valor de los actos o actividades pagados por los que no se pagará el IVA  (exentos).  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="IVARetCont" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el IVA retenido por el contribuyente.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
						<xs:attribute name="IVADevDescyBonifComp" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para indicar el IVA correspondiente a las devoluciones, descuentos y bonificaciones sobre compras.  En caso de registrar se puede colocar cero.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:integer">
									<xs:minInclusive value="0"/>
									<xs:totalDigits value="12"/>
									<xs:fractionDigits value="0"/>
								</xs:restriction>
							</xs:simpleType>							
						</xs:attribute>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
			<xs:attribute name="Version" type="xs:string" use="required" fixed="1.0">
				<xs:annotation>
					<xs:documentation>Atributo requerido con valor prefijado que indica la versión del estándar bajo el que se encuentra expresada la Declaración de Proveedores IVA.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="Ejercicio" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido que indica el ejercicio del que se realiza el documento digital</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:int">
						<xs:minInclusive value="2015"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="TipoPerid" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido que indica el tipo de periodicidad del que se realiza el documento digital de acuerdo al catálogo publicado en la página del SAT.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:length value="2"/>
						<xs:enumeration value="01"/>
						<xs:enumeration value="02"/>
						<xs:enumeration value="03"/>
						<xs:enumeration value="04"/>
						<xs:enumeration value="05"/>
						<xs:enumeration value="06"/>
						<xs:enumeration value="07"/>
						<xs:enumeration value="08"/>
						<xs:enumeration value="09"/>
						<xs:enumeration value="10"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="Periodo" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido que indica el periodo del que se realiza el Documento Digital, de acuerdo al tipo de periodicidad y al catálogo publicado en la página del SAT.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:length value="2"/>
						<xs:enumeration value="01"/>
						<xs:enumeration value="02"/>
						<xs:enumeration value="03"/>
						<xs:enumeration value="04"/>
						<xs:enumeration value="05"/>
						<xs:enumeration value="06"/>
						<xs:enumeration value="07"/>
						<xs:enumeration value="08"/>
						<xs:enumeration value="09"/>
						<xs:enumeration value="10"/>
						<xs:enumeration value="11"/>
						<xs:enumeration value="12"/>
						<xs:enumeration value="13"/>
						<xs:enumeration value="14"/>
						<xs:enumeration value="15"/>
						<xs:enumeration value="16"/>
						<xs:enumeration value="17"/>
						<xs:enumeration value="18"/>
						<xs:enumeration value="19"/>
						<xs:enumeration value="20"/>
						<xs:enumeration value="21"/>
						<xs:enumeration value="22"/>
						<xs:enumeration value="23"/>
						<xs:enumeration value="24"/>
						<xs:enumeration value="25"/>
						<xs:enumeration value="26"/>
						<xs:enumeration value="27"/>
						<xs:enumeration value="28"/>
						<xs:enumeration value="29"/>
						<xs:enumeration value="30"/>
						<xs:enumeration value="31"/>
						<xs:enumeration value="32"/>
						<xs:enumeration value="33"/>
						<xs:enumeration value="34"/>
						<xs:enumeration value="35"/>
						<xs:enumeration value="36"/>
						<xs:enumeration value="37"/>
						<xs:enumeration value="38"/>
						<xs:enumeration value="39"/>
						<xs:enumeration value="40"/>
						<xs:enumeration value="41"/>
						<xs:enumeration value="42"/>
						<xs:enumeration value="43"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="DPIVA" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido que indica de acuerdo a su valor:  0 = La presenta sin operaciones, 1 = La presenta con datos.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:enumeration value="1"/>
						<xs:enumeration value="0"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="TipoDec" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido que indica si la declaración es:  1 = Normal, 2 = Complementaria.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:enumeration value="1"/>
						<xs:enumeration value="2"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="FolioAnt" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional que indica el número de operación o folio con que se presentó la Declaración que se está sustituyendo.  Este dato se convierte en requerido cuando el tipo de declaración es complementaria.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="14"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="FechPresAnt" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional que indica la fecha de presentación de la Declaración que se está sustituyendo en formato aaaa-mm-dd. Este dato se convierte en requerido cuando el tipo de declaración es complementaria.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:date">
						<xs:minInclusive value="2007-01-01"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
		</xs:complexType>
	</xs:element>
</xs:schema>','encoding="UTF-8"','encoding="windows-1252"')

CREATE XML SCHEMA COLLECTION DPIVA
AS
@XSD
END TRY
BEGIN CATCH 
	SELECT ERROR_MESSAGE() 
END CATCH 
GO
if not substring(@@version, 1, 25) in ('Microsoft SQL Server 2000')
BEGIN
    DECLARE 
        @SQL varchar(200),
        @Nivel int,
        @Database varchar(256)
    
    SELECT @SQL = 'ALTER DATABASE ['+DB_NAME()+'] SET TRUSTWORTHY ON;'
    EXEC(@SQL)

    SELECT @Nivel = Nivel 
      FROM tmpNivel

    IF @Nivel IS NOT NULL
    BEGIN
        if substring(@@version, 1, 25) in ('Microsoft SQL Server 2005')
        BEGIN
          SET @Database = DB_NAME()
          EXEC dbo.sp_dbcmptlevel @Database, @Nivel
        END
        if not substring(@@version, 1, 25) in ('Microsoft SQL Server 2000','Microsoft SQL Server 2005')
        BEGIN
          SELECT @SQL = 'ALTER DATABASE ['+DB_NAME()+'] SET COMPATIBILITY_LEVEL = '+CONVERT(varchar,@Nivel)+';'
          EXEC(@SQL)
        END
    END

END
GO
/************************************************** Tablas **************************************************/
/****** DIOTPagoConciliado ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTPagoConciliado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTPagoConciliado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTPagoConciliado') and type = 'U') 
  CREATE TABLE dbo.DIOTPagoConciliado(
    RID					int identity(1,1) NOT NULL,
	Mov					varchar(20) NULL,
    Aplica				varchar(20) NULL,	
	
	CONSTRAINT priDIOTPagoConciliado PRIMARY KEY CLUSTERED (RID)
)
GO

/****** DIOTGastoAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTGastoAdicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTGastoAdicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTGastoAdicion') and type = 'U') 
  CREATE TABLE dbo.DIOTGastoAdicion(
	Mov					varchar(20),
	CONSTRAINT priDIOTGastoAdicion PRIMARY KEY CLUSTERED (Mov)
)
GO

/****** DIOTCfg ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTCfg')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTCfg','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTCfg') and type = 'U')
CREATE TABLE DIOTCfg(
	Empresa						varchar(5),
	CalcularBaseImportacion		bit			DEFAULT 0,
	CONSTRAINT priDIOTCfg PRIMARY KEY CLUSTERED(Empresa)
)
GO

EXEC spALTER_TABLE 'DIOTCfg', 'CxpAnticiposPagadosPeriodo', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO
EXEC SPALTER_TABLE 'DIOTCfg', 'GASIncluirComprobantes', 'bit NOT NULL DEFAULT 1 WITH VALUES'
GO
EXEC SPALTER_TABLE 'DIOTCfg', 'GASIncluirMovSinCxp', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG24887
EXEC SPALTER_TABLE 'DIOTCfg', 'COMSIVAImportacionAnticipado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

/****** DIOTProvTipoOperacion ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTProvTipoOperacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTProvTipoOperacion','Maestro')
if not exists (select * from sysobjects where id = object_id('DIOTProvTipoOperacion') and type = 'U')
CREATE TABLE DIOTProvTipoOperacion(
  Proveedor			varchar(20),
  TipoOperacion		varchar(50),
  CONSTRAINT priDIOTProvTipoOperacion PRIMARY KEY CLUSTERED(Proveedor)
)
GO
  
/****** DIOTIVARubro ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTIVARubro')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTIVARubro','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTIVARubro') and type = 'U')
CREATE TABLE DIOTIVARubro(
	Rubro				int,
	Descripcion			varchar(255),
	Signo				varchar(8),
	CONSTRAINT priDIOTIVARubro PRIMARY KEY CLUSTERED(Rubro)
)
GO

/****** DIOTIVARubroCondicion ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTIVARubroCondicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTIVARubroCondicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTIVARubroCondicion') and type = 'U')
CREATE TABLE DIOTIVARubroCondicion(
    RID					int		IDENTITY,
    Rubro				int,
	Concepto			varchar(255),
	Operador			varchar(255),
	Valor				varchar(max),
	CONSTRAINT priDIOTIVARubroCondicion PRIMARY KEY CLUSTERED(RID)
)
GO

/****** DIOTPagoClave ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTPagoClave')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTPagoClave','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTPagoClave') and type = 'U')
CREATE TABLE DIOTPagoClave(
    Clave			varchar(20),
	CONSTRAINT priDIOTPagoClave PRIMARY KEY CLUSTERED(Clave)
)
GO

/****** DIOTPagoExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTPagoExcepcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTPagoExcepcion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTPagoExcepcion') and type = 'U') 
  CREATE TABLE dbo.DIOTPagoExcepcion (
    RID					int identity(1,1) NOT NULL,
	Mov					varchar(20) NULL,
    Aplica				varchar(20) NULL,	
	
	CONSTRAINT priDIOTPagoExcepcion PRIMARY KEY CLUSTERED (RID)
)
GO

/****** DIOTPagoAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTPagoAdicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTPagoAdicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTPagoAdicion') and type = 'U') 
  CREATE TABLE dbo.DIOTPagoAdicion (
    RID					int identity(1,1) NOT NULL,
	Mov					varchar(20) NULL,
    Aplica				varchar(20) NULL,	
	
	CONSTRAINT priDIOTPagoAdicion PRIMARY KEY CLUSTERED (RID)
)
GO

/****** DIOTConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTConcepto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTConcepto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTConcepto') and type = 'U') 
  CREATE TABLE DIOTConcepto(
    Concepto		varchar(50),
    CONSTRAINT priDIOTConcepto PRIMARY KEY CLUSTERED(Concepto)
)
GO

/****** DIOTConceptoImportacion ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTConceptoImportacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTConceptoImportacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTConceptoImportacion') and type = 'U') 
  CREATE TABLE DIOTConceptoImportacion(
    Concepto		varchar(50),
    CONSTRAINT priDIOTConceptoImportacion PRIMARY KEY CLUSTERED(Concepto)
)
GO

/****** DIOTConceptoIVAImportacion ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTConceptoIVAImportacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTConceptoIVAImportacion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTConceptoIVAImportacion') and type = 'U') 
  CREATE TABLE DIOTConceptoIVAImportacion(
    Concepto		varchar(50),
    CONSTRAINT priDIOTConceptoIVAImportacion PRIMARY KEY CLUSTERED(Concepto)
)
GO

/****** DIOTArt ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTArt')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTArt','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTArt') and type = 'U') 
  CREATE TABLE DIOTArt(
    Articulo		varchar(20),
    CONSTRAINT priDIOTArt PRIMARY KEY CLUSTERED(Articulo)
)
GO

/****** DIOTPais ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTPais') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTPais','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTPais') and type = 'U') 
  CREATE TABLE dbo.DIOTPais (
	Pais				varchar(50) NOT NULL,
	Nacionalidad		varchar(50) NULL,
	Clave				varchar(2)  NULL,

	CONSTRAINT priDIOTPais PRIMARY KEY CLUSTERED (Pais)
	)
GO

/****** DIOT ******/
if not exists(select * from SysTabla where SysTabla = 'DIOT')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('DIOT', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOT') and type = 'U') 
  CREATE TABLE DIOT(
    RID				int			IDENTITY,
    EstacionTrabajo int			NULL,
    Rubro			int			NULL,
    Descripcion		varchar(255)NULL,
    Importe			float		NULL,
    IVA				float		NULL,
    CONSTRAINT priDIOT PRIMARY KEY CLUSTERED(RID)
	)
GO

/****** DIOTD ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTD')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('DIOTD', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTD') and type = 'U') 
  CREATE TABLE DIOTD(
    RID				int			IDENTITY,
    EstacionTrabajo int			NULL,
    Empresa			varchar(5)	NULL,
    Mov				varchar(20)	NULL,
    MovID			varchar(20)	NULL,
    Pago			varchar(20)	NULL,
    PagoID			varchar(20)	NULL,
    Proveedor		varchar(10)	NULL,
    Nombre			varchar(100)NULL,
    RFC				varchar(15)	NULL,
    Tasa			float		NULL,
    TipoDocumento	varchar(20) NULL,
    TipoTercero		varchar(20) NULL,
    TipoOperacion	int			NULL,
    Pais			varchar(50) NULL,
    Nacionalidad	varchar(50) NULL,
    FechaEmision	datetime	NULL,
    FechaPago		datetime	NULL,
    Ejercicio		int			NULL,
    Periodo			int			NULL,
    Importe			float		NULL,
    IVA				float		NULL,
    Retencion2		float		NULL,
    Factor			float		NULL,    
    EsImportacion	bit			NULL,
    EsExcento		bit			NULL,
    ConceptoClave	varchar(50) NULL,
    --BUG24767
    Concepto		varchar(100)NULL,
    CONSTRAINT priDIOTD PRIMARY KEY CLUSTERED(RID)
 )
GO


EXEC spADD_INDEX 'DIOTD', 'Proveedor', 'EstacionTrabajo, Proveedor'
EXEC spADD_INDEX 'DIOTD', 'Importe', 'Proveedor, EstacionTrabajo, TipoOperacion)INCLUDE(Importe, IVA, Retencion2'
GO

EXEC spALTER_TABLE 'DIOTD', 'ImportadorRegistro', 'varchar(30) NULL'
GO

--BUG22834
EXEC spALTER_TABLE 'DIOTD', 'BaseIVAImportacion', 'float NULL'
GO

EXEC spALTER_TABLE 'DIOTD', 'DineroMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'DIOTD', 'DineroMovID', 'varchar(20) NULL'
--BUG24767
EXEC spALTER_COLUMN 'DIOTD', 'Concepto', 'varchar(100)NULL'
GO

--BUG24755
EXEC spALTER_TABLE 'DIOTD', 'PorcentajeDeducible', 'float NOT NULL DEFAULT 100 WITH VALUES'
GO

--TAREA 4354
EXEC spALTER_TABLE 'DIOTD', 'DineroMov2',			'varchar(20) NULL'
EXEC spALTER_TABLE 'DIOTD', 'DineroMovID2',			'varchar(20) NULL'
EXEC spALTER_TABLE 'DIOTD', 'DineroImporte',		'float NULL'
EXEC spALTER_TABLE 'DIOTD', 'DineroFormaPago',		'varchar(50) NULL'
EXEC spALTER_TABLE 'DIOTD', 'ContID',				'int NULL'
EXEC spALTER_TABLE 'DIOTD', 'ContMov',				'varchar(20) NULL'
EXEC spALTER_TABLE 'DIOTD', 'ContMovID',			'varchar(20) NULL'
GO


/****** DIOTLayout ******/
if not exists(select * from SysTabla where SysTabla = 'DIOTLayout')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('DIOTLayout', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DIOTLayout') and type = 'U') 
  CREATE TABLE DIOTLayout(
    RID						int			IDENTITY,
    EstacionTrabajo			int			NULL,
    TipoTercero				varchar(2)	COLLATE Database_Default	NULL,
    TipoOperacion			varchar(2)	COLLATE Database_Default	NULL,
    RFC						varchar(13)	COLLATE Database_Default	NULL,
	IDFiscal				varchar(40)	COLLATE Database_Default	NULL,
	NombreExtranjero		varchar(43)	COLLATE Database_Default	NULL,
	Pais					varchar(2)	COLLATE Database_Default	NULL,
	Nacionalidad			varchar(40)	COLLATE Database_Default	NULL,
    Rubro1					float		NULL,
    Rubro1IVA				float		NULL,
    Rubro2					float		NULL,
    Rubro2IVA				float		NULL,
    Rubro3					float		NULL,
    Rubro3IVA				float		NULL,
    Rubro4					float		NULL,
    Rubro4IVA				float		NULL,
    Rubro5					float		NULL,
    Rubro6					float		NULL,    
    Rubro7					float		NULL,
    Retencion2				float		NULL,
    Rubro10IVA				float		NULL,
    Cadena					varchar(max)NULL
    )
GO

--BUG22150
EXEC spALTER_COLUMN 'DIOTLayout', 'RFC', 'varchar(15)	COLLATE Database_Default	NULL'
EXEC spALTER_COLUMN 'DIOTLayout', 'NombreExtranjero', 'varchar(100)	COLLATE Database_Default	NULL'
GO

/****************************     CATÁLOGO DE PERIODICIDAD     ************************************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'DIOTCatPeriodicidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTCatPeriodicidad','Maestro')
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.DIOTCatPeriodicidad') AND TYPE = 'U') 
	CREATE TABLE dbo.DIOTCatPeriodicidad(
		Clave			varchar(2)	NOT NULL,
		Descripcion		varchar(50)	NOT NULL,
		CONSTRAINT priDIOTCatPeriodicidad PRIMARY KEY  CLUSTERED (Clave)
	)
GO

/*******************************     CATÁLOGO DE PERIODOS     *************************************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'DIOTCatPeriodo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTCatPeriodo','Maestro')
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.DIOTCatPeriodo') AND TYPE = 'U') 
	CREATE TABLE dbo.DIOTCatPeriodo(
		ClavePeriodicidad	varchar(2)	NOT NULL,
		ClavePeriodo		varchar(2)	NOT NULL,
		Descripcion			varchar(50)	NOT NULL,
		FechaInicio			varchar(6)	NULL,
		FechaFin			varchar(6)	NULL,
		CONSTRAINT priDIOTCatPeriodo PRIMARY KEY  CLUSTERED (ClavePeriodicidad, ClavePeriodo)
	)
GO

/*******************************     CATÁLOGO DE PERIODOS     *************************************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'DIOTHistArchivos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTHistArchivos','N/A')
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.DIOTHistArchivos') AND TYPE = 'U') 
	CREATE TABLE dbo.DIOTHistArchivos(
		ID					int identity(1,1)	NOT NULL,
		Empresa				varchar(5)	NOT NULL,
		RFC					varchar(13)	NOT NULL,
		Ejercicio			int			NOT NULL,
		TipoPeriodo			varchar(2)	NOT NULL,
		Periodo				varchar(2)	NOT NULL,
		TipoDeclaracion		varchar(1)	NOT NULL,
		FechaEmision		datetime	NOT NULL
		CONSTRAINT priDIOTHistArchivos PRIMARY KEY CLUSTERED (ID, Empresa, Ejercicio, TipoPeriodo, Periodo)
	)
GO

/**************************************** Parámetros DIOT *****************************************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'DIOTParamXML')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DIOTParamXML','N/A')
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.DIOTParamXML') AND TYPE = 'U') 
	CREATE TABLE dbo.DIOTParamXML(
		Estacion		int			NOT NULL,
		Ejercicio		int			NOT NULL,
		TipoPeriodo		varchar(2)	NOT NULL,
		Periodo			varchar(2)	NOT NULL,
		DPIVA			bit			NOT NULL DEFAULT 1,
		TipoDec			bit			NOT NULL DEFAULT 0,
		FolioAnt		varchar(14)	NULL,
		FechaAnt		datetime	NULL	
	)
GO

/************************************************** Registros **************************************************/
DELETE DIOTIVARubro
GO
IF NOT EXISTS(SELECT * FROM DIOTIVARubro)
BEGIN
  INSERT INTO DIOTIVARubro(Rubro, Descripcion, Signo) SELECT 1, 'IVA Acreditable a la tasa 16%', 'Positivo'
  INSERT INTO DIOTIVARubro(Rubro, Descripcion, Signo) SELECT 2, 'IVA de Importación 16%', 'Positivo'
  INSERT INTO DIOTIVARubro(Rubro, Descripcion, Signo) SELECT 3, 'Valor de los actos pagadas en la importación exentas', 'Positivo'
  INSERT INTO DIOTIVARubro(Rubro, Descripcion, Signo) SELECT 4, 'Actividades a tasa 0 % otros', 'Positivo'
  INSERT INTO DIOTIVARubro(Rubro, Descripcion, Signo) SELECT 5, 'Valor de los actos o actividades exentas', 'Positivo'
  INSERT INTO DIOTIVARubro(Rubro, Descripcion, Signo) SELECT 6, 'IVA al 16% periodos anteriores y otros', 'Positivo'
  INSERT INTO DIOTIVARubro(Rubro, Descripcion, Signo) SELECT 7, 'IVA correspondiente a dev., desctos. y bonificaciones s/comp', 'Positivo'
END
GO

DELETE DIOTIVARubroCondicion
GO
IF NOT EXISTS(SELECT * FROM DIOTIVARubroCondicion)
BEGIN
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (1,'Tasa','En','16')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (2,'Tasa','En','16')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (2,'Es Importacion','Igual a','1')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (1,'Tipo Tercero','Igual a','Nacional')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (2,'Tipo Tercero','Igual a','Extranjero')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (7,'Tipo Documento','En',"'Nota Credito', 'Devolucion'")
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (3,'Tipo Tercero','Igual a','Extranjero')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (3,'Es Importacion','Igual a','1')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (3,'Tasa','Igual a','0')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (5,'Es Excento','Igual a','1')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (4,'Tasa','Igual a','0')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (1,'Es Excento','Igual a','0')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (1,'Es Importacion','Igual a','0')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (4,'Es Excento','Igual a','0')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (4,'Es Importacion','Igual a','0')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (2,'Es Excento','Igual a','0')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (3,'Es Excento','Igual a','1')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (1,'Tipo Documento','No En',"'Nota Credito', 'Devolucion'")
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (2,'Tipo Documento','No En',"'Nota Credito', 'Devolucion'")
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (3,'Tipo Documento','No En',"'Nota Credito', 'Devolucion'")
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (4,'Tipo Documento','No En',"'Nota Credito', 'Devolucion'")
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (6,'Es Excento','Igual a','0')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (6,'Tasa','Distinto que','16')
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (6,'Tipo Documento','No En',"'Nota Credito', 'Devolucion'")
  INSERT INTO DIOTIVARubroCondicion (Rubro,Concepto,Operador,Valor) VALUES (4,'Tipo Tercero','Igual a','Nacional')
END
GO

IF NOT EXISTS(SELECT * FROM DIOTPagoClave)
BEGIN
  INSERT INTO DIOTPagoClave(Clave) SELECT 'CXP.DP'
  INSERT INTO DIOTPagoClave(Clave) SELECT 'CXP.NCP'
  INSERT INTO DIOTPagoClave(Clave) SELECT 'CXP.P'
  INSERT INTO DIOTPagoClave(Clave) SELECT 'CXP.DC'
  INSERT INTO DIOTPagoClave(Clave) SELECT 'CXP.NC'
  INSERT INTO DIOTPagoClave(Clave) SELECT 'CXP.NET'  
END
GO

IF NOT EXISTS(SELECT * FROM DIOTCfg)
  INSERT INTO DIOTCfg(Empresa) SELECT Empresa FROM Empresa
GO

IF NOT EXISTS(SELECT * FROM DIOTPais)
BEGIN
  INSERT DIOTPais (Pais, Nacionalidad, Clave) VALUES ('Mexico', 'Mexicano', '')
  INSERT DIOTPais (Pais, Nacionalidad, Clave) VALUES ('Estados Unidos', 'Estadounidense', 'US')
  INSERT DIOTPais (Pais, Nacionalidad, Clave) VALUES ('Canada', 'Canadiense', 'CA')
END
GO

--BUG24768
IF NOT EXISTS(SELECT * FROM DIOTArt)
BEGIN
  INSERT INTO DIOTArt(Articulo) SELECT Articulo FROM Art
END
GO

--BUG24768
IF NOT EXISTS(SELECT * FROM DIOTConcepto)
BEGIN
  INSERT INTO DIOTConcepto(Concepto) SELECT Concepto FROM Concepto WHERE EsDeducible = 1 AND Modulo = 'GAS'
END
GO

IF NOT EXISTS(SELECT * FROM DIOTCatPeriodicidad)
BEGIN
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('01','Mensual')
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('02','Bimestral')
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('03','Trimestral')
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('04','Cuatrimestral')
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('05','Semestral')
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('06','Semestral por Liquidación')
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('07','Del Ejercicio')
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('08','Del ejercicio por liquidación')
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('09','Ajuste')
	INSERT DIOTCatPeriodicidad(Clave, Descripcion) VALUES('10','Sin Periodo')
END
GO

IF NOT EXISTS(SELECT * FROM DIOTCatPeriodicidad)
BEGIN
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','01','Enero','01/01/','31/01/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','02','Febrero','01/02/','28/02/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','03','Marzo','01/03/','31/03/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','04','Abril','01/04/','30/04/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','05','Mayo','01/05/','31/05/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','06','Junio','01/06/','30/06/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','07','Julio','01/07/','31/07/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','08','Agosto','01/08/','31/08/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','09','Septiembre','01/09/','30/09/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','10','Octubre','01/10/','31/10/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','11','Noviembre','01/11/','30/11/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('01','12','Diciembre','01/12/','31/12/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('02','13','Enero-Febrero','01/01/','28/02/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('02','14','Marzo-Abril','01/03/','30/04/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('02','15','Mayo-Junio','01/05/','30/06/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('02','16','Julio-Agosto','01/07/','31/08/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('02','17','Septiembre-Octubre','01/09/','31/10/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('02','18','Noviembre-Diciembre','01/11/','31/12/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('03','19','Enero-Marzo','01/01/','31/03/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('03','20','Abril-Junio','01/04/','30/06/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('03','21','Julio-Septiembre','01/07/','30/09/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('03','22','Octubre-Diciembre','01/10/','31/12/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('04','23','Enero-Abril','01/01/','30/04/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('04','24','Mayo-Agosto','01/05/','31/08/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('04','25','Septiembre-Diciembre','01/09/','31/12/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('05','26','Enero-Junio','01/01/','30/06/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('05','27','Julio-Diciembre','01/07/','31/12/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','28','Enero-Junio','01/01/','30/06/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','29','Febrero-Julio','01/02/','31/07/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','30','Marzo-Agosto','01/03/','31/08/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','31','Abril-Septiembre','01/04/','30/09/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','32','Mayo-Octubre','01/05/','31/10/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','33','Junio-Noviembre','01/06/','30/11/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','34','Julio-Diciembre','01/07/','31/12/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','35','Agosto-Enero','01/08/','31/01/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','36','Septiembre-Febrero','01/09/','28/02/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','37','Octubre-Marzo','01/10/','31/03/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','38','Noviembre-Abril','01/11/','30/04/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('06','39','Diciembre-Mayo','01/12/','31/05/')
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('09','40','Ajuste del Ejercicio',NULL,NULL)
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('07','41','Del Ejercicio',NULL,NULL)
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('08','42','Ejercicio por Liquidación',NULL,NULL)
	INSERT DIOTCatPeriodo(ClavePeriodicidad, ClavePeriodo, Descripcion, FechaInicio, FechaFin) VALUES('10','43','Sin periodo',NULL,NULL)
END
GO

/************************************************** Triggers **************************************************/
--BUG24768
/******************************* tgDIOTArt *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgDIOTArt') AND TYPE = 'tr') DROP TRIGGER tgDIOTArt
GO
CREATE TRIGGER tgDIOTArt ON Art
FOR INSERT, UPDATE
AS
BEGIN
  DECLARE @Articulo			varchar(20),
          @EsDeducible		bit
  
  SELECT @Articulo = Articulo, @EsDeducible = ISNULL(EsDeducible, 0) FROM Inserted
  
  IF UPDATE(EsDeducible)
  BEGIN
    IF @EsDeducible = 1
    BEGIN
      IF NOT EXISTS(SELECT Articulo FROM DIOTArt WHERE Articulo = @Articulo)
        INSERT INTO DIOTArt(Articulo) VALUES(@Articulo)
    END
    ELSE IF @EsDeducible = 0
      DELETE DIOTArt WHERE Articulo = @Articulo
      
  END
  RETURN
END
GO

--BUG24768
/******************************* tgDIOTConcepto *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgDIOTConcepto') AND TYPE = 'tr') DROP TRIGGER tgDIOTConcepto
GO
CREATE TRIGGER tgDIOTConcepto ON Concepto
FOR INSERT, UPDATE
AS
BEGIN
  DECLARE @Concepto			varchar(50),
          @EsDeducible		bit,
          @Modulo			varchar(5)
  
  SELECT @Concepto = Concepto, @EsDeducible = ISNULL(EsDeducible, 0), @Modulo = Modulo FROM Inserted
  
  IF UPDATE(EsDeducible) AND @Modulo = 'GAS'
  BEGIN
    IF @EsDeducible = 1
    BEGIN
      IF NOT EXISTS(SELECT Concepto FROM DIOTConcepto WHERE Concepto = @Concepto)
        INSERT INTO DIOTConcepto(Concepto) VALUES(@Concepto)
    END
    ELSE IF @EsDeducible = 0
      DELETE DIOTConcepto WHERE Concepto = @Concepto
  END
  RETURN
END
GO

/************************************************** Funciones **************************************************/
/**************** fnDIOTLayoutImporte ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTLayoutImporte') drop function dbo.fnDIOTLayoutImporte
GO
CREATE FUNCTION fnDIOTLayoutImporte(
				@Importe		float
				)
RETURNS int
AS
BEGIN
  DECLARE @Entero		int,
		  @Decimal		float

  SELECT @Entero = ISNULL(@Importe, 0)

  SELECT @Decimal = @Importe - @Entero

  IF @Decimal >= 0.5
    SELECT @Entero = @Entero + 1
  
  RETURN @Entero
END
GO

/**************** fnDIOTIVAImportacion ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTIVAImportacion') drop function dbo.fnDIOTIVAImportacion
GO
CREATE FUNCTION fnDIOTIVAImportacion(
				@Mov							varchar(20), 
				@MovID							varchar(20), 
				@Empresa						varchar(5),
				@CalcularBaseImportacion		bit
				)				
RETURNS float
AS
BEGIN
  DECLARE @Valor		float

  SELECT @Valor = SUM(ISNULL(Importe,0.0) + ISNULL(IVA,0.0) + ISNULL(IEPS,0.0) + ISNULL(ISAN,0.0) - ISNULL(Retencion1,0.0) - ISNULL(Retencion2,0.0))
    FROM DIOTCxpDocumentoImportacion
    JOIN DIOTConceptoIVAImportacion ON DIOTCxpDocumentoImportacion.Concepto = DIOTConceptoIVAImportacion.Concepto
   WHERE Empresa  = @Empresa
     AND Origen   = @Mov
     AND OrigenID = @MovID

  RETURN ISNULL(@Valor, 0)
END
GO

/**************** fnDIOTTasaIVAImportacion ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTTasaIVAImportacion') drop function fnDIOTTasaIVAImportacion
GO
CREATE FUNCTION fnDIOTTasaIVAImportacion(
				@Mov							varchar(20), 
				@MovID							varchar(20), 
				@Empresa						varchar(5),
				@CalcularBaseImportacion		bit,
				--BUG24887
				@Impuesto1						float
				)				
RETURNS float
AS
BEGIN
  DECLARE @Valor		float

  SELECT @Valor = Tasa
    FROM DIOTCxpDocumentoImportacion
   WHERE Empresa  = @Empresa
     AND Origen   = @Mov
     AND OrigenID = @MovID
     AND NULLIF(Tasa, 0) IS NOT NULL

  --BUG24887
  IF @Valor IS NULL
    SELECT @Valor = @Impuesto1
     
  RETURN ISNULL(@Valor, 0)
END
GO

/**************** fnDIOTBaseIVAImportacion ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTBaseIVAImportacion') drop function dbo.fnDIOTBaseIVAImportacion
GO
CREATE FUNCTION fnDIOTBaseIVAImportacion(
				@Mov						varchar(20), 
				@MovID						varchar(20), 
				@Empresa					varchar(5),
				@CalcularBaseImportacion	bit
				)				
RETURNS float
AS
BEGIN
  DECLARE @Valor		float

  SELECT @Valor = SUM(ISNULL(Importe,0.0) + ISNULL(IVA,0.0) + ISNULL(IEPS,0.0) + ISNULL(ISAN,0.0) - ISNULL(Retencion1,0.0) - ISNULL(Retencion2,0.0))
    FROM DIOTCxpDocumentoImportacion
    JOIN DIOTConceptoImportacion ON DIOTCxpDocumentoImportacion.Concepto = DIOTConceptoImportacion.Concepto
   WHERE Empresa  = @Empresa
     AND Origen   = @Mov
     AND OrigenID = @MovID

  RETURN ISNULL(@Valor, 0)
END
GO

/**************** fnDIOTTipoDocumento ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTTipoDocumento') drop function dbo.fnDIOTTipoDocumento
GO
CREATE FUNCTION fnDIOTTipoDocumento(
				@Modulo							varchar(5), 
				@Mov							varchar(20)
				)				
RETURNS varchar(20)
AS
BEGIN
  DECLARE @Clave		varchar(20),
		  @Valor		varchar(20)
  
  SELECT @Clave = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov

  SELECT @Valor = CASE
                    WHEN @Clave IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA','COMS.GX') THEN 'Factura'
                    WHEN @Clave IN ('COMS.B') THEN 'Nota Credito'
                    WHEN @Clave IN ('COMS.D') THEN 'Devolucion'
                    WHEN @Clave IN ('GAS.A','GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.CCH','GAS.CP','GAS.CB') THEN 'Factura'
                    WHEN @Clave IN ('GAS.DA','GAS.DG','GAS.DC','GAS.DGP','GAS.OI','GAS.AB') THEN 'Nota Credito'
                    WHEN @Clave IN ('CXP.AF','CXP.A') THEN 'Anticipo' 
                    WHEN @Clave IN ('CXP.CA','CXP.F','CXP.CD','CXP.D') THEN 'Factura'
                    WHEN @Clave IN ('CXP.NC') THEN 'Devolucion'
                    WHEN @Clave IN ('CXP.CA') THEN 'Nota Credito'
                    ELSE 'Factura'
                  END
  RETURN @Valor
END
GO

/**************** fnDIOTEsImportacion ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTEsImportacion') drop function dbo.fnDIOTEsImportacion
GO
CREATE FUNCTION fnDIOTEsImportacion(
				@Modulo							varchar(5), 
				@Mov							varchar(20)
				)				
RETURNS bit
AS
BEGIN
  DECLARE @Clave		varchar(20),
		  @Valor		bit
  
  SELECT @Clave = Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov

  SELECT @Valor = CASE
                    WHEN @Clave IN ('COMS.EI','COMS.GX') THEN 1
                    ELSE 0
                  END
  RETURN @Valor
END
GO

/**************** fnDIOTTipoTercero ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTTipoTercero') drop function dbo.fnDIOTTipoTercero
GO
CREATE FUNCTION fnDIOTTipoTercero(
				@Proveedor				varchar(10)
				)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @Valor		varchar(20)
  
  SELECT @Valor = CASE 
                    WHEN ISNULL(FiscalRegimen.Extranjero,0) = 0 THEN 'Nacional'
                    WHEN ISNULL(FiscalRegimen.Extranjero,0) = 1 THEN 'Extranjero'
                  END
     FROM Prov
     JOIN FiscalRegimen ON Prov.FiscalRegimen = FiscalRegimen.FiscalRegimen 
    WHERE Prov.Proveedor = @Proveedor

  RETURN ISNULL(NULLIF(RTRIM(@Valor), ''), 'Nacional')
END
GO

/**************** fnDIOTIVAFiscal ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTIVAFiscal') drop function dbo.fnDIOTIVAFiscal
GO
CREATE FUNCTION fnDIOTIVAFiscal (@Importe float, @Impuestos float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    (ISNULL(@Impuestos,0.0)/NULLIF((ISNULL(@Importe,0.0)+ISNULL(@Impuestos,0.0)),0.0))
END
GO

/**************** fnDIOTIVATasa ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTIVATasa') drop function dbo.fnDIOTIVATasa
GO
CREATE FUNCTION fnDIOTIVATasa (@Empresa varchar(5), @Importe float, @Impuestos float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  DECLARE 
  @IVAFiscal float,
  @Tasa		 float
 
  SET @Importe = ISNULL(@Importe,0.0)
  SET @Impuestos = ISNULL(@Impuestos,0.0)
  
  SET @IVAFiscal = dbo.fnMFAIVAFiscal(@Importe,@Impuestos)
 
  IF @Importe = 0 AND @Impuestos <> 0
    SELECT @Tasa = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa  
  ELSE
    SELECT @Tasa = ROUND(((@Importe/NULLIF((1-@IVAFiscal),0.0))*@IVAFiscal)/NULLIF(@Importe,0.0),2)*100.0

  RETURN @Tasa
END
GO

/**************** fnDIOTIVA ****************/
if exists (select * FROM sysobjects WHERE name = 'fnDIOTIVA') drop function dbo.fnDIOTIVA
GO
CREATE FUNCTION fnDIOTIVA(@Importe float, @Impuestos float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  DECLARE 
  @IVAFiscal float
 
  SET @Importe = ISNULL(@Importe,0.0)
  SET @Impuestos = ISNULL(@Impuestos,0.0)
   
  SET @IVAFiscal = dbo.fnDIOTIVAFiscal(@Importe,@Impuestos)
 
  RETURN ((@Importe/NULLIF((1-@IVAFiscal),0.0))*@IVAFiscal)
    
END
GO

/*************************************     NombreArchivoDIOT     **********************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('NombreArchivoDIOT')) 
	DROP FUNCTION NombreArchivoDIOT
GO
CREATE FUNCTION dbo.NombreArchivoDIOT(
    @Estacion		int
) 
RETURNS varchar(50)
BEGIN
DECLARE 
	@Nombre				varchar(50),
    @RFC				varchar(13),
    @TipoPeriodo		varchar(2),
    @Periodo			varchar(2),
    @TipoDeclaracion	varchar(1),
    @MesInicio			varchar(2),
    @MesFin				varchar(2),
    @Anio				varchar(4),
    @Contador			int,
    @Empresa			varchar(5)
    
	SELECT @RFC = B.RFC, @Empresa = B.Empresa
	  FROM DiotD A
	  JOIN Empresa B ON A.Empresa = B.Empresa
	 WHERE A.EstacionTrabajo = @Estacion
	
	SELECT @Anio = Ejercicio, @TipoPeriodo = TipoPeriodo, @Periodo = Periodo, @TipoDeclaracion = CASE WHEN TipoDec = 0 THEN 'N' ELSE 'C' END
	  FROM DIOTParamXML 
	 WHERE Estacion = @Estacion

		
	SELECT @MesInicio = SUBSTRING(FechaInicio,4,2), @MesFin = SUBSTRING(FechaFin,4,2)
	  FROM DIOTCatPeriodo
	 WHERE ClavePeriodicidad = @TipoPeriodo
	   AND ClavePeriodo = @Periodo
	   
	SELECT @Contador = COUNT(*)+1
	  FROM DIOTHistArchivos 
	 WHERE Empresa = @Empresa
	   AND Ejercicio = @Anio
	   AND TipoPeriodo = @TipoPeriodo
	   AND Periodo = @Periodo
	   AND TipoDeclaracion = @TipoDeclaracion


SELECT @Nombre = @RFC+@TipoPeriodo+@Periodo+@TipoDeclaracion+@MesInicio+@MesFin+SUBSTRING(@Anio,3,2)+
				 CASE WHEN @Contador < 9 THEN '0'+CAST(@Contador AS VARCHAR(2)) ELSE CAST(@Contador AS VARCHAR(2)) END
RETURN @Nombre
END
GO

/************************************************** Vistas **************************************************/
/*** DIOTMovClaveCXPP ***/
if exists (select * from sysobjects where id = object_id('dbo.DIOTMovClaveCXPP') and type = 'V') drop view dbo.DIOTMovClaveCXPP
GO
CREATE VIEW DIOTMovClaveCXPP
AS
  SELECT * FROM MovClave WHERE Modulo = 'CXP'
GO

/*** DIOTCxpDocumentoImportacion ***/
if exists (select * from sysobjects where id = object_id('dbo.DIOTCxpDocumentoImportacion') and type = 'V') drop view dbo.DIOTCxpDocumentoImportacion
GO
CREATE VIEW DIOTCxpDocumentoImportacion AS
-- Movimientos que no se prorratearon y provienen de una Entrada Importacion
SELECT
  Origen				 = c.Origen,	
  OrigenID				 = c.OrigenID,
  Estatus                = c.Estatus,
  ID					 = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  Empresa                = c.Empresa,
  Cxp.Mov,
  Cxp.MovID,
  Cxp.FechaEmision,
  Ejercicio              = Cxp.Ejercicio,
  Periodo                = Cxp.Periodo,
  Dia                    = DAY(Cxp.FechaEmision),
  Cxp.Proveedor,
  Concepto               = d.Concepto,
  Importe                = Cxp.Importe*Cxp.TipoCambio,
  Retencion1			 = 0.0, 
  Retencion2			 = Cxp.Retencion*Cxp.TipoCambio,
  IVA                    = dbo.fnDIOTIVA(Cxp.Importe,Cxp.Impuestos)*Cxp.TipoCambio,  
  --BUG24887
  Tasa                   = dbo.fnDIOTIVATasa(Cxp.Empresa, Cxp.Importe,Cxp.Impuestos),
  IEPS                   = (ISNULL(CONVERT(float,Cxp.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)*Cxp.TipoCambio,
  ISAN                   = 0.0
  FROM Cxp
  JOIN Gasto c    ON c.MovID = Cxp.OrigenID AND c.Mov = Cxp.Origen AND Cxp.OrigenTipo = 'GAS' AND C.Empresa = Cxp.Empresa
  JOIN Compra com ON com.MovID = c.OrigenID AND com.Mov = c.Origen AND c.OrigenTipo = 'COMS' AND com.Empresa = Cxp.Empresa
  JOIN GastoD d   ON c.ID = d.ID
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  JOIN Concepto co ON co.Concepto = d.Concepto AND co.Modulo = 'COMSG'
  JOIN Version ver ON 1 = 1
  JOIN DIOTCfg ON Cxp.Empresa = DIOTCfg.Empresa
  LEFT OUTER JOIN CxpD cd ON cd.ID = c.ID 
 WHERE Cxp.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D'))
   AND Cxp.OrigenTipo IN ('GAS')
   AND ISNULL(com.ProrrateoAplicaID, 0) = 0
UNION ALL 
-- Movimientos que si se prorratearon y provienen de una Entrada Importacion
SELECT
  Origen				 = c.Origen,	
  OrigenID				 = c.OrigenID,
  Estatus                = c.Estatus,
  ID					 = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  Empresa                = c.Empresa,
  c.Mov,
  c.MovID,
  c.FechaEmision,
  Ejercicio              = c.Ejercicio,
  Periodo                = c.Periodo,
  Dia                    = DAY(c.FechaEmision),
  c.Proveedor,
  Concepto               = c.Concepto,
  Importe                = c.Importe*c.TipoCambio,
  Retencion1			 = 0.0, 
  Retencion2			 = c.Retencion*c.TipoCambio,
  IVA                    = dbo.fnDIOTIVA(c.Importe,c.Impuestos)*c.TipoCambio,  
  --BUG24887
  Tasa                   = dbo.fnDIOTIVATasa(c.Empresa, c.Importe,c.Impuestos),
  IEPS                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  ISAN                   = 0.0
  FROM Cxp c
  JOIN Compra com ON com.MovID = c.OrigenID AND com.Mov = c.Origen AND c.OrigenTipo = 'COMS' AND com.Empresa = c.Empresa  
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'COMSG'
  JOIN Version ver ON 1 = 1
  JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
  LEFT OUTER JOIN CxpD cd ON cd.ID = c.ID 
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D'))
   AND c.OrigenTipo IN ('COMS')
   AND ISNULL(com.ProrrateoAplicaID, 0) = 0
UNION ALL 
-- Movimientos que no se prorratearon y provienen de un Gasto Extemporaneo
SELECT
  Origen				 = o.Mov,	
  OrigenID				 = o.MovID,
  Estatus                = c.Estatus,
  ID					 = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  Empresa                = c.Empresa,
  Cxp.Mov,
  Cxp.MovID,
  Cxp.FechaEmision,
  Ejercicio              = Cxp.Ejercicio,
  Periodo                = Cxp.Periodo,
  Dia                    = DAY(Cxp.FechaEmision),
  Cxp.Proveedor,
  Concepto               = d.Concepto,
  Importe                = Cxp.Importe*Cxp.TipoCambio,
  Retencion1			 = 0.0, 
  Retencion2			 = Cxp.Retencion*Cxp.TipoCambio,
  IVA                    = dbo.fnDIOTIVA(Cxp.Importe,Cxp.Impuestos)*Cxp.TipoCambio,  
  --BUG24887
  Tasa                   = dbo.fnDIOTIVATasa(Cxp.Empresa, Cxp.Importe,Cxp.Impuestos),
  IEPS                   = (ISNULL(CONVERT(float,Cxp.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)*Cxp.TipoCambio,
  ISAN                   = 0.0
  FROM Cxp
  JOIN Gasto c    ON c.MovID = Cxp.OrigenID AND c.Mov = Cxp.Origen AND Cxp.OrigenTipo = 'GAS' AND C.Empresa = Cxp.Empresa
  JOIN Compra com ON com.MovID = c.OrigenID AND com.Mov = c.Origen AND c.OrigenTipo = 'COMS' AND com.Empresa = Cxp.Empresa
  JOIN GastoD d   ON c.ID = d.ID
  JOIN Compra o   ON O.ID = com.ProrrateoAplicaID
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  JOIN Concepto co ON co.Concepto = d.Concepto AND co.Modulo = 'COMSG'
  JOIN Version ver ON 1 = 1
  JOIN DIOTCfg ON Cxp.Empresa = DIOTCfg.Empresa
  LEFT OUTER JOIN CxpD cd ON cd.ID = c.ID 
 WHERE Cxp.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D'))
   AND Cxp.OrigenTipo IN ('GAS')
   AND ISNULL(com.ProrrateoAplicaID, 0) <> 0
UNION ALL 
-- Movimientos que si se prorratearon y provienen de un Gasto Extemporaneo   
SELECT
  Origen				 = o.Mov,
  OrigenID				 = o.MovID,
  Estatus                = c.Estatus,
  ID					 = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  Empresa                = c.Empresa,
  c.Mov,
  c.MovID,
  c.FechaEmision,
  Ejercicio              = c.Ejercicio,
  Periodo                = c.Periodo,
  Dia                    = DAY(c.FechaEmision),
  c.Proveedor,
  Concepto               = c.Concepto,
  Importe                = c.Importe*c.TipoCambio,
  Retencion1			 = 0.0, 
  Retencion2			 = c.Retencion*c.TipoCambio,
  IVA                    = dbo.fnDIOTIVA(c.Importe,c.Impuestos)*c.TipoCambio,  
  --BUG24887
  Tasa                   = dbo.fnDIOTIVATasa(c.Empresa,c.Importe,c.Impuestos),
  IEPS                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  ISAN                   = 0.0
  FROM Cxp c
  JOIN Compra com ON com.MovID = c.OrigenID AND com.Mov = c.Origen AND c.OrigenTipo = 'COMS' AND com.Empresa = c.Empresa  
  JOIN Compra o   ON o.ID = com.ProrrateoAplicaID  
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'COMSG'
  JOIN Version ver ON 1 = 1
  JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
  LEFT OUTER JOIN CxpD cd ON cd.ID = c.ID 
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D'))
   AND c.OrigenTipo IN ('COMS')
   AND ISNULL(com.ProrrateoAplicaID, 0) <> 0
GO

/************************************************** Procedimientos **************************************************/
/**************** spDIOTTipoOperacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOTTipoOperacion') and type = 'P') drop procedure dbo.spDIOTTipoOperacion
GO
CREATE PROC spDIOTTipoOperacion
			@EsExcento			bit,
			@EsImportacion		bit,
			@Tasa				float,
			@TipoDocumento		varchar(20),
			@TipoTercero		varchar(20),
			@Rubro				int			OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RubroAnt			int,
		  @SQL				nvarchar(max),
		  @Parametros		nvarchar(max),
		  @RID				int,
		  @RIDAnt			int,
          @Concepto			varchar(255),
		  @Operador			varchar(255),
		  @Valor			varchar(max),
		  @ValidaCondicion	bit
 
  SELECT @Parametros = '@EsExcento			bit,
		                @EsImportacion		bit,
		                @Tasa			    float,
		                @TipoDocumento		varchar(20),
		                @TipoTercero	    varchar(20),
		                @ValidaCondicion	bit			OUTPUT'
    
  SELECT @RubroAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @Rubro = MIN(Rubro)
      FROM DIOTIVARubro
     WHERE Rubro > @RubroAnt

    IF @Rubro IS NULL BREAK
  
    SELECT @RubroAnt = @Rubro

    IF NOT EXISTS(SELECT * FROM DIOTIVARubroCondicion WHERE Rubro = @Rubro)
      SELECT @ValidaCondicion = 0
    ELSE
    BEGIN
      SELECT @RIDAnt = 0
      SELECT @SQL = 'SET ANSI_NULLS OFF IF '
      WHILE(1=1)
      BEGIN
        SELECT @RID = MIN(RID)
          FROM DIOTIVARubroCondicion
         WHERE Rubro = @Rubro
           AND RID > @RIDAnt

        IF @RID IS NULL BREAK
    
        SELECT @RIDAnt = @RID
    
        SELECT @Concepto = NULL, @Operador = NULL, @Valor = NULL
      
        SELECT @Concepto = '@'+ REPLACE(Concepto, ' ', ''), 
               @Operador = Operador, 
               @Valor = Valor
          FROM DIOTIVARubroCondicion
         WHERE Rubro = @Rubro AND RID = @RID
 
        IF @Operador = 'Igual a'
          SELECT @SQL = @SQL + ' (' + @Concepto + ' = ''' + RTRIM(LTRIM(@Valor)) + ''') ' + ' AND '
        ELSE IF @Operador = 'Distinto que'
          SELECT @SQL = @SQL + ' (' + @Concepto + ' <> ''' + RTRIM(LTRIM(@Valor)) + ''') '  + ' AND '
        ELSE IF @Operador = 'En'
          SELECT @SQL = @SQL + ' (' + @Concepto + ' IN (' + RTRIM(LTRIM(@Valor)) + ')) ' + ' AND '
        ELSE IF @Operador = 'No En'
          SELECT @SQL = @SQL + ' (' + @Concepto + ' NOT IN (' + RTRIM(LTRIM(@Valor)) + ')) ' + ' AND '         
      END

      BEGIN TRY  
        SELECT @SQL = LEFT(@SQL, LEN(@SQL) - 3)
        SELECT @SQL = @SQL + ' SELECT @ValidaCondicion = 1 ELSE SELECT @ValidaCondicion = 0'
     
        EXEC sp_executesql @SQL, @Parametros, @EsExcento, @EsImportacion, @Tasa, @TipoDocumento, @TipoTercero, @ValidaCondicion OUTPUT      
      END TRY
      BEGIN CATCH  
        SELECT @ValidaCondicion = 0
      END CATCH
    END
    IF @ValidaCondicion = 1 BREAK
  END
  
  RETURN
END
GO

/**************** xpDIOTObtenerPago ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDIOTObtenerPago') and type = 'P') drop procedure dbo.xpDIOTObtenerPago
GO
CREATE PROC xpDIOTObtenerPago
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
AS
BEGIN
RETURN
END
GO

/**************** spDIOTObtenerPago ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOTObtenerPago') and type = 'P') drop procedure dbo.spDIOTObtenerPago
GO
CREATE PROC spDIOTObtenerPago
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS
BEGIN
	EXEC xpDIOTObtenerPago @Estacion, @Empresa, @FechaD, @FechaA

	IF NOT EXISTS (SELECT 1 FROM #Pagos WHERE TipoInsert = 1)
	-- Insertamos los movimientos de Tesorería
	INSERT INTO #Tesoreria( Empresa, ID, Mov, MovID, RID, FormaPago,
							Importe,FechaEmision, OrigenTipo, OrigenIID, Origen,
							OrigenMID,ContID, ContMov, ContMovID)			
					 SELECT A.Empresa, A.IDRaiz, A.MovRaiz, A.MovIDRaiz, C.Renglon,ISNULL(C.FormaPago,B.FormaPago), 
							ISNULL(C.Importe,ISNULL(B.Importe,0)),B.FechaEmision, A.OModulo, E.ID, A.OMov, 
							A.OID, B.ContID, D.Mov, D.MovID
					   FROM #Movtos A
				  LEFT JOIN Dinero B ON A.IDRaiz = B.ID
				  --LEFT JOIN DiotPagoConciliado PC ON B.Mov = PC.Mov
				  LEFT JOIN DineroD C ON A.IDRaiz = C.ID AND B.Origen = C.Aplica AND B.OrigenID = C.AplicaID
				  LEFT JOIN Cont D ON B.ContID = D.ID
				  LEFT JOIN Cxp E ON A.Empresa = E.Empresa
						AND A.OModulo = 'CXP' 
						AND A.OID= E.ID
					  --WHERE (PC.Mov IS NOT NULL AND B.Estatus = 'CONCILIADO') OR PC.Mov IS NULL
					 EXCEPT
					 SELECT Empresa, ID, Mov, MovID, RID, FormaPago,
							Importe,FechaEmision, OrigenTipo, OrigenIID, Origen,
							OrigenMID,ContID, ContMov, ContMovID
					   FROM #Tesoreria
  

  --SELECT * FROM #Tesoreria
  
  --Insertamos Los Pagos
  INSERT INTO #Pagos(ID, Empresa, Mov, MovID, Ejercicio, Periodo, FechaEmision, Aplica, AplicaID, Importe,
					 TipoCambio, Dinero, DineroID, FechaConciliacion, DineroMov, DineroMovID,
					 DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID,TipoInsert
					 )
			  SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END, d.Aplica, d.AplicaID, d.Importe*c.TipoCambio,
					 c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion, c.Dinero, c.DineroID,
					 t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID,1
			    FROM Cxp c
			    JOIN #Tesoreria t ON c.ID = t.OrigenIID AND c.Dinero = t.Mov AND c.DineroID = t.MovID
			    JOIN CxpD d ON c.ID = d.ID
			    JOIN Cxp o ON c.Empresa = o.Empresa AND d.Aplica = o.Mov AND d.AplicaID = o.MovID
			    JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'CXP'
			    JOIN Prov p ON c.Proveedor = p.Proveedor
	 LEFT OUTER JOIN DIOTPagoAdicion mtmda ON mtmda.Mov = c.Mov AND ISNULL(mtmda.Aplica, d.Aplica) = d.Aplica
	 LEFT OUTER JOIN DIOTPagoExcepcion mtmde ON mtmde.Mov = c.Mov AND ISNULL(mtmde.Aplica, d.Aplica) = d.Aplica
	 LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, d.Aplica) = d.Aplica
			    JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
			   WHERE mtmde.Mov IS NULL
				 AND (mt.Clave IN (SELECT Clave FROM DIOTPagoClave) OR (mtmda.Mov IS NOT NULL))
				 AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
				 AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA
				 --AND c.Estatus =('CONCLUIDO')
				 --AND o.Estatus IN('PENDIENTE','CONCLUIDO')
				 AND c.Empresa = @Empresa
				 
  --Insertamos Los Pagos que son Aplicaciones de Anticipos
  INSERT INTO #Pagos(ID, Empresa, Mov, MovID, Ejercicio, Periodo, FechaEmision, Aplica, AplicaID, Importe,
					 TipoCambio, Dinero, DineroID, FechaConciliacion, DineroMov, DineroMovID,
					 DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID,TipoInsert
					 )	   
			  SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, CASE mtmda.Mov WHEN NULL THEN c.FechaEmision ELSE c2.FechaEmision END, d.Aplica, d.AplicaID, d.Importe*c.TipoCambio, 
	                 c.TipoCambio, c.Dinero, c.DineroID, CASE mtmda.Mov WHEN NULL THEN c.DineroFechaConciliacion ELSE c2.DineroFechaConciliacion END,  c.Dinero,	 c.DineroID,  
	                 NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1
				FROM Cxp c
				JOIN CxpD d ON c.ID = d.ID
				JOIN Cxp o ON c.Empresa = o.Empresa AND d.Aplica = o.Mov AND d.AplicaID = o.MovID
				JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'CXP'
				JOIN Prov p ON c.Proveedor = p.Proveedor
	 LEFT OUTER JOIN MovTipo mt2 ON mt2.Modulo = c.OrigenTipo AND mt2.Mov = c.Origen
     LEFT OUTER JOIN CxpD d2 ON d2.Aplica = c.Mov AND d2.AplicaID = c.MovID
     LEFT OUTER JOIN Cxp c2 ON c2.ID = d2.ID AND c2.Empresa = c.Empresa
     LEFT OUTER JOIN DIOTPagoAdicion mtmda ON mtmda.Mov = c.Mov AND ISNULL(mtmda.Aplica, d.Aplica) = d.Aplica
     LEFT OUTER JOIN DIOTPagoExcepcion mtmde ON mtmde.Mov = c.Mov AND ISNULL(mtmde.Aplica, d.Aplica) = d.Aplica
     LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, d.Aplica) = d.Aplica
				JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
			   WHERE mtmde.Mov IS NULL
				 AND (mt.Clave IN (SELECT Clave FROM DIOTPagoClave) OR (mtmda.Mov IS NOT NULL))
				 AND mt.Clave = 'CXP.ANC'
				 AND mt2.Clave NOT IN ('CXP.NC')
				 AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
				 AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mtmda.Mov WHEN NULL THEN c.FechaEmision ELSE c2.FechaEmision END ELSE CASE mtmda.Mov WHEN NULL THEN c.DineroFechaConciliacion ELSE c2.DineroFechaConciliacion END END BETWEEN @FechaD AND @FechaA
				 AND c.Estatus =('CONCLUIDO')
				 AND o.Estatus IN('PENDIENTE', 'CONCLUIDO')
				 AND ISNULL(c2.Estatus, 'CONCLUIDO') = 'CONCLUIDO'
				 AND c.Empresa = @Empresa
				 
  --Insertamos Los Pagos que son Aplicaciones de Credito Proveedor
  INSERT INTO #Pagos(ID, Empresa, Mov, MovID, Ejercicio, Periodo, FechaEmision, Aplica, AplicaID, Importe,
					 TipoCambio, Dinero, DineroID, FechaConciliacion, DineroMov, DineroMovID,
					 DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID,TipoInsert
					 )	   
			  SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, CASE mtmda.Mov WHEN NULL THEN c.FechaEmision ELSE c2.FechaEmision END, c.Origen, c.OrigenID, d.Importe*c.TipoCambio, 
	                 c.TipoCambio, c.Dinero, c.DineroID, CASE mtmda.Mov WHEN NULL THEN c.DineroFechaConciliacion ELSE c2.DineroFechaConciliacion END,  c.Dinero,	 c.DineroID,  
	                 NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1
				FROM Cxp c
				JOIN CxpD d ON c.ID = d.ID
				JOIN Cxp o ON c.Empresa = o.Empresa AND d.Aplica = o.Mov AND d.AplicaID = o.MovID
				JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'CXP'
				JOIN Prov p ON c.Proveedor = p.Proveedor
	 LEFT OUTER JOIN MovTipo mt2 ON mt2.Modulo = c.OrigenTipo AND mt2.Mov = c.Origen
     LEFT OUTER JOIN CxpD d2 ON d2.Aplica = c.Mov AND d2.AplicaID = c.MovID
     LEFT OUTER JOIN Cxp c2 ON c2.ID = d2.ID AND c2.Empresa = c.Empresa
     LEFT OUTER JOIN DIOTPagoAdicion mtmda ON mtmda.Mov = c.Mov AND ISNULL(mtmda.Aplica, d.Aplica) = d.Aplica
     LEFT OUTER JOIN DIOTPagoExcepcion mtmde ON mtmde.Mov = c.Mov AND ISNULL(mtmde.Aplica, d.Aplica) = d.Aplica
     LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, d.Aplica) = d.Aplica
				JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
			   WHERE mtmde.Mov IS NULL
				 AND (mt.Clave IN (SELECT Clave FROM DIOTPagoClave) OR (mtmda.Mov IS NOT NULL))
				 AND mt.Clave = 'CXP.ANC'
				 AND mt2.Clave IN ('CXP.NC')
				 AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
				 AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mtmda.Mov WHEN NULL THEN c.FechaEmision ELSE c2.FechaEmision END ELSE CASE mtmda.Mov WHEN NULL THEN c.DineroFechaConciliacion ELSE c2.DineroFechaConciliacion END END BETWEEN @FechaD AND @FechaA
				 AND c.Estatus =('CONCLUIDO')
				 AND o.Estatus IN('PENDIENTE', 'CONCLUIDO')
				 AND ISNULL(c2.Estatus, 'CONCLUIDO') = 'CONCLUIDO'
				 AND c.Empresa = @Empresa

  RETURN
END
GO

/**************** xpDIOTObtenerDocumentoCOMS ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDIOTObtenerDocumentoCOMS') and type = 'P') drop procedure dbo.xpDIOTObtenerDocumentoCOMS
GO
CREATE PROC xpDIOTObtenerDocumentoCOMS
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime,
			@CalcularBaseImportacion		bit,
			@COMSIVAImportacionAnticipado		bit
AS
BEGIN
RETURN
END
GO

/**************** xpDIOTObtenerDocumentoGD ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDIOTObtenerDocumentoGD') and type = 'P') drop procedure dbo.xpDIOTObtenerDocumentoGD
GO
CREATE PROC xpDIOTObtenerDocumentoGD
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime,
			@CalcularBaseImportacion		bit,
			@COMSIVAImportacionAnticipado		bit
AS
BEGIN
RETURN
END
GO

/**************** xpDIOTObtenerDocumentoEI ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDIOTObtenerDocumentoEI') and type = 'P') drop procedure dbo.xpDIOTObtenerDocumentoEI
GO
CREATE PROC xpDIOTObtenerDocumentoEI
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime,
			@CalcularBaseImportacion		bit,
			@COMSIVAImportacionAnticipado		bit
AS
BEGIN
RETURN
END
GO

/**************** xpDIOTObtenerDocumentoGAS ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDIOTObtenerDocumentoGAS') and type = 'P') drop procedure dbo.xpDIOTObtenerDocumentoGAS
GO
CREATE PROC xpDIOTObtenerDocumentoGAS
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime,
			@CalcularBaseImportacion		bit,
			@COMSIVAImportacionAnticipado		bit
AS
BEGIN
RETURN
END
GO

/**************** xpDIOTObtenerDocumentoGAS2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDIOTObtenerDocumentoGAS2') and type = 'P') drop procedure dbo.xpDIOTObtenerDocumentoGAS2
GO
CREATE PROC xpDIOTObtenerDocumentoGAS2
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime,
			@CalcularBaseImportacion		bit,
			@COMSIVAImportacionAnticipado		bit
AS
BEGIN
RETURN
END
GO

/**************** spDIOTObtenerDocumento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOTObtenerDocumento') and type = 'P') drop procedure dbo.spDIOTObtenerDocumento
GO
CREATE PROC spDIOTObtenerDocumento
			@Estacion						int,
			@Empresa						varchar(5),
			@FechaD							datetime,
			@FechaA							datetime,
			@CalcularBaseImportacion		bit,
			--BUG24887
			@COMSIVAImportacionAnticipado	bit,
			@GASIncluirMovSinCxp			bit
--//WITH ENCRYPTION
AS
BEGIN
  --BUG22437
  DECLARE @CxpGastoDiverso		varchar(20)

  SELECT @CxpGastoDiverso = CxpGastoDiverso FROM EmpresaCfgMov WHERE Empresa = @Empresa
  
  --Insertamos Los Documentos de Cxp que vienen de Compras y que no son Entradas de Importación y no son Gastos Diversos
  EXEC xpDIOTObtenerDocumentoCOMS @Estacion, @Empresa, @FechaD, @FechaA, @CalcularBaseImportacion, @COMSIVAImportacionAnticipado
  IF NOT EXISTS(SELECT 1 FROM #Documentos WHERE TipoInsert = 1)
  INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, 
						  FechaEmision, Proveedor, Nombre, RFC, ImportadorRegistro, Pais, Nacionalidad, TipoDocumento,
						  TipoTercero, Importe, BaseIVA, Tasa, IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, 
						  IEPS, ISAN, Retencion1, Retencion2, DineroMov, DineroMovID,
						  DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
				   SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, 
						  Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC, Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('COMS', c.Mov),
						  dbo.fnDIOTTipoTercero(Cxp.Proveedor), ctc.SubTotal*c.TipoCambio, ROUND((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio, 2), ISNULL(d.Impuesto1, 0), ISNULL(ctc.Impuesto1Total,0.0)*c.TipoCambio, Art.Articulo,      Art.Descripcion1, dbo.fnDIOTEsImportacion('COMS', c.Mov), ISNULL(Art.Impuesto1Excento,0),
						  ISNULL(ctc.Impuesto2Total,0.0)*c.TipoCambio, 0.0,  ctc.Retencion2Total*c.TipoCambio, ctc.Retencion1Total*c.TipoCambio, DineroMov, DineroMovID,
						  p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, 1
					 FROM #Pagos p
					 JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					 JOIN Compra c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
					 JOIN CompraD d ON c.ID = d.ID
					 JOIN CompraTCalc ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID 
					 JOIN MovTipo ON c.Mov = MovTipo.Mov AND MovTipo.Modulo = 'COMS'
					 JOIN Art ON d.Articulo = Art.Articulo
					 JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
		  LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
		  LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
				LEFT JOIN DIOTArt ON Art.Articulo = DIOTArt.Articulo      
					 JOIN Version ver ON 1 = 1
					WHERE ISNULL(DIOTArt.Articulo, '') = Art.Articulo
					  AND MovTipo.Clave NOT IN ('COMS.EI','COMS.GX')
					  AND Cxp.Mov <> @CxpGastoDiverso

	--Insertamos Los Documentos de Cxp que son Gastos Diversos
	EXEC xpDIOTObtenerDocumentoGD @Estacion, @Empresa, @FechaD, @FechaA, @CalcularBaseImportacion, @COMSIVAImportacionAnticipado
	IF NOT EXISTS(SELECT 1 FROM #Documentos WHERE TipoInsert = 2)
	INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo,
							FechaEmision, Proveedor, Nombre, RFC, ImportadorRegistro, Pais, Nacionalidad, TipoDocumento,
							TipoTercero, Importe, BaseIVA, Tasa, IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, 
							IEPS, ISAN, Retencion1, Retencion2, DineroMov, DineroMovID,
							DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					 --BUG24887
					 SELECT Cxp.ID, Cxp.Empresa, p.Mov,  p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo,
							Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC, Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('CXP', Cxp.Mov),
							dbo.fnDIOTTipoTercero(Cxp.Proveedor), Cxp.Importe*Cxp.TipoCambio, (ISNULL(CONVERT(float,Cxp.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,Cxp.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)) ELSE 0.0 END)*Cxp.TipoCambio, dbo.fnDIOTIVATasa(Cxp.Empresa,Cxp.Importe,Cxp.Impuestos), dbo.fnDIOTIVA(Cxp.Importe, Cxp.Impuestos), Cxp.Concepto,  Cxp.Concepto, dbo.fnDIOTEsImportacion('CXP', Cxp.Mov), 0, (ISNULL(CONVERT(float,Cxp.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)*Cxp.TipoCambio, 0.0,  cgd.Retencion*Cxp.TipoCambio,        cgd.Retencion2*Cxp.TipoCambio, DineroMov, DineroMovID,--0.0,        Cxp.Retencion*Cxp.TipoCambio, DineroMov, DineroMovID
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, 2
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					   JOIN Compra c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
					   JOIN CompraD d ON c.ID = d.ID
					   JOIN CompraTCalc ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID 
					   JOIN MovTipo ON c.Mov = MovTipo.Mov AND MovTipo.Modulo = 'COMS'
				  LEFT JOIN CompraGastoDiverso cgd ON cgd.Id = c.id
					   JOIN Art ON d.Articulo = Art.Articulo
					   JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
			LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
			LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
				  LEFT JOIN DIOTArt ON Art.Articulo = DIOTArt.Articulo
					   JOIN Version ver ON 1 = 1
					  WHERE ISNULL(DIOTArt.Articulo, '') = Art.Articulo
						AND MovTipo.Clave NOT IN ('COMS.EI','COMS.GX')
						AND Cxp.Mov = @CxpGastoDiverso

	--BUG22150 BUG24887
	IF @CalcularBaseImportacion = 1 AND @COMSIVAImportacionAnticipado = 0
	BEGIN
		--Insertamos Los Documentos de Cxp que vienen de Compras y que son Entradas de Importación
		EXEC xpDIOTObtenerDocumentoEI @Estacion, @Empresa, @FechaD, @FechaA, @CalcularBaseImportacion, @COMSIVAImportacionAnticipado
		IF NOT EXISTS(SELECT 1 FROM #Documentos WHERE TipoInsert = 3)
		INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC, 
								ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa, IVA,
								EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2,
								--BUG22834
								BaseIVAImportacion, DineroMov, DineroMovID,
								p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, TipoInsert)
						 SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC, 
								Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('COMS', c.Mov), dbo.fnDIOTTipoTercero(Cxp.Proveedor), 
								SUM((ctc.SubTotal*c.TipoCambio))+dbo.fnDIOTBaseIVAImportacion(Cxp.Origen, Cxp.OrigenID, c.Empresa, DIOTCfg.CalcularBaseImportacion) 'Importe', 
								SUM((ctc.SubTotal*c.TipoCambio))+ dbo.fnDIOTBaseIVAImportacion(Cxp.Origen, Cxp.OrigenID, c.Empresa, DIOTCfg.CalcularBaseImportacion) 'BaseIVA',
								--BUG24887
								CASE dbo.fnDIOTIVAImportacion(Cxp.Origen, Cxp.OrigenID, c.Empresa, DIOTCfg.CalcularBaseImportacion) WHEN 0 THEN 0 ELSE dbo.fnDIOTTasaIVAImportacion(Cxp.Origen, Cxp.OrigenID, c.Empresa, DIOTCfg.CalcularBaseImportacion, eg.DefImpuesto) END 'Tasa',
								dbo.fnDIOTIVAImportacion(Cxp.Origen, Cxp.OrigenID, c.Empresa, DIOTCfg.CalcularBaseImportacion) 'IVA',
								dbo.fnDIOTEsImportacion('COMS', c.Mov), ISNULL(Art.Impuesto1Excento,0), SUM(ISNULL(ctc.Impuesto2Total,0.0)*c.TipoCambio), 0.0,  
								SUM(cgd.Retencion*cgd.TipoCambio), SUM(cgd.Retencion2*cgd.TipoCambio),
								--BUG22834 BUG24887
								ISNULL(dbo.fnDIOTBaseIVAImportacion(Cxp.Origen, Cxp.OrigenID, c.Empresa, DIOTCfg.CalcularBaseImportacion), 0) + ISNULL(dbo.fnDIOTIVAImportacion(Cxp.Origen, Cxp.OrigenID, c.Empresa, DIOTCfg.CalcularBaseImportacion), 0) - SUM(ISNULL(ctc.Impuesto1Total,0.0)*c.TipoCambio),
								DineroMov, DineroMovID,
								p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, 3
						   FROM #Pagos p
						   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
						   JOIN Compra c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
						   --BUG24992
						   JOIN CompraD d ON c.ID = d.ID AND Cxp.Proveedor = ISNULL(NULLIF(RTRIM(d.ImportacionProveedor), ''), c.Proveedor) AND ISNULL(Cxp.Referencia, '') = ISNULL(NULLIF(RTRIM(d.ImportacionReferencia), ''), ISNULL(Cxp.Referencia, ''))
						   JOIN CompraTCalc ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID 
						   JOIN MovTipo ON c.Mov = MovTipo.Mov AND MovTipo.Modulo = 'COMS'
					  LEFT JOIN CompraGastoDiverso cgd ON cgd.Id = c.id AND cgd.Concepto IN (SELECT Concepto FROM DIOTConceptoImportacion)
						   JOIN Art ON d.Articulo = Art.Articulo
						   JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
				LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
				LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
					  LEFT JOIN DIOTArt ON Art.Articulo = DIOTArt.Articulo      
						   JOIN Version ver ON 1 = 1
						   JOIN DIOTCfg ON DIOTCfg.Empresa = Cxp.Empresa
						   --BUG24889
						   JOIN EmpresaGral eg ON eg.Empresa = c.Empresa
				     WHERE ISNULL(DIOTArt.Articulo, '') = Art.Articulo     
					   AND MovTipo.Clave IN ('COMS.EI','COMS.GX')
					 --BUG24887
					   AND Cxp.Mov <> @CxpGastoDiverso
				  GROUP BY Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC, dp.Pais, dp.Nacionalidad, 
						   --BUG24887
						   c.Mov, Cxp.Origen, Cxp.OrigenID, c.Empresa, DIOTCfg.CalcularBaseImportacion, ISNULL(Art.Impuesto1Excento,0), Prov.ImportadorRegistro, DineroMov, DineroMovID, eg.DefImpuesto,
						   p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID
  END
  ELSE IF @CalcularBaseImportacion = 0 AND @COMSIVAImportacionAnticipado = 1
  BEGIN
	INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa, 
							IVA, ConceptoClave,Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, DineroMov, DineroMovID,
							BaseIVAImportacion, PorcentajeDeducible,
							DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					 SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, co.Proveedor, Prov.Nombre, Prov.RFC, Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('COMS', co.Mov),
							dbo.fnDIOTTipoTercero(co.Proveedor), 
							SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio)) + dbo.fnDIOTBaseIVAImportacion(co.Mov, co.MovID, co.Empresa, CalcularBaseImportacion),
							SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio)) + dbo.fnDIOTBaseIVAImportacion(co.Mov, co.MovID, co.Empresa, CalcularBaseImportacion),
							ISNULL(NULLIF(dbo.fnDIOTIVATasa(cxp.Empresa, cxp.Importe, cxp.Impuestos), 0), eg.DefImpuesto),
							(ISNULL(cxp.Importe, 0) + ISNULL(cxp.Impuestos, 0))*cxp.TipoCambio,
							d.Concepto, d.Concepto, dbo.fnDIOTEsImportacion('COMS', co.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(0.0/*d.Impuestos2*/,0.0)*c.TipoCambio, 0.0,  
							SUM(cgd.Retencion*cgd.TipoCambio),
							SUM(cgd.Retencion2*cgd.TipoCambio),
							DineroMov, DineroMovID, 
							-1,
							100,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, 3
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					   JOIN Gasto c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'GAS' AND c.Empresa = cxp.Empresa
					   JOIN GastoD d ON c.ID = d.ID
					   JOIN Compra co ON co.MovID = c.OrigenID AND co.Mov = c.Origen AND c.OrigenTipo = 'COMS' AND c.Empresa = co.Empresa
					   JOIN CompraD cd on co.ID = cd.ID
					   JOIN CompraTCalc ctc ON ctc.RenglonSub = cd.RenglonSub AND ctc.Renglon = cd.Renglon AND ctc.ID = cd.ID 
			LEFT OUTER JOIN Concepto ON d.Concepto = Concepto.Concepto AND Concepto.Modulo = 'COMSG'
					   JOIN Prov ON co.Proveedor = Prov.Proveedor
			LEFT OUTER JOIN MovTipo mt ON mt.Mov = c.Origen AND mt.Modulo = c.OrigenTipo
				  LEFT JOIN CompraGastoDiverso cgd ON cgd.Id = co.id
			LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
			LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
					   JOIN DIOTCfg ON DIOTCfg.Empresa = Cxp.Empresa
					   JOIN EmpresaGral eg ON Cxp.Empresa = eg.Empresa
					   JOIN Version ver ON 1 = 1   
					  WHERE (ISNULL(mt.Clave, '') IN ('COMS.EI','COMS.GX') 
						AND d.Concepto IN(SELECT Concepto FROM DIOTConceptoIVAImportacion))
				   GROUP BY c.Origen, c.OrigenID, Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, co.Proveedor, 
							Prov.Nombre, Prov.RFC, Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, c.Mov, Cxp.Proveedor,
							d.Concepto, d.Concepto, c.Mov, Concepto.Impuesto1Excento, c.TipoCambio, cxp.Importe, cxp.Impuestos,eg.DefImpuesto,cxp.TipoCambio,ver.Impuesto2BaseImpuesto1,
							co.Mov, co.MovID, co.Empresa, CalcularBaseImportacion, Cxp.Origen, Cxp.OrigenID, c.Empresa,
							DineroMov, DineroMovID,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID							
  
  
  --Insertamos Los Documentos de Cxp que vienen de Gastos Diversos, son conceptos de IVA de Importación y no generaron Gasto
    INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa, IVA,
							ConceptoClave,Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, DineroMov, DineroMovID, 
							BaseIVAImportacion, PorcentajeDeducible,
							DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					 SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, c.Proveedor, Prov.Nombre, Prov.RFC, Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('COMS', c.Mov), 
							dbo.fnDIOTTipoTercero(c.Proveedor), 
							SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio)) + dbo.fnDIOTBaseIVAImportacion(c.Mov, c.MovID, c.Empresa, CalcularBaseImportacion),
							SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio)) + dbo.fnDIOTBaseIVAImportacion(c.Mov, c.MovID, c.Empresa, CalcularBaseImportacion),
							ISNULL(NULLIF(dbo.fnDIOTIVATasa(cxp.Empresa, cxp.Importe, cxp.Impuestos), 0), eg.DefImpuesto),
							(ISNULL(cxp.Importe, 0) + ISNULL(cxp.Impuestos, 0))*cxp.TipoCambio,
							Cxp.Concepto, Cxp.Concepto, dbo.fnDIOTEsImportacion('COMS', c.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(0.0/*d.Impuestos2*/,0.0)*c.TipoCambio, 0.0,  
							SUM(cgd.Retencion*cgd.TipoCambio),
							SUM(cgd.Retencion2*cgd.TipoCambio),
							DineroMov, DineroMovID, 
							-1,
							100,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, 3
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					   JOIN Compra c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
					   JOIN CompraD cd on c.ID = cd.ID
					   JOIN CompraTCalc ctc ON ctc.RenglonSub = cd.RenglonSub AND ctc.Renglon = cd.Renglon AND ctc.ID = cd.ID 
					   JOIN MovTipo ON c.Mov = MovTipo.Mov AND MovTipo.Modulo = 'COMS'
				  LEFT JOIN CompraGastoDiverso cgd ON cgd.Id = c.id AND cgd.Concepto IN (SELECT Concepto FROM DIOTConceptoImportacion)
					   JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
			LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
			LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
					   JOIN Version ver ON 1 = 1
			LEFT OUTER JOIN Concepto ON cxp.Concepto = Concepto.Concepto AND Concepto.Modulo = 'COMSG'      
					   JOIN DIOTCfg ON DIOTCfg.Empresa = Cxp.Empresa      
					   JOIN EmpresaGral eg ON Cxp.Empresa = eg.Empresa
					  WHERE (ISNULL(MovTipo.Clave, '') IN ('COMS.EI','COMS.GX') 
						AND cxp.Concepto IN(SELECT Concepto FROM DIOTConceptoIVAImportacion))
						AND Cxp.Mov = @CxpGastoDiverso
				   GROUP BY Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, c.Proveedor, Prov.Nombre, Prov.RFC, 
							Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, c.Mov, c.Proveedor, cxp.Empresa, cxp.Importe, cxp.Impuestos, eg.DefImpuesto,
							cxp.Importe, cxp.Impuestos, cxp.TipoCambio, Cxp.Concepto, c.Mov, Concepto.Impuesto1Excento,DineroMov, DineroMovID, c.MovID,c.Empresa,
							DIOTCfg.CalcularBaseImportacion, c.TipoCambio,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID
							
  --Insertamos Los Documentos de Cxp que vienen de Gastos Diversos y no generaron Gasto	y son pagados con Endoso o Documento				 
    INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa, IVA,
							ConceptoClave,Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, DineroMov, DineroMovID, 
							BaseIVAImportacion, PorcentajeDeducible,
							DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					 SELECT	Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC, Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('COMS', c2.Mov), 
							dbo.fnDIOTTipoTercero(c2.Proveedor), 
							SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c2.TipoCambio)) + dbo.fnDIOTBaseIVAImportacion(c2.Mov, c2.MovID, c2.Empresa, CalcularBaseImportacion),
							SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c2.TipoCambio)) + dbo.fnDIOTBaseIVAImportacion(c2.Mov, c2.MovID, c2.Empresa, CalcularBaseImportacion),
							ISNULL(NULLIF(dbo.fnDIOTIVATasa(cxp.Empresa, cxp.Importe, cxp.Impuestos), 0), eg.DefImpuesto),
							(ISNULL(cxp.Importe, 0) + ISNULL(cxp.Impuestos, 0))*cxp.TipoCambio,
							Cxp.Concepto, Cxp.Concepto, dbo.fnDIOTEsImportacion('COMS', c2.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(0.0/*d.Impuestos2*/,0.0)*c2.TipoCambio, 0.0,  
							SUM(cgd.Retencion*cgd.TipoCambio),
							SUM(cgd.Retencion2*cgd.TipoCambio),
							DineroMov, DineroMovID, 
							-1,
							100,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, 3
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					   JOIN Cxp c2 ON c2.Empresa = cxp.Empresa AND c2.Mov = cxp.Origen AND c2.MovID = cxp.OrigenID
					   JOIN Compra c3 ON c3.MovID = c2.OrigenID AND c3.Mov = c2.Origen AND c2.OrigenTipo = 'COMS' AND c3.Empresa = c2.Empresa
					   JOIN CompraD cd on c3.ID = cd.ID
					   JOIN CompraTCalc ctc ON ctc.RenglonSub = cd.RenglonSub AND ctc.Renglon = cd.Renglon AND ctc.ID = cd.ID 
					   JOIN MovTipo mt ON c3.Mov = mt.Mov AND mt.Modulo = 'COMS'
					   JOIN MovTipo mt2 ON Cxp.Mov = mt2.Mov AND mt2.Modulo = 'CXP'
				  LEFT JOIN CompraGastoDiverso cgd ON cgd.Id = c3.id AND cgd.Concepto IN (SELECT Concepto FROM DIOTConceptoImportacion)
					   JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
			LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
			LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
					   JOIN Version ver ON 1 = 1
			LEFT OUTER JOIN Concepto ON cxp.Concepto = Concepto.Concepto AND Concepto.Modulo = 'COMSG'      
					   JOIN DIOTCfg ON DIOTCfg.Empresa = Cxp.Empresa      
					   JOIN EmpresaGral eg ON Cxp.Empresa = eg.Empresa
					  WHERE ISNULL(mt.Clave, '') IN ('COMS.EI','COMS.GX')
						AND ISNULL(mt2.Clave,'') IN ('CXP.FAC','CXP.D')
						AND cxp.Concepto IN(SELECT Concepto FROM DIOTConceptoIVAImportacion)
						AND c2.Mov = @CxpGastoDiverso
				   GROUP BY Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC,
							Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, c2.Mov, c2.Proveedor, cxp.Empresa, cxp.Importe, cxp.Impuestos, eg.DefImpuesto,
							cxp.Importe, cxp.Impuestos, cxp.TipoCambio, Cxp.Concepto, c2.Mov, Concepto.Impuesto1Excento,DineroMov, DineroMovID, c2.MovID,c2.Empresa,
							DIOTCfg.CalcularBaseImportacion, c2.TipoCambio,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID					
	
  END
  ELSE IF @CalcularBaseImportacion = 0 AND @COMSIVAImportacionAnticipado = 0
    --BUG22150
    INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA,
							Tasa, IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, DineroMov, DineroMovID,
							DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					 SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC,
							Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('COMS', c.Mov), dbo.fnDIOTTipoTercero(Cxp.Proveedor), ctc.SubTotal*c.TipoCambio, ROUND((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio, 2),
							ISNULL(d.Impuesto1, 0), ISNULL(ctc.Impuesto1Total,0.0)*c.TipoCambio, Art.Articulo, Art.Descripcion1, dbo.fnDIOTEsImportacion('COMS', c.Mov), ISNULL(Art.Impuesto1Excento,0), ISNULL(ctc.Impuesto2Total,0.0)*c.TipoCambio, 0.0,  cgd.Retencion*cgd.TipoCambio, cgd.Retencion2*cgd.TipoCambio, DineroMov, DineroMovID,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, 3
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					   JOIN Compra c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
					   --BUG24992
					   JOIN CompraD d ON c.ID = d.ID AND Cxp.Proveedor = ISNULL(NULLIF(RTRIM(d.ImportacionProveedor), ''), c.Proveedor) AND ISNULL(Cxp.Referencia, '') = ISNULL(NULLIF(RTRIM(d.ImportacionReferencia), ''), ISNULL(Cxp.Referencia, ''))
					   JOIN CompraTCalc ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID 
					   JOIN MovTipo ON c.Mov = MovTipo.Mov AND MovTipo.Modulo = 'COMS'
				  LEFT JOIN CompraGastoDiverso cgd ON cgd.Id = c.id
					   JOIN Art ON d.Articulo = Art.Articulo
					   JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
			LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
			LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
				  LEFT JOIN DIOTArt ON Art.Articulo = DIOTArt.Articulo      
					   JOIN Version ver ON 1 = 1
					   JOIN DIOTCfg ON DIOTCfg.Empresa = Cxp.Empresa
					  WHERE ISNULL(DIOTArt.Articulo, '') = Art.Articulo     
						AND MovTipo.Clave IN ('COMS.EI', 'COMS.GX')

	--BUG22150
	--Insertamos Los Documentos de Cxp que vienen de Gastos
	EXEC xpDIOTObtenerDocumentoGAS @Estacion, @Empresa, @FechaD, @FechaA, @CalcularBaseImportacion, @COMSIVAImportacionAnticipado
	IF NOT EXISTS(SELECT 1 FROM #Documentos WHERE TipoInsert = 4) OR ISNULL(@GASIncluirMovSinCxp,0) = 1
	INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa, IVA, 
							ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, 
							DineroMov, DineroMovID, PorcentajeDeducible,
							DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					 SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC,
							Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('GAS', c.Mov), dbo.fnDIOTTipoTercero(Cxp.Proveedor), d.Importe*c.TipoCambio, (ISNULL(d.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(d.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, CASE WHEN NULLIF(d.Impuestos,0.0) IS NULL THEN NULL ELSE d.Impuesto1 END, 
							ISNULL(d.Impuestos,0.0)*c.TipoCambio, d.Concepto, d.Concepto, dbo.fnDIOTEsImportacion('GAS', c.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(d.Impuestos2,0.0)*c.TipoCambio, 0.0,  d.Retencion*c.TipoCambio, d.Retencion2*c.TipoCambio,
							DineroMov, DineroMovID, d.PorcentajeDeducible,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, 4
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					   JOIN Gasto c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'GAS' AND c.Empresa = cxp.Empresa
					   JOIN GastoD d ON c.ID = d.ID
					   JOIN GastoT ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID 
					   JOIN Concepto ON d.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'
					   JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
					   JOIN MovTipo mt1 ON mt1.Mov = c.Mov AND mt1.Modulo = 'GAS'
			LEFT OUTER JOIN MovTipo mt ON mt.Mov = c.Origen AND mt.Modulo = c.OrigenTipo
			LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
			LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
					   JOIN DIOTConcepto ON Concepto.Modulo = 'GAS' AND DIOTConcepto.Concepto = Concepto.Concepto
					   JOIN Version ver ON 1 = 1   
					  WHERE ISNULL(mt.Clave, '') NOT IN('COMS.EI','COMS.GX')
						AND mt1.Clave NOT IN('GAS.CCH', 'GAS.GTC', 'GAS.C', 'GAS.CP')
						--BUG24887
						AND d.Concepto NOT IN(SELECT Concepto FROM DIOTConceptoImportacion UNION ALL SELECT Concepto FROM DIOTConceptoIVAImportacion)

	--BUG22150 BUG24755
	--Insertamos Los Documentos de Cxp que vienen de Gastos
	EXEC xpDIOTObtenerDocumentoGAS2 @Estacion, @Empresa, @FechaD, @FechaA, @CalcularBaseImportacion, @COMSIVAImportacionAnticipado
	IF NOT EXISTS(SELECT 1 FROM #Documentos WHERE TipoInsert = 5)  
	INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa, IVA, 
							ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, DineroMov, DineroMovID, PorcentajeDeducible,
							DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					 SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, ISNULL(NULLIF(RTRIM(d.AcreedorRef), ''), c.Acreedor), Prov.Nombre, Prov.RFC,
							Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('GAS', c.Mov), dbo.fnDIOTTipoTercero(Cxp.Proveedor), d.Importe*c.TipoCambio, (ISNULL(d.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(d.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, CASE WHEN NULLIF(d.Impuestos,0.0) IS NULL THEN NULL ELSE d.Impuesto1 END, ISNULL(d.Impuestos,0.0)*c.TipoCambio, 
							d.Concepto, d.Concepto, dbo.fnDIOTEsImportacion('GAS', c.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(d.Impuestos2,0.0)*c.TipoCambio, 0.0,  d.Retencion*c.TipoCambio, d.Retencion2*c.TipoCambio, DineroMov, DineroMovID, d.PorcentajeDeducible,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID, 5
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					   JOIN Gasto c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'GAS' AND c.Empresa = cxp.Empresa
					   --BUG25056
					   JOIN GastoD d ON c.ID = d.ID AND d.Concepto = Cxp.Concepto AND ISNULL(d.Referencia, ISNULL(Cxp.Referencia, '')) = ISNULL(Cxp.Referencia, '')
					   JOIN GastoT ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID 
					   JOIN Concepto ON d.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'
					   JOIN Prov ON Prov.Proveedor = ISNULL(NULLIF(RTRIM(d.AcreedorRef), ''), c.Acreedor)
					   JOIN MovTipo mt1 ON mt1.Mov = c.Mov AND mt1.Modulo = 'GAS'
			LEFT OUTER JOIN MovTipo mt ON mt.Mov = c.Origen AND mt.Modulo = c.OrigenTipo
			LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
			LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
					   JOIN DIOTConcepto ON Concepto.Modulo = 'GAS' AND DIOTConcepto.Concepto = Concepto.Concepto
					   JOIN Version ver ON 1 = 1   
					  WHERE ISNULL(mt.Clave, '') NOT IN('COMS.EI','COMS.GX')
					    AND mt1.Clave IN('GAS.CCH', 'GAS.GTC', 'GAS.C', 'GAS.CP')
						 --BUG24887
						AND d.Concepto NOT IN(SELECT Concepto FROM DIOTConceptoImportacion UNION ALL SELECT Concepto FROM DIOTConceptoIVAImportacion)

  --Insertamos Los Documentos de Cxp que vienen de Gastos Diversos
  --BUG24755
  INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
						  ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa,
						  IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2,
						  DineroMov, DineroMovID, PorcentajeDeducible,
						  DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID)
				   SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC,
						  Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('GAS', c.Mov), dbo.fnDIOTTipoTercero(Cxp.Proveedor), d.Importe*c.TipoCambio, (ISNULL(d.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(d.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, CASE WHEN NULLIF(d.Impuestos,0.0) IS NULL THEN NULL ELSE d.Impuesto1 END, 
						  ISNULL(d.Impuestos,0.0)*c.TipoCambio, d.Concepto, d.Concepto, dbo.fnDIOTEsImportacion('GAS', c.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(d.Impuestos2,0.0)*c.TipoCambio, 0.0,  d.Retencion*c.TipoCambio, d.Retencion2*c.TipoCambio,
						  DineroMov, DineroMovID, d.PorcentajeDeducible,
						  p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID
					 FROM #Pagos p
					 JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					 JOIN Gasto c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'GAS' AND c.Empresa = cxp.Empresa
					 JOIN GastoD d ON c.ID = d.ID
					 JOIN GastoT ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID 
		  LEFT OUTER JOIN Concepto ON d.Concepto = Concepto.Concepto AND Concepto.Modulo = 'COMSG'
					 JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
		  LEFT OUTER JOIN MovTipo mt ON mt.Mov = c.Origen AND mt.Modulo = c.OrigenTipo
		  LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
		  LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
					 JOIN Version ver ON 1 = 1   
					WHERE (ISNULL(mt.Clave, '') IN ('COMS.EI','COMS.GX') 
					  AND d.Concepto NOT IN(SELECT Concepto FROM DIOTConceptoImportacion UNION ALL SELECT Concepto FROM DIOTConceptoIVAImportacion))

	--BUG24887
	--Insertamos Los Documentos de Cxp que vienen de Gastos Diversos y no generaron Gasto
	INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC, 
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa,
							IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2,
							DineroMov, DineroMovID,
							DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID)
					 SELECT Cxp.ID, Cxp.Empresa, p.Mov,  p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC,
							Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('CXP', Cxp.Mov), dbo.fnDIOTTipoTercero(Cxp.Proveedor), Cxp.Importe*Cxp.TipoCambio, (ISNULL(CONVERT(float,Cxp.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,Cxp.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)) ELSE 0.0 END)*Cxp.TipoCambio, dbo.fnDIOTIVATasa(Cxp.Empresa,Cxp.Importe,Cxp.Impuestos), 
							dbo.fnDIOTIVA(Cxp.Importe, Cxp.Impuestos), Cxp.Concepto,  Cxp.Concepto, dbo.fnDIOTEsImportacion('CXP', Cxp.Mov), 0, (ISNULL(CONVERT(float,Cxp.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)*Cxp.TipoCambio, 0.0,  0.0, Cxp.Retencion2*Cxp.TipoCambio,
							DineroMov, DineroMovID,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
					   JOIN Compra c ON c.MovID = Cxp.OrigenID AND c.Mov = cxp.Origen AND Cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
					   JOIN MovTipo ON c.Mov = MovTipo.Mov AND MovTipo.Modulo = 'COMS'
					   JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
			LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
			LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
					   JOIN Version ver ON 1 = 1
					  WHERE (ISNULL(MovTipo.Clave, '') IN ('COMS.EI','COMS.GX') 
						AND Cxp.Concepto NOT IN(SELECT Concepto FROM DIOTConceptoImportacion UNION ALL SELECT Concepto FROM DIOTConceptoIVAImportacion))
						AND Cxp.Mov = @CxpGastoDiverso		

	--Insertamos Los Documentos de Cxp que vienen de Compras y son pagados con Endoso o Documento
	INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA,
							Tasa, IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2,
							DineroMov, DineroMovID,
							DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID)
					 SELECT c.ID, c.Empresa, p.Mov, p.MovID, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Proveedor, Prov.Nombre,
							Prov.RFC, Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('COMS', c.Mov), dbo.fnDIOTTipoTercero(c.Proveedor), ctc.SubTotal*c.TipoCambio, ROUND((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio, 2), ISNULL(d.Impuesto1, 0), ISNULL(ctc.Impuesto1Total,0.0)*c.TipoCambio,  Art.Articulo, Art.Descripcion1, dbo.fnDIOTEsImportacion('COMS', c3.Mov), ISNULL(Art.Impuesto1Excento,0), ISNULL(ctc.Impuesto2Total,0.0)*c.TipoCambio, 0.0,  ctc.Retencion1Total*c.TipoCambio, ctc.Retencion2Total*c.TipoCambio,
							DineroMov, DineroMovID,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID  			
					   FROM #Pagos p
					   JOIN Cxp c ON p.Empresa = c.Empresa AND p.Aplica = c.Mov AND p.AplicaID = c.MovID
					   JOIN Cxp c2 ON c2.Empresa = c.Empresa AND c2.Mov = c.Origen AND c2.MovID = c.OrigenID
					   JOIN Compra c3 ON c3.Empresa = c2.Empresa AND c3.Mov = c2.Origen AND c3.MovID = c2.OrigenID
					   JOIN CompraD d ON d.ID = c3.ID
					   JOIN CompraTCalc ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID 
					   JOIN MovTipo mt ON c.Mov = mt.Mov
					   JOIN Art ON d.Articulo = Art.Articulo
					   JOIN Prov ON c.Proveedor = Prov.Proveedor
				  LEFT JOIN Pais ON Prov.Pais = Pais.Pais
				  LEFT JOIN DIOTPais dp ON Pais.Pais = dp.Pais
				  LEFT JOIN DIOTArt ON Art.Articulo = DIOTArt.Articulo
					   JOIN Version ver ON 1 = 1
					  WHERE ISNULL(DIOTArt.Articulo, '') = Art.Articulo
						AND mt.Clave IN ('CXP.FAC','CXP.D')		
						AND c2.Mov <> @CxpGastoDiverso
						
	--Insertamos Los Documentos de Cxp que vienen de Gastos y son pagados con Endoso o Documento
	INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA,
							Tasa, IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2,
							DineroMov, DineroMovID,
							DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID)
					 SELECT c.ID, c.Empresa, p.Mov, p.MovID, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Proveedor, Prov.Nombre,
							Prov.RFC, Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('GAS', c.Mov), dbo.fnDIOTTipoTercero(c.Proveedor), d.Importe*c.TipoCambio, ROUND((ISNULL(d.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(d.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, 2), CASE WHEN NULLIF(d.Impuestos,0.0) IS NULL THEN NULL ELSE ISNULL(d.Impuesto1, 0) END, ISNULL(d.Impuestos,0.0)*c.TipoCambio, d.Concepto, d.Concepto, dbo.fnDIOTEsImportacion('GAS', c3.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(d.Impuestos2,0.0)*c.TipoCambio, 0.0, d.Retencion*c.TipoCambio, d.Retencion2*c.TipoCambio,
							DineroMov, DineroMovID,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID  			
					   FROM #Pagos p
					   JOIN Cxp c ON p.Empresa = c.Empresa AND p.Aplica = c.Mov AND p.AplicaID = c.MovID
					   JOIN Cxp c2 ON c2.Empresa = c.Empresa AND c2.Mov = c.Origen AND c2.MovID = c.OrigenID
					   JOIN Gasto c3 ON c3.Empresa = c2.Empresa AND c3.Mov = c2.Origen AND c3.MovID = c2.OrigenID
					   JOIN GastoD d ON d.ID = c3.ID
					   JOIN GastoT ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID
					   JOIN Concepto ON d.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'
					   JOIN MovTipo mt ON c.Mov = mt.Mov
					   JOIN Prov ON c.Proveedor = Prov.Proveedor
				  LEFT JOIN Pais ON Prov.Pais = Pais.Pais
				  LEFT JOIN DIOTPais dp ON Pais.Pais = dp.Pais
					   JOIN DIOTConcepto ON Concepto.Modulo = 'GAS' AND DIOTConcepto.Concepto = Concepto.Concepto
					   JOIN Version ver ON 1 = 1
					  WHERE d.Concepto NOT IN(SELECT Concepto FROM DIOTConceptoImportacion UNION ALL SELECT Concepto FROM DIOTConceptoIVAImportacion)
						AND mt.Clave IN ('CXP.FAC','CXP.D')
						
	--Insertamos Los Documentos de Cxp que son Credito Proveedor
	INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa,
							IVA, ConceptoClave, Concepto,EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, 
							DineroMov, DineroMovID,
							DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID)
					 SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC,
							Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('CXP', Cxp.Mov), dbo.fnDIOTTipoTercero(Cxp.Proveedor), Cxp.Importe*Cxp.TipoCambio, (ISNULL(CONVERT(float,Cxp.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,Cxp.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)) ELSE 0.0 END)*Cxp.TipoCambio, dbo.fnDIOTIVATasa(Cxp.Empresa, Cxp.Importe,Cxp.Impuestos), dbo.fnDIOTIVA(Cxp.Importe, Cxp.Impuestos), Cxp.Concepto,  Cxp.Concepto, dbo.fnDIOTEsImportacion('CXP', Cxp.Mov), 0,         (ISNULL(CONVERT(float,Cxp.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)*Cxp.TipoCambio, 0.0,  0.0,Cxp.Retencion*Cxp.TipoCambio,
							DineroMov, DineroMovID,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID AND ISNULL(OrigenTipo, '') IN('', 'CXP')
					   JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
					   JOIN MovTipo mt ON mt.Mov = Cxp.Mov AND mt.Modulo = 'CXP'
				  LEFT JOIN Pais ON Prov.Pais = Pais.Pais
				  LEFT JOIN DIOTPais dp ON Pais.Pais = dp.Pais      
					   JOIN Version ver ON 1 = 1
					  WHERE mt.Clave IN ('CXP.NC')


	--Insertamos Los Documentos de Cxp que no tienen Origen
	INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, Nombre, RFC,
							ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa,
							IVA, ConceptoClave, Concepto,EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, 
							DineroMov, DineroMovID,
							DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID)
					 SELECT Cxp.ID, Cxp.Empresa, p.Mov, p.MovID, Cxp.Mov, Cxp.MovID, Cxp.Ejercicio, Cxp.Periodo, Cxp.FechaEmision, Cxp.Proveedor, Prov.Nombre, Prov.RFC,
							Prov.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('CXP', Cxp.Mov), dbo.fnDIOTTipoTercero(Cxp.Proveedor), Cxp.Importe*Cxp.TipoCambio, (ISNULL(CONVERT(float,Cxp.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,Cxp.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)) ELSE 0.0 END)*Cxp.TipoCambio, dbo.fnDIOTIVATasa(Cxp.Empresa, Cxp.Importe,Cxp.Impuestos), dbo.fnDIOTIVA(Cxp.Importe, Cxp.Impuestos)*Cxp.TipoCambio, Cxp.Concepto,  Cxp.Concepto, dbo.fnDIOTEsImportacion('CXP', Cxp.Mov), 0,         (ISNULL(CONVERT(float,Cxp.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,Cxp.IEPSFiscal),0.0)*Cxp.TipoCambio, 0.0,  0.0,Cxp.Retencion*Cxp.TipoCambio,
							DineroMov, DineroMovID,
							p.DineroMov2, p.DineroMovID2, p.DineroFormaPago, p.DineroImporte, p.ContID, p.ContMov, p.ContMovID  
					   FROM #Pagos p
					   JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID AND ISNULL(OrigenTipo, '') IN('', 'CXP')
					   JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
					   JOIN MovTipo mt ON mt.Mov = Cxp.Mov AND mt.Modulo = 'CXP'
				  LEFT JOIN Pais ON Prov.Pais = Pais.Pais
				  LEFT JOIN DIOTPais dp ON Pais.Pais = dp.Pais      
					   JOIN Version ver ON 1 = 1
					  WHERE mt.Clave NOT IN ('CXP.FAC','CXP.D','CXP.NC')
					    --AND Cxp.FechaEmision BETWEEN @FechaD AND @FechaA
						AND Cxp.Estatus IN('PENDIENTE', 'CONCLUIDO')
						
	RETURN
END
GO

/**************** xpDIOTObtenerAnticipo ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDIOTObtenerAnticipo') and type = 'P') drop procedure dbo.xpDIOTObtenerAnticipo
GO
CREATE PROC xpDIOTObtenerAnticipo
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
AS
BEGIN
RETURN
END
GO

/**************** spDIOTObtenerAnticipo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOTObtenerAnticipo') and type = 'P') drop procedure dbo.spDIOTObtenerAnticipo
GO
CREATE PROC spDIOTObtenerAnticipo
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS
BEGIN
  --Insertamos Los Anticipos que generaron un movimiento Final en Tesoreria
	EXEC xpDIOTObtenerAnticipo @Estacion, @Empresa, @FechaD, @FechaA
	IF NOT EXISTS (SELECT 1 FROM #Pagos WHERE TipoInsert = 2)
	  BEGIN
	  INSERT INTO #Pagos(ID,   Empresa,   Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Aplica,   AplicaID, Importe,                                          
						 TipoCambio,   Dinero,   DineroID,   FechaConciliacion,       EsAnticipo,   DineroMov,   DineroMovID,
						 DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert
						)
				  SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov,    c.MovID,   (c.Importe+ISNULL(c.Impuestos, 0))*c.TipoCambio, 
						 c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion, 1,          d.Mov,       d.MovID,
						 t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID, 2
					FROM Dinero d
					JOIN MovFlujo mf ON d.ID = mf.DID AND mf.OModulo = 'CXP' AND DModulo = 'DIN' 
					JOIN Cxp c ON d.OrigenTipo = 'CXP' AND d.Origen = c.Mov AND d.OrigenID = c.MovID AND d.Empresa = c.Empresa AND c.ID = mf.OID
					JOIN #Tesoreria t ON d.ID = t.ID AND c.ID = t.OrigenIID
					JOIN MovTipo mt ON mt.Mov = d.Mov AND mt.Modulo = 'DIN'
					JOIN MovTipo mt2 ON mt2.Mov = c.Mov AND mt2.Modulo = 'CXP'  
					JOIN Version ver ON 1 = 1  
		 LEFT OUTER JOIN DIOTPagoAdicion mtmda ON mtmda.Mov = c.Mov AND ISNULL(mtmda.Aplica, c.Mov) = c.Mov
		 LEFT OUTER JOIN DIOTPagoExcepcion mtmde ON mtmde.Mov = c.Mov AND ISNULL(mtmde.Aplica, c.Mov) = c.Mov
		 LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov
					JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa      
				   WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
					 AND d.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
					 AND (mt.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE', 'DIN.E'))
					 AND (mt2.Clave IN ('CXP.A'))
					 AND c.Empresa = @Empresa
					 --AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA
				  EXCEPT
				  SELECT ID,   Empresa,   Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Aplica,   AplicaID, Importe,                                          
						 TipoCambio,   Dinero,   DineroID,   FechaConciliacion,       EsAnticipo,   DineroMov,   DineroMovID,
						 DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert
					FROM #Pagos					 
			  
	  --Insertamos Los Anticipos que generaron primeramente una Solicitud en Tesoreria
		INSERT INTO #Pagos(ID, Empresa, Mov, MovID, Ejercicio, Periodo, FechaEmision, Aplica, AplicaID, Importe,
						   TipoCambio, Dinero, DineroID, FechaConciliacion, EsAnticipo, DineroMov, DineroMovID,
						   DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov, c.MovID, (c.Importe+ISNULL(c.Impuestos, 0))*c.TipoCambio,
						   c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion, 1, d.Mov, d.MovID,
						   t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID, 2
					  FROM Dinero d
					  JOIN MovFlujo mf ON d.ID = mf.DID AND mf.OModulo = 'DIN' AND DModulo = 'DIN'
					  JOIN Dinero d2 ON d2.ID = mf.OID
					  JOIN MovTipo mt ON mt.Mov = d.Mov AND mt.Modulo = 'DIN'
					  JOIN MovTipo mt2 ON mt2.Mov = d2.Mov AND mt2.Modulo = 'DIN'
					  JOIN Cxp c ON d2.OrigenTipo = 'CXP' AND d2.Origen = c.Mov AND d2.OrigenID = c.MovID AND d2.Empresa = c.Empresa
					  JOIN #Tesoreria t ON d.ID = t.ID AND c.ID = t.OrigenIID
					  JOIN MovTipo mt3 ON mt3.Mov = c.Mov AND mt3.Modulo = 'CXP'
					  JOIN Version ver ON 1 = 1  
		   LEFT OUTER JOIN DIOTPagoAdicion mtmda ON mtmda.Mov = c.Mov AND ISNULL(mtmda.Aplica, c.Mov) = c.Mov
		   LEFT OUTER JOIN DIOTPagoExcepcion mtmde ON mtmde.Mov = c.Mov AND ISNULL(mtmde.Aplica, c.Mov) = c.Mov
		   LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov
					  JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa            
					 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
					   AND d2.Estatus IN ('PENDIENTE','CONCLUIDO')
					   AND d.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
					   AND (mt.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE'))
					   AND (mt2.Clave IN ('DIN.SCH', 'DIN.SD'))
					   AND (mt3.Clave IN ('CXP.A'))
					   AND c.Empresa = @Empresa
					   --AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA
					EXCEPT
					SELECT ID,   Empresa,   Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Aplica,   AplicaID, Importe,                                          
						   TipoCambio,   Dinero,   DineroID,   FechaConciliacion,       EsAnticipo,   DineroMov,   DineroMovID,
						   DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert
					  FROM #Pagos						   
	END
END
GO

/**************** xpDIOTObtenerComprobante ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDIOTObtenerComprobante') and type = 'P') drop procedure dbo.xpDIOTObtenerComprobante
GO
CREATE PROC xpDIOTObtenerComprobante
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
AS
BEGIN
	RETURN
END
GO

/**************** spDIOTObtenerComprobante ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOTObtenerComprobante') and type = 'P') drop procedure dbo.spDIOTObtenerComprobante
GO
CREATE PROC spDIOTObtenerComprobante
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS
BEGIN
	EXEC xpDIOTObtenerComprobante @Estacion, @Empresa, @FechaD, @FechaA
	IF NOT EXISTS (SELECT 1 FROM #Pagos WHERE TipoInsert = 3)
	INSERT INTO #Pagos(ID, Empresa, Mov, MovID, Ejercicio, Periodo, FechaEmision, Aplica, AplicaID, Importe,
					   TipoCambio, Dinero, DineroID, FechaConciliacion, EsComprobante, DineroMov, DineroMovID,
					   DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert
					   )
				SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov, c.MovID, SUM((ISNULL(cd.Importe,0.0)+ISNULL(cd.Impuestos,0.0)+ISNULL(cd.Impuestos2,0.0)-ISNULL(cd.Retencion,0.0)-ISNULL(cd.Retencion2,0.0))*c.TipoCambio), 
					   c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion, 1, c.Dinero, c.DineroID,
					   t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID, 3
				  FROM Gasto c
				  JOIN GastoD cd ON cd.ID = c.ID
				  JOIN #Tesoreria t ON t.OrigenTipo = 'GAS' AND t.OrigenMID = c.ID AND c.Dinero = t.Mov AND c.DineroID = t.MovID
				  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
				  JOIN DIOTConcepto co ON co.Concepto = cd.Concepto
	   LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov     
				  JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa                   
				 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
				   AND (mt.Clave IN ('GAS.C'))
				   AND cd.Importe IS NOT NULL
				   AND c.Empresa = @Empresa
				   --AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA
			  GROUP BY c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov, c.MovID, 
					   c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion, c.Dinero, c.DineroID,
					   t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID
				EXCEPT
				SELECT ID, Empresa, Mov, MovID, Ejercicio, Periodo, FechaEmision, Aplica, AplicaID, Importe,
					   TipoCambio, Dinero, DineroID, FechaConciliacion, EsComprobante, DineroMov, DineroMovID,
					   DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert
				  FROM #Pagos

  --BUG22150 BUG24755
  INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor,
						  Nombre, RFC, ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero,
						  Importe, BaseIVA, Tasa, IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, 
						  IEPS, ISAN, Retencion1, Retencion2, PorcentajeDeducible,
						  DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert
						  )
						  --BUG24887
				   SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, ISNULL(NULLIF(RTRIM(cd.AcreedorRef), ''), c.Acreedor), 
						  p.Nombre, p.RFC, p.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('GAS', c.Mov), dbo.fnDIOTTipoTercero(c.Acreedor),
						  cd.Importe*c.TipoCambio, (ISNULL(cd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(cd.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, CASE WHEN NULLIF(cd.Impuestos,0.0) IS NULL THEN NULL ELSE cd.Impuesto1 END, ISNULL(cd.Impuestos,0.0)*c.TipoCambio, cd.Concepto,   cd.Concepto, dbo.fnDIOTEsImportacion('GAS', c.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(cd.Impuestos2,0.0)*c.TipoCambio, 0.0, cd.Retencion*c.TipoCambio, cd.Retencion2*c.TipoCambio, cd.PorcentajeDeducible,
						  t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID, 3
					 FROM Gasto c
					 JOIN GastoD cd ON cd.ID = c.ID
					 JOIN #Tesoreria t ON t.OrigenTipo = 'GAS' AND t.OrigenMID = c.ID AND c.Dinero = t.Mov AND c.DineroID = t.MovID
					 JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
					 JOIN Concepto ON cd.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'
					 JOIN DIOTConcepto co ON co.Concepto = cd.Concepto
					 JOIN Prov p ON p.Proveedor = ISNULL(NULLIF(RTRIM(cd.AcreedorRef), ''), c.Acreedor)
		  LEFT OUTER JOIN Pais ON p.Pais = Pais.Pais
		  LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
		  LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov     
					 JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
					 JOIN Version ver ON 1=1
					WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
					  AND (mt.Clave IN ('GAS.C'))
					  AND cd.Importe IS NOT NULL
					  AND c.Empresa = @Empresa
					  --AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA
END
GO

/**************** xpDIOTObtenerGasto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDIOTObtenerGasto') and type = 'P') drop procedure dbo.xpDIOTObtenerGasto
GO
CREATE PROC xpDIOTObtenerGasto
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
AS
BEGIN
RETURN
END
GO

/**************** spDIOTObtenerGasto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOTObtenerGasto') and type = 'P') drop procedure dbo.spDIOTObtenerGasto
GO
CREATE PROC spDIOTObtenerGasto
			@Estacion				int,
			@Empresa				varchar(5),
			@FechaD					datetime,
			@FechaA					datetime
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE @MovRetencion		varchar(20)
  
	SELECT @MovRetencion = CxpRetencion FROM EmpresaCfgMov WHERE Empresa = @Empresa
	
	EXEC xpDIOTObtenerGasto @Estacion, @Empresa, @FechaD, @FechaA
	IF NOT EXISTS (SELECT * FROM #Pagos WHERE TipoInsert = 4)
	BEGIN
		INSERT INTO #Pagos(ID, Empresa, Mov, MovID, Ejercicio, Periodo, FechaEmision, Aplica, AplicaID, Importe,
						   TipoCambio, Dinero, DineroID, FechaConciliacion, EsComprobante, DineroMov, DineroMovID,
						   DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov,    c.MovID,   SUM((ISNULL(cd.Importe,0.0)+ISNULL(cd.Impuestos,0.0)+ISNULL(cd.Impuestos2,0.0)-ISNULL(cd.Retencion,0.0)-ISNULL(cd.Retencion2,0.0))*c.TipoCambio), 
						   c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion, 1, c.Dinero, c.DineroID,
						   t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID, 4
					  FROM Gasto c
					  JOIN GastoD cd ON cd.ID = c.ID
					  JOIN #Tesoreria t ON t.OrigenTipo = 'GAS' AND t.OrigenMID = c.ID AND c.Dinero = t.Mov AND c.DineroID = t.MovID
					  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
					  JOIN DIOTConcepto co ON co.Concepto = cd.Concepto
		   LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov     
					  JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
					  JOIN DIOTGastoAdicion ON c.Mov = DIOTGastoAdicion.Mov
					 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
					   AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = c.ID AND DModulo IN('CXP') AND DMov <> @MovRetencion)
					   AND cd.Importe IS NOT NULL
					   AND c.Empresa = @Empresa
					   --BUG22429
					   AND mt.Clave <> 'GAS.C'
					   AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA
				  GROUP BY c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov, c.MovID, 
						   c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion,
						   t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID
						   
		-- CARGOS BANCARIOS
		INSERT INTO #Pagos(ID, Empresa, Mov, MovID, Ejercicio, Periodo, FechaEmision, Aplica, AplicaID, Importe,
						   TipoCambio, Dinero, DineroID, FechaConciliacion, EsComprobante, DineroMov, DineroMovID,
						   DineroMov2, DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert)
					SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov,    c.MovID,   SUM((ISNULL(cd.Importe,0.0)+ISNULL(cd.Impuestos,0.0)+ISNULL(cd.Impuestos2,0.0)-ISNULL(cd.Retencion,0.0)-ISNULL(cd.Retencion2,0.0))*c.TipoCambio),
						   c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion, 1, c.Dinero, c.DineroID,
						   t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID, 4
					  FROM Gasto c
					  JOIN GastoD cd ON cd.ID = c.ID
					  JOIN #Tesoreria t ON t.OrigenTipo = 'GAS' AND t.OrigenMID = c.ID
					  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
					  JOIN MovTipo mt2 ON mt2.Mov = t.Mov AND mt2.Modulo = 'DIN'
					  JOIN DIOTConcepto co ON co.Concepto = cd.Concepto
		   LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov     
					  JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
					  JOIN DIOTGastoAdicion ON c.Mov = DIOTGastoAdicion.Mov
					 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
					   AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = c.ID AND DModulo IN('CXP') AND DMov <> @MovRetencion)
					   AND cd.Importe IS NOT NULL
					   AND c.Empresa = @Empresa
					   AND mt.Clave = 'GAS.CB' AND mt2.SubClave NOT IN ('DIN.CBIVA')
					   AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA
				  GROUP BY c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov, c.MovID,
						   c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion,
						   t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID
         
	  --BUG22150 BUG24755
	  INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor, 
							  Nombre, RFC, ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa,
							  IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, PorcentajeDeducible,
							  DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert
							  )
							  --BUG24887
					   SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Acreedor,
							  p.Nombre, p.RFC, p.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('GAS', c.Mov), dbo.fnDIOTTipoTercero(c.Acreedor), cd.Importe*c.TipoCambio, (ISNULL(cd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(cd.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, CASE WHEN NULLIF(cd.Impuestos,0.0) IS NULL THEN NULL ELSE cd.Impuesto1 END, 
							  ISNULL(cd.Impuestos,0.0)*c.TipoCambio, cd.Concepto,   cd.Concepto, dbo.fnDIOTEsImportacion('GAS', c.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(cd.Impuestos2,0.0)*c.TipoCambio, 0.0, cd.Retencion*c.TipoCambio, cd.Retencion2*c.TipoCambio, cd.PorcentajeDeducible,
							  t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID, 4
						 FROM Gasto c
						 JOIN GastoD cd ON cd.ID = c.ID
						 JOIN #Tesoreria t ON t.OrigenTipo = 'GAS' AND t.OrigenMID = c.ID AND c.Dinero = t.Mov AND c.DineroID = t.MovID
						 JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
						 JOIN Concepto ON cd.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'
						 JOIN DIOTConcepto co ON co.Concepto = cd.Concepto
						 JOIN Prov p ON c.Acreedor = p.Proveedor
			  LEFT OUTER JOIN Pais ON p.Pais = Pais.Pais
			  LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais       
			  LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov     
						 JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
						 JOIN Version ver ON 1=1
						 JOIN DIOTGastoAdicion ON c.Mov = DIOTGastoAdicion.Mov
						WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
						  AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = c.ID AND DModulo IN('CXP') AND DMov <> @MovRetencion)        
						  AND cd.Importe IS NOT NULL
						  AND c.Empresa = @Empresa
						  AND mt.Clave NOT IN('GAS.CCH', 'GAS.GTC', 'GAS.C', 'GAS.CP')
						  --AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA

		--BUG22150 BUG24755
		INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor,
								Nombre, RFC, ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa,
								IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, PorcentajeDeducible,
								DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert
								)
								--BUG24887
						 SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, ISNULL(NULLIF(RTRIM(cd.AcreedorRef), ''), c.Acreedor), 
								p.Nombre, p.RFC, p.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('GAS', c.Mov), dbo.fnDIOTTipoTercero(c.Acreedor), cd.Importe*c.TipoCambio, (ISNULL(cd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(cd.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, CASE WHEN NULLIF(cd.Impuestos,0.0) IS NULL THEN NULL ELSE cd.Impuesto1 END, 
								ISNULL(cd.Impuestos,0.0)*c.TipoCambio, cd.Concepto,   cd.Concepto, dbo.fnDIOTEsImportacion('GAS', c.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(cd.Impuestos2,0.0)*c.TipoCambio, 0.0, cd.Retencion*c.TipoCambio, cd.Retencion2*c.TipoCambio, cd.PorcentajeDeducible,
								t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID, 4
						   FROM Gasto c
						   JOIN GastoD cd ON cd.ID = c.ID
						   JOIN #Tesoreria t ON t.OrigenTipo = 'GAS' AND t.OrigenMID = c.ID AND c.Dinero = t.Mov AND c.DineroID = t.MovID
						   JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
						   JOIN Concepto ON cd.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'
						   JOIN DIOTConcepto co ON co.Concepto = cd.Concepto
						   JOIN Prov p ON p.Proveedor = ISNULL(NULLIF(RTRIM(cd.AcreedorRef), ''), c.Acreedor)
				LEFT OUTER JOIN Pais ON p.Pais = Pais.Pais
				LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais       
				LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov     
						   JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
						   JOIN Version ver ON 1=1
						   JOIN DIOTGastoAdicion ON c.Mov = DIOTGastoAdicion.Mov
						  WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
							AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = c.ID AND DModulo IN('CXP') AND DMov <> @MovRetencion)      
							AND cd.Importe IS NOT NULL
							AND c.Empresa = @Empresa
							--BUG22429
							AND mt.Clave IN('GAS.CCH', 'GAS.GTC', /*'GAS.C', */'GAS.CP')
							AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA                       
							
		-- CARGOS BANCARIOS
		INSERT INTO #Documentos(ID, Empresa, Pago, PagoID, Mov, MovID, Ejercicio, Periodo, FechaEmision, Proveedor,
								Nombre, RFC, ImportadorRegistro, Pais, Nacionalidad, TipoDocumento, TipoTercero, Importe, BaseIVA, Tasa,
								IVA, ConceptoClave, Concepto, EsImportacion, EsExcento, IEPS, ISAN, Retencion1, Retencion2, PorcentajeDeducible,
								DineroMov2,	DineroMovID2, DineroFormaPago, DineroImporte, ContID, ContMov, ContMovID, TipoInsert
								)
						 SELECT c.ID, c.Empresa, c.Mov, c.MovID, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, ISNULL(NULLIF(RTRIM(cd.AcreedorRef), ''), c.Acreedor),
								p.Nombre, p.RFC, p.ImportadorRegistro, dp.Pais, dp.Nacionalidad, dbo.fnDIOTTipoDocumento('GAS', c.Mov), dbo.fnDIOTTipoTercero(c.Acreedor), cd.Importe*c.TipoCambio, (ISNULL(cd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(cd.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, CASE WHEN NULLIF(cd.Impuestos,0.0) IS NULL THEN NULL ELSE cd.Impuesto1 END,
								ISNULL(cd.Impuestos,0.0)*c.TipoCambio, cd.Concepto,   cd.Concepto, dbo.fnDIOTEsImportacion('GAS', c.Mov), ISNULL(Concepto.Impuesto1Excento,0), ISNULL(cd.Impuestos2,0.0)*c.TipoCambio, 0.0, cd.Retencion*c.TipoCambio, cd.Retencion2*c.TipoCambio, cd.PorcentajeDeducible,
								t.Mov, t.MovID, t.FormaPago, t.Importe,t.ContID, t.ContMov, t.ContMovID, 4
						   FROM Gasto c
						   JOIN GastoD cd ON cd.ID = c.ID
						   JOIN #Tesoreria t ON t.OrigenTipo = 'GAS' AND t.OrigenMID = c.ID
						   JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
						   JOIN MovTipo mt2 ON mt2.Mov = t.Mov AND mt2.Modulo = 'DIN'
						   JOIN Concepto ON cd.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'
						   JOIN DIOTConcepto co ON co.Concepto = cd.Concepto
						   JOIN Prov p ON p.Proveedor = ISNULL(NULLIF(RTRIM(cd.AcreedorRef), ''), c.Acreedor)
				LEFT OUTER JOIN Pais ON p.Pais = Pais.Pais
				LEFT OUTER JOIN DIOTPais dp ON Pais.Pais = dp.Pais
				LEFT OUTER JOIN DIOTPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov
						   JOIN DIOTCfg ON c.Empresa = DIOTCfg.Empresa
						   JOIN Version ver ON 1=1
						   JOIN DIOTGastoAdicion ON c.Mov = DIOTGastoAdicion.Mov
						  WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
							AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = c.ID AND DModulo IN('CXP') AND DMov <> @MovRetencion)
							AND cd.Importe IS NOT NULL
							AND c.Empresa = @Empresa
							AND mt.Clave = 'GAS.CB' AND mt2.SubClave NOT IN ('DIN.CBIVA')
							AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA
	END
END
GO

/**************** spDIOTClasificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOTClasificar') and type = 'P') drop procedure dbo.spDIOTClasificar
GO
CREATE PROC spDIOTClasificar
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RID					int,
		  @RIDAnt				int,
		  @EsExcento			bit,
		  @EsImportacion		bit,
		  @Tasa					float,
		  @TipoDocumento		varchar(20),
		  @TipoTercero			varchar(20),
		  @Rubro				int
		  
  SELECT @RIDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @RID = MIN(RID)
      FROM #Documentos
     WHERE RID > @RIDAnt
     
    IF @RID IS NULL BREAK
    
    SELECT @RIDAnt = @RID

    SELECT @EsExcento = NULL, @EsImportacion = NULL, @Tasa = NULL, @TipoDocumento = NULL, @TipoTercero = NULL, @Rubro = NULL

    SELECT @EsExcento = ISNULL(EsExcento, 0), 
		   @EsImportacion = ISNULL(EsImportacion, 0), 
		   @Tasa = ISNULL(Tasa, 0), 
		   @TipoDocumento = ISNULL(TipoDocumento, ''), 
		   @TipoTercero = ISNULL(TipoTercero, '')
      FROM #Documentos
     WHERE RID = @RID
    
    EXEC spDIOTTipoOperacion @EsExcento, @EsImportacion, @Tasa, @TipoDocumento, @TipoTercero, @Rubro OUTPUT
    
    UPDATE #Documentos 
       SET TipoOperacion = @Rubro
     WHERE RID = @RID
  END
END
GO

/**************** spDIOTProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOTProcesar') and type = 'P') drop procedure dbo.spDIOTProcesar
GO
CREATE PROC spDIOTProcesar
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RID					int,
		  @RIDAnt				int,  
		  @ImportePago			float,
		  @Aplica				varchar(20),
		  @AplicaID				varchar(20),
		  @Importe				float,
		  @Mov					varchar(20),
		  @MovID				varchar(20),
		  @Factor				float,
		  @FechaPago			datetime,
		  @Signo				int
		  		  
  SELECT @RIDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @RID = MIN(RID)
      FROM #Pagos
     WHERE RID > @RIDAnt
     
    IF @RID IS NULL BREAK
    
    SELECT @RIDAnt = @RID
    
    SELECT @Aplica = NULL, @AplicaID = NULL, @Importe = NULL, @ImportePago = NULL, @Factor = NULL, @FechaPago = NULL
    
    SELECT @Aplica = Aplica, @AplicaID = AplicaID, @ImportePago = ISNULL(Importe, 0), @Mov = Mov, @MovID = MovID, @FechaPago = FechaEmision FROM #Pagos WHERE RID = @RID

    --BUG22834 24887
    SELECT @Importe = SUM(CASE ISNULL(BaseIVAImportacion,0.0) WHEN -1 THEN ISNULL(IVA,0.0) ELSE NULLIF(ISNULL(Importe,0.0) + ISNULL(IVA,0.0) + ISNULL(IEPS,0.0) + ISNULL(ISAN,0.0) - ISNULL(Retencion1,0.0) - ISNULL(Retencion2,0.0) - ISNULL(BaseIVAImportacion,0.0) /*- ISNULL(Retencion3,0.0)*/, 0) END)
      FROM #Documentos 
     WHERE Empresa = @Empresa 
       AND Mov = @Aplica 
       AND MovID = @AplicaID 
       AND Pago = @Mov 
       AND PagoID = @MovID
       
    SELECT @Factor = @ImportePago / NULLIF(@Importe, 0)
    
    --SELECT * FROM #Documentos
        
    INSERT INTO DIOTD(
    		   EstacionTrabajo, Empresa, Mov, MovID, Pago, PagoID, Proveedor, Nombre, RFC, TipoOperacion, Tasa, TipoDocumento, TipoTercero, Pais, Nacionalidad, FechaEmision,  FechaPago, Ejercicio, Periodo, EsImportacion, EsExcento, Concepto, ConceptoClave, Factor,
    		   Importe, 
    		   IVA,  
    		   --BUG22834 BUG24755
    		   Retencion2, ImportadorRegistro, BaseIVAImportacion, DineroMov, DineroMovID, PorcentajeDeducible,
    		   DineroMov2, DineroMovID2, DineroImporte, DineroFormaPago, ContID, ContMov, ContMovID)
		SELECT @Estacion, Empresa, Mov, MovID, Pago, PagoID, Proveedor, Nombre, RFC, TipoOperacion, Tasa, TipoDocumento, TipoTercero, Pais, Nacionalidad, FechaEmision, @FechaPago, Ejercicio, Periodo, EsImportacion, EsExcento, Concepto, ConceptoClave, @Factor,
               ISNULL(SUM(BaseIVA)*@Factor,0),   
               --BUG24887            		
		       CASE TipoOperacion
		         WHEN 2 THEN ISNULL(SUM(IVA)*@Factor,0)		        
		         WHEN 3 THEN ISNULL(SUM(IVA)*@Factor,0)
		         ELSE        ISNULL(SUM(Importe*(Tasa/100.0))*@Factor,0)
		       END,
               ISNULL(SUM(Retencion2)*@Factor,0),
               --BUG22834 BUG24755
               ImportadorRegistro, SUM(BaseIVAImportacion), DineroMov, DineroMovID, PorcentajeDeducible,
               DineroMov2, DineroMovID2, DineroImporte, DineroFormaPago, ContID, ContMov, ContMovID
		  FROM #Documentos 
		 WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID AND Pago = @Mov AND PagoID = @MovID
		 --BUG24755
		 GROUP BY Empresa, Mov, MovID, Pago, PagoID, Proveedor, Nombre, RFC, Tasa, TipoDocumento, TipoTercero, Pais, 
				  Nacionalidad, FechaEmision, Ejercicio, Periodo, EsImportacion, EsExcento, Concepto, ConceptoClave, 
				  TipoOperacion, ImportadorRegistro, DineroMov, DineroMovID, PorcentajeDeducible,
				  DineroMov2, DineroMovID2, DineroImporte, DineroFormaPago, ContID, ContMov, ContMovID

  END

  UPDATE DIOTD 
     SET Importe = Importe*-1,
         IVA = IVA*-1,
         Retencion2 = Retencion2*-1
    FROM DIOTD 
    JOIN DIOTIVARubro ON DIOTD.TipoOperacion = DIOTIVARubro.Rubro
   WHERE EstacionTrabajo = @Estacion
     AND DIOTIVARubro.Signo = 'Negativo'
         
  INSERT INTO DIOT(
			EstacionTrabajo, Rubro,         Descripcion, Importe,      IVA)
    SELECT @Estacion,        TipoOperacion, Descripcion, SUM(Importe), SUM(IVA)
      FROM DIOTIVARubro
      JOIN DIOTD ON DIOTIVARubro.Rubro = DIOTD.TipoOperacion
     WHERE EstacionTrabajo = @Estacion 
     GROUP BY TipoOperacion, Descripcion

  INSERT INTO DIOT(
			EstacionTrabajo, Rubro, Descripcion, Importe, IVA)
    SELECT @Estacion,        Rubro, Descripcion, 0,       0
      FROM DIOTIVARubro
     WHERE Rubro NOT IN(SELECT Rubro FROM DIOT WHERE EstacionTrabajo = @Estacion)
END
GO

/**************** spDIOTLayout ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOTLayout') and type = 'P') drop procedure dbo.spDIOTLayout
GO
CREATE PROC spDIOTLayout
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Proveedor		varchar(20),
		  @ProveedorAnt		varchar(20),
		  @Rubro1			float,
		  @Rubro1IVA		float,
		  @Rubro2			float,
		  @Rubro2IVA		float,
		  @Rubro3			float,
		  @Rubro3IVA		float,
		  @Rubro4			float,
		  @Rubro4IVA		float,
		  @Rubro5			float,
		  @Rubro6			float, 
		  @Rubro7			float,
		  @Retencion2		float,
		  @Rubro10IVA		float

  SELECT @ProveedorAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Proveedor = MIN(Proveedor)
      FROM DIOTD
     WHERE EstacionTrabajo = @Estacion
       AND Proveedor > @ProveedorAnt
  
    IF @Proveedor IS NULL BREAK
    
    SELECT @ProveedorAnt = @Proveedor
    
    SELECT @Rubro1 = NULL, @Rubro1IVA = NULL, @Rubro2 = NULL, @Rubro2IVA = NULL, @Rubro3 = NULL, @Rubro3IVA = NULL, @Rubro4 = NULL, @Rubro4IVA = NULL, @Rubro5 = NULL, 
		   @Rubro6 = NULL, @Rubro7 = NULL, @Retencion2 = NULL, @Rubro10IVA = NULL

    SELECT @Rubro1     = ISNULL(SUM(Importe), 0)   FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 1

    --BUG24755
    SELECT @Rubro1IVA  = ISNULL(SUM(IVA),0) FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 1
      
    SELECT @Rubro3     = ISNULL(SUM(Importe*((100-PorcentajeDeducible)/100.0) ), 0) FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 2
	                    --ISNULL(SUM(Importe), 0)   FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 2
    
    --BUG24755
    SELECT @Rubro3IVA  = ISNULL(SUM(IVA*((100-PorcentajeDeducible)/100.0) ), 0) FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 2
	                    --ISNULL(SUM(IVA),0) FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 2        
    
    --BUG22834
    SELECT @Rubro5     = ISNULL(SUM(Importe), 0)   FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 3
    SELECT @Rubro6     = ISNULL(SUM(Importe), 0)   FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 4
    SELECT @Rubro7     = ISNULL(SUM(Importe), 0)   FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 5
    SELECT @Retencion2 = ISNULL(SUM(Retencion2), 0)FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor
    SELECT @Rubro10IVA = ISNULL(SUM(IVA), 0)       FROM DIOTD WHERE EstacionTrabajo = @Estacion AND Proveedor = @Proveedor AND TipoOperacion = 7
    
    INSERT INTO	DIOTLayout(
            EstacionTrabajo,
			TipoTercero, 
			TipoOperacion, 
			RFC, IDFiscal, NombreExtranjero, 
			Pais, 
			Nacionalidad,  Rubro1,  Rubro1IVA,  /*Rubro2,  Rubro2IVA,  */Rubro3 , Rubro3IVA,  /*Rubro4,  Rubro4IVA,  */Rubro5,  Rubro6,  Rubro7,  Retencion2,  Rubro10IVA)
	 SELECT @Estacion,
	        CASE d.TipoTercero WHEN 'Nacional' THEN '04' WHEN 'Extranjero' THEN '05' ELSE '04' END, 
	        CASE ISNULL(o.TipoOperacion, 'Otros') WHEN 'Prestacion Servicios' THEN '03' WHEN 'Arrendamiento Inmuebles' THEN '06' WHEN 'Otros' THEN '85' END, 
	        ISNULL(d.RFC, ''), ISNULL(d.ImportadorRegistro, ''), ISNULL(d.Nombre, ''), 
	        ISNULL(p.Clave, ''), 
	        ISNULL(d.Nacionalidad, ''), @Rubro1, @Rubro1IVA, /*@Rubro2, @Rubro2IVA, */@Rubro3, @Rubro3IVA, /*@Rubro4, @Rubro4IVA, */@Rubro5, @Rubro6, @Rubro7, @Retencion2, @Rubro10IVA
       FROM DIOTD d
       LEFT OUTER JOIN DIOTProvTipoOperacion o ON d.Proveedor = o.Proveedor
       LEFT OUTER JOIN DIOTPais p ON d.Pais = p.Pais
      WHERE EstacionTrabajo = @Estacion
        AND d.Proveedor = @Proveedor
      GROUP BY d.TipoTercero, o.TipoOperacion, d.RFC, d.ImportadorRegistro, d.Nombre, p.Clave, d.Nacionalidad
  END
  
  UPDATE DIOTLayout 
     SET Cadena = ISNULL(TipoTercero, '') + '|' + 
				  ISNULL(TipoOperacion, '') + '|'+
				  CASE ISNULL(TipoTercero, '') WHEN '04' THEN ISNULL(RFC, '') ELSE '' END + '|' + 
                  --BUG22264				  				  
				  CASE ISNULL(TipoTercero, '') WHEN '05' THEN ISNULL(IDFiscal, '') ELSE '' END + '|' + 
                  --BUG22264				  				  
				  CASE ISNULL(TipoTercero, '') WHEN '05' THEN ISNULL(NombreExtranjero, '') ELSE '' END + '|' +
                  --BUG22264
                  CASE ISNULL(TipoTercero, '') WHEN '05' THEN ISNULL(Pais, '') ELSE '' END + '|' + 
                  CASE ISNULL(TipoTercero, '') WHEN '05' THEN ISNULL(Nacionalidad, '') ELSE '' END + '|' + 
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro1)), 0)), '') + '|' +		--Importe a tasa 16%
                  '|' +																										--Importe a tasa 15% periodo Enero 2010
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro1IVA)), 0)), '') + '|' +	--IVA a tasa 16%
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro2)), 0)), '') + '|' +		--Importe a tasa 11%
                  '|' +																										--Importe a tasa 10% periodo Enero 2010
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro2IVA)), 0)), '') + '|' +	--IVA a tasa 11%
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro3)), 0)), '') + '|' +		--Importe importacion a tasa 16%

                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro3IVA)), 0)), '') + '|' +	--IVA importacion a tasa 16%
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro4)), 0)), '') + '|' +		--Importe importacion a tasa 11%
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro4IVA)), 0)), '') + '|' +	--IVA importacion a tasa 16%

                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro5)), 0)), '') + '|' +		--Importe importacion excentos
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro6)), 0)), '') + '|' +		--Importe a tasa 0%
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro7)), 0)), '') + '|' +		--Importe importacion excentos
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Retencion2)), 0)), '') + '|' +	--Retencion de IVA
                  ISNULL(CONVERT(varchar(max), NULLIF(CONVERT(int, dbo.fnDIOTLayoutImporte(Rubro10IVA)), 0)), '') + '|'		--IVA devoluciones y descuentos
    FROM DIOTLayout 
   WHERE EstacionTrabajo = @Estacion
END
GO

/**************************************************************************************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.spDIOTXMLDPIVA') AND TYPE = 'P') 
DROP PROCEDURE dbo.spDIOTXMLDPIVA
GO
CREATE PROCEDURE spDIOTXMLDPIVA
	@Estacion		int,
	@Bandera		int,
	@FechaD			datetime,
	@FechaA			datetime,
	@BanderaOk		int,
	@Ok				int
--//WITH ENCRYPTION
AS
BEGIN
DECLARE
	@Xml			as Varchar(max),
	@XmlXsd			as xml(DPIVA),
	@Totales		as Varchar(max),
	@ProvNacional	as Varchar(max),
	@ProvExtranjero	as Varchar(max),
	@ProvGlobal		as Varchar(max),
	--------------------------------
	@Version		as Varchar(4),
	@Ejercicio		as int,
	@TipoPeriodo	varchar(2),
	@Periodo		varchar(2),
	@DPIVA			as bit,
	@TipoDec		as int,
	@FolioAnt		as varchar(14),
	@FechPresAnt	as varchar(10),
	@Empresa		as varchar(5)
	
	
	SELECT @Empresa = Empresa FROM DIOTD WHERE EstacionTrabajo = @Estacion
	
	IF @Bandera = 1
	BEGIN
		DELETE FROM DIOTParamXML WHERE Estacion = @Estacion
		
		INSERT INTO DIOTParamXML(Estacion, Ejercicio, TipoPeriodo, Periodo)
						  SELECT @Estacion, DATEPART(YEAR,CAST(@FechaD AS DATETIME)),ClavePeriodicidad, ClavePeriodo 
						    FROM DIOTCatPeriodo 
						   WHERE CAST(@FechaD AS DATETIME) >= CAST((FechaInicio+CAST(DATEPART(YEAR,CAST(@FechaD AS DATETIME)) AS VARCHAR(10))) AS DATETIME)
						     AND CAST(@FechaA AS DATETIME) <= CAST((FechaFin+CAST(DATEPART(YEAR,CAST(@FechaA AS DATETIME)) AS VARCHAR(10))) AS DATETIME)
						     AND ClavePeriodicidad = CASE DATEDIFF(mm,CAST(@FechaD AS DATETIME), CAST(@FechaA AS DATETIME))
														WHEN 0 THEN '01'
														WHEN 1 THEN '02'
														WHEN 2 THEN '03'
														WHEN 3 THEN '04'
														WHEN 4 THEN '05'
														WHEN 6 THEN '06'
														ELSE '06'
													 END
		
		RETURN				  
	END 
	
	SELECT @Version = '1.0',
		   @Ejercicio = Ejercicio,
		   @TipoPeriodo = TipoPeriodo,
		   @Periodo = Periodo,
		   @DPIVA = DPIVA,
		   @TipoDec = CASE TipoDec WHEN 1 THEN 2 ELSE 1 END,
		   @FolioAnt = FolioAnt,
		   @FechPresAnt = REPLACE(CONVERT(VARCHAR(10),FechaAnt,102),'.','-')
	  FROM DIOTParamXML 
	 WHERE Estacion = @Estacion
	 
/*********************************     VALIDACIONES     ******************************************/

DECLARE @Mensaje TABLE(Mensaje varchar(255))	
	
	IF EXISTS(SELECT * FROM DIOTD WHERE ISNULL(RFC,'') = '' AND EstacionTrabajo = @Estacion) AND @Ok = 0
		BEGIN
			INSERT INTO @Mensaje(Mensaje) VALUES('Existen errores en la información')
			INSERT INTO @Mensaje(Mensaje)
			SELECT TOP 10 'El Proveedor: '+Proveedor+' No tiene RFC'
			  FROM DIOTD 
			 WHERE ISNULL(RFC,'') = ''
			   AND EstacionTrabajo = @Estacion
			   AND TipoTercero = 'Nacional'
			EXCEPT
			SELECT Mensaje FROM @Mensaje

			SET @Ok = 1
		END
		
		
	IF NOT EXISTS(SELECT * FROM DIOTD A JOIN DIOTProvTipoOperacion B ON A.Proveedor = B.Proveedor) AND @Ok = 0
		BEGIN
			INSERT INTO @Mensaje(Mensaje)
			SELECT 'Falta configurar el Tipo de Operación de los proveedores'
			
			SET @Ok = 1
		END

	IF EXISTS(SELECT * FROM DIOTD A LEFT JOIN DIOTProvTipoOperacion B ON A.Proveedor = B.Proveedor WHERE B.Proveedor IS NULL) AND @Ok = 0		
		BEGIN
			INSERT INTO @Mensaje(Mensaje)
			SELECT TOP 5 'Falta configurar el Tipo de Operación del proveedor: ' +A.Proveedor
			  FROM DIOTD A 
		 LEFT JOIN DIOTProvTipoOperacion B 
				ON A.Proveedor = B.Proveedor
			 WHERE B.Proveedor IS NULL
			EXCEPT
			SELECT Mensaje FROM @Mensaje
			
			SET @Ok = 1
		END		
		
/*************************************************************************************************/		

	IF @DPIVA = 1 AND @BanderaOk = 1 AND @Ok = 0
	BEGIN
	SELECT @ProvNacional = CAST((
		SELECT	CASE B.TipoOperacion WHEN 'Otros' THEN '85'
									 WHEN 'Arrendamiento Inmuebles' THEN '06'
									 WHEN 'Prestacion Servicios' THEN '03'
									 ELSE ''								
				END								as "@TipoOperac",
				A.RFC							as "@RFCProv",
				CAST(SUM(CASE A.TipoOperacion WHEN 1 THEN ((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagTas15o16IVA",
				0								as "@ValActPagTas15IVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 1 THEN (A.IVA/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@MonIVAPagNoAcrTas15o16",
				0.0								as "@ValActPagTas10u11IVA",
				0.0								as "@ValActPagTas10IVA",
				0.0								as "@MonIVAPagNoAcrTas10u11",
				CAST(SUM(CASE A.TipoOperacion WHEN 4 THEN ((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagTas0IVA",						  
				CAST(SUM(CASE A.TipoOperacion WHEN 3 THEN ((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagNoIVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 3 THEN A.Retencion2
											  ELSE 0
						  END) AS MONEY)		as "@IVARetCont",
				CAST(SUM(CASE A.TipoOperacion WHEN 7 THEN (A.IVA/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@IVADevDescyBonifComp"
		  FROM	DIOTD A
		  JOIN	DIOTProvTipoOperacion B ON A.Proveedor = B.Proveedor
		 WHERE	A.EstacionTrabajo = @Estacion
		   AND	A.TipoTercero = 'Nacional'
		   AND	A.RFC IS NOT NULL
	  GROUP BY	B.TipoOperacion, A.RFC
		 FOR XML PATH ('ProvNacional')
		) AS VARCHAR(max))

	SELECT @ProvExtranjero = CAST((
		SELECT	CASE B.TipoOperacion WHEN 'Otros' THEN '85'
									 WHEN 'Prestacion Servicios' THEN '03'
									 ELSE ''								
				END								as "@TipoOperac",
				''								as "@RFCProv",
				A.ImportadorRegistro			as "@NumIDFiscal",
				A.Nombre						as "@NombExtranjero",
				C.Clave							as "@PaisResidencia",
				A.Nacionalidad					as "@Nacionalidad",
				0.0								as "@ValActPagTas15o16IVA",
				0.0								as "@MonIVAPagNoAcrTas15o16",
				0.0								as "@ValActPagTas10u11IVA",
				0.0								as "@ValActPagTas10IVA",
				0.0								as "@MonIVAPagNoAcrTas10u11",
				CAST(SUM(CASE A.TipoOperacion WHEN 2 THEN (((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagImpBySTas15o16IVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 2 THEN ((A.IVA/A.DineroImporte)*A.DineroImporte)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@MonIVAPagNoAcrImpTas15o16",
				0.0								as "@ValActPagImpBySTas10u11IVA",
				0.0								as "@MonIVAPagNoAcrImpTas10u11",
				CAST(SUM(CASE A.TipoOperacion WHEN 3 THEN (((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagImpBySNoIVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 4 THEN (((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagTas0IVA",
				0.0								as "@ValActPagNoIVA",
				0.0								as "@IVARetCont",
				0.0								as "@IVADevDescyBonifComp"
		  FROM	DIOTD A
		  JOIN	DIOTProvTipoOperacion B ON A.Proveedor = B.Proveedor
  		  JOIN	DIOTPais C ON A.Pais = C.Pais
		 WHERE	A.EstacionTrabajo = @Estacion
		   AND	A.TipoTercero = 'Extranjero'
		 GROUP BY B.TipoOperacion, A.RFC, A.ImportadorRegistro, A.Nombre, C.Clave, A.Nacionalidad
		 FOR XML PATH ('ProvExtranjero')
		) AS VARCHAR(max))

	SELECT @ProvGlobal = CAST((
		SELECT	CASE B.TipoOperacion WHEN 'Otros' THEN '85'
									 WHEN 'Arrendamiento Inmuebles' THEN '06'
									 WHEN 'Prestacion Servicios' THEN '03'
									 ELSE ''								
				END								as "@TipoOperac",
				CAST(SUM(CASE A.TipoOperacion WHEN 1 THEN ((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagTas15o16IVA",
				0								as "@ValActPagTas15IVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 1 THEN (A.IVA/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@MonIVAPagNoAcrTas15o16",
				0.0								as "@ValActPagTas10u11IVA",
				0.0								as "@ValActPagTas10IVA",
				0.0								as "@MonIVAPagNoAcrTas10u11",
				CAST(SUM(CASE A.TipoOperacion WHEN 2 THEN (((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagImpBySTas15o16IVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 2 THEN ((A.IVA/A.DineroImporte)*A.DineroImporte)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@MonIVAPagNoAcrImpTas15o16",
				0.0								as "@ValActPagImpBySTas10u11IVA",
				0.0								as "@MonIVAPagNoAcrImpTas10u11",
				CAST(SUM(CASE A.TipoOperacion WHEN 3 THEN (((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagImpBySNoIVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 4 THEN ((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagTas0IVA",						  
				CAST(SUM(CASE A.TipoOperacion WHEN 3 THEN ((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@ValActPagNoIVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 3 THEN A.Retencion2
											  ELSE 0
						  END) AS MONEY)		as "@IVARetCont",
				CAST(SUM(CASE A.TipoOperacion WHEN 7 THEN (A.IVA/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@IVADevDescyBonifComp"
		  FROM	DIOTD A
		  JOIN	DIOTProvTipoOperacion B ON A.Proveedor = B.Proveedor
		 WHERE	A.EstacionTrabajo = @Estacion
		   AND	A.TipoTercero NOT IN ('Nacional','Extranjero')
		 GROUP BY B.TipoOperacion, A.RFC
		 FOR XML PATH ('ProvNacional')
		) AS VARCHAR(max))
	
	SELECT @Totales = CAST((
		SELECT	COUNT(*) as "@TotOperac", 
				CAST(SUM(CASE A.TipoOperacion WHEN 1 THEN ((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@TotActPagTas15o16IVA",
				0								as "@TotActPagTas15IVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 1 THEN (A.IVA/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@TotIVAPagNoAcrTas15o16",
				0.0								as "@TotActPagTas10u11IVA",
				0.0								as "@TotActPagTas10IVA",
				0.0								as "@TotIVAPagNoAcrTas10u11",
				CAST(SUM(CASE A.TipoOperacion WHEN 2 THEN (((A.Importe+A.IVA)/A.DineroImporte)*A.DineroImporte)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@TotActPagImpBySTas15o16IVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 2 THEN ((A.IVA/A.DineroImporte)*A.DineroImporte)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@TotIVAPagNoAcrImpTas15o16",
				0.0								as "@TotActPagImpBySTas10u11IVA",
				0.0								as "@TotIVAPagNoAcrImpTas10u11",
				CAST(SUM(CASE A.TipoOperacion WHEN 3 THEN ((A.DineroImporte/(A.Importe+A.IVA))*A.Importe)
														  *((100-PorcentajeDeducible)/100.0)
											  ELSE 0
						  END) AS MONEY)		as "@TotActPagImpBySNoPagIVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 4 THEN (A.DineroImporte/(A.Importe+A.IVA))*A.Importe
											  ELSE 0
						  END) AS MONEY)		as "@TotDemActPagTas0IVA",						  
				CAST(SUM(CASE A.TipoOperacion WHEN 3 THEN (A.DineroImporte/(A.Importe+A.IVA))*A.Importe
											  ELSE 0

						  END) AS MONEY)		as "@TotActPagNoPagIVA",
				CAST(SUM(CASE A.TipoOperacion WHEN 3 THEN A.Retencion2
											  ELSE 0
						  END) AS MONEY)		as "@TotIVARetCont",
				CAST(SUM(CASE A.TipoOperacion WHEN 7 THEN (A.IVA/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@TotIVADevDescyBonifComp",
				----
				CAST(SUM(CASE A.TipoOperacion WHEN 1 THEN (A.IVA/A.DineroImporte)*A.DineroImporte
											  ELSE 0
						  END) AS MONEY)		as "@TotIVATraslContExcImpByS",
				0.0								as "@TotIVAPagImpByS"
		  FROM	DIOTD A
		  JOIN	DIOTProvTipoOperacion B ON A.Proveedor = B.Proveedor
		 WHERE	A.EstacionTrabajo = @Estacion
		 --GROUP BY B.TipoOperacion
		 FOR XML PATH ('Totales')
		) AS VARCHAR(max))
	END
	
	--- SI SE PRESENTA SIN MOVIMIENTOS
	IF @DPIVA = 0 AND @Ok = 0
	BEGIN
	SELECT @Totales = CAST((SELECT	 0   as "@TotOperac",
									0.0	 as "@TotActPagTas15o16IVA",
									0.0  as "@TotActPagTas15IVA",
									0.0  as "@TotIVAPagNoAcrTas15o16",
									0.0	 as "@TotActPagTas10u11IVA",
									0.0	 as "@TotActPagTas10IVA",
									0.0  as "@TotIVAPagNoAcrTas10u11",
									0.0  as "@TotActPagImpBySTas15o16IVA",
									0.0  as "@TotIVAPagNoAcrImpTas15o16",
									0.0  as "@TotActPagImpBySTas10u11IVA",
									0.0  as "@TotIVAPagNoAcrImpTas10u11",
									0.0  as "@TotActPagImpBySNoPagIVA",
									0.0  as "@TotDemActPagTas0IVA",						  
									0.0  as "@TotActPagNoPagIVA",
									0.0  as "@TotIVARetCont",
									0.0  as "@TotIVADevDescyBonifComp",
									0.0  as "@TotIVATraslContExcImpByS",
									0.0  as "@TotIVAPagImpByS"
							FOR XML PATH ('Totales')
							) AS VARCHAR(max))
	END


IF @TipoDec = 2
BEGIN
	SELECT @Xml = CAST(( SELECT	@Version		as "@Version",
								@Ejercicio		as "@Ejercicio",
								@TipoPeriodo	as "@TipoPerid", --Mensual
								@Periodo		as "@Periodo",	 --Periodo
								@DPIVA			as "@DPIVA",
								@TipoDec		as "@TipoDec",
								@FolioAnt		as "@FolioAnt",  --Opcional Complementaria
								@FechPresAnt	as "@FechPresAnt",--Opcional Complementaria
								CAST(@Totales as Xml),
								CAST(@ProvNacional as XML),
								CAST(@ProvExtranjero as XML),
								CAST(@ProvGlobal as XML)
						FOR XML PATH ('DPIVA')) as Varchar(max))
END

IF @TipoDec = 1
BEGIN
	SELECT @Xml = CAST((SELECT	@Version		as "@Version",
								@Ejercicio		as "@Ejercicio",
								@TipoPeriodo	as "@TipoPerid", --Mensual
								@Periodo		as "@Periodo",	 --Periodo
								@DPIVA			as "@DPIVA",	
								@TipoDec		as "@TipoDec",
								CAST(@Totales as Xml),
								CAST(@ProvNacional as XML),
								CAST(@ProvExtranjero as XML),
								CAST(@ProvGlobal as XML)
						FOR XML PATH ('DPIVA')) as Varchar(max))
END

SELECT @Xml = '<?xml version="1.0" encoding="UTF-8"?>
<DD:DoctoDigital xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:DD="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/1"
xmlns:DPIVA="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/TipoDPIVA/1"
xsi:schemaLocation="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/1
http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/1/DoctoDigital.xsd
http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/TipoDPIVA/1
http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/TipoDPIVA/1/DPIVA.xsd"> <DD:TipoDoctoDigital>'+@Xml
SELECT @Xml = REPLACE(@Xml,'<DPIVA ','<DPIVA:DPIVA ')
SELECT @Xml = REPLACE(@Xml,'/DPIVA>', '/DPIVA:DPIVA></DD:TipoDoctoDigital></DD:DoctoDigital>')
--SELECT @Xml
--SELECT CAST(@Xml as XML)


IF @BanderaOk = 0
	BEGIN
		SELECT CAST(@Ok AS VARCHAR(1))
		RETURN
	END


IF @BanderaOk = 1
BEGIN
	IF @Ok = 1
		BEGIN
			SELECT Mensaje FROM @Mensaje
		END

	IF @Ok = 0
		BEGIN
			BEGIN TRY
				--SELECT @XmlXsd = CAST(@Xml AS XML)
				INSERT DIOTHistArchivos(Empresa, RFC, Ejercicio, TipoPeriodo, Periodo, TipoDeclaracion, FechaEmision)
								 SELECT Empresa, RFC, @Ejercicio, @TipoPeriodo, @Periodo, CASE @TipoDec WHEN 1 THEN 'N' ELSE 'C' END, GETDATE()
								   FROM Empresa
								  WHERE	Empresa = @Empresa
								 EXCEPT 
								 SELECT Empresa, RFC, Ejercicio, TipoPeriodo, Periodo, TipoDeclaracion, FechaEmision
								   FROM DIOTHistArchivos

				SELECT @Xml
			END TRY
			BEGIN CATCH
				RETURN @@ERROR
			END CATCH
		END			
END

END
GO

/*
03 = Prestación de Servicios Profesionales, 
06 = Arrendamiento de Inmuebles y 
85 = Otros
*/

--EXEC spDIOT 1, 'DEMO', '1/1/2010', '1/1/2014'
/**************** spDIOT ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDIOT') and type = 'P') drop procedure dbo.spDIOT
GO
CREATE PROC spDIOT
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS
BEGIN  
  SET NOCOUNT ON
  DECLARE @CxpAnticiposPagadosPeriodo	bit,
		  @GASIncluirComprobantes		bit,
		  @GASIncluirMovSinCxp			bit,
		  @CalcularBaseImportacion		bit,
		  --BUG24887
		  @COMSIVAImportacionAnticipado	bit
  
  SELECT @CxpAnticiposPagadosPeriodo = ISNULL(CxpAnticiposPagadosPeriodo, 0),
		 @GASIncluirComprobantes = ISNULL(GASIncluirComprobantes, 0),
		 @GASIncluirMovSinCxp    = ISNULL(GASIncluirMovSinCxp, 0),
		 @CalcularBaseImportacion = ISNULL(CalcularBaseImportacion, 0),
		 --BUG24887
		 @COMSIVAImportacionAnticipado = ISNULL(COMSIVAImportacionAnticipado, 0)
    FROM DIOTCfg
   WHERE Empresa = @Empresa
  
  DELETE DIOT       WHERE EstacionTrabajo = @Estacion
  DELETE DIOTD      WHERE EstacionTrabajo = @Estacion
  DELETE DIOTLayout WHERE EstacionTrabajo = @Estacion

  --- Se crea tabla que servirá como pivote para generación de la información
	CREATE TABLE #Movtos (Empresa		varchar(5)	NULL,
						  ModuloRaiz	varchar(5)	NULL,
						  IDRaiz		int			NULL,
						  MovRaiz		varchar(20)	NULL,
						  MovIDRaiz		varchar(20)	NULL,
						  OModulo		varchar(5)	NULL,
						  OID			int			NULL,
						  OMov			varchar(20)	NULL,
						  OMovID		varchar(20)	NULL,
						  DModulo		varchar(5)	NULL,
						  DID			int			NULL,
						  DMov			varchar(20)	NULL,
						  DMovID		varchar(20)	NULL
						 )
						 
  CREATE TABLE #Tesoreria(Empresa		varchar(5)	NULL,
						  ID			int			NULL,
						  Mov			varchar(20) NULL,
						  MovID			varchar(20) NULL,
						  RID			int			NULL,
						  FormaPago		varchar(50) NULL,
						  Importe		float		NULL,
						  FechaEmision	datetime	NULL,
						  OrigenTipo	varchar(20) NULL, 
						  OrigenIID		int			NULL,
						  Origen		varchar(20) NULL, 
						  OrigenMID		varchar(20) NULL,
						  ContID		int			NULL, 
						  ContMov		varchar(20) NULL, 
						  ContMovID		varchar(20) NULL
						 )
  
  CREATE TABLE #Pagos(
    RID					int			IDENTITY,
    ID					int			NULL,
    Empresa				varchar(5)	COLLATE Database_Default	NULL,
    Mov					varchar(20)	COLLATE Database_Default	NULL,
    MovID				varchar(20)	COLLATE Database_Default	NULL,
    Ejercicio			int			NULL,
    Periodo				int			NULL,
    FechaEmision		datetime	NULL,
    Aplica				varchar(20)	COLLATE Database_Default	NULL,
    AplicaID			varchar(20)	COLLATE Database_Default	NULL,
    Importe				float		NULL,
    TipoCambio			float		NULL,
    Dinero				varchar(20)	COLLATE Database_Default	NULL,
    DineroID			varchar(20)	COLLATE Database_Default	NULL,
    FechaConciliacion	datetime	NULL,
    EsAnticipo			bit			NULL DEFAULT 0,
    EsComprobante		bit			NULL DEFAULT 0,
    DineroMov			varchar(20) NULL,
	DineroMovID			varchar(20) NULL,
	TipoInsert          int         NULL,
	-----------------------------------------------------------------
	DineroMov2			varchar(20) NULL,
	DineroMovID2		varchar(20) NULL,
	DineroFormaPago		varchar(50) NULL,
	DineroImporte		float		NULL,
	ContID				int			NULL,
	ContMov				varchar(20) NULL,
	ContMovID			varchar(20) NULL
    )

  CREATE TABLE #Documentos(
    RID					int			IDENTITY, 
    ID					int			NULL,
    Empresa				varchar(5)	COLLATE Database_Default	NULL,
    Pago				varchar(20)	COLLATE Database_Default	NULL,
    PagoID				varchar(20)	COLLATE Database_Default	NULL,    
	ModuloID            int			NULL,
    Mov					varchar(20)	COLLATE Database_Default	NULL,
    MovID				varchar(20)	COLLATE Database_Default	NULL,
    Ejercicio			int			NULL,
    Periodo				int			NULL,
    FechaEmision		datetime	NULL,
    Proveedor			varchar(10)	COLLATE Database_Default	NULL,
    Nombre				varchar(100)COLLATE Database_Default	NULL,
    RFC					varchar(15) COLLATE Database_Default	NULL,
    ImportadorRegistro	varchar(30) COLLATE Database_Default	NULL,
    Pais				varchar(50) COLLATE Database_Default	NULL,    
    Nacionalidad		varchar(50) COLLATE Database_Default	NULL,
    TipoDocumento		varchar(20) COLLATE Database_Default	NULL,
    TipoTercero			varchar(20) COLLATE Database_Default	NULL,    
    TipoOperacion		int			NULL,
    Importe				float		NULL,
    IVA					float		NULL,
    IEPS				float		NULL,
    ISAN				float		NULL,
    Retencion1			float		NULL,
    Retencion2			float		NULL,
    BaseIVA				float		NULL,
    Tasa				float		NULL,
    ConceptoClave		varchar(50) COLLATE Database_Default	NULL,
    --BUG24767
    Concepto			varchar(100)COLLATE Database_Default	NULL,    
    EsImportacion		bit			NULL,
    EsExcento			bit			NULL,
    --BUG22834
    BaseIVAImportacion	float		NULL,
    DineroMov			varchar(20) NULL,
	DineroMovID			varchar(20) NULL,
    --BUG24755
    PorcentajeDeducible	float		NOT NULL DEFAULT 100,
	TipoInsert			int			NULL,
    ImporteFactor       float       NULL,
    -------------------------------------------------------------------
	DineroMov2			varchar(20) NULL,
	DineroMovID2		varchar(20) NULL,
	DineroFormaPago		varchar(50) NULL,
	DineroImporte		float		NULL,
	ContID				int			NULL,
	ContMov				varchar(20) NULL,
	ContMovID			varchar(20) NULL
    )
  
  CREATE INDEX Importe ON #Documentos(Mov, MovID, Pago, PagoID, Empresa) INCLUDE(Importe, IVA, IEPS, ISAN, Retencion1, Retencion2)
  
  --- Obtenemos los Movimientos de Tesorería
  BEGIN	
	WITH Cte
		AS (
	SELECT 0 [Orden], D.Empresa, M.DModulo [ModuloRaiz], M.DID [IDRaiz], M.DMov [MovRaiz], M.DMovID [MovIDRaiz],
		   M.OModulo, M.OID, M.OMov, M.OMovID, M2.DModulo, M2.DID, M2.DMov, M2.DMovID  
	  FROM MovFlujo M
 LEFT JOIN MovFlujo M2 
		ON M.DModulo = M2.OModulo 
	   AND M.DID = M2.OID
	   AND M2.DModulo = 'CONT'
	  JOIN Dinero D 
		ON M.DID = D.ID 
	   AND M.DModulo = 'DIN'
	   AND D.Empresa = @Empresa
	   AND (D.FechaEmision >= @FechaD OR D.FechaConciliacion >= @FechaD)
	   AND (D.FechaEmision <= @FechaA OR D.FechaConciliacion <= @FechaA)
	   AND D.Estatus IN ('CONCLUIDO','CONCILIADO')
	 UNION ALL   
	SELECT C.Orden+1, C.Empresa, C.ModuloRaiz, C.IDRaiz, C.MovRaiz, C.MovIDRaiz,
		   M.OModulo, M.OID, M.OMov, M.OMovID, C.DModulo, C.DID, C.DMov, C.DMovID  
	  FROM MovFlujo M
	  JOIN Cte C ON M.DModulo = C.OModulo AND M.DID = C.OID
		   )
	INSERT INTO #Movtos(Empresa, ModuloRaiz, IDRaiz, MovRaiz, MovIDRaiz, 
						OModulo, OID, OMov, OMovID, DModulo, DID, DMov, DMovID)
				 SELECT Empresa, ModuloRaiz, IDRaiz, MovRaiz, MovIDRaiz, 
						OModulo, OID, OMov, OMovID, DModulo, DID, DMov, DMovID
				   FROM Cte ORDER BY 4,1
  END
        
  EXEC spDIOTObtenerPago @Estacion, @Empresa, @FechaD, @FechaA

  IF @CxpAnticiposPagadosPeriodo = 1
    EXEC spDIOTObtenerAnticipo @Estacion, @Empresa, @FechaD, @FechaA

  IF @GASIncluirComprobantes = 1
    EXEC spDIOTObtenerComprobante @Estacion, @Empresa, @FechaD, @FechaA

  IF @GASIncluirMovSinCxp = 1
    EXEC spDIOTObtenerGasto @Estacion, @Empresa, @FechaD, @FechaA
  
  --BUG24887
  EXEC spDIOTObtenerDocumento @Estacion, @Empresa, @FechaD, @FechaA, @CalcularBaseImportacion, @COMSIVAImportacionAnticipado, @GASIncluirMovSinCxp

  EXEC spDIOTClasificar @Estacion, @Empresa, @FechaD, @FechaA
  
  EXEC spDIOTProcesar @Estacion, @Empresa, @FechaD, @FechaA
  
  EXEC spDIOTLayout @Estacion, @Empresa, @FechaD, @FechaA

  SELECT 'Proceso Concluido'
END
GO
--EXEC spDIOT 1,'DEMO','1/10/2017','31/10/2017'