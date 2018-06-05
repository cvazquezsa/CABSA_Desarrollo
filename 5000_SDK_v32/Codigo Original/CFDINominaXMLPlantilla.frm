
[Forma]
Clave=CFDINominaXMLPlantilla
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Plantilla XML
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=437
PosicionInicialArriba=209
PosicionInicialAlturaCliente=271
PosicionInicialAncho=491
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
Vista=CFDINominaXMLPlantilla
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

[Lista.CFDINominaXMLPlantilla.Version]
Carpeta=Lista
Clave=CFDINominaXMLPlantilla.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Version=93

Vista=215
VersionComprobante=115
[Acciones.Plantilla]
Nombre=Plantilla
Boton=124
NombreEnBoton=S
NombreDesplegar=&Plantilla
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CFDINominaXMLPlantillaTexto
Activo=S
Visible=S







EspacioPrevio=S












GuardarAntes=S
Antes=S
DespuesGuardar=S













AntesExpresiones=Asigna(Info.Anuncio, CFDINominaXMLPlantilla:CFDINominaXMLPlantilla.Version)

[Lista.CFDINominaXMLPlantilla.Vista]
Carpeta=Lista
Clave=CFDINominaXMLPlantilla.Vista
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
ClaveAccion=CFDINominaXMLCampo
Activo=S
Visible=S



EspacioPrevio=S




GuardarAntes=S








Antes=S
AntesExpresiones=Asigna(Info.Anuncio, CFDINominaXMLPlantilla:CFDINominaXMLPlantilla.Version)<BR>Asigna(Info.Vista, CFDINominaXMLPlantilla:CFDINominaXMLPlantilla.Vista)
DespuesGuardar=S















[Acciones.XSD]
Nombre=XSD
Boton=125
NombreEnBoton=S
NombreDesplegar=&XSD
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDINominaXMLXSD



Antes=S










































AntesExpresiones=Asigna(Info.Anuncio, CFDINominaXMLPlantilla:CFDINominaXMLPlantilla.Version)
[Lista.CFDINominaXMLPlantilla.VersionComprobante]
Carpeta=Lista
Clave=CFDINominaXMLPlantilla.VersionComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco




[Lista.ListaEnCaptura]
(Inicio)=CFDINominaXMLPlantilla.Version
CFDINominaXMLPlantilla.Version=CFDINominaXMLPlantilla.VersionComprobante
CFDINominaXMLPlantilla.VersionComprobante=CFDINominaXMLPlantilla.Vista
CFDINominaXMLPlantilla.Vista=(Fin)





























[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Plantilla
Plantilla=Campos
Campos=XSD
XSD=(Fin)
