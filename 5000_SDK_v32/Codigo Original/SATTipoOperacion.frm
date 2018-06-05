
[Forma]
Clave=SATTipoOperacion
Icono=0
Modulos=(Todos)
Nombre=<T>Catálogo de Tipo de Operación<T>
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=Aceptar
PosicionInicialIzquierda=422
PosicionInicialArriba=274
PosicionInicialAlturaCliente=309
PosicionInicialAncho=596
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATTipoOperacion
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
[Lista.ListaEnCaptura]
(Inicio)=SATTipoOperacion.Clave
SATTipoOperacion.Clave=SATTipoOperacion.Descripcion
SATTipoOperacion.Descripcion=(Fin)

[Lista.SATTipoOperacion.Clave]
Carpeta=Lista
Clave=SATTipoOperacion.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SATTipoOperacion.Descripcion]
Carpeta=Lista
Clave=SATTipoOperacion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Clave=94
Descripcion=409
