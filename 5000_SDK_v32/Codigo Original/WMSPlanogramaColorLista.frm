
[Forma]
Clave=WMSPlanogramaColorLista
Icono=0
Modulos=(Todos)
Nombre=Colores

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=823
PosicionInicialArriba=371
PosicionInicialAlturaCliente=280
PosicionInicialAncho=301
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Color
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Color
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S



PestanaOtroNombre=S
PestanaNombre=Color




PermiteLocalizar=S
ListaEnCaptura=Color.Numero
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=Color.Color<TAB>(Acendente)
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
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
FiltroGrupo1=Color.Numero
FiltroValida1=Color.Numero
FiltroTodo=S
IconosNombre=Color:Color.Color
[Lista.Columnas]
0=80
1=160
2=-2
3=64
4=-2




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


[Lista.ListaOrden]
(Inicio)=AlmPos.Orden	(Acendente)
AlmPos.Orden	(Acendente)=AlmPos.Posicion	(Acendente)
AlmPos.Posicion	(Acendente)=(Fin)








[Lista.ListaEnCaptura]
(Inicio)=Nombre
Nombre=Grupo
Grupo=(Fin)








[Lista.Color.Numero]
Carpeta=Lista
Clave=Color.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)











[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
