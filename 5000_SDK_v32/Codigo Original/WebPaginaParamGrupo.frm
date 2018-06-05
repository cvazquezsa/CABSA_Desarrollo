[Forma]
Clave=WebPaginaParamGrupo
Nombre=Grupos de Parámetros
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Pagina
PosicionInicialIzquierda=770
PosicionInicialArriba=354
PosicionInicialAlturaCliente=456
PosicionInicialAncho=379
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaParamGrupo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=WebPaginaParamGrupo.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=WebPaginaParamGrupo.Pagina=<T>{Info.Pagina}<T>

[Lista.WebPaginaParamGrupo.Grupo]
Carpeta=Lista
Clave=WebPaginaParamGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaParamGrupo.Orden]
Carpeta=Lista
Clave=WebPaginaParamGrupo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Grupo=304
Orden=37

[Lista.ListaEnCaptura]
(Inicio)=WebPaginaParamGrupo.Grupo
WebPaginaParamGrupo.Grupo=WebPaginaParamGrupo.Orden
WebPaginaParamGrupo.Orden=(Fin)
