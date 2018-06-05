[Forma]
Clave=CtaDineroL
Nombre=Listas de Cuentas  
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
Vista=CtaDineroL
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
FiltroRespetar=S
HojaConfirmarEliminar=S
FiltroGeneral=CtaDineroL.Rama = <T>DIN<T> AND <BR>CtaDineroL.Visible IN (<T>General<T>, {Comillas(Empresa)}, {Comillas(Usuario)})

[Lista.CtaDineroL.Lista]
Carpeta=Lista
Clave=CtaDineroL.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
ClaveAccion=CtaDineroLD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CtaDineroL:CtaDineroL.Lista)
EjecucionMensaje=
Antes=S
AntesExpresiones=Asigna(Info.Lista, CtaDineroL:CtaDineroL.Lista)<BR>Asigna(Info.Visible, CtaDineroL:CtaDineroL.Visible)
Visible=S
EspacioPrevio=S

[Lista.CtaDineroL.Visible]
Carpeta=Lista
Clave=CtaDineroL.Visible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Editar
Editar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtaDineroL.Lista
CtaDineroL.Lista=CtaDineroL.Visible
CtaDineroL.Visible=(Fin)
