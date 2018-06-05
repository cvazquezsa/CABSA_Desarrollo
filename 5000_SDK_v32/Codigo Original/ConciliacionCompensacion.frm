[Forma]
Clave=ConciliacionCompensacion
Icono=0
Modulos=(Todos)
Nombre=Compensación Manual
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=566
PosicionInicialArriba=343
PosicionInicialAlturaCliente=480
PosicionInicialAncho=787
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Totalizadores=S
PosicionSec1=412

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConciliacionCompensacion
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
FiltroGeneral=ConciliacionCompensacion.ID={Info.ID}
CondicionEdicion=Info.PuedeEditar

[Lista.ConciliacionCompensacion.ConciliacionD]
Carpeta=Lista
Clave=ConciliacionCompensacion.ConciliacionD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConciliacionCompensacion.Manual]
Carpeta=Lista
Clave=ConciliacionCompensacion.Manual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
ConCondicion=S
EjecucionCondicion=Suma(ConciliacionCompensacion:DetalleImporte)-Suma(ConciliacionCompensacion:AuxiliarImporte)=0.0
EjecucionMensaje=<T>No Cuadra<T>
EjecucionConError=S

[Lista.Columnas]
0=129
1=95
ConciliacionD=95
Manual=79
Referencia=150
DetalleImporte=140
AuxiliarMov=171
AuxiliarImporte=108

[Lista.DetalleImporte]
Carpeta=Lista
Clave=DetalleImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AuxiliarImporte]
Carpeta=Lista
Clave=AuxiliarImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConciliacionD.Referencia]
Carpeta=Lista
Clave=ConciliacionD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AuxiliarMov]
Carpeta=Lista
Clave=AuxiliarMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
Totalizadores1=Diferencia
Totalizadores2=Suma(ConciliacionCompensacion:DetalleImporte)-Suma(ConciliacionCompensacion:AuxiliarImporte)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Diferencia
CarpetaVisible=S

[(Carpeta Totalizadores).Diferencia]
Carpeta=(Carpeta Totalizadores)
Clave=Diferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.ListaEnCaptura]
(Inicio)=ConciliacionCompensacion.ConciliacionD
ConciliacionCompensacion.ConciliacionD=ConciliacionD.Referencia
ConciliacionD.Referencia=DetalleImporte
DetalleImporte=ConciliacionCompensacion.Manual
ConciliacionCompensacion.Manual=AuxiliarMov
AuxiliarMov=AuxiliarImporte
AuxiliarImporte=(Fin)
