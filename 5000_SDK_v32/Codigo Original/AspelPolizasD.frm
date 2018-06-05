[Forma]
Clave=AspelPolizasD
Nombre=Detalle Polizas
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Mov,Info.Fecha)
ListaAcciones=Cerrar
PosicionInicialIzquierda=470
PosicionInicialArriba=295
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Detalle Polizas
Clave=Lista
Filtros=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AspelPolizasD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
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
HojaAjustarColumnas=S
FiltroGeneral=Empresa = <T>{Info.Empresa}<T> AND<BR>Sucursal = {Info.Sucursal} AND<BR>Modulo = <T>{Info.Modulo}<T> AND<BR>Mov = <T>{Info.Mov}<T> AND<BR>FechaEmision = <T>{Info.Fecha}<T> AND<BR>Estatus = <T>{Info.Estatus}<T>

[Lista.Cuenta]
Carpeta=Lista
Clave=Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Debe]
Carpeta=Lista
Clave=Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Haber]
Carpeta=Lista
Clave=Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=40
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Cuenta=124
Debe=64
Haber=64

[Lista.ListaEnCaptura]
(Inicio)=Cuenta
Cuenta=Debe
Debe=Haber
Haber=(Fin)
