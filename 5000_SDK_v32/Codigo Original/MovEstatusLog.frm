[Forma]
Clave=MovEstatusLog
Nombre=<T>Usuarios - <T>+Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=151
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=721
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovEstatusLog
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
ListaOrden=MovEstatusLog.ID<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroGeneral=MovEstatusLog.Modulo=<T>{Info.Modulo}<T> AND MovEstatusLog.ModuloID={Info.ID}
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.MovEstatusLog.Fecha]
Carpeta=Lista
Clave=MovEstatusLog.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EstatusNombre]
Carpeta=Lista
Clave=EstatusNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovEstatusLog.Usuario]
Carpeta=Lista
Clave=MovEstatusLog.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Usuario.Nombre]
Carpeta=Lista
Clave=Usuario.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Usuario.GrupoTrabajo]
Carpeta=Lista
Clave=Usuario.GrupoTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Fecha=121
EstatusNombre=110
Usuario=86
Nombre=220
GrupoTrabajo=152

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=MovEstatusLog.Fecha
MovEstatusLog.Fecha=EstatusNombre
EstatusNombre=MovEstatusLog.Usuario
MovEstatusLog.Usuario=Usuario.Nombre
Usuario.Nombre=Usuario.GrupoTrabajo
Usuario.GrupoTrabajo=(Fin)
