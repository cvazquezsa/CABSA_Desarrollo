
[Funcion]
Clave=fnEmidaNivelCfgSiteID
Nombre=Obtiene el Nivel de Configuracion de Site ID para Emida
Parametros=Empresa
Expresion=SQL(<T>SELECT dbo.fnEmidaNivelCfgSiteID(:tEmpresa)<T>, [Empresa])
