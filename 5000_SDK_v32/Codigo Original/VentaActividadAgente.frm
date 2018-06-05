[Forma]
Clave=VentaActividadAgente
Nombre=Actividades del Agente - Movimientos Pendientes
Icono=48
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=124
PosicionInicialArriba=128
PosicionInicialAlturaCliente=477
PosicionInicialAncho=775
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=82
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Agente, Info.Nombre)
ExpresionesAlMostrar=Asigna(Info.Agente, Usuario.DefAgente)<BR>Asigna(Ver.Todo, Falso)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaActividad
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroAplicaEn=VentaDAgente.Estado
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=TareaEstado
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ValidarCampos=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroFechas=S
FiltroFechasCampo=VentaDAgente.Fecha
FiltroFechasDefault=Esta Semana
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Actividades
IconosNombre=VentaActividad:MovNombre
FiltroGeneral=Venta.Empresa=<T>{Empresa}<T> <BR>AND Venta.Estatus=<T>PENDIENTE<T><BR>AND (ISNULL(VentaD.CantidadPendiente,0)+ISNULL(VentaD.CantidadOrdenada, 0)+ISNULL(VentaD.CantidadReservada, 0))>0<BR>AND VentaDAgente.Agente=<T>{Info.Agente}<T>

[Lista.VentaDAgente.Actividad]
Carpeta=Lista
Clave=VentaDAgente.Actividad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Lista.VentaDAgente.Estado]
Carpeta=Lista
Clave=VentaDAgente.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.Fecha]
Carpeta=Lista
Clave=VentaDAgente.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.HoraD]
Carpeta=Lista
Clave=VentaDAgente.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.HoraA]
Carpeta=Lista
Clave=VentaDAgente.HoraA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tiempo]
Carpeta=Lista
Clave=Tiempo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Columnas]
Actividad=181
Estado=95
Agente=61
Fecha=69
HoraD=43
HoraA=37
Tiempo=39
Comentarios=97
MovNombre=94
Cliente=76
Articulo=83
0=127
1=92

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

[Comentarios.VentaDAgente.Comentarios]
Carpeta=Comentarios
Clave=VentaDAgente.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=50x3
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaD.Articulo]
Carpeta=Lista
Clave=VentaD.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

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
(Inicio)=Cerrar
Cerrar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaDAgente.Fecha
VentaDAgente.Fecha=VentaDAgente.HoraD
VentaDAgente.HoraD=VentaDAgente.HoraA
VentaDAgente.HoraA=Tiempo
Tiempo=VentaDAgente.Actividad
VentaDAgente.Actividad=VentaDAgente.Estado
VentaDAgente.Estado=VentaD.Articulo
VentaD.Articulo=(Fin)
