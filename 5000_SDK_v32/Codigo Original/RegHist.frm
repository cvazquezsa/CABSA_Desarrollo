[Forma]
Clave=RegHist
Icono=6
Modulos=(Todos)
Nombre=Histórico Cambios
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=170
PosicionInicialArriba=101
PosicionInicialAlturaCliente=564
PosicionInicialAncho=940
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionCol1=354
PosicionSec1=238
Comentarios=Info.Nombre
FiltrarFechasSinHora=S

VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RegHist
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=RegHist.ID<TAB>(Decendente)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Cambios
MenuLocal=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaMantenerSeleccion=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=RegHist.Fecha
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroGeneral=RegHist.SysTabla=<T>{Info.Tabla}<T> AND<BR>RegHist.Llave=<T>{Info.Llave}<T>

[Lista.RegHist.Usuario]
Carpeta=Lista
Clave=RegHist.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Usuario.Nombre]
Carpeta=Lista
Clave=Usuario.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RegHist.Empresa]
Carpeta=Lista
Clave=RegHist.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RegHist.Sucursal]
Carpeta=Lista
Clave=RegHist.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=127
1=55
Fecha=148
Usuario=82
Nombre=304
Empresa=69
Sucursal=64
Nombre_1=154

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

[Detalle]
Estilo=Hoja
Clave=Detalle
OtroOrden=S
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=RegHistD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=RegHist
LlaveLocal=(Lista)
LlaveMaestra=RegHist.SysTabla<BR>RegHist.Llave<BR>RegHist.ID
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=RegHistD.RID<TAB>(Acendente)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

[Detalle.RegHistD.Valor]
Carpeta=Detalle
Clave=RegHistD.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.RegHistD.ValorAnterior]
Carpeta=Detalle
Clave=RegHistD.ValorAnterior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Columnas]
0=153
1=228
Campo=298
Valor=303
ValorAnterior=285
CampoNombre=311

[Detalle.CampoNombre]
Carpeta=Detalle
Clave=CampoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RegHist.Fecha]
Carpeta=Lista
Clave=RegHist.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=RegHist.Fecha
RegHist.Fecha=RegHist.Usuario
RegHist.Usuario=Usuario.Nombre
Usuario.Nombre=RegHist.Sucursal
RegHist.Sucursal=Sucursal.Nombre
Sucursal.Nombre=RegHist.Empresa
RegHist.Empresa=(Fin)

[Detalle.LlaveLocal]
(Inicio)=RegHistD.SysTabla
RegHistD.SysTabla=RegHistD.Llave
RegHistD.Llave=RegHistD.ID
RegHistD.ID=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=CampoNombre
CampoNombre=RegHistD.Valor
RegHistD.Valor=RegHistD.ValorAnterior
RegHistD.ValorAnterior=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)
