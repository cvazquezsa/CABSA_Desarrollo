[Forma]
Clave=FiscalRegimenLista
Icono=0
Modulos=(Todos)
Nombre=Regímenes Fiscales

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=392
PosicionInicialArriba=130
PosicionInicialAlturaCliente=439
PosicionInicialAncho=598
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FiscalRegimen
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

[Lista.FiscalRegimen.FiscalRegimen]
Carpeta=Lista
Clave=FiscalRegimen.FiscalRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Lista.FiscalRegimen.Descripcion]
Carpeta=Lista
Clave=FiscalRegimen.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Columnas]
FiscalRegimen=124
Nombre=278
Descripcion=362

Extranjero=64

[Lista.FiscalRegimen.Extranjero]
Carpeta=Lista
Clave=FiscalRegimen.Extranjero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=FiscalRegimen.FiscalRegimen
FiscalRegimen.FiscalRegimen=FiscalRegimen.Descripcion
FiscalRegimen.Descripcion=FiscalRegimen.Extranjero
FiscalRegimen.Extranjero=(Fin)
