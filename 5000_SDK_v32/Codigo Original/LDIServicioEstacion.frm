
[Forma]
Clave=LDIServicioEstacion
Icono=0
CarpetaPrincipal=LDIServicioEstacion
Modulos=(Todos)
Nombre=IP  Estación
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=LDIServicioEstacion
PosicionInicialIzquierda=477
PosicionInicialArriba=304
PosicionInicialAlturaCliente=273
PosicionInicialAncho=325
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

[LDIServicioEstacion]
Estilo=Hoja
Clave=LDIServicioEstacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LDIServicioEstacion
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
[LDIServicioEstacion.ListaEnCaptura]
(Inicio)=LDIServicioEstacion.EstacionFija
LDIServicioEstacion.EstacionFija=LDIServicioEstacion.DireccionIP
LDIServicioEstacion.DireccionIP=LDIServicioEstacion.Puerto
LDIServicioEstacion.Puerto=(Fin)

[LDIServicioEstacion.LDIServicioEstacion.EstacionFija]
Carpeta=LDIServicioEstacion
Clave=LDIServicioEstacion.EstacionFija
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[LDIServicioEstacion.LDIServicioEstacion.DireccionIP]
Carpeta=LDIServicioEstacion
Clave=LDIServicioEstacion.DireccionIP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[LDIServicioEstacion.LDIServicioEstacion.Puerto]
Carpeta=LDIServicioEstacion
Clave=LDIServicioEstacion.Puerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[LDIServicioEstacion.Columnas]
EstacionFija=83
DireccionIP=94
Puerto=64
