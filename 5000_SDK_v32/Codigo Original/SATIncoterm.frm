
[Forma]
Clave=SATIncoterm
Icono=0
Modulos=(Todos)
Nombre=<T>Términos Internacionales de Comercio (INCOTERM)<T>
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=431
PosicionInicialArriba=199
PosicionInicialAlturaCliente=459
PosicionInicialAncho=578
ListaAcciones=Aceptar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATIncoterm
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
(Inicio)=SATIncoterm.Clave
SATIncoterm.Clave=SATIncoterm.Descripcion
SATIncoterm.Descripcion=(Fin)

[Lista.SATIncoterm.Clave]
Carpeta=Lista
Clave=SATIncoterm.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SATIncoterm.Descripcion]
Carpeta=Lista
Clave=SATIncoterm.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Clave=88
Descripcion=435

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
