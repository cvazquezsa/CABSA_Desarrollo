[Forma]
Clave=Incidencia
Nombre=<T>Incidencia<T>
Icono=0
Modulos=INC
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=355
PosicionInicialArriba=138
PosicionInicialAltura=558
PosicionInicialAncho=729
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
MovModulo=INC
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
TituloAutoNombre=S
PosicionInicialAlturaCliente=545
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.Aplica, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.NominaConcepto, Nulo)<BR>Asigna(Temp.Personal, Nulo)<BR>Asigna(Temp.NominaConcepto, Nulo)<BR>Asigna(Temp.AcumuladoAnual, Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Proveedor, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
PosicionSec1=319

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Incidencia
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

[Ficha.Incidencia.Mov]
Carpeta=Ficha
Clave=Incidencia.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.MovID]
Carpeta=Ficha
Clave=Incidencia.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Incidencia.FechaEmision]
Carpeta=Ficha
Clave=Incidencia.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.Proyecto]
Carpeta=Ficha
Clave=Incidencia.Proyecto
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
Vista=IncidenciaA
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
ListaOrden=Incidencia.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Incidencia.FechaEmision
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
FiltroFechasCancelacion=Incidencia.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S
FiltroUsuarios=S

IconosNombre=IncidenciaA:Incidencia.Mov+<T> <T>+IncidenciaA:Incidencia.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=129
1=88

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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Incidencia:Incidencia.ID) y (Incidencia:Incidencia.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Incidencia:Incidencia.ID, <T>INC<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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

Expresion=Si<BR> (Incidencia:Incidencia.Estatus en (EstatusPendiente))<BR>Entonces<BR>  Asigna(Info.Modulo, <T>INC<T>)<BR>  Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>  Asigna(Info.MovID, Incidencia:Incidencia.MovID)<BR>  Si(Forma(<T>GenerarMovFlujo<T>), Generar(<T>INC<T>, Incidencia:Incidencia.ID, Incidencia:Incidencia.Mov, Incidencia:Incidencia.MovID, <T>Todo<T>, Info.MovGenerar, <T>Incidencia<T>))<BR>Sino<BR>  Si<BR>    Incidencia:Incidencia.Estatus=EstatusSinAfectar<BR>  Entonces<BR>    Afectar(<T>INC<T>, Incidencia:Incidencia.ID, Incidencia:Incidencia.Mov, Incidencia:Incidencia.MovID, <T>Todo<T>, <T><T>, <T>Incidencia<T>)<BR>  Sino<BR>    Asigna(Afectar.Modulo, <T>INC<T>)<BR>    Asigna(Afectar.Mov, Incidencia:Incidencia.Mov)<BR>    Asigna(Afectar.MovID, Incidencia:Soporte.MovID) <BR>    Asigna(Afectar.ID, Incidencia:Incidencia.ID)<BR>    Asigna(Info.TituloDialogo, Capital:Incidencia.Mov+<T> <T>+Incidencia:Incidencia.MovID)<BR>    Asigna(Info.Estado, Incidencia:Incidencia.Estado)<BR>    Dialogo(<T>AfectarIncidencia<T>)<BR>  Fin<BR>Fin<BR>Asigna(Temp.Personal, Nulo)<BR>Asigna(Temp.NominaConcepto, Nulo)<BR>Asigna(Temp.AcumuladoAnual, Nulo)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Incidencia:Incidencia.Usuario) y<BR>(Incidencia:Incidencia.Estatus en (EstatusSinAfectar, EstatusPendiente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>INC<T>, Incidencia:Incidencia.Mov, Incidencia:Incidencia.Estatus, FormaSituacion, Usuario) y<BR>(Incidencia:Incidencia.Estatus=EstatusSinAfectar)
EjecucionCondicion=ConDatos(Incidencia:Incidencia.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Incidencia:Incidencia.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>INC<T>, Incidencia:Incidencia.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>INC<T>, Incidencia:Incidencia.Mov, Incidencia:Incidencia.ID, Verdadero, Incidencia:Incidencia.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Incidencia:Incidencia.MovID) y (Incidencia:Incidencia.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Incidencia:Incidencia.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Incidencia WHERE ID=:nID<T>, Incidencia:Incidencia.ID))
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
ListaParametros1=Incidencia:Incidencia.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>INC<T>, Incidencia:Incidencia.Mov, Incidencia:Incidencia.Estatus), Incidencia:Incidencia.ID)
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
ListaParametros1=Incidencia:Incidencia.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>INC<T>, Incidencia:Incidencia.Mov, Incidencia:Incidencia.Estatus), Incidencia:Incidencia.ID)
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
Expresion=Cancelar(<T>INC<T>, Incidencia:Incidencia.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Incidencia<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Incidencia:Incidencia.Usuario) y ConDatos(Incidencia:Incidencia.ID) y ConDatos(Incidencia:Incidencia.MovID) y<BR>((Incidencia:Incidencia.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPendiente)) o<BR>(Incidencia:Incidencia.Estatus=EstatusConcluido))
AntesExpresiones=Asigna(Afectar.Mov, Incidencia:Incidencia.Mov) <BR>Asigna(Afectar.MovID, Incidencia:Incidencia.MovID)<BR>Asigna(Temp.Personal, Nulo)<BR>Asigna(Temp.NominaConcepto, Nulo)<BR>Asigna(Temp.AcumuladoAnual, Nulo)

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
Expresion=Verificar(<T>INC<T>, Incidencia:Incidencia.ID,Incidencia:Incidencia.Mov,Incidencia:Incidencia.MovID)
ActivoCondicion=Incidencia:Incidencia.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Incidencia:Incidencia.Mov)

[Aplica.Incidencia.MovAplica]
Carpeta=Aplica
Clave=Incidencia.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Incidencia.MovAplicaID]
Carpeta=Aplica
Clave=Incidencia.MovAplicaID
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
ActivoCondicion=ConDatos(Incidencia:Incidencia.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.MovID, Incidencia:Incidencia.MovID)
[Aplica.Incidencia.Agente]
Carpeta=Aplica
Clave=Incidencia.Agente
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

Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>INC<T>, Incidencia:Incidencia.Mov, Incidencia:Incidencia.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>INC<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>INC<T>, Incidencia:Incidencia.Mov, Incidencia:Incidencia.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Incidencia:Incidencia.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.Estatus, Incidencia:Incidencia.Estatus)<BR>Asigna(Info.Situacion, Incidencia:Incidencia.Situacion)
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
ActivoCondicion=ConfigModulo(<T>INC<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Incidencia:Incidencia.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.MovID, Incidencia:Incidencia.MovID)

[(Carpeta Abrir).Incidencia.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Incidencia.FechaEmision
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
AntesExpresiones=Asigna(Info.Rama, <T>INC<T>)<BR>Asigna(Info.Fecha, Incidencia:Incidencia.FechaEmision)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Incidencia:Incidencia.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Incidencia:Incidencia.Mov+<T> <T>+Incidencia:Incidencia.MovID)
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
EjecucionCondicion=Si(Vacio(Incidencia:Incidencia.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.MovID, Incidencia:Incidencia.MovID)<BR>Asigna(Info.PuedeEditar, Incidencia:Incidencia.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Incidencia:Incidencia.Usuario))

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
ActivoCondicion=Incidencia:Incidencia.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Incidencia:Incidencia.Usuario)
EjecucionCondicion=Si(Vacio(Incidencia:Incidencia.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.MovID, Incidencia:Incidencia.MovID)

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
ActivoCondicion=ConDatos(Incidencia:Incidencia.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)

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
Expresion=CopiarMovimiento(<T>INC<T>, Incidencia:Incidencia.ID, <T>Incidencia<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Incidencia:Incidencia.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Incidencia:Incidencia.ID),GuardarCambios)
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
Cantidad=59
Precio=101
Costo=103
PrecioTotal=104
CostoTotal=93
Folio=42
FechaAplicacion=84
NominaConcepto=64
Concepto=176
Movimiento=109
Importe=131
Numero=43
0=49
1=92

2=-2
3=-2
4=-2
5=-2
[Ficha.Incidencia.UEN]
Carpeta=Ficha
Clave=Incidencia.UEN
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
AntesExpresiones=Asigna(Info.PuedeEditar, Incidencia:Incidencia.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.MovID, Incidencia:Incidencia.MovID)<BR>Asigna(Info.Cliente, Incidencia:Incidencia.Cliente)<BR>Asigna(Info.Proveedor, Incidencia:Incidencia.Proveedor)<BR>Asigna(Info.Agente, Incidencia:Incidencia.Agente)<BR>Asigna(Info.Personal, Incidencia:Incidencia.Personal)<BR>Asigna(Info.Proyecto, Incidencia:Incidencia.Proyecto)<BR>Asigna(Info.UEN, Incidencia:Incidencia.UEN)<BR>Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)<BR>Asigna(Info.Reporte, Nulo)

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
Expresion=Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.Clave, <T>INC<T>+Incidencia:Incidencia.ID)<BR>Asigna(Info.Nombre, Incidencia:Incidencia.Mov+<T> <T>+Incidencia:Incidencia.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Incidencia:Incidencia.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.MovID, Incidencia:Incidencia.MovID)<BR>Asigna(Info.Fecha, Incidencia:Incidencia.FechaEmision)<BR>Asigna(Info.Estatus, Incidencia:Incidencia.Estatus)

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
EjecucionCondicion=ConDatos(Incidencia:Incidencia.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>INC<T>)<BR>Asigna(Info.Clave, Incidencia:Incidencia.Mov)

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
EjecucionCondicion=ConDatos(Incidencia:Incidencia.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.Concepto, Incidencia:Incidencia.Concepto)

[Detalle]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=IncidenciaD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Incidencia
LlaveLocal=IncidenciaD.ID
LlaveMaestra=Incidencia.ID
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=(Lista)
CondicionEdicion=Falso
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Número<T>
IconosNombreNumerico=S
ElementosPorPagina=200
MenuLocal=S
ListaAcciones=LocalPersonalizar
IconosNombre=IncidenciaD:IncidenciaD.Numero
CondicionVisible=Incidencia:Incidencia.Estatus en (EstatusPendiente, EstatusConcluido, EstatusCancelado)

[Ficha.Incidencia.Referencia]
Carpeta=Ficha
Clave=Incidencia.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Incidencia.Observaciones]
Carpeta=Ficha
Clave=Incidencia.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=84
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.Moneda]
Carpeta=Ficha
Clave=Incidencia.Moneda
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.TipoCambio]
Carpeta=Ficha
Clave=Incidencia.TipoCambio
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
Expresion=Asigna(Info.Forma, <T>Incidencia<T>)<BR>Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.Nombre, Incidencia:Incidencia.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>INC<T>, Incidencia:Incidencia.Mov, Incidencia:Incidencia.ID, Falso, Incidencia:Incidencia.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>INC<T>+Incidencia:Incidencia.ID)<BR>  Asigna(Info.Nombre, Incidencia:Incidencia.Mov+<T> <T>+Incidencia:Incidencia.MovID)<BR>  Asigna(Info.Modulo, <T>INC<T>)<BR>  Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Incidencia:Incidencia.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Detalle.IncidenciaD.FechaAplicacion]
Carpeta=Detalle
Clave=IncidenciaD.FechaAplicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.IncidenciaD.Importe]
Carpeta=Detalle
Clave=IncidenciaD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Detalle.IncidenciaD.Cantidad]
Carpeta=Detalle
Clave=IncidenciaD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

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

[Ficha.Incidencia.Personal]
Carpeta=Ficha
Clave=Incidencia.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.NombreCompleto]
Carpeta=Ficha
Clave=NombreCompleto
Editar=S
3D=S
Tamano=58
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Abrir).Incidencia.Personal]
Carpeta=(Carpeta Abrir)
Clave=Incidencia.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).Incidencia.NominaConcepto]
Carpeta=(Carpeta Abrir)
Clave=Incidencia.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).NominaConcepto.Concepto]
Carpeta=(Carpeta Abrir)
Clave=NominaConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).NominaConcepto.Movimiento]
Carpeta=(Carpeta Abrir)
Clave=NominaConcepto.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Incidencia.FechaAplicacion]
Carpeta=Ficha
Clave=Incidencia.FechaAplicacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.NominaConcepto]
Carpeta=Ficha
Clave=Incidencia.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NominaConcepto.Concepto]
Carpeta=Ficha
Clave=NominaConcepto.Concepto
Editar=S
3D=S
Tamano=45
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Incidencia.Cantidad]
Carpeta=Ficha
Clave=Incidencia.Cantidad
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Ficha.Incidencia.Valor]
Carpeta=Ficha
Clave=Incidencia.Valor
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Ficha.Incidencia.Porcentaje]
Carpeta=Ficha
Clave=Incidencia.Porcentaje
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.Incidencia.Acreedor]
Carpeta=Ficha
Clave=Incidencia.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Acreedor.Nombre]
Carpeta=Ficha
Clave=Acreedor.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=33
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Incidencia.Vencimiento]
Carpeta=Ficha
Clave=Incidencia.Vencimiento
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.FechaD]
Carpeta=Ficha
Clave=Incidencia.FechaD
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.FechaA]
Carpeta=Ficha
Clave=Incidencia.FechaA
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.Repetir]
Carpeta=Ficha
Clave=Incidencia.Repetir
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.Prorratear]
Carpeta=Ficha
Clave=Incidencia.Prorratear
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.Veces]
Carpeta=Ficha
Clave=Incidencia.Veces
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Incidencia.Frecuencia]
Carpeta=Ficha
Clave=Incidencia.Frecuencia
Editar=S
3D=S
Pegado=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Ficha.Importe]
Carpeta=Ficha
Clave=Importe
Editar=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Tamano=20

[Ficha.NominaConcepto.Movimiento]
Carpeta=Ficha
Clave=NominaConcepto.Movimiento
Editar=S
3D=S
Pegado=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.IncidenciaD.Saldo]
Carpeta=Detalle
Clave=IncidenciaD.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.IncidenciaD.CantidadPendiente]
Carpeta=Detalle
Clave=IncidenciaD.CantidadPendiente
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.Modulo, <T>INC<T>)<BR>Asigna(Info.ID, Incidencia:Incidencia.ID)<BR>Asigna(Info.Mov, Incidencia:Incidencia.Mov)<BR>Asigna(Info.MovID, Incidencia:Incidencia.MovID)
DespuesGuardar=S
Visible=S

[Ficha.Incidencia.ImporteUnitario]
Carpeta=Ficha
Clave=Incidencia.ImporteUnitario
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.LocalPersonalizar]
Nombre=LocalPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Ficha.AcumuladoAnual]
Carpeta=Ficha
Clave=AcumuladoAnual
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel y (Incidencia:Incidencia.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=Incidencia:Incidencia.Estatus en (EstatusPendiente, EstatusConcluido, EstatusCancelado)

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>INC<T>, <T>{Incidencia:Incidencia.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>INC{Incidencia:Incidencia.ID}<T>

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




[Ficha.ListaEnCaptura]
(Inicio)=Incidencia.Mov
Incidencia.Mov=Incidencia.MovID
Incidencia.MovID=Incidencia.Proyecto
Incidencia.Proyecto=Incidencia.UEN
Incidencia.UEN=Incidencia.Moneda
Incidencia.Moneda=Incidencia.TipoCambio
Incidencia.TipoCambio=Incidencia.FechaEmision
Incidencia.FechaEmision=Incidencia.FechaAplicacion
Incidencia.FechaAplicacion=Incidencia.Personal
Incidencia.Personal=NombreCompleto
NombreCompleto=Incidencia.NominaConcepto
Incidencia.NominaConcepto=NominaConcepto.Concepto
NominaConcepto.Concepto=NominaConcepto.Movimiento
NominaConcepto.Movimiento=Incidencia.Referencia
Incidencia.Referencia=Incidencia.FechaD
Incidencia.FechaD=Incidencia.FechaA
Incidencia.FechaA=Incidencia.Cantidad
Incidencia.Cantidad=AcumuladoAnual
AcumuladoAnual=Incidencia.Valor
Incidencia.Valor=Incidencia.Porcentaje
Incidencia.Porcentaje=Importe
Importe=Incidencia.Acreedor
Incidencia.Acreedor=Acreedor.Nombre
Acreedor.Nombre=Incidencia.Vencimiento
Incidencia.Vencimiento=Incidencia.Observaciones
Incidencia.Observaciones=Incidencia.Repetir
Incidencia.Repetir=Incidencia.Prorratear
Incidencia.Prorratear=Incidencia.Veces
Incidencia.Veces=Incidencia.Frecuencia
Incidencia.Frecuencia=Incidencia.ImporteUnitario
Incidencia.ImporteUnitario=(Fin)




[Detalle.ListaEnCaptura]
(Inicio)=IncidenciaD.FechaAplicacion
IncidenciaD.FechaAplicacion=IncidenciaD.Cantidad
IncidenciaD.Cantidad=IncidenciaD.CantidadPendiente
IncidenciaD.CantidadPendiente=IncidenciaD.Importe
IncidenciaD.Importe=IncidenciaD.Saldo
IncidenciaD.Saldo=(Fin)

[Detalle.ListaOrden]
(Inicio)=IncidenciaD.FechaAplicacion<TAB>(Acendente)
IncidenciaD.FechaAplicacion<TAB>(Acendente)=IncidenciaD.Numero<TAB>(Acendente)
IncidenciaD.Numero<TAB>(Acendente)=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)










[Lista.Columnas]
0=106
1=301

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
(Inicio)=Incidencia.FechaEmision
Incidencia.FechaEmision=Incidencia.Personal
Incidencia.Personal=Incidencia.NominaConcepto
Incidencia.NominaConcepto=NominaConcepto.Concepto
NominaConcepto.Concepto=NominaConcepto.Movimiento
NominaConcepto.Movimiento=(Fin)

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
