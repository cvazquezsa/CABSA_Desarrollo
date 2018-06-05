
[Funcion]
Clave=AUTOEXEC
Expresion=Asigna(Info.Numero,SQL(<T>SELECT dbo.fnAccesoID(@@SPID)<T>))<BR>EjecutarSQL(<T>spRepParamInicializar :Estacion,:tEmpresa,:nSucursal,:tUsuario,:fFecha,:tAccesoID<T>,EstacionTrabajo,Empresa,Sucursal,Usuario,ahora,Info.Numero)
