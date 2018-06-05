
[Forma]
Clave=POSCBAccion
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=POS Acciones
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSLCBAccionTemp
CarpetaPrincipal=POSLCBAccionTemp
PosicionInicialAlturaCliente=685
PosicionInicialAncho=526
ListaAcciones=Guardar y Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=537
PosicionInicialArriba=68



VentanaExclusivaOpcion=0
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSInsertarPOSLCBAccionTemp :nEstacion<T>,EstacionTrabajo)
[POSCBAccion.Columnas]
Codigo=100
Accion=154


[Acciones.Guardar y Cerrar]
Nombre=Guardar y Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S











Multiple=S
ListaAccionesMultiples=(Lista)
[POSCBAccion.ListaEnCaptura]
(Inicio)=POSCBAccion.Codigo
POSCBAccion.Codigo=POSCBAccion.Accion
POSCBAccion.Accion=(Fin)

[POSLCBAccionTemp]
Estilo=Hoja
Clave=POSLCBAccionTemp
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLCBAccionTemp
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S

ListaOrden=(Lista)
FiltroGeneral=POSLCBAccionTemp.Estacion = {EstacionTrabajo}
[POSLCBAccionTemp.POSLCBAccionTemp.Codigo]
Carpeta=POSLCBAccionTemp
Clave=POSLCBAccionTemp.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSLCBAccionTemp.POSLCBAccionTemp.Accion]
Carpeta=POSLCBAccionTemp
Clave=POSLCBAccionTemp.Accion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[POSLCBAccionTemp.Columnas]
Codigo=184
Accion=304

[POSLCBAccionTemp.ListaEnCaptura]
(Inicio)=POSLCBAccionTemp.Codigo
POSLCBAccionTemp.Codigo=POSLCBAccionTemp.Accion
POSLCBAccionTemp.Accion=(Fin)

[POSLCBAccionTemp.ListaOrden]
(Inicio)=POSLCBAccionTemp.Codigo	(Acendente)
POSLCBAccionTemp.Codigo	(Acendente)=POSLCBAccionTemp.Accion	(Acendente)
POSLCBAccionTemp.Accion	(Acendente)=(Fin)

[Acciones.Guardar y Cerrar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSActualizarCBAccion :nEstacion<T>,EstacionTrabajo)
Activo=S
Visible=S

[Acciones.Guardar y Cerrar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Guardar y Cerrar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
