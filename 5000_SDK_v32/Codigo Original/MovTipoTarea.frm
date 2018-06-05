[Forma]
Clave=MovTipoTarea
Nombre=Tareas por Omisión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Mov
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=386
PosicionInicialArriba=302
PosicionInicialAlturaCliente=392
PosicionInicialAncho=632

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoTarea
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
OtroOrden=S
ListaOrden=MovTipoTarea.Orden<TAB>(Acendente)
FiltroGeneral=MovTipoTarea.Modulo=<T>{Info.Modulo}<T> AND MovTipoTarea.Mov=<T>{Info.Mov}<T>

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
Tarea=352
Dias=46
Forzosa=45
Orden=33
Tipo=124

[Lista.MovTipoTarea.Tarea]
Carpeta=Lista
Clave=MovTipoTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoTarea.Dias]
Carpeta=Lista
Clave=MovTipoTarea.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoTarea.Forzosa]
Carpeta=Lista
Clave=MovTipoTarea.Forzosa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoTarea.Orden]
Carpeta=Lista
Clave=MovTipoTarea.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoTarea.Tipo]
Carpeta=Lista
Clave=MovTipoTarea.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=MovTipoTarea.Tarea
MovTipoTarea.Tarea=MovTipoTarea.Tipo
MovTipoTarea.Tipo=MovTipoTarea.Dias
MovTipoTarea.Dias=MovTipoTarea.Forzosa
MovTipoTarea.Forzosa=MovTipoTarea.Orden
MovTipoTarea.Orden=(Fin)
