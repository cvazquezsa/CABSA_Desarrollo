
[Forma]
Clave=POSRedondeoCobro
Icono=0
Modulos=(Todos)
Nombre=Redondeo

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialAlturaCliente=140
PosicionInicialAncho=810
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=278
PosicionInicialArriba=274
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
MenuTouchScreen=S
PosicionSec1=106
PosicionSec2=520
PosicionCol1=449
PosicionCol3=449
PosicionCol2=449
ExpresionesAlMostrar=Asigna(Info.POSRedondeo2, SQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo, :nImporte<T>, Info.IDTexto, <T>SUGERIR COBRO<T>, Info.Importe))
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 20, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

AlinearTodaCarpeta=S
ConFuenteEspecial=S
[(Variables).Info.POSRedondeo2]
Carpeta=(Variables)
Clave=Info.POSRedondeo2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

AccionAlEnter=
[(Variables).Info.Importe]
Carpeta=(Variables)
Clave=Info.Importe
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata







[Acciones.InsertarRedondeo.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S
Expresion=Forma.VariablesAplicar   <BR>Si Info.POSRedondeo2 > 0<BR>Entonces<BR>EjecutarSQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo, :nImporte<T>, Info.IDTexto, <T>INSERTAR COBRO<T>, Info.POSRedondeo2)<BR><BR>Fin
EjecucionCondicion=Info.POSRedondeo<99999
EjecucionMensaje=<T>El Redondeo debe de ser menor a 99999 <T>
[Acciones.InsertarRedondeo.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.InsertarRedondeo]
Nombre=InsertarRedondeo
Boton=0
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S


TeclaFuncion=F12
NombreDesplegar=F12        Insertar Redondeo
EnMenu=S

NombreEnBoton=S




[Acciones.EliminarRedondeo.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.POSRedondeo2,0)<BR>EjecutarSQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo, :nImporte<T>, Info.IDTexto, <T>ELIMINAR<T>, Info.POSRedondeo2)<BR><BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Info.POSRedondeo2,0)
[Acciones.EliminarRedondeo.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.EliminarRedondeo]
Nombre=EliminarRedondeo
Boton=0
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S


TeclaFuncion=F10
NombreDesplegar=F10 Eliminar Redondeo




[Acciones.EliminarRedondeo.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.POSRedondeo2
Info.POSRedondeo2=Info.Importe
Info.Importe=(Fin)










[Acciones.InsertarRedondeo.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)





[Forma.ListaAcciones]
(Inicio)=InsertarRedondeo
InsertarRedondeo=EliminarRedondeo
EliminarRedondeo=(Fin)
