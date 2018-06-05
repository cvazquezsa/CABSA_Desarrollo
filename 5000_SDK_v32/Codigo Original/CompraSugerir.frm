[Forma]
Clave=CompraSugerir
Nombre=Sugerir Compras
Icono=5
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=451
PosicionInicialArriba=308
PosicionInicialAltura=436
PosicionInicialAncho=1015
Comentarios=Lista(<T>Cliente: <T>+Si(Vacio(Info.Cliente), <T>(Todos)<T>, Info.Cliente), <T>Proveedor: <T>+Si(Vacio(Info.Proveedor), <T>(Todos)<T>, Info.Proveedor), <T>Almacén: <T>+Si(Vacio(Info.Almacen), <T>(Todos)<T>, Info.Almacen))
PosicionInicialAlturaCliente=519

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraSugerir
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ValidarCampos=S
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
ListaEnCaptura=(Lista)
ListaCamposAValidar=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
OtroOrden=S
ListaOrden=(Lista)
HojaFondoGris=S
MenuLocal=S
ListaAcciones=Copiar
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroAplicaEn5=Art.Fabricante
FiltroTodo=S
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=CompraSugerir.Articulo
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGeneral=CompraSugerir.Estacion={EstacionTrabajo} AND <BR>CompraSugerir.CompraID={Info.ID}

[Lista.CompraSugerir.Articulo]
Carpeta=Lista
Clave=CompraSugerir.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Plata

[Lista.CompraSugerir.SubCuenta]
Carpeta=Lista
Clave=CompraSugerir.SubCuenta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=$00808040
ColorFondo=Plata

[Lista.MovNombre]
Carpeta=Lista
Clave=MovNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFuente=Negro
ColorFondo=Plata

[Lista.CompraSugerir.Almacen]
Carpeta=Lista
Clave=CompraSugerir.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Negro
ColorFondo=Plata

[Lista.CompraSugerir.Cliente]
Carpeta=Lista
Clave=CompraSugerir.Cliente
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Negro
ColorFondo=Plata

[Lista.CompraSugerir.FechaEmision]
Carpeta=Lista
Clave=CompraSugerir.FechaEmision
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Negro
ColorFondo=Plata

[Lista.CompraSugerir.FechaRequerida]
Carpeta=Lista
Clave=CompraSugerir.FechaRequerida
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Negro
ColorFondo=Plata

[Lista.CompraSugerir.Cantidad]
Carpeta=Lista
Clave=CompraSugerir.Cantidad
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=$00004080
ColorFondo=Plata
Efectos=[Negritas]

[Lista.CompraSugerir.CantidadA]
Carpeta=Lista
Clave=CompraSugerir.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=F12
Antes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>spCompraSugerirAceptar :nEstacion, :nSucursal, :tEmpresa, :nID, 0<T>, EstacionTrabajo, Sucursal, Empresa, Info.ID )

[Lista.Columnas]
Articulo=99
SubCuenta=84
MovNombre=122
Almacen=68
Cliente=69
FechaEmision=70
FechaRequerida=68
Cantidad=61
CantidadA=57
CantidadSugerida=50
ClaveProveedor=84
UnidadCompra=57
Codigo=74

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S
EspacioPrevio=S

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
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S

[Acciones.Proveedor]
Nombre=Proveedor
Boton=60
NombreEnBoton=S
NombreDesplegar=&Proveedor
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Visible=S
Multiple=S
ListaAccionesMultiples=SQL<BR>Actualizar Forma
EjecucionCondicion=Forma(<T>EspecificarProveedor<T>)

[Acciones.Base.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Base.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spCompraSugerir :nEstacion, :nID, :tProveedor, :tBase<T>, EstacionTrabajo, Info.ID, Info.Proveedor, Info.Base)

[Acciones.Proveedor.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spCompraSugerir :nEstacion, :nID, :tCliente, :tProveedor, :tAlmacen<T>, EstacionTrabajo, Info.ID, Info.Cliente, Info.Proveedor, Info.Almacen)

[Acciones.Proveedor.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Copiar]
Nombre=Copiar
Boton=0
NombreDesplegar=&Copiar
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=F5
Expresion=Asigna(CompraSugerir:CompraSugerir.CantidadA, CompraSugerir:CompraSugerir.Cantidad)
ActivoCondicion=ConDatos(CompraSugerir:CompraSugerir.Articulo)

[Lista.CompraSugerir.ClaveProveedor]
Carpeta=Lista
Clave=CompraSugerir.ClaveProveedor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.AceptarTodo]
Nombre=AceptarTodo
Boton=55
NombreDesplegar=Aceptar &Todo
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Antes=S
Visible=S
AntesExpresiones=EjecutarSQL(<T>spCompraSugerirAceptar :nEstacion, :nSucursal, :tEmp, :nID, 1<T>, EstacionTrabajo, Sucursal, Empresa, Info.ID)

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=Artícul&o
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CompraSugerir:CompraSugerir.Articulo)
AntesExpresiones=Asigna(Info.Articulo, CompraSugerir:CompraSugerir.Articulo)

[Acciones.Almacen]
Nombre=Almacen
Boton=16
NombreEnBoton=S
NombreDesplegar=A&lmacén
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EspecificarAlmacen
Activo=S
Visible=S
Multiple=S
ConCondicion=S
ListaAccionesMultiples=SQL<BR>Actualizar Forma
EjecucionCondicion=Forma(<T>EspecificarAlmacen<T>)

[Acciones.Almacen.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spCompraSugerir :nEstacion, :nID, :tCliente, :tProveedor, :tAlmacen<T>, EstacionTrabajo, Info.ID, Info.Cliente, Info.Proveedor, Info.Almacen)

[Acciones.Almacen.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Lista.CompraSugerir.UnidadCompra]
Carpeta=Lista
Clave=CompraSugerir.UnidadCompra
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Cliente]
Nombre=Cliente
Boton=60
NombreEnBoton=S
NombreDesplegar=&Cliente
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S
EspacioPrevio=S
ListaAccionesMultiples=SQL<BR>Actualizar Forma
ConCondicion=S
EjecucionCondicion=Forma(<T>EspecificarCliente<T>)

[Acciones.Cliente.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spCompraSugerir :nEstacion, :nID, :tCliente, :tProveedor, :tAlmacen<T>, EstacionTrabajo, Info.ID, Info.Cliente, Info.Proveedor, Info.Almacen)

[Acciones.Cliente.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Recalcular]
Nombre=Recalcular
Boton=92
NombreDesplegar=<T>Recalcular<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S
ActivoCondicion=Config.CompraSugerirArtR
AntesExpresiones=ProcesarSQL(<T>spReconstruirArtR<T>)<BR>EjecutarSQL(<T>spCompraSugerir :nEstacion, :nID, :tCliente, :tProveedor, :tAlmacen<T>, EstacionTrabajo, Info.ID, Info.Cliente, Info.Proveedor, Info.Almacen)

[Lista.Art.Codigo]
Carpeta=Lista
Clave=Art.Codigo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=AceptarTodo
AceptarTodo=Cancelar
Cancelar=CambiarVista
CambiarVista=Cliente
Cliente=Proveedor
Proveedor=Almacen
Almacen=Recalcular
Recalcular=ArtInfo
ArtInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CompraSugerir.Articulo
CompraSugerir.Articulo=Art.Codigo
Art.Codigo=CompraSugerir.ClaveProveedor
CompraSugerir.ClaveProveedor=CompraSugerir.SubCuenta
CompraSugerir.SubCuenta=CompraSugerir.Cliente
CompraSugerir.Cliente=MovNombre
MovNombre=CompraSugerir.FechaEmision
CompraSugerir.FechaEmision=CompraSugerir.FechaRequerida
CompraSugerir.FechaRequerida=CompraSugerir.Almacen
CompraSugerir.Almacen=CompraSugerir.UnidadCompra
CompraSugerir.UnidadCompra=CompraSugerir.Cantidad
CompraSugerir.Cantidad=CompraSugerir.CantidadA
CompraSugerir.CantidadA=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=Cte.Nombre
Cte.Nombre=CompraSugerir.Referencia
CompraSugerir.Referencia=CompraSugerir.Paquete
CompraSugerir.Paquete=CompraSugerir.Precio
CompraSugerir.Precio=CompraSugerir.Descuento
CompraSugerir.Descuento=(Fin)

[Lista.ListaOrden]
(Inicio)=CompraSugerir.Cliente<TAB>(Acendente)
CompraSugerir.Cliente<TAB>(Acendente)=CompraSugerir.Modulo<TAB>(Acendente)
CompraSugerir.Modulo<TAB>(Acendente)=CompraSugerir.ModuloID<TAB>(Acendente)
CompraSugerir.ModuloID<TAB>(Acendente)=CompraSugerir.Articulo<TAB>(Acendente)
CompraSugerir.Articulo<TAB>(Acendente)=CompraSugerir.FechaRequerida<TAB>(Acendente)
CompraSugerir.FechaRequerida<TAB>(Acendente)=(Fin)
