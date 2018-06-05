[Forma]
Clave=Captura
Nombre=<T>Capturas<T>
Icono=0
Modulos=CAPT
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=437
PosicionInicialArriba=68
PosicionInicialAltura=558
PosicionInicialAncho=609
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
MovModulo=CAPT
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=571
PosicionSec1=206
PosicionCol2=519

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Captura
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
PestanaNombre=Datos Generales
FichaEspacioNombresAuto=S
PestanaOtroNombre=S
Pestana=S

[Ficha.Captura.Mov]
Carpeta=Ficha
Clave=Captura.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Captura.MovID]
Carpeta=Ficha
Clave=Captura.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Captura.FechaEmision]
Carpeta=Ficha
Clave=Captura.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Captura.Proyecto]
Carpeta=Ficha
Clave=Captura.Proyecto
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
Vista=CapturaA
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
ListaOrden=Captura.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Captura.FechaEmision
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
FiltroFechasCancelacion=Captura.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S

BusquedaSelCampo=S
IconosNombre=CapturaA:Captura.Mov+<T> <T>+CapturaA:Captura.MovID
[(Carpeta Abrir).Columnas]
0=135
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Captura:Captura.ID) y (Captura:Captura.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Captura:Captura.ID, <T>CAPT<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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
ActivoCondicion=Vacio(Captura:Captura.MovID) y (Captura:Captura.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Captura:Captura.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Captura WHERE ID=:nID<T>, Captura:Captura.ID))
EjecucionMensaje=Captura.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>

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
ListaParametros1=Captura:Captura.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>CAPT<T>, Captura:Captura.Mov, Captura:Captura.Estatus), Captura:Captura.ID)
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
ListaParametros1=Captura:Captura.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CAPT<T>, Captura:Captura.Mov, Captura:Captura.Estatus), Captura:Captura.ID)
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
Expresion=Cancelar(<T>CAPT<T>, Captura:Captura.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Captura<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Captura:Captura.Usuario) y ConDatos(Captura:Captura.ID) y ConDatos(Captura:Captura.MovID) y<BR>((Captura:Captura.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusSincro, EstatusPendiente)) o<BR>(Captura:Captura.Estatus en (EstatusConcluido, EstatusPorConfirmar)))
AntesExpresiones=Asigna( Afectar.Mov, Captura:Captura.Mov ) <BR> Asigna( Afectar.MovID, Captura:Captura.MovID )

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
Expresion=Verificar(<T>CAPT<T>, Captura:Captura.ID,Captura:Captura.Mov,Captura:Captura.MovID)
ActivoCondicion=Captura:Captura.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Captura:Captura.Mov)

[Aplica.Captura.MovAplica]
Carpeta=Aplica
Clave=Captura.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Captura.MovAplicaID]
Carpeta=Aplica
Clave=Captura.MovAplicaID
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
ActivoCondicion=ConDatos(Captura:Captura.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, Captura:Captura.ID)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.MovID, Captura:Captura.MovID)
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>CAPT<T>, Captura:Captura.Mov, Captura:Captura.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>CAPT<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>CAPT<T>, Captura:Captura.Mov, Captura:Captura.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Captura:Captura.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, Captura:Captura.ID)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.Estatus, Captura:Captura.Estatus)<BR>Asigna(Info.Situacion, Captura:Captura.Situacion)
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
ActivoCondicion=ConfigModulo(<T>CAPT<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Captura:Captura.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, Captura:Captura.ID)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.MovID, Captura:Captura.MovID)

[(Carpeta Abrir).Captura.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Captura.FechaEmision
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
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Rama, <T>CAPT<T>)<BR>Asigna(Info.Fecha, Captura:Captura.FechaEmision)<BR>Asigna(Info.ID, Captura:Captura.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Captura:Captura.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Captura:Captura.Mov+<T> <T>+Captura:Captura.MovID)
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
EjecucionCondicion=Si(Vacio(Captura:Captura.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, Captura:Captura.ID)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.MovID, Captura:Captura.MovID)<BR>Asigna(Info.PuedeEditar, Captura:Captura.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Captura:Captura.Usuario))

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
ActivoCondicion=Captura:Captura.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Captura:Captura.Usuario)
EjecucionCondicion=Si(Vacio(Captura:Captura.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, Captura:Captura.ID)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.MovID, Captura:Captura.MovID)

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
ActivoCondicion=ConDatos(Captura:Captura.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, Captura:Captura.ID)

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
Expresion=CopiarMovimiento(<T>CAPT<T>, Captura:Captura.ID, <T>Captura<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Captura:Captura.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Captura:Captura.ID),GuardarCambios)
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
Posicion=74
Contenedor=61
CantidadRecogida=94
CantidadEntregada=100
SubCuenta=108
CantidadPendiente=98
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
Estado=102
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

[Ficha.Captura.UEN]
Carpeta=Ficha
Clave=Captura.UEN
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
TipoAccion=Formas
ClaveAccion=Tarea
Antes=S
DespuesGuardar=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
AntesExpresiones=Asigna(Info.PuedeEditar, Captura:Captura.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.MovID, Captura:Captura.MovID)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Captura:Captura.Proyecto)<BR>Asigna(Info.UEN, Captura:Captura.UEN)<BR>Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, Captura:Captura.ID)<BR>Asigna(Info.Reporte, Nulo)

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
Expresion=Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.Clave, <T>CAPT<T>+Captura:Captura.ID)<BR>Asigna(Info.Nombre, Captura:Captura.Mov+<T> <T>+Captura:Captura.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Captura:Captura.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, Captura:Captura.ID)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.MovID, Captura:Captura.MovID)<BR>Asigna(Info.Fecha, Captura:Captura.FechaEmision)<BR>Asigna(Info.Estatus, Captura:Captura.Estatus)

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
EjecucionCondicion=ConDatos(Captura:Captura.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CAPT<T>)<BR>Asigna(Info.Clave, Captura:Captura.Mov)

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
EjecucionCondicion=ConDatos(Captura:Captura.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.Concepto, Captura:Captura.Concepto)

[Ficha.Captura.Concepto]
Carpeta=Ficha
Clave=Captura.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Captura.Referencia]
Carpeta=Ficha
Clave=Captura.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Captura.Observaciones]
Carpeta=Ficha
Clave=Captura.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
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
Expresion=Asigna(Info.Forma, <T>Captura<T>)<BR>Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.Nombre, Captura:Captura.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, Captura:Captura.ID)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.MovID, Captura:Captura.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (Captura:Captura.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Contacto.Captura.Contacto]
Carpeta=Contacto
Clave=Captura.Contacto
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

[Contacto.Captura.Cliente]
Carpeta=Contacto
Clave=Captura.Cliente
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

[Contacto.Captura.Proveedor]
Carpeta=Contacto
Clave=Captura.Proveedor
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

[Contacto.Captura.Personal]
Carpeta=Contacto
Clave=Captura.Personal
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

[Contacto.Captura.Mov]
Carpeta=Contacto
Clave=Captura.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Captura.MovID]
Carpeta=Contacto
Clave=Captura.MovID
Editar=N
3D=S
Pegado=N
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Captura.Proceso]
Carpeta=Contacto
Clave=Captura.Proceso
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
Expresion=Asigna(Info.TareaID, Tarea:Tarea.ID)<BR>Asigna(Info.PuedeEditar, Captura:Captura.Estatus=EstatusPendiente)<BR>Forma(<T>TareaEditar<T>)
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
Expresion=RegistrarSeleccionID(<T>Tareas<T>)<BR>EjecutarSQL(<T>spTareasCompletarSeleccion :nEstacion<T>, EstacionTrabajo) <BR>Captura.ActualizarVista
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

[Contacto.CapturaD.Nombre]
Carpeta=Contacto
Clave=CapturaD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.CapturaD.Puesto]
Carpeta=Contacto
Clave=CapturaD.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.CapturaD.Organizacion]
Carpeta=Contacto
Clave=CapturaD.Organizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.CapturaD.Telefonos]
Carpeta=Contacto
Clave=CapturaD.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.CapturaD.eMail]
Carpeta=Contacto
Clave=CapturaD.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Observaciones.CapturaD.Observaciones]
Carpeta=Observaciones
Clave=CapturaD.Observaciones
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
Expresion=Asigna(Info.Nombre, CapturaD:ContactoNombre)<BR>Si<BR>  Dialogo(<T>EstaSeguroFormaCancelar<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spFormaCancelarContacto :nID, :nRID<T>, Captura:Captura.ID, CapturaD:CapturaD.RID) <BR>  Captura.ActualizarVista(<T>Lista<T>) <BR>Fin
VisibleCondicion=Captura:Captura.Estatus=EstatusPendiente

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
Expresion=Asigna(Info.Nombre, CapturaD:ContactoNombre)<BR>Si<BR>  Dialogo(<T>EstaSeguroFormaOportunidad<T>)<BR>Entonces<BR>  ProcesarSQL(<T>spFormaGenerarOportunidad :nID, :nRID<T>, Captura:Captura.ID, CapturaD:CapturaD.RID)<BR>  Captura.ActualizarVista(<T>Lista<T>) <BR>Fin
VisibleCondicion=Captura:Captura.Estatus=EstatusPendiente

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
Expresion=Asigna(Info.PuedeEditar, Captura:Captura.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Clave, CapturaD:CapturaD.Contacto)<BR>Asigna(Info.Nombre, CapturaD:ContactoNombre)<BR>Asigna(Info.Mov, Captura:Captura.Mov)<BR>Asigna(Info.MovID, Captura:Captura.MovID)<BR>Asigna(Info.Modulo, <T>CAPT<T>)<BR>Asigna(Info.ID, CapturaD:CapturaD.RID)<BR>Asigna(Info.Reporte, Nulo)<BR>Caso CapturaD:CapturaD.ContactoTipo<BR>  Es <T>Prospecto<T> Entonces Si(Forma(<T>FormaProspecto<T>), Captura.ActualizarVista(<T>Lista<T>))<BR>Fin
EjecucionCondicion=ConDatos(CapturaD:CapturaD.Contacto)

[Detalle]
Estilo=Hoja
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CapturaD
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
OtroOrden=S
Detalle=S
VistaMaestra=Captura
LlaveLocal=CapturaD.ID
LlaveMaestra=Captura.ID
HojaSinBorde=S
HojaFondoGris=S
ListaEnCaptura=(Lista)
ListaOrden=CapturaD.Campo<TAB>(Acendente)
HojaTitulos=S
HojaMostrarColumnas=S

[eMail.Captura.eMailDireccion]
Carpeta=eMail
Clave=Captura.eMailDireccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco
ColorFuente=Negro

[eMail.Captura.eMailAsunto]
Carpeta=eMail
Clave=Captura.eMailAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Captura.Catalogo]
Carpeta=Ficha
Clave=Captura.Catalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Captura.Clave]
Carpeta=Ficha
Clave=Captura.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CapturaD.Valor]
Carpeta=Detalle
Clave=CapturaD.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Plata
ColorFuente=Negro

[Detalle.CapturaD.ValorAnterior]
Carpeta=Detalle
Clave=CapturaD.ValorAnterior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Abrir).Captura.Catalogo]
Carpeta=(Carpeta Abrir)
Clave=Captura.Catalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).Captura.Clave]
Carpeta=(Carpeta Abrir)
Clave=Captura.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

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

[Acciones.FormaCaptura]
Nombre=FormaCaptura
Boton=25
NombreEnBoton=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=&Forma Captura
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
RefrescarDespues=S
Expresion=Asigna(Info.Forma, SQL(<T>SELECT Forma FROM CapturaCatalogo WHERE Catalogo=:tCatalogo<T>, Captura:Captura.Catalogo))<BR>EjecutarSQL( <T>spCapturaFoto :nID, :tTabla, :tClave, :tAccion<T>, Captura:Captura.ID, Info.Forma, Captura:Captura.Clave, <T>Antes<T>)<BR>Si<BR>  FormaPos(Info.Forma, Captura:Captura.Clave, Verdadero)<BR>Entonces<BR>  EjecutarSQL( <T>spCapturaFoto :nID, :tTabla, :tClave, :tAccion<T>, Captura:Captura.ID, Info.Forma, Captura:Captura.Clave, <T>Aceptar<T>)<BR>Sino<BR>  EjecutarSQL( <T>spCapturaFoto :nID, :tTabla, :tClave, :tAccion<T>, Captura:Captura.ID, Info.Forma, Captura:Captura.Clave, <T>Cancelar<T>)<BR>Fin
EjecucionCondicion=ConDatos(Captura:Captura.Catalogo) y ConDatos(Captura:Captura.Clave)




[Ficha.ListaEnCaptura]
(Inicio)=Captura.Mov
Captura.Mov=Captura.MovID
Captura.MovID=Captura.Proyecto
Captura.Proyecto=Captura.UEN
Captura.UEN=Captura.FechaEmision
Captura.FechaEmision=Captura.Catalogo
Captura.Catalogo=Captura.Clave
Captura.Clave=Captura.Concepto
Captura.Concepto=Captura.Referencia
Captura.Referencia=Captura.Observaciones
Captura.Observaciones=(Fin)




[Detalle.ListaEnCaptura]
(Inicio)=CampoNombre
CampoNombre=CapturaD.Valor
CapturaD.Valor=CapturaD.ValorAnterior
CapturaD.ValorAnterior=(Fin)






















[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S





























































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Captura.FechaEmision
Captura.FechaEmision=Captura.Catalogo
Captura.Catalogo=Captura.Clave
Captura.Clave=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=EMAIL
EMAIL=CONCLUIDO
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
Sucursal=FormaCaptura
FormaCaptura=Eliminar
Eliminar=Cancelar
Cancelar=Tareas
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
