[Forma]
Clave=ExplorarInvSerieLote
Nombre=Explorando - Inventario SeriesLotes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=296
PosicionInicialArriba=101
PosicionInicialAlturaCliente=487
PosicionInicialAncho=758
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.VerDetalles, falso)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLotePropExistencia
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Series/Lotes
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroAplicaEn5=Art.Fabricante
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroListas=S
FiltroListasRama=INV
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
FiltroListasAplicaEn=Art.Articulo
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroTodoFinal=S
FiltroSucursales=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaAjustarColumnas=S
HojaMantenerSeleccion=S

FiltroGeneral=SerieLote.Empresa=<T>{Empresa}<T><BR>{Si(no Info.VerDetalles, <T> AND SerieLote.Existencia>0<T>, <T><T>)}
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.SerieLote.SerieLote]
Carpeta=Lista
Clave=SerieLote.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SerieLote.Almacen]
Carpeta=Lista
Clave=SerieLote.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.SerieLote.Existencia]
Carpeta=Lista
Clave=SerieLote.Existencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=96
1=181
Articulo=124
Descripcion1=184
SerieLote=124
Almacen=64
Existencia=64

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
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(SerieLotePropExistencia:SerieLote.Articulo)
AntesExpresiones=Asigna(Info.Articulo, SerieLotePropExistencia:SerieLote.Articulo)

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Visible=S

[Lista.SerieLote.Articulo]
Carpeta=Lista
Clave=SerieLote.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Serie/Lote
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(SerieLotePropExistencia:SerieLote.Articulo)
AntesExpresiones=Asigna(Info.Articulo, SerieLotePropExistencia:SerieLote.Articulo)<BR>Asigna(Info.SerieLote, SerieLotePropExistencia:SerieLote.SerieLote)<BR>Asigna(Info.ArtTipo, SerieLotePropExistencia:Art.Tipo)

[Acciones.VerTodo]
Nombre=VerTodo
Boton=50
NombreEnBoton=S
NombreDesplegar=&Ver Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Visible=S
ActivoCondicion=no Info.VerDetalles
Antes=S
AntesExpresiones=Asigna(Info.VerDetalles, Verdadero)



[Acciones.MESExplorar]
Nombre=MESExplorar
Boton=106
NombreDesplegar=Explorar Factory
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.Base,SQL(<T>SELECT DB_NAME()<T>))<BR>Asigna(Info.Anuncio,SQL(<T>SELECT ServidorWEB FROM Version<T>))<BR>Asigna(Info.Mensaje,<T>http://<T>+Info.Anuncio+<T>/Trazabilidad.aspx?DB=IP<T>+Info.Base+ <T>&&Usuario=<T>+Usuario+<T>&&Articulo=<T>+SerieLotePropExistencia:SerieLote.Articulo+<T>&&Lote=<T>+SerieLotePropExistencia:SerieLote.SerieLote)<BR>Browser( Info.Mensaje,<T>Trazabilidad Factory<T> ,verdadero)












[Lista.ListaEnCaptura]
(Inicio)=SerieLote.Articulo
SerieLote.Articulo=Art.Descripcion1
Art.Descripcion1=SerieLote.SerieLote
SerieLote.SerieLote=SerieLote.Almacen
SerieLote.Almacen=SerieLote.Existencia
SerieLote.Existencia=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=ArtInfo
ArtInfo=SerieLoteInfo
SerieLoteInfo=Personalizar
Personalizar=VerTodo
VerTodo=MESExplorar
MESExplorar=(Fin)
