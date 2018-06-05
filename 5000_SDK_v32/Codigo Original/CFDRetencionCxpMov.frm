

[Forma]
Clave=CFDRetencionCxpMov
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFD Retenciones - Movimientos de la Constancia
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=CFDRetencionCxpMov
CarpetaPrincipal=CFDRetencionCxpMov
PosicionInicialIzquierda=326
PosicionInicialArriba=112
PosicionInicialAlturaCliente=466
PosicionInicialAncho=608
Comentarios=Info.Mov +<T> <T>+Info.MovID
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[CFDRetencionCxpMov]
Estilo=Iconos
Clave=CFDRetencionCxpMov
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDRetencion
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
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
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Listado
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200

ListaEnCaptura=(Lista)
IconosNombre=CFDRetencion:CFDRetencion.Mov+<T> <T>+CFDRetencion:CFDRetencion.MovID
FiltroGeneral=CFDRetencion.TimbradoCxpID = {Info.ID}
[CFDRetencionCxpMov.Columnas]
0=128

1=72
2=186
3=85

4=83
5=264
[CFDRetencionCxpMov.CFDRetencion.Proveedor]
Carpeta=CFDRetencionCxpMov
Clave=CFDRetencion.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[CFDRetencionCxpMov.CFDRetencion.ConceptoSAT]
Carpeta=CFDRetencionCxpMov
Clave=CFDRetencion.ConceptoSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco


[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
Carpeta=CFDRetencionCxpMov
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel 
EnBarraHerramientas=S
Carpeta=CFDRetencionCxpMov
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S







[CFDRetencionCxpMov.Prov.Nombre]
Carpeta=CFDRetencionCxpMov
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[CFDRetencionCxpMov.Prov.RFC]
Carpeta=CFDRetencionCxpMov
Clave=Prov.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco












[CFDRetencionCxpMov.ListaEnCaptura]
(Inicio)=CFDRetencion.Proveedor
CFDRetencion.Proveedor=Prov.Nombre
Prov.Nombre=Prov.RFC
Prov.RFC=CFDRetencion.ConceptoSAT
CFDRetencion.ConceptoSAT=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)
