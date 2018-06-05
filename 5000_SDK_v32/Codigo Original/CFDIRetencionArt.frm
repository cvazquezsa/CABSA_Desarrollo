

[Forma]
Clave=CFDIRetencionArt
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Asignación de Artículos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=CFDIRetencionArt
CarpetaPrincipal=CFDIRetencionArt
PosicionInicialIzquierda=350
PosicionInicialArriba=134
PosicionInicialAlturaCliente=421
PosicionInicialAncho=666
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

[CFDIRetencionArt]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=CFDIRetencionArt
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionArt
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
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
ValidarCampos=S
ListaEnCaptura=(Lista)

ListaCamposAValidar=(Lista)


[CFDIRetencionArt.CFDIRetencionArt.CFDIRetClave]
Carpeta=CFDIRetencionArt
Clave=CFDIRetencionArt.CFDIRetClave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.Columnas]
Clave=41
Retencion=604

[CFDIRetencionArt.Columnas]
Concepto=304
CFDIRetClave=91

Articulo=100


Descripcion=331
CFDIRetIEPSImpuesto=92
[CFDIRetencionArt.CFDIRetencionArt.Articulo]
Carpeta=CFDIRetencionArt
Clave=CFDIRetencionArt.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





Efectos=[Negritas]
[CFDIRetencionArt.CFDIRetencionArt.Descripcion]
Carpeta=CFDIRetencionArt
Clave=CFDIRetencionArt.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco







[CFDIRetencionArt.ListaEnCaptura]
(Inicio)=CFDIRetencionArt.Articulo
CFDIRetencionArt.Articulo=CFDIRetencionArt.Descripcion
CFDIRetencionArt.Descripcion=CFDIRetencionArt.CFDIRetClave
CFDIRetencionArt.CFDIRetClave=CFDIRetencionArt.CFDIRetIEPSImpuesto
CFDIRetencionArt.CFDIRetIEPSImpuesto=(Fin)

[CFDIRetencionArt.ListaCamposAValidar]
(Inicio)=CFDIRetencionArt.Descripcion
CFDIRetencionArt.Descripcion=CFDIRetSATRetencion.Retencion
CFDIRetSATRetencion.Retencion=(Fin)

[CFDIRetencionArt.CFDIRetencionArt.CFDIRetIEPSImpuesto]
Carpeta=CFDIRetencionArt
Clave=CFDIRetencionArt.CFDIRetIEPSImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
