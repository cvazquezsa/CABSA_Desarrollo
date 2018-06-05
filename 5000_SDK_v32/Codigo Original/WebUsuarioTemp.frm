[Forma]
Clave=WebUsuarioTemp
Nombre=Usuarios eCommerce
Icono=0
CarpetaPrincipal=WebUsuarioTemp
Modulos=(Todos)
ListaCarpetas=WebUsuarioTemp
PosicionInicialIzquierda=157
PosicionInicialArriba=256
PosicionInicialAlturaCliente=468
PosicionInicialAncho=1268
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=WebUsuario
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebUsuario.Apellido
ListaOrden=WebUsuario.ID<TAB>(Acendente)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroEmpresas=S
FiltroSucursales=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Usuario Web
IconosNombre=WebUsuario:WebUsuario.Nombre
BusquedaRapida=S
BusquedaEnLinea=S
[(Carpeta Abrir).WebUsuario.Apellido]
Carpeta=(Carpeta Abrir)
Clave=WebUsuario.Apellido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[(Carpeta Abrir).Columnas]
0=116
1=379
[WebUsuarioTemp]
Estilo=Hoja
Clave=WebUsuarioTemp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebUsuarioTemp
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=WebUsuarioTemp.Cliente<BR>WebUsuarioTemp.Nombre<BR>WebUsuarioTemp.Apellido<BR>WebUsuarioTemp.eMail<BR>WebUsuarioTemp.eMail2<BR>WebUsuarioTemp.Contrasena<BR>WebUsuarioTemp.ContrasenaConfirmacion<BR>WebUsuarioTemp.Telefono
Filtros=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=WebUsuarioTemp.Estacion ={EstacionTrabajo}
[WebUsuarioTemp.WebUsuarioTemp.Cliente]
Carpeta=WebUsuarioTemp
Clave=WebUsuarioTemp.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarioTemp.WebUsuarioTemp.Nombre]
Carpeta=WebUsuarioTemp
Clave=WebUsuarioTemp.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarioTemp.WebUsuarioTemp.Apellido]
Carpeta=WebUsuarioTemp
Clave=WebUsuarioTemp.Apellido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarioTemp.WebUsuarioTemp.eMail]
Carpeta=WebUsuarioTemp
Clave=WebUsuarioTemp.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=250
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarioTemp.WebUsuarioTemp.eMail2]
Carpeta=WebUsuarioTemp
Clave=WebUsuarioTemp.eMail2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=250
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarioTemp.WebUsuarioTemp.Contrasena]
Carpeta=WebUsuarioTemp
Clave=WebUsuarioTemp.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarioTemp.WebUsuarioTemp.ContrasenaConfirmacion]
Carpeta=WebUsuarioTemp
Clave=WebUsuarioTemp.ContrasenaConfirmacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarioTemp.WebUsuarioTemp.Telefono]
Carpeta=WebUsuarioTemp
Clave=WebUsuarioTemp.Telefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarioTemp.Columnas]
Cliente=85
Nombre=267
Apellido=291
eMail=196
eMail2=269
Contrasena=123
ContrasenaConfirmacion=120
Telefono=147
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
[Acciones.Expresion]
Nombre=Expresion
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
ConCondicion=S
EjecucionConError=S
Expresion=ProcesarSQL(<T>speCommerceInsertarWebUsuario :nEstacion<T>,EstacionTrabajo)<BR>ActualizarForma
EjecucionCondicion=GuardarCambios<BR>Asigna(Info.Descripcion,SQL(<T>SELECT dbo.fnWebValidarContacto(:nEstacion)<T>,EstacionTrabajo))<BR>Vacio(Info.Descripcion)
EjecucionMensaje=Info.Descripcion
[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=Guardar Cambios
Guardar Cambios=(Fin)
