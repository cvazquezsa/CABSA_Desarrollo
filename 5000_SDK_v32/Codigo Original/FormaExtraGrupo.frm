[Forma]
Clave=FormaExtraGrupo
Nombre=Grupos de la Forma
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=429
PosicionInicialArriba=296
PosicionInicialAlturaCliente=405
PosicionInicialAncho=422
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.FormaTipo

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
Vista=FormaExtraGrupo
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
ListaOrden=FormaExtraGrupo.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=FormaExtraGrupo.FormaTipo=<T>{Info.FormaTipo}<T>

[Lista.FormaExtraGrupo.Grupo]
Carpeta=Lista
Clave=FormaExtraGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FormaExtraGrupo.Orden]
Carpeta=Lista
Clave=FormaExtraGrupo.Orden
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
Grupo=355
Orden=36

[Lista.ListaEnCaptura]
(Inicio)=FormaExtraGrupo.Grupo
FormaExtraGrupo.Grupo=FormaExtraGrupo.Orden
FormaExtraGrupo.Orden=(Fin)
