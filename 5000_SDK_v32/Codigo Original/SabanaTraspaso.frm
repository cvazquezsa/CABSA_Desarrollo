
[Forma]
Clave=SabanaTraspaso
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Traspasos
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Detalle
CarpetaPrincipal=Detalle
ListaAcciones=(Lista)
PosicionInicialIzquierda=276
PosicionInicialArriba=195
PosicionInicialAlturaCliente=298
PosicionInicialAncho=813
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Totalizadores=S
PosicionSec1=231
VentanaSinIconosMarco=S
VentanaExclusiva=S
VentanaExclusivaOpcion=2
[Detalle]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Traspasos
Clave=Detalle
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SabanaTraspaso
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S

OtroOrden=S
ListaOrden=SabanaTraspaso.AlmacenDestino<TAB>(Acendente)
FiltroGeneral=SabanaTraspaso.Estacion = {EstacionTrabajoFija} AND<BR>SabanaTraspaso.Articulo = <T>{Info.Articulo}<T> AND<BR>SabanaTraspaso.Sucursal = {Info.Sucursal}
[Detalle.SabanaTraspaso.Almacen]
Carpeta=Detalle
Clave=SabanaTraspaso.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata

[Detalle.SabanaTraspaso.PrimeraEntrada]
Carpeta=Detalle
Clave=SabanaTraspaso.PrimeraEntrada
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaTraspaso.UltimaEntrada]
Carpeta=Detalle
Clave=SabanaTraspaso.UltimaEntrada
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaTraspaso.Venta]
Carpeta=Detalle
Clave=SabanaTraspaso.Venta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaTraspaso.Existencia]
Carpeta=Detalle
Clave=SabanaTraspaso.Existencia
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaTraspaso.Transito]
Carpeta=Detalle
Clave=SabanaTraspaso.Transito
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaTraspaso.Ordenado]
Carpeta=Detalle
Clave=SabanaTraspaso.Ordenado
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Detalle.SabanaTraspaso.CantidadTraspasar]
Carpeta=Detalle
Clave=SabanaTraspaso.CantidadTraspasar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SabanaTraspaso.AlmacenDestino]
Carpeta=Detalle
Clave=SabanaTraspaso.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



ConCondicion=S
EjecucionConError=S
EjecucionCondicion=(Info.Cantidad - SUMA(SabanaTraspaso:SabanaTraspaso.CantidadTraspasar)) >= 0
EjecucionMensaje=<T>La cantidad a traspasar es mayor al disponible<T>
[Detalle.Columnas]
Almacen=64
PrimeraEntrada=94
UltimaEntrada=94
Venta=64
Existencia=64
Transito=64
Ordenado=64
Disponible=64
CantidadTraspasar=95
AlmacenDestino=80

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Disponible
Totalizadores2=Info.Cantidad - SUMA(SabanaTraspaso:SabanaTraspaso.CantidadTraspasar)
Totalizadores3=
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Disponible
CarpetaVisible=S

TotAlCambiar=S
TotExpresionesEnSumas=S
TotCarpetaRenglones=Detalle
[(Carpeta Totalizadores).Disponible]
Carpeta=(Carpeta Totalizadores)
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata


[Lista.Columnas]
Almacen=90
Nombre=229
Grupo=100
Sucursal=46


[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S





Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar
Cancelar=Cerrar
Cerrar=(Fin)












[Detalle.ListaEnCaptura]
(Inicio)=SabanaTraspaso.Almacen
SabanaTraspaso.Almacen=SabanaTraspaso.PrimeraEntrada
SabanaTraspaso.PrimeraEntrada=SabanaTraspaso.UltimaEntrada
SabanaTraspaso.UltimaEntrada=SabanaTraspaso.Venta
SabanaTraspaso.Venta=SabanaTraspaso.Existencia
SabanaTraspaso.Existencia=SabanaTraspaso.Transito
SabanaTraspaso.Transito=SabanaTraspaso.Ordenado
SabanaTraspaso.Ordenado=SabanaTraspaso.CantidadTraspasar
SabanaTraspaso.CantidadTraspasar=SabanaTraspaso.AlmacenDestino
SabanaTraspaso.AlmacenDestino=(Fin)









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Cancelar
Cancelar=(Fin)
