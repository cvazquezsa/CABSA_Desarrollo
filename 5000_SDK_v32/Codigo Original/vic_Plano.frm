
[Forma]
Clave=vic_Plano
Icono=0
Menus=S
BarraHerramientas=S
EsConsultaExclusiva=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Planogramas
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=443
PosicionInicialArriba=269
PosicionInicialAltura=504
PosicionInicialAncho=1034
ListaAcciones=(Lista)
PosicionSec1=340
PosicionInicialAlturaCliente=443
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ExpresionesAlCerrar=Asigna(Info.OrigenTipo, Nulo)
MenuPrincipal=&Maestros
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Planos
Clave=Lista
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=vic_Plano
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=vic_planoCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=vic_PlanoFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=vic_PlanoGrp
FiltroAplicaEn1=vic_Plano.Categoria
FiltroAplicaEn2=vic_Plano.Familia
FiltroAplicaEn3=vic_Plano.Grupo
FiltroTodo=S
FiltroTodoFinal=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
BusquedaRapida=S
BusquedaRespetarControles=S
BusquedaAncho=28
BusquedaEnLinea=S
ListaAcciones=Seleccionar
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
IconosNombre=vic_Plano:vic_Plano.Plano
[Lista.Columnas]
0=-2



1=-2
2=137
3=172
4=299

[Lista.vic_Plano.NombreCorto]
Carpeta=Lista
Clave=vic_Plano.NombreCorto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.vic_Plano.Nombre]
Carpeta=Lista
Clave=vic_Plano.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=200
ColorFondo=Blanco

[Lista.vic_Plano.Lista]
Carpeta=Lista
Clave=vic_Plano.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.NombreInmueble]
Carpeta=Lista
Clave=NombreInmueble
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco










[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=0
NombreDesplegar=Ver Planograma (Producción)
EnMenu=S
TipoAccion=Expresion




Antes=S












Expresion=PlugIn(<T>Planograma<T>,<T>#P#I#<T>+Info.Plano+<T>#<T>)
ActivoCondicion=ConDatos(vic_Plano:vic_Plano.Plano)
AntesExpresiones=Asigna(Info.Plano, vic_Plano:vic_Plano.Plano)
VisibleCondicion=Vacio(Info.OrigenTipo, <T><T>) <> <T>CFG<T>
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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S



Carpeta=(Carpeta principal)
ClaveAccion=Imprimir




EspacioPrevio=S







[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S












[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S








EspacioPrevio=S
[Acciones.NvoPlanograma]
Nombre=NvoPlanograma
Boton=87
NombreDesplegar=&Nuevo Planograma
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S



EspacioPrevio=S
ListaAccionesMultiples=(Lista)

[Acciones.NvoPlanograma.VIC_PlanoNuevo]
Nombre=VIC_PlanoNuevo
Boton=0
TipoAccion=Formas
ClaveAccion=Vic_PlanoNuevo
Activo=S
Visible=S

[Acciones.NvoPlanograma.ActualizarVista]
Nombre=ActualizarVista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S




[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S






[Acciones.vic_PlanoCat]
Nombre=vic_PlanoCat
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorias
EnMenu=S
TipoAccion=Formas
ClaveAccion=vic_PlanoCat
Activo=S










VisibleCondicion=1=0
[Acciones.vic_PlanoGrp]
Nombre=vic_PlanoGrp
Boton=0
Menu=&Maestros
NombreDesplegar=&Grupo
EnMenu=S
TipoAccion=Formas
ClaveAccion=vic_PlanoGrp
Activo=S






VisibleCondicion=1=0
[Acciones.vic_PlanoFam]
Nombre=vic_PlanoFam
Boton=0
Menu=&Maestros
NombreDesplegar=&Familia
EnMenu=S
TipoAccion=Formas
ClaveAccion=vic_PlanoFam
Activo=S






VisibleCondicion=1=0
[Acciones.TipoPlano]
Nombre=TipoPlano
Boton=0
Menu=&Maestros
NombreDesplegar=&Tipo de Plano
EnMenu=S
TipoAccion=Formas
ClaveAccion=vic_PlanoTipo
Activo=S
Visible=S






















[Acciones]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Acciones
Clave=Acciones
OtroOrden=S
Detalle=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=vic_PlanoAcciones
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=vic_plano
LlaveLocal=vic_PlanoAcciones.Plano
LlaveMaestra=vic_Plano.Plano
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

ListaOrden=vic_PlanoAcciones.Renglon<TAB>(Acendente)
CarpetaVisible=S

ListaAcciones=(Lista)
HojaColorFondo=Plata
[Acciones.vic_PlanoAcciones.Nombre]
Carpeta=Acciones
Clave=vic_PlanoAcciones.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.vic_PlanoAcciones.Query]
Carpeta=Acciones
Clave=vic_PlanoAcciones.Query
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Acciones.vic_PlanoAcciones.Estatus]
Carpeta=Acciones
Clave=vic_PlanoAcciones.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco



[Acciones.Columnas]
Nombre=304
Query=444
Estatus=180






[Acciones.EliminarAccion]
Nombre=EliminarAccion
Boton=0
NombreDesplegar=&Eliminar acción del Planograma
Multiple=S
EnMenu=S
Visible=S

ListaAccionesMultiples=(Lista)



ActivoCondicion=(ConDatos(vic_PlanoAcciones:vic_PlanoAcciones.Plano)) y (ConDatos(vic_PlanoAcciones:vic_PlanoAcciones.Renglon))
[Acciones.EliminarAccion.Expresiones]
Nombre=Expresiones
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S







Expresion=Si Precaucion(<T>¿ Esta seguro que desea eliminar esta acción ?<T>+ NuevaLinea + NuevaLinea + <T>Acción <T> + vic_PlanoAcciones:vic_PlanoAcciones.Nombre, BotonSi, BotonNo ) = BotonSi<BR>Entonces EjecutarSQL(<T>vic_spEliminaAccionPlano :tPlano, :nRenglon<T>, vic_PlanoAcciones:vic_PlanoAcciones.Plano, vic_PlanoAcciones:vic_PlanoAcciones.Renglon)<BR>Sino<BR><T><T><BR>Fin
[Acciones.EliminarAccion.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S


[Acciones.ACImprimir]
Nombre=ACImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=Acciones
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S





[Acciones.ACPreliminar]
Nombre=ACPreliminar
Boton=0
NombreDesplegar=Presentación Preliminar
EnMenu=S
Carpeta=Acciones
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.ACExcel]
Nombre=ACExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=Acciones
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.ACPersonalizar]
Nombre=ACPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S



[Acciones.NvoPlanograma.ListaAccionesMultiples]
(Inicio)=VIC_PlanoNuevo
VIC_PlanoNuevo=ActualizarVista
ActualizarVista=(Fin)




































































[Acciones.EliminarAccion.ListaAccionesMultiples]
(Inicio)=Expresiones
Expresiones=Actualizar Vista
Actualizar Vista=(Fin)








[Acciones.ListaEnCaptura]
(Inicio)=vic_PlanoAcciones.Nombre
vic_PlanoAcciones.Nombre=vic_PlanoAcciones.Query
vic_PlanoAcciones.Query=vic_PlanoAcciones.Estatus
vic_PlanoAcciones.Estatus=(Fin)

[Acciones.ListaAcciones]
(Inicio)=EliminarAccion
EliminarAccion=ACImprimir
ACImprimir=ACPreliminar
ACPreliminar=ACExcel
ACExcel=ACPersonalizar
ACPersonalizar=(Fin)



















































[Lista.ListaEnCaptura]
(Inicio)=vic_Plano.NombreCorto
vic_Plano.NombreCorto=vic_Plano.Nombre
vic_Plano.Nombre=vic_Plano.Lista
vic_Plano.Lista=NombreInmueble
NombreInmueble=(Fin)

[Lista.ListaOrden]
(Inicio)=vic_Plano.Plano	(Acendente)
vic_Plano.Plano	(Acendente)=vic_Plano.Nombre	(Acendente)
vic_Plano.Nombre	(Acendente)=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQ_AVISO
BLOQ_AVISO=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Acciones
Acciones=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=NvoPlanograma
NvoPlanograma=Campos
Campos=vic_PlanoCat
vic_PlanoCat=vic_PlanoGrp
vic_PlanoGrp=vic_PlanoFam
vic_PlanoFam=TipoPlano
TipoPlano=(Fin)
