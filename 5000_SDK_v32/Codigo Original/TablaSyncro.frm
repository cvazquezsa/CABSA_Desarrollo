
[Forma]
Clave=TablaSyncro
Icono=0
Modulos=(Todos)
Nombre=Tabla Syncro CRM

ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=0
PosicionInicialArriba=273
PosicionInicialAlturaCliente=285
PosicionInicialAncho=1132
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[Hoja]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaSyncro
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
[Hoja.ListaEnCaptura]
(Inicio)=TablaSyncro.TablaIntelisis
TablaSyncro.TablaIntelisis=TablaSyncro.TablaCRM
TablaSyncro.TablaCRM=TablaSyncro.OrdenCampo
TablaSyncro.OrdenCampo=TablaSyncro.OrdenTabla
TablaSyncro.OrdenTabla=TablaSyncro.CampoInt
TablaSyncro.CampoInt=TablaSyncro.CampoExt
TablaSyncro.CampoExt=TablaSyncro.IdAutomatico
TablaSyncro.IdAutomatico=TablaSyncro.BuscarDato
TablaSyncro.BuscarDato=TablaSyncro.DefaultInsert
TablaSyncro.DefaultInsert=TablaSyncro.AccionEspecifica
TablaSyncro.AccionEspecifica=(Fin)

[Hoja.TablaSyncro.TablaIntelisis]
Carpeta=Hoja
Clave=TablaSyncro.TablaIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Hoja.TablaSyncro.TablaCRM]
Carpeta=Hoja
Clave=TablaSyncro.TablaCRM
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Hoja.TablaSyncro.OrdenCampo]
Carpeta=Hoja
Clave=TablaSyncro.OrdenCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.TablaSyncro.OrdenTabla]
Carpeta=Hoja
Clave=TablaSyncro.OrdenTabla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.TablaSyncro.CampoInt]
Carpeta=Hoja
Clave=TablaSyncro.CampoInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Hoja.TablaSyncro.CampoExt]
Carpeta=Hoja
Clave=TablaSyncro.CampoExt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Hoja.TablaSyncro.IdAutomatico]
Carpeta=Hoja
Clave=TablaSyncro.IdAutomatico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.TablaSyncro.BuscarDato]
Carpeta=Hoja
Clave=TablaSyncro.BuscarDato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.TablaSyncro.DefaultInsert]
Carpeta=Hoja
Clave=TablaSyncro.DefaultInsert
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.TablaSyncro.AccionEspecifica]
Carpeta=Hoja
Clave=TablaSyncro.AccionEspecifica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Hoja.Columnas]
TablaIntelisis=116
TablaCRM=175
OrdenCampo=67
OrdenTabla=64
CampoInt=123
CampoExt=154
IdAutomatico=68
BuscarDato=64
DefaultInsert=109
AccionEspecifica=134

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
