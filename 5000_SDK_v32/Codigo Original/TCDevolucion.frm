
[Forma]
Clave=TCDevolucion
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Tarjeta Bancaria - Devolución
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Transacciones
CarpetaPrincipal=Transacciones
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Afectar
PosicionInicialIzquierda=191
PosicionInicialArriba=72
PosicionInicialAlturaCliente=545
PosicionInicialAncho=983
Menus=S
VentanaExclusiva=S
VentanaExclusivaOpcion=2
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spTCDevolucion :tEmpresa, :nSucursal, :nEstacion, :tFormaPago, :tModulo, :nID<T>, Empresa, Sucursal, EstacionTrabajo, Temp.Reg[1], <T>VTAS<T>, Info.ID)
MenuPrincipal=Archivo
[Transacciones]
Estilo=Hoja
Clave=Transacciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TCDevolucion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=$00F0F0F0
CarpetaVisible=S

BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroFechas=S
FiltroFechasCampo=Venta.FechaEmision
FiltroFechasDefault=(Todo)
FiltroGeneral=TCDevolucion.Estacion = <T>{EstacionTrabajo}<T>
[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=Afectar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S


NombreEnBoton=S
ConfirmarAntes=S
DialogoMensaje=TCEstaSeguroDevolucion
Menu=Archivo
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=F12
Antes=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)
AntesExpresiones=Asigna(Info.Importe, TCDevolucion:TCDevolucion.Importe)<BR>Asigna(Info.FormaPago, TCDevolucion:NoTarjeta)
[Transacciones.Movimiento]
Carpeta=Transacciones
Clave=Movimiento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=$00F0F0F0

[Transacciones.NoTarjeta]
Carpeta=Transacciones
Clave=NoTarjeta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=4
ColorFondo=$00F0F0F0

[Transacciones.TCTransaccion.Tarjetahabiente]
Carpeta=Transacciones
Clave=TCTransaccion.Tarjetahabiente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=$00F0F0F0

[Transacciones.TCTransaccion.FechaExpiracion]
Carpeta=Transacciones
Clave=TCTransaccion.FechaExpiracion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=$00F0F0F0

[Transacciones.TCTransaccion.CodigoAutorizacion]
Carpeta=Transacciones
Clave=TCTransaccion.CodigoAutorizacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=$00F0F0F0


[Transacciones.TCTransaccion.FormaPago]
Carpeta=Transacciones
Clave=TCTransaccion.FormaPago
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=$00F0F0F0

[Transacciones.TCTransaccion.BancoEmisor]
Carpeta=Transacciones
Clave=TCTransaccion.BancoEmisor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=$00F0F0F0

[Transacciones.TCTransaccion.FechaFin]
Carpeta=Transacciones
Clave=TCTransaccion.FechaFin
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=$00F0F0F0

[Transacciones.Columnas]
Movimiento=77
FormaPago=96
NoTarjeta=83
BancoEmisor=80
Tarjetahabiente=138
FechaExpiracion=88
CodigoAutorizacion=102
FechaFin=116

Importe=70

Total=64
[Transacciones.TCDevolucion.Importe]
Carpeta=Transacciones
Clave=TCDevolucion.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Transacciones.TCTransaccion.Total]
Carpeta=Transacciones
Clave=TCTransaccion.Total
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=$00F0F0F0

[Transacciones.ListaEnCaptura]
(Inicio)=Movimiento
Movimiento=TCTransaccion.FormaPago
TCTransaccion.FormaPago=NoTarjeta
NoTarjeta=TCTransaccion.BancoEmisor
TCTransaccion.BancoEmisor=TCTransaccion.Tarjetahabiente
TCTransaccion.Tarjetahabiente=TCTransaccion.FechaExpiracion
TCTransaccion.FechaExpiracion=TCTransaccion.CodigoAutorizacion
TCTransaccion.CodigoAutorizacion=TCTransaccion.Total
TCTransaccion.Total=TCTransaccion.FechaFin
TCTransaccion.FechaFin=TCDevolucion.Importe
TCDevolucion.Importe=(Fin)

[Acciones.Afectar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Archivo, SQL(<T>EXEC spTCAfectarDevolucion :tEmpresa, :nSucursal, :nEstacion, :tFormaPago, :tModulo, :nID, :tUsuario, :nImporte, :tIDOrden, :tCampo, @Generar = 1<T>, Empresa, Sucursal, EstacionTrabajo, Temp.Reg[1], <T>VTAS<T>, Info.ID, Usuario, Info.Importe, TCDevolucion:TCDevolucion.IDOrden, Temp.Reg[4]))<BR>Si Izquierda(Info.Archivo, 5) <> <T>Error<T><BR>Entonces<BR>  Ejecutar(Info.Archivo, Verdadero)<BR>  ProcesarSQL(<T>EXEC spTCAfectarDevolucion :tEmpresa, :nSucursal, :nEstacion, :tFormaPago, :tModulo, :nID, :tUsuario, :nImporte, :tIDOrden, :tCampo<T>, Empresa, Sucursal, EstacionTrabajo, Temp.Reg[1], <T>VTAS<T>, Info.ID, Usuario, Info.Importe, TCDevolucion:TCDevolucion.IDOrden, Temp.Reg[4])<BR>Sino<BR>  Error(Info.Archivo)<BR>Fin
[Acciones.Afectar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S













[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)
