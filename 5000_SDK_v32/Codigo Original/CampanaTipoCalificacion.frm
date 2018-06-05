[Forma]
Clave=CampanaTipoCalificacion
Nombre=Calificaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=781
PosicionInicialArriba=389
PosicionInicialAlturaCliente=385
PosicionInicialAncho=357
Comentarios=Info.Tipo
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaTipoCalificacion
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
PermiteEditar=S
OtroOrden=S
ListaOrden=CampanaTipoCalificacion.Calificacion<TAB>(Acendente)
FiltroGeneral=CampanaTipoCalificacion.CampanaTipo=<T>{Info.Tipo}<T>

[Lista.CampanaTipoCalificacion.Situacion]
Carpeta=Lista
Clave=CampanaTipoCalificacion.Situacion
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
CalificacionD=64
CalificacionA=64
Situacion=243
CampanaTipo=119
Calificacion=76

[Lista.CampanaTipoCalificacion.Calificacion]
Carpeta=Lista
Clave=CampanaTipoCalificacion.Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CampanaTipoCalificacion.Calificacion
CampanaTipoCalificacion.Calificacion=CampanaTipoCalificacion.Situacion
CampanaTipoCalificacion.Situacion=(Fin)
