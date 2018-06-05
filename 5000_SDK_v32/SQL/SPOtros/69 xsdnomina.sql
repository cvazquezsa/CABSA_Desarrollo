SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
SET ANSI_DEFAULTS OFF
SET NOCOUNT ON
GO

--DELETE CFDINominaXMLXSD WHERE Version = '1.1'
--GO
IF NOT EXISTS(SELECT * FROM CFDINominaXMLXSD)
BEGIN
  INSERT INTO CFDINominaXMLXSD(Version, XSD) SELECT '1.1', '<xs:schema xmlns:nomina="http://www.sat.gob.mx/nomina" xmlns:xs="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.sat.gob.mx/nomina" elementFormDefault="qualified" attributeFormDefault="unqualified">
	<xs:element name="Nomina">
		<xs:annotation>
			<xs:documentation>Complemento al Comprobante Fiscal Digital a trav�s de Internet (CFDI) para el manejo de datos de N�mina.</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence>
				<xs:element name="Percepciones" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para expresar las percepciones aplicables</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Percepcion" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Nodo para expresar la informaci�n detallada de una percepci�n</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="TipoPercepcion" use="required">
										<xs:annotation>
											<xs:documentation>Clave agrupadora. Clasifica la percepci�n conforme al cat�logo publicado en el portal del SAT en internet</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:int">
												<xs:minInclusive value="1"/>
												<xs:pattern value="[0-9]{3}"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="Clave" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa la clave de percepci�n de n�mina propia de la contabilidad de cada patr�n, puede conformarse desde 3 hasta 15 caracteres</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="3"/>
												<xs:maxLength value="15"/>
												<xs:whiteSpace value="collapse"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="Concepto" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido para la descripci�n del concepto de percepci�n</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="100"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="ImporteGravado" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa el importe gravado de un concepto de percepci�n</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="ImporteExento" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa el importe exento de un concepto de percepci�n</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="TotalGravado" type="nomina:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total de percepciones gravadas que se relacionan en el comprobante</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="TotalExento" type="nomina:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total de percepciones exentas que se relacionan en el comprobante</xs:documentation>
							</xs:annotation>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Deducciones" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para expresar las deducciones aplicables</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Deduccion" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Nodo para expresar la informaci�n detallada de una deducci�n</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="TipoDeduccion" use="required">
										<xs:annotation>
											<xs:documentation>Clave agrupadora. Clasifica la deducci�n conforme al cat�logo publicado en el portal del SAT en internet</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:int">
												<xs:minInclusive value="1"/>
												<xs:pattern value="[0-9]{3}"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="Clave" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido para la clave de deducci�n de n�mina propia de la contabilidad de cada patr�n, puede conformarse desde 3 hasta 15 caracteres</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="3"/>
												<xs:maxLength value="15"/>
												<xs:whiteSpace value="collapse"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="Concepto" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido para la descripci�n del concepto de deducci�n</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="100"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="ImporteGravado" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa el importe gravado de un concepto de deducci�n</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="ImporteExento" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa el importe exento de un concepto de deducci�n</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="TotalGravado" type="nomina:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total de deducciones gravadas que se relacionan en el comprobante</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="TotalExento" type="nomina:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total de deducciones exentas que se relacionan en el comprobante</xs:documentation>
							</xs:annotation>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Incapacidades" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para expresar las incapacidades aplicables</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Incapacidad" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Nodo opcional para expresar informaci�n de las incapacidades</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="DiasIncapacidad" use="required">
										<xs:annotation>
											<xs:documentation>N�mero de d�as que el trabajador se incapacit� en el periodo</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:decimal">
												<xs:fractionDigits value="6"/>
												<xs:minInclusive value="1"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="TipoIncapacidad" type="xs:int" use="required">
										<xs:annotation>
											<xs:documentation>Raz�n de la incapacidad: Cat�logo publicado en el portal del SAT en internet</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="Descuento" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Monto del descuento por la incapacidad</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="HorasExtras" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para expresar las horas extras aplicables</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="HorasExtra" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Nodo opcional para expresar informaci�n de las horas extras</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="Dias" type="xs:int" use="required">
										<xs:annotation>
											<xs:documentation>N�mero de d�as en que el trabajador realiz� horas extra en el periodo</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="TipoHoras" use="required">
										<xs:annotation>
											<xs:documentation>Tipo de pago de las horas extra: dobles o triples</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:whiteSpace value="collapse"/>
												<xs:enumeration value="Dobles"/>
												<xs:enumeration value="Triples"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="HorasExtra" type="xs:int" use="required">
										<xs:annotation>
											<xs:documentation>N�mero de horas extra trabajadas en el periodo</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="ImportePagado" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Importe pagado por las horas extra</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
			<xs:attribute name="Version" type="xs:string" use="required" fixed="1.1">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresi�n de la versi�n del complemento</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="RegistroPatronal" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional para expresar el registro patronal a 20 posiciones m�ximo</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="20"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="NumEmpleado" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para expresar el n�mero de empleado de 1 a 15 posiciones</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="15"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="CURP" type="nomina:t_CURP" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresi�n de la CURP del trabajador</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="TipoRegimen" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresi�n de la clave del r�gimen por el cual se tiene contratado al trabajador, conforme al cat�logo publicado en el portal del SAT en internet</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:int">
						<xs:minInclusive value="1"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="NumSeguridadSocial" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional para la expresi�n del n�mero de seguridad social aplicable al trabajador</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="15"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="FechaPago" type="xs:date" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresi�n de la fecha efectiva de erogaci�n del gasto. Se expresa en la forma aaaa-mm-dd, de acuerdo con la especificaci�n ISO 8601.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="FechaInicialPago" type="xs:date" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresi�n de la fecha inicial del pago. Se expresa en la forma aaaa-mm-dd, de acuerdo con la especificaci�n ISO 8601.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="FechaFinalPago" type="xs:date" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresi�n de la fecha final del pago. Se expresa en la forma aaaa-mm-dd, de acuerdo con la especificaci�n ISO 8601.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="NumDiasPagados" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresi�n del n�mero de d�as pagados</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:decimal">
						<xs:fractionDigits value="6"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="Departamento">
				<xs:annotation>
					<xs:documentation>Atributo opcional para la expresi�n del departamento o �rea a la que pertenece el trabajador</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="100"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="CLABE" type="nomina:t_Clabe">
				<xs:annotation>
					<xs:documentation>Atributo opcional para la expresi�n de la CLABE </xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="Banco">
				<xs:annotation>
					<xs:documentation>Atributo opcional para la expresi�n del Banco conforme al cat�logo, donde se realiza un dep�sito de n�mina</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:int">
						<xs:minInclusive value="1"/>
						<xs:pattern value="[0-9]{3}"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="FechaInicioRelLaboral" type="xs:date" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional para expresar la fecha de inicio de la relaci�n laboral entre el empleador y el empleado</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="Antiguedad" type="xs:int" use="optional">
				<xs:annotation>
					<xs:documentation>N�mero de semanas que el empleado ha mantenido relaci�n laboral con el empleador</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="Puesto" type="xs:string" use="optional">
				<xs:annotation>
					<xs:documentation>Puesto asignado al empleado o actividad que realiza</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="TipoContrato" type="xs:string" use="optional">
				<xs:annotation>
					<xs:documentation>Tipo de contrato que tiene el trabajador: Base, Eventual, Confianza, Sindicalizado, a prueba, etc.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="TipoJornada" type="xs:string" use="optional">
				<xs:annotation>
					<xs:documentation>Tipo de jornada que cubre el trabajador: Diurna, nocturna, mixta, por hora, reducida, continuada, partida, por turnos, etc.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="PeriodicidadPago" use="required">
				<xs:annotation>
					<xs:documentation>Forma en que se establece el pago del salario: diario, semanal, quincenal, catorcenal mensual, bimestral, unidad de obra, comisi�n, precio alzado, etc.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="100"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="SalarioBaseCotApor" type="nomina:t_Importe" use="optional">
				<xs:annotation>
					<xs:documentation>Retribuci�n otorgada al trabajador, que se integra por los pagos hechos en efectivo por cuota diaria, gratificaciones, percepciones, alimentaci�n, habitaci�n, primas, comisiones, prestaciones en especie y cualquiera otra cantidad o prestaci�n que se entregue al trabajador por su trabajo</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="RiesgoPuesto" use="optional">
				<xs:annotation>
					<xs:documentation>Clave conforme a la Clase en que deben inscribirse los patrones, de acuerdo a las actividades que desempe�an sus trabajadores, seg�n lo previsto en el art�culo 196 del Reglamento en Materia de Afiliaci�n Clasificaci�n de Empresas, Recaudaci�n y Fiscalizaci�n. Cat�logo publicado en el portal del SAT en internet</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:int">
						<xs:minInclusive value="1"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="SalarioDiarioIntegrado" type="nomina:t_Importe" use="optional">
				<xs:annotation>
					<xs:documentation>Salario diario integrado</xs:documentation>
				</xs:annotation>
			</xs:attribute>
		</xs:complexType>
	</xs:element>
	<xs:simpleType name="t_CURP">
		<xs:annotation>
			<xs:documentation>Tipo definido para la expresi�n de una CURP</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:whiteSpace value="collapse"/>
			<xs:length value="18"/>
			<xs:pattern value="[A-Z][A,E,I,O,U,X][A-Z]{2}[0-9]{2}[0-1][0-9][0-3][0-9][M,H][A-Z]{2}[B,C,D,F,G,H,J,K,L,M,N,�,P,Q,R,S,T,V,W,X,Y,Z]{3}[0-9,A-Z][0-9]"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="t_Importe">
		<xs:annotation>
			<xs:documentation>Tipo definido para expresar importes num�ricos con fracci�n hasta seis decimales</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:decimal">
			<xs:fractionDigits value="6"/>
			<xs:whiteSpace value="collapse"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="t_Clabe">
		<xs:annotation>
			<xs:documentation>Tipo definido para expresar la CLABE interbancaria</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:integer">
			<xs:pattern value="[0-9]{18}"/>
		</xs:restriction>
	</xs:simpleType>
</xs:schema>
'  
END
GO
