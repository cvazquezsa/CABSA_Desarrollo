
[Funcion]
Clave=fnCPEsCentralizadora
Nombre=Función que analiza si la base de datos en Centralizadora
Expresion=Si SQL(<T>SELECT ISNULL(ContabilidadParalela, 0) FROM Version<T>)<BR>Entonces<BR>  Si SQL(<T>SELECT ISNULL(CPCentralizadora, 0) FROM Version<T>)<BR>  Entonces<BR>    Verdadero<BR>  Sino<BR>    Falso<BR>  Fin<BR>Sino<BR>  Falso<BR>Fin
