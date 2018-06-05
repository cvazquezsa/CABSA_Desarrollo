[Forma]
Clave=ExplorarInvAlmSub
Nombre=<T>Explorando - Inventarios por Almacenes (a Nivel Subcuenta)<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=214
PosicionInicialArriba=123
PosicionInicialAltura=471
PosicionInicialAncho=954
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=444

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtSubExistenciaReservado
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
FiltroGrupo1=Alm.Almacen
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
FiltroGrupo2=Art.Categoria
OtroOrden=S
ListaOrden=(Lista)
FiltroSucursalesSinTodas=S

FiltroAplicaO=ArtSubExistenciaReservado.Almacen
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Alm
FiltroEstilo=Directorio
IconosNombre=ArtSubExistenciaReservado:Art.Articulo
FiltroGeneral=ArtSubExistenciaReservado.Empresa=<T>{Empresa}<T> AND<BR>ISNULL(ArtSubExistenciaReservado.Existencias, 0) <> 0
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
10=-2
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
EjecucionCondicion=ConDatos(ArtSubExistenciaReservado:Art.Articulo)
AntesExpresiones=Asigna( Info.Articulo, ArtSubExistenciaReservado:Art.Articulo)

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
AntesExpresiones=Asigna(Info.Articulo, ArtSubExistenciaReservado:Art.Articulo)

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservado.Existencias]
Carpeta=Lista
Clave=ArtSubExistenciaReservado.Existencias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador=1
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservado.Reservado]
Carpeta=Lista
Clave=ArtSubExistenciaReservado.Reservado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador=1
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservado.Almacen]
Carpeta=Lista
Clave=ArtSubExistenciaReservado.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservado.Disponible]
Carpeta=Lista
Clave=ArtSubExistenciaReservado.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador=1
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
Activo=S
Visible=S

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

[Lista.ArtSubExistenciaReservado.Remisionado]
Carpeta=Lista
Clave=ArtSubExistenciaReservado.Remisionado
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtSubExistenciaReservado.SubCuenta]
Carpeta=Lista
Clave=ArtSubExistenciaReservado.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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
















[Lista.Apartado]
Carpeta=Lista
Clave=Apartado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ArtSubExistenciaReservado.SubCuenta
ArtSubExistenciaReservado.SubCuenta=ArtSubExistenciaReservado.Almacen
ArtSubExistenciaReservado.Almacen=ArtSubExistenciaReservado.Existencias
ArtSubExistenciaReservado.Existencias=Apartado
Apartado=ArtSubExistenciaReservado.Disponible
ArtSubExistenciaReservado.Disponible=ArtSubExistenciaReservado.Reservado
ArtSubExistenciaReservado.Reservado=ArtSubExistenciaReservado.Remisionado
ArtSubExistenciaReservado.Remisionado=ValorPromedio
ValorPromedio=ValorEstandar
ValorEstandar=(Fin)

[Lista.ListaOrden]
(Inicio)=ArtSubExistenciaReservado.Articulo	(Acendente)
ArtSubExistenciaReservado.Articulo	(Acendente)=ArtSubExistenciaReservado.SubCuenta	(Acendente)
ArtSubExistenciaReservado.SubCuenta	(Acendente)=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Informacion
Informacion=Mostrar Campos
Mostrar Campos=(Fin)
