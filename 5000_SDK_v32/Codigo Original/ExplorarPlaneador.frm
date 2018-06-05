[Forma]
Clave=ExplorarPlaneador
Nombre=Planeador Ordenes
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialAltura=502
PosicionInicialAncho=855
PosicionInicialIzquierda=84
PosicionInicialArriba=129
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
Comentarios=Asigna(Info.PlanReferencia, SQL(<T>SELECT PlanReferencia FROM Version<T>))<BR>Lista(Info.Accion, Info.PlanReferencia)
PosicionSeccion1=77
PosicionInicialAlturaCliente=475
ExpresionesAlMostrar=Asigna(Info.Accion, <T>Comprar<T>)<BR>Asigna(Ver.Sucursal, Falso)
MenuPrincipal=(Lista)
ForzarSDI=S
VentanaSiempreAlFrente=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlanArtOP
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=$00808040
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Fabricante
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Fabricante
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=PlanArtOP.Articulo
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=PlanArtOP.FechaLiberacion
FiltroFechasDefault=Esta Semana
FiltroFechasVencimiento=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
OtroOrden=S
ListaOrden=(Lista)
MenuLocal=S
ListaAcciones=(Lista)
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ordenes Planeadas
FiltroSucursales=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S
IconosNombre=PlanArtOP:PlanArtOP.Articulo
FiltroGeneral=PlanArtOP.Empresa=<T>{Empresa}<T> AND PlanArtOP.Accion=<T>{Info.Accion}<T> AND PlanArtOP.LiberacionID IS NULL

[Lista.PlanArtOP.SubCuenta]
Carpeta=Lista
Clave=PlanArtOP.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.PlanArtOP.FechaLiberacion]
Carpeta=Lista
Clave=PlanArtOP.FechaLiberacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlanArtOP.FechaEntrega]
Carpeta=Lista
Clave=PlanArtOP.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlanArtOP.Cantidad]
Carpeta=Lista
Clave=PlanArtOP.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlanArtOP.Ruta]
Carpeta=Lista
Clave=PlanArtOP.Ruta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.Columnas]
0=115
1=61
Articulo=83
SubCuenta=74
FechaLiberacion=85
FechaEntrega=76
Cantidad=48
Ruta=68
Descripcion=98
EnFirme=48
Descripcion1=244
Accion=46
Liberar=38
Proveedor=75
Almacen=70
Estado=48
Unidad=38
AlmacenDestino=65
Sucursal=46

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
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=&Cerrar
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
EnMenu=S
NombreEnBoton=S
EnBarraHerramientas=S

[Lista.PlanArtOP.Accion]
Carpeta=Lista
Clave=PlanArtOP.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Producir]
Nombre=Producir
Boton=71
NombreDesplegar=&Producir
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Menu=Ve&r
Antes=S
NombreEnBoton=S
EnBarraHerramientas=S
ActivoCondicion=Info.Accion<><T>Producir<T>
AntesExpresiones=Asigna(Info.Accion, <T>Producir<T>)
VisibleCondicion=General.Prod

[Acciones.Comprar]
Nombre=Comprar
Boton=71
Menu=Ve&r
NombreDesplegar=C&omprar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S
ActivoCondicion=Info.Accion<><T>Comprar<T>
AntesExpresiones=Asigna(Info.Accion, <T>Comprar<T>)

[Acciones.Dividir]
Nombre=Dividir
Boton=0
NombreDesplegar=&Dividir
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
GuardarAntes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(PlanArtOP:PlanArtOP.ID)
AntesExpresiones=EjecutarSQL(<T>spPlanArtOPDividir :tEmp, :tAlm, :tArt, :tSub, :nID<T>, Empresa, PlanArtOP:PlanArtOP.Almacen, PlanArtOP:PlanArtOP.Articulo, PlanArtOP:PlanArtOP.SubCuenta, PlanArtOP:PlanArtOP.ID)

[Acciones.Unir]
Nombre=Unir
Boton=0
UsaTeclaRapida=S
NombreDesplegar=&Unir
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
ConCondicion=S
TeclaRapida=Ctrl+U
GuardarAntes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(PlanArtOP:PlanArtOP.ID)
AntesExpresiones=EjecutarSQL(<T>spPlanArtOPUnir :tEmp, :tAlm, :tArt, :tSub, :nID<T>, Empresa, PlanArtOP:PlanArtOP.Almacen, PlanArtOP:PlanArtOP.Articulo, PlanArtOP:PlanArtOP.SubCuenta, PlanArtOP:PlanArtOP.ID)

[Lista.PlanArtOP.Proveedor]
Carpeta=Lista
Clave=PlanArtOP.Proveedor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.PlanArtOP.Almacen]
Carpeta=Lista
Clave=PlanArtOP.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
Menu=Ve&r
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
EspacioPrevio=S

[Lista.PlanArtOP.Estado]
Carpeta=Lista
Clave=PlanArtOP.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Centro]
Estilo=Iconos
Clave=Centro
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Centro
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Centro Trabajo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Centros Trabajo
Filtros=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CentroTipo
FiltroAplicaEn1=Centro.Tipo
FiltroTodo=S
FiltroAplicaEn=Centro.Tipo
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CentroTipo
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=Centro:Centro.Centro
CondicionVisible=General.Prod

[Centro.Columnas]
0=90
1=250

2=-2
[Centro.Centro.Descripcion]
Carpeta=Centro
Clave=Centro.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información Artículo
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
ConCondicion=S
GuardarAntes=S
EjecucionCondicion=ConDatos(PlanArtOP:PlanArtOP.Articulo)
AntesExpresiones=Asigna(Info.Articulo, PlanArtOP:PlanArtOP.Articulo)

[Acciones.ArtPlan]
Nombre=ArtPlan
Boton=0
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+P
NombreDesplegar=&Plan Artículo
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanArtAlm
Activo=S
Visible=S
Antes=S
ConCondicion=S
GuardarAntes=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(PlanArtOP:PlanArtOP.Articulo)
AntesExpresiones=Asigna(Info.Articulo, PlanArtOP:PlanArtOP.Articulo)<BR>Asigna(Info.Descripcion, PlanArtOP:Art.Descripcion1)<BR>Asigna(Info.ArtTipoOpcion, PlanArtOP:Art.TipoOpcion)<BR>Asigna(Info.Almacen, PlanArtOP:PlanArtOP.Almacen)

[Centro.Centro.Tipo]
Carpeta=Centro
Clave=Centro.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CentroGrafica]
Nombre=CentroGrafica
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Gráfica Centro Trabajo
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
GuardarAntes=S
Expresion=VerCRP(Centro:Centro.Centro+<T> - <T>+Centro:Centro.Descripcion, Centro:Centro.Centro)
EjecucionCondicion=ConDatos(Centro:Centro.Centro)

[Acciones.Capacidad]
Nombre=Capacidad
Boton=88
NombreEnBoton=S
Menu=Ve&r
NombreDesplegar=Capacidad &Total
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanCentro
Antes=S
GuardarAntes=S
ActivoCondicion=General.Prod
AntesExpresiones=Asigna(Info.Descripcion, <T>Capacidad Total<T>)<BR>Asigna(Info.Centro, <T><T>)
Visible=S

[Acciones.PlanCentro]
Nombre=PlanCentro
Boton=0
NombreDesplegar=Plan Centro Trabajo
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanCentro
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+P
EjecucionCondicion=ConDatos(Centro:Centro.Centro)
AntesExpresiones=Asigna(Info.Centro, Centro:Centro.Centro)<BR>Asigna(Info.Descripcion, <T>Plan - Centro Trabajo<T>)

[Acciones.CorridaPlaneacion]
Nombre=CorridaPlaneacion
Boton=92
Menu=&Archivo
NombreDesplegar=Generar Corrida &Planeación...
EnMenu=S
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)
EnBarraHerramientas=S
GuardarAntes=S
UsaTeclaRapida=S
TeclaRapida=F7
Antes=S
EspacioPrevio=S

AntesExpresiones=Asigna(Info.ArtCat, <T>(Todos)<T>)<BR>Asigna(Info.ArtGrupo, <T>(Todos)<T>)<BR>Asigna(Info.ArtFam, <T>(Todos)<T>)<BR>Asigna(Info.Fabricante, <T>(Todos)<T>)<BR>Asigna(Info.ArtLinea, <T>(Todos)<T>)<BR>Asigna(Info.ArtTemporada, <T>(Todos)<T>)<BR>Asigna(Info.Proveedor, <T>(TODOS)<T>)<BR>Asigna(Info.PlanReferencia, Nulo)
[Acciones.CorridaPlaneacion.CorridaPlaneacion]
Nombre=CorridaPlaneacion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>  General.Prod<BR>Entonces<BR>  Dialogo(<T>CorridaPlaneacion<T>)<BR>Sino<BR>  Forma(<T>CorridaPlaneacion<T>)<BR>Fin

[Acciones.CorridaPlaneacion.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.VerOpcion]
Nombre=VerOpcion
Boton=0
NombreDesplegar=&Interpretar Opción
EnMenu=S
TipoAccion=Expresion
EspacioPrevio=S
Expresion=VerOpcionesArticulo( PlanArtOP:PlanArtOP.Articulo, PlanArtOP:PlanArtOP.SubCuenta )
ActivoCondicion=ConDatos(PlanArtOP:PlanArtOP.SubCuenta)
VisibleCondicion=PlanArtOP:Art.TipoOpcion=TipoSi

[Acciones.Distribuir]
Nombre=Distribuir
Boton=71
Menu=Ve&r
NombreDesplegar=Dis&tribuir
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
Antes=S
NombreEnBoton=S
EnBarraHerramientas=S
ActivoCondicion=Info.Accion<><T>Distribuir<T>
AntesExpresiones=Asigna(Info.Accion, <T>Distribuir<T>)

[Lista.PlanArtOP.AlmacenDestino]
Carpeta=Lista
Clave=PlanArtOP.AlmacenDestino
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.PlanArtOP.Sucursal]
Carpeta=Lista
Clave=PlanArtOP.Sucursal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sucursal]
Nombre=Sucursal
Boton=0
Menu=Ve&r
NombreDesplegar=<T>&Sucursal<T>
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Refrescar Controles
Visible=S
Antes=S
Activo=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
AntesExpresiones=Asigna(Ver.Sucursal, no Ver.Sucursal)

[Acciones.PlanPos]
Nombre=PlanPos
Boton=0
NombreDesplegar=&Posición Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=PlanPos
Activo=S
Visible=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
EjecucionCondicion=ConDatos(PlanArtOP:PlanArtOP.Articulo)
AntesExpresiones=Asigna(Info.Articulo, PlanArtOP:PlanArtOP.Articulo)<BR>Asigna(Info.Descripcion, PlanArtOP:Art.Descripcion1)<BR>Asigna(Info.Almacen, PlanArtOP:PlanArtOP.Almacen)

[Acciones.Bitacora]
Nombre=Bitacora
Boton=56
Menu=Ve&r
NombreDesplegar=Bitácora
EnMenu=S
TipoAccion=Formas
ClaveAccion=PlanBitacora
Activo=S
Visible=S
EnBarraHerramientas=S
EspacioPrevio=S

[Acciones.Asistente]
Nombre=Asistente
Boton=12
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Asistente
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Forma(<T>EspecificarLiberarOrdenes<T>)

[Acciones.Proyectos]
Nombre=Proyectos
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+Y
NombreDesplegar=Pro&yectos
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyAlm
Antes=S
AntesExpresiones=Asigna(Info.Almacen, PlanArtOP:PlanArtOP.Almacen)

[Acciones.LiberarOrdenes]
Nombre=LiberarOrdenes
Boton=7
NombreEnBoton=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=&Liberar Ordenes
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=Si(Usuario.PlanEditarOrdenes, Forma(<T>LiberarOrdenes<T>), Dialogo(<T>LiberarOrdenes<T>))<BR>ActualizarVista
ActivoCondicion=Usuario.Afectar

[Acciones.CorridaPlaneacionRef]
Nombre=CorridaPlaneacionRef
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=Generar Corrida Planeación (Pedido &Especifico)...
EnMenu=S
TipoAccion=Formas
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=CorridaPlaneacionRef<BR>Actualizar Vista

[Acciones.CorridaPlaneacionRef.CorridaPlaneacionRef]
Nombre=CorridaPlaneacionRef
Boton=0
TipoAccion=Formas
ClaveAccion=CorridaPlaneacionRef
Activo=S
Visible=S

[Acciones.CorridaPlaneacionRef.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.ListaImprimir]
Nombre=ListaImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.ListaPreliminar]
Nombre=ListaPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.ListaExcel]
Nombre=ListaExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.ListaPersonalizar]
Nombre=ListaPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ListaTodo]
Nombre=ListaTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.ListaQuitar]
Nombre=ListaQuitar
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.ListaEnFirme]
Nombre=ListaEnFirme
Boton=0
NombreDesplegar=Estado = En Firme (Selección)
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
RefrescarIconos=S
Expresion=RegistrarSeleccionID(<T>Lista<T>)<BR>EjecutarSQL(<T>spPlanSeleccionEstado :nEstacion, :tEstado<T>, EstacionTrabajo, <T>En Firme<T>)

[Acciones.ListaPlan]
Nombre=ListaPlan
Boton=0
NombreDesplegar=Estado = Plan (Selección)
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
RefrescarIconos=S
Expresion=RegistrarSeleccionID(<T>Lista<T>)<BR>EjecutarSQL(<T>spPlanSeleccionEstado :nEstacion, :tEstado<T>, EstacionTrabajo, <T>Plan<T>)

[Acciones.ListaLiberado]
Nombre=ListaLiberado
Boton=0
NombreDesplegar=Estado = Liberado (Selección)
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
RefrescarIconos=S
Expresion=RegistrarSeleccionID(<T>Lista<T>)<BR>EjecutarSQL(<T>spPlanSeleccionEstado :nEstacion, :tEstado<T>, EstacionTrabajo, <T>Liberado<T>)

[Acciones.GuardarCorrida]
Nombre=GuardarCorrida
Boton=3
Menu=&Archivo
NombreDesplegar=Guardar - &Histórico Corridas Planeación
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spPlanHist<T>)

[Acciones.Historico]
Nombre=Historico
Boton=53
Menu=Ve&r
NombreDesplegar=&Histórico Corridas Planeacion
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarPlaneadorHist
Activo=S
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=PlanArtOP.SubCuenta
PlanArtOP.SubCuenta=PlanArtOP.Sucursal
PlanArtOP.Sucursal=PlanArtOP.Almacen
PlanArtOP.Almacen=PlanArtOP.FechaLiberacion
PlanArtOP.FechaLiberacion=PlanArtOP.FechaEntrega
PlanArtOP.FechaEntrega=PlanArtOP.Cantidad
PlanArtOP.Cantidad=PlanArtOP.Accion
PlanArtOP.Accion=PlanArtOP.Proveedor
PlanArtOP.Proveedor=PlanArtOP.Ruta
PlanArtOP.Ruta=PlanArtOP.AlmacenDestino
PlanArtOP.AlmacenDestino=PlanArtOP.Estado
PlanArtOP.Estado=(Fin)

[Lista.ListaOrden]
(Inicio)=PlanArtOP.FechaLiberacion<TAB>(Acendente)
PlanArtOP.FechaLiberacion<TAB>(Acendente)=PlanArtOP.AlmacenDestino<TAB>(Acendente)
PlanArtOP.AlmacenDestino<TAB>(Acendente)=PlanArtOP.Ruta<TAB>(Acendente)
PlanArtOP.Ruta<TAB>(Acendente)=PlanArtOP.Proveedor<TAB>(Acendente)
PlanArtOP.Proveedor<TAB>(Acendente)=PlanArtOP.Articulo<TAB>(Acendente)
PlanArtOP.Articulo<TAB>(Acendente)=PlanArtOP.SubCuenta<TAB>(Acendente)
PlanArtOP.SubCuenta<TAB>(Acendente)=PlanArtOP.Almacen<TAB>(Acendente)
PlanArtOP.Almacen<TAB>(Acendente)=PlanArtOP.Cantidad<TAB>(Acendente)
PlanArtOP.Cantidad<TAB>(Acendente)=(Fin)

[Lista.ListaAcciones]
(Inicio)=Dividir
Dividir=Unir
Unir=Proyectos
Proyectos=VerOpcion
VerOpcion=ArtInfo
ArtInfo=PlanPos
PlanPos=ArtPlan
ArtPlan=ListaTodo
ListaTodo=ListaQuitar
ListaQuitar=ListaPlan
ListaPlan=ListaEnFirme
ListaEnFirme=ListaLiberado
ListaLiberado=ListaImprimir
ListaImprimir=ListaPreliminar
ListaPreliminar=ListaExcel
ListaExcel=ListaPersonalizar
ListaPersonalizar=(Fin)

[Centro.ListaEnCaptura]
(Inicio)=Centro.Descripcion
Centro.Descripcion=Centro.Tipo
Centro.Tipo=(Fin)

[Centro.ListaAcciones]
(Inicio)=PlanCentro
PlanCentro=CentroGrafica
CentroGrafica=(Fin)




[Acciones.CorridaPlaneacion.ListaAccionesMultiples]
(Inicio)=CorridaPlaneacion
CorridaPlaneacion=Actualizar Vista
Actualizar Vista=(Fin)




[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Centro
Centro=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=CorridaPlaneacion
CorridaPlaneacion=CorridaPlaneacionRef
CorridaPlaneacionRef=GuardarCorrida
GuardarCorrida=LiberarOrdenes
LiberarOrdenes=Asistente
Asistente=Capacidad
Capacidad=Sucursal
Sucursal=Comprar
Comprar=Producir
Producir=Distribuir
Distribuir=Bitacora
Bitacora=Historico
Historico=Actualizar
Actualizar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=Ve&r
Ve&r=(Fin)
