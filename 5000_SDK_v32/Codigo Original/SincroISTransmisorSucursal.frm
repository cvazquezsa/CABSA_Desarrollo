
[Forma]
Clave=SincroISTransmisorSucursal
Icono=0
Modulos=(Todos)
Nombre=<T>Sincro IS - Configurar Conexión<T>

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=372
PosicionInicialArriba=169
PosicionInicialAlturaCliente=352
PosicionInicialAncho=622
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SincroISTransmisorSucursal
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

[Lista.SincroISTransmisorSucursal.Sucursal]
Carpeta=Lista
Clave=SincroISTransmisorSucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SincroISTransmisorSucursal.Servidor]
Carpeta=Lista
Clave=SincroISTransmisorSucursal.Servidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SincroISTransmisorSucursal.BaseDatosNombre]
Carpeta=Lista
Clave=SincroISTransmisorSucursal.BaseDatosNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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

[Lista.Columnas]
Sucursal=64
Servidor=121
BaseDatosNombre=145



SincroISDropBox=79

HabilitarCompresion=102
[Lista.SincroISTransmisorSucursal.SincroISDropBox]
Carpeta=Lista
Clave=SincroISTransmisorSucursal.SincroISDropBox
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=SincroISTransmisorSucursal.Sucursal
SincroISTransmisorSucursal.Sucursal=SincroISTransmisorSucursal.Servidor
SincroISTransmisorSucursal.Servidor=SincroISTransmisorSucursal.BaseDatosNombre
SincroISTransmisorSucursal.BaseDatosNombre=SincroISTransmisorSucursal.HabilitarCompresion
SincroISTransmisorSucursal.HabilitarCompresion=SincroISTransmisorSucursal.SincroISDropBox
SincroISTransmisorSucursal.SincroISDropBox=(Fin)

[Lista.SincroISTransmisorSucursal.HabilitarCompresion]
Carpeta=Lista
Clave=SincroISTransmisorSucursal.HabilitarCompresion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
