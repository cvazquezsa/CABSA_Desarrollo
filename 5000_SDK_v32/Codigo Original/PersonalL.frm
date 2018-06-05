[Forma]
Clave=PersonalL
Nombre=Listas del Personal
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=378
PosicionInicialArriba=233
PosicionInicialAltura=294
PosicionInicialAncho=269
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
PosicionInicialAlturaCliente=267

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalL
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
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroGeneral=PersonalL.Rama = <T>RH<T> AND <BR>PersonalL.Visible IN (<T>General<T>, {Comillas(Empresa)}, {Comillas(Usuario)})
FiltroRespetar=S
HojaConfirmarEliminar=S

[Lista.PersonalL.Lista]
Carpeta=Lista
Clave=PersonalL.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.Columnas]
Lista=170
Visible=69

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Editar]
Nombre=Editar
Boton=47
NombreEnBoton=S
NombreDesplegar=E&ditar Lista
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PersonalLD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(PersonalL:PersonalL.Lista)
EjecucionMensaje=
Antes=S
AntesExpresiones=Asigna(Info.Lista, PersonalL:PersonalL.Lista)<BR>Asigna(Info.Visible, PersonalL:PersonalL.Visible)
Visible=S
EspacioPrevio=S

[Lista.PersonalL.Visible]
Carpeta=Lista
Clave=PersonalL.Visible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Editar
Editar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PersonalL.Lista
PersonalL.Lista=PersonalL.Visible
PersonalL.Visible=(Fin)
