[Forma]
Clave=SATLocalidadLista
Nombre=Catálogo de Localidades
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=469
PosicionInicialArriba=200
PosicionInicialAltura=346
PosicionInicialAncho=501
PosicionInicialAlturaCliente=421

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATLocalidad
Fuente={MS Sans Serif, 8, Negro, []}
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
ListaOrden=SATLocalidad.ClaveLocalidad<TAB>(Acendente)






BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=95

ClaveLocalidad=87
ClaveEstado=73
Descripcion=220


[Lista.SATLocalidad.ClaveLocalidad]
Carpeta=Lista
Clave=SATLocalidad.ClaveLocalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATLocalidad.ClaveEstado]
Carpeta=Lista
Clave=SATLocalidad.ClaveEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.SATLocalidad.Descripcion]
Carpeta=Lista
Clave=SATLocalidad.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

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

[Lista.ListaEnCaptura]
(Inicio)=SATLocalidad.ClaveLocalidad
SATLocalidad.ClaveLocalidad=SATLocalidad.ClaveEstado
SATLocalidad.ClaveEstado=SATLocalidad.Descripcion
SATLocalidad.Descripcion=(Fin)
