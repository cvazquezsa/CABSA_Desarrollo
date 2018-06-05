[Forma]
Clave=SATMunicipioLista
Nombre=Catálogo de Municipios
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
Vista=SATMunicipio
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
ListaOrden=(Lista)






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
Fecha=122

ClaveMunicipio=113
ClaveEstado=114
Descripcion=190


[Lista.SATMunicipio.ClaveMunicipio]
Carpeta=Lista
Clave=SATMunicipio.ClaveMunicipio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATMunicipio.ClaveEstado]
Carpeta=Lista
Clave=SATMunicipio.ClaveEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.SATMunicipio.Descripcion]
Carpeta=Lista
Clave=SATMunicipio.Descripcion
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
(Inicio)=SATMunicipio.ClaveMunicipio
SATMunicipio.ClaveMunicipio=SATMunicipio.ClaveEstado
SATMunicipio.ClaveEstado=SATMunicipio.Descripcion
SATMunicipio.Descripcion=(Fin)

[Lista.ListaOrden]
(Inicio)=SATMunicipio.ClaveEstado	(Acendente)
SATMunicipio.ClaveEstado	(Acendente)=SATMunicipio.ClaveMunicipio	(Acendente)
SATMunicipio.ClaveMunicipio	(Acendente)=(Fin)
