[Forma]
Clave=EvaluacionComentariosInfo
Nombre=<T>Comentarios - <T>+Info.Evaluacion
Icono=17
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Si(Info.Aplica=<T>Movimientos<T>, Info.Nombre, Lista(Info.Clave, Info.Nombre, Info.Nombre2))
PosicionInicialIzquierda=232
PosicionInicialArriba=201
PosicionInicialAlturaCliente=332
PosicionInicialAncho=559
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EvaluacionComentarios
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=EvaluacionComentarios.Comentarios
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
AlinearTodaCarpeta=S
FiltroGeneral=EvaluacionComentarios.Evaluacion=<T>{Info.Evaluacion}<T> AND<BR>EvaluacionComentarios.Fecha=<T>{FechaFormatoServidor(Info.Fecha)}<T> AND<BR>EvaluacionComentarios.Contacto=<T>{Info.Clave}<T>

[Ficha.EvaluacionComentarios.Comentarios]
Carpeta=Ficha
Clave=EvaluacionComentarios.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10x10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
