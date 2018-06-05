
[Forma]
Clave=CampanaTipoSituacion
Nombre=Situaciones del Tipo Campaña
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=575
PosicionInicialArriba=289
PosicionInicialAlturaCliente=422
PosicionInicialAncho=769
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Tipo
PosicionCol1=663

PosicionSec1=178
PosicionSec2=178
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaTipoSituacion
Fuente={Tahoma, 8, Negro, []}
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
HojaTitulos=S
HojaMostrarColumnas=S
ListaOrden=CampanaTipoSituacion.Orden<TAB>(Acendente)
HojaMantenerSeleccion=S

HojaColorFondo=Plata
FiltroGeneral=CampanaTipoSituacion.CampanaTipo=<T>{Info.Tipo}<T>
[Lista.CampanaTipoSituacion.Situacion]
Carpeta=Lista
Clave=CampanaTipoSituacion.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Columnas]
Situacion=333
Orden=35
Flujo=136

AccionMovil=124
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

[Lista.CampanaTipoSituacion.Orden]
Carpeta=Lista
Clave=CampanaTipoSituacion.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Tareas]
Nombre=Tareas
Boton=70
NombreEnBoton=S
NombreDesplegar=&Tareas por Omisión
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CampanaTipoSituacionTarea
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(CampanaTipoSituacion:CampanaTipoSituacion.Situacion)
AntesExpresiones=Asigna(Info.Situacion, CampanaTipoSituacion:CampanaTipoSituacion.Situacion)
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CampanaTipoSituacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CampanaTipoSituacion.Icono
CarpetaVisible=S

[Ficha.CampanaTipoSituacion.Icono]
Carpeta=Ficha
Clave=CampanaTipoSituacion.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaTipoSituacion.Flujo]
Carpeta=Lista
Clave=CampanaTipoSituacion.Flujo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.CampanaTipoSituacion.AccionMovil]
Carpeta=Lista
Clave=CampanaTipoSituacion.AccionMovil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[SubSituacion]
Estilo=Hoja
Clave=SubSituacion
PermiteEditar=S
GuardarPorRegistro=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Vista=CampanaTipoSubSituacion
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


Detalle=S
VistaMaestra=CampanaTipoSituacion
LlaveLocal=(Lista)
LlaveMaestra=(Lista)
HojaColorFondo=Plata
CondicionVisible=(CampanaTipoSituacion:CampanaTipoSituacion.AccionMovil en (<T>Cancelado<T>,<T>Re Agendado<T>))
[SubSituacion.CampanaTipoSubSituacion.SubSituacion]
Carpeta=SubSituacion
Clave=CampanaTipoSubSituacion.SubSituacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[SubSituacion.CampanaTipoSubSituacion.Orden]
Carpeta=SubSituacion
Clave=CampanaTipoSubSituacion.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[SubSituacion.Columnas]
SubSituacion=331
Orden=64




CampanaTipo=304
Situacion=304





























[Lista.ListaEnCaptura]
(Inicio)=CampanaTipoSituacion.Situacion
CampanaTipoSituacion.Situacion=CampanaTipoSituacion.Flujo
CampanaTipoSituacion.Flujo=CampanaTipoSituacion.AccionMovil
CampanaTipoSituacion.AccionMovil=CampanaTipoSituacion.Orden
CampanaTipoSituacion.Orden=(Fin)

[SubSituacion.LlaveLocal]
(Inicio)=CampanaTipoSubSituacion.CampanaTipo
CampanaTipoSubSituacion.CampanaTipo=CampanaTipoSubSituacion.Situacion
CampanaTipoSubSituacion.Situacion=(Fin)

[SubSituacion.LlaveMaestra]
(Inicio)=CampanaTipoSituacion.CampanaTipo
CampanaTipoSituacion.CampanaTipo=CampanaTipoSituacion.Situacion
CampanaTipoSituacion.Situacion=(Fin)

[SubSituacion.ListaEnCaptura]
(Inicio)=CampanaTipoSubSituacion.SubSituacion
CampanaTipoSubSituacion.SubSituacion=CampanaTipoSubSituacion.Orden
CampanaTipoSubSituacion.Orden=(Fin)

















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=SubSituacion
SubSituacion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Tareas
Tareas=(Fin)
