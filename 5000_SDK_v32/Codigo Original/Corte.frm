[Forma]
Clave=Corte
Nombre=Corte
Icono=0
Modulos=CORTE
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=260
PosicionInicialArriba=112
PosicionInicialAltura=600
PosicionInicialAncho=920
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
PosicionSeccion1=48
PosicionSeccion2=92
BarraAyuda=S
MovModulo=CORTE
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)
PosicionInicialAlturaCliente=597
PosicionSec1=268
PosicionSec2=481

PosicionCol3=726
Totalizadores=S
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Corte
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
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Pestana=S

[Ficha.Corte.Mov]
Carpeta=Ficha
Clave=Corte.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Corte.MovID]
Carpeta=Ficha
Clave=Corte.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.Corte.FechaEmision]
Carpeta=Ficha
Clave=Corte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Corte.Concepto]
Carpeta=Ficha
Clave=Corte.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=S
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.Corte.Proyecto]
Carpeta=Ficha
Clave=Corte.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
IgnoraFlujo=N
ColorFondo=Blanco


[Ficha.Corte.Referencia]
Carpeta=Ficha
Clave=Corte.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.Corte.Observaciones]
Carpeta=Ficha
Clave=Corte.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=CorteA
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
ListaOrden=Corte.ID<TAB>(Decendente)
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
FiltroFechasCampo=Corte.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=SINAFECTAR
PestanaOtroNombre=S
PestanaNombre=movimientos
FiltroUsuarios=S
FiltroUsuarioDefault=(Todos)
FiltroFechasNormal=S
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroAutoValidar=Mon
FiltroAplicaEn=Corte.Moneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=Corte.FechaCancelacion
FiltroSucursales=S

IconosNombre=CorteA:Corte.Mov+<T> <T>+CorteA:Corte.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=186
1=97

2=58
3=-2
4=120
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Corte:Corte.ID) y (Corte:Corte.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Corte:Corte.ID, <T>CORTE<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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


[Detalle.Columnas]
Importe=69
Aplica=106
AplicaID=66
AplicaProntoPago=96
Referencia=113
Observaciones=202
ObligacionFiscal=132
Tasa=37
Factor=64
Contacto=64
ContactoTipo=79
DebeFiscal=82
HaberFiscal=87
OtrosImpuestos=89
Excento=43
Deducible=64
MovNombre=96
Base=69
Neto=95
CalcBase=74
CalcNeto=90

TipoImpuesto=72
Cuenta=99
Moneda=74
Efectivo=79
Consumos=81
Vales=74
Redondeo=67
ClienteEnviarA=64
Fecha=92
Mov=112
MovID=101
Cargo=64
Abono=64
Columna1=100
Columna2=100
Columna3=100
Columna4=100
Columna5=100
Columna6=100
Columna7=100
Columna8=100
Columna9=100
Columna10=100
Columna11=100
Columna12=100
Columna13=100
Columna14=100
Columna15=100
Columna16=100
Columna17=100
Columna18=100
Columna19=100
Columna20=100
Columna21=100
Columna22=100
Columna23=100
Columna24=100
Columna25=100
Columna26=100
Columna27=100
Columna28=100
Columna29=100
Columna30=100
Columna31=100
Columna32=100
Columna33=100
Columna34=100
Columna35=100
Columna36=100
Columna37=100
Columna38=100
Columna39=100
Columna40=100
Columna41=100
Columna42=100
Columna43=100
Columna44=100
Columna45=100
Columna46=100
Columna47=100
Columna48=100
Columna49=100
Columna50=100
Renglon=94
Vencimiento=94
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
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Importe Total<BR>Saldo Inicial<BR>Cargos<BR>Abonos<BR>Saldo Final<BR>Saldo Inicial U.<BR>Cargos U.<BR>Abonos U.<BR>Saldo Final U.
Totalizadores2=Corte:Corte.Importe<BR>Corte:Corte.SaldoI<BR>Corte:Corte.Cargo<BR>Corte:Corte.Abono<BR>Corte:Corte.Saldo<BR>Corte:Corte.SaldoUI<BR>Corte:Corte.CargoU<BR>Corte:Corte.AbonoU<BR>Corte:Corte.SaldoU
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Cantidades)<BR>(Cantidades)<BR>(Cantidades)<BR>(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Ficha
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=(Lista)

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

Expresion=Asigna(Afectar.Modulo, <T>CORTE<T>)<BR>Asigna(Afectar.ID, Corte:Corte.ID)<BR>Asigna(Afectar.Mov, Corte:Corte.Mov)<BR>Asigna(Afectar.MovID, Corte:Corte.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>CORTE<T>)<BR>Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.Mov, Corte:Corte.Mov)<BR>Asigna(Info.MovID, Corte:Corte.MovID)<BR>Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>CORTE<T>, Corte:Corte.Mov))<BR>Si<BR>  Corte:Corte.Estatus=EstatusVigente<BR>Entonces<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si<BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Caso Info.MovTipo<BR>      Es CORTE.CORTEIMPORTE  Entonces Dialogo(<T>GenerarCorteImporte<T>)<BR>      Es CORTE.CORTECONTABLE Entonces Dialogo(<T>GenerarCorteContable<T>)<BR>      Es CORTE.CORTEUNIDADES Entonces Dialogo(<T>GenerarCorteUnidades<T>)<BR>      Es CORTE.CORTECX       Entonces Dialogo(<T>GenerarCorteCx<T>)<BR>     Fin<BR>  Fin<BR>Sino<BR>  Afectar(<T>CORTE<T>, Corte:Corte.ID, Corte:Corte.Mov, Corte:Corte.MovID, <T>Todo<T>, <T><T>, <T>Corte<T>)<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Corte:Corte.Usuario) y(Usuario.AfectarCORTE) y<BR>((Corte:Corte.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusVigente)) o<BR>((Corte:Corte.Estatus=EstatusPendiente) y <BR>fnPuedeAvanzarEstatus(Empresa, <T>CORTE<T>, Corte:Corte.Mov, Corte:Corte.Estatus, FormaSituacion, Usuario)))
EjecucionCondicion=ConDatos(Corte:Corte.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Corte:Corte.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CORTE<T>, Corte:Corte.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CORTE<T>, Corte:Corte.Mov, Corte:Corte.ID, Verdadero, Corte:Corte.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ConCondicion=S
EjecucionConError=S

ActivoCondicion=Vacio(Corte:Corte.MovID) y (Corte:Corte.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Corte:Corte.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Corte WHERE ID=:nID<T>, Corte:Corte.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
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
ListaParametros1=Corte:Corte.ID
Visible=S
TeclaRapida=Alt+F11

Antes=S
Expresion=Si MovTipo(<T>CORTE<T>, Corte:Corte.Mov) noen(CORTE.INVVAL)<BR>Entonces<BR>  ReportePantalla(ReporteMovPantalla(<T>CORTE<T>, Corte:Corte.Mov, Corte:Corte.Estatus), Corte:Corte.ID)<BR>Sino<BR>  Si Corte:Corte.CorteValuacion noen(<T>UEPS<T>, <T>PEPS<T>)<BR>  Entonces<BR>    ReportePantalla(ReporteMovPantalla(<T>CORTE<T>, Corte:Corte.Mov, Corte:Corte.Estatus), Corte:Corte.ID)<BR>  Sino<BR>    ReportePantalla(<T>CorteInvValOtrasMonedas<T>, Corte:Corte.ID)<BR>  Fin<BR>Fin
ActivoCondicion=Usuario.PreliminarMovs y(Corte:Corte.Estatus en(EstatusConcluido, EstatusCancelado))
AntesExpresiones=Asigna(Rep.Titulo, SQL(<T>SELECT dbo.fnCorteReporteTitulo(:nID)<T>, Corte:Corte.ID))
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
ListaParametros1=Corte:Corte.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S

Antes=S
Expresion=Si MovTipo(<T>CORTE<T>, Corte:Corte.Mov) noen(CORTE.INVVAL)<BR>Entonces<BR>  ReporteImpresora(ReporteMovImpresora(<T>CORTE<T>, Corte:Corte.Mov, Corte:Corte.Estatus), Corte:Corte.ID)<BR>Sino<BR>  Si Corte:Corte.CorteValuacion noen(<T>UEPS<T>, <T>PEPS<T>)<BR>  Entonces<BR>    ReporteImpresora(ReporteMovImpresora(<T>CORTE<T>, Corte:Corte.Mov, Corte:Corte.Estatus), Corte:Corte.ID)<BR>  Sino<BR>    ReporteImpresora(<T>CorteInvValOtrasMonedas<T>, Corte:Corte.ID)<BR>  Fin<BR>Fin
ActivoCondicion=Usuario.ImprimirMovs y(Corte:Corte.Estatus en(EstatusConcluido, EstatusCancelado))
AntesExpresiones=Asigna(Rep.Titulo, SQL(<T>SELECT dbo.fnCorteReporteTitulo(:nID)<T>, Corte:Corte.ID))
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
Activo=S

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

Expresion=Cancelar(<T>CORTE<T>, Corte:Corte.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>CORTE<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Corte:Corte.Usuario) y ConDatos(Corte:Corte.ID) y ConDatos(Corte:Corte.MovID) y<BR>(Corte:Corte.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPorConfirmar, EstatusConcluido,EstatusPendiente, EstatusVigente))
AntesExpresiones=Asigna( Afectar.Mov, Corte:Corte.Mov ) <BR> Asigna( Afectar.MovID, Corte:Corte.MovID )
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
Expresion=Verificar(<T>CORTE<T>, Corte:Corte.ID,Corte:Corte.Mov,Corte:Corte.MovID)
ActivoCondicion=Corte:Corte.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Corte:Corte.Mov)


[Aplica.Corte.MovAplica]
Carpeta=Aplica
Clave=Corte.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Corte.MovAplicaID]
Carpeta=Aplica
Clave=Corte.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Corte.Referencia]
Carpeta=(Carpeta Abrir)
Clave=Corte.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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

[(Carpeta Abrir).Corte.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Corte.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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
ActivoCondicion=ConDatos(Corte:Corte.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.Mov, Corte:Corte.Mov)<BR>Asigna(Info.MovID, Corte:Corte.MovID)
[Aplica.Corte.Agente]
Carpeta=Aplica
Clave=Corte.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Agente.Nombre]
Carpeta=Aplica
Clave=Agente.Nombre
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
DespuesGuardar=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>CORTE<T>, Corte:Corte.Mov, Corte:Corte.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>CORTE<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>CORTE<T>, Corte:Corte.Mov, Corte:Corte.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Corte:Corte.ID),GuardarCambios)<BR><BR><BR>Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.Mov, Corte:Corte.Mov)<BR>Asigna(Info.Estatus, Corte:Corte.Estatus)<BR>Asigna(Info.Situacion, Corte:Corte.Situacion)
[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ActivoCondicion=ConfigModulo(<T>CORTE<T>,<T>Tiempos<T>)=<T>Si<T>
ConCondicion=S
EjecucionCondicion=ConDatos(Corte:Corte.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.Mov, Corte:Corte.Mov)<BR>Asigna(Info.MovID, Corte:Corte.MovID)
Visible=S

[(Carpeta Abrir).Corte.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Corte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=50

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S

ActivoCondicion=ConDatos(CorteA:Corte.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.ID, CorteA:Corte.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.Usuario, Corte:Corte.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Corte:Corte.ID)

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
Activo=S
Visible=S
ClaveAccion=AnexoMov
Antes=S
EnBarraHerramientas=S
EspacioPrevio=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>CORTE<T>)<BR>Asigna(Info.Fecha, Corte:Corte.FechaEmision)<BR>Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Corte:Corte.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Corte:Corte.Mov+<T> <T>+Corte:Corte.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S

ActivoCondicion=ConDatos(Corte:Corte.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.Rama, <T>CORTE<T>)<BR>Asigna(Info.Cuenta, Corte:Corte.ID)<BR>Asigna(Info.Descripcion, Corte:Corte.Mov+<T> <T>+Corte:Corte.MovID)
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

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
Menu=&Archivo
NombreDesplegar=&Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Shift+F11

Expresion=CopiarMovimiento(<T>CORTE<T>, Corte:Corte.ID, <T>Corte<T>)
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
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgentCampos
ActivoCondicion=no FormaBloqueada
Antes=S
RefrescarDespues=S
AntesExpresiones=Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.Mov, Corte:Corte.Mov)<BR>Asigna(Info.MovID, Corte:Corte.MovID)
VisibleCondicion=Corte:Corte.Estatus<>EstatusSinAfectar

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Corte:Corte.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Corte:Corte.ID),GuardarCambios)
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

[Ficha.Corte.UEN]
Carpeta=Ficha
Clave=Corte.UEN
Editar=S
3D=S
Pegado=S
Tamano=7
ColorFondo=Blanco

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
EjecucionCondicion=ConDatos(Corte:Corte.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, Corte:Corte.Proyecto)

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.Mov, Corte:Corte.Mov)<BR>Asigna(Info.Clave, <T>CORTE<T>+Corte:Corte.ID)<BR>Asigna(Info.Nombre, Corte:Corte.Mov+<T> <T>+Corte:Corte.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Corte:Corte.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

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
AntesExpresiones=Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.Mov, Corte:Corte.Mov)<BR>Asigna(Info.MovID, Corte:Corte.MovID)<BR>Asigna(Info.Fecha, Corte:Corte.FechaEmision)<BR>Asigna(Info.Estatus, Corte:Corte.Estatus)

[Acciones.ComisionBorrador]
Nombre=ComisionBorrador
Boton=0
Menu=&Ver
NombreDesplegar=Origen de la Comisión...
EnMenu=S
Activo=S
TipoAccion=Formas
Antes=S
AntesExpresiones=Asigna(Info.ID, Corte:Corte.ID)
VisibleCondicion=Corte:Corte.Estatus=EstatusBorrador

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
EjecucionCondicion=ConDatos(Corte:Corte.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CORTE<T>)<BR>Asigna(Info.Clave, Corte:Corte.Mov)

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
EjecucionCondicion=ConDatos(Corte:Corte.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.Concepto, Corte:Corte.Concepto)

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>CORTE<T>)<BR>Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.Mov, Corte:Corte.Mov)<BR>Asigna(Info.Nombre, Corte:Corte.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CORTE<T>, Corte:Corte.Mov, Corte:Corte.ID, Falso, Corte:Corte.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CORTE<T>+Corte:Corte.ID)<BR>  Asigna(Info.Nombre, Corte:Corte.Mov+<T> <T>+Corte:Corte.MovID)<BR>  Asigna(Info.Modulo, <T>CORTE<T>)<BR>  Asigna(Info.Mov, Corte:Corte.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Corte:Corte.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Modulo, <T>CORTE<T>)<BR>Asigna(Info.ID, Corte:Corte.ID)<BR>Asigna(Info.Mov, Corte:Corte.Mov)<BR>Asigna(Info.MovID, Corte:Corte.MovID)

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=DetalleReporte
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S

ActivoCondicion=Usuario.EnviarExcel y (Corte:Corte.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
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
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S

FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CORTE<T>, <T>{Corte:Corte.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CORTE{Corte:Corte.ID}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>
[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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
ColorFondo=Blanco
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=296
VerValor=310

[Detalle.]
Carpeta=Detalle
ColorFondo=Negro

[(Carpeta Totalizadores).]
Carpeta=(Carpeta Totalizadores)
ColorFondo=Negro











[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122














[Filtro.Columnas]
CorteCuentaDe=64
CorteCuentaA=64
CorteSubCuentaDe=304
CorteSubCuentaA=304


































[Lista.Columnas]
0=146
1=355
UEN=44
Nombre=269



















Tipo=304
Frecuencia=304
Grupo=218
Moneda=144
TipoCambio=69
Observacion=416
Parametro=181
Valor=231
[Filtro.ListaEnCaptura]
(Inicio)=Corte.CorteCuentaTipo
Corte.CorteCuentaTipo=Corte.CorteFechaD
Corte.CorteFechaD=Corte.CorteFechaA
Corte.CorteFechaA=Corte.CorteSucursalDe
Corte.CorteSucursalDe=Corte.CorteSucursalA
Corte.CorteSucursalA=Corte.CorteCuentaDe
Corte.CorteCuentaDe=Corte.CorteCuentaA
Corte.CorteCuentaA=Corte.CorteSubCuentaDe
Corte.CorteSubCuentaDe=Corte.CorteSubCuentaA
Corte.CorteSubCuentaA=Corte.CorteGrupoDe
Corte.CorteGrupoDe=Corte.CorteGrupoA
Corte.CorteGrupoA=Corte.CorteSubGrupoDe
Corte.CorteSubGrupoDe=Corte.CorteSubGrupoA
Corte.CorteSubGrupoA=Corte.CorteSubCuenta2De
Corte.CorteSubCuenta2De=Corte.CorteSubCuenta2A
Corte.CorteSubCuenta2A=Corte.CorteSubCuenta3De
Corte.CorteSubCuenta3De=Corte.CorteSubCuenta3A
Corte.CorteSubCuenta3A=Corte.CorteUENDe
Corte.CorteUENDe=Corte.CorteUENA
Corte.CorteUENA=Corte.CorteProyectoDe
Corte.CorteProyectoDe=Corte.CorteProyectoA
Corte.CorteProyectoA=Corte.CorteTitulo
Corte.CorteTitulo=Corte.CorteMensaje
Corte.CorteMensaje=(Fin)








































[FiltroEdoCtaCx]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Filtros
Clave=FiltroEdoCtaCx
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Corte
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


CondicionVisible=MovTipo(<T>CORTE<T>, Corte:Corte.Mov) en(CORTE.EDOCTACXC, CORTE.EDOCTACXP)
[FiltroEdoCtaCx.Corte.CorteCuentaTipo]
Carpeta=FiltroEdoCtaCx
Clave=Corte.CorteCuentaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[FiltroEdoCtaCx.Corte.CorteFechaD]
Carpeta=FiltroEdoCtaCx
Clave=Corte.CorteFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco




[FiltroEdoCtaCx.Corte.CorteCuentaDe]
Carpeta=FiltroEdoCtaCx
Clave=Corte.CorteCuentaDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[FiltroEdoCtaCx.Corte.CorteCuentaA]
Carpeta=FiltroEdoCtaCx
Clave=Corte.CorteCuentaA
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco















[FiltroEdoCtaCx.Corte.CorteTitulo]
Carpeta=FiltroEdoCtaCx
Clave=Corte.CorteTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=55
ColorFondo=Blanco






[Ficha.Corte.CorteFrecuencia]
Carpeta=Ficha
Clave=Corte.CorteFrecuencia
Editar=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco

[Ficha.Corte.CorteGrupo]
Carpeta=Ficha
Clave=Corte.CorteGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

LineaNueva=S
[Ficha.Corte.CorteEjercicio]
Carpeta=Ficha
Clave=Corte.CorteEjercicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10
[Ficha.Corte.CortePeriodo]
Carpeta=Ficha
Clave=Corte.CortePeriodo
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7








Pegado=S




















[Ficha.Corte.CorteTipo]
Carpeta=Ficha
Clave=Corte.CorteTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=28
ColorFondo=Blanco















[Ficha.Corte.CorteOrigen]
Carpeta=Ficha
Clave=Corte.CorteOrigen
Editar=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco




































































[FiltroEdoCtaCx.Corte.CorteEstatus]
Carpeta=FiltroEdoCtaCx
Clave=Corte.CorteEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[DetalleReporte]
Estilo=Hoja
Clave=DetalleReporte
OtroOrden=S
Detalle=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CorteDReporte
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Corte
LlaveLocal=CorteDReporte.ID
LlaveMaestra=Corte.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaFondoGrisAuto=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=CorteDReporte.Renglon<TAB>(Acendente)
ControlRenglon=S
CampoRenglon=CorteDReporte.Renglon

Pestana=S
PestanaOtroNombre=S
PestanaNombre=Reporte
PermiteEditar=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CondicionVisible=MovTipo(<T>CORTE<T>, Corte:Corte.Mov) en(CORTE.REPEXTERNO)
[DetalleReporte.CorteDReporte.Columna1]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna2]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna3]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna4]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna5]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna6]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna7]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna8]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna9]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna10]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna10
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna11]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna11
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna12]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna12
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna13]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna13
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna14]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna14
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna15]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna15
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna16]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna16
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna17]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna17
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna18]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna18
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna19]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna19
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna20]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna20
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna21]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna21
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna22]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna22
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna23]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna23
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna24]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna24
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna25]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna25
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna26]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna26
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna27]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna27
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna28]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna28
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna29]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna29
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna30]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna30
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna31]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna31
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna32]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna32
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna33]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna33
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna34]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna34
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna35]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna35
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna36]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna36
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna37]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna37
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna38]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna38
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna39]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna39
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna40]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna40
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna41]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna41
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna42]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna42
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna43]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna43
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna44]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna44
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna45]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna45
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna46]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna46
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna47]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna47
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna48]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna48
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna49]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna49
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DetalleReporte.CorteDReporte.Columna50]
Carpeta=DetalleReporte
Clave=CorteDReporte.Columna50
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco







[DetalleReporte.Columnas]
Columna1=100
Columna2=100
Columna3=100
Columna4=100
Columna5=100
Columna6=100
Columna7=100
Columna8=100
Columna9=100
Columna10=100
Columna11=100
Columna12=100
Columna13=100
Columna14=100
Columna15=100
Columna16=100
Columna17=100
Columna18=100
Columna19=100
Columna20=100
Columna21=100
Columna22=100
Columna23=100
Columna24=100
Columna25=100
Columna26=100
Columna27=100
Columna28=100
Columna29=100
Columna30=100
Columna31=100
Columna32=100
Columna33=100
Columna34=100
Columna35=100
Columna36=100
Columna37=100
Columna38=100
Columna39=100
Columna40=100
Columna41=100
Columna42=100
Columna43=100
Columna44=100
Columna45=100
Columna46=100
Columna47=100
Columna48=100
Columna49=100
Columna50=100











[Detalle.CorteD.Cuenta]
Carpeta=Detalle
Clave=CorteD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.CorteD.Fecha]
Carpeta=Detalle
Clave=CorteD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.CorteD.Moneda]
Carpeta=Detalle
Clave=CorteD.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.CorteD.Aplica]
Carpeta=Detalle
Clave=CorteD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.CorteD.AplicaID]
Carpeta=Detalle
Clave=CorteD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.CorteD.Cargo]
Carpeta=Detalle
Clave=CorteD.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.CorteD.Abono]
Carpeta=Detalle
Clave=CorteD.Abono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




































[Detalle.CorteD.Vencimiento]
Carpeta=Detalle
Clave=CorteD.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


















[Detalle.ListaEnCaptura]
(Inicio)=CorteD.Cuenta
CorteD.Cuenta=CorteD.Fecha
CorteD.Fecha=CorteD.Vencimiento
CorteD.Vencimiento=CorteD.Moneda
CorteD.Moneda=CorteD.Aplica
CorteD.Aplica=CorteD.AplicaID
CorteD.AplicaID=CorteD.Cargo
CorteD.Cargo=CorteD.Abono
CorteD.Abono=(Fin)

[Detalle.ListaOrden]
(Inicio)=CorteD.Moneda	(Acendente)
CorteD.Moneda	(Acendente)=CorteD.Cuenta	(Acendente)
CorteD.Cuenta	(Acendente)=CorteD.Fecha	(Acendente)
CorteD.Fecha	(Acendente)=CorteD.Aplica	(Acendente)
CorteD.Aplica	(Acendente)=CorteD.AplicaID	(Acendente)
CorteD.AplicaID	(Acendente)=CorteD.Cargo	(Acendente)
CorteD.Cargo	(Acendente)=CorteD.Abono	(Acendente)
CorteD.Abono	(Acendente)=(Fin)







































































































































































































































































[FiltroValInv]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Filtro
Clave=FiltroValInv
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Corte
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)



Pestana=S
CondicionVisible=MovTipo(<T>CORTE<T>, Corte:Corte.Mov) en(CORTE.INVVAL)
[FiltroValInv.Corte.CorteCuentaDe]
Carpeta=FiltroValInv
Clave=Corte.CorteCuentaDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[FiltroValInv.Corte.CorteCuentaA]
Carpeta=FiltroValInv
Clave=Corte.CorteCuentaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[FiltroValInv.Corte.CorteCuentaTipo]
Carpeta=FiltroValInv
Clave=Corte.CorteCuentaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


















[FiltroValInv.Corte.CorteFechaA]
Carpeta=FiltroValInv
Clave=Corte.CorteFechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[FiltroValInv.Corte.CorteGrupoDe]
Carpeta=FiltroValInv
Clave=Corte.CorteGrupoDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[FiltroValInv.Corte.CorteValuacion]
Carpeta=FiltroValInv
Clave=Corte.CorteValuacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco


[FiltroValInv.Corte.CorteSucursalDe]
Carpeta=FiltroValInv
Clave=Corte.CorteSucursalDe
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco







Tamano=20











[FiltroValInv.Corte.CorteTitulo]
Carpeta=FiltroValInv
Clave=Corte.CorteTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[FiltroValInv.ListaEnCaptura]
(Inicio)=Corte.CorteCuentaTipo
Corte.CorteCuentaTipo=Corte.CorteFechaA
Corte.CorteFechaA=Corte.CorteCuentaDe
Corte.CorteCuentaDe=Corte.CorteCuentaA
Corte.CorteCuentaA=Corte.CorteGrupoDe
Corte.CorteGrupoDe=Corte.CorteSucursalDe
Corte.CorteSucursalDe=Corte.CorteValuacion
Corte.CorteValuacion=Corte.CorteTitulo
Corte.CorteTitulo=(Fin)











































































































































[FiltroD.Columnas]
Empresa=64
Sucursal=64
UEN=64
Usuario=64
Modulo=64
Movimiento=124
Estatus=94
Situacion=304
Proyecto=304
ContactoTipo=124
Contacto=64
ImporteMin=77
ImporteMax=81
ValidarAlEmitir=102

[FiltroD.ListaEnCaptura]
(Inicio)=CorteDConsulta.Empresa
CorteDConsulta.Empresa=CorteDConsulta.Sucursal
CorteDConsulta.Sucursal=CorteDConsulta.UEN
CorteDConsulta.UEN=CorteDConsulta.Usuario
CorteDConsulta.Usuario=CorteDConsulta.Modulo
CorteDConsulta.Modulo=CorteDConsulta.Movimiento
CorteDConsulta.Movimiento=CorteDConsulta.Estatus
CorteDConsulta.Estatus=CorteDConsulta.Situacion
CorteDConsulta.Situacion=CorteDConsulta.Proyecto
CorteDConsulta.Proyecto=CorteDConsulta.ContactoTipo
CorteDConsulta.ContactoTipo=CorteDConsulta.Contacto
CorteDConsulta.Contacto=CorteDConsulta.ImporteMin
CorteDConsulta.ImporteMin=CorteDConsulta.ImporteMax
CorteDConsulta.ImporteMax=CorteDConsulta.ValidarAlEmitir
CorteDConsulta.ValidarAlEmitir=(Fin)


























































































[ConsultaImporte.Columnas]
Empresa=57
Sucursal=59
UEN=57
Usuario=64
Modulo=48
Movimiento=120
Estatus=72
Situacion=137
Proyecto=118
ContactoTipo=78
Contacto=64
ImporteMin=76
ImporteMax=81
ValidarAlEmitir=102





Signo=58
Informativo=66
Desglosar=65
Agrupador=132

Importe=112




[Ficha.Corte.Moneda]
Carpeta=Ficha
Clave=Corte.Moneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco

[Ficha.Corte.TipoCambio]
Carpeta=Ficha
Clave=Corte.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=5
ColorFondo=Blanco









Pegado=S












[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

Efectos=[Negritas]




























Pegado=S
[ConsultaImporte.ListaEnCaptura]
(Inicio)=CorteDConsulta.Empresa
CorteDConsulta.Empresa=CorteDConsulta.Sucursal
CorteDConsulta.Sucursal=CorteDConsulta.UEN
CorteDConsulta.UEN=CorteDConsulta.Usuario
CorteDConsulta.Usuario=CorteDConsulta.Modulo
CorteDConsulta.Modulo=CorteDConsulta.Movimiento
CorteDConsulta.Movimiento=CorteDConsulta.Estatus
CorteDConsulta.Estatus=CorteDConsulta.Situacion
CorteDConsulta.Situacion=CorteDConsulta.Proyecto
CorteDConsulta.Proyecto=CorteDConsulta.ContactoTipo
CorteDConsulta.ContactoTipo=CorteDConsulta.Contacto
CorteDConsulta.Contacto=CorteDConsulta.ImporteMin
CorteDConsulta.ImporteMin=CorteDConsulta.ImporteMax
CorteDConsulta.ImporteMax=CorteDConsulta.Signo
CorteDConsulta.Signo=CorteDConsulta.Informativo
CorteDConsulta.Informativo=CorteDConsulta.Desglosar
CorteDConsulta.Desglosar=CorteDConsulta.Agrupador
CorteDConsulta.Agrupador=CorteDConsulta.Importe
CorteDConsulta.Importe=(Fin)

























[(Carpeta Abrir).Corte.Importe]
Carpeta=(Carpeta Abrir)
Clave=Corte.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













[FiltroCorteImporte]
Estilo=Ficha
Pestana=S
Clave=FiltroCorteImporte
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Corte
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
PestanaNombre=Filtros
CondicionVisible=MovTipo(<T>CORTE<T>, Corte:Corte.Mov) en(CORTE.CORTEIMPORTE, CORTE.CORTECONTABLE, CORTE.CORTECX)
[FiltroCorteImporte.Corte.CorteFiltrarFechas]
Carpeta=FiltroCorteImporte
Clave=Corte.CorteFiltrarFechas
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[FiltroCorteImporte.Corte.CorteFechaD]
Carpeta=FiltroCorteImporte
Clave=Corte.CorteFechaD
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco

[FiltroCorteImporte.Corte.CorteFechaA]
Carpeta=FiltroCorteImporte
Clave=Corte.CorteFechaA
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=13
ColorFondo=Blanco



[ConsultaDImporte]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Consulta
Clave=ConsultaDImporte
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CorteDConsulta
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Corte
LlaveLocal=CorteDConsulta.ID
LlaveMaestra=Corte.ID
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

ControlRenglon=S
CampoRenglon=CorteDConsulta.Renglon


CondicionVisible=MovTipo(<T>CORTE<T>, Corte:Corte.Mov) en(CORTE.CORTEIMPORTE)
[ConsultaDImporte.CorteDConsulta.Sucursal]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.UEN]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Usuario]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Modulo]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Movimiento]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Estatus]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Situacion]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Proyecto]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.ContactoTipo]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Contacto]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.ImporteMin]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.ImporteMin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.ImporteMax]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.ImporteMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[ConsultaDImporte.CorteDConsulta.Desglosar]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Desglosar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Agrupador]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Agrupador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Importe]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]




[ConsultaDImporte.Columnas]
Empresa=64
Sucursal=64
UEN=64
Usuario=64
Modulo=64
Movimiento=124
Estatus=94
Situacion=67
Proyecto=96
ContactoTipo=86
Contacto=64
ImporteMin=77
ImporteMax=81
Signo=43
Informativo=60
Desglosar=77
Agrupador=134
Importe=102





Accion=74
Moneda=64
Totalizador=64

SaldoU=85
[ConsultaDImporte.CorteDConsulta.Accion]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[ConsultaDImporte.CorteDConsulta.Moneda]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

























[ConsultaDImporte.CorteDConsulta.Totalizador]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.Totalizador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
































































[Semanal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Frecuencia
Clave=Semanal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Corte
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


CondicionVisible=Corte:Corte.Frecuencia = <T>(Semanal)<T> y(fnSubMovTipo(<T>CORTE<T>, Corte:Corte.Mov)en(<T>CORTE.GENERACORTEIMP<T>, <T>CORTE.GENERACORTECON<T>, <T>CORTE.GENERACORTEU<T>, <T>CORTE.GENERACORTECX<T>))
[Semanal.Corte.Domingo]
Carpeta=Semanal
Clave=Corte.Domingo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[Semanal.Corte.Lunes]
Carpeta=Semanal
Clave=Corte.Lunes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[Semanal.Corte.Martes]
Carpeta=Semanal
Clave=Corte.Martes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[Semanal.Corte.Miercoles]
Carpeta=Semanal
Clave=Corte.Miercoles
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[Semanal.Corte.Jueves]
Carpeta=Semanal
Clave=Corte.Jueves
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[Semanal.Corte.Viernes]
Carpeta=Semanal
Clave=Corte.Viernes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[Semanal.Corte.Sabado]
Carpeta=Semanal
Clave=Corte.Sabado
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco




Tamano=20
[MensualOMayor]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Frecuencia
Clave=MensualOMayor
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Corte
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

ListaEnCaptura=Corte.DiaMes

CondicionVisible=(Corte:Corte.Frecuencia <> <T>(Diaria)<T>) y (Corte:Corte.Frecuencia <> <T>(Semanal)<T>) y(fnSubMovTipo(<T>CORTE<T>, Corte:Corte.Mov)en(<T>CORTE.GENERACORTEIMP<T>, <T>CORTE.GENERACORTECON<T>, <T>CORTE.GENERACORTEU<T>, <T>CORTE.GENERACORTECX<T>))
[Ficha.Corte.Frecuencia]
Carpeta=Ficha
Clave=Corte.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco









EspacioPrevio=S












[MensualOMayor.Corte.DiaMes]
Carpeta=MensualOMayor
Clave=Corte.DiaMes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco


[FiltroCorteImporte.Corte.CorteTitulo]
Carpeta=FiltroCorteImporte
Clave=Corte.CorteTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco



























































































[ConsultaDContable]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Consulta
Clave=ConsultaDContable
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CorteDConsulta
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
Detalle=S
VistaMaestra=Corte
LlaveLocal=CorteDConsulta.ID
LlaveMaestra=Corte.ID
ControlRenglon=S
CampoRenglon=CorteDConsulta.Renglon



















ListaEnCaptura=(Lista)





CondicionVisible=MovTipo(<T>CORTE<T>, Corte:Corte.Mov) en(CORTE.CORTECONTABLE)
[ConsultaDContable.CorteDConsulta.Sucursal]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.UEN]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[ConsultaDContable.CorteDConsulta.Movimiento]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.Estatus]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.Proyecto]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.ContactoTipo]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.Contacto]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



[ConsultaDContable.CorteDConsulta.Cuenta]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.CtaCategoria]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.CtaCategoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.CtaFamilia]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.CtaFamilia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.CtaGrupo]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.CtaGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[ConsultaDContable.Columnas]
Empresa=59
Cuenta=99
CtaCategoria=90
CtaFamilia=87
CtaGrupo=89
Sucursal=64
UEN=64
Modulo=64
Movimiento=113
Estatus=75
Proyecto=90
ContactoTipo=124
Contacto=64
ImporteMin=87
ImporteMax=88





Desglosar=72
Accion=72
Agrupador=137

Importe=112
Saldo=101
Cargo=102
Abono=94
SaldoI=74
[ConsultaDContable.CorteDConsulta.Desglosar]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Desglosar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.Accion]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.Agrupador]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Agrupador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
















[ConsultaDContable.CorteDConsulta.Saldo]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Saldo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Efectos=[Negritas]
[ConsultaDContable.CorteDConsulta.Cargo]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Cargo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Efectos=[Negritas]
[ConsultaDContable.CorteDConsulta.Abono]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.Abono
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













Efectos=[Negritas]












[ConsultaDContable.CorteDConsulta.ImporteMin]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.ImporteMin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[ConsultaDContable.CorteDConsulta.ImporteMax]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.ImporteMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

















































































































































































































































































































[(Carpeta Totalizadores).Saldo Inicial]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Inicial
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata

Pegado=S
[(Carpeta Totalizadores).Cargos]
Carpeta=(Carpeta Totalizadores)
Clave=Cargos
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata

Pegado=S
[(Carpeta Totalizadores).Abonos]
Carpeta=(Carpeta Totalizadores)
Clave=Abonos
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata

Pegado=S
[(Carpeta Totalizadores).Saldo Final]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Final
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata




Pegado=S













[TotalizadorCorteDContable.Corte.SaldoI]
Carpeta=TotalizadorCorteDContable
Clave=Corte.SaldoI
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[TotalizadorCorteDContable.Corte.Cargo]
Carpeta=TotalizadorCorteDContable
Clave=Corte.Cargo
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[TotalizadorCorteDContable.Corte.Abono]
Carpeta=TotalizadorCorteDContable
Clave=Corte.Abono
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[TotalizadorCorteDContable.Corte.Saldo]
Carpeta=TotalizadorCorteDContable
Clave=Corte.Saldo
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









Tamano=15









[TotalizadorCorteDImporte.Corte.Importe]
Carpeta=TotalizadorCorteDImporte
Clave=Corte.Importe
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco






[ConsultaDContable.CorteDConsulta.SaldoI]
Carpeta=ConsultaDContable
Clave=CorteDConsulta.SaldoI
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Efectos=[Negritas]




[TotalizadorCorteDContable.ListaEnCaptura]
(Inicio)=Corte.SaldoI
Corte.SaldoI=Corte.Cargo
Corte.Cargo=Corte.Abono
Corte.Abono=Corte.Saldo
Corte.Saldo=(Fin)











































[ConsultaDUnidades]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Consulta
Clave=ConsultaDUnidades
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CorteDConsulta
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Corte
LlaveLocal=CorteDConsulta.ID
LlaveMaestra=Corte.ID
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




ControlRenglon=S
CampoRenglon=CorteDConsulta.Renglon
CondicionVisible=MovTipo(<T>CORTE<T>, Corte:Corte.Mov) en(CORTE.CORTEUNIDADES)
[ConsultaDUnidades.CorteDConsulta.Moneda]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ConsultaDUnidades.CorteDConsulta.Cuenta]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ConsultaDUnidades.CorteDConsulta.CtaCategoria]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.CtaCategoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDUnidades.CorteDConsulta.CtaFamilia]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.CtaFamilia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDUnidades.CorteDConsulta.CtaGrupo]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.CtaGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDUnidades.CorteDConsulta.CtaFabricante]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.CtaFabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDUnidades.CorteDConsulta.CtaLinea]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.CtaLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDUnidades.CorteDConsulta.Movimiento]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[ConsultaDUnidades.Columnas]
Empresa=64
Moneda=76
Cuenta=115
CtaCategoria=91
CtaFamilia=90
CtaGrupo=90
CtaFabricante=73
CtaLinea=72
Movimiento=105






















Rama=102
Desglosar=74
Agrupador=123
Almacen=99

Accion=70
SaldoUI=83
CargoU=82
AbonoU=87
SaldoU=82
Importe=95


[ConsultaDUnidades.CorteDConsulta.Rama]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco





























[ConsultaDUnidades.CorteDConsulta.Desglosar]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.Desglosar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ConsultaDUnidades.CorteDConsulta.Agrupador]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.Agrupador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
































[ConsultaDUnidades.CorteDConsulta.Almacen]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco













[FiltroCorteUnidades]
Estilo=Ficha
Pestana=S
Clave=FiltroCorteUnidades
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Corte
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

PestanaOtroNombre=S
PestanaNombre=Filtro
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

PermiteEditar=S
CondicionVisible=MovTipo(<T>CORTE<T>, Corte:Corte.Mov) en(CORTE.CORTEUNIDADES)
[FiltroCorteUnidades.Corte.CorteFiltrarFechas]
Carpeta=FiltroCorteUnidades
Clave=Corte.CorteFiltrarFechas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15
[FiltroCorteUnidades.Corte.CorteFechaD]
Carpeta=FiltroCorteUnidades
Clave=Corte.CorteFechaD
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=13
[FiltroCorteUnidades.Corte.CorteFechaA]
Carpeta=FiltroCorteUnidades
Clave=Corte.CorteFechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=S
Tamano=13
[FiltroCorteUnidades.Corte.CorteTitulo]
Carpeta=FiltroCorteUnidades
Clave=Corte.CorteTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





EspacioPrevio=S



[FiltroCorteUnidades.Corte.CorteValuacion]
Carpeta=FiltroCorteUnidades
Clave=Corte.CorteValuacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco



[FiltroCorteUnidades.ListaEnCaptura]
(Inicio)=Corte.CorteFiltrarFechas
Corte.CorteFiltrarFechas=Corte.CorteFechaD
Corte.CorteFechaD=Corte.CorteFechaA
Corte.CorteFechaA=Corte.CorteValuacion
Corte.CorteValuacion=Corte.CorteTitulo
Corte.CorteTitulo=(Fin)











[(Carpeta Totalizadores).Saldo Inicial U.]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Inicial U.
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata

[(Carpeta Totalizadores).Cargos U.]
Carpeta=(Carpeta Totalizadores)
Clave=Cargos U.
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata

[(Carpeta Totalizadores).Abonos U.]
Carpeta=(Carpeta Totalizadores)
Clave=Abonos U.
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata

[(Carpeta Totalizadores).Saldo Final U.]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Final U.
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata














[ConsultaDUnidades.CorteDConsulta.Accion]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco














































































































































[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Saldo Inicial U.
Saldo Inicial U.=Cargos U.
Cargos U.=Abonos U.
Abonos U.=Saldo Final U.
Saldo Final U.=Saldo Inicial
Saldo Inicial=Cargos
Cargos=Abonos
Abonos=Saldo Final
Saldo Final=Importe Total
Importe Total=(Fin)





















































































[FiltroCorteImporte.ListaEnCaptura]
(Inicio)=Corte.CorteFiltrarFechas
Corte.CorteFiltrarFechas=Corte.CorteFechaD
Corte.CorteFechaD=Corte.CorteFechaA
Corte.CorteFechaA=Corte.CorteTitulo
Corte.CorteTitulo=(Fin)




[ConsultaDCx]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Consulta
Clave=ConsultaDCx
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CorteDConsulta
Fuente={Tahoma, 8, Negro, []}
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


Detalle=S
VistaMaestra=Corte
LlaveLocal=CorteDConsulta.ID
LlaveMaestra=Corte.ID
ControlRenglon=S
CampoRenglon=CorteDConsulta.Renglon
CondicionVisible=MovTipo(<T>CORTE<T>, Corte:Corte.Mov) en(CORTE.CORTECX)
[ConsultaDCx.CorteDConsulta.Moneda]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[ConsultaDCx.CorteDConsulta.CtaCategoria]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.CtaCategoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDCx.CorteDConsulta.CtaFamilia]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.CtaFamilia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDCx.CorteDConsulta.CtaGrupo]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.CtaGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ConsultaDCx.CorteDConsulta.Movimiento]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ConsultaDCx.CorteDConsulta.Accion]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[ConsultaDCx.CorteDConsulta.Agrupador]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.Agrupador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[ConsultaDCx.Columnas]
Moneda=70
Cuenta=87
CtaCategoria=94
CtaFamilia=82
CtaGrupo=71
Movimiento=124
Accion=58
Agrupador=110

ContactoTipo=96
Contacto=80

Desglosar=64
Rama=105
Modulo=64
CtaTipo=90
[ConsultaDCx.CorteDConsulta.ContactoTipo]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ConsultaDCx.CorteDConsulta.Contacto]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco





[ConsultaDCx.CorteDConsulta.Desglosar]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.Desglosar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[ConsultaDCx.CorteDConsulta.Rama]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco








[ConsultaDCx.CorteDConsulta.Modulo]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco









[ConsultaDContable.ListaEnCaptura]
(Inicio)=CorteDConsulta.Cuenta
CorteDConsulta.Cuenta=CorteDConsulta.CtaCategoria
CorteDConsulta.CtaCategoria=CorteDConsulta.CtaFamilia
CorteDConsulta.CtaFamilia=CorteDConsulta.CtaGrupo
CorteDConsulta.CtaGrupo=CorteDConsulta.Sucursal
CorteDConsulta.Sucursal=CorteDConsulta.UEN
CorteDConsulta.UEN=CorteDConsulta.Movimiento
CorteDConsulta.Movimiento=CorteDConsulta.Estatus
CorteDConsulta.Estatus=CorteDConsulta.Proyecto
CorteDConsulta.Proyecto=CorteDConsulta.ContactoTipo
CorteDConsulta.ContactoTipo=CorteDConsulta.Contacto
CorteDConsulta.Contacto=CorteDConsulta.ImporteMin
CorteDConsulta.ImporteMin=CorteDConsulta.ImporteMax
CorteDConsulta.ImporteMax=CorteDConsulta.Desglosar
CorteDConsulta.Desglosar=CorteDConsulta.Accion
CorteDConsulta.Accion=CorteDConsulta.Agrupador
CorteDConsulta.Agrupador=CorteDConsulta.SaldoI
CorteDConsulta.SaldoI=CorteDConsulta.Cargo
CorteDConsulta.Cargo=CorteDConsulta.Abono
CorteDConsulta.Abono=CorteDConsulta.Saldo
CorteDConsulta.Saldo=(Fin)


[DetalleReporte.ListaEnCaptura]
(Inicio)=CorteDReporte.Columna1
CorteDReporte.Columna1=CorteDReporte.Columna2
CorteDReporte.Columna2=CorteDReporte.Columna3
CorteDReporte.Columna3=CorteDReporte.Columna4
CorteDReporte.Columna4=CorteDReporte.Columna5
CorteDReporte.Columna5=CorteDReporte.Columna6
CorteDReporte.Columna6=CorteDReporte.Columna7
CorteDReporte.Columna7=CorteDReporte.Columna8
CorteDReporte.Columna8=CorteDReporte.Columna9
CorteDReporte.Columna9=CorteDReporte.Columna10
CorteDReporte.Columna10=CorteDReporte.Columna11
CorteDReporte.Columna11=CorteDReporte.Columna12
CorteDReporte.Columna12=CorteDReporte.Columna13
CorteDReporte.Columna13=CorteDReporte.Columna14
CorteDReporte.Columna14=CorteDReporte.Columna15
CorteDReporte.Columna15=CorteDReporte.Columna16
CorteDReporte.Columna16=CorteDReporte.Columna17
CorteDReporte.Columna17=CorteDReporte.Columna18
CorteDReporte.Columna18=CorteDReporte.Columna19
CorteDReporte.Columna19=CorteDReporte.Columna20
CorteDReporte.Columna20=CorteDReporte.Columna21
CorteDReporte.Columna21=CorteDReporte.Columna22
CorteDReporte.Columna22=CorteDReporte.Columna23
CorteDReporte.Columna23=CorteDReporte.Columna24
CorteDReporte.Columna24=CorteDReporte.Columna25
CorteDReporte.Columna25=CorteDReporte.Columna26
CorteDReporte.Columna26=CorteDReporte.Columna27
CorteDReporte.Columna27=CorteDReporte.Columna28
CorteDReporte.Columna28=CorteDReporte.Columna29
CorteDReporte.Columna29=CorteDReporte.Columna30
CorteDReporte.Columna30=CorteDReporte.Columna31
CorteDReporte.Columna31=CorteDReporte.Columna32
CorteDReporte.Columna32=CorteDReporte.Columna33
CorteDReporte.Columna33=CorteDReporte.Columna34
CorteDReporte.Columna34=CorteDReporte.Columna35
CorteDReporte.Columna35=CorteDReporte.Columna36
CorteDReporte.Columna36=CorteDReporte.Columna37
CorteDReporte.Columna37=CorteDReporte.Columna38
CorteDReporte.Columna38=CorteDReporte.Columna39
CorteDReporte.Columna39=CorteDReporte.Columna40
CorteDReporte.Columna40=CorteDReporte.Columna41
CorteDReporte.Columna41=CorteDReporte.Columna42
CorteDReporte.Columna42=CorteDReporte.Columna43
CorteDReporte.Columna43=CorteDReporte.Columna44
CorteDReporte.Columna44=CorteDReporte.Columna45
CorteDReporte.Columna45=CorteDReporte.Columna46
CorteDReporte.Columna46=CorteDReporte.Columna47
CorteDReporte.Columna47=CorteDReporte.Columna48
CorteDReporte.Columna48=CorteDReporte.Columna49
CorteDReporte.Columna49=CorteDReporte.Columna50
CorteDReporte.Columna50=(Fin)


[ConsultaDUnidades.ListaEnCaptura]
(Inicio)=CorteDConsulta.Moneda
CorteDConsulta.Moneda=CorteDConsulta.Cuenta
CorteDConsulta.Cuenta=CorteDConsulta.CtaCategoria
CorteDConsulta.CtaCategoria=CorteDConsulta.CtaFamilia
CorteDConsulta.CtaFamilia=CorteDConsulta.CtaGrupo
CorteDConsulta.CtaGrupo=CorteDConsulta.CtaFabricante
CorteDConsulta.CtaFabricante=CorteDConsulta.CtaLinea
CorteDConsulta.CtaLinea=CorteDConsulta.Almacen
CorteDConsulta.Almacen=CorteDConsulta.Movimiento
CorteDConsulta.Movimiento=CorteDConsulta.Rama
CorteDConsulta.Rama=CorteDConsulta.Desglosar
CorteDConsulta.Desglosar=CorteDConsulta.Accion
CorteDConsulta.Accion=CorteDConsulta.Agrupador
CorteDConsulta.Agrupador=CorteDConsulta.SaldoUI
CorteDConsulta.SaldoUI=CorteDConsulta.CargoU
CorteDConsulta.CargoU=CorteDConsulta.AbonoU
CorteDConsulta.AbonoU=CorteDConsulta.SaldoU
CorteDConsulta.SaldoU=CorteDConsulta.Importe
CorteDConsulta.Importe=(Fin)

[ConsultaDUnidades.CorteDConsulta.SaldoUI]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.SaldoUI
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]

[ConsultaDUnidades.CorteDConsulta.CargoU]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.CargoU
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]

[ConsultaDUnidades.CorteDConsulta.AbonoU]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.AbonoU
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]

[ConsultaDUnidades.CorteDConsulta.SaldoU]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.SaldoU
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]

[ConsultaDUnidades.CorteDConsulta.Importe]
Carpeta=ConsultaDUnidades
Clave=CorteDConsulta.Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]




























[ConsultaDCx.ListaEnCaptura]
(Inicio)=CorteDConsulta.Modulo
CorteDConsulta.Modulo=CorteDConsulta.Rama
CorteDConsulta.Rama=CorteDConsulta.Moneda
CorteDConsulta.Moneda=CorteDConsulta.ContactoTipo
CorteDConsulta.ContactoTipo=CorteDConsulta.Contacto
CorteDConsulta.Contacto=CorteDConsulta.CtaCategoria
CorteDConsulta.CtaCategoria=CorteDConsulta.CtaFamilia
CorteDConsulta.CtaFamilia=CorteDConsulta.CtaGrupo
CorteDConsulta.CtaGrupo=CorteDConsulta.CtaTipo
CorteDConsulta.CtaTipo=CorteDConsulta.Movimiento
CorteDConsulta.Movimiento=CorteDConsulta.Accion
CorteDConsulta.Accion=CorteDConsulta.Desglosar
CorteDConsulta.Desglosar=CorteDConsulta.Agrupador
CorteDConsulta.Agrupador=(Fin)

[ConsultaDCx.CorteDConsulta.CtaTipo]
Carpeta=ConsultaDCx
Clave=CorteDConsulta.CtaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




























[MensualOMayor.ListaEnCaptura]
(Inicio)=Corte.DiaMes
Corte.DiaMes=Corte.FechaInicio
Corte.FechaInicio=(Fin)

[Semanal.ListaEnCaptura]
(Inicio)=Corte.Domingo
Corte.Domingo=Corte.Lunes
Corte.Lunes=Corte.Martes
Corte.Martes=Corte.Miercoles
Corte.Miercoles=Corte.Jueves
Corte.Jueves=Corte.Viernes
Corte.Viernes=Corte.Sabado
Corte.Sabado=(Fin)



































































































































































[Ficha.Corte.VigenciaD]
Carpeta=Ficha
Clave=Corte.VigenciaD
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

[Ficha.Corte.VigenciaA]
Carpeta=Ficha
Clave=Corte.VigenciaA
Editar=S
3D=S
Tamano=18
ColorFondo=Blanco





ValidaNombre=S





[FiltroEdoCtaCx.ListaEnCaptura]
(Inicio)=Corte.CorteCuentaTipo
Corte.CorteCuentaTipo=Corte.CorteFechaD
Corte.CorteFechaD=Corte.CorteCuentaDe
Corte.CorteCuentaDe=Corte.CorteCuentaA
Corte.CorteCuentaA=Corte.CorteEstatus
Corte.CorteEstatus=Corte.CorteMoneda
Corte.CorteMoneda=Corte.CorteTitulo
Corte.CorteTitulo=(Fin)

[FiltroEdoCtaCx.Corte.CorteMoneda]
Carpeta=FiltroEdoCtaCx
Clave=Corte.CorteMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco




































































[ConsultaDImporte.CorteDConsulta.SaldoU]
Carpeta=ConsultaDImporte
Clave=CorteDConsulta.SaldoU
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Efectos=[Negritas]







[ConsultaDImporte.ListaEnCaptura]
(Inicio)=CorteDConsulta.Moneda
CorteDConsulta.Moneda=CorteDConsulta.Sucursal
CorteDConsulta.Sucursal=CorteDConsulta.UEN
CorteDConsulta.UEN=CorteDConsulta.Usuario
CorteDConsulta.Usuario=CorteDConsulta.Modulo
CorteDConsulta.Modulo=CorteDConsulta.Movimiento
CorteDConsulta.Movimiento=CorteDConsulta.Totalizador
CorteDConsulta.Totalizador=CorteDConsulta.Estatus
CorteDConsulta.Estatus=CorteDConsulta.Situacion
CorteDConsulta.Situacion=CorteDConsulta.Proyecto
CorteDConsulta.Proyecto=CorteDConsulta.ContactoTipo
CorteDConsulta.ContactoTipo=CorteDConsulta.Contacto
CorteDConsulta.Contacto=CorteDConsulta.ImporteMin
CorteDConsulta.ImporteMin=CorteDConsulta.ImporteMax
CorteDConsulta.ImporteMax=CorteDConsulta.Accion
CorteDConsulta.Accion=CorteDConsulta.Desglosar
CorteDConsulta.Desglosar=CorteDConsulta.Agrupador
CorteDConsulta.Agrupador=CorteDConsulta.Importe
CorteDConsulta.Importe=CorteDConsulta.SaldoU
CorteDConsulta.SaldoU=(Fin)
























































[Ficha.Corte.CorteNoPeriodos]
Carpeta=Ficha
Clave=Corte.CorteNoPeriodos
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=6
[Ficha.Corte.CorteTipoPeriodo]
Carpeta=Ficha
Clave=Corte.CorteTipoPeriodo
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

Pegado=S











[Ficha.ListaEnCaptura]
(Inicio)=Corte.Mov
Corte.Mov=Corte.MovID
Corte.MovID=Corte.Proyecto
Corte.Proyecto=Corte.UEN
Corte.UEN=Corte.FechaEmision
Corte.FechaEmision=Corte.Moneda
Corte.Moneda=Corte.TipoCambio
Corte.TipoCambio=Corte.Concepto
Corte.Concepto=Corte.CorteEjercicio
Corte.CorteEjercicio=Corte.CortePeriodo
Corte.CortePeriodo=Corte.Referencia
Corte.Referencia=Corte.VigenciaD
Corte.VigenciaD=Corte.Observaciones
Corte.Observaciones=Corte.VigenciaA
Corte.VigenciaA=Corte.CorteTipo
Corte.CorteTipo=Corte.CorteFrecuencia
Corte.CorteFrecuencia=Corte.CorteGrupo
Corte.CorteGrupo=Corte.CorteOrigen
Corte.CorteOrigen=Corte.Frecuencia
Corte.Frecuencia=Corte.CorteNoPeriodos
Corte.CorteNoPeriodos=Corte.CorteTipoPeriodo
Corte.CorteTipoPeriodo=(Fin)

















































































[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden	(Acendente)
GrupoOrden	(Acendente)=FormaExtraCampo.Orden	(Acendente)
FormaExtraCampo.Orden	(Acendente)=(Fin)










[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S

























[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Corte.Referencia
Corte.Referencia=Corte.Concepto
Corte.Concepto=Corte.FechaEmision
Corte.FechaEmision=Corte.Importe
Corte.Importe=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CANCELADO
CANCELADO=CONCLUIDO
CONCLUIDO=VIGENTE
VIGENTE=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)



















[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Semanal
Semanal=MensualOMayor
MensualOMayor=FiltroCorteImporte
FiltroCorteImporte=FiltroCorteUnidades
FiltroCorteUnidades=FiltroEdoCtaCx
FiltroEdoCtaCx=FiltroValInv
FiltroValInv=FormaExtraValor
FormaExtraValor=DetalleReporte
DetalleReporte=ConsultaDImporte
ConsultaDImporte=ConsultaDContable
ConsultaDContable=ConsultaDUnidades
ConsultaDUnidades=ConsultaDCx
ConsultaDCx=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=Abrir
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
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=Anterior
Anterior=Siguiente
Siguiente=Anexos
Anexos=ProyInfo
ProyInfo=ComisionBorrador
ComisionBorrador=Tiempo
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
