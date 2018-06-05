
[Forma]
Clave=POSSucursal
Icono=0
CarpetaPrincipal=Sucursal
Modulos=(Todos)
Nombre=Sucursales

ListaCarpetas=(Lista)
PosicionInicialIzquierda=325
PosicionInicialArriba=164
PosicionInicialAlturaCliente=360
PosicionInicialAncho=716
PosicionCol1=250
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[POSSucursal]
Estilo=Ficha
Clave=POSSucursal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSSucursal
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[POSSucursal.POSSucursal.POSMensajeLimiteCaja]
Carpeta=POSSucursal
Clave=POSSucursal.POSMensajeLimiteCaja
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=50
[POSSucursal.POSSucursal.POSLimiteCaja]
Carpeta=POSSucursal
Clave=POSSucursal.POSLimiteCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Sucursal]
Estilo=Hoja
Clave=Sucursal
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSSucursal
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
HojaAjustarColumnas=S
[Sucursal.POSSucursal.Nombre]
Carpeta=Sucursal
Clave=POSSucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Sucursal.Columnas]
Nombre=172



























Sucursal=45
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






RefrescarDespues=S
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.POSCobroFormasPago]
Nombre=POSCobroFormasPago
Boton=96
NombreEnBoton=S
NombreDesplegar=Formas Pago Cobro
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=POSCobroFormasPago
Activo=S
Antes=S
DespuesGuardar=S
Visible=S



EspacioPrevio=S








































AntesExpresiones=Asigna(Info.Sucursal,POSSucursal:POSSucursal.Sucursal)
[Acciones.POSLTipoCambioRef]
Nombre=POSLTipoCambioRef
Boton=61
NombreEnBoton=S
NombreDesplegar=Tipos Cambio
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=POSLTipoCambioRef
Activo=S
Visible=S











Antes=S










AntesExpresiones=Asigna(Info.Sucursal,POSSucursal:POSSucursal.Sucursal)

































[POSSucursal.POSSucursal.HOST]
Carpeta=POSSucursal
Clave=POSSucursal.HOST
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[Sucursal.ListaEnCaptura]
(Inicio)=POSSucursal.Sucursal
POSSucursal.Sucursal=POSSucursal.Nombre
POSSucursal.Nombre=(Fin)

[Sucursal.POSSucursal.Sucursal]
Carpeta=Sucursal
Clave=POSSucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






















[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=AvanzarCaptura<BR> Forma.Guardar
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)



[POSSucursal.POSSucursal.EnviaCorreo]
Carpeta=POSSucursal
Clave=POSSucursal.EnviaCorreo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[POSSucursal.POSSucursal.Perfil]
Carpeta=POSSucursal
Clave=POSSucursal.Perfil
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S


[POSSucursal.POSSucursal.Remitente]
Carpeta=POSSucursal
Clave=POSSucursal.Remitente
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
LineaNueva=S




[POSSucursal.ListaEnCaptura]
(Inicio)=POSSucursal.POSMensajeLimiteCaja
POSSucursal.POSMensajeLimiteCaja=POSSucursal.POSLimiteCaja
POSSucursal.POSLimiteCaja=POSSucursal.HOST
POSSucursal.HOST=POSSucursal.EnviaCorreo
POSSucursal.EnviaCorreo=POSSucursal.Perfil
POSSucursal.Perfil=POSSucursal.Remitente
POSSucursal.Remitente=(Fin)














[Forma.ListaCarpetas]
(Inicio)=Sucursal
Sucursal=POSSucursal
POSSucursal=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=POSLTipoCambioRef
POSLTipoCambioRef=POSCobroFormasPago
POSCobroFormasPago=(Fin)
