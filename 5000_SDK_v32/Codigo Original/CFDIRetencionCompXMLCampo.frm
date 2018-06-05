

[Forma]
Clave=CFDIRetencionCompXMLCampo
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Mapeo Campos Complemento
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=433
PosicionInicialArriba=144
PosicionInicialAlturaCliente=402
PosicionInicialAncho=500
Comentarios=Lista(Info.Anuncio, Info.Vista)
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
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionCompXMLCampo
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

ListaOrden=CFDIRetencionCompXMLCampo.CampoXML<TAB>(Acendente)
CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CFDIRetencionCompXMLCampo.Complemento = <T>{Info.Anuncio}<T>
[Lista.CFDIRetencionCompXMLCampo.CampoXML]
Carpeta=Lista
Clave=CFDIRetencionCompXMLCampo.CampoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CFDIRetencionCompXMLCampo.CampoVista]
Carpeta=Lista
Clave=CFDIRetencionCompXMLCampo.CampoVista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
CampoXML=230
CampoVista=221



[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencionCompXMLCampo.CampoXML
CFDIRetencionCompXMLCampo.CampoXML=CFDIRetencionCompXMLCampo.CampoVista
CFDIRetencionCompXMLCampo.CampoVista=(Fin)
