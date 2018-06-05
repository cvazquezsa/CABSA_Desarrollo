[Forma]
Clave=VentaPOS
Nombre=Info.ModuloVentasNombre
Icono=0
Modulos=VTAS
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=369
PosicionInicialArriba=95
PosicionInicialAltura=579
PosicionInicialAncho=861
EsMovimiento=S
TituloAuto=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=49
PosicionSeccion2=93
BarraHerramientas=S
BarraAyuda=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
MovModulo=VTAS
BarraAyudaBold=S
AutoGuardarEncabezado=S
TituloAutoNombre=S
Menus=S
PosicionInicialAlturaCliente=632
Totalizadores=S
PosicionSec1=276
PosicionSec2=494
VentanaEstadoInicial=Normal

ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Positivos, Verdadero)<BR>Asigna(Info.Paquete, Nulo)<BR>Asigna(Info.RefrescandoPrecio, Falso)<BR>Asigna(Info.ABC, Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Aseguradora, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)<BR>SI(VentaPOS:VentaPOS.Estatus=EstatusSinAfectar,EjecutarSQL(<T>spPOSBorrarVentaPOS :nID<T>,VentaPOS:VentaPOS.ID))
MenuPrincipal=(Lista)
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
Vista=VentaPOS
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
GuardarAlSalir=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=VentaPOS.ID={Info.ID}
FiltroRespetar=S
FiltroTipo=General
[Ficha.VentaPOS.Mov]
Carpeta=Ficha
Clave=VentaPOS.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ficha.VentaPOS.MovID]
Carpeta=Ficha
Clave=VentaPOS.MovID
3D=S
Pegado=S
Tamano=11
ColorFondo=Plata
Editar=S
IgnoraFlujo=S

[Ficha.VentaPOS.Proyecto]
Carpeta=Ficha
Clave=VentaPOS.Proyecto
Editar=S
ValidaNombre=S
3D=S
Tamano=15
Pegado=S
ColorFondo=Blanco

[Ficha.VentaPOS.Moneda]
Carpeta=Ficha
Clave=VentaPOS.Moneda
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco

[Ficha.VentaPOS.FechaEmision]
Carpeta=Ficha
Clave=VentaPOS.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=N
ColorFondo=Blanco

[Ficha.VentaPOS.Almacen]
Carpeta=Ficha
Clave=VentaPOS.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=N
ColorFondo=Blanco

[Ficha.VentaPOS.Cliente]
Carpeta=Ficha
Clave=VentaPOS.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=S
ColorFondo=Blanco

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
Efectos=[Negritas]
LineaNueva=N
ValidaNombre=N
Pegado=N

[Ficha.VentaPOS.Condicion]
Carpeta=Ficha
Clave=VentaPOS.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.VentaPOS.Vencimiento]
Carpeta=Ficha
Clave=VentaPOS.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.VentaPOS.Agente]
Carpeta=Ficha
Clave=VentaPOS.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=N
ColorFondo=Blanco
EditarConBloqueo=N

[Notas.VentaPOS.Referencia]
Carpeta=Notas
Clave=VentaPOS.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25

[Notas.VentaPOS.Observaciones]
Carpeta=Notas
Clave=VentaPOS.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N
ColorFondo=Blanco

[Ficha.VentaPOS.Descuento]
Carpeta=Ficha
Clave=VentaPOS.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco

[Ficha.VentaPOS.OrdenCompra]
Carpeta=Ficha
Clave=VentaPOS.OrdenCompra
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco

[Ficha.VentaPOS.Referencia]
Carpeta=Ficha
Clave=VentaPOS.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle]
Estilo=Hoja
Clave=Detalle
OtroOrden=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=VentaDPOS
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=VentaPOS
LlaveLocal=VentaDPOS.ID
LlaveMaestra=VentaPOS.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=VentaDPOS.Renglon<TAB>(Acendente)
CarpetaVisible=S
ControlRenglon=S
CampoRenglon=VentaDPOS.Renglon
ControlRenglonID=S
ControlRenglonTipo=S
HojaColoresPorTipo=S
CampoDespliegaTipo=Art.Tipo
ListaEnCaptura=(Lista)
ValidarCampos=S
ListaCamposAValidar=(Lista)
MenuLocal=S
ListaAcciones=(Lista)
ConResumen=S
ResumenVista=VentaR
ResumenLlave=ID
ResumenCampos=(Lista)
ResumenVistaMaestra=VentaPOS
ResumenLlaveMaestra=VentaPOS.ID
HojaFondoGrisAuto=S
PermiteLocalizar=S
HojaAjustarColumnas=S
CondicionAutoBloqueo=Config.VentaAutoBloqueo
CampoDespliegaTipoOpcion=Art.TipoOpcion
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral={Si((Info.SubModuloVenta=<T>AUTO<T>) y (Usuario.AutoArtGrupo<><T><T>) y (Usuario.AutoArtGrupo<>Nulo), <T>Art.Grupo=<T>+Comillas(Usuario.AutoArtGrupo), <T><T>)}
[Detalle.VentaDPOS.Articulo]
Carpeta=Detalle
Clave=VentaDPOS.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaDPOS.SubCuenta]
Carpeta=Detalle
Clave=VentaDPOS.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Detalle.VentaDPOS.Cantidad]
Carpeta=Detalle
Clave=VentaDPOS.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaDPOS.Precio]
Carpeta=Detalle
Clave=VentaDPOS.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
IgnoraFlujo=N
ColorFondo=Blanco

[Detalle.Importe]
Carpeta=Detalle
Clave=Importe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
IgnoraFlujo=S
ColorFondo=Blanco

[Detalle.Columnas]
Articulo=87
SubCuenta=99
Cantidad=48
Disponible=55
Precio=77
DescTipo=29
Descuento=35
Importe=87
CantidadA=47
DescuentoLinea=36
DescuentoTipo=28
Costo=76
CostoTotal=77
Aplica=100
AplicaID=64
Paquete=45
ContUso=76
Unidad=41
CantidadNeta=47
CantidadReservada=57
CantidadOrdenada=52
CantidadPendiente=53
FechaRequerida=88
Instruccion=58
CantidadInventario=54
Almacen=60
Agente=64
AplicaNombre=116
Departamento=33
PrecioNeto=168
DescuentoImporte=54
ClaveIdioma=74
AutoLocalidad=68
SustitutoArticulo=76
UEN=25
Espacio=42
HoraRequerida=33
CantidadInvNeta=53
SustitutoSubCuenta=71
SubImpuesto1=74
SubImpuesto2=72
SubImpuesto3=76
Horas=32
Estado=85
ServicioNumero=54
AgentesAsignados=44
AFArticulo=72
AFSerie=76
ExcluirPlaneacion=36
Codigo=97
EnviarA=80
ExcluirISAN=64
Posicion=64
DescripcionExtra=245
PresupuestoEsp=114
PrecioMoneda=48
PrecioTipoCambio=64
ProveedorRef=57
ImporteSobrePrecio=64
TransferirA=64
Tarima=79
ContUso2=124
ContUso3=124
ABC=83

VolumenTotal=54
PesoTotal=50
TipoImpuesto1=70
TipoImpuesto2=72
TipoImpuesto3=83
Impuesto1=35
Impuesto2=42
Impuesto3=64
TipoComprobante=143
SustentoComprobante=171
TipoIdentificacion=103
DerechoDevolucion=189
Establecimiento=124
PuntoEmision=83
SecuencialSRI=84
AutorizacionSRI=92
VigenteA=112
SecuenciaRetencion=122
Comprobante=69
FechaContableMov=136
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=VentaAPOS
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosConPaginas=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=VentaPOS.ID<TAB>(Acendente)
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=VentaPOS.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=movimientos
FiltroFechasNormal=S
BusquedaRespetarUsuario=S
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroAplicaEn=VentaPOS.Moneda
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
BusquedaRespetarControlesNum=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=VentaPOS.FechaCancelacion
FiltroSucursales=S
FiltroUENsCampo=VentaPOS.UEN
FiltroAutorizar=S


IconosNombre=VentaAPOS:VentaPOS.Mov+<T> <T>+VentaAPOS:VentaPOS.MovID
FiltroEstilo=Directorio
FiltroGeneral={Si(SQL(<T>SELECT ISNULL(Filtrar, 0) FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSub<T>, <T>VTAS<T>, Info.SubModuloVenta), <T>Venta.SubModulo=<T>+Comillas(Info.SubModuloVenta), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Mov), <T> AND Venta.Mov=<T>+Comillas(Filtro.Mov), <T><T>)}<BR>{Si<BR>  ConDatos(Filtro.Cliente) y ConDatos(Filtro.Aseguradora)<BR>Entonces<BR>  <T> AND VentaPOS.Cliente IN (<T>+Comillas(Filtro.Cliente)+<T>, <T>+Comillas(Filtro.Aseguradora)+<T>)<T><BR>Sino<BR>  Si(ConDatos(Filtro.Cliente), <T> AND VentaPOS.Cliente=<T>+Comillas(Filtro.Cliente), <T><T>)<BR>Fin}
[(Carpeta Abrir).Columnas]
0=138
1=69

2=156
3=-2
4=-2
5=113
6=72
7=-2
8=-2
[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Derecha
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Importe<BR>Desc<BR>Sub<BR>Impto<BR>Total<BR>Volumen<BR>Sobre Precio<BR>Peso<BR>Renglon
Totalizadores2=Suma(VentaDPOS:Importe)<BR>-Suma(VentaDPOS:DescGlobal)<BR>Suma(VentaDPOS:SubTotal)<BR>Suma(VentaDPOS:Impuesto)<BR>Redondea(Suma(VentaDPOS:ImporteTotal), Config.VentaCobroRedondeoDecimales)-VentaPOS:VentaPOS.AnticiposFacturados-VentaPOS:VentaPOS.Retencion<BR>Suma(VentaDPOS:VolumenTotal)<BR>Suma(VentaDPOS:ImporteSobrePrecio)<BR>Suma(VentaDPOS:PesoTotal)<BR>Conteo(VentaDPOS:VentaDPOS.Articulo)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>#,.##<BR> <BR>#,.##
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S



[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=S
Activo=S
Antes=S
ConCondicion=S
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(VentaPOS:VentaPOS.ID) y (VentaPOS:VentaPOS.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, VentaPOS:VentaPOS.ID, <T>VTAS<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>ConDatos(VentaPOS:VentaPOS.Cliente) y ConDatos(VentaPOS:VentaPOS.Almacen)
AntesExpresiones=Asigna(VentaPOS:VentaPOS.Importe, Suma(VentaDPOS:Importe))<BR>Asigna(VentaPOS:VentaPOS.Impuestos, Suma(VentaDPOS:Impuesto))

[Ficha.VentaPOS.FechaRequerida]
Carpeta=Ficha
Clave=VentaPOS.FechaRequerida
Editar=S
ValidaNombre=S
3D=S
Tamano=15
EditarConBloqueo=N
ColorFondo=Blanco
Pegado=N


[Acciones.Cambiar Vista Hoja]
Nombre=Cambiar Vista Hoja
Boton=0
NombreDesplegar=Cambiar Vista Hoja
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle-Resumen)
Visible=S
Activo=S

[Acciones.Asistente Articulos]
Nombre=Asistente Articulos
Boton=12
NombreDesplegar=Asistente Artículos
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=VentaDPOS:VentaDPOS.Articulo<BR>VentaDPOS:VentaDPOS.Almacen<BR>VentaDPOS:VentaDPOS.SubCuenta<BR>VentaDPOS:VentaDPOS.Cantidad<BR>VentaDPOS:VentaDPOS.Precio<BR>MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.D,VTAS.DF,VTAS.B,VTAS.DC,VTAS.DCR))<BR>Nulo<BR>MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.SG,VTAS.EG,VTAS.VC,VTAS.VCR))<BR>MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.P,VTAS.S,VTAS.PR,VTAS.EST))<BR>VentaDPOS:Art.Descripcion1<BR>VentaDPOS:Art.Tipo<BR>VentaDPOS:Art.Unidad<BR>VentaDPOS:Art.PrecioLista<BR>VentaDPOS:Art.TipoOpcion<BR>VentaDPOS:Art.Espacios<BR>VentaDPOS:VentaDPOS.FechaRequerida<BR>VentaDPOS:VentaDPOS.HoraRequerida<BR>VentaDPOS:VentaDPOS.Espacio<BR><T>VTAS<T><BR>VentaPOS:VentaPOS.ID<BR>VentaPOS:VentaPOS.Cliente
ListaParametros=S
Visible=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F7
EspacioPrevio=S

ActivoCondicion=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
[Notas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Información adicional
Clave=Notas
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaPOS
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
CondicionEdicion=Vacio(VentaPOS:VentaPOS.AnexoID)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Visible=S
Activo=S

[Acciones.Totalizar]
Nombre=Totalizar
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Totalizar
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
RefrescarDespues=S

Expresion=Si(General.OFER, EjecutarSQL(<T>spOfertaAplicar :nID<T>, VentaPOS:VentaPOS.ID))<BR>Si(Config.VentaCteArtEmpaqueCorrugado, EjecutarSQL(<T>spCalculaEmpaques :nID, :tModulo, :nSucursal<T>, VentaPOS:VentaPOS.ID, <T>VTAS<T>, Sucursal))
ActivoCondicion=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
[Detalle.VentaDPOS.CantidadA]
Carpeta=Detalle
Clave=VentaDPOS.CantidadA
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=<T>A&fectar<T>
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
MultipleConOpciones=
ConCondicion=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S

Multiple=S
ListaAccionesMultiples=(Lista)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, VentaPOS:VentaPOS.Usuario) y <BR>(VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusRecurrente)) y<BR>PuedeAvanzarEstatus(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, VentaPOS:VentaPOS.Estatus, FormaSituacion)
EjecucionCondicion=ConDatos(VentaPOS:VentaPOS.Mov) y ConDatos(VentaPOS:VentaPOS.Almacen)
AntesExpresiones=Asigna(Info.MovProcesar, ConfigMov.AutoRecaudacion)<BR>Si(General.AdvertirProyectosExpirados, Si(SQL(<T>SELECT COUNT(*) FROM Proy WHERE (Estatus = :tBaja OR FechaFin+1<GETDATE()) AND Proyecto=:tProy<T>, EstatusBaja, VentaPOS:VentaPOS.Proyecto) > 0, Si(Precaucion(<T>Proyecto Expirado<T>, BotonAceptar, BotonCancelar)=BotonCancelar, AbortarOperacion)))<BR>Si<BR>  (MovTipo(<T>VTAS<T>, VentaPOS:VentaPOS.Mov)=VTAS.P) <BR>Entonces<BR>  Si<BR>    General.Autotransportes<BR>  Entonces<BR>    Caso VentaPOS:VentaPOS.Mov<BR>      Es ConfigMov.AutoPapeleta Entonces Asigna(Info.Dialogo, <T>GenerarAutoPapeleta<T>)<BR>      Es <T>Orden Mantenimiento<T>  Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenMantenimiento<T>)<BR>      Es <T>Orden Reparacion Int<T> Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenReparacionInt<T>)<BR>      Es <T>Orden Reparacion Ext<T> Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenReparacionExt<T>)<BR>      Es <T>Orden Reparacion Ter<T> Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenReparacionTer<T>)<BR>    Sino<BR>      Asigna(Info.Dialogo, <T>GenerarPedido<T>)<BR>    Fin   <BR>  Sino<BR>    Caso VentaPOS:VentaPOS.Mov<BR>      Es ConfigMov.VentaReservacion Entonces Asigna(Info.Dialogo, <T>GenerarReservacion<T>)<BR>      Es ConfigMov.VentaIngreso Entonces Asigna(Info.Dialogo, <T>GenerarVentaIngreso<T>)<BR>    Sino<BR>      Asigna(Info.Dialogo, <T>GenerarPedido<T>)<BR>    Fin<BR>  Fin<BR>Fin<BR>Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>VTAS<T>, VentaPOS:VentaPOS.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, VentaPOS:VentaPOS.ID, Verdadero, VentaPOS:VentaPOS.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>Fin
[Detalle.ColumnasResumen]
Articulo=143
Descripcion1=184
Cantidad=62
Precio=100
DescTipo=27
Descuento=43
Importe=109
Descripcion=238
DescuentoLinea=33
DescuentoTipo=25
Almacen=57



[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]
Pegado=S

[Acciones.Catalogos]
Nombre=Catalogos
Boton=48
Menu=&Ver
NombreDesplegar=&Catálogos
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Catalogos Articulos
ListaParametros1=VentaDPOS:VentaDPOS.Articulo<BR>VentaPOS:VentaPOS.Almacen<BR>VentaDPOS:VentaDPOS.Cantidad
ListaParametros=S
Visible=S


ActivoCondicion=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
[Detalle.VentaDPOS.DescuentoLinea]
Carpeta=Detalle
Clave=VentaDPOS.DescuentoLinea
Editar=S
IgnoraFlujo=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+I
NombreDesplegar=Información del &Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=POSArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos( VentaDPOS:VentaDPOS.Articulo)
AntesExpresiones=Asigna( Info.Origen, <T>VTAS<T>)<BR>Asigna( Info.Articulo, VentaDPOS:VentaDPOS.Articulo )<BR>Asigna( Info.ArtTipo, VentaDPOS:Art.Tipo)
[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
Menu=&Ver
NombreDesplegar=Información del &Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=POSCteInfo
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EnBarraHerramientas=S
ConCondicion=S

ActivoCondicion=Usuario.CteInfo
EjecucionCondicion=ConDatos(VentaPOS:VentaPOS.Cliente)
AntesExpresiones=Asigna(Info.Origen, <T>VTAS<T>)<BR>Asigna( Info.Cliente,VentaPOS:VentaPOS.Cliente )
[Ficha.VentaPOS.AlmacenDestino]
Carpeta=Ficha
Clave=VentaPOS.AlmacenDestino
Editar=S
3D=S
Tamano=15
ValidaNombre=N
ColorFondo=Blanco

[Detalle.VentaDPOS.Costo]
Carpeta=Detalle
Clave=VentaDPOS.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.CostoTotal]
Carpeta=Detalle
Clave=CostoTotal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir...
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
ListaParametros1=VentaPOS:VentaPOS.ID
Visible=S
GuardarAntes=S
Expresion=Asigna(Info.Descripcion, SQL(<T>EXEC spAbrirAnexo :tModulo, :nID<T>, <T>VTAS<T>, VentaPOS:VentaPOS.ID))<BR>Si (Info.Descripcion <> NULO) Y (Archivo.Leer(Info.Descripcion) <> <T><T>)<BR>Entonces<BR>  VerImagen(<T><T>, Info.Descripcion)<BR>Sino<BR>  ReporteImpresora(ReporteMovImpresora(Info.SubModuloVenta, VentaPOS:VentaPOS.Mov, VentaPOS:VentaPOS.Estatus), VentaPOS:VentaPOS.ID)<BR>Fin
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentación preliminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=VentaPOS:VentaPOS.ID
Visible=S
GuardarAntes=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=Asigna(Info.Descripcion, SQL(<T>EXEC spAbrirAnexo :tModulo, :nID<T>, <T>VTAS<T>, VentaPOS:VentaPOS.ID))<BR>Si (Info.Descripcion <> NULO) Y (Archivo.Leer(Info.Descripcion) <> <T><T>)<BR>Entonces<BR>  VerImagen(<T><T>, Info.Descripcion)<BR>Sino<BR>  ReportePantalla(ReporteMovPantalla(Info.SubModuloVenta, VentaPOS:VentaPOS.Mov, VentaPOS:VentaPOS.Estatus), VentaPOS:VentaPOS.ID)<BR>Fin
ActivoCondicion=Usuario.PreliminarMovs

[Ficha.VentaPOS.TipoCambio]
Carpeta=Ficha
Clave=VentaPOS.TipoCambio
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Acciones.Asistente Precios]
Nombre=Asistente Precios
Boton=0
NombreDesplegar=Asistente Precios
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Precios
ListaParametros1=VentaDPOS:VentaDPOS.Articulo<BR>VentaDPOS:VentaDPOS.SubCuenta<BR>VentaDPOS:Art.Grupo<BR>VentaDPOS:Art.Categoria<BR>VentaDPOS:Art.Familia<BR>VentaDPOS:Art.ABC<BR>VentaDPOS:Art.Fabricante<BR>VentaDPOS:Art.Linea<BR>VentaDPOS:Art.Rama<BR>VentaPOS:VentaPOS.Cliente<BR>VentaPOS:Cte.Grupo<BR>VentaPOS:Cte.Categoria<BR>VentaPOS:Cte.Familia<BR>VentaPOS:Cte.Zona<BR>VentaPOS:VentaPOS.Moneda<BR>VentaPOS:VentaPOS.Condicion<BR>VentaDPOS:VentaDPOS.Almacen<BR>VentaPOS:VentaPOS.Proyecto<BR>VentaPOS:VentaPOS.Agente<BR>VentaPOS:VentaPOS.FormaEnvio<BR>VentaPOS:VentaPOS.Mov<BR>VentaPOS:VentaPOS.ServicioTipo<BR>VentaPOS:VentaPOS.ServicioContratoTipo<BR>VentaDPOS:VentaDPOS.Unidad<BR>VentaPOS:VentaPOS.Empresa<BR>VentaDPOS:VentaDPOS.Cantidad<BR>VentaDPOS:VentaDPOS.Unidad<BR>VentaDPOS:Art.PrecioLista<BR>VentaDPOS:Art.MonedaPrecio<BR>VentaPOS:VentaPOS.TipoCambio<BR>VentaDPOS:VentaDPOS.DescuentoImporte<BR>VentaDPOS:VentaDPOS.DescuentoLinea<BR>VentaPOS:VentaPOS.ListaPreciosEsp<BR>VentaDPOS:Art.Precio2<BR>VentaDPOS:Art.Precio3<BR>VentaDPOS:Art.Precio4<BR>VentaDPOS:Art.Precio5<BR>VentaDPOS:Art.Precio6<BR>VentaDPOS:Art.Precio7<BR>VentaDPOS:Art.Precio8<BR>VentaDPOS:Art.Precio9<BR>VentaDPOS:Art.Precio10<BR>VentaDPOS:VentaDPOS.Precio<BR>VentaDPOS:VentaDPOS.PoliticaPrecios<BR>VentaDPOS:VentaDPOS.PrecioMoneda<BR>VentaDPOS:VentaDPOS.PrecioTipoCambio<BR>VentaPOS:CteEnviarA.Grupo<BR>VentaPOS:CteEnviarA.Categoria<BR>VentaPOS:CteEnviarA.Familia
ListaParametros=S
Activo=S
Visible=S

[Acciones.ActualizarPoliticasPrecios]
Nombre=ActualizarPoliticasPrecios
Boton=0
Menu=&Archivo
NombreDesplegar=&Actualizar Políticas de Precios
EnMenu=S
TipoAccion=Otros
ClaveAccion=Actualizar Politicas Precios y Descuentos

[Acciones.VerPoliticaPrecios]
Nombre=VerPoliticaPrecios
Boton=0
Menu=&Ver
NombreDesplegar=P&olíticas de Precios Aplicadas
EnMenu=S
TipoAccion=Dialogos
Activo=S
Visible=S
EspacioPrevio=S
ClaveAccion=VerPoliticasPrecios
Antes=S
AntesExpresiones=Asigna(Info.Articulo, VentaDPOS:VentaDPOS.Articulo)<BR>Asigna(Info.SubCuenta, VentaDPOS:VentaDPOS.SubCuenta)<BR>Asigna(Info.Descripcion, VentaDPOS:Art.Descripcion1)<BR>Asigna(Info.Mensaje, VentaDPOS:VentaDPOS.PoliticaPrecios)



[Notas.VentaPOS.Prioridad]
Carpeta=Notas
Clave=VentaPOS.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=12
LineaNueva=N
EspacioPrevio=N
ColorFondo=Blanco

[Ficha.VentaPOS.Directo]
Carpeta=Ficha
Clave=VentaPOS.Directo
Editar=S
3D=S
Tamano=16
Pegado=N
ColorFondo=Blanco

[Acciones.Asistente Codigo Barras]
Nombre=Asistente Codigo Barras
Boton=42
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Mayús+F7
NombreDesplegar=Asistente Códigos de Barras
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Codigo Barras (1x1)
ListaParametros=S
Visible=S
ListaParametros1=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)<BR>VentaPOS:VentaPOS.Estatus=EstatusPendiente<BR>VentaDPOS:VentaDPOS.Cantidad<BR>VentaDPOS:VentaDPOS.CantidadPendiente<BR>VentaDPOS:VentaDPOS.CantidadReservada<BR>VentaDPOS:VentaDPOS.CantidadA<BR>VentaDPOS:VentaDPOS.SubCuenta<BR>VentaDPOS:VentaDPOS.Unidad<BR>VentaDPOS:VentaDPOS.Articulo<BR>VentaPOS:VentaPOS.Cliente<BR>VentaPOS:VentaPOS.Agente<BR>VentaPOS:VentaPOS.Almacen<BR>Nulo<BR>Nulo<BR>VentaPOS:Cte.Idioma<BR>Config.CBPreguntarCantidad<BR>Falso
ActivoCondicion=Config.CB y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente))

[Acciones.Asistente Codigo Barras (Lote)]
Nombre=Asistente Codigo Barras (Lote)
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=Asistente Códigos de Barras (en Lote)
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Codigo Barras (Lote)
ListaParametros=S
ListaParametros1=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>VentaPOS:VentaPOS.Estatus=EstatusPendiente<BR>VentaDPOS:VentaDPOS.Cantidad<BR>VentaDPOS:VentaDPOS.CantidadPendiente<BR>VentaDPOS:VentaDPOS.CantidadReservada<BR>VentaDPOS:VentaDPOS.CantidadA<BR>VentaDPOS:VentaDPOS.SubCuenta<BR>VentaDPOS:VentaDPOS.Unidad<BR>VentaDPOS:VentaDPOS.Articulo<BR>VentaPOS:VentaPOS.Cliente<BR>VentaPOS:VentaPOS.Agente<BR>VentaPOS:VentaPOS.Almacen<BR>Nulo<BR>Nulo<BR>VentaPOS:Cte.Idioma<BR>VentaPOS:VentaPOS.ID<BR>Verdadero<BR>Config.CBProcesarLote<BR>MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.DR,VTAS.SG,VTAS.EG,VTAS.D,VTAS.DF,VTAS.B,VTAS.VC,VTAS.VCR,VTAS.DC,VTAS.DCR,VTAS.N,VTAS.NO,VTAS.NR,VTAS.FM,VTAS.CO))<BR>Si(Config.CBDirAlmacen, VentaPOS:Cte.CBDir, <T><T>)
Boton=0
GuardarAntes=S
Antes=S
DespuesGuardar=S
ActivoCondicion=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Info.Renglon, VentaDPOS:VentaDPOS.Renglon)<BR>Asigna(Info.RenglonSub, VentaDPOS:VentaDPOS.RenglonSub)<BR>EjecutarSQL(<T>spProcesarCBInfo :nEst, :tEmp, :tMod, :nID, :nRen, :nSub<T>, EstacionTrabajo, Empresa, <T>VTAS<T>, Info.ID, Info.Renglon, Info.RenglonSub)
VisibleCondicion=Config.CB



[Ficha.VentaPOS.Concepto]
Carpeta=Ficha
Clave=VentaPOS.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
EditarConBloqueo=N


[Acciones.SeriesLotes]
Nombre=SeriesLotes
Boton=18
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
NombreDesplegar=&Series/Lotes del Artículo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Antes=S
Visible=S

Expresion=Asigna(Info.SumaSerieLote, Nulo)<BR>Si<BR>  MovTipo(<T>VTAS<T>, VentaPOS:VentaPOS.Mov) = VTAS.CO<BR>Entonces<BR>  Asigna(Info.Cliente, VentaPOS:VentaPOS.Cliente)<BR>  Si(VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>SerieLoteMovUbicacion<T>), Forma(<T>SerieLoteMovUbicacionInfo<T>))<BR>Sino<BR>  Si <BR>    VentaDPOS:Art.Tipo=TipoVIN<BR>  Entonces<BR>    Si<BR>      VentaPOS:VentaPOS.Estatus=EstatusSinAfectar<BR>    Entonces<BR>      Asigna(Info.Articulo, VentaDPOS:VentaDPOS.Articulo)<BR>      Si(Forma(<T>VINMov<T>), EjecutarSQL(<T>xpVentaVINAsignar :nID, :nRen, :nSub, :tVIN<T>, VentaPOS:VentaPOS.ID, VentaDPOS:VentaDPOS.Renglon, VentaDPOS:VentaDPOS.RenglonSub, Info.VIN))<BR>    Sino<BR>      Forma(<T>VINMovInfo<T>)<BR>    Fin<BR>  Sino<BR>    Si(VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente), Forma(<T>SerieLoteMov<T>), Si(Usuario.ModificarSerieLoteProp, Forma(<T>SerieLoteMovProp<T>), Forma(<T>SerieLoteMovInfo<T>)))<BR>    Si<BR>      VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar) <BR>    Entonces<BR>      Si<BR>        (VentaDPOS:Art.Tipo=TipoPartida) y (Info.SumaSerieLote>0)<BR>      Entonces<BR>        Asigna(Info.Copiar, Verdadero)<BR>        Asigna(Info.Precio, VentaDPOS:VentaDPOS.Precio)<BR>        Asigna(VentaDPOS:VentaDPOS.Cantidad, <BR>          Caso Minusculas(VentaDPOS:VentaDPOS.Unidad)<BR>            Es <T>metros<T> Entonces Info.SumaAlternaSerieLote<BR>            Es <T>yardas<T> Entonces Info.SumaAlternaSerieLote/UnidadFactor(VentaDPOS:VentaDPOS.Unidad)<BR>            Es <T>kilos<T>  Entonces Info.SumaSerieLote<BR>            Es <T>libras<T> Entonces Info.SumaSerieLote/UnidadFactor(VentaDPOS:VentaDPOS.Unidad)<BR>          Sino<BR>            0.0<BR>          Fin)<BR>        Asigna(VentaDPOS:VentaDPOS.Factor, Info.SumaSerieLote/VentaDPOS:VentaDPOS.Cantidad)<BR>        Asigna(VentaDPOS:VentaDPOS.CantidadAlterna, Info.SumaAlternaSerieLote)<BR>        Asigna(Info.Copiar, Falso)<BR>      Sino<BR>        Si<BR>          (no Config.MultiUnidades) y ConDatos(Info.SumaSerieLote) y (Info.SumaSerieLote<>ABS(VentaDPOS:VentaDPOS.Cantidad)) y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>        Entonces<BR>          Si<BR>            Confirmacion(<T>La Cantidad Difiere con la Selección.<T>+NuevaLinea+NuevaLinea+<T>¿ Desea Actualizar la Cantidad ?<T>,BotonSi, BotonNo)=BotonSi)<BR>          Entonces<BR>            Asigna(VentaDPOS:VentaDPOS.Cantidad, Si(Vacio(VentaDPOS:VentaDPOS.Cantidad, 0.0)<0,-Info.SumaSerieLote, Info.SumaSerieLote))<BR>          Fin<BR>        Fin  <BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin<BR><BR>Si<BR>  (Info.SubModuloVenta=<T>AUTO<T>) y (VentaDPOS:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX)) y (Info.SumaSerieLote>0) y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y Usuario.AsistentePrecios<BR>Entonces<BR>  Asigna(Info.Estatus, VentaPOS:VentaPOS.Estatus)<BR>  Asigna(Info.Modulo, <T>VTAS<T>)<BR>  Asigna(Info.ID, VentaPOS:VentaPOS.ID)<BR>  Asigna(Info.Articulo, VentaDPOS:VentaDPOS.Articulo)<BR>  Asigna(Info.ArtLinea, VentaDPOS:Art.Linea)<BR>  Asigna(Info.SubCuenta, VentaDPOS:VentaDPOS.SubCuenta)<BR>  Asigna(Info.RenglonID, VentaDPOS:VentaDPOS.RenglonID)<BR>  Si<BR>    Forma(<T>AutoBoletoMov<T>)<BR>  Entonces<BR>    Asigna(VentaDPOS:VentaDPOS.Cantidad, Info.Cantidad)<BR>    Si<BR>      VentaDPOS:Art.AutoRecaudacion en (<T>Gasto No Reembolsable<T>, <T>Ingreso Costo<T>)<BR>    Entonces<BR>      Asigna(VentaDPOS:VentaDPOS.Costo, Info.Importe/Info.Cantidad)<BR>    Sino<BR>      Asigna(VentaDPOS:VentaDPOS.Precio, Info.Importe/Info.Cantidad)<BR>      Si(VentaDPOS:Art.AutoRecaudacion=<T>Gasto<T>, Asigna(VentaDPOS:VentaDPOS.Precio, -VentaDPOS:VentaDPOS.Precio))<BR>    Fin<BR>  Fin<BR>Fin
Activo=S
EjecucionCondicion=VentaDPOS:Art.Tipo en (TipoSerie, TipoVIN, TipoLote) o <BR>((VentaDPOS:Art.Tipo=TipoPartida) y ConDatos(VentaDPOS:VentaDPOS.SubCuenta))
AntesExpresiones=Asigna(Info.Articulo, VentaDPOS:VentaDPOS.Articulo)<BR>Asigna(Info.Almacen, Si(Config.VentaMultiAlmacen, VentaDPOS:VentaDPOS.Almacen, VentaPOS:VentaPOS.Almacen))<BR>Asigna(Info.AlmTipo, VentaPOS:Alm.Tipo)<BR>Asigna(Info.Modulo, <T>VTAS<T>) <BR>Asigna(Info.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Info.RenglonID, VentaDPOS:VentaDPOS.RenglonID)<BR>Asigna(Info.Factor, VentaDPOS:VentaDPOS.Factor)<BR>Asigna(Info.Cantidad, ABS(VentaDPOS:VentaDPOS.Cantidad) * UnidadFactor(VentaDPOS:VentaDPOS.Unidad, VentaDPOS:VentaDPOS.Articulo))<BR>Asigna(Info.Paquete, VentaDPOS:VentaDPOS.Paquete)<BR>Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, VentaPOS:VentaPOS.Mov))<BR>Asigna(Info.ArtTipo, VentaDPOS:Art.Tipo)<BR>Asigna(Info.EsEntrada, MovTipoEn(<T>INV<T>,VentaPOS:VentaPOS.Mov, (VTAS.D, VTAS.DF, VTAS.DC,VTAS.DCR)))<BR>Asigna(Info.Unidad, VentaDPOS:VentaDPOS.Unidad)<BR>Asigna(Info.Estatus, VentaPOS:VentaPOS.Estatus)<BR>Si(General.Autotransportes, Asigna(Filtro.Espacio, VentaPOS:VentaPOS.Espacio))<BR>Si((Info.ArtTipo=TipoPartida) o (VentaDPOS:Art.TipoOpcion<>TipoNo), Asigna(Info.SubCuenta, VentaDPOS:VentaDPOS.SubCuenta), Asigna(Info.SubCuenta, <T><T>))<BR>Asigna(Info.Tarima, VentaDPOS:VentaDPOS.Tarima)
[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata

Pegado=S
[(Carpeta Totalizadores).Desc]
Carpeta=(Carpeta Totalizadores)
Clave=Desc
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata



[Envio.VentaPOS.EnviarA]
Carpeta=Envio
Clave=VentaPOS.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro

[Envio.CteEnviarA.Nombre]
Carpeta=Envio
Clave=CteEnviarA.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=35
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Envio.CteEnviarA.Direccion]
Carpeta=Envio
Clave=CteEnviarA.Direccion
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=35
ColorFondo=Plata
ColorFuente=Negro

[Envio.VentaPOS.Cliente]
Carpeta=Envio
Clave=VentaPOS.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=S
ColorFondo=Blanco
ColorFuente=Negro

[Envio.Cte.Nombre]
Carpeta=Envio
Clave=Cte.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=35
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Envio.Cte.Direccion]
Carpeta=Envio
Clave=Cte.Direccion
Editar=S
3D=S
Tamano=35
ColorFondo=Plata
Pegado=S
ColorFuente=Negro

[Envio.VentaPOS.FormaEnvio]
Carpeta=Envio
Clave=VentaPOS.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro


[Mostrador.VentaPOS.Mov]
Carpeta=Mostrador
Clave=VentaPOS.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22

[Mostrador.VentaPOS.MovID]
Carpeta=Mostrador
Clave=VentaPOS.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Plata
Pegado=S
Tamano=8


[Servicio.VentaPOS.ServicioArticulo]
Carpeta=Servicio
Clave=VentaPOS.ServicioArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioSerie]
Carpeta=Servicio
Clave=VentaPOS.ServicioSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
Efectos=[Negritas]

[Servicio.VentaPOS.ServicioContrato]
Carpeta=Servicio
Clave=VentaPOS.ServicioContrato
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
EspacioPrevio=N

[Servicio.VentaPOS.ServicioContratoID]
Carpeta=Servicio
Clave=VentaPOS.ServicioContratoID
Editar=N
3D=S
Tamano=8
ColorFondo=Plata
ValidaNombre=N
Pegado=S

[Servicio.ArtDestino.Descripcion1]
Carpeta=Servicio
Clave=ArtDestino.Descripcion1
Editar=S
3D=S
Tamano=49
ColorFondo=Plata
Efectos=[Negritas]

[Servicio.VentaPOS.ServicioGarantia]
Carpeta=Servicio
Clave=VentaPOS.ServicioGarantia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
Tamano=11
ColorFondo=Blanco


[Acciones.ArtAccesorioBuscar]
Nombre=ArtAccesorioBuscar
Boton=0
Menu=&Ver
NombreDesplegar=Buscar Accesorios...
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=FormaModal(<T>ArtAccesorioBuscar<T>)
[Acciones.ArtRefaccionBuscar]
Nombre=ArtRefaccionBuscar
Boton=0
Menu=&Ver
NombreDesplegar=Buscar Refacciones...
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=FormaModal(<T>ArtRefaccionBuscar<T>)
[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Visible=S
EspacioPrevio=S

ActivoCondicion=Usuario.ImprimirMovs
[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S

ActivoCondicion=ConDatos(VentaAPOS:VentaPOS.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaAPOS:VentaPOS.ID)
[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Visible=S

ActivoCondicion=Usuario.PreliminarMovs
[Acciones.AbrirMostrar]
Nombre=AbrirMostrar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.AbrirEnviar]
Nombre=AbrirEnviar
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S

ActivoCondicion=Usuario.EnviarExcel
[Servicio.VentaPOS.ServicioContratoTipo]
Carpeta=Servicio
Clave=VentaPOS.ServicioContratoTipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Servicio.VentaPOS.ServicioDescripcion]
Carpeta=Servicio
Clave=VentaPOS.ServicioDescripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Pegado=N


[Detalle.VentaDPOS.Paquete]
Carpeta=Detalle
Clave=VentaDPOS.Paquete
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=N

[Acciones.Observaciones]
Nombre=Observaciones
Boton=0
UsaTeclaRapida=S
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Expresion
Visible=S
Activo=S
TeclaRapida=Ctrl+O
Expresion=Si(VentaPOS:VentaPOS.Estatus en (EstatusConcluido, EstatusCancelado), Informacion(VentaDPOS:VentaDPOS.DescripcionExtra), Pregunta(VentaDPOS:VentaDPOS.DescripcionExtra))


[Detalle.VentaDPOS.ContUso]
Carpeta=Detalle
Clave=VentaDPOS.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S


[Servicio.VentaPOS.ServicioFecha]
Carpeta=Servicio
Clave=VentaPOS.ServicioFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
Pegado=N
LineaNueva=S


[(Carpeta Totalizadores).Renglon]
Carpeta=(Carpeta Totalizadores)
Clave=Renglon
Editar=S
LineaNueva=N
Tamano=4
ColorFondo=Plata
3D=S
ValidaNombre=N
Pegado=S



[Ficha.VentaPOS.EnviarA]
Carpeta=Ficha
Clave=VentaPOS.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ficha.CteEnviarA.Nombre]
Carpeta=Ficha
Clave=CteEnviarA.Nombre
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=23
ColorFondo=Plata
Editar=S
Pegado=N

[Ficha.CteEnviarA.Direccion]
Carpeta=Ficha
Clave=CteEnviarA.Direccion
3D=S
Pegado=S
Tamano=22
ColorFondo=Plata
Editar=S

[Ficha.VentaPOS.FormaEnvio]
Carpeta=Ficha
Clave=VentaPOS.FormaEnvio
ValidaNombre=N
3D=S
Pegado=N
Tamano=17
ColorFondo=Blanco
Editar=S

[Ficha.Cte.RFC]
Carpeta=Ficha
Clave=Cte.RFC
3D=S
Tamano=11
ColorFondo=Plata
Pegado=S
Editar=S


[Notas.VentaPOS.Causa]
Carpeta=Notas
Clave=VentaPOS.Causa
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
EditarConBloqueo=N
LineaNueva=S

[Servicio.VentaPOS.ServicioTipo]
Carpeta=Servicio
Clave=VentaPOS.ServicioTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.VentaPOS.FechaOriginal]
Carpeta=Ficha
Clave=VentaPOS.FechaOriginal
Editar=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco
Pegado=N

[Detalle.VentaDPOS.Unidad]
Carpeta=Detalle
Clave=VentaDPOS.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.CantidadNeta]
Carpeta=Detalle
Clave=CantidadNeta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaDPOS.CantidadReservada]
Carpeta=Detalle
Clave=VentaDPOS.CantidadReservada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Azul
Efectos=[Negritas]

[Detalle.VentaDPOS.CantidadOrdenada]
Carpeta=Detalle
Clave=VentaDPOS.CantidadOrdenada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

[Detalle.VentaDPOS.CantidadPendiente]
Carpeta=Detalle
Clave=VentaDPOS.CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00004080
Efectos=[Negritas]

[Detalle.VentaDPOS.FechaRequerida]
Carpeta=Detalle
Clave=VentaDPOS.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S


[Acciones.VentaDReservados]
Nombre=VentaDReservados
Boton=0
Menu=&Ver
NombreDesplegar=Reservados del Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaDReservado
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(VentaDPOS:VentaDPOS.Articulo)
AntesExpresiones=Asigna(Info.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Info.Articulo, VentaDPOS:VentaDPOS.Articulo)
VisibleCondicion=VentaPOS:VentaPOS.Estatus<>EstatusSinAfectar

[Detalle.VentaDPOS.CantidadInventario]
Carpeta=Detalle
Clave=VentaDPOS.CantidadInventario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Notas.VentaPOS.Atencion]
Carpeta=Notas
Clave=VentaPOS.Atencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.AbrirLocalizar]
Nombre=AbrirLocalizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.AbrirLocalizarSiguiente]
Nombre=AbrirLocalizarSiguiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S

[Ficha.VentaPOS.ServicioContratoTipo]
Carpeta=Ficha
Clave=VentaPOS.ServicioContratoTipo
Editar=S
3D=S
Tamano=13
ColorFondo=Blanco


[Acciones.Consecutivo]
Nombre=Consecutivo
Boton=0
Menu=&Archivo
NombreDesplegar=A&signar Consecutivo
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>VTAS<T>, VentaPOS:VentaPOS.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(VentaPOS:VentaPOS.MovID)
VisibleCondicion=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)


[Ficha.VentaPOS.Retencion]
Carpeta=Ficha
Clave=VentaPOS.Retencion
ValidaNombre=S
3D=S
Pegado=S
Tamano=8
ColorFondo=Blanco


[Notas.VentaPOS.Extra]
Carpeta=Notas
Clave=VentaPOS.Extra
Editar=S
3D=S
Tamano=13
ColorFondo=Blanco

[Acciones.VerOpciones]
Nombre=VerOpciones
Boton=0
NombreDesplegar=&Interpretar Opción
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=VerOpcionesArticulo( VentaDPOS:VentaDPOS.Articulo, VentaDPOS:VentaDPOS.SubCuenta )
ActivoCondicion=ConDatos(VentaDPOS:VentaDPOS.SubCuenta) y (VentaDPOS:Art.TipoOpcion=TipoSi)


[Servicio.VentaPOS.ServicioIdentificador]
Carpeta=Servicio
Clave=VentaPOS.ServicioIdentificador
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
Pegado=S

[Notas.VentaPOS.AtencionTelefono]
Carpeta=Notas
Clave=VentaPOS.AtencionTelefono
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Autorizar]
Nombre=Autorizar
Boton=0
Menu=&Archivo
NombreDesplegar=A&utorizar
EnMenu=S
TipoAccion=Formas
Antes=S
RefrescarDespues=S
ClaveAccion=MovAutorizar
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Alt+F12
ActivoCondicion=Vacio(VentaPOS:VentaPOS.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Afectar.Mov, VentaPOS:VentaPOS.Mov)<BR>Asigna(Afectar.MovID, VentaPOS:VentaPOS.MovID)<BR>Asigna(Info.Descripcion, VentaPOS:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(VentaPOS:VentaPOS.Mensaje)

[Ficha.VentaPOS.ListaPreciosEsp]
Carpeta=Ficha
Clave=VentaPOS.ListaPreciosEsp
Editar=S
ValidaNombre=N
3D=S
Tamano=17
ColorFondo=Blanco

[Notas.VentaPOS.ZonaImpuesto]
Carpeta=Notas
Clave=VentaPOS.ZonaImpuesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[(Carpeta Abrir).Cte.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Notas.VentaPOS.Departamento]
Carpeta=Notas
Clave=VentaPOS.Departamento
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco



[Acciones.EmbarqueMovPendientes]
Nombre=EmbarqueMovPendientes
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=Movimientos &Pendientes por Embarcar
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmbarqueMovPendientes
Activo=S
Visible=S


[Acciones.VerPoliticaDetalle]
Nombre=VerPoliticaDetalle
Boton=0
NombreDesplegar=&Ver Políticas de Precios Aplicadas
EnMenu=S
TipoAccion=Dialogos
Activo=S
Visible=S
ClaveAccion=VerPoliticasPrecios
Antes=S
AntesExpresiones=Asigna(Info.Articulo, VentaDPOS:VentaDPOS.Articulo)<BR>Asigna(Info.SubCuenta, VentaDPOS:VentaDPOS.SubCuenta)<BR>Asigna(Info.Descripcion, VentaDPOS:Art.Descripcion1)<BR>Asigna(Info.Mensaje, VentaDPOS:VentaDPOS.PoliticaPrecios)


[Notas.VentaPOS.DesglosarImpuestos]
Carpeta=Notas
Clave=VentaPOS.DesglosarImpuestos
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=10
ColorFondo=Blanco

[Notas.VentaPOS.ExcluirPlaneacion]
Carpeta=Notas
Clave=VentaPOS.ExcluirPlaneacion
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco


[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

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


[Ficha.VentaPOS.DescuentoGlobal]
Carpeta=Ficha
Clave=VentaPOS.DescuentoGlobal
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.VentaPOS.HoraRequerida]
Carpeta=Ficha
Clave=VentaPOS.HoraRequerida
Editar=S
3D=S
Pegado=S
Tamano=9
ColorFondo=Blanco

[Notas.VentaPOS.VigenciaDesde]
Carpeta=Notas
Clave=VentaPOS.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=12
ColorFondo=Blanco
LineaNueva=N
EspacioPrevio=N

[Notas.VentaPOS.VigenciaHasta]
Carpeta=Notas
Clave=VentaPOS.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=12
ColorFondo=Blanco

[Notas.VentaPOS.ConVigencia]
Carpeta=Notas
Clave=VentaPOS.ConVigencia
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco


[Notas.VentaPOS.AnticiposFacturados]
Carpeta=Notas
Clave=VentaPOS.AnticiposFacturados
Editar=N
3D=S
Tamano=18
LineaNueva=N
ValidaNombre=S
ColorFondo=Blanco

[(Carpeta Abrir).Dias]
Carpeta=(Carpeta Abrir)
Clave=Dias
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Throughput]
Carpeta=(Carpeta Abrir)
Clave=Throughput
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaDPOS.DescuentoImporte]
Carpeta=Detalle
Clave=VentaDPOS.DescuentoImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Notas.VentaPOS.Bonificacion]
Carpeta=Notas
Clave=VentaPOS.Bonificacion
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Ficha.CteEnviarA.Clave]
Carpeta=Ficha
Clave=CteEnviarA.Clave
Editar=S
3D=S
Tamano=6
ColorFondo=Plata
Pegado=S

[Detalle.ClaveIdioma]
Carpeta=Detalle
Clave=ClaveIdioma
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Editar=N

[Acciones.Precio]
Nombre=Precio
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+W
NombreDesplegar=Precio
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Expresion=Si<BR>  Usuario.AsistentePrecios<BR>Entonces<BR>  Si(VentaDPOS:Art.Linea=Config.AutoArtBX, Asigna(Temp.Flotante, 0), Asigna(Temp.Flotante, VentaDPOS:VentaDPOS.Cantidad))<BR>  Si<BR>    VentaDPOS:Art.AutoRecaudacion en (<T>Gasto No Reembolsable<T>, <T>Ingreso Costo<T>)<BR>  Entonces<BR>    ConfirmarImportes(VentaDPOS:VentaDPOS.Cantidad, VentaDPOS:VentaDPOS.Costo, Usuario.AutoDobleCapturaPrecios y (VentaDPOS:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX)), <T>Editar Costo<T>, Temp.Flotante)<BR>  Sino<BR>    ConfirmarImportes(VentaDPOS:VentaDPOS.Cantidad, VentaDPOS:VentaDPOS.Precio, Usuario.AutoDobleCapturaPrecios y (VentaDPOS:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX)), <T>Editar Precio<T>, Temp.Flotante, VentaDPOS:Art.AutoRecaudacion=<T>Gasto<T>)<BR>  Fin<BR>Sino<BR>  Asigna(Info.Estatus, VentaPOS:VentaPOS.Estatus)<BR>  Asigna(Info.Modulo, <T>VTAS<T>)<BR>  Asigna(Info.ID, VentaPOS:VentaPOS.ID)<BR>  Asigna(Info.Articulo, VentaDPOS:VentaDPOS.Articulo)<BR>  Asigna(Info.ArtLinea, VentaDPOS:Art.Linea)<BR>  Asigna(Info.SubCuenta, VentaDPOS:VentaDPOS.SubCuenta)<BR>  Asigna(Info.RenglonID, VentaDPOS:VentaDPOS.RenglonID)<BR>  Si<BR>    Forma(<T>AutoBoletoMov<T>)<BR>  Entonces<BR>    Asigna(VentaDPOS:VentaDPOS.Cantidad, Info.Cantidad)<BR>    Si<BR>      VentaDPOS:Art.AutoRecaudacion en (<T>Gasto No Reembolsable<T>, <T>Ingreso Costo<T>)<BR>    Entonces<BR>      Asigna(VentaDPOS:VentaDPOS.Costo, Info.Importe/Info.Cantidad)<BR>    Sino<BR>      Asigna(VentaDPOS:VentaDPOS.Precio, Info.Importe/Info.Cantidad)<BR>      Si(VentaDPOS:Art.AutoRecaudacion=<T>Gasto<T>, Asigna(VentaDPOS:VentaDPOS.Precio, -VentaDPOS:VentaDPOS.Precio))<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
EjecucionCondicion=(Info.SubModuloVenta=<T>AUTO<T>) y (VentaDPOS:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX))
VisibleCondicion=General.Autotransportes o Usuario.AsistentePrecios

[Detalle.VentaDPOS.AutoLocalidad]
Carpeta=Detalle
Clave=VentaDPOS.AutoLocalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco


[Corrida.VentaPOS.AutoCorrida]
Carpeta=Corrida
Clave=VentaPOS.AutoCorrida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro

[Corrida.AutoCorrida.Nombre]
Carpeta=Corrida
Clave=AutoCorrida.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
ColorFuente=Negro

[Corrida.VentaPOS.AutoBoleto]
Carpeta=Corrida
Clave=VentaPOS.AutoBoleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N


[Notas.VentaPOS.Periodicidad]
Carpeta=Notas
Clave=VentaPOS.Periodicidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco


[Acciones.CteEnviarA]
Nombre=CteEnviarA
Boton=0
Menu=&Edición
NombreDesplegar=&Sucursales del Cliente...
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteEnviarA
Antes=S
ActivoCondicion=Usuario.AgregarCteExpress y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
AntesExpresiones=Asigna(Info.Cliente, VentaPOS:VentaPOS.Cliente)<BR>Asigna(Info.Nombre, VentaPOS:Cte.Nombre)
VisibleCondicion=Usuario.CteSucursalVenta

[Detalle.VentaDPOS.SustitutoArticulo]
Carpeta=Detalle
Clave=VentaDPOS.SustitutoArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Sustitutos]
Nombre=Sustitutos
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+S
NombreDesplegar=Sustitutos del Artículo
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Antes=S
GuardarAntes=S
RefrescarDespues=S

Expresion=FormaModal(<T>VentaAsignarSusutitos<T>)
ActivoCondicion=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
EjecucionCondicion=VentaDPOS:Art.Sustitutos
AntesExpresiones=Asigna(Info.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Info.Mov, VentaPOS:VentaPOS.Mov)<BR>Asigna(Info.MovID, VentaPOS:VentaPOS.MovID)<BR>Asigna(Info.Articulo, VentaDPOS:VentaDPOS.Articulo)<BR>Asigna(Info.SubCuenta, VentaDPOS:VentaDPOS.SubCuenta)<BR>Asigna(Info.Descripcion, VentaDPOS:Art.Descripcion1)<BR>Asigna(Info.Almacen, VentaDPOS:VentaDPOS.Almacen)<BR>Asigna(Info.Cantidad, VentaDPOS:VentaDPOS.Cantidad)<BR>Asigna(Info.Renglon, VentaDPOS:VentaDPOS.Renglon)<BR>Asigna(Info.RenglonSub, VentaDPOS:VentaDPOS.RenglonSub)<BR>Asigna(Info.RenglonID, VentaDPOS:VentaDPOS.RenglonID)
VisibleCondicion=Config.FacturarSustitutos 
[Corrida.VentaPOS.Espacio]
Carpeta=Corrida
Clave=VentaPOS.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro

[Corrida.Espacio.Nombre]
Carpeta=Corrida
Clave=Espacio.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
ColorFuente=Negro

[Corrida.Espacio.Servicio]
Carpeta=Corrida
Clave=Espacio.Servicio
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Plata
ColorFuente=Negro

[Corrida.Espacio.Rol]
Carpeta=Corrida
Clave=Espacio.Rol
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Plata
ColorFuente=Negro

[Ficha.VentaPOS.UEN]
Carpeta=Ficha
Clave=VentaPOS.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco


[Notas.VentaPOS.Clase]
Carpeta=Notas
Clave=VentaPOS.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Notas.VentaPOS.Subclase]
Carpeta=Notas
Clave=VentaPOS.Subclase
Editar=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco

[Detalle.VentaDPOS.Espacio]
Carpeta=Detalle
Clave=VentaDPOS.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
EditarConBloqueo=N




[Detalle.CantidadInvNeta]
Carpeta=Detalle
Clave=CantidadInvNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.ActualizarPrecioMoneda]
Nombre=ActualizarPrecioMoneda
Boton=0
Menu=&Archivo
NombreDesplegar=Actualizar Precios Otras Monedas
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Alt+F5
Expresion=Si(Confirmacion(<T>¿ Desea Actualizar los Precios Otras Monedas ?<T>, BotonSi, BotonNo) = BotonSi, EjecutarSQL(<T>spVentaActualizarPrecios :nID<T>, VentaPOS:VentaPOS.ID))
ActivoCondicion=Config.VentaActualizarPrecioMoneda y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
VisibleCondicion=Config.VentaActualizarPrecioMoneda y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Corrida.VentaPOS.AutoKms]
Carpeta=Corrida
Clave=VentaPOS.AutoKms
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Plata
ColorFuente=Negro

[Corrida.VentaPOS.AutoBomba]
Carpeta=Corrida
Clave=VentaPOS.AutoBomba
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Corrida.VentaPOS.AutoBombaContador]
Carpeta=Corrida
Clave=VentaPOS.AutoBombaContador
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Corrida.VentaPOS.AutoKmsActuales]
Carpeta=Corrida
Clave=VentaPOS.AutoKmsActuales
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro

[Corrida.VentaPOS.AutoCorridaServicio]
Carpeta=Corrida
Clave=VentaPOS.AutoCorridaServicio
ValidaNombre=S
3D=S
Tamano=21
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.VentaPOS.AutoCorridaRol]
Carpeta=Corrida
Clave=VentaPOS.AutoCorridaRol
ValidaNombre=S
3D=S
Tamano=21
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.VentaPOS.AutoCorridaOrigen]
Carpeta=Corrida
Clave=VentaPOS.AutoCorridaOrigen
ValidaNombre=S
3D=S
Tamano=11
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.VentaPOS.AutoCorridaDestino]
Carpeta=Corrida
Clave=VentaPOS.AutoCorridaDestino
ValidaNombre=S
3D=S
Tamano=11
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.VentaPOS.AutoCorridaRuta]
Carpeta=Corrida
Clave=VentaPOS.AutoCorridaRuta
ValidaNombre=S
3D=S
Tamano=11
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.VentaPOS.AutoCorridaHora]
Carpeta=Corrida
Clave=VentaPOS.AutoCorridaHora
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.VentaPOS.AutoCorridaKms]
Carpeta=Corrida
Clave=VentaPOS.AutoCorridaKms
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.VentaPOS.AutoCorridaLts]
Carpeta=Corrida
Clave=VentaPOS.AutoCorridaLts
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Negro
Editar=S
ColorFondo=Blanco


[Gasto.VentaPOS.GastoAcreedor]
Carpeta=Gasto
Clave=VentaPOS.GastoAcreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gasto.Acreedor.Nombre]
Carpeta=Gasto
Clave=Acreedor.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata

[Gasto.VentaPOS.GastoConcepto]
Carpeta=Gasto
Clave=VentaPOS.GastoConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=61
ColorFondo=Blanco


[Comentarios.VentaPOS.Comentarios]
Carpeta=Comentarios
Clave=VentaPOS.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaDPOS.SustitutoSubCuenta]
Carpeta=Detalle
Clave=VentaDPOS.SustitutoSubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Servicio.VentaPOS.ServicioSiniestro]
Carpeta=Servicio
Clave=VentaPOS.ServicioSiniestro
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N

[Servicio.VentaPOS.ServicioPlacas]
Carpeta=Servicio
Clave=VentaPOS.ServicioPlacas
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
Pegado=S

[Detalle.SubImpuesto1]
Carpeta=Detalle
Clave=SubImpuesto1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SubImpuesto2]
Carpeta=Detalle
Clave=SubImpuesto2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SubImpuesto3]
Carpeta=Detalle
Clave=SubImpuesto3
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Servicio.VentaPOS.ServicioKms]
Carpeta=Servicio
Clave=VentaPOS.ServicioKms
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
Pegado=S

[Servicio.VentaPOS.Cliente]
Carpeta=Servicio
Clave=VentaPOS.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Servicio.Cte.Nombre]
Carpeta=Servicio
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=34
ColorFondo=Plata

[Servicio.VentaPOS.ListaPreciosEsp]
Carpeta=Servicio
Clave=VentaPOS.ListaPreciosEsp
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioTipoOrden]
Carpeta=Servicio
Clave=VentaPOS.ServicioTipoOrden
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioExpress]
Carpeta=Servicio
Clave=VentaPOS.ServicioExpress
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioTipoOperacion]
Carpeta=Servicio
Clave=VentaPOS.ServicioTipoOperacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Art.Horas]
Carpeta=Detalle
Clave=Art.Horas
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaDPOS.Estado]
Carpeta=Detalle
Clave=VentaDPOS.Estado
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioNumero]
Carpeta=Servicio
Clave=VentaPOS.ServicioNumero
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioDemerito]
Carpeta=Servicio
Clave=VentaPOS.ServicioDemerito
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioDeducible]
Carpeta=Servicio
Clave=VentaPOS.ServicioDeducible
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco


[Notas.VentaPOS.AgenteServicio]
Carpeta=Notas
Clave=VentaPOS.AgenteServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Notas.AgenteDestino.Nombre]
Carpeta=Notas
Clave=AgenteDestino.Nombre
Editar=S
ValidaNombre=S
OcultaNombre=S
3D=S
Tamano=18
ColorFondo=Plata


[Notas.VentaPOS.FechaOriginal]
Carpeta=Notas
Clave=VentaPOS.FechaOriginal
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Detalle.VentaDPOS.ServicioNumero]
Carpeta=Detalle
Clave=VentaDPOS.ServicioNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Notas.VentaPOS.ServicioTipo]
Carpeta=Notas
Clave=VentaPOS.ServicioTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Notas.VentaPOS.SucursalVenta]
Carpeta=Notas
Clave=VentaPOS.SucursalVenta
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco


[Servicio.VentaPOS.ServicioNumeroEconomico]
Carpeta=Servicio
Clave=VentaPOS.ServicioNumeroEconomico
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
Editar=S

[Servicio.VentaPOS.ServicioAseguradora]
Carpeta=Servicio
Clave=VentaPOS.ServicioAseguradora
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.AutoBoleto]
Nombre=AutoBoleto
Boton=0
NombreDesplegar=&Boletos
EnMenu=S
TipoAccion=Formas
ClaveAccion=AutoBoletoFactura
ConCondicion=S
Antes=S
Activo=S
EjecucionCondicion=VentaDPOS:Art.Linea=Config.AutoArtBT
AntesExpresiones=Asigna(Info.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Info.Mov, VentaPOS:VentaPOS.Mov)<BR>Asigna(Info.MovID, VentaPOS:VentaPOS.MovID)
VisibleCondicion=General.Autotransportes y (VentaDPOS:Art.Linea=Config.AutoArtBT)

[Acciones.DesglosarCantidadOrdenada]
Nombre=DesglosarCantidadOrdenada
Boton=0
NombreDesplegar=Desglosar Cantidad &Ordenada
EnMenu=S
TipoAccion=Formas
ClaveAccion=DesglosarCantidadOrdenada
Antes=S
EspacioPrevio=S
ActivoCondicion=Usuario.Costos
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Mov, VentaPOS:VentaPOS.Mov)<BR>Asigna(Info.MovID, VentaPOS:VentaPOS.MovID)<BR>Asigna(Info.Articulo, VentaDPOS:VentaDPOS.Articulo)<BR>Asigna(Info.SubCuenta, VentaDPOS:VentaDPOS.SubCuenta)
VisibleCondicion=Config.BackOrders y (VentaPOS:VentaPOS.Estatus=EstatusPendiente) y MovTipoEn(<T>VTAS<T>,VentaPOS:VentaPOS.Mov, (VTAS.P, VTAS.S, VTAS.F, VTAS.FAR, VTAS.FC, VTAS.FG, VTAS.FX, VTAS.DFC, VTAS.FB))

[Notas.VentaPOS.AF]
Carpeta=Notas
Clave=VentaPOS.AF
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco

[Notas.VentaPOS.AFArticulo]
Carpeta=Notas
Clave=VentaPOS.AFArticulo
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco

[Notas.VentaPOS.AFSerie]
Carpeta=Notas
Clave=VentaPOS.AFSerie
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
Pegado=N



[Contrato.VentaPOS.ContratoTipo]
Carpeta=Contrato
Clave=VentaPOS.ContratoTipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrato.VentaPOS.ContratoDescripcion]
Carpeta=Contrato
Clave=VentaPOS.ContratoDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[Contrato.VentaPOS.ContratoSerie]
Carpeta=Contrato
Clave=VentaPOS.ContratoSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrato.VentaPOS.ContratoValor]
Carpeta=Contrato
Clave=VentaPOS.ContratoValor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrato.VentaPOS.ContratoValorMoneda]
Carpeta=Contrato
Clave=VentaPOS.ContratoValorMoneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrato.VentaPOS.ContratoSeguro]
Carpeta=Contrato
Clave=VentaPOS.ContratoSeguro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrato.VentaPOS.ContratoResponsable]
Carpeta=Contrato
Clave=VentaPOS.ContratoResponsable
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrato.VentaPOS.ConVigencia]
Carpeta=Contrato
Clave=VentaPOS.ConVigencia
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=10
ColorFondo=Blanco

[Contrato.VentaPOS.VigenciaDesde]
Carpeta=Contrato
Clave=VentaPOS.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N
EspacioPrevio=N

[Contrato.VentaPOS.VigenciaHasta]
Carpeta=Contrato
Clave=VentaPOS.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrato.VentaPOS.Periodicidad]
Carpeta=Contrato
Clave=VentaPOS.Periodicidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Contrato.VentaPOS.ContratoVencimiento]
Carpeta=Contrato
Clave=VentaPOS.ContratoVencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Servicio.VentaPOS.ServicioDeducibleImporte]
Carpeta=Servicio
Clave=VentaPOS.ServicioDeducibleImporte
Editar=S
3D=S
Tamano=14
ColorFondo=Blanco

[Servicio.Cte.Telefonos]
Carpeta=Servicio
Clave=Cte.Telefonos
Editar=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata

[Notas.VentaPOS.GenerarOP]
Carpeta=Notas
Clave=VentaPOS.GenerarOP
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco

[Notas.VentaPOS.Extra1]
Carpeta=Notas
Clave=VentaPOS.Extra1
Editar=S
ValidaNombre=N
3D=S
Tamano=6
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioFlotilla]
Carpeta=Servicio
Clave=VentaPOS.ServicioFlotilla
Editar=S
3D=S
Tamano=7
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioRampa]
Carpeta=Servicio
Clave=VentaPOS.ServicioRampa
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco



[Notas.VentaPOS.EndosarA]
Carpeta=Notas
Clave=VentaPOS.EndosarA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Resumen]
Nombre=Resumen
Boton=0
Menu=&Ver
NombreDesplegar=Resumén
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaResumen
ActivoCondicion=VentaPOS:VentaPOS.Estatus<>EstatusSinAfectar
VisibleCondicion=MovTipo(<T>VTAS<T>, VentaPOS:VentaPOS.Mov) = VTAS.NR


[Acciones.PrecioConImpuestos]
Nombre=PrecioConImpuestos
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F6
NombreDesplegar=Precio con Impuestos Incluidos...
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Importe, Redondea((VentaDPOS:ImporteTotal*100)/(100-VentaPOS:VentaPOS.DescuentoGlobal), 2))<BR>Si<BR>  Forma(<T>EspecificarImporte<T>)<BR>Entonces<BR>  Asigna(VentaDPOS:VentaDPOS.Precio, Redondea(Info.Importe/(1+(JuntarImpuestos(VentaDPOS:VentaDPOS.Impuesto1+VentaDPOS:VentaDPOS.Impuesto3, VentaDPOS:VentaDPOS.Impuesto2)/100)), 2))<BR>Fin
ActivoCondicion=(no Usuario.BloquearPrecios) y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
VisibleCondicion=no Config.VentaPreciosImpuestoIncluido

[Notas.VentaPOS.DesglosarImpuesto2]
Carpeta=Notas
Clave=VentaPOS.DesglosarImpuesto2
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco


[Detalle.VentaDPOS.Codigo]
Carpeta=Detalle
Clave=VentaDPOS.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Acciones.ExcluirISAN]
Nombre=ExcluirISAN
Boton=0
NombreDesplegar=Excluir/Cargar ISAN...
EnMenu=S
TipoAccion=Expresion
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+E
Expresion=Si<BR>  VentaDPOS:VentaDPOS.ExcluirISAN<BR>Entonces<BR>   Si(Confirmacion(<T>¿ Desea Incluir de Nuevo Este Accesorio en el Cálculo del ISAN ?<T>, BotonSi, BotonNo)=BotonSi, Asigna(VentaDPOS:VentaDPOS.ExcluirISAN, Falso))<BR>Sino<BR>   Si(Precaucion(<T>¿ Desea Excluir Este Accesorio en el Cálculo del ISAN ?<T>, BotonSi, BotonNo)=BotonSi, Asigna(VentaDPOS:VentaDPOS.ExcluirISAN, Verdadero))<BR>Fin
ActivoCondicion=VentaPOS:VentaPOS.DesglosarImpuesto2 y (VentaDPOS:Art.Tipo<>TipoVIN)
VisibleCondicion=General.Ford y MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.P, VTAS.VCR, VTAS.R, VTAS.DCR, VTAS.DR, VTAS.F, VTAS.DC))


[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+O
NombreDesplegar=P&olítica Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(VentaPOS:VentaPOS.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Clave, VentaPOS:VentaPOS.Mov)


[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
Menu=&Archivo
NombreDesplegar=Actualizar
GuardarAntes=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Shift+F5



[AC.VentaPOS.LineaCredito]
Carpeta=AC
Clave=VentaPOS.LineaCredito
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[AC.VentaPOS.TipoAmortizacion]
Carpeta=AC
Clave=VentaPOS.TipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[AC.VentaPOS.TipoTasa]
Carpeta=AC
Clave=VentaPOS.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[AC.LC.Descripcion]
Carpeta=AC
Clave=LC.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[AC.LC.VigenciaHasta]
Carpeta=AC
Clave=LC.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[AC.TipoAmortizacion.Descripcion]
Carpeta=AC
Clave=TipoAmortizacion.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[AC.TipoTasa.Descripcion]
Carpeta=AC
Clave=TipoTasa.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[AC.LC.VigenciaDesde]
Carpeta=AC
Clave=LC.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[AC.VentaPOS.Condicion]
Carpeta=AC
Clave=VentaPOS.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[AC.VentaPOS.Vencimiento]
Carpeta=AC
Clave=VentaPOS.Vencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Corrida.VentaPOS.AutoOperador2]
Carpeta=Corrida
Clave=VentaPOS.AutoOperador2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AC.VentaPOS.Comisiones]
Carpeta=AC
Clave=VentaPOS.Comisiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[AC.VentaPOS.ComisionesIVA]
Carpeta=AC
Clave=VentaPOS.ComisionesIVA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[AC.TotalComisiones]
Carpeta=AC
Clave=TotalComisiones
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Acciones.DescuentoGlobal]
Nombre=DescuentoGlobal
Boton=0
NombreDesplegar=Descuento &Global
EnMenu=S
TipoAccion=Expresion
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+D


Expresion=Asigna(Temp.Monetario, Suma(VentaDPOS:Importe))<BR>Asigna(Info.Importe, Suma(VentaDPOS:DescGlobal))<BR>Si(Forma(<T>EspecificarDescuentoGlobal<T>), Asigna(VentaPOS:VentaPOS.DescuentoGlobal, Info.Importe/Temp.Monetario*100)  Forma.ActualizarTotalizadores)
ActivoCondicion=Usuario.ModificarDescGlobalImporte
VisibleCondicion=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
[Servicio.VentaPOS.ServicioPuntual]
Carpeta=Servicio
Clave=VentaPOS.ServicioPuntual
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco


[Acciones.ActualizarPrecios]
Nombre=ActualizarPrecios
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+F5
NombreDesplegar=Actualizar &Precios
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Visible=S

Expresion=EjecutarSQL(<T>spVentaActualizarPrecios :nID<T>, VentaPOS:VentaPOS.ID)
ActivoCondicion=VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Notas.VentaPOS.AgenteComision]
Carpeta=Notas
Clave=VentaPOS.AgenteComision
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ValidaNombre=S




[AC.VentaPOS.TieneTasaEsp]
Carpeta=AC
Clave=VentaPOS.TieneTasaEsp
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco

[AC.VentaPOS.TasaEsp]
Carpeta=AC
Clave=VentaPOS.TasaEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Servicio.VentaPOS.ServicioPoliza]
Carpeta=Servicio
Clave=VentaPOS.ServicioPoliza
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco


[FormaAnexo.Usuario]
Carpeta=FormaAnexo
Clave=Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[FormaAnexo.UltimoCambio]
Carpeta=FormaAnexo
Clave=UltimoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[FormaAnexo.Columnas]
0=121
1=48

2=-2

[MovEvento.Columnas]
0=455
1=70

2=-2
3=-2
4=-2
[Acciones.MovEventoImprimir]
Nombre=MovEventoImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=MovEvento
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.MovEventoPreliminar]
Nombre=MovEventoPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=MovEvento
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.MovEventoExcel]
Nombre=MovEventoExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=MovEvento
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.MovEventoPersonalizar]
Nombre=MovEventoPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=MovEvento
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.MovEventoAmpliar]
Nombre=MovEventoAmpliar
Boton=0
EsDefault=S
NombreDesplegar=&Ampliar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=VerComentario(MovEvento:MovEvento.Tipo+<T> - <T>+FechaEnTexto(MovEvento:MovEvento.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>), MovEvento:MovEvento.Asunto)

[MovEvento.MovEvento.Fecha]
Carpeta=MovEvento
Clave=MovEvento.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovEvento.MovEvento.Usuario]
Carpeta=MovEvento
Clave=MovEvento.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[MovEvento.MovEvento.Tipo]
Carpeta=MovEvento
Clave=MovEvento.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MovEvento.MovEvento.Estado]
Carpeta=MovEvento
Clave=MovEvento.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro


[OC]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Orden Compra
Clave=OC
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaPOS
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

CondicionVisible=Config.VentaVerDatosOC y (MovTipo(<T>VTAS<T>,VentaPOS:VentaPOS.Mov) noen (VTAS.D,VTAS.DF,VTAS.B,VTAS.DC,VTAS.DCR))
[OC.VentaPOS.OrdenCompra]
Carpeta=OC
Clave=VentaPOS.OrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[OC.VentaPOS.FechaOrdenCompra]
Carpeta=OC
Clave=VentaPOS.FechaOrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[OC.VentaPOS.ReferenciaOrdenCompra]
Carpeta=OC
Clave=VentaPOS.ReferenciaOrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Detalle.VentaDPOS.DescripcionExtra]
Carpeta=Detalle
Clave=VentaDPOS.DescripcionExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Negro
ColorFondo=Plata
IgnoraFlujo=N

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Negro
ColorFondo=Blanco
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=370
VerValor=370


[Acciones.FormaAnexoAbrir]
Nombre=FormaAnexoAbrir
Boton=0
EsDefault=S
NombreDesplegar=&Abrir
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(Anexo.Modulo, <T>VTAS<T>)<BR>Asigna(Anexo.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Anexo.Mov, VentaPOS:VentaPOS.Mov)<BR>Asigna(Anexo.MovID, VentaPOS:VentaPOS.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, Anexo.Mov, Anexo.MovID)
EjecucionCondicion=ConDatos(MovFormaAnexo:Clave)

[Acciones.FormaAnexoAnexar]
Nombre=FormaAnexoAnexar
Boton=0
NombreDesplegar=Ane&xar...
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
Expresion=Asigna(Anexo.Modulo, <T>VTAS<T>)<BR>Asigna(Anexo.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Anexo.Mov, VentaPOS:VentaPOS.Mov)<BR>Asigna(Anexo.MovID, VentaPOS:VentaPOS.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo.Anexar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, BuscarArchivo(<T><T>, Anexo.Clave+<T>.xml<T>, <T>xml<T>, Anexo.Clave, <T>Formas InfoPath<T>))
ActivoCondicion=MovFormaAnexo:Icono=732
EjecucionCondicion=ConDatos(MovFormaAnexo:Nombre)

[Acciones.FormaAnexoEliminar]
Nombre=FormaAnexoEliminar
Boton=0
NombreDesplegar=E&liminar
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(Anexo.Modulo, <T>VTAS<T>)<BR>Asigna(Anexo.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Anexo.Mov, VentaPOS:VentaPOS.Mov)<BR>Asigna(Anexo.MovID, VentaPOS:VentaPOS.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo.Eliminar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo)
ActivoCondicion=MovFormaAnexo:Icono=731


[Notas.VentaPOS.Enganche]
Carpeta=Notas
Clave=VentaPOS.Enganche
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Ficha.VentaPOS.FormaPagoTipo]
Carpeta=Ficha
Clave=VentaPOS.FormaPagoTipo
Editar=S
3D=S
Tamano=17
ColorFondo=Blanco

[Detalle.VentaDPOS.PrecioMoneda]
Carpeta=Detalle
Clave=VentaDPOS.PrecioMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaDPOS.PrecioTipoCambio]
Carpeta=Detalle
Clave=VentaDPOS.PrecioTipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaDPOS.ProveedorRef]
Carpeta=Detalle
Clave=VentaDPOS.ProveedorRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Oportunidad.VentaOportunidad.ImporteEstimado]
Carpeta=Oportunidad
Clave=VentaOportunidad.ImporteEstimado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Oportunidad.VentaOportunidad.Etapa]
Carpeta=Oportunidad
Clave=VentaOportunidad.Etapa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Oportunidad.VentaOportunidad.Avance]
Carpeta=Oportunidad
Clave=VentaOportunidad.Avance
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Oportunidad.VentaOportunidad.ProbabilidadCierre]
Carpeta=Oportunidad
Clave=VentaOportunidad.ProbabilidadCierre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Oportunidad.VentaOportunidad.FechaEstimadaCierre]
Carpeta=Oportunidad
Clave=VentaOportunidad.FechaEstimadaCierre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Oportunidad.VentaOportunidad.PresupuestoAsignado]
Carpeta=Oportunidad
Clave=VentaOportunidad.PresupuestoAsignado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Competidores.VentaCompetidor.Orden]
Carpeta=Competidores
Clave=VentaCompetidor.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Competidores.VentaCompetidor.Competidor]
Carpeta=Competidores
Clave=VentaCompetidor.Competidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Competidores.VentaCompetidor.Producto]
Carpeta=Competidores
Clave=VentaCompetidor.Producto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Competidores.VentaCompetidor.Importe]
Carpeta=Competidores
Clave=VentaCompetidor.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Competidores.VentaCompetidor.Moneda]
Carpeta=Competidores
Clave=VentaCompetidor.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Competidores.VentaCompetidor.Situacion]
Carpeta=Competidores
Clave=VentaCompetidor.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Competidores.VentaCompetidor.Fecha]
Carpeta=Competidores
Clave=VentaCompetidor.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Competidores.VentaCompetidor.Observaciones]
Carpeta=Competidores
Clave=VentaCompetidor.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Competidores.Columnas]
Orden=35
Competidor=237
Producto=148
Importe=88
Moneda=64
Situacion=99
Fecha=83
Observaciones=675

[Oportunidad.VentaOportunidad.Observaciones]
Carpeta=Oportunidad
Clave=VentaOportunidad.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=90x3
ColorFondo=Blanco
ColorFuente=Negro


[CentrosCostos.VentaPOS.ContUso2]
Carpeta=CentrosCostos
Clave=VentaPOS.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CentrosCostos.VentaPOS.ContUso3]
Carpeta=CentrosCostos
Clave=VentaPOS.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaDPOS.ContUso2]
Carpeta=Detalle
Clave=VentaDPOS.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaDPOS.ContUso3]
Carpeta=Detalle
Clave=VentaDPOS.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
0=97
1=207
Cliente=117
Nombre=229
RFC=107

Tarima=124
Articulo=118
Descripcion1=184
Cantidad=51
Almacen=90
Posicion=64
Grupo=100
Sucursal=46
2=-2
3=-2
4=-2
5=-2
6=156
7=199
8=54
Serie=195
Importe=85
EstatusNombre=87
Tipo=87
Moneda=53
Saldo=79
SerieLote=153
Departamento=47
Clave=126
Contacto=229
Mov=124
MovID=64
FechaEmision=74
Referencia=96
Concepto=94
AnticipoSaldo=96
AnticipoAplicar=91
Impuestos=64
Retencion=64
Precio=90
[Desglose.Columnas]
Impuesto1=64
Impuesto2=64
Impuesto3=72
Importe1=64
Importe2=64
Importe3=64
Retencion1=64
Retencion2=64
Retencion3=64
ContUso=124
ContUso2=124
ContUso3=124


[Acciones.PersonalizarVista]
Nombre=PersonalizarVista
Boton=0
NombreDesplegar=Personalizar vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[MovImpuesto.MovImpuestoMov.Impuesto1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Impuesto2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Impuesto3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Importe1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Importe2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Importe3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Retencion1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Retencion2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.Retencion3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.ContUso]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.ContUso2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.MovImpuestoMov.ContUso3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MovImpuesto.Columnas]
0=-2
1=-2

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2


[Detalle.ListaOrden]
(Inicio)=VentaDPOS.Renglon<TAB>(Acendente)
VentaDPOS.Renglon<TAB>(Acendente)=VentaDPOS.RenglonSub<TAB>(Acendente)
VentaDPOS.RenglonSub<TAB>(Acendente)=(Fin)








[MovEvento.ListaAcciones]
(Inicio)=MovEventoAmpliar
MovEventoAmpliar=MovEventoImprimir
MovEventoImprimir=MovEventoPreliminar
MovEventoPreliminar=MovEventoExcel
MovEventoExcel=MovEventoPersonalizar
MovEventoPersonalizar=(Fin)

[MovEvento.ListaEnCaptura]
(Inicio)=MovEvento.Fecha
MovEvento.Fecha=MovEvento.Usuario
MovEvento.Usuario=MovEvento.Tipo
MovEvento.Tipo=MovEvento.Estado
MovEvento.Estado=(Fin)


[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)

[FormaAnexo.ListaEnCaptura]
(Inicio)=Usuario
Usuario=UltimoCambio
UltimoCambio=(Fin)

[FormaAnexo.ListaAcciones]
(Inicio)=FormaAnexoAbrir
FormaAnexoAbrir=FormaAnexoAnexar
FormaAnexoAnexar=FormaAnexoEliminar
FormaAnexoEliminar=(Fin)

[Oportunidad.ListaEnCaptura]
(Inicio)=VentaOportunidad.ImporteEstimado
VentaOportunidad.ImporteEstimado=VentaOportunidad.PresupuestoAsignado
VentaOportunidad.PresupuestoAsignado=VentaOportunidad.Etapa
VentaOportunidad.Etapa=VentaOportunidad.Avance
VentaOportunidad.Avance=VentaOportunidad.ProbabilidadCierre
VentaOportunidad.ProbabilidadCierre=VentaOportunidad.FechaEstimadaCierre
VentaOportunidad.FechaEstimadaCierre=VentaOportunidad.Observaciones
VentaOportunidad.Observaciones=(Fin)

[Competidores.ListaEnCaptura]
(Inicio)=VentaCompetidor.Orden
VentaCompetidor.Orden=VentaCompetidor.Competidor
VentaCompetidor.Competidor=VentaCompetidor.Producto
VentaCompetidor.Producto=VentaCompetidor.Importe
VentaCompetidor.Importe=VentaCompetidor.Moneda
VentaCompetidor.Moneda=VentaCompetidor.Situacion
VentaCompetidor.Situacion=VentaCompetidor.Fecha
VentaCompetidor.Fecha=VentaCompetidor.Observaciones
VentaCompetidor.Observaciones=(Fin)

[CentrosCostos.ListaEnCaptura]
(Inicio)=VentaPOS.ContUso2
VentaPOS.ContUso2=VentaPOS.ContUso3
VentaPOS.ContUso3=(Fin)


[Corrida.ListaEnCaptura]
(Inicio)=VentaPOS.Espacio
VentaPOS.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.Servicio
Espacio.Servicio=Espacio.Rol
Espacio.Rol=VentaPOS.AutoCorrida
VentaPOS.AutoCorrida=AutoCorrida.Nombre
AutoCorrida.Nombre=VentaPOS.AutoCorridaServicio
VentaPOS.AutoCorridaServicio=VentaPOS.AutoCorridaRol
VentaPOS.AutoCorridaRol=VentaPOS.AutoBoleto
VentaPOS.AutoBoleto=VentaPOS.AutoCorridaRuta
VentaPOS.AutoCorridaRuta=VentaPOS.AutoCorridaOrigen
VentaPOS.AutoCorridaOrigen=VentaPOS.AutoCorridaDestino
VentaPOS.AutoCorridaDestino=VentaPOS.AutoCorridaHora
VentaPOS.AutoCorridaHora=VentaPOS.AutoCorridaKms
VentaPOS.AutoCorridaKms=VentaPOS.AutoCorridaLts
VentaPOS.AutoCorridaLts=VentaPOS.AutoOperador2
VentaPOS.AutoOperador2=VentaPOS.AutoBomba
VentaPOS.AutoBomba=VentaPOS.AutoBombaContador
VentaPOS.AutoBombaContador=VentaPOS.AutoKmsActuales
VentaPOS.AutoKmsActuales=VentaPOS.AutoKms
VentaPOS.AutoKms=(Fin)
























[Agrupadores.Contrato.MovID]
Carpeta=Agrupadores
Clave=Contrato.MovID
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro









[MovImpuesto.ListaEnCaptura]
(Inicio)=MovImpuestoMov.Impuesto1
MovImpuestoMov.Impuesto1=MovImpuestoMov.Impuesto2
MovImpuestoMov.Impuesto2=MovImpuestoMov.Impuesto3
MovImpuestoMov.Impuesto3=MovImpuestoMov.Importe1
MovImpuestoMov.Importe1=MovImpuestoMov.Importe2
MovImpuestoMov.Importe2=MovImpuestoMov.Importe3
MovImpuestoMov.Importe3=MovImpuestoMov.Retencion1
MovImpuestoMov.Retencion1=MovImpuestoMov.Retencion2
MovImpuestoMov.Retencion2=MovImpuestoMov.Retencion3
MovImpuestoMov.Retencion3=MovImpuestoMov.ContUso
MovImpuestoMov.ContUso=MovImpuestoMov.ContUso2
MovImpuestoMov.ContUso2=MovImpuestoMov.ContUso3
MovImpuestoMov.ContUso3=(Fin)










[Agrupadores.VentaPOS.ContratoMov]
Carpeta=Agrupadores
Clave=VentaPOS.ContratoMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agrupadores.VentaPOS.ContratoMovID]
Carpeta=Agrupadores
Clave=VentaPOS.ContratoMovID
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Detalle.VolumenTotal]
Carpeta=Detalle
Clave=VolumenTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.PesoTotal]
Carpeta=Detalle
Clave=PesoTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[(Carpeta Totalizadores).Sub]
Carpeta=(Carpeta Totalizadores)
Clave=Sub
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata

Pegado=S
[(Carpeta Totalizadores).Impto]
Carpeta=(Carpeta Totalizadores)
Clave=Impto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata











Pegado=S






















[Agrupadores.ListaEnCaptura]
(Inicio)=VentaPOS.ContratoMov
VentaPOS.ContratoMov=VentaPOS.ContratoMovID
VentaPOS.ContratoMovID=(Fin)


























































[(Carpeta Totalizadores).Peso]
Carpeta=(Carpeta Totalizadores)
Clave=Peso
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Plata

[(Carpeta Totalizadores).Volumen]
Carpeta=(Carpeta Totalizadores)
Clave=Volumen
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Plata











[Detalle.VentaDPOS.TipoImpuesto1]
Carpeta=Detalle
Clave=VentaDPOS.TipoImpuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaDPOS.TipoImpuesto2]
Carpeta=Detalle
Clave=VentaDPOS.TipoImpuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaDPOS.TipoImpuesto3]
Carpeta=Detalle
Clave=VentaDPOS.TipoImpuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco







































[Detalle.VentaDPOS.Impuesto1]
Carpeta=Detalle
Clave=VentaDPOS.Impuesto1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaDPOS.Impuesto2]
Carpeta=Detalle
Clave=VentaDPOS.Impuesto2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[Anexo.VentaPOS.Establecimiento]
Carpeta=Anexo
Clave=VentaPOS.Establecimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

LineaNueva=N
[Anexo.VentaPOS.PuntoEmision]
Carpeta=Anexo
Clave=VentaPOS.PuntoEmision
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=5
ColorFondo=Blanco

Pegado=S
[Anexo.VentaPOS.SecuencialSRI]
Carpeta=Anexo
Clave=VentaPOS.SecuencialSRI
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco

LineaNueva=N
Pegado=S
[Anexo.VentaPOS.AutorizacionSRI]
Carpeta=Anexo
Clave=VentaPOS.AutorizacionSRI
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Anexo.VentaPOS.VigenteA]
Carpeta=Anexo
Clave=VentaPOS.VigenteA
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

LineaNueva=S
Tamano=20


EspacioPrevio=N
[Detalle.VentaDPOS.Establecimiento]
Carpeta=Detalle
Clave=VentaDPOS.Establecimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Detalle.VentaDPOS.VigenteA]
Carpeta=Detalle
Clave=VentaDPOS.VigenteA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[VentaFlexibleD.VentaFlexibleD.Cliente]
Carpeta=VentaFlexibleD
Clave=VentaFlexibleD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[VentaFlexibleD.Cte.Nombre]
Carpeta=VentaFlexibleD
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[VentaFlexibleD.VentaFlexibleD.Articulo]
Carpeta=VentaFlexibleD
Clave=VentaFlexibleD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[VentaFlexibleD.Art.Descripcion1]
Carpeta=VentaFlexibleD
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[VentaFlexibleD.VentaFlexibleD.Cantidad]
Carpeta=VentaFlexibleD
Clave=VentaFlexibleD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaFlexibleD.VentaFlexibleD.Precio]
Carpeta=VentaFlexibleD
Clave=VentaFlexibleD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaFlexibleD.VentaFlexibleD.Importe]
Carpeta=VentaFlexibleD
Clave=VentaFlexibleD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[VentaFlexibleD.Columnas]
Cliente=93
Nombre=207
Articulo=64
Descripcion1=203
Cantidad=64
Precio=64
Importe=64













[VentaFlexibleD.ListaEnCaptura]
(Inicio)=VentaFlexibleD.Cliente
VentaFlexibleD.Cliente=Cte.Nombre
Cte.Nombre=VentaFlexibleD.Articulo
VentaFlexibleD.Articulo=Art.Descripcion1
Art.Descripcion1=VentaFlexibleD.Cantidad
VentaFlexibleD.Cantidad=VentaFlexibleD.Precio
VentaFlexibleD.Precio=VentaFlexibleD.Importe
VentaFlexibleD.Importe=(Fin)

















































[Anexo.ListaEnCaptura]
(Inicio)=VentaPOS.Establecimiento
VentaPOS.Establecimiento=VentaPOS.PuntoEmision
VentaPOS.PuntoEmision=VentaPOS.SecuencialSRI
VentaPOS.SecuencialSRI=VentaPOS.AutorizacionSRI
VentaPOS.AutorizacionSRI=VentaPOS.VigenteA
VentaPOS.VigenteA=(Fin)

















[Detalle.VentaDPOS.Impuesto3]
Carpeta=Detalle
Clave=VentaDPOS.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco












[Contrato.ListaEnCaptura]
(Inicio)=VentaPOS.ContratoDescripcion
VentaPOS.ContratoDescripcion=VentaPOS.ContratoTipo
VentaPOS.ContratoTipo=VentaPOS.ContratoSeguro
VentaPOS.ContratoSeguro=VentaPOS.ContratoValor
VentaPOS.ContratoValor=VentaPOS.ContratoValorMoneda
VentaPOS.ContratoValorMoneda=VentaPOS.ContratoSerie
VentaPOS.ContratoSerie=VentaPOS.ContratoResponsable
VentaPOS.ContratoResponsable=VentaPOS.ContratoVencimiento
VentaPOS.ContratoVencimiento=VentaPOS.Periodicidad
VentaPOS.Periodicidad=VentaPOS.VigenciaDesde
VentaPOS.VigenciaDesde=VentaPOS.VigenciaHasta
VentaPOS.VigenciaHasta=VentaPOS.ConVigencia
VentaPOS.ConVigencia=(Fin)








[Gasto.ListaEnCaptura]
(Inicio)=VentaPOS.GastoAcreedor
VentaPOS.GastoAcreedor=Acreedor.Nombre
Acreedor.Nombre=VentaPOS.GastoConcepto
VentaPOS.GastoConcepto=(Fin)




[Servicio.ListaEnCaptura]
(Inicio)=VentaPOS.ServicioSerie
VentaPOS.ServicioSerie=VentaPOS.ServicioNumeroEconomico
VentaPOS.ServicioNumeroEconomico=VentaPOS.ServicioPlacas
VentaPOS.ServicioPlacas=VentaPOS.ServicioKms
VentaPOS.ServicioKms=VentaPOS.ServicioArticulo
VentaPOS.ServicioArticulo=ArtDestino.Descripcion1
ArtDestino.Descripcion1=VentaPOS.ServicioPoliza
VentaPOS.ServicioPoliza=VentaPOS.Cliente
VentaPOS.Cliente=Cte.Nombre
Cte.Nombre=Cte.Telefonos
Cte.Telefonos=VentaPOS.ListaPreciosEsp
VentaPOS.ListaPreciosEsp=VentaPOS.ServicioTipo
VentaPOS.ServicioTipo=VentaPOS.ServicioTipoOperacion
VentaPOS.ServicioTipoOperacion=VentaPOS.ServicioTipoOrden
VentaPOS.ServicioTipoOrden=VentaPOS.ServicioFecha
VentaPOS.ServicioFecha=VentaPOS.ServicioAseguradora
VentaPOS.ServicioAseguradora=VentaPOS.ServicioSiniestro
VentaPOS.ServicioSiniestro=VentaPOS.ServicioContrato
VentaPOS.ServicioContrato=VentaPOS.ServicioContratoID
VentaPOS.ServicioContratoID=VentaPOS.ServicioContratoTipo
VentaPOS.ServicioContratoTipo=VentaPOS.ServicioDescripcion
VentaPOS.ServicioDescripcion=VentaPOS.ServicioGarantia
VentaPOS.ServicioGarantia=VentaPOS.ServicioExpress
VentaPOS.ServicioExpress=VentaPOS.ServicioPuntual
VentaPOS.ServicioPuntual=VentaPOS.ServicioDemerito
VentaPOS.ServicioDemerito=VentaPOS.ServicioFlotilla
VentaPOS.ServicioFlotilla=VentaPOS.ServicioRampa
VentaPOS.ServicioRampa=VentaPOS.ServicioDeducible
VentaPOS.ServicioDeducible=VentaPOS.ServicioDeducibleImporte
VentaPOS.ServicioDeducibleImporte=VentaPOS.ServicioIdentificador
VentaPOS.ServicioIdentificador=VentaPOS.ServicioNumero
VentaPOS.ServicioNumero=(Fin)






[Notas.ListaEnCaptura]
(Inicio)=VentaPOS.Observaciones
VentaPOS.Observaciones=VentaPOS.EndosarA
VentaPOS.EndosarA=VentaPOS.ZonaImpuesto
VentaPOS.ZonaImpuesto=VentaPOS.Prioridad
VentaPOS.Prioridad=VentaPOS.Enganche
VentaPOS.Enganche=VentaPOS.AnticiposFacturados
VentaPOS.AnticiposFacturados=VentaPOS.Atencion
VentaPOS.Atencion=VentaPOS.AtencionTelefono
VentaPOS.AtencionTelefono=VentaPOS.Departamento
VentaPOS.Departamento=VentaPOS.AgenteComision
VentaPOS.AgenteComision=VentaPOS.AgenteServicio
VentaPOS.AgenteServicio=AgenteDestino.Nombre
AgenteDestino.Nombre=VentaPOS.Causa
VentaPOS.Causa=VentaPOS.ServicioTipo
VentaPOS.ServicioTipo=VentaPOS.FechaOriginal
VentaPOS.FechaOriginal=VentaPOS.SucursalVenta
VentaPOS.SucursalVenta=VentaPOS.Bonificacion
VentaPOS.Bonificacion=VentaPOS.Clase
VentaPOS.Clase=VentaPOS.Subclase
VentaPOS.Subclase=VentaPOS.VigenciaDesde
VentaPOS.VigenciaDesde=VentaPOS.VigenciaHasta
VentaPOS.VigenciaHasta=VentaPOS.Periodicidad
VentaPOS.Periodicidad=VentaPOS.DesglosarImpuestos
VentaPOS.DesglosarImpuestos=VentaPOS.DesglosarImpuesto2
VentaPOS.DesglosarImpuesto2=VentaPOS.ConVigencia
VentaPOS.ConVigencia=VentaPOS.Extra
VentaPOS.Extra=VentaPOS.ExcluirPlaneacion
VentaPOS.ExcluirPlaneacion=VentaPOS.GenerarOP
VentaPOS.GenerarOP=VentaPOS.Extra1
VentaPOS.Extra1=VentaPOS.AF
VentaPOS.AF=VentaPOS.AFArticulo
VentaPOS.AFArticulo=VentaPOS.AFSerie
VentaPOS.AFSerie=(Fin)


















[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Peso
Peso=Volumen
Volumen=Importe
Importe=Desc
Desc=Sub
Sub=Impto
Impto=Total
Total=Renglon
Renglon=(Fin)



















































































































[(Carpeta Abrir).VentaPOS.Cliente]
Carpeta=(Carpeta Abrir)
Clave=VentaPOS.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).VentaPOS.Almacen]
Carpeta=(Carpeta Abrir)
Clave=VentaPOS.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).VentaPOS.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=VentaPOS.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).VentaPOS.Importe]
Carpeta=(Carpeta Abrir)
Clave=VentaPOS.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).VentaPOS.Saldo]
Carpeta=(Carpeta Abrir)
Clave=VentaPOS.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=VentaPOS.Cliente
VentaPOS.Cliente=Cte.Nombre
Cte.Nombre=VentaPOS.Almacen
VentaPOS.Almacen=VentaPOS.FechaEmision
VentaPOS.FechaEmision=VentaPOS.Importe
VentaPOS.Importe=VentaPOS.Saldo
VentaPOS.Saldo=Dias
Dias=Throughput
Throughput=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=(por Autorizar)
(por Autorizar)=SINAFECTAR
SINAFECTAR=BORRADOR
BORRADOR=CONFIRMAR
CONFIRMAR=PENDIENTE
PENDIENTE=FUERALINEA
FUERALINEA=SINCRO
SINCRO=RECURRENTE
RECURRENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=PROCESAR
PROCESAR=VIGENTE
VIGENTE=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirEnviar
AbrirEnviar=AbrirMostrar
AbrirMostrar=EmbarqueMovPendientes
EmbarqueMovPendientes=(Fin)











































































































































[AC.ListaEnCaptura]
(Inicio)=VentaPOS.LineaCredito
VentaPOS.LineaCredito=LC.Descripcion
LC.Descripcion=LC.VigenciaDesde
LC.VigenciaDesde=LC.VigenciaHasta
LC.VigenciaHasta=VentaPOS.TipoAmortizacion
VentaPOS.TipoAmortizacion=TipoAmortizacion.Descripcion
TipoAmortizacion.Descripcion=VentaPOS.Condicion
VentaPOS.Condicion=VentaPOS.Vencimiento
VentaPOS.Vencimiento=VentaPOS.TipoTasa
VentaPOS.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=VentaPOS.TieneTasaEsp
VentaPOS.TieneTasaEsp=VentaPOS.TasaEsp
VentaPOS.TasaEsp=VentaPOS.Comisiones
VentaPOS.Comisiones=VentaPOS.ComisionesIVA
VentaPOS.ComisionesIVA=TotalComisiones
TotalComisiones=(Fin)




[OC.ListaEnCaptura]
(Inicio)=VentaPOS.OrdenCompra
VentaPOS.OrdenCompra=VentaPOS.FechaOrdenCompra
VentaPOS.FechaOrdenCompra=VentaPOS.ReferenciaOrdenCompra
VentaPOS.ReferenciaOrdenCompra=(Fin)







[Detalle.ResumenCampos]
(Inicio)=Articulo
Articulo=Descripcion
Descripcion=Cantidad
Cantidad=Precio
Precio=DescuentoLinea
DescuentoLinea=Importe
Importe=Almacen
Almacen=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=VentaDPOS.Codigo
VentaDPOS.Codigo=VentaDPOS.Articulo
VentaDPOS.Articulo=VentaDPOS.SubCuenta
VentaDPOS.SubCuenta=ClaveIdioma
ClaveIdioma=VentaDPOS.SustitutoArticulo
VentaDPOS.SustitutoArticulo=VentaDPOS.SustitutoSubCuenta
VentaDPOS.SustitutoSubCuenta=VentaDPOS.Espacio
VentaDPOS.Espacio=VentaDPOS.Cantidad
VentaDPOS.Cantidad=CantidadNeta
CantidadNeta=PesoTotal
PesoTotal=VolumenTotal
VolumenTotal=VentaDPOS.Unidad
VentaDPOS.Unidad=VentaDPOS.CantidadInventario
VentaDPOS.CantidadInventario=CantidadInvNeta
CantidadInvNeta=Art.Horas
Art.Horas=VentaDPOS.Precio
VentaDPOS.Precio=VentaDPOS.DescuentoLinea
VentaDPOS.DescuentoLinea=VentaDPOS.DescuentoImporte
VentaDPOS.DescuentoImporte=VentaDPOS.PrecioMoneda
VentaDPOS.PrecioMoneda=VentaDPOS.PrecioTipoCambio
VentaDPOS.PrecioTipoCambio=VentaDPOS.FechaRequerida
VentaDPOS.FechaRequerida=Importe
Importe=VentaDPOS.TipoImpuesto1
VentaDPOS.TipoImpuesto1=VentaDPOS.Impuesto1
VentaDPOS.Impuesto1=SubImpuesto1
SubImpuesto1=VentaDPOS.TipoImpuesto2
VentaDPOS.TipoImpuesto2=VentaDPOS.Impuesto2
VentaDPOS.Impuesto2=SubImpuesto2
SubImpuesto2=VentaDPOS.TipoImpuesto3
VentaDPOS.TipoImpuesto3=VentaDPOS.Impuesto3
VentaDPOS.Impuesto3=SubImpuesto3
SubImpuesto3=VentaDPOS.ContUso
VentaDPOS.ContUso=VentaDPOS.ContUso2
VentaDPOS.ContUso2=VentaDPOS.ContUso3
VentaDPOS.ContUso3=VentaDPOS.ProveedorRef
VentaDPOS.ProveedorRef=VentaDPOS.Costo
VentaDPOS.Costo=CostoTotal
CostoTotal=VentaDPOS.Paquete
VentaDPOS.Paquete=VentaDPOS.AutoLocalidad
VentaDPOS.AutoLocalidad=VentaDPOS.DescripcionExtra
VentaDPOS.DescripcionExtra=VentaDPOS.CantidadReservada
VentaDPOS.CantidadReservada=VentaDPOS.CantidadOrdenada
VentaDPOS.CantidadOrdenada=VentaDPOS.CantidadPendiente
VentaDPOS.CantidadPendiente=VentaDPOS.ServicioNumero
VentaDPOS.ServicioNumero=VentaDPOS.Estado
VentaDPOS.Estado=VentaDPOS.CantidadA
VentaDPOS.CantidadA=VentaDPOS.Establecimiento
VentaDPOS.Establecimiento=VentaDPOS.VigenteA
VentaDPOS.VigenteA=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=DescripcionIdioma
DescripcionIdioma=OpcionDesc
OpcionDesc=Art.Unidad
Art.Unidad=Art.Tipo
Art.Tipo=Art.PrecioLista
Art.PrecioLista=Art.PrecioMinimo
Art.PrecioMinimo=(Fin)

[Detalle.ListaAcciones]
(Inicio)=Observaciones
Observaciones=VerPoliticaDetalle
VerPoliticaDetalle=DesglosarCantidadOrdenada
DesglosarCantidadOrdenada=VerOpciones
VerOpciones=AutoBoleto
AutoBoleto=ExcluirISAN
ExcluirISAN=(Fin)





[Ficha.ListaEnCaptura]
(Inicio)=VentaPOS.Mov
VentaPOS.Mov=VentaPOS.MovID
VentaPOS.MovID=VentaPOS.Proyecto
VentaPOS.Proyecto=VentaPOS.UEN
VentaPOS.UEN=VentaPOS.Moneda
VentaPOS.Moneda=VentaPOS.TipoCambio
VentaPOS.TipoCambio=VentaPOS.ServicioContratoTipo
VentaPOS.ServicioContratoTipo=VentaPOS.FechaEmision
VentaPOS.FechaEmision=VentaPOS.FechaRequerida
VentaPOS.FechaRequerida=VentaPOS.HoraRequerida
VentaPOS.HoraRequerida=VentaPOS.FechaOriginal
VentaPOS.FechaOriginal=VentaPOS.Retencion
VentaPOS.Retencion=VentaPOS.Cliente
VentaPOS.Cliente=Cte.Nombre
Cte.Nombre=Cte.RFC
Cte.RFC=VentaPOS.ListaPreciosEsp
VentaPOS.ListaPreciosEsp=VentaPOS.EnviarA
VentaPOS.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Direccion
CteEnviarA.Direccion=CteEnviarA.Clave
CteEnviarA.Clave=VentaPOS.FormaEnvio
VentaPOS.FormaEnvio=VentaPOS.Agente
VentaPOS.Agente=VentaPOS.Almacen
VentaPOS.Almacen=VentaPOS.AlmacenDestino
VentaPOS.AlmacenDestino=VentaPOS.Concepto
VentaPOS.Concepto=VentaPOS.Condicion
VentaPOS.Condicion=VentaPOS.Vencimiento
VentaPOS.Vencimiento=VentaPOS.FormaPagoTipo
VentaPOS.FormaPagoTipo=VentaPOS.Descuento
VentaPOS.Descuento=VentaPOS.DescuentoGlobal
VentaPOS.DescuentoGlobal=VentaPOS.Referencia
VentaPOS.Referencia=VentaPOS.OrdenCompra
VentaPOS.OrdenCompra=VentaPOS.Directo
VentaPOS.Directo=(Fin)






































































[Acciones.Afectar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaPOS:VentaPOS.ID)<BR>Asigna(Info.Mov, VentaPOS:VentaPOS.Mov)<BR>Asigna(Info.MovID, VentaPOS:VentaPOS.MovID)<BR>Asigna(Info.Cliente, VentaPOS:VentaPOS.Cliente)<BR>Asigna(Info.OrigenTipo, VentaPOS:VentaPOS.OrigenTipo)<BR>Si<BR>  Config.VentaActualizarPrecioMoneda y (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y SQL(<T>spVentaActualizarPreciosChecar :nID<T>, VentaPOS:VentaPOS.ID)<BR>Entonces<BR>  Caso Confirmacion(<T>¿ Desea Actualizar los Precios Otras Monedas ?<T>, BotonSi, BotonNo, BotonCancelar)<BR>    Es BotonSi Entonces EjecutarSQL(<T>spVentaActualizarPrecios :nID<T>, VentaPOS:VentaPOS.ID) AbortarOperacion<BR>    Es BotonCancelar Entonces AbortarOperacion<BR>  Fin<BR>Fin<BR><BR>Si(General.OFER y (Info.OrigenTipo <> <T>VMOS<T>), EjecutarSQL(<T>spOfertaAplicar :nID<T>, VentaPOS:VentaPOS.ID))<BR>Si<BR>  (VentaPOS:VentaPOS.Mov=Info.MovProcesar) y (VentaPOS:VentaPOS.Estatus=EstatusSinAfectar)<BR>Entonces<BR>  EjecutarSQL(<T>xpVentaAutoProcesar :nID<T>, VentaPOS:VentaPOS.ID)<BR>Sino<BR>  Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>  Asigna(Afectar.ID, VentaPOS:VentaPOS.ID)<BR>  Asigna(Afectar.Mov, VentaPOS:VentaPOS.Mov)<BR>  Asigna(Afectar.MovID, VentaPOS:VentaPOS.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>  Asigna(Afectar.EnviarCFD, Falso)<BR>  Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, VentaPOS:VentaPOS.Mov))<BR>  Asigna(Info.Cliente, VentaPOS:VentaPOS.Cliente)<BR>  Asigna(Info.Moneda, VentaPOS:VentaPOS.Moneda)<BR>  Asigna(Info.TipoCambio, VentaPOS:VentaPOS.TipoCambio)<BR>  Asigna(Info.Importe, Redondea(Suma(VentaDPOS:Importe)+Suma(VentaDPOS:Impuesto)-Suma(VentaDPOS:DescGlobal)+Suma(VentaDPOS:ImporteSobrePrecio)-(VentaPOS:VentaPOS.AnticiposFacturados+VentaPOS:VentaPOS.Retencion), Config.VentaCobroRedondeoDecimales))<BR>  Si<BR>    (Info.Importe<>0) y<BR>    (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y<BR>    ((MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.N, VTAS.FM)) y (ConDatos(VentaPOS:VentaPOS.MovID) o Config.VentaLiquidaIntegral) y (VentaPOS:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>)) o<BR>    (MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.S, VTAS.P, VTAS.VP, VTAS.SD, VTAS.B))  y (VentaPOS:Condicion.ControlAnticipos=<T>Cobrar Pedido<T>)) o<BR>    (MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.F, VTAS.FAR, VTAS.FB, VTAS.D, VTAS.DF)) y (VentaPOS:VentaPOS.Vencimiento<=VentaPOS:VentaPOS.FechaEmision) y Config.FacturaCobroIntegrado y (VentaPOS:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>) y (VentaPOS:VentaPOS.OrigenTipo<><T>VMOS<T>)))<BR>  Entonces<BR>    Asigna(Info.ID, VentaPOS:VentaPOS.ID)<BR>    Asigna(Info.Cerrado, Falso)<BR>    Asigna(Info.VentaCobroDevolucion, MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.VP, VTAS.SD, VTAS.B, VTAS.D, VTAS.DF)))<BR>    Forma(<T>VentaCobro<T>)<BR>  Sino<BR>    Si<BR>      (VentaPOS:VentaPOS.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) o ((MovTipo(<T>VTAS<T>,VentaPOS:VentaPOS.Mov)=VTAS.S) y (VentaPOS:VentaPOS.Estatus=EstatusPorConfirmar))<BR>    Entonces<BR>      Si(Config.CompraVentaSinIVA y (Suma(VentaDPOS:Impuesto)=0.0) y (Suma(VentaDPOS:Importe)>0.0), Si(Confirmacion(<T>Movimiento sin Impuestos<T>+NuevaLinea+<T>¿ Es Correcto ?<T>,BotonSi,BotonNo)=BotonNo,AbortarOperacion))<BR><BR>      Si<BR>        Empresa.CFD y SQL(<T>spVerMovTipoCFD :tEmpresa, :tModulo, :tMov<T>, Empresa, Afectar.Modulo, Afectar.Mov)<BR>      Entonces<BR>        EjecutarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, Afectar.Modulo, Afectar.ID, <T>CONSECUTIVO<T>)<BR>        Si(no CFD.Generar(Afectar.Modulo, Afectar.ID),  Forma.ActualizarForma AbortarOperacion)<BR>        Asigna(Afectar.EnviarCFD, SQL(<T>SELECT EnviarAlAfectar FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>, Empresa))<BR>      Fin<BR><BR>      Si<BR>        VentaPOS:VentaPOS.Estatus=EstatusPorConfirmar<BR>      Entonces<BR>        Caso MovTipo(<T>VTAS<T>, VentaPOS:VentaPOS.Mov)<BR>          Es VTAS.S  Entonces Dialogo(<T>GenerarServicioPorConfirmar<T>)<BR>          Es VTAS.CS Entonces Dialogo(<T>GenerarCotizacionServicio<T>)<BR>          Es VTAS.OP Entonces Dialogo(<T>GenerarOportunidad<T>)<BR>          Es VTAS.C  Entonces<BR>                      Si (VentaPOS:VentaPOS.OrigenTipo=<T>VTAS<T>) y (MovTipo(<T>VTAS<T>, VentaPOS:VentaPOS.Origen)=VTAS.S)<BR>                       Entonces<BR>                         Asigna(Afectar.Mov, VentaPOS:VentaPOS.Origen)<BR>                         Asigna(Afectar.MovID, VentaPOS:VentaPOS.OrigenID)<BR>                         Asigna(Afectar.ID, SQL(<T>SELECT ID FROM Venta WHERE Empresa = :tEmpresa AND Mov = :tMov AND MovID = :tMovID AND Estatus NOT IN (<T>+Comillas(EstatusSinAfectar)+<T>, <T>+Comillas(EstatusCancelado)+<T>)<T>, Empresa, Afectar.Mov, Afectar.MovID))<BR>                         Dialogo(<T>AfectarServicio<T>)<BR>                       Sino<BR>                         Dialogo(<T>GenerarCotizacion<T>)<BR>                     Fin<BR>          Es VTAS.CO Entonces Dialogo(<T>GenerarContrato<T>)<BR>          Sino Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>        Fin<BR>      Sino<BR>        Si<BR>          Config.Partidas y (MovTipo(<T>VTAS<T>, VentaPOS:VentaPOS.Mov)=VTAS.R)<BR>        Entonces<BR>          Forma(<T>AfectarPartidasRemision<T>)<BR>        Sino<BR>          Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>        Fin<BR>      Fin<BR>      CFD.Confirmar                                                 <BR>      Si(Afectar.EnviarCFD, CFD.Enviar(Afectar.Modulo, Afectar.ID))<BR>    Sino<BR>      Asigna(Info.Modulo, <T>VTAS<T>)<BR>      Asigna(Info.Mov, VentaPOS:VentaPOS.Mov)<BR>      Asigna(Info.MovID, VentaPOS:VentaPOS.MovID)<BR>      Asigna(Afectar.Base, <T>Pendiente<T>)<BR>      Asigna(Afectar.GenerarMov, <T><T>)<BR>      Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>      Si<BR>        (ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T>) y (no MovTipoEn(<T>VTAS<T>, VentaPOS:VentaPOS.Mov, (VTAS.F, VTAS.FAR, VTAS.FB)))<BR>      Entonces<BR>        Si <BR>          Forma(<T>GenerarMovFlujo<T>)<BR>        Entonces<BR>          Caso Info.MovGenerar<BR>            Es <T>(Reservar)<T>    Entonces Si(Usuario.Reservar,    Dialogo(<T>Reservar<T>),     Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Desreservar)<T> Entonces Si(Usuario.Desreservar, Dialogo(<T>DesReservar<T>),  Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Asignar)<T>     Entonces Si(Usuario.Asignar,     Dialogo(<T>Asignar<T>),      Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Desasignar)<T>  Entonces Si(Usuario.DesAsignar,  Dialogo(<T>DesAsignar<T>),   Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Facturacion Rapida)<T>          Entonces ProcesarSQL(<T>spFacturacionRapida :nID, :tUsuario, :tEmpresa<T>,    Afectar.ID, Usuario, Empresa)<BR>            Es <T>(Facturacion Rapida Agrupada)<T> Entonces ProcesarSQL(<T>spFacturacionRapida :nID, :tUsuario, :tEmpresa, 1<T>, Afectar.ID, Usuario, Empresa)<BR>            Es <T>(Generar Orden Transferencia)<T><BR>             Entonces<BR>               Si <BR>                 Usuario.PedidoGenerarOT y Dialogo(<T>EstaSeguro<T>)<BR>               Entonces<BR>                 Si<BR>                   Usuario.PedidoGenerarOTAbrir<BR>                 Entonces<BR>                   FormaPos(<T>Inv<T>, SQLEnLista(<T>spPedidoGenerarOT :tEmpresa, :nID, :nSucursal, :tUsuario, :tMov, @VerID = 1<T>, Empresa, VentaPOS:VentaPOS.ID, Sucursal, Usuario, ConfigMov.InvOrdenTransferencia))<BR>                 Sino<BR>                   ProcesarSQL(<T>spPedidoGenerarOT :tEmpresa, :nID, :nSucursal, :tUsuario, :tMov<T>, Empresa, VentaPOS:VentaPOS.ID, Sucursal, Usuario, ConfigMov.InvOrdenTransferencia)<BR>                 Fin<BR>               Sino<BR>                 Precaucion(<T>No Tiene Acceso<T>)<BR>               Fin<BR>            Sino<BR>              Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>              Asigna(Info.TituloDialogo, <T>Generar <T>+Comillas(Info.MovGenerar)+<T> de <T>+Comillas(Info.Mov))<BR>              Dialogo(<T>GenerarPedidoPendiente<T>)<BR>          Fin<BR>        Fin<BR>      Sino<BR>        Caso MovTipo(<T>VTAS<T>, VentaPOS:VentaPOS.Mov)<BR>          Es VTAS.PR  Entonces Dialogo(<T>GenerarPresupuestoVentas<T>) <BR>          Es VTAS.P   Entonces Dialogo(Info.Dialogo)<BR>          Es VTAS.S   Entonces Dialogo(<T>GenerarServicio<T>) <BR>          Es VTAS.R   Entonces Dialogo(<T>GenerarRemision<T>)<BR>          Es VTAS.VCR Entonces Dialogo(<T>GenerarRemisionConsignacion<T>)<BR>          Es VTAS.VC  Entonces Dialogo(<T>GenerarVentaConsignacion<T>)<BR>          Es VTAS.F   Entonces Dialogo(<T>GenerarFactura<T>)<BR>          Es VTAS.FAR Entonces Dialogo(<T>GenerarFactura<T>)<BR>          Es VTAS.FB  Entonces Dialogo(<T>GenerarFactura<T>)<BR>          Es VTAS.FR  Entonces Dialogo(<T>GenerarFacturaRecurrente<T>)<BR>          Es VTAS.SD  Entonces Dialogo(<T>GenerarSolicitudDevolucion<T>)<BR>        Fin<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin<BR>ActualizarForma                                                                                                                    <BR>si(VentaPOS:VentaPOS.Estatus=EstatusConcluido,Asigna(Info.IDTexto,SQL(<T>spPOSImportarVenta :nID,:nEstacion<T>,VentaPOS:VentaPOS.ID,EstacionTrabajo)))
[Acciones.Afectar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
Visible=S

EjecucionCondicion=VentaPOS:VentaPOS.Estatus=EstatusConcluido




[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)























































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=OC
OC=Notas
Notas=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Actualizar
Actualizar=ActualizarPrecios
ActualizarPrecios=Imprimir
Imprimir=RepPantalla
RepPantalla=Excel
Excel=Afectar
Afectar=Autorizar
Autorizar=Consecutivo
Consecutivo=ActualizarPoliticasPrecios
ActualizarPoliticasPrecios=ActualizarPrecioMoneda
ActualizarPrecioMoneda=Cambiar Vista Hoja
Cambiar Vista Hoja=Totalizar
Totalizar=DescuentoGlobal
DescuentoGlobal=Asistente Articulos
Asistente Articulos=Asistente Codigo Barras
Asistente Codigo Barras=Asistente Codigo Barras (Lote)
Asistente Codigo Barras (Lote)=SeriesLotes
SeriesLotes=Sustitutos
Sustitutos=Precio
Precio=PrecioConImpuestos
PrecioConImpuestos=CteEnviarA
CteEnviarA=Catalogos
Catalogos=ArtInfo
ArtInfo=CteInfo
CteInfo=VentaDReservados
VentaDReservados=ArtAccesorioBuscar
ArtAccesorioBuscar=ArtRefaccionBuscar
ArtRefaccionBuscar=VerPoliticaPrecios
VerPoliticaPrecios=Asistente Precios
Asistente Precios=Resumen
Resumen=Politica
Politica=Cerrar
Cerrar=Otros1
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
&Ver=&Otros
&Otros=(Fin)
