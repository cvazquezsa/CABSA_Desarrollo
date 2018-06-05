
[Funcion]
Clave=POSMatrizOpciones
























Parametros=(Lista)

Expresion=RegistrarLista(EditorOpcionesArticulo([Articulo], Nulo, verdadero),Falso )<BR>EjecutarSQL(<T>spPOSArtMatrizOpciones :tID,:tArticulo, :nEstacion,:tCodigo<T>,[ID],[Articulo],EstacionTrabajo,[Codigo])
[Funcion.Parametros]
(Inicio)=ID
ID=Articulo
Articulo=Codigo
Codigo=Almacen
Almacen=(Fin)
