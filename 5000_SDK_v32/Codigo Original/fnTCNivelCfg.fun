
[Funcion]
Clave=fnTCNivelCfg
Nombre=Obtiene el Nivel de Configuraci�n para la Interface con Tarjetas Bancarias
Parametros=Empresa
Expresion=SQL(<T>SELECT dbo.fnTCNivelCfg(:tEmpresa)<T>, [Empresa])
