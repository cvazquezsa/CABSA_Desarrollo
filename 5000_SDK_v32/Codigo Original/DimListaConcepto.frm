
[Forma]
Clave=DimListaConcepto
Icono=0
CarpetaPrincipal=Lista
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Lista Concepto
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
PosicionInicialIzquierda=342
PosicionInicialArriba=152
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
ExpresionesAlMostrar=EjecutarSQL(<T>exec spVerConceptoDim :tEmpresa, :nEstacion<T>,Empresa,EstacionTrabajo )
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DimListaConcepto
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

BusquedaRapidaControles=S
FiltroGeneral=DimListaConcepto.Empresa=<T>{Empresa}<T>
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
[Lista.DimListaConcepto.NominaConcepto]
Carpeta=Lista
Clave=DimListaConcepto.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.DimListaConcepto.Concepto]
Carpeta=Lista
Clave=DimListaConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
NominaConcepto=304
Concepto=304


[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S



[Lista.ListaEnCaptura]
(Inicio)=DimListaConcepto.NominaConcepto
DimListaConcepto.NominaConcepto=DimListaConcepto.Concepto
DimListaConcepto.Concepto=(Fin)
