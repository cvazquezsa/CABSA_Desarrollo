[Forma]
Clave=ListaGrupoOrdenar
Nombre=Ordenar Grupos
Icono=48
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=302
PosicionInicialArriba=181
PosicionInicialAltura=398
PosicionInicialAncho=420
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=(Lista)
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
VentanaExclusiva=S
PosicionInicialAlturaCliente=371

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaGrupo
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ListaGrupo.Grupo
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Orden<T>
ElementosPorPagina=200
IconosCambiarOrden=S
OtroOrden=S
ListaOrden=ListaGrupo.Orden<TAB>(Acendente)
PestanaOtroNombre=S
PestanaNombre=Registros
Filtros=S
IconosNombre=ListaGrupo:ListaGrupo.Orden
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=ListaGrupo.Rama = {Comillas(Info.Rama)}
FiltroRespetar=S
FiltroTipo=General

[Lista.Columnas]
Orden=42
Centro=114
Descripcion=236
0=51
1=304

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

[Acciones.Ordenar]
Nombre=Ordenar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Nuevo Orden
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Cerrar
Antes=S
AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>ListaGrupo.Grupo<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla, :tModulo<T>, EstacionTrabajo, <T>ListaGrupo<T>, Info.Rama)

[Lista.ListaGrupo.Grupo]
Carpeta=Lista
Clave=ListaGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)
