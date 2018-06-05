[Forma]
Clave=Cxp
Nombre=Cuentas por pagar
Icono=0
Modulos=CXP
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=384
PosicionInicialArriba=141
PosicionInicialAltura=564
PosicionInicialAncho=671
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DialogoAbrir=S
ListaAcciones=(Lista)
PosicionSeccion1=55
Totalizadores=S
PosicionSeccion2=93
BarraAyuda=S
MovModulo=CXP
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
PosicionInicialAlturaCliente=538
ExpresionesAlMostrar=Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Def.CxImpuesto, General.DefImpuesto)
ExpresionesAlCerrar=Asigna(Filtro.Proveedor, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
PosicionSec1=260
PosicionSec2=440

PosicionCol1=328
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
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
PermiteEditar=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.Cxp.Mov]
Carpeta=Ficha
Clave=Cxp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.MovID]
Carpeta=Ficha
Clave=Cxp.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Cxp.FechaEmision]
Carpeta=Ficha
Clave=Cxp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Concepto]
Carpeta=Ficha
Clave=Cxp.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Proyecto]
Carpeta=Ficha
Clave=Cxp.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=16
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.Cxp.Moneda]
Carpeta=Ficha
Clave=Cxp.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Referencia]
Carpeta=Ficha
Clave=Cxp.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Observaciones]
Carpeta=Ficha
Clave=Cxp.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Proveedor]
Carpeta=Ficha
Clave=Cxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Condicion]
Carpeta=Ficha
Clave=Cxp.Condicion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Vencimiento]
Carpeta=Ficha
Clave=Cxp.Vencimiento
Editar=S
3D=S
Tamano=18
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Importe]
Carpeta=Ficha
Clave=Cxp.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=CxpA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosConPaginas=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Cxp.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Cxp.Vencimiento
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
PestanaOtroNombre=S
PestanaNombre=movimientos
FiltroUsuarios=S
FiltroUsuarioDefault=(Todos)
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
Filtros=S
FiltroPredefinido=S
FiltroEstilo=Directorio
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroAutoValidar=Mon
FiltroAplicaEn=Cxp.Moneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=Cxp.FechaCancelacion
FiltroSucursales=S
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
FiltroProyectos=S

IconosNombre=CxpA:Cxp.Mov+<T> <T>+CxpA:Cxp.MovID
FiltroGeneral={Si(ConDatos(Filtro.Mov), <T>Cxp.Mov=<T>+Comillas(Filtro.Mov), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Proveedor), <T> AND Cxp.Proveedor=<T>+Comillas(Filtro.Proveedor), <T><T>)}<BR>{Si(ConDatos(Filtro.Tipo), <T> AND Prov.Tipo=<T>+Comillas(Filtro.Tipo), <T><T>)}
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=142
1=79

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
[Ficha.ImporteTotal]
Carpeta=Ficha
Clave=ImporteTotal
Editar=S
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=Si
EnMenu=Si
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=Si
Activo=Si
Menu=&Archivo
UsaTeclaRapida=Si
TeclaRapida=Ctrl+N

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Visible=S
Activo=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=S
Activo=S
ConCondicion=S
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Cxp:Cxp.ID) y (Cxp:Cxp.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Cxp:Cxp.ID, <T>CXP<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Visible=S
Activo=S

[Ficha.Cxp.Impuestos]
Carpeta=Ficha
Clave=Cxp.Impuestos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.FormaPago]
Carpeta=Ficha
Clave=Cxp.FormaPago
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=Si
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Visible=Si
Activo=Si
EspacioPrevio=Si

[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CxpD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Cxp
LlaveLocal=CxpD.ID
LlaveMaestra=Cxp.ID
ControlRenglon=S
CampoRenglon=CxpD.Renglon
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ValidarCampos=S
ListaCamposAValidar=(Lista)
MenuLocal=S
ListaAcciones=Copiar
OtroOrden=S
ListaOrden=(Lista)
CondicionEdicion=(Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) o (MovTipoEn(<T>CXP<T>,Cxp:Cxp.Mov, (CXP.NC, CXP.NCD, CXP.NCF, CXP.NCP)) y (Cxp:Cxp.Estatus=EstatusPendiente))
HojaFondoGrisAuto=S
PermiteLocalizar=S

CondicionVisible=(MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.F, CXP.A, CXP.AF, CXP.CD, CXP.DE, CXP.AJE, CXP.AJR, CXP.NCP, CXP.C, CXP.SD, CXP.SCH)) y <BR>(Cxp:Cxp.AplicaManual o ((Cxp:Cxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.NC, CXP.NCD, CXP.NCF, CXP.RA, CXP.FAC, CXP.DAC, CXP.PR))))
[Detalle.CxpD.Importe]
Carpeta=Detalle
Clave=CxpD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.CxpD.Aplica]
Carpeta=Detalle
Clave=CxpD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.CxpD.AplicaID]
Carpeta=Detalle
Clave=CxpD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.Columnas]
Importe=105
Aplica=96
AplicaID=70
AplicaProntoPago=96
DiferenciaNeta=80
ProntoPago=118
DescuentoProntoPago=107
SaldoProntoPago=92
DescuentoPP=94
SaldoPP=92
DiferenciaPorcentaje=37
DescuentoRecargos=104
DescuentoRecargosPorcentaje=45
DescuentoRecargosSugerido=68
IVAFiscal=90
ImporteIVAFiscal=81
Referencia=98
ImporteIEPSFiscal=64
InteresesOrdinarios=60
InteresesMoratorios=61
InteresesOrdinariosQuita=47
InteresesMoratoriosQuita=45

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=4
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total
Totalizadores2=Suma( CxpD:ImporteNeto )
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CondicionVisible=(MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.F, CXP.A, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP, CXP.CD, CXP.DE, CXP.AJE, CXP.AJR, CXP.NCP, CXP.C, CXP.SD, CXP.SCH)) y <BR>(Cxp:Cxp.AplicaManual o ((Cxp:Cxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.NC, CXP.NCD, CXP.NCF, CXP.PR))))

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Ficha.Cxp.AplicaManual]
Carpeta=Ficha
Clave=Cxp.AplicaManual
Editar=S
LineaNueva=S
3D=S
Tamano=39
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=<T>A&fectar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S
GuardarAntes=S
ConCondicion=S
EspacioPrevio=S
Antes=S
DespuesGuardar=S
EjecucionConError=S

Expresion=Asigna(Afectar.Modulo, <T>CXP<T>)<BR>Asigna(Afectar.ID, Cxp:Cxp.ID)<BR>Asigna(Afectar.Mov, Cxp:Cxp.Mov)<BR>Asigna(Afectar.MovID, Cxp:Cxp.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>CXP<T>, Cxp:Cxp.Mov))<BR>Asigna(Info.SubMovTipo, fnSubMovTipo(<T>CXP<T>, Cxp:Cxp.Mov))<BR>Asigna(Info.Referencia, Cxp:Cxp.Referencia)<BR>Asigna(Info.Saldo, Suma(CxpD:ImporteNeto)-Si(Version.Peru y (Info.MovTipo=CXP.P), Cxp:SubTotal, Cxp:ImporteTotal))<BR>Si<BR>  Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar,EstatusBorrador)<BR>Entonces<BR>  Si<BR>    (Info.MovTipo en (CXP.P, CXP.D, CXP.DM, CXP.PAG, CXP.NC, CXP.NCD, CXP.NCF, CXP.ANC, CXP.ACA, CXP.AE)) y Cxp:Cxp.AplicaManual y (ABS(Info.Saldo) > Config.CxpAutoAjuste)<BR>  Entonces<BR>    Si(no Forma(<T>CxpAplicaDif<T>), AbortarOperacion)<BR>  Fin<BR>  Afectar(<T>CXP<T>, Cxp:Cxp.ID, Cxp:Cxp.Mov, Cxp:Cxp.MovID, <T>Todo<T>, <T><T>, <T>Cxp<T>)<BR>Sino<BR>  Asigna(Info.Modulo, <T>CXP<T>)<BR>  Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>  Asigna(Info.MovID, Cxp:Cxp.MovID)<BR>  Asigna(Afectar.Modulo, <T>CXP<T>)<BR>  Asigna(Afectar.ID, Cxp:Cxp.ID)<BR>  Asigna(Afectar.Mov, Cxp:Cxp.Mov)<BR>  Asigna(Afectar.MovID, Cxp:Cxp.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Cxp<T>)<BR>  Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Asigna(Info.Pagares, Cxp:Prov.Pagares)<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si<BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Si Info.SubMovTipo = CXP.SLC Entonces<BR>      Dialogo(<T>GenerarCxpPagoSLC<T>)<BR>    Sino<BR>      Caso Info.MovTipo<BR>        Es CXP.A   Entonces Dialogo(<T>GenerarCxpAnticipo<T>)<BR>        Es CXP.DA  Entonces Dialogo(<T>GenerarCxpDocumentoAnticipo<T>)<BR>        Es CXP.NC  Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>        Es CXP.NCD Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>        Es CXP.DAC Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>        Es CXP.NCF Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>        Es CXP.NCP Entonces Asigna(Afectar.GenerarMov, ConfigMov.CxpAplicacionPago) Dialogo(<T>GenerarAplicacionCredito<T>)<BR>        Es CXP.DP  Entonces Dialogo(<T>GenerarCxpPagoPosfechado<T>)<BR>        Sino Dialogo(<T>GenerarCxpPago<T>)<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Cxp:Cxp.Usuario) y<BR>((Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) o ((Cxp:Cxp.Estatus=EstatusPendiente) y MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.F, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP, CXP.D, CXP.DM, CXP.PAG, CXP.DP, CXP.A, CXP.DA, CXP.NC, CXP.NCD, CXP.NCF, CXP.NCP, CXP.CD, CXP.FAC, CXP.DAC)))) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Cxp:Cxp.Mov) y ConDatos(Cxp:Cxp.Importe)
EjecucionMensaje=Si(Vacio(Cxp:Cxp.Importe), <T>Falta Especificar el Importe<T>))
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CXP<T>, Cxp:Cxp.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.ID, Verdadero, Cxp:Cxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
[Ficha.Cxp.Saldo]
Carpeta=Ficha
Clave=Cxp.Saldo
Editar=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]
LineaNueva=N

[(Carpeta Abrir).ImporteTotal]
Carpeta=(Carpeta Abrir)
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1
ColorFondo=Blanco

[(Carpeta Abrir).Cxp.Saldo]
Carpeta=(Carpeta Abrir)
Clave=Cxp.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Copiar
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna( CxpD:CxpD.Importe, CxpD:SaldoNeto)<BR>Asigna( CxpD:CxpD.DescuentoRecargos, CxpD:DescuentoRecargosSugerido)
ActivoCondicion=Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[(Carpeta Abrir).Cxp.Vencimiento]
Carpeta=(Carpeta Abrir)
Clave=Cxp.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Acciones.Asistente Aplicacion]
Nombre=Asistente Aplicacion
Boton=12
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=Asistente Aplicación
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Cxp
ListaParametros1=Cxp:Cxp.Proveedor<BR>Cxp:Prov.Nombre<BR>Cxp:ImporteTotal<BR>CxpD:CxpD.Aplica<BR>CxpD:CxpD.AplicaID<BR>CxpD:CxpD.Importe<BR>Cxp:Cxp.ProveedorMoneda
ListaParametros=S
Visible=S
ActivoCondicion=Cxp:Cxp.AplicaManual y<BR>((MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.NC,CXP.NCD,CXP.NCF,CXP.NCP,CXP.D,CXP.DM,CXP.PAG,CXP.DP,CXP.AE,CXP.ANC,CXP.ACA,CXP.P,CXP.A,CXP.AJM,CXP.AJA,CXP.NET)) y (Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))) o<BR> (MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.NC,CXP.NCD,CXP.NCF,CXP.NCP)) y (Cxp:Cxp.Estatus=EstatusPendiente))) y<BR>(Cxp:Cxp.Moneda=Cxp:Cxp.ProveedorMoneda)

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
ActivoCondicion=Vacio(Cxp:Cxp.MovID) y (Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Cxp:Cxp.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Cxp WHERE ID=:nID<T>, Cxp:Cxp.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
UsaTeclaRapida=S
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Cxp:Cxp.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.Estatus), Cxp:Cxp.ID)
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Cxp:Cxp.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.Estatus), Cxp:Cxp.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.Totalizar]
Nombre=Totalizar
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Totalizar
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Ultimo
Visible=S
Multiple=S
ListaAccionesMultiples=TotalizarPost<BR>TotalizarCopiar
ActivoCondicion=(no MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.F, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP))) y (Cxp:Cxp.AplicaManual o (Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)))

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConfirmarAntes=S
DialogoMensaje=MovCancelar
Antes=S
RefrescarDespues=S
GuardarAntes=S
Expresion=Cancelar(<T>CXP<T>, Cxp:Cxp.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Cxp<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Cxp:Cxp.Usuario) y ConDatos(Cxp:Cxp.ID) y ConDatos(Cxp:Cxp.MovID) y<BR>(Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusSincro, EstatusConcluido, EstatusPendiente))
AntesExpresiones=Asigna( Afectar.Mov, Cxp:Cxp.Mov ) <BR> Asigna( Afectar.MovID, Cxp:Cxp.MovID )

[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
EspacioPrevio=S
ConCondicion=S
Expresion=Verificar(<T>CXP<T>, Cxp:Cxp.ID,Cxp:Cxp.Mov,Cxp:Cxp.MovID)
ActivoCondicion=Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(Cxp:Cxp.Mov)

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=37
ColorFondo=Plata
Efectos=[Negritas]
Pegado=N
ColorFuente=Negro

[Ficha.CxpSaldo.Saldo]
Carpeta=Ficha
Clave=CxpSaldo.Saldo
Editar=S
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Plata
ColorFuente=Azul marino
Efectos=[Negritas]

[Acciones.Infomacion]
Nombre=Infomacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información del Proveedor
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>  ConDatos(Cxp:Cxp.Proveedor) <BR>Entonces<BR>  Si<BR>    (Cxp:Prov.Tipo<><T>Acreedor<T>) o Usuario.VerInfoAcreedores<BR>  Entonces<BR>    Asigna( Info.Proveedor,Cxp:Cxp.Proveedor ) <BR>    Asigna(Info.Origen, <T>Cxp<T>)<BR>    Forma( <T>ProvInfo<T> )<BR>  Fin<BR>Fin

[Ficha.Cxp.TipoCambio]
Carpeta=Ficha
Clave=Cxp.TipoCambio
Editar=S
3D=S
Tamano=8
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.ProveedorMoneda]
Carpeta=Ficha
Clave=Cxp.ProveedorMoneda
Editar=S
3D=S
Tamano=10
ValidaNombre=S
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.Cxp.CtaDinero]
Carpeta=Ficha
Clave=Cxp.CtaDinero
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.InfoCtaDinero]
Nombre=InfoCtaDinero
Boton=0
Menu=&Ver
NombreDesplegar=Información de la Cuenta
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+I
EspacioPrevio=S
Expresion=Asigna(Info.CtaDinero, Cxp:Cxp.CtaDinero)<BR>Forma(<T>CtaDineroInfo<T>)
ActivoCondicion=MovTipoEn(<T>CXP<T>,Cxp:Cxp.Mov,(CXP.P, CXP.DP, CXP.NCP, CXP.A, CXP.AA, CXP.DE, CXP.DC, CXP.CD, CXP.C)) y Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(Cxp:Cxp.CtaDinero)

[Aplica]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Movimiento a Aplicar
Clave=Aplica
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
Fuente={MS Sans Serif, 8, Negro, []}
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
CondicionVisible=MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) en (CXP.ANC, CXP.ACA, CXP.RA, CXP.FAC, CXP.DAC)

[Aplica.Cxp.MovAplica]
Carpeta=Aplica
Clave=Cxp.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Cxp.MovAplicaID]
Carpeta=Aplica
Clave=Cxp.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Cxp.Referencia]
Carpeta=(Carpeta Abrir)
Clave=Cxp.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Localizar]
Nombre=Localizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F3
NombreDesplegar=L&ocalizar...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Localizar
Activo=S
Visible=S

[(Carpeta Abrir).Cxp.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Cxp.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posición del Movimiento
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S

Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(Cxp:Cxp.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)
[Aplica.Cxp.Proveedor]
Carpeta=Aplica
Clave=Cxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Prov.Nombre]
Carpeta=Aplica
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=58
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12

GuardarAntes=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>CXP<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Cxp:Cxp.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.Estatus, Cxp:Cxp.Estatus)<BR>Asigna(Info.Situacion, Cxp:Cxp.Situacion)
DespuesGuardar=S
[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=ConfigModulo(<T>CXP<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Cxp:Cxp.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)

[(Carpeta Abrir).Cxp.Proveedor]
Carpeta=(Carpeta Abrir)
Clave=Cxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).Cxp.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Cxp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(CxpA:Cxp.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, CxpA:Cxp.ID)
Visible=S

[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Visible=S
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Visible=S
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.AbrirExcel]
Nombre=AbrirExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Acciones.AbrirCampos]
Nombre=AbrirCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ReasignarUsuario]
Nombre=ReasignarUsuario
Boton=0
Menu=&Archivo
NombreDesplegar=Reasignar &Usuario...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ReasignarUsuario
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Usuario, Cxp:Cxp.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Cxp:Cxp.ID)

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>CXP<T>)<BR>Asigna(Info.Fecha, Cxp:Cxp.FechaEmision)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Cxp:Cxp.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Cxp:Cxp.Mov+<T> <T>+Cxp:Cxp.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(Cxp:Cxp.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)
Visible=S

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F11
NombreDesplegar=&Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=CopiarMovimiento(<T>CXP<T>, Cxp:Cxp.ID, <T>Cxp<T>)

[Acciones.Anterior]
Nombre=Anterior
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+,
NombreDesplegar=Anterior
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Anterior
Activo=S
Visible=S

[Acciones.Siguiente]
Nombre=Siguiente
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+.
NombreDesplegar=Siguiente
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Siguiente
Activo=S
Visible=S

[Detalle.DiferenciaNeta]
Carpeta=Detalle
Clave=DiferenciaNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.MovExpress]
Nombre=MovExpress
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F8
NombreDesplegar=&Agregar Movimiento
Multiple=S
EnMenu=S
Visible=S
ListaAccionesMultiples=CxpExpress<BR>Registro Agregar<BR>Expresion
ActivoCondicion=Usuario.CxpMovExpress y (Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
Antes=S
AntesExpresiones=Asigna(Def.Proveedor, Cxp:Cxp.Proveedor)

[Acciones.MovExpress.CxpExpress]
Nombre=CxpExpress
Boton=0
TipoAccion=Formas
ClaveAccion=CxpExpress
Activo=S
Visible=S

[Acciones.MovExpress.Registro Agregar]
Nombre=Registro Agregar
Boton=0
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Info.Copiar

[Acciones.MovExpress.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(CxpD:CxpD.Aplica, Info.Mov)<BR>Asigna(CxpD:CxpD.AplicaID, Info.MovID)
EjecucionCondicion=Info.Copiar

[Aplica.CxpPendiente.Referencia]
Carpeta=Aplica
Clave=CxpPendiente.Referencia
3D=S
Tamano=21
ColorFondo=Plata
ColorFuente=Negro

[Aplica.CxpPendiente.FechaEmision]
Carpeta=Aplica
Clave=CxpPendiente.FechaEmision
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[Aplica.CxpPendiente.Vencimiento]
Carpeta=Aplica
Clave=CxpPendiente.Vencimiento
ValidaNombre=N
3D=S
Pegado=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[Acciones.AbrirLocalizar]
Nombre=AbrirLocalizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Acciones.AbrirLocalizarSiguiente]
Nombre=AbrirLocalizarSiguiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
Menu=&Edición
NombreDesplegar=&Campos...
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CxpCampos
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)
VisibleCondicion=Cxp:Cxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.GastoDiverso]
Nombre=GastoDiverso
Boton=0
Menu=&Ver
NombreDesplegar=&Gasto Diverso...
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompraGastoDiversoInfo
Activo=S
Antes=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Concepto, Cxp:Cxp.Concepto)<BR>Asigna(Info.ID, SQL(<T>SELECT ID FROM Compra WHERE Empresa=:tEmpresa AND Mov=:tMov AND MovID=:tMovID AND Estatus NOT IN (:tSinAfectar, :tConfirmar ,:tCancelado)<T>, Empresa, Cxp:Cxp.Origen, Cxp:Cxp.OrigenID, EstatusSinAfectar, EstatusPorConfirmar, EstatusCancelado))
VisibleCondicion=MovTipo(Cxp:Cxp.OrigenTipo, Cxp:Cxp.Origen) en (COMS.EG,COMS.EI)

[Ficha.Cxp.ProveedorTipoCambio]
Carpeta=Ficha
Clave=Cxp.ProveedorTipoCambio
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sucursal]
Nombre=Sucursal
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+U
NombreDesplegar=<T>Sucursal<T>
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Sucursal Destino
ActivoCondicion=Usuario.ModificarSucursalDestino y (Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Cxp:Cxp.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino

[Acciones.Autorizar]
Nombre=Autorizar
Boton=0
Menu=&Archivo
NombreDesplegar=A&utorizar
EnMenu=S
TipoAccion=Formas
Antes=S
RefrescarDespues=S
ClaveAccion=MovAutorizar
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Alt+F12
ActivoCondicion=Vacio(Cxp:Cxp.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Cxp<T>)<BR>Asigna(Afectar.Modulo, <T>CXP<T>)<BR>Asigna(Afectar.ID, Cxp:Cxp.ID)<BR>Asigna(Afectar.Mov, Cxp:Cxp.Mov)<BR>Asigna(Afectar.MovID, Cxp:Cxp.MovID)<BR>Asigna(Info.Descripcion, Cxp:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(Cxp:Cxp.Mensaje)

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros4]
Nombre=Otros4
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros5]
Nombre=Otros5
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros8]
Nombre=Otros8
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Anticipos]
Nombre=Anticipos
Boton=61
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F7
NombreDesplegar=Anticipos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
Expresion=Asigna(Info.Rama, <T>CXP<T>)<BR>Asigna(Info.Moneda, Cxp:Cxp.Moneda)<BR>Asigna(Info.Cuenta, Cxp:Cxp.Proveedor)<BR>Si<BR>  Forma(<T>AnticipoPendiente<T>)<BR>Entonces<BR>  Asigna(Cxp:Cxp.Referencia, Info.Referencia)<BR>  Asigna(Cxp:Cxp.Importe, Info.Importe)<BR>Fin
ActivoCondicion=(Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) = CXP.AA)
EjecucionCondicion=ConDatos(Cxp:Cxp.Proveedor)

[Detalle.DiferenciaPorcentaje]
Carpeta=Detalle
Clave=DiferenciaPorcentaje
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Detalle.CxpD.DescuentoRecargos]
Carpeta=Detalle
Clave=CxpD.DescuentoRecargos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.DescuentoRecargosPorcentaje]
Carpeta=Detalle
Clave=DescuentoRecargosPorcentaje
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Detalle.DescuentoRecargosSugerido]
Carpeta=Detalle
Clave=DescuentoRecargosSugerido
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Totalizar.TotalizarPost]
Nombre=TotalizarPost
Boton=0
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Afectar
Activo=S
Visible=S

[Acciones.Totalizar.TotalizarCopiar]
Nombre=TotalizarCopiar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Cxp:Cxp.Importe, Suma(CxpD:ImporteNeto) / (1+(Si(MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.F,CXP.NC,CXP.CA)), ImpuestoZona(General.DefImpuesto, Cxp:Prov.ZonaImpuesto)/100, 0))))

[Ficha.Cxp.Cajero]
Carpeta=Ficha
Clave=Cxp.Cajero
Editar=S
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AutoAplica]
Nombre=AutoAplica
Boton=0
Menu=&Edición
NombreDesplegar=Aplicación Automática
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
Expresion=Si<BR>  Forma(<T>EspecificarVencimiento<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spSugerirPago :nID, :tEmpresa, :tMon, :tProveedor, :fVencimiento<T>, Cxp:Cxp.ID, Empresa, Cxp:Cxp.Moneda, Cxp:Cxp.Proveedor, Info.Fecha)<BR>Fin
ActivoCondicion=Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.P))

[Detalle.ImporteIVAFiscal]
Carpeta=Detalle
Clave=ImporteIVAFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Cxp.UEN]
Carpeta=Ficha
Clave=Cxp.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ProyInfo]
Nombre=ProyInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del Proyecto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Cxp:Cxp.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Cxp:Cxp.Proyecto)
Visible=S

[Detalle.CxpAplica.Referencia]
Carpeta=Detalle
Clave=CxpAplica.Referencia
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.ImporteConImpuestos]
Nombre=ImporteConImpuestos
Boton=10
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F6
NombreDesplegar=&Importe con Impuestos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.Importe, Cxp:ImporteTotal)<BR>Asigna(Info.PorcentajeImpuesto, ImpuestoZona(Redondea(Def.CxImpuesto, 8), Cxp:Prov.ZonaImpuesto))<BR>Si<BR>  Forma(<T>EspecificarImporteConImpuestos<T>)<BR>Entonces<BR>  Asigna(Cxp:Cxp.Importe,  Redondea(Info.Importe/(1+(Info.PorcentajeImpuesto/100)), 4))<BR>  Asigna(Cxp:Cxp.Impuestos, Info.Importe-Cxp:Cxp.Importe)<BR>Fin
ActivoCondicion=(Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.F,CXP.NC,CXP.CA,CXP.A,CXP.AA,CXP.DE))

[Ficha.Retenciones]
Carpeta=Ficha
Clave=Retenciones
Editar=S
3D=S
Tamano=18
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.Clave, <T>CXP<T>+Cxp:Cxp.ID)<BR>Asigna(Info.Nombre, Cxp:Cxp.Mov+<T> <T>+Cxp:Cxp.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Cxp:Cxp.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

[Acciones.CopiarMeses]
Nombre=CopiarMeses
Boton=0
Menu=&Archivo
NombreDesplegar=Copiar en el Tiempo...
GuardarAntes=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)<BR>Si(no Forma(<T>MovCopiarMeses<T>),  AbortarOperacion)

[Acciones.Consecutivo]
Nombre=Consecutivo
Boton=0
Menu=&Archivo
NombreDesplegar=A&signar Consecutivo
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>CXP<T>, Cxp:Cxp.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(Cxp:Cxp.MovID) y PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Cxp:Cxp.Usuario)

[Detalle.ImporteIEPSFiscal]
Carpeta=Detalle
Clave=ImporteIEPSFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tareas
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.PuedeEditar, Cxp:Cxp.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)<BR>Asigna(Info.Proyecto, Cxp:Cxp.Proyecto)<BR>Asigna(Info.UEN, Cxp:Cxp.UEN)<BR>Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Cxp:Cxp.Proveedor)<BR>Asigna(Info.Agente, Cxp:Cxp.Cajero)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Comentarios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comentarios
Clave=Comentarios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Comentarios.Cxp.Comentarios]
Carpeta=Comentarios
Clave=Cxp.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=88x10
ColorFondo=Blanco

[Comentarios.Cxp.Nota]
Carpeta=Comentarios
Clave=Cxp.Nota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=46
ColorFondo=Blanco

[Acciones.MovPersonal]
Nombre=MovPersonal
Boton=0
Menu=&Archivo
NombreDesplegar=P&ersonal Involucrado
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPersonal
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)<BR>Asigna(Info.Fecha, Cxp:Cxp.FechaEmision)<BR>Asigna(Info.Estatus, Cxp:Cxp.Estatus)

[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+O
NombreDesplegar=P&olítica Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Cxp:Cxp.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CXP<T>)<BR>Asigna(Info.Clave, Cxp:Cxp.Mov)

[Acciones.PoliticaConcepto]
Nombre=PoliticaConcepto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+N
NombreDesplegar=Política Co&ncepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Cxp:Cxp.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.Concepto, Cxp:Cxp.Concepto)

[AC]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Crédito
Clave=AC
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CondicionVisible=General.AC y MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.F,CXP.CA,CXP.CAP,CXP.CAD,CXP.D,CXP.DM))

[AC.Cxp.TipoAmortizacion]
Carpeta=AC
Clave=Cxp.TipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.Cxp.TipoTasa]
Carpeta=AC
Clave=Cxp.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.Cxp.LineaCredito]
Carpeta=AC
Clave=Cxp.LineaCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.LC.Descripcion]
Carpeta=AC
Clave=LC.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Plata
ColorFuente=Negro

[AC.LC.VigenciaHasta]
Carpeta=AC
Clave=LC.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[AC.TipoAmortizacion.Descripcion]
Carpeta=AC
Clave=TipoAmortizacion.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Plata
ColorFuente=Negro

[AC.TipoTasa.Descripcion]
Carpeta=AC
Clave=TipoTasa.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Plata
ColorFuente=Negro

[AC.Cxp.Condicion]
Carpeta=AC
Clave=Cxp.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[AC.Cxp.Vencimiento]
Carpeta=AC
Clave=Cxp.Vencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TablaAmortizacion]
Nombre=TablaAmortizacion
Boton=88
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+M
NombreDesplegar=Tabla Amortización
TipoAccion=Formas
ClaveAccion=TablaAmortizacionCxp
Antes=S
ActivoCondicion=Cxp:Cxp.Amortizaciones>0
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)

[Detalle.CxpD.InteresesOrdinarios]
Carpeta=Detalle
Clave=CxpD.InteresesOrdinarios
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.CxpD.InteresesMoratorios]
Carpeta=Detalle
Clave=CxpD.InteresesMoratorios
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=&Sugerir
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
RefrescarDespues=S
EspacioPrevio=S
Expresion=Asigna(Info.Importe, Vacio(Cxp:ImporteTotal, Nulo))<BR>Asigna(Info.Acreditado, Cxp:Cxp.Proveedor)<BR>Si(Forma(<T>SugerirCobro<T>), EjecutarSQL(<T>spSugerirCobro :tSugerir, :tModulo, :nID, :nTotal<T>, Info.SugerirCobro, <T>CXP<T>, Cxp:Cxp.ID, Info.Importe))
ActivoCondicion=(Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y MovTipoEn(<T>Cxp<T>, Cxp:Cxp.Mov, (CXP.P, CXP.D, CXP.DM))

[Detalle.CxpD.InteresesOrdinariosQuita]
Carpeta=Detalle
Clave=CxpD.InteresesOrdinariosQuita
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.CxpD.InteresesMoratoriosQuita]
Carpeta=Detalle
Clave=CxpD.InteresesMoratoriosQuita
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[AC.Cxp.Comisiones]
Carpeta=AC
Clave=Cxp.Comisiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AC.Cxp.ComisionesIVA]
Carpeta=AC
Clave=Cxp.ComisionesIVA
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[AC.TotalComisiones]
Carpeta=AC
Clave=TotalComisiones
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[AC.LC.VigenciaDesde]
Carpeta=AC
Clave=LC.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Comentarios.Cxp.VIN]
Carpeta=Comentarios
Clave=Cxp.VIN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Retenciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Retenciones
Clave=Retenciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
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
CondicionVisible=Version.Peru y MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.P, CXP.ANC, CXP.ACA, CXP.NET))

[Retenciones.Cxp.Retencion]
Carpeta=Retenciones
Clave=Cxp.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Retenciones.Cxp.Retencion2]
Carpeta=Retenciones
Clave=Cxp.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Retenciones.Cxp.Retencion3]
Carpeta=Retenciones
Clave=Cxp.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>Cxp<T>)<BR>Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.Nombre, Cxp:Cxp.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=0
Menu=&Edición
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
RefrescarDespues=S
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.ID, Falso, Cxp:Cxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CXP<T>+Cxp:Cxp.ID)<BR>  Asigna(Info.Nombre, Cxp:Cxp.Mov+<T> <T>+Cxp:Cxp.MovID)<BR>  Asigna(Info.Modulo, <T>CXP<T>)<BR>  Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[AC.Cxp.TieneTasaEsp]
Carpeta=AC
Clave=Cxp.TieneTasaEsp
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[AC.Cxp.TasaEsp]
Carpeta=AC
Clave=Cxp.TasaEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.FormasAnexas]
Nombre=FormasAnexas
Boton=113
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F10
NombreDesplegar=Formas Anexas
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovFormaAnexo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)
DespuesGuardar=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel y (Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=(MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.F, CXP.A, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP, CXP.CD, CXP.DE, CXP.AJE, CXP.AJR, CXP.NCP, CXP.C, CXP.SD, CXP.SCH)) y <BR>(Cxp:Cxp.AplicaManual o ((Cxp:Cxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.NC, CXP.NCD, CXP.NCF, CXP.RA, CXP.FAC, CXP.DAC, CXP.PR))))

[Ficha.Cxp.ProveedorSucursal]
Carpeta=Ficha
Clave=Cxp.ProveedorSucursal
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Características
Clave=FormaExtraValor
Filtros=S
OtroOrden=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraValor
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroAplicaEn=FormaExtraCampo.Grupo
FiltroPredefinido=S
FiltroAutoCampo=FormaExtraCampo.Grupo
FiltroAutoValidar=FormaExtraCampo.Grupo
FiltroAutoOrden=FormaExtraCampo.Orden
FiltroGrupo1=FormaExtraCampo.Grupo
FiltroValida1=FormaExtraCampo.Grupo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CXP<T>, <T>{Cxp:Cxp.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CXP{Cxp:Cxp.ID}<T>

[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Negro
ColorFondo=Plata
IgnoraFlujo=N

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Negro
ColorFondo=Blanco
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=310
VerValor=304

[Detalle.CxpD.Retencion]
Carpeta=Detalle
Clave=CxpD.Retencion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.DineroDepositosAnticipados]
Nombre=DineroDepositosAnticipados
Boton=0
Menu=&Ver
NombreDesplegar=&Depósitos Anticipados Pendientes
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=DineroDepositosAnticipados
Activo=S
Visible=S

[DesgloseImpuestos.Columnas]
Impuesto1=64
Impuesto2=64
Impuesto3=72
Importe1=64
Importe2=64
Importe3=64
Retencion1=64
Retencion2=64
Retencion3=64
ContUso=124
ContUso2=124
ContUso3=124

[MovImpuesto]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Arrastre
Clave=MovImpuesto
Filtros=S
Detalle=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovImpuestoMov
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Cxp
LlaveLocal=MovImpuestoMov.ModuloID
LlaveMaestra=Cxp.ID
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaAcciones=PersonalVista

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=MovImpuestoMov.Modulo = <T>CXP<T>
CondicionVisible=((Cxp:Cxp.Estatus = EstatusConcluido) o (Cxp:Cxp.Estatus = EstatusCancelado)) y (Config.VisualizarArrastre)
[Acciones.PersonalVista]
Nombre=PersonalVista
Boton=0
NombreDesplegar=Personalizar vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[MovImpuesto.MovImpuestoMov.Impuesto1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Impuesto2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Impuesto3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Importe1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Importe2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Importe3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Retencion1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Retencion2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Retencion3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.ContUso]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.ContUso2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.ContUso3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovImpuesto.Columnas]
0=-2
1=-2

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
[Acciones.CargoNoIdentificado]
Nombre=CargoNoIdentificado
Boton=0
NombreDesplegar=Cargos No Identificados
EnMenu=S
TipoAccion=Formas
ClaveAccion=DineroCargosNoIdentificados
Activo=S
Visible=S
Menu=&Ver




[Ficha.ListaEnCaptura]
(Inicio)=Cxp.Mov
Cxp.Mov=Cxp.MovID
Cxp.MovID=Cxp.Proyecto
Cxp.Proyecto=Cxp.UEN
Cxp.UEN=Cxp.Moneda
Cxp.Moneda=Cxp.TipoCambio
Cxp.TipoCambio=Cxp.FechaEmision
Cxp.FechaEmision=Cxp.CtaDinero
Cxp.CtaDinero=Cxp.Cajero
Cxp.Cajero=Cxp.Proveedor
Cxp.Proveedor=Prov.Nombre
Prov.Nombre=Cxp.ProveedorSucursal
Cxp.ProveedorSucursal=Cxp.Importe
Cxp.Importe=Cxp.Impuestos
Cxp.Impuestos=ImporteTotal
ImporteTotal=Cxp.Concepto
Cxp.Concepto=Cxp.FormaPago
Cxp.FormaPago=Retenciones
Retenciones=Cxp.Referencia
Cxp.Referencia=Cxp.Condicion
Cxp.Condicion=Cxp.Vencimiento
Cxp.Vencimiento=Cxp.Observaciones
Cxp.Observaciones=Cxp.Saldo
Cxp.Saldo=Cxp.AplicaManual
Cxp.AplicaManual=Cxp.ProveedorMoneda
Cxp.ProveedorMoneda=Cxp.ProveedorTipoCambio
Cxp.ProveedorTipoCambio=CxpSaldo.Saldo
CxpSaldo.Saldo=(Fin)







[Aplica.ListaEnCaptura]
(Inicio)=Cxp.Proveedor
Cxp.Proveedor=Prov.Nombre
Prov.Nombre=Cxp.MovAplica
Cxp.MovAplica=Cxp.MovAplicaID
Cxp.MovAplicaID=CxpPendiente.Referencia
CxpPendiente.Referencia=CxpPendiente.FechaEmision
CxpPendiente.FechaEmision=CxpPendiente.Vencimiento
CxpPendiente.Vencimiento=(Fin)


[AC.ListaEnCaptura]
(Inicio)=Cxp.LineaCredito
Cxp.LineaCredito=LC.Descripcion
LC.Descripcion=LC.VigenciaDesde
LC.VigenciaDesde=LC.VigenciaHasta
LC.VigenciaHasta=Cxp.TipoAmortizacion
Cxp.TipoAmortizacion=TipoAmortizacion.Descripcion
TipoAmortizacion.Descripcion=Cxp.Condicion
Cxp.Condicion=Cxp.Vencimiento
Cxp.Vencimiento=Cxp.TipoTasa
Cxp.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=Cxp.TieneTasaEsp
Cxp.TieneTasaEsp=Cxp.TasaEsp
Cxp.TasaEsp=Cxp.Comisiones
Cxp.Comisiones=Cxp.ComisionesIVA
Cxp.ComisionesIVA=TotalComisiones
TotalComisiones=(Fin)

[Retenciones.ListaEnCaptura]
(Inicio)=Cxp.Retencion
Cxp.Retencion=Cxp.Retencion2
Cxp.Retencion2=Cxp.Retencion3
Cxp.Retencion3=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)


[Acciones.CPDesreservarFlujo]
Nombre=CPDesreservarFlujo
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+F
NombreDesplegar=<T>Desreservar Flujo...<T>
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CPCalMov
Antes=S
DespuesGuardar=S













ActivoCondicion=Cxp:MovTipo.ReservarCP=<T>Desreservar<T>
AntesExpresiones=Asigna(Info.PuedeEditar, Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))<BR>Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)<BR>Asigna(Info.Ejercicio, Año(Cxp:Cxp.FechaEmision))<BR>Asigna(Info.ClavePresupuestal, Nulo)<BR>Asigna(Info.Tipo, <T>Reduccion<T>)<BR>Asigna(Info.Importe, Cxp:ImporteTotal)
VisibleCondicion=General.CP












[Agrupadores]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agrupadores
Clave=Agrupadores
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=General.VerMovAgrupadores
[Agrupadores.Cxp.ContratoMov]
Carpeta=Agrupadores
Clave=Cxp.ContratoMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agrupadores.Cxp.ContratoMovID]
Carpeta=Agrupadores
Clave=Cxp.ContratoMovID
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agrupadores.ListaEnCaptura]
(Inicio)=Cxp.ContratoMov
Cxp.ContratoMov=Cxp.ContratoMovID
Cxp.ContratoMovID=(Fin)




[Comentarios.ListaEnCaptura]
(Inicio)=Cxp.Comentarios
Cxp.Comentarios=Cxp.Nota
Cxp.Nota=Cxp.VIN
Cxp.VIN=(Fin)







[CentrosCostos]
Estilo=Ficha
Pestana=S
Clave=CentrosCostos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
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

PestanaOtroNombre=S
PestanaNombre=Centros de Costo

CondicionVisible=(Config.ContUsoCxp) Y (Vacio(Cxp:Cxp.OrigenTipo))
[CentrosCostos.Cxp.ContUso]
Carpeta=CentrosCostos
Clave=Cxp.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CentrosCostos.Cxp.ContUso2]
Carpeta=CentrosCostos
Clave=Cxp.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CentrosCostos.Cxp.ContUso3]
Carpeta=CentrosCostos
Clave=Cxp.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122

[Acciones.SerieLoteConsignacionInfo]
Nombre=SerieLoteConsignacionInfo
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+C
NombreDesplegar=Información Corte &Consignación
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
Expresion=Caso  Cxp:Cxp.Estatus<BR>  Es EstatusBorrador     Entonces Forma(<T>SerieLoteConsignacionAuxTemp<T>)<BR>  Es EstatusSinAfectar   Entonces Forma(<T>SerieLoteConsignacionAuxTemp<T>)<BR>  Es EstatusPorConfirmar Entonces Forma(<T>SerieLoteConsignacionAuxTemp<T>)<BR>Sino<BR>  Forma(<T>SerieLoteConsignacionAux<T>)<BR>Fin
AntesExpresiones=Asigna(Info.ID,Cxp:Cxp.ID)<BR>Asigna(Info.Mov,Cxp:Cxp.Mov)<BR>Asigna(Info.MovID,Cxp:Cxp.MovID)
VisibleCondicion=(MovTipo(<T>CXP<T>,Cxp:Cxp.Mov) = CXP.D) Y ( fnSubMovTipo(<T>CXP<T>,Cxp:Cxp.Mov) = CXP.SLCCORTE)

[CorteConsignacion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Corte Consignación
Clave=CorteConsignacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
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
ListaEnCaptura=Cxp.ConsignacionFechaCorte
CondicionVisible=(MovTipo(<T>CXP<T>,Cxp:Cxp.Mov) = CXP.D) Y ( fnSubMovTipo(<T>CXP<T>,Cxp:Cxp.Mov) = CXP.SLCCORTE)

[CorteConsignacion.Cxp.ConsignacionFechaCorte]
Carpeta=CorteConsignacion
Clave=Cxp.ConsignacionFechaCorte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[CorteConsignacion.ListaEnCaptura]
(Inicio)=Cxp.ConsignacionFechaCorte
Cxp.ConsignacionFechaCorte=Cxp.ConsignacionSaldoInicialCorte
Cxp.ConsignacionSaldoInicialCorte=(Fin)

[Acciones.CorteConsignacionCalcular]
Nombre=CorteConsignacionCalcular
Boton=59
NombreDesplegar=&Calcular Corte Consignación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
















Expresion=Asigna(Temp.Numerico1,SQL(<T>SELECT ID FROM Cxp WHERE Mov = :tMov AND MovID = :tMovID<T>,Cxp:Cxp.Origen,Cxp:Cxp.OrigenID))<BR>EJECUTARSQL(<T>EXEC spCxpSLCCalcularCorte @@SPID, :nID, :nIDGenerar, :fFechaCorte<T>,Temp.Numerico1,Cxp:Cxp.ID,Cxp:Cxp.ConsignacionFechaCorte)<BR>ActualizarForma<BR>Forma.Accion(<T>Totalizar<T>)
ActivoCondicion=(MovTipo(<T>CXP<T>,Cxp:Cxp.Mov) = CXP.D) Y ( fnSubMovTipo(<T>CXP<T>,Cxp:Cxp.Mov) = CXP.SLCCORTE)

































[PorPagar.Columnas]
0=131
1=83
2=-2
3=-2
4=-2

[PagosPosfechados.Columnas]
0=155
1=83
2=-2
3=-2

[CompraPendiente.Columnas]
0=138
1=89
2=-2
3=-2

[Gastos.Columnas]
0=138
1=83
2=-2
3=-2

[Soporte.Columnas]
0=108
1=79
2=-2
3=-2

[Lista.Columnas]
0=116
1=266
2=-2
3=90
4=80
5=79
6=92
7=79
8=-2
















[CentrosCostos.ListaEnCaptura]
(Inicio)=Cxp.ContUso
Cxp.ContUso=Cxp.ContUso2
Cxp.ContUso2=Cxp.ContUso3
Cxp.ContUso3=(Fin)




[Detalle.ListaEnCaptura]
(Inicio)=CxpD.Aplica
CxpD.Aplica=CxpD.AplicaID
CxpD.AplicaID=CxpD.Importe
CxpD.Importe=DiferenciaNeta
DiferenciaNeta=DiferenciaPorcentaje
DiferenciaPorcentaje=CxpD.DescuentoRecargos
CxpD.DescuentoRecargos=DescuentoRecargosPorcentaje
DescuentoRecargosPorcentaje=DescuentoRecargosSugerido
DescuentoRecargosSugerido=CxpD.InteresesOrdinarios
CxpD.InteresesOrdinarios=CxpD.InteresesOrdinariosQuita
CxpD.InteresesOrdinariosQuita=CxpD.InteresesMoratorios
CxpD.InteresesMoratorios=CxpD.InteresesMoratoriosQuita
CxpD.InteresesMoratoriosQuita=CxpD.InteresesOrdinariosIVADescInfl
CxpD.InteresesOrdinariosIVADescInfl=CxpD.InteresesMoratoriosIVA
CxpD.InteresesMoratoriosIVA=CxpD.InteresesOrdinariosIVA
CxpD.InteresesOrdinariosIVA=CxpD.Retencion
CxpD.Retencion=ImporteIVAFiscal
ImporteIVAFiscal=ImporteIEPSFiscal
ImporteIEPSFiscal=CxpAplica.Referencia
CxpAplica.Referencia=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=CxpAplica.FechaEmision
CxpAplica.FechaEmision=CxpAplica.Vencimiento
CxpAplica.Vencimiento=CxpAplica.ImporteTotal
CxpAplica.ImporteTotal=SaldoNeto
SaldoNeto=CxpAplica.Moneda
CxpAplica.Moneda=(Fin)

[Detalle.ListaOrden]
(Inicio)=CxpD.Renglon	(Acendente)
CxpD.Renglon	(Acendente)=CxpD.RenglonSub	(Acendente)
CxpD.RenglonSub	(Acendente)=(Fin)

[Detalle.CxpD.InteresesOrdinariosIVADescInfl]
Carpeta=Detalle
Clave=CxpD.InteresesOrdinariosIVADescInfl
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.CxpD.InteresesMoratoriosIVA]
Carpeta=Detalle
Clave=CxpD.InteresesMoratoriosIVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.CxpD.InteresesOrdinariosIVA]
Carpeta=Detalle
Clave=CxpD.InteresesOrdinariosIVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S













[Emida]
Estilo=Ficha
Pestana=S
Clave=Emida
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco




PestanaOtroNombre=S
PestanaNombre=Emida



PermiteEditar=S






























ListaEnCaptura=(Lista)



FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CondicionVisible=General.InterfazEmida y(fnSubMovTipo(<T>CXP<T>, Cxp:Cxp.Mov) =<T>CXP.AEMIDA<T>)
[Emida.Cxp.EmidaCarrierID]
Carpeta=Emida
Clave=Cxp.EmidaCarrierID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco




[Emida.Columnas]
EmidaCarrierID=604




[Datos.Columnas]
CarrierId=71
Description=128
ProductCount=73














































[Emida.ListaEnCaptura]
(Inicio)=Cxp.EmidaCarrierID
Cxp.EmidaCarrierID=Cxp.EmidaRequestId
Cxp.EmidaRequestId=(Fin)

[Emida.Cxp.EmidaRequestId]
Carpeta=Emida
Clave=Cxp.EmidaRequestId
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco






















[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Cxp.Proveedor
Cxp.Proveedor=Cxp.Referencia
Cxp.Referencia=Cxp.Concepto
Cxp.Concepto=Cxp.FechaEmision
Cxp.FechaEmision=Cxp.Vencimiento
Cxp.Vencimiento=ImporteTotal
ImporteTotal=Cxp.Saldo
Cxp.Saldo=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=(por Autorizar)
(por Autorizar)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)







[MovImpuesto.ListaEnCaptura]
(Inicio)=MovImpuestoMov.Impuesto1
MovImpuestoMov.Impuesto1=MovImpuestoMov.Impuesto2
MovImpuestoMov.Impuesto2=MovImpuestoMov.Impuesto3
MovImpuestoMov.Impuesto3=MovImpuestoMov.Importe1
MovImpuestoMov.Importe1=MovImpuestoMov.Importe2
MovImpuestoMov.Importe2=MovImpuestoMov.Importe3
MovImpuestoMov.Importe3=MovImpuestoMov.Retencion1
MovImpuestoMov.Retencion1=MovImpuestoMov.Retencion2
MovImpuestoMov.Retencion2=MovImpuestoMov.Retencion3
MovImpuestoMov.Retencion3=MovImpuestoMov.ContUso
MovImpuestoMov.ContUso=MovImpuestoMov.ContUso2
MovImpuestoMov.ContUso2=MovImpuestoMov.ContUso3
MovImpuestoMov.ContUso3=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Retenciones
Retenciones=AC
AC=Aplica
Aplica=Comentarios
Comentarios=Detalle
Detalle=FormaExtraValor
FormaExtraValor=MovImpuesto
MovImpuesto=Agrupadores
Agrupadores=CentrosCostos
CentrosCostos=CorteConsignacion
CorteConsignacion=Emida
Emida=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=CopiarMeses
CopiarMeses=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=MovPersonal
MovPersonal=Evaluaciones
Evaluaciones=Propiedades
Propiedades=Imprimir
Imprimir=RepPantalla
RepPantalla=PlantillasOffice
PlantillasOffice=FormasAnexas
FormasAnexas=Excel
Excel=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Afectar
Afectar=Autorizar
Autorizar=Consecutivo
Consecutivo=Eliminar
Eliminar=Cancelar
Cancelar=Sugerir
Sugerir=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=CPDesreservarFlujo
CPDesreservarFlujo=Totalizar
Totalizar=MovExpress
MovExpress=Tareas
Tareas=Anexos
Anexos=ImporteConImpuestos
ImporteConImpuestos=Asistente Aplicacion
Asistente Aplicacion=AutoAplica
AutoAplica=Anticipos
Anticipos=Anterior
Anterior=Siguiente
Siguiente=Infomacion
Infomacion=TablaAmortizacion
TablaAmortizacion=DineroDepositosAnticipados
DineroDepositosAnticipados=CargoNoIdentificado
CargoNoIdentificado=InfoCtaDinero
InfoCtaDinero=ProyInfo
ProyInfo=SerieLoteConsignacionInfo
SerieLoteConsignacionInfo=GastoDiverso
GastoDiverso=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
MovPos=CorteConsignacionCalcular
CorteConsignacionCalcular=Navegador
Navegador=Cerrar
Cerrar=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
