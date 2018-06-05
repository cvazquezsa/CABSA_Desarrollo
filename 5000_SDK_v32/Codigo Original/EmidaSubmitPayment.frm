
[Forma]
Clave=EmidaSubmitPayment
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Reporte de Pago
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

Menus=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=354
PosicionInicialArriba=242
PosicionInicialAlturaCliente=205
PosicionInicialAncho=571
ListaCarpetas=Datos
CarpetaPrincipal=Datos
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spEmidaSubmitPaymentEliminar :nEstacion<T>, EstacionTrabajo)
MenuPrincipal=&Archivo
[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
EnBarraHerramientas=S
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=&Afectar
EnMenu=S
TipoAccion=Expresion

GuardarAntes=S
Expresion=ProcesarSQL(<T>spEmidaSubmitPayment :tEmpresa, :nEstacion, :tUsuario, :nSucursal<T>, Empresa, EstacionTrabajo, Usuario, Sucursal)
[Datos]
Estilo=Ficha
Clave=Datos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaSubmitPayment
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Datos
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[Datos.EmidaSubmitPayment.CarrierId]
Carpeta=Datos
Clave=EmidaSubmitPayment.CarrierId
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Datos.EmidaSubmitPayment.documentNumber]
Carpeta=Datos
Clave=EmidaSubmitPayment.documentNumber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Datos.EmidaSubmitPayment.documentDate]
Carpeta=Datos
Clave=EmidaSubmitPayment.documentDate
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Datos.EmidaSubmitPayment.Institucion]
Carpeta=Datos
Clave=EmidaSubmitPayment.Institucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

ColorFondo=Blanco
[Datos.InstitucionFin.Nombre]
Carpeta=Datos
Clave=InstitucionFin.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=$00F0F0F0

[Datos.EmidaSubmitPayment.amount]
Carpeta=Datos
Clave=EmidaSubmitPayment.amount
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Datos.Columnas]
CarrierId=71
documentNumber=154
documentDate=94
Institucion=124
Nombre=304
amount=64










Description=128
ProductCount=73
[Lista.Columnas]
Institucion=87
Nombre=190
Ciudad=63
Estado=48


[Datos.EmidaCarrierCfg.Description]
Carpeta=Datos
Clave=EmidaCarrierCfg.Description
Editar=S
3D=S
Tamano=40
ColorFondo=$00F0F0F0

[Datos.ListaEnCaptura]
(Inicio)=EmidaSubmitPayment.CarrierId
EmidaSubmitPayment.CarrierId=EmidaCarrierCfg.Description
EmidaCarrierCfg.Description=EmidaSubmitPayment.documentNumber
EmidaSubmitPayment.documentNumber=EmidaSubmitPayment.documentDate
EmidaSubmitPayment.documentDate=EmidaSubmitPayment.Institucion
EmidaSubmitPayment.Institucion=InstitucionFin.Nombre
InstitucionFin.Nombre=EmidaSubmitPayment.amount
EmidaSubmitPayment.amount=(Fin)

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cancelar
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S


Menu=&Archivo
EnMenu=S


[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cerrar
Cerrar=(Fin)

































































































































[Forma.ListaAcciones]
(Inicio)=Afectar
Afectar=Cancelar
Cancelar=(Fin)
