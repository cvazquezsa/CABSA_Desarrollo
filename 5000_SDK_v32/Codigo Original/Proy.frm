[Forma]
Clave=Proy
Nombre=Proyectos
Icono=4
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=(Lista)
PosicionInicialIzquierda=290
PosicionInicialArriba=118
PosicionInicialAltura=330
PosicionInicialAncho=786
ListaAcciones=(Lista)
CarpetaPrincipal=Ficha
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionColumna1=42
PosicionInicialAlturaCliente=433
MovModulo=PROY
BarraAyuda=S
BarraAyudaBold=S
DialogoAbrir=S
Menus=S
Plantillas=S
PermiteCopiarDoc=S

MenuPrincipal=(Lista)
[Proy.Columnas]
Proyecto=100
Descripcion=304
GrupoTrabajo=100

[Lista.Proy.Proyecto]
Carpeta=Lista
Clave=Proy.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Proy.Proyecto]
Carpeta=Detalle
Clave=Proy.Proyecto
Editar=S
3D=S
Tamano=30
Efectos=[Negritas]
LineaNueva=S
ValidaNombre=S

[Detalle.Proy.GrupoTrabajo]
Carpeta=Detalle
Clave=Proy.GrupoTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Lista.Columnas]
Proyecto=288
Descripcion=354
GrupoTrabajo=135
Categoria=136

[Detalle.Proy.Icono]
Carpeta=Detalle
Clave=Proy.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel...
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
Menu=&Archivo
EnMenu=S
ActivoCondicion=Usuario.EnviarExcel

[Acciones.ProyCat]
Nombre=ProyCat
Boton=91
NombreEnBoton=S
NombreDesplegar=&Categorías
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProyCat
Activo=S
Visible=S
Menu=&Maestros
EnMenu=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar...
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S
EspacioPrevio=S
Menu=&Archivo
EnMenu=S

Antes=S
AntesExpresiones=Asigna(Info.Cuenta,Proy:Proy.Proyecto)<BR>EjecutarSQL(<T>spMESCatalogos :tCatalogo, :tINTCuenta, :nEliminar<T>,<T>ProyMES<T>,Info.Cuenta,1)
[Comentarios.Proy.Comentarios]
Carpeta=Comentarios
Clave=Proy.Comentarios
Editar=S
LineaNueva=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Acciones.Contactos]
Nombre=Contactos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Contactos Asignados
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProyD
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
Menu=&Edición
EnMenu=S
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, Proy:Proy.Proyecto)<BR>Asigna(Info.FechaD, Proy:Proy.FechaInicio)<BR>Asigna(Info.FechaA, Proy:Proy.FechaFin)

[PlaneacionPresupuestal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Planeacion Presupuestal
Clave=PlaneacionPresupuestal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=Proy.ClavePresupuestalMascara

CondicionVisible=General.PCP
[PlaneacionPresupuestal.Proy.ClavePresupuestalMascara]
Carpeta=PlaneacionPresupuestal
Clave=Proy.ClavePresupuestalMascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.ClavePresupuestalRegla]
Nombre=ClavePresupuestalRegla
Boton=0
Menu=&Edición
NombreDesplegar=Reglas Claves Presupuestales
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyClavePresupuestalRegla
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Proy:Proy.Proyecto)
VisibleCondicion=General.PCP

[Acciones.ClavePresupuestalTipo]
Nombre=ClavePresupuestalTipo
Boton=0
Menu=&Edición
NombreDesplegar=Tipos de Catálogos de Claves Presupuestales
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ClavePresupuestalCatalogoTipo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Proy:Proy.Proyecto)
VisibleCondicion=General.PCP

[Acciones.Situacion]
Nombre=Situacion
Boton=71
NombreDesplegar=Situación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Visible=S
Menu=&Archivo
EnMenu=S

ActivoCondicion=Usuario.ModificarSituacion
[Acciones.Anexo]
Nombre=Anexo
Boton=77
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AnexoCta50
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
Menu=&Edición
EnMenu=S

EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
AntesExpresiones=Asigna(Info.Rama, <T>PROY<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Proy:Proy.Proyecto)<BR>Asigna(Info.Descripcion, Proy:Proy.Proyecto)
[OtrosDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=OtrosDatos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

[OtrosDatos.Proy.Descripcion1]
Carpeta=OtrosDatos
Clave=Proy.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proy.Descripcion2]
Carpeta=OtrosDatos
Clave=Proy.Descripcion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proy.Descripcion3]
Carpeta=OtrosDatos
Clave=Proy.Descripcion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proy.Descripcion4]
Carpeta=OtrosDatos
Clave=Proy.Descripcion4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proy.Descripcion5]
Carpeta=OtrosDatos
Clave=Proy.Descripcion5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proy.Descripcion6]
Carpeta=OtrosDatos
Clave=Proy.Descripcion6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proy.Descripcion7]
Carpeta=OtrosDatos
Clave=Proy.Descripcion7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proy.Descripcion8]
Carpeta=OtrosDatos
Clave=Proy.Descripcion8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proy.Descripcion9]
Carpeta=OtrosDatos
Clave=Proy.Descripcion9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proy.Descripcion10]
Carpeta=OtrosDatos
Clave=Proy.Descripcion10
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Direccion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Dirección
Clave=Direccion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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

[Direccion.Proy.Direccion]
Carpeta=Direccion
Clave=Proy.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Proy.EntreCalles]
Carpeta=Direccion
Clave=Proy.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Proy.Plano]
Carpeta=Direccion
Clave=Proy.Plano
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Proy.Colonia]
Carpeta=Direccion
Clave=Proy.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Proy.Delegacion]
Carpeta=Direccion
Clave=Proy.Delegacion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Proy.CodigoPostal]
Carpeta=Direccion
Clave=Proy.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Proy.Poblacion]
Carpeta=Direccion
Clave=Proy.Poblacion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Proy.Estado]
Carpeta=Direccion
Clave=Proy.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Proy.Pais]
Carpeta=Direccion
Clave=Proy.Pais
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.EspacioAsignacion]
Nombre=EspacioAsignacion
Boton=47
NombreEnBoton=S
NombreDesplegar=Asignar &Espacio
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EspacioAsignacion
Visible=S
GuardarAntes=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Menu=&Edición
EnMenu=S
ActivoCondicion=General.Espacios y Config.EspaciosAsignacion
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, Proy:Proy.Proyecto)<BR>Asigna(Info.Cliente, Nulo)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=Prop
Activo=S
ConCondicion=S
Antes=S
Visible=S
Menu=&Edición
EnMenu=S
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
AntesExpresiones=Asigna(Info.Rama, <T>PROY<T>)<BR>Asigna(Info.Cuenta, Proy:Proy.Proyecto)<BR>Asigna(Info.Descripcion, Proy:Proy.Descripcion)

[Comentarios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comentarios
Clave=Comentarios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
CarpetaVisible=S
ListaEnCaptura=Proy.Comentarios
AlinearTodaCarpeta=S

[Inicio]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Inicio
Clave=Inicio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=Proy.ComentariosInicio
CarpetaVisible=S
AlinearTodaCarpeta=S

[Inicio.Proy.ComentariosInicio]
Carpeta=Inicio
Clave=Proy.ComentariosInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Fin]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fin
Clave=Fin
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=Proy.ComentariosFin
CarpetaVisible=S
AlinearTodaCarpeta=S

[Fin.Proy.ComentariosFin]
Carpeta=Fin
Clave=Proy.ComentariosFin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S

GuardarAntes=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Cuenta,Proy:Proy.Proyecto)<BR>EjecutarSQL(<T>spMESCatalogos :tCatalogo, :tINTCuenta<T>,<T>ProyMES<T>,Info.Cuenta)
[Acciones.Abrir]
Nombre=Abrir
Boton=2
NombreDesplegar=Abrir...
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
EnMenu=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=ProyA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Proyecto<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Proyectos
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasCampo=Proy.FechaInicio
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ProyCat
FiltroAplicaEn1=Proy.Categoria
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroTodoFinal=S
FiltroNull=S
FiltroArbol=Proyectos
FiltroArbolAplica=Proy.Rama
IconosNombre=ProyA:Proy.Proyecto

[(Carpeta Abrir).Proy.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=Proy.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=138
1=268

2=-2
[Acciones.Informacion]
Nombre=Informacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
Antes=S
Visible=S
EspacioPrevio=S

AntesExpresiones=Asigna(Info.Proyecto, Proy:Proy.Proyecto)
[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F4
NombreDesplegar=Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
UsaTeclaRapida=S
NombreDesplegar=&Tareas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
TeclaRapida=Ctrl+T
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
AntesExpresiones=Asigna(Info.PuedeEditar, Verdadero)<BR>Asigna(Info.Nombre, Proy:Proy.Descripcion)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Proy:Proy.Proyecto)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, Proy:Proy.Proyecto)<BR>Asigna(Info.Nombre, Proy:Proy.Descripcion)<BR>Asigna(Info.Aplica, <T>Proyectos<T>)<BR>Asigna(Info.Nombre2, Nulo)
Visible=S

[(Carpeta Abrir).Proy.Categoria]
Carpeta=(Carpeta Abrir)
Clave=Proy.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ProyPeso]
Nombre=ProyPeso
Boton=0
Menu=&Archivo
NombreDesplegar=Asignar &Pesos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyPeso
Activo=S
Visible=S

[Acciones.Plantillas]
Nombre=Plantillas
Boton=0
Menu=&Maestros
NombreDesplegar=&Plantillas
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyPlan

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Edición
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=EditarDocumentacion(<T>PROY<T>, Proy:Proy.Proyecto, <T>Documentación - <T>+Proy:Proy.Descripcion)
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)

[Cliente]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cliente
Clave=Cliente
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=(Lista)
CondicionVisible=Proy:Proy.ContactoTipo = <T>Cliente<T>

[Cliente.Proy.Cliente]
Carpeta=Cliente
Clave=Proy.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cliente.Cte.Nombre]
Carpeta=Cliente
Clave=Cte.Nombre
Editar=S
3D=S
Pegado=S
Tamano=60
ColorFondo=Plata
ColorFuente=Negro

[Proveedor]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Proveedor
Clave=Proveedor
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=(Lista)
CondicionVisible=Proy:Proy.ContactoTipo = <T>Proveedor<T>

[Proveedor.Proy.Proveedor]
Carpeta=Proveedor
Clave=Proy.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Proveedor.Prov.Nombre]
Carpeta=Proveedor
Clave=Prov.Nombre
Editar=S
3D=S
Pegado=S
Tamano=60
ColorFondo=Plata
ColorFuente=Negro

[Prospecto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Prospecto
Clave=Prospecto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=(Lista)
CondicionVisible=Proy:Proy.ContactoTipo = <T>Prospecto<T>

[Prospecto.Proy.Prospecto]
Carpeta=Prospecto
Clave=Proy.Prospecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prospecto.Prospecto.Nombre]
Carpeta=Prospecto
Clave=Prospecto.Nombre
Editar=S
3D=S
Pegado=S
Tamano=60
ColorFondo=Plata
ColorFuente=Negro

[Agente]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agente
Clave=Agente
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=(Lista)
CondicionVisible=Proy:Proy.ContactoTipo = <T>Agente<T>

[Agente.Proy.Agente]
Carpeta=Agente
Clave=Proy.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agente.Agente.Nombre]
Carpeta=Agente
Clave=Agente.Nombre
Editar=S
3D=S
Pegado=S
Tamano=60
ColorFondo=Plata
ColorFuente=Negro

[Personal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Personal
Clave=Personal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=(Lista)
CondicionVisible=Proy:Proy.ContactoTipo = <T>Personal<T>

[Personal.Proy.Personal]
Carpeta=Personal
Clave=Proy.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Personal.PersonalNombre]
Carpeta=Personal
Clave=PersonalNombre
Editar=S
3D=S
Pegado=S
Tamano=60
ColorFondo=Plata
ColorFuente=Negro

[Riesgo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Riesgo
Clave=Riesgo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=(Lista)
CondicionVisible=Proy:Proy.ContactoTipo = <T>Riesgo<T>

[Riesgo.Proy.Riesgo]
Carpeta=Riesgo
Clave=Proy.Riesgo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[ProyectoRama]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Proyecto
Clave=ProyectoRama
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=(Lista)

CondicionVisible=Proy:Proy.ContactoTipo = <T>Proyecto<T>
[ProyectoRama.Proy.ProyectoRama]
Carpeta=ProyectoRama
Clave=Proy.ProyectoRama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ProyectoRama.ProyectoRama.Descripcion]
Carpeta=ProyectoRama
Clave=ProyectoRama.Descripcion
Editar=S
3D=S
Pegado=S
Tamano=60
ColorFondo=Plata

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.Proy.Proyecto]
Carpeta=Ficha
Clave=Proy.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
Efectos=[Negritas]

[Ficha.Proy.Rama]
Carpeta=Ficha
Clave=Proy.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Ficha.Proy.Descripcion]
Carpeta=Ficha
Clave=Proy.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Ficha.Proy.Observaciones]
Carpeta=Ficha
Clave=Proy.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Ficha.Proy.Categoria]
Carpeta=Ficha
Clave=Proy.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Ficha.Proy.ContactoTipo]
Carpeta=Ficha
Clave=Proy.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Contacto]
Carpeta=Ficha
Clave=Contacto
Editar=S
3D=S
Pegado=S
Tamano=21
ColorFondo=Plata

[Ficha.ContactoNombre]
Carpeta=Ficha
Clave=ContactoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[Ficha.Proy.Presupuesto]
Carpeta=Ficha
Clave=Proy.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Ficha.Proy.FechaInicio]
Carpeta=Ficha
Clave=Proy.FechaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Ficha.Proy.FechaInicioReal]
Carpeta=Ficha
Clave=Proy.FechaInicioReal
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Proy.FechaFin]
Carpeta=Ficha
Clave=Proy.FechaFin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Proy.FechaFinReal]
Carpeta=Ficha
Clave=Proy.FechaFinReal
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Proy.Tipo]
Carpeta=Ficha
Clave=Proy.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Proy.Estatus]
Carpeta=Ficha
Clave=Proy.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Riesgo.aroRiesgo.Nombre]
Carpeta=Riesgo
Clave=aroRiesgo.Nombre
Editar=S
3D=S
Tamano=60
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Resultado]
Nombre=Resultado
Boton=64
Menu=&Ver
NombreDesplegar=&Resultado
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyResultado
Activo=S
Visible=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, Proy:Proy.Proyecto)

[Acciones.CierreMES]
Nombre=CierreMES
Boton=23
Menu=&Edición
NombreDesplegar=Cierre de Proyecto
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Si<BR>  Forma(<T>EspecificarFecha<T>)<BR>Entonces<BR>  Asigna(Proy:Proy.Estatus, <T>CONCLUIDO<T>)<BR>  Asigna(Proy:Proy.FechaFin, Info.Fecha)<BR>  Asigna(Proy:Proy.FechaFinReal, Info.Fecha)<BR>  GuardarCambios<BR>Fin
ActivoCondicion=Proy:Proy.Estatus <> EstatusConcluido

[Acciones.ReaperturaMES]
Nombre=ReaperturaMES
Boton=72
Menu=&Edición
NombreDesplegar=Reapertura Proyecto
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Si<BR>  Forma(<T>EspecificarFecha<T>)<BR>Entonces<BR>  Asigna(Proy:Proy.Estatus, <T>REVISION<T>)<BR>  Asigna(Proy:Proy.FechaFin, Info.Fecha)<BR>  Asigna(Proy:Proy.FechaFinReal, Info.Fecha)<BR>  GuardarCambios<BR>Fin
ActivoCondicion=Proy:Proy.Estatus = EstatusConcluido


[Acciones.MovProy]
Nombre=MovProy
Boton=25
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=Generar &Movimientos...
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovProy
Visible=S
ActivoCondicion=Usuario.ProyMov
ConCondicion=S
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Proy:Proy.Proyecto)<BR>Asigna(Info.Actividad, Nulo)<BR>Asigna(Info.Nombre, Proy:Proy.Descripcion)

[Acciones.Historico]
Nombre=Historico
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
NombreDesplegar=Histórico de Cambios
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Tabla, <T>Proy<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
ConCondicion=S
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Nombre,Proy:Proy.Proyecto & <T> <T> & Proy:Proy.Descripcion)




[OtrosDatos.ListaEnCaptura]
(Inicio)=Proy.Descripcion1
Proy.Descripcion1=Proy.Descripcion2
Proy.Descripcion2=Proy.Descripcion3
Proy.Descripcion3=Proy.Descripcion4
Proy.Descripcion4=Proy.Descripcion5
Proy.Descripcion5=Proy.Descripcion6
Proy.Descripcion6=Proy.Descripcion7
Proy.Descripcion7=Proy.Descripcion8
Proy.Descripcion8=Proy.Descripcion9
Proy.Descripcion9=Proy.Descripcion10
Proy.Descripcion10=(Fin)

[Direccion.ListaEnCaptura]
(Inicio)=Proy.Direccion
Proy.Direccion=Proy.EntreCalles
Proy.EntreCalles=Proy.Plano
Proy.Plano=Proy.Colonia
Proy.Colonia=Proy.Delegacion
Proy.Delegacion=Proy.CodigoPostal
Proy.CodigoPostal=Proy.Poblacion
Proy.Poblacion=Proy.Estado
Proy.Estado=Proy.Pais
Proy.Pais=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Proy.Descripcion
Proy.Descripcion=Proy.Categoria
Proy.Categoria=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=REESTRUCTURADO
REESTRUCTURADO=BAJA
BAJA=(Fin)

[Cliente.ListaEnCaptura]
(Inicio)=Proy.Cliente
Proy.Cliente=Cte.Nombre
Cte.Nombre=(Fin)

[Proveedor.ListaEnCaptura]
(Inicio)=Proy.Proveedor
Proy.Proveedor=Prov.Nombre
Prov.Nombre=(Fin)

[Prospecto.ListaEnCaptura]
(Inicio)=Proy.Prospecto
Proy.Prospecto=Prospecto.Nombre
Prospecto.Nombre=(Fin)

[Agente.ListaEnCaptura]
(Inicio)=Proy.Agente
Proy.Agente=Agente.Nombre
Agente.Nombre=(Fin)

[Personal.ListaEnCaptura]
(Inicio)=Proy.Personal
Proy.Personal=PersonalNombre
PersonalNombre=(Fin)

[Riesgo.ListaEnCaptura]
(Inicio)=Proy.Riesgo
Proy.Riesgo=aroRiesgo.Nombre
aroRiesgo.Nombre=(Fin)


[SituacionCta]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Situaciones por Area
Clave=SituacionCta
Filtros=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=SituacionCta
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosSubTitulo=<T>Area<T>
ListaEnCaptura=(Lista)
IconosNombre=SituacionCta:SituacionCta.Area
FiltroGeneral=SituacionCta.Rama=<T>PROY<T> AND SituacionCta.Cuenta=<T>{Proy:Proy.Proyecto}<T>
CondicionVisible=General.SituacionesPorArea

[SituacionCta.SituacionCta.Situacion]
Carpeta=SituacionCta
Clave=SituacionCta.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[SituacionCta.SituacionCta.SituacionFecha]
Carpeta=SituacionCta
Clave=SituacionCta.SituacionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SituacionCta.SituacionCta.SituacionUsuario]
Carpeta=SituacionCta
Clave=SituacionCta.SituacionUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SituacionCta.SituacionCta.SituacionNota]
Carpeta=SituacionCta
Clave=SituacionCta.SituacionNota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[SituacionCta.ListaEnCaptura]
(Inicio)=SituacionCta.Situacion
SituacionCta.Situacion=SituacionCta.SituacionFecha
SituacionCta.SituacionFecha=SituacionCta.SituacionUsuario
SituacionCta.SituacionUsuario=SituacionCta.SituacionNota
SituacionCta.SituacionNota=(Fin)


[Acciones.PuntoCritico]
Nombre=PuntoCritico
Boton=22
NombreDesplegar=Puntos Críticos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyPuntoCritico
Activo=S
Visible=S
Menu=&Edición
ConCondicion=S
Antes=S
















EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, Proy:Proy.Proyecto)














































































[Ficha.ListaEnCaptura]
(Inicio)=Proy.Proyecto
Proy.Proyecto=Proy.Rama
Proy.Rama=Proy.Descripcion
Proy.Descripcion=Proy.Observaciones
Proy.Observaciones=Proy.Categoria
Proy.Categoria=Proy.ContactoTipo
Proy.ContactoTipo=Contacto
Contacto=ContactoNombre
ContactoNombre=Proy.Presupuesto
Proy.Presupuesto=Proy.FechaInicio
Proy.FechaInicio=Proy.FechaInicioReal
Proy.FechaInicioReal=Proy.FechaFin
Proy.FechaFin=Proy.FechaFinReal
Proy.FechaFinReal=Proy.Tipo
Proy.Tipo=Proy.Estatus
Proy.Estatus=(Fin)

























[ProyectoRama.ListaEnCaptura]
(Inicio)=Proy.ProyectoRama
Proy.ProyectoRama=ProyectoRama.Descripcion
ProyectoRama.Descripcion=(Fin)




























[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Cliente
Cliente=Proveedor
Proveedor=Prospecto
Prospecto=Agente
Agente=Personal
Personal=Riesgo
Riesgo=ProyectoRama
ProyectoRama=Direccion
Direccion=OtrosDatos
OtrosDatos=Inicio
Inicio=Fin
Fin=Comentarios
Comentarios=SituacionCta
SituacionCta=PlaneacionPresupuestal
PlaneacionPresupuestal=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Situacion
Situacion=Eliminar
Eliminar=Excel
Excel=ProyPeso
ProyPeso=MovProy
MovProy=Tareas
Tareas=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Anexo
Anexo=Doc
Doc=PuntoCritico
PuntoCritico=Contactos
Contactos=EspacioAsignacion
EspacioAsignacion=ClavePresupuestalTipo
ClavePresupuestalTipo=ClavePresupuestalRegla
ClavePresupuestalRegla=Plantillas
Plantillas=ProyCat
ProyCat=Informacion
Informacion=Resultado
Resultado=CierreMES
CierreMES=ReaperturaMES
ReaperturaMES=Navegador
Navegador=Cerrar
Cerrar=Historico
Historico=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
