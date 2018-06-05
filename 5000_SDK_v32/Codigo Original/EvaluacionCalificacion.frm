[Forma]
Clave=EvaluacionCalificacion
Nombre=Evaluaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=302
PosicionInicialArriba=191
PosicionInicialAlturaCliente=361
PosicionInicialAncho=675
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Si(Info.Aplica=<T>Movimientos<T>, e(Info.Nombre), Lista(Info.Clave, Info.Nombre, Info.Nombre2))

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
ListaOrden=EvaluacionCalificacion.Fecha<TAB>(Decendente)
BusquedaRapidaControles=S
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
NombreDesplegar=&Editar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(EvaluacionCalificacion:Evaluacion.Evaluacion)
AntesExpresiones=Asigna(Info.Evaluacion, EvaluacionCalificacion:Evaluacion.Evaluacion)<BR>Asigna(Info.Fecha, EvaluacionCalificacion:EvaluacionCalificacion.Fecha)<BR>Forma(<T>EvaluacionCto<T>)

[Lista.Evaluacion.Descripcion]
Carpeta=Lista
Clave=Evaluacion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Evaluacion.Tipo]
Carpeta=Lista
Clave=Evaluacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Evaluacion.Duracion]
Carpeta=Lista
Clave=Evaluacion.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EvaluacionCalificacion.Calificacion]
Carpeta=Lista
Clave=EvaluacionCalificacion.Calificacion
Editar=S
Totalizador=5
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EvaluacionCalificacion.Fecha]
Carpeta=Lista
Clave=EvaluacionCalificacion.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Agregar]
Nombre=Agregar
Boton=39
NombreEnBoton=S
NombreDesplegar=&Agregar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Fecha, Hoy)<BR>Asigna(Info.Evaluacion, Nulo)<BR>Si<BR>  Forma(<T>EvaluacionNueva<T>)<BR>Entonces<BR>  Si <BR>    ConDatos(Info.Evaluacion) y ConDatos(Info.Fecha)<BR>  Entonces<BR>    Forma(<T>EvaluacionCto<T>)<BR>  Fin<BR>Fin

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
DialogoMensaje=EstaSeguro
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(EvaluacionCalificacion:EvaluacionCalificacion.Evaluacion) y<BR>ConDatos(EvaluacionCalificacion:EvaluacionCalificacion.Fecha) y<BR>ConDatos(EvaluacionCalificacion:EvaluacionCalificacion.Contacto)
AntesExpresiones=EjecutarSQL(<T>spEvaluacionCtoEliminar :tEval, :fFecha, :tCto<T>, EvaluacionCalificacion:EvaluacionCalificacion.Evaluacion, EvaluacionCalificacion:EvaluacionCalificacion.Fecha, EvaluacionCalificacion:EvaluacionCalificacion.Contacto )


[Lista.ListaEnCaptura]
(Inicio)=Evaluacion.Descripcion
Evaluacion.Descripcion=Evaluacion.Tipo
Evaluacion.Tipo=Evaluacion.Duracion
Evaluacion.Duracion=EvaluacionCalificacion.Fecha
EvaluacionCalificacion.Fecha=EvaluacionCalificacion.Calificacion
EvaluacionCalificacion.Calificacion=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Agregar
Agregar=EvaluacionCto
EvaluacionCto=Eliminar
Eliminar=(Fin)
