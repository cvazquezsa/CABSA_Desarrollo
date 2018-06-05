[Forma]
Clave=EstacionT
Nombre=Estaciones Trabajo
Icono=4
Modulos=(Todos)
ListaCarpetas=Detalles
CarpetaPrincipal=Detalles
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAltura=376
PosicionInicialAncho=571
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=674
PosicionInicialArriba=407
PosicionSeccion1=89
Menus=S
BarraAyuda=S
DialogoAbrir=S
Plantillas=S
PermiteCopiarDoc=S
PlantillasExcepciones=EstacionT:EstacionT.Estatus
PosicionInicialAlturaCliente=349
MenuPrincipal=(Lista)

[Lista.EstacionT.Estacion]
Carpeta=Lista
Clave=EstacionT.Estacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EstacionT.Descripcion]
Carpeta=Lista
Clave=EstacionT.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Estacion=106
Descripcion=205
DiasSemana=71
TurnosDiarios=40
HorasTurno=65
Eficiencia=64
Utilizacion=64
DiasFestivos=71
Activa=36
Capacidad=58
Centro_1=64
Centro=86
Categoria=74

[(Carpeta Totalizadores).Capacidad Semanal Calculada]
Carpeta=(Carpeta Totalizadores)
Clave=Capacidad Semanal Calculada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Calendario]
Nombre=Calendario
Boton=9
NombreEnBoton=S
NombreDesplegar=&Calendario
EspacioPrevio=S
TipoAccion=Otros
ClaveAccion=Calendario
Activo=S
Visible=S
Menu=&Ver
EnMenu=S

[Lista.EstacionT.Centro]
Carpeta=Lista
Clave=EstacionT.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalles]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Estación Trabajo
Clave=Detalles
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EstacionT
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalles.EstacionT.Estacion]
Carpeta=Detalles
Clave=EstacionT.Estacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalles.EstacionT.Descripcion]
Carpeta=Detalles
Clave=EstacionT.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.EstacionT.Centro]
Carpeta=Detalles
Clave=EstacionT.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.Centro.Descripcion]
Carpeta=Detalles
Clave=Centro.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Plata
ColorFuente=Negro

[Detalles.EstacionT.Categoria]
Carpeta=Detalles
Clave=EstacionT.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.EstacionT.DiasSemana]
Carpeta=Detalles
Clave=EstacionT.DiasSemana
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Detalles.EstacionT.TurnosDiarios]
Carpeta=Detalles
Clave=EstacionT.TurnosDiarios
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Detalles.EstacionT.HorasTurno]
Carpeta=Detalles
Clave=EstacionT.HorasTurno
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Detalles.EstacionT.Eficiencia]
Carpeta=Detalles
Clave=EstacionT.Eficiencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Detalles.EstacionT.Utilizacion]
Carpeta=Detalles
Clave=EstacionT.Utilizacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EspacioPrevio=S
ActivoCondicion=no EstacionT:EstacionT.TieneMovimientos

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

[Detalles.EstacionT.Estatus]
Carpeta=Detalles
Clave=EstacionT.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.EstacionTCat]
Nombre=EstacionTCat
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías
EnMenu=S
TipoAccion=Formas
ClaveAccion=EstacionTCat
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Estaciones Trabajo
Clave=(Carpeta Abrir)
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=EstacionTA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Estación<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroGrupo1=EstacionT.Centro
FiltroValida1=EstacionT.Centro
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ListaAcciones=(Lista)
CarpetaVisible=S
FiltroAplicaEn=EstacionT.Centro
OtroOrden=S
ListaOrden=EstacionT.Estacion<TAB>(Acendente)
IconosNombre=EstacionTA:EstacionT.Estacion

[(Carpeta Abrir).EstacionT.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=EstacionT.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).EstacionT.Centro]
Carpeta=(Carpeta Abrir)
Clave=EstacionT.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=95
1=282

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

[Detalles.Capacidad]
Carpeta=Detalles
Clave=Capacidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Tamano=20

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros4]
Nombre=Otros4
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros5]
Nombre=Otros5
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros8]
Nombre=Otros8
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Detalles.EstacionT.ContUso]
Carpeta=Detalles
Clave=EstacionT.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.CentroCostos.Descripcion]
Carpeta=Detalles
Clave=CentroCostos.Descripcion
Editar=S
3D=S
Tamano=54
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Navegador
Navegador=Calendario
Calendario=Cerrar
Cerrar=EstacionTCat
EstacionTCat=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)

[Detalles.ListaEnCaptura]
(Inicio)=EstacionT.Estacion
EstacionT.Estacion=EstacionT.Descripcion
EstacionT.Descripcion=EstacionT.Estatus
EstacionT.Estatus=EstacionT.Centro
EstacionT.Centro=Centro.Descripcion
Centro.Descripcion=EstacionT.ContUso
EstacionT.ContUso=CentroCostos.Descripcion
CentroCostos.Descripcion=EstacionT.Categoria
EstacionT.Categoria=EstacionT.DiasSemana
EstacionT.DiasSemana=EstacionT.TurnosDiarios
EstacionT.TurnosDiarios=EstacionT.HorasTurno
EstacionT.HorasTurno=EstacionT.Eficiencia
EstacionT.Eficiencia=EstacionT.Utilizacion
EstacionT.Utilizacion=Capacidad
Capacidad=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=EstacionT.Descripcion
EstacionT.Descripcion=EstacionT.Centro
EstacionT.Centro=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)
