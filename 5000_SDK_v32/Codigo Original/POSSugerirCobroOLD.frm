[Forma]
Clave=POSSugerirCobroOLD
Nombre=Sugerir
Icono=5
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=498
PosicionInicialArriba=322
PosicionInicialAlturaCliente=125
PosicionInicialAncho=292
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal

PosicionSec1=355
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(info.Cantidad, 0)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
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

CampoAccionAlEnter=ValidaImporte
[(Variables).Info.Importe]
Carpeta=(Variables)
Clave=Info.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

AccionAlEnter=ValidaImporte
[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=<T>&Aceptar<T>
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=<T>&Cancelar<T>
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S


Multiple=S
ListaAccionesMultiples=(Lista)
ConfirmarAntes=S
DialogoMensaje=POSCancelarCxcPendiemte
[Acciones.Aceptar.VariablesAsignar]
Nombre=VariablesAsignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S
[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>((Info.Importe < 1) y (Info.SugerirCobro en (<T>Importe Especifico<T>)))<BR>Entonces<BR>Informacion(<T>El importe debe ser mayor a cero<T>)<BR>Sino<BR>  EjecutarSQL(<T>spPOSSugerirCobro :@SugerirPago, :@Modulo, :@ID, :@ImporteTotal<T>, Info.SugerirCobro, <T>CXC<T>, Info.IDTexto, Info.Importe)<BR>  (Si<BR>   Info.SugerirCobro = <T>Por Factura<T><BR>  Entonces<BR>   Forma(<T>POSCxcPendiente<T>)<BR>  Sino<BR>   Forma(<T>NegociaMoratorios<T>)<BR>  Fin)<BR>Fin
[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


































[NegociaMoratoriosMAVI.Columnas]
Mov=124
MovID=117
ImporteReal=101
ImporteAPagar=104
ImporteMoratorio=113
MoratorioAPagar=104
ImporteACondonar=114
Bonificacion=103
TotalAPagar=119





































































[(Variables).Info.SugerirCobro]
Carpeta=(Variables)
Clave=Info.SugerirCobro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







EditarConBloqueo=S


AccionAlEnter=Asigna
[Hoja.Columnas]
0=-2
1=94
2=71
3=293






























[NegociaMoratorios.Columnas]
Aplica=148
AplicaID=141
Importe=141
InteresesMoratorios=149













ImporteTotal=69
Saldo=86
SaldoTotal=64
Sugerido=64


DiasMoratorios=78
[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=VariablesAsignar
VariablesAsignar=Expresion
Expresion=Cerrar
Cerrar=(Fin)




















[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSEliminarMov :tID<T>,Info.IDTexto)<BR>Asigna(Info.Codigo,SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>,<T>ELIMINAR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Info.Codigo,Nulo)<BR> ActualizarVista<BR> ActualizarForma<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
Activo=S
Visible=S



[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar
Cancelar=expresion
expresion=(Fin)















[(Variables).ListaEnCaptura]
(Inicio)=Info.SugerirCobro
Info.SugerirCobro=Info.Importe
Info.Importe=(Fin)



























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
