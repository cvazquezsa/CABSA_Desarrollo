[Forma]
Clave=OpcionDLista
Nombre=Detalles de la Opción
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Opcion, Info.Descripcion)
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=237
PosicionInicialArriba=157
PosicionInicialAltura=446
PosicionInicialAncho=545
VentanaExclusiva=S
PosicionInicialAlturaCliente=419

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OpcionD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
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
FiltroPredefinido1=por Número<BR>por Nombre
FiltroPredefinido2=OpcionD.Opcion IS NOT NULL<BR>OpcionD.Opcion IS NOT NULL
FiltroPredefinido3=OpcionD.Numero<BR>OpcionD.Nombre
FiltroEstilo=Directorio
FiltroGeneral=OpcionD.Opcion=<T>{Info.Opcion}<T>

[Lista.OpcionD.Numero]
Carpeta=Lista
Clave=OpcionD.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=N

[Lista.OpcionD.Nombre]
Carpeta=Lista
Clave=OpcionD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Numero=58
Nombre=334

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

[Lista.ListaEnCaptura]
(Inicio)=OpcionD.Numero
OpcionD.Numero=OpcionD.Nombre
OpcionD.Nombre=(Fin)
