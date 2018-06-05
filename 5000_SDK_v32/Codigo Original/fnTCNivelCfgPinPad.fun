
[Funcion]
Clave=fnTCNivelCfgPinPad
Nombre=Obtiene el Nivel de Configuracion de la PinPad
Parametros=Empresa
Expresion=SQL(<T>SELECT dbo.fnTCNivelCfgPinPad(:tEmpresa)<T>, [Empresa])
