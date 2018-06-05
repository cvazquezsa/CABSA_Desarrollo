[Forma]
Clave=Recluta
Nombre=<T>Reclutamiento y Selección<T>
Icono=0
Modulos=RE
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=276
PosicionInicialArriba=82
PosicionInicialAltura=558
PosicionInicialAncho=751
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
MovModulo=RE
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
TituloAutoNombre=S
PosicionInicialAlturaCliente=574
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.Aplica, Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Proveedor, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
Totalizadores=S
PosicionSec1=208
PosicionSec2=468

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Recluta
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

[Ficha.Recluta.Mov]
Carpeta=Ficha
Clave=Recluta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Recluta.MovID]
Carpeta=Ficha
Clave=Recluta.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.Recluta.FechaEmision]
Carpeta=Ficha
Clave=Recluta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Recluta.Proyecto]
Carpeta=Ficha
Clave=Recluta.Proyecto
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
Vista=ReclutaA
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
ListaOrden=Recluta.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Recluta.FechaEmision
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
FiltroFechasCancelacion=Recluta.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S

IconosNombre=ReclutaA:Recluta.Mov+<T> <T>+ReclutaA:Recluta.MovID
FiltroUsuarios=S
[(Carpeta Abrir).Columnas]
0=136
1=72

2=165
3=120
4=49
5=68
6=101
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Recluta:Recluta.ID) y (Recluta:Recluta.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Recluta:Recluta.ID, <T>RE<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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

Expresion=Asigna(Afectar.Modulo, <T>RE<T>)<BR>Asigna(Afectar.ID, Recluta:Recluta.ID)<BR>Asigna(Afectar.Mov, Recluta:Recluta.Mov)<BR>Asigna(Afectar.MovID, Recluta:Recluta.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>Recluta<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.MovID, Recluta:Recluta.MovID)<BR>Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>Asigna(Info.MovTipo, MovTipo(Afectar.Modulo, Recluta:Recluta.Mov))<BR>Asigna(Info.Estatus, SQL(<T>SELECT MIN(p.Estatus) FROM ReclutaPlaza rp JOIN Plaza p ON p.Plaza = rp.Plaza WHERE rp.ID=:nID AND p.Estatus LIKE :tEstatus<T>, Info.ID, EstatusPorAutorizarE))<BR>Si<BR>  Recluta:Recluta.Estatus=EstatusPendiente<BR>Entonces<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si<BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Dialogo(<T>GenerarRecluta<T>)<BR>  Fin<BR>Sino<BR>  Afectar(Afectar.Modulo, Recluta:Recluta.ID, Recluta:Recluta.Mov, Recluta:Recluta.MovID, <T>Todo<T>, <T><T>, Afectar.FormaCaptura)<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Recluta:Recluta.Usuario) y<BR>((Recluta:Recluta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) o<BR>((Recluta:Recluta.Estatus=EstatusPendiente) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>RE<T>, Recluta:Recluta.Mov, Recluta:Recluta.Estatus, FormaSituacion, Usuario)))
EjecucionCondicion=ConDatos(Recluta:Recluta.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Recluta:Recluta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>RE<T>, Recluta:Recluta.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>RE<T>, Recluta:Recluta.Mov, Recluta:Recluta.ID, Verdadero, Recluta:Recluta.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Recluta:Recluta.MovID) y (Recluta:Recluta.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Recluta:Recluta.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Recluta WHERE ID=:nID<T>, Recluta:Recluta.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Recluta:Recluta.ID
Visible=S

Expresion=ReportePantalla(ReporteMovPantalla(<T>RE<T>, Recluta:Recluta.Mov, Recluta:Recluta.Estatus), Recluta:Recluta.ID)
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
ListaParametros1=Recluta:Recluta.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>RE<T>, Recluta:Recluta.Mov, Recluta:Recluta.Estatus), Recluta:Recluta.ID)
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
Expresion=Cancelar(<T>RE<T>, Recluta:Recluta.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Recluta<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Recluta:Recluta.Usuario) y ConDatos(Recluta:Recluta.ID) y ConDatos(Recluta:Recluta.MovID) y<BR>((Recluta:Recluta.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPendiente)) o<BR>(Recluta:Recluta.Estatus=EstatusConcluido))
AntesExpresiones=Asigna( Afectar.Mov, Recluta:Recluta.Mov ) <BR> Asigna( Afectar.MovID, Recluta:Recluta.MovID )

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
Expresion=Verificar(<T>RE<T>, Recluta:Recluta.ID,Recluta:Recluta.Mov,Recluta:Recluta.MovID)
ActivoCondicion=Recluta:Recluta.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Recluta:Recluta.Mov)
[Aplica.Recluta.MovAplica]
Carpeta=Aplica
Clave=Recluta.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Recluta.MovAplicaID]
Carpeta=Aplica
Clave=Recluta.MovAplicaID
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
ActivoCondicion=ConDatos(Recluta:Recluta.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.MovID, Recluta:Recluta.MovID)
[Aplica.Recluta.Agente]
Carpeta=Aplica
Clave=Recluta.Agente
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>RE<T>, Recluta:Recluta.Mov, Recluta:Recluta.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>RE<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>RE<T>, Recluta:Recluta.Mov, Recluta:Recluta.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Recluta:Recluta.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.Estatus, Recluta:Recluta.Estatus)<BR>Asigna(Info.Situacion, Recluta:Recluta.Situacion)
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
ActivoCondicion=ConfigModulo(<T>RE<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Recluta:Recluta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.MovID, Recluta:Recluta.MovID)


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
AntesExpresiones=Asigna(Info.Rama, <T>RE<T>)<BR>Asigna(Info.Fecha, Recluta:Recluta.FechaEmision)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Recluta:Recluta.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Recluta:Recluta.Mov+<T> <T>+Recluta:Recluta.MovID)

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
EjecucionCondicion=Si(Vacio(Recluta:Recluta.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.MovID, Recluta:Recluta.MovID)<BR>Asigna(Info.PuedeEditar, Recluta:Recluta.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Recluta:Recluta.Usuario))

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
ActivoCondicion=Recluta:Recluta.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Recluta:Recluta.Usuario)
EjecucionCondicion=Si(Vacio(Recluta:Recluta.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.MovID, Recluta:Recluta.MovID)

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
ActivoCondicion=ConDatos(Recluta:Recluta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)

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
Expresion=CopiarMovimiento(<T>RE<T>, Recluta:Recluta.ID, <T>Recluta<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Recluta:Recluta.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Recluta:Recluta.ID),GuardarCambios)
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
Competencia=88
Opcion=179
Valor=55
Ponderacion=64
Observaciones=201
Peso=45
Resultado=79
ValorMinimo=64
Nombre=166
[Ficha.Recluta.UEN]
Carpeta=Ficha
Clave=Recluta.UEN
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

AntesExpresiones=Asigna(Info.PuedeEditar, Recluta:Recluta.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.MovID, Recluta:Recluta.MovID)<BR>Asigna(Info.Personal, Recluta:Recluta.Personal)<BR>Asigna(Info.Proyecto, Recluta:Recluta.Proyecto)<BR>Asigna(Info.UEN, Recluta:Recluta.UEN)<BR>Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Reporte, Nulo)
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
Expresion=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.Clave, <T>RE<T>+Recluta:Recluta.ID)<BR>Asigna(Info.Nombre, Recluta:Recluta.Mov+<T> <T>+Recluta:Recluta.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Recluta:Recluta.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.MovID, Recluta:Recluta.MovID)<BR>Asigna(Info.Fecha, Recluta:Recluta.FechaEmision)<BR>Asigna(Info.Estatus, Recluta:Recluta.Estatus)

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
EjecucionCondicion=ConDatos(Recluta:Recluta.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>RE<T>)<BR>Asigna(Info.Clave, Recluta:Recluta.Mov)

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
EjecucionCondicion=ConDatos(Recluta:Recluta.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.Concepto, Recluta:Recluta.Concepto)


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
Vista=ReclutaD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Recluta
LlaveLocal=ReclutaD.ID
LlaveMaestra=Recluta.ID
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
CampoRenglon=ReclutaD.Renglon
HojaFondoGrisAuto=S

Filtros=S
FiltroAplicaEn=Competencia.Tipo
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CompetenciaTipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Directorio
FiltroRespetar=S
FiltroTipo=Automático
[Ficha.Recluta.Concepto]
Carpeta=Ficha
Clave=Recluta.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Recluta.Referencia]
Carpeta=Ficha
Clave=Recluta.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Recluta.Observaciones]
Carpeta=Ficha
Clave=Recluta.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=88
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
Totalizadores1=Peso parcial<BR>Calificación parcial
Totalizadores2=Suma(ReclutaD:ReclutaD.Peso)<BR>Suma(ReclutaD:Calificacion)
Totalizadores3=0.00%<BR>#.##
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
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
Expresion=Asigna(Info.Forma, <T>Recluta<T>)<BR>Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.Nombre, Recluta:Recluta.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>RE<T>, Recluta:Recluta.Mov, Recluta:Recluta.ID, Falso, Recluta:Recluta.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>RE<T>+Recluta:Recluta.ID)<BR>  Asigna(Info.Nombre, Recluta:Recluta.Mov+<T> <T>+Recluta:Recluta.MovID)<BR>  Asigna(Info.Modulo, <T>RE<T>)<BR>  Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Recluta:Recluta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.MovID, Recluta:Recluta.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (Recluta:Recluta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>RE<T>, <T>{Recluta:Recluta.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>RE{Recluta:Recluta.ID}<T>

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








[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)










[Detalle.ReclutaD.Competencia]
Carpeta=Detalle
Clave=ReclutaD.Competencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Detalle.ReclutaD.Valor]
Carpeta=Detalle
Clave=ReclutaD.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Detalle.ReclutaD.Observaciones]
Carpeta=Detalle
Clave=ReclutaD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco













[Ficha.Recluta.Personal]
Carpeta=Ficha
Clave=Recluta.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.NombreCompleto]
Carpeta=Ficha
Clave=NombreCompleto
Editar=S
3D=S
Tamano=56
ColorFondo=Plata

[Ficha.Recluta.Puesto]
Carpeta=Ficha
Clave=Recluta.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco





Pegado=N
[Lista.Columnas]
0=113
1=284
2=62
3=186





















4=113
5=94
6=73
[(Carpeta Abrir).Recluta.Personal]
Carpeta=(Carpeta Abrir)
Clave=Recluta.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).NombreCompleto]
Carpeta=(Carpeta Abrir)
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[(Carpeta Abrir).Recluta.Puesto]
Carpeta=(Carpeta Abrir)
Clave=Recluta.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco












[Detalle.ReclutaD.Peso]
Carpeta=Detalle
Clave=ReclutaD.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

















[Acciones.PersonalExpress]
Nombre=PersonalExpress
Boton=60
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=Personal Express...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S






















Expresion=Si<BR>  Forma(<T>PersonalExpress<T>)<BR>Entonces<BR>  Asigna(Recluta:Recluta.Personal, Info.Personal)<BR>Fin
ActivoCondicion=Recluta:Recluta.Estatus=EstatusSinAfectar
[Acciones.SugerirCompetencias]
Nombre=SugerirCompetencias
Boton=20
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F8
NombreDesplegar=&Sugerir Competencias
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S












































































RefrescarDespues=S

Expresion=EjecutarSQL( <T>spReclutaCompetenciaSugerir :nID<T>, Recluta:Recluta.ID)
ActivoCondicion=Recluta:Recluta.Estatus=EstatusSinAfectar
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
Vista=Recluta
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
ListaEnCaptura=Recluta.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S

[Comentarios.Recluta.Comentarios]
Carpeta=Comentarios
Clave=Recluta.Comentarios
Editar=S
LineaNueva=S
3D=S
Tamano=100x3
ColorFondo=Blanco







































[Ficha.OrigenNombre]
Carpeta=Ficha
Clave=OrigenNombre
Editar=S
3D=S
Tamano=30
ColorFondo=Plata

Efectos=[Negritas]





ValidaNombre=S




[(Carpeta Abrir).Calificacion]
Carpeta=(Carpeta Abrir)
Clave=Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













Totalizador=2







[Detalle.ReclutaD.Resultado]
Carpeta=Detalle
Clave=ReclutaD.Resultado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

































[Detalle.ReclutaD.ValorMinimo]
Carpeta=Detalle
Clave=ReclutaD.ValorMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













[(Carpeta Abrir).Califica]
Carpeta=(Carpeta Abrir)
Clave=Califica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco































[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Calificación parcial
Calificación parcial=Peso parcial
Peso parcial=(Fin)

[(Carpeta Totalizadores).Calificación parcial]
Carpeta=(Carpeta Totalizadores)
Clave=Calificación parcial
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
Efectos=[Negritas]

[(Carpeta Totalizadores).Peso parcial]
Carpeta=(Carpeta Totalizadores)
Clave=Peso parcial
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]























[Plazas]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Plazas
Clave=Plazas
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ReclutaPlaza
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Recluta
LlaveLocal=ReclutaPlaza.ID
LlaveMaestra=Recluta.ID
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


CondicionVisible=MovTipoEn(<T>RE<T>, Recluta:Recluta.Mov, (RE.SCO, RE.AP, RE.RCO, RE.CO))
[Plazas.ReclutaPlaza.Plaza]
Carpeta=Plazas
Clave=ReclutaPlaza.Plaza
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

Editar=S
[Plazas.Plaza.Descripcion]
Carpeta=Plazas
Clave=Plaza.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Plazas.Plaza.Tipo]
Carpeta=Plazas
Clave=Plaza.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Plazas.Plaza.Puesto]
Carpeta=Plazas
Clave=Plaza.Puesto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris


[Plazas.Columnas]
Plaza=113
Descripcion=155
Tipo=63
Puesto=144
Estatus=90




PlazaEstatusNombre=64

Completado=64
EstaPendiente=76
[Plazas.PlazaEstatusNombre]
Carpeta=Plazas
Clave=PlazaEstatusNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris




















[Plazas.ReclutaPlaza.EstaPendiente]
Carpeta=Plazas
Clave=ReclutaPlaza.EstaPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[(Carpeta Abrir).PlazasPendientes]
Carpeta=(Carpeta Abrir)
Clave=PlazasPendientes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




Totalizador=1






[Lista.ListaEnCaptura]
(Inicio)=ReclutaCompetenciaTipo.Tipo
ReclutaCompetenciaTipo.Tipo=ReclutaCompetenciaTipo.Peso
ReclutaCompetenciaTipo.Peso=(Fin)







[TiposCompetencias.ListaEnCaptura]
(Inicio)=ReclutaCompetenciaTipo.Tipo
ReclutaCompetenciaTipo.Tipo=ReclutaCompetenciaTipo.Peso
ReclutaCompetenciaTipo.Peso=(Fin)







[TiposCompetencias.Columnas]
Tipo=304
Peso=64

[PesoTipo]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Peso por Tipo
Clave=PesoTipo
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ReclutaCompetenciaTipo
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Recluta
LlaveLocal=ReclutaCompetenciaTipo.ID
LlaveMaestra=Recluta.ID
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

CondicionVisible=MovTipoEn(<T>RE<T>, Recluta:Recluta.Mov, (RE.SCO))
[PesoTipo.ListaEnCaptura]
(Inicio)=ReclutaCompetenciaTipo.Tipo
ReclutaCompetenciaTipo.Tipo=ReclutaCompetenciaTipo.Peso
ReclutaCompetenciaTipo.Peso=(Fin)

[PesoTipo.ReclutaCompetenciaTipo.Tipo]
Carpeta=PesoTipo
Clave=ReclutaCompetenciaTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[PesoTipo.ReclutaCompetenciaTipo.Peso]
Carpeta=PesoTipo
Clave=ReclutaCompetenciaTipo.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[PesoTipo.Columnas]
Tipo=304
Peso=64



















[Ficha.ListaEnCaptura]
(Inicio)=Recluta.Mov
Recluta.Mov=Recluta.MovID
Recluta.MovID=Recluta.Proyecto
Recluta.Proyecto=Recluta.UEN
Recluta.UEN=Recluta.Prioridad
Recluta.Prioridad=Recluta.FechaEmision
Recluta.FechaEmision=OrigenNombre
OrigenNombre=Recluta.Concepto
Recluta.Concepto=Recluta.Referencia
Recluta.Referencia=Recluta.Observaciones
Recluta.Observaciones=Recluta.Personal
Recluta.Personal=NombreCompleto
NombreCompleto=Recluta.Puesto
Recluta.Puesto=(Fin)

[Ficha.Recluta.Prioridad]
Carpeta=Ficha
Clave=Recluta.Prioridad
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco










[Acciones.Devolver]
Nombre=Devolver
Boton=79
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=<T>&Devolver<T>
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S







UsaTeclaRapida=S
TeclaRapida=Ctrl+D






EspacioPrevio=S
Expresion=ProcesarSQL(<T>spAfectarTraficoRecluta :nSucursal, :nID, :tAccion<T>, Sucursal, Recluta:Recluta.ID, <T>DEVOLVER<T>)
ActivoCondicion=Recluta:Recluta.Estatus en (EstatusSinAfectar, EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y<BR>PuedeModificar(Recluta:Recluta.Usuario) y Recluta:Recluta.PuedeDevolver
[Acciones.Transferir]
Nombre=Transferir
Boton=81
NombreEnBoton=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
NombreDesplegar=<T>Trans&ferir<T>
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ReclutaTransferir
Antes=S
Visible=S






















ActivoCondicion=Recluta:Recluta.Estatus en (EstatusSinAfectar, EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y<BR>PuedeModificar(Recluta:Recluta.Usuario)
AntesExpresiones=Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Mov, Recluta:Recluta.Mov)<BR>Asigna(Info.MovID, Recluta:Recluta.MovID)
[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Recluta.Personal
Recluta.Personal=NombreCompleto
NombreCompleto=Recluta.Puesto
Recluta.Puesto=Califica
Califica=Calificacion
Calificacion=PlazasPendientes
PlazasPendientes=(Fin)

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




























[Acciones.Prioridad]
Nombre=Prioridad
Boton=22
Menu=&Archivo
NombreDesplegar=Cambiar Prioridad...
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
TipoAccion=Dialogos
ClaveAccion=AfectarReclutaPrioridad
Antes=S
Visible=S



















ActivoCondicion=Recluta:Recluta.Estatus en (EstatusPendiente, EstatusAltaPrioridad, EstatusPrioridadBaja) y PuedeModificar(Recluta:Recluta.Usuario)
AntesExpresiones=Asigna(Info.ID, Recluta:Recluta.ID)<BR>Asigna(Info.Prioridad, Recluta:Recluta.Prioridad)









[Acciones.ColaUsuario]
Nombre=ColaUsuario
Boton=0
Menu=&Ver
NombreDesplegar=Cola de &Usuarios
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovUsuario
ActivoCondicion=(Recluta:Recluta.Estatus<>EstatusSinAfectar) y Recluta:Recluta.PuedeDevolver
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>RE<T>)<BR>Asigna(Info.ID, Recluta:Recluta.ID)
Visible=S




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
FiltroGeneral=MovBitacora.Modulo=<T>RE<T> AND MovBitacora.ID={Recluta:Recluta.ID}
CarpetaVisible=S
[Bitacora.MovBitacora.Evento]
Carpeta=Bitacora
Clave=MovBitacora.Evento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Bitacora.MovBitacora.Fecha]
Carpeta=Bitacora
Clave=MovBitacora.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Bitacora.MovBitacora.Usuario]
Carpeta=Bitacora
Clave=MovBitacora.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Bitacora.MovBitacora.Duracion]
Carpeta=Bitacora
Clave=MovBitacora.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Bitacora.MovBitacora.DuracionUnidad]
Carpeta=Bitacora
Clave=MovBitacora.DuracionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Bitacora.Columnas]
0=129
1=81
2=259
3=116
4=62
5=64

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






[Detalle.ListaCamposAValidar]
(Inicio)=Competencia.Nombre
Competencia.Nombre=Competencia.Tipo
Competencia.Tipo=(Fin)


























































[SueldoRango]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Rango Sueldo
Clave=SueldoRango
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Recluta
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


CondicionVisible=MovTipoEn(<T>RE<T>, Recluta:Recluta.Mov, (RE.SCO))
[SueldoRango.Recluta.SueldoD]
Carpeta=SueldoRango
Clave=Recluta.SueldoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SueldoRango.Recluta.SueldoA]
Carpeta=SueldoRango
Clave=Recluta.SueldoA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[SueldoRango.ListaEnCaptura]
(Inicio)=Recluta.SueldoD
Recluta.SueldoD=Recluta.SueldoA
Recluta.SueldoA=(Fin)




[Sueldo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Sueldo
Clave=Sueldo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Recluta
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


CondicionVisible=MovTipoEn(<T>RE<T>, Recluta:Recluta.Mov, (RE.ECO, RE.CO))
[Sueldo.Recluta.SueldoActual]
Carpeta=Sueldo
Clave=Recluta.SueldoActual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Sueldo.Recluta.SueldoMinimo]
Carpeta=Sueldo
Clave=Recluta.SueldoMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Sueldo.Recluta.SueldoAspira]
Carpeta=Sueldo
Clave=Recluta.SueldoAspira
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Plazas.ListaEnCaptura]
(Inicio)=ReclutaPlaza.Plaza
ReclutaPlaza.Plaza=Plaza.Descripcion
Plaza.Descripcion=Plaza.Tipo
Plaza.Tipo=Plaza.Puesto
Plaza.Puesto=PlazaEstatusNombre
PlazaEstatusNombre=ReclutaPlaza.EstaPendiente
ReclutaPlaza.EstaPendiente=(Fin)

[Sueldo.ListaEnCaptura]
(Inicio)=Recluta.SueldoActual
Recluta.SueldoActual=Recluta.SueldoMinimo
Recluta.SueldoMinimo=Recluta.SueldoAspira
Recluta.SueldoAspira=(Fin)



















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













[Detalle.ListaEnCaptura]
(Inicio)=ReclutaD.Competencia
ReclutaD.Competencia=Competencia.Nombre
Competencia.Nombre=ReclutaD.Resultado
ReclutaD.Resultado=ReclutaD.Valor
ReclutaD.Valor=ReclutaD.ValorMinimo
ReclutaD.ValorMinimo=ReclutaD.Peso
ReclutaD.Peso=ReclutaD.Observaciones
ReclutaD.Observaciones=(Fin)

[Detalle.Competencia.Nombre]
Carpeta=Detalle
Clave=Competencia.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco









































































[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=WizardSituaciones
TipoAccion=Controles Captura
Activo=S
Visible=S






















ClaveAccion=Cambiar Situacion
























[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=SueldoRango
SueldoRango=Sueldo
Sueldo=Plazas
Plazas=PesoTipo
PesoTipo=Comentarios
Comentarios=Bitacora
Bitacora=FormaExtraValor
FormaExtraValor=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=MovPersonal
MovPersonal=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Imprimir
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
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=Devolver
Devolver=Transferir
Transferir=CamposExtras
CamposExtras=SugerirCompetencias
SugerirCompetencias=PersonalExpress
PersonalExpress=Tareas
Tareas=Anexos
Anexos=AgregarEvento
AgregarEvento=Anterior
Anterior=Siguiente
Siguiente=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=Bitacora
Bitacora=ColaUsuario
ColaUsuario=MovPos
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
