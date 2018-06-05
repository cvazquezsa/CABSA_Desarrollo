[Forma]
Clave=Credito
Nombre=<T>Crédito<T>
Icono=0
Modulos=CREDI
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=275
PosicionInicialArriba=96
PosicionInicialAltura=558
PosicionInicialAncho=816
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
MovModulo=CREDI
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=497
PosicionSec1=148
PosicionSec2=429
Plantillas=S
PermiteCopiarDoc=S
ExpresionesAlMostrar=Asigna(Info.ConciliarManual, Falso)

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Credito
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

[Ficha.Credito.Mov]
Carpeta=Ficha
Clave=Credito.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.MovID]
Carpeta=Ficha
Clave=Credito.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=7
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Credito.FechaEmision]
Carpeta=Ficha
Clave=Credito.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.Proyecto]
Carpeta=Ficha
Clave=Credito.Proyecto
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
Vista=CreditoA
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
ListaOrden=Credito.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Credito.FechaEmision
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
FiltroFechasCancelacion=Credito.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S
FiltroUsuarios=S
IconosNombre=CreditoA:Credito.Mov+<T> <T>+CreditoA:Credito.MovID

[(Carpeta Abrir).Columnas]
0=140
1=80

2=-2
3=-2
4=-2
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

RefrescarDespues=S
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Credito:Credito.ID) y (Credito:Credito.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Credito:Credito.ID, <T>CREDI<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero
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

Expresion=Si<BR>  Credito:Credito.Estatus=EstatusSinAfectar<BR>Entonces<BR>  EjecutarSQL(<T>spTablaAmortizacion :tModulo, :nID, :tUsuario<T>, <T>CREDI<T>,  Credito:Credito.ID, Usuario)<BR>  Afectar(<T>CREDI<T>, Credito:Credito.ID, Credito:Credito.Mov, Credito:Credito.MovID, <T>Todo<T>, <T><T>, <T>Credito<T>)<BR>Sino<BR>  Asigna(Afectar.Modulo, <T>CREDI<T>)<BR>  Asigna(Afectar.Mov, Credito:Credito.Mov)<BR>  Asigna(Afectar.MovID, Credito:Credito.MovID)<BR>  Asigna(Afectar.ID, Credito:Credito.ID)<BR>  Asigna(Afectar.FormaCaptura, <T>Credito<T>)<BR>  Asigna(Info.TituloDialogo, Credito:Credito.Mov+<T> <T>+Credito:Credito.MovID)<BR>  Dialogo(<T>GenerarCreditoDA<T>)<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Credito:Credito.Usuario) y<BR>(Credito:Credito.Estatus en (EstatusSinAfectar, EstatusPendiente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>CREDI<T>, Credito:Credito.Mov, Credito:Credito.Estatus, FormaSituacion, Usuario) y<BR>(Credito:Credito.Estatus en (EstatusSinAfectar, EstatusPendiente))
EjecucionCondicion=ConDatos(Credito:Credito.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Credito:Credito.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CREDI<T>, Credito:Credito.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CREDI<T>, Credito:Credito.Mov, Credito:Credito.ID, Verdadero, Credito:Credito.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Credito:Credito.MovID) y (Credito:Credito.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Credito:Credito.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Credito WHERE ID=:nID<T>, Credito:Credito.ID))
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
ListaParametros1=Credito:Credito.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>CREDI<T>, Credito:Credito.Mov, Credito:Credito.Estatus), Credito:Credito.ID)
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
ListaParametros1=Credito:Credito.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CREDI<T>, Credito:Credito.Mov, Credito:Credito.Estatus), Credito:Credito.ID)
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
Expresion=Cancelar(<T>CREDI<T>, Credito:Credito.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Credito<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Credito:Credito.Usuario) y ConDatos(Credito:Credito.ID) y ConDatos(Credito:Credito.MovID) y<BR>((Credito:Credito.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPendiente)) o<BR>(Credito:Credito.Estatus=EstatusConcluido))
AntesExpresiones=Asigna(Afectar.Mov, Credito:Credito.Mov) <BR>Asigna(Afectar.MovID, Credito:Credito.MovID)<BR>Asigna(Temp.Personal, Nulo)<BR>Asigna(Temp.NominaConcepto, Nulo)<BR>Asigna(Temp.AcumuladoAnual, Nulo)

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
Expresion=Verificar(<T>CREDI<T>, Credito:Credito.ID,Credito:Credito.Mov,Credito:Credito.MovID)
ActivoCondicion=Credito:Credito.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Credito:Credito.Mov)

[Aplica.Credito.MovAplica]
Carpeta=Aplica
Clave=Credito.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Credito.MovAplicaID]
Carpeta=Aplica
Clave=Credito.MovAplicaID
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
ActivoCondicion=ConDatos(Credito:Credito.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.MovID, Credito:Credito.MovID)
[Aplica.Credito.Agente]
Carpeta=Aplica
Clave=Credito.Agente
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

GuardarAntes=S
DespuesGuardar=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>CREDI<T>, Credito:Credito.Mov, Credito:Credito.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>CREDI<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>CREDI<T>, Credito:Credito.Mov, Credito:Credito.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Credito:Credito.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.Estatus, Credito:Credito.Estatus)<BR>Asigna(Info.Situacion, Credito:Credito.Situacion)
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
ActivoCondicion=ConfigModulo(<T>CREDI<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Credito:Credito.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.MovID, Credito:Credito.MovID)

[(Carpeta Abrir).Credito.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Credito.FechaEmision
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
AntesExpresiones=Asigna(Info.Rama, <T>CREDI<T>)<BR>Asigna(Info.Fecha, Credito:Credito.FechaEmision)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Credito:Credito.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Credito:Credito.Mov+<T> <T>+Credito:Credito.MovID)
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
EjecucionCondicion=Si(Vacio(Credito:Credito.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.MovID, Credito:Credito.MovID)<BR>Asigna(Info.PuedeEditar, Credito:Credito.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Credito:Credito.Usuario))

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
ActivoCondicion=Credito:Credito.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Credito:Credito.Usuario)
EjecucionCondicion=Si(Vacio(Credito:Credito.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.MovID, Credito:Credito.MovID)

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
ActivoCondicion=ConDatos(Credito:Credito.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)

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
Expresion=CopiarMovimiento(<T>CREDI<T>, Credito:Credito.ID, <T>Credito<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Credito:Credito.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Credito:Credito.ID),GuardarCambios)
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
Concepto=180
Movimiento=122
Importe=131
Numero=43
0=49
1=92
Fecha=69
Referencia=72
Cargo=89
Abono=91
Observaciones=187
MovDinero=78
MovCont=68
TipoMovimiento=83
Poliza=79
Manual=40
ConceptoGasto=110
Acreedor=70

[Ficha.Credito.UEN]
Carpeta=Ficha
Clave=Credito.UEN
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

AntesExpresiones=Asigna(Info.PuedeEditar, Credito:Credito.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.MovID, Credito:Credito.MovID)<BR>Asigna(Info.Cliente, Credito:Credito.Deudor)<BR>Asigna(Info.Proveedor, Credito:Credito.Acreedor)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Credito:Credito.Proyecto)<BR>Asigna(Info.UEN, Credito:Credito.UEN)<BR>Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.Reporte, Nulo)
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
Expresion=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.Clave, <T>CREDI<T>+Credito:Credito.ID)<BR>Asigna(Info.Nombre, Credito:Credito.Mov+<T> <T>+Credito:Credito.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Credito:Credito.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.MovID, Credito:Credito.MovID)<BR>Asigna(Info.Fecha, Credito:Credito.FechaEmision)<BR>Asigna(Info.Estatus, Credito:Credito.Estatus)

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
EjecucionCondicion=ConDatos(Credito:Credito.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CREDI<T>)<BR>Asigna(Info.Clave, Credito:Credito.Mov)

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
EjecucionCondicion=ConDatos(Credito:Credito.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.Concepto, Credito:Credito.Concepto)

[Ficha.Credito.Observaciones]
Carpeta=Ficha
Clave=Credito.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Credito.Moneda]
Carpeta=Ficha
Clave=Credito.Moneda
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.TipoCambio]
Carpeta=Ficha
Clave=Credito.TipoCambio
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
Expresion=Asigna(Info.Forma, <T>Credito<T>)<BR>Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.Nombre, Credito:Credito.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CREDI<T>, Credito:Credito.Mov, Credito:Credito.ID, Falso, Credito:Credito.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CREDI<T>+Credito:Credito.ID)<BR>  Asigna(Info.Nombre, Credito:Credito.Mov+<T> <T>+Credito:Credito.MovID)<BR>  Asigna(Info.Modulo, <T>CREDI<T>)<BR>  Asigna(Info.Mov, Credito:Credito.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Credito:Credito.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.MovID, Credito:Credito.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (Credito:Credito.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=Credito:Credito.Estatus en (EstatusPendiente, EstatusConcluido, EstatusCancelado)

[Detalle.CreditoD.Fecha]
Carpeta=Detalle
Clave=CreditoD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CreditoD.Concepto]
Carpeta=Detalle
Clave=CreditoD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CreditoD.Referencia]
Carpeta=Detalle
Clave=CreditoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CreditoD.Cargo]
Carpeta=Detalle
Clave=CreditoD.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CreditoD.Abono]
Carpeta=Detalle
Clave=CreditoD.Abono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Saldo Inicial]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Inicial
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

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

[(Carpeta Totalizadores).Saldo Final]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Final
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
3D=S
Pegado=S
Tamano=4
ColorFondo=Plata
ColorFuente=Negro

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

[Detalle.CreditoD.TipoMovimiento]
Carpeta=Detalle
Clave=CreditoD.TipoMovimiento
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.CreditoD.Manual]
Carpeta=Detalle
Clave=CreditoD.Manual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CreditoD.ConceptoGasto]
Carpeta=Detalle
Clave=CreditoD.ConceptoGasto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Detalle.CreditoD.Acreedor]
Carpeta=Detalle
Clave=CreditoD.Acreedor
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[(Carpeta Abrir).Credito.Acreedor]
Carpeta=(Carpeta Abrir)
Clave=Credito.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Credito.Deudor]
Carpeta=(Carpeta Abrir)
Clave=Credito.Deudor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Credito.Importe]
Carpeta=(Carpeta Abrir)
Clave=Credito.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.Acreedor]
Carpeta=Ficha
Clave=Credito.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Credito.Deudor]
Carpeta=Ficha
Clave=Credito.Deudor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Credito.Importe]
Carpeta=Ficha
Clave=Credito.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Credito.TipoTasa]
Carpeta=Ficha
Clave=Credito.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Credito.TieneTasaEsp]
Carpeta=Ficha
Clave=Credito.TieneTasaEsp
Editar=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.TasaEsp]
Carpeta=Ficha
Clave=Credito.TasaEsp
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.Vencimiento]
Carpeta=Ficha
Clave=Credito.Vencimiento
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25
LineaNueva=N

[Ficha.Credito.Comisiones]
Carpeta=Ficha
Clave=Credito.Comisiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Credito.ComisionesIVA]
Carpeta=Ficha
Clave=Credito.ComisionesIVA
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.Descripcion]
Carpeta=Ficha
Clave=TipoTasa.Descripcion
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.TotalComisiones]
Carpeta=Ficha
Clave=TotalComisiones
Editar=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información del Deudor
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Credito:Credito.Deudor)
AntesExpresiones=Asigna(Info.Cliente, Credito:Credito.Deudor)

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=34
NombreEnBoton=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+I
NombreDesplegar=Información del &Acreedor
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Credito:Credito.Acreedor)
Antes=S
AntesExpresiones=Asigna(Info.Proveedor, Credito:Credito.Acreedor)

[Ficha.Credito.Referencia]
Carpeta=Ficha
Clave=Credito.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.Concepto]
Carpeta=Ficha
Clave=Credito.Concepto
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Ficha.Credito.TipoAmortizacion]
Carpeta=Ficha
Clave=Credito.TipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFuente=Negro
EspacioPrevio=N
ColorFondo=Blanco

[Ficha.TipoAmortizacion.Descripcion]
Carpeta=Ficha
Clave=TipoAmortizacion.Descripcion
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
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
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CREDI<T>, <T>{Credito:Credito.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CREDI{Credito:Credito.ID}<T>

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

[Ficha.Credito.Condicion]
Carpeta=Ficha
Clave=Credito.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.CtaDinero]
Carpeta=Ficha
Clave=Credito.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Credito.FormaPago]
Carpeta=Ficha
Clave=Credito.FormaPago
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.LineaCreditoEsp]
Carpeta=Ficha
Clave=Credito.LineaCreditoEsp
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Credito.LineaCredito]
Carpeta=Ficha
Clave=Credito.LineaCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
LineaNueva=S
EspacioPrevio=S

[Ficha.LC.Descripcion]
Carpeta=Ficha
Clave=LC.Descripcion
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Credito.LineaCreditoFondeo]
Carpeta=Ficha
Clave=Credito.LineaCreditoFondeo
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.VigenciaDesde]
Carpeta=Ficha
Clave=LC.VigenciaDesde
Editar=N
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[Ficha.LC.VigenciaHasta]
Carpeta=Ficha
Clave=LC.VigenciaHasta
Editar=N
3D=S
Pegado=N
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[Ficha.LCFondeo.Descripcion]
Carpeta=Ficha
Clave=LCFondeo.Descripcion
Editar=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Acciones.TablaAmortizacion]
Nombre=TablaAmortizacion
Boton=88
Menu=&Ver
NombreDesplegar=Tabla A&mortización
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+M
EspacioPrevio=S




RefrescarDespues=S
Expresion=Asigna(Info.Modulo, <T>CREDI<T>)<BR>Asigna(Info.ID, Credito:Credito.ID)<BR>Asigna(Info.Mov, Credito:Credito.Mov)<BR>Asigna(Info.MovID, Credito:Credito.MovID)<BR>Asigna(Info.Estatus, Credito:Credito.Estatus)<BR>Si(Credito:Credito.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar), EjecutarSQL(<T>spTablaAmortizacion :tModulo, :nID, :tUsuario<T>, Info.Modulo, Info.ID, Usuario))<BR>Forma(<T>TablaAmortizacion<T>)
ActivoCondicion=MovTipo(<T>CREDI<T>, Credito:Credito.Mov)<>CREDI.DA
[Ficha.ListaEnCaptura]
(Inicio)=Credito.Mov
Credito.Mov=Credito.MovID
Credito.MovID=Credito.Proyecto
Credito.Proyecto=Credito.UEN
Credito.UEN=Credito.Moneda
Credito.Moneda=Credito.TipoCambio
Credito.TipoCambio=Credito.FechaEmision
Credito.FechaEmision=Credito.Referencia
Credito.Referencia=Credito.Concepto
Credito.Concepto=Credito.Deudor
Credito.Deudor=Cte.Nombre
Cte.Nombre=Credito.Acreedor
Credito.Acreedor=Prov.Nombre
Prov.Nombre=Credito.LineaCredito
Credito.LineaCredito=LC.Descripcion
LC.Descripcion=LC.VigenciaDesde
LC.VigenciaDesde=LC.VigenciaHasta
LC.VigenciaHasta=Credito.TipoAmortizacion
Credito.TipoAmortizacion=TipoAmortizacion.Descripcion
TipoAmortizacion.Descripcion=Credito.TieneTasaEsp
Credito.TieneTasaEsp=Credito.TipoTasa
Credito.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=Credito.TasaEsp
Credito.TasaEsp=Credito.Condicion
Credito.Condicion=Credito.Vencimiento
Credito.Vencimiento=Credito.Importe
Credito.Importe=Credito.LineaCreditoFondeo
Credito.LineaCreditoFondeo=LCFondeo.Descripcion
LCFondeo.Descripcion=Credito.CtaDinero
Credito.CtaDinero=Credito.FormaPago
Credito.FormaPago=Credito.Comisiones
Credito.Comisiones=Credito.ComisionesIVA
Credito.ComisionesIVA=TotalComisiones
TotalComisiones=Credito.Observaciones
Credito.Observaciones=Credito.LineaCreditoEsp
Credito.LineaCreditoEsp=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Credito.FechaEmision
Credito.FechaEmision=Credito.Acreedor
Credito.Acreedor=Credito.Deudor
Credito.Deudor=Credito.Importe
Credito.Importe=(Fin)

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

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)























































[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S














































[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107
0=75
1=84
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2

























[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=FormaExtraValor
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
Bitacora=CteInfo
CteInfo=ProvInfo
ProvInfo=TablaAmortizacion
TablaAmortizacion=MovPos
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
