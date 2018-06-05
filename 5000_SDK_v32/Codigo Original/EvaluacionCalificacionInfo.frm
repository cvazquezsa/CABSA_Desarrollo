[Forma]
Clave=EvaluacionCalificacionInfo
Nombre=Evaluaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=616
PosicionInicialArriba=384
PosicionInicialAlturaCliente=396
PosicionInicialAncho=688
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Si(Info.Aplica=<T>Movimientos<T>, Info.Nombre, Lista(Info.Clave, Info.Nombre, Info.Nombre2))

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EvaluacionCalificacion
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Evaluación<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=(Lista)
OtroOrden=S
BusquedaRapidaControles=S
ListaOrden=EvaluacionCalificacion.Fecha<TAB>(Decendente)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=EvaluacionCalificacion.Fecha
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha

IconosNombre=EvaluacionCalificacion:Evaluacion.Evaluacion
FiltroGeneral=Evaluacion.Aplica=<T>{Info.Aplica}<T>
[Lista.Columnas]
0=177
1=188

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

[Acciones.EvaluacionCto]
Nombre=EvaluacionCto
Boton=35
NombreEnBoton=S
NombreDesplegar=&Evaluación
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EvaluacionCtoInfo
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionCondicion=ConDatos(EvaluacionCalificacion:Evaluacion.Evaluacion)
AntesExpresiones=Asigna(Info.Evaluacion, EvaluacionCalificacion:Evaluacion.Evaluacion)<BR>Asigna(Info.Fecha, EvaluacionCalificacion:EvaluacionCalificacion.Fecha)

[Lista.Evaluacion.Descripcion]
Carpeta=Lista
Clave=Evaluacion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Evaluacion.Tipo]
Carpeta=Lista
Clave=Evaluacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Evaluacion.Duracion]
Carpeta=Lista
Clave=Evaluacion.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.EvaluacionCalificacion.Calificacion]
Carpeta=Lista
Clave=EvaluacionCalificacion.Calificacion
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EvaluacionCalificacion.Fecha]
Carpeta=Lista
Clave=EvaluacionCalificacion.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.ListaEnCaptura]
(Inicio)=Evaluacion.Descripcion
Evaluacion.Descripcion=Evaluacion.Tipo
Evaluacion.Tipo=Evaluacion.Duracion
Evaluacion.Duracion=EvaluacionCalificacion.Fecha
EvaluacionCalificacion.Fecha=EvaluacionCalificacion.Calificacion
EvaluacionCalificacion.Calificacion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=EvaluacionCto
EvaluacionCto=(Fin)
