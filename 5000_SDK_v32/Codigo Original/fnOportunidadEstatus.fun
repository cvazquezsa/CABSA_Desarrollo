
[Funcion]
Clave=fnOportunidadEstatus
Nombre=Obtiene el Estatus del Encabezado de Oportunidad
Parametros=ID<TAB>
Expresion=SQL(<T>SELECT Estatus FROM Oportunidad WHERE ID = :nID<T>, [ID])
