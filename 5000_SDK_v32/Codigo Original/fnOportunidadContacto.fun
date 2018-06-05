
[Funcion]
Clave=fnOportunidadContacto
Nombre=Obtiene el Contacto del Encabezado de Oportunidad
Parametros=ID
Expresion=SQL(<T>SELECT Contacto FROM Oportunidad WHERE ID = :nID<T>, [ID])
