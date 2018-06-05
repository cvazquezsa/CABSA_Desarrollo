[Forma]
Clave=hCxp
Nombre=<T>Histórico Cuentas por pagar<T>
Icono=0
Modulos=CXP
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=351
PosicionInicialArriba=75
PosicionInicialAltura=564
PosicionInicialAncho=664
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraHerramientas=S
EsMovimiento=S
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
EsConsultaExclusiva=S
TituloAuto=S
TituloAutoNombre=S

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hCxp
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

[Ficha.hCxp.Mov]
Carpeta=Ficha
Clave=hCxp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.MovID]
Carpeta=Ficha
Clave=hCxp.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.hCxp.FechaEmision]
Carpeta=Ficha
Clave=hCxp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.Concepto]
Carpeta=Ficha
Clave=hCxp.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.Proyecto]
Carpeta=Ficha
Clave=hCxp.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=16
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.hCxp.Moneda]
Carpeta=Ficha
Clave=hCxp.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.Referencia]
Carpeta=Ficha
Clave=hCxp.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.Observaciones]
Carpeta=Ficha
Clave=hCxp.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.Proveedor]
Carpeta=Ficha
Clave=hCxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.Condicion]
Carpeta=Ficha
Clave=hCxp.Condicion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.Vencimiento]
Carpeta=Ficha
Clave=hCxp.Vencimiento
Editar=S
3D=S
Tamano=18
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.Importe]
Carpeta=Ficha
Clave=hCxp.Importe
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
Vista=hCxpA
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
ListaOrden=hCxp.ID<TAB>(Decendente)
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
FiltroFechasCampo=hCxp.Vencimiento
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
FiltroAplicaEn=hCxp.Moneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=hCxp.FechaCancelacion
FiltroSucursales=S
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
FiltroProyectos=S
IconosNombre=hCxpA:hCxp.Mov+<T> <T>+hCxpA:hCxp.MovID
FiltroGeneral={Si(ConDatos(Filtro.Mov), <T>hCxp.Mov=<T>+Comillas(Filtro.Mov), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Proveedor), <T> AND hCxp.Proveedor=<T>+Comillas(Filtro.Proveedor), <T><T>)}

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

[Ficha.hCxp.Impuestos]
Carpeta=Ficha
Clave=hCxp.Impuestos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.FormaPago]
Carpeta=Ficha
Clave=hCxp.FormaPago
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
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=hCxpD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=hCxp
LlaveLocal=hCxpD.ID
LlaveMaestra=hCxp.ID
ControlRenglon=S
CampoRenglon=hCxpD.Renglon
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
CondicionEdicion=(hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) o (MovTipoEn(<T>CXP<T>,hCxp:hCxp.Mov, (CXP.NC, CXP.NCD, CXP.NCF, CXP.NCP)) y (hCxp:hCxp.Estatus=EstatusPendiente))
HojaFondoGrisAuto=S
PermiteLocalizar=S

CondicionVisible=(MovTipo(<T>CXP<T>, hCxp:hCxp.Mov) noen (CXP.F, CXP.A, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP, CXP.CD, CXP.DE, CXP.AJE, CXP.AJR, CXP.NCP, CXP.C, CXP.SD, CXP.SCH)) y <BR>(hCxp:hCxp.AplicaManual o ((hCxp:hCxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXP<T>, hCxp:hCxp.Mov) noen (CXP.NC, CXP.NCD, CXP.NCF, CXP.RA, CXP.FAC, CXP.DAC, CXP.PR))))
[Detalle.hCxpD.Importe]
Carpeta=Detalle
Clave=hCxpD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.hCxpD.Aplica]
Carpeta=Detalle
Clave=hCxpD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.hCxpD.AplicaID]
Carpeta=Detalle
Clave=hCxpD.AplicaID
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
Totalizadores2=Suma( hCxpD:ImporteNeto )
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CondicionVisible=(MovTipo(<T>CXP<T>, hCxp:hCxp.Mov) noen (CXP.F, CXP.A, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP, CXP.CD, CXP.DE, CXP.AJE, CXP.AJR, CXP.NCP, CXP.C, CXP.SD, CXP.SCH)) y <BR>(hCxp:hCxp.AplicaManual o ((hCxp:hCxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXP<T>, hCxp:hCxp.Mov) noen (CXP.NC, CXP.NCD, CXP.NCF, CXP.PR))))

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

[Ficha.hCxp.AplicaManual]
Carpeta=Ficha
Clave=hCxp.AplicaManual
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
Expresion=Asigna(Afectar.Modulo, <T>CXP<T>)<BR>Asigna(Afectar.ID, hCxp:hCxp.ID)<BR>Asigna(Afectar.Mov, hCxp:hCxp.Mov)<BR>Asigna(Afectar.MovID, hCxp:hCxp.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>CXP<T>, hCxp:hCxp.Mov))<BR>Asigna(Info.Referencia, hCxp:hCxp.Referencia)<BR>Asigna(Info.Saldo, Suma(hCxpD:ImporteNeto)-Si(Version.Peru y (Info.MovTipo=CXP.P), hCxp:SubTotal, hCxp:ImporteTotal))<BR>Si<BR>  hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar) <BR>Entonces <BR>  Si<BR>    (Info.MovTipo en (CXP.P, CXP.D, CXP.DM, CXP.PAG, CXP.NC, CXP.NCD, CXP.NCF, CXP.ANC, CXP.ACA, CXP.AE)) y hCxp:hCxp.AplicaManual y (ABS(Info.Saldo) > Config.CxpAutoAjuste)<BR>  Entonces<BR>    Si(no Forma(<T>CxpAplicaDif<T>), AbortarOperacion)<BR>  Fin<BR>  Afectar(<T>CXP<T>, hCxp:hCxp.ID, hCxp:hCxp.Mov, hCxp:hCxp.MovID, <T>Todo<T>, <T><T>, <T>Cxp<T>)<BR>Sino<BR>  Asigna(Info.Modulo, <T>CXP<T>)<BR>  Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>  Asigna(Info.MovID, hCxp:hCxp.MovID)<BR>  Asigna(Afectar.Modulo, <T>CXP<T>)<BR>  Asigna(Afectar.ID, hCxp:hCxp.ID)<BR>  Asigna(Afectar.Mov, hCxp:hCxp.Mov)<BR>  Asigna(Afectar.MovID, hCxp:hCxp.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Cxp<T>)<BR>  Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Asigna(Info.Pagares, hCxp:Prov.Pagares)<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si <BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Caso Info.MovTipo<BR>      Es CXP.A   Entonces Dialogo(<T>GenerarCxpAnticipo<T>)<BR>      Es CXP.DA  Entonces Dialogo(<T>GenerarCxpDocumentoAnticipo<T>)<BR>      Es CXP.NC  Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>      Es CXP.NCD Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>      Es CXP.DAC Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>      Es CXP.NCF Entonces Dialogo(<T>GenerarCxpNCredito<T>)<BR>      Es CXP.NCP Entonces Asigna(Afectar.GenerarMov, ConfigMov.CxpAplicacionPago) Dialogo(<T>GenerarAplicacionCredito<T>)  <BR>      Es CXP.DP  Entonces Dialogo(<T>GenerarCxpPagoPosfechado<T>)<BR>      Sino Dialogo(<T>GenerarCxpPago<T>)<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hCxp:hCxp.Usuario) y <BR>((hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) o ((hCxp:hCxp.Estatus=EstatusPendiente) y MovTipoEn(<T>CXP<T>, hCxp:hCxp.Mov, (CXP.F, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP, CXP.D, CXP.DM, CXP.PAG, CXP.DP, CXP.A, CXP.DA, CXP.NC, CXP.NCD, CXP.NCF, CXP.NCP, CXP.CD, CXP.FAC, CXP.DAC)))) y<BR>PuedeAvanzarEstatus(<T>CXP<T>, hCxp:hCxp.Mov, hCxp:hCxp.Estatus, FormaSituacion)
EjecucionCondicion=ConDatos(hCxp:hCxp.Mov) y ConDatos(hCxp:hCxp.Importe)
EjecucionMensaje=Si(Vacio(hCxp:hCxp.Importe), <T>Falta Especificar el Importe<T>))
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CXP<T>, hCxp:hCxp.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CXP<T>, hCxp:hCxp.Mov, hCxp:hCxp.ID, Verdadero, hCxp:hCxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn

[Ficha.hCxp.Saldo]
Carpeta=Ficha
Clave=hCxp.Saldo
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
ColorFuente=Negro

[(Carpeta Abrir).hCxp.Saldo]
Carpeta=(Carpeta Abrir)
Clave=hCxp.Saldo
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
Expresion=Asigna( hCxpD:hCxpD.Importe, hCxpD:SaldoNeto)<BR>Asigna( hCxpD:hCxpD.DescuentoRecargos, hCxpD:DescuentoRecargosSugerido)
ActivoCondicion=hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[(Carpeta Abrir).hCxp.Vencimiento]
Carpeta=(Carpeta Abrir)
Clave=hCxp.Vencimiento
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
ListaParametros1=hCxp:hCxp.Proveedor<BR>hCxp:Prov.Nombre<BR>hCxp:ImporteTotal<BR>hCxpD:hCxpD.Aplica<BR>hCxpD:hCxpD.AplicaID<BR>hCxpD:hCxpD.Importe<BR>hCxp:hCxp.ProveedorMoneda
ListaParametros=S
Visible=S
ActivoCondicion=hCxp:hCxp.AplicaManual y<BR>((MovTipoEn(<T>CXP<T>, hCxp:hCxp.Mov, (CXP.NC,CXP.NCD,CXP.NCF,CXP.NCP,CXP.D,CXP.DM,CXP.PAG,CXP.DP,CXP.AE,CXP.ANC,CXP.ACA,CXP.P,CXP.A,CXP.AJM,CXP.AJA,CXP.NET)) y (hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))) o<BR> (MovTipoEn(<T>CXP<T>, hCxp:hCxp.Mov, (CXP.NC,CXP.NCD,CXP.NCF,CXP.NCP)) y (hCxp:hCxp.Estatus=EstatusPendiente))) y<BR>(hCxp:hCxp.Moneda=hCxp:hCxp.ProveedorMoneda)

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
ActivoCondicion=Vacio(hCxp:hCxp.MovID) y (hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, hCxp:hCxp.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Cxp WHERE ID=:nID<T>, hCxp:hCxp.ID))
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
ListaParametros1=hCxp:hCxp.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>hCXP<T>, hCxp:hCxp.Mov, hCxp:hCxp.Estatus), hCxp:hCxp.ID)
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
ListaParametros1=hCxp:hCxp.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CXP<T>, hCxp:hCxp.Mov, hCxp:hCxp.Estatus), hCxp:hCxp.ID)
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
ActivoCondicion=(no MovTipoEn(<T>CXP<T>, hCxp:hCxp.Mov, (CXP.F, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP))) y (hCxp:hCxp.AplicaManual o (hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)))

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

Expresion=Cancelar(<T>CXP<T>, hCxp:hCxp.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Cxp<T>)
ActivoCondicion=//PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, hCxp:hCxp.Usuario) y ConDatos(hCxp:hCxp.ID) y ConDatos(hCxp:hCxp.MovID) y<BR>//(hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusSincro, EstatusConcluido, EstatusPendiente))
AntesExpresiones=Asigna( Afectar.Mov, hCxp:hCxp.Mov ) <BR> Asigna( Afectar.MovID, hCxp:hCxp.MovID )
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
Expresion=Verificar(<T>CXP<T>, hCxp:hCxp.ID,hCxp:hCxp.Mov,hCxp:hCxp.MovID)
ActivoCondicion=hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(hCxp:hCxp.Mov)

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
Expresion=Si<BR>  ConDatos(hCxp:hCxp.Proveedor) <BR>Entonces<BR>  Si<BR>    (hCxp:Prov.Tipo<><T>Acreedor<T>) o Usuario.VerInfoAcreedores<BR>  Entonces<BR>    Asigna( Info.Proveedor,hCxp:hCxp.Proveedor ) <BR>    Asigna(Info.Origen, <T>Cxp<T>)<BR>    Forma( <T>ProvInfo<T> )<BR>  Fin<BR>Fin

[Ficha.hCxp.TipoCambio]
Carpeta=Ficha
Clave=hCxp.TipoCambio
Editar=S
3D=S
Tamano=8
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCxp.ProveedorMoneda]
Carpeta=Ficha
Clave=hCxp.ProveedorMoneda
Editar=S
3D=S
Tamano=10
ValidaNombre=S
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.hCxp.CtaDinero]
Carpeta=Ficha
Clave=hCxp.CtaDinero
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
Expresion=Asigna(Info.CtaDinero, hCxp:hCxp.CtaDinero)<BR>Forma(<T>CtaDineroInfo<T>)
ActivoCondicion=MovTipoEn(<T>CXP<T>,hCxp:hCxp.Mov,(CXP.P, CXP.DP, CXP.NCP, CXP.A, CXP.AA, CXP.DE, CXP.DC, CXP.CD, CXP.C)) y Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(hCxp:hCxp.CtaDinero)

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
Vista=hCxp
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
CondicionVisible=MovTipo(<T>CXP<T>, hCxp:hCxp.Mov) en (CXP.ANC, CXP.ACA, CXP.RA, CXP.FAC, CXP.DAC)

[Aplica.hCxp.MovAplica]
Carpeta=Aplica
Clave=hCxp.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.hCxp.MovAplicaID]
Carpeta=Aplica
Clave=hCxp.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).hCxp.Referencia]
Carpeta=(Carpeta Abrir)
Clave=hCxp.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
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

[(Carpeta Abrir).hCxp.Concepto]
Carpeta=(Carpeta Abrir)
Clave=hCxp.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
ActivoCondicion=ConDatos(hCxp:hCxp.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxp:hCxp.ID)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.MovID, hCxp:hCxp.MovID)

[Aplica.hCxp.Proveedor]
Carpeta=Aplica
Clave=hCxp.Proveedor
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
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
ActivoCondicion=(ConfigModulo(<T>CXP<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>PuedeAvanzarSituacion(<T>CXP<T>, hCxp:hCxp.Mov, hCxp:hCxp.Estatus, FormaSituacion)
AntesExpresiones=Si(Vacio(hCxp:hCxp.ID),GuardarCambios)

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
EjecucionCondicion=ConDatos(hCxp:hCxp.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxp:hCxp.ID)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.MovID, hCxp:hCxp.MovID)

[(Carpeta Abrir).hCxp.Proveedor]
Carpeta=(Carpeta Abrir)
Clave=hCxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).hCxp.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=hCxp.FechaEmision
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
ActivoCondicion=ConDatos(hCxpA:hCxp.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxpA:hCxp.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxp:hCxp.ID)<BR>Asigna(Info.Usuario, hCxp:hCxp.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(hCxp:hCxp.ID)

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
AntesExpresiones=Asigna(Info.Rama, <T>CXP<T>)<BR>Asigna(Info.Fecha, hCxp:hCxp.FechaEmision)<BR>Asigna(Info.ID, hCxp:hCxp.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hCxp:hCxp.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, hCxp:hCxp.Mov+<T> <T>+hCxp:hCxp.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(hCxp:hCxp.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxp:hCxp.ID)
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
Expresion=CopiarMovimiento(<T>CXP<T>, hCxp:hCxp.ID, <T>Cxp<T>)

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
ActivoCondicion=Usuario.CxpMovExpress y (hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
Antes=S
AntesExpresiones=Asigna(Def.Proveedor, hCxp:hCxp.Proveedor)

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
Expresion=Asigna(hCxpD:hCxpD.Aplica, Info.Mov)<BR>Asigna(hCxpD:hCxpD.AplicaID, Info.MovID)
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
AntesExpresiones=Asigna(Info.ID, hCxp:hCxp.ID)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.MovID, hCxp:hCxp.MovID)
VisibleCondicion=hCxp:hCxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)

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
AntesExpresiones=Asigna(Info.Concepto, hCxp:hCxp.Concepto)<BR>Asigna(Info.ID, SQL(<T>SELECT ID FROM Compra WHERE Empresa=:tEmpresa AND Mov=:tMov AND MovID=:tMovID AND Estatus NOT IN (:tSinAfectar, :tCancelado)<T>, Empresa, hCxp:hCxp.Origen, hCxp:hCxp.OrigenID, EstatusSinAfectar, EstatusPorConfirmar, EstatusCancelado))
VisibleCondicion=MovTipo(hCxp:hCxp.OrigenTipo, hCxp:hCxp.Origen) en (COMS.EG,COMS.EI)

[Ficha.hCxp.ProveedorTipoCambio]
Carpeta=Ficha
Clave=hCxp.ProveedorTipoCambio
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(hCxp:hCxp.ID),GuardarCambios)
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
ActivoCondicion=Vacio(hCxp:hCxp.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Cxp<T>)<BR>Asigna(Afectar.Modulo, <T>CXP<T>)<BR>Asigna(Afectar.ID, hCxp:hCxp.ID)<BR>Asigna(Afectar.Mov, hCxp:hCxp.Mov)<BR>Asigna(Afectar.MovID, hCxp:hCxp.MovID)<BR>Asigna(Info.Descripcion, hCxp:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(hCxp:hCxp.Mensaje)

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
Expresion=Asigna(Info.Rama, <T>CXP<T>)<BR>Asigna(Info.Moneda, hCxp:hCxp.Moneda)<BR>Asigna(Info.Cuenta, hCxp:hCxp.Proveedor)<BR>Si<BR>  Forma(<T>AnticipoPendiente<T>)<BR>Entonces<BR>  Asigna(hCxp:hCxp.Referencia, Info.Referencia)<BR>  Asigna(hCxp:hCxp.Importe, Info.Importe)<BR>Fin
ActivoCondicion=(hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXP<T>, hCxp:hCxp.Mov) = CXP.AA)
EjecucionCondicion=ConDatos(hCxp:hCxp.Proveedor)

[Detalle.DiferenciaPorcentaje]
Carpeta=Detalle
Clave=DiferenciaPorcentaje
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Detalle.hCxpD.DescuentoRecargos]
Carpeta=Detalle
Clave=hCxpD.DescuentoRecargos
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
Expresion=Asigna(hCxp:hCxp.Importe, Suma(hCxpD:ImporteNeto) / (1+(Si(MovTipoEn(<T>CXP<T>, hCxp:hCxp.Mov, (CXP.F,CXP.NC,CXP.CA)), ImpuestoZona(General.DefImpuesto, hCxp:Prov.ZonaImpuesto)/100, 0))))

[Ficha.hCxp.Cajero]
Carpeta=Ficha
Clave=hCxp.Cajero
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
Expresion=Si<BR>  Forma(<T>EspecificarVencimiento<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spSugerirPago :nID, :tEmpresa, :tMon, :tProveedor, :fVencimiento<T>, hCxp:hCxp.ID, Empresa, hCxp:hCxp.Moneda, hCxp:hCxp.Proveedor, Info.Fecha)<BR>Fin
ActivoCondicion=hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=MovTipoEn(<T>CXP<T>, hCxp:hCxp.Mov, (CXP.P))

[Detalle.ImporteIVAFiscal]
Carpeta=Detalle
Clave=ImporteIVAFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.hCxp.UEN]
Carpeta=Ficha
Clave=hCxp.UEN
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
EjecucionCondicion=ConDatos(hCxp:hCxp.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, hCxp:hCxp.Proyecto)
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
Expresion=Asigna(Info.Importe, hCxp:ImporteTotal)<BR>Asigna(Info.PorcentajeImpuesto, ImpuestoZona(Redondea(Def.CxImpuesto, 8), hCxp:Prov.ZonaImpuesto))<BR>Si<BR>  Forma(<T>EspecificarImporteConImpuestos<T>)<BR>Entonces<BR>  Asigna(hCxp:hCxp.Importe,  Redondea(Info.Importe/(1+(Info.PorcentajeImpuesto/100)), 4))<BR>  Asigna(hCxp:hCxp.Impuestos, Info.Importe-hCxp:hCxp.Importe)<BR>Fin
ActivoCondicion=(hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y MovTipoEn(<T>CXP<T>, hCxp:hCxp.Mov, (CXP.F,CXP.NC,CXP.CA,CXP.A,CXP.AA,CXP.DE))

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
Expresion=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.Clave, <T>CXP<T>+hCxp:hCxp.ID)<BR>Asigna(Info.Nombre, hCxp:hCxp.Mov+<T> <T>+hCxp:hCxp.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(hCxp:hCxp.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

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
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxp:hCxp.ID)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.MovID, hCxp:hCxp.MovID)<BR>Si(no Forma(<T>MovCopiarMeses<T>),  AbortarOperacion)
DespuesGuardar=S
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
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>CXP<T>, hCxp:hCxp.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(hCxp:hCxp.MovID) y PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hCxp:hCxp.Usuario)

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
AntesExpresiones=Asigna(Info.PuedeEditar, hCxp:hCxp.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.MovID, hCxp:hCxp.MovID)<BR>Asigna(Info.Proyecto, hCxp:hCxp.Proyecto)<BR>Asigna(Info.UEN, hCxp:hCxp.UEN)<BR>Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxp:hCxp.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, hCxp:hCxp.Proveedor)<BR>Asigna(Info.Agente, hCxp:hCxp.Cajero)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
Vista=hCxp
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

[Comentarios.hCxp.Comentarios]
Carpeta=Comentarios
Clave=hCxp.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=88x10
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios.hCxp.Nota]
Carpeta=Comentarios
Clave=hCxp.Nota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=46
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
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxp:hCxp.ID)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.MovID, hCxp:hCxp.MovID)<BR>Asigna(Info.Fecha, hCxp:hCxp.FechaEmision)<BR>Asigna(Info.Estatus, hCxp:hCxp.Estatus)

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
EjecucionCondicion=ConDatos(hCxp:hCxp.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CXP<T>)<BR>Asigna(Info.Clave, hCxp:hCxp.Mov)

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
EjecucionCondicion=ConDatos(hCxp:hCxp.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.Concepto, hCxp:hCxp.Concepto)

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
Vista=hCxp
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
CondicionVisible=General.AC y MovTipoEn(<T>CXP<T>, hCxp:hCxp.Mov, (CXP.F,CXP.CA,CXP.CAP,CXP.CAD,CXP.D,CXP.DM))

[AC.hCxp.TipoAmortizacion]
Carpeta=AC
Clave=hCxp.TipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.hCxp.TipoTasa]
Carpeta=AC
Clave=hCxp.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.hCxp.LineaCredito]
Carpeta=AC
Clave=hCxp.LineaCredito
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

[AC.hCxp.Condicion]
Carpeta=AC
Clave=hCxp.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[AC.hCxp.Vencimiento]
Carpeta=AC
Clave=hCxp.Vencimiento
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
ActivoCondicion=hCxp:hCxp.Amortizaciones>0
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxp:hCxp.ID)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.MovID, hCxp:hCxp.MovID)

[Detalle.hCxpD.InteresesOrdinarios]
Carpeta=Detalle
Clave=hCxpD.InteresesOrdinarios
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCxpD.InteresesMoratorios]
Carpeta=Detalle
Clave=hCxpD.InteresesMoratorios
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
Expresion=Asigna(Info.Importe, Vacio(hCxp:ImporteTotal, Nulo))<BR>Asigna(Info.Acreditado, hCxp:hCxp.Proveedor)<BR>Si(Forma(<T>SugerirCobro<T>), EjecutarSQL(<T>spSugerirCobro :tSugerir, :tModulo, :nID, :nTotal<T>, Info.SugerirCobro, <T>CXP<T>, hCxp:hCxp.ID, Info.Importe))
ActivoCondicion=(hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y MovTipoEn(<T>Cxp<T>, hCxp:hCxp.Mov, (CXP.P, CXP.D, CXP.DM))

[Detalle.hCxpD.InteresesOrdinariosQuita]
Carpeta=Detalle
Clave=hCxpD.InteresesOrdinariosQuita
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCxpD.InteresesMoratoriosQuita]
Carpeta=Detalle
Clave=hCxpD.InteresesMoratoriosQuita
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[AC.hCxp.Comisiones]
Carpeta=AC
Clave=hCxp.Comisiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AC.hCxp.ComisionesIVA]
Carpeta=AC
Clave=hCxp.ComisionesIVA
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

[Comentarios.hCxp.VIN]
Carpeta=Comentarios
Clave=hCxp.VIN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios.hCxp.ContUso]
Carpeta=Comentarios
Clave=hCxp.ContUso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=hCxp
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
CondicionVisible=Version.Peru y MovTipoEn(<T>CXP<T>, hCxp:hCxp.Mov, (CXP.P, CXP.ANC, CXP.ACA, CXP.NET))

[Retenciones.hCxp.Retencion]
Carpeta=Retenciones
Clave=hCxp.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Retenciones.hCxp.Retencion2]
Carpeta=Retenciones
Clave=hCxp.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Retenciones.hCxp.Retencion3]
Carpeta=Retenciones
Clave=hCxp.Retencion3
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
Expresion=Asigna(Info.Forma, <T>Cxp<T>)<BR>Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.Nombre, hCxp:hCxp.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CXP<T>, hCxp:hCxp.Mov, hCxp:hCxp.ID, Falso, hCxp:hCxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CXP<T>+hCxp:hCxp.ID)<BR>  Asigna(Info.Nombre, hCxp:hCxp.Mov+<T> <T>+hCxp:hCxp.MovID)<BR>  Asigna(Info.Modulo, <T>CXP<T>)<BR>  Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[AC.hCxp.TieneTasaEsp]
Carpeta=AC
Clave=hCxp.TieneTasaEsp
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[AC.hCxp.TasaEsp]
Carpeta=AC
Clave=hCxp.TasaEsp
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
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, hCxp:hCxp.ID)<BR>Asigna(Info.Mov, hCxp:hCxp.Mov)<BR>Asigna(Info.MovID, hCxp:hCxp.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (hCxp:hCxp.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=(MovTipo(<T>CXP<T>, hCxp:hCxp.Mov) noen (CXP.F, CXP.A, CXP.CA, CXP.CAD, CXP.AF, CXP.CAP, CXP.CD, CXP.DE, CXP.AJE, CXP.AJR, CXP.NCP, CXP.C, CXP.SD, CXP.SCH)) y <BR>(hCxp:hCxp.AplicaManual o ((hCxp:hCxp.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y (MovTipo(<T>CXP<T>, hCxp:hCxp.Mov) noen (CXP.NC, CXP.NCD, CXP.NCF, CXP.RA, CXP.FAC, CXP.DAC, CXP.PR))))

[Ficha.hCxp.ProveedorSucursal]
Carpeta=Ficha
Clave=hCxp.ProveedorSucursal
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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CXP<T>, <T>{hCxp:hCxp.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CXP{hCxp:hCxp.ID}<T>

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
(Inicio)=hCxp.Mov
hCxp.Mov=hCxp.MovID
hCxp.MovID=hCxp.Proyecto
hCxp.Proyecto=hCxp.UEN
hCxp.UEN=hCxp.Moneda
hCxp.Moneda=hCxp.TipoCambio
hCxp.TipoCambio=hCxp.FechaEmision
hCxp.FechaEmision=hCxp.CtaDinero
hCxp.CtaDinero=hCxp.Cajero
hCxp.Cajero=hCxp.Proveedor
hCxp.Proveedor=Prov.Nombre
Prov.Nombre=hCxp.ProveedorSucursal
hCxp.ProveedorSucursal=hCxp.Importe
hCxp.Importe=hCxp.Impuestos
hCxp.Impuestos=ImporteTotal
ImporteTotal=hCxp.Concepto
hCxp.Concepto=hCxp.FormaPago
hCxp.FormaPago=Retenciones
Retenciones=hCxp.Referencia
hCxp.Referencia=hCxp.Condicion
hCxp.Condicion=hCxp.Vencimiento
hCxp.Vencimiento=hCxp.Observaciones
hCxp.Observaciones=hCxp.Saldo
hCxp.Saldo=hCxp.AplicaManual
hCxp.AplicaManual=hCxp.ProveedorMoneda
hCxp.ProveedorMoneda=hCxp.ProveedorTipoCambio
hCxp.ProveedorTipoCambio=CxpSaldo.Saldo
CxpSaldo.Saldo=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=hCxp.Proveedor
hCxp.Proveedor=hCxp.Referencia
hCxp.Referencia=hCxp.Concepto
hCxp.Concepto=hCxp.FechaEmision
hCxp.FechaEmision=hCxp.Vencimiento
hCxp.Vencimiento=ImporteTotal
ImporteTotal=hCxp.Saldo
hCxp.Saldo=(Fin)

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




[Aplica.ListaEnCaptura]
(Inicio)=hCxp.Proveedor
hCxp.Proveedor=Prov.Nombre
Prov.Nombre=hCxp.MovAplica
hCxp.MovAplica=hCxp.MovAplicaID
hCxp.MovAplicaID=CxpPendiente.Referencia
CxpPendiente.Referencia=CxpPendiente.FechaEmision
CxpPendiente.FechaEmision=CxpPendiente.Vencimiento
CxpPendiente.Vencimiento=(Fin)

[Comentarios.ListaEnCaptura]
(Inicio)=hCxp.Comentarios
hCxp.Comentarios=hCxp.Nota
hCxp.Nota=hCxp.ContUso
hCxp.ContUso=hCxp.VIN
hCxp.VIN=(Fin)

[AC.ListaEnCaptura]
(Inicio)=hCxp.LineaCredito
hCxp.LineaCredito=LC.Descripcion
LC.Descripcion=LC.VigenciaDesde
LC.VigenciaDesde=LC.VigenciaHasta
LC.VigenciaHasta=hCxp.TipoAmortizacion
hCxp.TipoAmortizacion=TipoAmortizacion.Descripcion
TipoAmortizacion.Descripcion=hCxp.Condicion
hCxp.Condicion=hCxp.Vencimiento
hCxp.Vencimiento=hCxp.TipoTasa
hCxp.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=hCxp.TieneTasaEsp
hCxp.TieneTasaEsp=hCxp.TasaEsp
hCxp.TasaEsp=hCxp.Comisiones
hCxp.Comisiones=hCxp.ComisionesIVA
hCxp.ComisionesIVA=TotalComisiones
TotalComisiones=(Fin)

[Retenciones.ListaEnCaptura]
(Inicio)=hCxp.Retencion
hCxp.Retencion=hCxp.Retencion2
hCxp.Retencion2=hCxp.Retencion3
hCxp.Retencion3=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)










[Detalle.ListaEnCaptura]
(Inicio)=hCxpD.Aplica
hCxpD.Aplica=hCxpD.AplicaID
hCxpD.AplicaID=hCxpD.Importe
hCxpD.Importe=DiferenciaNeta
DiferenciaNeta=DiferenciaPorcentaje
DiferenciaPorcentaje=hCxpD.DescuentoRecargos
hCxpD.DescuentoRecargos=DescuentoRecargosPorcentaje
DescuentoRecargosPorcentaje=DescuentoRecargosSugerido
DescuentoRecargosSugerido=hCxpD.InteresesOrdinarios
hCxpD.InteresesOrdinarios=hCxpD.InteresesOrdinariosQuita
hCxpD.InteresesOrdinariosQuita=hCxpD.InteresesMoratorios
hCxpD.InteresesMoratorios=hCxpD.InteresesMoratoriosQuita
hCxpD.InteresesMoratoriosQuita=ImporteIVAFiscal
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
(Inicio)=hCxpD.Renglon	(Acendente)
hCxpD.Renglon	(Acendente)=hCxpD.RenglonSub	(Acendente)
hCxpD.RenglonSub	(Acendente)=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Retenciones
Retenciones=AC
AC=Aplica
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
Afectar=Autorizar
Autorizar=Consecutivo
Consecutivo=Eliminar
Eliminar=Cancelar
Cancelar=Sugerir
Sugerir=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=Totalizar
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
TablaAmortizacion=InfoCtaDinero
InfoCtaDinero=ProyInfo
ProyInfo=GastoDiverso
GastoDiverso=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
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
