
[Forma]
Clave=POSCfgUbicacionRed
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Ubicación Red del Servidor Sucursal y Matriz
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Campos
CarpetaPrincipal=Campos
ListaAcciones=Guardar
PosicionInicialIzquierda=367
PosicionInicialArriba=229
PosicionInicialAlturaCliente=273
PosicionInicialAncho=632
[Campos]
Estilo=Hoja
Clave=Campos
PermiteEditar=S
GuardarPorRegistro=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCfgUbicacionRed
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

[Campos.POSCfgUbicacionRed.Tipo]
Carpeta=Campos
Clave=POSCfgUbicacionRed.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.POSCfgUbicacionRed.Servidor]
Carpeta=Campos
Clave=POSCfgUbicacionRed.Servidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Campos.POSCfgUbicacionRed.BaseDatos]
Carpeta=Campos
Clave=POSCfgUbicacionRed.BaseDatos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Campos.Columnas]
Tipo=110
Servidor=166
BaseDatos=156

ConexionActiva=82
UbicacionLocal=76

[Campos.POSCfgUbicacionRed.ConexionActiva]
Carpeta=Campos
Clave=POSCfgUbicacionRed.ConexionActiva
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.POSCfgUbicacionRed.UbicacionLocal]
Carpeta=Campos
Clave=POSCfgUbicacionRed.UbicacionLocal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.ListaEnCaptura]
(Inicio)=POSCfgUbicacionRed.Tipo
POSCfgUbicacionRed.Tipo=POSCfgUbicacionRed.UbicacionLocal
POSCfgUbicacionRed.UbicacionLocal=POSCfgUbicacionRed.Servidor
POSCfgUbicacionRed.Servidor=POSCfgUbicacionRed.BaseDatos
POSCfgUbicacionRed.BaseDatos=POSCfgUbicacionRed.ConexionActiva
POSCfgUbicacionRed.ConexionActiva=(Fin)
