[Forma]
Clave=ExplorarGestion
Nombre=e(<T>Explorando<T>)+<T> - <T>+Info.Mov+<T> <T>+Info.MovID
Icono=4
Modulos=GES
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=419
PosicionInicialArriba=282
PosicionInicialAltura=558
PosicionInicialAncho=1082
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionSeccion1=29
PosicionSeccion2=92
BarraAyuda=S
MovModulo=GES
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=600
PosicionSec1=241
PosicionCol2=519
PosicionSec2=445
VentanaRepetir=S
VentanaEstadoInicial=Normal
ListaAcciones=Cerrar
PosicionCol1=279
EsConsultaExclusiva=S

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Gestion
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=100
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnGestion=Gestion.Mov<BR>Gestion.MovID<BR>Gestion.Proyecto<BR>Gestion.UEN<BR>Gestion.FechaEmision<BR>Gestion.Catalogo<BR>Gestion.Clave<BR>Gestion.Concepto<BR>Gestion.Referencia<BR>Gestion.Observaciones
CarpetaVisible=S
PestanaNombre=Datos Generales
FichaEspacioNombresAuto=S
PestanaOtroNombre=S
Pestana=S
ListaEnCaptura=(Lista)

[Ficha.Gestion.Mov]
Carpeta=Ficha
Clave=Gestion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.MovID]
Carpeta=Ficha
Clave=Gestion.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=12
ColorFondo=Plata
Pegado=S
IgnoraFlujo=N
ColorFuente=Negro

[Ficha.Gestion.FechaEmision]
Carpeta=Ficha
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Proyecto]
Carpeta=Ficha
Clave=Gestion.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
EditarConBloqueo=N

[(Carpeta Abrir).Columnas]
0=169
1=309

[Aplica.Gestion.MovAplica]
Carpeta=Aplica
Clave=Gestion.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Gestion.MovAplicaID]
Carpeta=Aplica
Clave=Gestion.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gestion.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Visible=S
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Visible=S
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.AbrirExcel]
Nombre=AbrirExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Acciones.AbrirCampos]
Nombre=AbrirCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Impuestos]
Carpeta=(Carpeta Totalizadores)
Clave=Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Retención]
Carpeta=(Carpeta Totalizadores)
Clave=Retención
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Columnas]
Aplica=92
AplicaID=64
FechaEmision=128
Reporte=136
Tipo=96
Asunto=232
Socio=83
Titulo=86
Cantidad=49
Precio=101
Costo=85
PrecioTotal=104
CostoTotal=93
Tarima=97
Articulo=106
Unidad=45
Factor=49
Posicion=74
Contenedor=61
CantidadRecogida=94
CantidadEntregada=100
SubCuenta=108
CantidadPendiente=98
AplicaRID=64
PosicionDestino=86
CantidadA=64
Contacto=78
ContactoTipo=75
Nombre=183
Medio=44
Direccion=94
Agente=51
Observaciones=91
Estado=127
Calificacion=58
Organizacion=108
MedioRef=67
Puesto=87
Telefonos=77
eMail=79
Recurso=76
0=124
1=452
VerCampo=297
VerValor=275
Campo=196
Valor=198
ValorAnterior=187
CampoNombre=179
Personal=82
Avance=56

[Ficha.Gestion.UEN]
Carpeta=Ficha
Clave=Gestion.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N
LineaNueva=N
ValidaNombre=N

[Ficha.Gestion.Concepto]
Carpeta=Ficha
Clave=Gestion.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Gestion.Referencia]
Carpeta=Ficha
Clave=Gestion.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Observaciones]
Carpeta=Ficha
Clave=Gestion.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=95
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.Gestion.Contacto]
Carpeta=Contacto
Clave=Gestion.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Contacto.Contacto.NombreCompleto]
Carpeta=Contacto
Clave=Contacto.NombreCompleto
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Cliente]
Carpeta=Contacto
Clave=Gestion.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.Cte.Nombre]
Carpeta=Contacto
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Proveedor]
Carpeta=Contacto
Clave=Gestion.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.Prov.Nombre]
Carpeta=Contacto
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Personal]
Carpeta=Contacto
Clave=Gestion.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.PersonalNombreCompleto]
Carpeta=Contacto
Clave=PersonalNombreCompleto
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Mov]
Carpeta=Contacto
Clave=Gestion.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.MovID]
Carpeta=Contacto
Clave=Gestion.MovID
Editar=N
3D=S
Pegado=N
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Gestion.Proceso]
Carpeta=Contacto
Clave=Gestion.Proceso
Editar=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Tareas.Tarea.Estado]
Carpeta=Tareas
Clave=Tarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Tareas.Tarea.Vencimiento]
Carpeta=Tareas
Clave=Tarea.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Tareas.Tarea.Prioridad]
Carpeta=Tareas
Clave=Tarea.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Tareas.Columnas]
Asunto=474
Estado=93
Vencimiento=105
Prioridad=50
0=387
1=36

[Acciones.TareasImprimir]
Nombre=TareasImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.TareasSeleccionar]
Nombre=TareasSeleccionar
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.TareasQuitar]
Nombre=TareasQuitar
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.TareasPreliminar]
Nombre=TareasPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.TareasExcel]
Nombre=TareasExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.TareasPersonalizar]
Nombre=TareasPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.TareasAbrir]
Nombre=TareasAbrir
Boton=0
NombreDesplegar=&Abrir
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
RefrescarDespues=S
Expresion=Asigna(Info.TareaID, Tarea:Tarea.ID)<BR>Asigna(Info.PuedeEditar, Gestion:Gestion.Estatus=EstatusPendiente)<BR>Forma(<T>TareaEditar<T>)
ConCondicion=S
EjecucionCondicion=ConDatos(Tarea:Tarea.ID)

[Tareas.Tarea.Tipo]
Carpeta=Tareas
Clave=Tarea.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TareasCompletar]
Nombre=TareasCompletar
Boton=0
NombreDesplegar=Completar Selección
EnMenu=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Expresion=RegistrarSeleccionID(<T>Tareas<T>)<BR>EjecutarSQL(<T>spTareasCompletarSeleccion :nEstacion<T>, EstacionTrabajo) <BR>Gestion.ActualizarVista
Activo=S
Visible=S

[Tareas.Tarea.Fase]
Carpeta=Tareas
Clave=Tarea.Fase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Tareas.Tarea.Orden]
Carpeta=Tareas
Clave=Tarea.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.Nombre]
Carpeta=Contacto
Clave=GestionPara.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.Puesto]
Carpeta=Contacto
Clave=GestionPara.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.Organizacion]
Carpeta=Contacto
Clave=GestionPara.Organizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.Telefonos]
Carpeta=Contacto
Clave=GestionPara.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.GestionPara.eMail]
Carpeta=Contacto
Clave=GestionPara.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Observaciones.GestionPara.Observaciones]
Carpeta=Observaciones
Clave=GestionPara.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10x10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.DetallePersonalizar]
Nombre=DetallePersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Detalle.ContactoNombre]
Carpeta=Detalle
Clave=ContactoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.TareaSiguiente]
Carpeta=Detalle
Clave=TareaSiguiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.DetalleCancelar]
Nombre=DetalleCancelar
Boton=0
NombreDesplegar=&Cancelar
EnMenu=S
TipoAccion=Expresion
Activo=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+X
Expresion=Asigna(Info.Nombre, GestionPara:ContactoNombre)<BR>Si<BR>  Dialogo(<T>EstaSeguroFormaCancelar<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spFormaCancelarContacto :nID, :nRID<T>, Gestion:Gestion.ID, GestionPara:GestionPara.RID) <BR>  Gestion.ActualizarVista(<T>Lista<T>) <BR>Fin
VisibleCondicion=Gestion:Gestion.Estatus=EstatusPendiente

[Acciones.DetalleOportunidad]
Nombre=DetalleOportunidad
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=Generar &Oportunidad...
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(Info.Nombre, GestionPara:ContactoNombre)<BR>Si<BR>  Dialogo(<T>EstaSeguroFormaOportunidad<T>)<BR>Entonces<BR>  ProcesarSQL(<T>spFormaGenerarOportunidad :nID, :nRID<T>, Gestion:Gestion.ID, GestionPara:GestionPara.RID)<BR>  Gestion.ActualizarVista(<T>Lista<T>) <BR>Fin
VisibleCondicion=Gestion:Gestion.Estatus=EstatusPendiente

[Acciones.DetalleAbrir]
Nombre=DetalleAbrir
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Abrir
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(Info.PuedeEditar, Gestion:Gestion.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Clave, GestionPara:GestionPara.Contacto)<BR>Asigna(Info.Nombre, GestionPara:ContactoNombre)<BR>Asigna(Info.Mov, Gestion:Gestion.Mov)<BR>Asigna(Info.MovID, Gestion:Gestion.MovID)<BR>Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, GestionPara:GestionPara.RID)<BR>Asigna(Info.Reporte, Nulo)<BR>Caso GestionPara:GestionPara.ContactoTipo<BR>  Es <T>Prospecto<T> Entonces Si(Forma(<T>FormaProspecto<T>), Gestion.ActualizarVista(<T>Lista<T>))<BR>Fin
EjecucionCondicion=ConDatos(GestionPara:GestionPara.Contacto)

[eMail.Gestion.eMailDireccion]
Carpeta=eMail
Clave=Gestion.eMailDireccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco
ColorFuente=Negro

[eMail.Gestion.eMailAsunto]
Carpeta=eMail
Clave=Gestion.eMailAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Catalogo]
Carpeta=Ficha
Clave=Gestion.Catalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Clave]
Carpeta=Ficha
Clave=Gestion.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gestion.Catalogo]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Catalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gestion.Clave]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CampoNombre]
Carpeta=Detalle
Clave=CampoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Plata
ColorFuente=Negro

[Detalle.GestionPara.Aplica]
Carpeta=Detalle
Clave=GestionPara.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.AplicaID]
Carpeta=Detalle
Clave=GestionPara.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Personal]
Carpeta=Detalle
Clave=GestionPara.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Recurso]
Carpeta=Detalle
Clave=GestionPara.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Cantidad]
Carpeta=Detalle
Clave=GestionPara.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Costo]
Carpeta=Detalle
Clave=GestionPara.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Estado]
Carpeta=Detalle
Clave=GestionPara.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GestionPara.Avance]
Carpeta=Detalle
Clave=GestionPara.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Comentarios
Clave=Comentarios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Gestion
Fuente={Tahoma, 10, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Gestion.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S
ConFuenteEspecial=S

[Comentarios.Gestion.Comentarios]
Carpeta=Comentarios
Clave=Gestion.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Asunto]
Carpeta=Ficha
Clave=Gestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=69
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Prioridad]
Carpeta=Ficha
Clave=Gestion.Prioridad
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gestion.Asunto]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Avance]
Carpeta=Ficha
Clave=Gestion.Avance
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Estado]
Carpeta=Ficha
Clave=Gestion.Estado
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=19
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Motivo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Motivo
Clave=Motivo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Gestion
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
ListaEnCaptura=Gestion.Motivo
AlinearTodaCarpeta=S
CondicionVisible=MovTipoEn(<T>GES<T>, Gestion:Gestion.Mov, (GES.NO))

[Motivo.Gestion.Motivo]
Carpeta=Motivo
Clave=Gestion.Motivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro

[Para]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Para
Clave=Para
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=GestionPara
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gestion
LlaveLocal=GestionPara.ID
LlaveMaestra=Gestion.ID
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
CondicionVisible=MovTipoEn(<T>GES<T>, Gestion:Gestion.Mov, (GES.SRES, GES.REU, GES.STAR, GES.OTAR)) o ((MovTipo(<T>GES<T>, Gestion:Gestion.Mov)=GES.MOD) y MovTipoEn(Gestion:Gestion.OrigenTipo, Gestion:Gestion.Origen, (GES.SRES, GES.REU, GES.STAR, GES.OTAR)))

[Para.GestionPara.Usuario]
Carpeta=Para
Clave=GestionPara.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Para.Usuario.Nombre]
Carpeta=Para
Clave=Usuario.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Para.Columnas]
Usuario=96
Nombre=307
GrupoTrabajo=116
Como=61
Requerido=56
EstatusNombre=109
Participacion=78
Respuestas=63
Conteo=84
Referencia=163
Movimiento=163
Respuesta=147
FechaEmision=113
FechaRegistro=113

[Para.GestionPara.Participacion]
Carpeta=Para
Clave=GestionPara.Participacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[SubMovs.Columnas]
0=-2
1=-2

[SubMovimientos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Sub movimientos
Clave=SubMovimientos
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=GestionSub
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gestion
LlaveLocal=Gestion.IDOrigen
LlaveMaestra=Gestion.ID
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
MenuLocal=S
ListaAcciones=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=GestionSub:Gestion.Mov+<T> <T>+GestionSub:Gestion.MovID
FiltroGeneral=Gestion.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>)
CondicionVisible=(Gestion:Gestion.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y (MovTipo(<T>GES<T>, Gestion:Gestion.Mov) en (GES.SRES, GES.REU, GES.STAR, GES.OTAR, GES.TAR))

[SubMovimientos.Gestion.FechaEmision]
Carpeta=SubMovimientos
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[SubMovimientos.Gestion.Asunto]
Carpeta=SubMovimientos
Clave=Gestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[SubMovimientos.Columnas]
0=180
1=93

[(Carpeta Abrir).Gestion.Estado]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gestion.Avance]
Carpeta=(Carpeta Abrir)
Clave=Gestion.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Reunion.Gestion.Asunto]
Carpeta=Reunion
Clave=Gestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=90
ColorFondo=Blanco
ColorFuente=Negro

[Reunion.Gestion.Ubicacion]
Carpeta=Reunion
Clave=Gestion.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=90
ColorFondo=Blanco
ColorFuente=Negro

[Reunion.Gestion.FechaD]
Carpeta=Reunion
Clave=Gestion.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Reunion.Gestion.FechaA]
Carpeta=Reunion
Clave=Gestion.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Reunion.Gestion.TodoElDia]
Carpeta=Reunion
Clave=Gestion.TodoElDia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Ficha.Gestion.FechaD]
Carpeta=Ficha
Clave=Gestion.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.FechaA]
Carpeta=Ficha
Clave=Gestion.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Ficha.Gestion.TodoElDia]
Carpeta=Ficha
Clave=Gestion.TodoElDia
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gestion.FechaA]
Carpeta=(Carpeta Abrir)
Clave=Gestion.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.Columnas]
Recurso=64
Personal=64
Referencia=124
Fecha=73
HoraD=57
HoraA=53
Cantidad=48
Costo=55
CostoTotal=68
Nombre=163
Horas=64

[Recursos]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Recursos
Clave=Recursos
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=GestionRecurso
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gestion
LlaveLocal=GestionRecurso.ID
LlaveMaestra=Gestion.ID
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
CondicionVisible=MovTipoEn(<T>GES<T>, Gestion:Gestion.Mov, (GES.AV, GES.TE))

[Recursos.GestionRecurso.Recurso]
Carpeta=Recursos
Clave=GestionRecurso.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Gris

[Recursos.GestionRecurso.Referencia]
Carpeta=Recursos
Clave=GestionRecurso.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.GestionRecurso.Fecha]
Carpeta=Recursos
Clave=GestionRecurso.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.GestionRecurso.HoraD]
Carpeta=Recursos
Clave=GestionRecurso.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.GestionRecurso.HoraA]
Carpeta=Recursos
Clave=GestionRecurso.HoraA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.CostoTotal]
Carpeta=Recursos
Clave=CostoTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.Gestion.HoraD]
Carpeta=Ficha
Clave=Gestion.HoraD
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.HoraA]
Carpeta=Ficha
Clave=Gestion.HoraA
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.SubMovPersonalizar]
Nombre=SubMovPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=SubMovimientos
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.SubMovPreliminar]
Nombre=SubMovPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=SubMovimientos
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Recursos.Recurso.Nombre]
Carpeta=Recursos
Clave=Recurso.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Para.Respuesta]
Carpeta=Para
Clave=Respuesta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Para.Gestion.FechaRegistro]
Carpeta=Para
Clave=Gestion.FechaRegistro
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[SubMovimientos.Gestion.Motivo]
Carpeta=SubMovimientos
Clave=Gestion.Motivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.OrigenNombre]
Carpeta=Ficha
Clave=OrigenNombre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

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

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=Gestion
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
IconosSubTitulo=<T>Movimiento<T>
FiltroPredefinido=S
FiltroArbolClave=Gestion.MovID
FiltroArbolValidar=Gestion.MovID
FiltroArbolRama=Gestion.MovID
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=Gestion.FechaEmision
PermiteLocalizar=S
OtroOrden=S
ListaOrden=Orden<TAB>(Acendente)
MenuLocal=S
ListaAcciones=ListaPersonalizar

IconosNombre=Gestion:Gestion.Mov+<T> <T>+Gestion:Gestion.MovID
FiltroGeneral=Gestion.ID={Info.ID} OR (Gestion.RamaID={Info.ID} AND Gestion.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>))
[Lista.Columnas]
0=161
1=-2

[Lista.Gestion.FechaEmision]
Carpeta=Lista
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.ListaPersonalizar]
Nombre=ListaPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Recursos.GestionRecurso.Costo]
Carpeta=Recursos
Clave=GestionRecurso.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gestion.Espacio]
Carpeta=Ficha
Clave=Gestion.Espacio
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Recursos.GestionRecurso.Cantidad]
Carpeta=Recursos
Clave=GestionRecurso.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


[Ficha.ListaEnCaptura]
(Inicio)=Gestion.Mov
Gestion.Mov=Gestion.MovID
Gestion.MovID=Gestion.Proyecto
Gestion.Proyecto=Gestion.UEN
Gestion.UEN=Gestion.Prioridad
Gestion.Prioridad=Gestion.FechaEmision
Gestion.FechaEmision=OrigenNombre
OrigenNombre=Gestion.Asunto
Gestion.Asunto=Gestion.Espacio
Gestion.Espacio=Gestion.FechaD
Gestion.FechaD=Gestion.TodoElDia
Gestion.TodoElDia=Gestion.HoraD
Gestion.HoraD=Gestion.HoraA
Gestion.HoraA=Gestion.FechaA
Gestion.FechaA=Gestion.Estado
Gestion.Estado=Gestion.Avance
Gestion.Avance=Gestion.Concepto
Gestion.Concepto=Gestion.Referencia
Gestion.Referencia=Gestion.Observaciones
Gestion.Observaciones=(Fin)

[Para.ListaEnCaptura]
(Inicio)=GestionPara.Usuario
GestionPara.Usuario=Usuario.Nombre
Usuario.Nombre=GestionPara.Participacion
GestionPara.Participacion=Respuesta
Respuesta=Gestion.FechaRegistro
Gestion.FechaRegistro=(Fin)

[SubMovimientos.ListaEnCaptura]
(Inicio)=Gestion.FechaEmision
Gestion.FechaEmision=Gestion.Asunto
Gestion.Asunto=Gestion.Motivo
Gestion.Motivo=(Fin)

[SubMovimientos.ListaAcciones]
(Inicio)=SubMovPreliminar
SubMovPreliminar=SubMovPersonalizar
SubMovPersonalizar=(Fin)

[Recursos.ListaEnCaptura]
(Inicio)=GestionRecurso.Recurso
GestionRecurso.Recurso=Recurso.Nombre
Recurso.Nombre=GestionRecurso.Fecha
GestionRecurso.Fecha=GestionRecurso.HoraD
GestionRecurso.HoraD=GestionRecurso.HoraA
GestionRecurso.HoraA=GestionRecurso.Cantidad
GestionRecurso.Cantidad=GestionRecurso.Costo
GestionRecurso.Costo=CostoTotal
CostoTotal=GestionRecurso.Referencia
GestionRecurso.Referencia=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Para
Para=Motivo
Motivo=Recursos
Recursos=SubMovimientos
SubMovimientos=Comentarios
Comentarios=(Fin)
