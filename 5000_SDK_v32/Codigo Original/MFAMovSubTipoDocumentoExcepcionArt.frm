
[Forma]
Clave=MFAMovSubTipoDocumentoExcepcionArt
Icono=0
Modulos=(Todos)
Nombre=MFA - Configuración Artículo IEPS

ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Lista
PosicionInicialIzquierda=266
PosicionInicialArriba=113
PosicionInicialAlturaCliente=463
PosicionInicialAncho=747
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
Vista=MFAMovSubTipoDocumentoExcepcionArt
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

[Lista.MFAMovSubTipoDocumentoExcepcionArt.Modulo]
Carpeta=Lista
Clave=MFAMovSubTipoDocumentoExcepcionArt.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MFAMovSubTipoDocumentoExcepcionArt.Mov]
Carpeta=Lista
Clave=MFAMovSubTipoDocumentoExcepcionArt.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAMovSubTipoDocumentoExcepcionArt.Articulo]
Carpeta=Lista
Clave=MFAMovSubTipoDocumentoExcepcionArt.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFAMovSubTipoDocumentoExcepcionArt.SubTipoDocumento]
Carpeta=Lista
Clave=MFAMovSubTipoDocumentoExcepcionArt.SubTipoDocumento
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

Descripcion1=244
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

[Lista.ListaEnCaptura]
(Inicio)=MFAMovSubTipoDocumentoExcepcionArt.Modulo
MFAMovSubTipoDocumentoExcepcionArt.Modulo=MFAMovSubTipoDocumentoExcepcionArt.Mov
MFAMovSubTipoDocumentoExcepcionArt.Mov=MFAMovSubTipoDocumentoExcepcionArt.Articulo
MFAMovSubTipoDocumentoExcepcionArt.Articulo=Art.Descripcion1
Art.Descripcion1=MFAMovSubTipoDocumentoExcepcionArt.SubTipoDocumento
MFAMovSubTipoDocumentoExcepcionArt.SubTipoDocumento=(Fin)

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
