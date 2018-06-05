[Forma]
Clave=Socio
Nombre=<T>Socios<T>
Icono=4
Modulos=CAP
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=516
PosicionInicialArriba=185
PosicionInicialAltura=403
PosicionInicialAncho=574
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
PosicionInicialAlturaCliente=555
PosicionSec1=238

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Tipo,<T>Socio<T>)
MenuPrincipal=(Lista)
[Lista.Socio.Socio]
Carpeta=Lista
Clave=Socio.Socio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Socio=100
Nombre=304
Fecha=148
Usuario=82
Sucursal=64
Nombre_1=154
Empresa=69

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

ConCondicion=S
ActivoCondicion=no Socio:Socio.TieneMovimientos
EjecucionCondicion=Forma.ActualizarVista<BR>Forma.ActualizarControles<BR>Si<BR> Socio:Socio.TieneMovimientos<BR>Entonces<BR>  Error(<T>El socio ya tiene movimientos activos<T> , BotonAceptar  )<BR>Fin
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

[Lista.Socio.Nombre]
Carpeta=Lista
Clave=Socio.Nombre
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
EjecucionCondicion=ConDatos(Socio:Socio.Socio)
AntesExpresiones=Asigna(Info.Rama, <T>CAP<T>)<BR>Asigna(Info.Cuenta,Socio:Socio.Socio)<BR>Asigna(Info.Descripcion, Socio:Socio.Nombre)

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
EjecucionCondicion=ConDatos(Socio:Socio.Socio)
AntesExpresiones=Asigna(Info.PuedeEditar, Verdadero)<BR>Asigna(Info.Nombre, Socio:Socio.Nombre)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Socio, Socio:Socio.Socio)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Otros.Socio.Socio]
Carpeta=Otros
Clave=Socio.Socio
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Otros.Socio.Nombre]
Carpeta=Otros
Clave=Socio.Nombre
3D=S
Tamano=55
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Otros.Socio.CostoHora]
Carpeta=Otros
Clave=Socio.CostoHora
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Otros.Socio.Mensaje]
Carpeta=Otros
Clave=Socio.Mensaje
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Socio.Direccion]
Carpeta=Direccion
Clave=Socio.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Direccion.Socio.Colonia]
Carpeta=Direccion
Clave=Socio.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Socio.CodigoPostal]
Carpeta=Direccion
Clave=Socio.CodigoPostal
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Socio.Poblacion]
Carpeta=Direccion
Clave=Socio.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Socio.Estado]
Carpeta=Direccion
Clave=Socio.Estado
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Socio.Pais]
Carpeta=Direccion
Clave=Socio.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Socio.RFC]
Carpeta=Direccion
Clave=Socio.RFC
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=N

[Direccion.Socio.Socio]
Carpeta=Direccion
Clave=Socio.Socio
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Direccion.Socio.Nombre]
Carpeta=Direccion
Clave=Socio.Nombre
ValidaNombre=N
3D=S
Tamano=55
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Direccion.Socio.Telefonos]
Carpeta=Direccion
Clave=Socio.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.Socio.Extencion]
Carpeta=Direccion
Clave=Socio.Extencion
Editar=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
DespuesGuardar=S
EjecucionCondicion=ConDatos(Socio:Socio.Socio)
AntesExpresiones=Asigna(Info.Rama, <T>CAP<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Socio:Socio.Socio)<BR>Asigna(Info.Descripcion, Socio:Socio.Nombre)
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
ClaveAccion=SocioInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Socio:Socio.Socio)
AntesExpresiones=Asigna(Info.Socio, Socio:Socio.Socio)

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
Expresion=EditarDocumentacion(<T>CAP<T>, Socio:Socio.Socio, <T>Documentación - <T>+Socio:Socio.Nombre)
EjecucionCondicion=ConDatos(Socio:Socio.Socio)

[Acciones.SocioCat]
Nombre=SocioCat
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías
EnMenu=S
TipoAccion=Formas
ClaveAccion=SocioCat
Activo=S
Visible=S

[Acciones.SocioGrupo]
Nombre=SocioGrupo
Boton=0
Menu=&Maestros
NombreDesplegar=&Grupos
EnMenu=S
TipoAccion=Formas
ClaveAccion=SocioGrupo
Activo=S
Visible=S

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Socios
Clave=(Carpeta Abrir)
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=SocioA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Socio<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Socio.Nombre
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=SocioCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=SocioGrupo
FiltroAplicaEn1=Socio.Categoria
FiltroAplicaEn2=Socio.Grupo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
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
FiltroValida3=SocioFam
FiltroAplicaEn3=Socio.Familia

IconosConPaginas=S
IconosNombre=SocioA:Socio.Socio
[(Carpeta Abrir).Socio.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Socio.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

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

[Direccion.Socio.CURP]
Carpeta=Direccion
Clave=Socio.CURP
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Direccion.Socio.Zona]
Carpeta=Direccion
Clave=Socio.Zona
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

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
EjecucionCondicion=ConDatos(Socio:Socio.Socio)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, Socio:Socio.Socio)<BR>Asigna(Info.Nombre, Socio:Socio.Nombre)<BR>Asigna(Info.Aplica, <T>Socios<T>)<BR>Asigna(Info.Nombre2, Nulo)
Visible=S

[Otros.Socio.ArticuloDef]
Carpeta=Otros
Clave=Socio.ArticuloDef
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

[Direccion.Socio.eMail]
Carpeta=Direccion
Clave=Socio.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Otros.Socio.VentasCasa]
Carpeta=Otros
Clave=Socio.VentasCasa
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.SocioFam]
Nombre=SocioFam
Boton=0
Menu=&Maestros
NombreDesplegar=&Familias
EnMenu=S
TipoAccion=Formas
ClaveAccion=SocioFam
Activo=S
Visible=S

[Otros.Socio.Alta]
Carpeta=Otros
Clave=Socio.Alta
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Otros.Socio.Baja]
Carpeta=Otros
Clave=Socio.Baja
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Otros.Socio.ReportaA]
Carpeta=Otros
Clave=Socio.ReportaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Otros.SocioDestino.Nombre]
Carpeta=Otros
Clave=SocioDestino.Nombre
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
EjecucionCondicion=ConDatos(Socio:Socio.Socio)
AntesExpresiones=Asigna(Info.Rama, <T>CAP<T>)<BR>Asigna(Info.Clave, Socio:Socio.Socio)

[Ficha]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Socio
Fuente={MS Sans Serif, 8, Negro, []}
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

[Ficha.Socio.Socio]
Carpeta=Ficha
Clave=Socio.Socio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
Efectos=[Negritas]

[Ficha.Socio.Nombre]
Carpeta=Ficha
Clave=Socio.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco

[Ficha.Socio.Estatus]
Carpeta=Ficha
Clave=Socio.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
LineaNueva=S

[Ficha.Socio.Categoria]
Carpeta=Ficha
Clave=Socio.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.Grupo]
Carpeta=Ficha
Clave=Socio.Grupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.Familia]
Carpeta=Ficha
Clave=Socio.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.Cliente]
Carpeta=Ficha
Clave=Socio.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.Socio.Acreedor]
Carpeta=Ficha
Clave=Socio.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata

[Ficha.Acreedor.Nombre]
Carpeta=Ficha
Clave=Acreedor.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata

[Ficha.Socio.Zona]
Carpeta=Ficha
Clave=Socio.Zona
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.Direccion]
Carpeta=Ficha
Clave=Socio.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=77
ColorFondo=Blanco

[Ficha.Socio.Colonia]
Carpeta=Ficha
Clave=Socio.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.Poblacion]
Carpeta=Ficha
Clave=Socio.Poblacion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.Estado]
Carpeta=Ficha
Clave=Socio.Estado
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.CodigoPostal]
Carpeta=Ficha
Clave=Socio.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.Pais]
Carpeta=Ficha
Clave=Socio.Pais
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.eMail]
Carpeta=Ficha
Clave=Socio.eMail
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.RFC]
Carpeta=Ficha
Clave=Socio.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco

[Ficha.Socio.CURP]
Carpeta=Ficha
Clave=Socio.CURP
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

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
Visible=S
EjecucionCondicion=ConDatos(Socio:Socio.Socio)
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>CAP<T>)<BR>Asigna(Info.Cuenta, Socio:Socio.Socio)<BR>Asigna(Info.Nombre, Socio:Socio.Nombre)

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
EspacioPrevio=S
Expresion=Asigna(Info.Forma, <T>Socio<T>)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Nombre, <T>Socios<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
ConCondicion=S
Visible=S
Expresion=Asigna(Info.Tabla, <T>Socio<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
EjecucionCondicion=ConDatos(Socio:Socio.Socio)
Antes=S
AntesExpresiones=Asigna(Info.Nombre, Socio:Socio.Socio & <T> <T> & Socio:Socio.Nombre)

[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285






[Acciones.Mapa]
Nombre=Mapa
Boton=105
Menu=&Ver
NombreDesplegar=&Mapa
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=Mapa.Borrar<BR>Mapa.Agregar(<T>Socio<T>, Socio:Socio.Socio)<BR>PlugIn(<T>Mapa<T>, <T>Socio<T>, <T>Posicionar<T>)
Activo=S
Visible=S

































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










[Ficha.Socio.MapaUbicacion]
Carpeta=Ficha
Clave=Socio.MapaUbicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco









[Ficha.ListaEnCaptura]
(Inicio)=Socio.Socio
Socio.Socio=Socio.Nombre
Socio.Nombre=Socio.Estatus
Socio.Estatus=Socio.Categoria
Socio.Categoria=Socio.Grupo
Socio.Grupo=Socio.Familia
Socio.Familia=Socio.Zona
Socio.Zona=Socio.Direccion
Socio.Direccion=Socio.Colonia
Socio.Colonia=Socio.Poblacion
Socio.Poblacion=Socio.Estado
Socio.Estado=Socio.CodigoPostal
Socio.CodigoPostal=Socio.Pais
Socio.Pais=Socio.eMail
Socio.eMail=Socio.MapaUbicacion
Socio.MapaUbicacion=Socio.RFC
Socio.RFC=Socio.CURP
Socio.CURP=Socio.Cliente
Socio.Cliente=Cte.Nombre
Cte.Nombre=Socio.Acreedor
Socio.Acreedor=Acreedor.Nombre
Acreedor.Nombre=(Fin)





[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=PlantillasOffice
PlantillasOffice=Cerrar
Cerrar=Tareas
Tareas=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Anexos
Anexos=Doc
Doc=Politica
Politica=RefCta
RefCta=Mapa
Mapa=Informacion
Informacion=Navegador
Navegador=SocioCat
SocioCat=SocioGrupo
SocioGrupo=SocioFam
SocioFam=Historico
Historico=Otros1
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
