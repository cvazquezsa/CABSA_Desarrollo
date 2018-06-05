[Forma]
Clave=EvaluacionLista
Nombre=Evaluaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=710
PosicionInicialArriba=418
PosicionInicialAltura=354
PosicionInicialAncho=500
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=479
Comentarios=Info.Aplica

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Evaluacion
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Evaluación<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroAutoCampo=Evaluacion.Tipo
FiltroAncho=20
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
FiltroGrupo1=Evaluacion.Tipo
ListaEnCaptura=Evaluacion.Tipo
PestanaOtroNombre=S
PestanaNombre=Evaluaciones
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaAncho=20
IconosNombre=Evaluacion:Evaluacion.Evaluacion
FiltroGeneral=Evaluacion.Aplica=<T>{Info.Aplica}<T><BR>{Si(ConDatos(Info.Modulo), <T> AND NULLIF(Evaluacion.Modulo, <T>+Comillas(<T><T>) + <T>) IN (NULL, <T>+Comillas(Info.Modulo) + <T>)<T>, <T><T>)}<BR>{Si(ConDatos(Info.Mov),    <T> AND NULLIF(Evaluacion.Mov,    <T>+Comillas(<T><T>) + <T>) IN (NULL, <T>+Comillas(Info.Mov)    + <T>)<T>, <T><T>)}

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

[Lista.Columnas]
0=222
1=101

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

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)
