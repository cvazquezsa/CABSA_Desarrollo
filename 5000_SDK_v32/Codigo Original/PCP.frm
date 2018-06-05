[Forma]
Clave=PCP
Nombre=<T>PCP<T>
Icono=0
Modulos=PCP
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=470
PosicionInicialArriba=197
PosicionInicialAltura=531
PosicionInicialAncho=500
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
MovModulo=PCP
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
PosicionInicialAlturaCliente=426
PosicionSec1=206
PosicionSec2=448

VentanaEstadoInicial=Normal
TituloAutoNombre=S
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>EJECUTARSQL(<T>EXEC spPCPInicializarTemporalRama :nEstacionTrabajo<T>,EstacionTrabajo)<BR>EJECUTARSQL(<T>EXEC spPCPInicializarTemporalCatalogoRama :nEstacionTrabajo<T>,EstacionTrabajo)
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PCP
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

[Ficha.PCP.Mov]
Carpeta=Ficha
Clave=PCP.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.PCP.MovID]
Carpeta=Ficha
Clave=PCP.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.PCP.FechaEmision]
Carpeta=Ficha
Clave=PCP.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.PCP.Concepto]
Carpeta=Ficha
Clave=PCP.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=S
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.PCP.Proyecto]
Carpeta=Ficha
Clave=PCP.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.PCP.Moneda]
Carpeta=Ficha
Clave=PCP.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.PCP.Referencia]
Carpeta=Ficha
Clave=PCP.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.PCP.Observaciones]
Carpeta=Ficha
Clave=PCP.Observaciones
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
Vista=PCPA
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
ListaOrden=PCP.ID<TAB>(Decendente)
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
FiltroFechasCampo=PCP.FechaEmision
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
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroAutoValidar=Mon
FiltroAplicaEn=PCP.Moneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=PCP.FechaCancelacion
FiltroSucursales=S
FiltroMonedas=S
FiltroMonedasCampo=PCP.Moneda

IconosNombre=PCPA:PCP.Mov+<T> <T>+PCPA:PCP.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=134
1=99

2=117
3=-2
4=98
5=150
6=60
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=S
Activo=S
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
Activo=S
ConCondicion=S

EjecucionCondicion=Si(General.MovConcurrente y ConDatos(PCP:PCP.ID) y (PCP:PCP.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, PCP:PCP.ID, <T>PCP<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero
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
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Visible=S
Activo=S
EspacioPrevio=S

[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=PCPD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=PCP
LlaveLocal=PCPD.ID
LlaveMaestra=PCP.ID
ControlRenglon=S
CampoRenglon=PCPD.Renglon
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
OtroOrden=S
ListaOrden=PCPD.Renglon<TAB>(Acendente)
HojaFondoGrisAuto=S
PermiteLocalizar=S

ListaEnCaptura=(Lista)
CondicionVisible=(No  MovTipoEn(<T>PCP<T>, PCP:PCP.Mov, ( PCP.PP, PCP.P,PCP.PC) ) )
[Detalle.Columnas]
Importe=69
Aplica=124
AplicaID=124
AplicaProntoPago=96
Referencia=113
Observaciones=110
ObligacionPCP=132
Tasa=37
Factor=64
Contacto=64
ContactoTipo=79
DebePCP=82
HaberPCP=87
OtrosImpuestos=89
Excento=43
Deducible=64
MovNombre=96
Base=69
Neto=95
CalcBase=74
CalcNeto=90

TipoImpuesto=72
CatalogoTipoTipo=107
CatalogoTipoRama=135
CatalogoTipoDigitos=41
CatalogoTipoEsAcumulativa=76
CatalogoTipoValidacion=112
CatalogoTipoTechoPresupuesto=96
ClavePresupuestal=134
ClavePresupuestalNombre=182
ClavePresupuestalDescripcion=141
ClavePresupuestalArticulosEsp=97
CatalogoClave=48
CatalogoTipo=84
CatalogoRamaTipo=304
CatalogoNombre=153
CatalogoTechoPresupuesto=96
CatalogoDescripcion=123
CatalogoObservaciones=185
CatalogoNombreAnterior=304
CatalogoDescripcionAnterior=604
CatalogoObservacionesAnterior=604
CatalogoRID=65
ReglaOrden=39
ReglaMascara=228
ReglaTipo=73
ReglaID=59
ID=64
Renglon=64
CatalogoTechoPresupuestoAnt=153
Sucursal=64
SucursalOrigen=76
Estatus=94
MiID=64
CampoNulo=10
RegistroNoGuardado=11
CatalogoRama=82
ClavePresupuestalCat1=62
ClavePresupuestalCat2=62
ClavePresupuestalCat3=62
ClavePresupuestalCat4=62
ClavePresupuestalCat5=124
ClavePresupuestalCat6=124
ClavePresupuestalCat7=124
ClavePresupuestalCat8=124
ClavePresupuestalCat9=124
ClavePresupuestalCatA=124
ClavePresupuestalCatB=124
ClavePresupuestalCatC=124
Nombre=266
ReglaDescripcion=231
Descripcion=208
Tipo=64
Mascara=185
ObjetoGasto=68
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
Totalizadores1=
Totalizadores2=
Totalizadores3=
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=Neto

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

Expresion=Asigna(Afectar.Modulo, <T>PCP<T>)<BR>Asigna(Afectar.ID, PCP:PCP.ID)<BR>Asigna(Afectar.Mov, PCP:PCP.Mov)<BR>Asigna(Afectar.MovID, PCP:PCP.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>PCP<T>)<BR>Asigna(Info.ID, PCP:PCP.ID)<BR>Asigna(Info.Mov, PCP:PCP.Mov)<BR>Asigna(Info.MovID, PCP:PCP.MovID)<BR>Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>PCP<T>, PCP:PCP.Mov))<BR>Si<BR>  (PCP:PCP.Estatus=EstatusPendiente) o (PCP:PCP.Estatus = EstatusVigente)<BR>Entonces<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si<BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Caso  Info.MovTipo<BR>      Es PCP.PP Entonces Dialogo(<T>GenerarPCPProyectoPresupuesto<T>)<BR>      Es PCP.E  Entonces Dialogo(<T>GenerarPCPEstructura<T>)<BR>      Es PCP.P  Entonces Dialogo(<T>GenerarPCPPresupuesto<T>)      <BR>    Fin<BR>  Fin<BR>Sino<BR>  Afectar(<T>PCP<T>, PCP:PCP.ID, PCP:PCP.Mov, PCP:PCP.MovID, <T>Todo<T>, <T><T>, <T>PCP<T>)<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, PCP:PCP.Usuario) y<BR>((PCP:PCP.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) o<BR>((PCP:PCP.Estatus en (EstatusPendiente, EstatusVigente)) y                                       <BR>fnPuedeAvanzarEstatus(Empresa, <T>PCP<T>, PCP:PCP.Mov, PCP:PCP.Estatus, FormaSituacion, Usuario)))
EjecucionCondicion=ConDatos(PCP:PCP.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (PCP:PCP.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusVigente, EstatusPendiente)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>PCP<T>, PCP:PCP.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>PCP<T>, PCP:PCP.Mov, PCP:PCP.ID, Verdadero, PCP:PCP.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusVigente, EstatusPendiente)), AbortarOperacion)<BR>FIn
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

ActivoCondicion=Vacio(PCP:PCP.MovID) y (PCP:PCP.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, PCP:PCP.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM PCP WHERE ID=:nID<T>, PCP:PCP.ID))
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
ListaParametros1=PCP:PCP.ID
Visible=S
TeclaRapida=Alt+F11

Expresion=Asigna(Info.ID,PCP:PCP.ID)<BR>ReportePantalla(ReporteMovPantalla(<T>PCP<T>, PCP:PCP.Mov, PCP:PCP.Estatus), PCP:PCP.ID)
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
ListaParametros1=PCP:PCP.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S

Expresion=Asigna(Info.ID,PCP:PCP.ID)<BR>ReporteImpresora(ReporteMovImpresora(<T>PCP<T>, PCP:PCP.Mov, PCP:PCP.Estatus), PCP:PCP.ID)
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

Expresion=Cancelar(<T>PCP<T>, PCP:PCP.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>PCP<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, PCP:PCP.Usuario) y ConDatos(PCP:PCP.ID) y ConDatos(PCP:PCP.MovID) y<BR>(PCP:PCP.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPorConfirmar, EstatusConcluido,EstatusPendiente, EstatusVigente))
AntesExpresiones=Asigna( Afectar.Mov, PCP:PCP.Mov ) <BR> Asigna( Afectar.MovID, PCP:PCP.MovID )
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

Expresion=Verificar(<T>PCP<T>, PCP:PCP.ID,PCP:PCP.Mov,PCP:PCP.MovID)
ActivoCondicion=PCP:PCP.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador,EstatusPendiente,EstatusVigente)
EjecucionCondicion=ConDatos(PCP:PCP.Mov)
[Ficha.PCP.TipoCambio]
Carpeta=Ficha
Clave=PCP.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco

[Aplica.PCP.MovAplica]
Carpeta=Aplica
Clave=PCP.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.PCP.MovAplicaID]
Carpeta=Aplica
Clave=PCP.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).PCP.Referencia]
Carpeta=(Carpeta Abrir)
Clave=PCP.Referencia
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
TeclaRapida=Shift+F3
NombreDesplegar=L&ocalizar...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Localizar
Activo=S
Visible=S

[(Carpeta Abrir).PCP.Concepto]
Carpeta=(Carpeta Abrir)
Clave=PCP.Concepto
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
ActivoCondicion=ConDatos(PCP:PCP.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.ID, PCP:PCP.ID)<BR>Asigna(Info.Mov, PCP:PCP.Mov)<BR>Asigna(Info.MovID, PCP:PCP.MovID)
[Aplica.PCP.Agente]
Carpeta=Aplica
Clave=PCP.Agente
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>PCP<T>, PCP:PCP.Mov, PCP:PCP.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>PCP<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>PCP<T>, PCP:PCP.Mov, PCP:PCP.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(PCP:PCP.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.ID, PCP:PCP.ID)<BR>Asigna(Info.Mov, PCP:PCP.Mov)<BR>Asigna(Info.Estatus, PCP:PCP.Estatus)<BR>Asigna(Info.Situacion, PCP:PCP.Situacion)
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

ActivoCondicion=ConfigModulo(<T>PCP<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(PCP:PCP.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.ID, PCP:PCP.ID)<BR>Asigna(Info.Mov, PCP:PCP.Mov)<BR>Asigna(Info.MovID, PCP:PCP.MovID)
[(Carpeta Abrir).PCP.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=PCP.FechaEmision
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

ActivoCondicion=ConDatos(PCPA:PCP.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.ID, PCPA:PCP.ID)
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
Antes=S

ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.ID, PCP:PCP.ID)<BR>Asigna(Info.Usuario, PCP:PCP.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(PCP:PCP.ID)
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

AntesExpresiones=Asigna(Info.Rama, <T>PCP<T>)<BR>Asigna(Info.Fecha, PCP:PCP.FechaEmision)<BR>Asigna(Info.ID, PCP:PCP.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (PCP:PCP.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, PCP:PCP.Mov+<T> <T>+PCP:PCP.MovID)
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

ActivoCondicion=ConDatos(PCP:PCP.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.ID, PCP:PCP.ID)
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

Expresion=CopiarMovimiento(<T>PCP<T>, PCP:PCP.ID, <T>PCP<T>)
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
Antes=S
RefrescarDespues=S

ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.ID, PCP:PCP.ID)<BR>Asigna(Info.Mov, PCP:PCP.Mov)<BR>Asigna(Info.MovID, PCP:PCP.MovID)
VisibleCondicion=PCP:PCP.Estatus<>EstatusSinAfectar
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
Antes=S

ActivoCondicion=Usuario.ModificarSucursalDestino y (PCP:PCP.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
AntesExpresiones=Si(Vacio(PCP:PCP.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino
[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

Boton=0
[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

Boton=0
[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

Boton=0
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

[Ficha.PCP.UEN]
Carpeta=Ficha
Clave=PCP.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
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

EjecucionCondicion=ConDatos(PCP:PCP.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, PCP:PCP.Proyecto)
[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.Mov, PCP:PCP.Mov)<BR>Asigna(Info.Clave, <T>PCP<T>+PCP:PCP.ID)<BR>Asigna(Info.Nombre, PCP:PCP.Mov+<T> <T>+PCP:PCP.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(PCP:PCP.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
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

AntesExpresiones=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.ID, PCP:PCP.ID)<BR>Asigna(Info.Mov, PCP:PCP.Mov)<BR>Asigna(Info.MovID, PCP:PCP.MovID)<BR>Asigna(Info.Fecha, PCP:PCP.FechaEmision)<BR>Asigna(Info.Estatus, PCP:PCP.Estatus)

[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+O
NombreDesplegar=P&olítica Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(PCP:PCP.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>PCP<T>)<BR>Asigna(Info.Clave, PCP:PCP.Mov)
[Acciones.PoliticaConcepto]
Nombre=PoliticaConcepto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+N
NombreDesplegar=Política Co&ncepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(PCP:PCP.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.Concepto, PCP:PCP.Concepto)
[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Forma, <T>PCP<T>)<BR>Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.Mov, PCP:PCP.Mov)<BR>Asigna(Info.Nombre, PCP:PCP.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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

Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>PCP<T>, PCP:PCP.Mov, PCP:PCP.ID, Falso, PCP:PCP.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>PCP<T>+PCP:PCP.ID)<BR>  Asigna(Info.Nombre, PCP:PCP.Mov+<T> <T>+PCP:PCP.MovID)<BR>  Asigna(Info.Modulo, <T>PCP<T>)<BR>  Asigna(Info.Mov, PCP:PCP.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si<BR>      PCP:PCP.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin
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

AntesExpresiones=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.ID, PCP:PCP.ID)<BR>Asigna(Info.Mov, PCP:PCP.Mov)<BR>Asigna(Info.MovID, PCP:PCP.MovID)
[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S

ActivoCondicion=Usuario.EnviarExcel y (PCP:PCP.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador,EstatusPendiente,EstatusVigente))
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

FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>PCP<T>, <T>{PCP:PCP.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>PCP{PCP:PCP.ID}<T>
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








[(Carpeta Totalizadores).Neto]
Carpeta=(Carpeta Totalizadores)
Clave=Neto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]










[Detalle.PCPD.CatalogoTipoTipo]
Carpeta=Detalle
Clave=PCPD.CatalogoTipoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.PCPD.CatalogoTipoRama]
Carpeta=Detalle
Clave=PCPD.CatalogoTipoRama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.PCPD.CatalogoTipoDigitos]
Carpeta=Detalle
Clave=PCPD.CatalogoTipoDigitos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Detalle.PCPD.ClavePresupuestal]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalNombre]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalDescripcion]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalArticulosEsp]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalArticulosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Detalle.PCPD.ReglaOrden]
Carpeta=Detalle
Clave=PCPD.ReglaOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.PCPD.ReglaMascara]
Carpeta=Detalle
Clave=PCPD.ReglaMascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.PCPD.ReglaTipo]
Carpeta=Detalle
Clave=PCPD.ReglaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Ficha.PCP.ClavePresupuestalMascara]
Carpeta=Ficha
Clave=PCP.ClavePresupuestalMascara
Editar=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco


































[Lista.Columnas]
UEN=44
Nombre=269
















0=64
1=-2
2=120
3=127
4=-2
5=-2
6=-2
Observacion=416
[Ficha.PCP.ProyectoDescripcion]
Carpeta=Ficha
Clave=PCP.ProyectoDescripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco


[Ficha.PCP.FechaInicio]
Carpeta=Ficha
Clave=PCP.FechaInicio
Editar=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco

[Ficha.PCP.FechaFin]
Carpeta=Ficha
Clave=PCP.FechaFin
Editar=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco












[Ficha.PCP.Categoria]
Carpeta=Ficha
Clave=PCP.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco





[Detalle.PCPD.CatalogoTipoValidacion]
Carpeta=Detalle
Clave=PCPD.CatalogoTipoValidacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.PCPD.CatalogoTipoTechoPresupuesto]
Carpeta=Detalle
Clave=PCPD.CatalogoTipoTechoPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco












































[Detalle.PCPD.Aplica]
Carpeta=Detalle
Clave=PCPD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.AplicaID]
Carpeta=Detalle
Clave=PCPD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















































































































































































































[Detalle.PCPD.CatalogoNombre]
Carpeta=Detalle
Clave=PCPD.CatalogoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco








[Detalle.PCPD.CatalogoTipo]
Carpeta=Detalle
Clave=PCPD.CatalogoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.PCPD.CatalogoClave]
Carpeta=Detalle
Clave=PCPD.CatalogoClave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.CatalogoTechoPresupuesto]
Carpeta=Detalle
Clave=PCPD.CatalogoTechoPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.PCPD.CatalogoDescripcion]
Carpeta=Detalle
Clave=PCPD.CatalogoDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Detalle.PCPD.CatalogoObservaciones]
Carpeta=Detalle
Clave=PCPD.CatalogoObservaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco




















































[Detalle.PCPD.CatalogoRama]
Carpeta=Detalle
Clave=PCPD.CatalogoRama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco































[Detalle.PCPD.Estatus]
Carpeta=Detalle
Clave=PCPD.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco






[Detalle.PCPD.Observaciones]
Carpeta=Detalle
Clave=PCPD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco














































































































[Detalle.PCPD.ClavePresupuestalCat1]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCat1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCat2]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCat2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCat3]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCat3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCat4]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCat4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCat5]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCat5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCat6]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCat6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCat7]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCat7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCat8]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCat8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCat9]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCat9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCatA]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCatA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCatB]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCatB
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PCPD.ClavePresupuestalCatC]
Carpeta=Detalle
Clave=PCPD.ClavePresupuestalCatC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








































































































[Detalle.ClavePresupuestal.Nombre]
Carpeta=Detalle
Clave=ClavePresupuestal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
































[Detalle.PCPD.ReglaDescripcion]
Carpeta=Detalle
Clave=PCPD.ReglaDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Acciones.Vigencia]
Nombre=Vigencia
Boton=53
NombreDesplegar=&Vigencia Regla
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PCPDRegla
Activo=S
Antes=S







ConCondicion=S





































































































































































EjecucionCondicion=Asigna(Info.Descripcion,PCPD:PCPD.ReglaDescripcion)<BR>GuardarCambios<BR>Forma.LocalizarValor(<T>Detalle<T>,<T>ReglaDescripcion<T>,PCPD:PCPD.ReglaDescripcion,FALSO)<BR>SI(Vacio(Info.Descripcion),FALSO,VERDADERO)
AntesExpresiones=Asigna(Info.ID,PCP:PCP.ID)<BR>Asigna(Info.Mov,PCP:PCP.Mov)<BR>Asigna(Info.MovID,PCP:PCP.MovID)<BR>Asigna(Info.Renglon,PCPD:PCPD.Renglon)<BR>Asigna(Info.Estatus,PCP:PCP.Estatus)
VisibleCondicion=MovTipoEn(<T>PCP<T>, PCP:PCP.Mov,(<T>PCP.R<T>))



















[Detalle.PCPD.ReglaID]
Carpeta=Detalle
Clave=PCPD.ReglaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Detalle.ProyClavePresupuestalRegla.Descripcion]
Carpeta=Detalle
Clave=ProyClavePresupuestalRegla.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.ProyClavePresupuestalRegla.Tipo]
Carpeta=Detalle
Clave=ProyClavePresupuestalRegla.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProyClavePresupuestalRegla.Mascara]
Carpeta=Detalle
Clave=ProyClavePresupuestalRegla.Mascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco








[(Carpeta Abrir).PCP.Proyecto]
Carpeta=(Carpeta Abrir)
Clave=PCP.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).PCP.ClavePresupuestalMascara]
Carpeta=(Carpeta Abrir)
Clave=PCP.ClavePresupuestalMascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).PCP.Categoria]
Carpeta=(Carpeta Abrir)
Clave=PCP.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco















[Ficha.PCP.CategoriaPredominante]
Carpeta=Ficha
Clave=PCP.CategoriaPredominante
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco






















































































[Ficha.ListaEnCaptura]
(Inicio)=PCP.Mov
PCP.Mov=PCP.MovID
PCP.MovID=PCP.Proyecto
PCP.Proyecto=PCP.UEN
PCP.UEN=PCP.Moneda
PCP.Moneda=PCP.TipoCambio
PCP.TipoCambio=PCP.FechaEmision
PCP.FechaEmision=PCP.ClavePresupuestalMascara
PCP.ClavePresupuestalMascara=PCP.Concepto
PCP.Concepto=PCP.ProyectoDescripcion
PCP.ProyectoDescripcion=PCP.Referencia
PCP.Referencia=PCP.FechaInicio
PCP.FechaInicio=PCP.Observaciones
PCP.Observaciones=PCP.FechaFin
PCP.FechaFin=PCP.Categoria
PCP.Categoria=PCP.CategoriaPredominante
PCP.CategoriaPredominante=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden	(Acendente)
GrupoOrden	(Acendente)=FormaExtraCampo.Orden	(Acendente)
FormaExtraCampo.Orden	(Acendente)=(Fin)






















[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122













[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S













[Detalle.ListaEnCaptura]
(Inicio)=PCPD.Aplica
PCPD.Aplica=PCPD.AplicaID
PCPD.AplicaID=PCPD.CatalogoTipoTipo
PCPD.CatalogoTipoTipo=PCPD.CatalogoTipoRama
PCPD.CatalogoTipoRama=PCPD.CatalogoTipoDigitos
PCPD.CatalogoTipoDigitos=PCPD.CatalogoTipoValidacion
PCPD.CatalogoTipoValidacion=PCPD.CatalogoTipoTechoPresupuesto
PCPD.CatalogoTipoTechoPresupuesto=PCPD.ReglaOrden
PCPD.ReglaOrden=PCPD.ReglaID
PCPD.ReglaID=PCPD.ReglaDescripcion
PCPD.ReglaDescripcion=PCPD.ReglaTipo
PCPD.ReglaTipo=PCPD.ReglaMascara
PCPD.ReglaMascara=PCPD.CatalogoTipo
PCPD.CatalogoTipo=PCPD.CatalogoClave
PCPD.CatalogoClave=PCPD.CatalogoNombre
PCPD.CatalogoNombre=PCPD.CatalogoRama
PCPD.CatalogoRama=PCPD.CatalogoTechoPresupuesto
PCPD.CatalogoTechoPresupuesto=PCPD.CatalogoDescripcion
PCPD.CatalogoDescripcion=PCPD.CatalogoObservaciones
PCPD.CatalogoObservaciones=PCPD.ClavePresupuestalCat1
PCPD.ClavePresupuestalCat1=PCPD.ClavePresupuestalCat2
PCPD.ClavePresupuestalCat2=PCPD.ClavePresupuestalCat3
PCPD.ClavePresupuestalCat3=PCPD.ClavePresupuestalCat4
PCPD.ClavePresupuestalCat4=PCPD.ClavePresupuestalCat5
PCPD.ClavePresupuestalCat5=PCPD.ClavePresupuestalCat6
PCPD.ClavePresupuestalCat6=PCPD.ClavePresupuestalCat7
PCPD.ClavePresupuestalCat7=PCPD.ClavePresupuestalCat8
PCPD.ClavePresupuestalCat8=PCPD.ClavePresupuestalCat9
PCPD.ClavePresupuestalCat9=PCPD.ClavePresupuestalCatA
PCPD.ClavePresupuestalCatA=PCPD.ClavePresupuestalCatB
PCPD.ClavePresupuestalCatB=PCPD.ClavePresupuestalCatC
PCPD.ClavePresupuestalCatC=PCPD.ClavePresupuestal
PCPD.ClavePresupuestal=PCPD.ClavePresupuestalNombre
PCPD.ClavePresupuestalNombre=PCPD.ClavePresupuestalDescripcion
PCPD.ClavePresupuestalDescripcion=PCPD.ObjetoGasto
PCPD.ObjetoGasto=PCPD.ClavePresupuestalArticulosEsp
PCPD.ClavePresupuestalArticulosEsp=ClavePresupuestal.Nombre
ClavePresupuestal.Nombre=ProyClavePresupuestalRegla.Descripcion
ProyClavePresupuestalRegla.Descripcion=ProyClavePresupuestalRegla.Tipo
ProyClavePresupuestalRegla.Tipo=ProyClavePresupuestalRegla.Mascara
ProyClavePresupuestalRegla.Mascara=PCPD.Estatus
PCPD.Estatus=PCPD.Observaciones
PCPD.Observaciones=(Fin)

[Detalle.PCPD.ObjetoGasto]
Carpeta=Detalle
Clave=PCPD.ObjetoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco






















[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=PCP.Referencia
PCP.Referencia=PCP.Concepto
PCP.Concepto=PCP.FechaEmision
PCP.FechaEmision=PCP.Proyecto
PCP.Proyecto=PCP.ClavePresupuestalMascara
PCP.ClavePresupuestalMascara=PCP.Categoria
PCP.Categoria=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=PENDIENTE
PENDIENTE=VIGENTE
VIGENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=SINCRO
SINCRO=(Fin)

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
Ficha=FormaExtraValor
FormaExtraValor=Detalle
Detalle=(Fin)

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
ProyInfo=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
MovPos=Vigencia
Vigencia=Navegador
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
