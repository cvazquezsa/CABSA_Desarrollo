[Forma]
Clave=aroRiesgoEvaluacion
Nombre=Evaluaciones del Riesgo
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=307
PosicionInicialArriba=93
PosicionInicialAlturaCliente=521
PosicionInicialAncho=870
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Riesgo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSec1=239
Totalizadores=S
PosicionSec2=418
DialogoAbrir=S
BarraAyuda=S

MenuPrincipal=(Lista)
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

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=aroRiesgoEvaluacionA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Evaluaciones
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=aroRiesgoEvaluacion.Fecha
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
MenuLocal=S
ListaAcciones=Personalizar
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)

IconosConPaginas=S
IconosNombre=aroRiesgoEvaluacionA:aroRiesgoEvaluacion.Fecha
FiltroGeneral=aroRiesgoEvaluacion.Riesgo=<T>{Info.Riesgo}<T>
[(Carpeta Abrir).aroRiesgoEvaluacion.Tipo]
Carpeta=(Carpeta Abrir)
Clave=aroRiesgoEvaluacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Carpeta Abrir).aroRiesgoEvaluacion.Version]
Carpeta=(Carpeta Abrir)
Clave=aroRiesgoEvaluacion.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=97
1=264

2=-2
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

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
RefrescarDespues=S
Expresion=EjecutarSQL( <T>sp_aroRiesgoEvaluacionAceptar :nID<T>, aroRiesgoEvaluacion:aroRiesgoEvaluacion.ID)

[Detalle.aroRiesgoEvaluacionD.EventoRiesgo]
Carpeta=Detalle
Clave=aroRiesgoEvaluacionD.EventoRiesgo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.aroRiesgoEvaluacionD.Desde]
Carpeta=Detalle
Clave=aroRiesgoEvaluacionD.Desde
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.aroRiesgoEvaluacionD.Hasta]
Carpeta=Detalle
Clave=aroRiesgoEvaluacionD.Hasta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Columnas]
EventoRiesgo=111
Desde=110
Hasta=107
Nombre=253
Descripcion=201
n1=246

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Desde<BR>Hasta
Totalizadores2=Suma(aroRiesgoEvaluacionD:aroRiesgoEvaluacionD.Desde)<BR>Suma(aroRiesgoEvaluacionD:aroRiesgoEvaluacionD.Hasta)
Totalizadores3=(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Desde]
Carpeta=(Carpeta Totalizadores)
Clave=Desde
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Hasta]
Carpeta=(Carpeta Totalizadores)
Clave=Hasta
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Detalle.aroEvento.Nombre]
Carpeta=Detalle
Clave=aroEvento.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroRiesgoEvaluacion
Fuente={Tahoma, 8, Negro, []}
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

[Ficha.aroRiesgoEvaluacion.Fecha]
Carpeta=Ficha
Clave=aroRiesgoEvaluacion.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroRiesgoEvaluacion.Tipo]
Carpeta=Ficha
Clave=aroRiesgoEvaluacion.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroRiesgoEvaluacion.Version]
Carpeta=Ficha
Clave=aroRiesgoEvaluacion.Version
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroRiesgoEvaluacion.Severidad]
Carpeta=Ficha
Clave=aroRiesgoEvaluacion.Severidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=120
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroRiesgoEvaluacion.Ocurrencia]
Carpeta=Ficha
Clave=aroRiesgoEvaluacion.Ocurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=120
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroRiesgoEvaluacion.Deteccion]
Carpeta=Ficha
Clave=aroRiesgoEvaluacion.Deteccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=120
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroRiesgoEvaluacion.Observaciones]
Carpeta=Ficha
Clave=aroRiesgoEvaluacion.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=120x2
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.n1]
Carpeta=Detalle
Clave=n1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=aroRiesgoEvaluacionD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=aroRiesgoEvaluacion
LlaveLocal=aroRiesgoEvaluacionD.ID
LlaveMaestra=aroRiesgoEvaluacion.ID
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
ListaOrden=aroRiesgoEvaluacionD.Renglon<TAB>(Acendente)
ControlRenglon=S
CampoRenglon=aroRiesgoEvaluacionD.Renglon

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=&Personalizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
ActivoCondicion=aroRiesgoEvaluacion:aroRiesgoEvaluacion.Estatus=EstatusSinAfectar

[Ficha.aroRiesgoEvaluacion.Nivel]
Carpeta=Ficha
Clave=aroRiesgoEvaluacion.Nivel
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.aroNivel.Nombre]
Carpeta=Ficha
Clave=aroNivel.Nombre
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.aroRiesgoEvaluacion.Valor]
Carpeta=Ficha
Clave=aroRiesgoEvaluacion.Valor
Editar=N
EditarConBloqueo=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=&Afectar
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
Expresion=ProcesarSQL(<T>sp_aroRiesgoEvaluacionEstatus :nID, :tEstatus, :tUsuario<T>, aroRiesgoEvaluacion:aroRiesgoEvaluacion.ID, EstatusConcluido, Usuario)
ActivoCondicion=aroRiesgoEvaluacion:aroRiesgoEvaluacion.Estatus=EstatusSinAfectar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=&Cancelar Evaluación
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguroPrecaucion
Expresion=ProcesarSQL(<T>sp_aroRiesgoEvaluacionEstatus :nID, :tEstatus, :tUsuario<T>, aroRiesgoEvaluacion:aroRiesgoEvaluacion.ID, EstatusCancelado, Usuario)
ActivoCondicion=aroRiesgoEvaluacion:aroRiesgoEvaluacion.Estatus<>EstatusCancelado






[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Desde
Desde=Hasta
Hasta=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=aroRiesgoEvaluacion.Fecha
aroRiesgoEvaluacion.Fecha=aroRiesgoEvaluacion.Tipo
aroRiesgoEvaluacion.Tipo=aroRiesgoEvaluacion.Version
aroRiesgoEvaluacion.Version=aroRiesgoEvaluacion.Nivel
aroRiesgoEvaluacion.Nivel=aroNivel.Nombre
aroNivel.Nombre=aroRiesgoEvaluacion.Valor
aroRiesgoEvaluacion.Valor=aroRiesgoEvaluacion.Severidad
aroRiesgoEvaluacion.Severidad=aroRiesgoEvaluacion.Ocurrencia
aroRiesgoEvaluacion.Ocurrencia=aroRiesgoEvaluacion.Deteccion
aroRiesgoEvaluacion.Deteccion=aroRiesgoEvaluacion.Observaciones
aroRiesgoEvaluacion.Observaciones=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=aroRiesgoEvaluacionD.EventoRiesgo
aroRiesgoEvaluacionD.EventoRiesgo=n1
n1=aroEvento.Nombre
aroEvento.Nombre=aroRiesgoEvaluacionD.Desde
aroRiesgoEvaluacionD.Desde=aroRiesgoEvaluacionD.Hasta
aroRiesgoEvaluacionD.Hasta=(Fin)


































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=aroRiesgoEvaluacion.Tipo
aroRiesgoEvaluacion.Tipo=aroRiesgoEvaluacion.Version
aroRiesgoEvaluacion.Version=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Afectar
Afectar=Cancelar
Cancelar=Navegador
Navegador=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=(Fin)
