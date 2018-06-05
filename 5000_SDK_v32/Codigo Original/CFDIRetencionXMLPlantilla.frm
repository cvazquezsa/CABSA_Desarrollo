

[Forma]
Clave=CFDIRetencionXMLPlantilla
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Plantilla XML
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=476
PosicionInicialArriba=209
PosicionInicialAlturaCliente=271
PosicionInicialAncho=413
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
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionXMLPlantilla
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

[Lista.CFDIRetencionXMLPlantilla.Version]
Carpeta=Lista
Clave=CFDIRetencionXMLPlantilla.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Version=111

Vista=215
VersionComprobante=115
[Acciones.Plantilla]
Nombre=Plantilla
Boton=124
NombreEnBoton=S
NombreDesplegar=&Plantilla
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionXMLPlantillaTexto
Activo=S
Visible=S







EspacioPrevio=S












GuardarAntes=S
Antes=S
DespuesGuardar=S














AntesExpresiones=Asigna(Info.Anuncio, CFDIRetencionXMLPlantilla:CFDIRetencionXMLPlantilla.Version)
[Lista.CFDIRetencionXMLPlantilla.Vista]
Carpeta=Lista
Clave=CFDIRetencionXMLPlantilla.Vista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




















[Acciones.Campos]
Nombre=Campos
Boton=47
NombreEnBoton=S
NombreDesplegar=Campos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionXMLCampo
Activo=S
Visible=S



EspacioPrevio=S




GuardarAntes=S








Antes=S
DespuesGuardar=S















AntesExpresiones=Asigna(Info.Anuncio, CFDIRetencionXMLPlantilla:CFDIRetencionXMLPlantilla.Version)<BR>Asigna(Info.Vista, CFDIRetencionXMLPlantilla:CFDIRetencionXMLPlantilla.Vista)
[Acciones.XSD]
Nombre=XSD
Boton=125
NombreEnBoton=S
NombreDesplegar=&XSD
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionXMLXSD



Antes=S












































Activo=S
AntesExpresiones=Asigna(Info.Anuncio, CFDIRetencionXMLPlantilla:CFDIRetencionXMLPlantilla.Version)
Visible=S
[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencionXMLPlantilla.Version
CFDIRetencionXMLPlantilla.Version=CFDIRetencionXMLPlantilla.Vista
CFDIRetencionXMLPlantilla.Vista=(Fin)









































































[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Plantilla
Plantilla=Campos
Campos=XSD
XSD=(Fin)
