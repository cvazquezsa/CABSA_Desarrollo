
[Funcion]
Clave=fnContParalela
Nombre=Función que verifica si está encendida la funcionalidad de Contabilidad Paralela
Expresion=SQL(<T>SELECT ISNULL(ContabilidadParalela, 0) FROM Version<T>)
