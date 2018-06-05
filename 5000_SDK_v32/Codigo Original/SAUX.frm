[Forma]
Clave=SAUX
Nombre=Servicios Auxiliares
Icono=0
Modulos=SAUX
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=402
PosicionInicialArriba=65
PosicionInicialAltura=558
PosicionInicialAncho=679
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
MovModulo=SAUX
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
TituloAutoNombre=S
PosicionInicialAlturaCliente=577
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.Aplica, Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Proveedor, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
PosicionSec1=276

SinTransacciones=S
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUX
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=100
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
FichaEspacioNombresAuto=S
Pestana=S

[Ficha.SAUX.Mov]
Carpeta=Ficha
Clave=SAUX.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUX.MovID]
Carpeta=Ficha
Clave=SAUX.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.SAUX.FechaEmision]
Carpeta=Ficha
Clave=SAUX.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.SAUX.Proyecto]
Carpeta=Ficha
Clave=SAUX.Proyecto
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
Vista=SAUXA
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
ListaOrden=SAUX.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=SAUX.FechaEmision
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
FiltroFechasNormal=S
FiltroFechasCancelacion=SAUX.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S

IconosNombre=SAUXA:SAUX.Mov+<T> <T>+SAUXA:SAUX.MovID
[(Carpeta Abrir).Columnas]
0=135
1=88

2=-2
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(SAUX:SAUX.ID) y (SAUX:SAUX.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, SAUX:SAUX.ID, <T>SAUX<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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

Expresion=Asigna(Afectar.Modulo, <T>SAUX<T>)<BR>Asigna(Afectar.ID, SAUX:SAUX.ID)<BR>Asigna(Afectar.Mov, SAUX:SAUX.Mov)<BR>Asigna(Afectar.MovID, SAUX:SAUX.MovID)<BR>Asigna(Afectar.Base, <T>Todo<T>)<BR>Asigna(Afectar.GenerarMov, <T><T>)<BR>Asigna(Afectar.FormaCaptura, <T>SAUX<T>)<BR>Asigna(Info.MovTipo, MovTipo(<T>SAUX<T>, SAUX:SAUX.Mov))<BR>Asigna(Info.TituloDialogo, SAUX:SAUX.Mov+<T> <T>+SAUX:SAUX.MovID)<BR>Si<BR> SAUX:SAUX.Estatus = EstatusPendiente<BR>Entonces<BR>  Asigna(Info.Modulo, <T>SAUX<T>)<BR>  Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>  Asigna(Info.MovID, SAUX:SAUX.MovID)<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si<BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.Base, <T>Pendiente<T>)<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Asigna(Afectar.GenerarMov, Nulo)<BR>    Si<BR>      Caso Info.MovTipo<BR>        Es SAUX.SS Entonces Dialogo(<T>GenerarSAUXServicio<T>)<BR>        Es SAUX.S Entonces   Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>      Fin<BR>      Asigna(Info.TituloDialogo, <T>Generar <T>+Comillas(Afectar.GenerarMov)+<T> de <T>+Comillas(Afectar.Mov))<BR>//      ConDatos(Afectar.GenerarMov)<BR>//    Entonces<BR>//      Asigna(Afectar.Base, <T>Pendiente<T>)<BR>//      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>//    Fin<BR>  Fin<BR>Sino<BR>  Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, SAUX:SAUX.Usuario) y<BR>(SAUX:SAUX.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente))  y<BR>fnPuedeAvanzarEstatus(Empresa, <T>SAUX<T>, SAUX:SAUX.Mov, SAUX:SAUX.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(SAUX:SAUX.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (SAUX:SAUX.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>SAUX<T>, SAUX:SAUX.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>SAUX<T>, SAUX:SAUX.Mov, SAUX:SAUX.ID, Verdadero, SAUX:SAUX.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(SAUX:SAUX.MovID) y (SAUX:SAUX.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, SAUX:SAUX.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM SAUX WHERE ID=:nID<T>, SAUX:SAUX.ID))
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
ListaParametros1=SAUX:SAUX.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>SAUX<T>, SAUX:SAUX.Mov, SAUX:SAUX.Estatus), SAUX:SAUX.ID)
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
ListaParametros1=SAUX:SAUX.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>SAUX<T>, SAUX:SAUX.Mov, SAUX:SAUX.Estatus), SAUX:SAUX.ID)
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
Expresion=Cancelar(<T>SAUX<T>, SAUX:SAUX.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>SAUX<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, SAUX:SAUX.Usuario) y ConDatos(SAUX:SAUX.ID) y ConDatos(SAUX:SAUX.MovID) y<BR>((SAUX:SAUX.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusSincro, EstatusPendiente)) o<BR>(SAUX:SAUX.Estatus en (EstatusConcluido, EstatusPorConfirmar)))
AntesExpresiones=Asigna( Afectar.Mov, SAUX:SAUX.Mov ) <BR> Asigna( Afectar.MovID, SAUX:SAUX.MovID )

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
Expresion=Verificar(<T>SAUX<T>, SAUX:SAUX.ID,SAUX:SAUX.Mov,SAUX:SAUX.MovID)
ActivoCondicion=SAUX:SAUX.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(SAUX:SAUX.Mov)

[Aplica.SAUX.MovAplica]
Carpeta=Aplica
Clave=SAUX.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.SAUX.MovAplicaID]
Carpeta=Aplica
Clave=SAUX.MovAplicaID
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
ActivoCondicion=ConDatos(SAUX:SAUX.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.MovID, SAUX:SAUX.MovID)
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>SAUX<T>, SAUX:SAUX.Mov, SAUX:SAUX.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>SAUX<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>SAUX<T>, SAUX:SAUX.Mov, SAUX:SAUX.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(SAUX:SAUX.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.Estatus, SAUX:SAUX.Estatus)<BR>Asigna(Info.Situacion, SAUX:SAUX.Situacion)
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
ActivoCondicion=ConfigModulo(<T>SAUX<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(SAUX:SAUX.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.MovID, SAUX:SAUX.MovID)

[(Carpeta Abrir).SAUX.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=SAUX.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
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
AntesExpresiones=Asigna(Info.Rama, <T>SAUX<T>)<BR>Asigna(Info.Fecha, SAUX:SAUX.FechaEmision)<BR>Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (SAUX:SAUX.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, SAUX:SAUX.Mov+<T> <T>+SAUX:SAUX.MovID)
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
EjecucionCondicion=Si(Vacio(SAUX:SAUX.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.MovID, SAUX:SAUX.MovID)<BR>Asigna(Info.PuedeEditar, SAUX:SAUX.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(SAUX:SAUX.Usuario))

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
ActivoCondicion=SAUX:SAUX.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(SAUX:SAUX.Usuario)
EjecucionCondicion=Si(Vacio(SAUX:SAUX.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.MovID, SAUX:SAUX.MovID)

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
ActivoCondicion=ConDatos(SAUX:SAUX.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUX:SAUX.ID)

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
Expresion=CopiarMovimiento(<T>SAUX<T>, SAUX:SAUX.ID, <T>SAUX<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (SAUX:SAUX.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(SAUX:SAUX.ID),GuardarCambios)
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
Cantidad=50
Precio=101
Costo=103
PrecioTotal=104
CostoTotal=93
Tarima=97
Articulo=106
Unidad=45
Factor=49
Posicion=83
Contenedor=61
CantidadRecogida=94
CantidadEntregada=100
SubCuenta=108
CantidadPendiente=98
AplicaRID=64
PosicionDestino=86
CantidadA=64
Almacen=78
Posicion_1=80
EstaPendiente=55

ID=64
Renglon=64
Producto=124
SubProducto=124
Servicio=124
Codigo=75
CantidadPendeiente=63
CantidadCancelada=97
FechaRequerida=94
FechaInicio=94
FechaFin=94
FechaEntrega=117
Estado=84
Observaciones=161
Prioridad=75
[Ficha.SAUX.UEN]
Carpeta=Ficha
Clave=SAUX.UEN
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
AntesExpresiones=Asigna(Info.PuedeEditar, SAUX:SAUX.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.MovID, SAUX:SAUX.MovID)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, SAUX:SAUX.Proyecto)<BR>Asigna(Info.UEN, SAUX:SAUX.UEN)<BR>Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Reporte, Nulo)

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
Expresion=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.Clave, <T>SAUX<T>+SAUX:SAUX.ID)<BR>Asigna(Info.Nombre, SAUX:SAUX.Mov+<T> <T>+SAUX:SAUX.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(SAUX:SAUX.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.MovID, SAUX:SAUX.MovID)<BR>Asigna(Info.Fecha, SAUX:SAUX.FechaEmision)<BR>Asigna(Info.Estatus, SAUX:SAUX.Estatus)

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
EjecucionCondicion=ConDatos(SAUX:SAUX.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>SAUX<T>)<BR>Asigna(Info.Clave, SAUX:SAUX.Mov)

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
EjecucionCondicion=ConDatos(SAUX:SAUX.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.Concepto, SAUX:SAUX.Concepto)

[(Carpeta Abrir).SAUX.Concepto]
Carpeta=(Carpeta Abrir)
Clave=SAUX.Concepto
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
Vista=SAUXD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=SAUX
LlaveLocal=SAUXD.ID
LlaveMaestra=SAUX.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ControlRenglon=S
CampoRenglon=SAUXD.Renglon
HojaFondoGrisAuto=S

ListaEnCaptura=(Lista)
ValidarCampos=S
ListaCamposAValidar=(Lista)
[Ficha.SAUX.Concepto]
Carpeta=Ficha
Clave=SAUX.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.SAUX.Referencia]
Carpeta=Ficha
Clave=SAUX.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.SAUX.Observaciones]
Carpeta=Ficha
Clave=SAUX.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=74
ColorFondo=Blanco

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
Expresion=Asigna(Info.Forma, <T>SAUX<T>)<BR>Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.Nombre, SAUX:SAUX.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin




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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>SAUX<T>, SAUX:SAUX.Mov, SAUX:SAUX.ID, Falso, SAUX:SAUX.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>SAUX<T>+SAUX:SAUX.ID)<BR>  Asigna(Info.Nombre, SAUX:SAUX.Mov+<T> <T>+SAUX:SAUX.MovID)<BR>  Asigna(Info.Modulo, <T>SAUX<T>)<BR>  Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      SAUX:SAUX.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin


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
AntesExpresiones=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Mov, SAUX:SAUX.Mov)<BR>Asigna(Info.MovID, SAUX:SAUX.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (SAUX:SAUX.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>SAUX<T>, <T>{SAUX:SAUX.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>SAUX{SAUX:SAUX.ID}<T>
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
VerCampo=310
VerValor=310


[Ficha.OrigenNombre]
Carpeta=Ficha
Clave=OrigenNombre
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata


LineaNueva=S



[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)




[Lista.Columnas]
0=66
1=56
2=-2
Almacen=90
Nombre=293
Grupo=100
Sucursal=46








































3=-2
4=-2










5=-2
Articulo=131
Descripcion1=244
Servicio=131
Descripcion=604

Cliente=117
RFC=107
[Detalle.SAUXD.Producto]
Carpeta=Detalle
Clave=SAUXD.Producto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Detalle.SAUXD.Servicio]
Carpeta=Detalle
Clave=SAUXD.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.SAUXD.Codigo]
Carpeta=Detalle
Clave=SAUXD.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.SAUXD.Cantidad]
Carpeta=Detalle
Clave=SAUXD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SAUXD.CantidadPendeiente]
Carpeta=Detalle
Clave=SAUXD.CantidadPendeiente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Detalle.SAUXD.CantidadA]
Carpeta=Detalle
Clave=SAUXD.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EditarConBloqueo=S
[Detalle.SAUXD.FechaRequerida]
Carpeta=Detalle
Clave=SAUXD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SAUXD.FechaInicio]
Carpeta=Detalle
Clave=SAUXD.FechaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SAUXD.FechaFin]
Carpeta=Detalle
Clave=SAUXD.FechaFin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SAUXD.FechaEntrega]
Carpeta=Detalle
Clave=SAUXD.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Detalle.SAUXD.Observaciones]
Carpeta=Detalle
Clave=SAUXD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

EditarConBloqueo=S
[Detalle.SAUXD.Prioridad]
Carpeta=Detalle
Clave=SAUXD.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



EditarConBloqueo=S
[Acciones.SAUXDIndicador]
Nombre=SAUXDIndicador
Boton=87
NombreDesplegar=Indicadores
TipoAccion=Formas
ClaveAccion=SAUXDIndicador
Antes=S

































































































































































































































































































Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
GuardarAntes=S






































































Activo=S
EnBarraHerramientas=S
EspacioPrevio=S
EnMenu=S
AntesExpresiones=Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Producto, SAUXD:SAUXD.Producto)<BR>Asigna(Info.Servicio, SAUXD:SAUXD.Servicio)
VisibleCondicion=MovTipoEn(<T>SAUX<T>, SAUX:SAUX.Mov, (SAUX.S)) y (SAUX:SAUX.Estatus en (EstatusSinAfectar))
[Ficha.SAUX.FechaRegistro]
Carpeta=Ficha
Clave=SAUX.FechaRegistro
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.SAUX.FechaEntrega]
Carpeta=Ficha
Clave=SAUX.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[Ficha.SAUX.EnviarA]
Carpeta=Ficha
Clave=SAUX.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


















[Detalle.ListaEnCaptura]
(Inicio)=SAUXD.Producto
SAUXD.Producto=SAUXD.Servicio
SAUXD.Servicio=SAUXD.Codigo
SAUXD.Codigo=SAUXD.Cantidad
SAUXD.Cantidad=SAUXD.CantidadPendeiente
SAUXD.CantidadPendeiente=SAUXD.CantidadA
SAUXD.CantidadA=SAUXD.FechaRequerida
SAUXD.FechaRequerida=SAUXD.FechaInicio
SAUXD.FechaInicio=SAUXD.FechaFin
SAUXD.FechaFin=SAUXD.FechaEntrega
SAUXD.FechaEntrega=SAUXD.Observaciones
SAUXD.Observaciones=SAUXD.Prioridad
SAUXD.Prioridad=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=SAUXD.Producto
SAUXD.Producto=Art.Descripcion1
Art.Descripcion1=SAUXD.Servicio
SAUXD.Servicio=SAUXServicio.Descripcion
SAUXServicio.Descripcion=(Fin)
























































[Ficha.SAUX.Contacto]
Carpeta=Ficha
Clave=SAUX.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco








[Ficha.SAUX.TipoContacto]
Carpeta=Ficha
Clave=SAUX.TipoContacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


















[Ficha.NombreContacto]
Carpeta=Ficha
Clave=NombreContacto
Editar=S
ValidaNombre=N
3D=S
Tamano=43
ColorFondo=Plata


































[Ficha.Columnas]
0=-2
1=-2
2=-2






























































[Ficha.NombreEnviarA]
Carpeta=Ficha
Clave=NombreEnviarA
Editar=S
ValidaNombre=N
3D=S
Tamano=43
ColorFondo=Plata












[Ficha.ListaEnCaptura]
(Inicio)=SAUX.Mov
SAUX.Mov=SAUX.MovID
SAUX.MovID=SAUX.Proyecto
SAUX.Proyecto=SAUX.UEN
SAUX.UEN=SAUX.FechaEmision
SAUX.FechaEmision=SAUX.FechaRegistro
SAUX.FechaRegistro=SAUX.FechaEntrega
SAUX.FechaEntrega=SAUX.TipoContacto
SAUX.TipoContacto=SAUX.Contacto
SAUX.Contacto=NombreContacto
NombreContacto=SAUX.EnviarA
SAUX.EnviarA=NombreEnviarA
NombreEnviarA=SAUX.Concepto
SAUX.Concepto=SAUX.Referencia
SAUX.Referencia=OrigenNombre
OrigenNombre=SAUX.Observaciones
SAUX.Observaciones=(Fin)










































































































[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122








































[Acciones.SAUXDIndicadorInfo]
Nombre=SAUXDIndicadorInfo
Boton=87
EnMenu=S
Activo=S




NombreDesplegar=Indicadores
TipoAccion=Formas
ClaveAccion=SAUXDIndicadorInfo






Menu=&Edición












Antes=S









UsaTeclaRapida=S






TeclaRapida=F8

























































EnBarraHerramientas=S
















































AntesExpresiones=Asigna(Info.ID, SAUX:SAUX.ID)<BR>Asigna(Info.Producto, SAUXD:SAUXD.Producto)<BR>Asigna(Info.Servicio, SAUXD:SAUXD.Servicio)
VisibleCondicion=MovTipoEn(<T>SAUX<T>, SAUX:SAUX.Mov, (SAUX.S)) y (SAUX:SAUX.Estatus en (EstatusConcluido))

































[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S

























[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=SAUX.FechaEmision
SAUX.FechaEmision=SAUX.Concepto
SAUX.Concepto=(Fin)

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
CamposExtras=SAUXDIndicador
SAUXDIndicador=SAUXDIndicadorInfo
SAUXDIndicadorInfo=Tareas
Tareas=Anexos
Anexos=AgregarEvento
AgregarEvento=Anterior
Anterior=Siguiente
Siguiente=Tiempo
Tiempo=Politica
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
