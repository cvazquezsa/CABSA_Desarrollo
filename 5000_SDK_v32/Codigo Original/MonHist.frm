[Forma]
Clave=MonHist
Nombre=<T>Historial<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
PosicionInicialIzquierda=472
PosicionInicialArriba=309
PosicionInicialAltura=298
PosicionInicialAncho=335
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
CarpetaPrincipal=Lista
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
AccionesDivision=S
BarraHerramientas=S
Comentarios=Info.Moneda
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=372
FiltrarFechasSinHora=S

[MonHist.Columnas]
Moneda_1=101
Nombre=212
Fecha=98
TipoCambio=115
Moneda=100
0=120
1=115

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=&Cerrar
EnBarraAcciones=Si
TipoAccion=Ventana
ClaveAccion=Cerrar
Visible=Si
Activo=Si
NombreEnBoton=Si
EnBarraHerramientas=Si

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Cambios
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MonHist
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Fecha y Hora
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MonHist.TipoCambio
ListaOrden=MonHist.Fecha<TAB>(Decendente)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(Sin clasificar)
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=MonHist.Fecha
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosNombre=MonHist:MonHist.Fecha
FiltroGeneral=MonHist.Moneda = <T>{Info.Moneda}<T>

[Lista.MonHist.TipoCambio]
Carpeta=Lista
Clave=MonHist.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=160
1=81
