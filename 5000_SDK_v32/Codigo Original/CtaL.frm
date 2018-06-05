[Forma]
Clave=CtaL
Nombre=Listas de Cuentas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=378
PosicionInicialArriba=233
PosicionInicialAltura=294
PosicionInicialAncho=268
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
Vista=CtaL
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
FiltroGeneral=CtaL.Rama = <T>CONT<T> AND<BR>CtaL.Visible IN (<T>General<T>, {Comillas(Empresa)}, {Comillas(Usuario)})
FiltroRespetar=S
HojaConfirmarEliminar=S

[Lista.CtaL.Lista]
Carpeta=Lista
Clave=CtaL.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.Columnas]
Lista=170
Visible=68

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
ClaveAccion=CtaLD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CtaL:CtaL.Lista)
EjecucionMensaje=
Antes=S
AntesExpresiones=Asigna(Info.Lista, CtaL:CtaL.Lista)<BR>Asigna(Info.Visible, CtaL:CtaL.Visible)
Visible=S
EspacioPrevio=S

[Lista.CtaL.Visible]
Carpeta=Lista
Clave=CtaL.Visible
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
(Inicio)=CtaL.Lista
CtaL.Lista=CtaL.Visible
CtaL.Visible=(Fin)
