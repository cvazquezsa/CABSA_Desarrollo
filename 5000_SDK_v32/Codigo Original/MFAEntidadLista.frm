
[Forma]
Clave=MFAEntidadLista
Icono=0
Modulos=(Todos)
Nombre=MFA - Lista Entidades

ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=391
PosicionInicialArriba=136
PosicionInicialAlturaCliente=439
PosicionInicialAncho=497
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAEntidad
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

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
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=MFAEntidad.entidad_tipo
FiltroAutoValidar=MFAEntidad.entidad_tipo
FiltroAutoOrden=MFAEntidad.entidad_tipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Folder (1 línea)
FiltroRespetar=S
FiltroTipo=Automático
IconosNombre=MFAEntidad:MFAEntidad.entidad_clave
FiltroGeneral={Si(Info.Tipo = <T><T>,<T> 1 = 1 <T>,<T> entidad_tipo = <T> + ASCII(39) + Info.Tipo + ASCII(39))}
[Lista.MFAEntidad.entidad_nombre]
Carpeta=Lista
Clave=MFAEntidad.entidad_nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.MFAEntidad.entidad_tipo]
Carpeta=Lista
Clave=MFAEntidad.entidad_tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco


[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Columnas]
0=90
1=299
2=-2





















[Lista.ListaEnCaptura]
(Inicio)=MFAEntidad.entidad_nombre
MFAEntidad.entidad_nombre=MFAEntidad.entidad_tipo
MFAEntidad.entidad_tipo=(Fin)
