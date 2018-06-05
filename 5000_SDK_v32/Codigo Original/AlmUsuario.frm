[Forma]
Clave=AlmUsuario
Nombre=Configurar
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=229
PosicionInicialArriba=204
PosicionInicialAlturaCliente=325
PosicionInicialAncho=566
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioCfg2
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
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
HojaMantenerSeleccion=S

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

[Lista.Columnas]
0=111
1=289
Usuario=84
Nombre=290
GrupoTrabajo=161

[Lista.Usuario.GrupoTrabajo]
Carpeta=Lista
Clave=Usuario.GrupoTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Almacenes]
Nombre=Almacenes
Boton=80
NombreEnBoton=S
NombreDesplegar=&Almacenes con Acceso
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=UsuarioAlm
Visible=S
Antes=S
ActivoCondicion=UsuarioCfg2:UsuarioCfg2.ControlAlmacenes
AntesExpresiones=Asigna(Info.Usuario, UsuarioCfg2:UsuarioCfg2.Usuario)

[Lista.UsuarioCfg2.Usuario]
Carpeta=Lista
Clave=UsuarioCfg2.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Almacenes
Almacenes=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=UsuarioCfg2.Usuario
UsuarioCfg2.Usuario=Usuario.Nombre
Usuario.Nombre=Usuario.GrupoTrabajo
Usuario.GrupoTrabajo=(Fin)
