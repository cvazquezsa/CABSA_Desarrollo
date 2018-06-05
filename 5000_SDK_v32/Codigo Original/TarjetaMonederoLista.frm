
[Forma]
Clave=TarjetaMonederoLista
Icono=67
Modulos=(Todos)
Nombre=Monedero Electrónico
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=457
PosicionInicialArriba=158
PosicionInicialAlturaCliente=439
PosicionInicialAncho=459
ListaAcciones=(Lista)
[Lista]
Estilo=Iconos
Clave=Lista
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TarjetaMonedero
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Monedero Electrónico<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Negro
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
ListaOrden=TarjetaMonedero.Serie<TAB>(Acendente)
FiltroEstatus=S
FiltroFechas=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasCampo=TarjetaMonedero.FechaAlta
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaInicializar=S
BusquedaEnLinea=S

PestanaOtroNombre=S
PestanaNombre=Monedero Electrónico
IconosSeleccionPorLlave=S
FiltroFechasDefault=(Todo)
BusquedaRespetarControles=S
IconosNombre=TarjetaMonedero:TarjetaMonedero.Serie
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
[Lista.Columnas]
0=430

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=ACTIVA
ACTIVA=(Fin)









[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cerrar
Cerrar=(Fin)
