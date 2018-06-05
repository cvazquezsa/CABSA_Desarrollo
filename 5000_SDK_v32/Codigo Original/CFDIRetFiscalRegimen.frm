

[Forma]
Clave=CFDIRetFiscalRegimen
Icono=0
Modulos=(Todos)
Nombre=Regímenes Fiscales

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=253
PosicionInicialArriba=125
PosicionInicialAlturaCliente=451
PosicionInicialAncho=891
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetFiscalRegimen
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


[Lista.CFDIRetFiscalRegimen.Nombre]
Carpeta=Lista
Clave=CFDIRetFiscalRegimen.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CFDIRetFiscalRegimen.Descripcion]
Carpeta=Lista
Clave=CFDIRetFiscalRegimen.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Columnas]
CFDIRetFiscalRegimen=124
Nombre=278
Descripcion=362

Extranjero=64
FiscalRegimen=120
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Lista.CFDIRetFiscalRegimen.Extranjero]
Carpeta=Lista
Clave=CFDIRetFiscalRegimen.Extranjero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=CFDIRetFiscalRegimen.FiscalRegimen
CFDIRetFiscalRegimen.FiscalRegimen=CFDIRetFiscalRegimen.Nombre
CFDIRetFiscalRegimen.Nombre=CFDIRetFiscalRegimen.Descripcion
CFDIRetFiscalRegimen.Descripcion=CFDIRetFiscalRegimen.Extranjero
CFDIRetFiscalRegimen.Extranjero=(Fin)

[Lista.CFDIRetFiscalRegimen.FiscalRegimen]
Carpeta=Lista
Clave=CFDIRetFiscalRegimen.FiscalRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
