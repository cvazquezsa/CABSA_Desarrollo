[Forma]
Clave=EvaluacionFormatoOrdenar
Nombre=Ordenar Evaluaci�n
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
PosicionInicialIzquierda=428
PosicionInicialArriba=235
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
Vista=EvaluacionFormato
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
ListaEnCaptura=EvaluacionFormato.Punto
ListaOrden=EvaluacionFormato.Orden<TAB>(Acendente)
IconosCambiarOrden=S
Filtros=S
IconosNombre=EvaluacionFormato:EvaluacionFormato.Orden
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=EvaluacionFormato.Evaluacion=<T>{Info.Evaluacion}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.Columnas]
0=47
1=315

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
AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>EvaluacionFormato.Punto<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla, @Cuenta=:tEval<T>, EstacionTrabajo, <T>EvaluacionFormato<T>, Info.Evaluacion)

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

[Lista.EvaluacionFormato.Punto]
Carpeta=Lista
Clave=EvaluacionFormato.Punto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)
