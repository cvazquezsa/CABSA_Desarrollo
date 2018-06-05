
[Forma]
Clave=POSArtSucursalTemp
Icono=0
CarpetaPrincipal=POSArtSucursalTemp
Modulos=(Todos)
Nombre=Sucursales
PosicionInicialAlturaCliente=273
PosicionInicialAncho=403
SinCondicionDespliege=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSArtSucursalTemp
ListaAcciones=(Lista)
PosicionInicialIzquierda=598
PosicionInicialArriba=274
[POSArtSucursalTemp]
Estilo=Hoja
Clave=POSArtSucursalTemp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSArtSucursalTemp
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

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=POSArtSucursalTemp.Estacion = {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[POSArtSucursalTemp.POSArtSucursalTemp.Sucursal]
Carpeta=POSArtSucursalTemp
Clave=POSArtSucursalTemp.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S
Antes=S
DespuesGuardar=S
EjecucionCondicion=GuardarCambios<BR>Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSvalidarPOSArtSucursalTemp2(:nEstacion)<T>,EstacionTrabajo))<BR>Temp.Logico
EjecucionMensaje=<T>Sucursal Invalida<T>
[POSArtSucursalTemp.Columnas]
Sucursal=64
Nombre=300
HOST=124




[Lista.Columnas]
0=91
1=267


[POSArtSucursalTemp.Sucursal.Nombre]
Carpeta=POSArtSucursalTemp
Clave=Sucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Expresion]
Nombre=Expresion
Boton=59
NombreEnBoton=S
NombreDesplegar=Asignar Todas
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S





EspacioPrevio=S




GuardarAntes=S
















Expresion=EjecutarSQL(<T>spPOSeleccionarPOSArtSucursalTemp :nEstacion<T>,EstacionTrabajo)<BR>ActualizarForma



[POSArtSucursalTemp.ListaEnCaptura]
(Inicio)=POSArtSucursalTemp.Sucursal
POSArtSucursalTemp.Sucursal=Sucursal.Nombre
Sucursal.Nombre=(Fin)











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)
