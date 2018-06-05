[Forma]
Clave=MenuAccionLista
Nombre=Acciones del Menú
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
CarpetaPrincipal=Lista
PosicionInicialIzquierda=292
PosicionInicialArriba=185
PosicionInicialAlturaCliente=572
PosicionInicialAncho=660
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MenuAccion
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MenuAccion.Nombre
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Acciones
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
FiltroAutoCampo=MenuAccion.Estatus
FiltroAutoValidar=Estatus.Nombre
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroAplicaEn=MenuAccion.Estatus
FiltroGrupo1=MenuAccion.Estatus
FiltroValida1=EstatusNombre
FiltroEstilo=Directorio
IconosNombre=MenuAccion:MenuAccion.Accion

[Lista.MenuAccion.Nombre]
Carpeta=Lista
Clave=MenuAccion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=170
1=394

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

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
