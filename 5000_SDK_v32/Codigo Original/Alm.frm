[Forma]
Clave=Alm
Nombre=<T>Almacenes<T>
Icono=4
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=367
PosicionInicialArriba=213
PosicionInicialAltura=532
PosicionInicialAncho=872
BarraHerramientas=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraAyuda=S
DialogoAbrir=S
Plantillas=S
PermiteCopiarDoc=S
PlantillasExcepciones=Alm:Alm.Estatus
PosicionInicialAlturaCliente=472
VentanaBloquearAjuste=N
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)
PosicionSec1=238

SinTransacciones=S
MenuPrincipal=(Lista)
[Alm.Columnas]
Almacen=62
Nombre=413

[Detalle]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Alm
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
CondicionEditar=FormaNormal
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Pestana=S
PestanaOtroNombre=S

[Detalle.Alm.Almacen]
Carpeta=Detalle
Clave=Alm.Almacen
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
Efectos=[Negritas]
ColorFondo=Blanco

[Detalle.Alm.Nombre]
Carpeta=Detalle
Clave=Alm.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=66
EspacioPrevio=S
ColorFondo=Blanco

[Detalle.Alm.Encargado]
Carpeta=Detalle
Clave=Alm.Encargado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=N

[Detalle.Alm.Telefonos]
Carpeta=Detalle
Clave=Alm.Telefonos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Lista.Alm.Almacen]
Carpeta=Lista
Clave=Alm.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Alm.Nombre]
Carpeta=Lista
Clave=Alm.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Almacen=90
Nombre=229
EstatusRegistro=78
Tipo=106
Orden=64
Grupo=100
Fecha=148
Usuario=82
Sucursal=46
Nombre_1=154
Empresa=69
0=106
1=276
Clave=52
Descripcion=130

Posicion=64
ArticuloEsp=124
Pasillo=45
Nivel=37
Zona=64
Estatus=54
2=122
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=S
Activo=S
EnBarraHerramientas=S
Menu=&Archivo
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+N

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EnBarraHerramientas=S
Menu=&Archivo
EnMenu=S
EspacioPrevio=S

Antes=S
DespuesGuardar=S
ActivoCondicion=no Alm:Alm.TieneMovimientos
AntesExpresiones=Asigna(Info.Cuenta,Alm:Alm.Almacen)<BR>EjecutarSQL(<T>spMESCatalogos :tCatalogo, :tINTCuenta, :nEliminar<T>,<T>AlmMES<T>,Info.Cuenta,1)
[Detalle.Columnas]
Almacen=49
Nombre=355
Direccion=604
Colonia=184
CodigoPostal=66
Poblacion=184
Estado=184
Pais=184
Encargado=304
Telefonos=304
Notas=304
Virtual=64
CampoNombre=311
Valor=303
ValorAnterior=285

[Acciones.Ir a la Carpeta]
Nombre=Ir a la Carpeta
Boton=0
NombreDesplegar=Ir a la Carpeta
EnEnter=Si
EnDblClick=Si
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Ir a la Carpeta
Visible=S
Activo=S

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

[Detalle.Alm.Grupo]
Carpeta=Detalle
Clave=Alm.Grupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=Prop
Activo=S
Antes=S
Visible=S
GuardarAntes=S
EspacioPrevio=S
Menu=&Edición
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=F11
ConCondicion=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(Alm:Alm.Almacen)
AntesExpresiones=Asigna(Info.Rama, <T>ALM<T>)<BR>Asigna(Info.Cuenta, Alm:Alm.Almacen)<BR>Asigna(Info.Descripcion, Alm:Alm.Nombre)

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar cambios
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
DespuesGuardar=S
Antes=S
AntesExpresiones=Si (Alm:Alm.Tipo=<T>Estructura<T>) y (Alm:Alm.Rama=<T><T>)<BR>Entonces<BR>  Asigna(Alm:Alm.Rama,Nulo)<BR>Fin<BR>Asigna(Info.Cuenta,Alm:Alm.Almacen)<BR>    EjecutarSQL(<T>spMESCatalogos :tCatalogo, :tINTCuenta<T>,<T>AlmMES<T>,Info.Cuenta)
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

[Opciones.Alm.Almacen]
Carpeta=Opciones
Clave=Alm.Almacen
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Opciones.Alm.Nombre]
Carpeta=Opciones
Clave=Alm.Nombre
Editar=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Opciones.Alm.Exclusivo]
Carpeta=Opciones
Clave=Alm.Exclusivo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Alm.Grupo]
Carpeta=Lista
Clave=Alm.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Alm.Tipo]
Carpeta=Opciones
Clave=Alm.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

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
EjecucionCondicion=ConDatos(Alm:Alm.Almacen)
AntesExpresiones=Asigna(Info.Rama, <T>ALM<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Alm:Alm.Almacen)<BR>Asigna(Info.Descripcion, Alm:Alm.Nombre)
DespuesGuardar=S
RefrescarDespues=S

[Opciones.Alm.FacturasPendientes]
Carpeta=Opciones
Clave=Alm.FacturasPendientes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=N
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Alm.wMostrar]
Carpeta=Opciones
Clave=Alm.wMostrar
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Edición
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=EditarDocumentacion(<T>ALM<T>, Alm:Alm.Almacen, <T>Documentación - <T>+Alm:Alm.Nombre)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Alm:Alm.Almacen)
Visible=S

[Acciones.Grupo]
Nombre=Grupo
Boton=0
Menu=&Maestros
NombreDesplegar=&Grupos
EnMenu=S
TipoAccion=Formas
ClaveAccion=AlmGrupo
Activo=S
Visible=S

[Detalle.Alm.Estatus]
Carpeta=Detalle
Clave=Alm.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
LineaNueva=S

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Almacenes
Clave=(Carpeta Abrir)
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=AlmA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Almacén<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Alm.Almacen<TAB>(Acendente)
FiltroPredefinido=S
FiltroAutoCampo=Alm.Tipo
FiltroNullNombre=(otros)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
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
FiltroGrupo1=Alm.Tipo
FiltroValida1=Alm.Tipo
ListaAcciones=(Lista)
FiltroSucursales=S
FiltroArbolClave=Alm.Almacen
FiltroArbolValidar=Alm.Nombre
FiltroArbolRama=Alm.Rama
FiltroArbolAcumulativas=Alm.Tipo
FiltroArbolTipoEstructura=S
IconosNombre=AlmA:Alm.Almacen

[(Carpeta Abrir).Alm.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Alm.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=119
1=369
2=-2

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

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
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

[Opciones.Alm.Sucursal]
Carpeta=Opciones
Clave=Alm.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Sucursal.Nombre]
Carpeta=Opciones
Clave=Sucursal.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Alm.Sucursal]
Carpeta=Detalle
Clave=Alm.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco

[Detalle.Sucursal.Nombre]
Carpeta=Detalle
Clave=Sucursal.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata

[Detalle.Alm.Tipo]
Carpeta=Detalle
Clave=Alm.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Alm.Exclusivo]
Carpeta=Detalle
Clave=Alm.Exclusivo
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Detalle.Alm.wMostrar]
Carpeta=Detalle
Clave=Alm.wMostrar
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco
Tamano=17

[Detalle.Alm.FacturasPendientes]
Carpeta=Detalle
Clave=Alm.FacturasPendientes
Editar=S
LineaNueva=N
3D=S
ColorFondo=Blanco
Tamano=25

[Detalle.Alm.wUnicamenteDisponibles]
Carpeta=Detalle
Clave=Alm.wUnicamenteDisponibles
Editar=S
3D=S
Tamano=31
ColorFondo=Blanco

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

[Detalle.Alm.Ruta]
Carpeta=Detalle
Clave=Alm.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[(Carpeta Abrir).Alm.Grupo]
Carpeta=(Carpeta Abrir)
Clave=Alm.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Alm.NivelAcceso]
Carpeta=Detalle
Clave=Alm.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.Alm.Idioma]
Carpeta=Detalle
Clave=Alm.Idioma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
Menu=&Archivo
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>AlmOrdenar<T>)

[Detalle.Alm.ExcluirPlaneacion]
Carpeta=Detalle
Clave=Alm.ExcluirPlaneacion
Editar=S
LineaNueva=S
3D=S
Tamano=17
ColorFondo=Blanco

[Detalle.Alm.CBDir]
Carpeta=Detalle
Clave=Alm.CBDir
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.Alm.Cuenta]
Carpeta=Detalle
Clave=Alm.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.Cta.Descripcion]
Carpeta=Detalle
Clave=Cta.Descripcion
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata

[Detalle.Alm.Segundas]
Carpeta=Detalle
Clave=Alm.Segundas
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Alm.Compartido]
Carpeta=Detalle
Clave=Alm.Compartido
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.AlmUsuario]
Nombre=AlmUsuario
Boton=0
Menu=&Edición
NombreDesplegar=Configurar Almacenes con Acceso...
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AlmUsuario
Activo=S
VisibleCondicion=(no Usuario.ControlAlmacenes) y Usuario.ControlAlmacenesEnAlm

[Detalle.Alm.SucursalRef]
Carpeta=Detalle
Clave=Alm.SucursalRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.SucursalDestino.Nombre]
Carpeta=Detalle
Clave=SucursalDestino.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata

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
Vista=Alm
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

[Direccion.Alm.Almacen]
Carpeta=Direccion
Clave=Alm.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata

[Direccion.Alm.Nombre]
Carpeta=Direccion
Clave=Alm.Nombre
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata

[Direccion.Alm.Direccion]
Carpeta=Direccion
Clave=Alm.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Direccion.Alm.EntreCalles]
Carpeta=Direccion
Clave=Alm.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Direccion.Alm.Plano]
Carpeta=Direccion
Clave=Alm.Plano
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Direccion.Alm.Observaciones]
Carpeta=Direccion
Clave=Alm.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Direccion.Alm.Colonia]
Carpeta=Direccion
Clave=Alm.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Direccion.Alm.Poblacion]
Carpeta=Direccion
Clave=Alm.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Direccion.Alm.CodigoPostal]
Carpeta=Direccion
Clave=Alm.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Direccion.Alm.Estado]
Carpeta=Direccion
Clave=Alm.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Direccion.Alm.Pais]
Carpeta=Direccion
Clave=Alm.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Direccion.Alm.Delegacion]
Carpeta=Direccion
Clave=Alm.Delegacion
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Detalle.Alm.Rama]
Carpeta=Detalle
Clave=Alm.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.AlmLista.Nombre]
Carpeta=Detalle
Clave=AlmLista.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata

[Acciones.AlmABC]
Nombre=AlmABC
Boton=0
Menu=&Edición
NombreDesplegar=Conteo &Cíclico
EnMenu=S
TipoAccion=Formas
ClaveAccion=AlmABC
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Alm:Alm.Almacen)
AntesExpresiones=Asigna(Info.Almacen, Alm:Alm.Almacen)

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
EjecucionCondicion=ConDatos(Alm:Alm.Almacen)
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>ALM<T>)<BR>Asigna(Info.Cuenta, Alm:Alm.Almacen)<BR>Asigna(Info.Nombre, Alm:Alm.Nombre)
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
EspacioPrevio=S
Expresion=Asigna(Info.Forma, <T>Alm<T>)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Nombre, <T>Almacenes<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=104
Menu=&Edición
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasContacto(<T>Almacen<T>, Alm:Alm.Tipo, Alm:Alm.Almacen)<BR>Sino<BR>  Asigna(Info.Aplica, <T>Almacen<T>)<BR>  Asigna(Info.Clave, Alm:Alm.Almacen)<BR>  Asigna(Info.Nombre, Alm:Alm.Nombre)<BR>  Asigna(Info.Modulo, Nulo)<BR>  Asigna(Info.Mov, Nulo)<BR>  Asigna(Info.Categoria, Alm:Alm.Categoria)<BR>  Asigna(Info.Grupo, Alm:Alm.Grupo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si(ConDatos(Info.FormaTipo), iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre), Informacion(<T>No Tiene Definida Ninguna Forma<T>))<BR>Fin
EjecucionCondicion=ConDatos(Alm:Alm.Almacen)

[Acciones.AlmPos]
Nombre=AlmPos
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+W
NombreDesplegar=&Posiciones del Almacén
EnMenu=S
TipoAccion=Formas
ClaveAccion=AlmPos
Activo=S
ConCondicion=S
Antes=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Alm:Alm.Almacen)
AntesExpresiones=Asigna(Info.Almacen, Alm:Alm.Almacen)
VisibleCondicion=(General.WMS y Alm:Alm.WMS) o Config.Posiciones

[Detalle.Alm.WMS]
Carpeta=Detalle
Clave=Alm.WMS
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco

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
CarpetaVisible=S
PermiteEditar=S

HojaColorFondo=Plata
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleAlmacen(<T>{Alm:Alm.Categoria}<T>, <T>{Alm:Alm.Grupo}<T>)) AND FormaExtraValor.Aplica=<T>Almacen<T> AND FormaExtraValor.AplicaClave=<T>{Alm:Alm.Almacen}<T>
[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=298
VerValor=266

[WMS]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=WMS
Clave=WMS
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Alm
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







CondicionVisible=(Alm:Alm.WMS y General.WMS)
[Acciones.Historico]
Nombre=Historico
Boton=0
NombreDesplegar=Histórico de Cambios
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Antes=S
Visible=S
Menu=&Ver
Expresion=Asigna(Info.Tabla, <T>Alm<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
EjecucionCondicion=ConDatos(Alm:Alm.Almacen)
AntesExpresiones=Asigna(Info.Nombre, Alm:Alm.Almacen & <T> <T> & Alm:Alm.Nombre)

[Direccion.Alm.DireccionNumero]
Carpeta=Direccion
Clave=Alm.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Direccion.Alm.DireccionNumeroInt]
Carpeta=Direccion
Clave=Alm.DireccionNumeroInt
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
EspacioPrevio=S
Expresion=Mapa.Borrar<BR>Mapa.Agregar(<T>Almacen<T>, Alm:Alm.Almacen)<BR>PlugIn(<T>Mapa<T>, <T>Almacen<T>, <T>Posicionar<T>)

[Acciones.MapaTodos]
Nombre=MapaTodos
Boton=0
NombreDesplegar=Ver Mapa (&Selección)
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Mapa.Borrar<BR>RegistrarListaSt(<T>(Carpeta Abrir)<T>, <T>Alm.Almacen<T>, Verdadero)<BR>Mapa.AgregarListaSt(<T>Almacen<T>)<BR>PlugIn(<T>Mapa<T>, <T>Almacen<T>, <T>Posicionar<T>)

[Acciones.MapaSeleccion]
Nombre=MapaSeleccion
Boton=0
NombreDesplegar=Ver Mapa (&Todos)
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Mapa.Borrar<BR>RegistrarListaSt(<T>(Carpeta Abrir)<T>, <T>Alm.Almacen<T>)<BR>Mapa.AgregarListaSt(<T>Almacen<T>)<BR>PlugIn(<T>Mapa<T>, <T>Almacen<T>, <T>Posicionar<T>)





[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Alm.Nombre
Alm.Nombre=Alm.Grupo
Alm.Grupo=(Fin)

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
Excel=MapaTodos
MapaTodos=MapaSeleccion
MapaSeleccion=Campos
Campos=(Fin)


[Acciones.AlmSugerirSurtidoTarima]
Nombre=AlmSugerirSurtidoTarima
Boton=0
Menu=&Edición
NombreDesplegar=Configurar Movimientos WMS
EnMenu=S
TipoAccion=Formas
ClaveAccion=AlmSugerirSurtidoTarima
Antes=S
DespuesGuardar=S

GuardarAntes=S
Activo=S
AntesExpresiones=Asigna(Info.Almacen, Alm:Alm.Almacen)
VisibleCondicion=General.WMS y Alm:Alm.WMS
[Infor]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Infor
Clave=Infor
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Alm
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
CondicionVisible=General.ProdInterfazInfor

[Infor.Alm.PermiteRechazos]
Carpeta=Infor
Clave=Alm.PermiteRechazos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Infor.Alm.PermiteUbicaciones]
Carpeta=Infor
Clave=Alm.PermiteUbicaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Infor.Alm.EsAlmacenDeDeposito]
Carpeta=Infor
Clave=Alm.EsAlmacenDeDeposito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Infor.Alm.EsAlmacenMaterialesExteriores]
Carpeta=Infor
Clave=Alm.EsAlmacenMaterialesExteriores
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Infor.Alm.NoDisponibleConsumos]
Carpeta=Infor
Clave=Alm.NoDisponibleConsumos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Infor.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.PermiteRechazos=Alm.EsAlmacenDeDeposito
Alm.PermiteUbicaciones=Alm.EsAlmacenMaterialesExteriores
Alm.EsAlmacenDeDeposito=Alm.PermiteUbicaciones
Alm.EsAlmacenMaterialesExteriores=Alm.NoDisponibleConsumos
Alm.NoDisponibleConsumos=(Fin)
Alm.Almacen=Alm.PermiteRechazos





[Infor.Columnas]
Almacen=34
PermiteRechazos=89
EsAlmacenDeDeposito=119
PermiteUbicaciones=99
EsAlmacenMaterialesExteriores=162
NoDisponibleConsumos=114

[Intelisis MES.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.PermiteRechazos
Alm.PermiteRechazos=Alm.PermiteUbicaciones
Alm.PermiteUbicaciones=Alm.EsAlmacenDeDeposito
Alm.EsAlmacenDeDeposito=Alm.EsAlmacenMaterialesExteriores
Alm.EsAlmacenMaterialesExteriores=Alm.NoDisponibleConsumos
Alm.NoDisponibleConsumos=Alm.INFORClavePlanta
Alm.INFORClavePlanta=(Fin)

[Intelisis Factory]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Intelisis Factory
Clave=Intelisis Factory
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Alm
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


CondicionVisible=//General.ProdInterfazINFOR<BR>1=2
[Intelisis Factory.Alm.Almacen]
Carpeta=Intelisis Factory
Clave=Alm.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Intelisis Factory.Alm.PermiteRechazos]
Carpeta=Intelisis Factory
Clave=Alm.PermiteRechazos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Intelisis Factory.Alm.PermiteUbicaciones]
Carpeta=Intelisis Factory
Clave=Alm.PermiteUbicaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Intelisis Factory.Alm.EsAlmacenDeDeposito]
Carpeta=Intelisis Factory
Clave=Alm.EsAlmacenDeDeposito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intelisis Factory.Alm.EsAlmacenMaterialesExteriores]
Carpeta=Intelisis Factory
Clave=Alm.EsAlmacenMaterialesExteriores
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intelisis Factory.Alm.NoDisponibleConsumos]
Carpeta=Intelisis Factory
Clave=Alm.NoDisponibleConsumos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Intelisis Factory.Alm.INFORClavePlanta]
Carpeta=Intelisis Factory
Clave=Alm.INFORClavePlanta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[WMS.Alm.DefPosicionRecibo]
Carpeta=WMS
Clave=Alm.DefPosicionRecibo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[WMS.Alm.DefPosicionSurtido]
Carpeta=WMS
Clave=Alm.DefPosicionSurtido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco



[Detalle.Alm.EsFactory]
Carpeta=Detalle
Clave=Alm.EsFactory
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco





Tamano=30





[Detalle.Alm.Ubicaciones]
Carpeta=Detalle
Clave=Alm.Ubicaciones
Editar=S
3D=S
Tamano=17
ColorFondo=Blanco

LineaNueva=S



[Ubicaciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ubicaciones
Clave=Ubicaciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Alm
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


CondicionVisible=(Alm:Alm.Ubicaciones y Config.Posiciones)
[Ubicaciones.Alm.DefPosicionRecibo]
Carpeta=Ubicaciones
Clave=Alm.DefPosicionRecibo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[Ubicaciones.Alm.DefPosicionSurtido]
Carpeta=Ubicaciones
Clave=Alm.DefPosicionSurtido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[Detalle.Alm.CEDIS]
Carpeta=Detalle
Clave=Alm.CEDIS
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Detalle.Alm.CompraDirecta]
Carpeta=Detalle
Clave=Alm.CompraDirecta
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




Tamano=20












[Acciones.PlanRutaDist]
Nombre=PlanRutaDist
Boton=0
Menu=&Edición
NombreDesplegar=Ruta de Distribución
EnMenu=S
TipoAccion=Formas
ClaveAccion=RutaDistribucionMaxMin
Activo=S
Visible=S







Antes=S
AntesExpresiones=Asigna(Info.Almacen,Alm:Alm.Almacen)



















[WMS.Alm.Defposicioncrossdocking]
Carpeta=WMS
Clave=Alm.Defposicioncrossdocking
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[WMS.Alm.Escrossdocking]
Carpeta=WMS
Clave=Alm.Escrossdocking
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco




























[Acciones.Zonas]
Nombre=Zonas
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+Z
NombreDesplegar=&Zonas
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PosicionZona
Activo=S
Visible=S











[WMS.AlmPos.Posicion]
Carpeta=WMS
Clave=AlmPos.Posicion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=45
ColorFondo=Plata

[WMS.AlmPosDestino.Descripcion]
Carpeta=WMS
Clave=AlmPosDestino.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=45
ColorFondo=Plata

[WMS.AlmPosCrossDocking.Descripcion]
Carpeta=WMS
Clave=AlmPosCrossDocking.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=45
ColorFondo=Plata

















[Ubicaciones.AlmPos.Descripcion]
Carpeta=Ubicaciones
Clave=AlmPos.Descripcion
3D=S
Pegado=S
Tamano=45
ColorFondo=Blanco

[Ubicaciones.AlmPosDestino.Descripcion]
Carpeta=Ubicaciones
Clave=AlmPosDestino.Descripcion
3D=S
Pegado=S
Tamano=45
ColorFondo=Blanco








[Detalle.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Tipo
Alm.Tipo=Alm.Nombre
Alm.Nombre=Alm.Rama
Alm.Rama=AlmLista.Nombre
AlmLista.Nombre=Alm.Sucursal
Alm.Sucursal=Sucursal.Nombre
Sucursal.Nombre=Alm.SucursalRef
Alm.SucursalRef=SucursalDestino.Nombre
SucursalDestino.Nombre=Alm.Ruta
Alm.Ruta=Alm.Grupo
Alm.Grupo=Alm.Encargado
Alm.Encargado=Alm.Telefonos
Alm.Telefonos=Alm.Exclusivo
Alm.Exclusivo=Alm.NivelAcceso
Alm.NivelAcceso=Alm.Idioma
Alm.Idioma=Alm.CBDir
Alm.CBDir=Alm.Cuenta
Alm.Cuenta=Cta.Descripcion
Cta.Descripcion=Alm.Estatus
Alm.Estatus=Alm.wMostrar
Alm.wMostrar=Alm.wUnicamenteDisponibles
Alm.wUnicamenteDisponibles=Alm.FacturasPendientes
Alm.FacturasPendientes=Alm.ExcluirPlaneacion
Alm.ExcluirPlaneacion=Alm.Segundas
Alm.Segundas=Alm.CEDIS
Alm.CEDIS=Alm.CompraDirecta
Alm.CompraDirecta=Alm.EsFactory
Alm.EsFactory=Alm.WMS
Alm.WMS=Alm.Compartido
Alm.Compartido=Alm.Ubicaciones
Alm.Ubicaciones=(Fin)

[WMS.ListaEnCaptura]
(Inicio)=Alm.DefPosicionRecibo
Alm.DefPosicionRecibo=AlmPos.Posicion
AlmPos.Posicion=Alm.DefPosicionSurtido
Alm.DefPosicionSurtido=AlmPosDestino.Descripcion
AlmPosDestino.Descripcion=Alm.Defposicioncrossdocking
Alm.Defposicioncrossdocking=AlmPosCrossDocking.Descripcion
AlmPosCrossDocking.Descripcion=Alm.Escrossdocking
Alm.Escrossdocking=(Fin)

[Ubicaciones.ListaEnCaptura]
(Inicio)=Alm.DefPosicionRecibo
Alm.DefPosicionRecibo=AlmPos.Descripcion
AlmPos.Descripcion=Alm.DefPosicionSurtido
Alm.DefPosicionSurtido=AlmPosDestino.Descripcion
AlmPosDestino.Descripcion=(Fin)


[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden	(Acendente)
GrupoOrden	(Acendente)=FormaExtraCampo.Orden	(Acendente)
FormaExtraCampo.Orden	(Acendente)=(Fin)

[Intelisis Factory.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.PermiteRechazos
Alm.PermiteRechazos=Alm.PermiteUbicaciones
Alm.PermiteUbicaciones=Alm.EsAlmacenDeDeposito
Alm.EsAlmacenDeDeposito=Alm.EsAlmacenMaterialesExteriores
Alm.EsAlmacenMaterialesExteriores=Alm.NoDisponibleConsumos
Alm.NoDisponibleConsumos=Alm.INFORClavePlanta
Alm.INFORClavePlanta=(Fin)


















[Direccion.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Nombre
Alm.Nombre=Alm.Direccion
Alm.Direccion=Alm.DireccionNumero
Alm.DireccionNumero=Alm.DireccionNumeroInt
Alm.DireccionNumeroInt=Alm.EntreCalles
Alm.EntreCalles=Alm.Plano
Alm.Plano=Alm.Observaciones
Alm.Observaciones=Alm.Delegacion
Alm.Delegacion=Alm.Colonia
Alm.Colonia=Alm.CodigoPostal
Alm.CodigoPostal=Alm.Poblacion
Alm.Poblacion=Alm.Estado
Alm.Estado=Alm.Pais
Alm.Pais=Alm.MapaUbicacion
Alm.MapaUbicacion=(Fin)

[Direccion.Alm.MapaUbicacion]
Carpeta=Direccion
Clave=Alm.MapaUbicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco




[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=WMS
WMS=Ubicaciones
Ubicaciones=Direccion
Direccion=FormaExtraValor
FormaExtraValor=Intelisis Factory
Intelisis Factory=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=PlantillasOffice
PlantillasOffice=Ordenar
Ordenar=CamposExtras
CamposExtras=Propiedades
Propiedades=Anexos
Anexos=Doc
Doc=RefCta
RefCta=AlmABC
AlmABC=AlmPos
AlmPos=AlmSugerirSurtidoTarima
AlmSugerirSurtidoTarima=AlmUsuario
AlmUsuario=Mapa
Mapa=Navegador
Navegador=Cerrar
Cerrar=Grupo
Grupo=Historico
Historico=Zonas
Zonas=PlanRutaDist
PlanRutaDist=Otros1
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
&Edición=&Maestros
&Maestros=&Ver
&Ver=&Otros
&Otros=(Fin)
