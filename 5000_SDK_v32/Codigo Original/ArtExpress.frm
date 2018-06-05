[Forma]
Clave=ArtExpress
Nombre=Agregar Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=280
PosicionInicialArriba=243
PosicionInicialAltura=274
PosicionInicialAncho=463
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(ArtX.Descripcion, Nulo)<BR>Asigna(ArtX.Tipo, <T>Normal<T>)<BR>Asigna(ArtX.Categoria, General.ArtExpressCategoria)<BR>Asigna(ArtX.Clave, General.ArtExpressDef)<BR>Asigna(ArtX.PrecioLista, Nulo)<BR>Asigna(ArtX.Moneda, Config.ContMoneda)<BR>Asigna(ArtX.Impuesto1, General.DefImpuesto)<BR>Asigna(ArtX.Impuesto2, Nulo)<BR>Asigna(ArtX.Impuesto3, Nulo)<BR>Asigna(ArtX.Comentarios, Nulo)<BR>Asigna(ArtX.Unidad, Nulo)
PosicionInicialAlturaCliente=247

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.ArtX.Descripcion]
Carpeta=Ficha
Clave=ArtX.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ArtX.Tipo]
Carpeta=Ficha
Clave=ArtX.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ArtX.Unidad]
Carpeta=Ficha
Clave=ArtX.Unidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ArtX.Clave]
Carpeta=Ficha
Clave=ArtX.Clave
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ArtX.Categoria]
Carpeta=Ficha
Clave=ArtX.Categoria
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.ArtX.Impuesto1]
Carpeta=Ficha
Clave=ArtX.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ArtX.Impuesto2]
Carpeta=Ficha
Clave=ArtX.Impuesto2
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.ArtX.Moneda]
Carpeta=Ficha
Clave=ArtX.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ArtX.PrecioLista]
Carpeta=Ficha
Clave=ArtX.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ArtX.Comentarios]
Carpeta=Ficha
Clave=ArtX.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S
ListaAccionesMultiples=Variables Asignar<BR>SQL<BR>Cerrar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtX.Descripcion)
Visible=S

[Acciones.Aceptar.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(Info.Articulo, Nulo)<BR><BR>Asigna(Info.Articulo, <BR>SQL(<T>spAgregarArticuloExpress :tClave, :tDes, :tTip, :tUni, :tMon, :$Lista, :$Imp1, :$Imp2, :$Imp3, :tCat, :tComentarios, :tPre, :tLike, :nDig, :tEmp<T>, <BR>ArtX.Clave, ArtX.Descripcion, ArtX.Tipo, ArtX.Unidad, ArtX.Moneda,  ArtX.PrecioLista, ArtX.Impuesto1, ArtX.Impuesto2, ArtX.Impuesto3, ArtX.Categoria, ArtX.Comentarios, <BR>General.ArtExpressPrefijo, General.ArtExpressPrefijo+<T>[0-9]%<T>, General.ArtExpressDigitos, Empresa))<BR><BR>Si<BR>  ConDatos(Info.Articulo)<BR>Entonces<BR>  EjecutarSQLLocal(<T>spAgregarArticuloExpress :tClave, :tDes, :tTip, :tUni, :tMon, :$Lista, :$Imp1, :$Imp2, :$Imp3, :tCat, :tComentarios, :tPre, :tLike, :nDig, :tEmp<T>, <BR>  Info.Articulo, ArtX.Descripcion, ArtX.Tipo, ArtX.Unidad, ArtX.Moneda,  ArtX.PrecioLista, ArtX.Impuesto1, ArtX.Impuesto2, ArtX.Impuesto3, ArtX.Categoria, ArtX.Comentarios,<BR>  General.ArtExpressPrefijo, General.ArtExpressPrefijo+<T>[0-9]%<T>, General.ArtExpressDigitos, Empresa)<BR>Fin
EjecucionCondicion=ConDatos(ArtX.Descripcion)

[Ficha.ArtX.Impuesto3]
Carpeta=Ficha
Clave=ArtX.Impuesto3
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=ArtX.Descripcion
ArtX.Descripcion=ArtX.PrecioLista
ArtX.PrecioLista=ArtX.Unidad
ArtX.Unidad=ArtX.Clave
ArtX.Clave=ArtX.Moneda
ArtX.Moneda=ArtX.Tipo
ArtX.Tipo=ArtX.Categoria
ArtX.Categoria=ArtX.Impuesto1
ArtX.Impuesto1=ArtX.Impuesto2
ArtX.Impuesto2=ArtX.Impuesto3
ArtX.Impuesto3=ArtX.Comentarios
ArtX.Comentarios=(Fin)
