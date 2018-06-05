[Forma]
Clave=ListaSubGrupo
Nombre=Sub Grupos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=362
PosicionInicialArriba=230
PosicionInicialAlturaCliente=273
PosicionInicialAncho=299
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Grupo

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaSubGrupo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ListaSubGrupo.SubGrupo
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ListaSubGrupo.Rama=<T>{Info.Rama}<T> AND ListaSubGrupo.Grupo=<T>{Info.Grupo}<T>

[Lista.ListaSubGrupo.SubGrupo]
Carpeta=Lista
Clave=ListaSubGrupo.SubGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
SubGrupo=270

[Acciones.SubGrupo]
Nombre=SubGrupo
Boton=47
NombreEnBoton=S
NombreDesplegar=&Sub Grupo
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaSubSubGrupo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ListaSubGrupo:ListaSubGrupo.SubGrupo)
Antes=S
AntesExpresiones=Asigna(Info.SubGrupo, ListaSubGrupo:ListaSubGrupo.SubGrupo)
DespuesGuardar=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=SubGrupo
SubGrupo=(Fin)
