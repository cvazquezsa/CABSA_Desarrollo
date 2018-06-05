
[Funcion]
Clave=fnRepParamActualizarTitulo
Nombre=Actualiza el campo InfoTitulo en la tabla RepParam


Parametros=Titulo
Expresion=EJECUTARSQL(<T>EXEC spRepParamActualizarTitulo :nEstacionTrabajo, :tTitulo<T>,EstacionTrabajo,[Titulo])
[Estacion]=[Titulo]





[Funcion.Parametros]
(Inicio)=EstacionTrabajo
EstacionTrabajo=Titulo
Titulo=(Fin)
