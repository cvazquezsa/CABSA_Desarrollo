
[Forma]
Clave=MFAMovSubTipoDocumentoExcepcionGas
Icono=0
Modulos=(Todos)
Nombre=MFA - Configuración Concepto IEPS

ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Lista
PosicionInicialIzquierda=303
PosicionInicialArriba=138
PosicionInicialAlturaCliente=414
PosicionInicialAncho=674
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Registros
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAMovSubTipoDocumentoExcepcionGas
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

[Lista.MFAMovSubTipoDocumentoExcepcionGas.Modulo]
Carpeta=Lista
Clave=MFAMovSubTipoDocumentoExcepcionGas.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MFAMovSubTipoDocumentoExcepcionGas.Mov]
Carpeta=Lista
Clave=MFAMovSubTipoDocumentoExcepcionGas.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Lista.MFAMovSubTipoDocumentoExcepcionGas.SubTipoDocumento]
Carpeta=Lista
Clave=MFAMovSubTipoDocumentoExcepcionGas.SubTipoDocumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Modulo=61
Mov=124
Articulo=93
SubTipoDocumento=187

ConceptoGas=263
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


[Lista.MFAMovSubTipoDocumentoExcepcionGas.ConceptoGas]
Carpeta=Lista
Clave=MFAMovSubTipoDocumentoExcepcionGas.ConceptoGas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=MFAMovSubTipoDocumentoExcepcionGas.Modulo
MFAMovSubTipoDocumentoExcepcionGas.Modulo=MFAMovSubTipoDocumentoExcepcionGas.Mov
MFAMovSubTipoDocumentoExcepcionGas.Mov=MFAMovSubTipoDocumentoExcepcionGas.ConceptoGas
MFAMovSubTipoDocumentoExcepcionGas.ConceptoGas=MFAMovSubTipoDocumentoExcepcionGas.SubTipoDocumento
MFAMovSubTipoDocumentoExcepcionGas.SubTipoDocumento=(Fin)
