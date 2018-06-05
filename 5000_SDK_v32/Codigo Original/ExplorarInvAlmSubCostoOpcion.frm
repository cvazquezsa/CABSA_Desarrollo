[Forma]
Clave=ExplorarInvAlmSubCostoOpcion
Nombre=<T>Explorando - Inventarios por Almacenes (a Nivel Subcuenta)<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=329
PosicionInicialArriba=194
PosicionInicialAltura=471
PosicionInicialAncho=938
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=444

VentanaEstadoInicial=Normal
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtSubExistenciaReservadoCostoOpcion
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
CarpetaVisible=S
FiltroListasRama=INV
FiltroListasAplicaEn=Articulo
FiltroGrupo1=(Validaciones Memoria)
FiltroTodo=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
FiltroTodoFinal=S
MenuLocal=S
ListaAcciones=LocalInformacion
PestanaOtroNombre=S
PestanaNombre=Artículos
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroMonedas=S
FiltroMonedasCampo=Art.MonedaCosto
PermiteLocalizar=S
FiltroAplicaEn=Alm.Almacen
OtroOrden=S
ListaOrden=(Lista)
FiltroValida1=Alm
FiltroAplicaEn1=Alm.Almacen

FiltroAplicaO=ArtSubExistenciaReservadoOpcion.Almacen
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Alm
FiltroEstilo=Directorio
IconosNombre=ArtSubExistenciaReservadoCostoOpcion:Art.Articulo
FiltroGeneral=ArtSubExistenciaReservadoOpcion.Empresa=<T>{Empresa}<T> AND<BR>ISNULL(ArtSubExistenciaReservadoOpcion.Existencias, 0) <> 0
FiltroEmpresas=S
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S
[Lista.Columnas]
Articulo=124
Descripcion1=256
Costo=95
Existencia=74
Valor=100
Existencias=68
0=90
1=144

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
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

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
ConCondicion=S

EjecucionCondicion=ConDatos(ArtSubExistenciaReservadoCostoOpcion:Art.Articulo)
AntesExpresiones=Asigna( Info.Articulo, ArtSubExistenciaReservadoCostoOpcion:Art.Articulo)
[Acciones.LocalInformacion]
Nombre=LocalInformacion
Boton=0
NombreDesplegar=&Información del Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S
Antes=S

AntesExpresiones=Asigna(Info.Articulo, ArtSubExistenciaReservadoCostoOpcion:Art.Articulo)
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Visible=S

ActivoCondicion=Usuario.Costos
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Lista.ValorPromedio]
Carpeta=Lista
Clave=ValorPromedio
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ValorEstandar]
Carpeta=Lista
Clave=ValorEstandar
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[Lista.ArtSubExistenciaReservadoOpcion.SubCuenta]
Carpeta=Lista
Clave=ArtSubExistenciaReservadoOpcion.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservadoOpcion.Almacen]
Carpeta=Lista
Clave=ArtSubExistenciaReservadoOpcion.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservadoOpcion.Existencias]
Carpeta=Lista
Clave=ArtSubExistenciaReservadoOpcion.Existencias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservadoOpcion.Reservado]
Carpeta=Lista
Clave=ArtSubExistenciaReservadoOpcion.Reservado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservadoOpcion.Disponible]
Carpeta=Lista
Clave=ArtSubExistenciaReservadoOpcion.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservadoOpcion.Remisionado]
Carpeta=Lista
Clave=ArtSubExistenciaReservadoOpcion.Remisionado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





















[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ArtSubExistenciaReservadoOpcion.SubCuenta
ArtSubExistenciaReservadoOpcion.SubCuenta=ArtSubExistenciaReservadoOpcion.Almacen
ArtSubExistenciaReservadoOpcion.Almacen=ArtSubExistenciaReservadoOpcion.Existencias
ArtSubExistenciaReservadoOpcion.Existencias=ArtSubExistenciaReservadoOpcion.Reservado
ArtSubExistenciaReservadoOpcion.Reservado=Apartado
Apartado=ArtSubExistenciaReservadoOpcion.Disponible
ArtSubExistenciaReservadoOpcion.Disponible=ArtSubExistenciaReservadoOpcion.Remisionado
ArtSubExistenciaReservadoOpcion.Remisionado=ValorPromedio
ValorPromedio=ValorEstandar
ValorEstandar=(Fin)

[Lista.ListaOrden]
(Inicio)=ArtSubExistenciaReservadoOpcion.Articulo	(Acendente)
ArtSubExistenciaReservadoOpcion.Articulo	(Acendente)=ArtSubExistenciaReservadoOpcion.SubCuenta	(Acendente)
ArtSubExistenciaReservadoOpcion.SubCuenta	(Acendente)=(Fin)

[Lista.Apartado]
Carpeta=Lista
Clave=Apartado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Informacion
Informacion=Mostrar Campos
Mostrar Campos=(Fin)
