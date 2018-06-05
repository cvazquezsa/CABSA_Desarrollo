[Forma]
Clave=WebUsuarioLista
Nombre=Lista de Usuarios Web
Icono=0
Modulos=(Todos)
ListaCarpetas=WebUsuariosLista
CarpetaPrincipal=WebUsuariosLista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=690
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=373
PosicionInicialArriba=363
[WebUsuariosLista]
Estilo=Hoja
Clave=WebUsuariosLista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebUsuario
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Normal
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
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
BusquedaAncho=40
BusquedaEnLinea=S
[WebUsuariosLista.WebUsuario.UsuarioWeb]
Carpeta=WebUsuariosLista
Clave=WebUsuario.UsuarioWeb
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuariosLista.WebUsuario.Nombre]
Carpeta=WebUsuariosLista
Clave=WebUsuario.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuariosLista.WebUsuario.eMail]
Carpeta=WebUsuariosLista
Clave=WebUsuario.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuariosLista.WebUsuario.Rol]
Carpeta=WebUsuariosLista
Clave=WebUsuario.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuariosLista.Columnas]
UsuarioWeb=124
Nombre=295
eMail=304
Rol=304
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Seleccionar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S











Expresion=Asigna(CteX.eMail, WebUsuario:WebUsuario.eMail )<BR>Asigna(Info.Valor, WebUsuario:WebUsuario.Nombre )
[WebUsuariosLista.ListaEnCaptura]
(Inicio)=WebUsuario.UsuarioWeb
WebUsuario.UsuarioWeb=WebUsuario.eMail
WebUsuario.eMail=WebUsuario.Nombre
WebUsuario.Nombre=WebUsuario.Rol
WebUsuario.Rol=(Fin)

[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Seleccionar
Seleccionar=(Fin)
