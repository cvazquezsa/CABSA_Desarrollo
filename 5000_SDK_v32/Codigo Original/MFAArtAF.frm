
[Forma]
Clave=MFAArtAF
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Artículos Activo Fijo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
PosicionInicialIzquierda=414
PosicionInicialArriba=171
PosicionInicialAlturaCliente=348
PosicionInicialAncho=451
ListaCarpetas=MFAArtAF
CarpetaPrincipal=MFAArtAF
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

[MFAArtAF]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=MFAArtAF
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAArtAF
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
ListaOrden=MFAArtAF.Articulo<TAB>(Acendente)
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
[MFAArtAF.MFAArtAF.Articulo]
Carpeta=MFAArtAF
Clave=MFAArtAF.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MFAArtAF.Columnas]
Articulo=90

Descripcion1=303

[MFAArtAF.Art.Descripcion1]
Carpeta=MFAArtAF
Clave=Art.Descripcion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco






[Lista.Columnas]
Articulo=131
Descripcion1=244


[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
NombreEnBoton=S
NombreDesplegar=&Sugerir
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S















ConfirmarAntes=S



Multiple=S
ListaAccionesMultiples=(Lista)
[MFAArtAF.ListaEnCaptura]
(Inicio)=MFAArtAF.Articulo
MFAArtAF.Articulo=Art.Descripcion1
Art.Descripcion1=(Fin)














[Acciones.Sugerir.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>EXEC spMFAArtAFSugerir<T>)<BR>ActualizarForma<BR>ActualizarVista
[Acciones.Sugerir.CancelarCambios]
Nombre=CancelarCambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S





[Acciones.Sugerir.ListaAccionesMultiples]
(Inicio)=CancelarCambios
CancelarCambios=Expresion
Expresion=(Fin)

[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Sugerir
Sugerir=(Fin)
