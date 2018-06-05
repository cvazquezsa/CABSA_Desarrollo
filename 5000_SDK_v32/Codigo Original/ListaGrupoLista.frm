[Forma]
Clave=ListaGrupoLista
Nombre=Grupos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=372
PosicionInicialArriba=181
PosicionInicialAlturaCliente=371
PosicionInicialAncho=279
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaGrupo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Grupo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Negro
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Grupos
IconosNombre=ListaGrupo:ListaGrupo.Grupo
FiltroGeneral=ListaGrupo.Rama={Comillas(Info.Rama)}

[Lista.Columnas]
0=233

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

[Lista.ListaOrden]
(Inicio)=ListaGrupo.Orden<TAB>(Acendente)
ListaGrupo.Orden<TAB>(Acendente)=ListaGrupo.Grupo<TAB>(Acendente)
ListaGrupo.Grupo<TAB>(Acendente)=(Fin)
