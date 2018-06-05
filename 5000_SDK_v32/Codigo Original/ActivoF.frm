[Forma]
Clave=ActivoF
Nombre=Activos Fijos
Icono=4
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=355
PosicionInicialArriba=69
PosicionInicialAltura=626
PosicionInicialAncho=655
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
DialogoAbrir=S
PosicionInicialAlturaCliente=551

MenuPrincipal=(Lista)
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=116
Descripcion1=198
SerieLote=107
Serie=115
0=120
1=157

CentroCostos2=127
Descripcion=235
CentroCostos3=127
[Detalle]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=$00F0F0F0
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Pestana=S

[Detalle.ActivoF.Articulo]
Carpeta=Detalle
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[Detalle.Art.Descripcion1]
Carpeta=Detalle
Clave=Art.Descripcion1
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[Detalle.ActivoF.Almacen]
Carpeta=Detalle
Clave=ActivoF.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[Detalle.ActivoF.Localizacion]
Carpeta=Detalle
Clave=ActivoF.Localizacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Detalle.ActivoF.Categoria]
Carpeta=Detalle
Clave=ActivoF.Categoria
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Antes=S
AntesExpresiones=Si(Vacio(ActivoF:ActivoF.VidaUtil), Precaucion(<T>Falta Especificar la Vida Util del Activo<T>))

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

[Detalle.ActivoF.Observaciones]
Carpeta=Detalle
Clave=ActivoF.Observaciones
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco

[Detalle.EstatusNombre]
Carpeta=Detalle
Clave=EstatusNombre
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
LineaNueva=S
Efectos=[Negritas]
EspacioPrevio=N

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F4

[Lista.ActivoF.Serie]
Carpeta=Lista
Clave=ActivoF.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ActivoF.Serie]
Carpeta=Detalle
Clave=ActivoF.Serie
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]
LineaNueva=N

[Lista.ActivoF.Articulo]
Carpeta=Lista
Clave=ActivoF.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EnMenu=S
AntesExpresiones=Asigna(Info.Articulo, ActivoF:ActivoF.Articulo)

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=50
NombreEnBoton=S
NombreDesplegar=&Historial Artículo/Serie
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Antes=S
Visible=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
EnMenu=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Articulo, ActivoF:ActivoF.Articulo)<BR>Asigna(Info.ArtTipo, TipoSerie)<BR>Asigna(Info.SerieLote, ActivoF:ActivoF.Serie)

[Acciones.ActivoFCat]
Nombre=ActivoFCat
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFCat
Activo=S
Visible=S

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Activos Fijos
Clave=(Carpeta Abrir)
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=ActivoFA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroGrupo1=ActivoF.Categoria
FiltroValida1=ActivoF.Categoria
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroAncho=30
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=INACTIVO
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=30
BusquedaEnLinea=S
CarpetaVisible=S
FiltroGrupo2=ActivoF.Almacen
FiltroValida2=ActivoF.Almacen
ListaAcciones=(Lista)
FiltroNull=S
IconosNombre=ActivoFA:ActivoF.Articulo
FiltroGeneral=ActivoF.Empresa=<T>{Empresa}<T>

[(Carpeta Abrir).ActivoF.Serie]
Carpeta=(Carpeta Abrir)
Clave=ActivoF.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=110
1=101

2=-2
3=-2
[(Carpeta Abrir).ActivoF.Almacen]
Carpeta=(Carpeta Abrir)
Clave=ActivoF.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
Carpeta=(Carpeta Abrir)

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

[(Carpeta Abrir).Art.Descripcion1]
Carpeta=(Carpeta Abrir)
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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

[Detalle.ActivoF.CentroCostos]
Carpeta=Detalle
Clave=ActivoF.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Detalle.ActivoF.Cliente]
Carpeta=Detalle
Clave=ActivoF.Cliente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S
[Detalle.CentroCostos.Descripcion]
Carpeta=Detalle
Clave=CentroCostos.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Detalle.Cte.Nombre]
Carpeta=Detalle
Clave=Cte.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Detalle.ActivoF.Responsable]
Carpeta=Detalle
Clave=ActivoF.Responsable
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
LineaNueva=S
EspacioPrevio=S

[Acciones.Gastos]
Nombre=Gastos
Boton=64
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
NombreDesplegar=Gastos del Activo &Fijo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarGastoAF
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Articulo, ActivoF:ActivoF.Articulo)<BR>Asigna(Info.SerieLote, ActivoF:ActivoF.Serie)

[Mantenimiento]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mantenimiento
Clave=Mantenimiento
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
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
CarpetaVisible=S
ListaEnCaptura=(Lista)
PermiteEditar=S

[Mantenimiento.ActivoF.Articulo]
Carpeta=Mantenimiento
Clave=ActivoF.Articulo
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Mantenimiento.Art.Descripcion1]
Carpeta=Mantenimiento
Clave=Art.Descripcion1
Editar=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.Articulo]
Carpeta=Seguro
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.Art.Descripcion1]
Carpeta=Seguro
Clave=Art.Descripcion1
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Serie]
Carpeta=Mantenimiento
Clave=ActivoF.Serie
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Almacen]
Carpeta=Mantenimiento
Clave=ActivoF.Almacen
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[Mantenimiento.ActivoF.Localizacion]
Carpeta=Mantenimiento
Clave=ActivoF.Localizacion
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Categoria]
Carpeta=Mantenimiento
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.Serie]
Carpeta=Seguro
Clave=ActivoF.Serie
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.Almacen]
Carpeta=Seguro
Clave=ActivoF.Almacen
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[Seguro.ActivoF.Localizacion]
Carpeta=Seguro
Clave=ActivoF.Localizacion
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.Categoria]
Carpeta=Seguro
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoSiguiente]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoSiguiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoPeriodicidad]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoPeriodicidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoCantidad]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoCantidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoUnidad]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoUltimo]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoUltimo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoAcum]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoAcum
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.MantenimientoPromedio]
Carpeta=Mantenimiento
Clave=MantenimientoPromedio
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Mantenimientos]
Carpeta=Mantenimiento
Clave=ActivoF.Mantenimientos
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoHoras]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoHoras
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.ReparacionUltima]
Carpeta=Mantenimiento
Clave=ActivoF.ReparacionUltima
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.ReparacionAcum]
Carpeta=Mantenimiento
Clave=ActivoF.ReparacionAcum
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Reparaciones]
Carpeta=Mantenimiento
Clave=ActivoF.Reparaciones
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.ReparacionHoras]
Carpeta=Mantenimiento
Clave=ActivoF.ReparacionHoras
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ReparacionPromedio]
Carpeta=Mantenimiento
Clave=ReparacionPromedio
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.Referencia]
Carpeta=Detalle
Clave=ActivoF.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Mantenimiento.ActivoF.Referencia]
Carpeta=Mantenimiento
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.ActivoFDR]
Nombre=ActivoFDR
Boton=51
Menu=&Ver
NombreDesplegar=&Depreciaciones y Reevaluaciones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFDR
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
AntesExpresiones=Asigna(Info.Articulo, ActivoF:ActivoF.Articulo)<BR>Asigna(Info.SerieLote, ActivoF:ActivoF.Serie)

[Detalle.NombreCompleto]
Carpeta=Detalle
Clave=NombreCompleto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
OcultaNombre=S

[Detalle.ActivoF.Espacio]
Carpeta=Detalle
Clave=ActivoF.Espacio
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Detalle.Espacio.Nombre]
Carpeta=Detalle
Clave=Espacio.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
OcultaNombre=S

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
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(ActivoF:ActivoF.ID)
AntesExpresiones=Asigna(Info.Descripcion, ActivoF:ActivoF.Articulo+<T> <T>+ActivoF:ActivoF.Serie) <BR>Asigna(Info.Rama, <T>AF<T>)<BR>Asigna(Info.Cuenta, ActivoF:ActivoF.ID)

[Garantia]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Garantía
Clave=Garantia
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Garantia.ActivoF.Articulo]
Carpeta=Garantia
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.Art.Descripcion1]
Carpeta=Garantia
Clave=Art.Descripcion1
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Serie]
Carpeta=Garantia
Clave=ActivoF.Serie
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoVence]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoVence
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Almacen]
Carpeta=Garantia
Clave=ActivoF.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Localizacion]
Carpeta=Garantia
Clave=ActivoF.Localizacion
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Categoria]
Carpeta=Garantia
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Referencia]
Carpeta=Garantia
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Garantia]
Carpeta=Garantia
Clave=ActivoF.Garantia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Garantia.ActivoF.GarantiaVence]
Carpeta=Garantia
Clave=ActivoF.GarantiaVence
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=ActivoF
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

[Seguro.ActivoF.Referencia]
Carpeta=Seguro
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.SeguroVence]
Carpeta=Seguro
Clave=ActivoF.SeguroVence
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Seguro.ActivoF.SeguroAcum]
Carpeta=Seguro
Clave=ActivoF.SeguroAcum
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Seguro.ActivoF.SeguroInicio]
Carpeta=Seguro
Clave=ActivoF.SeguroInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Seguro.ActivoF.SeguroTipoPoliza]
Carpeta=Seguro
Clave=ActivoF.SeguroTipoPoliza
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Seguro.ActivoF.Aseguradora]
Carpeta=Seguro
Clave=ActivoF.Aseguradora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Seguro.ActivoF.SeguroMonto]
Carpeta=Seguro
Clave=ActivoF.SeguroMonto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Seguro.ProvAseguradora.Nombre]
Carpeta=Seguro
Clave=ProvAseguradora.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.Departamento]
Carpeta=Detalle
Clave=ActivoF.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.ActivoF.Licencia]
Carpeta=Detalle
Clave=ActivoF.Licencia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Evaluacion]
Nombre=Evaluacion
Boton=103
Menu=&Edición
NombreDesplegar=Evaluaciones
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EvaluacionCalificacion
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, ActivoF:ActivoF.ID)<BR>Asigna(Info.Nombre, ActivoF:ActivoF.Articulo+<T>/<T>+ActivoF:ActivoF.Serie)<BR>Asigna(Info.Aplica, <T>Activos Fijos<T>)<BR>Asigna(Info.Nombre2, Nulo)

[Detalle.ActivoF.Arrendadora]
Carpeta=Detalle
Clave=ActivoF.Arrendadora
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProvArrendadora.Nombre]
Carpeta=Detalle
Clave=ProvArrendadora.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Acciones.Lecturas]
Nombre=Lecturas
Boton=9
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+L
NombreDesplegar=&Lecturas
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFLectura
Activo=S
Visible=S
Antes=S
EnBarraHerramientas=S
AntesExpresiones=Asigna(Info.Articulo, ActivoF:ActivoF.Articulo)<BR>Asigna(Info.SerieLote, ActivoF:ActivoF.Serie)

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
Vista=ActivoF
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

[OtrosDatos.ActivoF.UEN]
Carpeta=OtrosDatos
Clave=ActivoF.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[OtrosDatos.UEN.Nombre]
Carpeta=OtrosDatos
Clave=UEN.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.ActivoF.Proyecto]
Carpeta=OtrosDatos
Clave=ActivoF.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.ActivoF.Actividad]
Carpeta=OtrosDatos
Clave=ActivoF.Actividad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.ActivoF.Articulo]
Carpeta=OtrosDatos
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.Art.Descripcion1]
Carpeta=OtrosDatos
Clave=Art.Descripcion1
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.ActivoF.Serie]
Carpeta=OtrosDatos
Clave=ActivoF.Serie
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.ActivoF.Almacen]
Carpeta=OtrosDatos
Clave=ActivoF.Almacen
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
LineaNueva=S

[OtrosDatos.ActivoF.Localizacion]
Carpeta=OtrosDatos
Clave=ActivoF.Localizacion
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.ActivoF.Categoria]
Carpeta=OtrosDatos
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.ActivoF.Referencia]
Carpeta=OtrosDatos
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
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
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>AF<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, ActivoF:ActivoF.ID)<BR>Asigna(Info.Descripcion, ActivoF:ActivoF.Serie)
RefrescarDespues=S

[OtrosDatos.ProyectoDEnFirme.Asunto]
Carpeta=OtrosDatos
Clave=ProyectoDEnFirme.Asunto
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Contable]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contable
Clave=Contable
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Contable.ActivoF.Articulo]
Carpeta=Contable
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.Art.Descripcion1]
Carpeta=Contable
Clave=Art.Descripcion1
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.Serie]
Carpeta=Contable
Clave=ActivoF.Serie
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.Almacen]
Carpeta=Contable
Clave=ActivoF.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.Localizacion]
Carpeta=Contable
Clave=ActivoF.Localizacion
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.Categoria]
Carpeta=Contable
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.Referencia]
Carpeta=Contable
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.AdquisicionValor]
Carpeta=Contable
Clave=ActivoF.AdquisicionValor
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.AdquisicionFecha]
Carpeta=Contable
Clave=ActivoF.AdquisicionFecha
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.DepreciacionInicio]
Carpeta=Contable
Clave=ActivoF.DepreciacionInicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contable.ActivoF.Moneda]
Carpeta=Contable
Clave=ActivoF.Moneda
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.DepreciacionAnual]
Carpeta=Contable
Clave=ActivoF.DepreciacionAnual
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Contable.ActivoF.VidaUtil]
Carpeta=Contable
Clave=ActivoF.VidaUtil
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contable.ActivoF.DepreciacionMeses]
Carpeta=Contable
Clave=ActivoF.DepreciacionMeses
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Contable.ActivoF.Utilizacion]
Carpeta=Contable
Clave=ActivoF.Utilizacion
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=9

[Contable.ActivoF.DepreciacionAcum]
Carpeta=Contable
Clave=ActivoF.DepreciacionAcum
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Contable.ActivoF.DepreciacionUltima]
Carpeta=Contable
Clave=ActivoF.DepreciacionUltima
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Contable.ActivoF.ValorRevaluado]
Carpeta=Contable
Clave=ActivoF.ValorRevaluado
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Contable.ActivoF.RevaluacionUltima]
Carpeta=Contable
Clave=ActivoF.RevaluacionUltima
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Contable.ActivoF.ValorDesecho]
Carpeta=Contable
Clave=ActivoF.ValorDesecho
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contable.DepreciacionPorcentaje]
Carpeta=Contable
Clave=DepreciacionPorcentaje
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Contable.ValorHistoricoNeto]
Carpeta=Contable
Clave=ValorHistoricoNeto
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

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
Vista=ActivoF
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Fiscal.ActivoF.Articulo]
Carpeta=Contable
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.Art.Descripcion1]
Carpeta=Contable
Clave=Art.Descripcion1
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ActivoF.Serie]
Carpeta=Contable
Clave=ActivoF.Serie
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ActivoF.Almacen]
Carpeta=Contable
Clave=ActivoF.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ActivoF.Localizacion]
Carpeta=Contable
Clave=ActivoF.Localizacion
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ActivoF.Categoria]
Carpeta=Contable
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ActivoF.Referencia]
Carpeta=Contable
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ActivoF.AdquisicionValorF]
Carpeta=Contable
Clave=ActivoF.AdquisicionValorF
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ActivoF.AdquisicionFechaF]
Carpeta=Contable
Clave=ActivoF.AdquisicionFechaF
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ActivoF.DepreciacionInicioF]
Carpeta=Contable
Clave=ActivoF.DepreciacionInicioF
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.ActivoF.Moneda]
Carpeta=Contable
Clave=ActivoF.Moneda
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ActivoF.DepreciacionAnualF]
Carpeta=Contable
Clave=ActivoF.DepreciacionAnualF
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Fiscal.ActivoF.VidaUtilF]
Carpeta=Contable
Clave=ActivoF.VidaUtilF
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Fiscal.ActivoF.DepreciacionMesesF]
Carpeta=Contable
Clave=ActivoF.DepreciacionMesesF
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Fiscal.ActivoF.UtilizacionF]
Carpeta=Contable
Clave=ActivoF.UtilizacionF
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=9

[Fiscal.ActivoF.DepreciacionAcumF]
Carpeta=Contable
Clave=ActivoF.DepreciacionAcumF
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Fiscal.ActivoF.DepreciacionUltimaF]
Carpeta=Contable
Clave=ActivoF.DepreciacionUltimaF
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Fiscal.ActivoF.ValorRevaluadoF]
Carpeta=Contable
Clave=ActivoF.ValorRevaluadoF
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Fiscal.ActivoF.RevaluacionUltimaF]
Carpeta=Contable
Clave=ActivoF.RevaluacionUltimaF
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Fiscal.ActivoF.ValorDesechoF]
Carpeta=Contable
Clave=ActivoF.ValorDesechoF
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Fiscal.DepreciacionPorcentajeF]
Carpeta=Contable
Clave=DepreciacionPorcentajeF
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Fiscal.ValorHistoricoNetoF]
Carpeta=Contable
Clave=ValorHistoricoNetoF
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fiscal IETU
Clave=Fiscal2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Fiscal2.ActivoF.Articulo]
Carpeta=Contable
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.Art.Descripcion1]
Carpeta=Contable
Clave=Art.Descripcion1
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoF.Serie]
Carpeta=Contable
Clave=ActivoF.Serie
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoF.Almacen]
Carpeta=Contable
Clave=ActivoF.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoF.Localizacion]
Carpeta=Contable
Clave=ActivoF.Localizacion
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoF.Categoria]
Carpeta=Contable
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoF.Referencia]
Carpeta=Contable
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoF.AdquisicionValorF2]
Carpeta=Contable
Clave=ActivoF.AdquisicionValorF2
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoF.AdquisicionFechaF2]
Carpeta=Contable
Clave=ActivoF.AdquisicionFechaF2
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoF.DepreciacionInicioF2]
Carpeta=Contable
Clave=ActivoF.DepreciacionInicioF2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal2.ActivoF.Moneda]
Carpeta=Contable
Clave=ActivoF.Moneda
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ActivoF.DepreciacionAnualF2]
Carpeta=Contable
Clave=ActivoF.DepreciacionAnualF2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Fiscal2.ActivoF.VidaUtilF2]
Carpeta=Contable
Clave=ActivoF.VidaUtilF2
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Fiscal2.ActivoF.DepreciacionMesesF2]
Carpeta=Contable
Clave=ActivoF.DepreciacionMesesF2
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Fiscal2.ActivoF.UtilizacionF2]
Carpeta=Contable
Clave=ActivoF.UtilizacionF2
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=9

[Fiscal2.ActivoF.DepreciacionAcumF2]
Carpeta=Contable
Clave=ActivoF.DepreciacionAcumF2
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Fiscal2.ActivoF.DepreciacionUltimaF2]
Carpeta=Contable
Clave=ActivoF.DepreciacionUltimaF2
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Fiscal2.ActivoF.ValorRevaluadoF2]
Carpeta=Contable
Clave=ActivoF.ValorRevaluadoF2
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Fiscal2.ActivoF.RevaluacionUltimaF2]
Carpeta=Contable
Clave=ActivoF.RevaluacionUltimaF2
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Fiscal2.ActivoF.ValorDesechoF2]
Carpeta=Contable
Clave=ActivoF.ValorDesechoF2
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Fiscal2.DepreciacionPorcentajeF2]
Carpeta=Contable
Clave=DepreciacionPorcentajeF2
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Fiscal2.ValorHistoricoNetoF2]
Carpeta=Contable
Clave=ValorHistoricoNetoF2
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contable.ActivoF.PorcentajeDeducible]
Carpeta=Contable
Clave=ActivoF.PorcentajeDeducible
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Historico]
Nombre=Historico
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
NombreDesplegar=Histórico de Cambios
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Tabla, <T>ActivoF<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ActivoF:ActivoF.ID)
Antes=S
AntesExpresiones=Asigna(Info.Nombre, ActivoF:ActivoF.ID & <T> <T> & ActivoF:ActivoF.Articulo)
Visible=S





[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=ActivoF.Serie
ActivoF.Serie=Art.Descripcion1
Art.Descripcion1=ActivoF.Almacen
ActivoF.Almacen=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos menos uno)
(Todos menos uno)=ACTIVO
ACTIVO=REPARACION
REPARACION=MANTENIMIENTO
MANTENIMIENTO=INACTIVO
INACTIVO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)

[Mantenimiento.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.MantenimientoSiguiente
ActivoF.MantenimientoSiguiente=ActivoF.MantenimientoPeriodicidad
ActivoF.MantenimientoPeriodicidad=ActivoF.MantenimientoCantidad
ActivoF.MantenimientoCantidad=ActivoF.MantenimientoUnidad
ActivoF.MantenimientoUnidad=ActivoF.MantenimientoUltimo
ActivoF.MantenimientoUltimo=ActivoF.MantenimientoAcum
ActivoF.MantenimientoAcum=ActivoF.MantenimientoHoras
ActivoF.MantenimientoHoras=ActivoF.Mantenimientos
ActivoF.Mantenimientos=MantenimientoPromedio
MantenimientoPromedio=ActivoF.MantenimientoVence
ActivoF.MantenimientoVence=ActivoF.ReparacionUltima
ActivoF.ReparacionUltima=ActivoF.ReparacionAcum
ActivoF.ReparacionAcum=ActivoF.ReparacionHoras
ActivoF.ReparacionHoras=ActivoF.Reparaciones
ActivoF.Reparaciones=ReparacionPromedio
ReparacionPromedio=(Fin)

[Garantia.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.Garantia
ActivoF.Garantia=ActivoF.GarantiaVence
ActivoF.GarantiaVence=(Fin)

[Seguro.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.Aseguradora
ActivoF.Aseguradora=ProvAseguradora.Nombre
ProvAseguradora.Nombre=ActivoF.SeguroTipoPoliza
ActivoF.SeguroTipoPoliza=ActivoF.SeguroInicio
ActivoF.SeguroInicio=ActivoF.SeguroVence
ActivoF.SeguroVence=ActivoF.SeguroMonto
ActivoF.SeguroMonto=ActivoF.SeguroAcum
ActivoF.SeguroAcum=(Fin)

[OtrosDatos.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.UEN
ActivoF.UEN=UEN.Nombre
UEN.Nombre=ActivoF.Proyecto
ActivoF.Proyecto=ActivoF.Actividad
ActivoF.Actividad=ProyectoDEnFirme.Asunto
ProyectoDEnFirme.Asunto=(Fin)

[Contable.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.AdquisicionValor
ActivoF.AdquisicionValor=ActivoF.AdquisicionFecha
ActivoF.AdquisicionFecha=ActivoF.DepreciacionInicio
ActivoF.DepreciacionInicio=ActivoF.Moneda
ActivoF.Moneda=ActivoF.DepreciacionAnual
ActivoF.DepreciacionAnual=ActivoF.VidaUtil
ActivoF.VidaUtil=ActivoF.DepreciacionMeses
ActivoF.DepreciacionMeses=DepreciacionPorcentaje
DepreciacionPorcentaje=ActivoF.Utilizacion
ActivoF.Utilizacion=ActivoF.DepreciacionUltima
ActivoF.DepreciacionUltima=ActivoF.DepreciacionAcum
ActivoF.DepreciacionAcum=ValorHistoricoNeto
ValorHistoricoNeto=ActivoF.PorcentajeDeducible
ActivoF.PorcentajeDeducible=ActivoF.RevaluacionUltima
ActivoF.RevaluacionUltima=ActivoF.ValorRevaluado
ActivoF.ValorRevaluado=ActivoF.ValorDesecho
ActivoF.ValorDesecho=(Fin)

[Fiscal.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.AdquisicionValorF
ActivoF.AdquisicionValorF=ActivoF.AdquisicionFechaF
ActivoF.AdquisicionFechaF=ActivoF.DepreciacionInicioF
ActivoF.DepreciacionInicioF=ActivoF.Moneda
ActivoF.Moneda=ActivoF.DepreciacionAnualF
ActivoF.DepreciacionAnualF=ActivoF.VidaUtilF
ActivoF.VidaUtilF=ActivoF.DepreciacionMesesF
ActivoF.DepreciacionMesesF=DepreciacionPorcentajeF
DepreciacionPorcentajeF=ActivoF.UtilizacionF
ActivoF.UtilizacionF=ActivoF.DepreciacionUltimaF
ActivoF.DepreciacionUltimaF=ActivoF.DepreciacionAcumF
ActivoF.DepreciacionAcumF=ValorHistoricoNetoF
ValorHistoricoNetoF=ActivoF.RevaluacionUltimaF
ActivoF.RevaluacionUltimaF=ActivoF.ValorRevaluadoF
ActivoF.ValorRevaluadoF=ActivoF.ValorDesechoF
ActivoF.ValorDesechoF=(Fin)

[Fiscal2.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.AdquisicionValorF2
ActivoF.AdquisicionValorF2=ActivoF.AdquisicionFechaF2
ActivoF.AdquisicionFechaF2=ActivoF.DepreciacionInicioF2
ActivoF.DepreciacionInicioF2=ActivoF.Moneda
ActivoF.Moneda=ActivoF.DepreciacionAnualF2
ActivoF.DepreciacionAnualF2=ActivoF.VidaUtilF2
ActivoF.VidaUtilF2=ActivoF.DepreciacionMesesF2
ActivoF.DepreciacionMesesF2=DepreciacionPorcentajeF2
DepreciacionPorcentajeF2=ActivoF.UtilizacionF2
ActivoF.UtilizacionF2=ActivoF.DepreciacionUltimaF2
ActivoF.DepreciacionUltimaF2=ActivoF.DepreciacionAcumF2
ActivoF.DepreciacionAcumF2=ValorHistoricoNetoF2
ValorHistoricoNetoF2=ActivoF.RevaluacionUltimaF2
ActivoF.RevaluacionUltimaF2=ActivoF.ValorRevaluadoF2
ActivoF.ValorRevaluadoF2=ActivoF.ValorDesechoF2
ActivoF.ValorDesechoF2=(Fin)




[Acciones.ActivoFReferencia]
Nombre=ActivoFReferencia
Boton=0
Menu=&Edición
NombreDesplegar=&Componentes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFReferencia
Activo=S
Antes=S




GuardarAntes=S
AntesExpresiones=Asigna(Info.Articulo,ActivoF:ActivoF.Articulo)<BR>Asigna(Info.Descripcion,ActivoF:Art.Descripcion1)<BR>Asigna(Info.ID,ActivoF:ActivoF.ID)
VisibleCondicion=General.MAF
[Acciones.ActivoFIndicador]
Nombre=ActivoFIndicador
Boton=0
Menu=&Edición
NombreDesplegar=&Indicadores
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFIndicador
Activo=S
Antes=S

AntesExpresiones=Asigna(Info.ID, ActivoF:ActivoF.ID)<BR>Asigna(Info.Tipo, ActivoF:ActivoF.Tipo)<BR>Asigna(Info.Articulo,ActivoF:Art.Articulo)
VisibleCondicion=General.MAF









[Acciones.ActivoFTipo]
Nombre=ActivoFTipo
Boton=0
Menu=&Maestros
NombreDesplegar=&Tipos
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFTipo
Activo=S
VisibleCondicion=General.MAF


[Detalle.ActivoF.Tipo]
Carpeta=Detalle
Clave=ActivoF.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Detalle.ActivoF.UltimaInspeccion]
Carpeta=Detalle
Clave=ActivoF.UltimaInspeccion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ActivoF.SiguienteInspeccion]
Carpeta=Detalle
Clave=ActivoF.SiguienteInspeccion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ActivoF.InspeccionUsuario]
Carpeta=Detalle
Clave=ActivoF.InspeccionUsuario
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ActivoF.Inspeccion]
Carpeta=Detalle
Clave=ActivoF.Inspeccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ActivoF.InspeccionUnidad]
Carpeta=Detalle
Clave=ActivoF.InspeccionUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




















[CentrosCostos.CentroCostos2.Descripcion]
Carpeta=CentrosCostos
Clave=CentroCostos2.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=35
ColorFondo=$00F0F0F0


[CentrosCostos.CentroCostos3.Descripcion]
Carpeta=CentrosCostos
Clave=CentroCostos3.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=35
ColorFondo=$00F0F0F0


















[CentrosCostos.ListaEnCaptura]
(Inicio)=ActivoF.ContUso2
ActivoF.ContUso2=CentroCostos2.Descripcion
CentroCostos2.Descripcion=ActivoF.ContUso3
ActivoF.ContUso3=CentroCostos3.Descripcion
CentroCostos3.Descripcion=(Fin)

[CentrosCostos.ActivoF.ContUso2]
Carpeta=CentrosCostos
Clave=ActivoF.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[CentrosCostos.ActivoF.ContUso3]
Carpeta=CentrosCostos
Clave=ActivoF.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


































































[Detalle.ActivoF.ContUso2]
Carpeta=Detalle
Clave=ActivoF.ContUso2
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.CentroCostos2.Descripcion]
Carpeta=Detalle
Clave=CentroCostos2.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$00F0F0F0

[Detalle.ActivoF.ContUso3]
Carpeta=Detalle
Clave=ActivoF.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.CentroCostos3.Descripcion]
Carpeta=Detalle
Clave=CentroCostos3.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$00F0F0F0








[Detalle.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.Departamento
ActivoF.Departamento=ActivoF.Licencia
ActivoF.Licencia=ActivoF.Arrendadora
ActivoF.Arrendadora=ProvArrendadora.Nombre
ProvArrendadora.Nombre=ActivoF.Cliente
ActivoF.Cliente=Cte.Nombre
Cte.Nombre=ActivoF.CentroCostos
ActivoF.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=ActivoF.ContUso2
ActivoF.ContUso2=CentroCostos2.Descripcion
CentroCostos2.Descripcion=ActivoF.ContUso3
ActivoF.ContUso3=CentroCostos3.Descripcion
CentroCostos3.Descripcion=ActivoF.Responsable
ActivoF.Responsable=NombreCompleto
NombreCompleto=ActivoF.Espacio
ActivoF.Espacio=Espacio.Nombre
Espacio.Nombre=EstatusNombre
EstatusNombre=ActivoF.Observaciones
ActivoF.Observaciones=ActivoF.Tipo
ActivoF.Tipo=ActivoF.UltimaInspeccion
ActivoF.UltimaInspeccion=ActivoF.SiguienteInspeccion
ActivoF.SiguienteInspeccion=ActivoF.InspeccionUsuario
ActivoF.InspeccionUsuario=ActivoF.Inspeccion
ActivoF.Inspeccion=ActivoF.InspeccionUnidad
ActivoF.InspeccionUnidad=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Contable
Contable=Fiscal
Fiscal=Fiscal2
Fiscal2=Seguro
Seguro=Garantia
Garantia=Mantenimiento
Mantenimiento=OtrosDatos
OtrosDatos=(Fin)

[Forma.ListaAcciones]
(Inicio)=Abrir
Abrir=Guardar
Guardar=Propiedades
Propiedades=Evaluacion
Evaluacion=Anexos
Anexos=Cerrar
Cerrar=ArtInfo
ArtInfo=SerieLoteInfo
SerieLoteInfo=ActivoFDR
ActivoFDR=ActivoFCat
ActivoFCat=ActivoFTipo
ActivoFTipo=Lecturas
Lecturas=Gastos
Gastos=ActivoFReferencia
ActivoFReferencia=ActivoFIndicador
ActivoFIndicador=Navegador
Navegador=Historico
Historico=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros8
Otros8=Otros9
Otros9=Otros7
Otros7=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
