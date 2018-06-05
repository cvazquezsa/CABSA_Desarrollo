[Forma]
Clave=ExplorarEspacioAsigacion
Nombre=Explorando - Asignación Directa
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=92
PosicionInicialArriba=146
PosicionInicialAlturaCliente=442
PosicionInicialAncho=840
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EspacioAsignacion
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Espacio<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroEstatus=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroProyectos=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroFechasCampo=EspacioAsignacion.Fecha
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosNombre=EspacioAsignacion:EspacioAsignacion.Espacio
FiltroGeneral=EspacioAsignacion.Empresa=<T>{Empresa}<T>

[Lista.Espacio.Nombre]
Carpeta=Lista
Clave=Espacio.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioAsignacion.Fecha]
Carpeta=Lista
Clave=EspacioAsignacion.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioAsignacion.Hora]
Carpeta=Lista
Clave=EspacioAsignacion.Hora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioAsignacion.Cliente]
Carpeta=Lista
Clave=EspacioAsignacion.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioAsignacion.Proyecto]
Carpeta=Lista
Clave=EspacioAsignacion.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=84
1=98

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S

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

[Acciones.EspacioInfo]
Nombre=EspacioInfo
Boton=34
NombreDesplegar=&Espacio
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EspacioInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(EspacioAsignacion:EspacioAsignacion.Espacio)
AntesExpresiones=Asigna(Info.Espacio, EspacioAsignacion:EspacioAsignacion.Espacio)

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
NombreDesplegar=C&liente
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(EspacioAsignacion:EspacioAsignacion.Cliente)
AntesExpresiones=Asigna(Info.Cliente, EspacioAsignacion:EspacioAsignacion.Cliente)

[Acciones.ProyInfo]
Nombre=ProyInfo
Boton=34
NombreDesplegar=&Proyecto
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(EspacioAsignacion:EspacioAsignacion.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, EspacioAsignacion:EspacioAsignacion.Proyecto)


[Lista.ListaEnCaptura]
(Inicio)=Espacio.Nombre
Espacio.Nombre=EspacioAsignacion.Fecha
EspacioAsignacion.Fecha=EspacioAsignacion.Hora
EspacioAsignacion.Hora=EspacioAsignacion.Cliente
EspacioAsignacion.Cliente=Cte.Nombre
Cte.Nombre=EspacioAsignacion.Proyecto
EspacioAsignacion.Proyecto=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=CONFIRMADO
CONFIRMADO=RECHAZADO
RECHAZADO=BAJA
BAJA=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=EspacioInfo
EspacioInfo=CteInfo
CteInfo=ProyInfo
ProyInfo=Personalizar
Personalizar=(Fin)
