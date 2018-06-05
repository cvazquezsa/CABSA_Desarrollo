[Forma]
Clave=ExplorarArtAlm
Nombre=Explorando - Artículos en Almacenes
Icono=47
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=286
PosicionInicialArriba=121
PosicionInicialAltura=473
PosicionInicialAncho=793
PosicionInicialAlturaCliente=446

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtAlm
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
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=ArtAlm.UltimoMovimiento
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
FiltroTodo=S
FiltroTodoFinal=S
FiltroListas=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
PestanaOtroNombre=S
PestanaNombre=Artículos
FiltroListasRama=INV
FiltroListasAplicaEn=ArtAlm.Articulo

OtroOrden=S
ListaOrden=ArtAlm.Articulo<TAB>(Acendente)
Paginacion=S
PaginacionTamano=1000
IconosNombre=ArtAlm:ArtAlm.Articulo
[Lista.ArtAlm.SubCuenta]
Carpeta=Lista
Clave=ArtAlm.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ArtAlm.Almacen]
Carpeta=Lista
Clave=ArtAlm.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ArtAlm.UltimoMovimiento]
Carpeta=Lista
Clave=ArtAlm.UltimoMovimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtAlm.Localizacion]
Carpeta=Lista
Clave=ArtAlm.Localizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

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

[Lista.Columnas]
0=91
1=87

2=-2
3=-2
4=-2
5=-2
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Impresora
ClaveAccion=ArtAlmTotal
Activo=S
Visible=S


Antes=S
AntesExpresiones=Asigna(Info.Valor,<T><T> & Carpeta.FiltroActual( <T>Lista<T> ))
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

[Acciones.Existencia]
Nombre=Existencia
Boton=47
NombreEnBoton=S
NombreDesplegar=&Existencia
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtAlmExistencia
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, ArtAlm:ArtAlm.Articulo)<BR>Asigna(Info.Almacen, ArtAlm:ArtAlm.Almacen)<BR>Asigna(Info.Descripcion, ArtAlm:Art.Descripcion1)



[Acciones.ExcelTotal]
Nombre=ExcelTotal
Boton=67
NombreDesplegar=Excel(Total)
EnBarraHerramientas=S
TipoAccion=Reportes Excel
ClaveAccion=ArtAlmTotal
Activo=S
Antes=S
Visible=S


NombreEnBoton=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Valor,<T><T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Paginacion
Activo=S
Visible=S










EspacioPrevio=S
[Lista.ListaEnCaptura]
(Inicio)=ArtAlm.SubCuenta
ArtAlm.SubCuenta=Art.Descripcion1
Art.Descripcion1=ArtAlm.Almacen
ArtAlm.Almacen=ArtAlm.UltimoMovimiento
ArtAlm.UltimoMovimiento=ArtAlm.Localizacion
ArtAlm.Localizacion=(Fin)


















[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=ArtAlmTotal
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Valor,<T><T> & Carpeta.FiltroActual( <T>Lista<T> ))
Visible=S









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Existencia
Existencia=ExcelTotal
ExcelTotal=Navegador
Navegador=Personalizar
Personalizar=(Fin)
