
[Funcion]
Clave=fnPuedeAvanzarEstatus

Nombre=Verifica si el usuario tiene permitido afectar el movimiento debido a la situacion actual del movimiento











Parametros=(Lista)

Expresion=Si fnMovSituacionTipoFlujo([Empresa], [Modulo], [Mov], [Estatus]) = <T>Condicional<T><BR>Entonces<BR>  SQL(<T>SELECT dbo.fnPuedeAvanzarEstatus(:tEmpresa, :tModulo, :tMov, :tEstatus, :tSituacion, :tUsuario)<T>, [Empresa], [Modulo], [Mov], [Estatus], [Situacion], [Usuario])<BR>Sino<BR>  PuedeAvanzarEstatus([Modulo], [Mov], [Estatus], [Situacion])<BR>Fin
[Funcion.Parametros]
(Inicio)=Empresa
Empresa=Modulo
Modulo=Mov
Mov=Estatus
Estatus=Situacion
Situacion=Usuario
Usuario=(Fin)
