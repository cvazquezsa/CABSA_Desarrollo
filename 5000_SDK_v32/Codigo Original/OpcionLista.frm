[Forma]
Clave=OpcionLista
Nombre=Listas de la Opción
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=328
PosicionInicialArriba=167
PosicionInicialAltura=300
PosicionInicialAncho=327
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Opcion, Info.Descripcion)
VentanaExclusiva=S
PosicionInicialAlturaCliente=427

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OpcionLista
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=OpcionLista.Lista
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaMantenerSeleccion=S
FiltroGeneral=OpcionLista.Opcion=<T>{Info.Opcion}<T>

[Lista.OpcionLista.Lista]
Carpeta=Lista
Clave=OpcionLista.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
Lista=298

[Acciones.Detalles]
Nombre=Detalles
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalles
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OpcionListaD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(OpcionLista:OpcionLista.Lista)
Antes=S
AntesExpresiones=Asigna(Info.Lista, OpcionLista:OpcionLista.Lista)
DespuesGuardar=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalles
Detalles=(Fin)
