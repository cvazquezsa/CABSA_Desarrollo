[Forma]
Clave=ExplorarPlaneadorHist
Nombre=Histórico Corridas Planeación
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
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
PosicionSeccion1=77
PosicionInicialAlturaCliente=475
Comentarios=FechaEnTexto(Info.Fecha, <T>dd/mmm/aaaa<T>)
ExpresionesAlMostrar=Asigna(Info.Fecha, Hoy)
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
Vista=PlanArtOPHist
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
FiltroListasAplicaEn=PlanArtOPHist.Articulo
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=PlanArtOPHist.FechaLiberacion
FiltroFechasDefault=(Todo)
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
PestanaNombre=Registros
FiltroSucursales=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S
PestanaOtroNombre=S
FiltroFechas=S
IconosNombre=PlanArtOPHist:PlanArtOPHist.Articulo
FiltroGeneral=PlanArtOPHist.Fecha=<T>{FechaFormatoServidor(Info.Fecha)}<T>  AND PlanArtOPHist.Empresa=<T>{Empresa}<T> AND PlanArtOPHist.Accion=<T>{Info.Accion}<T> AND PlanArtOPHist.LiberacionID IS NULL

[Lista.PlanArtOPHist.SubCuenta]
Carpeta=Lista
Clave=PlanArtOPHist.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.PlanArtOPHist.FechaLiberacion]
Carpeta=Lista
Clave=PlanArtOPHist.FechaLiberacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlanArtOPHist.FechaEntrega]
Carpeta=Lista
Clave=PlanArtOPHist.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlanArtOPHist.Cantidad]
Carpeta=Lista
Clave=PlanArtOPHist.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlanArtOPHist.Ruta]
Carpeta=Lista
Clave=PlanArtOPHist.Ruta
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

[Lista.PlanArtOPHist.Accion]
Carpeta=Lista
Clave=PlanArtOPHist.Accion
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

[Lista.PlanArtOPHist.Proveedor]
Carpeta=Lista
Clave=PlanArtOPHist.Proveedor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.PlanArtOPHist.Almacen]
Carpeta=Lista
Clave=PlanArtOPHist.Almacen
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

[Lista.PlanArtOPHist.Estado]
Carpeta=Lista
Clave=PlanArtOPHist.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Centro.Columnas]
0=90
1=250

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
EjecucionCondicion=ConDatos(PlanArtOPHist:PlanArtOPHist.Articulo)
AntesExpresiones=Asigna(Info.Articulo, PlanArtOPHist:PlanArtOPHist.Articulo)

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
EjecucionCondicion=ConDatos(PlanArtOPHist:PlanArtOPHist.Articulo)
AntesExpresiones=Asigna(Info.Articulo, PlanArtOPHist:PlanArtOPHist.Articulo)<BR>Asigna(Info.Descripcion, PlanArtOPHist:Art.Descripcion1)<BR>Asigna(Info.ArtTipoOpcion, PlanArtOPHist:Art.TipoOpcion)<BR>Asigna(Info.Almacen, PlanArtOPHist:PlanArtOPHist.Almacen)

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
Expresion=VerOpcionesArticulo( PlanArtOPHist:PlanArtOPHist.Articulo, PlanArtOPHist:PlanArtOPHist.SubCuenta )
ActivoCondicion=ConDatos(PlanArtOPHist:PlanArtOPHist.SubCuenta)
VisibleCondicion=PlanArtOPHist:Art.TipoOpcion=TipoSi

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

[Lista.PlanArtOPHist.AlmacenDestino]
Carpeta=Lista
Clave=PlanArtOPHist.AlmacenDestino
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.PlanArtOPHist.Sucursal]
Carpeta=Lista
Clave=PlanArtOPHist.Sucursal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
EjecucionCondicion=ConDatos(PlanArtOPHist:PlanArtOPHist.Articulo)
AntesExpresiones=Asigna(Info.Articulo, PlanArtOPHist:PlanArtOPHist.Articulo)<BR>Asigna(Info.Descripcion, PlanArtOPHist:Art.Descripcion1)<BR>Asigna(Info.Almacen, PlanArtOPHist:PlanArtOPHist.Almacen)

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
AntesExpresiones=Asigna(Info.Almacen, PlanArtOPHist:PlanArtOPHist.Almacen)

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

[Acciones.Fecha]
Nombre=Fecha
Boton=53
NombreEnBoton=S
Menu=Ve&r
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
NombreDesplegar=&Fecha
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Forma(<T>EspecificarFecha<T>)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Fecha
Fecha=Comprar
Comprar=Producir
Producir=Distribuir
Distribuir=Actualizar
Actualizar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=Ve&r
Ve&r=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PlanArtOPHist.SubCuenta
PlanArtOPHist.SubCuenta=PlanArtOPHist.Sucursal
PlanArtOPHist.Sucursal=PlanArtOPHist.Almacen
PlanArtOPHist.Almacen=PlanArtOPHist.FechaLiberacion
PlanArtOPHist.FechaLiberacion=PlanArtOPHist.FechaEntrega
PlanArtOPHist.FechaEntrega=PlanArtOPHist.Cantidad
PlanArtOPHist.Cantidad=PlanArtOPHist.Accion
PlanArtOPHist.Accion=PlanArtOPHist.Proveedor
PlanArtOPHist.Proveedor=PlanArtOPHist.Ruta
PlanArtOPHist.Ruta=PlanArtOPHist.AlmacenDestino
PlanArtOPHist.AlmacenDestino=PlanArtOPHist.Estado
PlanArtOPHist.Estado=(Fin)

[Lista.ListaOrden]
(Inicio)=PlanArtOPHist.FechaLiberacion<TAB>(Acendente)
PlanArtOPHist.FechaLiberacion<TAB>(Acendente)=PlanArtOPHist.AlmacenDestino<TAB>(Acendente)
PlanArtOPHist.AlmacenDestino<TAB>(Acendente)=PlanArtOPHist.Ruta<TAB>(Acendente)
PlanArtOPHist.Ruta<TAB>(Acendente)=PlanArtOPHist.Proveedor<TAB>(Acendente)
PlanArtOPHist.Proveedor<TAB>(Acendente)=PlanArtOPHist.Articulo<TAB>(Acendente)
PlanArtOPHist.Articulo<TAB>(Acendente)=PlanArtOPHist.SubCuenta<TAB>(Acendente)
PlanArtOPHist.SubCuenta<TAB>(Acendente)=PlanArtOPHist.Almacen<TAB>(Acendente)
PlanArtOPHist.Almacen<TAB>(Acendente)=PlanArtOPHist.Cantidad<TAB>(Acendente)
PlanArtOPHist.Cantidad<TAB>(Acendente)=(Fin)

[Lista.ListaAcciones]
(Inicio)=Proyectos
Proyectos=VerOpcion
VerOpcion=ArtInfo
ArtInfo=PlanPos
PlanPos=ArtPlan
ArtPlan=ListaImprimir
ListaImprimir=ListaPreliminar
ListaPreliminar=ListaExcel
ListaExcel=ListaPersonalizar
ListaPersonalizar=(Fin)
