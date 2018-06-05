[Forma]
Clave=ExplorarCompraAcumD
Nombre=<T>Explorando - Compras Acumuladas
Icono=47
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=197
PosicionInicialArriba=240
PosicionInicialAltura=426
PosicionInicialAncho=885
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=517

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

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Artículos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraAcumD
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Proveedor<T>
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAncho=25
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
MenuLocal=S
ListaAcciones=(Lista)
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Articulo
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtGrupo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Fabricante
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Familia
FiltroAplicaEn3=Art.Grupo
FiltroAplicaEn4=Art.Fabricante
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
FiltroMonedas=S
FiltroMonedasCampo=Moneda
PermiteLocalizar=S
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
IconosNombre=CompraAcumD:Prov.Proveedor

[Lista.Columnas]
0=97
1=103

[Lista.CantidadAcum]
Carpeta=Lista
Clave=CantidadAcum
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Desglosar]
Nombre=Desglosar
Boton=47
NombreEnBoton=S
NombreDesplegar=&Desglosar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(CompraAcumD:Proveedor) y ConDatos(CompraAcumD:Articulo)
AntesExpresiones=IrModulo(<T>COMS<T>)<BR>IrDireccion(<T>COMS<T>, CompraAcumD:Articulo, CompraAcumD:Proveedor)

[Acciones.Articulo]
Nombre=Articulo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Artículo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CompraAcumD:Articulo)
AntesExpresiones=Asigna( Info.Articulo, CompraAcumD:Articulo)

[Acciones.Proveedor]
Nombre=Proveedor
Boton=34
NombreEnBoton=S
NombreDesplegar=&Proveedor
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CompraAcumD:Prov.Proveedor)
AntesExpresiones=Asigna( Info.Proveedor, CompraAcumD:Prov.Proveedor)

[Acciones.LocalDesglosar]
Nombre=LocalDesglosar
Boton=0
NombreDesplegar=&Desglosar
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Antes=S
Visible=S
AntesExpresiones=IrModulo(<T>COMS<T>)<BR>IrDireccion(<T>COMS<T>, CompraAcumD:Articulo, CompraAcumD:Prov.Proveedor)

[Acciones.LocalArticulo]
Nombre=LocalArticulo
Boton=0
NombreDesplegar=Información del &Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna( Info.Articulo, CompraAcumD:Articulo )

[Acciones.LocalProveedor]
Nombre=LocalProveedor
Boton=0
NombreDesplegar=Información del &Proveedor
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna( Info.Proveedor, CompraAcumD:Prov.Proveedor)

[Lista.Articulo]
Carpeta=Lista
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.CantidadMes]
Carpeta=Lista
Clave=CantidadMes
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Descripcion1]
Carpeta=Lista
Clave=Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraMes]
Carpeta=Lista
Clave=CompraMes
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraAcum]
Carpeta=Lista
Clave=CompraAcum
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Desglosar
Desglosar=Articulo
Articulo=Proveedor
Proveedor=Mostrar Campos
Mostrar Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Articulo
Articulo=Descripcion1
Descripcion1=CompraMes
CompraMes=CantidadMes
CantidadMes=CompraAcum
CompraAcum=CantidadAcum
CantidadAcum=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalDesglosar
LocalDesglosar=LocalArticulo
LocalArticulo=LocalProveedor
LocalProveedor=(Fin)
