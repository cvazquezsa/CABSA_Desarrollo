[Forma]
Clave=ExplorarInvCorte
Nombre=<T>Explorando - Inventario al <T>+FechaEnTexto(Info.Fecha, <T>dd/mmm/aaaa<T>)
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=514
PosicionInicialAncho=742
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=269
PosicionInicialArriba=241
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Vacio(Info.Almacen, <T>Falta Especificar Almacén<T>), Vacio(FechaEnTexto(Info.Fecha, <T>dd/mmm/aaaa<T>), <T>Falta Indicar Fecha Corte<T>))
ExpresionesAlMostrar=Asigna(Info.Fecha, SQL(<T>SELECT MIN(Fecha) FROM VerInvCorte WHERE Estacion=:nEstacion AND Empresa=:tEmp<T>, EstacionTrabajo, Empresa))<BR>Asigna(Info.Almacen, SQL(<T>SELECT MIN(Almacen) FROM VerInvCorte WHERE Estacion=:nEstacion AND Empresa=:tEmp<T>, EstacionTrabajo, Empresa))

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerInvCorte
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Artículos
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroAplicaEn1=Art.Categoria
FiltroTodo=S
FiltroTodoFinal=S
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=VerInvCorte.Articulo
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroAplicaEn5=Art.Fabricante
IconosNombre=VerInvCorte:Art.Articulo
FiltroGeneral=VerInvCorte.Estacion={EstacionTrabajo} AND<BR>VerInvCorte.Empresa=<T>{Empresa}<T>

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerInvCorte.Almacen]
Carpeta=Lista
Clave=VerInvCorte.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerInvCorte.Existencia]
Carpeta=Lista
Clave=VerInvCorte.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=109
1=174

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
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

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

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=Información del Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(VerInvCorte:VerInvCorte.Articulo)
Antes=S
AntesExpresiones=Asigna(Info.Articulo, VerInvCorte:VerInvCorte.Articulo)
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Fecha.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spGenerarInvCorte :nEstacion, :tEmp, :tAlm, :fFecha<T>,  EstacionTrabajo , Empresa, Info.Almacen, Vacio(Info.Fecha, Nulo))

[Acciones.Fecha.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Fecha]
Nombre=Fecha
Boton=53
NombreEnBoton=S
NombreDesplegar=&Parámetros
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
ListaAccionesMultiples=Expresion<BR>Actualizar Titulos<BR>Actualizar Forma
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Forma(<T>EspecificarInvCorte<T>)

[Acciones.Almacen.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spGenerarInvCorte :nEstacion, :tEmp, :tAlm, :fFecha<T>,  EstacionTrabajo , Empresa, Info.Almacen, Info.Fecha)

[Acciones.Almacen.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Almacen.Actualizar Titulos]
Nombre=Actualizar Titulos
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
Activo=S
Visible=S

[Acciones.Fecha.Actualizar Titulos]
Nombre=Actualizar Titulos
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
Activo=S
Visible=S

[Lista.VerInvCorte.SubCuenta]
Carpeta=Lista
Clave=VerInvCorte.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=ArtInfo
ArtInfo=Personalizar
Personalizar=Fecha
Fecha=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=VerInvCorte.SubCuenta
VerInvCorte.SubCuenta=VerInvCorte.Almacen
VerInvCorte.Almacen=VerInvCorte.Existencia
VerInvCorte.Existencia=(Fin)
