[Forma]
Clave=Cont
Nombre=Pólizas
Icono=0
Modulos=Cont
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=193
PosicionInicialArriba=81
PosicionInicialAltura=503
PosicionInicialAncho=979
PosicionSeccion1=26
Totalizadores=S
PosicionSeccion2=93
Menus=S
BarraHerramientas=S
BarraAyuda=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DialogoAbrir=S
ListaAcciones=(Lista)
Plantillas=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsMovimiento=S
Movimientos=
PosicionColumna3=50
PlantillasExcepciones=(Lista)
BarraAyudaBold=S
MovTipo=Todos
VentanaBloquearAjuste=N
TituloAuto=S
MovModulo=CONT
MovEspecificos=Todos
PlantillasEstandar=S
PlantillasProrrateo=S
PlantillasExcel=S
CarpetaProrrateo=Detalle
CamposProrrateo=(Lista)
MensajeProrrateo=Importe
ExcelCarpetaDestino=Detalle
ExcelColumnas=(Lista)
PlantillasClases=Normal
PosicionInicialAlturaCliente=527
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Def.Cuenta, Nulo)
PosicionSec1=120
PosicionSec2=430

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cont
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
CarpetaVisible=S

[Ficha.Cont.Mov]
Carpeta=Ficha
Clave=Cont.Mov
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[Ficha.Cont.MovID]
Carpeta=Ficha
Clave=Cont.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=$00400040
Pegado=S
IgnoraFlujo=S

[Ficha.Cont.Proyecto]
Carpeta=Ficha
Clave=Cont.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
Pegado=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Cont.Concepto]
Carpeta=Ficha
Clave=Cont.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.Cont.Moneda]
Carpeta=Ficha
Clave=Cont.Moneda
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Plata
Pegado=N
IgnoraFlujo=N

[Ficha.Cont.FechaEmision]
Carpeta=Ficha
Clave=Cont.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Cont.Referencia]
Carpeta=Ficha
Clave=Cont.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.Cont.Observaciones]
Carpeta=Ficha
Clave=Cont.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=64
ColorFondo=Blanco

[Detalle]
Estilo=Hoja
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Detalle=S
VistaMaestra=Cont
LlaveLocal=ContD.ID
LlaveMaestra=Cont.ID
ControlRenglon=S
CampoRenglon=ContD.Renglon
ValidarCampos=S
ListaCamposAValidar=(Lista)
HojaSubCta=Si
HojaSubNS=Si
HojaColoresPorTipo=S
CampoDespliegaTipo=Art.Tipo
ConResumen=S
VistaOmision=Resumén
HojaVistaOmision=Automática
HojaFondoGrisAuto=S
ResumenVista=ContR
ResumenLlave=ID
ResumenCampos=Cuenta<BR>Descripcion<BR>Debe<BR>Haber
ResumenVistaMaestra=Cont
ResumenLlaveMaestra=Cont.ID
PermiteLocalizar=S
HojaAjustarColumnas=S
Filtros=S
FiltroPredefinido1=Póliza<BR>Presupuesto
FiltroPredefinido2=ISNULL(ContD.Presupuesto, 0)=0<BR>ISNULL(ContD.Presupuesto, 0)=1
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroEstilo=Directorio
FiltroRespetar=S
FiltroTipo=Predefinido
FiltroPredefinido3=ContD.Renglon, ContD.RenglonSub<BR>ContD.Renglon, ContD.RenglonSub

[Detalle.Columnas]
Cantidad=66
Articulo=85
SubCuenta=110
Costo=71
Importe=81
CantidadPendiente=57
CantidadA=64
Disponible=63
Estatus=110
Renglon=64
RenglonID=64
RenglonTipo=54
DisponibleCuenta=75
Cuenta=114
Concepto=128
Debe=109
Haber=104
Descripcion=177
TipoCambio=63
Contacto=94
Movimiento=98
Vencimiento=62
Periodo=41
PeriodoNombre=59
Presupuesto=66
SucursalContable=44
Debe2=81
Haber2=84
DepartamentoDetallista=39
SubCuenta2=124
SubCuenta3=124
ContactoTipo=124
ContactoEspecifico=98

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Debe<BR>Haber
Totalizadores2=Suma(ContD:ContD.Debe)<BR>Suma(ContD:ContD.Haber)
Totalizadores3=(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=(Lista)
TotExpresionesEnSumas=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=S
Activo=S

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

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=S
Activo=S
ConCondicion=S
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Cont:Cont.ID) y (Cont:Cont.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Cont:Cont.ID, <T>CONT<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=ContA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
OtroOrden=S
ListaEnCaptura=(Lista)
ListaOrden=Cont.ID<TAB>(Decendente)
PestanaOtroNombre=S
PestanaNombre=Pólizas
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroUsuarios=S
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=Cont.FechaContable
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=SINAFECTAR
FiltroFechas=S
FiltroFechasDefault=(Todo)
BusquedaAvanzada=
BusquedaRespetarControlesNum=S
BusquedaRespetarFiltros=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDef=Devolucion Interna
FiltroMovDefault=(Todos)
IconosConPaginas=S
MenuLocal=S
IconosSeleccionUnitaria=S
FiltroFechasNormal=S
ListaAcciones=(Lista)
BusquedaRespetarUsuario=S
FiltroSituacion=S
FiltroSituacionTodo=S
PermiteLocalizar=S
BusquedaRespetarControles=S
FiltroFechasCancelacion=Cont.FechaCancelacion
FiltroSucursales=S

IconosNombre=ContA:Cont.Mov+<T> <T>+ContA:Cont.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=133
1=142

2=-2
3=-2
4=-2
[(Carpeta Abrir).Cont.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Cont.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

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

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=<T>E&liminar<T>
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
ActivoCondicion=Vacio(Cont:Cont.OrigenTipo) y Vacio(Cont:Cont.MovID) y (Cont:Cont.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Cont:Cont.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Cont WHERE ID=:nID<T>, Cont:Cont.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

[Acciones.Cambiar Vista Hoja]
Nombre=Cambiar Vista Hoja
Boton=0
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle-Resumen)
Visible=S
Activo=S

[Detalle.ContD.SubCuenta]
Carpeta=Detalle
Clave=ContD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
NombreDesplegar=<T>A&fectar<T>
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=F12
GuardarAntes=S
RefrescarDespues=S
ConCondicion=S
Antes=S
DespuesGuardar=S

Expresion=Afectar(<T>Cont<T>, Cont:Cont.ID, Cont:Cont.Mov, Cont:Cont.MovID, <T>Todo<T>, <T><T>, <T>Cont<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Cont:Cont.Usuario) y<BR>(Cont:Cont.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>CONT<T>, Cont:Cont.Mov, Cont:Cont.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Cont:Cont.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Cont:Cont.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CONT<T>, Cont:Cont.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CONT<T>, Cont:Cont.Mov, Cont:Cont.ID, Verdadero, Cont:Cont.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentación preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Cont:Cont.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=Asigna(Info.ID, Cont:Cont.ID)<BR>ReportePantalla(ReporteMovPantalla(<T>CONT<T>, Cont:Cont.Mov, Cont:Cont.Estatus), Cont:Cont.ID)
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
NombreDesplegar=&Imprimir...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Cont:Cont.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
EspacioPrevio=S
Expresion=Asigna(Info.ID, Cont:Cont.ID)<BR>ReporteImpresora(ReporteMovImpresora(<T>CONT<T>, Cont:Cont.Mov, Cont:Cont.Estatus), Cont:Cont.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Detalle.ColumnasResumen]
Articulo=117
Descripcion1=223
Cantidad=68
Costo=67
Importe=76
Pendiente=56
Cuenta=132
Descripcion=222
Debe=101
Haber=93

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
Activo=
ActivoCondicion=Cont:Cont.Estatus=EstatusSinAfectar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnMenu=S
TipoAccion=Expresion
Visible=S
ConfirmarAntes=S
DialogoMensaje=MovCancelar
EnBarraHerramientas=S
Antes=S
RefrescarDespues=S
GuardarAntes=S
Expresion=Cancelar(<T>Cont<T>, Cont:Cont.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Cont<T>)
ActivoCondicion=Vacio(Cont:Cont.OrigenTipo) y PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Cont:Cont.Usuario) y ConDatos(Cont:Cont.ID) y (ConDatos(Cont:Cont.MovID) o (Cont:Cont.Estatus=EstatusBorrador)) y<BR>(Cont:Cont.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusSincro, EstatusConcluido))
AntesExpresiones=Asigna(Afectar.Mov, Cont:Cont.Mov)<BR>Asigna(Afectar.MovID, Cont:Cont.MovID)

[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
GuardarAntes=S
ConCondicion=S
Expresion=Verificar(<T>Cont<T>, Cont:Cont.ID, Cont:Cont.Mov, Cont:Cont.MovID)
ActivoCondicion=Cont:Cont.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Cont:Cont.Mov)

[Acciones.Informacion]
Nombre=Informacion
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información de la Cuenta
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(ContD:ContD.Cuenta)
AntesExpresiones=Asigna(Info.Cuenta, ContD:ContD.Cuenta)<BR>Asigna(Info.Origen, <T>Cont<T>)

[Ficha.Cont.TipoCambio]
Carpeta=Ficha
Clave=Cont.TipoCambio
Editar=S
3D=S
Pegado=S
Tamano=6

[Detalle.ContD.Cuenta]
Carpeta=Detalle
Clave=ContD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ContD.Concepto]
Carpeta=Detalle
Clave=ContD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ContD.Debe]
Carpeta=Detalle
Clave=ContD.Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ContD.Haber]
Carpeta=Detalle
Clave=ContD.Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Debe]
Carpeta=(Carpeta Totalizadores)
Clave=Debe
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[(Carpeta Totalizadores).Haber]
Carpeta=(Carpeta Totalizadores)
Clave=Haber
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[(Carpeta Abrir).Cont.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Cont.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.DesAfectar]
Nombre=DesAfectar
Boton=0
Menu=&Archivo
NombreDesplegar=<T>&Desafectar<T>
EnMenu=S
TipoAccion=Expresion
Antes=S
RefrescarDespues=S
ConfirmarAntes=S
DialogoMensaje=MovDesAfectar
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F12
Expresion=DesAfectar(<T>Cont<T>, Cont:Cont.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Cont<T>)
ActivoCondicion=Vacio(Cont:Cont.OrigenTipo) y (Cont:Cont.Estatus=EstatusConcluido)
AntesExpresiones=Asigna(Afectar.Mov, Cont:Cont.Mov)<BR>Asigna(Afectar.MovID, Cont:Cont.MovID)
VisibleCondicion=Usuario.Desafectar

[Ficha.Cont.FechaContable]
Carpeta=Ficha
Clave=Cont.FechaContable
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Acciones.Diferencia]
Nombre=Diferencia
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=<T>&Diferencia<T>
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(Temp.Monetario, Suma(ContD:ContD.Debe)-Suma(ContD:ContD.Haber))<BR>Asigna(ContD:ContD.Debe, Nulo)<BR>Asigna(ContD:ContD.Haber, Nulo)<BR>Si(Temp.Monetario>0, Asigna(ContD:ContD.Haber, Temp.Monetario))<BR>Si(Temp.Monetario<0, Asigna(ContD:ContD.Debe, -Temp.Monetario))
ActivoCondicion=Cont:Cont.Estatus=EstatusSinAfectar

[Acciones.AsistenteCuentas]
Nombre=AsistenteCuentas
Boton=0
NombreDesplegar=Asistente Cuentas
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Cuentas Contables
ListaParametros1=ContD:ContD.Cuenta<BR>ContD:ContD.SubCuenta<BR>ContD:Cta.CentrosCostos<BR>ContD:ContD.Debe<BR>ContD:ContD.Haber
ListaParametros=S
Activo=S
Visible=S

[Acciones.NuevoUsando]
Nombre=NuevoUsando
Boton=0
Menu=&Archivo
NombreDesplegar=Nue&vo usando...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo Usando
Activo=S
Visible=S

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
EspacioPrevio=S
VisibleCondicion=Usuario.AfectarLote o Usuario.CancelarLote

[Acciones.AfectarLote]
Nombre=AfectarLote
Boton=0
NombreDesplegar=<T>&Afectar Selección<T>
EnMenu=S
TipoAccion=Expresion
RefrescarIconos=S
EnLote=S
Expresion=Afectar(<T>Cont<T>, ContA:Cont.ID, ContA:Cont.Mov, ContA:Cont.MovID, <T>Todo<T>, <T><T>, <T>Cont<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, ContA:Cont.Usuario)
VisibleCondicion=Usuario.AfectarLote

[Acciones.DesafectarLote]
Nombre=DesafectarLote
Boton=0
NombreDesplegar=<T>&Desafectar Selección<T>
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
Activo=S
EnLote=S
Expresion=Si<BR>  Vacio(ContA:Cont.OrigenTipo) y (ContA:Cont.Estatus=EstatusConcluido)<BR>Entonces<BR>  DesAfectar(<T>Cont<T>, ContA:Cont.ID, ContA:Cont.Mov, ContA:Cont.MovID)<BR>Fin
VisibleCondicion=Usuario.AfectarLote y Usuario.Desafectar

[(Carpeta Abrir).Cont.FechaContable]
Carpeta=(Carpeta Abrir)
Clave=Cont.FechaContable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).Cont.Referencia]
Carpeta=(Carpeta Abrir)
Clave=Cont.Referencia
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
ActivoCondicion=ConDatos(Cont:Cont.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.MovID, Cont:Cont.MovID)
[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S

GuardarAntes=S
DespuesGuardar=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>CONT<T>, Cont:Cont.Mov, Cont:Cont.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>CONT<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>CONT<T>, Cont:Cont.Mov, Cont:Cont.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Cont:Cont.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.Estatus, Cont:Cont.Estatus)<BR>Asigna(Info.Situacion, Cont:Cont.Situacion)
[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ActivoCondicion=ConfigModulo(<T>CONT<T>,<T>Tiempos<T>)=<T>Si<T>
ConCondicion=S
EjecucionCondicion=ConDatos(Cont:Cont.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.MovID, Cont:Cont.MovID)
Visible=S

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(ContA:Cont.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, ContA:Cont.ID)

[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Visible=S
EspacioPrevio=S
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
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Usuario, Cont:Cont.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Cont:Cont.ID)

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
ClaveAccion=AnexoMov
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EnBarraHerramientas=S
AntesExpresiones=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Fecha, Cont:Cont.FechaEmision)<BR>Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Cont:Cont.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Cont:Cont.Mov+<T> <T>+Cont:Cont.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(Cont:Cont.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, Cont:Cont.ID)
Visible=S

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
UsaTeclaRapida=S
TeclaRapida=Shift+F11
NombreDesplegar=Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=CopiarMovimiento(<T>CONT<T>, Cont:Cont.ID, <T>Cont<T>)

[Acciones.RepPanR]
Nombre=RepPanR
Boton=0
Menu=&Archivo
NombreDesplegar=Presentación Preliminar (Res&umen)
GuardarAntes=S
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=ContR
ListaParametros1=Cont:Cont.ID
ListaParametros=S
Visible=S
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.CancelarLote]
Nombre=CancelarLote
Boton=0
NombreDesplegar=<T>&Cancelar Selección<T>
EnMenu=S
TipoAccion=Expresion
Activo=S
RefrescarIconos=S
EnLote=S
ConfirmarAntes=S
DialogoMensaje=CancelarLote
Expresion=Cancelar(<T>Cont<T>, ContA:Cont.ID, ContA:Cont.Mov, ContA:Cont.MovID)
VisibleCondicion=Usuario.Cancelar y Usuario.CancelarLote

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
ClaveAccion=ContCampos
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.MovID, Cont:Cont.MovID)
VisibleCondicion=Cont:Cont.Estatus<>EstatusSinAfectar

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Cont:Cont.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
AntesExpresiones=Si(Vacio(Cont:Cont.ID),GuardarCambios)
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

[Ficha.Cont.UEN]
Carpeta=Ficha
Clave=Cont.UEN
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
EjecucionCondicion=ConDatos(Cont:Cont.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Cont:Cont.Proyecto)
Visible=S

[Detalle.ContD.Periodo]
Carpeta=Detalle
Clave=ContD.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AsistentePresupuestos]
Nombre=AsistentePresupuestos
Boton=12
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=Asistente Presupuestos
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Presupuestos
ListaParametros1=ContD:ContD.Cuenta<BR>ContD:Cta.Descripcion<BR>ContD:ContD.Periodo<BR>Si(ContD:Cta.EsAcreedora, <T>ContD:ContD.Haber<T>, <T>ContD:ContD.Debe<T>)
ListaParametros=S
Visible=S
EspacioPrevio=S
ConCondicion=S
Antes=S

ActivoCondicion=(MovTipo(<T>CONT<T>, Cont:Cont.Mov) = CONT.PR) y (Cont:Cont.Estatus=EstatusSinAfectar)
EjecucionCondicion=ConDatos(ContD:ContD.Cuenta)
AntesExpresiones=Asigna(Def.Cuenta, ContD:ContD.Cuenta)
[Detalle.PeriodoNombre]
Carpeta=Detalle
Clave=PeriodoNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Detalle.ContD.SucursalContable]
Carpeta=Detalle
Clave=ContD.SucursalContable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.Clave, <T>CONT<T>+Cont:Cont.ID)<BR>Asigna(Info.Nombre, Cont:Cont.Mov+<T> <T>+Cont:Cont.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Cont:Cont.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=0
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel y (Cont:Cont.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

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
AntesExpresiones=Asigna(Info.PuedeEditar, Cont:Cont.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Cont:Cont.Mov+<T> <T>+Cont:Cont.MovID)<BR>Asigna(Info.Proyecto, Cont:Cont.Proyecto)<BR>Asigna(Info.UEN, Cont:Cont.UEN)<BR>Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, Cont:Cont.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.MovID, Cont:Cont.MovID)<BR>Asigna(Info.Fecha, Cont:Cont.FechaEmision)<BR>Asigna(Info.Estatus, Cont:Cont.Estatus)

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
EjecucionCondicion=ConDatos(Cont:Cont.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Clave, Cont:Cont.Mov)

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
EjecucionCondicion=ConDatos(Cont:Cont.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.Concepto, Cont:Cont.Concepto)

[Ficha.Cont.Intercompania]
Carpeta=Ficha
Clave=Cont.Intercompania
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[Ficha.Cont.Contacto]
Carpeta=Ficha
Clave=Cont.Contacto
3D=S
Tamano=15
Editar=S
ColorFondo=Blanco

[Detalle.ContD.Debe2]
Carpeta=Detalle
Clave=ContD.Debe2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ContD.Haber2]
Carpeta=Detalle
Clave=ContD.Haber2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cont.OrigenMoneda]
Carpeta=Ficha
Clave=Cont.OrigenMoneda
3D=S
Tamano=9
ColorFondo=Plata

[Ficha.Cont.OrigenTipoCambio]
Carpeta=Ficha
Clave=Cont.OrigenTipoCambio
3D=S
Pegado=S
Tamano=6
ColorFondo=Plata

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>Cont<T>)<BR>Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.Nombre, Cont:Cont.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

[Detalle.ContD.Articulo]
Carpeta=Detalle
Clave=ContD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ContD.DepartamentoDetallista]
Carpeta=Detalle
Clave=ContD.DepartamentoDetallista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=CamposExtrasMovimiento(<T>CONT<T>, Cont:Cont.Mov, Cont:Cont.ID, Falso, Cont:Cont.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Ficha.Cont.AfectarPresupuesto]
Carpeta=Ficha
Clave=Cont.AfectarPresupuesto
Editar=S
LineaNueva=N
3D=S
Tamano=15
ColorFondo=Blanco

[Detalle.ContD.Presupuesto]
Carpeta=Detalle
Clave=ContD.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Distribuir]
Nombre=Distribuir
Boton=0
Menu=&Edición
NombreDesplegar=Distribuir Presupuesto...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ContDistribuir
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
GuardarAntes=S
RefrescarDespues=S
Antes=S
DespuesGuardar=S
ActivoCondicion=(MovTipo(<T>CONT<T>, Cont:Cont.Mov)=CONT.PR) y (Cont:Cont.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
EjecucionCondicion=ConDatos(ContD:ContD.Cuenta)
AntesExpresiones=Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Renglon, ContD:ContD.Renglon)<BR>Asigna(Info.RenglonSub, ContD:ContD.RenglonSub)<BR>Asigna(Info.Cuenta, ContD:ContD.Cuenta)<BR>Asigna(Info.SubCuenta, ContD:ContD.SubCuenta)<BR>Asigna(Info.Saldo, SQL(<T>SELECT SUM(ISNULL(Presupuesto, 0)-ISNULL(Ejercido, 0)-ISNULL(Reservado, 0)) FROM Presupuesto WHERE Cuenta=:tCta AND SubCuenta=:tSubCta AND Moneda=:tMon AND Empresa=:tEmpresa<T>, ContD:ContD.Cuenta, ContD:ContD.SubCuenta, Cont:Cont.Moneda, Empresa))
VisibleCondicion=General.PPTO

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
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.MovID, Cont:Cont.MovID)
DespuesGuardar=S
Visible=S

[Ficha.Cont.ContactoTipo]
Carpeta=Ficha
Clave=Cont.ContactoTipo
Editar=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco

[Ficha.Cont.Moneda2]
Carpeta=Ficha
Clave=Cont.Moneda2
3D=S
Tamano=9
ColorFondo=Plata

[Ficha.Cont.TipoCambio2]
Carpeta=Ficha
Clave=Cont.TipoCambio2
3D=S
Pegado=S
Tamano=6
ColorFondo=Plata

[Acciones.ContReg]
Nombre=ContReg
Boton=51
Menu=&Ver
NombreDesplegar=&Detalle Contable
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ContReg
Activo=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
AntesExpresiones=Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.MovID, Cont:Cont.MovID)
VisibleCondicion=General.Registro

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
Visible=S
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.MovID, Cont:Cont.MovID)<BR>Si(no Forma(<T>MovCopiarMeses<T>),  AbortarOperacion)

[Detalle.ContD.SubCuenta2]
Carpeta=Detalle
Clave=ContD.SubCuenta2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ContD.SubCuenta3]
Carpeta=Detalle
Clave=ContD.SubCuenta3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=207





[Detalle.ListaEnCaptura]
(Inicio)=ContD.Cuenta
ContD.Cuenta=ContD.SubCuenta
ContD.SubCuenta=ContD.SubCuenta2
ContD.SubCuenta2=ContD.SubCuenta3
ContD.SubCuenta3=ContD.Concepto
ContD.Concepto=ContD.Articulo
ContD.Articulo=ContD.DepartamentoDetallista
ContD.DepartamentoDetallista=ContD.Debe
ContD.Debe=ContD.Debe2
ContD.Debe2=ContD.Haber
ContD.Haber=ContD.Haber2
ContD.Haber2=ContD.Periodo
ContD.Periodo=PeriodoNombre
PeriodoNombre=ContD.SucursalContable
ContD.SucursalContable=ContD.Presupuesto
ContD.Presupuesto=ContD.ContactoTipo
ContD.ContactoTipo=ContD.ContactoEspecifico
ContD.ContactoEspecifico=(Fin)


[Detalle.ListaCamposAValidar]
(Inicio)=Cta.Descripcion
Cta.Descripcion=CentroCostos.Descripcion
CentroCostos.Descripcion=(Fin)

[Detalle.ContD.ContactoTipo]
Carpeta=Detalle
Clave=ContD.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ContD.ContactoEspecifico]
Carpeta=Detalle
Clave=ContD.ContactoEspecifico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Debe
Debe=Haber
Haber=(Fin)




[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122







[Ficha.ListaEnCaptura]
(Inicio)=Cont.Mov
Cont.Mov=Cont.MovID
Cont.MovID=Cont.Proyecto
Cont.Proyecto=Cont.UEN
Cont.UEN=Cont.Moneda
Cont.Moneda=Cont.TipoCambio
Cont.TipoCambio=Cont.OrigenMoneda
Cont.OrigenMoneda=Cont.OrigenTipoCambio
Cont.OrigenTipoCambio=Cont.FechaEmision
Cont.FechaEmision=Cont.FechaContable
Cont.FechaContable=Cont.ContactoTipo
Cont.ContactoTipo=Cont.Moneda2
Cont.Moneda2=Cont.TipoCambio2
Cont.TipoCambio2=Cont.Concepto
Cont.Concepto=Cont.Referencia
Cont.Referencia=Cont.Contacto
Cont.Contacto=Cont.Observaciones
Cont.Observaciones=Cont.AfectarPresupuesto
Cont.AfectarPresupuesto=Cont.Intercompania
Cont.Intercompania=(Fin)

























[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S







































































































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Cont.Concepto
Cont.Concepto=Cont.Referencia
Cont.Referencia=Cont.FechaContable
Cont.FechaContable=Cont.FechaEmision
Cont.FechaEmision=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=Seleccionar Todo
Seleccionar Todo=AfectarLote
AfectarLote=DesafectarLote
DesafectarLote=CancelarLote
CancelarLote=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirMostrar
AbrirMostrar=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=NuevoUsando
NuevoUsando=Nuevo
Nuevo=MovCopiar
MovCopiar=CopiarMeses
CopiarMeses=Abrir
Abrir=Localizar
Localizar=Guardar Cambios
Guardar Cambios=MovPersonal
MovPersonal=Evaluaciones
Evaluaciones=Propiedades
Propiedades=Imprimir
Imprimir=RepPantalla
RepPantalla=RepPanR
RepPanR=PlantillasOffice
PlantillasOffice=FormasAnexas
FormasAnexas=Excel
Excel=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Afectar
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=DesAfectar
DesAfectar=ReasignarUsuario
ReasignarUsuario=Cambiar Vista Hoja
Cambiar Vista Hoja=Campos
Campos=CamposExtras
CamposExtras=Distribuir
Distribuir=Totalizar
Totalizar=Tareas
Tareas=Anexos
Anexos=Diferencia
Diferencia=AsistentePresupuestos
AsistentePresupuestos=AsistenteCuentas
AsistenteCuentas=Anterior
Anterior=Siguiente
Siguiente=Informacion
Informacion=ContReg
ContReg=ProyInfo
ProyInfo=Tiempo
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

[Forma.PlantillasExcepciones]
(Inicio)=Cont:Cont.FechaEmision
Cont:Cont.FechaEmision=Cont:Cont.FechaContable
Cont:Cont.FechaContable=Cont:Cont.OrigenID
Cont:Cont.OrigenID=Cont:Cont.Origen
Cont:Cont.Origen=Cont:Cont.OrigenTipo
Cont:Cont.OrigenTipo=Cont:Cont.FechaCancelacion
Cont:Cont.FechaCancelacion=Cont:Cont.FechaConclusion
Cont:Cont.FechaConclusion=(Fin)

[Forma.CamposProrrateo]
(Inicio)=ContD.Debe
ContD.Debe=ContD.Haber
ContD.Haber=(Fin)

[Forma.ExcelColumnas]
(Inicio)=ContD.Cuenta
ContD.Cuenta=ContD.SubCuenta
ContD.SubCuenta=ContD.Concepto
ContD.Concepto=ContD.Debe
ContD.Debe=ContD.Haber
ContD.Haber=(Fin)
