[Forma]
Clave=PersonalLD
Nombre=<T>Lista del Personal - <T>+Info.Lista
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=255
PosicionInicialArriba=228
PosicionInicialAltura=311
PosicionInicialAncho=513
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalLD
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
FiltroRespetar=S
FiltroGeneral=PersonalLD.Rama = <T>RH<T> AND<BR>PersonalLD.Lista = <T>{Info.Lista}<T>

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
Personal=123
Grupo=79
Descripcion1=202
Nombre=202
Cuenta=116
SubGrupo=77
NombreCompleto=210

[Lista.PersonalLD.Cuenta]
Carpeta=Lista
Clave=PersonalLD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalLD.Grupo]
Carpeta=Lista
Clave=PersonalLD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalLD.SubGrupo]
Carpeta=Lista
Clave=PersonalLD.SubGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Positivo]
Nombre=Positivo
Boton=62
NombreDesplegar=Positivo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(PersonalLD:PersonalLD.Signo, <T>+<T>)

[Acciones.Negativo]
Nombre=Negativo
Boton=63
NombreDesplegar=Negativo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(PersonalLD:PersonalLD.Signo, <T>-<T>)

[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Grupo]
Nombre=Grupo
Boton=91
NombreEnBoton=S
NombreDesplegar=G&rupos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaGrupo
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>RH<T>)<BR>Asigna(Info.Descripcion, <T>Listas del Personal<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Grupo
Grupo=Positivo
Positivo=Negativo
Negativo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PersonalLD.Cuenta
PersonalLD.Cuenta=NombreCompleto
NombreCompleto=PersonalLD.Grupo
PersonalLD.Grupo=PersonalLD.SubGrupo
PersonalLD.SubGrupo=(Fin)
