
[Forma]
Clave=MFAActivoFCat
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Categorías de Activo Fijo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
PosicionInicialAlturaCliente=337
PosicionInicialAncho=376
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=452
PosicionInicialArriba=176
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Menus=S
MenuPrincipal=&Maestros
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

GuardarAntes=S
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAActivoFCat
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

ListaOrden=MFAActivoFCat.Categoria<TAB>(Acendente)
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
ValidarCampos=S
ListaCamposAValidar=MFATipoActivo.Descripcion
[Lista.MFAActivoFCat.Categoria]
Carpeta=Lista
Clave=MFAActivoFCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFAActivoFCat.Tipo]
Carpeta=Lista
Clave=MFAActivoFCat.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
Categoria=238
Tipo=79

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
[Acciones.MFATipoActivo]
Nombre=MFATipoActivo
Boton=0
Menu=&Maestros
NombreDesplegar=Tipos de Activo Fijo
EnMenu=S
TipoAccion=Formas
ClaveAccion=MFATipoActivo
Activo=S
Visible=S








[Lista.ListaEnCaptura]
(Inicio)=MFAActivoFCat.Categoria
MFAActivoFCat.Categoria=MFAActivoFCat.Tipo
MFAActivoFCat.Tipo=(Fin)






























[Acciones.Sugerir.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>EXEC spMFAActivoFCatSugerir<T>)<BR>ActualizarForma<BR>ActualizarVista
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
Sugerir=MFATipoActivo
MFATipoActivo=(Fin)
