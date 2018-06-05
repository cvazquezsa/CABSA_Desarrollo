[Forma]
Clave=NegociaMoratoriosMAVI
Icono=126
Modulos=(Todos)
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
ListaCarpetas=NegociaMoratoriosMAVI
CarpetaPrincipal=NegociaMoratoriosMAVI
PosicionInicialIzquierda=328
PosicionInicialArriba=141
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
ExpresionesAlMostrar=Asigna(Info.Usuario, nulo)<BR>Asigna(info.abc, nulo)<BR>//Asigna(Info.Numero, sql(<T>select ISNULL(interesxpolitica,0) from cxc where id = :nid<T>, info.id) )<BR>//Informacion(Info.Id)<BR>//Informacion(Info.bloqueado)<BR>Si (Info.SugerirCobro <> <T>Por Factura<T>) y (Info.cantidad = 0)<BR> Entonces<BR>   EjecutarSQL(<T>spSugerirCobroMavi  :tSuge, :tMod, :nID, :nImpTotal, :tUsua, :nEst<T>, Info.SugerirCobro, <T>CXC<T>, Info.ID, Info.Importe, Usuario,  EstacionTrabajo )<BR> Sino<BR>   Si (Info.SugerirCobro = <T>Por Factura<T>) y (Info.Cantidad = 0)<BR>   Entonces<BR>     EjecutarSQL(<T>spSugerirCobroxFact  :tSuge, :tMod, :nID, :nImpTotal, :tUsua, :nEst<T>, Info.SugerirCobro, <T>CXC<T>, Info.ID, Info.Importe, Usuario,  EstacionTrabajo )<BR>    Sino<BR>     Si (Info.SugerirCobroPM = <T>Por Fac<CONTINUA>
ExpresionesAlMostrar002=<CONTINUA>tura<T>) y (Info.Cantidad = 1)<BR>     Entonces     <BR>       EjecutarSQL(<T>spSugerirCobroxFactPMMavi  :tSuge, :tMod, :nID, :nImpTotal, :tUsua, :nEst<T>, Info.SugerirCobroPM, <T>CXC<T>, Info.ID, Info.Importe, Usuario,  EstacionTrabajo )<BR>     Fin<BR>   Fin<BR> Fin


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
AntesExpresiones=Si<BR>  Vacio(Info.CxcMovID,Nulo) = Nulo<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spConsecutivoGral :nID, :tMod, :bApl<T> ,Info.ID, <T>CXC<T>, 1)<BR>Fin<BR><BR>Si  Vacio( Info.Usuario) entonces Asigna(Info.Usuario,  Usuario )  Fin<BR><BR>Si (Info.ABC = <T>4<T>) y (Info.Numero = <T>0<T>) Entonces<BR>    error(<T>Por favor Autorizar nuevamente<T>)<BR>    AbortarOperacion<BR>Fin<BR><BR>Asigna(Info.ABC, Nulo)<BR>Asigna(Info.ABC, SQL(<T>spValidaAutorizacionCondMAVI :nID, :tUsuario, :tEstacion<T>,Info.ID, Info.Usuario,  EstacionTrabajo ))<BR><BR>Si Info.ABC en (<T>2<T>,<T>3<T>,<T>0<T>) entonces<BR>  Asigna(Info.Descripcion,  SQL( <T>spGeneraCobroSugeridoMAVI :tMod, :nId,  :tUsua, :nEst<T>, <T>CXC<T>, Info.ID,  Usuario ,  EstacionTrabajo   ))<BR>  Si ConDatos(Info.Descripcion) entonces Informacion(Info.Descripcion) Fin<BR>Sino<BR>    Si Info.ABC = <T>1<T>  entonces<BR>      Precaucion(<T>Ha sobrepasado el % Autorizado para condonar..<T>)<BR>    Sino<BR>      Precaucion(<T>No hay autorizacion para condonar...Verifique<T>)<BR>    Fin<BR>Fin<BR>//Forma.Accion( <T>Cerrar<T> )<BR>OtraForma( <T>Cxc<T>,  ActualizarVista  )
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




[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe a Pagar
Importe a Pagar=Moratorios
Moratorios=Importe Total
Importe Total=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=AutorizaCondonacion
AutorizaCondonacion=GeneraCobro
GeneraCobro=(Fin)
