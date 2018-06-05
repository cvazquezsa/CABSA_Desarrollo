
[Funcion]
Clave=fnVisorWeb
Nombre=Inicializa con un formato especifico el visor web y lo despliega


Parametros=Formato
Expresion=Asigna(Temp.Reg,SQL(<T>EXEC spVisorWebInicializar :nEstacion, :tFormato<T>,EstacionTrabajo,[Formato]))<BR>Asigna(Info.Clave,Temp.Reg[1])<BR>Asigna(Info.Titulo,Temp.Reg[2])<BR>Asigna(Temp.Logico,Temp.Reg[3])<BR><BR>Si No (Vacio(Info.Clave)) Entonces<BR>  VisorWeb(Info.Clave,Info.Titulo,Temp.Logico)<BR>Fin
[EstacionTrabajo]=[Formato]

[Funcion.Parametros]
(Inicio)=EstacionTrabajo
EstacionTrabajo=Formato
Formato=(Fin)
