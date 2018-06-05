[Forma]
Clave=AgenteInfo
Nombre=Información del Agente
Icono=6
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Agente
PosicionInicialAltura=357
PosicionInicialAncho=828
PosicionInicialIzquierda=226
PosicionInicialArriba=265
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionColumna1=46
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Agente
PosicionInicialAlturaCliente=459
PosicionCol1=357

[Agente]
Estilo=Ficha
Clave=Agente
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Agente
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
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
FiltroGeneral=Agente.Agente=<T>{Info.Agente}<T>

[Agente.Agente.Agente]
Carpeta=Agente
Clave=Agente.Agente
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Agente.Agente.Nombre]
Carpeta=Agente
Clave=Agente.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Agente.Agente.Telefonos]
Carpeta=Agente
Clave=Agente.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Plata
ColorFuente=Negro

[Agente.Agente.Extencion]
Carpeta=Agente
Clave=Agente.Extencion
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Agente.Agente.Grupo]
Carpeta=Agente
Clave=Agente.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=N

[Agente.Agente.Categoria]
Carpeta=Agente
Clave=Agente.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Agente.Agente.Zona]
Carpeta=Agente
Clave=Agente.Zona
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[Pendientes.Columnas]
0=113
1=84

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

[Agente.Agente.Nomina]
Carpeta=Agente
Clave=Agente.Nomina
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Agente.NombreCompleto]
Carpeta=Agente
Clave=NombreCompleto
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Agente.Agente.Personal]
Carpeta=Agente
Clave=Agente.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PropInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>AGENT<T>)<BR>Asigna(Info.Cuenta, Agente:Agente.Agente)<BR>Asigna(Info.Descripcion, Agente:Agente.Nombre)

[Acciones.Anexos]
Nombre=Anexos
Boton=77
NombreDesplegar=Ane&xos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>AGENT<T>)<BR>Asigna(Info.Cuenta, Agente:Agente.Agente)<BR>Asigna(Info.Descripcion, Agente:Agente.Nombre)
Visible=S
RefrescarDespues=S

[Acciones.PendientesProp]
Nombre=PendientesProp
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=ConDatos(AgentPendienteLista:ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>AGENT<T>)<BR>Asigna(Info.ID, AgentPendienteLista:ID)

[Soporte]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Atención Clientes
Clave=Soporte
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=SoporteA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasCampo=Soporte.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
MenuLocal=S
ListaAcciones=SoporteProp
IconosNombre=SoporteA:Soporte.Mov+<T> <T>+SoporteA:Soporte.MovID
FiltroGeneral=Soporte.Agente=<T>{Info.Agente}<T>

[Soporte.Soporte.FechaEmision]
Carpeta=Soporte
Clave=Soporte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Vencimiento]
Carpeta=Soporte
Clave=Soporte.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Titulo]
Carpeta=Soporte
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Columnas]
0=113
1=81

[Acciones.SoporteProp]
Nombre=SoporteProp
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(SoporteA:Soporte.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, SoporteA:Soporte.ID)
Visible=S

[Comisiones]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
Clave=Comisiones
Filtros=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=AgentPendienteLista
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroEstilo=Directorio
FiltroAplicaEn=Moneda
FiltroRespetar=S
FiltroTipo=Automático
ListaAcciones=PendientesProp
IconosNombre=AgentPendienteLista:Mov+<T> <T>+AgentPendienteLista:MovID
FiltroGeneral=Agente=<T>{Info.Agente}<T>
CondicionVisible=Usuario.VerComisionesPendientes

[Comisiones.FechaEmision]
Carpeta=Comisiones
Clave=FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Comisiones.SaldoNeto]
Carpeta=Comisiones
Clave=SaldoNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Comisiones.Referencia]
Carpeta=Comisiones
Clave=Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Comisiones.Columnas]
0=97
1=81

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

[Acciones.Cubos]
Nombre=Cubos
Boton=100
NombreDesplegar=Cubos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Dialogos
ClaveAccion=CuboAgente
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)<BR>Asigna(Info.Nombre, Agente:Agente.Nombre)
Visible=S

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=103
NombreDesplegar=E&valuaciones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EvaluacionCalificacionInfo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, Agente:Agente.Agente)<BR>Asigna(Info.Nombre, Agente:Agente.Nombre)<BR>Asigna(Info.Aplica, <T>Agentes<T>)<BR>Asigna(Info.Nombre2, Nulo)
Visible=S

[Equipo]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Equipo
Clave=Equipo
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EquipoAgente
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=EquipoAgente.Equipo=<T>{Info.Agente}<T>
CondicionVisible=Agente:Agente.Equipo

[Equipo.EquipoAgente.Agente]
Carpeta=Equipo
Clave=EquipoAgente.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Equipo.Agente.Nombre]
Carpeta=Equipo
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Equipo.EquipoAgente.Porcentaje]
Carpeta=Equipo
Clave=EquipoAgente.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Equipo.Columnas]
Agente=70
Nombre=215
Porcentaje=30

[Acciones.Tareas]
Nombre=Tareas
Boton=70
NombreDesplegar=Tareas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.PuedeEditar, Falso)<BR>Asigna(Info.Nombre, Agente:Agente.Nombre)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Agente:Agente.Agente)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Asigna(Info.Reporte, Nulo)
Visible=S

[Acciones.Politica]
Nombre=Politica
Boton=22
NombreDesplegar=Política
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Rama, <T>AGTE<T>)<BR>Asigna(Info.Clave, Agente:Agente.Agente)

[Acciones.Correos]
Nombre=Correos
Boton=112
NombreDesplegar=&Correos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=OutlookAgente
Activo=S
Visible=S

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Características
Clave=FormaExtraValor
Filtros=S
OtroOrden=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraValor
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaSinBorde=S
HojaFondoGris=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleAgente(<T>{Agente:Agente.Categoria}<T>, <T>{Agente:Agente.Grupo}<T>, <T>{Agente:Agente.Familia}<T>)) AND FormaExtraValor.Aplica=<T>Agente<T> AND FormaExtraValor.AplicaClave=<T>{Agente:Agente.Agente}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>

[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[FormaExtraValor.Columnas]
VerCampo=165
VerValor=155

[Forma.ListaCarpetas]
(Inicio)=Agente
Agente=Equipo
Equipo=Comisiones
Comisiones=Soporte
Soporte=FormaExtraValor
FormaExtraValor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Tareas
Tareas=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Anexos
Anexos=Doc
Doc=Politica
Politica=Cubos
Cubos=Correos
Correos=(Fin)

[Agente.ListaEnCaptura]
(Inicio)=Agente.Agente
Agente.Agente=Agente.Nombre
Agente.Nombre=Agente.Telefonos
Agente.Telefonos=Agente.Extencion
Agente.Extencion=Agente.Categoria
Agente.Categoria=Agente.Grupo
Agente.Grupo=Agente.Zona
Agente.Zona=Agente.Nomina
Agente.Nomina=Agente.Personal
Agente.Personal=NombreCompleto
NombreCompleto=(Fin)

[Soporte.ListaEnCaptura]
(Inicio)=Soporte.FechaEmision
Soporte.FechaEmision=Soporte.Vencimiento
Soporte.Vencimiento=Soporte.Titulo
Soporte.Titulo=(Fin)

[Soporte.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=ALTAPRIORIDAD
ALTAPRIORIDAD=PRIORIDADBAJA
PRIORIDADBAJA=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[Comisiones.ListaEnCaptura]
(Inicio)=FechaEmision
FechaEmision=Referencia
Referencia=SaldoNeto
SaldoNeto=(Fin)

[Equipo.ListaEnCaptura]
(Inicio)=EquipoAgente.Agente
EquipoAgente.Agente=Agente.Nombre
Agente.Nombre=EquipoAgente.Porcentaje
EquipoAgente.Porcentaje=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)
