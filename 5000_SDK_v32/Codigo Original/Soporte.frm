[Forma]
Clave=Soporte
Nombre=Info.STNombre
Icono=0
Modulos=Soporte
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=323
PosicionInicialArriba=60
PosicionInicialAltura=558
PosicionInicialAncho=723
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
AccionesTamanoBoton=15x5
DialogoAbrir=S
ListaAcciones=(Lista)
PosicionSeccion1=80
PosicionSeccion2=92
BarraAyuda=S
MovModulo=ST
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=578
AccionesIzq=S
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
Vista=Soporte
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
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Pestana=S
FichaEspacioNombresAuto=S
PermiteEditar=S
GuardarAlSalir=S

[Ficha.Soporte.Mov]
Carpeta=Ficha
Clave=Soporte.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Soporte.MovID]
Carpeta=Ficha
Clave=Soporte.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Soporte.FechaEmision]
Carpeta=Ficha
Clave=Soporte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Soporte.Concepto]
Carpeta=Ficha
Clave=Soporte.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
EditarConBloqueo=S

[Ficha.Soporte.Proyecto]
Carpeta=Ficha
Clave=Soporte.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
EditarConBloqueo=S

[Ficha.Soporte.Referencia]
Carpeta=Ficha
Clave=Soporte.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Soporte.Observaciones]
Carpeta=Ficha
Clave=Soporte.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Soporte.Agente]
Carpeta=Ficha
Clave=Soporte.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=SoporteA
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
ListaOrden=Soporte.ID<TAB>(Decendente)
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
FiltroFechasCampo=Soporte.FechaEmision
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
FiltroUsuarioDefault=(Usuario)
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasNormal=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=Soporte.Clase
FiltroGrupo2=Soporte.Subclase
FiltroAncho=15
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroAutoCampo=Soporte.Clase
FiltroAplicaEn=Soporte.Clase
FiltroEstilo=Directorio
FiltroFechasCancelacion=Soporte.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S

IconosNombre=SoporteA:Soporte.Mov+<T> <T>+SoporteA:Soporte.MovID
FiltroGeneral={Si(SQL(<T>SELECT ISNULL(Filtrar, 0) FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSub<T>, <T>ST<T>, Info.SubModuloST), <T>Soporte.SubModulo=<T>+Comillas(Info.SubModuloST), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Mov), <T> AND Soporte.Mov=<T>+Comillas(Filtro.Mov), <T><T>)}<BR>{Si(ConDatos(Filtro.Cliente), <T> AND Soporte.Cliente=<T>+Comillas(Filtro.Cliente), <T><T>)}
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=136
1=98

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Soporte:Soporte.ID) y (Soporte:Soporte.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Soporte:Soporte.ID, <T>ST<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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

Expresion=Si<BR> MovTipoEn(<T>ST<T>, Soporte:Soporte.Mov, (ST.P, ST.I, ST.A)) y (Soporte:Soporte.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja))<BR>Entonces<BR>  Asigna(Info.Modulo, <T>ST<T>)<BR>  Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>  Asigna(Info.MovID, Soporte:Soporte.MovID)<BR>  Si(Forma(<T>GenerarMovFlujo<T>), Generar(<T>ST<T>, Soporte:Soporte.ID, Soporte:Soporte.Mov, Soporte:Soporte.MovID, <T>Todo<T>, Info.MovGenerar, <T>Soporte<T>))<BR>Sino<BR>  Si<BR>    Soporte:Soporte.Estatus=EstatusSinAfectar<BR>  Entonces<BR>    Afectar(<T>ST<T>, Soporte:Soporte.ID, Soporte:Soporte.Mov, Soporte:Soporte.MovID, <T>Todo<T>, <T><T>, <T>Soporte<T>)<BR>  Sino<BR>    Asigna(Afectar.Modulo, <T>ST<T>)<BR>    Asigna(Afectar.Mov, Soporte:Soporte.Mov)<BR>    Asigna(Afectar.MovID, Soporte:Soporte.MovID) <BR>    Asigna(Afectar.ID, Soporte:Soporte.ID)<BR>    Asigna(Info.TituloDialogo, Soporte:Soporte.Mov+<T> <T>+Soporte:Soporte.MovID)<BR>    Asigna(Info.Estado, Soporte:Soporte.Estado)<BR>    Dialogo(<T>AfectarSoporte<T>)<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Soporte:Soporte.Usuario) y<BR>(Soporte:Soporte.Estatus en (EstatusSinAfectar, EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>ST<T>, Soporte:Soporte.Mov, Soporte:Soporte.Estatus, FormaSituacion, Usuario) y<BR>((Soporte:Soporte.Usuario=Soporte:Soporte.UsuarioResponsable) o (Soporte:Soporte.Estatus=EstatusSinAfectar))
EjecucionCondicion=ConDatos(Soporte:Soporte.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Soporte:Soporte.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>ST<T>, Soporte:Soporte.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>ST<T>, Soporte:Soporte.Mov, Soporte:Soporte.ID, Verdadero, Soporte:Soporte.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Soporte:Soporte.MovID) y (Soporte:Soporte.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Soporte:Soporte.Usuario)

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
ListaParametros1=Soporte:Soporte.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>ST<T>, Soporte:Soporte.Mov, Soporte:Soporte.Estatus), Soporte:Soporte.ID)
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
ListaParametros1=Soporte:Soporte.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>ST<T>, Soporte:Soporte.Mov, Soporte:Soporte.Estatus), Soporte:Soporte.ID)
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
Expresion=Cancelar(<T>ST<T>, Soporte:Soporte.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>ST<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Soporte:Soporte.Usuario) y ConDatos(Soporte:Soporte.ID) y ConDatos(Soporte:Soporte.MovID) y<BR>((Soporte:Soporte.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja)) o<BR>((MovTipo(<T>ST<T>, Soporte:Soporte.Mov) en (ST.S, ST.F)) y (Soporte:Soporte.Estatus=EstatusConcluido)))
AntesExpresiones=Asigna( Afectar.Mov, Soporte:Soporte.Mov ) <BR> Asigna( Afectar.MovID, Soporte:Soporte.MovID )

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
Expresion=Verificar(<T>ST<T>, Soporte:Soporte.ID,Soporte:Soporte.Mov,Soporte:Soporte.MovID)
ActivoCondicion=Soporte:Soporte.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Soporte:Soporte.Mov)

[Aplica.Soporte.MovAplica]
Carpeta=Aplica
Clave=Soporte.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Soporte.MovAplicaID]
Carpeta=Aplica
Clave=Soporte.MovAplicaID
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
ActivoCondicion=ConDatos(Soporte:Soporte.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)
[Aplica.Soporte.Agente]
Carpeta=Aplica
Clave=Soporte.Agente
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>ST<T>, Soporte:Soporte.Mov, Soporte:Soporte.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>ST<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>ST<T>, Soporte:Soporte.Mov, Soporte:Soporte.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Soporte:Soporte.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.Estatus, Soporte:Soporte.Estatus)<BR>Asigna(Info.Situacion, Soporte:Soporte.Situacion)
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
ActivoCondicion=ConfigModulo(<T>ST<T>,<T>Tiempos<T>)=<T>Si<T>
ConCondicion=S
EjecucionCondicion=ConDatos(Soporte:Soporte.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)
Visible=S

[(Carpeta Abrir).Soporte.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Soporte.FechaEmision
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
ActivoCondicion=ConDatos(SoporteA:Soporte.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, SoporteA:Soporte.ID)
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

[Detalle.SoporteUnico.Referencia]
Carpeta=Detalle
Clave=SoporteUnico.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
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
AntesExpresiones=Asigna(Info.Rama, <T>ST<T>)<BR>Asigna(Info.Fecha, Soporte:Soporte.FechaEmision)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Soporte:Soporte.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Soporte:Soporte.Mov+<T> <T>+Soporte:Soporte.MovID)
RefrescarDespues=S

[(Carpeta Abrir).Soporte.Cliente]
Carpeta=(Carpeta Abrir)
Clave=Soporte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Soporte.Vencimiento]
Carpeta=(Carpeta Abrir)
Clave=Soporte.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=100

[Ficha.Soporte.Cliente]
Carpeta=Ficha
Clave=Soporte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=46
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Soporte.EnviarA]
Carpeta=Ficha
Clave=Soporte.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteEnviarA.Nombre]
Carpeta=Ficha
Clave=CteEnviarA.Nombre
Editar=S
3D=S
Tamano=46
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Soporte.Contacto]
Carpeta=Ficha
Clave=Soporte.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S
EspacioPrevio=S

[Ficha.Soporte.Telefono]
Carpeta=Ficha
Clave=Soporte.Telefono
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Soporte.Extencion]
Carpeta=Ficha
Clave=Soporte.Extencion
Editar=S
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S
EditarConBloqueo=S
ValidaNombre=N

[Ficha.Soporte.Fax]
Carpeta=Ficha
Clave=Soporte.Fax
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S
EditarConBloqueo=S
LineaNueva=N

[Ficha.Soporte.eMail]
Carpeta=Ficha
Clave=Soporte.eMail
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S
EditarConBloqueo=S
LineaNueva=S

[Ficha.Soporte.UsuarioResponsable]
Carpeta=Ficha
Clave=Soporte.UsuarioResponsable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFuente=Negro
EspacioPrevio=S
ColorFondo=Blanco

[Solucion.Soporte.Solucion]
Carpeta=Solucion
Clave=Soporte.Solucion
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ValidaNombre=S
Tamano=96x25
EditarConBloqueo=S

ConScroll=S
[Comentarios.Soporte.Comentarios]
Carpeta=Comentarios
Clave=Soporte.Comentarios
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
Tamano=96x28
ValidaNombre=S
EditarConBloqueo=S

ConScroll=S
[Ficha.Soporte.FechaConclusion]
Carpeta=Ficha
Clave=Soporte.FechaConclusion
Editar=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=25
LineaNueva=N

[Ficha.Soporte.TieneContrato]
Carpeta=Ficha
Clave=Soporte.TieneContrato
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

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
Vista=Soporte
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

CondicionVisible=MovTipo(<T>ST<T>, Soporte:Soporte.Mov) <> ST.MIN
[Comentarios.Soporte.Titulo]
Carpeta=Comentarios
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco
Efectos=[Negritas]
EditarConBloqueo=S

[Comentarios.Soporte.Prioridad]
Carpeta=Comentarios
Clave=Soporte.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
Efectos=[Negritas]
EditarConBloqueo=N

[Ficha.UsuarioCopia.Nombre]
Carpeta=Ficha
Clave=UsuarioCopia.Nombre
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Ficha.Soporte.Usuario]
Carpeta=Ficha
Clave=Soporte.Usuario
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=N
Pegado=S

[(Carpeta Abrir).Soporte.Titulo]
Carpeta=(Carpeta Abrir)
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Devolver]
Nombre=Devolver
Boton=79
NombreDesplegar=<T>&Devolver<T>
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
Menu=&Archivo
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
EspacioPrevio=S
RefrescarDespues=S
GuardarAntes=S
NombreEnBoton=S
Expresion=ProcesarSQL(<T>spAfectarTraficoSoporte :nSucursal, :nID, :tAccion<T>, Sucursal, Soporte:Soporte.ID, <T>DEVOLVER<T>)
ActivoCondicion=Soporte:Soporte.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y<BR>PuedeModificar(Soporte:Soporte.Usuario) y Soporte:Soporte.PuedeDevolver

[Acciones.Transferir]
Nombre=Transferir
Boton=81
NombreDesplegar=<T>Trans&ferir<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
ClaveAccion=SoporteTransferir
RefrescarDespues=S
Antes=S
GuardarAntes=S
NombreEnBoton=S
ActivoCondicion=Soporte:Soporte.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y<BR>PuedeModificar(Soporte:Soporte.Usuario)
AntesExpresiones=Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)

[Acciones.Prioridad]
Nombre=Prioridad
Boton=22
Menu=&Archivo
NombreDesplegar=Cambiar Prioridad...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=AfectarSoportePrioridad
Visible=S
Antes=S
RefrescarDespues=S
GuardarAntes=S
ActivoCondicion=Soporte:Soporte.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y PuedeModificar(Soporte:Soporte.Usuario)
AntesExpresiones=Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Prioridad, Soporte:Soporte.Prioridad)

[Ficha.Soporte.Clase]
Carpeta=Ficha
Clave=Soporte.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Soporte.Subclase]
Carpeta=Ficha
Clave=Soporte.Subclase
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Acciones.AgenteInfo]
Nombre=AgenteInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del &Agente
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteInfo
ConCondicion=S
Visible=S
Antes=S
Activo=S
EjecucionCondicion=ConDatos(Soporte:Soporte.Agente)
AntesExpresiones=Asigna(Info.Agente, Soporte:Soporte.Agente)

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
Menu=&Ver
NombreDesplegar=&Información del Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteInfo
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
ActivoCondicion=Usuario.CteInfo
EjecucionCondicion=ConDatos(Soporte:Soporte.Cliente)
AntesExpresiones=Asigna(Info.Cliente, Soporte:Soporte.Cliente)

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
EjecucionCondicion=Si(Vacio(Soporte:Soporte.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)<BR>Asigna(Info.PuedeEditar, Soporte:Soporte.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Soporte:Soporte.Usuario))

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
ActivoCondicion=Soporte:Soporte.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Soporte:Soporte.Usuario)
EjecucionCondicion=Si(Vacio(Soporte:Soporte.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)

[Ficha.UsuarioRelacion.Nombre]
Carpeta=Ficha
Clave=UsuarioRelacion.Nombre
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Acciones.Responsable]
Nombre=Responsable
Boton=0
Menu=&Edición
NombreDesplegar=&Responsable Final
EnMenu=S
TipoAccion=Formas
ClaveAccion=SoporteResponsable
Antes=S
Visible=S
GuardarAntes=S
RefrescarDespues=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
ActivoCondicion=Soporte:Soporte.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y<BR>PuedeModificar(Soporte:Soporte.Usuario)
AntesExpresiones=Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)

[Acciones.ColaUsuario]
Nombre=ColaUsuario
Boton=80
Menu=&Ver
NombreDesplegar=Cola de &Usuarios
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovUsuario
Antes=S
Visible=S
ActivoCondicion=(Soporte:Soporte.Estatus<>EstatusSinAfectar) y Soporte:Soporte.PuedeDevolver
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)

[Acciones.CteExpress]
Nombre=CteExpress
Boton=60
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F8
NombreDesplegar=Agregar &Cliente
EnMenu=S
TipoAccion=Expresion
Visible=S
EnBarraHerramientas=S
Expresion=Asigna(Info.Tipo, <T>Cliente<T>)<BR>Forma(<T>CteExpress<T>)<BR>Asigna(Soporte:Soporte.Cliente, Info.Cliente)
ActivoCondicion=Usuario.AgregarCteExpress y (Soporte:Soporte.Estatus=EstatusSinAfectar)

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
ActivoCondicion=ConDatos(Soporte:Soporte.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)

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
Expresion=CopiarMovimiento(<T>ST<T>, Soporte:Soporte.ID, <T>Soporte<T>)
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

[Acciones.EnviarCorreo]
Nombre=EnviarCorreo
Boton=84
Menu=&Archivo
NombreDesplegar=&Enviar Mensaje...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S

Expresion=EnviarMensajePara(Soporte:Soporte.eMail, Soporte:Soporte.Contacto, Soporte:Soporte.Titulo, Soporte:Soporte.Problema, <T>-----<T>+e(<T>Problema<T>)+<T>-----<T>, Soporte:Soporte.Solucion, <T>-----<T>+e(<T>Solución<T>)+<T>-----<T>, Soporte:Soporte.Comentarios, <T>-----<T>+e(<T>Comentarios<T>)+<T>-----<T>)
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

[(Carpeta Abrir).Soporte.Estado]
Carpeta=(Carpeta Abrir)
Clave=Soporte.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Soporte:Soporte.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Soporte:Soporte.ID),GuardarCambios)
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
Aplica=124
AplicaID=75
FechaEmision=128

[Aplicacion]
Estilo=Hoja
PestanaNombre=Aplicación
Clave=Aplicacion
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SoporteD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Soporte
LlaveLocal=SoporteD.ID
LlaveMaestra=Soporte.ID
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
CampoRenglon=SoporteD.Renglon
Pestana=S
PestanaOtroNombre=S
CondicionVisible=MovTipoEn(<T>ST<T>, Soporte:Soporte.Mov, (ST.P, ST.S, ST.A, ST.F))

[Aplicacion.SoporteD.Aplica]
Carpeta=Aplicacion
Clave=SoporteD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Aplicacion.SoporteD.AplicaID]
Carpeta=Aplicacion
Clave=SoporteD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Aplicacion.Soporte.FechaEmision]
Carpeta=Aplicacion
Clave=Soporte.FechaEmision
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Aplicacion.Columnas]
Aplica=131
AplicaID=71
FechaEmision=94
Cliente=75
Titulo=247
Prioridad=45

[Aplicacion.Soporte.Cliente]
Carpeta=Aplicacion
Clave=Soporte.Cliente
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Aplicacion.Soporte.Titulo]
Carpeta=Aplicacion
Clave=Soporte.Titulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Aplicacion.Soporte.Prioridad]
Carpeta=Aplicacion
Clave=Soporte.Prioridad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Problema]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Problema
Clave=Problema
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Soporte
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

CondicionVisible=MovTipoEn(<T>ST<T>, Soporte:Soporte.Mov, (ST.R, ST.P, ST.S, ST.I, ST.A, ST.F))
[Problema.Soporte.Titulo]
Carpeta=Problema
Clave=Soporte.Titulo
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco
Efectos=[Negritas]

[Problema.Soporte.Cliente]
Carpeta=Problema
Clave=Soporte.Cliente
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco

[Problema.Soporte.Prioridad]
Carpeta=Problema
Clave=Soporte.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
Efectos=[Negritas]

[Problema.Soporte.Problema]
Carpeta=Problema
Clave=Soporte.Problema
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=96x18
ColorFondo=Blanco

[Problema.Soporte.Vencimiento]
Carpeta=Problema
Clave=Soporte.Vencimiento
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
Efectos=[Negritas]

[Problema.Soporte.Estado]
Carpeta=Problema
Clave=Soporte.Estado
Editar=S
EditarConBloqueo=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
Efectos=[Negritas]

[Problema.Soporte.FechaInicio]
Carpeta=Problema
Clave=Soporte.FechaInicio
Editar=S
EditarConBloqueo=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Problema.Soporte.CondicionEntrega]
Carpeta=Problema
Clave=Soporte.CondicionEntrega
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
EspacioPrevio=S

[Problema.Soporte.Importe]
Carpeta=Problema
Clave=Soporte.Importe
Editar=S
EditarConBloqueo=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Problema.Soporte.CondicionPago]
Carpeta=Problema
Clave=Soporte.CondicionPago
Editar=S
EditarConBloqueo=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Problema.Soporte.Version]
Carpeta=Problema
Clave=Soporte.Version
Editar=S
EditarConBloqueo=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Comentarios.Soporte.Cliente]
Carpeta=Comentarios
Clave=Soporte.Cliente
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco

[Solucion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Solución
Clave=Solucion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Soporte
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

CondicionVisible=MovTipoEn(<T>ST<T>, Soporte:Soporte.Mov, (ST.R, ST.P, ST.S, ST.I, ST.A, ST.F))
[Solucion.Soporte.Titulo]
Carpeta=Solucion
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco
EditarConBloqueo=S
Efectos=[Negritas]

[Solucion.Soporte.Cliente]
Carpeta=Solucion
Clave=Soporte.Cliente
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco

[Solucion.Soporte.Prioridad]
Carpeta=Solucion
Clave=Soporte.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
Efectos=[Negritas]

[Acciones.Mensaje]
Nombre=Mensaje
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+M
NombreDesplegar=&Mensaje
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=VerComentario(e(<T>Mensaje<T>), <BR>Si(ConDatos(Soporte:Soporte.Cliente), Soporte:Cte.Nombre+NuevaLinea)+<BR>Si(ConDatos(Soporte:Soporte.Proveedor), Soporte:Prov.Nombre+NuevaLinea)+<BR>Si(ConDatos(Soporte:Soporte.Personal), Soporte:NombreCompleto+NuevaLinea)+<BR>Soporte:Soporte.Contacto+NuevaLinea+<BR>Soporte:Soporte.eMail+NuevaLinea+<BR>NuevaLinea+<BR>e(<T>Asunto<T>)+<T>: <T>+Soporte:Soporte.Titulo+NuevaLinea+<BR>e(<T>Referencia<T>)+<T>: <T>+Soporte:Soporte.Mov+<T> <T>+Soporte:Soporte.MovID+NuevaLinea+<BR>e(<T>Fecha<T>)+<T>: <T>+ FechaEnTexto(Soporte:Soporte.FechaEmision, <T>dd/mmm/aaaa<T>)+NuevaLinea+<BR>NuevaLinea+<BR>NuevaLinea+<BR>Si(Recorta(Soporte:Soporte.Problema)<><T><T>, <T>-----<T>+e(<T>Problema<T>)+<T>-----<T> + NuevaLinea + Soporte:Soporte.Problema + NuevaLinea+NuevaLinea)+<BR>Si(Recorta(Soporte:Soporte.Solucion)<><T><T>, <T>-----<T>+e(<T>Solución<T>)+<T>-----<T> + NuevaLinea + Soporte:Soporte.Solucion + NuevaLinea+NuevaLinea)+<BR>Si(Recorta(Soporte:Soporte.Comentarios)<><T><T>, <T>-----<T>+e(<T>Comentarios<T>)+<T>-----<T> + NuevaLinea + Soporte:Soporte.Comentarios)<BR>)

[(Carpeta Abrir).Atraso]
Carpeta=(Carpeta Abrir)
Clave=Atraso
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Soporte.Proveedor]
Carpeta=Ficha
Clave=Soporte.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=46
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Soporte.Personal]
Carpeta=Ficha
Clave=Soporte.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NombreCompleto]
Carpeta=Ficha
Clave=NombreCompleto
Editar=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del Proveedor
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Visible=S
ConCondicion=S
Antes=S
Activo=S
EjecucionCondicion=ConDatos(Soporte:Soporte.Proveedor)
AntesExpresiones=Asigna(Info.Proveedor, Soporte:Soporte.Proveedor)

[Acciones.CtoInfo]
Nombre=CtoInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información del Contacto
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Si<BR>  ConDatos(Soporte:Soporte.Cliente)<BR>Entonces<BR>  Asigna(Info.Cliente, Soporte:Soporte.Cliente) <BR>  Forma(<T>CteInfo<T>)<BR>Sino<BR>  Si<BR>    ConDatos(Soporte:Soporte.Proveedor)<BR>  Entonces<BR>    Asigna(Info.Proveedor, Soporte:Soporte.Proveedor) <BR>    Forma(<T>ProvInfo<T>)<BR>  Sino<BR>    Si<BR>      ConDatos(Soporte:Soporte.Personal)<BR>    Entonces<BR>      Asigna(Info.Personal, Soporte:Soporte.Personal) <BR>      Forma(<T>PersonalInfo<T>)<BR>    Sino<BR>      Si<BR>        ConDatos(Soporte:Soporte.Agente)<BR>      Entonces<BR>        Asigna(Info.Agente, Soporte:Soporte.Agente) <BR>        Forma(<T>AgenteInfo<T>)<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
Activo=S

[Acciones.PersonalInfo]
Nombre=PersonalInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del Personal
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalInfo
Visible=S
ConCondicion=S
Antes=S
Activo=S
EjecucionCondicion=ConDatos(Soporte:Soporte.Personal)
AntesExpresiones=Asigna(Info.Personal, Soporte:Soporte.Personal)

[Problema.Soporte.Tiempo]
Carpeta=Problema
Clave=Soporte.Tiempo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Problema.Soporte.TiempoUnidad]
Carpeta=Problema
Clave=Soporte.TiempoUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Soporte.ReferenciaInicial]
Carpeta=Ficha
Clave=Soporte.ReferenciaInicial
3D=N
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Abrir).Soporte.FechaConclusion]
Carpeta=(Carpeta Abrir)
Clave=Soporte.FechaConclusion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Dias]
Carpeta=(Carpeta Abrir)
Clave=Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Soporte.Espacio]
Carpeta=Ficha
Clave=Soporte.Espacio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Soporte.UEN]
Carpeta=Ficha
Clave=Soporte.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Acciones.ProyInfo]
Nombre=ProyInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del Proyecto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyInfo
ConCondicion=S
Antes=S
Visible=S
Activo=S
EjecucionCondicion=ConDatos(Soporte:Soporte.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, Soporte:Soporte.Proyecto)

[Minuta]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Minuta
Clave=Minuta
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Soporte
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
CondicionVisible=MovTipo(<T>ST<T>, Soporte:Soporte.Mov) = ST.MIN

[Minuta.Soporte.Titulo]
Carpeta=Minuta
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=77
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Minuta.Soporte.Comentarios]
Carpeta=Minuta
Clave=Soporte.Comentarios
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=88x23
ColorFondo=Blanco
ColorFuente=Negro

[Minuta.Soporte.Estado]
Carpeta=Minuta
Clave=Soporte.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N
EditarConBloqueo=S

[Minuta.Soporte.FechaInicio]
Carpeta=Minuta
Clave=Soporte.FechaInicio
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Minuta.Soporte.FechaTermino]
Carpeta=Minuta
Clave=Soporte.FechaTermino
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Minuta.Soporte.Tiempo]
Carpeta=Minuta
Clave=Soporte.Tiempo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Minuta.Soporte.TiempoUnidad]
Carpeta=Minuta
Clave=Soporte.TiempoUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Minuta.Soporte.Prioridad]
Carpeta=Minuta
Clave=Soporte.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.PuedeEditar, Soporte:Soporte.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)<BR>Asigna(Info.Cliente, Soporte:Soporte.Cliente)<BR>Asigna(Info.Proveedor, Soporte:Soporte.Proveedor)<BR>Asigna(Info.Agente, Soporte:Soporte.Agente)<BR>Asigna(Info.Personal, Soporte:Soporte.Personal)<BR>Asigna(Info.Proyecto, Soporte:Soporte.Proyecto)<BR>Asigna(Info.UEN, Soporte:Soporte.UEN)<BR>Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Reporte, Nulo)

[Ficha.Soporte.ProyectoFolio]
Carpeta=Ficha
Clave=Soporte.ProyectoFolio
3D=S
Tamano=5
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Soporte.Fuente]
Carpeta=Ficha
Clave=Soporte.Fuente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Soporte.Elemento]
Carpeta=Ficha
Clave=Soporte.Elemento
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Soporte.Medio]
Carpeta=Ficha
Clave=Soporte.Medio
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
EditarConBloqueo=S

[Ficha.NombreSucursalTrabajo]
Carpeta=Ficha
Clave=NombreSucursalTrabajo
Editar=S
3D=S
Tamano=16
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

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
Expresion=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.Clave, <T>ST<T>+Soporte:Soporte.ID)<BR>Asigna(Info.Nombre, Soporte:Soporte.Mov+<T> <T>+Soporte:Soporte.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Soporte:Soporte.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Acciones.OtrosDatos]
Nombre=OtrosDatos
Boton=57
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=&Otros Datos
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)<BR>Si(Soporte:Soporte.Estatus en (EstatusConcluido, EstatusCancelado), Forma(<T>MovFormaInfo<T>), Forma(<T>MovForma<T>))

[Vehiculo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Vehículo
Clave=Vehiculo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Soporte
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=Config.VIN

[Vehiculo.Soporte.VIN]
Carpeta=Vehiculo
Clave=Soporte.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Vehiculo.VIN.NumeroEconomico]
Carpeta=Vehiculo
Clave=VIN.NumeroEconomico
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[Vehiculo.Soporte.ServicioTipo]
Carpeta=Vehiculo
Clave=Soporte.ServicioTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Vehiculo.Soporte.FechaRequerida]
Carpeta=Vehiculo
Clave=Soporte.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Vehiculo.VIN.Placas]
Carpeta=Vehiculo
Clave=VIN.Placas
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Acciones.SoporteCambio]
Nombre=SoporteCambio
Boton=0
Menu=&Edición
NombreDesplegar=&Cambios
EnMenu=S
TipoAccion=Formas
ClaveAccion=SoporteCambio
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=F7
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)<BR>Asigna(Info.PuedeEditar, Soporte:Soporte.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Soporte:Soporte.Usuario))

[Problema.Soporte.FechaInicioEst]
Carpeta=Problema
Clave=Soporte.FechaInicioEst
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Problema.Soporte.FechaFinEst]
Carpeta=Problema
Clave=Soporte.FechaFinEst
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Problema.Soporte.FechaRevision]
Carpeta=Problema
Clave=Soporte.FechaRevision
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Problema.Soporte.FechaAprobacion]
Carpeta=Problema
Clave=Soporte.FechaAprobacion
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Direccion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Dirección
Clave=Direccion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Soporte
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
CondicionVisible=General.Espacios

[Direccion.Soporte.Direccion]
Carpeta=Direccion
Clave=Soporte.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=73
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.DireccionNumero]
Carpeta=Direccion
Clave=Soporte.DireccionNumero
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.EntreCalles]
Carpeta=Direccion
Clave=Soporte.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=83
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.Plano]
Carpeta=Direccion
Clave=Soporte.Plano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.Delegacion]
Carpeta=Direccion
Clave=Soporte.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.Colonia]
Carpeta=Direccion
Clave=Soporte.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.CodigoPostal]
Carpeta=Direccion
Clave=Soporte.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.Poblacion]
Carpeta=Direccion
Clave=Soporte.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.Pais]
Carpeta=Direccion
Clave=Soporte.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.Zona]
Carpeta=Direccion
Clave=Soporte.Zona
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Soporte.PaisEstado]
Carpeta=Direccion
Clave=Soporte.PaisEstado
Editar=S
ValidaNombre=S
3D=S
Tamano=35
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
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)<BR>Asigna(Info.Fecha, Soporte:Soporte.FechaEmision)<BR>Asigna(Info.Estatus, Soporte:Soporte.Estatus)

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
EjecucionCondicion=ConDatos(Soporte:Soporte.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>ST<T>)<BR>Asigna(Info.Clave, Soporte:Soporte.Mov)

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
EjecucionCondicion=ConDatos(Soporte:Soporte.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.Concepto, Soporte:Soporte.Concepto)

[Solucion.Soporte.Calificacion]
Carpeta=Solucion
Clave=Soporte.Calificacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=0
NombreDesplegar=Guardar &Orden
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=RegistrarListaID(<T>(Carpeta Abrir)<T>)<BR>EjecutarSQL(<T>spOrdenarModulo :nEstacion, :tModulo<T>,  EstacionTrabajo, <T>ST<T>)

[Ficha.Soporte.Reporte]
Carpeta=Ficha
Clave=Soporte.Reporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Rep.Asunto]
Carpeta=Ficha
Clave=Rep.Asunto
Editar=S
3D=S
Tamano=35
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Rep.Tipo]
Carpeta=Ficha
Clave=Rep.Tipo
Editar=S
3D=S
Pegado=S
Tamano=11
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Soporte.LineaCredito]
Carpeta=Ficha
Clave=Soporte.LineaCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Ficha.LC.Descripcion]
Carpeta=Ficha
Clave=LC.Descripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=46
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Soporte.Articulo]
Carpeta=Ficha
Clave=Soporte.Articulo
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del &Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Soporte:Soporte.Articulo)
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Soporte:Soporte.Articulo)
Visible=S

[Acciones.RepExpress]
Nombre=RepExpress
Boton=59
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F7
NombreDesplegar=Agregar &Reporte...
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Si(Forma(<T>RepExpress<T>), Asigna(Soporte:Soporte.Reporte, Info.Reporte))
ActivoCondicion=Soporte:Soporte.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>Soporte<T>)<BR>Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.Nombre, Soporte:Soporte.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

[Ficha.Soporte.SerieLote]
Carpeta=Ficha
Clave=Soporte.SerieLote
Editar=S
3D=S
Pegado=S
Tamano=15
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
RefrescarDespues=S
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>ST<T>, Soporte:Soporte.Mov, Soporte:Soporte.ID, Falso, Soporte:Soporte.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>ST<T>+Soporte:Soporte.ID)<BR>  Asigna(Info.Nombre, Soporte:Soporte.Mov+<T> <T>+Soporte:Soporte.MovID)<BR>  Asigna(Info.Modulo, <T>ST<T>)<BR>  Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Soporte:Soporte.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Acciones.FormaAnexo]
Nombre=FormaAnexo
Boton=113
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F10
NombreDesplegar=Formas Anexas
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovFormaAnexo
Antes=S
DespuesGuardar=S
Visible=S
Activo=S
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)

[Prueba.Cte.Nombre]
Carpeta=Prueba
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Prueba.Cte.NombreCorto]
Carpeta=Prueba
Clave=Cte.NombreCorto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Prueba.Cte.Numero]
Carpeta=Prueba
Clave=Cte.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=50

[Prueba.Cte.Direccion]
Carpeta=Prueba
Clave=Cte.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Prueba.Cte.EntreCalles]
Carpeta=Prueba
Clave=Cte.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Prueba.Cte.Colonia]
Carpeta=Prueba
Clave=Cte.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Prueba.Cte.CodigoPostal]
Carpeta=Prueba
Clave=Cte.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Prueba.Cte.Poblacion]
Carpeta=Prueba
Clave=Cte.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Prueba.Cte.Estado]
Carpeta=Prueba
Clave=Cte.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Prueba.Cte.Pais]
Carpeta=Prueba
Clave=Cte.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Prueba.Cte.Zona]
Carpeta=Prueba
Clave=Cte.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[FormaAnexo]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Formas Anexas
Clave=FormaAnexo
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovFormaAnexo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Forma Anexa<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
MenuLocal=S
ListaAcciones=(Lista)
ExpAntesRefrescar=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)
ListaEnCaptura=(Lista)
CarpetaVisible=S
IconosNombre=MovFormaAnexo:Nombre

[FormaAnexo.Columnas]
0=121
1=48

2=-2
[Acciones.FormaAnexoAbrir]
Nombre=FormaAnexoAbrir
Boton=0
NombreDesplegar=&Abrir
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
EsDefault=S
RefrescarIconos=S
Expresion=Asigna(Anexo.Modulo, <T>ST<T>)<BR>Asigna(Anexo.ID, Soporte:Soporte.ID)<BR>Asigna(Anexo.Mov, Soporte:Soporte.Mov)<BR>Asigna(Anexo.MovID, Soporte:Soporte.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, Anexo.Mov, Anexo.MovID)
EjecucionCondicion=ConDatos(MovFormaAnexo:Clave)

[Acciones.FormaAnexoAnexar]
Nombre=FormaAnexoAnexar
Boton=0
NombreDesplegar=Ane&xar...
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
Activo=S
Expresion=Asigna(Anexo.Modulo, <T>ST<T>)<BR>Asigna(Anexo.ID, Soporte:Soporte.ID)<BR>Asigna(Anexo.Mov, Soporte:Soporte.Mov)<BR>Asigna(Anexo.MovID, Soporte:Soporte.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo.Anexar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, BuscarArchivo(<T><T>, Anexo.Clave+<T>.xml<T>, <T>xml<T>, Anexo.Clave, <T>Formas InfoPath<T>))
EjecucionCondicion=ConDatos(MovFormaAnexo:Clave) y (MovFormaAnexo:Icono=732)

[Acciones.FormaAnexoEliminar]
Nombre=FormaAnexoEliminar
Boton=0
NombreDesplegar=E&liminar
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Activo=S
ConCondicion=S
Expresion=Asigna(Anexo.Modulo, <T>ST<T>)<BR>Asigna(Anexo.ID, Soporte:Soporte.ID)<BR>Asigna(Anexo.Mov, Soporte:Soporte.Mov)<BR>Asigna(Anexo.MovID, Soporte:Soporte.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo.Eliminar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo)
EjecucionCondicion=ConDatos(MovFormaAnexo:Clave) y (MovFormaAnexo:Icono=731)

[InfoPat.Columnas]
0=48
1=48

[MovEvento]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Eventos
Clave=MovEvento
Filtros=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovEvento
Fuente={Tahoma, 8, Negro, []}
IconosCampo=EventoTipo.Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Asunto<T>
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
CarpetaVisible=S
OtroOrden=S
ListaOrden=MovEvento.Fecha<TAB>(Acendente)
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=MovEvento:MovEvento.Asunto
FiltroGeneral=MovEvento.Modulo=<T>ST<T> AND MovEvento.ModuloID={Soporte:Soporte.ID}

[MovEvento.MovEvento.Fecha]
Carpeta=MovEvento
Clave=MovEvento.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovEvento.MovEvento.Usuario]
Carpeta=MovEvento
Clave=MovEvento.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[MovEvento.MovEvento.Estado]
Carpeta=MovEvento
Clave=MovEvento.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[MovEvento.Columnas]
0=341
1=93

2=-2
3=-2
4=-2
[Acciones.MovEventoImprimir]
Nombre=MovEventoImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=MovEvento
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.MovEventoPreliminar]
Nombre=MovEventoPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=MovEvento
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.MovEventoExcel]
Nombre=MovEventoExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=MovEvento
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.MovEventoPersonalizar]
Nombre=MovEventoPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=MovEvento
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.MovEventoAmpliar]
Nombre=MovEventoAmpliar
Boton=0
EsDefault=S
NombreDesplegar=&Ampliar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=VerComentario(MovEvento:MovEvento.Tipo+<T> - <T>+FechaEnTexto(MovEvento:MovEvento.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>), MovEvento:MovEvento.Asunto)

[MovEvento.MovEvento.Tipo]
Carpeta=MovEvento
Clave=MovEvento.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>ST<T>, <T>{Soporte:Soporte.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>ST{Soporte:Soporte.ID}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>

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
VerCampo=330
VerValor=330

[FormaAnexo.Usuario]
Carpeta=FormaAnexo
Clave=Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[FormaAnexo.UltimoCambio]
Carpeta=FormaAnexo
Clave=UltimoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Clasificación
Clave=Clasificacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Soporte
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
CarpetaVisible=S

[Clasificacion.Soporte.Causa]
Carpeta=Clasificacion
Clave=Soporte.Causa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Clasificacion.Soporte.Clase1]
Carpeta=Clasificacion
Clave=Soporte.Clase1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion.Soporte.Clase2]
Carpeta=Clasificacion
Clave=Soporte.Clase2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion.Soporte.Clase3]
Carpeta=Clasificacion
Clave=Soporte.Clase3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion.Soporte.Clase4]
Carpeta=Clasificacion
Clave=Soporte.Clase4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Clasificacion.Soporte.Clase5]
Carpeta=Clasificacion
Clave=Soporte.Clase5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actividades]
Nombre=Actividades
Boton=75
Menu=&Ver
NombreDesplegar=&Actividades
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=SoporteActividad
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.ID, Soporte:Soporte.ID)<BR>Asigna(Info.Mov, Soporte:Soporte.Mov)<BR>Asigna(Info.MovID, Soporte:Soporte.MovID)

[MovBitacora]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Bitácora
Clave=MovBitacora
Filtros=S
RefrescarAlEntrar=S
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
CarpetaVisible=S
IconosSubTitulo=<T>Tipo<T>
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=MovBitacora:MovBitacora.Tipo
FiltroGeneral=MovBitacora.Modulo=<T>ST<T> AND MovBitacora.ID={Soporte:Soporte.ID}

[MovBitacora.MovBitacora.Fecha]
Carpeta=MovBitacora
Clave=MovBitacora.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovBitacora.MovBitacora.Evento]
Carpeta=MovBitacora
Clave=MovBitacora.Evento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[MovBitacora.MovBitacora.Duracion]
Carpeta=MovBitacora
Clave=MovBitacora.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovBitacora.MovBitacora.Usuario]
Carpeta=MovBitacora
Clave=MovBitacora.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[MovBitacora.Columnas]
0=101
1=79

2=-2
3=-2
4=-2
5=-2
6=-2
[Acciones.BitacoraImprimir]
Nombre=BitacoraImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=MovBitacora
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.BitacoraPreliminar]
Nombre=BitacoraPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=MovBitacora
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.BitacoraExcel]
Nombre=BitacoraExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=MovBitacora
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.BitacoraPersonalizar]
Nombre=BitacoraPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=MovBitacora
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Solucion.Soporte.Estado]
Carpeta=Solucion
Clave=Soporte.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S

[Solucion.Soporte.Avance]
Carpeta=Solucion
Clave=Soporte.Avance
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S
LineaNueva=S

[MovBitacora.MovBitacora.DuracionUnidad]
Carpeta=MovBitacora
Clave=MovBitacora.DuracionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[MovBitacora.HorasHabiles]
Carpeta=MovBitacora
Clave=HorasHabiles
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro




[Ficha.ListaEnCaptura]
(Inicio)=Soporte.Mov
Soporte.Mov=Soporte.MovID
Soporte.MovID=Soporte.Proyecto
Soporte.Proyecto=Soporte.UEN
Soporte.UEN=Soporte.ProyectoFolio
Soporte.ProyectoFolio=Soporte.FechaEmision
Soporte.FechaEmision=Soporte.FechaConclusion
Soporte.FechaConclusion=Soporte.Cliente
Soporte.Cliente=Cte.Nombre
Cte.Nombre=Soporte.EnviarA
Soporte.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=Soporte.Proveedor
Soporte.Proveedor=Prov.Nombre
Prov.Nombre=Soporte.Personal
Soporte.Personal=NombreCompleto
NombreCompleto=NombreSucursalTrabajo
NombreSucursalTrabajo=Soporte.LineaCredito
Soporte.LineaCredito=LC.Descripcion
LC.Descripcion=Soporte.Reporte
Soporte.Reporte=Rep.Asunto
Rep.Asunto=Rep.Tipo
Rep.Tipo=Soporte.Agente
Soporte.Agente=Soporte.Articulo
Soporte.Articulo=Soporte.SerieLote
Soporte.SerieLote=Soporte.Fuente
Soporte.Fuente=Soporte.Espacio
Soporte.Espacio=Soporte.Contacto
Soporte.Contacto=Soporte.Telefono
Soporte.Telefono=Soporte.Extencion
Soporte.Extencion=Soporte.eMail
Soporte.eMail=Soporte.Fax
Soporte.Fax=Soporte.Clase
Soporte.Clase=Soporte.Subclase
Soporte.Subclase=Soporte.Concepto
Soporte.Concepto=Soporte.Elemento
Soporte.Elemento=Soporte.Referencia
Soporte.Referencia=Soporte.Medio
Soporte.Medio=Soporte.Observaciones
Soporte.Observaciones=Soporte.TieneContrato
Soporte.TieneContrato=Soporte.ReferenciaInicial
Soporte.ReferenciaInicial=Soporte.UsuarioResponsable
Soporte.UsuarioResponsable=UsuarioCopia.Nombre
UsuarioCopia.Nombre=Soporte.Usuario
Soporte.Usuario=UsuarioRelacion.Nombre
UsuarioRelacion.Nombre=(Fin)





[Aplicacion.ListaEnCaptura]
(Inicio)=SoporteD.Aplica
SoporteD.Aplica=SoporteD.AplicaID
SoporteD.AplicaID=Soporte.FechaEmision
Soporte.FechaEmision=Soporte.Cliente
Soporte.Cliente=Soporte.Titulo
Soporte.Titulo=Soporte.Prioridad
Soporte.Prioridad=(Fin)


[Minuta.ListaEnCaptura]
(Inicio)=Soporte.Titulo
Soporte.Titulo=Soporte.Prioridad
Soporte.Prioridad=Soporte.Comentarios
Soporte.Comentarios=Soporte.Estado
Soporte.Estado=Soporte.FechaInicio
Soporte.FechaInicio=Soporte.FechaTermino
Soporte.FechaTermino=Soporte.Tiempo
Soporte.Tiempo=Soporte.TiempoUnidad
Soporte.TiempoUnidad=(Fin)

[Vehiculo.ListaEnCaptura]
(Inicio)=Soporte.VIN
Soporte.VIN=VIN.NumeroEconomico
VIN.NumeroEconomico=VIN.Placas
VIN.Placas=Soporte.ServicioTipo
Soporte.ServicioTipo=Soporte.FechaRequerida
Soporte.FechaRequerida=(Fin)

[Direccion.ListaEnCaptura]
(Inicio)=Soporte.Direccion
Soporte.Direccion=Soporte.DireccionNumero
Soporte.DireccionNumero=Soporte.EntreCalles
Soporte.EntreCalles=Soporte.Plano
Soporte.Plano=Soporte.Delegacion
Soporte.Delegacion=Soporte.Colonia
Soporte.Colonia=Soporte.CodigoPostal
Soporte.CodigoPostal=Soporte.Poblacion
Soporte.Poblacion=Soporte.PaisEstado
Soporte.PaisEstado=Soporte.Pais
Soporte.Pais=Soporte.Zona
Soporte.Zona=(Fin)

[FormaAnexo.ListaAcciones]
(Inicio)=FormaAnexoAbrir
FormaAnexoAbrir=FormaAnexoAnexar
FormaAnexoAnexar=FormaAnexoEliminar
FormaAnexoEliminar=(Fin)

[FormaAnexo.ListaEnCaptura]
(Inicio)=Usuario
Usuario=UltimoCambio
UltimoCambio=(Fin)

[MovEvento.ListaEnCaptura]
(Inicio)=MovEvento.Fecha
MovEvento.Fecha=MovEvento.Usuario
MovEvento.Usuario=MovEvento.Tipo
MovEvento.Tipo=MovEvento.Estado
MovEvento.Estado=(Fin)

[MovEvento.ListaAcciones]
(Inicio)=MovEventoAmpliar
MovEventoAmpliar=MovEventoImprimir
MovEventoImprimir=MovEventoPreliminar
MovEventoPreliminar=MovEventoExcel
MovEventoExcel=MovEventoPersonalizar
MovEventoPersonalizar=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)

[Clasificacion.ListaEnCaptura]
(Inicio)=Soporte.Clase1
Soporte.Clase1=Soporte.Clase2
Soporte.Clase2=Soporte.Clase3
Soporte.Clase3=Soporte.Clase4
Soporte.Clase4=Soporte.Clase5
Soporte.Clase5=Soporte.Causa
Soporte.Causa=(Fin)

[MovBitacora.ListaEnCaptura]
(Inicio)=MovBitacora.Fecha
MovBitacora.Fecha=MovBitacora.Evento
MovBitacora.Evento=MovBitacora.Usuario
MovBitacora.Usuario=MovBitacora.Duracion
MovBitacora.Duracion=MovBitacora.DuracionUnidad
MovBitacora.DuracionUnidad=HorasHabiles
HorasHabiles=(Fin)

[MovBitacora.ListaAcciones]
(Inicio)=BitacoraImprimir
BitacoraImprimir=BitacoraPreliminar
BitacoraPreliminar=BitacoraExcel
BitacoraExcel=BitacoraPersonalizar
BitacoraPersonalizar=(Fin)
































































[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S
















[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Soporte.Titulo
Soporte.Titulo=Soporte.FechaEmision
Soporte.FechaEmision=Soporte.FechaConclusion
Soporte.FechaConclusion=Soporte.Vencimiento
Soporte.Vencimiento=Dias
Dias=Atraso
Atraso=Soporte.Estado
Soporte.Estado=Soporte.Cliente
Soporte.Cliente=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=ALTAPRIORIDAD
ALTAPRIORIDAD=PRIORIDADBAJA
PRIORIDADBAJA=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=Ordenar
Ordenar=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)












[Problema.ListaEnCaptura]
(Inicio)=Soporte.Titulo
Soporte.Titulo=Soporte.Cliente
Soporte.Cliente=Soporte.Prioridad
Soporte.Prioridad=Soporte.Problema
Soporte.Problema=Soporte.Vencimiento
Soporte.Vencimiento=Soporte.Estado
Soporte.Estado=Soporte.FechaInicio
Soporte.FechaInicio=Soporte.Tiempo
Soporte.Tiempo=Soporte.TiempoUnidad
Soporte.TiempoUnidad=Soporte.FechaInicioEst
Soporte.FechaInicioEst=Soporte.FechaFinEst
Soporte.FechaFinEst=Soporte.FechaRevision
Soporte.FechaRevision=Soporte.FechaAprobacion
Soporte.FechaAprobacion=Soporte.CondicionEntrega
Soporte.CondicionEntrega=Soporte.Importe
Soporte.Importe=Soporte.CondicionPago
Soporte.CondicionPago=Soporte.Version
Soporte.Version=(Fin)

[Solucion.ListaEnCaptura]
(Inicio)=Soporte.Titulo
Soporte.Titulo=Soporte.Cliente
Soporte.Cliente=Soporte.Prioridad
Soporte.Prioridad=Soporte.Solucion
Soporte.Solucion=Soporte.Avance
Soporte.Avance=Soporte.Estado
Soporte.Estado=Soporte.Calificacion
Soporte.Calificacion=(Fin)

[Comentarios.ListaEnCaptura]
(Inicio)=Soporte.Titulo
Soporte.Titulo=Soporte.Cliente
Soporte.Cliente=Soporte.Prioridad
Soporte.Prioridad=Soporte.Comentarios
Soporte.Comentarios=(Fin)




[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Problema
Problema=Solucion
Solucion=Clasificacion
Clasificacion=Direccion
Direccion=Vehiculo
Vehiculo=Minuta
Minuta=Comentarios
Comentarios=Aplicacion
Aplicacion=FormaAnexo
FormaAnexo=MovBitacora
MovBitacora=MovEvento
MovEvento=FormaExtraValor
FormaExtraValor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=OtrosDatos
OtrosDatos=MovPersonal
MovPersonal=Evaluaciones
Evaluaciones=Propiedades
Propiedades=Imprimir
Imprimir=RepPantalla
RepPantalla=PlantillasOffice
PlantillasOffice=FormaAnexo
FormaAnexo=EnviarCorreo
EnviarCorreo=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Prioridad
Prioridad=Afectar
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=Devolver
Devolver=Transferir
Transferir=Responsable
Responsable=RepExpress
RepExpress=CteExpress
CteExpress=CamposExtras
CamposExtras=Tareas
Tareas=Anexos
Anexos=AgregarEvento
AgregarEvento=SoporteCambio
SoporteCambio=Anterior
Anterior=Siguiente
Siguiente=CtoInfo
CtoInfo=CteInfo
CteInfo=ProvInfo
ProvInfo=PersonalInfo
PersonalInfo=AgenteInfo
AgenteInfo=ProyInfo
ProyInfo=ArtInfo
ArtInfo=Mensaje
Mensaje=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=Bitacora
Bitacora=ColaUsuario
ColaUsuario=Actividades
Actividades=MovPos
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
