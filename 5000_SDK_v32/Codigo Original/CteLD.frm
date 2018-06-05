[Forma]
Clave=CteLD
Nombre=<T>Lista de Clientes - <T>+Info.Lista
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
PosicionInicialIzquierda=255
PosicionInicialArriba=228
PosicionInicialAltura=311
PosicionInicialAncho=513
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
Vista=CteLD
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
FiltroGeneral=CteLD.Rama = <T>CXC<T> AND<BR>CteLD.Lista = <T>{Info.Lista}<T>
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
Cliente=123
Grupo=79
Descripcion1=202
Nombre=202
Cuenta=124
SubGrupo=77

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFuente=Gris

[Lista.CteLD.Cuenta]
Carpeta=Lista
Clave=CteLD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Lista.CteLD.Grupo]
Carpeta=Lista
Clave=CteLD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.CteLD.SubGrupo]
Carpeta=Lista
Clave=CteLD.SubGrupo
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
Expresion=Asigna(CteLD:CteLD.Signo, <T>+<T>)

[Acciones.Negativo]
Nombre=Negativo
Boton=63
NombreDesplegar=Negativo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(CteLD:CteLD.Signo, <T>-<T>)

[Acciones.Grupos]
Nombre=Grupos
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
AntesExpresiones=Asigna(Info.Rama, <T>CXC<T>)<BR>Asigna(Info.Descripcion, <T>Listas de Clientes<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Grupos
Grupos=Positivo
Positivo=Negativo
Negativo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CteLD.Cuenta
CteLD.Cuenta=Cte.Nombre
Cte.Nombre=CteLD.Grupo
CteLD.Grupo=CteLD.SubGrupo
CteLD.SubGrupo=(Fin)
