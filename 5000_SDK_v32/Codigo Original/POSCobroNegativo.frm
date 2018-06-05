
[Forma]
Clave=POSCobroNegativo
Icono=0
Modulos=(Todos)
Nombre=POS Cobro

ListaCarpetas=(Lista)
CarpetaPrincipal=Cobro

AccionesTamanoBoton=100x5
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=406
PosicionInicialArriba=295
PosicionInicialAlturaCliente=411
PosicionInicialAncho=1108
PosicionCol1=401




ListaAcciones=(Lista)
PosicionSec1=177
PosicionSec2=374
VentanaEscCerrar=S
VentanaRepetir=S
VentanaExclusiva=S
PosicionCol3=322
AccionesCentro=S
AccionesDivision=S
MenuTouchScreenMostrarTeclasFuncion=S
PosicionCol2=294
VentanaExclusivaOpcion=0

VentanaColor=$00804000
ExpresionesAlMostrar=//Asigna(Ver.FormasPago, TextoEnLista(SQL(<T>EXEC spPOSMuestraFormasPago<T>)))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef, Info.Importe)<BR>Asigna(Info.CodigoFormaPago, Nulo)<BR>Asigna(Ver.Cambio, $0.00)<BR>Asigna(Info.Cambio, 0)<BR>Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR><BR>//Asigna(Info.CodigoFormaPago, SQL(<T>SELECT ISNULL(f.F2,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR><BR>Asigna(Info.CodigoFormaPago, SQL(<T>SELECT NULLIF(FormaPagoSaldoAFavor,:tVacio) FROM POSCfg WHERE Empresa = :tEmpresa<T>, <T> <T>, Empresa))<BR><BR>Si<BR>  Vacio(Info.CodigoFormaPago)<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago,SQL(<T>SELECT ISNULL(NULLIF(f.F2, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Fin<BR><BR>Asigna(Temp.TextoTemp02, Info.CodigoFormaPago)<BR>Asigna(Info.POSFormaPago2,SQL(<T>SELECT ISNULL(NULLIF(f.F2, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago3,SQL(<T>SELECT ISNULL(NULLIF(f.F3, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F3 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago4,SQL(<T>SELECT ISNULL(NULLIF(f.F4, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F4 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago5,SQL(<T>SELECT ISNULL(NULLIF(f.F5, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F5 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago6,SQL(<T>SELECT ISNULL(NULLIF(f.F6, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F6 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago7,SQL(<T>SELECT ISNULL(NULLIF(f.F7, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F7 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.POSFormaPago8,SQL(<T>SELECT ISNULL(NULLIF(f.F8, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR><BR>Asigna(Info.BancoA01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA01, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoA02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA02, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA02 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoA03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA03, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA03 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoA04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA04, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA04 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoA05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA05, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA05 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoA06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA06, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA06 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoA07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA07, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA07 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoA08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoA08, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoA08 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR><BR>Asigna(Info.BancoB01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB01, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoB02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB02, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB02 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoB03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB03, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB03 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoB04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB04, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB04 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoB05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB05, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB05 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoB06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB06, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB06 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoB07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB07, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB07 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoB08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoB08, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoB08 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR><BR>Asigna(Info.BancoC01,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC01, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC01 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoC02,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC02, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC02 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoC03,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC03, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC03 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoC04,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC04, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC04 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoC05,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC05, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC05 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoC06,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC06, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC06 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoC07,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC07, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC07 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR>Asigna(Info.BancoC08,SQL(<T>SELECT ISNULL(NULLIF(f.BancoC08, :tNulo),:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.BancoC08 AND c.TipoCuenta = :tTipoCuenta WHERE f.Sucursal = :nSucursal<T>, <T> <T>, <T>Vacio<T>, <T>Forma Pago<T>, Sucursal)))<BR><BR>Asigna(Temp.POSMonederoL,SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Temp.POSMonederoFP,SQL(<T>SELECT ISNULL(NULLIF(POSDefMonedero, :tNulo),:tVacio) FROM POSCfg WHERE Empresa = :tEmpresa<T>, <T> <T>, <T>Vacio<T>, Empresa))
ExpresionesAlActivar=Asigna(Info.Codigo, Nulo)
DeshabilitarAyuda=S
Menus=S
[POSCobroNegativo.ListaEnCaptura]
(Inicio)=Ver.Total
Ver.Total=Info.Codigo
Info.Codigo=Info.Saldo
Info.Saldo=(Fin)



[FormasPago]
Estilo=Ficha
Clave=FormasPago
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro
CampoColorLetras=Negro
CampoColorFondo=$00C6FFFF
CarpetaVisible=S

ListaEnCaptura=Ver.FormasPago
ConFuenteEspecial=S
FichaNombres=Clasico
FichaAlineacion=Derecha
FichaAlineacionDerecha=S
FichaEspacioNombresAuto=S
AlinearTodaCarpeta=S

[Cobro]
Estilo=Ficha
Clave=Cobro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
ConFuenteEspecial=S
Fuente={Segoe UI, 18, Blanco, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=$008080FF
CampoColorFondo=Aqua
ListaEnCaptura=(Lista)

CarpetaVisible=S


AlinearTodaCarpeta=S

CampoAccionAlEnter=CalculaCambio

[Acciones.Enter.VariablesAsignar]
Nombre=VariablesAsignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

[Acciones.Enter]
Nombre=Enter
Boton=0
NombreDesplegar=Cobrar
Activo=S
Visible=S

TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar















Multiple=S
ListaAccionesMultiples=(Lista)
NombreEnBoton=S
UsaTeclaRapida=S
TeclaFuncion=F12
[Cobro.Info.Importe]
Carpeta=Cobro
Clave=Info.Importe
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Aqua








AccionAlEnter=CalculaCambio
EspacioPrevio=N
Pegado=S
ColorFuente=$008080FF
[Saldo]
Estilo=Ficha
Clave=Saldo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 48, Lima, []}
CampoColorLetras=Lima
CampoColorFondo=Negro
ListaEnCaptura=Ver.Saldo
CarpetaVisible=S

ConFuenteEspecial=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Negro
FichaAlineacionDerecha=S
AlinearTodaCarpeta=S
[Saldo.Ver.Saldo]
Carpeta=Saldo
Clave=Ver.Saldo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=11
ColorFondo=Negro





















ColorFuente=Lima
[Cobro.Info.Referencia]
Carpeta=Cobro
Clave=Info.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=14













AccionAlEnter=Enter












IgnoraFlujo=N

AccionAlEnterBloquearAvance=N
ColorFondo=Blanco
ColorFuente=Rojo obscuro
[Acciones.CalculaCambio.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.CalculaCambio.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S











Expresion=Asigna(Ver.Cambio, SQL(<T>EXEC spPOSCalculaCambio :nSaldo, :nImporte<T>, Info.Saldo, Info.Importe))<BR>Asigna(Info.Cambio, SQL(<T>EXEC spPOSCalculaCambioCalc :nSaldo, :nImporte, :nMostrar<T>, Info.Saldo, Info.Importe, 1))
[Cambio.Ver.Cambio]
Carpeta=Cambio
Clave=Ver.Cambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Plata

































[Acciones.Enter.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Enter.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





ConCondicion=S

EjecucionCondicion=Info.Saldo <= 0
[Acciones.ActualizaRedondeo.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.ActualizaRedondeo.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si Info.POSRedondeo > 0<BR>Entonces<BR>EjecutarSQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo, :nImporte<T>, Info.IDTexto, <T>INSERTAR<T>, Info.POSRedondeo)<BR>Sino<BR>Asigna(Info.POSRedondeo, Info.POSRedondeo)<BR>Fin<BR><BR>Asigna(Info.Importe, Info.Importe + Info.POSRedondeo)<BR>Asigna(Info.Saldo, Info.Saldo + Info.POSRedondeo)<BR>Asigna(Ver.Saldo, <T>$<T> & SQL(<T>SELECT CONVERT(varchar,CONVERT(money, :nSaldo) ,101)<T>, Info.Saldo))<BR>Asigna(Info.POSRedondeo, 0)

[Acciones.Enter.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S








































ConCondicion=S



















Expresion=Asigna(Rep.Cargos,  Abs(SQL(<T>SELECT SUM(ISNULL(Puntos,0)) FROM POSLVenta WHERE ID=:tID<T>, Info.IDTexto) ))<BR>Asigna(Info.POSLDIError, Nulo)<BR>Asigna(Info.FormaExtra, Nulo)<BR>Asigna(Info.FormaExtra, SQL(<T>EXEC spPOSLDIFormaPagoFormaAnexa :tCodigo, :tID, :tEmpresa<T>, Info.CodigoFormaPago, Info.IDTexto, Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa)=0<BR>Entonces<BR>  Si Info.FormaExtra <> Nulo Entonces FormaModal(Info.FormaExtra) Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Asigna(Info.FormaExtra, Nulo)<BR><BR>Asigna(Info.Codigo, Info.CodigoFormaPago)<BR>Asigna(Info.CodigoFormaPago, Nulo)<BR><BR>Si Info.POSLDIError <> Nulo Entonces Asigna(Info.Codigo, Nulo) Fin<BR><BR>/*Verifica si hay un servicio en este movimiento*/<BR>Asigna(Rep.Cargos,  Abs(SQL(<T>SELECT SUM(ISNULL(Puntos,0)) FROM POSLVenta WHERE ID=:tID<T>, Info.IDTexto) ))<BR>Si Info.POSMonedero <> Nulo Entonces<BR> Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, 0, Nulo,Nulo, 0, Nulo, Nulo, Info.POSMonedero))<BR>Fin<BR><BR>Asigna(Info.FormaExtra,Temp.Reg[13])<BR>Asigna(Info.Servicio,Temp.Reg[12])<BR><BR>/* Aqui se ejecuta el SPPOS para cobrar */<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero, Info.POSImporteRef))<BR><BR>Asigna(Info.Saldo, Temp.Reg[9])<BR><BR>/* Aqui se ejecuta la forma en caso que el servicio tenga configurada una forma y ya se vaya a cobrar la nota */<BR>  Si (Info.Saldo = 0) y (Info.FormaExtra <> Nulo)  y (Info.Servicio <> Nulo) Entonces FormaModal(Info.FormaExtra) Fin<BR><BR>Si Ver.Cambio noen(0, <T>$0.00<T>) Entonces Informacion(<T>Cambio: <T> & Ver.Cambio) Fin<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
EjecucionCondicion=((Ver.Cambio en(0, <T>$0.00<T>))<BR>o (ConDatos(Info.FormaPagoCambio))) y (Info.Importe <> 0)
[Cambio.ListaEnCaptura]
(Inicio)=Ver.Cambio
Ver.Cambio=Ver.Aviso
Ver.Aviso=(Fin)







[Mensaje]
Estilo=Ficha
Clave=Mensaje
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=(Variables)
Fuente={Segoe UI, 18, Rojo obscuro, []}
CampoColorLetras=$008080FF
CampoColorFondo=Aqua
ListaEnCaptura=Ver.Aviso
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Aqua
AlinearTodaCarpeta=S
ConFuenteEspecial=S
BarraBotones=S
ListaAccionesBB=(Lista)
BarraBtnFuente={Segoe UI, 10, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=4
BarraBtnBisel=0
BarraBtnPaginas=5
BarraBtnSinBisel=S
[Mensaje.Ver.Aviso]
Carpeta=Mensaje
Clave=Ver.Aviso
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Aqua



























ColorFuente=$008080FF
[Cobro.Info.CodigoFormaPago]
Carpeta=Cobro
Clave=Info.CodigoFormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
AccionAlEnter=CalculaImporteRef
Tamano=14








EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Rojo obscuro
[Acciones.Monedero]
Nombre=Monedero
Boton=0
NombreEnBoton=S

NombreDesplegar=&Alta Monedero
TipoAccion=Expresion
Activo=S
Visible=S

Menu=Principal

Expresion=Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa =:tEmpresa<T>,Empresa)=0<BR>Entonces<BR>  FormaModal(<T>POSMonedero<T>)<BR>Sino<BR>  Informacion(<T>OpciÃ³n no Disponible<T>)<BR>Fin
[Acciones.FormaAnexa.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S


[Acciones.FormaAnexa.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S







[Acciones.FormaAnexa.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)



















































[Acciones.ActualizaRedondeo.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)






















[Acciones.CalculaImporteRef]
Nombre=CalculaImporteRef
Boton=0
NombreDesplegar=CalculaImporteRef
TipoAccion=Expresion
Activo=S
Visible=S




Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.CalculaImporteRef.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.CalculaImporteRef.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Ano,SQL(<T>SELECT dbo.fnPOSRedondeoMonetarios(:tEmpresa)<T>,Empresa))<BR>Asigna(Info.POSImporteRef, Redondea(Info.Saldo / SQL(<T>EXEC spPOSTipoCambioRefCalc :nSuc, :tCodigoFP, :tEmpresa<T>, Sucursal, Info.CodigoFormaPago,Empresa),Info.Ano))<BR>Asigna(Info.Importe, SQL(<T>EXEC spPOSImporteRefCalc :nSuc, :nImporteRef, :tCodigoFP, :tEmpresa<T>, Sucursal, Info.POSImporteRef, Info.CodigoFormaPago,Empresa))<BR>Forma.Accion(<T>CalculaCambio<T>)


[FormasPago.Ver.FormasPago]
Carpeta=FormasPago
Clave=Ver.FormasPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=$00A8FFFF
























































[Cobro.Info.POSImporteRef]
Carpeta=Cobro
Clave=Info.POSImporteRef
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=$00C08000
AccionAlEnter=CalculaImporteRef
ColorFuente=Blanco

[Acciones.CalculaCambio.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)


[Acciones.F2]
Nombre=F2
Boton=0
NombreDesplegar=Info.POSFormaPago2
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.F3]
Nombre=F3
Boton=0
NombreDesplegar=Info.POSFormaPago3
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.F4]
Nombre=F4
Boton=0
NombreDesplegar=Info.POSFormaPago4
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.F5]
Nombre=F5
Boton=0
NombreDesplegar=Info.POSFormaPago5
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.F6]
Nombre=F6
Boton=0
NombreDesplegar=Info.POSFormaPago6
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.F7]
Nombre=F7
Boton=0
NombreDesplegar=Info.POSFormaPago7
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.F8]
Nombre=F8
Boton=0
NombreDesplegar=Info.POSFormaPago8
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.BancoA01]
Nombre=BancoA01
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA01
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoA02]
Nombre=BancoA02
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA02
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoA03]
Nombre=BancoA03
Boton=0
NombreDesplegar=Info.BancoA03
Activo=S
Visible=S
Menu=Especial 1
TipoAccion=expresion

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoA04]
Nombre=BancoA04
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA04
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoA05]
Nombre=BancoA05
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA05
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoA06]
Nombre=BancoA06
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA06
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoA07]
Nombre=BancoA07
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA07
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoA08]
Nombre=BancoA08
Boton=0
Menu=Especial 1
NombreDesplegar=Info.BancoA08
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoB01]
Nombre=BancoB01
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB01
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoB02]
Nombre=BancoB02
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB02
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoB03]
Nombre=BancoB03
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB03
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoB04]
Nombre=BancoB04
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB04
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoB05]
Nombre=BancoB05
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB05
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoB06]
Nombre=BancoB06
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB06
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoB07]
Nombre=BancoB07
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB07
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoB08]
Nombre=BancoB08
Boton=0
Menu=Especial 2
NombreDesplegar=Info.BancoB08
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoC01]
Nombre=BancoC01
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC01
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoC02]
Nombre=BancoC02
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC02
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoC03]
Nombre=BancoC03
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC03
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoC04]
Nombre=BancoC04
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC04
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoC05]
Nombre=BancoC05
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC05
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoC06]
Nombre=BancoC06
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC06
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoC07]
Nombre=BancoC07
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC07
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancoC08]
Nombre=BancoC08
Boton=0
Menu=Especial 3
NombreDesplegar=Info.BancoC08
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.F2.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F2,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.F2.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.F3.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F3,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.F3.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.F4.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F4,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.F4.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.F5.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F5,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.F5.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.F6.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F6,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.F6.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.F7.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F7,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.F7.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.F8.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F8,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.F8.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S









[Cobro.Info.Importe2]
Carpeta=Cobro
Clave=Info.Importe2
LineaNueva=N
3D=S
AccionAlEnter=Enter
Tamano=-1
ColorFondo=$00C08000
Pegado=N
Editar=S



ColorFuente=Blanco
[Acciones.Enter.Devolucion]
Nombre=Devolucion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=Si Info.POSMonedero <> Nulo Entonces<BR>Si<BR>  Info.POSImporteRef < 0<BR>Entonces<BR>  Asigna(Temp.Logico,SQL(<T>SELECT ISNULL(MonederoLDI,0) FROM POSCfg pc   WHERE Empresa =:tEmpresa<T>,Empresa))<BR><BR>Si Temp.Logico<BR>Entonces<BR>  Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal, :nMonRemp, :nCargo<T>, <T>MON CARGO<T>, Info.IDTexto, Info.POSMonedero,Empresa, Usuario, Sucursal, nulo, Rep.Cargos))<BR><BR>Si Temp.Reg3[1] <> Nulo Entonces Error(Temp.Reg3[2]) Fin<BR>Si Temp.Reg3[1] = Nulo Entonces Informacion(Temp.Reg3[3]) Fin<BR>//Si Temp.Reg3[1] = Nulo Entonces Forma.Accion(<T>Cerrar<T>) Fin<BR>//Si Temp.Reg3[1] = Nulo Entonces ReportePantalla(<T>POSMonedero<T>) Fin<BR>Informacion(<T>Se descontara de su saldo los puntos Generados de su compra Original: <T>+Rep.Cargos)<BR><BR>//Asigna(Temp.Reg3, Nulo)<BR>Fin<BR><BR>Sino<BR>  <T><T><BR>Fin<BR>Fin       <BR>Asigna(Info.POSMonedero, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef, Nulo)
[MenuBotones.ListaEnCaptura]
(Inicio)=Info.ABC
Info.ABC=Info.Agente
Info.Agente=Info.AgenteA
Info.AgenteA=(Fin)

[Acciones.Regresa]
Nombre=Regresa
Boton=0
NombreDesplegar=<T>Regresar<T>
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





































[Acciones.Separador1]
Nombre=Separador1
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1





[Acciones.Principal1]
Nombre=Principal1
Boton=0
NombreDesplegar=<T>Principal<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado













TeclaFuncion=F1
edBotonSrc=F1.png








Expresion=BarraIrPagina(<T>Mensaje<T>,2 )
[Acciones.Regresa2]
Nombre=Regresa2
Boton=0
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





TeclaFuncion=ESC
Expresion=BarraIrPagina(<T>Mensaje<T>,1)
[Acciones.Monedero2]
Nombre=Monedero2
Boton=0
NombreDesplegar=<T>Alta Monedero<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa =:tEmpresa<T>,Empresa)=0<BR>Entonces<BR>  FormaModal(<T>POSMonedero<T>)<BR>Sino<BR>  Informacion(<T>OpciÃ³n no Disponible<T>)<BR>Fin




[Acciones.Separador2]
Nombre=Separador2
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=2
















[Acciones.Especial1_1]
Nombre=Especial1_1
Boton=0
NombreDesplegar=<T>Especial<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F2
Expresion=BarraIrPagina(<T>Mensaje<T>,3)
[Acciones.Especial2_1]
Nombre=Especial2_1
Boton=0
NombreDesplegar=<T>Bancos<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F3
Expresion=BarraIrPagina(<T>Mensaje<T>,4)
[Acciones.Especial3_1]
Nombre=Especial3_1
Boton=0
NombreDesplegar=<T>Vales<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F4.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado










TeclaFuncion=F4
Expresion=BarraIrPagina(<T>Mensaje<T>,5)
[Acciones.POSFormaPago2]
Nombre=POSFormaPago2
Boton=0
NombreDesplegar=Info.POSFormaPago2
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






edBotonSrc=F5.png
Multiple=S
ListaAccionesMultiples=(Lista)
TeclaFuncion=F5
[Cobro.ListaEnCaptura]
(Inicio)=Info.CodigoFormaPago
Info.CodigoFormaPago=Info.Referencia
Info.Referencia=Info.Importe2
Info.Importe2=Info.POSImporteRef
Info.POSImporteRef=Info.Importe
Info.Importe=(Fin)











[Acciones.Separador12]
Nombre=Separador12
Boton=0
NombreDesplegar=Separador
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1









[Acciones.POSFormaPago3]
Nombre=POSFormaPago3
Boton=0
NombreDesplegar=<T>Info.POSFormaPago3<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





Multiple=S
ListaAccionesMultiples=(Lista)
TeclaFuncion=F6
[Acciones.POSFormaPago4]
Nombre=POSFormaPago4
Boton=0
NombreDesplegar=Info.POSFormaPago4
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F7.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado









TeclaFuncion=F7
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.POSFormaPago2.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F2,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.POSFormaPago2.ActualizarForma]
Nombre=ActualizarForma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S



[Acciones.POSFormaPago5]
Nombre=POSFormaPago5
Boton=0
NombreDesplegar=Info.POSFormaPago5
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F8.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





TeclaFuncion=F8
ListaAccionesMultiples=(Lista)
[Acciones.Separador13]
Nombre=Separador13
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1

[Acciones.POSFormaPago6]
Nombre=POSFormaPago6
Boton=0
NombreDesplegar=Info.POSFormaPago6
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F9.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F9
ListaAccionesMultiples=(Lista)
[Acciones.POSFormaPago7]
Nombre=POSFormaPago7
Boton=0
NombreDesplegar=Info.POSFormaPago7
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F10.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F10
ListaAccionesMultiples=(Lista)
[Acciones.POSFormaPago8]
Nombre=POSFormaPago8
Boton=0
NombreDesplegar=Info.POSFormaPago8
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F11.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





TeclaFuncion=F11
ListaAccionesMultiples=(Lista)
[Acciones.Cobrar1]
Nombre=Cobrar1
Boton=0
NombreDesplegar=<T>Cobrar<T>
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F12.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





TeclaFuncion=F12
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.POSFormaPago3.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F3,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.POSFormaPago3.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S






[Acciones.POSFormaPago4.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F4,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.POSFormaPago4.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S


[Acciones.POSFormaPago2.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=ActualizarForma
ActualizarForma=(Fin)

[Acciones.POSFormaPago3.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar
Actualizar=(Fin)






[Acciones.POSFormaPago4.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar
Actualizar=(Fin)

[Acciones.POSFormaPago5.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F5,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.POSFormaPago5.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S


[Acciones.POSFormaPago6.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F6,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.POSFormaPago6.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S


[Acciones.POSFormaPago7.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F7,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.POSFormaPago7.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S


[Acciones.POSFormaPago8.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (F8,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>  Temp.POSMonederoL=Verdadero<BR>Entonces<BR>  Si<BR>    Info.CodigoFormaPago = Temp.POSMonederoFP<BR>  Entonces<BR>    Forma(<T>SerieTarjetaMovAplicar<T>)<BR>    Asigna(Info.POSImporteRef, SQL(<T>SELECT Importe FROM SerieTarjetaMov WHERE ID=:tid<T>,Info.IDTexto))<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.POSFormaPago8.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S



[Acciones.POSFormaPago8.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar
Actualizar=(Fin)





[Acciones.POSFormaPago5.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar
Actualizar=(Fin)





[Acciones.POSFormaPago6.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar
Actualizar=(Fin)







[Acciones.POSFormaPago7.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar
Actualizar=(Fin)





[Acciones.Cobrar1.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Cobrar1.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
Expresion=Asigna(Rep.Cargos,  Abs(SQL(<T>SELECT SUM(ISNULL(Puntos,0)) FROM POSLVenta WHERE ID=:tID<T>, Info.IDTexto) ))<BR>Asigna(Info.POSLDIError, Nulo)<BR>Asigna(Info.FormaExtra, Nulo)<BR>Asigna(Info.POSMensajeError,nulo)<BR><BR>Si<BR>  Info.MonederoCB<BR>Entonces<BR>  Asigna(Info.FormaExtra, SQL(<T>EXEC spPOSMonederoFormaAnexa :tCodigo, :tID, :tEmpresa<T>, Info.CodigoFormaPago, Info.IDTexto, Empresa))<BR>Sino<BR>  Asigna(Info.FormaExtra, SQL(<T>EXEC spPOSLDIFormaPagoFormaAnexa :tCodigo, :tID, :tEmpresa<T>, Info.CodigoFormaPago, Info.IDTexto, Empresa))<BR>Fin<BR><BR>Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa)=0<BR>Entonces<BR>  Si<BR>    Info.FormaExtra <> Nulo<BR>  Entonces<BR>    FormaModal(Info.FormaExtra)<BR>  Fin<BR>Fin<BR><BR>Si<BR>  Info.MonederoCB y ConDatos(Info.POSMonedero)<BR>Entonces<BR>  Asigna(Info.POSMensajeError,SQL(<T>EXEC spPOSMonederoRedimir :tEmpresa, :tMonedero, :nImporte, :tUsuario, :nEstacion, :nSucursal, :tID<T>, Empresa, Info.POSMonedero, Info.POSImporteRef, Usuario, EstacionTrabajo, Sucursal, Info.IDTexto ))<BR>  Asigna(Info.POSMonedero,nulo)<BR>  Si<BR>    ConDatos(Info.POSMensajeError)<BR>  Entonces<BR>    Asigna(Info.POSMonedero,nulo)<BR>    Asigna(Info.POSImporteRef,0)<BR>    Asigna(Info.Importe,0)<BR>    ERROR(Info.POSMensajeError)<BR>  Sino<BR>    Informacion(<T>CARGO REALIZADO CON ÉXITO<T>)<BR>  Fin<BR>Fin<BR><BR>Asigna(Info.FormaExtra, Nulo)<BR><BR>Asigna(Info.Codigo, Info.CodigoFormaPago)<BR>Asigna(Info.CodigoFormaPago, Nulo)<BR><BR>Si<BR>  Info.POSLDIError <> Nulo<BR>Entonces<BR>  Asigna(Info.Codigo, Nulo)<BR>Fin<BR><BR>Si<BR>  Condatos(Info.POSMensajeError)<BR>Entonces<BR>  Asigna(Info.Codigo, Nulo)<BR>Fin<BR><BR>Asigna(Rep.Cargos,  Abs(SQL(<T>SELECT SUM(ISNULL(Puntos,0)) FROM POSLVenta WHERE ID=:tID<T>, Info.IDTexto) ))<BR>Si<BR>  Info.MonederoCB<BR>Entonces<BR>  Asigna(Rep.Cargos, nulo)<BR>Fin<BR><BR>Si<BR>  Info.POSMonedero <> Nulo<BR>Entonces<BR> Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, 0, Nulo,Nulo, 0, Nulo, Nulo, Info.POSMonedero))<BR>Fin<BR><BR>Asigna(Info.FormaExtra,Temp.Reg[13])<BR>Asigna(Info.Servicio,Temp.Reg[12])<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero, Info.POSImporteRef))<BR><BR>Asigna(Info.Saldo, Temp.Reg[9])<BR><BR><BR>Si<BR>  (Info.Saldo = 0) y (Info.FormaExtra <> Nulo) y (Info.Servicio <> Nulo)<BR>Entonces<BR>  FormaModal(Info.FormaExtra)<BR>Fin<BR><BR>Si Ver.Cambio noen(0, <T>$0.00<T>) Entonces Informacion(<T>Cambio: <T> & Ver.Cambio) Fin<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
EjecucionCondicion=((Ver.Cambio en(0, <T>$0.00<T>))<BR>o (ConDatos(Info.FormaPagoCambio))) y (Info.Importe <> 0)
[Acciones.Cobrar1.Devolucion]
Nombre=Devolucion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  Info.MonederoCB<BR>Entonces<BR>  Asigna(Info.POSMonedero,nulo)<BR>Fin<BR>Si<BR>  ConDatos(Info.POSMonedero)<BR>Entonces<BR>  Si<BR>    Info.POSImporteRef < 0<BR>  Entonces<BR>    Asigna(Temp.Logico,SQL(<T>SELECT ISNULL(MonederoLDI,0) FROM POSCfg pc   WHERE Empresa =:tEmpresa<T>,Empresa))<BR>    Si<BR>      Temp.Logico<BR>    Entonces<BR>      Asigna(Temp.Reg3, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero, :tEmpresa, :tUsuario, :nSucursal, :nMonRemp, :nCargo<T>, <T>MON CARGO<T>, Info.IDTexto, Info.POSMonedero,Empresa, Usuario, Sucursal, nulo, Rep.Cargos))<BR>      Si<BR>        Temp.Reg3[1] <> Nulo<BR>      Entonces<BR>        Error(Temp.Reg3[2])<BR>      Fin<BR>      Si<BR>        Temp.Reg3[1] = Nulo<BR>      Entonces<BR>        Informacion(Temp.Reg3[3])<BR>      Fin<BR>      Informacion(<T>Se descontara de su saldo los puntos Generados de su compra Original: <T>+Rep.Cargos)<BR>    Fin<BR>  Fin<BR>Fin<BR>Asigna(Info.POSMonedero, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef, Nulo)
[Acciones.Cobrar1.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S











ConCondicion=S





EjecucionCondicion=Info.Saldo <= 0








[Acciones.Cobrar1.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=Devolucion
Devolucion=Cerrar
Cerrar=(Fin)



[Acciones.Regresa3]
Nombre=Regresa3
Boton=0
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=BarraIrPagina(<T>Mensaje<T>,1) 









[Acciones.BancosA01]
Nombre=BancosA01
Boton=0
TeclaFuncion=F1
NombreDesplegar=Info.BancoA01
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosA02]
Nombre=BancosA02
Boton=0
NombreDesplegar=Info.BancoA02
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=$00C08000
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





TeclaFuncion=F2
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.Separador3]
Nombre=Separador3
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=3





[Acciones.BancosA03]
Nombre=BancosA03
Boton=0
NombreDesplegar=Info.BancoA03
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F3

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin



[Acciones.BancosA04]
Nombre=BancosA04
Boton=0
TeclaFuncion=F4
NombreDesplegar=Info.BancoA04
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F4.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin





[Acciones.Separador32]
Nombre=Separador32
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=3

[Acciones.BancosA05]
Nombre=BancosA05
Boton=0
NombreDesplegar=Info.BancoA05
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F5.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F5
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosA06]
Nombre=BancosA06
Boton=0
NombreDesplegar=Info.BancoA06
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F6
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosA07]
Nombre=BancosA07
Boton=0
TeclaFuncion=F7
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F7.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosA08]
Nombre=BancosA08
Boton=0
NombreDesplegar=Info.BancoA08
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F8.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
TeclaFuncion=F8
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoA08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin





[Acciones.Regresa4]
Nombre=Regresa4
Boton=0
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
Expresion=BarraIrPagina(<T>Mensaje<T>,1) 

[Acciones.Separador4]
Nombre=Separador4
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=4

[Acciones.BancosB01]
Nombre=BancosB01
Boton=0
TeclaFuncion=F1
NombreDesplegar=Info.BancoB01
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin





[Acciones.BancosB02]
Nombre=BancosB02
Boton=0
TeclaFuncion=F2
NombreDesplegar=Info.BancoB02
TipoAccion=Expresion
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





[Acciones.BancosB03]
Nombre=BancosB03
Boton=0
TeclaFuncion=F3
NombreDesplegar=Info.BancoB03
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosB04]
Nombre=BancosB04
Boton=0
TeclaFuncion=F4
NombreDesplegar=Info.BancoB04
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F4.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.Separador42]
Nombre=Separador42
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=4

[Acciones.BancosB05]
Nombre=BancosB05
Boton=0
TeclaFuncion=F5
NombreDesplegar=Info.BancoB05
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F5.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosB06]
Nombre=BancosB06
Boton=0
TeclaFuncion=F6
NombreDesplegar=Info.BancoB06
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosB07]
Nombre=BancosB07
Boton=0
TeclaFuncion=F7
NombreDesplegar=Info.BancoB07
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F7.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosB08]
Nombre=BancosB08
Boton=0
TeclaFuncion=F8
NombreDesplegar=Info.BancoB08
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F8.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoB08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opcion Vacia<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin




[Acciones.Regresa5]
Nombre=Regresa5
Boton=0
TeclaFuncion=ESC
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=BarraIrPagina(<T>Mensaje<T>,1) 









[Acciones.BancosC01]
Nombre=BancosC01
Boton=0
NombreDesplegar=Info.BancosC01

Activo=S
Visible=S
BarraBtnFondo=$00C08000
TipoAccion=Expresion
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC01,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opción Vacía<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosC01.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualiza
Actualiza=(Fin)





[Acciones.BancosC02]
Nombre=BancosC02
Boton=0
TeclaFuncion=F2
NombreDesplegar=Info.BancosC02
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC02,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opción Vacía<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosC03]
Nombre=BancosC03
Boton=0
NombreDesplegar=Info.BancosC03
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F3.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC03,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opción Vacía<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosC04]
Nombre=BancosC04
Boton=0
TeclaFuncion=F4
NombreDesplegar=Info.BancosC04
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F4.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC04,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opción Vacía<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.Separador5]
Nombre=Separador5
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=5

[Acciones.BancosC06]
Nombre=BancosC06
Boton=0
TeclaFuncion=F6
NombreDesplegar=Info.BancosC06
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC06,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opción Vacía<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosC07]
Nombre=BancosC07
Boton=0
TeclaFuncion=F7
NombreDesplegar=Info.BancosC07
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F7.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC07,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opción Vacía<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosC05]
Nombre=BancosC05
Boton=0
TeclaFuncion=F5
NombreDesplegar=Info.BancosC05
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F5.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC05,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opción Vacía<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.BancosC08]
Nombre=BancosC08
Boton=0
TeclaFuncion=F8
NombreDesplegar=Info.BancosC08
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F8.png
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT NULLIF (BancoC08,:tVacio) FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>, <T> <T>,Sucursal))<BR><BR>Si<BR>   Info.CodigoFormaPago = nulo<BR>Entonces<BR>  Asigna(Info.CodigoFormaPago, Temp.TextoTemp02)<BR>  Precaucion(<T>Opción Vacía<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Cobro<T>, <T>Info.POSImporteRef<T>)<BR>Fin
[Acciones.Separador52]
Nombre=Separador52
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=5





[Mensaje.ListaAccionesBB]
(Inicio)=Regresa
Regresa=Separador1
Separador1=Principal1
Principal1=Especial1_1
Especial1_1=Especial2_1
Especial2_1=Especial3_1
Especial3_1=Separador12
Separador12=POSFormaPago2
POSFormaPago2=POSFormaPago3
POSFormaPago3=POSFormaPago4
POSFormaPago4=POSFormaPago5
POSFormaPago5=Separador13
Separador13=POSFormaPago6
POSFormaPago6=POSFormaPago7
POSFormaPago7=POSFormaPago8
POSFormaPago8=Cobrar1
Cobrar1=Regresa2
Regresa2=Separador2
Separador2=Monedero2
Monedero2=Regresa3
Regresa3=Separador3
Separador3=BancosA01
BancosA01=BancosA02
BancosA02=BancosA03
BancosA03=BancosA04
BancosA04=Separador32
Separador32=BancosA05
BancosA05=BancosA06
BancosA06=BancosA07
BancosA07=BancosA08
BancosA08=Regresa4
Regresa4=Separador4
Separador4=BancosB01
BancosB01=BancosB02
BancosB02=BancosB03
BancosB03=BancosB04
BancosB04=Separador42
Separador42=BancosB05
BancosB05=BancosB06
BancosB06=BancosB07
BancosB07=BancosB08
BancosB08=Regresa5
Regresa5=Separador5
Separador5=BancosC01
BancosC01=BancosC02
BancosC02=BancosC03
BancosC03=BancosC04
BancosC04=Separador52
Separador52=BancosC05
BancosC05=BancosC06
BancosC06=BancosC07
BancosC07=BancosC08
BancosC08=(Fin)






[Forma.MenuPrincipal]
(Inicio)=Principal
Principal=Especial 1
Especial 1=Especial 2
Especial 2=Especial 3
Especial 3=(Fin)

















[Acciones.F2.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.F3.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=(Fin)



[Acciones.F4.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=(Fin)



[Acciones.F5.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=(Fin)



[Acciones.F6.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=(Fin)



[Acciones.F7.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=(Fin)




[Acciones.CalculaImporteRef.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)



[Acciones.F8.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=(Fin)



[Acciones.Enter.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=Devolucion
Devolucion=Cerrar
Cerrar=(Fin)

























































[Forma.ListaCarpetas]
(Inicio)=Cobro
Cobro=Mensaje
Mensaje=(Fin)

[Forma.ListaAcciones]
(Inicio)=F2
F2=F3
F3=F4
F4=F5
F5=F6
F6=F7
F7=F8
F8=CalculaImporteRef
CalculaImporteRef=Enter
Enter=Monedero
Monedero=BancoA01
BancoA01=BancoA02
BancoA02=BancoA03
BancoA03=BancoA04
BancoA04=BancoA05
BancoA05=BancoA06
BancoA06=BancoA07
BancoA07=BancoA08
BancoA08=BancoB01
BancoB01=BancoB02
BancoB02=BancoB03
BancoB03=BancoB04
BancoB04=BancoB05
BancoB05=BancoB06
BancoB06=BancoB07
BancoB07=BancoB08
BancoB08=BancoC01
BancoC01=BancoC02
BancoC02=BancoC03
BancoC03=BancoC04
BancoC04=BancoC05
BancoC05=BancoC06
BancoC06=BancoC07
BancoC07=BancoC08
BancoC08=(Fin)
