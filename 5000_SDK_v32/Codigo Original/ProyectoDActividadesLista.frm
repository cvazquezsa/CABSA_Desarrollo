
[Forma]
Clave=ProyectoDActividadesLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Fases del Proyecto
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=498
PosicionInicialArriba=210
PosicionInicialAlturaCliente=400
PosicionInicialAncho=443
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=Seleccionar
Comentarios=Info.Proyecto
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoD
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ProyectoD.Asunto

ListaOrden=ProyectoD.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Actividad<T>
ElementosPorPaginaEsp=200
PestanaOtroNombre=S
PestanaNombre=Actividades
IconosNombre=ProyectoD:ProyectoD.Actividad
FiltroGeneral=ProyectoD.ID = {Info.ID} AND ProyectoD.EsFase = 1
[Lista.ListaEnCaptura]
(Inicio)=ProyectoD.Actividad
ProyectoD.Actividad=ProyectoD.Asunto
ProyectoD.Asunto=(Fin)


[Lista.ProyectoD.Asunto]
Carpeta=Lista
Clave=ProyectoD.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Actividad=88
Asunto=322

0=98
1=-2
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
