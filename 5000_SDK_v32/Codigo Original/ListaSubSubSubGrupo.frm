[Forma]
Clave=ListaSubSubSubGrupo
Nombre=Sub Grupos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=818
PosicionInicialArriba=446
PosicionInicialAlturaCliente=273
PosicionInicialAncho=283
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Grupo, Info.SubGrupo, Info.SubSubGrupo)

VentanaEstadoInicial=Normal
ForzarSDI=S
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaSubSubSubGrupo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ListaSubSubSubGrupo.SubSubSubGrupo
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ListaSubSubSubGrupo.Rama=<T>{Info.Rama}<T> AND ListaSubSubSubGrupo.Grupo=<T>{Info.Grupo}<T> AND ListaSubSubSubGrupo.SubGrupo=<T>{Info.SubGrupo}<T> AND ListaSubSubSubGrupo.SubSubGrupo=<T>{Info.SubSubGrupo}<T>

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
SubSubGrupo=270
SubSubSubGrupo=254

[Lista.ListaSubSubSubGrupo.SubSubSubGrupo]
Carpeta=Lista
Clave=ListaSubSubSubGrupo.SubSubSubGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
