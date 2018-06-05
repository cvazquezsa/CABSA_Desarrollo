[Forma]
Clave=ProcesarCompra
Nombre=Compras - Procesar en Lote
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=124
PosicionInicialArriba=139
PosicionInicialAltura=503
PosicionInicialAncho=1032
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=91
EsMovimiento=S
TituloAuto=S
MovModulo=COMS
MovEspecificos=Todos
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=712

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraP
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
BusquedaRapidaControles=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroUsuarioDefault=(Usuario)
FiltroFechasNormal=S
FiltroMonedasCampo=Compra.Moneda
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
MenuLocal=S
ListaAcciones=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
BusquedaRespetarFiltros=S
BusquedaRespetarUsuario=S
FiltroFechasCampo=FechaEmision
FiltroFechasDefault=(Todo)
IconosSeleccionMultiple=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroMovDefault=(Todos)
FiltroSituacionTodo=S
IconosConSenales=S
FiltroEstatus=S
FiltroUsuarios=S
FiltroSucursales=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Alm
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Alm
FiltroAutoOrden=Alm
FiltroTodo=S
FiltroAplicaEn=e.Almacen
FiltroAplicaEn1=e.Almacen
FiltroSituacion=S
IconosNombre=CompraP:Mov+<T> <T>+CompraP:MovID

[Lista.Columnas]
0=127
1=76

[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CompraP:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, CompraP:ID)

[Acciones.LocalPropiedades]
Nombre=LocalPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(CompraP:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, CompraP:ID)

[Acciones.Localizar]
Nombre=Localizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Acciones.LocalizarSiguiente]
Nombre=LocalizarSiguiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Enviar a Excel]
Nombre=Enviar a Excel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.LocalCampos]
Nombre=LocalCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.NombreEstatus]
Carpeta=Lista
Clave=NombreEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FechaEmision]
Carpeta=Lista
Clave=FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Nombre]
Carpeta=Lista
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Importe]
Carpeta=Lista
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0
Tamano=30

[Lista.Pendiente]
Carpeta=Lista
Clave=Pendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ImprimirSeleccion]
Nombre=ImprimirSeleccion
Boton=0
NombreDesplegar=&Imprimir Lote
EnMenu=S
TipoAccion=Expresion
Visible=S
EnLote=S
RefrescarIconos=S
ConCondicion=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>COMS<T>, CompraP:Mov, CompraP:e.Estatus), CompraP:ID)
ActivoCondicion=Usuario.ImprimirMovs
EjecucionCondicion=ConDatos(CompraP:ID)

[Acciones.CancelarPendiente]
Nombre=CancelarPendiente
Boton=0
NombreDesplegar=Cancelar Lote (Cantidad Pendiente)
RefrescarIconos=S
EnLote=S
EnMenu=S
TipoAccion=Expresion
Expresion=Cancelar(<T>COMS<T>, CompraP:ID, CompraP:Mov, CompraP:MovID, <T>PENDIENTE<T>, <T><T>, <T>ProcesarCompra<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, CompraP:e.Usuario) y ConDatos(CompraP:ID) y ConDatos(CompraP:MovID)
VisibleCondicion=Usuario.CancelarLote

[Acciones.CompraPerdida]
Nombre=CompraPerdida
Boton=0
NombreDesplegar=Compra Perdida Lote
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
Expresion=RegistrarSeleccionID<BR>ProcesarSQL(<T>spAfectarLoteLista :nEstacion, :tEmpresa, :tModulo, :tAccion, :tBase, :tGenerarMov, :tUsuario, :tFactLote<T>, EstacionTrabajo, Empresa, <T>COMS<T>, <T>GENERAR<T>, <T>PENDIENTE<T>, ConfigMov.CompraPerdida, Usuario, <T>Proveedor<T>)<BR>Forma(<T>ListaIDOk<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, CompraP:e.Usuario)
VisibleCondicion=Usuario.AfectarLote

[Acciones.CancelarMov]
Nombre=CancelarMov
Boton=0
NombreDesplegar=Cancelar Lote (Movimiento Completo)
RefrescarIconos=S
EnLote=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Cancelar(<T>COMS<T>, CompraP:ID, CompraP:Mov, CompraP:MovID, <T>TODO<T>, <T><T>, <T>ProcesarCompra<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, CompraP:e.Usuario) y ConDatos(CompraP:ID) y ConDatos(CompraP:MovID)
VisibleCondicion=Usuario.CancelarLote

[Acciones.Afectar]
Nombre=Afectar
Boton=0
NombreDesplegar=&Afectar Lote
EnMenu=S
TipoAccion=Expresion
EspacioPrevio=S
ConCondicion=S
RefrescarIconos=S
EnLote=S
Expresion=Afectar(<T>COMS<T>, CompraP:ID, CompraP:Mov, CompraP:MovID, <T>Todo<T>, <T><T>, <T>ProcesarCompra<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, CompraP:e.Usuario)
EjecucionCondicion=CompraP:e.Estatus=EstatusSinAfectar
VisibleCondicion=Usuario.AfectarLote

[Acciones.Nota]
Nombre=Nota
Boton=22
NombreDesplegar=&Nota
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Dialogos
Activo=S
Visible=S
NombreEnBoton=S
ClaveAccion=ProcesoEnLote

[Lista.e.Proveedor]
Carpeta=Lista
Clave=e.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Comprar]
Nombre=Comprar
Boton=0
NombreDesplegar=&Comprar Lote...
RefrescarIconos=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=RegistrarSeleccionID<BR>ProcesarSQL(<T>spAfectarLoteLista :nEstacion, :tEmpresa, :tModulo, :tAccion, :tBase, :tGenerarMov, :tUsuario, :tFactLote<T>, EstacionTrabajo, Empresa, <T>COMS<T>, <T>GENERAR<T>, <T>TODO<T>, ConfigMov.CompraEntrada, Usuario, <T>Proveedor<T>)<BR>Forma(<T>ListaIDOk<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, CompraP:e.Usuario)
VisibleCondicion=Usuario.AfectarLote

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Seleccionar Todo
Seleccionar Todo=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=Nota
Nota=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=NombreEstatus
NombreEstatus=FechaEmision
FechaEmision=e.Proveedor
e.Proveedor=Nombre
Nombre=Pendiente
Pendiente=Importe
Importe=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalPropiedades
LocalPropiedades=Localizar
Localizar=LocalizarSiguiente
LocalizarSiguiente=SeleccionarTodo
SeleccionarTodo=QuitarSeleccion
QuitarSeleccion=Afectar
Afectar=ImprimirSeleccion
ImprimirSeleccion=Comprar
Comprar=CancelarMov
CancelarMov=CancelarPendiente
CancelarPendiente=CompraPerdida
CompraPerdida=Imprimir
Imprimir=Preliminar
Preliminar=Enviar a Excel
Enviar a Excel=LocalCampos
LocalCampos=(Fin)
