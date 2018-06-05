
[Forma]
Clave=TCVentaCobroAdministrar
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Tarjetas Bancarias - Administar Cobros
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
PosicionInicialIzquierda=280
PosicionInicialArriba=100
PosicionInicialAlturaCliente=490
PosicionInicialAncho=806
ListaCarpetas=Cobros
CarpetaPrincipal=Cobros
VentanaExclusiva=S
VentanaExclusivaOpcion=2
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Cobros]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Cobros
Clave=Cobros
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TCVentaCobroAdministrar
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroAutoCampo=Estatus
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroAutoValidar=Estatus


IconosCampo=Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Campo<T>
ElementosPorPaginaEsp=200
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=RID<TAB>(Acendente)
IconosNombre=TCVentaCobroAdministrar:Campo
[Cobros.Columnas]
FormaPago=304

0=92
1=107
2=93


3=97
4=153
5=124
6=-2
7=-2
8=-2

[Cobros.FormaPago]
Carpeta=Cobros
Clave=FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Cobros.Importe]
Carpeta=Cobros
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Cobros.NumeroTarjeta]
Carpeta=Cobros
Clave=NumeroTarjeta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=4
ColorFondo=Blanco

[Cobros.Tarjetahabiente]
Carpeta=Cobros
Clave=Tarjetahabiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco






[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Mostrar Campos
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S














EspacioPrevio=S

[Acciones.Reimprimir]
Nombre=Reimprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=Reimprimir Voucher
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



EspacioPrevio=S






ConCondicion=S






Expresion=ReportePantalla(<T>TCVoucher<T>, TCVentaCobroAdministrar:RID)
EjecucionCondicion=ConDatos(TCVentaCobroAdministrar:RID)
















[Acciones.Cancelar]
Nombre=Cancelar
Boton=32
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S

EspacioPrevio=S




































Expresion=Asigna(Info.Archivo, SQL(<T>EXEC spTCAfectarPinPad :tEmpresa, :tModulo, :nModuloID, :nSucursal, :tEstacion, :tAccion, :tUsuario, :nRID, @Generar = 1<T>, Empresa, TCVentaCobroAdministrar:Modulo, TCVentaCobroAdministrar:ModuloID, Sucursal, EstacionTrabajo, <T>Void<T>, Usuario, TCVentaCobroAdministrar:RID))<BR><BR>Si Izquierda(Info.Archivo, 5) <> <T>Error<T><BR>Entonces<BR>  Ejecutar(Info.Archivo, Verdadero)<BR>  ProcesarSQL(<T>EXEC spTCAfectarPinPad :tEmpresa, :tModulo, :nModuloID, :nSucursal, :tEstacion, :tAccion, :tUsuario, :nRID<T>, Empresa, TCVentaCobroAdministrar:Modulo, TCVentaCobroAdministrar:ModuloID, Sucursal, EstacionTrabajo, <T>Void<T>, Usuario, TCVentaCobroAdministrar:RID)<BR>  ReportePantalla(<T>TCVoucher<T>, SQL(<T>SELECT RID FROM TCEstacionTransaccion WHERE Empresa = :tEmpresa AND Sucursal = :nSucursal AND Estacion = :nEstacion<T>, Empresa, Sucursal, EstacionTrabajo))<BR>  ActualizarVista<BR>  ActualizarForma<BR>Sino<BR>  Error(Info.Archivo)<BR>Fin
ActivoCondicion=TCVentaCobroAdministrar:Estatus en(<T>Autorizacion<T>, <T>Devolucion<T>) /*y(TCVentaCobroAdministrar:MovEstatus noen(<T>CONCLUIDO<T>, <T>CANCELADO<T>))*/
[Cobros.CodigoAutorizacion]
Carpeta=Cobros
Clave=CodigoAutorizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
















































































[Cobros.Estatus]
Carpeta=Cobros
Clave=Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Cobros.ListaOrden]
(Inicio)=CodigoAutorizacion	(Acendente)
CodigoAutorizacion	(Acendente)=RID	(Acendente)
RID	(Acendente)=(Fin)







































[Cobros.ListaEnCaptura]
(Inicio)=FormaPago
FormaPago=Importe
Importe=NumeroTarjeta
NumeroTarjeta=Tarjetahabiente
Tarjetahabiente=Estatus
Estatus=CodigoAutorizacion
CodigoAutorizacion=TotalCobrado
TotalCobrado=(Fin)

[Cobros.TotalCobrado]
Carpeta=Cobros
Clave=TotalCobrado
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Reimprimir
Reimprimir=Cancelar
Cancelar=Mostrar Campos
Mostrar Campos=(Fin)
