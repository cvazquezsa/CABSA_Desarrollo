
[Forma]
Clave=SATFormaPagoLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Forma de Pago
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=495
PosicionInicialArriba=140
PosicionInicialAlturaCliente=402
PosicionInicialAncho=359
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATFormaPago
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
(Inicio)=SATFormaPago.Clave
SATFormaPago.Clave=SATFormaPago.Descripcion
SATFormaPago.Descripcion=(Fin)

[Lista.SATFormaPago.Clave]
Carpeta=Lista
Clave=SATFormaPago.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.SATFormaPago.Descripcion]
Carpeta=Lista
Clave=SATFormaPago.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Lista.Columnas]
Clave=64
Descripcion=251

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
