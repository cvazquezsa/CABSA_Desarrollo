[Forma]
Clave=LCExpress
Nombre=Línea de Crédito Express
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=580
PosicionInicialAncho=806
PosicionInicialIzquierda=237
PosicionInicialArriba=208
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraAyuda=S
BarraAyudaBold=S
PosicionSeccion1=92
PosicionSeccion2=93
MovModulo=AC
VentanaExclusiva=S
Comentarios=Lista(Info.Mov, Info.MovID)

[Ficha]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LC
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
Pestana=S
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=LC.LineaCredito=<T>{Info.LineaCredito}<T>

[Ficha.LC.LineaCredito]
Carpeta=Ficha
Clave=LC.LineaCredito
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.LC.Descripcion]
Carpeta=Ficha
Clave=LC.Descripcion
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro
Editar=S
IgnoraFlujo=S

[Ficha.LC.TipoCredito]
Carpeta=Ficha
Clave=LC.TipoCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro

[Solicitud.LC.SolicitudConcepto]
Carpeta=Solicitud
Clave=LC.SolicitudConcepto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=83
ColorFondo=Blanco
ColorFuente=Negro

[Solicitud.LC.SolicititudImporte]
Carpeta=Solicitud
Clave=LC.SolicititudImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Solicitud.LC.SolicitudMoneda]
Carpeta=Solicitud
Clave=LC.SolicitudMoneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Solicitud.LC.SolicitudPlazo]
Carpeta=Solicitud
Clave=LC.SolicitudPlazo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Solicitud.Columnas]
SolicitudConcepto=304
SolicititudImporte=64
SolicitudMoneda=64
SolicitudPlazo=64

[Solicitud.LC.LineaCredito]
Carpeta=Solicitud
Clave=LC.LineaCredito
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Solicitud.LC.Descripcion]
Carpeta=Solicitud
Clave=LC.Descripcion
ValidaNombre=S
3D=S
Tamano=83
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Analisis.LC.CapacidadCredito]
Carpeta=Analisis
Clave=LC.CapacidadCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Analisis.LC.CreditosExistentes]
Carpeta=Analisis
Clave=LC.CreditosExistentes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Analisis.LC.CapacidadPago]
Carpeta=Analisis
Clave=LC.CapacidadPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Analisis.LC.LineaCredito]
Carpeta=Analisis
Clave=LC.LineaCredito
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Analisis.LC.Descripcion]
Carpeta=Analisis
Clave=LC.Descripcion
ValidaNombre=S
3D=S
Tamano=83
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=LC
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=LC.Descripcion
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasCampo=LC.FechaEmision
FiltroFechasDefault=(Todo)
MenuLocal=S
ListaAcciones=(Lista)
PestanaOtroNombre=S
PestanaNombre=Líneas de Crédito
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=LC.Uso
FiltroAutoValidar=LC.Uso
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Folder (1 línea)
FiltroRespetar=S
FiltroTipo=Automático
IconosNombre=LC:LC.LineaCredito
FiltroGeneral={Si(Vacio(Usuario.ACLCUsoEspecifico), <T>1=1<T>, <T>LC.Uso=<T>+Comillas(Usuario.ACLCUsoEspecifico))}

[(Carpeta Abrir).LC.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=LC.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=120
1=266

[Tasa.LC.TasaTipo]
Carpeta=Tasa
Clave=LC.TasaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tasa.LC.TasaBase]
Carpeta=Tasa
Clave=LC.TasaBase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Tasa.LC.SobreTasaEn]
Carpeta=Tasa
Clave=LC.SobreTasaEn
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Tasa.LC.SobreTasa]
Carpeta=Tasa
Clave=LC.SobreTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
EspacioPrevio=N

[Tasa.LC.MoratoriosFactor]
Carpeta=Tasa
Clave=LC.MoratoriosFactor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Ficha.LC.Moneda]
Carpeta=Ficha
Clave=LC.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Vigencia.LC.LineaCredito]
Carpeta=Vigencia
Clave=LC.LineaCredito
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Vigencia.LC.Descripcion]
Carpeta=Vigencia
Clave=LC.Descripcion
ValidaNombre=S
3D=S
Tamano=83
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Vigencia.LC.VigenciaDesde]
Carpeta=Vigencia
Clave=LC.VigenciaDesde
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Vigencia.LC.VigenciaDias]
Carpeta=Vigencia
Clave=LC.VigenciaDias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Vigencia.LC.VigenciaHasta]
Carpeta=Vigencia
Clave=LC.VigenciaHasta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tasa.LC.LineaCredito]
Carpeta=Tasa
Clave=LC.LineaCredito
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Tasa.LC.Descripcion]
Carpeta=Tasa
Clave=LC.Descripcion
ValidaNombre=S
3D=S
Tamano=83
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Analisis.CapacidadCreditoDisponible]
Carpeta=Analisis
Clave=CapacidadCreditoDisponible
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Solicitud.LC.FechaSolicitud]
Carpeta=Solicitud
Clave=LC.FechaSolicitud
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Analisis.LC.FechaAnalisis]
Carpeta=Analisis
Clave=LC.FechaAnalisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aval]
Nombre=Aval
Boton=80
Menu=&Edición
NombreDesplegar=&Avales
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=LCAval
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
AntesExpresiones=Asigna(Info.LineaCredito, LC:LC.LineaCredito)

[Acciones.Doc]
Nombre=Doc
Boton=50
Menu=&Edición
NombreDesplegar=Documentación
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=LCDoc
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
AntesExpresiones=Asigna(Info.LineaCredito, LC:LC.LineaCredito)

[Acciones.Garantia]
Nombre=Garantia
Boton=87
Menu=&Edición
NombreDesplegar=&Garantías
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=LCGarantia
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.LineaCredito, LC:LC.LineaCredito)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Prop
Activo=S
Antes=S
Visible=S
GuardarAntes=S
ConCondicion=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(LC:LC.LineaCredito)
AntesExpresiones=Asigna(Info.Rama, <T>LC<T>)<BR>Asigna(Info.Cuenta, LC:LC.LineaCredito)<BR>Asigna(Info.Descripcion, LC:LC.Descripcion)

[Acciones.Informacion]
Nombre=Informacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
Antes=S
Visible=S
Activo=S
AntesExpresiones=Asigna(Info.LineaCredito, LC:LC.LineaCredito)

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tareas
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(LC:LC.LineaCredito)
AntesExpresiones=Asigna(Info.PuedeEditar, Verdadero)<BR>Asigna(Info.Nombre, LC:LC.Descripcion)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(LC:LC.LineaCredito)
AntesExpresiones=Asigna(Info.Rama, <T>LC<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, LC:LC.LineaCredito)<BR>Asigna(Info.Descripcion, LC:LC.Descripcion)
RefrescarDespues=S

[Acciones.AgregarEvento]
Nombre=AgregarEvento
Boton=56
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=Agregar &Evento
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaBitacoraAgregar
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(LC:LC.LineaCredito)
AntesExpresiones=Asigna(Info.Modulo, <T>LC<T>)<BR>Asigna(Info.Cuenta, LC:LC.LineaCredito)<BR>Asigna(Info.Descripcion, LC:LC.Descripcion)

[Acciones.Bitacora]
Nombre=Bitacora
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+B
NombreDesplegar=&Bitácora
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaBitacora
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(LC:LC.LineaCredito)
AntesExpresiones=Asigna(Info.Modulo, <T>LC<T>)<BR>Asigna(Info.Tipo, LC:LC.TipoCredito)<BR>Asigna(Info.Cuenta, LC:LC.LineaCredito)<BR>Asigna(Info.Descripcion, LC:LC.Descripcion)<BR>Asigna(Info.PuedeEditar, Verdadero)

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
NombreDesplegar=&Presentacion preliminar
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

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

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

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=103
Menu=&Edición
NombreDesplegar=E&valuaciones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EvaluacionCalificacion
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(LC:LC.LineaCredito)
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, LC:LC.LineaCredito)<BR>Asigna(Info.Nombre, LC:LC.Descripcion)<BR>Asigna(Info.Aplica, <T>Línea de Crédito<T>)<BR>Asigna(Info.Nombre2, Nulo)

[Ficha.LC.Agente]
Carpeta=Ficha
Clave=LC.Agente
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Tasa.LC.TasaFija]
Carpeta=Tasa
Clave=LC.TasaFija
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Otros.LC.LineaCredito]
Carpeta=Otros
Clave=LC.LineaCredito
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Otros.LC.Descripcion]
Carpeta=Otros
Clave=LC.Descripcion
ValidaNombre=S
3D=S
Tamano=83
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Otros.LC.Reestructurado]
Carpeta=Otros
Clave=LC.Reestructurado
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.LC.DisposicionTipo]
Carpeta=Ficha
Clave=LC.DisposicionTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Ficha.LC.DisposicionPlazoMaximo]
Carpeta=Ficha
Clave=LC.DisposicionPlazoMaximo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.DisposicionPlazoMinimo]
Carpeta=Ficha
Clave=LC.DisposicionPlazoMinimo
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Tasa.LC.TasaTotalMinima]
Carpeta=Tasa
Clave=LC.TasaTotalMinima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Tasa.LC.TasaTotalMaxima]
Carpeta=Tasa
Clave=LC.TasaTotalMaxima
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tasa.LC.TasaBase2]
Carpeta=Tasa
Clave=LC.TasaBase2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tasa.LC.TasaBase3]
Carpeta=Tasa
Clave=LC.TasaBase3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TipoCredito]
Nombre=TipoCredito
Boton=0
Menu=&Maestros
NombreDesplegar=Tipos de Créditos
EnMenu=S
TipoAccion=Formas
ClaveAccion=TipoCredito
Activo=S
Visible=S

[Acciones.DocTipo]
Nombre=DocTipo
Boton=0
Menu=&Maestros
NombreDesplegar=Tipos de Documentos
EnMenu=S
TipoAccion=Formas
ClaveAccion=DocTipo
Activo=S
Visible=S

[Acciones.GarantiaTipo]
Nombre=GarantiaTipo
Boton=0
Menu=&Maestros
NombreDesplegar=Tipos de Garantías
EnMenu=S
TipoAccion=Formas
ClaveAccion=GarantiaTipo
Activo=S
Visible=S

[Acciones.CalificacionCartera]
Nombre=CalificacionCartera
Boton=0
Menu=&Maestros
NombreDesplegar=Calificación Cartera
EnMenu=S
TipoAccion=Formas
ClaveAccion=CalificacionCartera
Activo=S
Visible=S
EspacioPrevio=S

[Destino.LCD.Articulo]
Carpeta=Destino
Clave=LCD.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Destino.Art.Descripcion1]
Carpeta=Destino
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Destino.LCD.Importe]
Carpeta=Destino
Clave=LCD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Destino.LCD.Enganche]
Carpeta=Destino
Clave=LCD.Enganche
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Destino.Columnas]
Articulo=137
Descripcion1=184
Importe=134
Enganche=114

[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Enganche Total]
Carpeta=(Carpeta Totalizadores)
Clave=Enganche Total
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.LC.Acreditado]
Carpeta=Ficha
Clave=LC.Acreditado
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Ficha.LC.Coacreditado]
Carpeta=Ficha
Clave=LC.Coacreditado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteDestino.Nombre]
Carpeta=Ficha
Clave=CteDestino.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro

[Ficha.LC.Importe]
Carpeta=Ficha
Clave=LC.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.LC.Fecha]
Carpeta=Ficha
Clave=LC.Fecha
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
IgnoraFlujo=S

[Ficha.LC.VigenciaDesde]
Carpeta=Ficha
Clave=LC.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=12

[Ficha.LC.VigenciaHasta]
Carpeta=Ficha
Clave=LC.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=12

[Ficha.LC.TipoAmortizacion]
Carpeta=Ficha
Clave=LC.TipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.LC.TipoTasa]
Carpeta=Ficha
Clave=LC.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.TipoAmortizacion.Descripcion]
Carpeta=Ficha
Clave=TipoAmortizacion.Descripcion
Editar=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Ficha.TipoTasa.Descripcion]
Carpeta=Ficha
Clave=TipoTasa.Descripcion
Editar=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Ficha.LC.VigenciaCondicion]
Carpeta=Ficha
Clave=LC.VigenciaCondicion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.Condicion]
Carpeta=Ficha
Clave=LC.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.Uso]
Carpeta=Ficha
Clave=LC.Uso
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.LC.Acreedor]
Carpeta=Ficha
Clave=LC.Acreedor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Acreedor.Nombre]
Carpeta=Ficha
Clave=Acreedor.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.LC.Reestructurada]
Carpeta=Ficha
Clave=LC.Reestructurada
Editar=S
LineaNueva=N
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.Calificacion]
Carpeta=Ficha
Clave=LC.Calificacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.LCHist]
Nombre=LCHist
Boton=53
Menu=&Ver
NombreDesplegar=Histórico de Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=LCHist
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.LineaCredito, LC:LC.LineaCredito)
Visible=S

[Ficha.LC.CarteraVencidaCBNV]
Carpeta=Ficha
Clave=LC.CarteraVencidaCBNV
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.PeriodosGraciaCapital]
Carpeta=Ficha
Clave=LC.PeriodosGraciaCapital
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.Estatus]
Carpeta=Ficha
Clave=LC.Estatus
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.LC.TipoTasaBonificacion]
Carpeta=Ficha
Clave=LC.TipoTasaBonificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasaBonificacion.Descripcion]
Carpeta=Ficha
Clave=TipoTasaBonificacion.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro

[Ficha.LC.MinistracionHipotecaria]
Carpeta=Ficha
Clave=LC.MinistracionHipotecaria
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.Empresa]
Carpeta=Ficha
Clave=LC.Empresa
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.LC.TieneTasaEsp]
Carpeta=Ficha
Clave=LC.TieneTasaEsp
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.TasaEsp]
Carpeta=Ficha
Clave=LC.TasaEsp
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.Contrato]
Carpeta=Ficha
Clave=LC.Contrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=19
ColorFuente=Negro
Efectos=[Negritas]
ColorFondo=Blanco

[Seguro]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Seguro
Clave=Seguro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LC
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
CarpetaDesActivada=S

[Seguro.LC.SeguroImporte]
Carpeta=Seguro
Clave=LC.SeguroImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Seguro.LC.SeguroImpuestos]
Carpeta=Seguro
Clave=LC.SeguroImpuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Seguro.LC.SeguroAmortizar]
Carpeta=Seguro
Clave=LC.SeguroAmortizar
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Seguro.LC.LineaCredito]
Carpeta=Seguro
Clave=LC.LineaCredito
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Seguro.LC.Descripcion]
Carpeta=Seguro
Clave=LC.Descripcion
Editar=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Seguro.LC.Uso]
Carpeta=Seguro
Clave=LC.Uso
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Seguro.LC.TipoCredito]
Carpeta=Seguro
Clave=LC.TipoCredito
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.LC.ContratoFolio]
Carpeta=Ficha
Clave=LC.ContratoFolio
Editar=S
3D=S
Pegado=N
Tamano=5
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Ficha.LC.CobroIntereses]
Carpeta=Ficha
Clave=LC.CobroIntereses
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.PorcentajeResidual]
Carpeta=Ficha
Clave=LC.PorcentajeResidual
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.LineaMaestra]
Carpeta=Ficha
Clave=LC.LineaMaestra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CtaDinero]
Nombre=CtaDinero
Boton=0
Menu=&Edición
NombreDesplegar=&Cuentas Dinero
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S
Expresion=Si(Forma(<T>LCCtaDinero<T>), Asigna(LC:LC.Importe, SQL(<T>SELECT SUM(Importe) FROM LCCtaDinero WHERE LineaCredito=:tLC<T>, LC:LC.LineaCredito)))
ActivoCondicion=LC:LC.Estatus=EstatusPorConfirmar
AntesExpresiones=Asigna(Info.LineaCredito, LC:LC.LineaCredito)

[Referencias]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Referencias
Clave=Referencias
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LC
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Referencias.LC.Referencia1]
Carpeta=Referencias
Clave=LC.Referencia1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=67
ColorFondo=Blanco
ColorFuente=Negro

[Referencias.LC.Referencia2]
Carpeta=Referencias
Clave=LC.Referencia2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=67
ColorFondo=Blanco
ColorFuente=Negro

[Referencias.LC.Referencia3]
Carpeta=Referencias
Clave=LC.Referencia3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=67
ColorFondo=Blanco
ColorFuente=Negro

[Referencias.LC.LineaCredito]
Carpeta=Referencias
Clave=LC.LineaCredito
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Referencias.LC.Descripcion]
Carpeta=Referencias
Clave=LC.Descripcion
Editar=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Referencias.LC.TipoCredito]
Carpeta=Referencias
Clave=LC.TipoCredito
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Referencias.LC.Uso]
Carpeta=Referencias
Clave=LC.Uso
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Referencias.LC.Fecha1]
Carpeta=Referencias
Clave=LC.Fecha1
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Referencias.LC.ReferenciaOk1]
Carpeta=Referencias
Clave=LC.ReferenciaOk1
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Referencias.LC.Fecha2]
Carpeta=Referencias
Clave=LC.Fecha2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Referencias.LC.ReferenciaOk2]
Carpeta=Referencias
Clave=LC.ReferenciaOk2
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Referencias.LC.Fecha3]
Carpeta=Referencias
Clave=LC.Fecha3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Referencias.LC.ReferenciaOk3]
Carpeta=Referencias
Clave=LC.ReferenciaOk3
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LC.AcreedorSucursal]
Carpeta=Ficha
Clave=LC.AcreedorSucursal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProvSucursal.Nombre]
Carpeta=Ficha
Clave=ProvSucursal.Nombre
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cancelar
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S
NombreEnBoton=S

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Referencias
Referencias=Seguro
Seguro=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Garantia
Garantia=Aval
Aval=Doc
Doc=CtaDinero
CtaDinero=Tareas
Tareas=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Anexos
Anexos=AgregarEvento
AgregarEvento=Bitacora
Bitacora=Informacion
Informacion=LCHist
LCHist=TipoCredito
TipoCredito=DocTipo
DocTipo=GarantiaTipo
GarantiaTipo=CalificacionCartera
CalificacionCartera=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=LC.LineaCredito
LC.LineaCredito=LC.Descripcion
LC.Descripcion=LC.Fecha
LC.Fecha=LC.Uso
LC.Uso=LC.LineaMaestra
LC.LineaMaestra=LC.VigenciaDesde
LC.VigenciaDesde=LC.VigenciaCondicion
LC.VigenciaCondicion=LC.VigenciaHasta
LC.VigenciaHasta=LC.Estatus
LC.Estatus=LC.TipoCredito
LC.TipoCredito=LC.Acreditado
LC.Acreditado=Cte.Nombre
Cte.Nombre=LC.MinistracionHipotecaria
LC.MinistracionHipotecaria=LC.Coacreditado
LC.Coacreditado=CteDestino.Nombre
CteDestino.Nombre=LC.Acreedor
LC.Acreedor=Acreedor.Nombre
Acreedor.Nombre=LC.AcreedorSucursal
LC.AcreedorSucursal=ProvSucursal.Nombre
ProvSucursal.Nombre=LC.Importe
LC.Importe=LC.Moneda
LC.Moneda=LC.DisposicionTipo
LC.DisposicionTipo=LC.Agente
LC.Agente=Agente.Nombre
Agente.Nombre=LC.TipoAmortizacion
LC.TipoAmortizacion=TipoAmortizacion.Descripcion
TipoAmortizacion.Descripcion=LC.CobroIntereses
LC.CobroIntereses=LC.TipoTasa
LC.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=LC.TieneTasaEsp
LC.TieneTasaEsp=LC.TasaEsp
LC.TasaEsp=LC.TipoTasaBonificacion
LC.TipoTasaBonificacion=TipoTasaBonificacion.Descripcion
TipoTasaBonificacion.Descripcion=LC.Condicion
LC.Condicion=LC.DisposicionPlazoMinimo
LC.DisposicionPlazoMinimo=LC.DisposicionPlazoMaximo
LC.DisposicionPlazoMaximo=LC.PeriodosGraciaCapital
LC.PeriodosGraciaCapital=LC.PorcentajeResidual
LC.PorcentajeResidual=LC.Contrato
LC.Contrato=LC.ContratoFolio
LC.ContratoFolio=LC.Empresa
LC.Empresa=LC.Calificacion
LC.Calificacion=LC.Reestructurada
LC.Reestructurada=LC.CarteraVencidaCBNV
LC.CarteraVencidaCBNV=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=CONFIRMAR
CONFIRMAR=RECHAZADO
RECHAZADO=AUTORIZADO
AUTORIZADO=ALTA
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

[Seguro.ListaEnCaptura]
(Inicio)=LC.LineaCredito
LC.LineaCredito=LC.Descripcion
LC.Descripcion=LC.TipoCredito
LC.TipoCredito=LC.Uso
LC.Uso=LC.SeguroImporte
LC.SeguroImporte=LC.SeguroImpuestos
LC.SeguroImpuestos=LC.SeguroAmortizar
LC.SeguroAmortizar=(Fin)

[Referencias.ListaEnCaptura]
(Inicio)=LC.LineaCredito
LC.LineaCredito=LC.Descripcion
LC.Descripcion=LC.TipoCredito
LC.TipoCredito=LC.Uso
LC.Uso=LC.Referencia1
LC.Referencia1=LC.Fecha1
LC.Fecha1=LC.ReferenciaOk1
LC.ReferenciaOk1=LC.Referencia2
LC.Referencia2=LC.Fecha2
LC.Fecha2=LC.ReferenciaOk2
LC.ReferenciaOk2=LC.Referencia3
LC.Referencia3=LC.Fecha3
LC.Fecha3=LC.ReferenciaOk3
LC.ReferenciaOk3=(Fin)
