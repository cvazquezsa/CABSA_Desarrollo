
[Forma]
Clave=POSArtInfo
Nombre=<T>Información del Artículo<T>
Icono=6
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=414
PosicionInicialArriba=175
PosicionInicialAltura=420
PosicionInicialAncho=772
PosicionColumna1=42
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
AccionesDivision=S
VentanaExclusiva=S
Menus=S
VentanaEscCerrar=S
Comentarios=Info.Articulo
EsConsultaExclusiva=S
BarraAyudaBold=S
PosicionSeccion1=77
PosicionInicialAlturaCliente=471
PosicionCol1=365

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSWSSolicitudArtInfo :tEmpresa, :tArticulo,:tUsuario, :nEstacion, :nSucursal<T>,Empresa,Info.Articulo,Usuario,EstacionTrabajo,Sucursal)
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Pestana=S
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Art
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=General
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30

FiltroGeneral=Art.Articulo={Comillas(Info.Articulo)}
[Ficha.Art.Descripcion1]
Carpeta=Ficha
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[Ficha.Art.Descripcion2]
Carpeta=Ficha
Clave=Art.Descripcion2
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=41
ColorFondo=Plata
Pegado=N

[Ficha.Art.Categoria]
Carpeta=Ficha
Clave=Art.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Art.Familia]
Carpeta=Ficha
Clave=Art.Familia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Art.Fabricante]
Carpeta=Ficha
Clave=Art.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Art.Unidad]
Carpeta=Ficha
Clave=Art.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata
EspacioPrevio=S

[Ficha.Art.Peso]
Carpeta=Ficha
Clave=Art.Peso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata

[Ficha.Art.Volumen]
Carpeta=Ficha
Clave=Art.Volumen
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=$00BBCCD5

[Ficha.Art.PrecioLista]
Carpeta=Ficha
Clave=Art.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
EspacioPrevio=S

[Ficha.Art.MonedaPrecio]
Carpeta=Ficha
Clave=Art.MonedaPrecio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Desc.Art.DescripcionAmplia]
Carpeta=Desc
Clave=Art.DescripcionAmplia
Editar=S
LineaNueva=S
3D=S
Tamano=41x19
ColorFondo=Plata
ConScroll=S

[Notas.Art.Notas]
Carpeta=Notas
Clave=Art.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=41x15
ColorFondo=Plata

[Notas.Art.Mensaje]
Carpeta=Notas
Clave=Art.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ConScroll=S

[ArtDisponible]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Disponible
Clave=ArtDisponible
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSArtDisponibleAlmTemp
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=Almacén
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=POSArtDisponibleAlmTemp.Disponible
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Almacenes
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=15
Pestana=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=AlmGrupo
FiltroAplicaEn=Alm.Grupo
FiltroTodo=S
FiltroAplicaEn1=POSArtDisponibleAlmTemp.Grupo
MenuLocal=S
ListaAcciones=ArtDisponibleDesglosar

IconosNombre=POSArtDisponibleAlmTemp:POSArtDisponibleAlmTemp.Almacen
FiltroGeneral=POSArtDisponibleAlmTemp.Empresa={Comillas(Empresa)} AND<BR>POSArtDisponibleAlmTemp.Articulo={Comillas(Info.Articulo)} AND<BR>POSArtDisponibleAlmTemp.Disponible<>0.0   AND<BR>POSArtDisponibleAlmTemp.Estacion = {EstacionTrabajo}
[ArtDisponible.Columnas]
0=85
1=95


[Ficha.EstatusNombre]
Carpeta=Ficha
Clave=EstatusNombre
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]


[Ficha.Art.Tipo]
Carpeta=Ficha
Clave=Art.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[ArtReservado]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Reservados
Clave=ArtReservado
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSArtResevadoAlmTemp
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Almacén
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=POSArtResevadoAlmTemp.Reservado
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30

IconosNombre=POSArtResevadoAlmTemp:POSArtResevadoAlmTemp.Almacen
FiltroGeneral=POSArtResevadoAlmTemp.Empresa={Comillas(Empresa)} AND<BR>POSArtResevadoAlmTemp.Articulo={Comillas(Info.Articulo)}  AND<BR>POSArtResevadoAlmTemp.Estacion = {EstacionTrabajo}
[ArtReservado.Columnas]
0=116
1=101

[Acciones.Desglose]
Nombre=Desglose
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Desglosar Disponible
EnMenu=S
TipoAccion=Expresion
Antes=S
EnBarraHerramientas=S
Activo=S
Expresion=Forma(Si((Art:Art.Tipo en (TipoSerie, TipoVIN, TipoLote)) y Config.SeriesLotesMayoreo, <T>ArtDesgloseSerieLote<T>, <T>ArtDesglose<T>))
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.ArtTipo, Art:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, Art:Art.TipoOpcion)
VisibleCondicion=(Art:Art.Tipo noen (TipoNormal, TipoServicio)) o (Art:Art.TipoOpcion<>TipoNo)

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
BtnResaltado=


[Ficha.Art.ClaveFabricante]
Carpeta=Ficha
Clave=Art.ClaveFabricante
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[ArtConsignacion.ArtConsignacion.Consignacion]
Carpeta=ArtConsignacion
Clave=ArtConsignacion.Consignacion
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[ArtConsignacion.Columnas]
0=114
1=96



[Accesorios]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Accesorios
Clave=Accesorios
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtAccesorio
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
HojaMantenerSeleccion=S
MenuLocal=S
ListaAcciones=AccesoriosInfo

FiltroGeneral=ArtAccesorio.Articulo=<T>{Info.Articulo}<T>
CondicionVisible=Art:Art.Accesorios
[Accesorios.ArtAccesorio.Accesorio]
Carpeta=Accesorios
Clave=ArtAccesorio.Accesorio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=Blanco

[Accesorios.Art.Descripcion1]
Carpeta=Accesorios
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=Blanco

[Accesorios.Columnas]
Accesorio=94
Descripcion1=186




[Costos.Art.MonedaCosto]
Carpeta=Costos
Clave=Art.MonedaCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
EspacioPrevio=S
ColorFuente=Negro

[Acciones.ArtSerie]
Nombre=ArtSerie
Boton=0
Menu=&Ver
NombreDesplegar=<T>&Registro de <T>+Art:Art.Tipo+<T>s<T>
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtSerieLote
Activo=S
Antes=S
EspacioPrevio=S

AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.ArtTipo, Art:Art.Tipo)
VisibleCondicion=(Art:Art.Tipo en (TipoSerie, TipoVIN, TipoLote, TipoPartida)) y Config.SeriesLotesMayoreo

[Refacciones.ArtRefaccion.Cantidad]
Carpeta=Refacciones
Clave=ArtRefaccion.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Refacciones.Art.Descripcion1]
Carpeta=Refacciones
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Refacciones.Columnas]
Refaccion=80
Descripcion1=152
Cantidad=49
0=93
1=144


[ArtPartida.ArtPartida.Existencia]
Carpeta=ArtPartida
Clave=ArtPartida.Existencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartida.ArtPartida.ExistenciaAlterna]
Carpeta=ArtPartida
Clave=ArtPartida.ExistenciaAlterna
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartida.Columnas]
0=75
1=54

2=-2
3=-2
4=-2
5=-2
[ArtPartida.ArtPartida.Almacen]
Carpeta=ArtPartida
Clave=ArtPartida.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartida.ArtPartida.SubCuenta]
Carpeta=ArtPartida
Clave=ArtPartida.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.CantidadPendiente]
Carpeta=Compras
Clave=CompraPendienteD.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.Costo]
Carpeta=Compras
Clave=CompraPendienteD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.FechaEntrega]
Carpeta=Compras
Clave=CompraPendienteD.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.Almacen]
Carpeta=Compras
Clave=CompraPendienteD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Compras.Columnas]
CantidadPendiente=64
Costo=64
FechaEntrega=94
Almacen=64


[ArtSustitutos.Columnas]
Sustituto=68
Descripcion1=157
Comentarios=604

[Sustitutos]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Sustitutos
Clave=Sustitutos
Filtros=S
OtroOrden=S
ValidarCampos=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtSustituto
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaCamposAValidar=(Lista)
ListaOrden=ArtSustituto.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=SustitutosInfo
FiltroGeneral=ArtSustituto.Articulo=<T>{Info.Articulo}<T>
CondicionVisible=Art:Art.Sustitutos

[Sustitutos.ArtSustituto.Sustituto]
Carpeta=Sustitutos
Clave=ArtSustituto.Sustituto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Sustitutos.Columnas]
Sustituto=94
Comentarios=604
Descripcion1=187

[Sustitutos.Art.Descripcion1]
Carpeta=Sustitutos
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AccesoriosInfo]
Nombre=AccesoriosInfo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfoCopia
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtAccesorio:ArtAccesorio.Accesorio)
AntesExpresiones=Asigna(Info.ArticuloCopia, ArtAccesorio:ArtAccesorio.Accesorio)<BR>Asigna(Info.Descripcion, <T>del Accesorio<T>)

[Acciones.Refacciones]
Nombre=Refacciones
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfoCopia
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtRefaccion:ArtRefaccion.Refaccion)
AntesExpresiones=Asigna(Info.ArticuloCopia, ArtRefaccion:ArtRefaccion.Refaccion)<BR>Asigna(Info.Descripcion, <T>de la Refacción<T>)

[Acciones.SustitutosInfo]
Nombre=SustitutosInfo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfoCopia
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtSustituto:ArtSustituto.Sustituto)
AntesExpresiones=Asigna(Info.ArticuloCopia, ArtSustituto:ArtSustituto.Sustituto)<BR>Asigna(Info.Descripcion, <T>del Sustituto<T>)



[ArtPartidaAsignado.Almacen]
Carpeta=ArtPartidaAsignado
Clave=Almacen
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartidaAsignado.Cliente]
Carpeta=ArtPartidaAsignado
Clave=Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartidaAsignado.Nombre]
Carpeta=ArtPartidaAsignado
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartidaAsignado.Existencia]
Carpeta=ArtPartidaAsignado
Clave=Existencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartidaAsignado.ExistenciaAlterna]
Carpeta=ArtPartidaAsignado
Clave=ExistenciaAlterna
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtPartidaAsignado.Columnas]
0=69
1=67

2=-2
3=-2
4=-2
5=-2
[Precios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Precios
Clave=Precios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Art
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CondicionVisible=Config.VentaPrecios>1
[Precios.Art.PrecioLista]
Carpeta=Precios
Clave=Art.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio2]
Carpeta=Precios
Clave=Art.Precio2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio3]
Carpeta=Precios
Clave=Art.Precio3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio4]
Carpeta=Precios
Clave=Art.Precio4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio5]
Carpeta=Precios
Clave=Art.Precio5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.PrecioMinimo]
Carpeta=Precios
Clave=Art.PrecioMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio6]
Carpeta=Precios
Clave=Art.Precio6
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
LineaNueva=S

[Precios.Art.Precio7]
Carpeta=Precios
Clave=Art.Precio7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio8]
Carpeta=Precios
Clave=Art.Precio8
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
LineaNueva=S

[Precios.Art.Precio9]
Carpeta=Precios
Clave=Art.Precio9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Precios.Art.Precio10]
Carpeta=Precios
Clave=Art.Precio10
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
LineaNueva=S



[SubCostos.Columnas]
0=83
1=160

2=-2
3=-2

[Refacciones.ArtRefaccion.Refaccion]
Carpeta=Refacciones
Clave=ArtRefaccion.Refaccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[SubCostos.ArtSubCosto.UltimoCosto]
Carpeta=SubCostos
Clave=ArtSubCosto.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[SubCostos.ArtSubCosto.CostoPromedio]
Carpeta=SubCostos
Clave=ArtSubCosto.CostoPromedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[SubCostos.Art.MonedaCosto]
Carpeta=SubCostos
Clave=Art.MonedaCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VerOpcion]
Nombre=VerOpcion
Boton=0
NombreDesplegar=&Interpretar Opción
EnMenu=S
TipoAccion=Expresion
Expresion=VerOpcionesArticulo(ArtSubCosto:ArtSubCosto.Articulo, ArtSubCosto:ArtSubCosto.SubCuenta)
ActivoCondicion=ConDatos(ArtSubCosto:ArtSubCosto.SubCuenta)
VisibleCondicion=Art:Art.TipoOpcion=TipoSi


[Servicios]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Servicios
Clave=Servicios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtServicio
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ArtServicio.Articulo=<T>{Info.Articulo}<T>
FiltroRespetar=S
FiltroTipo=General
CondicionVisible=Art:Art.Servicios

[Servicios.ArtServicio.Servicio]
Carpeta=Servicios
Clave=ArtServicio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Servicios.ArtServicio.Cantidad]
Carpeta=Servicios
Clave=ArtServicio.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Servicios.Columnas]
Servicio=81
Cantidad=46
Descripcion1=153

[Servicios.Art.Descripcion1]
Carpeta=Servicios
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro


[Consumibles.ArtConsumible.Consumible]
Carpeta=Consumibles
Clave=ArtConsumible.Consumible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Consumibles.Art.Descripcion1]
Carpeta=Consumibles
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Consumibles.ArtConsumible.Cantidad]
Carpeta=Consumibles
Clave=ArtConsumible.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Consumibles.Columnas]
Consumible=80
Descripcion1=153
Cantidad=48


[Costos.ArtCostoEmpresa.UltimoCosto]
Carpeta=Costos
Clave=ArtCostoEmpresa.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Costos.ArtCostoEmpresa.CostoPromedio]
Carpeta=Costos
Clave=ArtCostoEmpresa.CostoPromedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Costos.Art.CostoEstandar]
Carpeta=Costos
Clave=Art.CostoEstandar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Costos.Art.CostoReposicion]
Carpeta=Costos
Clave=Art.CostoReposicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Opciones]
Nombre=Opciones
Boton=0
Menu=&Ver
NombreDesplegar=Disponible a &Nivel Opción
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtDesglose
Activo=S
Antes=S

AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.ArtTipo, Art:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, Art:Art.TipoOpcion)
VisibleCondicion=(Art:Art.Tipo noen (TipoNormal, TipoServicio)) y (Art:Art.TipoOpcion<>TipoNo)
[ArtPartida.SubCuentaDesc]
Carpeta=ArtPartida
Clave=SubCuentaDesc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=200
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.Impuesto1]
Carpeta=Ficha
Clave=Art.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=$00C8D0D4

[Ficha.Art.Impuesto2]
Carpeta=Ficha
Clave=Art.Impuesto2
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=$00C8D0D4

[Ficha.Art.Impuesto3]
Carpeta=Ficha
Clave=Art.Impuesto3
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=$00C8D0D4

[Acciones.SubCostoCampos]
Nombre=SubCostoCampos
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[ArtCosto.ArtCosto.CostoPromedio]
Carpeta=ArtCosto
Clave=ArtCosto.CostoPromedio
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtCosto.ArtCosto.UltimoCosto]
Carpeta=ArtCosto
Clave=ArtCosto.UltimoCosto
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ArtCosto.Columnas]
0=57
1=114

2=-2



[Presupuesto.Presupuesto.Periodo]
Carpeta=Presupuesto
Clave=Presupuesto.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Presupuesto.Presupuesto.Presupuesto]
Carpeta=Presupuesto
Clave=Presupuesto.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Presupuesto.Presupuesto.Reservado]
Carpeta=Presupuesto
Clave=Presupuesto.Reservado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Presupuesto.Presupuesto.Ejercido]
Carpeta=Presupuesto
Clave=Presupuesto.Ejercido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Presupuesto.Disponible]
Carpeta=Presupuesto
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Presupuesto.Columnas]
0=33
1=48

2=-2
3=-2
4=-2
5=-2
[Acciones.ArtDisponibleDesglosar]
Nombre=ArtDisponibleDesglosar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Desglosar Opciones
EnMenu=S
TipoAccion=Expresion
Activo=S

Expresion=VerOpcionesArticuloAlmacen(POSArtDisponibleAlmTemp:POSArtDisponibleAlmTemp.Articulo, POSArtDisponibleAlmTemp:POSArtDisponibleAlmTemp.Almacen)
VisibleCondicion=Art:Art.TipoOpcion=<T>Si<T>

[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=173
VerValor=153



[ArtDisponible.ListaAcciones]
(Inicio)=ArtDisponibleDesglosar
ArtDisponibleDesglosar=ArtDisponibleTarima
ArtDisponibleTarima=(Fin)

[Costos.ListaEnCaptura]
(Inicio)=ArtCostoEmpresa.UltimoCosto
ArtCostoEmpresa.UltimoCosto=ArtCostoEmpresa.CostoPromedio
ArtCostoEmpresa.CostoPromedio=Art.CostoEstandar
Art.CostoEstandar=Art.CostoReposicion
Art.CostoReposicion=Art.MonedaCosto
Art.MonedaCosto=(Fin)



[Refacciones.ListaEnCaptura]
(Inicio)=ArtRefaccion.Refaccion
ArtRefaccion.Refaccion=Art.Descripcion1
Art.Descripcion1=ArtRefaccion.Cantidad
ArtRefaccion.Cantidad=(Fin)

[ArtPartida.ListaEnCaptura]
(Inicio)=ArtPartida.SubCuenta
ArtPartida.SubCuenta=SubCuentaDesc
SubCuentaDesc=ArtPartida.Existencia
ArtPartida.Existencia=ArtPartida.ExistenciaAlterna
ArtPartida.ExistenciaAlterna=ArtPartida.Almacen
ArtPartida.Almacen=(Fin)

[Sustitutos.ListaEnCaptura]
(Inicio)=ArtSustituto.Sustituto
ArtSustituto.Sustituto=Art.Descripcion1
Art.Descripcion1=(Fin)

[Sustitutos.ListaCamposAValidar]
(Inicio)=Art.PrecioLista
Art.PrecioLista=ArtSustituto.Comentarios
ArtSustituto.Comentarios=(Fin)

[ArtPartidaAsignado.ListaEnCaptura]
(Inicio)=Cliente
Cliente=Nombre
Nombre=Existencia
Existencia=ExistenciaAlterna
ExistenciaAlterna=Almacen
Almacen=(Fin)


[SubCostos.ListaEnCaptura]
(Inicio)=ArtSubCosto.UltimoCosto
ArtSubCosto.UltimoCosto=ArtSubCosto.CostoPromedio
ArtSubCosto.CostoPromedio=Art.MonedaCosto
Art.MonedaCosto=(Fin)

[SubCostos.ListaAcciones]
(Inicio)=VerOpcion
VerOpcion=SubCostoCampos
SubCostoCampos=(Fin)

[Servicios.ListaEnCaptura]
(Inicio)=ArtServicio.Servicio
ArtServicio.Servicio=Art.Descripcion1
Art.Descripcion1=ArtServicio.Cantidad
ArtServicio.Cantidad=(Fin)

[Consumibles.ListaEnCaptura]
(Inicio)=ArtConsumible.Consumible
ArtConsumible.Consumible=Art.Descripcion1
Art.Descripcion1=ArtConsumible.Cantidad
ArtConsumible.Cantidad=(Fin)

[ArtCosto.ListaEnCaptura]
(Inicio)=ArtCosto.CostoPromedio
ArtCosto.CostoPromedio=ArtCosto.UltimoCosto
ArtCosto.UltimoCosto=(Fin)

[Presupuesto.ListaEnCaptura]
(Inicio)=Presupuesto.Periodo
Presupuesto.Periodo=Presupuesto.Presupuesto
Presupuesto.Presupuesto=Presupuesto.Reservado
Presupuesto.Reservado=Presupuesto.Ejercido
Presupuesto.Ejercido=Disponible
Disponible=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)


[Ficha.Art.ObjetoGasto]
Carpeta=Ficha
Clave=Art.ObjetoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41












ColorFondo=$00C8D0D4




[Ficha.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.Descripcion2
Art.Descripcion2=Art.Tipo
Art.Tipo=EstatusNombre
EstatusNombre=Art.PrecioLista
Art.PrecioLista=Art.MonedaPrecio
Art.MonedaPrecio=Art.Categoria
Art.Categoria=Art.Familia
Art.Familia=Art.Fabricante
Art.Fabricante=Art.ClaveFabricante
Art.ClaveFabricante=Art.Unidad
Art.Unidad=Art.Peso
Art.Peso=Art.Volumen
Art.Volumen=Art.Impuesto1
Art.Impuesto1=Art.Impuesto2
Art.Impuesto2=Art.Impuesto3
Art.Impuesto3=Art.ObjetoGasto
Art.ObjetoGasto=(Fin)

[Precios.ListaEnCaptura]
(Inicio)=Art.PrecioLista
Art.PrecioLista=Art.Precio2
Art.Precio2=Art.Precio3
Art.Precio3=Art.Precio4
Art.Precio4=Art.Precio5
Art.Precio5=Art.Precio6
Art.Precio6=Art.Precio7
Art.Precio7=Art.Precio8
Art.Precio8=Art.Precio9
Art.Precio9=Art.Precio10
Art.Precio10=Art.PrecioMinimo
Art.PrecioMinimo=(Fin)

[Accesorios.ListaEnCaptura]
(Inicio)=ArtAccesorio.Accesorio
ArtAccesorio.Accesorio=Art.Descripcion1
Art.Descripcion1=(Fin)

[Accesorios.ListaCamposAValidar]
(Inicio)=Art.PrecioLista
Art.PrecioLista=Art.MonedaPrecio
Art.MonedaPrecio=(Fin)

[ArtDisponible.POSArtDisponibleAlmTemp.Disponible]
Carpeta=ArtDisponible
Clave=POSArtDisponibleAlmTemp.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[ArtReservado.POSArtResevadoAlmTemp.Reservado]
Carpeta=ArtReservado
Clave=POSArtResevadoAlmTemp.Reservado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco














































































































































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Precios
Precios=Accesorios
Accesorios=Servicios
Servicios=Sustitutos
Sustitutos=ArtDisponible
ArtDisponible=ArtReservado
ArtReservado=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Desglose
Desglose=Opciones
Opciones=ArtSerie
ArtSerie=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Ver
&Ver=&Explorar
&Explorar=(Fin)
