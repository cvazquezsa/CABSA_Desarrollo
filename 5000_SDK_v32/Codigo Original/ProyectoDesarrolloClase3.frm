[Forma]
Clave=ProyectoDesarrolloClase3
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
PosicionInicialIzquierda=757
PosicionInicialArriba=366
PosicionInicialAlturaCliente=434
PosicionInicialAncho=532
Comentarios=Info.Clase2

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

[Acciones.Clase4]
Nombre=Clase4
Boton=91
NombreEnBoton=S
NombreDesplegar=&Sub Clasificación
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProyectoDesarrolloClase4
Activo=S
Visible=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Clase3, ProyectoDesarrolloClase3:ProyectoDesarrolloClase3.Clase3)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDesarrolloClase3
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
ListaOrden=ProyectoDesarrolloClase3.Orden<TAB>(Acendente)
ValidarCampos=S
ListaCamposAValidar=Recurso.Nombre
FiltroGeneral=ProyectoDesarrolloClase3.Clase1 = <T>{Info.Clase1}<T> AND<BR>ProyectoDesarrolloClase3.Clase2 = <T>{Info.Clase2}<T>

[Lista.ProyectoDesarrolloClase3.Clase3]
Carpeta=Lista
Clave=ProyectoDesarrolloClase3.Clase3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Clase3=332
Orden=44
Supervisor=124

[Lista.ProyectoDesarrolloClase3.Orden]
Carpeta=Lista
Clave=ProyectoDesarrolloClase3.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDesarrolloClase3.Supervisor]
Carpeta=Lista
Clave=ProyectoDesarrolloClase3.Supervisor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Clase4
Clase4=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProyectoDesarrolloClase3.Clase3
ProyectoDesarrolloClase3.Clase3=ProyectoDesarrolloClase3.Supervisor
ProyectoDesarrolloClase3.Supervisor=ProyectoDesarrolloClase3.Orden
ProyectoDesarrolloClase3.Orden=(Fin)
