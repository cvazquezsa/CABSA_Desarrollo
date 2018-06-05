
[Forma]
Clave=POSCFD
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración CFD
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Campos
CarpetaPrincipal=Campos
PosicionInicialAlturaCliente=273
PosicionInicialAncho=1024
ListaAcciones=Guardar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=171
PosicionInicialArriba=229
Comentarios=Empresa
[Campos]
Estilo=Hoja
Clave=Campos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCFD
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
ValidarCampos=S

ListaCamposAValidar=Cte.Nombre
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=POSCFD.Empresa = <T>{Empresa}<T>
FiltroRespetar=S
FiltroTipo=General
[Campos.POSCFD.Cliente]
Carpeta=Campos
Clave=POSCFD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.POSCFD.GenerarPDF]
Carpeta=Campos
Clave=POSCFD.GenerarPDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.POSCFD.NombreReportePDF]
Carpeta=Campos
Clave=POSCFD.NombreReportePDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Campos.POSCFD.GuardarRutaPDF]
Carpeta=Campos
Clave=POSCFD.GuardarRutaPDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Campos.POSCFD.GuardarArchivoPDF]
Carpeta=Campos
Clave=POSCFD.GuardarArchivoPDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Campos.POSCFD.GenerarXML]
Carpeta=Campos
Clave=POSCFD.GenerarXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.POSCFD.GuardarRutaXML]
Carpeta=Campos
Clave=POSCFD.GuardarRutaXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Campos.POSCFD.GuardarArchivoXML]
Carpeta=Campos
Clave=POSCFD.GuardarArchivoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Campos.POSCFD.EnviarMail]
Carpeta=Campos
Clave=POSCFD.EnviarMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.POSCFD.EnviarAsunto]
Carpeta=Campos
Clave=POSCFD.EnviarAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Campos.POSCFD.EnviarMensaje]
Carpeta=Campos
Clave=POSCFD.EnviarMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.POSCFD.EnviarGuardarArchivo]
Carpeta=Campos
Clave=POSCFD.EnviarGuardarArchivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Campos.Columnas]
Cliente=56
GenerarPDF=65
NombreReportePDF=145
GuardarRutaPDF=231
GuardarArchivoPDF=240
GenerarXML=67
GuardarRutaXML=177
GuardarArchivoXML=219
EnviarMail=69
EnviarAsunto=188
EnviarMensaje=304
EnviarGuardarArchivo=287

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S









[Campos.ListaEnCaptura]
(Inicio)=POSCFD.Cliente
POSCFD.Cliente=POSCFD.GenerarPDF
POSCFD.GenerarPDF=POSCFD.NombreReportePDF
POSCFD.NombreReportePDF=POSCFD.GuardarRutaPDF
POSCFD.GuardarRutaPDF=POSCFD.GuardarArchivoPDF
POSCFD.GuardarArchivoPDF=POSCFD.GenerarXML
POSCFD.GenerarXML=POSCFD.GuardarRutaXML
POSCFD.GuardarRutaXML=POSCFD.GuardarArchivoXML
POSCFD.GuardarArchivoXML=POSCFD.EnviarMail
POSCFD.EnviarMail=POSCFD.EnviarAsunto
POSCFD.EnviarAsunto=POSCFD.EnviarMensaje
POSCFD.EnviarMensaje=POSCFD.EnviarGuardarArchivo
POSCFD.EnviarGuardarArchivo=(Fin)

[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107
