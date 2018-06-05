[Forma]
Clave=hConciliacion
Nombre=<T>hConciliacion<T>
Icono=0
Modulos=CONC
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=1940
PosicionInicialArriba=0
PosicionInicialAltura=558
PosicionInicialAncho=759
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
PosicionSeccion1=64
PosicionSeccion2=92
BarraAyuda=S
MovModulo=CONC
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=556
Totalizadores=S
PosicionSec1=177
PosicionSec2=492
Plantillas=S
PermiteCopiarDoc=S
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.ConciliarManual, Falso)

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hConciliacion
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

[Ficha.hConciliacion.Mov]
Carpeta=Ficha
Clave=hConciliacion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hConciliacion.MovID]
Carpeta=Ficha
Clave=hConciliacion.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=5
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.hConciliacion.FechaEmision]
Carpeta=Ficha
Clave=hConciliacion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hConciliacion.Proyecto]
Carpeta=Ficha
Clave=hConciliacion.Proyecto
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

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=hConciliacionA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situaci�n)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosConPaginas=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=hConciliacion.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=hConciliacion.FechaEmision
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
FiltroFechasCancelacion=hConciliacion.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S
FiltroUsuarios=S

IconosNombre=hConciliacionA:hConciliacion.Mov+<T> <T>+hConciliacionA:hConciliacion.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=129
1=80

2=-2
3=-2
4=-2
5=-2
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(hConciliacion:hConciliacion.ID) y (hConciliacion:hConciliacion.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, hConciliacion:hConciliacion.ID, <T>CONC<T>)),  Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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

Expresion=Si<BR> (hConciliacion:hConciliacion.Estatus en (EstatusPendiente))<BR>Entonces<BR>  Asigna(Info.Modulo, <T>CONC<T>)<BR>  Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>  Asigna(Info.MovID, hConciliacion:hConciliacion.MovID)<BR>  Si(Forma(<T>GenerarMovFlujo<T>), Generar(<T>CONC<T>, hConciliacion:hConciliacion.ID, hConciliacion:hConciliacion.Mov, hConciliacion:hConciliacion.MovID, <T>Todo<T>, Info.MovGenerar, <T>hConciliacion<T>))<BR>Sino<BR>  Si<BR>    hConciliacion:hConciliacion.Estatus=EstatusSinAfectar<BR>  Entonces<BR>    Afectar(<T>CONC<T>, hConciliacion:hConciliacion.ID, hConciliacion:hConciliacion.Mov, hConciliacion:hConciliacion.MovID, <T>Todo<T>, <T><T>, <T>hConciliacion<T>)<BR>  Sino<BR>    Asigna(Afectar.Modulo, <T>CONC<T>)<BR>    Asigna(Afectar.Mov, hConciliacion:hConciliacion.Mov)<BR>    Asigna(Afectar.MovID, hConciliacion:Soporte.MovID) <BR>    Asigna(Afectar.ID, hConciliacion:hConciliacion.ID)<BR>    Asigna(Info.TituloDialogo, Capital:hConciliacion.Mov+<T> <T>+hConciliacion:hConciliacion.MovID)<BR>    Asigna(Info.Estado, hConciliacion:hConciliacion.Estado)<BR>    Dialogo(<T>AfectarConciliacion<T>)<BR>  Fin<BR>Fin<BR>Asigna(Temp.Personal, Nulo)<BR>Asigna(Temp.NominaConcepto, Nulo)<BR>Asigna(Temp.AcumuladoAnual, Nulo)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hConciliacion:hConciliacion.Usuario) y<BR>(hConciliacion:hConciliacion.Estatus en (EstatusSinAfectar, EstatusPendiente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>CONC<T>, hConciliacion:hConciliacion.Mov, hConciliacion:hConciliacion.Estatus, FormaSituacion, Usuario) y<BR>(hConciliacion:hConciliacion.Estatus=EstatusSinAfectar)
EjecucionCondicion=ConDatos(hConciliacion:hConciliacion.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (hConciliacion:hConciliacion.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CONC<T>, hConciliacion:hConciliacion.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CONC<T>, hConciliacion:hConciliacion.Mov, hConciliacion:hConciliacion.ID, Verdadero, hConciliacion:hConciliacion.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(hConciliacion:hConciliacion.MovID) y (hConciliacion:hConciliacion.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, hConciliacion:hConciliacion.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM hConciliacion WHERE ID=:nID<T>, hConciliacion:hConciliacion.ID))
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
ListaParametros1=hConciliacion:hConciliacion.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>CONC<T>, hConciliacion:hConciliacion.Mov, hConciliacion:hConciliacion.Estatus), hConciliacion:hConciliacion.ID)
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
ListaParametros1=hConciliacion:hConciliacion.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CONC<T>, hConciliacion:hConciliacion.Mov, hConciliacion:hConciliacion.Estatus), hConciliacion:hConciliacion.ID)
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
Expresion=Cancelar(<T>CONC<T>, hConciliacion:hConciliacion.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>hConciliacion<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, hConciliacion:hConciliacion.Usuario) y ConDatos(hConciliacion:hConciliacion.ID) y ConDatos(hConciliacion:hConciliacion.MovID) y<BR>((hConciliacion:hConciliacion.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPendiente)) o<BR>(hConciliacion:hConciliacion.Estatus=EstatusConcluido))
AntesExpresiones=Asigna(Afectar.Mov, hConciliacion:hConciliacion.Mov) <BR>Asigna(Afectar.MovID, hConciliacion:hConciliacion.MovID)<BR>Asigna(Temp.Personal, Nulo)<BR>Asigna(Temp.NominaConcepto, Nulo)<BR>Asigna(Temp.AcumuladoAnual, Nulo)

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
Expresion=Verificar(<T>CONC<T>, hConciliacion:hConciliacion.ID,hConciliacion:hConciliacion.Mov,hConciliacion:hConciliacion.MovID)
ActivoCondicion=hConciliacion:hConciliacion.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(hConciliacion:hConciliacion.Mov)

[Aplica.hConciliacion.MovAplica]
Carpeta=Aplica
Clave=hConciliacion.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.hConciliacion.MovAplicaID]
Carpeta=Aplica
Clave=hConciliacion.MovAplicaID
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
NombreDesplegar=Locali&zar...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Localizar
Activo=S
Visible=S

[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posici�n del Movimiento
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S
EspacioPrevio=S

Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(hConciliacion:hConciliacion.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.MovID, hConciliacion:hConciliacion.MovID)
[Aplica.hConciliacion.Agente]
Carpeta=Aplica
Clave=hConciliacion.Agente
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
NombreDesplegar=&Situaci�n
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S

GuardarAntes=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>CONC<T>, hConciliacion:hConciliacion.Mov, hConciliacion:hConciliacion.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>CONC<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>CONC<T>, hConciliacion:hConciliacion.Mov, hConciliacion:hConciliacion.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(hConciliacion:hConciliacion.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.Estatus, hConciliacion:hConciliacion.Estatus)<BR>Asigna(Info.Situacion, hConciliacion:hConciliacion.Situacion)
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
ActivoCondicion=ConfigModulo(<T>CONC<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(hConciliacion:hConciliacion.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.MovID, hConciliacion:hConciliacion.MovID)

[(Carpeta Abrir).hConciliacion.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=hConciliacion.FechaEmision
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
NombreDesplegar=&Presentaci�n preliminar
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

[(Carpeta Totalizadores).Retenci�n]
Carpeta=(Carpeta Totalizadores)
Clave=Retenci�n
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
Menu=&Edici�n
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
AntesExpresiones=Asigna(Info.Rama, <T>CONC<T>)<BR>Asigna(Info.Fecha, hConciliacion:hConciliacion.FechaEmision)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hConciliacion:hConciliacion.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, hConciliacion:hConciliacion.Mov+<T> <T>+hConciliacion:hConciliacion.MovID)
RefrescarDespues=S

[Acciones.Bitacora]
Nombre=Bitacora
Boton=56
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+B
NombreDesplegar=Bit�cora
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacora
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=Si(Vacio(hConciliacion:hConciliacion.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.MovID, hConciliacion:hConciliacion.MovID)<BR>Asigna(Info.PuedeEditar, hConciliacion:hConciliacion.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(hConciliacion:hConciliacion.Usuario))

[Acciones.AgregarEvento]
Nombre=AgregarEvento
Boton=56
Menu=&Edici�n
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
ActivoCondicion=hConciliacion:hConciliacion.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(hConciliacion:hConciliacion.Usuario)
EjecucionCondicion=Si(Vacio(hConciliacion:hConciliacion.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.MovID, hConciliacion:hConciliacion.MovID)

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
ActivoCondicion=ConDatos(hConciliacion:hConciliacion.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=May�s+F11
NombreDesplegar=&Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=CopiarMovimiento(<T>CONC<T>, hConciliacion:hConciliacion.ID, <T>Conciliacion<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (hConciliacion:hConciliacion.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(hConciliacion:hConciliacion.ID),GuardarCambios)
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
Tipo=63
Asunto=232
Socio=83
Titulo=86
Cantidad=59
Precio=101
Costo=103
PrecioTotal=104
CostoTotal=93
Folio=42
NominaConcepto=64
Concepto=164
Movimiento=116
Importe=131
Numero=43
0=49
1=92
Fecha=69
Referencia=86
Cargo=89
Abono=91
Observaciones=187
MovDinero=78
MovCont=68
TipoMovimiento=91
Poliza=79
Manual=40
ConceptoGasto=110
Acreedor=70
ObligacionFiscal=137

[Ficha.hConciliacion.UEN]
Carpeta=Ficha
Clave=hConciliacion.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edici�n
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
AntesExpresiones=Asigna(Info.PuedeEditar, hConciliacion:hConciliacion.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.MovID, hConciliacion:hConciliacion.MovID)<BR>Asigna(Info.Cliente, hConciliacion:hConciliacion.Cliente)<BR>Asigna(Info.Proveedor, hConciliacion:hConciliacion.Proveedor)<BR>Asigna(Info.Agente, hConciliacion:hConciliacion.Agente)<BR>Asigna(Info.Personal, hConciliacion:hConciliacion.Personal)<BR>Asigna(Info.Proyecto, hConciliacion:hConciliacion.Proyecto)<BR>Asigna(Info.UEN, hConciliacion:hConciliacion.UEN)<BR>Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Reporte, Nulo)

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
Expresion=Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.Clave, <T>CONC<T>+hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Nombre, hConciliacion:hConciliacion.Mov+<T> <T>+hConciliacion:hConciliacion.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(hConciliacion:hConciliacion.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Acciones.MovPersonal]
Nombre=MovPersonal
Boton=0
Menu=&Archivo
NombreDesplegar=Personal Involucrado
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPersonal
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S

AntesExpresiones=Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.MovID, hConciliacion:hConciliacion.MovID)<BR>Asigna(Info.Fecha, hConciliacion:hConciliacion.FechaEmision)<BR>Asigna(Info.Estatus, hConciliacion:hConciliacion.Estatus)
[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+O
NombreDesplegar=P&ol�tica Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(hConciliacion:hConciliacion.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CONC<T>)<BR>Asigna(Info.Clave, hConciliacion:hConciliacion.Mov)

[Acciones.PoliticaConcepto]
Nombre=PoliticaConcepto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+N
NombreDesplegar=Pol�tica Concepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(hConciliacion:hConciliacion.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.Concepto, hConciliacion:hConciliacion.Concepto)
[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=hConciliacionD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=hConciliacion
LlaveLocal=hConciliacionD.ID
LlaveMaestra=hConciliacion.ID
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=hConciliacionD.Fecha<TAB>(Acendente)
MenuLocal=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Autom�tica
PermiteEditar=S
HojaAjustarColumnas=S
ValidarCampos=S
ListaCamposAValidar=hConciliacionD.Observaciones
HojaPermiteInsertar=S
HojaPermiteEliminar=S
PermiteLocalizar=S
Filtros=S
FiltroPredefinido1=Movimientos Banco<BR>Pendientes Banco<BR>Pendientes Empresa
FiltroPredefinido2=hConciliacionD.Seccion=0<BR>hConciliacionD.Seccion=1<BR>hConciliacionD.Seccion=2
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Directorio
FiltroRespetar=S
FiltroTipo=Predefinido
FiltroPredefinido3=RID<BR>RID<BR>RID

[Ficha.hConciliacion.Observaciones]
Carpeta=Ficha
Clave=hConciliacion.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=88
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hConciliacion.Moneda]
Carpeta=Ficha
Clave=hConciliacion.Moneda
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hConciliacion.TipoCambio]
Carpeta=Ficha
Clave=hConciliacion.TipoCambio
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

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
Expresion=Asigna(Info.Forma, <T>hConciliacion<T>)<BR>Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.Nombre, hConciliacion:hConciliacion.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=0
Menu=&Edici�n
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
RefrescarDespues=S
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CONC<T>, hConciliacion:hConciliacion.Mov, hConciliacion:hConciliacion.ID, Falso, hConciliacion:hConciliacion.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CONC<T>+hConciliacion:hConciliacion.ID)<BR>  Asigna(Info.Nombre, hConciliacion:hConciliacion.Mov+<T> <T>+hConciliacion:hConciliacion.MovID)<BR>  Asigna(Info.Modulo, <T>CONC<T>)<BR>  Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      hConciliacion:hConciliacion.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[(Carpeta Totalizadores).Cantidad Total]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

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
AntesExpresiones=Asigna(Info.Modulo, <T>CONC<T>)<BR>Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.MovID, hConciliacion:hConciliacion.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (hConciliacion:hConciliacion.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=hConciliacion:hConciliacion.Estatus en (EstatusPendiente, EstatusConcluido, EstatusCancelado)

[(Carpeta Abrir).hConciliacion.FechaD]
Carpeta=(Carpeta Abrir)
Clave=hConciliacion.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).hConciliacion.FechaA]
Carpeta=(Carpeta Abrir)
Clave=hConciliacion.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).hConciliacion.CtaDinero]
Carpeta=(Carpeta Abrir)
Clave=hConciliacion.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.hConciliacionD.Fecha]
Carpeta=Detalle
Clave=hConciliacionD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hConciliacionD.Concepto]
Carpeta=Detalle
Clave=hConciliacionD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Detalle.hConciliacionD.Referencia]
Carpeta=Detalle
Clave=hConciliacionD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hConciliacionD.Cargo]
Carpeta=Detalle
Clave=hConciliacionD.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hConciliacionD.Abono]
Carpeta=Detalle
Clave=hConciliacionD.Abono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Totalizadores1=Cargos<BR>Abonos<BR>Conteo
Totalizadores3=(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Totalizadores2=Suma(hConciliacionD:hConciliacionD.Cargo)<BR>Suma(hConciliacionD:hConciliacionD.Abono)<BR>Conteo(hConciliacionD:hConciliacionD.Fecha)

[(Carpeta Totalizadores).Cargos]
Carpeta=(Carpeta Totalizadores)
Clave=Cargos
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Abonos]
Carpeta=(Carpeta Totalizadores)
Clave=Abonos
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
3D=S
Pegado=S
Tamano=4
ColorFondo=Plata
ColorFuente=Negro

[Ficha.hConciliacion.FechaD]
Carpeta=Ficha
Clave=hConciliacion.FechaD
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.hConciliacion.FechaA]
Carpeta=Ficha
Clave=hConciliacion.FechaA
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
Pegado=S

[Ficha.hConciliacion.CtaDinero]
Carpeta=Ficha
Clave=hConciliacion.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.CtaDinero.Descripcion]
Carpeta=Ficha
Clave=CtaDinero.Descripcion
Editar=S
3D=S
Tamano=46
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CtaDinero.Institucion]
Carpeta=Ficha
Clave=CtaDinero.Institucion
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Abrir).CtaDinero.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=CtaDinero.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Conciliar]
Nombre=Conciliar
Boton=92
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=Conciliar
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=F8
EspacioPrevio=S

Expresion=EjecutarSQL(<T>spConciliacionCalc :niD<T>, hConciliacion:hConciliacion.ID)
ActivoCondicion=hConciliacion:hConciliacion.Estatus=EstatusSinAfectar
[Acciones.Importar]
Nombre=Importar
Boton=96
NombreDesplegar=Importar...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Otros
Visible=S
EspacioPrevio=S
NombreEnBoton=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F7
ClaveAccion=Procesar Lista
ListaParametros=S
ListaParametros1=<T>Importar Archivo Conciliaci�n<T><BR><T>ListaSt<T><BR><T>Estacion<T><BR><T>ID<T><BR><T>spConciliacionImportar<T><BR>EstacionTrabajo & <T>, <T> & hConciliacion:hConciliacion.ID<BR>Falso
GuardarAntes=S
RefrescarDespues=S

ActivoCondicion=hConciliacion:hConciliacion.Estatus=EstatusSinAfectar
[Detalle.Movimiento]
Carpeta=Detalle
Clave=Movimiento
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Poliza]
Carpeta=Detalle
Clave=Poliza
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Detalle.hConciliacionD.TipoMovimiento]
Carpeta=Detalle
Clave=hConciliacionD.TipoMovimiento
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.hConciliacionD.Manual]
Carpeta=Detalle
Clave=hConciliacionD.Manual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ConciliarManual]
Nombre=ConciliarManual
Boton=0
Menu=&Archivo
NombreDesplegar=Conciliar &Manualmente
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Refrescar Controles
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+M
ActivoCondicion=hConciliacion:hConciliacion.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.ConciliarManual, no Info.ConciliarManual)<BR>Asigna(Info.CtaDinero, hConciliacion:hConciliacion.CtaDinero)

[Detalle.hConciliacionD.ConceptoGasto]
Carpeta=Detalle
Clave=hConciliacionD.ConceptoGasto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Detalle.hConciliacionD.Acreedor]
Carpeta=Detalle
Clave=hConciliacionD.Acreedor
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Acciones.Conceptos]
Nombre=Conceptos
Boton=0
Menu=&Edici�n
NombreDesplegar=Conceptos (Conciliaci�n)
EnMenu=S
TipoAccion=Formas
ClaveAccion=InstitucionFinConcepto
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(hConciliacion:CtaDinero.Institucion)
AntesExpresiones=Asigna(Info.Cuenta, hConciliacion:CtaDinero.Institucion)

[Acciones.CtaDineroInfo]
Nombre=CtaDineroInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Informaci�n de la Cuenta
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaDineroInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(hConciliacion:hConciliacion.CtaDinero)
AntesExpresiones=Asigna(Info.CtaDinero, hConciliacion:hConciliacion.CtaDinero)

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Caracter�sticas
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
HojaVistaOmision=Autom�tica
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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CONC<T>, <T>{hConciliacion:hConciliacion.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CONC{hConciliacion:hConciliacion.ID}<T>

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

[Acciones.SeleccionarMovs]
Nombre=SeleccionarMovs
Boton=55
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Seleccionar Movimientos
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S

Expresion=Asigna(Info.CtaDinero, hConciliacion:hConciliacion.CtaDinero)<BR>Si<BR>  Forma(<T>hConciliacionLista<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spConciliacionListaAceptar :nID, :nSucursal, :nEstacion<T>, hConciliacion:hConciliacion.ID, Sucursal, EstacionTrabajo) <BR>Fin
ActivoCondicion=hConciliacion:hConciliacion.Estatus=EstatusSinAfectar
[Detalle.hConciliacionD.ObligacionFiscal]
Carpeta=Detalle
Clave=hConciliacionD.ObligacionFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Acciones.EditarPendientesEmpresa]
Nombre=EditarPendientesEmpresa
Boton=0
Menu=&Edici�n
NombreDesplegar=Editar Conceptos Pendientes Empresa
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S

Expresion=Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.Mov, hConciliacion:hConciliacion.Mov)<BR>Asigna(Info.MovID, hConciliacion:hConciliacion.MovID)<BR>Asigna(Info.Cuenta, hConciliacion:CtaDinero.Institucion)<BR>Si<BR>  Forma(<T>ConciliacionPendientesEmpresa<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spConciliacionPendientesEmpresaAceptar :nID<T>, Info.ID)<BR>  Forma.ActualizarForma<BR>Fin
VisibleCondicion=hConciliacion:hConciliacion.Estatus=EstatusConcluido
[Ficha.hConciliacion.SaldoBanco]
Carpeta=Ficha
Clave=hConciliacion.SaldoBanco
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hConciliacion.SaldoLibros]
Carpeta=Ficha
Clave=hConciliacion.SaldoLibros
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.hConciliacion.SaldoConciliado]
Carpeta=Ficha
Clave=hConciliacion.SaldoConciliado
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[DesgloseImpuestos.Columnas]
Impuesto1=64
Impuesto2=64
Impuesto3=72
Importe1=64
Importe2=64
Importe3=64
Retencion1=64
Retencion2=64
Retencion3=64
ContUso=124
ContUso2=124
ContUso3=124

[Acciones.PersonalizarVista]
Nombre=PersonalizarVista
Boton=0
NombreDesplegar=Personalizar vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[MovImpuesto]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Arrastre
Clave=MovImpuesto
Filtros=S
Detalle=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovImpuestoMov
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=hConciliacion
LlaveLocal=MovImpuestoMov.ModuloID
LlaveMaestra=hConciliacion.ID
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Origen<T>
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
ListaAcciones=PersonalizarVista
IconosNombre=MovImpuestoMov:Mov.Mov & <T> <T> & MovImpuestoMov:Mov.MovID
FiltroGeneral=MovImpuestoMov.Modulo = <T>CONC<T>
CondicionVisible=(hConciliacion:hConciliacion.Estatus = EstatusConcluido) o (hConciliacion:hConciliacion.Estatus = EstatusCancelado)

[MovImpuesto.MovImpuestoMov.Impuesto1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Impuesto2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Impuesto3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Importe1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Importe2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Importe3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Retencion1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Retencion2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Retencion3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.ContUso]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.ContUso2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.ContUso3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.Columnas]
0=-2
1=-2

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
[Lista.Columnas]
0=143
1=82

2=-2
3=-2
4=-2
[Acciones.Compensacion]
Nombre=Compensacion
Boton=95
Menu=&Archivo
NombreDesplegar=Compensaci�n Manual
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConciliacionCompensacion
Activo=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Shift+F8




AntesExpresiones=Asigna(Info.ID, hConciliacion:hConciliacion.ID)<BR>Asigna(Info.CtaDinero, hConciliacion:hConciliacion.CtaDinero)<BR>Asigna(Info.Redondeo, Config.ConcToleranciaDec)<BR>Asigna(Info.PuedeEditar, hConciliacion:hConciliacion.Estatus=EstatusSinAfectar)
[Ficha.ListaEnCaptura]
(Inicio)=hConciliacion.Mov
hConciliacion.Mov=hConciliacion.MovID
hConciliacion.MovID=hConciliacion.Proyecto
hConciliacion.Proyecto=hConciliacion.UEN
hConciliacion.UEN=hConciliacion.Moneda
hConciliacion.Moneda=hConciliacion.TipoCambio
hConciliacion.TipoCambio=hConciliacion.FechaEmision
hConciliacion.FechaEmision=hConciliacion.FechaD
hConciliacion.FechaD=hConciliacion.FechaA
hConciliacion.FechaA=hConciliacion.CtaDinero
hConciliacion.CtaDinero=CtaDinero.Descripcion
CtaDinero.Descripcion=CtaDinero.Institucion
CtaDinero.Institucion=hConciliacion.SaldoBanco
hConciliacion.SaldoBanco=hConciliacion.SaldoLibros
hConciliacion.SaldoLibros=hConciliacion.SaldoConciliado
hConciliacion.SaldoConciliado=hConciliacion.Observaciones
hConciliacion.Observaciones=(Fin)




[Detalle.ListaEnCaptura]
(Inicio)=hConciliacionD.Fecha
hConciliacionD.Fecha=hConciliacionD.Concepto
hConciliacionD.Concepto=hConciliacionD.Referencia
hConciliacionD.Referencia=hConciliacionD.Cargo
hConciliacionD.Cargo=hConciliacionD.Abono
hConciliacionD.Abono=hConciliacionD.Manual
hConciliacionD.Manual=hConciliacionD.TipoMovimiento
hConciliacionD.TipoMovimiento=Movimiento
Movimiento=Poliza
Poliza=hConciliacionD.ConceptoGasto
hConciliacionD.ConceptoGasto=hConciliacionD.Acreedor
hConciliacionD.Acreedor=hConciliacionD.ObligacionFiscal
hConciliacionD.ObligacionFiscal=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Cargos
Cargos=Abonos
Abonos=Conteo
Conteo=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)

[MovImpuesto.ListaEnCaptura]
(Inicio)=MovImpuestoMov.Impuesto1
MovImpuestoMov.Impuesto1=MovImpuestoMov.Impuesto2
MovImpuestoMov.Impuesto2=MovImpuestoMov.Impuesto3
MovImpuestoMov.Impuesto3=MovImpuestoMov.Importe1
MovImpuestoMov.Importe1=MovImpuestoMov.Importe2
MovImpuestoMov.Importe2=MovImpuestoMov.Importe3
MovImpuestoMov.Importe3=MovImpuestoMov.Retencion1
MovImpuestoMov.Retencion1=MovImpuestoMov.Retencion2
MovImpuestoMov.Retencion2=MovImpuestoMov.Retencion3
MovImpuestoMov.Retencion3=MovImpuestoMov.ContUso
MovImpuestoMov.ContUso=MovImpuestoMov.ContUso2
MovImpuestoMov.ContUso2=MovImpuestoMov.ContUso3
MovImpuestoMov.ContUso3=(Fin)

















































[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S






















[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=hConciliacion.FechaEmision
hConciliacion.FechaEmision=hConciliacion.CtaDinero
hConciliacion.CtaDinero=CtaDinero.Descripcion
CtaDinero.Descripcion=hConciliacion.FechaD
hConciliacion.FechaD=hConciliacion.FechaA
hConciliacion.FechaA=(Fin)

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
FormaExtraValor=MovImpuesto
MovImpuesto=(Fin)

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
Excel=Importar
Importar=SeleccionarMovs
SeleccionarMovs=ConciliarManual
ConciliarManual=Conciliar
Conciliar=Compensacion
Compensacion=Verificar
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
AgregarEvento=Conceptos
Conceptos=EditarPendientesEmpresa
EditarPendientesEmpresa=Anterior
Anterior=Siguiente
Siguiente=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=Bitacora
Bitacora=CtaDineroInfo
CtaDineroInfo=MovPos
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
&Archivo=&Edici�n
&Edici�n=&Ver
&Ver=&Otros
&Otros=(Fin)
