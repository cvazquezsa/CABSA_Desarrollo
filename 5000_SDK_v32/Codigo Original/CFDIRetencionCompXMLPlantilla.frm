

[Forma]
Clave=CFDIRetencionCompXMLPlantilla
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Plantilla Complemento
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=439
PosicionInicialArriba=179
PosicionInicialAlturaCliente=332
PosicionInicialAncho=487
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
Vista=CFDIRetencionCompXMLPlantilla
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

[Lista.CFDIRetencionCompXMLPlantilla.Version]
Carpeta=Lista
Clave=CFDIRetencionCompXMLPlantilla.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Version=111

Vista=195
VersionComprobante=115
Complemento=124
[Acciones.Plantilla]
Nombre=Plantilla
Boton=124
NombreEnBoton=S
NombreDesplegar=&Plantilla
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionCompXMLPlantillaTexto
Activo=S
Visible=S







EspacioPrevio=S












GuardarAntes=S
Antes=S
DespuesGuardar=S














AntesExpresiones=Asigna(Info.Anuncio, CFDIRetencionCompXMLPlantilla:CFDIRetencionCompXMLPlantilla.Complemento)
[Lista.CFDIRetencionCompXMLPlantilla.Vista]
Carpeta=Lista
Clave=CFDIRetencionCompXMLPlantilla.Vista
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
ClaveAccion=CFDIRetencionCompXMLCampo
Activo=S
Visible=S



EspacioPrevio=S




GuardarAntes=S








Antes=S
DespuesGuardar=S















AntesExpresiones=Asigna(Info.Anuncio, CFDIRetencionCompXMLPlantilla:CFDIRetencionCompXMLPlantilla.Complemento)<BR>Asigna(Info.Vista, CFDIRetencionCompXMLPlantilla:CFDIRetencionCompXMLPlantilla.Vista)
[Acciones.XSD]
Nombre=XSD
Boton=125
NombreEnBoton=S
NombreDesplegar=&XSD
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDIRetencionCompXMLXSD



Antes=S












































Activo=S
Visible=S
AntesExpresiones=Asigna(Info.Anuncio, CFDIRetencionCompXMLPlantilla:CFDIRetencionCompXMLPlantilla.Complemento)


[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencionCompXMLPlantilla.Complemento
CFDIRetencionCompXMLPlantilla.Complemento=CFDIRetencionCompXMLPlantilla.Version
CFDIRetencionCompXMLPlantilla.Version=CFDIRetencionCompXMLPlantilla.Vista
CFDIRetencionCompXMLPlantilla.Vista=(Fin)

[Lista.CFDIRetencionCompXMLPlantilla.Complemento]
Carpeta=Lista
Clave=CFDIRetencionCompXMLPlantilla.Complemento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco































[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Plantilla
Plantilla=Campos
Campos=XSD
XSD=(Fin)
