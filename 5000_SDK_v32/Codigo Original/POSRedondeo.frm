
[Forma]
Clave=POSRedondeo
Icono=0
Modulos=(Todos)
Nombre=Redondeo

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialAlturaCliente=189
PosicionInicialAncho=384
VentanaTipoMarco=Chico
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=576
PosicionInicialArriba=298
PosicionSec1=280
PosicionSec2=442
PosicionCol1=430
PosicionCol3=449
PosicionCol2=449
VentanaEscCerrar=S
VentanaExclusiva=S
VentanaExclusivaOpcion=0


VentanaColor=$00804000
VentanaSinIconosMarco=S
VentanaCarpetasSinBordes=S
ExpresionesAlMostrar=Asigna(Temp.Reg5[9], nulo)<BR>ActualizarForma<BR>ActualizarVista
ExpresionesAlCerrar=FormaModal(<T>POSCobro<T>)<BR>Asigna(Info.POSRedondeo, nulo)<BR>Asigna(Info.Importe, nulo)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Segoe UI, 20, Blanco, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Rojo obscuro
CampoColorFondo=$00FFE8E8
ListaEnCaptura=(Lista)

CarpetaVisible=S

AlinearTodaCarpeta=S
ConFuenteEspecial=S
BarraBotones=S
BarraBtnFuente={Segoe UI, 16, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnSize=80
BarraBtnPosicion=Abajo
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=1
ListaAccionesBB=(Lista)
[(Variables).Info.POSRedondeo]
Carpeta=(Variables)
Clave=Info.POSRedondeo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=$00FFE8E8
AccionAlEnter=
ColorFuente=Rojo obscuro
EditarConBloqueo=S
AccionAlEnterBloquearAvance=N

[(Variables).Info.Importe]
Carpeta=(Variables)
Clave=Info.Importe
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
Editar=N


[Acciones.InsertarRedondeo.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S
Expresion=Si Info.POSRedondeo > 0<BR>Entonces<BR>EjecutarSQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo, :nImporte<T>, Info.IDTexto, <T>INSERTAR<T>, Info.POSRedondeo)<BR><BR>Sino<BR>Asigna(Info.POSRedondeo, Info.POSRedondeo)<BR>Fin<BR><BR>Asigna(Info.Importe, Info.Importe + Info.POSRedondeo)<BR>Asigna(Info.POSImporteRef, Info.POSImporteRef + Info.POSRedondeo)<BR><BR>Asigna(Info.Saldo, Info.Saldo + Info.POSRedondeo)<BR>Asigna(Ver.Saldo, <T>$<T> & SQL(<T>SELECT CONVERT(varchar,CONVERT(money, :nSaldo) ,101)<T>, Info.Saldo))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Imagen,Temp.Reg[11])
EjecucionCondicion=Info.POSRedondeo<99999
EjecucionMensaje=<T>El Redondeo debe de ser menor a 99999 <T>


[Acciones.InsertarRedondeo.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



[Acciones.EliminarRedondeo.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.POSRedondeo,0)<BR>EjecutarSQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo, :nImporte<T>, Info.IDTexto, <T>ELIMINAR<T>, 0)<BR><BR>Asigna(Temp.Reg5, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Nulo, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero,Nulo))<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg5[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg5[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg5[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg5[6]))<BR>Asigna(Ver.Total, Temp.Reg5[8])<BR>Asigna(Info.Saldo, Temp.Reg5[9])<BR>Asigna(Info.Importe, Temp.Reg5[9])<BR>Asigna(Ver.Saldo, Temp.Reg5[9])<BR>Asigna(Info.POSRedondeo,0)


[Acciones.EliminarRedondeo.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.InsertaRed.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Si Info.POSRedondeo > 0<BR>Entonces<BR>EjecutarSQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo, :nImporte<T>, Info.IDTexto, <T>INSERTAR<T>, Info.POSRedondeo)<BR><BR>Sino<BR>Asigna(Info.POSRedondeo, Info.POSRedondeo)<BR>Fin<BR><BR>Asigna(Info.Importe, Info.Importe + Info.POSRedondeo)<BR>Asigna(Info.POSImporteRef, Info.POSImporteRef + Info.POSRedondeo)<BR><BR>Asigna(Info.Saldo, Info.Saldo + Info.POSRedondeo)<BR>Asigna(Ver.Saldo, <T>$<T> & SQL(<T>SELECT CONVERT(varchar,CONVERT(money, :nSaldo) ,101)<T>, Info.Saldo))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>FormaModal(<T>POSCobro<T>)
Activo=S
Visible=S


[Acciones.InsertaRed.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)


[Acciones.InsertarRedondeo.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S



[Acciones.InsertaRed.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






[Acciones.EliminarRedondeo.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)








[Acciones.InsertarRedondeo.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Cerrar
Cerrar=(Fin)














[Acciones.AgregaRedondeo]
Nombre=AgregaRedondeo
Boton=0
NombreDesplegar=<T>SI<T>
Activo=S
Visible=S
BarraBtnFondo=$00C08000

NombreEnBoton=S
BarraBtnAncho=72
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
Multiple=S
ListaAccionesMultiples=(Lista)
TeclaFuncion=F1
edBotonSrc=F1.png
[Acciones.EliminaRedondeo]
Nombre=EliminaRedondeo
Boton=0
NombreDesplegar=<T>NO<T>
Activo=S
Visible=S
BarraBtnFondo=$00C08000

NombreEnBoton=S
BarraBtnAncho=72
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F2
edBotonSrc=F2.png
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.AgregaRedondeo.Variable]
Nombre=Variable
Boton=0
NombreDesplegar=Variables
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.AgregaRedondeo.Agrega]
Nombre=Agrega
Boton=0
NombreDesplegar=Agregar
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si Info.POSRedondeo > 0<BR>Entonces<BR>EjecutarSQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo, :nImporte<T>, Info.IDTexto, <T>INSERTAR<T>, Info.POSRedondeo)<BR><BR>Sino<BR>Asigna(Info.POSRedondeo, Info.POSRedondeo)<BR>Fin<BR><BR>Asigna(Info.Importe, Info.Importe + Info.POSRedondeo)<BR>Asigna(Info.POSImporteRef, Info.POSImporteRef + Info.POSRedondeo)<BR><BR>Asigna(Info.Saldo, Info.Saldo + Info.POSRedondeo)<BR>Asigna(Ver.Saldo, <T>$<T> & SQL(<T>SELECT CONVERT(varchar,CONVERT(money, :nSaldo) ,101)<T>, Info.Saldo))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Imagen,Temp.Reg[11])
ConCondicion=S
EjecucionCondicion=Info.POSRedondeo<99999   
EjecucionMensaje=<T>El Redondeo debe de ser menor a 99999 <T>
EjecucionConError=S
[Acciones.AgregaRedondeo.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=Cerrar
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S






[Acciones.Espacio]
Nombre=Espacio
Boton=0
NombreDesplegar=<T>Espacio<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=110
BarraBtnAlto=80
BarraBtnFondo=Negro
BarraBtnPagina=1




[Acciones.Separador]
Nombre=Separador
Boton=0
NombreDesplegar=<T>Separado<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=10
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1

















[Acciones.EliminaRedondeo.Elimina]
Nombre=Elimina
Boton=0
NombreDesplegar=Elimina
TipoAccion=Expresion
Expresion=Asigna(Info.POSRedondeo,0)<BR>EjecutarSQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo, :nImporte<T>, Info.IDTexto, <T>ELIMINAR<T>, 0)<BR><BR>Asigna(Temp.Reg5, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Nulo, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero,Nulo))<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg5[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg5[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg5[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg5[6]))<BR>Asigna(Ver.Total, Temp.Reg5[8])<BR>Asigna(Info.Saldo, Temp.Reg5[9])<BR>Asigna(Info.Importe, Temp.Reg5[9])<BR>Asigna(Ver.Saldo, Temp.Reg5[9])<BR>Asigna(Info.POSRedondeo,0)
Activo=S
Visible=S

[Acciones.EliminaRedondeo.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=Cerrar
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Forma.ListaAcciones]
(Inicio)=InsertarRedondeo
InsertarRedondeo=EliminarRedondeo
EliminarRedondeo=(Fin)

















[Acciones.AgregaRedondeo.ListaAccionesMultiples]
(Inicio)=Variable
Variable=Agrega
Agrega=Cerrar
Cerrar=(Fin)

[Acciones.EliminaRedondeo.ListaAccionesMultiples]
(Inicio)=Elimina
Elimina=Cerrar
Cerrar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.POSRedondeo
Info.POSRedondeo=Info.Importe
Info.Importe=(Fin)

[(Variables).ListaAccionesBB]
(Inicio)=Espacio
Espacio=AgregaRedondeo
AgregaRedondeo=Separador
Separador=EliminaRedondeo
EliminaRedondeo=(Fin)
