[Forma]
Clave=ArtL
Nombre=Listas de Artículos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=378
PosicionInicialArriba=237
PosicionInicialAltura=294
PosicionInicialAncho=268
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtL
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
FiltroGeneral=ArtL.Rama = <T>INV<T> AND<BR>ArtL.Visible IN (<T>General<T>, {Comillas(Empresa)}, {Comillas(Usuario)})
FiltroRespetar=S
HojaConfirmarEliminar=S

[Lista.ArtL.Lista]
Carpeta=Lista
Clave=ArtL.Lista
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
ClaveAccion=ArtLD
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(ArtL:ArtL.Lista)
AntesExpresiones=Asigna(Info.Lista, ArtL:ArtL.Lista)<BR>Asigna(Info.Visible, ArtL:ArtL.Visible)

[Lista.ArtL.Visible]
Carpeta=Lista
Clave=ArtL.Visible
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
(Inicio)=ArtL.Lista
ArtL.Lista=ArtL.Visible
ArtL.Visible=(Fin)
