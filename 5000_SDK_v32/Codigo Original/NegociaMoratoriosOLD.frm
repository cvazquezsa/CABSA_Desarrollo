[Forma]
Clave=NegociaMoratoriosOLD
Icono=126
Modulos=(Todos)
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaCarpetas=NegociaMoratorios
CarpetaPrincipal=NegociaMoratorios
PosicionInicialIzquierda=497
PosicionInicialArriba=97
PosicionInicialAlturaCliente=424
PosicionInicialAncho=776
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSec1=355
Nombre=Preliminar de Negociacion
Comentarios=Info.Acreditado
Totalizadores=S
VentanaExclusiva=S









VentanaExclusivaOpcion=0
VentanaSinIconosMarco=S
ExpresionesAlCerrar=ActualizarVista  ActualizarForma
[NegociaMoratoriosMAVI.Columnas]
Mov=124
MovID=117
ImporteReal=101
ImporteAPagar=104
ImporteMoratorio=113
ImporteACondonar=114
MoratorioAPagar=104
Bonificacion=103
TotalAPagar=119

[Acciones.GeneraCobro]
Nombre=GeneraCobro
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar Cobro
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
Activo=S
Visible=S
GuardarAntes=S
ClaveAccion=Cerrar
Antes=S
RefrescarDespues=S
DespuesGuardar=S

AntesExpresiones=EjecutarSQL(<T>spPOSInsertarReferenciaCobro :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :nID, :tIDPOS<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, POSCxcAnticipoTempD:POSCxcAnticipoTempD.ID, Info.IDTexto)<BR>Asigna(Info.Codigo,NULO)
[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Moratorios<BR>Importe a Pagar<BR>Importe Total
Totalizadores2=Suma(POSCxcAnticipoTempD.InteresesMoratorios)<BR>Suma(POSCxcAnticipoTempD:POSCxcAnticipoTempD.Importe)<BR>Suma(POSCxcAnticipoTempD:POSCxcAnticipoTempD.Importe + POSCxcAnticipoTempD.InteresesMoratorios)
Totalizadores3=#,.00<BR>#,.00<BR>#,.00
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
TotCarpetaRenglones=NegociaMoratorios

ListaEnCaptura=(Lista)


[Acciones.AutorizaCondonacion.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S






































[NegociaMoratorios]
Estilo=Hoja
Clave=NegociaMoratorios
Filtros=S
OtroOrden=S
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCxcAnticipoTempD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S













ListaEnCaptura=(Lista)

ListaCamposAValidar=(Lista)
FiltroGeneral=POSCxcAnticipoTempD.Estacion = {EstacionTrabajo} AND<BR>POSCxcAnticipoTemp.Mov = <T>Documento<T>
[NegociaMoratorios.ListaOrden]
(Inicio)=CxcPendiente.Vencimiento	(Acendente)
CxcPendiente.Vencimiento	(Acendente)=NegociaMoratoriosMAVI.Mov	(Acendente)
NegociaMoratoriosMAVI.Mov	(Acendente)=NegociaMoratoriosMAVI.MovID	(Acendente)
NegociaMoratoriosMAVI.MovID	(Acendente)=(Fin)



[NegociaMoratorios.POSCxcAnticipoTempD.Aplica]
Carpeta=NegociaMoratorios
Clave=POSCxcAnticipoTempD.Aplica
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[NegociaMoratorios.POSCxcAnticipoTempD.AplicaID]
Carpeta=NegociaMoratorios
Clave=POSCxcAnticipoTempD.AplicaID
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata


[NegociaMoratorios.Columnas]
Aplica=148
AplicaID=141
Importe=141
InteresesMoratorios=149









Sugerido=64
ImporteTotal=69
Saldo=86
SaldoTotal=64
SaldoInteresesMoratorios=127
DiasMoratorios=78
[(Carpeta Totalizadores).Moratorios]
Carpeta=(Carpeta Totalizadores)
Clave=Moratorios
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata

[(Carpeta Totalizadores).Importe a Pagar]
Carpeta=(Carpeta Totalizadores)
Clave=Importe a Pagar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata

Pegado=S
[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata


Pegado=S








[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

Multiple=S
ConfirmarAntes=S
ListaAccionesMultiples=(Lista)

DialogoMensaje=POSCancelarCxcPendiemte
[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSEliminarMov :tID<T>,Info.IDTexto)<BR>Asigna(Info.Codigo,SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>,<T>ELIMINAR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Info.Codigo,Nulo)<BR> ActualizarVista<BR> ActualizarForma<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
Activo=S
Visible=S



[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar
Cancelar=Expresion
Expresion=(Fin)









[NegociaMoratorios.POSCxcAnticipoTemp.DiasMoratorios]
Carpeta=NegociaMoratorios
Clave=POSCxcAnticipoTemp.DiasMoratorios
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[NegociaMoratorios.POSCxcAnticipoTempD.Importe]
Carpeta=NegociaMoratorios
Clave=POSCxcAnticipoTempD.Importe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[NegociaMoratorios.POSCxcAnticipoTempD.InteresesMoratorios]
Carpeta=NegociaMoratorios
Clave=POSCxcAnticipoTempD.InteresesMoratorios
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco












[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe a Pagar
Importe a Pagar=Moratorios
Moratorios=Importe Total
Importe Total=(Fin)





[NegociaMoratorios.ListaEnCaptura]
(Inicio)=POSCxcAnticipoTempD.Aplica
POSCxcAnticipoTempD.Aplica=POSCxcAnticipoTempD.AplicaID
POSCxcAnticipoTempD.AplicaID=POSCxcAnticipoTempD.Importe
POSCxcAnticipoTempD.Importe=POSCxcAnticipoTemp.DiasMoratorios
POSCxcAnticipoTemp.DiasMoratorios=POSCxcAnticipoTempD.InteresesMoratorios
POSCxcAnticipoTempD.InteresesMoratorios=(Fin)

[NegociaMoratorios.ListaCamposAValidar]
(Inicio)=POSCxcAnticipoTemp.Origen
POSCxcAnticipoTemp.Origen=POSCxcAnticipoTemp.OrigenID
POSCxcAnticipoTemp.OrigenID=(Fin)





























































[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=GeneraCobro
GeneraCobro=(Fin)
