[Forma]
Clave=CteHD
Nombre=Help Desk
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=106
PosicionInicialArriba=95
PosicionInicialAlturaCliente=543
PosicionInicialAncho=811
EsConsultaExclusiva=S
PosicionSeccion1=19
PosicionColumna1=50
PosicionColumna2=54
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteA
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=Cte.Cliente=<T>{Info.Cliente}<T>
FiltroRespetar=S
FiltroTipo=General

[Ficha.Cte.Cliente]
Carpeta=Ficha
Clave=Cte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=44
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Cte.Telefonos]
Carpeta=Ficha
Clave=Cte.Telefonos
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Contacto1]
Carpeta=Ficha
Clave=Cte.Contacto1
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Contacto2]
Carpeta=Ficha
Clave=Cte.Contacto2
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.eMail1]
Carpeta=Ficha
Clave=Cte.eMail1
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.eMail2]
Carpeta=Ficha
Clave=Cte.eMail2
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Soporte]
Estilo=Iconos
Clave=Soporte
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=SoporteA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Soporte.FechaEmision
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasCancelacion=Soporte.FechaCancelacion
FiltroFechasNombre=&Fecha
ListaEnCaptura=Soporte.Titulo
MenuLocal=S
IconosNombre=SoporteA:Soporte.Mov+<T> <T>+SoporteA:Soporte.MovID
FiltroGeneral=Soporte.Empresa=<T>{Empresa}<T> AND Soporte.Cliente=<T>{Info.Cliente}<T>
ListaAcciones=(Lista)

[Soporte.Columnas]
0=135
1=269

[Tarea]
Estilo=Iconos
Clave=Tarea
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=Tarea
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Asunto<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Tareas
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Tarea.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
ListaEnCaptura=Tarea.Vencimiento
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=TareaEstado
FiltroAutoOrden=TareaEstado.Orden
FiltroAplicaEn=Tarea.Estado
FiltroEstilo=Folder (1 línea)
MenuLocal=S
ListaAcciones=TareaEditar
IconosNombre=Tarea:Tarea.Asunto
FiltroGeneral=Tarea.Empresa=<T>{Empresa}<T> AND Tarea.Cliente=<T>{Info.Cliente}<T>

[Tarea.Columnas]
0=164
1=141

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

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteInfo
Visible=S
ActivoCondicion=ConDatos(Info.Cliente)

[Acciones.MovCte]
Nombre=MovCte
Boton=25
NombreDesplegar=Generar &Movimientos...
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovCte
Antes=S
Visible=S
NombreEnBoton=S
ActivoCondicion=Usuario.CteMov y ConDatos(Info.Cliente)
AntesExpresiones=Asigna(Info.Cliente, CteA:Cte.Cliente)<BR>Asigna(Info.Nombre, CteA:Cte.Nombre)

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

[Tarea.Tarea.Vencimiento]
Carpeta=Tarea
Clave=Tarea.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TareaEditar]
Nombre=TareaEditar
Boton=0
NombreDesplegar=&Editar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Si<BR>  ConDatos(Tarea:Tarea.ID)<BR>Entonces<BR>  Asigna(Info.TareaID, Tarea:Tarea.ID)<BR>  Forma(<T>TareaEditar<T>)<BR>Sino<BR>  Falso<BR>Fin

[Acciones.Tarea]
Nombre=Tarea
Boton=70
NombreEnBoton=S
NombreDesplegar=Generar &Tarea...
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
ConCondicion=S
Visible=S
ActivoCondicion=ConDatos(Info.Cliente)
EjecucionCondicion=Forma(<T>TareaNueva<T>)

[Acciones.Cliente]
Nombre=Cliente
Boton=2
NombreEnBoton=S
NombreDesplegar=&Cliente...
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=Forma(<T>EspecificarCliente<T>)

[Acciones.CteTel]
Nombre=CteTel
Boton=17
NombreDesplegar=Otros Teléfonos...
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteTel
Visible=S
NombreEnBoton=S
ActivoCondicion=ConDatos(Info.Cliente)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, SoporteA:Soporte.ID)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Soporte
Soporte=Tarea
Tarea=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Cliente
Cliente=CteInfo
CteInfo=MovCte
MovCte=Tarea
Tarea=CteTel
CteTel=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Cte.Cliente
Cte.Cliente=Cte.Nombre
Cte.Nombre=Cte.Telefonos
Cte.Telefonos=Cte.Contacto1
Cte.Contacto1=Cte.eMail1
Cte.eMail1=Cte.Contacto2
Cte.Contacto2=Cte.eMail2
Cte.eMail2=(Fin)

[Soporte.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[Soporte.ListaAcciones]
(Inicio)=Propiedades
Propiedades=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)
