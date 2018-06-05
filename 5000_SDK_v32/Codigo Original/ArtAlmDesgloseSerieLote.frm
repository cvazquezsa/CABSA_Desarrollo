[Forma]
Clave=ArtAlmDesgloseSerieLote
Icono=6
Modulos=(Todos)
Nombre=Existencia
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=772
PosicionInicialArriba=427
PosicionInicialAltura=336
PosicionInicialAncho=376
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Lista(Info.Articulo,e(<T>Almacén<T>)+<T>: <T>+Info.Almacen)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=309

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLote
Fuente={Fixedsys, 9, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Series/Lotes
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ConFuenteEspecial=S

FiltroGeneral=SerieLote.Empresa=<T>{Empresa}<T> AND<BR>SerieLote.Articulo=<T>{Info.Articulo}<T> AND<BR>SerieLote.Almacen=<T>{Info.Almacen}<T> AND<BR>SerieLote.Existencia IS NOT NULL
[Lista.SerieLote.Propiedades]
Carpeta=Lista
Clave=SerieLote.Propiedades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
0=183
1=133
SerieLote=163
Propiedades=112
Existencia=62
Tarima=156
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(SerieLote:SerieLote.SerieLote)
AntesExpresiones=Asigna(Info.SubCuenta, SerieLote:SerieLote.SubCuenta)<BR>Asigna(Info.SerieLote, SerieLote:SerieLote.SerieLote)

[Lista.SerieLote.SerieLote]
Carpeta=Lista
Clave=SerieLote.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SerieLote.Existencia]
Carpeta=Lista
Clave=SerieLote.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.ListaEnCaptura]
(Inicio)=SerieLote.SerieLote
SerieLote.SerieLote=SerieLote.Existencia
SerieLote.Existencia=SerieLote.Propiedades
SerieLote.Propiedades=SerieLote.Tarima
SerieLote.Tarima=(Fin)

[Lista.SerieLote.Tarima]
Carpeta=Lista
Clave=SerieLote.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=SerieLoteInfo
SerieLoteInfo=(Fin)
