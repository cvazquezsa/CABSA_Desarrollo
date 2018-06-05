[Forma]
Clave=SATMetodoPagoLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Método de  Pago
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=523
PosicionInicialArriba=200
PosicionInicialAlturaCliente=300
PosicionInicialAncho=336
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATMetodoPago
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
ListaEnCaptura=SATMetodoPago.Clave
CarpetaVisible=S

[Lista.SATMetodoPago.Clave]
Carpeta=Lista
Clave=SATMetodoPago.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Clave=295


[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)

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
