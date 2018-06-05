[Forma]
Clave=ListaSubSubGrupo
Nombre=Sub Grupos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=810
PosicionInicialArriba=446
PosicionInicialAlturaCliente=273
PosicionInicialAncho=299
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Grupo, Info.SubGrupo)

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
Vista=ListaSubSubGrupo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ListaSubSubGrupo.SubSubGrupo
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ListaSubSubGrupo.Rama=<T>{Info.Rama}<T> AND ListaSubSubGrupo.Grupo=<T>{Info.Grupo}<T> AND ListaSubSubGrupo.SubGrupo=<T>{Info.SubGrupo}<T>

[Lista.ListaSubSubGrupo.SubSubGrupo]
Carpeta=Lista
Clave=ListaSubSubGrupo.SubSubGrupo
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
SubSubGrupo=270

[Acciones.SubGrupo]
Nombre=SubGrupo
Boton=47
NombreEnBoton=S
NombreDesplegar=&Sub Grupo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ListaSubSubSubGrupo
Activo=S
Antes=S
Visible=S
GuardarAntes=S
ConCondicion=S
EjecucionCondicion=ConDatos(ListaSubSubGrupo:ListaSubSubGrupo.SubSubGrupo)
AntesExpresiones=Asigna(Info.SubSubGrupo, ListaSubSubGrupo:ListaSubSubGrupo.SubSubGrupo)
DespuesGuardar=S





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=SubGrupo
SubGrupo=(Fin)
