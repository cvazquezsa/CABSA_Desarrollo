
[Funcion]
Clave=fnFecha
Nombre=Fecha de Hoy
Parametros=Fecha
Expresion=Si<BR>  [Fecha]<>nulo<BR>Entonces<BR>  Asigna(Info.Fecha, [Fecha])<BR>Sino<BR>  Asigna(Info.Fecha,SQL(<T>SELECT GETDATE()<T>))<BR>Fin<BR>Si<BR>  Forma(<T>EspecificarFecha<T>)<BR>Entonces<BR>  Info.Fecha<BR>Fin
