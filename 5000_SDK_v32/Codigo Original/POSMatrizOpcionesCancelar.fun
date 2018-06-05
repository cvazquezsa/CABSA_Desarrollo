
[Funcion]
Clave=POSMatrizOpcionesCancelar









Nombre=POSMatrizOpcionesCancelar









Parametros=(Lista)

Expresion=RegistrarLista(EditorOpcionesArticulo([Articulo], Nulo, verdadero),Falso )<BR>EjecutarSQL(<T>spPOSArtMatrizOpcionesCancelar :tID,:tArticulo, :nEstacion, :tCodigo<T>,[ID],[Articulo],EstacionTrabajo,[Codigo])
[Funcion.Parametros]
(Inicio)=ID
ID=Articulo
Articulo=Codigo
Codigo=Almacen
Almacen=(Fin)
