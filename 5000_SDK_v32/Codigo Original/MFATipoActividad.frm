
[Forma]
Clave=MFATipoActividad
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Cambio Tipo Actividad Declaración IVA
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=491
PosicionInicialArriba=202
PosicionInicialAlturaCliente=285
PosicionInicialAncho=391
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFATipoActividad
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
OtroOrden=S
BusquedaRapidaControles=S

ListaOrden=(Lista)
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
[Lista.MFATipoActividad.Modulo]
Carpeta=Lista
Clave=MFATipoActividad.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MFATipoActividad.Mov]
Carpeta=Lista
Clave=MFATipoActividad.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFATipoActividad.Tipo]
Carpeta=Lista
Clave=MFATipoActividad.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=MFATipoActividad.Modulo
MFATipoActividad.Modulo=MFATipoActividad.Mov
MFATipoActividad.Mov=MFATipoActividad.Tipo
MFATipoActividad.Tipo=(Fin)

[Lista.ListaOrden]
(Inicio)=MFATipoActividad.Modulo	(Acendente)
MFATipoActividad.Modulo	(Acendente)=MFATipoActividad.Mov	(Acendente)
MFATipoActividad.Mov	(Acendente)=(Fin)

[Lista.Columnas]
Modulo=58
Mov=141
Tipo=120
