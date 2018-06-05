[Forma]
Clave=ProyPlanLista
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
EspacioPrevio=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(ProyPlan:ProyPlan.Plantilla)
AntesExpresiones=Asigna(Info.ProyPlan, ProyPlan:ProyPlan.Plantilla)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=Explorar
Explorar=(Fin)
