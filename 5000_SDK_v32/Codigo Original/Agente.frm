[Forma]
Clave=Agente
Nombre=<T>Agentes<T>
Icono=4
Modulos=(Lista)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=477
PosicionInicialArriba=222
PosicionInicialAltura=403
PosicionInicialAncho=653
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaSinIcono=S
PosicionSeccion1=33
PosicionSeccion2=66
Menus=S
BarraAyuda=S
DialogoAbrir=S
Plantillas=S
PermiteCopiarDoc=S
PlantillasExcepciones=(Lista)
PosicionInicialAlturaCliente=476
PosicionSec1=238

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Tipo,<T>Agente<T>)
MenuPrincipal=(Lista)
[Lista.Agente.Agente]
Carpeta=Lista
Clave=Agente.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Agente=100
Nombre=304
Fecha=148
Usuario=82
Sucursal=64
Nombre_1=154
Empresa=69

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Agente
Fuente={MS Sans Serif, 8, Negro, []}
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

[Detalle.Agente.Agente]
Carpeta=Detalle
Clave=Agente.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Agente.Nombre]
Carpeta=Detalle
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[Detalle.Agente.Categoria]
Carpeta=Detalle
Clave=Agente.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
EspacioPrevio=S
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=S
Activo=S
Menu=&Archivo
UsaTeclaRapida=S
EnMenu=S
TeclaRapida=Ctrl+N

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
Menu=&Archivo
EnMenu=S
EspacioPrevio=S

ActivoCondicion=no Agente:Agente.TieneMovimientos
ConCondicion=S
EjecucionCondicion=Forma.ActualizarVista<BR>Forma.ActualizarControles<BR>Si<BR> Agente:Agente.TieneMovimientos<BR>Entonces<BR>  Error(<T>El agente ya tiene movimientos activos<T> , BotonAceptar  )<BR>Fin
[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Visible=S
Activo=S

[Lista.Agente.Nombre]
Carpeta=Lista
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=Prop
Activo=S
Antes=S
Visible=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F11
EnMenu=S
ConCondicion=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Rama, <T>AGENT<T>)<BR>Asigna(Info.Cuenta,Agente:Agente.Agente)<BR>Asigna(Info.Descripcion, Agente:Agente.Nombre)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Detalle.Agente.Grupo]
Carpeta=Detalle
Clave=Agente.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tareas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Visible=S
ConCondicion=S
Antes=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.PuedeEditar, Verdadero)<BR>Asigna(Info.Nombre, Agente:Agente.Nombre)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Agente:Agente.Agente)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Otros]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros datos
Clave=Otros
PermiteEditar=S
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

[Otros.Agente.Agente]
Carpeta=Otros
Clave=Agente.Agente
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Otros.Agente.Nombre]
Carpeta=Otros
Clave=Agente.Nombre
3D=S
Tamano=55
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Otros.Agente.CostoHora]
Carpeta=Otros
Clave=Agente.CostoHora
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Otros.Agente.Mensaje]
Carpeta=Otros
Clave=Agente.Mensaje
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Direccion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Personales
Clave=Direccion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Agente
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=111
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
PermiteEditar=S

CondicionVisible=no Agente:Agente.Equipo
[Direccion.Agente.Direccion]
Carpeta=Direccion
Clave=Agente.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
EspacioPrevio=S

[Direccion.Agente.Colonia]
Carpeta=Direccion
Clave=Agente.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Direccion.Agente.CodigoPostal]
Carpeta=Direccion
Clave=Agente.CodigoPostal
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Direccion.Agente.Poblacion]
Carpeta=Direccion
Clave=Agente.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Direccion.Agente.Estado]
Carpeta=Direccion
Clave=Agente.Estado
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Direccion.Agente.Pais]
Carpeta=Direccion
Clave=Agente.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Direccion.Agente.RFC]
Carpeta=Direccion
Clave=Agente.RFC
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=N

[Direccion.Agente.Agente]
Carpeta=Direccion
Clave=Agente.Agente
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]

[Direccion.Agente.Nombre]
Carpeta=Direccion
Clave=Agente.Nombre
ValidaNombre=N
3D=S
Tamano=55
ColorFondo=Plata
Efectos=[Negritas]

[Detalle.Agente.Personal]
Carpeta=Detalle
Clave=Agente.Personal
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
EspacioPrevio=N
Tamano=35
ColorFondo=Blanco
Pegado=S

[Detalle.NombreCompleto]
Carpeta=Detalle
Clave=NombreCompleto
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata

[Direccion.Agente.Telefonos]
Carpeta=Direccion
Clave=Agente.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Blanco

[Direccion.Agente.Extencion]
Carpeta=Direccion
Clave=Agente.Extencion
Editar=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco

[Detalle.Agente.TipoComision]
Carpeta=Detalle
Clave=Agente.TipoComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco
Pegado=N
EspacioPrevio=S

[Detalle.Agente.Porcentaje]
Carpeta=Detalle
Clave=Agente.Porcentaje
Editar=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
Pegado=S
LineaNueva=N
EspacioPrevio=N

[Detalle.Agente.Nomina]
Carpeta=Detalle
Clave=Agente.Nomina
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=11
ColorFondo=Blanco

[Direccion.Agente.BeneficiarioNombre]
Carpeta=Direccion
Clave=Agente.BeneficiarioNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=55
ColorFondo=Blanco

[Detalle.Agente.NominaMov]
Carpeta=Detalle
Clave=Agente.NominaMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

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
Visible=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Rama, <T>AGENT<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Agente:Agente.Agente)<BR>Asigna(Info.Descripcion, Agente:Agente.Nombre)
DespuesGuardar=S
RefrescarDespues=S

[Acciones.Informacion]
Nombre=Informacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AgenteInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)

[Acciones.Clientes]
Nombre=Clientes
Boton=0
Menu=&Edición
NombreDesplegar=&Clientes del Agente
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AgenteCte
Activo=S
Antes=S
ConCondicion=S
Visible=S

EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)<BR>Asigna(Info.Nombre, Agente:Agente.Nombre)

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Edición
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=EditarDocumentacion(<T>AGENT<T>, Agente:Agente.Agente, <T>Documentación - <T>+Agente:Agente.Nombre)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Visible=S

[Acciones.AgenteCat]
Nombre=AgenteCat
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteCat
Activo=S
Visible=S

[Acciones.AgenteGrupo]
Nombre=AgenteGrupo
Boton=0
Menu=&Maestros
NombreDesplegar=&Grupos
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteGrupo
Activo=S
Visible=S

[Detalle.Agente.Estatus]
Carpeta=Detalle
Clave=Agente.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Agentes
Clave=(Carpeta Abrir)
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=AgenteA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Agente<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Agente.Nombre
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=AgenteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=AgenteGrupo
FiltroAplicaEn1=Agente.Categoria
FiltroAplicaEn2=Agente.Grupo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ListaAcciones=(Lista)
FiltroTodo=S
FiltroTodoFinal=S
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=AgenteTipo
FiltroAplicaEn3=Agente.Tipo
IconosNombre=AgenteA:Agente.Agente
FiltroSucursales=S

[(Carpeta Abrir).Agente.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=&Presentación preliminar
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

[(Carpeta Abrir).Columnas]
0=114
1=332

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

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

[Direccion.Agente.CURP]
Carpeta=Direccion
Clave=Agente.CURP
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
Pegado=S

[Detalle.Agente.Tipo]
Carpeta=Detalle
Clave=Agente.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]

[Acciones.AgentePersonal]
Nombre=AgentePersonal
Boton=0
Menu=&Edición
NombreDesplegar=&Personal Asignado
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgentePersonal
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)
Visible=S

[Detalle.Agente.SucursalEmpresa]
Carpeta=Detalle
Clave=Agente.SucursalEmpresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=8

[Detalle.Sucursal.Nombre]
Carpeta=Detalle
Clave=Sucursal.Nombre
Editar=S
3D=S
Tamano=27
ColorFondo=Plata
Pegado=S

[Direccion.Agente.Zona]
Carpeta=Direccion
Clave=Agente.Zona
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Detalle.Agente.NominaConcepto]
Carpeta=Detalle
Clave=Agente.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[Detalle.Agente.Equipo]
Carpeta=Detalle
Clave=Agente.Equipo
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Acciones.EquipoAgente]
Nombre=EquipoAgente
Boton=80
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=&Equipo
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EquipoAgente
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Agente:Agente.Equipo
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)<BR>Asigna(Info.Nombre, Agente:Agente.Nombre)

[Acciones.Cubos]
Nombre=Cubos
Boton=100
Menu=&Ver
NombreDesplegar=Cubos
EnBarraHerramientas=S
EnMenu=S
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
Menu=&Edición
NombreDesplegar=E&valuaciones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EvaluacionCalificacion
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, Agente:Agente.Agente)<BR>Asigna(Info.Nombre, Agente:Agente.Nombre)<BR>Asigna(Info.Aplica, <T>Agentes<T>)<BR>Asigna(Info.Nombre2, Nulo)
Visible=S

[Detalle.Agente.Cuota]
Carpeta=Detalle
Clave=Agente.Cuota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[Otros.Agente.ArticuloDef]
Carpeta=Otros
Clave=Agente.ArticuloDef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Otros.Art.Descripcion1]
Carpeta=Otros
Clave=Art.Descripcion1
Editar=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Plata
ColorFuente=Negro

[Direccion.Agente.Acreedor]
Carpeta=Direccion
Clave=Agente.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=23
ColorFondo=Blanco

[Direccion.Acreedor.Nombre]
Carpeta=Direccion
Clave=Acreedor.Nombre
Editar=S
3D=S
Tamano=31
ColorFondo=Plata

[Direccion.Agente.eMail]
Carpeta=Direccion
Clave=Agente.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=55
ColorFondo=Blanco

[Direccion.Agente.eMailAuto]
Carpeta=Direccion
Clave=Agente.eMailAuto
Editar=S
LineaNueva=S
3D=S
Tamano=55
ColorFondo=Blanco

[Otros.Agente.VentasCasa]
Carpeta=Otros
Clave=Agente.VentasCasa
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AgenteFam]
Nombre=AgenteFam
Boton=0
Menu=&Maestros
NombreDesplegar=&Familias
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteFam
Activo=S
Visible=S

[Detalle.Agente.Familia]
Carpeta=Detalle
Clave=Agente.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[Otros.Agente.Alta]
Carpeta=Otros
Clave=Agente.Alta
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Otros.Agente.Baja]
Carpeta=Otros
Clave=Agente.Baja
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Otros.Agente.ReportaA]
Carpeta=Otros
Clave=Agente.ReportaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Otros.AgenteDestino.Nombre]
Carpeta=Otros
Clave=AgenteDestino.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Politica]
Nombre=Politica
Boton=22
Menu=&Edición
NombreDesplegar=Política
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Politica
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+O
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Rama, <T>AGTE<T>)<BR>Asigna(Info.Clave, Agente:Agente.Agente)

[Acciones.TipoComision]
Nombre=TipoComision
Boton=0
Menu=&Edición
NombreDesplegar=&Tipo Comisión
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteComisionTipoFactura
Activo=S
GuardarAntes=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)
DespuesGuardar=S
VisibleCondicion=Agente:Agente.TipoComision=<T>por Tipo Factura<T>

[Otros.Agente.AlmacenDef]
Carpeta=Otros
Clave=Agente.AlmacenDef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.RefCta]
Nombre=RefCta
Boton=110
Menu=&Edición
NombreDesplegar=Referencias
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=RefCta
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>AGENT<T>)<BR>Asigna(Info.Cuenta, Agente:Agente.Agente)<BR>Asigna(Info.Nombre, Agente:Agente.Nombre)
Visible=S

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Forma, <T>Agente<T>)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Nombre, <T>Agentes<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=104
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
EspacioPrevio=S
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasContacto(<T>Agente<T>, Agente:Agente.Tipo, Agente:Agente.Agente)<BR>Sino<BR>  Asigna(Info.Aplica, <T>Agente<T>)<BR>  Asigna(Info.Clave, Agente:Agente.Agente)<BR>  Asigna(Info.Nombre, Agente:Agente.Nombre)<BR>  Asigna(Info.Modulo, Nulo)<BR>  Asigna(Info.Mov, Nulo)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Agente:Agente.Grupo)<BR>  Asigna(Info.Familia, Agente:Agente.Familia)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si(ConDatos(Info.FormaTipo), iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre), Informacion(<T>No Tiene Definida Ninguna Forma<T>))<BR>Fin
EjecucionCondicion=ConDatos(Agente:Agente.Agente)

[Acciones.Mensajes]
Nombre=Mensajes
Boton=112
Menu=&Ver
NombreDesplegar=&Mensajes
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=OutlookAgente
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)
Visible=S

[Detalle.Agente.Jornada]
Carpeta=Detalle
Clave=Agente.Jornada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[Acciones.Actividades]
Nombre=Actividades
Boton=0
Menu=&Edición
NombreDesplegar=Actividades
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteActividad
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+K
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Características
Clave=FormaExtraValor
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraValor
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
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
RefrescarAlEntrar=S
PermiteEditar=S

FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleAgente(<T>{Agente:Agente.Categoria}<T>, <T>{Agente:Agente.Grupo}<T>, <T>{Agente:Agente.Familia}<T>)) AND FormaExtraValor.Aplica=<T>Agente<T> AND FormaExtraValor.AplicaClave=<T>{Agente:Agente.Agente}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>
[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
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

[FormaExtraValor.Columnas]
VerCampo=278
VerValor=318

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
ConCondicion=S
Antes=S
Expresion=Asigna(Info.Tabla, <T>Agente<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Nombre, Agente:Agente.Agente & <T> <T> & Agente:Agente.Nombre)

[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285





[Otros.ListaEnCaptura]
(Inicio)=Agente.Agente
Agente.Agente=Agente.Nombre
Agente.Nombre=Agente.ReportaA
Agente.ReportaA=AgenteDestino.Nombre
AgenteDestino.Nombre=Agente.CostoHora
Agente.CostoHora=Agente.Mensaje
Agente.Mensaje=Agente.ArticuloDef
Agente.ArticuloDef=Art.Descripcion1
Art.Descripcion1=Agente.AlmacenDef
Agente.AlmacenDef=Agente.Alta
Agente.Alta=Agente.Baja
Agente.Baja=Agente.VentasCasa
Agente.VentasCasa=(Fin)


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




[Direccion.Agente.DireccionNumero]
Carpeta=Direccion
Clave=Agente.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Direccion.Agente.DireccionNumeroInt]
Carpeta=Direccion
Clave=Agente.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco





















[Acciones.Mapa]
Nombre=Mapa
Boton=105
Menu=&Ver
NombreDesplegar=&Mapa
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Mapa.Borrar<BR>Mapa.Agregar(<T>Agente<T>, Agente:Agente.Agente)<BR>PlugIn(<T>Mapa<T>, <T>Agente<T>, <T>Posicionar<T>)
































[Emida]
Estilo=Ficha
Pestana=S
Clave=Emida
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Agente
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Agente.ClerkID

PestanaOtroNombre=S
PestanaNombre=Emida
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CondicionVisible=General.InterfazEmida
[Emida.Agente.ClerkID]
Carpeta=Emida
Clave=Agente.ClerkID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco





















[Acciones.Zonas]
Nombre=Zonas
Boton=0
Menu=&Edición
NombreDesplegar=Zonas
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteZona
Activo=S
Antes=S
DespuesGuardar=S

















AntesExpresiones=Asigna(Info.Agente,Agente:Agente.Agente)<BR>Asigna(Info.Nombre,Agente:Agente.Nombre)
VisibleCondicion=General.WMS













[CRM.ListaEnCaptura]
(Inicio)=Agente.DomainName
Agente.DomainName=(Fin)






[CRM]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=CRM
Clave=CRM
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Agente
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
ListaEnCaptura=Agente.DomainName
CarpetaVisible=S

[CRM.Agente.DomainName]
Carpeta=CRM
Clave=Agente.DomainName
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

















[Acciones.EmidaTerminalIDCfg]
Nombre=EmidaTerminalIDCfg
Boton=16
NombreDesplegar=Emida - Terminales
EnBarraHerramientas=S
Activo=S





EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmidaAgenteTerminalCfg
Antes=S




























































AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)
VisibleCondicion=General.InterfazEmida y(fnEmidaNivelCfgSiteID(Empresa) = <T>Agente<T>)








































[Acciones.TCTerminalAgenteCfg]
Nombre=TCTerminalAgenteCfg
Boton=46
NombreDesplegar=Tarjetas Bancarias - PinPad
EnBarraHerramientas=S
Activo=S





EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TCTerminalAgenteCfg
Antes=S






























































































AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)
VisibleCondicion=General.InterfazTC y(fnTCNivelCfgPinPad(Empresa) = <T>Agente<T>)












[Acciones.Articulos]
Nombre=Articulos
Boton=0
Menu=&Edición
NombreDesplegar=&Artículos del Agente
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteArt
Activo=S
Visible=S





GuardarAntes=S
Antes=S

DespuesGuardar=S
















ConCondicion=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)






























































[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden	(Acendente)
GrupoOrden	(Acendente)=FormaExtraCampo.Orden	(Acendente)
FormaExtraCampo.Orden	(Acendente)=(Fin)




































[WMS]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
Clave=WMS
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Agente
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

PestanaNombre=WMS
PermiteEditar=S















ListaEnCaptura=Agente.TMAPrefijo
CondicionVisible=General.WMS
[Detalle.ListaEnCaptura]
(Inicio)=Agente.Agente
Agente.Agente=Agente.Tipo
Agente.Tipo=Agente.Nombre
Agente.Nombre=Agente.Estatus
Agente.Estatus=Agente.SucursalEmpresa
Agente.SucursalEmpresa=Sucursal.Nombre
Sucursal.Nombre=Agente.Categoria
Agente.Categoria=Agente.Grupo
Agente.Grupo=Agente.Familia
Agente.Familia=Agente.TipoComision
Agente.TipoComision=Agente.Porcentaje
Agente.Porcentaje=Agente.Cuota
Agente.Cuota=Agente.Nomina
Agente.Nomina=Agente.Personal
Agente.Personal=NombreCompleto
NombreCompleto=Agente.NominaMov
Agente.NominaMov=Agente.NominaConcepto
Agente.NominaConcepto=Agente.Jornada
Agente.Jornada=Agente.Equipo
Agente.Equipo=(Fin)






[WMS.Agente.TMAPrefijo]
Carpeta=WMS
Clave=Agente.TMAPrefijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco







































































[Acciones.Objetivos]
Nombre=Objetivos
Boton=0
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Objetivos
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteObjetivos
Activo=S
ConCondicion=S
Antes=S
Visible=S
















GuardarAntes=S
EjecucionCondicion=ConDatos(Agente:Agente.Agente)
AntesExpresiones=Asigna(Info.Agente, Agente:Agente.Agente)<BR>Asigna(Info.Nombre, Agente:Agente.Nombre)




































[Direccion.Agente.MapaUbicacion]
Carpeta=Direccion
Clave=Agente.MapaUbicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco












[Direccion.ListaEnCaptura]
(Inicio)=Agente.Agente
Agente.Agente=Agente.Nombre
Agente.Nombre=Agente.Telefonos
Agente.Telefonos=Agente.Extencion
Agente.Extencion=Agente.Direccion
Agente.Direccion=Agente.DireccionNumero
Agente.DireccionNumero=Agente.DireccionNumeroInt
Agente.DireccionNumeroInt=Agente.Colonia
Agente.Colonia=Agente.CodigoPostal
Agente.CodigoPostal=Agente.Poblacion
Agente.Poblacion=Agente.Estado
Agente.Estado=Agente.Pais
Agente.Pais=Agente.Zona
Agente.Zona=Agente.MapaUbicacion
Agente.MapaUbicacion=Agente.Acreedor
Agente.Acreedor=Acreedor.Nombre
Acreedor.Nombre=Agente.BeneficiarioNombre
Agente.BeneficiarioNombre=Agente.RFC
Agente.RFC=Agente.CURP
Agente.CURP=Agente.eMail
Agente.eMail=Agente.eMailAuto
Agente.eMailAuto=(Fin)
















[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Direccion
Direccion=Otros
Otros=FormaExtraValor
FormaExtraValor=Emida
Emida=CRM
CRM=WMS
WMS=(Fin)

[Forma.Modulos]
(Inicio)=CXC
CXC=VTAS
VTAS=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=PlantillasOffice
PlantillasOffice=Cerrar
Cerrar=CamposExtras
CamposExtras=Tareas
Tareas=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Anexos
Anexos=Doc
Doc=Politica
Politica=RefCta
RefCta=Clientes
Clientes=Articulos
Articulos=AgentePersonal
AgentePersonal=Objetivos
Objetivos=Actividades
Actividades=TipoComision
TipoComision=EquipoAgente
EquipoAgente=Informacion
Informacion=Cubos
Cubos=Mapa
Mapa=Mensajes
Mensajes=EmidaTerminalIDCfg
EmidaTerminalIDCfg=TCTerminalAgenteCfg
TCTerminalAgenteCfg=Navegador
Navegador=AgenteCat
AgenteCat=AgenteGrupo
AgenteGrupo=AgenteFam
AgenteFam=Historico
Historico=Zonas
Zonas=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)

[Forma.PlantillasExcepciones]
(Inicio)=Agente:Agente.Estatus
Agente:Agente.Estatus=Agente:Agente.TieneMovimientos
Agente:Agente.TieneMovimientos=(Fin)
