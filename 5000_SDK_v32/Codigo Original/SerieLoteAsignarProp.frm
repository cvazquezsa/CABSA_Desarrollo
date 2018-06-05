[Forma]
Clave=SerieLoteAsignarProp
Nombre=Reasignar Propiedades - Series/Lotes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=470
PosicionInicialAncho=568
PosicionInicialIzquierda=356
PosicionInicialArriba=263
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLoteAsignarProp
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Lista
PermiteEditar=S
ListaEnCaptura=(Lista)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha Entrada
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechas=S
FiltroFechasCampo=SerieLote.UltimaEntrada
FiltroFechasDefault=Esta Semana
HojaFondoGris=S
FiltroGeneral=SerieLote.Empresa=<T>{Empresa}<T>

[Lista.Columnas]
SerieLote=177
Propiedades=143
Articulo=124
Almacen=93

[Lista.SerieLote.SerieLote]
Carpeta=Lista
Clave=SerieLote.SerieLote
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.SerieLote.Propiedades]
Carpeta=Lista
Clave=SerieLote.Propiedades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Lista.SerieLote.Articulo]
Carpeta=Lista
Clave=SerieLote.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.SerieLote.Almacen]
Carpeta=Lista
Clave=SerieLote.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar Cambios
Guardar Cambios=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SerieLote.SerieLote
SerieLote.SerieLote=SerieLote.Articulo
SerieLote.Articulo=SerieLote.Almacen
SerieLote.Almacen=SerieLote.Propiedades
SerieLote.Propiedades=(Fin)
