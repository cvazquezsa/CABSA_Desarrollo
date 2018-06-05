
[Forma]
Clave=AspelCambiaClaves
Icono=0
Modulos=(Todos)
Nombre=AspelCambiaClaves

ListaCarpetas=AspelCambiaClaves
CarpetaPrincipal=AspelCambiaClaves
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
[Acciones.Clientes]
Nombre=Clientes
Boton=0
NombreDesplegar=Cambia Clientes
EnMenu=S
TipoAccion=sQL
Activo=S
Visible=S

ConfirmarAntes=S
DialogoMensaje=estaseguro
SQL=spaspelcambiaclientes
[AspelCambiaClaves]
Estilo=Hoja
Clave=AspelCambiaClaves
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AspelCambiaClaves
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaAcciones=(Lista)
CarpetaVisible=S


[AspelCambiaClaves.Columnas]
Anterior=124
Nueva=124
Nivel=604





[Acciones.Artículos]
Nombre=Artículos
Boton=0
NombreDesplegar=Cambia Artículos
EnMenu=S
TipoAccion=sQL
Activo=S
Visible=S

ConfirmarAntes=S
DialogoMensaje=estaseguro
SQL=spaspelcambiaarticulos
[Acciones.Almacenes]
Nombre=Almacenes
Boton=0
NombreDesplegar=Cambia Almacenes
EnMenu=S
TipoAccion=sQL
Activo=S
Visible=S

ConfirmarAntes=S
DialogoMensaje=estaseguro
SQL=spaspelcambiaalmacen
[Acciones.Agentes]
Nombre=Agentes
Boton=0
NombreDesplegar=Cambia Agentes
EnMenu=S
TipoAccion=sQL
Activo=S
Visible=S

ConfirmarAntes=S
DialogoMensaje=estaseguro
SQL=spAspelCambiaagentes
[Acciones.Proveedores]
Nombre=Proveedores
Boton=0
NombreDesplegar=Cambia Proveedores
EnMenu=S
TipoAccion=sQL
Activo=S
Visible=S

ConfirmarAntes=S
DialogoMensaje=estaseguro
SQL=spAspelCambiaproveedores
[Acciones.CuentasContables]
Nombre=CuentasContables
Boton=0
NombreDesplegar=Cambia Cuentas Contables
EnMenu=S
TipoAccion=sQL
Activo=S
Visible=S

ConfirmarAntes=S
DialogoMensaje=estaseguro
SQL=spAspelCambiacuentas
[Acciones.CentroCostos]
Nombre=CentroCostos
Boton=0
NombreDesplegar=Cambia Centros de Costos
EnMenu=S
TipoAccion=sQL
Activo=S
Visible=S











ConfirmarAntes=S
DialogoMensaje=estaseguro
SQL=spAspelCambiacentrocostos


[AspelCambiaClaves.ListaEnCaptura]
(Inicio)=AspelCambiaClaves.Anterior
AspelCambiaClaves.Anterior=AspelCambiaClaves.Nueva
AspelCambiaClaves.Nueva=AspelCambiaClaves.Nivel
AspelCambiaClaves.Nivel=(Fin)



[AspelCambiaClaves.ListaAcciones]
(Inicio)=Clientes
Clientes=Artículos
Artículos=Almacenes
Almacenes=Agentes
Agentes=Proveedores
Proveedores=CuentasContables
CuentasContables=CentroCostos
CentroCostos=(Fin)
