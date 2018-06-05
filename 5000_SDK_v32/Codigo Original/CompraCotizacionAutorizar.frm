[Forma]
Clave=CompraCotizacionAutorizar
Icono=24
Modulos=(Todos)
Nombre=Autorizar Cotizaciones
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=231
PosicionInicialArriba=114
PosicionInicialAlturaCliente=457
PosicionInicialAncho=818
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

Totalizadores=S
PosicionSec1=399
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraConfirmarD
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
FiltroFechasCampo=CompraConfirmarD.FechaEmision
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

FiltroAplicaEn1=Art.Linea
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtGrupo
FiltroAplicaEn2=Art.Familia
FiltroAplicaEn3=Art.Grupo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ActCat
FiltroAplicaEn4=Art.Categoria
IconosNombre=CompraConfirmarD:CompraConfirmarD.Articulo
FiltroGeneral=CompraConfirmarD.MovTipo=<T>COMS.C<T><BR>{Si(no Config.CompraMultiEmpresas, <T> AND CompraConfirmarD.Empresa=<T>+Comillas(Empresa), <T><T>)}
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
[Lista.CompraConfirmarD.CantidadPendiente]
Carpeta=Lista
Clave=CompraConfirmarD.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraConfirmarD.Costo]
Carpeta=Lista
Clave=CompraConfirmarD.Costo
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
1=135

2=-2
3=-2
4=94
5=92
Mov=300
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

[Acciones.GenerarOC]
Nombre=GenerarOC
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar &Ordenes Compra
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Lista.CompraConfirmarD.Empresa]
Carpeta=Lista
Clave=CompraConfirmarD.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro














[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=CompraConfirmarD.CantidadPendiente
CompraConfirmarD.CantidadPendiente=CompraConfirmarD.Costo
CompraConfirmarD.Costo=Movimiento
Movimiento=CompraConfirmarD.Empresa
CompraConfirmarD.Empresa=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)












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
Totalizadores2=SUMA(CompraConfirmarD:CompraConfirmarD.Costo)<BR>SUMA(CompraConfirmarD:CompraConfirmarD.Cantidad)
Totalizadores3=(Monetario)<BR>(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S

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






















[Acciones.GenerarOC.GenerarOC]
Nombre=GenerarOC
Boton=0
TipoAccion=Formas
ClaveAccion=GenerarOC
Activo=S
Visible=S

[Acciones.GenerarOC.Procesar]
Nombre=Procesar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S






Expresion=RegistrarSeleccionIDRenglon( <T>Lista<T>, <T>CompraConfirmarD.Modulo<T>, <T>CompraConfirmarD.ID<T>, <T>CompraConfirmarD.Renglon<T>, <T>CompraConfirmarD.RenglonSub<T>)<BR>Asigna( Temp.Num, SQL( <T>select dbo.fnCompraCotizacionAutorizarValida (:nEstacio)<T>,  EstacionTrabajo ) )<BR><BR>Si Temp.Num = 1<BR>Entonces<BR>  ProcesarSQL(<T>spCompraCotizacionAutorizar :nEstacion, :tEmpresa, :nSucursal, :tUsuario, :fFecha, :tMov<T>,  EstacionTrabajo, Empresa, Sucursal, Usuario, FechaTrabajo, Info.MovGenerar)<BR>Sino<BR> Informacion(<T>Verifique que ha seleccionado todos los Articulos de la cotización<T>)<BR>Fin
EjecucionCondicion=ConDatos(Info.MovGenerar)


[Acciones.GenerarOC.ListaAccionesMultiples]
(Inicio)=GenerarOC
GenerarOC=Procesar
Procesar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=GenerarOC
GenerarOC=Personalizar
Personalizar=(Fin)
