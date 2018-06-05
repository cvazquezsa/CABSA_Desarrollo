
[Funcion]
Clave=fnTCProcesadorTransAMEXCfg
Nombre=Obtiene la Configuración para la Interface con Tarjetas Bancarias del Procesador de Transacciones AMEX




Parametros=(Lista)

Expresion=SQL(<T>SELECT dbo.fnTCProcesadorTransAMEXCfg(:tEmpresa, :nSucursal)<T>, [Empresa], [Sucursal])
[Funcion.Parametros]
(Inicio)=Empresa
Empresa=Sucursal
Sucursal=(Fin)
