[Forma]
Clave=POSNegociaMoratorios
Icono=126
Modulos=(Todos)
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
ListaCarpetas=NegociaMoratoriosMAVI
CarpetaPrincipal=NegociaMoratoriosMAVI
PosicionInicialIzquierda=440
PosicionInicialArriba=203
PosicionInicialAlturaCliente=424
PosicionInicialAncho=720
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
ExpresionesAlMostrar=Asigna(Info.Usuario, nulo)<BR>Asigna(info.abc, nulo)<BR>//Asigna(Info.Numero, sql(<T>select ISNULL(interesxpolitica,0) from cxc where id = :nid<T>, info.id) )<BR>//Informacion(Info.Id)<BR>//Informacion(Info.bloqueado)<BR>Si (Info.SugerirCobro <> <T>Por Factura<T>) y (Info.cantidad = 0)<BR> Entonces<BR>   EjecutarSQL(<T>spSugerirCobroMavi  :tSuge, :tMod, :nID, :nImpTotal, :tUsua, :nEst, :tOModulo<T>, Info.SugerirCobro, <T>CXC<T>, Info.ID, Info.Importe, Usuario,  EstacionTrabajo, <T>POS<T>)<BR> Sino<BR>   Si (Info.SugerirCobro = <T>Por Factura<T>) y (Info.Cantidad = 0)<BR>   Entonces<BR>     EjecutarSQL(<T>spSugerirCobroxFact  :tSuge, :tMod, :nID, :nImpTotal, :tUsua, :nEst, :tOModulo<T>, Info.SugerirCobro, <T>CXC<T>, Info.ID, Info.Importe, Usuario,  EstacionTrabajo, <T>POS<T>)<BR>    Sino<BR>     Si (Info.SugerirCobroPM = <T>Por Factura<T>) y (Info.Cantidad = 1)<BR>     Entonces     <BR>       EjecutarSQL(<T>spSugerirCobroxFactPMMavi  :tSuge, :tMod, :nID, :nImpTotal, :tUsua, :nEst<T>, Info.SugerirCobroPM, <T>CXC<T>, Info.ID, Info.Importe, Usuario,  EstacionTrabajo )<BR>     Fin<BR>   Fin<BR> Fin
[NegociaMoratoriosMAVI]
Estilo=Hoja
Clave=NegociaMoratoriosMAVI
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NegociaMoratoriosMAVI
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
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroGeneral=NegociaMoratoriosMAVI.IDCobro = {Info.Id} AND NegociaMoratoriosMAVI.Estacion = {EstacionTrabajo}
[NegociaMoratoriosMAVI.NegociaMoratoriosMAVI.Mov]
Carpeta=NegociaMoratoriosMAVI
Clave=NegociaMoratoriosMAVI.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
[NegociaMoratoriosMAVI.NegociaMoratoriosMAVI.MovID]
Carpeta=NegociaMoratoriosMAVI
Clave=NegociaMoratoriosMAVI.MovID
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
[NegociaMoratoriosMAVI.NegociaMoratoriosMAVI.ImporteReal]
Carpeta=NegociaMoratoriosMAVI
Clave=NegociaMoratoriosMAVI.ImporteReal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
[NegociaMoratoriosMAVI.NegociaMoratoriosMAVI.ImporteAPagar]
Carpeta=NegociaMoratoriosMAVI
Clave=NegociaMoratoriosMAVI.ImporteAPagar
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
[NegociaMoratoriosMAVI.NegociaMoratoriosMAVI.ImporteMoratorio]
Carpeta=NegociaMoratoriosMAVI
Clave=NegociaMoratoriosMAVI.ImporteMoratorio
Editar=N
IgnoraFlujo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

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
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)
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
AntesExpresiones=EjecutarSQL(<T>spPOSInsertarReferenciaCobroDOC :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :nID, :tIDPOS<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, NegociaMoratoriosMAVI:NegociaMoratoriosMAVI.IDCobro, Info.IDTexto)<BR>Asigna(Info.Codigo,NULO)
[Acciones.AutorizaCondonacion]
Nombre=AutorizaCondonacion
Boton=61
NombreEnBoton=S
NombreDesplegar=Autoriza Condonaciòn
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
EspacioPrevio=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)
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
Totalizadores1=Moratorios<BR>Importe a Pagar<BR>Importe Total<BR>Bonificaciones<BR>Condonaciones
Totalizadores2=Suma( NegociaMoratoriosMAVI:NegociaMoratoriosMAVI.MoratorioAPagar )<BR>Suma( NegociaMoratoriosMAVI:NegociaMoratoriosMAVI.ImporteAPagar )<BR>(Suma( NegociaMoratoriosMAVI:NegociaMoratoriosMAVI.ImporteAPagar ) + Suma( NegociaMoratoriosMAVI:NegociaMoratoriosMAVI.MoratorioAPagar ) - Suma(NegociaMoratoriosMAVI:NegociaMoratoriosMAVI.ImporteACondonar)) - Suma(NegociaMoratoriosMAVI:NegociaMoratoriosMAVI.Bonificacion)<BR>Suma( NegociaMoratoriosMAVI:NegociaMoratoriosMAVI.Bonificacion )<BR>Suma( NegociaMoratoriosMAVI:NegociaMoratoriosMAVI.ImporteACondonar )
Totalizadores3=#,.00<BR>#,.00<BR>#,.00<BR>#,.00<BR>#,.00
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=(Lista)
TotCarpetaRenglones=NegociaMoratoriosMAVI
[(Carpeta Totalizadores).Importe a Pagar]
Carpeta=(Carpeta Totalizadores)
Clave=Importe a Pagar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
[NegociaMoratoriosMAVI.NegociaMoratoriosMAVI.MoratorioAPagar]
Carpeta=NegociaMoratoriosMAVI
Clave=NegociaMoratoriosMAVI.MoratorioAPagar
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
;[Acciones.DetalleBonif]
;Nombre=DetalleBonif
;Boton=102
;NombreEnBoton=S
;NombreDesplegar=Detalle Bonificaciones
;EnBarraHerramientas=S
;TipoAccion=Formas
;Activo=S
;Visible=S
;EspacioPrevio=S
;ClaveAccion=MaviBonificacionTestFinal



[(Carpeta Totalizadores).Moratorios]
Carpeta=(Carpeta Totalizadores)
Clave=Moratorios
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
[Acciones.AutorizaCondonacion.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma(<T>AutorizarCondMAVI<T>)
[Acciones.AutorizaCondonacion.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S












[Acciones.AutorizaCondonacion.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=(Fin)











[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe a Pagar
Importe a Pagar=Moratorios
Moratorios=Importe Total
Importe Total=(Fin)




































[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Cerrar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSEliminarMov :tID<T>,Info.IDTexto)<BR>Asigna(Info.Codigo,SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>,<T>ELIMINAR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Info.Codigo,Nulo)<BR> ActualizarVista<BR> ActualizarForma<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
Activo=S
Visible=S

[Acciones.Cerrar.ListaAccionesMultiples]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=(Fin)


























































[NegociaMoratoriosMAVI.ListaEnCaptura]
(Inicio)=NegociaMoratoriosMAVI.Mov
NegociaMoratoriosMAVI.Mov=NegociaMoratoriosMAVI.MovID
NegociaMoratoriosMAVI.MovID=NegociaMoratoriosMAVI.ImporteReal
NegociaMoratoriosMAVI.ImporteReal=NegociaMoratoriosMAVI.ImporteAPagar
NegociaMoratoriosMAVI.ImporteAPagar=NegociaMoratoriosMAVI.ImporteMoratorio
NegociaMoratoriosMAVI.ImporteMoratorio=NegociaMoratoriosMAVI.MoratorioAPagar
NegociaMoratoriosMAVI.MoratorioAPagar=(Fin)

[NegociaMoratoriosMAVI.ListaCamposAValidar]
(Inicio)=Folio
Folio=Saldo
Saldo=(Fin)

[NegociaMoratoriosMAVI.ListaOrden]
(Inicio)=CxcPendiente.Vencimiento	(Acendente)
CxcPendiente.Vencimiento	(Acendente)=NegociaMoratoriosMAVI.Mov	(Acendente)
NegociaMoratoriosMAVI.Mov	(Acendente)=NegociaMoratoriosMAVI.MovID	(Acendente)
NegociaMoratoriosMAVI.MovID	(Acendente)=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=AutorizaCondonacion
AutorizaCondonacion=GeneraCobro
GeneraCobro=(Fin)
