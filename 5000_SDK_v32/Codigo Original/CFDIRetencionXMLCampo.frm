

[Forma]
Clave=CFDIRetencionXMLCampo
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Mapeo Campos
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
Vista=CFDIRetencionXMLCampo
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

ListaOrden=CFDIRetencionXMLCampo.CampoXML<TAB>(Acendente)
CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=CFDIRetencionXMLCampo.Version = <T>{Info.Anuncio}<T>
FiltroRespetar=S
FiltroTipo=General
[Lista.CFDIRetencionXMLCampo.CampoXML]
Carpeta=Lista
Clave=CFDIRetencionXMLCampo.CampoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CFDIRetencionXMLCampo.CampoVista]
Carpeta=Lista
Clave=CFDIRetencionXMLCampo.CampoVista
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
(Inicio)=CFDIRetencionXMLCampo.CampoXML
CFDIRetencionXMLCampo.CampoXML=CFDIRetencionXMLCampo.CampoVista
CFDIRetencionXMLCampo.CampoVista=(Fin)
