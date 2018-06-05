

[Forma]
Clave=CFDIRetencionConcepto
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Asignación de Conceptos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=CFDIRetencionConcepto
CarpetaPrincipal=CFDIRetencionConcepto
PosicionInicialIzquierda=389
PosicionInicialArriba=134
PosicionInicialAlturaCliente=421
PosicionInicialAncho=588
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

[CFDIRetencionConcepto]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=CFDIRetencionConcepto
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionConcepto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroGrupo1=CFDIRetencionConcepto.Modulo
FiltroValida1=CFDIRetencionConcepto.Modulo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
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

ListaCamposAValidar=CFDIRetSATRetencion.Retencion

[CFDIRetencionConcepto.CFDIRetencionConcepto.Concepto]
Carpeta=CFDIRetencionConcepto
Clave=CFDIRetencionConcepto.Concepto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

Efectos=[Negritas]
[CFDIRetencionConcepto.CFDIRetencionConcepto.CFDIRetClave]
Carpeta=CFDIRetencionConcepto
Clave=CFDIRetencionConcepto.CFDIRetClave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.Columnas]
Clave=41
Retencion=604

[CFDIRetencionConcepto.Columnas]
Concepto=304
CFDIRetClave=78





[CFDIRetencionConcepto.ListaEnCaptura]
(Inicio)=CFDIRetencionConcepto.Concepto
CFDIRetencionConcepto.Concepto=CFDIRetencionConcepto.CFDIRetClave
CFDIRetencionConcepto.CFDIRetClave=(Fin)
