[Forma]
Clave=ArtLD
Nombre=<T>Lista de Artículos - <T>+Info.Lista
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=251
PosicionInicialArriba=228
PosicionInicialAltura=311
PosicionInicialAncho=521
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
ValidarCampos=
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtLD
Fuente={MS Sans Serif, 8, Negro, []}
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroGeneral=ArtLD.Rama = <T>INV<T> AND<BR>ArtLD.Lista=<T>{Info.Lista}<T>
FiltroRespetar=S

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
Articulo=123
Grupo=82
Descripcion1=203
Cuenta=124
SubGrupo=81

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFuente=Gris

[Lista.ArtLD.Cuenta]
Carpeta=Lista
Clave=ArtLD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Lista.ArtLD.Grupo]
Carpeta=Lista
Clave=ArtLD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.ArtLD.SubGrupo]
Carpeta=Lista
Clave=ArtLD.SubGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Acciones.Positivo]
Nombre=Positivo
Boton=62
NombreDesplegar=Positivo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(ArtLD:ArtLD.Signo, <T>+<T>)

[Acciones.Negativo]
Nombre=Negativo
Boton=63
NombreDesplegar=Negativo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(ArtLD:ArtLD.Signo, <T>-<T>)

[Acciones.Grupo]
Nombre=Grupo
Boton=91
NombreEnBoton=S
NombreDesplegar=G&rupos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ListaGrupo
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.Descripcion, <T>Listas de Artículos<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Grupo
Grupo=Positivo
Positivo=Negativo
Negativo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtLD.Cuenta
ArtLD.Cuenta=Art.Descripcion1
Art.Descripcion1=ArtLD.Grupo
ArtLD.Grupo=ArtLD.SubGrupo
ArtLD.SubGrupo=(Fin)
