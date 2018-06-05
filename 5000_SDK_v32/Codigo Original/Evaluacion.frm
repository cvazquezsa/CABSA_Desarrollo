[Forma]
Clave=Evaluacion
Nombre=<T>Evaluaciones<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=553
PosicionInicialArriba=132
PosicionInicialAltura=336
PosicionInicialAncho=378
PosicionInicialAlturaCliente=444
PosicionColumna1=53
DialogoAbrir=S
Menus=S

MenuPrincipal=(Lista)
[Lista.Evaluacion.Evaluacion]
Carpeta=Lista
Clave=Evaluacion.Evaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Evaluacion=197
Tipo=124

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S
EspacioPrevio=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S

[Acciones.Formato]
Nombre=Formato
Boton=47
NombreEnBoton=S
NombreDesplegar=&Formato
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EvaluacionFormato
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
EnMenu=S
EjecucionCondicion=ConDatos(Evaluacion:Evaluacion.Evaluacion)
AntesExpresiones=Asigna(Info.Evaluacion, Evaluacion:Evaluacion.Evaluacion)<BR>Asigna(Info.Aplica, Evaluacion:Evaluacion.Aplica)

[Acciones.EvaluacionGrupo]
Nombre=EvaluacionGrupo
Boton=91
NombreDesplegar=Grupo&s
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EvaluacionGrupo
Activo=S
Visible=S
Menu=&Maestros
EnMenu=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=EvaluacionA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Evaluación<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Evaluaciones
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=Evaluacion.Aplica
FiltroGrupo2=Evaluacion.Grupo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA

IconosConPaginas=S
IconosNombre=EvaluacionA:Evaluacion.Evaluacion
[(Carpeta Abrir).Evaluacion.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=Evaluacion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[(Carpeta Abrir).Evaluacion.Tipo]
Carpeta=(Carpeta Abrir)
Clave=Evaluacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=166
1=286

2=-2
[Ficha]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Evaluacion
Fuente={MS Sans Serif, 8, Negro, []}
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

[Ficha.Evaluacion.Evaluacion]
Carpeta=Ficha
Clave=Evaluacion.Evaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Evaluacion.Aplica]
Carpeta=Ficha
Clave=Evaluacion.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Evaluacion.Grupo]
Carpeta=Ficha
Clave=Evaluacion.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Evaluacion.Orden]
Carpeta=Ficha
Clave=Evaluacion.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Evaluacion.Modulo]
Carpeta=Ficha
Clave=Evaluacion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Evaluacion.Mov]
Carpeta=Ficha
Clave=Evaluacion.Mov
Editar=S
3D=S
Tamano=29
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Evaluacion.Tipo]
Carpeta=Ficha
Clave=Evaluacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Evaluacion.Duracion]
Carpeta=Ficha
Clave=Evaluacion.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Evaluacion.Descripcion]
Carpeta=Ficha
Clave=Evaluacion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40x10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S

[Ficha.Evaluacion.Estatus]
Carpeta=Ficha
Clave=Evaluacion.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro





[Ficha.ListaEnCaptura]
(Inicio)=Evaluacion.Evaluacion
Evaluacion.Evaluacion=Evaluacion.Aplica
Evaluacion.Aplica=Evaluacion.Grupo
Evaluacion.Grupo=Evaluacion.Orden
Evaluacion.Orden=Evaluacion.Modulo
Evaluacion.Modulo=Evaluacion.Mov
Evaluacion.Mov=Evaluacion.Tipo
Evaluacion.Tipo=Evaluacion.Duracion
Evaluacion.Duracion=Evaluacion.Descripcion
Evaluacion.Descripcion=Evaluacion.Estatus
Evaluacion.Estatus=(Fin)















[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Evaluacion.Descripcion
Evaluacion.Descripcion=Evaluacion.Tipo
Evaluacion.Tipo=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Formato
Formato=EvaluacionGrupo
EvaluacionGrupo=Navegador
Navegador=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
