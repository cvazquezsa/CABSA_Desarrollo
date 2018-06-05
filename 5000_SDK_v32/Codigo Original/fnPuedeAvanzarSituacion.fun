
[Funcion]
Clave=fnPuedeAvanzarSituacion
Nombre=Verifica si el usuario actual tiene permitido modificar la situacion del movimiento














Parametros=(Lista)

Expresion=Si fnMovSituacionTipoFlujo([Empresa], [Modulo], [Mov], [Estatus]) = <T>Condicional<T><BR>Entonces<BR>  SQL(<T>SELECT dbo.fnPuedeAvanzarSituacion(:tEmpresa, :tModulo, :tMov, :tEstatus, :tSituacion, :tUsuario)<T>, [Empresa], [Modulo], [Mov], [Estatus], [Situacion], [Usuario])<BR>Sino<BR>  PuedeAvanzarSituacion([Modulo], [Mov], [Estatus], [Situacion])<BR>Fin
[Funcion.Parametros]
(Inicio)=Empresa
Empresa=Modulo
Modulo=Mov
Mov=Estatus
Estatus=Situacion
Situacion=Usuario
Usuario=(Fin)
