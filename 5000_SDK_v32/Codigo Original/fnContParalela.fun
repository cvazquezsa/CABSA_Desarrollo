
[Funcion]
Clave=fnContParalela
Nombre=Funci�n que verifica si est� encendida la funcionalidad de Contabilidad Paralela
Expresion=SQL(<T>SELECT ISNULL(ContabilidadParalela, 0) FROM Version<T>)
