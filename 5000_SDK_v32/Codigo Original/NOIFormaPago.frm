
[Forma]
Clave=NOIFormaPago
Icono=0
CarpetaPrincipal=NOIFormaPago
BarraHerramientas=S
Modulos=(Todos)
Nombre=Formas de Pago
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=NOIFormaPago
ListaAcciones=Aceptar
PosicionInicialIzquierda=618
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=363
[NOIFormaPago]
Estilo=Hoja
Clave=NOIFormaPago
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOIFormaPago
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
PermiteEditar=S

[NOIFormaPago.NOIFormaPago.FormaPagoNOI]
Carpeta=NOIFormaPago
Clave=NOIFormaPago.FormaPagoNOI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOIFormaPago.NOIFormaPago.FormaPago]
Carpeta=NOIFormaPago
Clave=NOIFormaPago.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

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

[NOIFormaPago.Columnas]
FormaPagoNOI=147
FormaPago=176

[NOIFormaPago.ListaEnCaptura]
(Inicio)=NOIFormaPago.FormaPagoNOI
NOIFormaPago.FormaPagoNOI=NOIFormaPago.FormaPago
NOIFormaPago.FormaPago=(Fin)
