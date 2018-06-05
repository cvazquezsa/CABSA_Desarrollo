
[Forma]
Clave=CompetenciaListaTipo
Icono=4
Modulos=(Todos)
Nombre=Competencias

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=318
PosicionInicialArriba=125
PosicionInicialAlturaCliente=481
PosicionInicialAncho=730
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Info.Tipo
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Competencias
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Competencia
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S
IconosSubTitulo=<T>Clave<T>
ListaEnCaptura=Competencia.Nombre

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
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
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CompetenciaCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CompetenciaGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CompetenciaFam
FiltroAplicaEn1=Competencia.Categoria
FiltroAplicaEn2=Competencia.Grupo
FiltroAplicaEn3=Competencia.Familia
FiltroTodo=S
FiltroTodoFinal=S

IconosNombre=Competencia:Competencia.Competencia
FiltroGeneral=Competencia.Tipo=<T>{Info.Tipo}<T>
[Lista.Competencia.Nombre]
Carpeta=Lista
Clave=Competencia.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.Columnas]
0=113
1=284
2=125

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=<T>&Seleccionar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
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












[Lista.ListaEnCaptura]
(Inicio)=Competencia.Nombre
Competencia.Nombre=Competencia.Tipo
Competencia.Tipo=(Fin)



[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
