[Forma]
Clave=CtaLD
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
PosicionInicialIzquierda=261
PosicionInicialArriba=225
PosicionInicialAltura=311
PosicionInicialAncho=501
VentanaExclusiva=S
PosicionInicialAlturaCliente=284

[Lista]
Estilo=Hoja
Clave=Lista
ValidarCampos=
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaLD
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
FiltroGeneral=CtaLD.Rama = <T>CONT<T> AND<BR>CtaLD.Lista = <T>{Info.Lista}<T>
FiltroRespetar=S

[Lista.CtaLD.Cuenta]
Carpeta=Lista
Clave=CtaLD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

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
Cuenta=123
Grupo=84
Descripcion1=202
Descripcion=186
SubGrupo=76
Signo=32

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFuente=Gris

[Lista.CtaLD.Grupo]
Carpeta=Lista
Clave=CtaLD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.CtaLD.SubGrupo]
Carpeta=Lista
Clave=CtaLD.SubGrupo
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
Expresion=Asigna(CtaLD:CtaLD.Signo, <T>+<T>)
Activo=S
Visible=S

[Acciones.Negativo]
Nombre=Negativo
Boton=63
NombreDesplegar=Negativo
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=Asigna(CtaLD:CtaLD.Signo, <T>-<T>)
Activo=S
Visible=S

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
AntesExpresiones=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Descripcion, <T>Listas de Cuentas<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Grupos
Grupos=Positivo
Positivo=Negativo
Negativo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtaLD.Cuenta
CtaLD.Cuenta=Cta.Descripcion
Cta.Descripcion=CtaLD.Grupo
CtaLD.Grupo=CtaLD.SubGrupo
CtaLD.SubGrupo=(Fin)
