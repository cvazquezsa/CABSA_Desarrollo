
[Forma]
Clave=SATFormaPago
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
ListaAcciones=Cerrar
PosicionInicialIzquierda=496
PosicionInicialArriba=139
PosicionInicialAlturaCliente=402
PosicionInicialAncho=359
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

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Clave=64
Descripcion=251
