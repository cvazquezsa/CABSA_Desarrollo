[Forma]
Clave=ProyectoDesarrolloClase4
Nombre=Sub Clasificación
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=759
PosicionInicialArriba=334
PosicionInicialAlturaCliente=498
PosicionInicialAncho=527
Comentarios=Info.Clase3

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

[Acciones.Clase5]
Nombre=Clase5
Boton=91
NombreEnBoton=S
NombreDesplegar=&Sub Clasificación
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProyectoDesarrolloClase5
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Clase4, ProyectoDesarrolloClase4:ProyectoDesarrolloClase4.Clase4)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDesarrolloClase4
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
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=ProyectoDesarrolloClase4.Orden<TAB>(Acendente)
ValidarCampos=S
ListaCamposAValidar=Recurso.Nombre
FiltroGeneral=ProyectoDesarrolloClase4.Clase1 = <T>{Info.Clase1}<T> AND<BR>ProyectoDesarrolloClase4.Clase2 = <T>{Info.Clase2}<T> AND<BR>ProyectoDesarrolloClase4.Clase3 = <T>{Info.Clase3}<T>

[Lista.ProyectoDesarrolloClase4.Clase4]
Carpeta=Lista
Clave=ProyectoDesarrolloClase4.Clase4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Clase4=330
Orden=41
Supervisor=124

[Lista.ProyectoDesarrolloClase4.Orden]
Carpeta=Lista
Clave=ProyectoDesarrolloClase4.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDesarrolloClase4.Supervisor]
Carpeta=Lista
Clave=ProyectoDesarrolloClase4.Supervisor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=ProyectoDesarrolloClase4.Clase4
ProyectoDesarrolloClase4.Clase4=ProyectoDesarrolloClase4.Supervisor
ProyectoDesarrolloClase4.Supervisor=ProyectoDesarrolloClase4.Orden
ProyectoDesarrolloClase4.Orden=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Clase5
Clase5=(Fin)
