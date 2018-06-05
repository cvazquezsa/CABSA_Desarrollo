[Forma]
Clave=ProyectoRecurso
Nombre=Recursos Asignados al Movimiento
Icono=29
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=268
PosicionInicialArriba=274
PosicionInicialAlturaCliente=285
PosicionInicialAncho=934
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Proyecto
PosicionCol1=297

VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
PosicionSec1=234
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoRecurso
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

FiltroGeneral=ProyectoRecurso.ID={Info.ID}
[Lista.ProyectoRecurso.Recurso]
Carpeta=Lista
Clave=ProyectoRecurso.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
Recurso=68
Nombre=197
Puesto=132
Grupo=181
HorasDia=54
PrecioHora=73
CostoHora=75
Rol=134
Comienzo=94
Fin=94
Estatus=94

0=-2
1=232
2=-2
3=84
4=-2
[Acciones.Info]
Nombre=Info
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
Visible=S
ClaveAccion=RecursoInfo
ConCondicion=S
Antes=S


NombreEnBoton=S
EjecucionCondicion=ConDatos(ProyectoRecurso:ProyectoRecurso.Recurso)
AntesExpresiones=Asigna(Info.Recurso, ProyectoRecurso:ProyectoRecurso.Recurso)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ProyectoRecurso
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Detalles
[Ficha.ProyectoRecurso.Recurso]
Carpeta=Ficha
Clave=ProyectoRecurso.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Recurso.Nombre]
Carpeta=Ficha
Clave=Recurso.Nombre
Editar=S
3D=S
Pegado=N
Tamano=34
ColorFondo=Plata
IgnoraFlujo=S

[Ficha.ProyectoRecurso.Rol]
Carpeta=Ficha
Clave=ProyectoRecurso.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.ProyectoRecurso.HorasDia]
Carpeta=Ficha
Clave=ProyectoRecurso.HorasDia
Editar=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Ficha.ProyectoRecurso.PrecioHora]
Carpeta=Ficha
Clave=ProyectoRecurso.PrecioHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.ProyectoRecurso.CostoHora]
Carpeta=Ficha
Clave=ProyectoRecurso.CostoHora
Editar=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Ficha.ProyectoRecurso.Comienzo]
Carpeta=Ficha
Clave=ProyectoRecurso.Comienzo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
Efectos=[Negritas]

[Ficha.ProyectoRecurso.Fin]
Carpeta=Ficha
Clave=ProyectoRecurso.Fin
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Plata
Efectos=[Negritas]

[Ficha.ProyectoRecurso.Estatus]
Carpeta=Ficha
Clave=ProyectoRecurso.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=Ficha
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Visible=S
EspacioPrevio=S
Activo=S

NombreEnBoton=S
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionConError=S
ActivoCondicion=(Info.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y (no ProyectoRecurso:ProyectoRecurso.TieneMovimientos)
EjecucionCondicion=no ProyectoRecurso:ProyectoRecurso.TieneMovimientos
EjecucionMensaje=<T>No se Puede Eliminar, Tiene Movimientos<T>

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

NombreEnBoton=S
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


[Ficha.ProyectoRecurso.ComienzoProgramado]
Carpeta=Ficha
Clave=ProyectoRecurso.ComienzoProgramado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.ProyectoRecurso.FinProgramado]
Carpeta=Ficha
Clave=ProyectoRecurso.FinProgramado
Editar=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco




[DetalleActividades]
Estilo=Iconos
Clave=DetalleActividades
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=ProyectoRecurso
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Negro
CarpetaVisible=S




[Detalle.Columnas]
0=80
1=136
2=69
3=113
4=526


5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
13=-2
14=-2
15=-2
16=-2
17=-2
18=-2
19=-2
20=-2
21=-2
22=-2
23=-2
24=-2
25=-2
26=-2
27=-2
28=-2
29=-2
30=-2
31=-2
32=-2
33=-2
34=-2
35=-2
36=-2
37=-2
[Detalle.ProyectoD.Tipo]
Carpeta=Detalle
Clave=ProyectoD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Detalle.ProyectoD.RecursosAsignados]
Carpeta=Detalle
Clave=ProyectoD.RecursosAsignados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Detalle.ProyectoD.Asunto]
Carpeta=Detalle
Clave=ProyectoD.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Ficha.ListaEnCaptura]
(Inicio)=ProyectoRecurso.Recurso
ProyectoRecurso.Recurso=Recurso.Nombre
Recurso.Nombre=ProyectoRecurso.Estatus
ProyectoRecurso.Estatus=ProyectoRecurso.Comienzo
ProyectoRecurso.Comienzo=ProyectoRecurso.Fin
ProyectoRecurso.Fin=ProyectoRecurso.ComienzoProgramado
ProyectoRecurso.ComienzoProgramado=ProyectoRecurso.FinProgramado
ProyectoRecurso.FinProgramado=ProyectoRecurso.Rol
ProyectoRecurso.Rol=ProyectoRecurso.HorasDia
ProyectoRecurso.HorasDia=ProyectoRecurso.PrecioHora
ProyectoRecurso.PrecioHora=ProyectoRecurso.CostoHora
ProyectoRecurso.CostoHora=(Fin)




[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S





[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S








[Acciones.LocalMostrar]
Nombre=LocalMostrar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

EspacioPrevio=S












[Detalle.ListaEnCaptura]
(Inicio)=ProyectoD.Asunto
ProyectoD.Asunto=ProyectoD.Tipo
ProyectoD.Tipo=ProyectoDEstado
ProyectoDEstado=ProyectoD.RecursosAsignados
ProyectoD.RecursosAsignados=(Fin)

[Detalle.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=LocalMostrar
LocalMostrar=(Fin)

[Detalle.ProyectoDEstado]
Carpeta=Detalle
Clave=ProyectoDEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco













































[Lista.ListaEnCaptura]
(Inicio)=ProyectoRecurso.Recurso
ProyectoRecurso.Recurso=Recurso.Nombre
Recurso.Nombre=(Fin)

[Lista.Recurso.Nombre]
Carpeta=Lista
Clave=Recurso.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

































































































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Guardar
Guardar=Eliminar
Eliminar=Info
Info=(Fin)
