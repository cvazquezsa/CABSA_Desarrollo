
[Forma]
Clave=POSLDIFormaPago
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración Formas de Pago LDI
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaSiempreAlFrente=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Campos
CarpetaPrincipal=Campos
ListaAcciones=Guardar
PosicionInicialIzquierda=290
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=786
[Campos]
Estilo=Hoja
Clave=Campos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLDIFormaPago
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

[Campos.POSLDIFormaPago.FormaPago]
Carpeta=Campos
Clave=POSLDIFormaPago.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Campos.POSLDIFormaPago.Servicio]
Carpeta=Campos
Clave=POSLDIFormaPago.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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

[Campos.Columnas]
FormaPago=167
Servicio=124
Forma=170
ServicioInverso=124
AplicaMeses=76
ApartirDe=77

[Campos.POSLDIFormaPago.Forma]
Carpeta=Campos
Clave=POSLDIFormaPago.Forma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Campos.POSLDIFormaPago.ServicioInverso]
Carpeta=Campos
Clave=POSLDIFormaPago.ServicioInverso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Campos.POSLDIFormaPago.AplicaMeses]
Carpeta=Campos
Clave=POSLDIFormaPago.AplicaMeses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S


[Campos.POSLDIFormaPago.ApartirDe]
Carpeta=Campos
Clave=POSLDIFormaPago.ApartirDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S


[Campos.ListaEnCaptura]
(Inicio)=POSLDIFormaPago.FormaPago
POSLDIFormaPago.FormaPago=POSLDIFormaPago.Servicio
POSLDIFormaPago.Servicio=POSLDIFormaPago.ServicioInverso
POSLDIFormaPago.ServicioInverso=POSLDIFormaPago.Forma
POSLDIFormaPago.Forma=POSLDIFormaPago.AplicaMeses
POSLDIFormaPago.AplicaMeses=POSLDIFormaPago.ApartirDe
POSLDIFormaPago.ApartirDe=(Fin)


[Meses.Columnas]
Meses=150



