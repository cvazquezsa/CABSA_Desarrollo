[Forma]
Clave=CompraCotizacionGenerar
Icono=24
Modulos=(Todos)
Nombre=Generar Cotizaciones / Licitaciones
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=158
PosicionInicialArriba=133
PosicionInicialAlturaCliente=419
PosicionInicialAncho=964
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

Totalizadores=S
PosicionSec1=360
PosicionSec2=202
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraPendienteD
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=CompraPendienteD.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtLinea
FiltroTodo=S
FiltroTodoFinal=S

FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtCat
FiltroAplicaEn1=Art.Linea
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Categoria
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=ActGrupo
FiltroAplicaEn5=Art.Grupo
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
IconosNombre=CompraPendienteD:CompraPendienteD.Articulo
FiltroGeneral=CompraPendienteD.MovTipo=<T>COMS.R<T><BR>{Si(no Config.CompraMultiEmpresas, <T> AND CompraPendienteD.Empresa=<T>+Comillas(Empresa), <T><T>)}
[Lista.CompraPendienteD.CantidadPendiente]
Carpeta=Lista
Clave=CompraPendienteD.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.Costo]
Carpeta=Lista
Clave=CompraPendienteD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Movimiento]
Carpeta=Lista
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=74
1=112

2=69
3=97
4=-2
5=-2
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

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.GenerarCotizacion]
Nombre=GenerarCotizacion
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar C&otizaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

RefrescarDespues=S
Expresion=Si<BR>  Forma(<T>EspecificarProveedor<T>)<BR>Entonces<BR>  Si<BR>    ConDatos(Info.Proveedor)<BR>  Entonces<BR>    RegistrarSeleccionIDRenglon( <T>Lista<T>, <T>CompraPendienteD.Modulo<T>, <T>CompraPendienteD.ID<T>, <T>CompraPendienteD.Renglon<T>, <T>CompraPendienteD.RenglonSub<T>)<BR>    ProcesarSQL(<T>spCompraCotizacionGenerar :nEstacion, :tEmpresa, :nSucursal, :tUsuario, :fFecha, :tProveedor, :tMov<T>,  EstacionTrabajo, Empresa, Sucursal, Usuario, FechaTrabajo, Info.Proveedor, ConfigMov.CompraCotizacion)<BR>  Fin<BR>Fin
[Acciones.GenerarLicitacion]
Nombre=GenerarLicitacion
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar &Licitación
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>  Forma(<T>EspecificarProveedor<T>)<BR>Entonces<BR>  Si<BR>    ConDatos(Info.Proveedor)<BR>  Entonces<BR>    RegistrarSeleccionIDRenglon( <T>Lista<T>, <T>CompraPendienteD.Modulo<T>, <T>CompraPendienteD.ID<T>, <T>CompraPendienteD.Renglon<T>, <T>CompraPendienteD.RenglonSub<T>)<BR>    ProcesarSQL(<T>spCompraCotizacionGenerar :nEstacion, :tEmpresa, :nSucursal, :tUsuario, :fFecha, :tProveedor, :tMov<T>,  EstacionTrabajo, Empresa, Sucursal, Usuario, FechaTrabajo, Info.Proveedor, ConfigMov.CompraLicitacion)<BR>  Fin<BR>Fin

[Lista.CompraPendienteD.Empresa]
Carpeta=Lista
Clave=CompraPendienteD.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro




[Acciones.GenerarOrdenCompra]
Nombre=GenerarOrdenCompra
Boton=7
NombreDesplegar=Generar O&rden Compra
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S





NombreEnBoton=S
EspacioPrevio=S
Expresion=Si<BR>  Forma(<T>EspecificarProveedor<T>)<BR>Entonces<BR>  Si<BR>    ConDatos(Info.Proveedor)<BR>  Entonces<BR>    RegistrarSeleccionIDRenglon( <T>Lista<T>, <T>CompraPendienteD.Modulo<T>, <T>CompraPendienteD.ID<T>, <T>CompraPendienteD.Renglon<T>, <T>CompraPendienteD.RenglonSub<T>)<BR>    ProcesarSQL(<T>spCompraCotizacionGenerar :nEstacion, :tEmpresa, :nSucursal, :tUsuario, :fFecha, :tProveedor, :tMov<T>,  EstacionTrabajo, Empresa, Sucursal, Usuario, FechaTrabajo, Info.Proveedor, ConfigMov.CompraOrden)<BR>  Fin<BR>Fin

































































[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Costo<BR>Cantidad
Totalizadores2=Suma(CompraPendienteD:CompraPendienteD.Costo)<BR>suma(CompraPendienteD:CompraPendienteD.Cantidad)
Totalizadores3=(Monetario)<BR>(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S

















ListaEnCaptura=(Lista)

[(Carpeta Totalizadores).Costo]
Carpeta=(Carpeta Totalizadores)
Clave=Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro













[(Carpeta Totalizadores).Cantidad]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro




[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Costo
Costo=Cantidad
Cantidad=(Fin)







[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=CompraPendienteD.CantidadPendiente
CompraPendienteD.CantidadPendiente=CompraPendienteD.Costo
CompraPendienteD.Costo=Movimiento
Movimiento=CompraPendienteD.Empresa
CompraPendienteD.Empresa=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=GenerarCotizacion
GenerarCotizacion=GenerarLicitacion
GenerarLicitacion=GenerarOrdenCompra
GenerarOrdenCompra=Personalizar
Personalizar=(Fin)
