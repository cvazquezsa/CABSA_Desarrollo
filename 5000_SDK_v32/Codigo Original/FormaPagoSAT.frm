
[Forma]
Clave=FormaPagoSAT
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Forma Pago
AccionesTamanoBoton=15x5
AccionesDerecha=S

CarpetaPrincipal=Lista
PosicionInicialIzquierda=374
PosicionInicialArriba=102
PosicionInicialAlturaCliente=478
PosicionInicialAncho=601
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=(Lista)
PosicionCol1=240
ListaAcciones=Guardar
[Lista.ListaEnCaptura]
(Inicio)=FormaPagoSAT.FormaPago
FormaPagoSAT.FormaPago=FormaPagoSAT.ClaveSAT
FormaPagoSAT.ClaveSAT=(Fin)

[Lista.FormaPagoSAT.FormaPago]
Carpeta=Lista
Clave=FormaPagoSAT.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.FormaPagoSAT.ClaveSAT]
Carpeta=Lista
Clave=FormaPagoSAT.ClaveSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
FormaPago=205
ClaveSAT=64

Clave=64
Descripcion=251
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoSAT
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
ListaEnCaptura=FormaPagoSAT.FormaPago
CarpetaVisible=S

[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=FormaPagoSAT
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
[Detalle.FormaPagoSAT.FormaPago]
Carpeta=Detalle
Clave=FormaPagoSAT.FormaPago
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.FormaPagoSAT.ClaveSAT]
Carpeta=Detalle
Clave=FormaPagoSAT.ClaveSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.SATFormaPago.Descripcion]
Carpeta=Detalle
Clave=SATFormaPago.Descripcion
3D=S
Pegado=N
Tamano=20
ColorFondo=Blanco





ValidaNombre=S
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S








[Detalle.ListaEnCaptura]
(Inicio)=FormaPagoSAT.FormaPago
FormaPagoSAT.FormaPago=FormaPagoSAT.ClaveSAT
FormaPagoSAT.ClaveSAT=SATFormaPago.Descripcion
SATFormaPago.Descripcion=(Fin)















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)
