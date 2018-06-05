
[Forma]
Clave=POSLDIServicioEstacion
Icono=0
CarpetaPrincipal=POSLDIServicioEstacion
Modulos=(Todos)
Nombre=IP  Estación
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=POSLDIServicioEstacion
PosicionInicialIzquierda=390
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

[POSLDIServicioEstacion]
Estilo=Hoja
Clave=POSLDIServicioEstacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLDIServicioEstacion
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
[POSLDIServicioEstacion.ListaEnCaptura]
(Inicio)=POSLDIServicioEstacion.EstacionFija
POSLDIServicioEstacion.EstacionFija=POSLDIServicioEstacion.DireccionIP
POSLDIServicioEstacion.DireccionIP=POSLDIServicioEstacion.Puerto
POSLDIServicioEstacion.Puerto=(Fin)

[POSLDIServicioEstacion.POSLDIServicioEstacion.EstacionFija]
Carpeta=POSLDIServicioEstacion
Clave=POSLDIServicioEstacion.EstacionFija
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLDIServicioEstacion.POSLDIServicioEstacion.DireccionIP]
Carpeta=POSLDIServicioEstacion
Clave=POSLDIServicioEstacion.DireccionIP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[POSLDIServicioEstacion.POSLDIServicioEstacion.Puerto]
Carpeta=POSLDIServicioEstacion
Clave=POSLDIServicioEstacion.Puerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[POSLDIServicioEstacion.Columnas]
EstacionFija=83
DireccionIP=94
Puerto=64
