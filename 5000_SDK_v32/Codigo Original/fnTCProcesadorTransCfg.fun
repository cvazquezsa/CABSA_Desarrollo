
[Funcion]
Clave=fnTCProcesadorTransCfg
Nombre=Obtiene la Configuraci�n para la Interface con Tarjetas Bancarias del Procesador de Transacciones


Parametros=(Lista)

Expresion=SQL(<T>SELECT dbo.fnTCProcesadorTransCfg(:tEmpresa, :nSucursal)<T>, [Empresa], [Sucursal])
[Funcion.Parametros]
(Inicio)=Empresa
Empresa=Sucursal
Sucursal=(Fin)
