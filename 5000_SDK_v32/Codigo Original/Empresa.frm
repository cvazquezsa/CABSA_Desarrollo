[Forma]
Clave=Empresa
Nombre=Empresas
Icono=4
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=(Lista)
PosicionInicialIzquierda=27
PosicionInicialArriba=149
PosicionInicialAltura=371
PosicionInicialAncho=743
CarpetaPrincipal=Detalle
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionColumna1=50
BarraHerramientas=S
Menus=S
BarraAyuda=S
DialogoAbrir=S
PosicionInicialAlturaCliente=497
PosicionSec1=238
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Tipo,<T>Empresa<T>)<BR>Asigna(Info.Copiar, Falso)

MenuPrincipal=(Lista)
[Lista.Empresa.Empresa]
Carpeta=Lista
Clave=Empresa.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Empresa=71
Nombre=371
Grupo=135
Sucursal=64
Fecha=148
Usuario=82
Nombre_1=154
0=-2
1=-2

SATEstado.Descripcion=129
SATMunicipio.Descripcion=123
SATColonia.Descripcion=296
SATCatCP.ClaveCP=104
SATLocalidad.Descripcion=137
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
Vista=Empresa
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=72
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
CondicionEdicion=FormaNormal
FichaEspacioNombresAuto=S

[Detalle.Empresa.Empresa]
Carpeta=Detalle
Clave=Empresa.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
Efectos=[Negritas]
EditarConBloqueo=N

[Detalle.Empresa.Nombre]
Carpeta=Detalle
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
Efectos=[Negritas]
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.Empresa.Direccion]
Carpeta=Detalle
Clave=Empresa.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
EspacioPrevio=N
ColorFondo=Blanco

[Detalle.Empresa.Colonia]
Carpeta=Detalle
Clave=Empresa.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.Empresa.CodigoPostal]
Carpeta=Detalle
Clave=Empresa.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Empresa.Poblacion]
Carpeta=Detalle
Clave=Empresa.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.Empresa.Estado]
Carpeta=Detalle
Clave=Empresa.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.Empresa.Pais]
Carpeta=Detalle
Clave=Empresa.Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Empresa.Telefonos]
Carpeta=Detalle
Clave=Empresa.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.Empresa.Fax]
Carpeta=Detalle
Clave=Empresa.Fax
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Columnas]
Empresa=51
Nombre=604
Direccion=1204
Colonia=184
CodigoPostal=66
Poblacion=184
Estado=184
Pais=184
Telefonos=604
Fax=304
Notas=304
CampoNombre=311
Valor=303
ValorAnterior=285

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
EnBarraHerramientas=S
Visible=S
Menu=&Archivo
EnMenu=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EspacioPrevio=S
Menu=&Archivo
EnMenu=S
EnBarraHerramientas=S
ActivoCondicion=no Empresa:Empresa.TieneMovimientos

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

[Detalle.Empresa.Grupo]
Carpeta=Detalle
Clave=Empresa.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Notas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Notas
Clave=Notas
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Empresa
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
PermiteEditar=S
CarpetaVisible=S
CarpetaDesActivada=S

[Notas.Empresa.Encabezado1]
Carpeta=Notas
Clave=Empresa.Encabezado1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=72
ColorFondo=Blanco

[Notas.Empresa.Encabezado2]
Carpeta=Notas
Clave=Empresa.Encabezado2
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=72
ColorFondo=Blanco
Pegado=N

[Lista.Empresa.Grupo]
Carpeta=Lista
Clave=Empresa.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Movimientos]
Nombre=Movimientos
Boton=35
NombreDesplegar=&4: Movimientos por Omisión
TipoAccion=Formas
ClaveAccion=EmpresaCfgMov
Activo=S
Visible=S
GuardarAntes=S
Antes=S
Menu=&Edición
EnMenu=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)

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

[Acciones.General]
Nombre=General
Boton=0
Menu=&Edición
NombreDesplegar=&1: Configuración General
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaGral
Activo=S
Visible=S
Antes=S
GuardarAntes=S
ConCondicion=S
RefrescarDespues=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)

[Acciones.EmpresaConcepto]
Nombre=EmpresaConcepto
Boton=0
Menu=&Edición
NombreDesplegar=&6: Conceptos de Movimientos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaConcepto
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)

[Acciones.porModulos]
Nombre=porModulos
Boton=35
Menu=&Edición
NombreDesplegar=&3: Opciones Módulos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgModulo
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)

[Acciones.OpcionesGenerales]
Nombre=OpcionesGenerales
Boton=35
Menu=&Edición
NombreDesplegar=&2: Configuración Módulos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCfg
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)

[Acciones.EmpresaCfgMovImp]
Nombre=EmpresaCfgMovImp
Boton=0
Menu=&Edición
NombreDesplegar=&5: Reportes Específicos (Movimientos)
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgMovImp
Activo=S
Antes=S
Visible=S
GuardarAntes=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)

[Acciones.Embarques]
Nombre=Embarques
Boton=0
Menu=&Edición
NombreDesplegar=&7: Movimientos a Embarcar (Automáticamente)
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgMovEsp
Activo=S
Antes=S
Visible=S
GuardarAntes=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Asunto, <T>EMB<T>)<BR>Asigna(Info.Descripcion, <T>Movimientos a Embarcar (Automáticamente) - <T>+Empresa:Empresa.Nombre)

[Notas.Empresa.Empresa]
Carpeta=Notas
Clave=Empresa.Empresa
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]

[Notas.Empresa.Nombre]
Carpeta=Notas
Clave=Empresa.Nombre
LineaNueva=N
3D=S
Tamano=56
ColorFondo=Plata
Efectos=[Negritas]

[Acciones.CfgNomina]
Nombre=CfgNomina
Boton=0
Menu=&Edición
NombreDesplegar=&8: Propiedades de la Nómina
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalPropValor
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Rama, <T>EMP<T>)<BR>Asigna(Info.Cuenta, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)

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
Antes=S
DespuesGuardar=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Rama, <T>EMP<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)
RefrescarDespues=S

[Fiscal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fiscal
Clave=Fiscal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Empresa
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

[Fiscal.Empresa.Nombre]
Carpeta=Fiscal
Clave=Empresa.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Plata

[Fiscal.Empresa.RFC]
Carpeta=Fiscal
Clave=Empresa.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Fiscal.Empresa.Representante]
Carpeta=Fiscal
Clave=Empresa.Representante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Fiscal.Empresa.RepresentanteRFC]
Carpeta=Fiscal
Clave=Empresa.RepresentanteRFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Fiscal.Empresa.RepresentanteCURP]
Carpeta=Fiscal
Clave=Empresa.RepresentanteCURP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Fiscal.Empresa.ClaveActividad]
Carpeta=Fiscal
Clave=Empresa.ClaveActividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.Grupo]
Nombre=Grupo
Boton=0
Menu=&Maestros
NombreDesplegar=G&rupos
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaGrupo
Activo=S
Visible=S

[Acciones.Zona]
Nombre=Zona
Boton=0
Menu=&Maestros
NombreDesplegar=&Zonas
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaZona
Activo=S
Visible=S

[Detalle.Empresa.Zona]
Carpeta=Detalle
Clave=Empresa.Zona
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Pegado=N
EspacioPrevio=N

[Lista.Empresa.Sucursal]
Carpeta=Lista
Clave=Empresa.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Empresa.Estatus]
Carpeta=Detalle
Clave=Empresa.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N
EspacioPrevio=N

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Empresas
Clave=(Carpeta Abrir)
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=EmpresaA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Empresa<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todas
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
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=EmpresaZona
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=EmpresaGrupo
FiltroAplicaEn1=Empresa.Zona
FiltroAplicaEn2=Empresa.Grupo
FiltroTodo=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ListaAcciones=(Lista)
IconosNombre=EmpresaA:Empresa.Empresa

[(Carpeta Abrir).Empresa.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Empresa.Nombre
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
0=138
1=332
2=-2

[Acciones.PlugInAcceso]
Nombre=PlugInAcceso
Boton=0
Menu=&PlugIn<T>s
NombreDesplegar=Control de &Acceso
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgAcceso
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)

[Acciones.PlugInPV]
Nombre=PlugInPV
Boton=0
Menu=&PlugIn<T>s
NombreDesplegar=Punto de &Venta
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgPV
Activo=S
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)

[(Carpeta Abrir).Empresa.Grupo]
Carpeta=(Carpeta Abrir)
Clave=Empresa.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.EspaciosPlan]
Nombre=EspaciosPlan
Boton=88
Menu=&Ver
NombreDesplegar=&Plan
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Expresion=CalendarioReservaciones(<T><T>, <T><T>)
VisibleCondicion=General.Espacios

[Acciones.EmpresaCfgCR]
Nombre=EmpresaCfgCR
Boton=0
Menu=&Edición
NombreDesplegar=&9: Plantilla - Cajas Registradoras
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgCR
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)

[Fiscal.Empresa.RegistroPatronal]
Carpeta=Fiscal
Clave=Empresa.RegistroPatronal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=&Propiedades
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Prop
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Descripcion, Empresa:Empresa.Nombre) <BR>Asigna(Info.Rama, <T>EMP<T>)<BR>Asigna(Info.Cuenta, Empresa:Empresa.Empresa)

[Acciones.Documentacion]
Nombre=Documentacion
Boton=17
Menu=&Edición
NombreDesplegar=&Documentación
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=EditarDocumentacion(<T>EMP<T>, Empresa:Empresa.Empresa, <T>Documentación - <T>+ Empresa:Empresa.Nombre)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
Visible=S

[Acciones.EmpresaParticipacion]
Nombre=EmpresaParticipacion
Boton=0
Menu=&Edición
NombreDesplegar=1&0: Otras Participaciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaParticipacion
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)

[Acciones.Otros1]
Nombre=Otros1
Boton=0
EnMenu=S
TipoAccion=Expresion
Menu=&Otros

[Acciones.Otros2]
Nombre=Otros2
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros4]
Nombre=Otros4
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros5]
Nombre=Otros5
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros8]
Nombre=Otros8
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Detalle.Empresa.Controladora]
Carpeta=Detalle
Clave=Empresa.Controladora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.Controladora.Nombre]
Carpeta=Detalle
Clave=Controladora.Nombre
Editar=S
3D=S
Tamano=25
ColorFondo=Plata

[Acciones.CfgECollaborationMov]
Nombre=CfgECollaborationMov
Boton=0
Menu=&Edición
NombreDesplegar=&e-Collaboration - Mapa Movimientos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CfgECollaborationMov
Activo=S
VisibleCondicion=General.eCollaboration

[Acciones.CfgSistemaDetallista]
Nombre=CfgSistemaDetallista
Boton=0
Menu=&Edición
NombreDesplegar=&Sistema Detallista
EnMenu=S
TipoAccion=Formas
ClaveAccion=CfgSistemaDetallista
Activo=S
VisibleCondicion=General.SistemaDetallista

[Fiscal.Empresa.ImportadorRegimen]
Carpeta=Fiscal
Clave=Empresa.ImportadorRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Fiscal.Empresa.ImportadorRegistro]
Carpeta=Fiscal
Clave=Empresa.ImportadorRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Fiscal.Empresa.ImportadorFechaD]
Carpeta=Fiscal
Clave=Empresa.ImportadorFechaD
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Empresa.ImportadorFechaA]
Carpeta=Fiscal
Clave=Empresa.ImportadorFechaA
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.NomAuto]
Nombre=NomAuto
Boton=0
Menu=&Edición
NombreDesplegar=&Nómina Automática
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgNomAuto
Antes=S
ActivoCondicion=General.NomAuto
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)
VisibleCondicion=General.NomAuto

[Detalle.Empresa.DireccionNumero]
Carpeta=Detalle
Clave=Empresa.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Detalle.Empresa.Delegacion]
Carpeta=Detalle
Clave=Empresa.Delegacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.Empresa.GLN]
Carpeta=Detalle
Clave=Empresa.GLN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Fiscal.Empresa.CFD]
Carpeta=Fiscal
Clave=Empresa.CFD
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Detalle.Empresa.DireccionNumeroInt]
Carpeta=Detalle
Clave=Empresa.DireccionNumeroInt
Editar=S
3D=S
Tamano=6
ColorFondo=Blanco
Pegado=S

[CFD.Empresa.CFD_noCertificado]
Carpeta=CFD
Clave=Empresa.CFD_noCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CFD.Empresa.CFD_version]
Carpeta=CFD
Clave=Empresa.CFD_version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[CFD.Empresa.CFD_versionFecha]
Carpeta=CFD
Clave=Empresa.CFD_versionFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[CFD.Empresa.CFD_versionAnterior]
Carpeta=CFD
Clave=Empresa.CFD_versionAnterior
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[CFD.Empresa.CFD_EAN13]
Carpeta=CFD
Clave=Empresa.CFD_EAN13
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[CFD.Empresa.CFD_DUN14]
Carpeta=CFD
Clave=Empresa.CFD_DUN14
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[CFD.Empresa.CFD_SKU]
Carpeta=CFD
Clave=Empresa.CFD_SKU
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[CFD.Empresa.CFD_SKUCodigoInterno]
Carpeta=CFD
Clave=Empresa.CFD_SKUCodigoInterno
Editar=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[CFD.Empresa.CFD_Llave]
Carpeta=CFD
Clave=Empresa.CFD_Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=74
ColorFondo=Blanco
ColorFuente=Negro

[CFD.Empresa.CFD_Certificado]
Carpeta=CFD
Clave=Empresa.CFD_Certificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=74
ColorFondo=Blanco
ColorFuente=Negro

[CFD.Empresa.CFD_ContrasenaSello]
Carpeta=CFD
Clave=Empresa.CFD_ContrasenaSello
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=74
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.EmpresaCFD]
Nombre=EmpresaCFD
Boton=0
Menu=&Edición
NombreDesplegar=Comprobante Fiscal Digital (CFD)
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCFD
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Empresa:Empresa.CFD
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Nombre, Empresa:Empresa.Nombre)

[Acciones.Socios]
Nombre=Socios
Boton=0
Menu=&Edición
NombreDesplegar=&Socios
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaSocio
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
Antes=S
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)

[Acciones.EmpresaCfgPuntosEnVales]
Nombre=EmpresaCfgPuntosEnVales
Boton=0
Menu=&Edición
NombreDesplegar=Vales por Puntos
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgPuntosEnVales
Antes=S
Visible=S
ActivoCondicion=Config.VentaPuntosEnVales
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)

[Acciones.CfgMovProy]
Nombre=CfgMovProy
Boton=0
Menu=&Edición
NombreDesplegar=&Proyectos - Mapa Movimientos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CfgMovProy
Activo=S
Visible=S

[Acciones.Historico]
Nombre=Historico
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
NombreDesplegar=Histórico de Cambios
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Tabla, <T>Empresa<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
Antes=S
AntesExpresiones=Asigna(Info.Nombre, Empresa:Empresa.Empresa & <T> <T> & Empresa:Empresa.Nombre)
Visible=S

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Empresa.Nombre
Empresa.Nombre=Empresa.Grupo
Empresa.Grupo=(Fin)

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

[Fiscal.Empresa.FiscalRegimen]
Carpeta=Fiscal
Clave=Empresa.FiscalRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Fiscal.Empresa.FactorIntegracion]
Carpeta=Fiscal
Clave=Empresa.FactorIntegracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Organizaciones]
Nombre=Organizaciones
Boton=0
NombreDesplegar=&Organizaciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=Organizacion
Activo=S
Visible=S
Menu=&Maestros

[Ecuador]
Estilo=Ficha
Pestana=S
Clave=Ecuador
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Empresa
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
PestanaOtroNombre=S
PestanaNombre=Ecuador
CondicionVisible=Empresa:Empresa.EsEcuador

[Ecuador.Empresa.TipoRegistro]
Carpeta=Ecuador
Clave=Empresa.TipoRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ecuador.Empresa.Contador]
Carpeta=Ecuador
Clave=Empresa.Contador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ecuador.Empresa.RFCContador]
Carpeta=Ecuador
Clave=Empresa.RFCContador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Notas.ListaEnCaptura]
(Inicio)=Empresa.Empresa
Empresa.Empresa=Empresa.Nombre
Empresa.Nombre=Empresa.Encabezado1
Empresa.Encabezado1=Empresa.Encabezado2
Empresa.Encabezado2=(Fin)

[Guatemala]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Guatemala
Clave=Guatemala
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Empresa
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
ListaEnCaptura=Empresa.GtImporteMinimoSinRetencion
CondicionVisible=Empresa:Empresa.EsGuatemala

[Guatemala.Empresa.GtImporteMinimoSinRetencion]
Carpeta=Guatemala
Clave=Empresa.GtImporteMinimoSinRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Ecuador.Empresa.LongitudEstablecimiento]
Carpeta=Ecuador
Clave=Empresa.LongitudEstablecimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
EspacioPrevio=S

[Ecuador.Empresa.LongitudPuntoEmision]
Carpeta=Ecuador
Clave=Empresa.LongitudPuntoEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Ecuador.Empresa.LongitudSecuencialSRI]
Carpeta=Ecuador
Clave=Empresa.LongitudSecuencialSRI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Ecuador.Empresa.LongitudAutorizacion]
Carpeta=Ecuador
Clave=Empresa.LongitudAutorizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=5

[Ecuador.Empresa.EcuadorRepresentantelegal]
Carpeta=Ecuador
Clave=Empresa.EcuadorRepresentantelegal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco

[Ecuador.Empresa.EcuadorRepresentantelegalTipo]
Carpeta=Ecuador
Clave=Empresa.EcuadorRepresentantelegalTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ecuador.Empresa.EcuadorNumeroidentificacion]
Carpeta=Ecuador
Clave=Empresa.EcuadorNumeroidentificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ecuador.Empresa.EcuadorRUCContadorTipo]
Carpeta=Ecuador
Clave=Empresa.EcuadorRUCContadorTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Ecuador.ListaEnCaptura]
(Inicio)=Empresa.TipoRegistro
Empresa.TipoRegistro=Empresa.EcuadorRepresentantelegal
Empresa.EcuadorRepresentantelegal=Empresa.EcuadorRepresentantelegalTipo
Empresa.EcuadorRepresentantelegalTipo=Empresa.EcuadorNumeroidentificacion
Empresa.EcuadorNumeroidentificacion=Empresa.EcuadorRUCContadorTipo
Empresa.EcuadorRUCContadorTipo=Empresa.Contador
Empresa.Contador=Empresa.RFCContador
Empresa.RFCContador=Empresa.LongitudEstablecimiento
Empresa.LongitudEstablecimiento=Empresa.LongitudPuntoEmision
Empresa.LongitudPuntoEmision=Empresa.LongitudSecuencialSRI
Empresa.LongitudSecuencialSRI=Empresa.LongitudAutorizacion
Empresa.LongitudAutorizacion=(Fin)

[Acciones.EmpresaCFDFlex]
Nombre=EmpresaCFDFlex
Boton=0
NombreDesplegar=CFD &Flexible
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCFDFlex
Menu=&Edición
ConCondicion=S
Visible=S
Antes=S

ActivoCondicion=SQL(<T>SELECT ISNULL(eDoc, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, Empresa:Empresa.Empresa) y(SQL(<T>SELECT ISNULL(CFDFlex, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, Empresa:Empresa.Empresa))
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Nombre, Empresa:Empresa.Nombre)
[Fiscal.ListaEnCaptura]
(Inicio)=Empresa.Nombre
Empresa.Nombre=Empresa.RFC
Empresa.RFC=Empresa.RegistroPatronal
Empresa.RegistroPatronal=Empresa.ClaveActividad
Empresa.ClaveActividad=Empresa.FiscalRegimen
Empresa.FiscalRegimen=Empresa.FiscalZona
Empresa.FiscalZona=Empresa.Representante
Empresa.Representante=Empresa.RepresentanteRFC
Empresa.RepresentanteRFC=Empresa.RepresentanteCURP
Empresa.RepresentanteCURP=Empresa.ImportadorRegimen
Empresa.ImportadorRegimen=Empresa.ImportadorFechaD
Empresa.ImportadorFechaD=Empresa.ImportadorRegistro
Empresa.ImportadorRegistro=Empresa.ImportadorFechaA
Empresa.ImportadorFechaA=Empresa.CFD
Empresa.CFD=Empresa.FactorIntegracion
Empresa.FactorIntegracion=(Fin)

[Fiscal.Empresa.FiscalZona]
Carpeta=Fiscal
Clave=Empresa.FiscalZona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.EmpresaRegimenFiscales]
Nombre=EmpresaRegimenFiscales
Boton=0
Menu=&Edición
NombreDesplegar=&Regímenes Fiscales
GuardarAntes=S
TipoAccion=Formas
ClaveAccion=EmpresaRegimenFiscales
Activo=S
Antes=S
EnMenu=S

AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Nombre, Empresa:Empresa.Nombre)
VisibleCondicion=(SQL(<T>SELECT ISNULL(eDoc, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, Empresa:Empresa.Empresa) y(SQL(<T>SELECT ISNULL(CFDFlex, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, Empresa:Empresa.Empresa))) o Empresa:Empresa.CFD
[Acciones.FiscalRegimen]
Nombre=FiscalRegimen
Boton=0
Menu=&Maestros
NombreDesplegar=&Regímenes Fiscales
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=FiscalRegimen
Activo=S

VisibleCondicion=(SQL(<T>SELECT ISNULL(eDoc, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, Empresa:Empresa.Empresa) y(SQL(<T>SELECT ISNULL(CFDFlex, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, Empresa:Empresa.Empresa))) o Empresa:Empresa.CFD
[Detalle.Empresa.Configuracion]
Carpeta=Detalle
Clave=Empresa.Configuracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[Detalle.Empresa.EmpresaLDI]
Carpeta=Detalle
Clave=Empresa.EmpresaLDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco








[Detalle.ListaEnCaptura]
(Inicio)=Empresa.Empresa
Empresa.Empresa=Empresa.Nombre
Empresa.Nombre=Empresa.Direccion
Empresa.Direccion=Empresa.DireccionNumero
Empresa.DireccionNumero=Empresa.DireccionNumeroInt
Empresa.DireccionNumeroInt=Empresa.Delegacion
Empresa.Delegacion=Empresa.GLN
Empresa.GLN=Empresa.Colonia
Empresa.Colonia=Empresa.CodigoPostal
Empresa.CodigoPostal=Empresa.Poblacion
Empresa.Poblacion=Empresa.Zona
Empresa.Zona=Empresa.Estado
Empresa.Estado=Empresa.Pais
Empresa.Pais=Empresa.Telefonos
Empresa.Telefonos=Empresa.Fax
Empresa.Fax=Empresa.Grupo
Empresa.Grupo=Empresa.Estatus
Empresa.Estatus=Empresa.Configuracion
Empresa.Configuracion=Empresa.Controladora
Empresa.Controladora=Empresa.EmpresaLDI
Empresa.EmpresaLDI=Controladora.Nombre
Controladora.Nombre=(Fin)







[Acciones.PlugInDistribucion]
Nombre=PlugInDistribucion
Boton=0
Menu=&PlugIn<T>s
NombreDesplegar=&Distribución
EnMenu=S
TipoAccion=Formas
ClaveAccion=DistribucionCfg
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Empresa:Empresa.Empresa)
Antes=S
AntesExpresiones=Asigna(Info.Empresa, Empresa:Empresa.Empresa)<BR>Asigna(Info.Descripcion, Empresa:Empresa.Nombre)
Visible=S






















[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Fiscal
Fiscal=Notas
Notas=Ecuador
Ecuador=Guatemala
Guatemala=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=General
General=OpcionesGenerales
OpcionesGenerales=porModulos
porModulos=Movimientos
Movimientos=EmpresaCfgMovImp
EmpresaCfgMovImp=EmpresaConcepto
EmpresaConcepto=Embarques
Embarques=CfgNomina
CfgNomina=EmpresaCfgCR
EmpresaCfgCR=EmpresaParticipacion
EmpresaParticipacion=CfgECollaborationMov
CfgECollaborationMov=CfgMovProy
CfgMovProy=EmpresaCfgPuntosEnVales
EmpresaCfgPuntosEnVales=CfgSistemaDetallista
CfgSistemaDetallista=EmpresaCFD
EmpresaCFD=EmpresaCFDFlex
EmpresaCFDFlex=EmpresaRegimenFiscales
EmpresaRegimenFiscales=FiscalRegimen
FiscalRegimen=NomAuto
NomAuto=Socios
Socios=Propiedades
Propiedades=Anexos
Anexos=Documentacion
Documentacion=PlugInAcceso
PlugInAcceso=PlugInPV
PlugInPV=PlugInDistribucion
PlugInDistribucion=Grupo
Grupo=Zona
Zona=Historico
Historico=Cerrar
Cerrar=EspaciosPlan
EspaciosPlan=Navegador
Navegador=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=Organizaciones
Organizaciones=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&PlugIn's
&PlugIn's=&Maestros
&Maestros=(Fin)
