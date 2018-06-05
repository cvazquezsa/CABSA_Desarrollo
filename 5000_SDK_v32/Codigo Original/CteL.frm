[Forma]
Clave=CteL
Nombre=Listas de Clientes
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
PosicionInicialAlturaCliente=267

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteL
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
FiltroGeneral=CteL.Rama = <T>CXC<T> AND <BR>CteL.Visible IN (<T>General<T>, {Comillas(Empresa)}, {Comillas(Usuario)})
FiltroRespetar=S
HojaConfirmarEliminar=S

[Lista.CteL.Lista]
Carpeta=Lista
Clave=CteL.Lista
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
ClaveAccion=CteLD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CteL:CteL.Lista)
EjecucionMensaje=
Antes=S
AntesExpresiones=Asigna(Info.Lista, CteL:CteL.Lista)<BR>Asigna(Info.Visible, CteL:CteL.Visible)
Visible=S
EspacioPrevio=S

[Lista.CteL.Visible]
Carpeta=Lista
Clave=CteL.Visible
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
(Inicio)=CteL.Lista
CteL.Lista=CteL.Visible
CteL.Visible=(Fin)
