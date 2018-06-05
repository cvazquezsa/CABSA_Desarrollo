[Forma]
Clave=ExplorarVentaAcumD
Nombre=<T>Explorando - Ventas Acumuladas (Detalle)
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
PosicionInicialIzquierda=517
PosicionInicialArriba=319
PosicionInicialAltura=430
PosicionInicialAncho=885
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=403

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
Vista=VentaAcumD
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Cliente<T>
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

OtroOrden=S
ListaOrden=Cliente<TAB>(Acendente)
Paginacion=S
PaginacionTamano=1000
IconosNombre=VentaAcumD:Cliente
[Lista.Columnas]
0=97
1=103

2=-2
3=-2
4=-2
5=-2
6=-2
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
EjecucionCondicion=ConDatos(VentaAcumD:Cliente) y ConDatos(VentaAcumD:Articulo)
AntesExpresiones=IrModulo(<T>VTAS<T>)<BR>IrDireccion(<T>VTAS<T>, VentaAcumD:Articulo, VentaAcumD:Cliente)

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
EjecucionCondicion=ConDatos(VentaAcumD:Articulo)
AntesExpresiones=Asigna( Info.Articulo, VentaAcumD:Articulo)

[Acciones.Cliente]
Nombre=Cliente
Boton=34
NombreEnBoton=S
NombreDesplegar=C&liente
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteInfo
ActivoCondicion=Usuario.CteInfo
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(VentaAcumD:Cliente)
AntesExpresiones=Asigna( Info.Cliente, VentaAcumD:Cliente)

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
AntesExpresiones=IrModulo(<T>VTAS<T>)<BR>IrDireccion(<T>VTAS<T>, VentaAcumD:Articulo, VentaAcumD:Cliente)

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
AntesExpresiones=Asigna( Info.Articulo, VentaAcumD:Articulo )

[Acciones.LocalCliente]
Nombre=LocalCliente
Boton=0
NombreDesplegar=Información del &Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna( Info.Cliente, VentaAcumD:Cliente)

[Lista.Articulo]
Carpeta=Lista
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Lista.CantidadMes]
Carpeta=Lista
Clave=CantidadMes
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaMes]
Carpeta=Lista
Clave=VentaMes
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaAcum]
Carpeta=Lista
Clave=VentaAcum
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
TipoAccion=Reportes Impresora
ClaveAccion=VentaAcumDTotalE
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T> WHERE <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T> <T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=VentaAcumDTotalE
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T> WHERE <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T> <T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco










[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Paginacion
Activo=S
Visible=S


[Acciones.Totales]
Nombre=Totales
Boton=64
NombreEnBoton=S
NombreDesplegar=Totales
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ExplorarVentaAcumDTotal
Activo=S
Visible=S






Antes=S



AntesExpresiones=Asigna(Info.Filtro,<T> WHERE <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T> <T> & Carpeta.FiltroActual( <T>Lista<T> ))



[Lista.ListaEnCaptura]
(Inicio)=Articulo
Articulo=Art.Descripcion1
Art.Descripcion1=VentaMes
VentaMes=CantidadMes
CantidadMes=VentaAcum
VentaAcum=CantidadAcum
CantidadAcum=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalDesglosar
LocalDesglosar=LocalArticulo
LocalArticulo=LocalCliente
LocalCliente=(Fin)

























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Desglosar
Desglosar=Cliente
Cliente=Articulo
Articulo=Navegador
Navegador=Totales
Totales=Mostrar Campos
Mostrar Campos=(Fin)
