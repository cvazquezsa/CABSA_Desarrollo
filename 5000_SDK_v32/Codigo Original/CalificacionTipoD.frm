[Forma]
Clave=CalificacionTipoD
Nombre=Calificaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=705
PosicionInicialArriba=330
PosicionInicialAlturaCliente=467
PosicionInicialAncho=446
Comentarios=Info.Tipo

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CalificacionTipoD
Fuente={Tahoma, 8, Negro, []}
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=CalificacionTipoD.Orden<TAB>(Acendente)
FiltroGeneral=CalificacionTipoD.Tipo=<T>{Info.Tipo}<T>

[Lista.CalificacionTipoD.Calificacion]
Carpeta=Lista
Clave=CalificacionTipoD.Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CalificacionTipoD.Valor]
Carpeta=Lista
Clave=CalificacionTipoD.Valor
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
Calificacion=304
Valor=64
Orden=38

[Lista.CalificacionTipoD.Orden]
Carpeta=Lista
Clave=CalificacionTipoD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CalificacionTipoD.Calificacion
CalificacionTipoD.Calificacion=CalificacionTipoD.Valor
CalificacionTipoD.Valor=CalificacionTipoD.Orden
CalificacionTipoD.Orden=(Fin)
