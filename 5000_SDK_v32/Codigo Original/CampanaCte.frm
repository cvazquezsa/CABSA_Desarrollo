[Forma]
Clave=CampanaCte
Nombre=Cliente
Icono=4
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=654
PosicionInicialArriba=314
PosicionInicialAltura=593
PosicionInicialAncho=611
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSeccion1=7
BarraAyuda=S
MovModulo=CXC
PosicionInicialAlturaCte=589
BarraAyudaBold=S
PosicionInicialAlturaCliente=535
VentanaExclusiva=S
Comentarios=Lista(Info.Clave, Info.Nombre)
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)

[Lista.Cte.Cliente]
Carpeta=Lista
Clave=Cte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Cte=110
Nombre=273
0=268
1=61

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteCampana
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Cte.Cliente=<T>{Info.Clave}<T>

[Ficha.Cte.Cliente]
Carpeta=Ficha
Clave=Cte.Cliente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Cte.Categoria]
Carpeta=Ficha
Clave=Cte.Categoria
Editar=S
ValidaNombre=S
3D=S
Tamano=30
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=66
ColorFuente=Negro
Efectos=[Negritas]
EspacioPrevio=S
ColorFondo=Blanco

[Ficha.Cte.RFC]
Carpeta=Ficha
Clave=Cte.RFC
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Direccion]
Carpeta=Ficha
Clave=Cte.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=54
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.CodigoPostal]
Carpeta=Ficha
Clave=Cte.CodigoPostal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Colonia]
Carpeta=Ficha
Clave=Cte.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Poblacion]
Carpeta=Ficha
Clave=Cte.Poblacion
Editar=S
ValidaNombre=S
3D=S
Tamano=30
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Estado]
Carpeta=Ficha
Clave=Cte.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Pais]
Carpeta=Ficha
Clave=Cte.Pais
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Telefonos]
Carpeta=Ficha
Clave=Cte.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Fax]
Carpeta=Ficha
Clave=Cte.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.PedirTono]
Carpeta=Ficha
Clave=Cte.PedirTono
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Familia]
Carpeta=Ficha
Clave=Cte.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Grupo]
Carpeta=Ficha
Clave=Cte.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=30
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Tipo]
Carpeta=Ficha
Clave=Cte.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=30
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
LineaNueva=S
IgnoraFlujo=S

[Ficha.Cte.EntreCalles]
Carpeta=Ficha
Clave=Cte.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Plano]
Carpeta=Ficha
Clave=Cte.Plano
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Observaciones]
Carpeta=Ficha
Clave=Cte.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Estatus]
Carpeta=Ficha
Clave=Cte.Estatus
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=N

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=CteA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cte<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Cte.Nombre
FiltroPredefinido=S
FiltroGrupo1=Cte.Tipo
FiltroValida1=Cte.Tipo
FiltroGrupo2=SIC.Industria
FiltroValida2=SIC.Industria
FiltroGrupo3=SIC.Giro
FiltroValida3=SIC.Giro
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
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
CarpetaVisible=S
FiltroListasRama=CMP
FiltroListasAplicaEn=Cte.Cliente
ListaAcciones=(Lista)
PestanaOtroNombre=S
PestanaNombre=Ctes
FiltroSituacion=S
FiltroSituacionTodo=S
IconosConPaginas=S
OtroOrden=S
ListaOrden=Cte.Cliente<TAB>(Acendente)
IconosNombre=CteA:Cte.Cliente

[(Carpeta Abrir).Cte.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=106
1=283

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

[Ficha.Cte.Delegacion]
Carpeta=Ficha
Clave=Cte.Delegacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.CURP]
Carpeta=Ficha
Clave=Cte.CURP
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CteCto]
Nombre=CteCto
Boton=60
Menu=&Edición
NombreDesplegar=C&ontactos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteCto
Activo=S
Antes=S
Visible=S
EnBarraHerramientas=S
GuardarAntes=S
EspacioPrevio=S
ConCondicion=S
EjecucionCondicion=ConDatos(CteCampana:Cte.Cliente)
AntesExpresiones=Asigna(Info.Cliente, CteCampana:Cte.Cliente)<BR>Asigna(Info.Nombre, CteCampana:Cte.Nombre)

[Ficha.Cte.DireccionNumero]
Carpeta=Ficha
Clave=Cte.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.TelefonosLada]
Carpeta=Ficha
Clave=Cte.TelefonosLada
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N

[Personal.Cte.Extranjero]
Carpeta=Personal
Clave=Cte.Extranjero
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.Cte.ImportadorRegimen]
Carpeta=Fiscal
Clave=Cte.ImportadorRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.DireccionNumeroInt]
Carpeta=Ficha
Clave=Cte.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios.Cte.Comentarios]
Carpeta=Comentarios
Clave=Cte.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10x10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Agente]
Carpeta=Ficha
Clave=Cte.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
Editar=S
3D=S
Tamano=35
ColorFondo=Plata
ColorFuente=Negro

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
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
EnMenu=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Tareas.Columnas]
0=240
1=65

[Lista.Tarea.Tipo]
Carpeta=Lista
Clave=Tarea.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tarea.Estado]
Carpeta=Lista
Clave=Tarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tarea.Prioridad]
Carpeta=Lista
Clave=Tarea.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tarea.Vencimiento]
Carpeta=Lista
Clave=Tarea.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ListaSeleccionar]
Nombre=ListaSeleccionar
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.ListaEditar]
Nombre=ListaEditar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Editar
EnMenu=S
TipoAccion=Expresion
Expresion=Si<BR>  ConDatos(Tarea:Tarea.ID)<BR>Entonces<BR>  Asigna(Info.TareaID, Tarea:Tarea.ID)<BR>  Si(Forma(<T>TareaEditar<T>),  Forma.ActualizarVista(<T>Lista<T>))<BR>Sino<BR>  Falso<BR>Fin
Activo=S
Visible=S

[Acciones.ListaCompletar]
Nombre=ListaCompletar
Boton=0
NombreDesplegar=&Completar Selección
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=RegistrarSeleccionID(<T>Lista<T>)<BR>EjecutarSQL(<T>spTareasCompletarSeleccion :nEstacion<T>, EstacionTrabajo) <BR>Forma.ActualizarVista(<T>Lista<T>)
ActivoCondicion=Info.PuedeEditar y (no General.PM)

[Acciones.ListaNueva]
Nombre=ListaNueva
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nueva...
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Si(Forma(<T>TareaNueva<T>), Forma.ActualizarVista(<T>Lista<T>))
ActivoCondicion=Info.PuedeEditar y (no General.PM)
Visible=S

[Acciones.ListaQuitar]
Nombre=ListaQuitar
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.ListaPersonalizar]
Nombre=ListaPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.AgregarEvento]
Nombre=AgregarEvento
Boton=56
NombreEnBoton=S
NombreDesplegar=Agregar E&vento
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CampanaEvento
Visible=S
ActivoCondicion=Info.PuedeEditar

[Acciones.Encuesta]
Nombre=Encuesta
Boton=103
NombreEnBoton=S
NombreDesplegar=&Encuesta
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CampanaEncuesta
ActivoCondicion=Info.PuedeEditar
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=CteCto
CteCto=Encuesta
Encuesta=AgregarEvento
AgregarEvento=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Cte.Cliente
Cte.Cliente=Cte.Estatus
Cte.Estatus=Cte.Tipo
Cte.Tipo=Cte.Nombre
Cte.Nombre=Cte.Categoria
Cte.Categoria=Cte.Grupo
Cte.Grupo=Cte.RFC
Cte.RFC=Cte.Familia
Cte.Familia=Cte.CURP
Cte.CURP=Cte.Direccion
Cte.Direccion=Cte.DireccionNumero
Cte.DireccionNumero=Cte.DireccionNumeroInt
Cte.DireccionNumeroInt=Cte.EntreCalles
Cte.EntreCalles=Cte.Plano
Cte.Plano=Cte.Observaciones
Cte.Observaciones=Cte.Delegacion
Cte.Delegacion=Cte.Colonia
Cte.Colonia=Cte.CodigoPostal
Cte.CodigoPostal=Cte.Poblacion
Cte.Poblacion=Cte.Estado
Cte.Estado=Cte.Pais
Cte.Pais=Cte.Telefonos
Cte.Telefonos=Cte.TelefonosLada
Cte.TelefonosLada=Cte.Fax
Cte.Fax=Cte.PedirTono
Cte.PedirTono=Cte.Agente
Cte.Agente=Agente.Nombre
Agente.Nombre=(Fin)

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
