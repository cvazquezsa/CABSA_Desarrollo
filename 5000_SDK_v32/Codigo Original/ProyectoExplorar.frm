[Forma]
Clave=ProyectoExplorar
Nombre=Explorar Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=155
PosicionInicialArriba=165
PosicionInicialAlturaCliente=403
PosicionInicialAncho=714
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoTarea
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroArbolClave=ProyectoTarea.Clave
FiltroArbolRama=ProyectoTarea.Rama
FiltroArbolAcumulativas=ProyectoTarea.TieneDetalle
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=Tareas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
CarpetaVisible=S
FiltroArbolValidar=ProyectoTarea.Asunto
FiltroTodo=S
FiltroArbolOrden=ProyPlanTarea.Orden
OtroOrden=S
ListaOrden=(Lista)
PestanaOtroNombre=S
PestanaNombre=Tareas
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Asunto<T>
ElementosPorPagina=200
IconosNombre=ProyectoTarea:ProyectoTarea.Asunto
FiltroGeneral=ProyectoTarea.ID={Info.ID}

[Lista.Columnas]
0=347
1=47
Tiempo=39
TiempoUnidad=42
Asunto=316
Estado=88

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ProyectoTarea.Estado]
Carpeta=Lista
Clave=ProyectoTarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoTarea.Tiempo]
Carpeta=Lista
Clave=ProyectoTarea.Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoTarea.TiempoUnidad]
Carpeta=Lista
Clave=ProyectoTarea.TiempoUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProyectoTarea.Tiempo
ProyectoTarea.Tiempo=ProyectoTarea.TiempoUnidad
ProyectoTarea.TiempoUnidad=ProyectoTarea.Estado
ProyectoTarea.Estado=(Fin)

[Lista.ListaOrden]
(Inicio)=ProyectoTarea.Orden<TAB>(Acendente)
ProyectoTarea.Orden<TAB>(Acendente)=ProyectoTarea.Asunto<TAB>(Acendente)
ProyectoTarea.Asunto<TAB>(Acendente)=(Fin)
