[Forma]
Clave=ProyectoDesarrolloClase5
Nombre=Sub Clasificación
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
ListaAcciones=Cerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=682
PosicionInicialArriba=323
PosicionInicialAlturaCliente=520
PosicionInicialAncho=556
Comentarios=Info.Clase4

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDesarrolloClase5
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=ProyectoDesarrolloClase5.Orden<TAB>(Acendente)
ValidarCampos=S
ListaCamposAValidar=Recurso.Nombre
FiltroGeneral=ProyectoDesarrolloClase5.Clase1 = <T>{Info.Clase1}<T> AND<BR>ProyectoDesarrolloClase5.Clase2 = <T>{Info.Clase2}<T> AND<BR>ProyectoDesarrolloClase5.Clase3 = <T>{Info.Clase3}<T> AND<BR>ProyectoDesarrolloClase5.Clase4 = <T>{Info.Clase4}<T>

[Lista.ProyectoDesarrolloClase5.Clase5]
Carpeta=Lista
Clave=ProyectoDesarrolloClase5.Clase5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Clase5=350
Orden=50
Supervisor=124

[Lista.ProyectoDesarrolloClase5.Orden]
Carpeta=Lista
Clave=ProyectoDesarrolloClase5.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDesarrolloClase5.Supervisor]
Carpeta=Lista
Clave=ProyectoDesarrolloClase5.Supervisor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ProyectoDesarrolloClase5.Clase5
ProyectoDesarrolloClase5.Clase5=ProyectoDesarrolloClase5.Supervisor
ProyectoDesarrolloClase5.Supervisor=ProyectoDesarrolloClase5.Orden
ProyectoDesarrolloClase5.Orden=(Fin)
