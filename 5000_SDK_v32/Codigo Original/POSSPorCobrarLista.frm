
[Forma]
Clave=POSSPorCobrarLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Lista de Movimientos Por Cobrar
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Seleccionar
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=459
PosicionInicialArriba=229
PosicionInicialAlturaCliente=273
PosicionInicialAncho=448
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Activo=S
Antes=S
Visible=S

AntesExpresiones=Asigna(Info.Codigo, POSS:POSS.ID)
[Hoja]
Estilo=Hoja
Clave=Hoja
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSS
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

BusquedaRapida=S
BusquedaInicializar=S
BusquedaEnLinea=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=POSS.Estatus = <T>PorCobrar<T>
[Hoja.POSS.Mov]
Carpeta=Hoja
Clave=POSS.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Hoja.POSS.MovID]
Carpeta=Hoja
Clave=POSS.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Hoja.POSS.FechaEmision]
Carpeta=Hoja
Clave=POSS.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.POSS.Importe]
Carpeta=Hoja
Clave=POSS.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.Columnas]
Mov=124
MovID=124
FechaEmision=94
Importe=64







[Hoja.ListaEnCaptura]
(Inicio)=POSS.Mov
POSS.Mov=POSS.MovID
POSS.MovID=POSS.FechaEmision
POSS.FechaEmision=POSS.Importe
POSS.Importe=POSS.Cliente
POSS.Cliente=(Fin)

[Hoja.POSS.Cliente]
Carpeta=Hoja
Clave=POSS.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
