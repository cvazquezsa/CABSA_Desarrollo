[Forma]
Clave=AgenteProcesar
Nombre=Agentes
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Lista
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=248
PosicionInicialArriba=283
PosicionInicialAltura=421
PosicionInicialAncho=783
VentanaEscCerrar=S
BarraHerramientas=S
PosicionInicialAlturaCliente=431
VentanaExclusiva=S

[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AgenteA
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=AgenteCat
FiltroPredefinido=S
FiltroAplicaEn=Agente.Categoria
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=20
FiltroFechasNormal=S
FiltroAplicaEn1=Agente.Categoria
MenuLocal=S
ListaAcciones=(Lista)
PermiteLocalizar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=BAJA
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Agente<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Agentes
ListaEnCaptura=Agente.Nombre
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=AgenteTipo
FiltroAplicaEn2=Agente.Tipo
FiltroSucursales=S
IconosSeleccionMultiple=S
IconosNombre=AgenteA:Agente.Agente

[Lista.Columnas]
Agente=92
Nombre=320
0=105
1=247

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
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

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.Agente.Nombre]
Carpeta=Lista
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AgenteInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PropInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>AGENT<T>)<BR>Asigna(Info.Cuenta, Agente:Agente.Agente)<BR>Asigna(Info.Descripcion, Agente:Agente.Nombre)
Visible=S

[Acciones.Anexos]
Nombre=Anexos
Boton=77
NombreDesplegar=Ane&xos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>AGENT<T>)<BR>Asigna(Info.Cuenta, Agente:Agente.Agente)<BR>Asigna(Info.Descripcion, Agente:Agente.Nombre)
Visible=S
RefrescarDespues=S

[Acciones.Doc]
Nombre=Doc
Boton=17
NombreDesplegar=&Documentación
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=VerDocumentacion(<T>AGENT<T>, Agente:Agente.Agente, <T>Documentación - <T>+Agente:Agente.Nombre)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreDesplegar=Seleccionar Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
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

[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Seleccionar Todo
Seleccionar Todo=Procesar
Procesar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Informacion
Informacion=Propiedades
Propiedades=Anexos
Anexos=Doc
Doc=Personalizar
Personalizar=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos menos uno)
(Todos menos uno)=NORMAL
NORMAL=BLOQ_AVISO
BLOQ_AVISO=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)
