[Forma]
Clave=Organiza
Nombre=<T>Organización<T>
Icono=0
Modulos=ORG
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=343
PosicionInicialArriba=150
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
MovModulo=ORG
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=520
Totalizadores=S
PosicionSec1=148
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
Vista=Organiza
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

[Ficha.Organiza.Mov]
Carpeta=Ficha
Clave=Organiza.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Organiza.MovID]
Carpeta=Ficha
Clave=Organiza.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.Organiza.FechaEmision]
Carpeta=Ficha
Clave=Organiza.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Organiza.Proyecto]
Carpeta=Ficha
Clave=Organiza.Proyecto
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
Vista=OrganizaA
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
ListaOrden=Organiza.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Organiza.FechaEmision
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
FiltroFechasCancelacion=Organiza.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S

BusquedaSelCampo=S
IconosNombre=OrganizaA:Organiza.Mov+<T> <T>+OrganizaA:Organiza.MovID
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Organiza:Organiza.ID) y (Organiza:Organiza.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Organiza:Organiza.ID, <T>ORG<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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

Expresion=Asigna(Afectar.Modulo, <T>ORG<T>)<BR>Asigna(Afectar.ID, Organiza:Organiza.ID)<BR>Asigna(Afectar.Mov, Organiza:Organiza.Mov)<BR>Asigna(Afectar.MovID, Organiza:Organiza.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>Organiza<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.MovID, Organiza:Organiza.MovID)<BR>Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>Asigna(Info.MovTipo, MovTipo(Afectar.Modulo, Organiza:Organiza.Mov))<BR>Si<BR>  Organiza:Organiza.Estatus=EstatusPendiente<BR>Entonces<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si<BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Dialogo(<T>GenerarOrganiza<T>)<BR>  Fin<BR>Sino<BR>  Afectar(Afectar.Modulo, Organiza:Organiza.ID, Organiza:Organiza.Mov, Organiza:Organiza.MovID, <T>Todo<T>, <T><T>, Afectar.FormaCaptura)<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Organiza:Organiza.Usuario) y<BR>((Organiza:Organiza.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) o<BR>((Organiza:Organiza.Estatus=EstatusPendiente) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>ORG<T>, Organiza:Organiza.Mov, Organiza:Organiza.Estatus, FormaSituacion, Usuario)))
EjecucionCondicion=ConDatos(Organiza:Organiza.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Organiza:Organiza.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>ORG<T>, Organiza:Organiza.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>ORG<T>, Organiza:Organiza.Mov, Organiza:Organiza.ID, Verdadero, Organiza:Organiza.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Organiza:Organiza.MovID) y (Organiza:Organiza.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Organiza:Organiza.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Organiza WHERE ID=:nID<T>, Organiza:Organiza.ID))
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
ListaParametros1=Organiza:Organiza.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>ORG<T>, Organiza:Organiza.Mov, Organiza:Organiza.Estatus), Organiza:Organiza.ID)
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
ListaParametros1=Organiza:Organiza.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>ORG<T>, Organiza:Organiza.Mov, Organiza:Organiza.Estatus), Organiza:Organiza.ID)
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
Expresion=Cancelar(<T>ORG<T>, Organiza:Organiza.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Organiza<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Organiza:Organiza.Usuario) y ConDatos(Organiza:Organiza.ID) y ConDatos(Organiza:Organiza.MovID) y<BR>((Organiza:Organiza.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPendiente)) o<BR>(Organiza:Organiza.Estatus=EstatusConcluido))
AntesExpresiones=Asigna( Afectar.Mov, Organiza:Organiza.Mov ) <BR> Asigna( Afectar.MovID, Organiza:Organiza.MovID )

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
Expresion=Verificar(<T>ORG<T>, Organiza:Organiza.ID,Organiza:Organiza.Mov,Organiza:Organiza.MovID)
ActivoCondicion=Organiza:Organiza.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Organiza:Organiza.Mov)
[Aplica.Organiza.MovAplica]
Carpeta=Aplica
Clave=Organiza.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Organiza.MovAplicaID]
Carpeta=Aplica
Clave=Organiza.MovAplicaID
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
ActivoCondicion=ConDatos(Organiza:Organiza.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.MovID, Organiza:Organiza.MovID)
[Aplica.Organiza.Agente]
Carpeta=Aplica
Clave=Organiza.Agente
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>ORG<T>, Organiza:Organiza.Mov, Organiza:Organiza.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>ORG<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>ORG<T>, Organiza:Organiza.Mov, Organiza:Organiza.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Organiza:Organiza.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.Estatus, Organiza:Organiza.Estatus)<BR>Asigna(Info.Situacion, Organiza:Organiza.Situacion)
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
ActivoCondicion=ConfigModulo(<T>ORG<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Organiza:Organiza.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.MovID, Organiza:Organiza.MovID)


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
AntesExpresiones=Asigna(Info.Rama, <T>ORG<T>)<BR>Asigna(Info.Fecha, Organiza:Organiza.FechaEmision)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Organiza:Organiza.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Organiza:Organiza.Mov+<T> <T>+Organiza:Organiza.MovID)
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
EjecucionCondicion=Si(Vacio(Organiza:Organiza.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.MovID, Organiza:Organiza.MovID)<BR>Asigna(Info.PuedeEditar, Organiza:Organiza.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Organiza:Organiza.Usuario))

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
ActivoCondicion=Organiza:Organiza.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Organiza:Organiza.Usuario)
EjecucionCondicion=Si(Vacio(Organiza:Organiza.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.MovID, Organiza:Organiza.MovID)

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
ActivoCondicion=ConDatos(Organiza:Organiza.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)

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
Expresion=CopiarMovimiento(<T>ORG<T>, Organiza:Organiza.ID, <T>Organiza<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Organiza:Organiza.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Organiza:Organiza.ID),GuardarCambios)
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
Posicion=107
Entidad=98
Rol=152
Observaciones=262
Organizacion=66
ContactoTipo=107
Clave=84
TipoRelacion=93
[Ficha.Organiza.UEN]
Carpeta=Ficha
Clave=Organiza.UEN
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
AntesExpresiones=Asigna(Info.PuedeEditar, Organiza:Organiza.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.MovID, Organiza:Organiza.MovID)<BR>Asigna(Info.Cliente, Organiza:Organiza.Cliente)<BR>Asigna(Info.Proveedor, Organiza:Organiza.Proveedor)<BR>Asigna(Info.Agente, Organiza:Organiza.Agente)<BR>Asigna(Info.Personal, Organiza:Organiza.Personal)<BR>Asigna(Info.Proyecto, Organiza:Organiza.Proyecto)<BR>Asigna(Info.UEN, Organiza:Organiza.UEN)<BR>Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.Reporte, Nulo)

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
Expresion=Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.Clave, <T>ORG<T>+Organiza:Organiza.ID)<BR>Asigna(Info.Nombre, Organiza:Organiza.Mov+<T> <T>+Organiza:Organiza.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Organiza:Organiza.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.MovID, Organiza:Organiza.MovID)<BR>Asigna(Info.Fecha, Organiza:Organiza.FechaEmision)<BR>Asigna(Info.Estatus, Organiza:Organiza.Estatus)

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
EjecucionCondicion=ConDatos(Organiza:Organiza.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>ORG<T>)<BR>Asigna(Info.Clave, Organiza:Organiza.Mov)

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
EjecucionCondicion=ConDatos(Organiza:Organiza.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.Concepto, Organiza:Organiza.Concepto)

[(Carpeta Abrir).Organiza.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Organiza.Concepto
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
Vista=OrganizaD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Organiza
LlaveLocal=OrganizaD.ID
LlaveMaestra=Organiza.ID
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
CampoRenglon=OrganizaD.Renglon
HojaFondoGrisAuto=S

ValidarCampos=S
ListaCamposAValidar=(Lista)
[Ficha.Organiza.Concepto]
Carpeta=Ficha
Clave=Organiza.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Organiza.Referencia]
Carpeta=Ficha
Clave=Organiza.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Organiza.Observaciones]
Carpeta=Ficha
Clave=Organiza.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=88
ColorFondo=Blanco

[Ficha.Organiza.Moneda]
Carpeta=Ficha
Clave=Organiza.Moneda
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Organiza.TipoCambio]
Carpeta=Ficha
Clave=Organiza.TipoCambio
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
Pegado=S





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
Expresion=Asigna(Info.Forma, <T>Organiza<T>)<BR>Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.Nombre, Organiza:Organiza.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>ORG<T>, Organiza:Organiza.Mov, Organiza:Organiza.ID, Falso, Organiza:Organiza.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>ORG<T>+Organiza:Organiza.ID)<BR>  Asigna(Info.Nombre, Organiza:Organiza.Mov+<T> <T>+Organiza:Organiza.MovID)<BR>  Asigna(Info.Modulo, <T>ORG<T>)<BR>  Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Organiza:Organiza.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>ORG<T>)<BR>Asigna(Info.ID, Organiza:Organiza.ID)<BR>Asigna(Info.Mov, Organiza:Organiza.Mov)<BR>Asigna(Info.MovID, Organiza:Organiza.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (Organiza:Organiza.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>ORG<T>, <T>{Organiza:Organiza.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>ORG{Organiza:Organiza.ID}<T>

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







[(Carpeta Abrir).Organiza.Referencia]
Carpeta=(Carpeta Abrir)
Clave=Organiza.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).Organiza.Observaciones]
Carpeta=(Carpeta Abrir)
Clave=Organiza.Observaciones
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
Vista=Organiza
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
ListaEnCaptura=Organiza.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S

[Comentarios.Organiza.Comentarios]
Carpeta=Comentarios
Clave=Organiza.Comentarios
Editar=S
LineaNueva=S
3D=S
Tamano=100x3
ColorFondo=Blanco




[Detalle.OrganizaD.Posicion]
Carpeta=Detalle
Clave=OrganizaD.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.OrganizaD.Entidad]
Carpeta=Detalle
Clave=OrganizaD.Entidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.OrganizaD.Rol]
Carpeta=Detalle
Clave=OrganizaD.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.OrganizaD.Observaciones]
Carpeta=Detalle
Clave=OrganizaD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco













[Lista.Columnas]
0=81
1=377













2=109



[Detalle.OrganizaD.Organizacion]
Carpeta=Detalle
Clave=OrganizaD.Organizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













IgnoraFlujo=N
[Ficha.ListaEnCaptura]
(Inicio)=Organiza.Mov
Organiza.Mov=Organiza.MovID
Organiza.MovID=Organiza.Proyecto
Organiza.Proyecto=Organiza.UEN
Organiza.UEN=Organiza.Moneda
Organiza.Moneda=Organiza.TipoCambio
Organiza.TipoCambio=Organiza.FechaEmision
Organiza.FechaEmision=Organiza.Concepto
Organiza.Concepto=Organiza.Referencia
Organiza.Referencia=Organiza.Observaciones
Organiza.Observaciones=(Fin)


































[Detalle.OrganizaD.ContactoTipo]
Carpeta=Detalle
Clave=OrganizaD.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.OrganizaD.TipoRelacion]
Carpeta=Detalle
Clave=OrganizaD.TipoRelacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[Detalle.ListaEnCaptura]
(Inicio)=OrganizaD.Organizacion
OrganizaD.Organizacion=OrganizaD.Posicion
OrganizaD.Posicion=OrganizaD.Entidad
OrganizaD.Entidad=OrganizaD.Rol
OrganizaD.Rol=OrganizaD.ContactoTipo
OrganizaD.ContactoTipo=Clave
Clave=OrganizaD.TipoRelacion
OrganizaD.TipoRelacion=OrganizaD.Observaciones
OrganizaD.Observaciones=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=OrganizacionPosicion.Nombre
OrganizacionPosicion.Nombre=Entidad.Nombre
Entidad.Nombre=(Fin)

[Detalle.Clave]
Carpeta=Detalle
Clave=Clave
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

























[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Organiza.Concepto
Organiza.Concepto=Organiza.Referencia
Organiza.Referencia=Organiza.Observaciones
Organiza.Observaciones=(Fin)

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
Ficha=Comentarios
Comentarios=FormaExtraValor
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
Cancelar=CamposExtras
CamposExtras=Tareas
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
