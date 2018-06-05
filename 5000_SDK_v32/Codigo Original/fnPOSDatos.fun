
[Funcion]
Clave=fnPOSDatos
Nombre=Datos






Parametros=(Lista)

Expresion=<T><Datos><Cantidad><T>+[Cantidad]+<T></Cantidad><SubCuenta><T>+[SubCuenta]+<T></SubCuenta><Precio><T>+[Precio]+<T></Precio></Datos><T>
[Funcion.Parametros]
(Inicio)=SubCuenta
SubCuenta=Cantidad
Cantidad=Precio
Precio=(Fin)
