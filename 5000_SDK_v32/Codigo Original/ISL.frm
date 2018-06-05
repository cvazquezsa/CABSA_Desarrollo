[Forma]
Clave=ISL
Nombre=<T>Licencias<T>
Icono=0
Modulos=ISL
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=306
PosicionInicialArriba=85
PosicionInicialAltura=558
PosicionInicialAncho=754
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
PosicionSeccion1=33
PosicionSeccion2=92
BarraAyuda=S
MovModulo=ISL
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=520
Totalizadores=S
PosicionSec1=176
PosicionSec2=419

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.Aplica, Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Proveedor, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ISL
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=100
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
FichaEspacioNombresAuto=S
Pestana=S

[Ficha.ISL.Mov]
Carpeta=Ficha
Clave=ISL.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.ISL.MovID]
Carpeta=Ficha
Clave=ISL.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.ISL.FechaEmision]
Carpeta=Ficha
Clave=ISL.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.ISL.Proyecto]
Carpeta=Ficha
Clave=ISL.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
Pegado=N
EditarConBloqueo=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=ISLA
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
ListaOrden=ISL.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=ISL.FechaEmision
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
FiltroUsuarioDefault=(Usuario)
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasNormal=S
FiltroFechasCancelacion=ISL.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S

IconosNombre=ISLA:ISL.Mov+<T> <T>+ISLA:ISL.MovID
[(Carpeta Abrir).Columnas]
0=136
1=88

2=-2
3=-2
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(ISL:ISL.ID) y (ISL:ISL.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, ISL:ISL.ID, <T>ISL<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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
ConCondicion=S
EspacioPrevio=S
GuardarAntes=S
Antes=S
DespuesGuardar=S

Expresion=Si<BR> (ISL:ISL.Estatus en (EstatusPendiente))<BR>Entonces<BR>  Asigna(Info.Modulo, <T>ISL<T>)<BR>  Asigna(Info.Mov, ISL:ISL.Mov)<BR>  Asigna(Info.MovID, ISL:ISL.MovID)<BR>  Si(Forma(<T>GenerarMovFlujo<T>), Generar(<T>ISL<T>, ISL:ISL.ID, ISL:ISL.Mov, ISL:ISL.MovID, <T>Todo<T>, Info.MovGenerar, <T>ISL<T>))<BR>Sino<BR>  Si<BR>    ISL:ISL.Estatus=EstatusSinAfectar<BR>  Entonces<BR>    Afectar(<T>ISL<T>, ISL:ISL.ID, ISL:ISL.Mov, ISL:ISL.MovID, <T>Todo<T>, <T><T>, <T>ISL<T>)<BR>    PlugIn(<T>ET<T>, ISL:ISL.ID)<BR>  Sino<BR>    Asigna(Afectar.Modulo, <T>ISL<T>)<BR>    Asigna(Afectar.Mov, ISL:ISL.Mov)<BR>    Asigna(Afectar.MovID, ISL:Soporte.MovID) <BR>    Asigna(Afectar.ID, ISL:ISL.ID)<BR>    Asigna(Info.TituloDialogo, ISL:ISL.Mov+<T> <T>+ISL:ISL.MovID)<BR>    Asigna(Info.Estado, ISL:ISL.Estado)<BR>    Dialogo(<T>AfectarISL<T>)<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, ISL:ISL.Usuario) y<BR>(ISL:ISL.Estatus en (EstatusSinAfectar, EstatusPendiente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>ISL<T>, ISL:ISL.Mov, ISL:ISL.Estatus, FormaSituacion, Usuario) y<BR>(ISL:ISL.Estatus=EstatusSinAfectar)
EjecucionCondicion=ConDatos(ISL:ISL.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (ISL:ISL.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>ISL<T>, ISL:ISL.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>ISL<T>, ISL:ISL.Mov, ISL:ISL.ID, Verdadero, ISL:ISL.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(ISL:ISL.MovID) y (ISL:ISL.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, ISL:ISL.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM ISL WHERE ID=:nID<T>, ISL:ISL.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

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
ListaParametros1=ISL:ISL.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>ISL<T>, ISL:ISL.Mov, ISL:ISL.Estatus), ISL:ISL.ID)
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
ListaParametros1=ISL:ISL.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>ISL<T>, ISL:ISL.Mov, ISL:ISL.Estatus), ISL:ISL.ID)
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
Expresion=Cancelar(<T>ISL<T>, ISL:ISL.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>ISL<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, ISL:ISL.Usuario) y ConDatos(ISL:ISL.ID) y ConDatos(ISL:ISL.MovID) y<BR>((ISL:ISL.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPendiente)) o<BR>(ISL:ISL.Estatus=EstatusConcluido))
AntesExpresiones=Asigna( Afectar.Mov, ISL:ISL.Mov ) <BR> Asigna( Afectar.MovID, ISL:ISL.MovID )

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
Expresion=Verificar(<T>ISL<T>, ISL:ISL.ID,ISL:ISL.Mov,ISL:ISL.MovID)
ActivoCondicion=ISL:ISL.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(ISL:ISL.Mov)
[Aplica.ISL.MovAplica]
Carpeta=Aplica
Clave=ISL.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.ISL.MovAplicaID]
Carpeta=Aplica
Clave=ISL.MovAplicaID
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
ActivoCondicion=ConDatos(ISL:ISL.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.ID, ISL:ISL.ID)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.MovID, ISL:ISL.MovID)
[Aplica.ISL.Agente]
Carpeta=Aplica
Clave=ISL.Agente
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
DespuesGuardar=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>ISL<T>, ISL:ISL.Mov, ISL:ISL.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>ISL<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>ISL<T>, ISL:ISL.Mov, ISL:ISL.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(ISL:ISL.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.ID, ISL:ISL.ID)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.Estatus, ISL:ISL.Estatus)<BR>Asigna(Info.Situacion, ISL:ISL.Situacion)
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
ActivoCondicion=ConfigModulo(<T>ISL<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(ISL:ISL.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.ID, ISL:ISL.ID)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.MovID, ISL:ISL.MovID)


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
AntesExpresiones=Asigna(Info.Rama, <T>ISL<T>)<BR>Asigna(Info.Fecha, ISL:ISL.FechaEmision)<BR>Asigna(Info.ID, ISL:ISL.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (ISL:ISL.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, ISL:ISL.Mov+<T> <T>+ISL:ISL.MovID)
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
EjecucionCondicion=Si(Vacio(ISL:ISL.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.ID, ISL:ISL.ID)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.MovID, ISL:ISL.MovID)<BR>Asigna(Info.PuedeEditar, ISL:ISL.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(ISL:ISL.Usuario))

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
ActivoCondicion=ISL:ISL.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(ISL:ISL.Usuario)
EjecucionCondicion=Si(Vacio(ISL:ISL.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.ID, ISL:ISL.ID)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.MovID, ISL:ISL.MovID)

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
ActivoCondicion=ConDatos(ISL:ISL.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.ID, ISL:ISL.ID)

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
Expresion=CopiarMovimiento(<T>ISL<T>, ISL:ISL.ID, <T>ISL<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (ISL:ISL.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(ISL:ISL.ID),GuardarCambios)
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
Aplica=97
AplicaID=64
FechaEmision=128
Reporte=136
Tipo=96
Asunto=232
Socio=83
Titulo=86
Cantidad=50
Precio=101
Costo=103
PrecioTotal=104
CostoTotal=93

Articulo=124
Licencia=81
Vencimiento=87
Mantenimiento=77
Licenciamiento=118
Nombre_1=183
Cliente=58
Nombre=207
VencimientoA=103
MantenimientoA=116
CantidadA=89
[Ficha.ISL.UEN]
Carpeta=Ficha
Clave=ISL.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
EditarConBloqueo=S

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
NombreDesplegar=&Tareas
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
AntesExpresiones=Asigna(Info.PuedeEditar, ISL:ISL.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.MovID, ISL:ISL.MovID)<BR>Asigna(Info.Cliente, ISL:ISL.Cliente)<BR>Asigna(Info.Proveedor, ISL:ISL.Proveedor)<BR>Asigna(Info.Agente, ISL:ISL.Agente)<BR>Asigna(Info.Personal, ISL:ISL.Personal)<BR>Asigna(Info.Proyecto, ISL:ISL.Proyecto)<BR>Asigna(Info.UEN, ISL:ISL.UEN)<BR>Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.ID, ISL:ISL.ID)<BR>Asigna(Info.Reporte, Nulo)

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.Clave, <T>ISL<T>+ISL:ISL.ID)<BR>Asigna(Info.Nombre, ISL:ISL.Mov+<T> <T>+ISL:ISL.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(ISL:ISL.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.ID, ISL:ISL.ID)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.MovID, ISL:ISL.MovID)<BR>Asigna(Info.Fecha, ISL:ISL.FechaEmision)<BR>Asigna(Info.Estatus, ISL:ISL.Estatus)

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
EjecucionCondicion=ConDatos(ISL:ISL.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>ISL<T>)<BR>Asigna(Info.Clave, ISL:ISL.Mov)

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
EjecucionCondicion=ConDatos(ISL:ISL.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.Concepto, ISL:ISL.Concepto)

[(Carpeta Abrir).ISL.Concepto]
Carpeta=(Carpeta Abrir)
Clave=ISL.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ISLD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ISL
LlaveLocal=ISLD.ID
LlaveMaestra=ISL.ID
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
CarpetaVisible=S
ControlRenglon=S
CampoRenglon=ISLD.Renglon
HojaFondoGrisAuto=S

HojaAjustarColumnas=S
[Ficha.ISL.Concepto]
Carpeta=Ficha
Clave=ISL.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.ISL.Referencia]
Carpeta=Ficha
Clave=ISL.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.ISL.Observaciones]
Carpeta=Ficha
Clave=ISL.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=88
ColorFondo=Blanco



[Detalle.ISLD.Cantidad]
Carpeta=Detalle
Clave=ISLD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Conteo
Totalizadores2=Conteo
Totalizadores3=
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Conteo
CarpetaVisible=S



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
Expresion=Asigna(Info.Forma, <T>ISL<T>)<BR>Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.Nombre, ISL:ISL.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>ISL<T>, ISL:ISL.Mov, ISL:ISL.ID, Falso, ISL:ISL.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>ISL<T>+ISL:ISL.ID)<BR>  Asigna(Info.Nombre, ISL:ISL.Mov+<T> <T>+ISL:ISL.MovID)<BR>  Asigna(Info.Modulo, <T>ISL<T>)<BR>  Asigna(Info.Mov, ISL:ISL.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      ISL:ISL.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>ISL<T>)<BR>Asigna(Info.ID, ISL:ISL.ID)<BR>Asigna(Info.Mov, ISL:ISL.Mov)<BR>Asigna(Info.MovID, ISL:ISL.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (ISL:ISL.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>ISL<T>, <T>{ISL:ISL.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>ISL{ISL:ISL.ID}<T>

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
VerCampo=350
VerValor=350







[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Precio Total
Precio Total=Costo Total
Costo Total=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)




[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=ISL.Concepto
ISL.Concepto=ISL.Referencia
ISL.Referencia=ISL.Observaciones
ISL.Observaciones=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)

[(Carpeta Abrir).ISL.Referencia]
Carpeta=(Carpeta Abrir)
Clave=ISL.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).ISL.Observaciones]
Carpeta=(Carpeta Abrir)
Clave=ISL.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
3D=S
Tamano=5
ColorFondo=Plata















































[Detalle.ISLD.Licencia]
Carpeta=Detalle
Clave=ISLD.Licencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Detalle.ISLD.Vencimiento]
Carpeta=Detalle
Clave=ISLD.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.ISLD.Mantenimiento]
Carpeta=Detalle
Clave=ISLD.Mantenimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.ISLD.Licenciamiento]
Carpeta=Detalle
Clave=ISLD.Licenciamiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco













[Lista.Columnas]
0=82
1=139
2=71
3=155
4=89
5=-2
6=47
7=140









































[Detalle.ListaCamposAValidar]
(Inicio)=IntelisisSL.Nombre
IntelisisSL.Nombre=IntelisisSL.Cliente
IntelisisSL.Cliente=(Fin)








[Detalle.IntelisisSL.Cliente]
Carpeta=Detalle
Clave=IntelisisSL.Cliente
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris






[Detalle.IntelisisSL.Nombre]
Carpeta=Detalle
Clave=IntelisisSL.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

ColorFuente=Gris







[Detalle.ListaEnCaptura]
(Inicio)=ISLD.Licencia
ISLD.Licencia=IntelisisSL.Cliente
IntelisisSL.Cliente=IntelisisSL.Nombre
IntelisisSL.Nombre=ISLD.Vencimiento
ISLD.Vencimiento=ISLD.VencimientoA
ISLD.VencimientoA=ISLD.Mantenimiento
ISLD.Mantenimiento=ISLD.MantenimientoA
ISLD.MantenimientoA=ISLD.Licenciamiento
ISLD.Licenciamiento=ISLD.Cantidad
ISLD.Cantidad=ISLD.CantidadA
ISLD.CantidadA=(Fin)

[Detalle.ISLD.VencimientoA]
Carpeta=Detalle
Clave=ISLD.VencimientoA
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.ISLD.MantenimientoA]
Carpeta=Detalle
Clave=ISLD.MantenimientoA
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.ISLD.CantidadA]
Carpeta=Detalle
Clave=ISLD.CantidadA
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



















[Acciones.VerXML]
Nombre=VerXML
Boton=57
Menu=&Ver
NombreDesplegar=&Ver Ultima Licencia Generada
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=IntelisisSLXML
Activo=S
ConCondicion=S
Antes=S
Visible=S




UsaTeclaRapida=S
TeclaRapida=Ctrl+D









EspacioPrevio=S
EjecucionCondicion=ConDatos(ISLD:ISLD.Licencia)
AntesExpresiones=Asigna(Info.Clave, ISLD:ISLD.Licencia)<BR>Asigna(Info.Nombre, ISLD:IntelisisSL.Nombre)



























[Ficha.ListaEnCaptura]
(Inicio)=ISL.Mov
ISL.Mov=ISL.MovID
ISL.MovID=ISL.Proyecto
ISL.Proyecto=ISL.UEN
ISL.UEN=ISL.FechaEmision
ISL.FechaEmision=ISL.Concepto
ISL.Concepto=ISL.Referencia
ISL.Referencia=ISL.Vencimiento
ISL.Vencimiento=ISL.Mantenimiento
ISL.Mantenimiento=ISL.Observaciones
ISL.Observaciones=(Fin)

[Ficha.ISL.Vencimiento]
Carpeta=Ficha
Clave=ISL.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.ISL.Mantenimiento]
Carpeta=Ficha
Clave=ISL.Mantenimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




















































[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S



















[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalle
Detalle=FormaExtraValor
FormaExtraValor=(Fin)

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
Cancelar=CamposExtras
CamposExtras=Tareas
Tareas=Anexos
Anexos=AgregarEvento
AgregarEvento=Anterior
Anterior=Siguiente
Siguiente=Tiempo
Tiempo=VerXML
VerXML=Politica
Politica=PoliticaConcepto
PoliticaConcepto=Bitacora
Bitacora=MovPos
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
