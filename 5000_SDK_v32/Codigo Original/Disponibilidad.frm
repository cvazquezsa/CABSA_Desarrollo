[Forma]
Clave=Disponibilidad
Nombre=<T>Explorando - Disponibilidad<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=286
PosicionInicialArriba=212
PosicionInicialAltura=562
PosicionInicialAncho=708
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=72
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=<T>Ultimo Recálculo: <T>+  FechaEnTexto(SQL(<T>SELECT ArtR FROM Version<T>), <T>dd/mmm/aaaa hh:nn am/pm<T>)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=535

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtR
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
PestanaOtroNombre=S
PestanaNombre=Artículos
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroGrupo2=(Validaciones Memoria)
FiltroGrupo3=(Validaciones Memoria)
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroTodo=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Zona
BusquedaRespetarFiltros=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
FiltroValida1=ArtCat
FiltroValida2=ArtGrupo
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Fabricante
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Fabricante
FiltroTodoFinal=S
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=ArtR.Articulo
FiltroEmpresas=S
IconosNombre=ArtR:ArtR.Articulo

[Lista.Columnas]
0=83
1=216
Articulo=104
Descripcion1=157
PrecioLista=68
Almacen=61
Disponible=58
porSurtir=50
porRecibir=58
ExistenciaReservada=58
Minimo=43
Sugerencia=112
Zona=34
ExistenciaFisica=56

2=-2
3=-2
4=-2
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.PrecioLista]
Carpeta=Lista
Clave=Art.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtR.Almacen]
Carpeta=Lista
Clave=ArtR.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Disponible]
Carpeta=Lista
Clave=Disponible
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

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

[Detalle.ArtR.Articulo]
Carpeta=Detalle
Clave=ArtR.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Art.Descripcion1]
Carpeta=Detalle
Clave=Art.Descripcion1
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ArtR.Almacen]
Carpeta=Detalle
Clave=ArtR.Almacen
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Alm.Zona]
Carpeta=Detalle
Clave=Alm.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Disponible]
Carpeta=Detalle
Clave=Disponible
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Detalle.porRecibir]
Carpeta=Detalle
Clave=porRecibir
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Detalle.porSurtir]
Carpeta=Detalle
Clave=porSurtir
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Detalle.ExistenciaReservada]
Carpeta=Detalle
Clave=ExistenciaReservada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ArtR.Minimo]
Carpeta=Detalle
Clave=ArtR.Minimo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ExistenciaFisica]
Carpeta=Detalle
Clave=ExistenciaFisica
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Art.Categoria]
Carpeta=Detalle
Clave=Art.Categoria
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S

NombreEnBoton=S
AntesExpresiones=Asigna(Info.Articulo, ArtR:ArtR.Articulo)
[Acciones.Recalcular]
Nombre=Recalcular
Boton=92
NombreEnBoton=S
NombreDesplegar=&Recalcular
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
EspacioPrevio=S
ClaveAccion=Actualizar Forma
Antes=S
AntesExpresiones=ProcesarSQL(<T>spReconstruirArtR<T>)

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.PrecioLista
Art.PrecioLista=ArtR.Almacen
ArtR.Almacen=Disponible
Disponible=(Fin)









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=ArtInfo
ArtInfo=Recalcular
Recalcular=Campos
Campos=(Fin)
