[Forma]
Clave=ProyectoGestion
Nombre=<T>Gestión<T>
Icono=0
Modulos=GES
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=319
PosicionInicialArriba=103
PosicionInicialAltura=558
PosicionInicialAncho=801
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
PosicionSeccion1=29
PosicionSeccion2=92
BarraAyuda=S
MovModulo=GES
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=615
PosicionSec1=265
PosicionCol2=519
PosicionSec2=445
VentanaEstadoInicial=Normal

VentanaExclusiva=S
VentanaExclusivaOpcion=2
ExpresionesAlMostrar=Asigna(Filtro.Mov, Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Mov, Nulo)
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gestion
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=100
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnGestion=Gestion.Mov<BR>Gestion.MovID<BR>Gestion.Proyecto<BR>Gestion.UEN<BR>Gestion.FechaEmision<BR>Gestion.Catalogo<BR>Gestion.Clave<BR>Gestion.Concepto<BR>Gestion.Referencia<BR>Gestion.Observaciones
CarpetaVisible=S
PermiteEditar=S
PestanaNombre=Datos Generales
FichaEspacioNombresAuto=S
PestanaOtroNombre=S
Pestana=S
ListaEnCaptura=(Lista)

GuardarAlSalir=S
[Ficha.Gestion.Mov]
Carpeta=Ficha
Clave=Gestion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.MovID]
Carpeta=Ficha
Clave=Gestion.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=12
ColorFondo=Plata
Pegado=S
IgnoraFlujo=N
ColorFuente=Negro

[Ficha.Gestion.FechaEmision]
Carpeta=Ficha
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Proyecto]
Carpeta=Ficha
Clave=Gestion.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
EditarConBloqueo=N

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=GestionA
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
ListaEnGestion=Gestion.FechaEmision<BR>Gestion.Catalogo<BR>Gestion.Clave
ListaOrden=Gestion.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Gestion.FechaA
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
FiltroUsuarioDefault=(Usuario)
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=Gestion.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S
ListaEnCaptura=(Lista)
FiltroUsuarios=S
FiltroUsuarioAdicional=OR {Comillas(FiltroUsuarioActual)} IN (SELECT Usuario FROM GestionPara p WHERE p.ID = Gestion.ID AND p.RespuestaID IS NULL)
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

IconosNombre=GestionA:Gestion.Mov+<T> <T>+GestionA:Gestion.MovID
FiltroGeneral={Si(ConDatos(Filtro.RamaID),<T>Gestion.RamaID=<T>+Filtro.RamaID, <T><T>)}
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=169
1=168

2=124
3=106
4=-2
5=61
6=-2
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Gestion:Gestion.ID) y (Gestion:Gestion.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Gestion:Gestion.ID, <T>GES<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionConError=S
ActivoCondicion=Vacio(Gestion:Gestion.MovID) y (Gestion:Gestion.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Gestion:Gestion.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Gestion WHERE ID=:nID<T>, Gestion:Gestion.ID))
EjecucionMensaje=Gestion.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
UsaTeclaRapida=
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=
TipoAccion=Expresion
ListaParametros1=Gestion:Gestion.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>GES<T>, Gestion:Gestion.Mov, Gestion:Gestion.Estatus), Gestion:Gestion.ID)
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
ListaParametros1=Gestion:Gestion.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S

Expresion=ReporteImpresora(ReporteMovImpresora(<T>GES<T>, Gestion:Gestion.Mov, Gestion:Gestion.Estatus), Gestion:Gestion.ID)
ActivoCondicion=Usuario.ImprimirMovs
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
Expresion=Cancelar(<T>GES<T>, Gestion:Gestion.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Gestion<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Gestion:Gestion.Usuario) y ConDatos(Gestion:Gestion.ID) y ConDatos(Gestion:Gestion.MovID) y<BR>((Gestion:Gestion.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusSincro, EstatusPorAutorizar, EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja)) o (Gestion:Gestion.Estatus en (EstatusConcluido, EstatusPorConfirmar)))<BR>y (MovTipo(<T>GES<T>, Gestion:Gestion.Mov)<><T>GES.MOD<T>)
AntesExpresiones=Asigna( Afectar.Mov, Gestion:Gestion.Mov ) <BR>Asigna( Afectar.MovID, Gestion:Gestion.MovID )

[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
EspacioPrevio=S
ConCondicion=S
EnBarraHerramientas=S
Expresion=Verificar(<T>GES<T>, Gestion:Gestion.ID,Gestion:Gestion.Mov,Gestion:Gestion.MovID)
ActivoCondicion=Gestion:Gestion.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Gestion:Gestion.Mov)

[Aplica.Gestion.MovAplica]
Carpeta=Aplica
Clave=Gestion.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Gestion.MovAplicaID]
Carpeta=Aplica
Clave=Gestion.MovAplicaID
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
TeclaRapida=Shift+F3
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
EspacioPrevio=S

Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(Gestion:Gestion.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)
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
EspacioPrevio=S

GuardarAntes=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>GES<T>, Gestion:Gestion.Mov, Gestion:Gestion.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>GES<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>GES<T>, Gestion:Gestion.Mov, Gestion:Gestion.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Gestion:Gestion.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.Estatus, Gestion:Gestion.Estatus)<BR>Asigna(Info.Situacion, Gestion:Gestion.Situacion)
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
ActivoCondicion=ConfigModulo(<T>GES<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Gestion:Gestion.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)

[(Carpeta Abrir).Gestion.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

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

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Impuestos]
Carpeta=(Carpeta Totalizadores)
Clave=Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Retención]
Carpeta=(Carpeta Totalizadores)
Clave=Retención
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

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
DespuesGuardar=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Rama, <T>GES<T>)<BR>Asigna(Info.Fecha, Gestion:Gestion.FechaEmision)<BR>Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Gestion:Gestion.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Gestion:Gestion.Mov+<T> <T>+Gestion:Gestion.MovID)
RefrescarDespues=S

[Acciones.Bitacora]
Nombre=Bitacora
Boton=56
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
EjecucionCondicion=Si(Vacio(Gestion:Gestion.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)<BR>Asigna(Info.PuedeEditar, Gestion:Gestion.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Gestion:Gestion.Usuario))

[Acciones.AgregarEvento]
Nombre=AgregarEvento
Boton=56
Menu=&Edición
NombreDesplegar=Agregar E&vento
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacoraAgregar
ConCondicion=S
Antes=S
Visible=S
RefrescarDespues=S
GuardarAntes=S
ActivoCondicion=Gestion:Gestion.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Gestion:Gestion.Usuario)
EjecucionCondicion=Si(Vacio(Gestion:Gestion.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)

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
ActivoCondicion=ConDatos(Gestion:Gestion.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)

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
Expresion=CopiarMovimiento(<T>GES<T>, Gestion:Gestion.ID, <T>Gestion<T>)
Activo=S
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Gestion:Gestion.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Gestion:Gestion.ID),GuardarCambios)
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

[Detalle.Columnas]
Aplica=92
AplicaID=64
FechaEmision=128
Reporte=136
Tipo=96
Asunto=232
Socio=83
Titulo=86
Precio=101
Costo=85
PrecioTotal=104
CostoTotal=93
Tarima=97
Articulo=106
Unidad=45
Factor=49
Posicion=74
Contenedor=61
SubCuenta=108
AplicaRID=64
PosicionDestino=86
CantidadA=64
Contacto=78
ContactoTipo=75
Nombre=183
Medio=44
Direccion=94
Agente=51
Observaciones=91
Estado=127
Calificacion=58
Organizacion=108
MedioRef=67
Puesto=87
Telefonos=77
eMail=79
Recurso=76
0=124
1=452
VerCampo=297
VerValor=275
Campo=196
Valor=198
ValorAnterior=187
CampoNombre=179
Personal=82
Avance=56

[Ficha.Gestion.UEN]
Carpeta=Ficha
Clave=Gestion.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N
LineaNueva=N
ValidaNombre=N

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=103
Menu=&Edición
NombreDesplegar=E&valuaciones
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
EnBarraHerramientas=S
Expresion=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.Clave, <T>GES<T>+Gestion:Gestion.ID)<BR>Asigna(Info.Nombre, Gestion:Gestion.Mov+<T> <T>+Gestion:Gestion.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Gestion:Gestion.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)<BR>Asigna(Info.Fecha, Gestion:Gestion.FechaEmision)<BR>Asigna(Info.Estatus, Gestion:Gestion.Estatus)

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
EjecucionCondicion=ConDatos(Gestion:Gestion.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>GES<T>)<BR>Asigna(Info.Clave, Gestion:Gestion.Mov)

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
EjecucionCondicion=ConDatos(Gestion:Gestion.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.Concepto, Gestion:Gestion.Concepto)

[Ficha.Gestion.Concepto]
Carpeta=Ficha
Clave=Gestion.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Gestion.Referencia]
Carpeta=Ficha
Clave=Gestion.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Observaciones]
Carpeta=Ficha
Clave=Gestion.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=95
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
Activo=S
Visible=S
Expresion=Asigna(Info.Forma, <T>Gestion<T>)<BR>Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.Nombre, Gestion:Gestion.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)
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
Visible=S
ActivoCondicion=Usuario.EnviarExcel y (Gestion:Gestion.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Contacto.Gestion.Contacto]
Carpeta=Contacto
Clave=Gestion.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Contacto.Contacto.NombreCompleto]
Carpeta=Contacto
Clave=Contacto.NombreCompleto
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Cliente]
Carpeta=Contacto
Clave=Gestion.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.Cte.Nombre]
Carpeta=Contacto
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Proveedor]
Carpeta=Contacto
Clave=Gestion.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.Prov.Nombre]
Carpeta=Contacto
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Personal]
Carpeta=Contacto
Clave=Gestion.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.PersonalNombreCompleto]
Carpeta=Contacto
Clave=PersonalNombreCompleto
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Mov]
Carpeta=Contacto
Clave=Gestion.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.MovID]
Carpeta=Contacto
Clave=Gestion.MovID
Editar=N
3D=S
Pegado=N
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Proceso]
Carpeta=Contacto
Clave=Gestion.Proceso
Editar=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Tareas.Tarea.Estado]
Carpeta=Tareas
Clave=Tarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Tareas.Tarea.Vencimiento]
Carpeta=Tareas
Clave=Tarea.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Tareas.Tarea.Prioridad]
Carpeta=Tareas
Clave=Tarea.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Tareas.Columnas]
Asunto=474
Estado=93
Vencimiento=105
Prioridad=50
0=387
1=36

[Acciones.TareasImprimir]
Nombre=TareasImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.TareasSeleccionar]
Nombre=TareasSeleccionar
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.TareasQuitar]
Nombre=TareasQuitar
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.TareasPreliminar]
Nombre=TareasPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.TareasExcel]
Nombre=TareasExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.TareasPersonalizar]
Nombre=TareasPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.TareasAbrir]
Nombre=TareasAbrir
Boton=0
NombreDesplegar=&Abrir
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
RefrescarDespues=S
Expresion=Asigna(Info.TareaID, Tarea:Tarea.ID)<BR>Asigna(Info.PuedeEditar, Gestion:Gestion.Estatus=EstatusPendiente)<BR>Forma(<T>TareaEditar<T>)
ConCondicion=S
EjecucionCondicion=ConDatos(Tarea:Tarea.ID)

[Tareas.Tarea.Tipo]
Carpeta=Tareas
Clave=Tarea.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TareasCompletar]
Nombre=TareasCompletar
Boton=0
NombreDesplegar=Completar Selección
EnMenu=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Expresion=RegistrarSeleccionID(<T>Tareas<T>)<BR>EjecutarSQL(<T>spTareasCompletarSeleccion :nEstacion<T>, EstacionTrabajo) <BR>Gestion.ActualizarVista
Activo=S
Visible=S

[Tareas.Tarea.Fase]
Carpeta=Tareas
Clave=Tarea.Fase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Tareas.Tarea.Orden]
Carpeta=Tareas
Clave=Tarea.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.Nombre]
Carpeta=Contacto
Clave=GestionPara.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.Puesto]
Carpeta=Contacto
Clave=GestionPara.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.Organizacion]
Carpeta=Contacto
Clave=GestionPara.Organizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.Telefonos]
Carpeta=Contacto
Clave=GestionPara.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.eMail]
Carpeta=Contacto
Clave=GestionPara.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Observaciones.GestionPara.Observaciones]
Carpeta=Observaciones
Clave=GestionPara.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10x10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.DetallePersonalizar]
Nombre=DetallePersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Detalle.ContactoNombre]
Carpeta=Detalle
Clave=ContactoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.TareaSiguiente]
Carpeta=Detalle
Clave=TareaSiguiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.DetalleCancelar]
Nombre=DetalleCancelar
Boton=0
NombreDesplegar=&Cancelar
EnMenu=S
TipoAccion=Expresion
Activo=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+X
Expresion=Asigna(Info.Nombre, GestionPara:ContactoNombre)<BR>Si<BR>  Dialogo(<T>EstaSeguroFormaCancelar<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spFormaCancelarContacto :nID, :nRID<T>, Gestion:Gestion.ID, GestionPara:GestionPara.RID) <BR>  Gestion.ActualizarVista(<T>Lista<T>) <BR>Fin
VisibleCondicion=Gestion:Gestion.Estatus=EstatusPendiente

[Acciones.DetalleOportunidad]
Nombre=DetalleOportunidad
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=Generar &Oportunidad...
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(Info.Nombre, GestionPara:ContactoNombre)<BR>Si<BR>  Dialogo(<T>EstaSeguroFormaOportunidad<T>)<BR>Entonces<BR>  ProcesarSQL(<T>spFormaGenerarOportunidad :nID, :nRID<T>, Gestion:Gestion.ID, GestionPara:GestionPara.RID)<BR>  Gestion.ActualizarVista(<T>Lista<T>) <BR>Fin
VisibleCondicion=Gestion:Gestion.Estatus=EstatusPendiente

[Acciones.DetalleAbrir]
Nombre=DetalleAbrir
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Abrir
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(Info.PuedeEditar, Gestion:Gestion.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Clave, GestionPara:GestionPara.Contacto)<BR>Asigna(Info.Nombre, GestionPara:ContactoNombre)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)<BR>Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, GestionPara:GestionPara.RID)<BR>Asigna(Info.Reporte, Nulo)<BR>Caso GestionPara:GestionPara.ContactoTipo<BR>  Es <T>Prospecto<T> Entonces Si(Forma(<T>FormaProspecto<T>), Gestion.ActualizarVista(<T>Lista<T>))<BR>Fin
EjecucionCondicion=ConDatos(GestionPara:GestionPara.Contacto)

[eMail.Gestion.eMailDireccion]
Carpeta=eMail
Clave=Gestion.eMailDireccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco
ColorFuente=Negro

[eMail.Gestion.eMailAsunto]
Carpeta=eMail
Clave=Gestion.eMailAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Catalogo]
Carpeta=Ficha
Clave=Gestion.Catalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Clave]
Carpeta=Ficha
Clave=Gestion.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gestion.Catalogo]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Catalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gestion.Clave]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CampoNombre]
Carpeta=Detalle
Clave=CampoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Plata
ColorFuente=Negro

[Detalle.GestionPara.Aplica]
Carpeta=Detalle
Clave=GestionPara.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.AplicaID]
Carpeta=Detalle
Clave=GestionPara.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Personal]
Carpeta=Detalle
Clave=GestionPara.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Recurso]
Carpeta=Detalle
Clave=GestionPara.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Cantidad]
Carpeta=Detalle
Clave=GestionPara.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Costo]
Carpeta=Detalle
Clave=GestionPara.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Estado]
Carpeta=Detalle
Clave=GestionPara.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Avance]
Carpeta=Detalle
Clave=GestionPara.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Comentarios
Clave=Comentarios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Gestion
Fuente={Tahoma, 10, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Gestion.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S
ConFuenteEspecial=S

Pestana=S
[Comentarios.Gestion.Comentarios]
Carpeta=Comentarios
Clave=Gestion.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Asunto]
Carpeta=Ficha
Clave=Gestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=95
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Prioridad]
Carpeta=Ficha
Clave=Gestion.Prioridad
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gestion.Asunto]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Ficha.Gestion.Avance]
Carpeta=Ficha
Clave=Gestion.Avance
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Estado]
Carpeta=Ficha
Clave=Gestion.Estado
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
UsaTeclaRapida=S
NombreDesplegar=<T>A&fectar<T>
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConCondicion=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
TeclaRapida=F12

Expresion=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)<BR>Asigna(Afectar.Modulo, <T>GES<T>)<BR>Asigna(Afectar.ID, Gestion:Gestion.ID)<BR>Asigna(Afectar.Mov, Gestion:Gestion.Mov)<BR>Asigna(Afectar.MovID, Gestion:Gestion.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>GES<T>, Gestion:Gestion.Mov))<BR><BR>Si<BR> Gestion:Gestion.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja)<BR>Entonces<BR>  Si (ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T>)<BR>  Entonces<BR>    Si(Forma(<T>GenerarMovFlujo<T>), Generar(<T>GES<T>, Gestion:Gestion.ID, Gestion:Gestion.Mov, Gestion:Gestion.MovID, <T>Todo<T>, Info.MovGenerar, <T>Gestion<T>))<BR>  Sino<BR>    Dialogo(<T>GenerarGestion<T>)<BR>  Fin<BR>Sino<BR>  Si<BR>    Gestion:Gestion.Estatus=EstatusSinAfectar<BR>  Entonces<BR>    Afectar(<T>GES<T>, Gestion:Gestion.ID, Gestion:Gestion.Mov, Gestion:Gestion.MovID, <T>Todo<T>, <T><T>, <T>Gestion<T>)<BR>  Fin<BR>Fin
ActivoCondicion=(PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Gestion:Gestion.Usuario) y (Gestion:Gestion.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja))) o<BR>((Gestion:Gestion.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y (SQL(<T>SELECT COUNT(*) FROM GestionPara WHERE ID=:nID AND Usuario=:tUsuario<T>, Gestion:Gestion.ID, Usuario)))>0)<BR>y fnPuedeAvanzarEstatus(Empresa, <T>GES<T>, Gestion:Gestion.Mov, Gestion:Gestion.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Gestion:Gestion.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Gestion:Gestion.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>GES<T>, Gestion:Gestion.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>GES<T>, Gestion:Gestion.Mov, Gestion:Gestion.ID, Verdadero, Gestion:Gestion.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
[Motivo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Motivo
Clave=Motivo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gestion
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
ListaEnCaptura=Gestion.Motivo
AlinearTodaCarpeta=S
CondicionVisible=MovTipo(<T>GES<T>, Gestion:Gestion.Mov) = GES.NO

[Motivo.Gestion.Motivo]
Carpeta=Motivo
Clave=Gestion.Motivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro

[Para]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Para
Clave=Para
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GestionPara
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gestion
LlaveLocal=GestionPara.ID
LlaveMaestra=Gestion.ID
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

CondicionVisible=MovTipoEn(<T>GES<T>, Gestion:Gestion.Mov, (GES.SRES, GES.REU, GES.STAR, GES.OTAR)) o ((MovTipo(<T>GES<T>, Gestion:Gestion.Mov)=GES.MOD) y MovTipoEn(Gestion:Gestion.OrigenTipo, Gestion:Gestion.Origen, (GES.SRES, GES.REU, GES.STAR, GES.OTAR)))
[Para.GestionPara.Usuario]
Carpeta=Para
Clave=GestionPara.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Para.Usuario.Nombre]
Carpeta=Para
Clave=Usuario.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Para.Columnas]
Usuario=96
Nombre=307
GrupoTrabajo=116
Como=61
Requerido=56
EstatusNombre=109
Participacion=78
Respuestas=63
Conteo=84
Referencia=163
Movimiento=163
Respuesta=147
FechaEmision=113
FechaRegistro=113

[Para.GestionPara.Participacion]
Carpeta=Para
Clave=GestionPara.Participacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SubMovs.Columnas]
0=-2
1=-2

[SubMovimientos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Sub movimientos
Clave=SubMovimientos
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GestionSub
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gestion
LlaveLocal=Gestion.IDOrigen
LlaveMaestra=Gestion.ID
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
MenuLocal=S
ListaAcciones=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

IconosNombre=GestionSub:Gestion.Mov+<T> <T>+GestionSub:Gestion.MovID
FiltroGeneral=Gestion.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>)
CondicionVisible=(Gestion:Gestion.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y (MovTipo(<T>GES<T>, Gestion:Gestion.Mov) en (GES.SRES, GES.REU, GES.STAR, GES.OTAR, GES.TAR))
[SubMovimientos.Gestion.FechaEmision]
Carpeta=SubMovimientos
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SubMovimientos.Gestion.Asunto]
Carpeta=SubMovimientos
Clave=Gestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[SubMovimientos.Columnas]
0=180
1=93

2=214
3=208
4=-2
[(Carpeta Abrir).Gestion.Estado]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[(Carpeta Abrir).Gestion.Avance]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Reunion.Gestion.Asunto]
Carpeta=Reunion
Clave=Gestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=90
ColorFondo=Blanco
ColorFuente=Negro

[Reunion.Gestion.Ubicacion]
Carpeta=Reunion
Clave=Gestion.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=90
ColorFondo=Blanco
ColorFuente=Negro

[Reunion.Gestion.FechaD]
Carpeta=Reunion
Clave=Gestion.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Reunion.Gestion.FechaA]
Carpeta=Reunion
Clave=Gestion.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Reunion.Gestion.TodoElDia]
Carpeta=Reunion
Clave=Gestion.TodoElDia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Ficha.Gestion.FechaD]
Carpeta=Ficha
Clave=Gestion.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.FechaA]
Carpeta=Ficha
Clave=Gestion.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Ficha.Gestion.TodoElDia]
Carpeta=Ficha
Clave=Gestion.TodoElDia
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[(Carpeta Abrir).Gestion.FechaA]
Carpeta=(Carpeta Abrir)
Clave=Gestion.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Recursos.Columnas]
Recurso=64
Personal=64
Referencia=141
Fecha=73
HoraD=57
HoraA=53
Costo=55
CostoTotal=68
Nombre=163
Horas=49
Cantidad=64

[Recursos]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Recursos
Clave=Recursos
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GestionRecurso
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gestion
LlaveLocal=GestionRecurso.ID
LlaveMaestra=Gestion.ID
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
CondicionVisible=MovTipoEn(<T>GES<T>, Gestion:Gestion.Mov, (GES.AV, GES.TE))

[Recursos.GestionRecurso.Recurso]
Carpeta=Recursos
Clave=GestionRecurso.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Gris

[Recursos.GestionRecurso.Referencia]
Carpeta=Recursos
Clave=GestionRecurso.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.GestionRecurso.Fecha]
Carpeta=Recursos
Clave=GestionRecurso.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.GestionRecurso.HoraD]
Carpeta=Recursos
Clave=GestionRecurso.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.GestionRecurso.HoraA]
Carpeta=Recursos
Clave=GestionRecurso.HoraA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.GestionRecurso.Costo]
Carpeta=Recursos
Clave=GestionRecurso.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.CostoTotal]
Carpeta=Recursos
Clave=CostoTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.Gestion.HoraD]
Carpeta=Ficha
Clave=Gestion.HoraD
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.HoraA]
Carpeta=Ficha
Clave=Gestion.HoraA
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.SubMovPersonalizar]
Nombre=SubMovPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=SubMovimientos
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.SubMovPreliminar]
Nombre=SubMovPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=SubMovimientos
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Recursos.Recurso.Nombre]
Carpeta=Recursos
Clave=Recurso.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Para.Respuesta]
Carpeta=Para
Clave=Respuesta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Para.Gestion.FechaRegistro]
Carpeta=Para
Clave=Gestion.FechaRegistro
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[SubMovimientos.Gestion.Motivo]
Carpeta=SubMovimientos
Clave=Gestion.Motivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Ficha.OrigenNombre]
Carpeta=Ficha
Clave=OrigenNombre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.ExplorarMovimiento]
Nombre=ExplorarMovimiento
Boton=66
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=E&xplorar Movimiento
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ExplorarGestion
Antes=S
Visible=S
ActivoCondicion=SQL(<T>SELECT TOP(1) ID FROM Gestion WHERE RamaID=:nID<T>, Gestion:Gestion.ID)>0
AntesExpresiones=Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)

[Acciones.Fuente]
Nombre=Fuente
Boton=0
Menu=Forma&to
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
NombreDesplegar=&Fuente...
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma.RTF.Fuente(<T>Comentarios<T>, <T>Gestion.Comentarios<T>)

[Acciones.AlinearIzquierda]
Nombre=AlinearIzquierda
Boton=0
Menu=Forma&to
NombreDesplegar=Alinear a la &Izquierda
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma.RTF.AlinearIzquierda(<T>Comentarios<T>, <T>Gestion.Comentarios<T>)

[Acciones.Centrar]
Nombre=Centrar
Boton=0
Menu=Forma&to
NombreDesplegar=&Centrar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma.RTF.Centrar(<T>Comentarios<T>, <T>Gestion.Comentarios<T>)

[Acciones.AlinearDerecha]
Nombre=AlinearDerecha
Boton=0
Menu=Forma&to
NombreDesplegar=Alinear a la &Derecha
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma.RTF.AlinearDerecha(<T>Comentarios<T>, <T>Gestion.Comentarios<T>)

[Acciones.ConViñetas]
Nombre=ConViñetas
Boton=0
Menu=Forma&to
NombreDesplegar=Con &Viñetas
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Forma.RTF.ConVinetas(<T>Comentarios<T>, <T>Gestion.Comentarios<T>)

[Acciones.SinViñetas]
Nombre=SinViñetas
Boton=0
NombreDesplegar=&Sin Viñetas
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Menu=Forma&to
Expresion=Forma.RTF.SinVinetas(<T>Comentarios<T>, <T>Gestion.Comentarios<T>)

[Bitacora]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Bitácora
Clave=Bitacora
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovBitacora
Fuente={Tahoma, 8, Negro, []}
IconosCampo=EventoTipo.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=(Lista)
RefrescarAlEntrar=S
IconosNombre=MovBitacora:MovBitacora.Tipo
FiltroGeneral=MovBitacora.Modulo=<T>GES<T> AND MovBitacora.ID={Gestion:Gestion.ID}
CondicionVisible=Gestion:Gestion.Estatus <> EstatusSinAfectar

[Bitacora.MovBitacora.Evento]
Carpeta=Bitacora
Clave=MovBitacora.Evento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Bitacora.MovBitacora.Fecha]
Carpeta=Bitacora
Clave=MovBitacora.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Bitacora.MovBitacora.Usuario]
Carpeta=Bitacora
Clave=MovBitacora.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Bitacora.MovBitacora.Duracion]
Carpeta=Bitacora
Clave=MovBitacora.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Bitacora.MovBitacora.DuracionUnidad]
Carpeta=Bitacora
Clave=MovBitacora.DuracionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Bitacora.Columnas]
0=85
1=85

2=-2
3=-2
4=-2
5=-2
[Acciones.BitacoraPreliminar]
Nombre=BitacoraPreliminar
Boton=0
NombreDesplegar=Presentación &Preliminar
EnMenu=S
Carpeta=Bitacora
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.BitacoraImprimir]
Nombre=BitacoraImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=Bitacora
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.BitacoraExcel]
Nombre=BitacoraExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Bitacora
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.BitacoraPersonalizar]
Nombre=BitacoraPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Bitacora
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.BitacoraDetalles]
Nombre=BitacoraDetalles
Boton=0
NombreDesplegar=&Detalles
EnMenu=S
TipoAccion=Expresion
Expresion=VerComentario(MovBitacora:MovBitacora.Tipo+<T> - <T>+FechaEnTexto( MovBitacora:MovBitacora.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>), MovBitacora:MovBitacora.Evento )
Activo=S
Visible=S

[Acciones.Devolver]
Nombre=Devolver
Boton=79
NombreEnBoton=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=<T>&Devolver<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
RefrescarDespues=S
EspacioPrevio=S
Expresion=ProcesarSQL(<T>spAfectarTraficoGestion :nSucursal, :nID, :tAccion<T>, Sucursal, Gestion:Gestion.ID, <T>DEVOLVER<T>)
ActivoCondicion=Gestion:Gestion.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y<BR>PuedeModificar(Gestion:Gestion.Usuario) y Gestion:Gestion.PuedeDevolver

[Acciones.Transferir]
Nombre=Transferir
Boton=81
NombreEnBoton=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
NombreDesplegar=<T>Trans&ferir<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=GestionTransferir
Visible=S
GuardarAntes=S
RefrescarDespues=S
Antes=S
ActivoCondicion=Gestion:Gestion.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y<BR>PuedeModificar(Gestion:Gestion.Usuario) y MovTipoEn(<T>GES<T>, Gestion:Gestion.Mov, (GES.RES, GES.REU, GES.TAR))
AntesExpresiones=Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)

[Acciones.Prioridad]
Nombre=Prioridad
Boton=22
Menu=&Archivo
NombreDesplegar=Cambiar Prioridad...
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Dialogos
ClaveAccion=AfectarGestionPrioridad
Antes=S
Visible=S
RefrescarDespues=S

ActivoCondicion=Gestion:Gestion.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y PuedeModificar(Gestion:Gestion.Usuario)
AntesExpresiones=Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Prioridad, Gestion:Gestion.Prioridad)
[Acciones.ColaUsuario]
Nombre=ColaUsuario
Boton=0
Menu=&Ver
NombreDesplegar=Cola de &Usuarios
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovUsuario
ActivoCondicion=(Gestion:Gestion.Estatus<>EstatusSinAfectar) y Gestion:Gestion.PuedeDevolver
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, Gestion:Gestion.ID)
Visible=S

[Acciones.Autorizar]
Nombre=Autorizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F12
NombreDesplegar=A&utorizar
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovAutorizar
Antes=S
ActivoCondicion=Vacio(Gestion:Gestion.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Gestion<T>)<BR>Asigna(Afectar.Modulo, <T>GES<T>)<BR>Asigna(Afectar.ID, Gestion:Gestion.ID)<BR>Asigna(Afectar.Mov, Gestion:Gestion.Mov)<BR>Asigna(Afectar.MovID, Gestion:Gestion.MovID)<BR>Asigna(Info.Descripcion, Gestion:MensajeLista.Descripcion)
VisibleCondicion=Gestion:Gestion.Estatus=EstatusPorAutorizar

[Recursos.GestionRecurso.Cantidad]
Carpeta=Recursos
Clave=GestionRecurso.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Duracion]
Carpeta=Ficha
Clave=Gestion.Duracion
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Ficha.Gestion.Espacio]
Carpeta=Ficha
Clave=Gestion.Espacio
Editar=S
ValidaNombre=N
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Espacio.Nombre]
Carpeta=Ficha
Clave=Espacio.Nombre
Editar=S
3D=S
Pegado=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[Agenda]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agenda
Clave=Agenda
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GestionAgenda
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gestion
LlaveLocal=GestionAgenda.ID
LlaveMaestra=Gestion.ID
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
OtroOrden=S
ListaOrden=GestionAgenda.Orden<TAB>(Acendente)
HojaAjustarColumnas=S
MenuLocal=S
ListaAcciones=(Lista)
CondicionVisible=(MovTipo(<T>GES<T>, Gestion:Gestion.Mov) = GES.REU) o ((MovTipo(<T>GES<T>, Gestion:Gestion.Mov) en (GES.MOD, GES.TE)) y (MovTipo(Gestion:Gestion.OrigenTipo, Gestion:Gestion.Origen) = GES.REU))

[Agenda.GestionAgenda.Mov]
Carpeta=Agenda
Clave=GestionAgenda.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agenda.GestionAgenda.MovID]
Carpeta=Agenda
Clave=GestionAgenda.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agenda.GestionAgenda.Orden]
Carpeta=Agenda
Clave=GestionAgenda.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Agenda.Columnas]
Mov=106
MovID=65
Orden=35
Asunto=108
Espacio=64
FechaA=80
Duracion=49
Estado=69
Avance=55
Situacion=75
EstatusNombre=84
Modulo=45
FechaEmision=84
ID_1=64

[Acciones.AgendaAbrir]
Nombre=AgendaAbrir
Boton=0
NombreDesplegar=&Abrir Movimiento
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=Si<BR>  GestionAgenda:GestionAgenda.Modulo=Forma.Modulo<BR>Entonces<BR>  Forma.CapturaLocalizarMov(GestionAgenda:Gestion.ID)<BR>Sino<BR>  Si<BR>    Usuario.AgendaAccesoOtrosModulos<BR>  Entonces<BR>    FormaPos(SQL(<T>SELECT dbo.fnMovTabla(:tModulo)<T>, GestionAgenda:GestionAgenda.Modulo), SQL(<T>SELECT MIN(ID) FROM Mov WHERE Empresa=:tEmpresa AND Modulo=:tModulo AND Mov=:tMov AND MovID=:tMovID<T>, Empresa, GestionAgenda:GestionAgenda.Modulo, GestionAgenda:GestionAgenda.Mov, GestionAgenda:GestionAgenda.MovID))<BR>  Sino<BR>    Informacion(<T>Usted No Tiene Acceso a Abrir el Movimiento de Otro Modulo<T>) <BR>  Fin<BR>Fin

[Acciones.ModificarAgenda]
Nombre=ModificarAgenda
Boton=0
Menu=&Edición
NombreDesplegar=Modificar &Agenda...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=GestionAgenda
Antes=S
ActivoCondicion=Usuario.ModificarGestionAgenda
AntesExpresiones=Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)
VisibleCondicion=(MovTipo(<T>GES<T>, Gestion:Gestion.Mov) = GES.REU) y (Gestion:Gestion.Estatus=EstatusPendiente)

[Acciones.GastosAnexos]
Nombre=GastosAnexos
Boton=64
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F4
NombreDesplegar=Gastos...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Gasto
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Anexo.Modulo, <T>GES<T>)<BR>Asigna(Anexo.ID, Gestion:Gestion.ID)<BR>Asigna(Anexo.Mov, Gestion:Gestion.Mov)<BR>Asigna(Anexo.MovID, Gestion:Gestion.MovID)<BR>Asigna(Anexo.Estatus, Gestion:Gestion.Estatus)

[(Carpeta Abrir).Gestion.Gastos]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Gastos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovGrupo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agrupadores
Clave=MovGrupo
Filtros=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovGrupo
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gestion
LlaveLocal=MovGrupo.ModuloID
LlaveMaestra=Gestion.ID
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=MovGrupo.Modulo=<T>{Forma.Modulo}<T>

[MovGrupo.MovGrupo.ABC]
Carpeta=MovGrupo
Clave=MovGrupo.ABC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[MovGrupo.MovGrupo.POA]
Carpeta=MovGrupo
Clave=MovGrupo.POA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[MovGrupo.MovGrupo.CentroCostos]
Carpeta=MovGrupo
Clave=MovGrupo.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[MovGrupo.CentroCostos.Descripcion]
Carpeta=MovGrupo
Clave=CentroCostos.Descripcion
Editar=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[MovGrupo.MovGrupo.Espacio]
Carpeta=MovGrupo
Clave=MovGrupo.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[MovGrupo.Espacio.Nombre]
Carpeta=MovGrupo
Clave=Espacio.Nombre
Editar=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[MovGrupo.MovGrupo.Recurso]
Carpeta=MovGrupo
Clave=MovGrupo.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MovGrupo.Recurso.Nombre]
Carpeta=MovGrupo
Clave=Recurso.Nombre
Editar=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Acciones.VerModulo]
Nombre=VerModulo
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+M
NombreDesplegar=&Módulo
EnMenu=S
Carpeta=Agenda
TipoAccion=Controles Captura
ClaveAccion=Refrescar Controles
Antes=S
ActivoCondicion=Gestion:Gestion.Estatus = EstatusSinAfectar
AntesExpresiones=Asigna(Ver.Modulo, no Ver.Modulo)
VisibleCondicion=(MovTipo(<T>GES<T>, Gestion:Gestion.Mov) = GES.REU) o ((MovTipo(<T>GES<T>, Gestion:Gestion.Mov) en (GES.MOD, GES.TE)) y (MovTipo(Gestion:Gestion.OrigenTipo, Gestion:Gestion.Origen) = GES.REU))

[Agenda.EstatusNombre]
Carpeta=Agenda
Clave=EstatusNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Agenda.Gestion.Avance]
Carpeta=Agenda
Clave=Gestion.Avance
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Agenda.Gestion.Asunto]
Carpeta=Agenda
Clave=Gestion.Asunto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Gris

[Agenda.Gestion.FechaA]
Carpeta=Agenda
Clave=Gestion.FechaA
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Agenda.Gestion.Duracion]
Carpeta=Agenda
Clave=Gestion.Duracion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Agenda.Gestion.Estado]
Carpeta=Agenda
Clave=Gestion.Estado
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Gris

[Agenda.Gestion.Situacion]
Carpeta=Agenda
Clave=Gestion.Situacion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Agenda.Gestion.Espacio]
Carpeta=Agenda
Clave=Gestion.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AgendaAgregar]
Nombre=AgendaAgregar
Boton=0
NombreDesplegar=Agregar Movimientos &Otros Módulos...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=GestionAgendaMovLista
Visible=S
EspacioPrevio=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
ActivoCondicion=Gestion:Gestion.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID, Gestion:Gestion.ID)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)








[Recursos.ListaEnCaptura]
(Inicio)=GestionRecurso.Recurso
GestionRecurso.Recurso=Recurso.Nombre
Recurso.Nombre=GestionRecurso.Fecha
GestionRecurso.Fecha=GestionRecurso.HoraD
GestionRecurso.HoraD=GestionRecurso.HoraA
GestionRecurso.HoraA=GestionRecurso.Cantidad
GestionRecurso.Cantidad=GestionRecurso.Costo
GestionRecurso.Costo=CostoTotal
CostoTotal=GestionRecurso.Referencia
GestionRecurso.Referencia=(Fin)

[Bitacora.ListaEnCaptura]
(Inicio)=MovBitacora.Fecha
MovBitacora.Fecha=MovBitacora.Evento
MovBitacora.Evento=MovBitacora.Usuario
MovBitacora.Usuario=MovBitacora.Duracion
MovBitacora.Duracion=MovBitacora.DuracionUnidad
MovBitacora.DuracionUnidad=(Fin)

[Bitacora.ListaAcciones]
(Inicio)=BitacoraDetalles
BitacoraDetalles=BitacoraPreliminar
BitacoraPreliminar=BitacoraImprimir
BitacoraImprimir=BitacoraExcel
BitacoraExcel=BitacoraPersonalizar
BitacoraPersonalizar=(Fin)

[Agenda.ListaEnCaptura]
(Inicio)=GestionAgenda.Mov
GestionAgenda.Mov=GestionAgenda.MovID
GestionAgenda.MovID=GestionAgenda.Orden
GestionAgenda.Orden=Gestion.Avance
Gestion.Avance=EstatusNombre
EstatusNombre=Gestion.Asunto
Gestion.Asunto=Gestion.FechaA
Gestion.FechaA=Gestion.Duracion
Gestion.Duracion=Gestion.Espacio
Gestion.Espacio=Gestion.Estado
Gestion.Estado=Gestion.Situacion
Gestion.Situacion=(Fin)

[Agenda.ListaAcciones]
(Inicio)=AgendaAbrir
AgendaAbrir=AgendaAgregar
AgendaAgregar=(Fin)

[MovGrupo.ListaEnCaptura]
(Inicio)=MovGrupo.ABC
MovGrupo.ABC=MovGrupo.POA
MovGrupo.POA=MovGrupo.CentroCostos
MovGrupo.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=MovGrupo.Espacio
MovGrupo.Espacio=Espacio.Nombre
Espacio.Nombre=MovGrupo.Recurso
MovGrupo.Recurso=Recurso.Nombre
Recurso.Nombre=(Fin)













[Lista.Columnas]
0=201
1=375





































































[MAF]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Activo Fijo
Clave=MAF
PermiteEditar=S
GuardarAlSalir=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gestion
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

CondicionVisible=(((Gestion:MovTipo.Clave = <T>GES.SRES<T>) Y (Gestion:MovTipo.SubClave = <T>MAF.SI<T>)) O ((Gestion:MovTipo.Clave = <T>GES.RES<T>) Y (Gestion:MovTipo.SubClave = <T>MAF.I<T>))) Y (General.MAF)
[MAF.ListaEnCaptura]
(Inicio)=Gestion.AFArticulo
Gestion.AFArticulo=Gestion.AFSerie
Gestion.AFSerie=(Fin)

[MAF.Gestion.AFArticulo]
Carpeta=MAF
Clave=Gestion.AFArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MAF.Gestion.AFSerie]
Carpeta=MAF
Clave=Gestion.AFSerie
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ListaEnCaptura]
(Inicio)=Gestion.Mov
Gestion.Mov=Gestion.MovID
Gestion.MovID=Gestion.Proyecto
Gestion.Proyecto=Gestion.UEN
Gestion.UEN=Gestion.Prioridad
Gestion.Prioridad=Gestion.FechaEmision
Gestion.FechaEmision=OrigenNombre
OrigenNombre=Gestion.Asunto
Gestion.Asunto=Gestion.FechaD
Gestion.FechaD=Gestion.TodoElDia
Gestion.TodoElDia=Gestion.HoraD
Gestion.HoraD=Gestion.HoraA
Gestion.HoraA=Gestion.Espacio
Gestion.Espacio=Espacio.Nombre
Espacio.Nombre=Gestion.FechaA
Gestion.FechaA=Gestion.Duracion
Gestion.Duracion=Gestion.Estado
Gestion.Estado=Gestion.Avance
Gestion.Avance=Gestion.Concepto
Gestion.Concepto=Gestion.Referencia
Gestion.Referencia=Gestion.Observaciones
Gestion.Observaciones=(Fin)




[MAFIndicador]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Indicadores
Clave=MAFIndicador
Detalle=S
PermiteEditar=S
GuardarAlSalir=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=GestionActivoFIndicador
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gestion
LlaveLocal=GestionActivoFIndicador.ID
LlaveMaestra=Gestion.ID
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


CondicionVisible=Asigna(Info.Tipo,Gestion:ActivoF.Tipo)<BR>(((Gestion:MovTipo.Clave = <T>GES.SRES<T>) Y (Gestion:MovTipo.SubClave = <T>MAF.SI<T>)) O ((Gestion:MovTipo.Clave = <T>GES.RES<T>) Y (Gestion:MovTipo.SubClave = <T>MAF.I<T>))) Y (General.MAF)
[MAFIndicador.GestionActivoFIndicador.Indicador]
Carpeta=MAFIndicador
Clave=GestionActivoFIndicador.Indicador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[MAFIndicador.GestionActivoFIndicador.Referencia]
Carpeta=MAFIndicador
Clave=GestionActivoFIndicador.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[MAFIndicador.GestionActivoFIndicador.LecturaAnterior]
Carpeta=MAFIndicador
Clave=GestionActivoFIndicador.LecturaAnterior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[MAFIndicador.GestionActivoFIndicador.Lectura]
Carpeta=MAFIndicador
Clave=GestionActivoFIndicador.Lectura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro




[MAFIndicador.ListaEnCaptura]
(Inicio)=GestionActivoFIndicador.Indicador
GestionActivoFIndicador.Indicador=GestionActivoFIndicador.Referencia
GestionActivoFIndicador.Referencia=GestionActivoFIndicador.LecturaAnterior
GestionActivoFIndicador.LecturaAnterior=GestionActivoFIndicador.Lectura
GestionActivoFIndicador.Lectura=(Fin)




[MAFIndicador.Columnas]
Indicador=304
Referencia=201
LecturaAnterior=124
Lectura=124































[(Carpeta Abrir).Para]
Carpeta=(Carpeta Abrir)
Clave=Para
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco












































































[SubMovimientos.ListaEnCaptura]
(Inicio)=Gestion.FechaEmision
Gestion.FechaEmision=Para
Para=Gestion.Asunto
Gestion.Asunto=Gestion.Motivo
Gestion.Motivo=(Fin)

[SubMovimientos.ListaAcciones]
(Inicio)=SubMovPreliminar
SubMovPreliminar=SubMovPersonalizar
SubMovPersonalizar=(Fin)

[SubMovimientos.Para]
Carpeta=SubMovimientos
Clave=Para
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco







[Para.ListaEnCaptura]
(Inicio)=GestionPara.Usuario
GestionPara.Usuario=Usuario.Nombre
Usuario.Nombre=GestionPara.Participacion
GestionPara.Participacion=Respuesta
Respuesta=Gestion.FechaRegistro
Gestion.FechaRegistro=(Fin)













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




















































































































































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Gestion.Asunto
Gestion.Asunto=Para
Para=Gestion.FechaA
Gestion.FechaA=Gestion.Estado
Gestion.Estado=Gestion.Avance
Gestion.Avance=Gestion.Gastos
Gestion.Gastos=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=ALTAPRIORIDAD
ALTAPRIORIDAD=PRIORIDADBAJA
PRIORIDADBAJA=AUTORIZAR
AUTORIZAR=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Agenda
Agenda=Para
Para=Motivo
Motivo=Recursos
Recursos=Bitacora
Bitacora=SubMovimientos
SubMovimientos=MAFIndicador
MAFIndicador=Comentarios
Comentarios=MovGrupo
MovGrupo=MAF
MAF=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=MovPersonal
MovPersonal=Propiedades
Propiedades=Imprimir
Imprimir=RepPantalla
RepPantalla=PlantillasOffice
PlantillasOffice=FormasAnexas
FormasAnexas=Excel
Excel=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Prioridad
Prioridad=Afectar
Afectar=Autorizar
Autorizar=Eliminar
Eliminar=Cancelar
Cancelar=Devolver
Devolver=Transferir
Transferir=Anexos
Anexos=Evaluaciones
Evaluaciones=AgregarEvento
AgregarEvento=GastosAnexos
GastosAnexos=ModificarAgenda
ModificarAgenda=Fuente
Fuente=AlinearIzquierda
AlinearIzquierda=Centrar
Centrar=AlinearDerecha
AlinearDerecha=ConViñetas
ConViñetas=SinViñetas
SinViñetas=Anterior
Anterior=Siguiente
Siguiente=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=Bitacora
Bitacora=ColaUsuario
ColaUsuario=ExplorarMovimiento
ExplorarMovimiento=VerModulo
VerModulo=MovPos
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
&Edición=Forma&to
Forma&to=&Ver
&Ver=&Otros
&Otros=(Fin)
