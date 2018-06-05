[Forma]
Clave=CxpExpress
Nombre=Cuentas por pagar
Icono=0
Modulos=CXP
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=313
PosicionInicialArriba=325
PosicionInicialAltura=370
PosicionInicialAncho=653
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
PosicionSeccion1=88
Totalizadores=S
PosicionSeccion2=93
MovModulo=CXP
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
IniciarAgregando=S
VentanaExclusiva=S
PosicionInicialAlturaCliente=346
ExpresionesAlMostrar=Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.Copiar, Falso)<BR>Asigna(Def.CxImpuesto,  Si(ConDatos(Def.Importe), PorcentajeImporte(Def.Importe, Def.Impuestos), General.DefImpuesto))
ExpresionesAlCerrar=Asigna(Def.Mov, Nulo)<BR>Asigna(Def.Proveedor, Nulo)<BR>Asigna(Def.Importe, Nulo)<BR>Asigna(Def.Impuestos, Nulo)<BR>Asigna(Def.Referencia, Nulo)<BR>Asigna(Def.Concepto, Nulo)<BR>Asigna(Def.Proyecto, Nulo)<BR>Asigna(Def.CxImpuesto, General.DefImpuesto)<BR>Asigna(Def.Moneda, Nulo)
PosicionSec1=259

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
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Proyecto]
Carpeta=Ficha
Clave=Cxp.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.Moneda]
Carpeta=Ficha
Clave=Cxp.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
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
EditarConBloqueo=S
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
Tamano=15
EditarConBloqueo=S
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
FiltroFechasCampo=Cxp.FechaEmision
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
FiltroFechasNormal=S
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
FiltroAplicaEn=Cxp.ProveedorMoneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CxpA:Cxp.Mov+<T> <T>+CxpA:Cxp.MovID

[(Carpeta Abrir).Columnas]
0=135
1=79

[Ficha.ImporteTotal]
Carpeta=Ficha
Clave=ImporteTotal
Editar=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

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

[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
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
CondicionEdicion=(Cxp:Cxp.Estatus=EstatusSinAfectar) o (MovTipoEn(<T>CXP<T>,Cxp:Cxp.Mov, (CXP.NC, CXP.NCD, CXP.NCF, CXP.NCP)) y (Cxp:Cxp.Estatus=EstatusPendiente))
HojaFondoGrisAuto=S
PermiteLocalizar=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Aplicación
CondicionVisible=(MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.F, CXP.A, CXP.AA, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP, CXP.CD, CXP.DE, CXP.AJE, CXP.AJR)) y (Cxp:Cxp.AplicaManual o ((Cxp:Cxp.Estatus<>EstatusSinAfectar) y (MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.NC, CXP.NCD, CXP.NCF, CXP.NCP, CXP.RA, CXP.FAC, CXP.DAC))))

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
ColorFuente=Negro

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
ColorFuente=Negro

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
ColorFuente=Negro

[Detalle.Columnas]
Importe=98
Aplica=96
AplicaID=74
AplicaProntoPago=96
DiferenciaNeta=85
DiferenciaPorcentaje=39
DescuentoRecargos=104
DescuentoRecargosPorcentaje=29
DescuentoRecargosSugerido=58
ImporteNeto=64

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=4
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total
Totalizadores2=Suma(CxpD:ImporteNeto)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CondicionVisible=(MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.F, CXP.A, CXP.AA, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP, CXP.CD, CXP.DE, CXP.AJE, CXP.AJR)) y (Cxp:Cxp.AplicaManual o ((Cxp:Cxp.Estatus<>EstatusSinAfectar) y (MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.NC, CXP.NCD, CXP.NCF, CXP.NCP))))

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

Expresion=Asigna(Afectar.Modulo, <T>CXP<T>)<BR>Asigna(Afectar.ID, Cxp:Cxp.ID)<BR>Asigna(Afectar.Mov, Cxp:Cxp.Mov)<BR>Asigna(Afectar.MovID, Cxp:Cxp.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>CXP<T>, Cxp:Cxp.Mov))<BR>Asigna(Info.Referencia, Cxp:Cxp.Referencia)<BR>Asigna(Info.Saldo, Suma(CxpD:ImporteNeto)-Cxp:ImporteTotal)<BR>Si<BR>  Cxp:Cxp.Estatus=EstatusSinAfectar <BR>Entonces <BR>  Si<BR>    (Info.MovTipo en (CXP.P, CXP.D, CXP.DM, CXP.PAG)) y Cxp:Cxp.AplicaManual y (ABS(Info.Saldo) > Config.CxpAutoAjuste)<BR>  Entonces<BR>    Si(no Forma(<T>CxpAplicaDif<T>), AbortarOperacion)<BR>  Fin<BR>  Afectar(<T>CXP<T>, Cxp:Cxp.ID, Cxp:Cxp.Mov, Cxp:Cxp.MovID, <T>Todo<T>, <T><T>, <T>CxpExpress<T>)<BR>Sino<BR>  Asigna(Afectar.FormaCaptura, <T>Cxp<T>)<BR>  Asigna(Info.TituloDialogo, Cxp:Cxp.Mov+<T> <T>+Cxp:Cxp.MovID)<BR>  Caso Info.MovTipo<BR>    Es CXP.A   Entonces Dialogo(<T>GenerarCxpAnticipo<T>)<BR>    Es CXP.NC  Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>    Es CXP.NCD Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>    Es CXP.DAC Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>    Es CXP.NCF Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>    Es CXP.NCP Entonces Asigna(Afectar.GenerarMov, ConfigMov.CxpAplicacionPago) Dialogo(<T>GenerarAplicacionCredito<T>)  <BR>    Es CXP.DP  Entonces Dialogo(<T>GenerarCxpPagoPosfechado<T>)<BR>    Sino Dialogo(<T>GenerarCxpPago<T>)<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Cxp:Cxp.Usuario) y<BR>(Cxp:Cxp.Estatus=EstatusSinAfectar) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Cxp:Cxp.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Cxp:Cxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CXP<T>, Cxp:Cxp.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.ID, Verdadero, Cxp:Cxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
[Ficha.Cxp.Saldo]
Carpeta=Ficha
Clave=Cxp.Saldo
Editar=N
ValidaNombre=N
3D=S
Tamano=15
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
ColorFuente=Negro

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
ColorFuente=Negro

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
ActivoCondicion=Cxp:Cxp.Estatus=EstatusSinAfectar

[(Carpeta Abrir).Cxp.Vencimiento]
Carpeta=(Carpeta Abrir)
Clave=Cxp.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

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
EspacioPrevio=S
ActivoCondicion=Cxp:Cxp.AplicaManual y<BR>((MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.NC,CXP.NCD,CXP.NCF,CXP.NCP,CXP.D,CXP.DM,CXP.PAG,CXP.DP,CXP.AE,CXP.ANC,CXP.ACA,CXP.P,CXP.A)) y (Cxp:Cxp.Estatus=EstatusSinAfectar)) o<BR> (MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.NC,CXP.NCD,CXP.NCF,CXP.NCP)) y (Cxp:Cxp.Estatus=EstatusPendiente)))

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
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
ActivoCondicion=Cxp:Cxp.Estatus=EstatusSinAfectar

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=45
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
Tamano=15
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
ConCondicion=
Visible=S
Expresion=Si<BR>  ConDatos(Cxp:Cxp.Proveedor) <BR>Entonces<BR>  Si<BR>    (Cxp:Prov.Tipo<><T>Acreedor<T>) o Usuario.VerInfoAcreedores<BR>  Entonces<BR>    Asigna( Info.Proveedor,Cxp:Cxp.Proveedor ) <BR>    Asigna(Info.Origen, <T>Cxp<T>)<BR>    Forma( <T>ProvInfo<T> )<BR>  Fin<BR>Fin

[Ficha.Cxp.TipoCambio]
Carpeta=Ficha
Clave=Cxp.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cxp.ProveedorMoneda]
Carpeta=Ficha
Clave=Cxp.ProveedorMoneda
Editar=S
3D=S
Tamano=15
ColorFondo=Plata
ValidaNombre=S
ColorFuente=Negro

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
TeclaRapida=Mayús+Ctrl+I
Expresion=Asigna(Info.CtaDinero, Cxp:Cxp.CtaDinero)<BR>Forma(<T>CtaDineroInfo<T>)
ActivoCondicion=MovTipoEn(<T>CXP<T>,Cxp:Cxp.Mov,(CXP.P, CXP.DP, CXP.A, CXP.AA, CXP.DE, CXP.DC, CXP.CD)) y Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(Cxp:Cxp.CtaDinero)

[Aplica]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Crédito a Aplicar
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
CampoColorFondo=Plata
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
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Cxp.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Cxp.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[(Carpeta Abrir).Cxp.Proveedor]
Carpeta=(Carpeta Abrir)
Clave=Cxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Cxp.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Cxp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Activo=S
Visible=S

[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.AbrirExcel]
Nombre=AbrirExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

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

[Detalle.DiferenciaNeta]
Carpeta=Detalle
Clave=DiferenciaNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Eliminar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Eliminar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Seleccionar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnMenu=S
Visible=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Antes=S
ActivoCondicion=(Cxp:Cxp.Estatus<>EstatusSinAfectar) y (no Cxp:Cxp.AplicaManual)
AntesExpresiones=Si<BR>  (MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) noen (CXP.P, CXP.A, CXP.AA, CXP.ANC, CXP.ACA, CXP.RA, CXP.FAC, CXP.DAC, CXP.AE, CXP.DE, CXP.DC, CXP.AJE, CXP.AJR))<BR>Entonces<BR>  Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>  Asigna(Info.MovID, Cxp:Cxp.MovID)<BR>  Asigna(Info.Copiar, Verdadero)<BR>Sino<BR>  Asigna(Info.Copiar, Falso)<BR>Fin

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
ActivoCondicion=(Cxp:Cxp.Estatus=EstatusSinAfectar) y (MovTipo(<T>CXP<T>, Cxp:Cxp.Mov) = CXP.AA)
EjecucionCondicion=ConDatos(Cxp:Cxp.Proveedor)

[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posición del Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPos
Antes=S
Visible=S
EspacioPrevio=S
ActivoCondicion=ConDatos(Cxp:Cxp.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)<BR>Asigna(Info.Mov, Cxp:Cxp.Mov)<BR>Asigna(Info.MovID, Cxp:Cxp.MovID)

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
ColorFuente=Negro

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

[Acciones.Totalizar]
Nombre=Totalizar
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Totalizar
Multiple=S
EnMenu=S
ListaAccionesMultiples=TotalizarPost<BR>TotalizarCopiar
Visible=S
ActivoCondicion=(no MovTipoEn(<T>CXP<T>, Cxp:Cxp.Mov, (CXP.F, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP))) y (Cxp:Cxp.AplicaManual o (Cxp:Cxp.Estatus=EstatusSinAfectar))

[Acciones.Totalizar.TotalizarCopiar]
Nombre=TotalizarCopiar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Cxp:Cxp.Importe, Suma(CxpD:ImporteNeto))

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir...
EnMenu=S
TipoAccion=Expresion
Visible=S
EnBarraHerramientas=S
EspacioPrevio=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CXP<T>, Cxp:Cxp.Mov, Cxp:Cxp.Estatus), Cxp:Cxp.ID)
ActivoCondicion=Usuario.ImprimirMovs

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
VerCampo=320
VerValor=291




[Ficha.ListaEnCaptura]
(Inicio)=Cxp.Mov
Cxp.Mov=Cxp.MovID
Cxp.MovID=Cxp.Proyecto
Cxp.Proyecto=Cxp.Moneda
Cxp.Moneda=Cxp.TipoCambio
Cxp.TipoCambio=Cxp.FechaEmision
Cxp.FechaEmision=Cxp.CtaDinero
Cxp.CtaDinero=Cxp.Proveedor
Cxp.Proveedor=Prov.Nombre
Prov.Nombre=Cxp.Importe
Cxp.Importe=Cxp.Impuestos
Cxp.Impuestos=ImporteTotal
ImporteTotal=Cxp.Concepto
Cxp.Concepto=Cxp.FormaPago
Cxp.FormaPago=Cxp.Referencia
Cxp.Referencia=Cxp.Condicion
Cxp.Condicion=Cxp.Vencimiento
Cxp.Vencimiento=Cxp.Observaciones
Cxp.Observaciones=Cxp.Saldo
Cxp.Saldo=Cxp.AplicaManual
Cxp.AplicaManual=Cxp.ProveedorMoneda
Cxp.ProveedorMoneda=CxpSaldo.Saldo
CxpSaldo.Saldo=(Fin)

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
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=CxpD.Aplica
CxpD.Aplica=CxpD.AplicaID
CxpD.AplicaID=CxpD.Importe
CxpD.Importe=DiferenciaNeta
DiferenciaNeta=DiferenciaPorcentaje
DiferenciaPorcentaje=CxpD.DescuentoRecargos
CxpD.DescuentoRecargos=DescuentoRecargosPorcentaje
DescuentoRecargosPorcentaje=DescuentoRecargosSugerido
DescuentoRecargosSugerido=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=CxpAplica.FechaEmision
CxpAplica.FechaEmision=CxpAplica.Vencimiento
CxpAplica.Vencimiento=CxpAplica.Referencia
CxpAplica.Referencia=CxpAplica.ImporteTotal
CxpAplica.ImporteTotal=SaldoNeto
SaldoNeto=(Fin)

[Detalle.ListaOrden]
(Inicio)=CxpD.Renglon<TAB>(Acendente)
CxpD.Renglon<TAB>(Acendente)=CxpD.RenglonSub<TAB>(Acendente)
CxpD.RenglonSub<TAB>(Acendente)=(Fin)

[Aplica.ListaEnCaptura]
(Inicio)=Cxp.Proveedor
Cxp.Proveedor=Prov.Nombre
Prov.Nombre=Cxp.MovAplica
Cxp.MovAplica=Cxp.MovAplicaID
Cxp.MovAplicaID=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Aplica
Aplica=Detalle
Detalle=FormaExtraValor
FormaExtraValor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Afectar
Afectar=Imprimir
Imprimir=Eliminar
Eliminar=Totalizar
Totalizar=CamposExtras
CamposExtras=Tareas
Tareas=Asistente Aplicacion
Asistente Aplicacion=Anticipos
Anticipos=Infomacion
Infomacion=InfoCtaDinero
InfoCtaDinero=MovPos
MovPos=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=(Fin)
