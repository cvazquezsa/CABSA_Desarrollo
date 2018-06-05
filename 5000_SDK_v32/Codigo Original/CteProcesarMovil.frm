

[Forma]
Clave=CteProcesarMovil
Icono=44
Modulos=(Todos)
MovModulo=CteProcesarMovil
Nombre=Buscar Clientes (Agente)

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=250
PosicionInicialArriba=59
PosicionInicialAlturaCliente=570
PosicionInicialAncho=866
BarraHerramientas=S
EsConsultaExclusiva=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Info.Articulo, Nulo)<BR>EjecutarSQL(<T>EXEC xpListaCteProcesarMovil :tEmpresa,:nEstacion,:tAgente<T>,Empresa,EstacionTrabajo,Info.Agente)
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Clientes
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
Vista=CteProcesarMovil
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=CteProcesarMovil.Cliente<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=CteTipo
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Espacio
FiltroAplicaEn1=CteProcesarMovil.Categoria
FiltroAplicaEn2=CteProcesarMovil.Familia
FiltroAplicaEn3=CteProcesarMovil.Grupo
FiltroAplicaEn4=CteProcesarMovil.Tipo
FiltroAplicaEn5=CteProcesarMovil.Espacio
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroArbol=Clientes
FiltroArbolAplica=Rama
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S

FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
ListaAcciones=(Lista)

IconosSubTitulo=<T>No<T>
IconosNombreNumerico=S
IconosSeleccionPorLlave=S
IconosNombre=CteProcesarMovil:CteProcesarMovil.ID
FiltroGeneral=Estacion = {EstacionTrabajo}
[Lista.Columnas]
0=-2
1=82

2=52

3=-2
4=66
5=89
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
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S






[Lista.CteProcesarMovil.Agente]
Carpeta=Lista
Clave=CteProcesarMovil.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.CteProcesarMovil.EnviarA]
Carpeta=Lista
Clave=CteProcesarMovil.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




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

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S




[Acciones.Cuantos]
Nombre=Cuantos
Boton=101
NombreDesplegar=Selección Actual
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=Informacion(e(<T>Selección Actual: <T>) +ListaConteo(ListaSeleccion(<T>Lista<T>)))
Activo=S
Visible=S




[Acciones.Procesar]
Nombre=Procesar
Boton=25
NombreEnBoton=S
NombreDesplegar=&Procesar Selección
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Antes=S
Visible=S


AntesExpresiones=RegistrarSeleccion(<T>Lista<T>)
[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteInfo
ActivoCondicion=Usuario.CteInfo
ConCondicion=S
EjecucionCondicion=ConDatos(CteProcesarMovil:CteProcesarMovil.Cliente) y ((CteProcesarMovil:CteProcesarMovil.Tipo<><T>Deudor<T>) o Usuario.VerInfoDeudores)
Antes=S
AntesExpresiones=Asigna( Info.Cliente,CteProcesarMovil:CteProcesarMovil.Cliente )
Visible=S











[Lista.CteProcesarMovil.ClienteNombre]
Carpeta=Lista
Clave=CteProcesarMovil.ClienteNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CteProcesarMovil.AgenteNombre]
Carpeta=Lista
Clave=CteProcesarMovil.AgenteNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco































[Lista.CteProcesarMovil.Cliente]
Carpeta=Lista
Clave=CteProcesarMovil.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


















[Lista.ListaEnCaptura]
(Inicio)=CteProcesarMovil.Cliente
CteProcesarMovil.Cliente=CteProcesarMovil.EnviarA
CteProcesarMovil.EnviarA=CteProcesarMovil.ClienteNombre
CteProcesarMovil.ClienteNombre=CteProcesarMovil.Agente
CteProcesarMovil.Agente=CteProcesarMovil.AgenteNombre
CteProcesarMovil.AgenteNombre=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=ALTA
ALTA=BLOQ_AVISO
BLOQ_AVISO=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)























[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Todo
Todo=Cuantos
Cuantos=Procesar
Procesar=CteInfo
CteInfo=(Fin)
