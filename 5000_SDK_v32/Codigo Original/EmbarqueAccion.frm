[Forma]
Clave=EmbarqueAccion
Nombre=<T>Acciones - Embarques<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=373
PosicionInicialArriba=220
PosicionInicialAltura=327
PosicionInicialAncho=278
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueAccion
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
OtroOrden=S
ListaOrden=(Lista)
PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General

[Lista.EmbarqueAccion.Accion]
Carpeta=Lista
Clave=EmbarqueAccion.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAccion.Orden]
Carpeta=Lista
Clave=EmbarqueAccion.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Accion=204
Orden=44

[Lista.ListaEnCaptura]
(Inicio)=EmbarqueAccion.Accion
EmbarqueAccion.Accion=EmbarqueAccion.Orden
EmbarqueAccion.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=EmbarqueAccion.Orden<TAB>(Acendente)
EmbarqueAccion.Orden<TAB>(Acendente)=EmbarqueAccion.Accion<TAB>(Acendente)
EmbarqueAccion.Accion<TAB>(Acendente)=(Fin)
