
[Forma]
Clave=WMSProcesarCompra
Nombre=Compras - Procesar Ordenes Pre Entarimado en Lote
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=178
PosicionInicialArriba=61
PosicionInicialAltura=503
PosicionInicialAncho=966
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
MovEspecificos=Especificos
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=565

MovimientosValidos=Orden Pre Entarimado
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSCompraP
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
FiltroMovDefault=Orden Pre Entarimado
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

IconosNombre=WMSCompraP:Mov+<T> <T>+WMSCompraP:MovID
[Lista.Columnas]
0=127
1=139
2=84
3=76
4=185
5=71
6=71
7=60
8=87
9=170
10=59
11=76
12=64
13=83
14=71
15=56
16=97
17=92
18=24
19=51
20=56
21=56
22=56
23=56
24=72
25=81
26=81
27=81
28=81
29=64
30=73
31=73
32=73
33=73
34=47
35=41

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
EjecucionCondicion=ConDatos(WMSCompraP:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, WMSCompraP:ID)

[Acciones.LocalPropiedades]
Nombre=LocalPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(WMSCompraP:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, WMSCompraP:ID)

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


[Lista.FechaEmision]
Carpeta=Lista
Clave=FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Nombre]
Carpeta=Lista
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Importe]
Carpeta=Lista
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
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


[Lista.e.Proveedor]
Carpeta=Lista
Clave=e.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Acciones.ComprarSinAfectar]
Nombre=ComprarSinAfectar
Boton=0
NombreDesplegar=&Comprar Lote (Sin Afectar)...
EnMenu=S
TipoAccion=Expresion
RefrescarIconos=S
Expresion=RegistrarSeleccionID<BR>ProcesarSQL(<T>spAfectarLoteLista :nEstacion, :tEmpresa, :tModulo, :tAccion, :tBase, :tGenerarMov, :tUsuario, :tFactLote<T>, EstacionTrabajo, Empresa, <T>COMS<T>, <T>GENERAR<T>, <T>TODO<T>, ConfigMov.CompraEntrada, Usuario, <T>Proveedor<T>)<BR>Forma(<T>ListaIDOk<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, WMSCompraP:e.Usuario)
VisibleCondicion=Usuario.AfectarLote





[Acciones.GenerarEntradaCompra]
Nombre=GenerarEntradaCompra
Boton=0
NombreDesplegar=&Generar Entrada de Compra...
RefrescarIconos=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S












Expresion=RegistrarSeleccionID<BR>Asigna(Info.Anuncio, SQL(<T>spGenerarCompraLoteLista :nEstacion, :tEmpresa, :tModulo, :tAccion, :tBase, :tGenerarMov, :tUsuario, :tFactLote<T>, EstacionTrabajo, Empresa, <T>COMS<T>, <T>GENERAR<T>, <T>TODO<T>, ConfigMov.CompraEntrada, Usuario, <T>Proveedor<T>))<BR><BR>Si EsNumerico(Info.Anuncio) = Verdadero<BR>Entonces<BR>  Asigna(Info.ID, Info.Anuncio)<BR>  <BR>  FormaPos(<T>Compra<T>,Info.ID)<BR>Sino<BR>  Error(Info.Anuncio)<BR>Fin
[Lista.MovOrigen]
Carpeta=Lista
Clave=MovOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
































































[Lista.ListaEnCaptura]
(Inicio)=MovOrigen
MovOrigen=FechaEmision
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
QuitarSeleccion=GenerarEntradaCompra
GenerarEntradaCompra=Imprimir
Imprimir=Preliminar
Preliminar=Enviar a Excel
Enviar a Excel=LocalCampos
LocalCampos=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Seleccionar Todo
Seleccionar Todo=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
