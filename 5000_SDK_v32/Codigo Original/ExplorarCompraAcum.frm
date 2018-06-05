[Forma]
Clave=ExplorarCompraAcum
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
PosicionInicialIzquierda=255
PosicionInicialArriba=91
PosicionInicialAltura=457
PosicionInicialAncho=911
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
PestanaNombre=Proveedores
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraAcum
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
FiltroValida1=Prov
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
MenuLocal=S
ListaAcciones=LocalProveedor
FiltroListas=S
FiltroListasRama=CXP
FiltroListasAplicaEn=Proveedor
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroMonedas=S
FiltroMonedasCampo=Moneda
PermiteLocalizar=S
IconosNombre=CompraAcum:Proveedor
FiltroAplicaEn1=Proveedor

[Lista.Columnas]
0=97
1=221
2=-2
3=-2

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
EspacioPrevio=S
EjecucionCondicion=ConDatos(CompraAcum:Proveedor)
AntesExpresiones=Asigna( Info.Proveedor, CompraAcum:Proveedor)

[Acciones.LocalProveedor]
Nombre=LocalProveedor
Boton=0
NombreDesplegar=&Información del Proveedor
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna( Info.Proveedor, CompraAcum:Proveedor)

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
EspacioPrevio=
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Lista.CompraMes]
Carpeta=Lista
Clave=CompraMes
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CompraAcum]
Carpeta=Lista
Clave=CompraAcum
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Nombre]
Carpeta=Lista
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=68
NombreDesplegar=&Reporte
TipoAccion=Formas
ClaveAccion=RepCompraAcum
ListaParametros1=Info.ProveedorD<BR>Info.ProveedorA
Activo=S
Visible=S
EnBarraHerramientas=S
EspacioPrevio=S

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
NombreDesplegar=&Imprimir
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

[Lista.ListaEnCaptura]
(Inicio)=Nombre
Nombre=CompraMes
CompraMes=CompraAcum
CompraAcum=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=RepPantalla
RepPantalla=Proveedor
Proveedor=Mostrar Campos
Mostrar Campos=(Fin)
