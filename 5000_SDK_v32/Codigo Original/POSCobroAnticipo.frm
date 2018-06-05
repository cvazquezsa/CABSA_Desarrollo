

[Forma]
Clave=POSCobroAnticipo
Icono=0
Modulos=(Todos)
Nombre=POS Cobro Anticipo

ListaCarpetas=(Lista)
CarpetaPrincipal=Cobro
BarraAcciones=S
AccionesTamanoBoton=100x5
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=202
PosicionInicialArriba=113
PosicionInicialAlturaCliente=499
PosicionInicialAncho=885
PosicionCol1=449




ListaAcciones=(Lista)
PosicionSec1=106
PosicionSec2=457
VentanaEscCerrar=S
PosicionCol3=449
AccionesCentro=S
AccionesDivision=S
MenuTouchScreen=S
Menus=S
MenuTouchScreenMostrarTeclasFuncion=S
PosicionCol2=449
EsConsultaExclusiva=S
ExpresionesAlMostrar=Asigna(Ver.FormasPago, TextoEnLista(SQL(<T>EXEC spPOSMuestraFormasPago<T>)))<BR>Asigna(Info.POSImporteOferta,TextoEnLista(SQL(<T>spPOSMuestraOfertasFormasPago :tID,:tEmpresa,:nSucursal, :nEstacion<T>,Info.IDTexto,Empresa,Sucursal,  EstacionTrabajo )))<BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))  <BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Aviso,Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef, Info.Importe)<BR>Asigna(Info.CodigoFormaPago, Nulo)<BR>Asigna(Ver.Cambio, $0.00)<BR>Asigna(Info.Cambio, 0)<BR>Asigna(Info.FormaPagoCambio, SQL(<T>SELECT DefFormaPagoCambio FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Info.POSTipoCambioSuc,1)<BR>Asigna(Info.TorretaMensaje1,<T>IMPORTE  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Importe,Empresa))<BR>Asigna(Info.TorretaPosicion1,<T>Derecha<T>)<BR>Asigna(Info.TorretaMensaje2,<T>SALDO  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha<T>)<BR>Asigna(Info.Importe2,Info.Importe)<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR>                                                                                                    <BR><BR><BR>Asigna(Info.POSFormaPago2,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F2 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago3,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F3 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago4,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F4 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago5,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F5 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago6,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F6 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago7,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F7 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))<BR>Asigna(Info.POSFormaPago8,SQL(<T>SELECT ISNULL(c.FormaPago,:tVacio) FROM POSCobroFormasPago f LEFT JOIN CB c ON c.Codigo = f.F8 AND c.TipoCuenta = :tTipoCta WHERE f.Sucursal = :nSucursal<T>,<T>  <T>, <T>Forma Pago<T> ,Sucursal))
ExpresionesAlActivar=Asigna(Info.Codigo, Nulo)
[POSCobro.ListaEnCaptura]
(Inicio)=Ver.Total
Ver.Total=Info.Codigo
Info.Codigo=Info.Saldo
Info.Saldo=(Fin)




[Cobro]
Estilo=Ficha
Clave=Cobro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=(Variables)
ConFuenteEspecial=S
Fuente={Tahoma, 20, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
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
EnMenu=S
TeclaFuncion=F12
[Cobro.Info.Importe]
Carpeta=Cobro
Clave=Info.Importe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata








AccionAlEnter=CalculaCambio
EspacioPrevio=N
Pegado=N
[Saldo]
Estilo=Ficha
Clave=Saldo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 48, Negro, []}
CampoColorLetras=Rojo obscuro
CampoColorFondo=$00FFE8E8
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
ColorFondo=$00FFE8E8





















ColorFuente=Rojo obscuro
[Cobro.Info.Referencia]
Carpeta=Cobro
Clave=Info.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=$00FFE8E8













AccionAlEnter=












IgnoraFlujo=N

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











Expresion=Asigna(Ver.Cambio, SQL(<T>EXEC spPOSCalculaCambio :nSaldo, :tEmpresa, :nImporte, :tFPCodigo, :nSuc<T>, Info.Saldo,Empresa, Info.Importe, Info.FormaPagoCambio, Sucursal))<BR>Asigna(Info.Cambio, SQL(<T>EXEC spPOSCalculaCambioCalc :nSaldo, :tEmpresa, :nImporte, :nMostrar<T>, Info.Saldo, Empresa, Info.Importe, 1))
[Cambio.Ver.Cambio]
Carpeta=Cambio
Clave=Ver.Cambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=14
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


[Acciones.Enter.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S








































ConCondicion=S




















Expresion=forma.Accion(<T>CalculaCambio<T>)<BR>forma.Accion(<T>CalculaImporteRef<T>)<BR>Asigna(Info.POSImporteOferta,Nulo)  <BR>Asigna(Info.POSLDIError, Nulo)<BR>Asigna(Info.FormaExtra, Nulo)<BR>Asigna(Info.VFAFormaPago, SQL(<T>EXEC spPOSVFAFormaPago :tCodigo, :tID<T>, Info.CodigoFormaPago, Info.IDTexto))<BR>Asigna(Info.FormaExtra, SQL(<T>EXEC spPOSLDIFormaPagoFormaAnexa :tCodigo, :tID, :tEmpresa<T>, Info.CodigoFormaPago, Info.IDTexto, Empresa))<BR> Si Info.FormaExtra <> Nulo   y    vacio(Info.POSMonedero)<BR> Entonces FormaModal(<T>POSCobroMonedero<T>) Fin<BR>Si<BR>  ConDatos(Info.VFAFormaPago)<BR>Entonces<BR>  VFA.Cargo(<T>POS<T>, Info.IDTexto,<T>2048<T>,Info.Referencia,Info.Importe)<BR>  Asigna(Temp.Reg2, SQL(<T>spPOSVFAVerificar :tID<T>,Info.IDTexto))<BR>  Asigna(Info.POSVFAError,Temp.Reg2[1])<BR>  Asigna(Info.POSVFAMensajeError,Temp.Reg2[2])<BR>  Asigna(Info.Importe,Temp.Reg2[3])<BR>                                                              <BR>Fin<BR>Si<BR>  ConDatos(Info.POSVFAError)<BR>Entonces<BR>  Error(Info.POSVFAMensajeError)<BR>  Asigna(Info.Codigo,Nulo)<BR>Fin<BR>Asigna(Info.FormaExtra, Nulo)<BR><BR>Asigna(Info.Codigo, Info.CodigoFormaPago)<BR>Asigna(Info.CodigoFormaPago, Nulo)<BR><BR>Si Info.POSLDIError <> Nulo Entonces Asigna(Info.Codigo, Nulo) Fin<BR><BR>/*Verifica si hay un servicio en este movimiento*/<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, 0, Nulo,Nulo, 0, Nulo, Nulo, Info.POSMonedero))<BR>Asigna(Info.FormaExtra,Temp.Reg[13])<BR>Asigna(Info.Servicio,Temp.Reg[12])<BR><BR><BR>/* Aqui se ejecuta el SPPOS para cobrar */<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero, Info.POSImporteRef))<BR><BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))<BR><BR>/* Aqui se ejecuta la forma en caso que el servicio tenga configurada una forma y ya se vaya a cobrar la nota */<BR>  Si (Info.Saldo = 0) y (Info.FormaExtra <> Nulo)  y (Info.Servicio <> Nulo) Entonces FormaModal(Info.FormaExtra) Fin<BR>Asigna(Info.TorretaMensaje1,<T>IMPORTE  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Importe2,Empresa))<BR>Asigna(Info.TorretaPosicion1,<T>Derecha<T>)<BR>Asigna(Info.TorretaMensaje2,<T>SALDO  <T>+SQL(<T>SELECT dbo.fnFormatoMoneda(:nImporte,:tEmpresa)<T>,Info.Saldo,Empresa))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha  <T>)<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR>//Si Info.Cambio noen(0, <T>$0.00<T>) Entonces Informacion(<T>Cambio: <T> & Ver.Cambio) Fin<BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.POSMonedero, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.POSImporteRef, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))                                    <BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Si Info.Cambio noen(0, <T>$0.00<T>) Entonces Asigna(Info.Mensaje,<T>Cambio: <T> & Ver.Cambio)<BR><BR>Fin
EjecucionCondicion=(Info.Cambio en(0, <T>$0.00<T>))<BR>o (ConDatos(Info.FormaPagoCambio) y (Info.Importe = 0)y (Info.Saldo = 0))<BR>o (ConDatos(Info.FormaPagoCambio) y (Info.Importe > 0)y (Info.Saldo > 0))
[Cambio.ListaEnCaptura]
(Inicio)=Ver.Cambio
Ver.Cambio=Ver.Aviso
Ver.Aviso=(Fin)








[Mensaje.Ver.Aviso]
Carpeta=Mensaje
Clave=Ver.Aviso
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=38x5
ColorFondo=$00C6FFFF



























ColorFuente=Rojo
[Cobro.Info.CodigoFormaPago]
Carpeta=Cobro
Clave=Info.CodigoFormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
AccionAlEnter=CalculaImporteRefPrevio
Tamano=14
ColorFondo=$00FFE8E8








EspacioPrevio=S

ColorFuente=Rojo obscuro
[Acciones.Monedero]
Nombre=Monedero
Boton=0
NombreEnBoton=S
TeclaFuncion=F9
NombreDesplegar=&Alta Monedero
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S























Expresion=FormaModal(<T>POSMonedero<T>)<BR>Forma.Accion(<T>CalculaImporteRefPrevio<T>)
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





Expresion=Asigna(Info.Importe, SQL(<T>EXEC spPOSImporteRefCalc :nSuc, :nImporteRef, :tCodigoFP,:tEmpresa<T>, Sucursal, Info.POSImporteRef, Info.CodigoFormaPago,Empresa))
[FormasPago.Ver.FormasPago]
Carpeta=FormasPago
Clave=Ver.FormasPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=$00C6FFFF
























































AccionAlEnter=
[Cobro.Info.POSImporteRef]
Carpeta=Cobro
Clave=Info.POSImporteRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=$00FFE8E8




AccionAlEnter=CalculaImporteRef








ColorFuente=Rojo obscuro
[Cobro.Info.POSTipoCambioSuc]
Carpeta=Cobro
Clave=Info.POSTipoCambioSuc
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata









[Acciones.ActualizaRedondeo.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)




[Acciones.CalculaImporteRefPrevio]
Nombre=CalculaImporteRefPrevio
Boton=0
Multiple=S
Activo=S
Visible=S



ListaAccionesMultiples=(Lista)

[Acciones.CalculaImporteRefPrevio.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.CalculaImporteRefPrevio.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S










Expresion=Asigna(Info.POSImporteRef,0.0)<BR>Asigna(Info.Moneda,SQL(<T>SELECT f.Moneda FROM FormaPago f JOIN CB c ON c.FormaPago=f.FormaPago  WHERE c.Codigo =:tCodigo<T>,Info.CodigoFormaPago))<BR>Asigna(Info.POSTipoCambioSuc, SQL(<T>SELECT TipoCambio FROM POSLTipoCambioRef WHERE Sucursal = :nSuc AND Moneda = :tMoneda<T>, Sucursal,Info.Moneda))<BR>Asigna(Info.POSTipoCambioSuc,  Redondea( Info.POSTipoCambioSuc,Info.Ano))<BR>SI(Vacio(Info.POSTipoCambioSuc),Asigna(Info.POSTipoCambioSuc,1))<BR>Asigna(Info.Importe, SQL(<T>EXEC spPOSImporteRefCalc :nSuc, :nImporteRef, :tCodigoFP,:tEmpresa<T>, Sucursal, Info.POSImporteRef, Info.CodigoFormaPago,Empresa))
[VentaCobro.Ver.Cobro]
Carpeta=VentaCobro
Clave=Ver.Cobro
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=60x10
ColorFondo=$00C6FFFF









[Acciones.F2]
Nombre=F2
Boton=0
TeclaFuncion=F2
NombreDesplegar=Info.POSFormaPago2
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT F2 FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>,Sucursal))
[Acciones.F3]
Nombre=F3
Boton=0
TeclaFuncion=F3
NombreDesplegar=Info.POSFormaPago3
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT F3 FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>,Sucursal))
[Acciones.F4]
Nombre=F4
Boton=0
TeclaFuncion=F4
NombreDesplegar=Info.POSFormaPago4
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT F4  FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>,Sucursal))
[Acciones.F5]
Nombre=F5
Boton=0
TeclaFuncion=F5
NombreDesplegar=Info.POSFormaPago5
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



























































































Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT F5  FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>,Sucursal))

[Acciones.F6]
Nombre=F6
Boton=0
NombreDesplegar=Info.POSFormaPago6
EnMenu=S
TipoAccion=Expresion
Visible=S



TeclaFuncion=F6




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT F6  FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>,Sucursal))
Activo=S
[Acciones.F7]
Nombre=F7
Boton=0
NombreDesplegar=Info.POSFormaPago7
EnMenu=S
TipoAccion=Expresion
Visible=S

TeclaFuncion=F7




Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT F7  FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>,Sucursal))
Activo=S
[Acciones.F8]
Nombre=F8
Boton=0
TeclaFuncion=F8
NombreDesplegar=Info.POSFormaPago8
EnMenu=S
TipoAccion=Expresion
Visible=S





























































Expresion=Asigna(Info.CodigoFormaPago,SQL(<T>SELECT F8 FROM POSCobroFormasPago  WHERE Sucursal = :nSucursal<T>,Sucursal))
Activo=S




[Acciones.CalculaCambio.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)







[VentaCobro.Info.POSImporteOferta]
Carpeta=VentaCobro
Clave=Info.POSImporteOferta
Editar=S
LineaNueva=S
3D=S
Tamano=60x10
ColorFondo=$00BBFFFF
























[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
TeclaFuncion=F10
NombreDesplegar=Cancelar Partida
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=Asigna(Temp.Reg5,SQL(<T>spPOSCancelarPartidaCobro :nEstacion, :tID<T>,EstacionTrabajo,Info.IDTexto))<BR><BR>Asigna(Ver.Cobro, TextoEnLista(SQL(<T>EXEC spPOSMuestraVentaCobro :tID<T>, Info.IDTexto)))<BR>Asigna(Temp.Reg4,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg4[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg4[5]))<BR>Asigna(Ver.Total, Temp.Reg4[8])<BR>Asigna(Info.Saldo, Temp.Reg4[9])<BR>Asigna(Info.Importe, Temp.Reg4[9])<BR>Asigna(Ver.Saldo, Temp.Reg4[9])<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg5[2]))


[VentaCobro.ListaEnCaptura]
(Inicio)=Ver.Cobro
Ver.Cobro=Info.POSImporteOferta
Info.POSImporteOferta=(Fin)










[Pagado]
Estilo=Ficha
Clave=Pagado
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Rojo obscuro
CampoColorFondo=$00FFE8E8
ListaEnCaptura=Ver.Cobro
CarpetaVisible=S
AlinearTodaCarpeta=S

ConFuenteEspecial=S
[Pagado.Ver.Cobro]
Carpeta=Pagado
Clave=Ver.Cobro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$00FFE8E8
ColorFuente=Rojo obscuro















[Cobro.ListaEnCaptura]
(Inicio)=Info.POSTipoCambioSuc
Info.POSTipoCambioSuc=Info.CodigoFormaPago
Info.CodigoFormaPago=Info.Referencia
Info.Referencia=Info.POSImporteRef
Info.POSImporteRef=Info.Importe
Info.Importe=(Fin)



[Acciones.CalculaImporteRef.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)






[Acciones.CalculaImporteRefPrevio.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)











[Acciones.Enter.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=Cerrar
Cerrar=(Fin)





[Forma.ListaCarpetas]
(Inicio)=Saldo
Saldo=Cobro
Cobro=Pagado
Pagado=(Fin)

[Forma.ListaAcciones]
(Inicio)=CalculaImporteRefPrevio
CalculaImporteRefPrevio=CalculaImporteRef
CalculaImporteRef=Enter
Enter=Monedero
Monedero=F2
F2=F3
F3=F4
F4=F5
F5=F6
F6=F7
F7=F8
F8=Cancelar
Cancelar=(Fin)
