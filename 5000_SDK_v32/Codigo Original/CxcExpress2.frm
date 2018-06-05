[Forma]
Clave=CxcExpress2
Nombre=Cuentas por cobrar
Icono=0
Modulos=CXC
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=494
PosicionInicialArriba=224
PosicionInicialAltura=408
PosicionInicialAncho=612
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsMovimiento=S
TituloAuto=S
DialogoAbrir=S
PosicionSeccion1=89
Totalizadores=S
PosicionSeccion2=93
MovModulo=CXC
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
ListaAcciones=(Lista)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaExclusiva=S
Menus=S
PosicionInicialAlturaCliente=374
IniciarAgregando=S
ExpresionesAlMostrar=Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.Copiar, Falso)<BR>Asigna(Def.CxImpuesto,  Si(ConDatos(Def.Importe), PorcentajeImporte(Def.Importe, Def.Impuestos), General.DefImpuesto))
ExpresionesAlCerrar=Asigna(Def.Mov, Nulo)<BR>Asigna(Def.Cliente, Nulo)<BR>Asigna(Def.EnviarA, Nulo)<BR>Asigna(Def.Agente, Nulo)<BR>Asigna(Def.Importe, Nulo)<BR>Asigna(Def.Impuestos, Nulo)<BR>Asigna(Def.Referencia, Nulo)<BR>Asigna(Def.Concepto, Nulo)<BR>Asigna(Def.Proyecto, Nulo)<BR>Asigna(Def.CxImpuesto, General.DefImpuesto)<BR>Asigna(Def.Moneda, Nulo)
PosicionSec1=288

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxc
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=80
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Azul marino
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.Cxc.Mov]
Carpeta=Ficha
Clave=Cxc.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[Ficha.Cxc.MovID]
Carpeta=Ficha
Clave=Cxc.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.Cxc.FechaEmision]
Carpeta=Ficha
Clave=Cxc.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Cxc.Concepto]
Carpeta=Ficha
Clave=Cxc.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Cxc.Proyecto]
Carpeta=Ficha
Clave=Cxc.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Cxc.Moneda]
Carpeta=Ficha
Clave=Cxc.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Cxc.Referencia]
Carpeta=Ficha
Clave=Cxc.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
EditarConBloqueo=S
ColorFondo=Blanco

[Ficha.Cxc.Observaciones]
Carpeta=Ficha
Clave=Cxc.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=53
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.Cxc.Cliente]
Carpeta=Ficha
Clave=Cxc.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco

[Ficha.Cxc.Condicion]
Carpeta=Ficha
Clave=Cxc.Condicion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Ficha.Cxc.Vencimiento]
Carpeta=Ficha
Clave=Cxc.Vencimiento
Editar=S
3D=S
Tamano=15
EditarConBloqueo=S
ColorFondo=Blanco

[Ficha.Cxc.Importe]
Carpeta=Ficha
Clave=Cxc.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=CxcA
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
ListaOrden=Cxc.ID<TAB>(Decendente)
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
FiltroFechasCampo=Cxc.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
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
FiltroAplicaEn=Cxc.ClienteMoneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
BusquedaEnLinea=S
IconosNombre=CxcA:Cxc.Mov+<T> <T>+CxcA:Cxc.MovID

[(Carpeta Abrir).Columnas]
0=138
1=84

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
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]

[Ficha.Cxc.Impuestos]
Carpeta=Ficha
Clave=Cxc.Impuestos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Ficha.Cxc.FormaCobro]
Carpeta=Ficha
Clave=Cxc.FormaCobro
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Cxc
LlaveLocal=CxcD.ID
LlaveMaestra=Cxc.ID
ControlRenglon=S
CampoRenglon=CxcD.Renglon
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
CondicionEdicion=(Cxc:Cxc.Estatus=EstatusSinAfectar) o (MovTipoEn(<T>CXC<T>,Cxc:Cxc.Mov, (CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.NCP)) y (Cxc:Cxc.Estatus=EstatusPendiente))
HojaFondoGrisAuto=S
PermiteLocalizar=S
HojaAjustarColumnas=S
PestanaOtroNombre=S
PestanaNombre=Aplicación
Pestana=S
CondicionVisible=ConDatos(Cxc:Cxc.Mov) y<BR>((MovTipo(<T>CXC<T>, Cxc:Cxc.Mov) noen (CXC.F, CXC.FA, CXC.AF, CXC.A, CXC.AR, CXC.AA, CXC.CA, CXC.CAD, CXC.CAP, CXC.VV, CXC.OV, CXC.CD, CXC.DE, CXC.DI, CXC.AJE, CXC.AJR)) y (Cxc:Cxc.AplicaManual o ((Cxc:Cxc.Estatus<>EstatusSinAfectar) y (MovTipo(<T>CXC<T>, Cxc:Cxc.Mov) noen (CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.NCP, CXC.RA, CXC.FAC, CXC.DAC)))) o<BR>(MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.IM, CXC.RM))))

[Detalle.CxcD.Importe]
Carpeta=Detalle
Clave=CxcD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CxcD.Aplica]
Carpeta=Detalle
Clave=CxcD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CxcD.AplicaID]
Carpeta=Detalle
Clave=CxcD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Columnas]
Importe=83
Aplica=98
AplicaID=66
Fecha=94
UsarProntoPago=89
DescuentoProntoPago=119
AplicaProntoPago=99
DiferenciaNeta=80
SaldoNeto=81
Referencia=79
Vencimiento=94
DiferenciaPorcentaje=36
DescuentoRecargos=104
DescuentoRecargosPorcentaje=32
DescuentoRecargosSugerido=62

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
Totalizadores2=Suma( CxcD:ImporteNeto )
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CondicionVisible=(MovTipo(<T>CXC<T>, Cxc:Cxc.Mov) noen (CXC.F, CXC.FA, CXC.AF, CXC.A, CXC.AR, CXC.AA, CXC.CA, CXC.CAD, CXC.CAP, CXC.VV, CXC.OV, CXC.CD, CXC.DE, CXC.DI, CXC.AJE, CXC.AJR)) y (Cxc:Cxc.AplicaManual o ((Cxc:Cxc.Estatus<>EstatusSinAfectar) y (MovTipo(<T>CXC<T>, Cxc:Cxc.Mov) noen (CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.NCP)))) o<BR>(MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.IM, CXC.RM)))

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

[Ficha.Cxc.AplicaManual]
Carpeta=Ficha
Clave=Cxc.AplicaManual
Editar=S
LineaNueva=S
3D=S
Tamano=15
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.Cxc.Cobrador]
Carpeta=Ficha
Clave=Cxc.Cobrador
Editar=S
3D=S
Tamano=15
ValidaNombre=N
Pegado=N
ColorFondo=Blanco

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=<T>&Afectar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S
GuardarAntes=S
ConCondicion=S
EspacioPrevio=S
Expresion=Asigna(Afectar.Modulo, <T>CXC<T>)<BR>Asigna(Afectar.ID, Cxc:Cxc.ID)<BR>Asigna(Afectar.Mov, Cxc:Cxc.Mov)<BR>Asigna(Afectar.MovID, Cxc:Cxc.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>CXC<T>, Cxc:Cxc.Mov))<BR>Asigna(Info.Cliente, Cxc:Cxc.Cliente)<BR>Asigna(Info.EnviarA, Cxc:Cxc.ClienteEnviarA)<BR>Asigna(Info.Referencia, Cxc:Cxc.Referencia)<BR>Asigna(Info.Saldo, Suma(CxcD:ImporteNeto)-Cxc:ImporteTotal)<BR>Si<BR>  Cxc:Cxc.Estatus=EstatusSinAfectar <BR>Entonces <BR>  Si<BR>    (Info.MovTipo en (CXC.C, CXC.D, CXC.DM)) y Cxc:Cxc.AplicaManual y (ABS(Info.Saldo) > Config.CxcAutoAjuste)<BR>  Entonces<BR>    Si(no Forma(<T>CxcAplicaDif<T>), AbortarOperacion)<BR>  Fin<BR>  Afectar(<T>CXC<T>, Cxc:Cxc.ID, Cxc:Cxc.Mov, Cxc:Cxc.MovID, <T>Todo<T>, <T><T>, <T>CxcExpress<T>)<BR>Sino<BR>  Asigna(Afectar.Modulo, <T>CXC<T>)<BR>  Asigna(Afectar.ID, Cxc:Cxc.ID)<BR>  Asigna(Afectar.Mov, Cxc:Cxc.Mov)<BR>  Asigna(Afectar.MovID, Cxc:Cxc.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Cxc<T>)<BR>  Asigna(Info.TituloDialogo, Cxc:Cxc.Mov+<T> <T>+Cxc:Cxc.MovID)<BR>  Caso Info.MovTipo<BR>    Es CXC.A   Entonces Dialogo(<T>GenerarCxcAnticipo<T>)<BR>    Es CXC.AR  Entonces Dialogo(<T>GenerarCxcAnticipo<T>)<BR>    Es CXC.NC  Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>    Es CXC.NCD Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>    Es CXC.DAC Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>    Es CXC.NCF Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>    Es CXC.DV Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>    Es CXC.NCP Entonces Asigna(Afectar.GenerarMov, ConfigMov.CxcAplicacion) Dialogo(<T>GenerarAplicacionCredito<T>)  <BR>    Es CXC.DP  Entonces Dialogo(<T>GenerarCxcCobroPosfechado<T>)<BR>    Sino Dialogo(<T>GenerarCxcCobro<T>)<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Cxc:Cxc.Usuario) y <BR>(Cxc:Cxc.Estatus=EstatusSinAfectar) y<BR>PuedeAvanzarEstatus(<T>CXC<T>, Cxc:Cxc.Mov, Cxc:Cxc.Estatus, FormaSituacion)
EjecucionCondicion=ConDatos(Cxc:Cxc.Mov)
Antes=S
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Cxc:Cxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CXC<T>, Cxc:Cxc.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CXC<T>, Cxc:Cxc.Mov, Cxc:Cxc.ID, Verdadero, Cxc:Cxc.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
DespuesGuardar=S

[Ficha.Cxc.Saldo]
Carpeta=Ficha
Clave=Cxc.Saldo
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

[(Carpeta Abrir).Cxc.Saldo]
Carpeta=(Carpeta Abrir)
Clave=Cxc.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Cxc.Vencimiento]
Carpeta=(Carpeta Abrir)
Clave=Cxc.Vencimiento
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
ClaveAccion=Asistente Cxc
ListaParametros1=Cxc:Cxc.Cliente<BR>Cxc:Cte.Nombre<BR>Cxc:ImporteTotal<BR>CxcD:CxcD.Aplica<BR>CxcD:CxcD.AplicaID<BR>CxcD:CxcD.Importe<BR>CxcD:CxcD.Fecha<BR>Cxc:Cxc.ClienteMoneda<BR>MovTipo(<T>CXC<T>, Cxc:Cxc.Mov)=CXC.IM<BR>MovTipo(<T>CXC<T>, Cxc:Cxc.Mov)=CXC.RM<BR>Cxc:Cxc.Importe
ListaParametros=S
Visible=S
ActivoCondicion=(Cxc:Cxc.AplicaManual y<BR>((MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.NC,CXC.NCD,CXC.NCF,CXC.DV,CXC.NCP,CXC.D,CXC.DM,CXC.DP,CXC.AE,CXC.ANC,CXC.ACA,CXC.C,CXC.A,CXC.AR)) y (Cxc:Cxc.Estatus=EstatusSinAfectar)) o<BR>(MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.NCP)) y (Cxc:Cxc.Estatus=EstatusPendiente)))) o <BR>(MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.IM,CXC.RM)) y (Cxc:Cxc.Estatus=EstatusSinAfectar))

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=43
ColorFondo=Plata
Efectos=[Negritas]
Pegado=N

[Ficha.CxcSaldo.Saldo]
Carpeta=Ficha
Clave=CxcSaldo.Saldo
Editar=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Azul marino
Efectos=[Negritas]

[Acciones.Informacion]
Nombre=Informacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información del Cliente
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=Si <BR>  ConDatos(Cxc:Cxc.Cliente)<BR>Entonces<BR>  Si <BR>    (Cxc:Cte.Tipo<><T>Deudor<T>) o Usuario.VerInfoDeudores<BR>  Entonces<BR>    Asigna( Info.Cliente,Cxc:Cxc.Cliente ) <BR>    Asigna(Info.Origen, <T>CXC<T>)<BR>    Forma( <T>CteInfo<T> )<BR>  Fin<BR>Fin
ActivoCondicion=Usuario.CteInfo

[Ficha.Cxc.TipoCambio]
Carpeta=Ficha
Clave=Cxc.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco

[Ficha.Cxc.ClienteMoneda]
Carpeta=Ficha
Clave=Cxc.ClienteMoneda
Editar=S
3D=S
Tamano=15
ColorFondo=Plata
ValidaNombre=S

[Ficha.Cxc.ConDesglose]
Carpeta=Ficha
Clave=Cxc.ConDesglose
Editar=S
3D=S
Tamano=21
ColorFondo=Blanco

[Ficha.Cxc.CtaDinero]
Carpeta=Ficha
Clave=Cxc.CtaDinero
Editar=S
3D=S
Tamano=15
ValidaNombre=S
ColorFondo=Blanco

[(Carpeta Abrir).Cxc.Referencia]
Carpeta=(Carpeta Abrir)
Clave=Cxc.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=Cxc
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
CondicionVisible=MovTipo(<T>CXC<T>, Cxc:Cxc.Mov) en (CXC.ANC, CXC.ACA, CXC.RA, CXC.FAC, CXC.DAC)

[Aplica.Cxc.MovAplica]
Carpeta=Aplica
Clave=Cxc.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Cxc.MovAplicaID]
Carpeta=Aplica
Clave=Cxc.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Cxc.Cliente]
Carpeta=Aplica
Clave=Cxc.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Cte.Nombre]
Carpeta=Aplica
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=55
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[(Carpeta Abrir).Cxc.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Cxc.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CxcD.Fecha]
Carpeta=Detalle
Clave=CxcD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Desglose]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Desglose del cobro
Clave=Desglose
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxc
Fuente={MS Sans Serif, 8, Negro, []}
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
CondicionVisible=(MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.C, CXC.A, CXC.AR, CXC.AA))) y Cxc:Cxc.ConDesglose

[Desglose.Cxc.Importe1]
Carpeta=Desglose
Clave=Cxc.Importe1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.FormaCobro1]
Carpeta=Desglose
Clave=Cxc.FormaCobro1
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Referencia1]
Carpeta=Desglose
Clave=Cxc.Referencia1
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Importe2]
Carpeta=Desglose
Clave=Cxc.Importe2
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.FormaCobro2]
Carpeta=Desglose
Clave=Cxc.FormaCobro2
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Referencia2]
Carpeta=Desglose
Clave=Cxc.Referencia2
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Importe3]
Carpeta=Desglose
Clave=Cxc.Importe3
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.FormaCobro3]
Carpeta=Desglose
Clave=Cxc.FormaCobro3
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Referencia3]
Carpeta=Desglose
Clave=Cxc.Referencia3
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Importe4]
Carpeta=Desglose
Clave=Cxc.Importe4
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.FormaCobro4]
Carpeta=Desglose
Clave=Cxc.FormaCobro4
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Referencia4]
Carpeta=Desglose
Clave=Cxc.Referencia4
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Importe5]
Carpeta=Desglose
Clave=Cxc.Importe5
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.FormaCobro5]
Carpeta=Desglose
Clave=Cxc.FormaCobro5
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Referencia5]
Carpeta=Desglose
Clave=Cxc.Referencia5
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Cxc.Cambio]
Carpeta=Desglose
Clave=Cxc.Cambio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.CobroTotal]
Carpeta=Desglose
Clave=CobroTotal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Desglose.Cxc.DelEfectivo]
Carpeta=Desglose
Clave=Cxc.DelEfectivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Cxc.Cliente]
Carpeta=(Carpeta Abrir)
Clave=Cxc.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Cxc.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Cxc.FechaEmision
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
ActivoCondicion=ConDatos(CxcA:Cxc.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, CxcA:Cxc.ID)
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

[Acciones.AbrirMostrar]
Nombre=AbrirMostrar
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

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

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
Expresion=Asigna(Info.Copiar, Falso)
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Antes=S
Visible=S
Menu=&Archivo
EnMenu=S
ActivoCondicion=(Cxc:Cxc.Estatus<>EstatusSinAfectar) y (no Cxc:Cxc.AplicaManual)
AntesExpresiones=Si<BR>  (MovTipo(<T>CXC<T>, Cxc:Cxc.Mov) noen (CXC.C, CXC.A, CXC.AR, CXC.AA, CXC.ANC, CXC.ACA, CXC.RA, CXC.FAC, CXC.DAC, CXC.AE, CXC.DE, CXC.DI, CXC.DC, CXC.AJE, CXC.AJR))<BR>Entonces<BR>  Asigna(Info.Mov, Cxc:Cxc.Mov)<BR>  Asigna(Info.MovID, Cxc:Cxc.MovID)<BR>  Asigna(Info.Copiar, Verdadero)<BR>Sino<BR>  Asigna(Info.Copiar, Falso)<BR>Fin

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
Menu=&Archivo
NombreDesplegar=Eliminar
Multiple=S
EnBarraHerramientas=S
EnMenu=S
ListaAccionesMultiples=Cancelar Cambios<BR>Expresion<BR>Cancelar
Visible=S
EspacioPrevio=S
ActivoCondicion=Cxc:Cxc.Estatus=EstatusSinAfectar

[Acciones.InfoCtaDinero]
Nombre=InfoCtaDinero
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+I
NombreDesplegar=Información de la Cuenta
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
Expresion=Asigna(Info.CtaDinero, Cxc:Cxc.CtaDinero)<BR>Forma(<T>CtaDineroInfo<T>)
ActivoCondicion=MovTipoEn(<T>CXC<T>,Cxc:Cxc.Mov, (CXC.C, CXC.DP, CXC.A, CXC.AR, CXC.AA, CXC.DE, CXC.DI, CXC.DC, CXC.CD)) y Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(Cxc:Cxc.CtaDinero)

[Ficha.Cxc.ClienteEnviarA]
Carpeta=Ficha
Clave=Cxc.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.CteEnviarA.Nombre]
Carpeta=Ficha
Clave=CteEnviarA.Nombre
ValidaNombre=N
3D=S
Tamano=27
ColorFondo=Plata

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
Expresion=Asigna(Info.Rama, <T>CXC<T>)<BR>Asigna(Info.Moneda, Cxc:Cxc.Moneda)<BR>Asigna(Info.Cuenta, Cxc:Cxc.Cliente)<BR>Si<BR>  Forma(<T>AnticipoPendiente<T>)<BR>Entonces<BR>  Asigna(Cxc:Cxc.Referencia, Info.Referencia)<BR>  Asigna(Cxc:Cxc.Importe, Info.Importe)<BR>Fin
ActivoCondicion=(Cxc:Cxc.Estatus=EstatusSinAfectar) y (MovTipo(<T>CXC<T>, Cxc:Cxc.Mov) = CXC.AA)
EjecucionCondicion=ConDatos(Cxc:Cxc.Cliente)

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
ActivoCondicion=ConDatos(Cxc:Cxc.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, Cxc:Cxc.ID)<BR>Asigna(Info.Mov, Cxc:Cxc.Mov)<BR>Asigna(Info.MovID, Cxc:Cxc.MovID)

[Detalle.DiferenciaPorcentaje]
Carpeta=Detalle
Clave=DiferenciaPorcentaje
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Detalle.CxcD.DescuentoRecargos]
Carpeta=Detalle
Clave=CxcD.DescuentoRecargos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Copiar]
Nombre=Copiar
Boton=0
NombreDesplegar=Copiar
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=F5
EnMenu=S
Expresion=Asigna( CxcD:CxcD.Importe, CxcD:SaldoNeto)<BR>Asigna( CxcD:CxcD.DescuentoRecargos, CxcD:DescuentoRecargosSugerido)
ActivoCondicion=Cxc:Cxc.Estatus=EstatusSinAfectar
Visible=S

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
Expresion=Asigna(Cxc:Cxc.Importe, Suma(CxcD:ImporteNeto))

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
ActivoCondicion=(no MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.F, CXC.FA, CXC.AF, CXC.CA, CXC.CAD, CXC.CAP, CXC.VV, CXC.OV, CXC.IM, CXC.RM))) y (Cxc:Cxc.AplicaManual o (Cxc:Cxc.Estatus=EstatusSinAfectar))

[Ficha.Cxc.Cajero]
Carpeta=Ficha
Clave=Cxc.Cajero
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

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
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CXC<T>, Cxc:Cxc.Mov, Cxc:Cxc.Estatus), Cxc:Cxc.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.Vales]
Nombre=Vales
Boton=96
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+L
NombreDesplegar=Va&les
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
ConCondicion=S
RefrescarDespues=S
Expresion=Si(Cxc:Cxc.Estatus=EstatusSinAfectar, Forma(<T>ValeSerieMov<T>), Forma(<T>ValeSerieMovInfo<T>))
ActivoCondicion=MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.A, CXC.AR, CXC.AA, CXC.C))
EjecucionCondicion=Asigna(Cxc:Cxc.ConDesglose, Verdadero) <BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, Cxc:Cxc.ID)<BR>Asigna(Info.Mov, Cxc:Cxc.Mov)<BR>Asigna(Info.MovID, Cxc:Cxc.MovID)<BR>Asigna(Info.Moneda, Cxc:Cxc.Moneda)

[Ficha.Cxc.Agente]
Carpeta=Ficha
Clave=Cxc.Agente
Editar=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Tareas
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
AntesExpresiones=Asigna(Info.PuedeEditar, Cxc:Cxc.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Cxc:Cxc.Mov)<BR>Asigna(Info.MovID, Cxc:Cxc.MovID)<BR>Asigna(Info.Proyecto, Cxc:Cxc.Proyecto)<BR>Asigna(Info.UEN, Cxc:Cxc.UEN)<BR>Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, Cxc:Cxc.ID)<BR><BR>Asigna(Info.Cliente, Cxc:Cxc.Cliente)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Cxc:Cxc.Cobrador)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Acciones.ImporteConImpuestos]
Nombre=ImporteConImpuestos
Boton=10
NombreDesplegar=&Importe con Impuestos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F6
Expresion=Asigna(Info.Importe, Cxc:ImporteTotal)<BR>Asigna(Info.PorcentajeImpuesto, ImpuestoZona(Redondea(Def.CxImpuesto, 8), Cxc:Cte.ZonaImpuesto, Cxc:Cxc.ClienteEnviarA, Cxc:CteEnviarA.ZonaImpuesto))<BR>Si<BR>  Forma(<T>EspecificarImporteConImpuestos<T>)<BR>Entonces<BR>  Asigna(Cxc:Cxc.Importe,  Redondea(Info.Importe/(1+(Info.PorcentajeImpuesto/100)), 4))<BR>  Asigna(Cxc:Cxc.Impuestos, Info.Importe-Cxc:Cxc.Importe)<BR>Fin
ActivoCondicion=(Cxc:Cxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y <BR>(MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.F,CXC.FA,CXC.AF,CXC.NC,CXC.CA,CXC.IM,CXC.RM,CXC.A,CXC.AR,CXC.AA,CXC.DE)) o <BR>(MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.C, CXC.CD)) y Config.CxcCobroImpuestos))

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CXC<T>, Cxc:Cxc.Mov, Cxc:Cxc.ID, Falso, Cxc:Cxc.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CXC<T>+Cxc:Cxc.ID)<BR>  Asigna(Info.Nombre, Cxc:Cxc.Mov+<T> <T>+Cxc:Cxc.MovID)<BR>  Asigna(Info.Modulo, <T>CXC<T>)<BR>  Asigna(Info.Mov, Cxc:Cxc.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Cxc:Cxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CXC<T>, <T>{Cxc:Cxc.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CXC{Cxc:Cxc.ID}<T>

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
VerCampo=305
VerValor=265

[Acciones.Tarjetas]
Nombre=Tarjetas
Boton=64
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+K
NombreDesplegar=Tar&jetas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConCondicion=S
Antes=S
GuardarAntes=S
RefrescarDespues=S
DespuesGuardar=S
Expresion=Si(Cxc:Cxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>TarjetaSerieMov<T>), Forma(<T>TarjetaSerieMovInfo<T>))
ActivoCondicion=MovTipoEn(<T>CXC<T>, Cxc:Cxc.Mov, (CXC.A, CXC.AR, CXC.AA, CXC.C, CXC.DC, CXC.DE))
EjecucionCondicion=Asigna(Cxc:Cxc.ConDesglose, Verdadero) <BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, Cxc:Cxc.ID)<BR>Asigna(Info.Mov, Cxc:Cxc.Mov)<BR>Asigna(Info.MovID, Cxc:Cxc.MovID)<BR>Asigna(Info.Moneda, Cxc:Cxc.Moneda)




[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Cxc.Cliente
Cxc.Cliente=Cxc.Referencia
Cxc.Referencia=Cxc.Concepto
Cxc.Concepto=Cxc.FechaEmision
Cxc.FechaEmision=Cxc.Vencimiento
Cxc.Vencimiento=ImporteTotal
ImporteTotal=Cxc.Saldo
Cxc.Saldo=(Fin)

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
AbrirExcel=AbrirMostrar
AbrirMostrar=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=CxcD.Aplica
CxcD.Aplica=CxcD.AplicaID
CxcD.AplicaID=CxcD.Fecha
CxcD.Fecha=CxcD.Importe
CxcD.Importe=DiferenciaNeta
DiferenciaNeta=DiferenciaPorcentaje
DiferenciaPorcentaje=CxcD.DescuentoRecargos
CxcD.DescuentoRecargos=DescuentoRecargosPorcentaje
DescuentoRecargosPorcentaje=DescuentoRecargosSugerido
DescuentoRecargosSugerido=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=CxcAplica.FechaEmision
CxcAplica.FechaEmision=CxcAplica.Vencimiento
CxcAplica.Vencimiento=CxcAplica.Referencia
CxcAplica.Referencia=CxcAplica.ImporteTotal
CxcAplica.ImporteTotal=SaldoNeto
SaldoNeto=(Fin)

[Detalle.ListaOrden]
(Inicio)=CxcD.Renglon<TAB>(Acendente)
CxcD.Renglon<TAB>(Acendente)=CxcD.RenglonSub<TAB>(Acendente)
CxcD.RenglonSub<TAB>(Acendente)=(Fin)

[Aplica.ListaEnCaptura]
(Inicio)=Cxc.Cliente
Cxc.Cliente=Cte.Nombre
Cte.Nombre=Cxc.MovAplica
Cxc.MovAplica=Cxc.MovAplicaID
Cxc.MovAplicaID=(Fin)

[Desglose.ListaEnCaptura]
(Inicio)=Cxc.Importe1
Cxc.Importe1=Cxc.FormaCobro1
Cxc.FormaCobro1=Cxc.Referencia1
Cxc.Referencia1=Cxc.Importe2
Cxc.Importe2=Cxc.FormaCobro2
Cxc.FormaCobro2=Cxc.Referencia2
Cxc.Referencia2=Cxc.Importe3
Cxc.Importe3=Cxc.FormaCobro3
Cxc.FormaCobro3=Cxc.Referencia3
Cxc.Referencia3=Cxc.Importe4
Cxc.Importe4=Cxc.FormaCobro4
Cxc.FormaCobro4=Cxc.Referencia4
Cxc.Referencia4=Cxc.Importe5
Cxc.Importe5=Cxc.FormaCobro5
Cxc.FormaCobro5=Cxc.Referencia5
Cxc.Referencia5=Cxc.DelEfectivo
Cxc.DelEfectivo=Cxc.Cambio
Cxc.Cambio=CobroTotal
CobroTotal=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)






[Ficha.ListaEnCaptura]
(Inicio)=Cxc.Mov
Cxc.Mov=Cxc.MovID
Cxc.MovID=Cxc.Proyecto
Cxc.Proyecto=Cxc.Moneda
Cxc.Moneda=Cxc.TipoCambio
Cxc.TipoCambio=Cxc.FechaEmision
Cxc.FechaEmision=Cxc.CtaDinero
Cxc.CtaDinero=Cxc.Cajero
Cxc.Cajero=Cxc.Cliente
Cxc.Cliente=Cte.Nombre
Cte.Nombre=Cxc.ClienteEnviarA
Cxc.ClienteEnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=Cxc.Agente
Cxc.Agente=Cxc.Importe
Cxc.Importe=Cxc.Impuestos
Cxc.Impuestos=ImporteTotal
ImporteTotal=Cxc.Concepto
Cxc.Concepto=Cxc.FormaCobro
Cxc.FormaCobro=Cxc.Cobrador
Cxc.Cobrador=Cxc.Referencia
Cxc.Referencia=Cxc.Condicion
Cxc.Condicion=Cxc.Vencimiento
Cxc.Vencimiento=Cxc.Observaciones
Cxc.Observaciones=Cxc.Saldo
Cxc.Saldo=Cxc.AplicaManual
Cxc.AplicaManual=Cxc.ConDesglose
Cxc.ConDesglose=Cxc.ClienteMoneda
Cxc.ClienteMoneda=CxcSaldo.Saldo
CxcSaldo.Saldo=(Fin)




[PedidoReferencia]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pedido Referencia
Clave=PedidoReferencia
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxc
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
ListaEnCaptura=Cxc.PedidoReferencia
CarpetaVisible=S

[PedidoReferencia.Cxc.PedidoReferencia]
Carpeta=PedidoReferencia
Clave=Cxc.PedidoReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Desglose
Desglose=Aplica
Aplica=Detalle
Detalle=FormaExtraValor
FormaExtraValor=PedidoReferencia
PedidoReferencia=(Fin)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Afectar
Afectar=Imprimir
Imprimir=Cancelar
Cancelar=Totalizar
Totalizar=CamposExtras
CamposExtras=Tareas
Tareas=Vales
Vales=Tarjetas
Tarjetas=ImporteConImpuestos
ImporteConImpuestos=Asistente Aplicacion
Asistente Aplicacion=Anticipos
Anticipos=Informacion
Informacion=InfoCtaDinero
InfoCtaDinero=MovPos
MovPos=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=(Fin)
