[Forma]
Clave=CR
Nombre=<T>Caja Registradora<T>
Icono=0
Modulos=CR
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=298
PosicionInicialArriba=56
PosicionInicialAltura=581
PosicionInicialAncho=770
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
PosicionSeccion1=43
PosicionSeccion2=93
BarraAyuda=S
MovModulo=CR
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
PosicionColumna2=59
PosicionInicialAlturaCliente=578
AutoRefrescarControles=S
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.EnviarA, Nulo)<BR>Asigna(Info.Almacen, Nulo)
PosicionSec1=238

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CR
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
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
PermiteEditar=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Pestana=S

[Ficha.CR.Mov]
Carpeta=Ficha
Clave=CR.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CR.MovID]
Carpeta=Ficha
Clave=CR.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.CR.FechaEmision]
Carpeta=Ficha
Clave=CR.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CR.Concepto]
Carpeta=Ficha
Clave=CR.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Ficha.CR.Proyecto]
Carpeta=Ficha
Clave=CR.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.CR.Moneda]
Carpeta=Ficha
Clave=CR.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CR.Observaciones]
Carpeta=Ficha
Clave=CR.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=76
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=CRA
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
ListaOrden=CR.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=CR.FechaEmision
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
FiltroFechasNormal=S
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
Filtros=S
FiltroPredefinido=S
FiltroEstilo=Directorio
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroAutoValidar=Mon
FiltroAplicaEn=CR.Moneda
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroUsuarios=S
FiltroMovs=S
FiltroFechasCancelacion=CR.FechaCancelacion
FiltroSucursales=S
IconosNombre=CRA:CR.Mov+<T> <T>+CRA:CR.MovID

[(Carpeta Abrir).Columnas]
0=153
1=89

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
EjecucionConError=S
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(CR:CR.ID) y (CR:CR.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, CR:CR.ID, <T>CR<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>ConDatos(CR:CR.Caja) y ConDatos(CR:CR.Cajero)
EjecucionMensaje=Si(Vacio(CR:CR.Caja), <T>Falta Indicar la Caja<T>, Si(Vacio(CR:CR.Cajero), <T>Falta Indicar el Cajero<T>))

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

[Detalle.Columnas]
Importe=106
Aplica=96
AplicaID=74
AplicaProntoPago=96
Personal=125
Cantidad=51
Porcentaje=51
Periodos=48
FechaInicio=73
FechaTermino=79
Observaciones=153
CantidadPendiente=53
Saldo=106
Estatus=94
Condicion=99
CtaDinero=83
Variable=95
Activo=35
FechaD=70
FechaA=77
Monto=86
Descripcion=106
Referencia=98
Concepto=104
Categoria=118
Departamento=122
Puesto=108
Grupo=101
Motivo=153
Calificacion=60
Articulo=124
Actual=99
Anterior=86
Nuevo=91
Diferencia=91
%Diferencia=64
DiferenciaPorcentaje=56
CR=218
Serie=176
Tipo=122
Precio=104
FechaEmision=94

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
GuardarAntes=S
ConCondicion=S
EspacioPrevio=S
Antes=S
DespuesGuardar=S

Expresion=Afectar(<T>CR<T>, CR:CR.ID, CR:CR.Mov, CR:CR.MovID, <T>Todo<T>, <T><T>, <T>CR<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, CR:CR.Usuario) y<BR>(CR:CR.Estatus en (EstatusSinAfectar, EstatusPendiente, EstatusVigente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>CR<T>, CR:CR.Mov, CR:CR.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(CR:CR.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (CR:CR.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CR<T>, CR:CR.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CR<T>, CR:CR.Mov, CR:CR.ID, Verdadero, CR:CR.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
ActivoCondicion=Vacio(CR:CR.MovID) y (CR:CR.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, CR:CR.Usuario)

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=CR:CR.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>CR<T>, CR:CR.Mov, CR:CR.Estatus), CR:CR.ID)
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
ListaParametros1=CR:CR.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CR<T>, CR:CR.Mov, CR:CR.Estatus), CR:CR.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.Totalizar]
Nombre=Totalizar
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Totalizar
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Ultimo
Visible=S
ActivoCondicion=CR:CR.Estatus=EstatusSinAfectar

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
Expresion=Cancelar(<T>CR<T>, CR:CR.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>CR<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, CR:CR.Usuario) y ConDatos(CR:CR.ID) y ConDatos(CR:CR.MovID) y<BR>(CR:CR.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusConcluido))
AntesExpresiones=Asigna( Afectar.Mov, CR:CR.Mov ) <BR>Asigna( Afectar.MovID, CR:CR.MovID )

[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
EspacioPrevio=S
ConCondicion=S
Expresion=Verificar(<T>CR<T>, CR:CR.ID,CR:CR.Mov,CR:CR.MovID)
ActivoCondicion=CR:CR.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(CR:CR.Mov)

[Ficha.CR.TipoCambio]
Carpeta=Ficha
Clave=CR.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.CR.MovAplica]
Carpeta=Aplica
Clave=CR.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.CR.MovAplicaID]
Carpeta=Aplica
Clave=CR.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10

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

Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(CR:CR.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CR:CR.ID)<BR>Asigna(Info.Mov, CR:CR.Mov)<BR>Asigna(Info.MovID, CR:CR.MovID)
[Aplica.CR.Proveedor]
Carpeta=Aplica
Clave=CR.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.Prov.Nombre]
Carpeta=Aplica
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=50
ColorFondo=Plata

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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>CR<T>, CR:CR.Mov, CR:CR.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>CR<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>CR<T>, CR:CR.Mov, CR:CR.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(CR:CR.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CR:CR.ID)<BR>Asigna(Info.Mov, CR:CR.Mov)<BR>Asigna(Info.Estatus, CR:CR.Estatus)<BR>Asigna(Info.Situacion, CR:CR.Situacion)
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
ActivoCondicion=ConfigModulo(<T>CR<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(CR:CR.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CR:CR.ID)<BR>Asigna(Info.Mov, CR:CR.Mov)<BR>Asigna(Info.MovID, CR:CR.MovID)

[(Carpeta Abrir).CR.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=CR.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(CRA:CR.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CRA:CR.ID)
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

[Acciones.ReasignarUsuario]
Nombre=ReasignarUsuario
Boton=0
Menu=&Archivo
NombreDesplegar=Reasignar &Usuario...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ReasignarUsuario
Antes=S
ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CR:CR.ID)<BR>Asigna(Info.Usuario, CR:CR.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(CR:CR.ID)

[Ficha.CR.Referencia]
Carpeta=Ficha
Clave=CR.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=36
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
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>CR<T>)<BR>Asigna(Info.Fecha, CR:CR.FechaEmision)<BR>Asigna(Info.ID, CR:CR.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (CR:CR.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, CR:CR.Mov+<T> <T>+CR:CR.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(CR:CR.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CR:CR.ID)
Visible=S

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
Expresion=CopiarMovimiento(<T>CR<T>, CR:CR.ID, <T>CR<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (CR:CR.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(CR:CR.ID),GuardarCambios)
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

[Ficha.CR.UEN]
Carpeta=Ficha
Clave=CR.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ProyInfo]
Nombre=ProyInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del Proyecto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CR:CR.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, CR:CR.Proyecto)
Visible=S

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.Mov, CR:CR.Mov)<BR>Asigna(Info.Clave, <T>CR<T>+CR:CR.ID)<BR>Asigna(Info.Nombre, CR:CR.Mov+<T> <T>+CR:CR.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(CR:CR.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

[Ficha.CR.Caja]
Carpeta=Ficha
Clave=CR.Caja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.CtaDinero.Descripcion]
Carpeta=Ficha
Clave=CtaDinero.Descripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CR.Cajero]
Carpeta=Ficha
Clave=CR.Cajero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=35
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Abrir).CR.Caja]
Carpeta=(Carpeta Abrir)
Clave=CR.Caja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).CR.Cajero]
Carpeta=(Carpeta Abrir)
Clave=CR.Cajero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.CRDinero.Movimiento]
Carpeta=Dinero
Clave=CRDinero.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.CRDinero.CtaDinero]
Carpeta=Dinero
Clave=CRDinero.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.CRDinero.Referencia]
Carpeta=Dinero
Clave=CRDinero.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.CRDinero.Importe]
Carpeta=Dinero
Clave=CRDinero.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.Columnas]
Movimiento=85
CtaDinero=84
Referencia=94
Importe=120
Descripcion=97
FormaPago=84

[Dinero.CtaDineroDestino.Descripcion]
Carpeta=Dinero
Clave=CtaDineroDestino.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Venta.Columnas]
Articulo=120
Descripcion1=181
Importe=132
Cantidad=48
Operaciones=84

[Cobro.Columnas]
FormaPago=173
Referencia=207
Importe=185

[Ficha.Agente.Tipo]
Carpeta=Ficha
Clave=Agente.Tipo
Editar=S
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro
Pegado=N

[Acciones.CtaDineroInfo]
Nombre=CtaDineroInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información de la Caja
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CtaDineroInfo
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(CR:CR.Caja)
AntesExpresiones=Asigna(Info.CtaDinero, CR:CR.Caja)

[Acciones.AgenteInfo]
Nombre=AgenteInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del Agente
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CR:CR.Cajero)
Antes=S
AntesExpresiones=Asigna(Info.Agente, CR:CR.Cajero)
Visible=S

[(Carpeta Abrir).CtaDinero.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=CtaDinero.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Agente.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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
Totalizadores1=Venta Total
Totalizadores2=Suma(CRVenta:CRVenta.Importe)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Ventas
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Venta Total
CarpetaVisible=S

[(Carpeta Totalizadores).Venta Total]
Carpeta=(Carpeta Totalizadores)
Clave=Venta Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.CR.FechaD]
Carpeta=Ficha
Clave=CR.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CR.FechaA]
Carpeta=Ficha
Clave=CR.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Plantilla]
Nombre=Plantilla
Boton=20
NombreEnBoton=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=&Plantilla
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=EjecutarSQL(<T>spCRPlantilla :tEmpresa, :nSuc, :nID<T>, Empresa, CR:CR.Sucursal, CR:CR.ID)
ActivoCondicion=CR:CR.Estatus=EstatusSinAfectar

[Dinero.CRDinero.FormaPago]
Carpeta=Dinero
Clave=CRDinero.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agentes.CRAgente.Agente]
Carpeta=Agentes
Clave=CRAgente.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Agentes.Agente.Nombre]
Carpeta=Agentes
Clave=Agente.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Agentes.CRAgente.Cantidad]
Carpeta=Agentes
Clave=CRAgente.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Agentes.CRAgente.Importe]
Carpeta=Agentes
Clave=CRAgente.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Agentes.CRAgente.Operaciones]
Carpeta=Agentes
Clave=CRAgente.Operaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Agentes.Columnas]
Agente=122
Nombre=180
Cantidad=47
Importe=132
Operaciones=84

[Hoja.Columnas]
Tipo=69
Articulo=112
Agente=64
Cantidad=49
Operaciones=84
Movimiento=124
CtaDinero=64
FormaPago=107
Referencia=93
Importe=112

[Agente]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Vendedores
Clave=Agente
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CRAgente
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CR
LlaveLocal=CRAgente.ID
LlaveMaestra=CR.ID
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
CampoRenglon=CRAgente.Renglon
HojaFondoGrisAuto=S
CondicionVisible=Config.CRAgente

[Agente.CRAgente.Agente]
Carpeta=Agente
Clave=CRAgente.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Agente.CRAgente.Operaciones]
Carpeta=Agente
Clave=CRAgente.Operaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Agente.CRAgente.Cantidad]
Carpeta=Agente
Clave=CRAgente.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Agente.CRAgente.Importe]
Carpeta=Agente
Clave=CRAgente.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Agente.Columnas]
Agente=124
Operaciones=84
Cantidad=51
Importe=128
Nombre=177

[Agente.AgenteDestino.Nombre]
Carpeta=Agente
Clave=AgenteDestino.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Caja]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Caja
Clave=Caja
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CRCaja
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CR
LlaveLocal=CRCaja.ID
LlaveMaestra=CR.ID
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
CampoRenglon=CRCaja.Renglon
HojaFondoGrisAuto=S
CondicionVisible=Config.CRCaja

[Caja.CRCaja.Movimiento]
Carpeta=Caja
Clave=CRCaja.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Caja.CRCaja.CtaDinero]
Carpeta=Caja
Clave=CRCaja.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Caja.CRCaja.Referencia]
Carpeta=Caja
Clave=CRCaja.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Caja.CRCaja.Importe]
Carpeta=Caja
Clave=CRCaja.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Caja.CRCaja.FormaPago]
Carpeta=Caja
Clave=CRCaja.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Caja.Columnas]
Movimiento=109
CtaDinero=67
Descripcion=99
FormaPago=65
Referencia=72
Importe=95
Moneda=44
TipoCambio=61
FechaEmision=69
Concepto=92

[Ventas]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ventas Contado
Clave=Ventas
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CRVenta
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CR
LlaveLocal=CRVenta.ID
LlaveMaestra=CR.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaFondoGrisAuto=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ControlRenglon=S
CampoRenglon=CRVenta.Renglon
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=Art.Descripcion1
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CRVenta.Cxc=0

[Ventas.CRVenta.Articulo]
Carpeta=Ventas
Clave=CRVenta.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.CRVenta.Operaciones]
Carpeta=Ventas
Clave=CRVenta.Operaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.CRVenta.Cantidad]
Carpeta=Ventas
Clave=CRVenta.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.CRVenta.Importe]
Carpeta=Ventas
Clave=CRVenta.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Cobros]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cobros Contado
Clave=Cobros
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CRCobro
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CR
LlaveLocal=CRCobro.ID
LlaveMaestra=CR.ID
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
CampoRenglon=CRCobro.Renglon
HojaFondoGrisAuto=S
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CRCobro.Cxc=0

[Cobros.CRCobro.FormaPago]
Carpeta=Cobros
Clave=CRCobro.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Cobros.CRCobro.Referencia]
Carpeta=Cobros
Clave=CRCobro.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Cobros.CRCobro.Importe]
Carpeta=Cobros
Clave=CRCobro.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.Columnas]
Articulo=114
Descripcion1=160
Operaciones=84
Cantidad=52
Importe=87
SubCuenta=126
Cliente=66
Cxc=27
Almacen=59
DescripcionExtra=89
Precio=74
DescuentoLinea=44
ClienteEnviarA=46
Posicion=64
Mov=60
MovID=63

[Cobros.Columnas]
FormaPago=102
Referencia=168
Importe=122
Moneda=53
TipoCambio=61
Cliente=89
Vencimiento=78
Cxc=35
ClienteEnviarA=44

[Cobros.CRCobro.Moneda]
Carpeta=Cobros
Clave=CRCobro.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Cobros.CRCobro.TipoCambio]
Carpeta=Cobros
Clave=CRCobro.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Caja.CRCaja.Moneda]
Carpeta=Caja
Clave=CRCaja.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Caja.CRCaja.TipoCambio]
Carpeta=Caja
Clave=CRCaja.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Caja.CRCaja.FechaEmision]
Carpeta=Caja
Clave=CRCaja.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Caja.CRCaja.Concepto]
Carpeta=Caja
Clave=CRCaja.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CR.CajaFolio]
Carpeta=Ficha
Clave=CR.CajaFolio
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Acciones.Campos]
Nombre=Campos
Boton=0
Menu=&Edición
NombreDesplegar=&Campos...
EnMenu=S
TipoAccion=Formas
ClaveAccion=CRCampos
Antes=S
RefrescarDespues=S
ActivoCondicion=no FormaBloqueada y (CR:CR.Estatus<>EstatusSinAfectar)
AntesExpresiones=Asigna(Info.ID, CR:CR.ID)<BR>Asigna(Info.Mov, CR:CR.Mov)<BR>Asigna(Info.MovID, CR:CR.MovID)
Visible=S

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tareas
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.PuedeEditar, CR:CR.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, CR:CR.Mov)<BR>Asigna(Info.MovID, CR:CR.MovID)<BR>Asigna(Info.Proyecto, CR:CR.Proyecto)<BR>Asigna(Info.UEN, CR:CR.UEN)<BR>Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CR:CR.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, CR:CR.Cajero)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Ficha.CR.DocFuente]
Carpeta=Ficha
Clave=CR.DocFuente
3D=S
Tamano=10
ColorFondo=Plata
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
AntesExpresiones=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CR:CR.ID)<BR>Asigna(Info.Mov, CR:CR.Mov)<BR>Asigna(Info.MovID, CR:CR.MovID)<BR>Asigna(Info.Fecha, CR:CR.FechaEmision)<BR>Asigna(Info.Estatus, CR:CR.Estatus)

[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+O
NombreDesplegar=&Política
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(CR:CR.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CR<T>)<BR>Asigna(Info.Clave, CR:CR.Mov)

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
EjecucionCondicion=ConDatos(CR:CR.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.Concepto, CR:CR.Concepto)

[Ventas.CRVenta.SubCuenta]
Carpeta=Ventas
Clave=CRVenta.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=$00808040

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[Acciones.AsistenteArticulos]
Nombre=AsistenteArticulos
Boton=12
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=Asistente Artículos
EnBarraHerramientas=S
EnMenu=S
Carpeta=Ventas
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=CRVenta:CRVenta.Articulo<BR>Nulo<BR>CRVenta:CRVenta.SubCuenta<BR>CRVenta:CRVenta.Cantidad<BR>Nulo<BR>Falso<BR>Falso<BR>Verdadero<BR>Verdadero<BR>CRVenta:Art.Descripcion1<BR>CRVenta:Art.Tipo<BR>CRVenta:Art.Unidad<BR>CRVenta:Art.PrecioLista<BR>CRVenta:Art.TipoOpcion<BR>Falso<BR>Nulo<BR>Nulo<BR>Nulo
ListaParametros=S
Visible=S
EspacioPrevio=S
ActivoCondicion=CR:CR.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Ventas.CRVenta.Cliente]
Carpeta=Ventas
Clave=CRVenta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Cobros.CRCobro.Cliente]
Carpeta=Cobros
Clave=CRCobro.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Cobros.CRCobro.Vencimiento]
Carpeta=Cobros
Clave=CRCobro.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[InvFisico]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Inventario Físico
Clave=InvFisico
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CRInvFisico
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CR
LlaveLocal=CRInvFisico.ID
LlaveMaestra=CR.ID
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
CampoRenglon=CRInvFisico.Renglon
HojaFondoGrisAuto=S
CondicionVisible=Config.CRInvFisico

[InvFisico.CRInvFisico.Articulo]
Carpeta=InvFisico
Clave=CRInvFisico.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[InvFisico.CRInvFisico.SubCuenta]
Carpeta=InvFisico
Clave=CRInvFisico.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=$00808040

[InvFisico.Art.Descripcion1]
Carpeta=InvFisico
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[InvFisico.CRInvFisico.Cantidad]
Carpeta=InvFisico
Clave=CRInvFisico.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[InvFisico.Columnas]
Articulo=131
SubCuenta=150
Descripcion1=349
Cantidad=62
Unidad=61
Posicion=64

[Soporte]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Atención a Clientes
Clave=Soporte
ValidarCampos=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CRSoporte
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CR
LlaveLocal=CRSoporte.ID
LlaveMaestra=CR.ID
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
ListaCamposAValidar=Cte.Nombre
ControlRenglon=S
CampoRenglon=CRSoporte.Renglon
MenuLocal=S
ListaAcciones=Problema
HojaFondoGrisAuto=S
CondicionVisible=Config.CRSoporte

[Soporte.CRSoporte.Mov]
Carpeta=Soporte
Clave=CRSoporte.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.CRSoporte.Cliente]
Carpeta=Soporte
Clave=CRSoporte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.CRSoporte.Titulo]
Carpeta=Soporte
Clave=CRSoporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Columnas]
Mov=98
Cliente=80
Titulo=316
Contacto=111
Telefono=73

[Acciones.Problema]
Nombre=Problema
Boton=0
NombreDesplegar=&Problema
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CRSoporteProblema
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
AntesExpresiones=Asigna(Info.ID, CR:CR.ID)<BR>Asigna(Info.Renglon, CRSoporte:CRSoporte.Renglon)<BR>Asigna(Info.Nombre, CRSoporte:CRSoporte.Titulo)<BR>Asigna(Info.Bloqueado, CR:CR.Estatus<>EstatusSinAfectar)

[Ventas.CRVenta.Almacen]
Carpeta=Ventas
Clave=CRVenta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.CRSoporte.Contacto]
Carpeta=Soporte
Clave=CRSoporte.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.CRSoporte.Telefono]
Carpeta=Soporte
Clave=CRSoporte.Telefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.CRVenta.DescripcionExtra]
Carpeta=Ventas
Clave=CRVenta.DescripcionExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.CRVenta.Precio]
Carpeta=Ventas
Clave=CRVenta.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.CRVenta.DescuentoLinea]
Carpeta=Ventas
Clave=CRVenta.DescuentoLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Disponible]
Nombre=Disponible
Boton=47
Menu=&Ver
UsaTeclaRapida=S
NombreDesplegar=&Disponible del Artículo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
TeclaRapida=Ctrl+D
Expresion=Asigna(Info.Origen, <T>VTAS<T>)<BR>Asigna(Info.Articulo, CRVenta:CRVenta.Articulo)<BR>Asigna(Info.Descripcion, CRVenta:Art.Descripcion1)<BR>Asigna(Info.ArtTipo, CRVenta:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, CRVenta:Art.TipoOpcion)<BR>Asigna(Info.Almacen, CRVenta:CRVenta.Almacen)<BR>Forma(<T>ArtAlmExistencia<T>)
EjecucionCondicion=ConDatos(CRVenta:CRVenta.Articulo) y ConDatos(CRVenta:CRVenta.Almacen)

[VentaCxc]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ventas Crédito
Clave=VentaCxc
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CRVentaCxc
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CR
LlaveLocal=CRVentaCxc.ID
LlaveMaestra=CR.ID
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
CampoRenglon=CRVentaCxc.Renglon
ValidarCampos=S
ListaCamposAValidar=Art.Descripcion1
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaFondoGrisAuto=S
FiltroGeneral=CRVentaCxc.Cxc=1
CondicionVisible=Config.CRCxc

[VentaCxc.Columnas]
Articulo=114
Operaciones=84
Cantidad=51
Precio=75
DescuentoLinea=46
Importe=87
Almacen=59
Cliente=63
DescripcionExtra=90
ClienteEnviarA=46
SubCuenta=304
Posicion=64
Mov=60
MovID=63

[VentaCxc.CRVentaCxc.Articulo]
Carpeta=VentaCxc
Clave=CRVentaCxc.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.SubCuenta]
Carpeta=VentaCxc
Clave=CRVentaCxc.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=$00808040

[VentaCxc.CRVentaCxc.Operaciones]
Carpeta=VentaCxc
Clave=CRVentaCxc.Operaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.Cantidad]
Carpeta=VentaCxc
Clave=CRVentaCxc.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.Precio]
Carpeta=VentaCxc
Clave=CRVentaCxc.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.DescuentoLinea]
Carpeta=VentaCxc
Clave=CRVentaCxc.DescuentoLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.Importe]
Carpeta=VentaCxc
Clave=CRVentaCxc.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.DescripcionExtra]
Carpeta=VentaCxc
Clave=CRVentaCxc.DescripcionExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.Almacen]
Carpeta=VentaCxc
Clave=CRVentaCxc.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.Cliente]
Carpeta=VentaCxc
Clave=CRVentaCxc.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[CobroCxc]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cobro Crédito
Clave=CobroCxc
Filtros=S
ValidarCampos=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CRCobroCxc
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CR
LlaveLocal=CRCobroCxc.ID
LlaveMaestra=CR.ID
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
ListaCamposAValidar=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ControlRenglon=S
CampoRenglon=CRCobroCxc.Renglon
HojaFondoGrisAuto=S
FiltroGeneral=CRCobroCxc.Cxc=1

[CobroCxc.CRCobroCxc.FormaPago]
Carpeta=CobroCxc
Clave=CRCobroCxc.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[CobroCxc.CRCobroCxc.Referencia]
Carpeta=CobroCxc
Clave=CRCobroCxc.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[CobroCxc.CRCobroCxc.Importe]
Carpeta=CobroCxc
Clave=CRCobroCxc.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[CobroCxc.CRCobroCxc.Moneda]
Carpeta=CobroCxc
Clave=CRCobroCxc.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[CobroCxc.CRCobroCxc.TipoCambio]
Carpeta=CobroCxc
Clave=CRCobroCxc.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[CobroCxc.CRCobroCxc.Cliente]
Carpeta=CobroCxc
Clave=CRCobroCxc.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[CobroCxc.CRCobroCxc.Vencimiento]
Carpeta=CobroCxc
Clave=CRCobroCxc.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[CobroCxc.Columnas]
FormaPago=98
Referencia=157
Importe=128
Moneda=67
TipoCambio=64
Cliente=78
Vencimiento=79
ClienteEnviarA=46

[Ventas.CRVenta.ClienteEnviarA]
Carpeta=Ventas
Clave=CRVenta.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.ClienteEnviarA]
Carpeta=VentaCxc
Clave=CRVentaCxc.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Cobros.CRCobro.ClienteEnviarA]
Carpeta=Cobros
Clave=CRCobro.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[CobroCxc.CRCobroCxc.ClienteEnviarA]
Carpeta=CobroCxc
Clave=CRCobroCxc.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Expresion=Asigna(Info.Forma, <T>CR<T>)<BR>Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.Mov, CR:CR.Mov)<BR>Asigna(Info.Nombre, CR:CR.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

[Transferencias]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Transferencias
Clave=Transferencias
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CRTrans
Fuente={Tahoma, 8, Negro, []}
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
PermiteEditar=S
Detalle=S
VistaMaestra=CR
LlaveLocal=CRTrans.ID
LlaveMaestra=CR.ID
ControlRenglon=S
CampoRenglon=CRTrans.Renglon
HojaFondoGrisAuto=S
CondicionVisible=Config.CRTransferencias

[Transferencias.CRTrans.Articulo]
Carpeta=Transferencias
Clave=CRTrans.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Transferencias.CRTrans.SubCuenta]
Carpeta=Transferencias
Clave=CRTrans.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Transferencias.CRTrans.Cantidad]
Carpeta=Transferencias
Clave=CRTrans.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Transferencias.CRTrans.AlmacenOrigen]
Carpeta=Transferencias
Clave=CRTrans.AlmacenOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Transferencias.CRTrans.AlmacenDestino]
Carpeta=Transferencias
Clave=CRTrans.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Transferencias.Columnas]
Articulo=124
Cantidad=64
AlmacenOrigen=81
AlmacenDestino=83
SubCuenta=132
Posicion=64

[VentaCxc.CRVentaCxc.Posicion]
Carpeta=VentaCxc
Clave=CRVentaCxc.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CR<T>, CR:CR.Mov, CR:CR.ID, Falso, CR:CR.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CR<T>+CR:CR.ID)<BR>  Asigna(Info.Nombre, CR:CR.Mov+<T> <T>+CR:CR.MovID)<BR>  Asigna(Info.Modulo, <T>CR<T>)<BR>  Asigna(Info.Mov, CR:CR.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      CR:CR.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CR:CR.ID)<BR>Asigna(Info.Mov, CR:CR.Mov)<BR>Asigna(Info.MovID, CR:CR.MovID)
DespuesGuardar=S
Visible=S

[Ventas.CRVenta.Mov]
Carpeta=Ventas
Clave=CRVenta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.CRVenta.MovID]
Carpeta=Ventas
Clave=CRVenta.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.Mov]
Carpeta=VentaCxc
Clave=CRVentaCxc.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VentaCxc.CRVentaCxc.MovID]
Carpeta=VentaCxc
Clave=CRVentaCxc.MovID
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
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CR<T>, <T>{CR:CR.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CR{CR:CR.ID}<T>

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




[Ficha.ListaEnCaptura]
(Inicio)=CR.Mov
CR.Mov=CR.MovID
CR.MovID=CR.Proyecto
CR.Proyecto=CR.UEN
CR.UEN=CR.Moneda
CR.Moneda=CR.TipoCambio
CR.TipoCambio=CR.FechaEmision
CR.FechaEmision=CR.Caja
CR.Caja=CtaDinero.Descripcion
CtaDinero.Descripcion=CR.CajaFolio
CR.CajaFolio=CR.Cajero
CR.Cajero=Agente.Nombre
Agente.Nombre=Agente.Tipo
Agente.Tipo=CR.FechaD
CR.FechaD=CR.FechaA
CR.FechaA=CR.Concepto
CR.Concepto=CR.Referencia
CR.Referencia=CR.Observaciones
CR.Observaciones=CR.DocFuente
CR.DocFuente=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=CR.FechaEmision
CR.FechaEmision=CR.Caja
CR.Caja=CtaDinero.Descripcion
CtaDinero.Descripcion=CR.Cajero
CR.Cajero=Agente.Nombre
Agente.Nombre=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)

[Agente.ListaEnCaptura]
(Inicio)=CRAgente.Agente
CRAgente.Agente=AgenteDestino.Nombre
AgenteDestino.Nombre=CRAgente.Operaciones
CRAgente.Operaciones=CRAgente.Cantidad
CRAgente.Cantidad=CRAgente.Importe
CRAgente.Importe=(Fin)

[Caja.ListaEnCaptura]
(Inicio)=CRCaja.Movimiento
CRCaja.Movimiento=CRCaja.Concepto
CRCaja.Concepto=CRCaja.FormaPago
CRCaja.FormaPago=CRCaja.Referencia
CRCaja.Referencia=CRCaja.Importe
CRCaja.Importe=CRCaja.CtaDinero
CRCaja.CtaDinero=CRCaja.FechaEmision
CRCaja.FechaEmision=CRCaja.Moneda
CRCaja.Moneda=CRCaja.TipoCambio
CRCaja.TipoCambio=(Fin)

[Ventas.ListaEnCaptura]
(Inicio)=CRVenta.Articulo
CRVenta.Articulo=CRVenta.SubCuenta
CRVenta.SubCuenta=CRVenta.Operaciones
CRVenta.Operaciones=CRVenta.Cantidad
CRVenta.Cantidad=CRVenta.Precio
CRVenta.Precio=CRVenta.DescuentoLinea
CRVenta.DescuentoLinea=CRVenta.Importe
CRVenta.Importe=CRVenta.DescripcionExtra
CRVenta.DescripcionExtra=CRVenta.Almacen
CRVenta.Almacen=CRVenta.Cliente
CRVenta.Cliente=CRVenta.ClienteEnviarA
CRVenta.ClienteEnviarA=CRVenta.Mov
CRVenta.Mov=CRVenta.MovID
CRVenta.MovID=(Fin)

[Cobros.ListaEnCaptura]
(Inicio)=CRCobro.FormaPago
CRCobro.FormaPago=CRCobro.Referencia
CRCobro.Referencia=CRCobro.Importe
CRCobro.Importe=CRCobro.Moneda
CRCobro.Moneda=CRCobro.TipoCambio
CRCobro.TipoCambio=CRCobro.Cliente
CRCobro.Cliente=CRCobro.ClienteEnviarA
CRCobro.ClienteEnviarA=CRCobro.Vencimiento
CRCobro.Vencimiento=(Fin)

[Cobros.ListaCamposAValidar]
(Inicio)=Cte.Nombre
Cte.Nombre=CteEnviarA.Nombre
CteEnviarA.Nombre=(Fin)

[InvFisico.ListaEnCaptura]
(Inicio)=CRInvFisico.Articulo
CRInvFisico.Articulo=CRInvFisico.SubCuenta
CRInvFisico.SubCuenta=Art.Descripcion1
Art.Descripcion1=CRInvFisico.Cantidad
CRInvFisico.Cantidad=(Fin)

[Soporte.ListaEnCaptura]
(Inicio)=CRSoporte.Mov
CRSoporte.Mov=CRSoporte.Cliente
CRSoporte.Cliente=CRSoporte.Contacto
CRSoporte.Contacto=CRSoporte.Telefono
CRSoporte.Telefono=CRSoporte.Titulo
CRSoporte.Titulo=(Fin)

[VentaCxc.ListaEnCaptura]
(Inicio)=CRVentaCxc.Articulo
CRVentaCxc.Articulo=CRVentaCxc.SubCuenta
CRVentaCxc.SubCuenta=CRVentaCxc.Operaciones
CRVentaCxc.Operaciones=CRVentaCxc.Cantidad
CRVentaCxc.Cantidad=CRVentaCxc.Precio
CRVentaCxc.Precio=CRVentaCxc.DescuentoLinea
CRVentaCxc.DescuentoLinea=CRVentaCxc.Importe
CRVentaCxc.Importe=CRVentaCxc.DescripcionExtra
CRVentaCxc.DescripcionExtra=CRVentaCxc.Almacen
CRVentaCxc.Almacen=CRVentaCxc.Posicion
CRVentaCxc.Posicion=CRVentaCxc.Cliente
CRVentaCxc.Cliente=CRVentaCxc.ClienteEnviarA
CRVentaCxc.ClienteEnviarA=CRVentaCxc.Mov
CRVentaCxc.Mov=CRVentaCxc.MovID
CRVentaCxc.MovID=(Fin)

[CobroCxc.ListaEnCaptura]
(Inicio)=CRCobroCxc.FormaPago
CRCobroCxc.FormaPago=CRCobroCxc.Referencia
CRCobroCxc.Referencia=CRCobroCxc.Importe
CRCobroCxc.Importe=CRCobroCxc.Moneda
CRCobroCxc.Moneda=CRCobroCxc.TipoCambio
CRCobroCxc.TipoCambio=CRCobroCxc.Cliente
CRCobroCxc.Cliente=CRCobroCxc.ClienteEnviarA
CRCobroCxc.ClienteEnviarA=CRCobroCxc.Vencimiento
CRCobroCxc.Vencimiento=(Fin)

[CobroCxc.ListaCamposAValidar]
(Inicio)=Cte.Nombre
Cte.Nombre=CteEnviarA.Nombre
CteEnviarA.Nombre=(Fin)

[Transferencias.ListaEnCaptura]
(Inicio)=CRTrans.Articulo
CRTrans.Articulo=CRTrans.SubCuenta
CRTrans.SubCuenta=CRTrans.Cantidad
CRTrans.Cantidad=CRTrans.AlmacenOrigen
CRTrans.AlmacenOrigen=CRTrans.AlmacenDestino
CRTrans.AlmacenDestino=(Fin)

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






















[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Ventas
Ventas=Cobros
Cobros=VentaCxc
VentaCxc=CobroCxc
CobroCxc=Agente
Agente=Caja
Caja=Transferencias
Transferencias=InvFisico
InvFisico=Soporte
Soporte=FormaExtraValor
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
FormasAnexas=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Afectar
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=CambiarVista
CambiarVista=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=AsistenteArticulos
AsistenteArticulos=Plantilla
Plantilla=Totalizar
Totalizar=Tareas
Tareas=Anexos
Anexos=Anterior
Anterior=Siguiente
Siguiente=CtaDineroInfo
CtaDineroInfo=AgenteInfo
AgenteInfo=ProyInfo
ProyInfo=Disponible
Disponible=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
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
