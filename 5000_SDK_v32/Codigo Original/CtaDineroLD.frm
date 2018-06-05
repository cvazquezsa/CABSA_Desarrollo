[Forma]
Clave=CtaDineroLD
Nombre=<T>Lista de Cuentas - <T>+Info.Lista
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
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaDineroLD
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
FiltroGeneral=CtaDineroLD.Rama = <T>DIN<T> AND<BR>CtaDineroLD.Lista = <T>{Info.Lista}<T>

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
CtaDinero=123
Grupo=79
Descripcion1=202
Nombre=202
Cuenta=124
SubGrupo=77
Descripcion=202

[Lista.CtaDineroLD.Cuenta]
Carpeta=Lista
Clave=CtaDineroLD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroLD.Grupo]
Carpeta=Lista
Clave=CtaDineroLD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroLD.SubGrupo]
Carpeta=Lista
Clave=CtaDineroLD.SubGrupo
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
Expresion=Asigna(CtaDineroLD:CtaDineroLD.Signo, <T>+<T>)

[Acciones.Negativo]
Nombre=Negativo
Boton=63
NombreDesplegar=Negativo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(CtaDineroLD:CtaDineroLD.Signo, <T>-<T>)

[Lista.CtaDinero.Descripcion]
Carpeta=Lista
Clave=CtaDinero.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>DIN<T>)<BR>Asigna(Info.Descripcion, <T>Listas de Cuentas Dinero<T>)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Grupos
Grupos=Positivo
Positivo=Negativo
Negativo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtaDineroLD.Cuenta
CtaDineroLD.Cuenta=CtaDinero.Descripcion
CtaDinero.Descripcion=CtaDineroLD.Grupo
CtaDineroLD.Grupo=CtaDineroLD.SubGrupo
CtaDineroLD.SubGrupo=(Fin)
