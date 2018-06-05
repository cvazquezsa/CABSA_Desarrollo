
[Funcion]
Clave=fnMovSituacionTipoFlujo
Nombre=Especifica si el Movimiento contiene flujo Normal o Condicional (Binario) de Situación














Parametros=(Lista)

Expresion=SQL(<T>SELECT dbo.fnMovSituacionTipoFlujo(:tEmpresa, :tModulo, :tMov, :tEstatus)<T>, [Empresa], [Modulo], [Mov], [Estatus])
[Funcion.Parametros]
(Inicio)=Empresa
Empresa=Modulo
Modulo=Mov
Mov=Estatus
Estatus=(Fin)
