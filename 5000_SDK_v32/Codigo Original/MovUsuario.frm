[Forma]
Clave=MovUsuario
Nombre=Cola de Usuarios
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=376
PosicionInicialArriba=360
PosicionInicialAltura=303
PosicionInicialAncho=527
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=276

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovUsuario
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=(Lista)
PestanaOtroNombre=S
PestanaNombre=Usuario(s)
OtroOrden=S
ListaOrden=MovUsuario.Orden<TAB>(Decendente)
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=Modulo=<T>{Info.Modulo}<T> AND ID={Info.ID} AND Eliminado=0

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

[Lista.Columnas]
0=100
1=226
Usuario=91
Nombre=259
GrupoTrabajo=147

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

[Lista.MovUsuario.Usuario]
Carpeta=Lista
Clave=MovUsuario.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=MovUsuario.Usuario
MovUsuario.Usuario=Usuario.Nombre
Usuario.Nombre=Usuario.GrupoTrabajo
Usuario.GrupoTrabajo=(Fin)
