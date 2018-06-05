[Forma]
Clave=ProyectoDesarrolloClase2
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
PosicionInicialIzquierda=758
PosicionInicialArriba=353
PosicionInicialAlturaCliente=459
PosicionInicialAncho=528
Comentarios=Info.Clase1

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

[Acciones.Clase3]
Nombre=Clase3
Boton=91
NombreEnBoton=S
NombreDesplegar=&Sub Clasificación
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProyectoDesarrolloClase3
Activo=S
Visible=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Clase2, ProyectoDesarrolloClase2:ProyectoDesarrolloClase2.Clase2)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDesarrolloClase2
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
ListaOrden=ProyectoDesarrolloClase2.Orden<TAB>(Acendente)
ValidarCampos=S
ListaCamposAValidar=Recurso.Nombre
FiltroGeneral=ProyectoDesarrolloClase2.Clase1 = <T>{Info.Clase1}<T>

[Lista.ProyectoDesarrolloClase2.Clase2]
Carpeta=Lista
Clave=ProyectoDesarrolloClase2.Clase2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Clase2=333
Orden=40
Supervisor=124

[Lista.ProyectoDesarrolloClase2.Orden]
Carpeta=Lista
Clave=ProyectoDesarrolloClase2.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDesarrolloClase2.Supervisor]
Carpeta=Lista
Clave=ProyectoDesarrolloClase2.Supervisor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=ProyectoDesarrolloClase2.Clase2
ProyectoDesarrolloClase2.Clase2=ProyectoDesarrolloClase2.Supervisor
ProyectoDesarrolloClase2.Supervisor=ProyectoDesarrolloClase2.Orden
ProyectoDesarrolloClase2.Orden=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Clase3
Clase3=(Fin)
