[Forma]
Clave=ProyPlan
Nombre=Plantillas Proyectos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=473
PosicionInicialArriba=314
PosicionInicialAlturaCliente=368
PosicionInicialAncho=333
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyPlan
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ProyPlan.Plantilla
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.ProyPlan.Plantilla]
Carpeta=Lista
Clave=ProyPlan.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Plantilla=304

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

[Acciones.Tareas]
Nombre=Tareas
Boton=47
NombreEnBoton=S
NombreDesplegar=&Tareas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProyPlanTarea
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.ProyPlan, ProyPlan:ProyPlan.Plantilla)<BR>Asigna(Info.Asunto, ProyPlan:ProyPlan.Plantilla)<BR>Asigna(Info.Clave, <T>(Inicio)<T>)<BR>EjecutarSQL(<T>spListaStEliminar :nEstacion<T>, EstacionTrabajo)

[Acciones.Explorar]
Nombre=Explorar
Boton=66
NombreDesplegar=E&xplorar
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ExplorarProyPlan
Activo=S
Visible=S
NombreEnBoton=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(ProyPlan:ProyPlan.Plantilla)
AntesExpresiones=Asigna(Info.ProyPlan, ProyPlan:ProyPlan.Plantilla)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Tareas
Tareas=Explorar
Explorar=(Fin)
