[Forma]
Clave=PlantillaProyectoD
Nombre=Actividades de la Plantilla
Icono=62
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=126
PosicionInicialArriba=87
PosicionInicialAlturaCliente=530
PosicionInicialAncho=1116
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
Comentarios=Lista(Info.Plantilla)
PosicionCol1=725
VentanaExclusiva=S
PosicionSec1=446

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Info.Actividad, Nulo)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlantillaProyectoD
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
OtroOrden=S
ListaOrden=PlantillaProyectoD.Orden<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ValidarCampos=S
ListaCamposAValidar=Recurso.Nombre
FiltroGeneral=PlantillaProyectoD.Plantilla=<T>{Info.Plantilla}<T>

[Lista.PlantillaProyectoD.Asunto]
Carpeta=Lista
Clave=PlantillaProyectoD.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Actividad=61
Fase=45
Asunto=333
Tipo=60
ActivarCuandoActividad=109
ActivarEstado=84
Orden=44
Opcional=47
Predecesora=67
Dias=50
Duracion=46
DuracionUnidad=38
EsOpcional=49
Referencia=63
Predecesoras=93
Categoria=88
Grupo=86
Familia=78
EsFase=29
SubPlantilla=80
Clave=81
RecursoOmision=102

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
ConCondicion=S
EjecucionConError=S
Antes=S

DespuesGuardar=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(PlantillaProyectoD:PlantillaProyectoD.Actividad)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicada<T>
AntesExpresiones=Asigna(Temp.Texto, SQL(<T>spPlantillaProyectoDVerificar :tPlantilla<T>, Info.Plantilla))<BR>ActualizarVista<BR>Si(ConDatos(Temp.Texto), Error(Temp.Texto) AbortarOperacion)
[Lista.PlantillaProyectoD.Actividad]
Carpeta=Lista
Clave=PlantillaProyectoD.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Lista.PlantillaProyectoD.Duracion]
Carpeta=Lista
Clave=PlantillaProyectoD.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlantillaProyectoD.DuracionUnidad]
Carpeta=Lista
Clave=PlantillaProyectoD.DuracionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S


[Lista.PlantillaProyectoD.Predecesora]
Carpeta=Lista
Clave=PlantillaProyectoD.Predecesora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
GuardarAntes=S
EspacioPrevio=S

ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(PlantillaProyectoD:PlantillaProyectoD.Actividad)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicada<T>
Antes=S
AntesExpresiones=Asigna(Temp.Texto, SQL(<T>spPlantillaProyectoDVerificar :tPlantilla<T>, Info.Plantilla))<BR>ActualizarVista<BR>Si(ConDatos(Temp.Texto), Error(Temp.Texto) AbortarOperacion)
DespuesGuardar=S
[Ficha.PlantillaProyectoD.SubPlantilla]
Carpeta=Ficha
Clave=PlantillaProyectoD.SubPlantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Lista.PlantillaProyectoD.EsFase]
Carpeta=Lista
Clave=PlantillaProyectoD.EsFase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Comentarios]
Nombre=Comentarios
Boton=47
NombreEnBoton=S
NombreDesplegar=&Comentarios
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PlantillaProyectoDComentarios
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S

EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(PlantillaProyectoD:PlantillaProyectoD.Actividad)))<BR>(ConDatos(PlantillaProyectoD:PlantillaProyectoD.Actividad)) y (Vacio(Temp.Texto))
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicada<T>
AntesExpresiones=Asigna(Info.Actividad, PlantillaProyectoD:PlantillaProyectoD.Actividad)<BR>Asigna(Temp.Texto, SQL(<T>spPlantillaProyectoDVerificar :tPlantilla<T>, Info.Plantilla))<BR>ActualizarVista<BR>Si(ConDatos(Temp.Texto), Error(Temp.Texto) AbortarOperacion)
DespuesGuardar=S
[Lista.PlantillaProyectoD.Clave]
Carpeta=Lista
Clave=PlantillaProyectoD.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlantillaProyectoD.Tipo]
Carpeta=Lista
Clave=PlantillaProyectoD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlantillaProyectoD.Categoria]
Carpeta=Lista
Clave=PlantillaProyectoD.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlantillaProyectoD.Grupo]
Carpeta=Lista
Clave=PlantillaProyectoD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlantillaProyectoD.Familia]
Carpeta=Lista
Clave=PlantillaProyectoD.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlantillaProyectoD.RecursoOmision]
Carpeta=Lista
Clave=PlantillaProyectoD.RecursoOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlantillaProyectoD.SubPlantilla]
Carpeta=Lista
Clave=PlantillaProyectoD.SubPlantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Recursos]
Nombre=Recursos
Boton=80
NombreEnBoton=S
NombreDesplegar=&Recursos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PlantillaProyectoDRecurso
Activo=S
Visible=S
Antes=S
ConCondicion=S


EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(PlantillaProyectoD:PlantillaProyectoD.Actividad)))<BR>(ConDatos(PlantillaProyectoD:PlantillaProyectoD.Actividad)) y (Vacio(Temp.Texto))
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicada<T>
AntesExpresiones=Asigna(Info.Actividad, PlantillaProyectoD:PlantillaProyectoD.Actividad)<BR>Asigna(Temp.Texto, SQL(<T>spPlantillaProyectoDVerificar :tPlantilla<T>, Info.Plantilla))<BR>ActualizarVista<BR>Si(ConDatos(Temp.Texto), Error(Temp.Texto) AbortarOperacion)
DespuesGuardar=S
[Lista.ListaEnCaptura]
(Inicio)=PlantillaProyectoD.Actividad
PlantillaProyectoD.Actividad=PlantillaProyectoD.Clave
PlantillaProyectoD.Clave=PlantillaProyectoD.Asunto
PlantillaProyectoD.Asunto=PlantillaProyectoD.EsFase
PlantillaProyectoD.EsFase=PlantillaProyectoD.Duracion
PlantillaProyectoD.Duracion=PlantillaProyectoD.DuracionUnidad
PlantillaProyectoD.DuracionUnidad=PlantillaProyectoD.Predecesora
PlantillaProyectoD.Predecesora=PlantillaProyectoD.Tipo
PlantillaProyectoD.Tipo=PlantillaProyectoD.Categoria
PlantillaProyectoD.Categoria=PlantillaProyectoD.Grupo
PlantillaProyectoD.Grupo=PlantillaProyectoD.Familia
PlantillaProyectoD.Familia=PlantillaProyectoD.RecursoOmision
PlantillaProyectoD.RecursoOmision=PlantillaProyectoD.SubPlantilla
PlantillaProyectoD.SubPlantilla=(Fin)















































































































































































































































































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Comentarios
Comentarios=Recursos
Recursos=Excel
Excel=Actualizar
Actualizar=Navegador
Navegador=(Fin)
