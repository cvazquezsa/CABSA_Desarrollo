[Forma]
Clave=ServicioTareaOrdenar
Nombre=Ordenar Tareas
Icono=48
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=300
PosicionInicialArriba=103
PosicionInicialAltura=385
PosicionInicialAncho=423
ListaAcciones=(Lista)
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
PosicionInicialAlturaCliente=527

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioTarea
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Registros
OtroOrden=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Orden<T>
ElementosPorPagina=200
ListaEnCaptura=ServicioTarea.Tarea
ListaOrden=ServicioTarea.Orden<TAB>(Acendente)
IconosCambiarOrden=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=ServicioTarea:ServicioTarea.Orden
FiltroGeneral=ServicioTarea.ID={Info.ID}

[Lista.ServicioTarea.Tarea]
Carpeta=Lista
Clave=ServicioTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=47
1=341

[Acciones.Ordenar]
Nombre=Ordenar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Nuevo Orden
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Antes=S
Visible=S
AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>ServicioTarea.Tarea<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla, @ID=:nID<T>, EstacionTrabajo, <T>ServicioTarea<T>, Info.ID)

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)
