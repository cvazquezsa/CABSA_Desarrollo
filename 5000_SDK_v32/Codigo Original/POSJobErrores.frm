
[Forma]
Clave=POSJobErrores
Icono=0
EsConsultaExclusiva=S
Modulos=(Todos)
Nombre=POS Errores
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=-8
PosicionInicialArriba=-8
PosicionInicialAlturaCliente=716
PosicionInicialAncho=1382
ListaAcciones=(Lista)
BarraHerramientas=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Maximizado
ExpresionesAlMostrar=ProcesarSQL(<T>EXEC spActualizaPOSJobError :nSuc<T>, Sucursal)    <BR>ActualizarVista<BR>ActualizarForma
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Errores
Clave=Lista
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSJobErrores
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=POSJobErrores.ID<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=POSJobErrores.Sucursal=Sucursal
FiltroSucursales=S
[Lista.POSJobErrores.Sucursal]
Carpeta=Lista
Clave=POSJobErrores.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSJobErrores.IDPos]
Carpeta=Lista
Clave=POSJobErrores.IDPos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco

[Lista.POSJobErrores.Error]
Carpeta=Lista
Clave=POSJobErrores.Error
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Columnas]
0=58
1=207
2=1028



3=-2

Sucursal=64
IDPos=220
Error=989
Atendido=64
[Lista.POSJobErrores.Atendido]
Carpeta=Lista
Clave=POSJobErrores.Atendido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
BtnResaltado=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Actualiza]
Nombre=Actualiza
Boton=0
NombreDesplegar=Ac&tualizar Vista
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S


NombreEnBoton=S
BtnResaltado=S
Expresion=ProcesarSQL(<T>EXEC spActualizaPOSJobError :nSuc<T>, Sucursal)    <BR>ActualizarVista<BR>ActualizarForma
[Acciones.Depura]
Nombre=Depura
Boton=0
NombreEnBoton=S
NombreDesplegar=De&purar Atendidos
EnBarraHerramientas=S
BtnResaltado=S
TipoAccion=Expresion
Activo=S

































Expresion=ProcesarSQL(<T>EXEC spDepuraPOSJobError :nSuc<T>, Sucursal)<BR>ActualizarVista<BR>ActualizarForma

[Lista.ListaEnCaptura]
(Inicio)=POSJobErrores.Sucursal
POSJobErrores.Sucursal=POSJobErrores.IDPos
POSJobErrores.IDPos=POSJobErrores.Error
POSJobErrores.Error=POSJobErrores.Atendido
POSJobErrores.Atendido=(Fin)











[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Actualiza
Actualiza=Depura
Depura=(Fin)
