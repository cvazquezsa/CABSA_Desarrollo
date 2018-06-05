[Forma]
Clave=EvaluacionCtoHist
Nombre=Histórico
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Si(Info.Aplica=<T>Movimientos<T>, Lista(Info.Evaluacion, Info.Nombre), Lista(Info.Evaluacion, Info.Clave, Info.Nombre))
PosicionInicialIzquierda=368
PosicionInicialArriba=291
PosicionInicialAlturaCliente=414
PosicionInicialAncho=543
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=EvaluacionCtoHist
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Punto<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todos los puntos)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
PestanaOtroNombre=S
FiltroAplicaEn=EvaluacionCtoHist.Punto
FiltroAutoCampo=EvaluacionCtoHist.Punto
FiltroAutoValidar=EvaluacionCtoHist.Punto
FiltroEstilo=Lista (Arriba)
FiltroTodo=S
IconosNombre=EvaluacionCtoHist:EvaluacionCtoHist.Punto
FiltroGeneral=EvaluacionCtoHist.Evaluacion=<T>{Info.Evaluacion}<T> AND<BR>EvaluacionCtoHist.Contacto=<T>{Info.Clave}<T>

[Lista.EvaluacionCtoHist.Fecha]
Carpeta=Lista
Clave=EvaluacionCtoHist.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EvaluacionCtoHist.Calificacion]
Carpeta=Lista
Clave=EvaluacionCtoHist.Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
0=298
1=137

[Lista.ListaEnCaptura]
(Inicio)=EvaluacionCtoHist.Fecha
EvaluacionCtoHist.Fecha=EvaluacionCtoHist.Calificacion
EvaluacionCtoHist.Calificacion=(Fin)
