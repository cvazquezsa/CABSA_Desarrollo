[Forma]
Clave=ProcesarVenta
Nombre=Ventas - Procesar en Lote
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=124
PosicionInicialArriba=142
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
MovModulo=VTAS
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
Vista=VentaP
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
FiltroMonedasCampo=Venta.Moneda
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
IconosNombre=VentaP:Mov+<T> <T>+VentaP:MovID

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
EjecucionCondicion=ConDatos(VentaP:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaP:ID)

[Acciones.LocalPropiedades]
Nombre=LocalPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(VentaP:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaP:ID)

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

[Acciones.Reservar]
Nombre=Reservar
Boton=0
NombreDesplegar=&Reservar Lote
RefrescarIconos=S
EnLote=S
EnMenu=S
TipoAccion=Expresion
Expresion=Reservar(<T>VTAS<T>, VentaP:ID, VentaP:Mov, VentaP:MovID, <T>PENDIENTE<T>, <T><T>, <T>ProcesarVenta<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, VentaP:e.Usuario)
VisibleCondicion=Usuario.AfectarLote

[Acciones.Desreservar]
Nombre=Desreservar
Boton=0
NombreDesplegar=&Des-Reservar Lote
RefrescarIconos=S
EnLote=S
EnMenu=S
TipoAccion=Expresion
Expresion=DesReservar(<T>VTAS<T>, VentaP:ID, VentaP:Mov, VentaP:MovID, <T>RESERVADO<T>, <T><T>, <T>ProcesarVenta<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, VentaP:e.Usuario)
VisibleCondicion=Usuario.AfectarLote

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

[Lista.Reservado]
Carpeta=Lista
Clave=Reservado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=30

[Lista.Ordenado]
Carpeta=Lista
Clave=Ordenado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=30

[Lista.e.Cliente]
Carpeta=Lista
Clave=e.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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
Expresion=ReporteImpresora(ReporteMovImpresora(<T>VTAS<T>, VentaP:Mov, VentaP:e.Estatus), VentaP:ID)
ActivoCondicion=Usuario.ImprimirMovs
EjecucionCondicion=ConDatos(VentaP:ID)

[Acciones.CancelarPendiente]
Nombre=CancelarPendiente
Boton=0
NombreDesplegar=Cancelar Lote (Cantidad Pendiente)
RefrescarIconos=S
EnLote=S
EnMenu=S
TipoAccion=Expresion
Expresion=Cancelar(<T>VTAS<T>, VentaP:ID, VentaP:Mov, VentaP:MovID, <T>PENDIENTE<T>, <T><T>, <T>ProcesarVenta<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, VentaP:e.Usuario) y ConDatos(VentaP:ID) y ConDatos(VentaP:MovID)
VisibleCondicion=Usuario.CancelarLote

[Acciones.VentaPerdida]
Nombre=VentaPerdida
Boton=0
NombreDesplegar=Venta Perdida Lote
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
Expresion=RegistrarSeleccionID<BR>ProcesarSQL(<T>spAfectarLoteLista :nEstacion, :tEmpresa, :tModulo, :tAccion, :tBase, :tGenerarMov, :tUsuario, :tFactLote<T>, EstacionTrabajo, Empresa, <T>VTAS<T>, <T>GENERAR<T>, <T>PENDIENTE<T>, ConfigMov.VentaPerdida, Usuario, <T>Cliente<T>)<BR>Forma(<T>ListaIDOk<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, VentaP:e.Usuario)
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
Expresion=Cancelar(<T>VTAS<T>, VentaP:ID, VentaP:Mov, VentaP:MovID, <T>TODO<T>, <T><T>, <T>ProcesarVenta<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, VentaP:e.Usuario) y ConDatos(VentaP:ID) y ConDatos(VentaP:MovID)
VisibleCondicion=Usuario.CancelarLote

[Acciones.Concluir]
Nombre=Concluir
Boton=0
NombreDesplegar=Concluir &Facturas Lote
EnMenu=S
TipoAccion=Expresion
RefrescarIconos=S
EnLote=S
Expresion=Afectar(<T>VTAS<T>, VentaP:ID, VentaP:Mov, VentaP:MovID, <T>Todo<T>, <T><T>, <T>ProcesarVenta<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, VentaP:e.Usuario)
VisibleCondicion=Usuario.AfectarLote y Config.FacturasPendientesSerieLote

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
Expresion=Afectar(<T>VTAS<T>, VentaP:ID, VentaP:Mov, VentaP:MovID, <T>Todo<T>, <T><T>, <T>ProcesarVenta<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, VentaP:e.Usuario)
EjecucionCondicion=VentaP:e.Estatus=EstatusSinAfectar
VisibleCondicion=Usuario.AfectarLote

[Acciones.Facturar]
Nombre=Facturar
Boton=0
NombreDesplegar=&Facturar Lote...
EnMenu=S
TipoAccion=Expresion
RefrescarIconos=S
EspacioPrevio=S
Expresion=Si<BR>  Forma(<T>EspecificarMovFactura<T>) y (MovTipo(<T>VTAS<T>, Info.MovFactura) = VTAS.F)<BR>Entonces<BR>  RegistrarSeleccionID<BR>  ProcesarSQL(<T>spAfectarLoteLista :nEstacion, :tEmpresa, :tModulo, :tAccion, :tBase, :tGenerarMov, :tUsuario, :tFactLote<T>, EstacionTrabajo, Empresa, <T>VTAS<T>, <T>GENERAR<T>, <T>TODO<T>, Info.MovFactura, Usuario, Info.FacturarLote)<BR>  Forma(<T>ListaIDOk<T>)<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, VentaP:e.Usuario)
VisibleCondicion=Usuario.AfectarLote

[Acciones.DesEmbarcar]
Nombre=DesEmbarcar
Boton=0
NombreDesplegar=Desembarcar Lote
EnMenu=S
TipoAccion=Expresion
Activo=S
EnLote=S
RefrescarIconos=S
Expresion=EjecutarSQL(<T>spEmbarqueManual :tEmpresa, :tModulo, :nID, :tMov, :tMovID, :tEstatus, 1, 1<T>, VentaP:Empresa, <T>VTAS<T>, VentaP:ID, VentaP:Mov, VentaP:MovID, VentaP:e.Estatus)
VisibleCondicion=Usuario.AfectarLote

[Acciones.Embarcar]
Nombre=Embarcar
Boton=0
NombreDesplegar=Embarcar Lote
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
EnLote=S
RefrescarIconos=S
Expresion=EjecutarSQL(<T>spEmbarqueManual :tEmpresa, :tModulo, :nID, :tMov, :tMovID, :tEstatus, 0, 1<T>, VentaP:Empresa, <T>VTAS<T>, VentaP:ID, VentaP:Mov, VentaP:MovID, VentaP:e.Estatus)
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

[Acciones.FacturacionRapida]
Nombre=FacturacionRapida
Boton=0
NombreDesplegar=Fac&turación Rápida Lote
EnMenu=S
TipoAccion=Expresion
RefrescarIconos=S
EnLote=S
Expresion=EjecutarSQL(<T>spFacturacionRapida :nID, :tUsuario, :tEmpresa<T>, VentaP:ID, Usuario, Empresa)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, VentaP:e.Usuario)
VisibleCondicion=Usuario.AfectarLote y (Config.VentaLimiteRenFacturas>0)

[Acciones.FacturacionRapidaAgrupada]
Nombre=FacturacionRapidaAgrupada
Boton=0
NombreDesplegar=Fac&turación Rápida Agrupada Lote 
EnMenu=S
TipoAccion=Expresion
RefrescarIconos=S
EnLote=S
Expresion=EjecutarSQL(<T>spFacturacionRapida :nID, :tUsuario, :tEmpresa, 1<T>, VentaP:ID, Usuario, Empresa)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, VentaP:e.Usuario)
VisibleCondicion=Usuario.AfectarLote y (Config.VentaLimiteRenFacturas>0)

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
FechaEmision=e.Cliente
e.Cliente=Nombre
Nombre=Pendiente
Pendiente=Reservado
Reservado=Ordenado
Ordenado=Importe
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
QuitarSeleccion=Embarcar
Embarcar=DesEmbarcar
DesEmbarcar=Afectar
Afectar=Concluir
Concluir=Reservar
Reservar=Desreservar
Desreservar=ImprimirSeleccion
ImprimirSeleccion=Facturar
Facturar=FacturacionRapida
FacturacionRapida=FacturacionRapidaAgrupada
FacturacionRapidaAgrupada=CancelarMov
CancelarMov=CancelarPendiente
CancelarPendiente=VentaPerdida
VentaPerdida=Imprimir
Imprimir=Preliminar
Preliminar=Enviar a Excel
Enviar a Excel=LocalCampos
LocalCampos=(Fin)
