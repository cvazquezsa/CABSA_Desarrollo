[Forma]
Clave=OpcionPrecio
Nombre=Precios Adicionales - Opciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=275
PosicionInicialArriba=189
PosicionInicialAltura=288
PosicionInicialAncho=819
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.Articulo, Nulo)

PosicionInicialAlturaCliente=261
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OpcionPrecio
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)

[Lista.OpcionPrecio.Opcion]
Carpeta=Lista
Clave=OpcionPrecio.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OpcionPrecio.Articulo]
Carpeta=Lista
Clave=OpcionPrecio.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.OpcionPrecio.Precio]
Carpeta=Lista
Clave=OpcionPrecio.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OpcionPrecio.Moneda]
Carpeta=Lista
Clave=OpcionPrecio.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Opcion=73
Articulo=94
Descripcion1=213
Precio=74
Moneda=59
OpcionDesc=225
Porcentaje=44

[Acciones.OpcionInfo]
Nombre=OpcionInfo
Boton=8
NombreEnBoton=S
NombreDesplegar=&Opciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OpcionInfo
Activo=S
Visible=S

[Lista.OpcionDesc]
Carpeta=Lista
Clave=OpcionDesc
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Gris

[Lista.OpcionPrecio.Porcentaje]
Carpeta=Lista
Clave=OpcionPrecio.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=OpcionPrecio.Opcion
OpcionPrecio.Opcion=OpcionDesc
OpcionDesc=OpcionPrecio.Articulo
OpcionPrecio.Articulo=Art.Descripcion1
Art.Descripcion1=OpcionPrecio.Precio
OpcionPrecio.Precio=OpcionPrecio.Moneda
OpcionPrecio.Moneda=OpcionPrecio.Porcentaje
OpcionPrecio.Porcentaje=(Fin)

[Lista.ListaOrden]
(Inicio)=OpcionPrecio.Opcion<TAB>(Acendente)
OpcionPrecio.Opcion<TAB>(Acendente)=OpcionPrecio.Articulo<TAB>(Acendente)
OpcionPrecio.Articulo<TAB>(Acendente)=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=OpcionInfo
OpcionInfo=(Fin)
