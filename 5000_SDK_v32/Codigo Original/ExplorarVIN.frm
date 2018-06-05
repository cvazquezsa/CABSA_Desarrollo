[Forma]
Clave=ExplorarVIN
Nombre=Explorando - Unidades
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=182
PosicionInicialArriba=204
PosicionInicialAlturaCliente=588
PosicionInicialAncho=916
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
MovModulo=AUTO
ExpresionesAlMostrar=Asigna(Info.Filtro, Nulo)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VINLista
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>VIN<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=Art.Fabricante
FiltroValida1=Art.Fabricante
FiltroGrupo2=Art.Modelo
FiltroValida2=VIN.Modelo
FiltroGrupo3=Art.Linea
FiltroValida3=Art.Linea
FiltroGrupo4=Art.Version
FiltroValida4=Art.Version
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroGrupo5=Art.Articulo
FiltroValida5=Art.Articulo
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Unidades
FiltroTodo=S
FiltroTodoFinal=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=VINLista:VIN.VIN
FiltroEmpresas=S

[Lista.VIN.Articulo]
Carpeta=Lista
Clave=VIN.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Art.Fabricante]
Carpeta=Lista
Clave=Art.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Linea]
Carpeta=Lista
Clave=Art.Linea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Modelo]
Carpeta=Lista
Clave=Art.Modelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=4
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Version]
Carpeta=Lista
Clave=Art.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=154
1=78

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

[Acciones.Info]
Nombre=Info
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VINInfo
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
AntesExpresiones=Asigna(Info.VIN, VINLista:VIN.VIN)

[Acciones.LocalVINInfo]
Nombre=LocalVINInfo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información
EnMenu=S
TipoAccion=Formas
ClaveAccion=VINInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.VIN, VINLista:VIN.VIN)

[Acciones.LocalComponentes]
Nombre=LocalComponentes
Boton=0
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=&Ver Componentes
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(Info.VIN, VINLista:VIN.VIN)<BR>Asigna(Info.Bloqueado, Verdadero)<BR>Si(Config.VINAccesorioArt, Forma(<T>VINAccesorioArt<T>), Forma(<T>VINAccesorio<T>))
ActivoCondicion=Usuario.Costos

[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
NombreDesplegar=&Filtro
EnBarraHerramientas=S
Activo=S
Visible=S
TipoAccion=Expresion
Expresion=Asigna(Info.Filtro, FiltroArbolActual)<BR>Forma(<T>ExplorarVINAccesorios<T>)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Info
Info=Filtro
Filtro=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VIN.Articulo
VIN.Articulo=Art.Descripcion1
Art.Descripcion1=Art.Fabricante
Art.Fabricante=Art.Linea
Art.Linea=Art.Modelo
Art.Modelo=Art.Version
Art.Version=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ORDENADO
ORDENADO=RESERVADO
RESERVADO=ENFIRME
ENFIRME=FACTURADO
FACTURADO=SERVICIO
SERVICIO=DISPONIBLE
DISPONIBLE=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalVINInfo
LocalVINInfo=LocalComponentes
LocalComponentes=(Fin)
