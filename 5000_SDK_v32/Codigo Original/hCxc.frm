[Forma]
Clave=hCxc
Nombre=<T>Histórico Cuentas por cobrar<T>
Icono=0
Modulos=CXC
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=350
PosicionInicialArriba=68
PosicionInicialAltura=580
PosicionInicialAncho=665
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
EsMovimiento=S
TituloAuto=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DialogoAbrir=S
ListaAcciones=(Lista)
PosicionSeccion1=60
Totalizadores=S
PosicionSeccion2=93
MovModulo=CXC
PosicionColumna3=50
BarraAyudaBold=S
VentanaBloquearAjuste=N
BarraAyuda=S
PosicionInicialAlturaCliente=553
BarraHerramientas=S
ExpresionesAlMostrar=Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Def.CxImpuesto, General.DefImpuesto)
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
PosicionSec1=295
PosicionSec2=454
EsConsultaExclusiva=S
TituloAutoNombre=S

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hCxc
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=80
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

[Ficha.hCxc.Mov]
Carpeta=Ficha
Clave=hCxc.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.MovID]
Carpeta=Ficha
Clave=hCxc.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.hCxc.FechaEmision]
Carpeta=Ficha
Clave=hCxc.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.Concepto]
Carpeta=Ficha
Clave=hCxc.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Ficha.hCxc.Proyecto]
Carpeta=Ficha
Clave=hCxc.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=16
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.hCxc.Moneda]
Carpeta=Ficha
Clave=hCxc.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.Referencia]
Carpeta=Ficha
Clave=hCxc.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.Observaciones]
Carpeta=Ficha
Clave=hCxc.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.hCxc.Cliente]
Carpeta=Ficha
Clave=hCxc.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.Condicion]
Carpeta=Ficha
Clave=hCxc.Condicion
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.Vencimiento]
Carpeta=Ficha
Clave=hCxc.Vencimiento
Editar=S
3D=S
Tamano=20
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.Importe]
Carpeta=Ficha
Clave=hCxc.Importe
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
Vista=hCxcA
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
ListaOrden=hCxc.ID<TAB>(Decendente)
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
FiltroFechasCampo=hCxc.Vencimiento
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
FiltroAplicaEn=hCxc.Moneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
BusquedaEnLinea=S
FiltroFechasCancelacion=hCxc.FechaCancelacion
FiltroSucursales=S
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
IconosNombre=hCxcA:hCxc.Mov+<T> <T>+hCxcA:hCxc.MovID
FiltroGeneral={Si(ConDatos(Filtro.Mov), <T>hCxc.Mov=<T>+Comillas(Filtro.Mov), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Cliente), <T> AND hCxc.Cliente=<T>+Comillas(Filtro.Cliente), <T><T>)}

[(Carpeta Abrir).Columnas]
0=177
1=86

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
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
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

[Ficha.hCxc.Impuestos]
Carpeta=Ficha
Clave=hCxc.Impuestos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.FormaCobro]
Carpeta=Ficha
Clave=hCxc.FormaCobro
Editar=S
ValidaNombre=S
3D=S
Tamano=17
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
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=hCxcD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=hCxc
LlaveLocal=hCxcD.ID
LlaveMaestra=hCxc.ID
ControlRenglon=S
CampoRenglon=hCxcD.Renglon
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
CondicionEdicion=(hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) o (MovTipoEn(<T>CXC<T>,hCxc:hCxc.Mov, (CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.NCP)) y (hCxc:hCxc.Estatus=EstatusPendiente))
HojaFondoGrisAuto=S
PermiteLocalizar=S
HojaAjustarColumnas=S

CondicionVisible=ConDatos(hCxc:hCxc.Mov) y<BR>((MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) noen (CXC.F, CXC.A, CXC.DFA, CXC.AR, CXC.FA, CXC.AF, CXC.CA, CXC.CAD, CXC.CAP, CXC.VV, CXC.OV, CXC.AV, CXC.CD, CXC.DE, CXC.DI, CXC.AJE, CXC.AJR, CXC.NCP)) y (hCxc:hCxc.AplicaManual o ((hCxc:hCxc.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) noen (CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.RA, CXC.FAC, CXC.DAC, CXC.PR, CXC.SD, CXC.SCH)))) o<BR>(MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.IM, CXC.RM))))
[Detalle.hCxcD.Importe]
Carpeta=Detalle
Clave=hCxcD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.hCxcD.Aplica]
Carpeta=Detalle
Clave=hCxcD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.hCxcD.AplicaID]
Carpeta=Detalle
Clave=hCxcD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.Columnas]
Importe=83
Aplica=117
AplicaID=66
Fecha=94
UsarProntoPago=89
DescuentoProntoPago=119
AplicaProntoPago=99
DiferenciaNeta=80
SaldoNeto=81
Referencia=79
Vencimiento=94
ProntoPago=117
DiferenciaPorcentaje=38
DescuentoRecargos=104
DescuentoRecargosSugerido=64
DescuentoRecargosPorcentaje=38
ImporteIVAFiscal=64
ProporcionRetencion=53
ImporteIEPSFiscal=64
InteresesOrdinarios=69
InteresesMoratorios=75
InteresesOrdinariosQuita=47
InteresesMoratoriosQuita=44
ImpuestoAdicionalNeto=94

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
Totalizadores1=Total<BR>IVA
Totalizadores2=Suma( hCxcD:ImporteNeto )<BR>Suma(hCxcD:ImporteIVAFiscal)
Totalizadores3=(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CondicionVisible=ConDatos(hCxc:hCxc.Mov) y<BR>((MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) noen (CXC.F, CXC.A, CXC.DFA, CXC.AR, CXC.FA, CXC.AF, CXC.CA, CXC.CAD, CXC.CAP, CXC.VV, CXC.OV, CXC.AV, CXC.CD, CXC.DE, CXC.DI, CXC.AJE, CXC.AJR, CXC.NCP, CXC.SD, CXC.SCH)) y <BR>(hCxc:hCxc.AplicaManual o ((hCxc:hCxc.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) noen (CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.RA, CXC.PR)))) o<BR>(MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.IM, CXC.RM))))

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

[Ficha.hCxc.AplicaManual]
Carpeta=Ficha
Clave=hCxc.AplicaManual
Editar=S
LineaNueva=S
3D=S
Tamano=15
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
Expresion=Asigna(Afectar.Modulo, <T>CXC<T>)<BR>Asigna(Afectar.ID, hCxc:hCxc.ID)<BR>Asigna(Afectar.Mov, hCxc:hCxc.Mov)<BR>Asigna(Afectar.MovID, hCxc:hCxc.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>CXC<T>, hCxc:hCxc.Mov))<BR>Asigna(Info.Cliente, hCxc:hCxc.Cliente)<BR>Asigna(Info.EnviarA, hCxc:hCxc.ClienteEnviarA)<BR>Asigna(Info.Agente, hCxc:Cte.Agente)<BR>Asigna(Info.Referencia, hCxc:hCxc.Referencia)<BR>Asigna(Info.Saldo, Suma(hCxcD:ImporteNeto)-hCxc:ImporteTotal)<BR>Si<BR>  hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar) <BR>Entonces <BR>  Si<BR>    (Info.MovTipo en (CXC.C, CXC.D, CXC.DM, CXC.NC, CXC.NCD, CXC.NCF, CXC.ANC, CXC.ACA, CXC.AE)) y hCxc:hCxc.AplicaManual y (ABS(Info.Saldo) > Config.CxcAutoAjuste)<BR>  Entonces<BR>    Si(no Forma(<T>CxcAplicaDif<T>), AbortarOperacion)<BR>  Fin<BR>  Afectar(<T>CXC<T>, hCxc:hCxc.ID, hCxc:hCxc.Mov, hCxc:hCxc.MovID, <T>Todo<T>, <T><T>, <T>Cxc<T>)<BR>Sino<BR>  Asigna(Info.Modulo, <T>CXC<T>)<BR>  Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>  Asigna(Info.MovID, hCxc:hCxc.MovID)<BR>  Asigna(Afectar.Modulo, <T>CXC<T>)<BR>  Asigna(Afectar.ID, hCxc:hCxc.ID)<BR>  Asigna(Afectar.Mov, hCxc:hCxc.Mov)<BR>  Asigna(Afectar.MovID, hCxc:hCxc.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Cxc<T>)<BR>  Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si <BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Caso Info.MovTipo<BR>      Es CXC.A   Entonces Dialogo(<T>GenerarCxcAnticipo<T>)<BR>      Es CXC.AR  Entonces Dialogo(<T>GenerarCxcAnticipo<T>)<BR>      Es CXC.DA  Entonces Dialogo(<T>GenerarCxcDocumentoAnticipo<T>)<BR>      Es CXC.NC  Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>      Es CXC.DAC Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>      Es CXC.NCD Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>      Es CXC.NCF Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>      Es CXC.DV Entonces Dialogo(<T>GenerarCxcNCredito<T>)<BR>      Es CXC.NCP Entonces Asigna(Afectar.GenerarMov, ConfigMov.CxcAplicacion) Dialogo(<T>GenerarAplicacionCredito<T>)  <BR>      Es CXC.DP  Entonces Dialogo(<T>GenerarCxcCobroPosfechado<T>)<BR>      Sino Dialogo(<T>GenerarCxcCobro<T>)<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hCxc:hCxc.Usuario) y <BR>((hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) o ((hCxc:hCxc.Estatus=EstatusPendiente) y MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.F, CXC.FA, CXC.AF, CXC.CA, CXC.CAD, CXC.CAP, CXC.VV, CXC.OV, CXC.IM, CXC.RM, CXC.D, CXC.DM, CXC.DP, CXC.CD, CXC.A, CXC.AR, CXC.DA, CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.NCP, CXC.FAC, CXC.DAC))))  y<BR>PuedeAvanzarEstatus(<T>CXC<T>, hCxc:hCxc.Mov, hCxc:hCxc.Estatus, FormaSituacion)
EjecucionCondicion=ConDatos(hCxc:hCxc.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CXC<T>, hCxc:hCxc.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CXC<T>, hCxc:hCxc.Mov, hCxc:hCxc.ID, Verdadero, hCxc:hCxc.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn

[Ficha.hCxc.Saldo]
Carpeta=Ficha
Clave=hCxc.Saldo
Editar=N
ValidaNombre=N
3D=S
Tamano=20
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

[(Carpeta Abrir).hCxc.Saldo]
Carpeta=(Carpeta Abrir)
Clave=hCxc.Saldo
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
Expresion=Asigna( hCxcD:hCxcD.Importe, hCxcD:SaldoNeto)<BR>Asigna( hCxcD:hCxcD.DescuentoRecargos, hCxcD:DescuentoRecargosSugerido)
ActivoCondicion=hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[(Carpeta Abrir).hCxc.Vencimiento]
Carpeta=(Carpeta Abrir)
Clave=hCxc.Vencimiento
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
ListaParametros1=hCxc:hCxc.Cliente<BR>hCxc:Cte.Nombre<BR>hCxc:ImporteTotal<BR>hCxcD:hCxcD.Aplica<BR>hCxcD:hCxcD.AplicaID<BR>hCxcD:hCxcD.Importe<BR>hCxcD:hCxcD.Fecha<BR>hCxc:hCxc.ClienteMoneda<BR>MovTipo(<T>CXC<T>, hCxc:hCxc.Mov)=CXC.IM<BR>MovTipo(<T>CXC<T>, hCxc:hCxc.Mov)=CXC.RM<BR>hCxc:hCxc.Importe
ListaParametros=S
Visible=S
ActivoCondicion=(hCxc:hCxc.AplicaManual y<BR>((MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.NC,CXC.NCD, CXC.NCF,CXC.DV,CXC.NCP,CXC.D,CXC.DM,CXC.DP,CXC.AE,CXC.ANC,CXC.ACA,CXC.C,CXC.A,CXC.AR,CXC.AJM,CXC.AJA,CXC.NET)) y (hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))) o<BR>(MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.NCP)) y (hCxc:hCxc.Estatus=EstatusPendiente)))) o <BR>(MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.IM,CXC.RM)) y (hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))) y<BR>(hCxc:hCxc.Moneda=hCxc:hCxc.ClienteMoneda)

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
ActivoCondicion=Vacio(hCxc:hCxc.MovID) y (hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, hCxc:hCxc.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Cxc WHERE ID=:nID<T>, hCxc:hCxc.ID))
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
ListaParametros1=hCxc:hCxc.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>hCXC<T>, hCxc:hCxc.Mov, hCxc:hCxc.Estatus), hCxc:hCxc.ID)
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
ListaParametros1=hCxc:hCxc.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CXC<T>, hCxc:hCxc.Mov, hCxc:hCxc.Estatus), hCxc:hCxc.ID)
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
Multiple=S
ListaAccionesMultiples=TotalizarPost<BR>TotalizarCopiar
ActivoCondicion=(no MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.F, CXC.FA, CXC.AF, CXC.CA, CXC.CAD, CXC.CAP, CXC.VV, CXC.OV, CXC.IM, CXC.RM))) y (hCxc:hCxc.AplicaManual o (hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)))
VisibleCondicion=hCxc:hCxc.AplicaManual

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

Expresion=Cancelar(<T>CXC<T>, hCxc:hCxc.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Cxc<T>)
ActivoCondicion=//PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, hCxc:hCxc.Usuario) y ConDatos(hCxc:hCxc.ID) y ConDatos(hCxc:hCxc.MovID) y<BR>//(hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusSincro, EstatusConcluido, EstatusPendiente))
AntesExpresiones=Asigna( Afectar.Mov, hCxc:hCxc.Mov ) <BR>Asigna( Afectar.MovID, hCxc:hCxc.MovID )
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
Expresion=Verificar(<T>CXC<T>, hCxc:hCxc.ID,hCxc:hCxc.Mov,hCxc:hCxc.MovID)
ActivoCondicion=hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(hCxc:hCxc.Mov)

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=29
ColorFondo=Plata
Efectos=[Negritas]
Pegado=N
ColorFuente=Negro

[Ficha.CxcSaldo.Saldo]
Carpeta=Ficha
Clave=CxcSaldo.Saldo
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Azul marino
Efectos=[Negritas]

[Acciones.Infomacion]
Nombre=Infomacion
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
Expresion=Si <BR>  ConDatos(hCxc:hCxc.Cliente)<BR>Entonces<BR>  Si <BR>    (hCxc:Cte.Tipo<><T>Deudor<T>) o Usuario.VerInfoDeudores<BR>  Entonces<BR>    Asigna( Info.Cliente,hCxc:hCxc.Cliente ) <BR>    Asigna(Info.Origen, <T>CXC<T>)<BR>    Forma( <T>CteInfo<T> )<BR>  Fin<BR>Fin
ActivoCondicion=Usuario.CteInfo

[Ficha.hCxc.TipoCambio]
Carpeta=Ficha
Clave=hCxc.TipoCambio
Editar=S
3D=S
Tamano=10
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.ClienteMoneda]
Carpeta=Ficha
Clave=hCxc.ClienteMoneda
Editar=S
3D=S
Tamano=11
ValidaNombre=S
ColorFuente=Negro
Pegado=S
ColorFondo=Blanco

[Ficha.hCxc.ConDesglose]
Carpeta=Ficha
Clave=hCxc.ConDesglose
Editar=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxc.CtaDinero]
Carpeta=Ficha
Clave=hCxc.CtaDinero
Editar=S
3D=S
Tamano=13
ValidaNombre=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Acciones.InfoCtaDinero]
Nombre=InfoCtaDinero
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+I
NombreDesplegar=Información de la Cuenta
EnMenu=S
TipoAccion=Expresion
Visible=S
ConCondicion=S
Expresion=Asigna(Info.CtaDinero, hCxc:hCxc.CtaDinero)<BR>Forma(<T>CtaDineroInfo<T>)
ActivoCondicion=MovTipoEn(<T>CXC<T>,hCxc:hCxc.Mov, (CXC.C, CXC.DP, CXC.NCP, CXC.A, CXC.AR, CXC.AA, CXC.DE, CXC.DI, CXC.DC, CXC.CD)) y Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(hCxc:hCxc.CtaDinero)

[(Carpeta Abrir).hCxc.Referencia]
Carpeta=(Carpeta Abrir)
Clave=hCxc.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=hCxc
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
CondicionVisible=MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) en (CXC.ANC, CXC.ACA, CXC.RA, CXC.FAC, CXC.DAC)

[Aplica.hCxc.MovAplica]
Carpeta=Aplica
Clave=hCxc.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.hCxc.MovAplicaID]
Carpeta=Aplica
Clave=hCxc.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Aplica.hCxc.Cliente]
Carpeta=Aplica
Clave=hCxc.Cliente
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

[(Carpeta Abrir).hCxc.Concepto]
Carpeta=(Carpeta Abrir)
Clave=hCxc.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
ActivoCondicion=ConDatos(hCxc:hCxc.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)

[Acciones.DepositosAnticipados]
Nombre=DepositosAnticipados
Boton=0
Menu=&Ver
NombreDesplegar=&Depósitos Anticipados Pendientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=DineroDepositosAnticipados
Activo=S
Visible=S
EspacioPrevio=S

[Detalle.hCxcD.Fecha]
Carpeta=Detalle
Clave=hCxcD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
Vista=hCxc
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
CondicionVisible=(MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.C, CXC.A, CXC.AR, CXC.AA, CXC.DE, CXC.CAP))) y hCxc:hCxc.ConDesglose

[Desglose.hCxc.Importe1]
Carpeta=Desglose
Clave=hCxc.Importe1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.FormaCobro1]
Carpeta=Desglose
Clave=hCxc.FormaCobro1
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Referencia1]
Carpeta=Desglose
Clave=hCxc.Referencia1
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Importe2]
Carpeta=Desglose
Clave=hCxc.Importe2
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.FormaCobro2]
Carpeta=Desglose
Clave=hCxc.FormaCobro2
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Referencia2]
Carpeta=Desglose
Clave=hCxc.Referencia2
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Importe3]
Carpeta=Desglose
Clave=hCxc.Importe3
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.FormaCobro3]
Carpeta=Desglose
Clave=hCxc.FormaCobro3
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Referencia3]
Carpeta=Desglose
Clave=hCxc.Referencia3
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Importe4]
Carpeta=Desglose
Clave=hCxc.Importe4
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.FormaCobro4]
Carpeta=Desglose
Clave=hCxc.FormaCobro4
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Referencia4]
Carpeta=Desglose
Clave=hCxc.Referencia4
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Importe5]
Carpeta=Desglose
Clave=hCxc.Importe5
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.FormaCobro5]
Carpeta=Desglose
Clave=hCxc.FormaCobro5
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Referencia5]
Carpeta=Desglose
Clave=hCxc.Referencia5
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.hCxc.Cambio]
Carpeta=Desglose
Clave=hCxc.Cambio
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

[Desglose.hCxc.DelEfectivo]
Carpeta=Desglose
Clave=hCxc.DelEfectivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Antes=S
Visible=S
ActivoCondicion=(ConfigModulo(<T>CXC<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>PuedeAvanzarSituacion(<T>CXC<T>, hCxc:hCxc.Mov, hCxc:hCxc.Estatus, FormaSituacion)
AntesExpresiones=Si(Vacio(hCxc:hCxc.ID),GuardarCambios)

[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
ActivoCondicion=ConfigModulo(<T>CXC<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(hCxc:hCxc.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)

[(Carpeta Abrir).hCxc.Cliente]
Carpeta=(Carpeta Abrir)
Clave=hCxc.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).hCxc.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=hCxc.FechaEmision
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
ActivoCondicion=ConDatos(hCxcA:hCxc.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxcA:hCxc.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Usuario, hCxc:hCxc.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(hCxc:hCxc.ID)

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
AntesExpresiones=Asigna(Info.Rama, <T>CXC<T>)<BR>Asigna(Info.Fecha, hCxc:hCxc.FechaEmision)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hCxc:hCxc.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, hCxc:hCxc.Mov+<T> <T>+hCxc:hCxc.MovID)
RefrescarDespues=S

[Acciones.AgregarEvento]
Nombre=AgregarEvento
Boton=56
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=Agregar &Evento
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacoraAgregar
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=hCxc:hCxc.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(hCxc:hCxc.Usuario)
EjecucionCondicion=Si(Vacio(hCxc:hCxc.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)

[Acciones.MovBitacora]
Nombre=MovBitacora
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+B
NombreDesplegar=Bitácora
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacora
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=Si(Vacio(hCxc:hCxc.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)<BR>Asigna(Info.PuedeEditar, hCxc:hCxc.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(hCxc:hCxc.Usuario))

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(hCxc:hCxc.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)
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
Expresion=CopiarMovimiento(<T>CXC<T>, hCxc:hCxc.ID, <T>Cxc<T>)

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
TipoAccion=Expresion
ListaAccionesMultiples=CxcExpress<BR>Agregar<BR>Expresion
Visible=S
Antes=S
ActivoCondicion=Usuario.CxcMovExpress y (hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y hCxc:hCxc.AplicaManual
AntesExpresiones=Asigna(Def.Cliente, hCxc:hCxc.Cliente)<BR>Asigna(Def.EnviarA, hCxc:hCxc.ClienteEnviarA)<BR>Asigna(Def.Agente, hCxc:hCxc.Agente)

[Acciones.MovExpress.Agregar]
Nombre=Agregar
Boton=0
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Info.Copiar

[Acciones.MovExpress.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=Asigna(hCxcD:hCxcD.Aplica, Info.Mov)<BR>Asigna(hCxcD:hCxcD.AplicaID, Info.MovID)
EjecucionCondicion=Info.Copiar

[Acciones.MovExpress.CxcExpress]
Nombre=CxcExpress
Boton=0
TipoAccion=Formas
ClaveAccion=CxcExpress
Activo=S
Visible=S

[Ficha.hCxc.ClienteEnviarA]
Carpeta=Ficha
Clave=hCxc.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Ficha.CteEnviarA.Nombre]
Carpeta=Ficha
Clave=CteEnviarA.Nombre
Editar=S
3D=S
Tamano=29
ColorFondo=Plata
ColorFuente=Negro
Pegado=N

[Acciones.AfectarLote]
Nombre=AfectarLote
Boton=0
NombreDesplegar=<T>&Afectar Selección<T>
RefrescarIconos=S
EnLote=S
EnMenu=S
TipoAccion=Expresion
Expresion=Afectar(<T>Cxc<T>, hCxcA:hCxc.ID, hCxcA:hCxc.Mov, hCxcA:hCxc.MovID, <T>Todo<T>, <T><T>, <T>Cxc<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hCxcA:hCxc.Usuario)
VisibleCondicion=Usuario.AfectarLote

[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Seleccionar &Todo
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
VisibleCondicion=Usuario.AfectarLote

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
ClaveAccion=CxcCampos
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)
VisibleCondicion=hCxc:hCxc.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.Embarcar]
Nombre=Embarcar
Boton=0
Menu=&Archivo
NombreDesplegar=E&mbarcar...
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)<BR>Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.Estatus, hCxc:hCxc.Estatus)<BR>Dialogo(<T>MovEmbarcar<T>)
ActivoCondicion=hCxc:hCxc.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusSincro, EstatusCancelado) y (no FormaBloqueada)

[Ficha.hCxc.ClienteTipoCambio]
Carpeta=Ficha
Clave=hCxc.ClienteTipoCambio
Editar=S
3D=S
Pegado=S
Tamano=6
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(hCxc:hCxc.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino

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
NombreDesplegar=Anticipos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F7
Expresion=Asigna(Info.Rama, <T>CXC<T>)<BR>Asigna(Info.Moneda, hCxc:hCxc.Moneda)<BR>Asigna(Info.Cuenta, hCxc:hCxc.Cliente)<BR>Si<BR>  Forma(<T>AnticipoPendiente<T>)<BR>Entonces<BR>  Asigna(hCxc:hCxc.Referencia, Info.Referencia)<BR>  Si<BR>    hCxc:hCxc.ConDesglose<BR>  Entonces<BR>    Asigna(hCxc:hCxc.Importe1, Info.Importe)<BR>  Sino<BR>    Asigna(hCxc:hCxc.Impuestos, Info.Importe-QuitarPorcentaje(Info.Importe, Def.CxImpuesto))<BR>    Asigna(hCxc:hCxc.Importe, Info.Importe-hCxc:hCxc.Impuestos)<BR>  Fin<BR>Fin
ActivoCondicion=(hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) = CXC.AA)
EjecucionCondicion=ConDatos(hCxc:hCxc.Cliente)

[Acciones.Vales]
Nombre=Vales
Boton=96
Menu=&Edición
UsaTeclaRapida=S
NombreDesplegar=Va&les
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
TeclaRapida=Ctrl+L
EspacioPrevio=S
RefrescarDespues=S
Expresion=Si(hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>ValeSerieMov<T>), Forma(<T>ValeSerieMovInfo<T>))
ActivoCondicion=MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.A, CXC.AR, CXC.AA, CXC.C))
ConCondicion=S
EjecucionCondicion=Asigna(hCxc:hCxc.ConDesglose, Verdadero) <BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)<BR>Asigna(Info.Moneda, hCxc:hCxc.Moneda)

[Detalle.DiferenciaPorcentaje]
Carpeta=Detalle
Clave=DiferenciaPorcentaje
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Detalle.hCxcD.DescuentoRecargos]
Carpeta=Detalle
Clave=hCxcD.DescuentoRecargos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.DescuentoRecargosSugerido]
Carpeta=Detalle
Clave=DescuentoRecargosSugerido
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Detalle.DescuentoRecargosPorcentaje]
Carpeta=Detalle
Clave=DescuentoRecargosPorcentaje
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Totalizar.TotalizarCopiar]
Nombre=TotalizarCopiar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>  hCxc:hCxc.AplicaManual y MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.C, CXC.CD, CXC.D, CXC.DM)) y Config.CxcCobroImpuestos<BR>Entonces<BR>  Asigna(hCxc:hCxc.Importe, Suma(hCxcD:ImporteNeto)-Suma(hCxcD:ImporteIVAFiscal))<BR>  Asigna(hCxc:hCxc.Impuestos, Suma(hCxcD:ImporteIVAFiscal))<BR>Sino<BR>  Asigna(hCxc:hCxc.Importe, Suma(hCxcD:ImporteNeto) / (1+(Si(MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.F,CXC.FA,CXC.AF,CXC.NC,CXC.CA,CXC.IM,CXC.RM)), (ImpuestoZona(General.DefImpuesto, hCxc:Cte.ZonaImpuesto, hCxc:hCxc.ClienteEnviarA, hCxc:CteEnviarA.ZonaImpuesto)/100), 0))))<BR>Fin

[Acciones.Totalizar.TotalizarPost]
Nombre=TotalizarPost
Boton=0
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Afectar
Activo=S
Visible=S

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
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>CXC<T>, hCxc:hCxc.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(hCxc:hCxc.MovID) y PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hCxc:hCxc.Usuario)

[Ficha.hCxc.Cajero]
Carpeta=Ficha
Clave=hCxc.Cajero
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.hCxc.Agente]
Carpeta=Ficha
Clave=hCxc.Agente
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N

[Aplica.CxcPendiente.Referencia]
Carpeta=Aplica
Clave=CxcPendiente.Referencia
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Aplica.CxcPendiente.FechaEmision]
Carpeta=Aplica
Clave=CxcPendiente.FechaEmision
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=12
Pegado=S

[Aplica.CxcPendiente.Vencimiento]
Carpeta=Aplica
Clave=CxcPendiente.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=12
Pegado=S

[Detalle.ImporteIVAFiscal]
Carpeta=Detalle
Clave=ImporteIVAFiscal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.hCxc.UEN]
Carpeta=Ficha
Clave=hCxc.UEN
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
Antes=S
Visible=S
EjecucionCondicion=ConDatos(hCxc:hCxc.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, hCxc:hCxc.Proyecto)

[Ficha.hCxc.PersonalCobrador]
Carpeta=Ficha
Clave=hCxc.PersonalCobrador
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProporcionRetencion]
Carpeta=Detalle
Clave=ProporcionRetencion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

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
Expresion=Asigna(Info.Importe, hCxc:ImporteTotal)<BR>Asigna(Info.PorcentajeImpuesto, ImpuestoZona(Redondea(Def.CxImpuesto, 8), hCxc:Cte.ZonaImpuesto, hCxc:hCxc.ClienteEnviarA, hCxc:CteEnviarA.ZonaImpuesto))<BR>Si<BR>  Forma(<T>EspecificarImporteConImpuestos<T>)<BR>Entonces<BR>  Asigna(hCxc:hCxc.Importe,  Redondea(Info.Importe/(1+(Info.PorcentajeImpuesto/100)), 4))<BR>  Asigna(hCxc:hCxc.Impuestos, Info.Importe-hCxc:hCxc.Importe)<BR>Fin
ActivoCondicion=(hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y <BR>(MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.F,CXC.FA,CXC.AF,CXC.NC,CXC.CA,CXC.IM,CXC.RM,CXC.A,CXC.AR,CXC.AA,CXC.DE)) o <BR>(MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.C, CXC.CD)) y Config.CxcCobroImpuestos))

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.Clave, <T>CXC<T>+hCxc:hCxc.ID)<BR>Asigna(Info.Nombre, hCxc:hCxc.Mov+<T> <T>+hCxc:hCxc.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(hCxc:hCxc.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

[Ficha.hCxc.FechaOriginal]
Carpeta=Ficha
Clave=hCxc.FechaOriginal
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CopiarMeses]
Nombre=CopiarMeses
Boton=0
Menu=&Archivo
NombreDesplegar=Copiar en Meses...
GuardarAntes=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)<BR>Si(no Forma(<T>MovCopiarMeses<T>),  AbortarOperacion)
DespuesGuardar=S
Visible=S

[Acciones.AnticiposFacturados]
Nombre=AnticiposFacturados
Boton=0
Menu=&Edición
NombreDesplegar=Anticipos Facturados...
EnMenu=S
TipoAccion=Expresion
GuardarAntes=S
RefrescarDespues=S
Expresion=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Cliente, hCxc:hCxc.Cliente)<BR>Asigna(Info.Nombre, hCxc:Cte.Nombre)<BR>Forma(<T>CxcAnticiposPendientes<T>)
ActivoCondicion=hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=Config.CxcAnticiposFacturados y (MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) = CXC.DFA)

[Detalle.ImporteIEPSFiscal]
Carpeta=Detalle
Clave=ImporteIEPSFiscal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

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
AntesExpresiones=Asigna(Info.PuedeEditar, hCxc:hCxc.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)<BR>Asigna(Info.Proyecto, hCxc:hCxc.Proyecto)<BR>Asigna(Info.UEN, hCxc:hCxc.UEN)<BR>Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR><BR>Asigna(Info.Cliente, hCxc:hCxc.Cliente)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, hCxc:hCxc.Cobrador)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
Vista=hCxc
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

[Comentarios.hCxc.Comentarios]
Carpeta=Comentarios
Clave=hCxc.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=89x12
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios.hCxc.Nota]
Carpeta=Comentarios
Clave=hCxc.Nota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=47
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)<BR>Asigna(Info.Fecha, hCxc:hCxc.FechaEmision)<BR>Asigna(Info.Estatus, hCxc:hCxc.Estatus)

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
EjecucionCondicion=ConDatos(hCxc:hCxc.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CXC<T>)<BR>Asigna(Info.Clave, hCxc:hCxc.Mov)

[Acciones.PoliticaConcepto]
Nombre=PoliticaConcepto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+O
NombreDesplegar=Política Co&ncepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(hCxc:hCxc.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.Concepto, hCxc:hCxc.Concepto)

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
Vista=hCxc
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
CondicionVisible=General.AC y MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.F,CXC.CA,CXC.CAP,CXC.CAD,CXC.D,CXC.DM))

[AC.hCxc.LineaCredito]
Carpeta=AC
Clave=hCxc.LineaCredito
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
LineaNueva=N
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

[AC.hCxc.TipoAmortizacion]
Carpeta=AC
Clave=hCxc.TipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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

[AC.hCxc.TipoTasa]
Carpeta=AC
Clave=hCxc.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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

[AC.hCxc.Condicion]
Carpeta=AC
Clave=hCxc.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[AC.hCxc.Vencimiento]
Carpeta=AC
Clave=hCxc.Vencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
Menu=&Archivo
NombreDesplegar=&Sugerir
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
Expresion=Asigna(Info.Importe, Vacio(hCxc:ImporteTotal, Nulo))<BR>Asigna(Info.Acreditado, hCxc:hCxc.Cliente)<BR>Si(Forma(<T>SugerirCobro<T>), EjecutarSQL(<T>spSugerirCobro :tSugerir, :tModulo, :nID, :nTotal<T>, Info.SugerirCobro, <T>CXC<T>, hCxc:hCxc.ID, Info.Importe))
ActivoCondicion=(hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.C, CXC.D, CXC.DM))

[Acciones.TablaAmortizacion]
Nombre=TablaAmortizacion
Boton=88
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+M
NombreDesplegar=Tabla Amortización
TipoAccion=Formas
ClaveAccion=TablaAmortizacionCxc
Antes=S
ActivoCondicion=hCxc:hCxc.Amortizaciones>0
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)

[Detalle.hCxcD.InteresesOrdinarios]
Carpeta=Detalle
Clave=hCxcD.InteresesOrdinarios
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCxcD.InteresesMoratorios]
Carpeta=Detalle
Clave=hCxcD.InteresesMoratorios
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCxcD.InteresesOrdinariosQuita]
Carpeta=Detalle
Clave=hCxcD.InteresesOrdinariosQuita
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCxcD.InteresesMoratoriosQuita]
Carpeta=Detalle
Clave=hCxcD.InteresesMoratoriosQuita
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[AC.hCxc.Comisiones]
Carpeta=AC
Clave=hCxc.Comisiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AC.hCxc.ComisionesIVA]
Carpeta=AC
Clave=hCxc.ComisionesIVA
Editar=S
LineaNueva=N
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

[Acciones.Voucher]
Nombre=Voucher
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+V
NombreDesplegar=&Voucher
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CxcVoucher
Activo=S
Antes=S
DespuesGuardar=S
RefrescarDespues=S
AntesExpresiones=Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Cliente, hCxc:hCxc.Cliente)<BR>Asigna(Info.Moneda, hCxc:hCxc.Moneda)<BR>Asigna(Info.Importe, hCxc:ImporteTotal)<BR>Asigna(Info.Estatus, hCxc:hCxc.Estatus)
VisibleCondicion=MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) = CXC.C

[VIN.hCxc.VIN]
Carpeta=VIN
Clave=hCxc.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios.hCxc.VIN]
Carpeta=Comentarios
Clave=hCxc.VIN
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios.hCxc.ContUso]
Carpeta=Comentarios
Clave=hCxc.ContUso
Editar=S
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
Expresion=Asigna(Info.Forma, <T>Cxc<T>)<BR>Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.Nombre, hCxc:hCxc.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CXC<T>, hCxc:hCxc.Mov, hCxc:hCxc.ID, Falso, hCxc:hCxc.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CXC<T>+hCxc:hCxc.ID)<BR>  Asigna(Info.Nombre, hCxc:hCxc.Mov+<T> <T>+hCxc:hCxc.MovID)<BR>  Asigna(Info.Modulo, <T>CXC<T>)<BR>  Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[AC.hCxc.TieneTasaEsp]
Carpeta=AC
Clave=hCxc.TieneTasaEsp
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[AC.hCxc.TasaEsp]
Carpeta=AC
Clave=hCxc.TasaEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ImpuestoAdicionalNeto]
Carpeta=Detalle
Clave=ImpuestoAdicionalNeto
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.ACRecorrerVencimiento]
Nombre=ACRecorrerVencimiento
Boton=0
Menu=&Archivo
NombreDesplegar=Recorrer &Vencimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=ACRecorrerVencimiento
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)
VisibleCondicion=General.AC y (hCxc:hCxc.Estatus=EstatusConcluido)

[Acciones.ACBajaParcial]
Nombre=ACBajaParcial
Boton=0
Menu=&Archivo
NombreDesplegar=&Baja Parcial
EnMenu=S
TipoAccion=Formas
ClaveAccion=ACBajaParcial
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)
VisibleCondicion=General.AC y (hCxc:hCxc.Estatus=EstatusConcluido)

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
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=ConDatos(hCxc:hCxc.Mov) y<BR>((MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) noen (CXC.F, CXC.A, CXC.DFA, CXC.AR, CXC.FA, CXC.AF, CXC.CA, CXC.CAD, CXC.CAP, CXC.VV, CXC.OV, CXC.AV, CXC.CD, CXC.DE, CXC.DI, CXC.AJE, CXC.AJR, CXC.NCP)) y (hCxc:hCxc.AplicaManual o ((hCxc:hCxc.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXC<T>, hCxc:hCxc.Mov) noen (CXC.NC, CXC.NCD, CXC.NCF, CXC.DV, CXC.RA, CXC.FAC, CXC.DAC, CXC.PR, CXC.SD, CXC.SCH)))) o<BR>(MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.IM, CXC.RM))))

[Acciones.LCExpress]
Nombre=LCExpress
Boton=0
Menu=&Edición
NombreDesplegar=Línea Crédito Express
EnMenu=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Ctrl+F8
GuardarAntes=S
Expresion=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)<BR>Asigna(Info.LineaCredito, Info.Modulo+Info.ID)<BR>EjecutarSQL(<T>spLCExpress :tModulo, :nID<T>, Info.Modulo, Info.ID)<BR>Si<BR>  Forma(<T>LCExpress<T>)<BR>Entonces<BR>  Asigna(hCxc:hCxc.LineaCredito, Info.LineaCredito)<BR>  GuardarCambios <BR>Fin
ActivoCondicion=Config.ACLineaCreditoExpress
VisibleCondicion=General.AC y MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.F,CXC.CA,CXC.CAP,CXC.CAD,CXC.D,CXC.DM))

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
Expresion=Si(hCxc:hCxc.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>TarjetaSerieMov<T>), Forma(<T>TarjetaSerieMovInfo<T>))
ActivoCondicion=MovTipoEn(<T>CXC<T>, hCxc:hCxc.Mov, (CXC.A, CXC.AR, CXC.AA, CXC.C))
EjecucionCondicion=Asigna(hCxc:hCxc.ConDesglose, Verdadero) <BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, hCxc:hCxc.ID)<BR>Asigna(Info.Mov, hCxc:hCxc.Mov)<BR>Asigna(Info.MovID, hCxc:hCxc.MovID)<BR>Asigna(Info.Moneda, hCxc:hCxc.Moneda)

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CXC<T>, <T>{hCxc:hCxc.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CXC{hCxc:hCxc.ID}<T>

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
VerValor=310




[Ficha.ListaEnCaptura]
(Inicio)=hCxc.Mov
hCxc.Mov=hCxc.MovID
hCxc.MovID=hCxc.Proyecto
hCxc.Proyecto=hCxc.UEN
hCxc.UEN=hCxc.Moneda
hCxc.Moneda=hCxc.TipoCambio
hCxc.TipoCambio=hCxc.FechaEmision
hCxc.FechaEmision=hCxc.FechaOriginal
hCxc.FechaOriginal=hCxc.CtaDinero
hCxc.CtaDinero=hCxc.Cliente
hCxc.Cliente=Cte.Nombre
Cte.Nombre=hCxc.Cajero
hCxc.Cajero=hCxc.ClienteEnviarA
hCxc.ClienteEnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=hCxc.Agente
hCxc.Agente=hCxc.Importe
hCxc.Importe=hCxc.Impuestos
hCxc.Impuestos=ImporteTotal
ImporteTotal=hCxc.Concepto
hCxc.Concepto=hCxc.FormaCobro
hCxc.FormaCobro=hCxc.PersonalCobrador
hCxc.PersonalCobrador=hCxc.Referencia
hCxc.Referencia=hCxc.Condicion
hCxc.Condicion=hCxc.Vencimiento
hCxc.Vencimiento=hCxc.Observaciones
hCxc.Observaciones=hCxc.Saldo
hCxc.Saldo=hCxc.AplicaManual
hCxc.AplicaManual=hCxc.ConDesglose
hCxc.ConDesglose=hCxc.ClienteMoneda
hCxc.ClienteMoneda=hCxc.ClienteTipoCambio
hCxc.ClienteTipoCambio=CxcSaldo.Saldo
CxcSaldo.Saldo=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=hCxc.Cliente
hCxc.Cliente=hCxc.Referencia
hCxc.Referencia=hCxc.Concepto
hCxc.Concepto=hCxc.FechaEmision
hCxc.FechaEmision=hCxc.Vencimiento
hCxc.Vencimiento=ImporteTotal
ImporteTotal=hCxc.Saldo
hCxc.Saldo=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
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
AbrirLocalizarSiguiente=SeleccionarTodo
SeleccionarTodo=AfectarLote
AfectarLote=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirMostrar
AbrirMostrar=(Fin)




[Aplica.ListaEnCaptura]
(Inicio)=hCxc.Cliente
hCxc.Cliente=Cte.Nombre
Cte.Nombre=hCxc.MovAplica
hCxc.MovAplica=hCxc.MovAplicaID
hCxc.MovAplicaID=CxcPendiente.Referencia
CxcPendiente.Referencia=CxcPendiente.FechaEmision
CxcPendiente.FechaEmision=CxcPendiente.Vencimiento
CxcPendiente.Vencimiento=(Fin)

[Desglose.ListaEnCaptura]
(Inicio)=hCxc.Importe1
hCxc.Importe1=hCxc.FormaCobro1
hCxc.FormaCobro1=hCxc.Referencia1
hCxc.Referencia1=hCxc.Importe2
hCxc.Importe2=hCxc.FormaCobro2
hCxc.FormaCobro2=hCxc.Referencia2
hCxc.Referencia2=hCxc.Importe3
hCxc.Importe3=hCxc.FormaCobro3
hCxc.FormaCobro3=hCxc.Referencia3
hCxc.Referencia3=hCxc.Importe4
hCxc.Importe4=hCxc.FormaCobro4
hCxc.FormaCobro4=hCxc.Referencia4
hCxc.Referencia4=hCxc.Importe5
hCxc.Importe5=hCxc.FormaCobro5
hCxc.FormaCobro5=hCxc.Referencia5
hCxc.Referencia5=hCxc.DelEfectivo
hCxc.DelEfectivo=hCxc.Cambio
hCxc.Cambio=CobroTotal
CobroTotal=(Fin)

[Comentarios.ListaEnCaptura]
(Inicio)=hCxc.Comentarios
hCxc.Comentarios=hCxc.Nota
hCxc.Nota=hCxc.ContUso
hCxc.ContUso=hCxc.VIN
hCxc.VIN=(Fin)

[AC.ListaEnCaptura]
(Inicio)=hCxc.LineaCredito
hCxc.LineaCredito=LC.Descripcion
LC.Descripcion=LC.VigenciaDesde
LC.VigenciaDesde=LC.VigenciaHasta
LC.VigenciaHasta=hCxc.TipoAmortizacion
hCxc.TipoAmortizacion=TipoAmortizacion.Descripcion
TipoAmortizacion.Descripcion=hCxc.Condicion
hCxc.Condicion=hCxc.Vencimiento
hCxc.Vencimiento=hCxc.TipoTasa
hCxc.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=hCxc.TieneTasaEsp
hCxc.TieneTasaEsp=hCxc.TasaEsp
hCxc.TasaEsp=hCxc.Comisiones
hCxc.Comisiones=hCxc.ComisionesIVA
hCxc.ComisionesIVA=TotalComisiones
TotalComisiones=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=hCxcD.Aplica
hCxcD.Aplica=hCxcD.AplicaID
hCxcD.AplicaID=hCxcD.Fecha
hCxcD.Fecha=hCxcD.Importe
hCxcD.Importe=DiferenciaNeta
DiferenciaNeta=DiferenciaPorcentaje
DiferenciaPorcentaje=hCxcD.DescuentoRecargos
hCxcD.DescuentoRecargos=DescuentoRecargosPorcentaje
DescuentoRecargosPorcentaje=DescuentoRecargosSugerido
DescuentoRecargosSugerido=hCxcD.InteresesOrdinarios
hCxcD.InteresesOrdinarios=hCxcD.InteresesOrdinariosQuita
hCxcD.InteresesOrdinariosQuita=hCxcD.InteresesMoratorios
hCxcD.InteresesMoratorios=hCxcD.InteresesMoratoriosQuita
hCxcD.InteresesMoratoriosQuita=ImpuestoAdicionalNeto
ImpuestoAdicionalNeto=ImporteIVAFiscal
ImporteIVAFiscal=ImporteIEPSFiscal
ImporteIEPSFiscal=ProporcionRetencion
ProporcionRetencion=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=CxcAplica.FechaEmision
CxcAplica.FechaEmision=CxcAplica.Vencimiento
CxcAplica.Vencimiento=CxcAplica.Referencia
CxcAplica.Referencia=CxcAplica.ImporteTotal
CxcAplica.ImporteTotal=SaldoNeto
SaldoNeto=CxcAplica.Moneda
CxcAplica.Moneda=(Fin)

[Detalle.ListaOrden]
(Inicio)=hCxcD.Renglon	(Acendente)
hCxcD.Renglon	(Acendente)=hCxcD.RenglonSub	(Acendente)
hCxcD.RenglonSub	(Acendente)=(Fin)
















[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=AC
AC=Desglose
Desglose=Aplica
Aplica=Comentarios
Comentarios=Detalle
Detalle=FormaExtraValor
FormaExtraValor=(Fin)

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
Situacion=Sucursal
Sucursal=Afectar
Afectar=Consecutivo
Consecutivo=Eliminar
Eliminar=Cancelar
Cancelar=Sugerir
Sugerir=ReasignarUsuario
ReasignarUsuario=ACRecorrerVencimiento
ACRecorrerVencimiento=ACBajaParcial
ACBajaParcial=Embarcar
Embarcar=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=Voucher
Voucher=MovExpress
MovExpress=LCExpress
LCExpress=Tareas
Tareas=Anexos
Anexos=AgregarEvento
AgregarEvento=Vales
Vales=Tarjetas
Tarjetas=ImporteConImpuestos
ImporteConImpuestos=Asistente Aplicacion
Asistente Aplicacion=Anticipos
Anticipos=AnticiposFacturados
AnticiposFacturados=Anterior
Anterior=Siguiente
Siguiente=Infomacion
Infomacion=InfoCtaDinero
InfoCtaDinero=ProyInfo
ProyInfo=TablaAmortizacion
TablaAmortizacion=DepositosAnticipados
DepositosAnticipados=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovBitacora
MovBitacora=MovPos
MovPos=Navegador
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
