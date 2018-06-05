[Forma]
Clave=Venta
Nombre=Info.ModuloVentasNombre
Icono=0
Modulos=VTAS
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=122
PosicionInicialArriba=39
PosicionInicialAltura=579
PosicionInicialAncho=1035
EsMovimiento=S
TituloAuto=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=49
DialogoAbrir=S
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
PosicionInicialAlturaCliente=563
Totalizadores=S
PosicionSec1=292
PosicionSec2=434
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Positivos, Verdadero)<BR>Asigna(Info.Paquete, Nulo)<BR>Asigna(Info.RefrescandoPrecio, Falso)<BR>Asigna(Info.ABC, Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Aseguradora, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
PosicionCol1=309

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
Vista=Venta
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

[Ficha.Venta.Mov]
Carpeta=Ficha
Clave=Venta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ficha.Venta.MovID]
Carpeta=Ficha
Clave=Venta.MovID
3D=S
Pegado=S
Tamano=11
ColorFondo=Plata
Editar=S
IgnoraFlujo=S

[Ficha.Venta.Proyecto]
Carpeta=Ficha
Clave=Venta.Proyecto
Editar=S
ValidaNombre=S
3D=S
Tamano=15
Pegado=S
ColorFondo=Blanco

[Ficha.Venta.Moneda]
Carpeta=Ficha
Clave=Venta.Moneda
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco

[Ficha.Venta.FechaEmision]
Carpeta=Ficha
Clave=Venta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=N
ColorFondo=Blanco

[Ficha.Venta.Almacen]
Carpeta=Ficha
Clave=Venta.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=N
ColorFondo=Blanco

[Ficha.Venta.Cliente]
Carpeta=Ficha
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=N
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

[Ficha.Venta.Condicion]
Carpeta=Ficha
Clave=Venta.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Venta.Vencimiento]
Carpeta=Ficha
Clave=Venta.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.Venta.Agente]
Carpeta=Ficha
Clave=Venta.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=N
ColorFondo=Blanco
EditarConBloqueo=N

[Notas.Venta.Referencia]
Carpeta=Notas
Clave=Venta.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25

[Notas.Venta.Observaciones]
Carpeta=Notas
Clave=Venta.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta.Descuento]
Carpeta=Ficha
Clave=Venta.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco

[Ficha.Venta.OrdenCompra]
Carpeta=Ficha
Clave=Venta.OrdenCompra
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco

[Ficha.Venta.Referencia]
Carpeta=Ficha
Clave=Venta.Referencia
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
Vista=VentaD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Venta
LlaveLocal=VentaD.ID
LlaveMaestra=Venta.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=VentaD.Renglon<TAB>(Acendente)
CarpetaVisible=S
ControlRenglon=S
CampoRenglon=VentaD.Renglon
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
ResumenVistaMaestra=Venta
ResumenLlaveMaestra=Venta.ID
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

[Detalle.VentaD.Articulo]
Carpeta=Detalle
Clave=VentaD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaD.SubCuenta]
Carpeta=Detalle
Clave=VentaD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Detalle.VentaD.Cantidad]
Carpeta=Detalle
Clave=VentaD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.Precio]
Carpeta=Detalle
Clave=VentaD.Precio
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
SubCuenta=192
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
Unidad=59
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
DescripcionExtra=153
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
TipoRetencion1=95
Retencion1=86
TipoRetencion2=95
Retencion2=86
TipoRetencion3=84
Retencion3=75
SubRetencion1=72
SubRetencion2=72
SubRetencion3=64
RecargaTelefono=80
RecargaConfirmarTelefono=104
POSDesGlobal=86
POSDesLinea=64
LDIReferencia=304
PorcentajeUtilidad=108
Cantidad2=64
Unidad2=93
Inventario2=64
TelaEtiqueta=74
ColorEtiqueta=92
Quality=93
Pattern=82
ColorNo=82
Variante=85
CHPrecio2=64

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=VentaA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situaci�n)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosConPaginas=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Venta.ID<TAB>(Decendente)
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
FiltroFechasCampo=Venta.FechaEmision
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
FiltroEstilo=Directorio
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroAplicaEn=Venta.Moneda
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Autom�tico
BusquedaRespetarControlesNum=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=Venta.FechaCancelacion
FiltroSucursales=S
FiltroUENsCampo=Venta.UEN
FiltroAutorizar=S
IconosNombre=VentaA:Venta.Mov+<T> <T>+VentaA:Venta.MovID
FiltroGeneral={Si(SQL(<T>SELECT ISNULL(Filtrar, 0) FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSub<T>, <T>VTAS<T>, Info.SubModuloVenta), <T>Venta.SubModulo=<T>+Comillas(Info.SubModuloVenta), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Mov), <T> AND Venta.Mov=<T>+Comillas(Filtro.Mov), <T><T>)}<BR>{Si<BR>  ConDatos(Filtro.Cliente) y ConDatos(Filtro.Aseguradora)<BR>Entonces<BR>  <T> AND Venta.Cliente IN (<T>+Comillas(Filtro.Cliente)+<T>, <T>+Comillas(Filtro.Aseguradora)+<T>)<T><BR>Sino<BR>  Si(ConDatos(Filtro.Cliente), <T> AND Venta.Cliente=<T>+Comillas(Filtro.Cliente), <T><T>)<BR>Fin}
BusquedaSelCampo=S

[(Carpeta Abrir).Venta.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Venta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

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
Totalizadores1=Importe<BR>Desc<BR>Sub<BR>Impto<BR>Total<BR>Retencion<BR>Volumen<BR>Sobre Precio<BR>Peso<BR>Renglon<BR>Retencion1<BR>Retencion2<BR>Retencion3
Totalizadores2=Suma(VentaD:Importe)<BR>-Suma(VentaD:DescGlobal)<BR>Suma(VentaD:SubTotal)<BR>Suma(VentaD:Impuesto)<BR>Suma(VentaD:ImporteTotal)-Venta:Venta.AnticiposFacturados-Suma(ImportePorcentaje(VentaD:SubTotal,VentaD:VentaD.Retencion1))-Suma(ImportePorcentaje(Si(Version.Retencion2BaseImpuesto1,VentaD:SubImpuesto1,VentaD:SubTotal),VentaD:VentaD.Retencion2))-Suma(ImportePorcentaje(VentaD:SubTotal,VentaD:VentaD.Retencion3))<BR>Venta:Venta.Retencion<BR>Suma(VentaD:VolumenTotal)<BR>Suma(VentaD:ImporteSobrePrecio)<BR>Suma(VentaD:PesoTotal)<BR>Conteo(VentaD:VentaD.Articulo)<BR>Suma(ImportePorcentaje(VentaD:SubTotal,VentaD:VentaD.Retencion1))<BR>Suma(ImportePorcentaje(Si(Version.Retencion2BaseImpuesto1,VentaD:SubImpuesto1,VentaD:SubTotal,VentaD:VentaD.Retencion2))<BR>Suma(ImportePorcentaje(VentaD:SubTotal,VentaD:VentaD.Retencion3))
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)<BR> #,.##<BR> <BR>#,.##
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=S
Activo=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N

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
Visible=S
Activo=S

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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Venta:Venta.ID) y (Venta:Venta.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Venta:Venta.ID, <T>VTAS<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>ConDatos(Venta:Venta.Cliente) y ConDatos(Venta:Venta.Almacen)
AntesExpresiones=Asigna(Venta:Venta.Importe, Suma(VentaD:Importe))<BR>Asigna(Venta:Venta.Impuestos, Suma(VentaD:Impuesto))

[Ficha.Venta.FechaRequerida]
Carpeta=Ficha
Clave=Venta.FechaRequerida
Editar=S
ValidaNombre=S
3D=S
Tamano=15
EditarConBloqueo=N
ColorFondo=Blanco
Pegado=N

[Acciones.Navegador]
Nombre=Navegador
Boton=0
Menu=&Archivo
NombreDesplegar=Navegador
EnMenu=
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Visible=S
Activo=S
EspacioPrevio=S
EnBarraHerramientas=S

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
NombreDesplegar=Asistente Art�culos
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=VentaD:VentaD.Articulo<BR>VentaD:VentaD.Almacen<BR>VentaD:VentaD.SubCuenta<BR>VentaD:VentaD.Cantidad<BR>VentaD:VentaD.Precio<BR>MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.D,VTAS.DF,VTAS.B,VTAS.DC,VTAS.DCR))<BR>Nulo<BR>MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.SG,VTAS.EG,VTAS.VC,VTAS.VCR))<BR>MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.P,VTAS.S,VTAS.PR,VTAS.EST))<BR>VentaD:Art.Descripcion1<BR>VentaD:Art.Tipo<BR>VentaD:Art.Unidad<BR>VentaD:Art.PrecioLista<BR>VentaD:Art.TipoOpcion<BR>VentaD:Art.Espacios<BR>VentaD:VentaD.FechaRequerida<BR>VentaD:VentaD.HoraRequerida<BR>VentaD:VentaD.Espacio<BR><T>VTAS<T><BR>Venta:Venta.ID<BR>Venta:Venta.Cliente
ListaParametros=S
Visible=S
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Alt+F7
EspacioPrevio=S
ActivoCondicion=((Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) o  ((MovTipo(<T>VTAS<T>, Venta:Venta.Mov) en  (VTAS.P)) y (Venta:Venta.Estatus en (EstatusPendiente))))
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Si<BR> ((MovTipo(<T>VTAS<T>, Venta:Venta.Mov) en  (VTAS.P)) y (Venta:Venta.Estatus en (EstatusPendiente)))<BR>Entonces<BR> ((SQL(<T>EXEC spTVValidaCant :nid, :renglon<T>, Venta:Venta.ID, VentaD:VentaD.Renglon))=1)<BR>Fin
EjecucionMensaje=<T>Las Cantidades no son iguales<T>

[Notas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Informaci�n adicional
Clave=Notas
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
CondicionEdicion=Vacio(Venta:Venta.AnexoID)

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
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Totalizar
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
RefrescarDespues=S
Expresion=Si(General.OFER, EjecutarSQL(<T>spOfertaAplicar :nID<T>, Venta:Venta.ID))<BR>Si(Config.VentaCteArtEmpaqueCorrugado, EjecutarSQL(<T>spCalculaEmpaques :nID, :tModulo, :nSucursal<T>, Venta:Venta.ID, <T>VTAS<T>, Sucursal))
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Detalle.VentaD.CantidadA]
Carpeta=Detalle
Clave=VentaD.CantidadA
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
Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>Asigna(Info.OrigenTipo, Venta:Venta.OrigenTipo)<BR>Si<BR>  Config.VentaActualizarPrecioMoneda y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y SQL(<T>spVentaActualizarPreciosChecar :nID<T>, Venta:Venta.ID)<BR>Entonces<BR>  Caso Confirmacion(<T>� Desea Actualizar los Precios Otras Monedas ?<T>, BotonSi, BotonNo, BotonCancelar)<BR>    Es BotonSi Entonces EjecutarSQL(<T>spVentaActualizarPrecios :nID<T>, Venta:Venta.ID) AbortarOperacion<BR>    Es BotonCancelar Entonces AbortarOperacion<BR>  Fin<BR>Fin<BR>Si(General.InterfazLDI,EjecutarSQL(<T>spLDIInsertarEstacionTemp :nEstacion, :nEstacionFija<T>,  EstacionTrabajo , EstacionTrabajoFija ))<BR><BR>Si(General.OFER y (Info.OrigenTipo <> <T>VMOS<T>), EjecutarSQL(<T>spOfertaAplicar :nID<T>, Venta:Venta.ID))<BR>ActualizarVista <BR>Si<BR>  (Venta:Venta.Mov=Info.MovProcesar) y (Venta:Venta.Estatus=EstatusSinAfectar)<BR>Entonces<BR>  EjecutarSQL(<T>xpVentaAutoProcesar :nID<T>, Venta:Venta.ID)<BR>Sino<BR>  Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>  Asigna(Afectar.ID, Venta:Venta.ID)<BR>  Asigna(Afectar.Mov, Venta:Venta.Mov)<BR>  Asigna(Afectar.MovID, Venta:Venta.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>  Asigna(Afectar.EnviarCFD, Falso)<BR>  Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, Venta:Venta.Mov))<BR>  Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>  Asigna(Info.Moneda, Venta:Venta.Moneda)<BR>  Asigna(Info.TipoCambio, Venta:Venta.TipoCambio)<BR>  Asigna(Info.Importe, Redondea(Suma(VentaD:Importe)+Suma(VentaD:Impuesto)-Suma(VentaD:DescGlobal)+Suma(VentaD:ImporteSobrePrecio)-(Venta:Venta.AnticiposFacturados+Suma(ImportePorcentaje(VentaD:SubTotal,VentaD:VentaD.Retencion1))+Suma(ImportePorcentaje(Si(Version.Retencion2BaseImpuesto1,VentaD:SubImpuesto1,VentaD:SubTotal),VentaD:VentaD.Retencion2))+Suma(ImportePorcentaje(VentaD:SubTotal,VentaD:VentaD.Retencion3))), Config.VentaCobroRedondeoDecimales))<BR>  Si<BR>    (Info.Importe<>0) y<BR>    (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y<BR>    ((MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.N, VTAS.FM)) y (ConDatos(Venta:Venta.MovID) o Config.VentaLiquidaIntegral) y (Venta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>)) o<BR>    (MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.P, VTAS.VP, VTAS.SD, VTAS.B))  y (Venta:Condicion.ControlAnticipos=<T>Cobrar Pedido<T>)) o<BR>    (MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F, VTAS.FAR, VTAS.FB, VTAS.D, VTAS.DF)) y (Venta:Venta.Vencimiento<=Venta:Venta.FechaEmision) y Config.FacturaCobroIntegrado y (Venta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>) y (Venta:Venta.OrigenTipo<><T>VMOS<T>)))<BR>  Entonces<BR>    Asigna(Info.ID, Venta:Venta.ID)<BR>    Asigna(Info.Cerrado, Falso)<BR>    Asigna(Info.VentaCobroDevolucion, MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.VP, VTAS.SD, VTAS.B, VTAS.D, VTAS.DF)))<BR>    Forma(<T>VentaCobro<T>)<BR>  Sino<BR>    Si<BR>      (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) o ((MovTipo(<T>VTAS<T>,Venta:Venta.Mov)=VTAS.S) y (Venta:Venta.Estatus=EstatusPorConfirmar))<BR>    Entonces<BR>      Si(Config.CompraVentaSinIVA y (Suma(VentaD:Impuesto)=0.0) y (Suma(VentaD:Importe)>0.0), Si(Confirmacion(<T>Movimiento sin Impuestos<T>+NuevaLinea+<T>� Es Correcto ?<T>,BotonSi,BotonNo)=BotonNo,AbortarOperacion))<BR><BR>      Si<BR>        Venta:Venta.Estatus=EstatusPorConfirmar<BR>      Entonces<BR>        Caso MovTipo(<T>VTAS<T>, Venta:Venta.Mov)<BR>          Es VTAS.S  Entonces Dialogo(<T>GenerarServicioPorConfirmar<T>)<BR>          Es VTAS.CS Entonces Dialogo(<T>GenerarCotizacionServicio<T>)<BR>          Es VTAS.OP Entonces Dialogo(<T>GenerarOportunidad<T>)<BR>          Es VTAS.C  Entonces<BR>                      Si (Venta:Venta.OrigenTipo=<T>VTAS<T>) y (MovTipo(<T>VTAS<T>, Venta:Venta.Origen)=VTAS.S)<BR>                       Entonces<BR>                         Asigna(Afectar.Mov, Venta:Venta.Origen)<BR>                         Asigna(Afectar.MovID, Venta:Venta.OrigenID)<BR>                         Asigna(Afectar.ID, SQL(<T>SELECT ID FROM Venta WHERE Empresa = :tEmpresa AND Mov = :tMov AND MovID = :tMovID AND Estatus NOT IN (<T>+Comillas(EstatusSinAfectar)+<T>, <T>+Comillas(EstatusCancelado)+<T>)<T>, Empresa, Afectar.Mov, Afectar.MovID))<BR>                         Dialogo(<T>AfectarServicio<T>)<BR>                       Sino<BR>                         Dialogo(<T>GenerarCotizacion<T>)<BR>                     Fin<BR>          Es VTAS.CO Entonces Dialogo(<T>GenerarContrato<T>)<BR>          Sino Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>        Fin<BR>      Sino<BR>        Si<BR>          Config.Partidas y (MovTipo(<T>VTAS<T>, Venta:Venta.Mov)=VTAS.R)<BR>        Entonces<BR>          Forma(<T>AfectarPartidasRemision<T>)<BR>        Sino<BR>          Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>          Si SQL(<T>spMovReporteIntelisis :tEmpresa, :tModulo, :tMov, :nID, :nAfectar<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID, 1) Entonces<BR>            Asigna(Info.Reporte, SQL(<T>spMovFormatoIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID))<BR>            Asigna(Info.RutaArchivo, SQL(<T>spMovRutaIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID))<BR>            ReportePDF(Info.Reporte,Afectar.ID,Info.RutaArchivo)<BR>            EjecutarSQL(<T>spMovEnviarIntelisis :tEmpresa,:tModulo,:tMov,:nID<T>,Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID)<BR>          Fin<BR>        Fin<BR>      Fin<BR>      Si<BR>        Empresa.CFD y SQL(<T>spVerMovTipoCFD :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID)<BR>      Entonces<BR>        Si(no CFD.Generar(Afectar.Modulo, Afectar.ID),  Forma.ActualizarForma AbortarOperacion)<BR>        Asigna(Afectar.EnviarCFD, SQL(<T>SELECT EnviarAlAfectar FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>, Empresa))<BR>      Fin<BR>      CFD.Confirmar<BR>      Si(Afectar.EnviarCFD, CFD.Enviar(Afectar.Modulo, Afectar.ID))<BR>    Sino<BR>      Asigna(Info.Modulo, <T>VTAS<T>)<BR>      Asigna(Info.Mov, Venta:Venta.Mov)<BR>      Asigna(Info.MovID, Venta:Venta.MovID)<BR>      Asigna(Afectar.Base, <T>Pendiente<T>)<BR>      Asigna(Afectar.GenerarMov, <T><T>)<BR>      Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>      Si<BR>        (ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T>) y (no MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F, VTAS.FAR, VTAS.FB)))<BR>      Entonces<BR>        Si<BR>          Forma(<T>GenerarMovFlujo<T>)<BR>        Entonces<BR>          Caso Info.MovGenerar<BR>            Es <T>(Reservar)<T>    Entonces Si(Usuario.Reservar,    Dialogo(<T>Reservar<T>),     Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Desreservar)<T> Entonces Si(Usuario.Desreservar, Dialogo(<T>DesReservar<T>),  Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Asignar)<T>     Entonces Si(Usuario.Asignar,     Dialogo(<T>Asignar<T>),      Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Desasignar)<T>  Entonces Si(Usuario.DesAsignar,  Dialogo(<T>DesAsignar<T>),   Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Facturacion Rapida)<T>          Entonces ProcesarSQL(<T>spFacturacionRapida :nID, :tUsuario, :tEmpresa<T>,    Afectar.ID, Usuario, Empresa)<BR>            Es <T>(Facturacion Rapida Agrupada)<T> Entonces ProcesarSQL(<T>spFacturacionRapida :nID, :tUsuario, :tEmpresa, 1<T>, Afectar.ID, Usuario, Empresa)<BR>            Es <T>(Generar Orden Transferencia)<T><BR>             Entonces<BR>               Si<BR>                 Usuario.PedidoGenerarOT y Dialogo(<T>EstaSeguro<T>)<BR>               Entonces<BR>                 Si<BR>                   Usuario.PedidoGenerarOTAbrir<BR>                 Entonces<BR>                   FormaPos(<T>Inv<T>, SQLEnLista(<T>spPedidoGenerarOT :tEmpresa, :nID, :nSucursal, :tUsuario, :tMov, @VerID = 1<T>, Empresa, Venta:Venta.ID, Sucursal, Usuario, ConfigMov.InvOrdenTransferencia))<BR>                 Sino<BR>                   ProcesarSQL(<T>spPedidoGenerarOT :tEmpresa, :nID, :nSucursal, :tUsuario, :tMov<T>, Empresa, Venta:Venta.ID, Sucursal, Usuario, ConfigMov.InvOrdenTransferencia)<BR>                 Fin<BR>               Sino<BR>                 Precaucion(<T>No Tiene Acceso<T>)<BR>               Fin<BR>            Sino<BR>              Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>              Asigna(Info.TituloDialogo, <T>Generar <T>+Comillas(Info.MovGenerar)+<T> de <T>+Comillas(Info.Mov))<BR>              Dialogo(<T>GenerarPedidoPendiente<T>)<BR>          Fin<BR>        Fin<BR>      Sino<BR>        Caso MovTipo(<T>VTAS<T>, Venta:Venta.Mov)<BR>          Es VTAS.PR  Entonces Dialogo(<T>GenerarPresupuestoVentas<T>)<BR>          Es VTAS.P   Entonces Dialogo(Info.Dialogo)<BR>          Es VTAS.S   Entonces Dialogo(<T>GenerarServicio<T>)<BR>          Es VTAS.R   Entonces Dialogo(<T>GenerarRemision<T>)<BR>          Es VTAS.VCR Entonces Dialogo(<T>GenerarRemisionConsignacion<T>)<BR>          Es VTAS.VC  Entonces Dialogo(<T>GenerarVentaConsignacion<T>)<BR>          Es VTAS.F   Entonces Dialogo(<T>GenerarFactura<T>)<BR>          Es VTAS.FAR Entonces Dialogo(<T>GenerarFactura<T>)<BR>          Es VTAS.FB  Entonces Dialogo(<T>GenerarFactura<T>)<BR>          Es VTAS.FR  Entonces Dialogo(<T>GenerarFacturaRecurrente<T>)<BR>          Es VTAS.SD  Entonces Dialogo(<T>GenerarSolicitudDevolucion<T>)<BR>        Fin<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Venta:Venta.Usuario) y<BR>(Venta:Venta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusRecurrente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Venta:Venta.Mov) y ConDatos(Venta:Venta.Almacen)
AntesExpresiones=Asigna(Info.MovProcesar, ConfigMov.AutoRecaudacion)<BR>Si(General.AdvertirProyectosExpirados, Si(SQL(<T>SELECT COUNT(*) FROM Proy WHERE (Estatus = :tBaja OR FechaFin+1<GETDATE()) AND Proyecto=:tProy<T>, EstatusBaja, Venta:Venta.Proyecto) > 0, Si(Precaucion(<T>Proyecto Expirado<T>, BotonAceptar, BotonCancelar)=BotonCancelar, AbortarOperacion)))<BR>Si<BR>  (MovTipo(<T>VTAS<T>, Venta:Venta.Mov)=VTAS.P) <BR>Entonces<BR>  Si<BR>    General.Autotransportes<BR>  Entonces<BR>    Caso Venta:Venta.Mov<BR>      Es ConfigMov.AutoPapeleta Entonces Asigna(Info.Dialogo, <T>GenerarAutoPapeleta<T>)<BR>      Es <T>Orden Mantenimiento<T>  Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenMantenimiento<T>)<BR>      Es <T>Orden Reparacion Int<T> Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenReparacionInt<T>)<BR>      Es <T>Orden Reparacion Ext<T> Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenReparacionExt<T>)<BR>      Es <T>Orden Reparacion Ter<T> Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenReparacionTer<T>)<BR>    Sino<BR>      Asigna(Info.Dialogo, <T>GenerarPedido<T>)<BR>    Fin   <BR>  Sino<BR>    Caso Venta:Venta.Mov<BR>      Es ConfigMov.VentaReservacion Entonces Asigna(Info.Dialogo, <T>GenerarReservacion<T>)<BR>      Es ConfigMov.VentaIngreso Entonces Asigna(Info.Dialogo, <T>GenerarVentaIngreso<T>)<BR>    Sino<BR>      Asigna(Info.Dialogo, <T>GenerarPedido<T>)<BR>    Fin<BR>  Fin<BR>Fin<BR>Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>VTAS<T>, Venta:Venta.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID, Verdadero, Venta:Venta.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>Fin

[Acciones.CopiarPendiente]
Nombre=CopiarPendiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Copiar Pendiente
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(VentaD:VentaD.CantidadA,  <BR>VentaD:VentaD.CantidadPendiente+VentaD:VentaD.CantidadReservada)
ActivoCondicion=Venta:Venta.Estatus=EstatusPendiente

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnMenu=S
TipoAccion=Expresion
Visible=S
EnBarraHerramientas=S
RefrescarDespues=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
ConCondicion=S
Expresion=Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, Venta:Venta.ID)<BR>Asigna(Afectar.Mov, Venta:Venta.Mov)<BR>Asigna(Afectar.MovID, Venta:Venta.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, Venta:Venta.Mov))<BR>Asigna(Info.Estatus, Venta:Venta.Estatus)<BR>Asigna(Temp.Logico,0)<BR>Si <BR>  (Info.MovTipo en (VTAS.N,VTAS.FM)) y (Info.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))<BR>Entonces<BR>  Asigna(Info.TituloDialogo, <T>Cancelar: <T>+Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Dialogo(<T>CancelarNota<T>)<BR>Sino<BR>  Si<BR>    (Info.Estatus=EstatusPendiente) y (Info.MovTipo en (VTAS.P,VTAS.S,VTAS.SD))<BR>  Entonces<BR>    Asigna(Info.TituloDialogo, <T>Cancelar: <T>+Afectar.Mov+<T> <T>+Afectar.MovID)<BR>    Dialogo(<T>CancelarVentaPendiente<T>)<BR>  Sino<BR>    Si<BR>      Asigna(Temp.Texto, <T><T>)<BR>      Si <BR>        (Config.CancelarFactura<><T>No<T>) y Vacio(Venta:Venta.AnticiposFacturados) y (Info.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))<BR>      Entonces<BR>        Asigna(Temp.Fecha, SQL(<T>SELECT GETDATE()<T>))<BR>        Si<BR>          Info.MovTipo en (VTAS.F, VTAS.FAR)<BR>        Entonces<BR>          Si             <BR>            (Mes(Temp.Fecha) > Mes(Venta:Venta.FechaEmision)) o (A�o(Temp.Fecha) > A�o(Venta:Venta.FechaEmision)) o ((Config.CancelarFactura=<T>Cambio Dia<T>) y (Dia(Temp.Fecha) > Dia(Venta:Venta.FechaEmision)))<BR>          Entonces<BR>            Asigna(Temp.Texto, <T>Nota: Esta Cancelaci�n va a Generar un Movimiento Contrario.<T>+NuevaLinea+NuevaLinea+NuevaLinea+NuevaLinea+NuevaLinea+NuevaLinea)<BR>            Asigna(Temp.Logico,1)<BR>          Fin<BR>        Fin<BR>      Fin<BR>      Precaucion(Temp.Texto+<T>� Esta seguro que desea cancelar el movimiento ?<T>+NuevaLinea+NuevaLinea+Afectar.Mov+<T> <T>+Afectar.MovID, BotonSi, BotonNo ) = BotonSi<BR>   Entonces<BR>      Cancelar(<T>VTAS<T>, Venta:Venta.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, Afectar.FormaCaptura)<BR><BR>     Asigna(Afectar.AsignarID, SQL(<T>SELECT CancelacionID FROM Venta WHERE ID=:nID<T>, Venta:Venta.ID))<BR>     Si(ConDatos(Afectar.AsignarID), Asigna(Afectar.ID,Afectar.AsignarID))<BR>     Si<BR>        Empresa.CFD y SQL(<T>spVerMovTipoCFD :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa,Afectar.Modulo, Afectar.Mov, Afectar.ID)<BR>      Entonces<BR>        Si(Temp.Logico,Si(no CFD.Generar(Afectar.Modulo, Afectar.ID), AbortarOperacion))<BR>        Si<BR>         SQL(<T>SELECT EnviarAlAfectar FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>,Empresa) y  SQL(<T>SELECT Timbrado  FROM CFD WHERE Modulo = :tModulo AND ModuloID = :nID<T>,Afectar.Modulo, Afectar.ID)<BR>        Entonces<BR>           EjecutarSQL(<T>spCFDAlmacenar :tModulo, :nId, :tUsuario, 0<T>, <T>VTAS<T>,Afectar.ID, Usuario)<BR>           CFD.Enviar(Afectar.Modulo, Afectar.ID)<BR>        Fin       <BR>        CFD.Confirmar<BR>     Fin<BR><BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Si<BR>  PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Venta:Venta.Usuario) y ConDatos(Venta:Venta.ID) y ConDatos(Venta:Venta.MovID) y (Vacio(Venta:Venta.CancelacionID) o (MovTipo(<T>VTAS<T>, Venta:Venta.Mov) en (VTAS.D,VTAS.DF,VTAS.B)))<BR>Entonces<BR>  Si<BR>    MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.C,VTAS.CS,VTAS.R,VTAS.P,VTAS.S,VTAS.VC,VTAS.VCR,VTAS.SD))<BR>  Entonces<BR>    Venta:Venta.Estatus en (EstatusSinAfectar, EstatusFueraLinea, EstatusSincro, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusPorConfirmar)<BR>  Sino<BR>    Venta:Venta.Estatus en (EstatusSinAfectar, EstatusFueraLinea, EstatusSincro, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusProcesar, EstatusRecurrente, EstatusConcluido) <BR>  Fin<BR>Sino<BR>  Falso<BR>Fin
EjecucionCondicion=Si<BR>SQL(<T>EXEC xpMostrarAccion  :tEmpresa,  :tMov,  :tID, :tModulo, :tAccion<T>, Empresa, Venta:Venta.Mov, Venta:Venta.ID,<T>VTAS<T>,<T>CANCELAR<T>)=Falso<BR>Entonces<BR>     Precaucion( <T>CFD - Este movimiento no se puede cancelar ya fue timbrado<T> )<BR>Sino<BR>    Verdadero<BR>Fin
AntesExpresiones=Si<BR>  MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.N<BR>Entonces<BR>  Si<BR>    SQL(<T>SELECT COUNT(*) FROM Venta WHERE Empresa=:tEmpresa AND OrigenTipo=:tModulo AND Origen=:tOrigen AND OrigenID=:tOrigenID AND Estatus NOT IN (:tSinAfectar, :tCancelado)<T>, Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.MovID, <T>SINAFECTAR<T>, <T>CANCELADO<T>)>0 <BR>  Entonces<BR>     Error(<T>Este Movimiento, Ya Fue Cancelado<T>) <BR>     AbortarOperacion<BR>  Fin<BR>Fin

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
EspacioPrevio=S
Visible=S
ConCondicion=S
EjecucionConError=S
ActivoCondicion=Vacio(Venta:Venta.MovID) y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Venta:Venta.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Venta WHERE ID=:nID<T>, Venta:Venta.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>

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
NombreDesplegar=&Cat�logos
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Catalogos Articulos
ListaParametros1=VentaD:VentaD.Articulo<BR>Venta:Venta.Almacen<BR>VentaD:VentaD.Cantidad
ListaParametros=S
Visible=S
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
EspacioPrevio=S
ConCondicion=S
EnBarraHerramientas=S
Expresion=Verificar( <T>VTAS<T>, Venta:Venta.ID, Venta:Venta.Mov, Venta:Venta.MovID )
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Venta:Venta.Mov)

[Detalle.VentaD.DescuentoLinea]
Carpeta=Detalle
Clave=VentaD.DescuentoLinea
Editar=S
IgnoraFlujo=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Disponible]
Nombre=Disponible
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Disponible del Art�culo
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(Info.Origen, <T>VTAS<T>)<BR>Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)<BR>Asigna(Info.ArtTipo, VentaD:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, VentaD:Art.TipoOpcion)<BR>Asigna(Info.Almacen, Si(Config.VentaMultiAlmacen, VentaD:VentaD.Almacen, Venta:Venta.Almacen))<BR>Forma(<T>ArtAlmExistencia<T>)
EjecucionCondicion=ConDatos( VentaD:VentaD.Articulo)

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+I
NombreDesplegar=Informaci�n del &Art�culo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos( VentaD:VentaD.Articulo)
AntesExpresiones=Asigna( Info.Origen, <T>VTAS<T>)<BR>Asigna( Info.Articulo, VentaD:VentaD.Articulo )<BR>Asigna( Info.ArtTipo, VentaD:Art.Tipo)

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
Menu=&Ver
NombreDesplegar=Informaci�n del &Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteInfo
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EnBarraHerramientas=S
ConCondicion=S
ActivoCondicion=Usuario.CteInfo
EjecucionCondicion=ConDatos(Venta:Venta.Cliente)
AntesExpresiones=Asigna(Info.Origen, <T>VTAS<T>)<BR>Asigna( Info.Cliente,Venta:Venta.Cliente )

[Ficha.Venta.AlmacenDestino]
Carpeta=Ficha
Clave=Venta.AlmacenDestino
Editar=S
3D=S
Tamano=15
ValidaNombre=N
ColorFondo=Blanco

[Detalle.VentaD.Costo]
Carpeta=Detalle
Clave=VentaD.Costo
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
ListaParametros1=Venta:Venta.ID
Visible=S
GuardarAntes=S
Expresion=Asigna(Info.Descripcion, SQL(<T>EXEC spAbrirAnexo :tModulo, :nID<T>, <T>VTAS<T>, Venta:Venta.ID))<BR>Si (Info.Descripcion <> NULO) Y (Archivo.Leer(Info.Descripcion) <> <T><T>)<BR>Entonces<BR>  VerImagen(<T><T>, Info.Descripcion)<BR>Sino<BR>  ReporteImpresora(ReporteMovImpresora(Info.SubModuloVenta, Venta:Venta.Mov, Venta:Venta.Estatus), Venta:Venta.ID)<BR>Fin
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentaci�n preliminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Venta:Venta.ID
Visible=S
GuardarAntes=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Rama, <T>VTAS<T>)
Expresion=Asigna(Info.Descripcion, SQL(<T>EXEC spAbrirAnexo :tModulo, :nID<T>, <T>VTAS<T>, Venta:Venta.ID))<BR>Si (Info.Descripcion <> NULO) Y (Archivo.Leer(Info.Descripcion) <> <T><T>)<BR>Entonces<BR>  VerImagen(<T><T>, Info.Descripcion)<BR>Sino<BR>  ReportePantalla(ReporteMovPantalla(Info.SubModuloVenta, Venta:Venta.Mov, Venta:Venta.Estatus), Venta:Venta.ID)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Fin
ActivoCondicion=Usuario.PreliminarMovs

[Ficha.Venta.TipoCambio]
Carpeta=Ficha
Clave=Venta.TipoCambio
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
ListaParametros1=VentaD:VentaD.Articulo<BR>VentaD:VentaD.SubCuenta<BR>VentaD:Art.Grupo<BR>VentaD:Art.Categoria<BR>VentaD:Art.Familia<BR>VentaD:Art.ABC<BR>VentaD:Art.Fabricante<BR>VentaD:Art.Linea<BR>VentaD:Art.Rama<BR>Venta:Venta.Cliente<BR>Venta:Cte.Grupo<BR>Venta:Cte.Categoria<BR>Venta:Cte.Familia<BR>Venta:Cte.Zona<BR>Venta:Venta.Moneda<BR>Venta:Venta.Condicion<BR>VentaD:VentaD.Almacen<BR>Venta:Venta.Proyecto<BR>Venta:Venta.Agente<BR>Venta:Venta.FormaEnvio<BR>Venta:Venta.Mov<BR>Venta:Venta.ServicioTipo<BR>Venta:Venta.ServicioContratoTipo<BR>VentaD:VentaD.Unidad<BR>Venta:Venta.Empresa<BR>VentaD:VentaD.Cantidad<BR>VentaD:VentaD.Unidad<BR>VentaD:Art.PrecioLista<BR>VentaD:Art.MonedaPrecio<BR>Venta:Venta.TipoCambio<BR>VentaD:VentaD.DescuentoImporte<BR>VentaD:VentaD.DescuentoLinea<BR>Venta:Venta.ListaPreciosEsp<BR>VentaD:Art.Precio2<BR>VentaD:Art.Precio3<BR>VentaD:Art.Precio4<BR>VentaD:Art.Precio5<BR>VentaD:Art.Precio6<BR>VentaD:Art.Precio7<BR>VentaD:Art.Precio8<BR>VentaD:Art.Precio9<BR>VentaD:Art.Precio10<BR>VentaD:VentaD.Precio<BR>VentaD:VentaD.PoliticaPrecios<BR>VentaD:VentaD.PrecioMoneda<BR>VentaD:VentaD.PrecioTipoCambio<BR>Venta:CteEnviarA.Grupo<BR>Venta:CteEnviarA.Categoria<BR>Venta:CteEnviarA.Familia
ListaParametros=S
Activo=S
Visible=S

[Acciones.ActualizarPoliticasPrecios]
Nombre=ActualizarPoliticasPrecios
Boton=0
Menu=&Archivo
NombreDesplegar=&Actualizar Pol�ticas de Precios
EnMenu=S
TipoAccion=Otros
ClaveAccion=Actualizar Politicas Precios y Descuentos

[Acciones.VerPoliticaPrecios]
Nombre=VerPoliticaPrecios
Boton=0
Menu=&Ver
NombreDesplegar=P&ol�ticas de Precios Aplicadas
EnMenu=S
TipoAccion=Dialogos
Activo=S
Visible=S
EspacioPrevio=S
ClaveAccion=VerPoliticasPrecios
Antes=S
AntesExpresiones=Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)<BR>Asigna(Info.Mensaje, VentaD:VentaD.PoliticaPrecios)

[Detalle.VentaD.Aplica]
Carpeta=Detalle
Clave=VentaD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaD.AplicaID]
Carpeta=Detalle
Clave=VentaD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Notas.Venta.Prioridad]
Carpeta=Notas
Clave=Venta.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=12
LineaNueva=N
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta.Directo]
Carpeta=Ficha
Clave=Venta.Directo
Editar=S
3D=S
Tamano=16
Pegado=N
ColorFondo=Blanco

[Acciones.Asistente Codigo Barras]
Nombre=Asistente Codigo Barras
Boton=42
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=May�s+F7
NombreDesplegar=Asistente C�digos de Barras
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Codigo Barras (1x1)
ListaParametros=S
Visible=S
ListaParametros1=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)<BR>Venta:Venta.Estatus=EstatusPendiente<BR>VentaD:VentaD.Cantidad<BR>VentaD:VentaD.CantidadPendiente<BR>VentaD:VentaD.CantidadReservada<BR>VentaD:VentaD.CantidadA<BR>VentaD:VentaD.SubCuenta<BR>VentaD:VentaD.Unidad<BR>VentaD:VentaD.Articulo<BR>Venta:Venta.Cliente<BR>Venta:Venta.Agente<BR>Venta:Venta.Almacen<BR>Nulo<BR>Nulo<BR>Venta:Cte.Idioma<BR>Config.CBPreguntarCantidad<BR>Falso
ActivoCondicion=Config.CB y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente))

[Acciones.Asistente Codigo Barras (Lote)]
Nombre=Asistente Codigo Barras (Lote)
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=Asistente C�digos de Barras (en Lote)
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Codigo Barras (Lote)
ListaParametros=S
ListaParametros1=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>Venta:Venta.Estatus=EstatusPendiente<BR>VentaD:VentaD.Cantidad<BR>VentaD:VentaD.CantidadPendiente<BR>VentaD:VentaD.CantidadReservada<BR>VentaD:VentaD.CantidadA<BR>VentaD:VentaD.SubCuenta<BR>VentaD:VentaD.Unidad<BR>VentaD:VentaD.Articulo<BR>Venta:Venta.Cliente<BR>Venta:Venta.Agente<BR>Venta:Venta.Almacen<BR>Nulo<BR>Nulo<BR>Venta:Cte.Idioma<BR>Venta:Venta.ID<BR>Verdadero<BR>Config.CBProcesarLote<BR>MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.DR,VTAS.SG,VTAS.EG,VTAS.D,VTAS.DF,VTAS.B,VTAS.VC,VTAS.VCR,VTAS.DC,VTAS.DCR,VTAS.N,VTAS.NO,VTAS.NR,VTAS.FM,VTAS.CO))<BR>Si(Config.CBDirAlmacen, Venta:Cte.CBDir, <T><T>)
Boton=0
GuardarAntes=S
Antes=S
DespuesGuardar=S
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Renglon, VentaD:VentaD.Renglon)<BR>Asigna(Info.RenglonSub, VentaD:VentaD.RenglonSub)<BR>EjecutarSQL(<T>spProcesarCBInfo :nEst, :tEmp, :tMod, :nID, :nRen, :nSub<T>, EstacionTrabajo, Empresa, <T>VTAS<T>, Info.ID, Info.Renglon, Info.RenglonSub)
VisibleCondicion=Config.CB

[(Carpeta Abrir).Venta.Almacen]
Carpeta=(Carpeta Abrir)
Clave=Venta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Localizar]
Nombre=Localizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=May�s+F3
NombreDesplegar=L&ocalizar...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Localizar
Activo=S
Visible=S

[Ficha.Venta.Concepto]
Carpeta=Ficha
Clave=Venta.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
EditarConBloqueo=N

[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posici�n del Movimiento
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S
Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(Venta:Venta.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)

[Acciones.SeriesLotes]
Nombre=SeriesLotes
Boton=18
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
NombreDesplegar=&Series/Lotes del Art�culo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Antes=S
Visible=S
Expresion=Asigna(Info.SumaSerieLote, Nulo)<BR>Si<BR>  MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.CO<BR>Entonces<BR>  Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>  Si(Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>SerieLoteMovUbicacion<T>), Forma(<T>SerieLoteMovUbicacionInfo<T>))<BR>Sino<BR>  Si <BR>    VentaD:Art.Tipo=TipoVIN<BR>  Entonces<BR>    Si<BR>      Venta:Venta.Estatus=EstatusSinAfectar<BR>    Entonces<BR>      Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>      Si(Forma(<T>VINMov<T>), EjecutarSQL(<T>xpVentaVINAsignar :nID, :nRen, :nSub, :tVIN<T>, Venta:Venta.ID, VentaD:VentaD.Renglon, VentaD:VentaD.RenglonSub, Info.VIN))<BR>    Sino<BR>      Forma(<T>VINMovInfo<T>)<BR>    Fin<BR>  Sino<BR>    Si(Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente), Forma(<T>SerieLoteMov<T>), Si(Usuario.ModificarSerieLoteProp, Forma(<T>SerieLoteMovProp<T>), Forma(<T>SerieLoteMovInfo<T>)))<BR>    Si<BR>      Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar) <BR>    Entonces<BR>      Si<BR>        (VentaD:Art.Tipo=TipoPartida) y (Info.SumaSerieLote>0)<BR>      Entonces<BR>        Asigna(Info.Copiar, Verdadero)<BR>        Asigna(Info.Precio, VentaD:VentaD.Precio)<BR>        Asigna(VentaD:VentaD.Cantidad, <BR>          Caso Minusculas(VentaD:VentaD.Unidad)<BR>            Es <T>metros<T> Entonces Info.SumaAlternaSerieLote<BR>            Es <T>yardas<T> Entonces Info.SumaAlternaSerieLote/UnidadFactor(VentaD:VentaD.Unidad)<BR>            Es <T>kilos<T>  Entonces Info.SumaSerieLote<BR>            Es <T>libras<T> Entonces Info.SumaSerieLote/UnidadFactor(VentaD:VentaD.Unidad)<BR>          Sino<BR>            0.0<BR>          Fin)<BR>        Asigna(VentaD:VentaD.Factor, Info.SumaSerieLote/VentaD:VentaD.Cantidad)<BR>        Asigna(VentaD:VentaD.CantidadAlterna, Info.SumaAlternaSerieLote)<BR>        Asigna(Info.Copiar, Falso)<BR>      Sino<BR>        Si<BR>          (no Config.MultiUnidades) y ConDatos(Info.SumaSerieLote) y (Info.SumaSerieLote<>ABS(VentaD:VentaD.Cantidad)) y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>        Entonces<BR>          Si<BR>            Confirmacion(<T>La Cantidad Difiere con la Selecci�n.<T>+NuevaLinea+NuevaLinea+<T>� Desea Actualizar la Cantidad ?<T>,BotonSi, BotonNo)=BotonSi)<BR>          Entonces<BR>            Asigna(VentaD:VentaD.Cantidad, Si(Vacio(VentaD:VentaD.Cantidad, 0.0)<0,-Info.SumaSerieLote, Info.SumaSerieLote))<BR>          Fin<BR>        Fin  <BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin<BR><BR>Si<BR>  (Info.SubModuloVenta=<T>AUTO<T>) y (VentaD:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX)) y (Info.SumaSerieLote>0) y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y Usuario.AsistentePrecios<BR>Entonces<BR>  Asigna(Info.Estatus, Venta:Venta.Estatus)<BR>  Asigna(Info.Modulo, <T>VTAS<T>)<BR>  Asigna(Info.ID, Venta:Venta.ID)<BR>  Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>  Asigna(Info.ArtLinea, VentaD:Art.Linea)<BR>  Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta)<BR>  Asigna(Info.RenglonID, VentaD:VentaD.RenglonID)<BR>  Si<BR>    Forma(<T>AutoBoletoMov<T>)<BR>  Entonces<BR>    Asigna(VentaD:VentaD.Cantidad, Info.Cantidad)<BR>    Si<BR>      VentaD:Art.AutoRecaudacion en (<T>Gasto No Reembolsable<T>, <T>Ingreso Costo<T>)<BR>    Entonces<BR>      Asigna(VentaD:VentaD.Costo, Info.Importe/Info.Cantidad)<BR>    Sino<BR>      Asigna(VentaD:VentaD.Precio, Info.Importe/Info.Cantidad)<BR>      Si(VentaD:Art.AutoRecaudacion=<T>Gasto<T>, Asigna(VentaD:VentaD.Precio, -VentaD:VentaD.Precio))<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Config.SeriesLotesMayoreo y (MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.DR,VTAS.SG,VTAS.EG,VTAS.D,VTAS.DF,VTAS.VC,VTAS.VCR,VTAS.DC,VTAS.DCR,VTAS.N,VTAS.NO,VTAS.NR,VTAS.FM,VTAS.CO)) o (MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.C, VTAS.P)) y Config.VentaRefSerieLotePedidos))
EjecucionCondicion=VentaD:Art.Tipo en (TipoSerie, TipoVIN, TipoLote) o <BR>((VentaD:Art.Tipo=TipoPartida) y ConDatos(VentaD:VentaD.SubCuenta))
AntesExpresiones=Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.Almacen, Si(Config.VentaMultiAlmacen, VentaD:VentaD.Almacen, Venta:Venta.Almacen))<BR>Asigna(Info.AlmTipo, Venta:Alm.Tipo)<BR>Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.RenglonID, VentaD:VentaD.RenglonID)<BR>Asigna(Info.Factor, VentaD:VentaD.Factor)<BR>Asigna(Info.Cantidad, ABS(VentaD:VentaD.Cantidad) * UnidadFactor(VentaD:VentaD.Unidad, VentaD:VentaD.Articulo))<BR>Asigna(Info.Paquete, VentaD:VentaD.Paquete)<BR>Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, Venta:Venta.Mov))<BR>Asigna(Info.ArtTipo, VentaD:Art.Tipo)<BR>Asigna(Info.EsEntrada, MovTipoEn(<T>INV<T>,Venta:Venta.Mov, (VTAS.D, VTAS.DF, VTAS.DC,VTAS.DCR)))<BR>Asigna(Info.Unidad, VentaD:VentaD.Unidad)<BR>Asigna(Info.Estatus, Venta:Venta.Estatus)<BR>Si(General.Autotransportes, Asigna(Filtro.Espacio, Venta:Venta.Espacio))<BR>Si((Info.ArtTipo=TipoPartida) o (VentaD:Art.TipoOpcion<>TipoNo), Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta), Asigna(Info.SubCuenta, <T><T>))<BR>Asigna(Info.Tarima, VentaD:VentaD.Tarima)<BR>Asigna(Info.Mov, Venta:Venta.Mov)

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

[Acciones.Embarque]
Nombre=Embarque
Boton=69
Menu=&Edici�n
NombreDesplegar=Datos &Embarque...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=GuiaEmbarque
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
EnBarraHerramientas=S
ActivoCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.SG,VTAS.EG,VTAS.VC,VTAS.VCR,VTAS.S)) y (Venta:Venta.Estatus<>EstatusCancelado)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.FormaEnvio, Venta:Venta.FormaEnvio)

[Acciones.CteExpress]
Nombre=CteExpress
Boton=60
Menu=&Edici�n
NombreDesplegar=Agregar &Cliente...
EnMenu=S
TipoAccion=Expresion
Visible=S
EnBarraHerramientas=S
UsaTeclaRapida=S
TeclaRapida=Alt+F8
Expresion=Asigna(Info.Tipo, <T>Cliente<T>)<BR>Forma(<T>CteExpress<T>)<BR>Si(ConDatos(Info.Cliente),Asigna(Venta:Venta.Cliente, Info.Cliente))
ActivoCondicion=Usuario.AgregarCteExpress y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Envio.Venta.EnviarA]
Carpeta=Envio
Clave=Venta.EnviarA
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

[Envio.Venta.Cliente]
Carpeta=Envio
Clave=Venta.Cliente
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

[Envio.Venta.FormaEnvio]
Carpeta=Envio
Clave=Venta.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cobro]
Nombre=Cobro
Boton=64
Menu=&Edici�n
NombreDesplegar=Si(MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.VP, VTAS.SD, VTAS.B)), <T>Devoluci�n...<T>, <T>Cobro...<T>)
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaCobro
Antes=S
DespuesGuardar=S
Activo=S
AntesExpresiones=Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, Venta:Venta.ID)<BR>Asigna(Afectar.Mov, Venta:Venta.Mov)<BR>Asigna(Afectar.MovID, Venta:Venta.MovID)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>Asigna(Info.Fecha, Venta:Venta.FechaEmision)<BR>Asigna(Info.Moneda, Venta:Venta.Moneda)<BR>Asigna(Info.TipoCambio,Venta:Venta.TipoCambio)<BR>Asigna(Info.Importe, Redondea(Suma(VentaD:Importe)+Suma(VentaD:Impuesto)-Suma(VentaD:DescGlobal)+Suma(VentaD:ImporteSobrePrecio)-(Venta:Venta.AnticiposFacturados+Venta:Venta.Retencion), Config.VentaCobroRedondeoDecimales))<BR>Asigna(Info.Cerrado, Venta:Venta.Estatus<>EstatusSinAfectar)<BR>Asigna(Info.VentaCobroDevolucion, MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.VP, VTAS.SD, VTAS.D, VTAS.DF)))<BR>Asigna(Info.FormaPago, Vacio(Usuario.DefFormaPago, Config.FormaPagoOmision))
VisibleCondicion=((MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.N, VTAS.FM)) y (ConDatos(Venta:Venta.MovID) o Config.VentaLiquidaIntegral) y (Venta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>)) o<BR>(MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.P, VTAS.VP, VTAS.SD, VTAS.B))  y (Venta:Condicion.ControlAnticipos=<T>Cobrar Pedido<T>)) o<BR>(MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F,VTAS.FAR, VTAS.FB, VTAS.D, VTAS.DF)) y (Venta:Venta.Vencimiento<=Venta:Venta.FechaEmision) y Config.FacturaCobroIntegrado y (Venta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>)))

[Mostrador.Venta.Mov]
Carpeta=Mostrador
Clave=Venta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22

[Mostrador.Venta.MovID]
Carpeta=Mostrador
Clave=Venta.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Plata
Pegado=S
Tamano=8

[Servicio]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos del servicio
Clave=Servicio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
CondicionEdicion=Vacio(Venta:Venta.AnexoID)
CondicionVisible=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.CS, VTAS.SG, VTAS.EG))

[Servicio.Venta.ServicioArticulo]
Carpeta=Servicio
Clave=Venta.ServicioArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Venta.ServicioSerie]
Carpeta=Servicio
Clave=Venta.ServicioSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Servicio.Venta.ServicioContrato]
Carpeta=Servicio
Clave=Venta.ServicioContrato
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
EspacioPrevio=N
ColorFuente=Negro

[Servicio.Venta.ServicioContratoID]
Carpeta=Servicio
Clave=Venta.ServicioContratoID
Editar=N
3D=S
Tamano=8
ColorFondo=Plata
ValidaNombre=N
Pegado=S
ColorFuente=Negro

[Servicio.ArtDestino.Descripcion1]
Carpeta=Servicio
Clave=ArtDestino.Descripcion1
Editar=S
3D=S
Tamano=49
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Servicio.Venta.ServicioGarantia]
Carpeta=Servicio
Clave=Venta.ServicioGarantia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ServicioHist]
Nombre=ServicioHist
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
NombreDesplegar=Historia Art�culo/Serie del Servicio
EnMenu=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Antes=S
EspacioPrevio=S
ActivoCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.CS, VTAS.SG, VTAS.EG))
AntesExpresiones=Asigna(Info.Articulo, Venta:Venta.ServicioArticulo)<BR>Asigna(Info.SerieLote, Venta:Venta.ServicioSerie)<BR>Asigna(Info.SubCuenta, <T><T>)<BR>Asigna(Info.ArtTipo, Venta:ArtDestino.Tipo)
VisibleCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.CS, VTAS.SG, VTAS.EG))

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tareas
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Tarea
Antes=S
Visible=S
DespuesGuardar=S
Activo=S
AntesExpresiones=Asigna(Info.PuedeEditar, Venta:Venta.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Venta:Venta.Agente)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Venta:Venta.Proyecto)<BR>Asigna(Info.UEN, Venta:Venta.UEN)<BR>Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Reporte, Nulo)

[Acciones.ArtAccesorioBuscar]
Nombre=ArtAccesorioBuscar
Boton=0
Menu=&Ver
NombreDesplegar=Buscar Accesorios...
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtAccesorioBuscar
Activo=S
Visible=S

[Acciones.ArtRefaccionBuscar]
Nombre=ArtRefaccionBuscar
Boton=0
Menu=&Ver
NombreDesplegar=Buscar Refacciones...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtRefaccionBuscar
Activo=S
Visible=S

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
NombreDesplegar=&Situaci�n
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>VTAS<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Venta:Venta.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.Estatus, Venta:Venta.Estatus)<BR>Asigna(Info.Situacion, Venta:Venta.Situacion)

[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
Antes=S
EspacioPrevio=S
ConCondicion=S
Visible=S
ActivoCondicion=ConfigModulo(<T>VTAS<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Venta:Venta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)

[(Carpeta Abrir).Venta.Cliente]
Carpeta=(Carpeta Abrir)
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

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
ActivoCondicion=ConDatos(VentaA:Venta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaA:Venta.ID)

[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=&Presentaci�n preliminar
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

[Servicio.Venta.ServicioContratoTipo]
Carpeta=Servicio
Clave=Venta.ServicioContratoTipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Accesorios]
Nombre=Accesorios
Boton=0
Menu=&Edici�n
NombreDesplegar=&Accesorios
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
Expresion=Si(Venta:Venta.Estatus en (EstatusConcluido, EstatusCancelado), Forma(<T>ServicioAccesoriosInfo<T>), Forma(<T>ServicioAccesorios<T>))
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)
VisibleCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.CS))

[Servicio.Venta.ServicioDescripcion]
Carpeta=Servicio
Clave=Venta.ServicioDescripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Acciones.ReasignarUsuario]
Nombre=ReasignarUsuario
Boton=0
Menu=&Archivo
NombreDesplegar=Reasignar &Usuario...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ReasignarUsuario
Antes=S
ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Usuario, Venta:Venta.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Venta:Venta.ID)

[Detalle.VentaD.Paquete]
Carpeta=Detalle
Clave=VentaD.Paquete
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
Expresion=Si(Venta:Venta.Estatus en (EstatusConcluido, EstatusCancelado), Informacion(VentaD:VentaD.DescripcionExtra), Pregunta(VentaD:VentaD.DescripcionExtra))

[Acciones.ArtExpress]
Nombre=ArtExpress
Boton=0
Menu=&Edici�n
NombreDesplegar=Agregar Art�cul&o...
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=May�s+F8
Expresion=Asigna(Info.Articulo, Nulo)<BR>Forma(<T>ArtExpress<T>)<BR>Si <BR>  ConDatos(Info.Articulo) y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>Entonces<BR>  Asigna(VentaD:VentaD.Articulo, Info.Articulo)<BR>Fin
ActivoCondicion=Usuario.AgregarArtExpress y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Acciones.Embarcar]
Nombre=Embarcar
Boton=0
Menu=&Archivo
NombreDesplegar=E&mbarcar...
EnMenu=S
TipoAccion=Expresion
GuardarAntes=S
Expresion=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Estatus, Venta:Venta.Estatus)<BR>Dialogo(<T>MovEmbarcar<T>)
ActivoCondicion=Venta:Venta.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusSincro, EstatusCancelado) y (no FormaBloqueada)
VisibleCondicion=Venta:Venta.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusSincro, EstatusCancelado) y (no FormaBloqueada)

[Acciones.Importar]
Nombre=Importar
Boton=0
Menu=&Archivo
NombreDesplegar=I&mportar...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=Si<BR>  MovTipo(<T>VTAS<T>, Venta:Venta.Mov) <> VTAS.CO<BR>Entonces<BR>  ProcesarLista(<T>Importar Movimiento<T>, <T>ImportarInv<T>, <T>Estacion<T>, <T>ID<T>, <T>spImportarInv<T>, EstacionTrabajo & <T>, <T> & Comillas(Empresa) & <T>, <T> & Comillas(<T>VTAS<T>) & <T>, <T> & Venta:Venta.ID & <T>, <T> & Sucursal)<BR>Sino<BR>  ProcesarLista(<T>Importar Contrato<T>, <T>ImportarInvArt<T>, <T>Estacion<T>, <T>ID<T>, <T>spImportarInvArt<T>, EstacionTrabajo & <T>, <T> & Venta:Venta.ID & <T>, <T> & Sucursal)<BR>Fin
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.ModificarAlmacen]
Nombre=ModificarAlmacen
Boton=0
Menu=&Archivo
NombreDesplegar=Mo&dificar Almac�n Pedido...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaModificarAlmacen
Antes=S
ConCondicion=S
ActivoCondicion=((MovTipo(<T>VTAS<T>, Venta:Venta.Mov)<>VTAS.P) y (Venta:Venta.Estatus=EstatusSinAfectar)) o<BR>((Venta:Venta.Estatus=EstatusPendiente) y (MovTipo(<T>VTAS<T>, Venta:Venta.Mov)=VTAS.P) y (no FormaBloqueada))
EjecucionCondicion=(MovTipo(<T>VTAS<T>, Venta:Venta.Mov)=VTAS.P) o (MovTipo(<T>VTAS<T>, VentaD:VentaD.Aplica)=VTAS.P)
AntesExpresiones=Si<BR>  MovTipo(<T>VTAS<T>, Venta:Venta.Mov)=VTAS.P<BR>Entonces<BR>  Asigna(Info.Mov, Venta:Venta.Mov)<BR>  Asigna(Info.MovID, Venta:Venta.MovID)<BR>  Asigna(Info.ID, Venta:Venta.ID)<BR>Sino<BR>  Asigna(Info.Mov, VentaD:VentaD.Aplica)<BR>  Asigna(Info.MovID, VentaD:VentaD.AplicaID)<BR>  Asigna(Info.ID, SQL(<T>SELECT ID FROM Venta WHERE Empresa=:tEmpresa AND Mov=:tMov AND MovID=:tMovID AND Estatus=:tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>Fin
VisibleCondicion=Usuario.ModificarAlmacenPedidos

[Detalle.VentaD.ContUso]
Carpeta=Detalle
Clave=VentaD.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S

[Acciones.RentabilidadContrato]
Nombre=RentabilidadContrato
Boton=0
Menu=&Ver
NombreDesplegar=&Rentabilidad del Contrato
EnMenu=S
TipoAccion=Formas
ClaveAccion=RentabilidadContrato
Activo=S
Antes=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)
VisibleCondicion=(MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.CO) y (Venta:Venta.Estatus noen (EstatusSinAfectar, EstatusCancelado))

[Servicio.Venta.ServicioFecha]
Carpeta=Servicio
Clave=Venta.ServicioFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
LineaNueva=S

[Acciones.ArtListaDisponible]
Nombre=ArtListaDisponible
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+L
NombreDesplegar=&Lista Art�culos Disponibles
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtListaDisponible
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=ConDatos(Venta:Venta.Almacen)
EjecucionMensaje=<T>Falta Especificar el Almac�n<T>
AntesExpresiones=Asigna(Info.Almacen, Venta:Venta.Almacen)<BR>Asigna(Info.Origen, <T>VTAS<T>)

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Fecha, Venta:Venta.FechaEmision)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Venta:Venta.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Venta:Venta.Mov+<T> <T>+Venta:Venta.MovID)
RefrescarDespues=S

[Acciones.AnexosDetalle]
Nombre=AnexosDetalle
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+F4
NombreDesplegar=Anexos &Detalle
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoMovD
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionConError=S
EjecucionCondicion=ConDatos(Venta:Venta.ID) y ConDatos(VentaD:VentaD.Articulo)
EjecucionMensaje=Si(Vacio(Venta:Venta.ID), <T>Es Necesario Guardar el Movimiento Antes de Ejecutar esta Opci�n<T>, <T>Falta Indicar el Art�culo<T>)
AntesExpresiones=Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Fecha, Venta:Venta.FechaEmision)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Venta:Venta.Estatus noen (EstatusCancelado, EstatusConcluido)))<BR>Asigna(Info.Cuenta, VentaD:VentaD.Articulo)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)

[Acciones.AgregarEvento]
Nombre=AgregarEvento
Boton=0
Menu=&Edici�n
NombreDesplegar=Agregar E&vento
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacoraAgregar
ConCondicion=S
Visible=S
Antes=S
ActivoCondicion=Venta:Venta.Estatus<>EstatusCancelado
EjecucionCondicion=Si(Vacio(Venta:Venta.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)

[Acciones.MovBitacora]
Nombre=MovBitacora
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+B
NombreDesplegar=Bit�cora
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacora
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=Si(Vacio(Venta:Venta.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.PuedeEditar, Venta:Venta.Estatus<>EstatusCancelado)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(Venta:Venta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Cuenta, Venta:Venta.ID)<BR>Asigna(Info.Descripcion, Venta:Venta.Mov+<T> <T>+Venta:Venta.MovID)

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

[Acciones.Anterior]
Nombre=Anterior
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+,
NombreDesplegar=Anterior
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Anterior
Activo=S
Visible=S

[Acciones.Siguiente]
Nombre=Siguiente
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+.
NombreDesplegar=Siguiente
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Siguiente
Activo=S
Visible=S

[Acciones.CopiarOtros]
Nombre=CopiarOtros
Boton=65
Menu=&Archivo
NombreDesplegar=Copiar de Otro Movimiento...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Si<BR>  Forma(<T>EspecificarFechas<T>)<BR>Entonces<BR>  Asigna(Info.ID, Venta:Venta.ID)<BR>  Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, Venta:Venta.Mov))<BR>  Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>  Asigna(Info.EnviarA, Venta:Venta.EnviarA)<BR>  Asigna(Info.Nombre, Venta:Cte.Nombre)<BR>  EjecutarSQL(<T>spVentaCteD :nEstacion, :tEmpresa, :tCliente, :fDel, :fAl<T>, EstacionTrabajo, Empresa, Info.Cliente, Info.FechaD, Info.FechaA)<BR>  Forma(<T>VentaCopiar<T>)<BR>Fin
VisibleCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Ficha.Venta.EnviarA]
Carpeta=Ficha
Clave=Venta.EnviarA
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

[Ficha.Venta.FormaEnvio]
Carpeta=Ficha
Clave=Venta.FormaEnvio
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

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=May�s+F11
NombreDesplegar=&Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=CopiarMovimiento(<T>VTAS<T>, Venta:Venta.ID, <T>Venta<T>)

[Notas.Venta.Causa]
Carpeta=Notas
Clave=Venta.Causa
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N
LineaNueva=S

[Servicio.Venta.ServicioTipo]
Carpeta=Servicio
Clave=Venta.ServicioTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Venta.FechaOriginal]
Carpeta=Ficha
Clave=Venta.FechaOriginal
Editar=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco
Pegado=N

[Detalle.VentaD.Unidad]
Carpeta=Detalle
Clave=VentaD.Unidad
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

[Detalle.VentaD.CantidadReservada]
Carpeta=Detalle
Clave=VentaD.CantidadReservada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Azul
Efectos=[Negritas]

[Detalle.VentaD.CantidadOrdenada]
Carpeta=Detalle
Clave=VentaD.CantidadOrdenada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

[Detalle.VentaD.CantidadPendiente]
Carpeta=Detalle
Clave=VentaD.CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00004080
Efectos=[Negritas]

[Detalle.VentaD.FechaRequerida]
Carpeta=Detalle
Clave=VentaD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Detalle.VentaD.Instruccion]
Carpeta=Detalle
Clave=VentaD.Instruccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.PedidoPos]
Nombre=PedidoPos
Boton=0
Menu=&Ver
NombreDesplegar=Posici�n del Pedido (en Cantidades)
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=PedidoPos
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Venta:Venta.ID)
Antes=S
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)
VisibleCondicion=MovTipo(<T>VTAS<T>, Venta:Venta.Mov)=VTAS.P

[Acciones.VentaDReservados]
Nombre=VentaDReservados
Boton=0
Menu=&Ver
NombreDesplegar=Reservados del Art�culo
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaDReservado
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(VentaD:VentaD.Articulo)
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Articulo, VentaD:VentaD.Articulo)
VisibleCondicion=Venta:Venta.Estatus<>EstatusSinAfectar

[Detalle.VentaD.CantidadInventario]
Carpeta=Detalle
Clave=VentaD.CantidadInventario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Notas.Venta.Atencion]
Carpeta=Notas
Clave=Venta.Atencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

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

[Ficha.Venta.ServicioContratoTipo]
Carpeta=Ficha
Clave=Venta.ServicioContratoTipo
Editar=S
3D=S
Tamano=13
ColorFondo=Blanco

[Acciones.Campos]
Nombre=Campos
Boton=0
Menu=&Edici�n
NombreDesplegar=&Campos...
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Expresion=GuardarCambios<BR>Forma(<T>VentaCampos<T>)
ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)
VisibleCondicion=
Visible=S
GuardarAntes=S
DespuesGuardar=S

[Acciones.Consecutivo]
Nombre=Consecutivo
Boton=0
Menu=&Archivo
NombreDesplegar=A&signar Consecutivo
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>VTAS<T>, Venta:Venta.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(Venta:Venta.MovID)
VisibleCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[Detalle.VentaD.Almacen]
Carpeta=Detalle
Clave=VentaD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Venta.Retencion]
Carpeta=Ficha
Clave=Venta.Retencion
ValidaNombre=S
3D=S
Pegado=S
Tamano=8
ColorFondo=Blanco

[Acciones.CopiarLote]
Nombre=CopiarLote
Boton=0
Menu=&Archivo
NombreDesplegar=Copiar en S&ucursales del Cliente...
GuardarAntes=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>Si(no Forma(<T>VentaCopiarLote<T>),  AbortarOperacion)

[Notas.Venta.Extra]
Carpeta=Notas
Clave=Venta.Extra
Editar=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VerOpciones]
Nombre=VerOpciones
Boton=0
NombreDesplegar=&Interpretar Opci�n
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=VerOpcionesArticulo( VentaD:VentaD.Articulo, VentaD:VentaD.SubCuenta )
ActivoCondicion=ConDatos(VentaD:VentaD.SubCuenta) y (VentaD:Art.TipoOpcion=TipoSi)

[Detalle.VentaD.Agente]
Carpeta=Detalle
Clave=VentaD.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
EditarConBloqueo=S

[Servicio.Venta.ServicioIdentificador]
Carpeta=Servicio
Clave=Venta.ServicioIdentificador
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Notas.Venta.AtencionTelefono]
Carpeta=Notas
Clave=Venta.AtencionTelefono
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VINExpress]
Nombre=VINExpress
Boton=0
Menu=&Edici�n
NombreDesplegar=Agregar &VIN...
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Expresion=Asigna(Info.Articulo, Venta:Venta.ServicioArticulo)<BR>Si(Forma(<T>VINExpress<T>), Asigna(Venta:Venta.ServicioSerie, Info.SerieLote))
EjecucionCondicion=ConDatos(Venta:Venta.ServicioArticulo)
EjecucionMensaje=<T>Es Necesario Indicar el Ar�culo Servicio<T>
VisibleCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.CS)) y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Detalle.AplicaNombre]
Carpeta=Detalle
Clave=AplicaNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Editar=N

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
ActivoCondicion=Vacio(Venta:Venta.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, Venta:Venta.ID)<BR>Asigna(Afectar.Mov, Venta:Venta.Mov)<BR>Asigna(Afectar.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Descripcion, Venta:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(Venta:Venta.Mensaje)

[Ficha.Venta.ListaPreciosEsp]
Carpeta=Ficha
Clave=Venta.ListaPreciosEsp
Editar=S
ValidaNombre=N
3D=S
Tamano=17
ColorFondo=Blanco

[Notas.Venta.ZonaImpuesto]
Carpeta=Notas
Clave=Venta.ZonaImpuesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Cte.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Notas.Venta.Departamento]
Carpeta=Notas
Clave=Venta.Departamento
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Venta.Importe]
Carpeta=(Carpeta Abrir)
Clave=Venta.Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Venta.Saldo]
Carpeta=(Carpeta Abrir)
Clave=Venta.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
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

[Acciones.CopiarPendientes]
Nombre=CopiarPendientes
Boton=65
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=Copiar &Pendientes
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
EspacioPrevio=S
RefrescarDespues=S
GuardarAntes=S
Visible=S
Expresion=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Moneda, Venta:Venta.Moneda)<BR>Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>Asigna(Info.EnviarA, Venta:Venta.EnviarA)<BR>Forma(<T>VentaPendienteDMultiple<T>)
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.VerPoliticaDetalle]
Nombre=VerPoliticaDetalle
Boton=0
NombreDesplegar=&Ver Pol�ticas de Precios Aplicadas
EnMenu=S
TipoAccion=Dialogos
Activo=S
Visible=S
ClaveAccion=VerPoliticasPrecios
Antes=S
AntesExpresiones=Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)<BR>Asigna(Info.Mensaje, VentaD:VentaD.PoliticaPrecios)

[Acciones.Sucursal]
Nombre=Sucursal
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+U
NombreDesplegar=<T>Sucursal<T>
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Sucursal Destino
Antes=S
Activo=S
AntesExpresiones=Si(Vacio(Venta:Venta.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino y Usuario.ModificarSucursalDestino y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y (no FormaBloqueada)

[Notas.Venta.DesglosarImpuestos]
Carpeta=Notas
Clave=Venta.DesglosarImpuestos
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Notas.Venta.ExcluirPlaneacion]
Carpeta=Notas
Clave=Venta.ExcluirPlaneacion
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VentaOtros]
Nombre=VentaOtros
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
NombreDesplegar=&Otros Datos...
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
Expresion=Forma(<T>VentaOtros<T>)
ActivoCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.CS))
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Estatus, Venta:Venta.Estatus)
VisibleCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.CS))

[Acciones.Otros1]
Nombre=Otros1
Menu=&Edici�n
EnMenu=S
TipoAccion=Expresion
Boton=47

NombreEnBoton=S
NombreDesplegar=&Ped Export
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
Antes=S
Visible=S
Expresion=SI<BR>  SQL(<T>Select Logico4 from Venta Where ID = :nID<T>,Venta:Venta.ID)=<T>1<T><BR> Entonces<BR>  Forma(<T>PedExporConsulta<T>)<BR> Sino<BR>  SI<BR>   Venta:Venta.Mov = <T>Devolucion Venta<T><BR> Entonces<BR>    Forma(<T>PedExporConsulta<T>)<BR>  Sino<BR>  Forma(<T>PedExpor<T>)<BR> Fin<BR>Fin
ActivoCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F,VTAS.D))
AntesExpresiones=asigna(info.id,Venta:Venta.ID)<BR>asigna(info.Renglon,VentaD:VentaD.Renglon)<BR>asigna(info.cantidad,VentaD:CantidadNeta)<BR>asigna(info.Estatus,Venta:Venta.Estatus)   <BR>EjecutarSQL(<T>EXEC spPedCarga :nID, :nRenglon<T>,Venta:Venta.ID,VentaD:VentaD.Renglon)
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

[Acciones.Anticipos]
Nombre=Anticipos
Boton=61
Menu=&Edici�n
NombreDesplegar=Anticipos...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F7
Expresion=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.EnviarA, Venta:Venta.EnviarA)<BR>Asigna(Info.Rama, <T>CXC<T>)<BR>Asigna(Info.Cuenta, Venta:Venta.Cliente)<BR>Asigna(Info.Agente, Venta:Venta.Agente)<BR>Asigna(Info.Moneda, Venta:Venta.Moneda)<BR>Asigna(Info.TipoCambio, Venta:Venta.TipoCambio)<BR>Asigna(Info.Estatus, Venta:Venta.Estatus)<BR>Asigna(Info.PorcentajeImpuesto,  Redondea(Si(Venta:Venta.DesglosarImpuesto2, General.DefImpuesto, (Suma(VentaD:Impuesto)/Suma(VentaD:SubTotal))*100), 8))<BR>Asigna(Info.Concepto, Venta:Venta.Concepto)<BR>Asigna(Info.Proyecto, Venta:Venta.Proyecto)<BR>Forma(<T>VentaVerAnticipo<T>)
ActivoCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.P, VTAS.S)) y (Venta:Venta.Estatus en (EstatusPendiente, EstatusConcluido)) y<BR>(Venta:Condicion.ControlAnticipos en (<T>Abierto<T>, <T>Plazos<T>, <T>Fecha Requerida<T>))

[Ficha.Venta.DescuentoGlobal]
Carpeta=Ficha
Clave=Venta.DescuentoGlobal
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.Venta.HoraRequerida]
Carpeta=Ficha
Clave=Venta.HoraRequerida
Editar=S
3D=S
Pegado=S
Tamano=9
ColorFondo=Blanco

[Ficha.Venta.Actividad]
Carpeta=Ficha
Clave=Venta.Actividad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S

[Notas.Venta.VigenciaDesde]
Carpeta=Notas
Clave=Venta.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Notas.Venta.VigenciaHasta]
Carpeta=Notas
Clave=Venta.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Notas.Venta.ConVigencia]
Carpeta=Notas
Clave=Venta.ConVigencia
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Refacturar]
Nombre=Refacturar
Boton=0
Menu=&Archivo
NombreDesplegar=Refacturar
EnMenu=S
TipoAccion=Expresion
ConfirmarAntes=S
DialogoMensaje=Refacturar
Antes=S
ConCondicion=S
EjecucionConError=S
Expresion=spAfectar(<T>VTAS<T>, Venta:Venta.ID, Venta:Venta.Mov, Venta:Venta.MovID, <T>Refacturar<T>, <T>Todo<T>, <T><T>, <T>Venta<T>)
ActivoCondicion=Usuario.Refacturar
EjecucionCondicion=Si <BR>  Config.CancelarFactura=<T>Cambio Mes<T><BR>Entonces<BR>  Asigna(Temp.Fecha, SQL(<T>SELECT GETDATE()<T>))<BR>  Si<BR>    (Mes(Temp.Fecha)>Mes(Venta:Venta.FechaEmision)) o (A�o(Temp.Fecha)>A�o(Venta:Venta.FechaEmision))<BR>  Entonces<BR>    Falso<BR>  Sino<BR>    Verdadero<BR>  Fin<BR>Sino<BR>  Verdadero<BR>Fin
EjecucionMensaje=<T>No se Puede Refacturar Autom�ticamente Fuera del Mes<T>
AntesExpresiones=Asigna(Afectar.Mov, Venta:Venta.Mov)<BR>Asigna(Afectar.MovID, Venta:Venta.MovID)
VisibleCondicion=Usuario.Refacturar y ((MovTipo(<T>VTAS<T>, Venta:Venta.Mov) en (VTAS.F, VTAS.FAR)) y (Venta:Venta.Estatus=EstatusConcluido))

[Notas.Venta.AnticiposFacturados]
Carpeta=Notas
Clave=Venta.AnticiposFacturados
Editar=N
3D=S
Tamano=18
ColorFuente=Negro
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

[Detalle.VentaD.DescuentoImporte]
Carpeta=Detalle
Clave=VentaD.DescuentoImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Notas.Venta.Bonificacion]
Carpeta=Notas
Clave=Venta.Bonificacion
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

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
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+W
NombreDesplegar=Precio
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Expresion=Si<BR>  Usuario.AsistentePrecios<BR>Entonces<BR>  Si(VentaD:Art.Linea=Config.AutoArtBX, Asigna(Temp.Flotante, 0), Asigna(Temp.Flotante, VentaD:VentaD.Cantidad))<BR>  Si<BR>    VentaD:Art.AutoRecaudacion en (<T>Gasto No Reembolsable<T>, <T>Ingreso Costo<T>)<BR>  Entonces<BR>    ConfirmarImportes(VentaD:VentaD.Cantidad, VentaD:VentaD.Costo, Usuario.AutoDobleCapturaPrecios y (VentaD:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX)), <T>Editar Costo<T>, Temp.Flotante)<BR>  Sino<BR>    ConfirmarImportes(VentaD:VentaD.Cantidad, VentaD:VentaD.Precio, Usuario.AutoDobleCapturaPrecios y (VentaD:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX)), <T>Editar Precio<T>, Temp.Flotante, VentaD:Art.AutoRecaudacion=<T>Gasto<T>)<BR>  Fin<BR>Sino<BR>  Asigna(Info.Estatus, Venta:Venta.Estatus)<BR>  Asigna(Info.Modulo, <T>VTAS<T>)<BR>  Asigna(Info.ID, Venta:Venta.ID)<BR>  Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>  Asigna(Info.ArtLinea, VentaD:Art.Linea)<BR>  Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta)<BR>  Asigna(Info.RenglonID, VentaD:VentaD.RenglonID)<BR>  Si<BR>    Forma(<T>AutoBoletoMov<T>)<BR>  Entonces<BR>    Asigna(VentaD:VentaD.Cantidad, Info.Cantidad)<BR>    Si<BR>      VentaD:Art.AutoRecaudacion en (<T>Gasto No Reembolsable<T>, <T>Ingreso Costo<T>)<BR>    Entonces<BR>      Asigna(VentaD:VentaD.Costo, Info.Importe/Info.Cantidad)<BR>    Sino<BR>      Asigna(VentaD:VentaD.Precio, Info.Importe/Info.Cantidad)<BR>      Si(VentaD:Art.AutoRecaudacion=<T>Gasto<T>, Asigna(VentaD:VentaD.Precio, -VentaD:VentaD.Precio))<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
EjecucionCondicion=(Info.SubModuloVenta=<T>AUTO<T>) y (VentaD:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX))
VisibleCondicion=General.Autotransportes o Usuario.AsistentePrecios

[Detalle.VentaD.AutoLocalidad]
Carpeta=Detalle
Clave=VentaD.AutoLocalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Corrida]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Corrida
Clave=Corrida
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
CondicionEdicion=Vacio(Venta:Venta.AnexoID)
CondicionVisible=Info.SubModuloVenta=<T>AUTO<T>
CarpetaDesActivada=S

[Corrida.Venta.AutoCorrida]
Carpeta=Corrida
Clave=Venta.AutoCorrida
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

[Corrida.Venta.AutoBoleto]
Carpeta=Corrida
Clave=Venta.AutoBoleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Acciones.Desafectar]
Nombre=Desafectar
Boton=0
Menu=&Archivo
NombreDesplegar=Desafectar
EnMenu=S
ConfirmarAntes=S
TipoAccion=Expresion
RefrescarDespues=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F12
Expresion=Caso MovTipo(<T>VTAS<T>, Venta:Venta.Mov)<BR>  Es VTAS.P   Entonces EjecutarSQL(<T>spDesAfectarPedido :nID, :tUsuario<T>, Venta:Venta.ID, Usuario)<BR>  Es VTAS.S   Entonces EjecutarSQL(<T>spDesAfectarPedido :nID, :tUsuario<T>, Venta:Venta.ID, Usuario)<BR>  Es VTAS.FAR Entonces EjecutarSQL(<T>spDesAfectarRecaudacion :nID<T>, Venta:Venta.ID)<BR>Sino<BR>  EjecutarSQL(<T>spDesAfectarPresupuesto :tModulo, :tMov, :nID<T>, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID)<BR>Fin
ActivoCondicion=Usuario.Desafectar
VisibleCondicion=Usuario.Desafectar y <BR>((MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.P, VTAS.S)) y (Venta:Venta.Estatus=EstatusPendiente)) o<BR>(MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.PR, VTAS.FR, VTAS.FAR)) y (Venta:Venta.Estatus en (EstatusConcluido, EstatusRecurrente, EstatusBorrador))))

[Notas.Venta.Periodicidad]
Carpeta=Notas
Clave=Venta.Periodicidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AnticiposFacturados]
Nombre=AnticiposFacturados
Boton=0
Menu=&Edici�n
NombreDesplegar=Anticipos Facturados...
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
GuardarAntes=S
Expresion=Si<BR>  ConDatos(Venta:Venta.PedidoReferenciaID)<BR>Entonces<BR>  Asigna(Info.RID,Venta:Venta.PedidoReferenciaID)<BR>  Si<BR>  Forma(<T>CxcAnticiposPendientes2<T>)<BR>  Entonces<BR>    Si Config.CxcAnticipoTipoServicio = Verdadero Entonces<BR>      SQL(<T>EXEC spVtasAplicarAnticiposTipoServicio :nEstacion, :nID<T>,EstacionTrabajo, Venta:Venta.ID)<BR>      ActualizarForma<BR>    SiNo<BR>      Asigna(Temp.Reg, SQL(<T>SELECT SUM(AnticipoAplicar), SUM(AnticipoAplicar*Impuestos/(Importe+Impuestos)) FROM Cxc WHERE AnticipoAplicaModulo=:tModulo AND AnticipoAplicaID=:nID<T>, Info.Modulo, Info.ID))<BR>      Asigna(Venta:Venta.AnticiposFacturados, Temp.Reg[1])<BR>      Asigna(Venta:Venta.AnticiposImpuestos,  Temp.Reg[2])<BR>    Fin<BR>  Fin<BR>Sino<BR>  Si<BR>    Forma(<T>CxcAnticiposPendientes<T>)<BR>  Entonces<BR>    Si Config.CxcAnticipoTipoServicio = Verdadero Entonces<BR>      SQL(<T>EXEC spVtasAplicarAnticiposTipoServicio :nEstacion, :nID<T>,EstacionTrabajo, Venta:Venta.ID)<BR>      ActualizarForma<BR>    SiNo<BR>      Asigna(Temp.Reg, SQL(<T>SELECT SUM(AnticipoAplicar), SUM(AnticipoAplicar*Impuestos/(Importe+Impuestos)) FROM Cxc WHERE AnticipoAplicaModulo=:tModulo AND AnticipoAplicaID=:nID<T>, Info.Modulo, Info.ID))<BR>      Asigna(Venta:Venta.AnticiposFacturados, Temp.Reg[1])<BR>      Asigna(Venta:Venta.AnticiposImpuestos,  Temp.Reg[2])<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Venta:Venta.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>Asigna(Info.Nombre, Venta:Cte.Nombre)
VisibleCondicion=Config.CxcAnticiposFacturados y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F, VTAS.FAR, VTAS.FB))

[Acciones.CteEnviarA]
Nombre=CteEnviarA
Boton=0
Menu=&Edici�n
NombreDesplegar=&Sucursales del Cliente...
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteEnviarA
Antes=S
ActivoCondicion=Usuario.AgregarCteExpress y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
AntesExpresiones=Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>Asigna(Info.Nombre, Venta:Cte.Nombre)
VisibleCondicion=Usuario.CteSucursalVenta

[Detalle.VentaD.SustitutoArticulo]
Carpeta=Detalle
Clave=VentaD.SustitutoArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Sustitutos]
Nombre=Sustitutos
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+S
NombreDesplegar=Sustitutos del Art�culo
EnMenu=S
TipoAccion=Formas
ConCondicion=S
ClaveAccion=VentaAsignarSusutitos
Antes=S
GuardarAntes=S
RefrescarDespues=S
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
EjecucionCondicion=VentaD:Art.Sustitutos
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)<BR>Asigna(Info.Almacen, VentaD:VentaD.Almacen)<BR>Asigna(Info.Cantidad, VentaD:VentaD.Cantidad)<BR>Asigna(Info.Renglon, VentaD:VentaD.Renglon)<BR>Asigna(Info.RenglonSub, VentaD:VentaD.RenglonSub)<BR>Asigna(Info.RenglonID, VentaD:VentaD.RenglonID)
VisibleCondicion=Config.FacturarSustitutos y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.R, VTAS.VCR, VTAS.F))

[Corrida.Venta.Espacio]
Carpeta=Corrida
Clave=Venta.Espacio
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

[Ficha.Venta.UEN]
Carpeta=Ficha
Clave=Venta.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco

[Detalle.VentaD.UEN]
Carpeta=Detalle
Clave=VentaD.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Notas.Venta.Clase]
Carpeta=Notas
Clave=Venta.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Notas.Venta.Subclase]
Carpeta=Notas
Clave=Venta.Subclase
Editar=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.Espacio]
Carpeta=Detalle
Clave=VentaD.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
EditarConBloqueo=N

[Detalle.VentaD.HoraRequerida]
Carpeta=Detalle
Clave=VentaD.HoraRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
EditarConBloqueo=S

[Acciones.ProyInfo]
Nombre=ProyInfo
Boton=0
Menu=&Ver
NombreDesplegar=Informaci�n del Proyecto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Venta:Venta.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Venta:Venta.Proyecto)
Visible=S

[Acciones.EspacioInfo]
Nombre=EspacioInfo
Boton=0
Menu=&Ver
NombreDesplegar=Informaci�n del Espacio
EnMenu=S
TipoAccion=Formas
ClaveAccion=EspacioInfo
ConCondicion=S
Antes=S
ActivoCondicion=General.Espacios y Config.VentaEspacioDetalle
EjecucionCondicion=ConDatos(VentaD:VentaD.Espacio)
AntesExpresiones=Asigna(Info.Espacio, VentaD:VentaD.Espacio)
VisibleCondicion=General.Espacios y Config.VentaEspacioDetalle

[Acciones.ProrrateoFecha]
Nombre=ProrrateoFecha
Boton=0
Menu=&Edici�n
NombreDesplegar=Prorratear Fecha Requerida
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
GuardarAntes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
Expresion=Si<BR>  Asigna(Info.Periodicidad, <T>Diaria<T>)<BR>  Asigna(Info.Veces, VentaD:VentaD.Cantidad)<BR>  Forma(<T>EspecificarPeriodicidad<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spProrrateoFecha :nEstacion, :nTotal, :fFecha, :tPeridicidad, :nVeces<T>, EstacionTrabajo, VentaD:VentaD.Cantidad, VentaD:VentaD.FechaRequerida, Info.Periodicidad, Info.Veces)<BR>  Si<BR>    Forma(<T>ProrrateoFecha<T>)<BR>  Entonces<BR>    EjecutarSQL(<T>spProrrateoFechaAceptar :nEstacion, :tModulo, :nID, :nRen, :nSub<T>, EstacionTrabajo, <T>VTAS<T>, Venta:Venta.ID, VentaD:VentaD.Renglon, VentaD:VentaD.RenglonSub)<BR>  Fin<BR>Fin
ActivoCondicion=(Venta:Venta.Estatus=EstatusSinAfectar) y (MovTipo(<T>VTAS<T>, Venta:Venta.Mov) en (VTAS.C, VTAS.CS, VTAS.P, VTAS.VP, VTAS.S, VTAS.PR, VTAS.EST)) y Config.VentaDFechaRequerida y General.Espacios
EjecucionCondicion=ConDatos(VentaD:VentaD.Articulo)
VisibleCondicion=Config.VentaDFechaRequerida y General.Espacios

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
Expresion=Si(Confirmacion(<T>� Desea Actualizar los Precios Otras Monedas ?<T>, BotonSi, BotonNo) = BotonSi, EjecutarSQL(<T>spVentaActualizarPrecios :nID<T>, Venta:Venta.ID))
ActivoCondicion=Config.VentaActualizarPrecioMoneda y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
VisibleCondicion=Config.VentaActualizarPrecioMoneda y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Corrida.Venta.AutoKms]
Carpeta=Corrida
Clave=Venta.AutoKms
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Plata
ColorFuente=Negro

[Corrida.Venta.AutoBomba]
Carpeta=Corrida
Clave=Venta.AutoBomba
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Corrida.Venta.AutoBombaContador]
Carpeta=Corrida
Clave=Venta.AutoBombaContador
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Corrida.Venta.AutoKmsActuales]
Carpeta=Corrida
Clave=Venta.AutoKmsActuales
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro

[Corrida.Venta.AutoCorridaServicio]
Carpeta=Corrida
Clave=Venta.AutoCorridaServicio
ValidaNombre=S
3D=S
Tamano=21
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.Venta.AutoCorridaRol]
Carpeta=Corrida
Clave=Venta.AutoCorridaRol
ValidaNombre=S
3D=S
Tamano=21
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.Venta.AutoCorridaOrigen]
Carpeta=Corrida
Clave=Venta.AutoCorridaOrigen
ValidaNombre=S
3D=S
Tamano=11
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.Venta.AutoCorridaDestino]
Carpeta=Corrida
Clave=Venta.AutoCorridaDestino
ValidaNombre=S
3D=S
Tamano=11
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.Venta.AutoCorridaRuta]
Carpeta=Corrida
Clave=Venta.AutoCorridaRuta
ValidaNombre=S
3D=S
Tamano=11
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.Venta.AutoCorridaHora]
Carpeta=Corrida
Clave=Venta.AutoCorridaHora
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.Venta.AutoCorridaKms]
Carpeta=Corrida
Clave=Venta.AutoCorridaKms
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.Venta.AutoCorridaLts]
Carpeta=Corrida
Clave=Venta.AutoCorridaLts
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Acciones.ServicioTipoPlantilla]
Nombre=ServicioTipoPlantilla
Boton=0
Menu=&Edici�n
NombreDesplegar=Sugerir Art�culos del Tipo Servicio
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Alt+F2
Expresion=EjecutarSQL(<T>spGenerarServicioTipo :nID, :tEmp, :nSuc, :tAlm, :tLista, :tTipo, :tMoneda, :nTC, :fFecha<T>, Venta:Venta.ID, Empresa, Sucursal, Venta:Venta.Almacen, Venta:Venta.ListaPreciosEsp, Venta:Venta.ServicioTipo, Venta:Venta.Moneda, Venta:Venta.TipoCambio, Venta:Venta.FechaRequerida)
ActivoCondicion=Venta:Venta.Estatus=EstatusSinAfectar
EjecucionCondicion=ConDatos(Venta:Venta.ServicioTipo)
EjecucionMensaje=<T>Falta Indicar el Tipo de Servicio<T>
EjecucionConError=S
Visible=S

[Gasto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gasto
Clave=Gasto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
CondicionVisible=MovTipo(<T>VTAS<T>, Venta:Venta.Mov) en (VTAS.FG, VTAS.FX)
CondicionEdicion=Vacio(Venta:Venta.AnexoID)

[Gasto.Venta.GastoAcreedor]
Carpeta=Gasto
Clave=Venta.GastoAcreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.Acreedor.Nombre]
Carpeta=Gasto
Clave=Acreedor.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Gasto.Venta.GastoConcepto]
Carpeta=Gasto
Clave=Venta.GastoConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=61
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=Venta
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
ListaEnCaptura=Venta.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S

[Comentarios.Venta.Comentarios]
Carpeta=Comentarios
Clave=Venta.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.SustitutoSubCuenta]
Carpeta=Detalle
Clave=VentaD.SustitutoSubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.CopiarComentario]
Nombre=CopiarComentario
Boton=0
Menu=&Archivo
NombreDesplegar=Copiar Comentario...
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(Info.Modulo,<T>VTAS<T>)<BR>Si(Forma(<T>ComentarioLista<T>), Asigna(Venta:Venta.Comentarios, Temp.Texto))
VisibleCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Servicio.Venta.ServicioSiniestro]
Carpeta=Servicio
Clave=Venta.ServicioSiniestro
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Servicio.Venta.ServicioPlacas]
Carpeta=Servicio
Clave=Venta.ServicioPlacas
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro
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

[Acciones.FordOasis]
Nombre=FordOasis
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=&Oasis
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
EjecucionConError=S
EspacioPrevio=S
Antes=S
Expresion=URL(General.FordOASIS)
ActivoCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.CS))
EjecucionCondicion=ConDatos(Venta:Venta.ServicioSerie)
EjecucionMensaje=<T>Falta Especificar el VIN<T>
AntesExpresiones=Asigna(Venta:Venta.FordVisitoOASIS, Verdadero)
VisibleCondicion=General.Ford

[Servicio.Venta.ServicioKms]
Carpeta=Servicio
Clave=Venta.ServicioKms
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Servicio.Venta.Cliente]
Carpeta=Servicio
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Cte.Nombre]
Carpeta=Servicio
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=34
ColorFondo=Plata
ColorFuente=Negro

[Servicio.Venta.ListaPreciosEsp]
Carpeta=Servicio
Clave=Venta.ListaPreciosEsp
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Venta.ServicioTipoOrden]
Carpeta=Servicio
Clave=Venta.ServicioTipoOrden
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Venta.ServicioExpress]
Carpeta=Servicio
Clave=Venta.ServicioExpress
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Venta.ServicioTipoOperacion]
Carpeta=Servicio
Clave=Venta.ServicioTipoOperacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Art.Horas]
Carpeta=Detalle
Clave=Art.Horas
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaD.Estado]
Carpeta=Detalle
Clave=VentaD.Estado
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Servicio.Venta.ServicioNumero]
Carpeta=Servicio
Clave=Venta.ServicioNumero
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Venta.ServicioDemerito]
Carpeta=Servicio
Clave=Venta.ServicioDemerito
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Venta.ServicioDeducible]
Carpeta=Servicio
Clave=Venta.ServicioDeducible
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TiempoEntregaSugerido]
Nombre=TiempoEntregaSugerido
Boton=0
Menu=&Ver
NombreDesplegar=Fecha Entrega Sugerida
EnMenu=S
TipoAccion=Expresion
Expresion=Si<BR>  Config.VentaDMultiAgente<BR>Entonces<BR>  Asigna(Info.ID, Venta:Venta.ID)<BR>  Si(MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.P)) y (Venta:Venta.Estatus=EstatusPendiente), Forma(<T>VentaFechaEntrega<T>))<BR>Sino<BR>  Asigna(Info.Fecha, SQL(<T>spSugerirFechaEntrega :tEmp, :nID<T>, Empresa, Venta:Venta.ID))<BR>  Informacion(<T>Tiempo Entrega Sugerido: <T>+FechaEnTexto(Info.Fecha, <T>dddd dd/mmm/aaaa<T>))<BR>Fin
ActivoCondicion=Venta:Venta.Estatus noen (EstatusConcluido, EstatusCancelado)
VisibleCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.C, VTAS.CS, VTAS.S, VTAS.P))

[Notas.Venta.AgenteServicio]
Carpeta=Notas
Clave=Venta.AgenteServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Notas.AgenteDestino.Nombre]
Carpeta=Notas
Clave=AgenteDestino.Nombre
Editar=S
ValidaNombre=S
OcultaNombre=S
3D=S
Tamano=18
ColorFondo=Plata
ColorFuente=Negro

[Acciones.CopiarMeses]
Nombre=CopiarMeses
Boton=0
Menu=&Archivo
NombreDesplegar=Copiar en el Tiempo...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Si(no Forma(<T>MovCopiarMeses<T>),  AbortarOperacion)

[Notas.Venta.FechaOriginal]
Carpeta=Notas
Clave=Venta.FechaOriginal
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.ServicioNumero]
Carpeta=Detalle
Clave=VentaD.ServicioNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Notas.Venta.ServicioTipo]
Carpeta=Notas
Clave=Venta.ServicioTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Notas.Venta.SucursalVenta]
Carpeta=Notas
Clave=Venta.SucursalVenta
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Boletos]
Nombre=Boletos
Boton=0
Menu=&Ver
NombreDesplegar=&Boletos Recaudados
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaAutoBoleto
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Filtro, <T>AutoBoleto.VentaID=<T>+Venta:Venta.ID)
VisibleCondicion=General.AutoTransportes

[Acciones.SubMovimiento]
Nombre=SubMovimiento
Boton=0
Menu=&Archivo
NombreDesplegar=<T>Generar Sub <T>+Venta:Venta.Mov
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=CopiarMovimiento(<T>VTAS<T>, Venta:Venta.ID, <T>Venta<T>, <T>GENERAR<T>, <T>SUB<T>)
ActivoCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.P, VTAS.S, VTAS.SD))
VisibleCondicion=Config.VentaSubMovimientos y (Venta.Estatus en (EstatusPendiente, EstatusConcluido))

[Acciones.AnexarMov]
Nombre=AnexarMov
Boton=0
Menu=&Archivo
NombreDesplegar=Anexar Movimiento...
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Afectar.GenerarMov, Nulo)<BR>Si<BR>  Forma(<T>AnexarMov<T>)<BR>Entonces<BR>  CopiarMovimiento(Info.Modulo, Info.ID, <T>Venta<T>, <T>GENERAR<T>, <T>SUB<T>, Afectar.GenerarMov)<BR>Fin
VisibleCondicion=Config.VentaAnexarMov y (Venta.Estatus en (EstatusPendiente, EstatusConcluido))

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.Clave, <T>VTAS<T>+Venta:Venta.ID)<BR>Asigna(Info.Nombre, Venta:Venta.Mov+<T> <T>+Venta:Venta.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Venta:Venta.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Servicio.Venta.ServicioNumeroEconomico]
Carpeta=Servicio
Clave=Venta.ServicioNumeroEconomico
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Servicio.Venta.ServicioAseguradora]
Carpeta=Servicio
Clave=Venta.ServicioAseguradora
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.AgentesAsignados]
Carpeta=Detalle
Clave=VentaD.AgentesAsignados
LineaNueva=S
ValidaNombre=S
3D=S
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
EjecucionCondicion=VentaD:Art.Linea=Config.AutoArtBT
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)
VisibleCondicion=General.Autotransportes y (VentaD:Art.Linea=Config.AutoArtBT)

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
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta)
VisibleCondicion=Config.BackOrders y (Venta:Venta.Estatus=EstatusPendiente) y MovTipoEn(<T>VTAS<T>,Venta:Venta.Mov, (VTAS.P, VTAS.S, VTAS.F, VTAS.FAR, VTAS.FC, VTAS.FG, VTAS.FX, VTAS.DFC, VTAS.FB))

[Notas.Venta.AF]
Carpeta=Notas
Clave=Venta.AF
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Notas.Venta.AFArticulo]
Carpeta=Notas
Clave=Venta.AFArticulo
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Notas.Venta.AFSerie]
Carpeta=Notas
Clave=Venta.AFSerie
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Detalle.VentaD.AFArticulo]
Carpeta=Detalle
Clave=VentaD.AFArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaD.AFSerie]
Carpeta=Detalle
Clave=VentaD.AFSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrato]
Estilo=Ficha
Pestana=S
Clave=Contrato
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
PestanaOtroNombre=S
PestanaNombre=Datos del Contrato
CondicionVisible=MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.CTO
CondicionEdicion=Vacio(Venta:Venta.AnexoID)

[Contrato.Venta.ContratoTipo]
Carpeta=Contrato
Clave=Venta.ContratoTipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Venta.ContratoDescripcion]
Carpeta=Contrato
Clave=Venta.ContratoDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Venta.ContratoSerie]
Carpeta=Contrato
Clave=Venta.ContratoSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Venta.ContratoValor]
Carpeta=Contrato
Clave=Venta.ContratoValor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Venta.ContratoValorMoneda]
Carpeta=Contrato
Clave=Venta.ContratoValorMoneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Venta.ContratoSeguro]
Carpeta=Contrato
Clave=Venta.ContratoSeguro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Venta.ContratoResponsable]
Carpeta=Contrato
Clave=Venta.ContratoResponsable
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Venta.ConVigencia]
Carpeta=Contrato
Clave=Venta.ConVigencia
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Venta.VigenciaDesde]
Carpeta=Contrato
Clave=Venta.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Contrato.Venta.VigenciaHasta]
Carpeta=Contrato
Clave=Venta.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Venta.Periodicidad]
Carpeta=Contrato
Clave=Venta.Periodicidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Contrato.Venta.ContratoVencimiento]
Carpeta=Contrato
Clave=Venta.ContratoVencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.ExcluirPlaneacion]
Carpeta=Detalle
Clave=VentaD.ExcluirPlaneacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Servicio.Venta.ServicioDeducibleImporte]
Carpeta=Servicio
Clave=Venta.ServicioDeducibleImporte
Editar=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Cte.Telefonos]
Carpeta=Servicio
Clave=Cte.Telefonos
Editar=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Notas.Venta.GenerarOP]
Carpeta=Notas
Clave=Venta.GenerarOP
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Notas.Venta.Extra1]
Carpeta=Notas
Clave=Venta.Extra1
Editar=S
ValidaNombre=N
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Venta.ServicioFlotilla]
Carpeta=Servicio
Clave=Venta.ServicioFlotilla
Editar=S
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Venta.ServicioRampa]
Carpeta=Servicio
Clave=Venta.ServicioRampa
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actividades]
Nombre=Actividades
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+K
NombreDesplegar=Actividades del Art�culo
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
Expresion=Asigna(Info.Minutos, SQL(<T>SELECT (Horas*60)+Minutos FROM ArtSub WHERE Articulo=:tArt AND SubCuenta=:tSub<T>, VentaD:VentaD.Articulo, VentaD:VentaD.SubCuenta))<BR>Si(Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente), Si(Forma(<T>VentaDAgente<T>), Asigna(VentaD:VentaD.AgentesAsignados, Info.Cantidad)), Si(Usuario.Costos, Forma(<T>VentaDAgenteCostoInfo<T>), Forma(<T>VentaDAgenteInfo<T>)))
ActivoCondicion=Config.VentaDMultiAgente
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Renglon, VentaD:VentaD.Renglon)<BR>Asigna(Info.RenglonSub, VentaD:VentaD.RenglonSub)<BR>Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)<BR>Asigna(Info.Cantidad, VentaD:VentaD.Cantidad)<BR>Asigna(Info.Agente, VentaD:VentaD.Agente)
VisibleCondicion=Config.VentaDMultiAgente

[Acciones.Incentivo]
Nombre=Incentivo
Boton=0
Menu=&Edici�n
NombreDesplegar=&Incentivo...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaIncentivo
Activo=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)
VisibleCondicion=General.Ford y (MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.F)

[Notas.Venta.EndosarA]
Carpeta=Notas
Clave=Venta.EndosarA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Resumen]
Nombre=Resumen
Boton=0
Menu=&Ver
NombreDesplegar=Resum�n
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaResumen
ActivoCondicion=Venta:Venta.Estatus<>EstatusSinAfectar
VisibleCondicion=MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.NR

[Acciones.AsesoresDisponible]
Nombre=AsesoresDisponible
Boton=0
Menu=&Ver
NombreDesplegar=Asesores Disponible
EnMenu=S
TipoAccion=Expresion
Antes=S
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+D
Expresion=Si(Forma(<T>AsesorDisponible<T>), Asigna(Venta:Venta.Agente, Info.Agente))
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
ConCondicion=S
EjecucionCondicion=ConDatos(Venta:Venta.FechaRequerida) y ConDatos(Venta:Venta.HoraRequerida)
EjecucionMensaje=Si(Vacio(Venta:Venta.FechaRequerida), <T>Falta Indicar la Fecha Requerida<T>)<BR>Si(Vacio(Venta:Venta.HoraRequerida), <T>Falta Indicar la Hora Requerida<T>)
EjecucionConError=S
AntesExpresiones=Asigna(Info.Fecha, Venta:Venta.FechaRequerida)<BR>Asigna(Info.Hora, Venta:Venta.HoraRequerida)
VisibleCondicion=General.Ford y (MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.S)

[Acciones.EditarVIN]
Nombre=EditarVIN
Boton=0
Menu=&Edici�n
NombreDesplegar=Datos VIN...
EnMenu=S
TipoAccion=Formas
ClaveAccion=VINPoliza
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(Venta:Venta.ServicioSerie)
AntesExpresiones=Asigna(Info.VIN, Venta:Venta.ServicioSerie)
VisibleCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.CS)) y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Acciones.EditarCliente]
Nombre=EditarCliente
Boton=0
Menu=&Edici�n
NombreDesplegar=Datos Cliente...
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaCte
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(Venta:Venta.Cliente)
AntesExpresiones=Asigna(Info.Cliente, Venta:Venta.Cliente)
VisibleCondicion=Usuario.ModificarDatosCliente y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Acciones.PrecioConImpuestos]
Nombre=PrecioConImpuestos
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+F6
NombreDesplegar=Precio con Impuestos Incluidos...
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Importe, Redondea((VentaD:ImporteTotal*100)/(100-Venta:Venta.DescuentoGlobal), 2))<BR>Si<BR>  Forma(<T>EspecificarImporte<T>)<BR>Entonces<BR>  Asigna(VentaD:VentaD.Precio, Redondea(Info.Importe/(1+(JuntarImpuestos(VentaD:VentaD.Impuesto1+VentaD:VentaD.Impuesto3, VentaD:VentaD.Impuesto2)/100)), 2))<BR>Fin
ActivoCondicion=(no Usuario.BloquearPrecios) y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
VisibleCondicion=no Config.VentaPreciosImpuestoIncluido

[Notas.Venta.DesglosarImpuesto2]
Carpeta=Notas
Clave=Venta.DesglosarImpuesto2
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.MovImpuesto]
Nombre=MovImpuesto
Boton=0
Menu=&Ver
NombreDesplegar=Impuestos
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovImpuesto
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)
VisibleCondicion=(Venta:Venta.Estatus en (EstatusConcluido, EstatusPendiente, EstatusCancelado, EstatusProcesar)) y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.N, VTAS.NO, VTAS.NR, VTAS.FM, VTAS.F, VTAS.FAR, VTAS.FC, VTAS.FG, VTAS.FX, VTAS.FB, VTAS.D, VTAS.DF, VTAS.B))

[Acciones.MovActividad]
Nombre=MovActividad
Boton=0
Menu=&Edici�n
NombreDesplegar=Actividades del Movimiento
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+K
Expresion=Si(Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente), Si(Forma(<T>VentaMovActividad<T>), Asigna(VentaD:VentaD.AgentesAsignados, Info.Cantidad)), Si(Usuario.Costos, Forma(<T>VentaMovActividadCostoInfo<T>), Forma(<T>VentaMovActividadInfo<T>)))
ActivoCondicion=Config.VentaDMultiAgente
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)
VisibleCondicion=Config.VentaDMultiAgente

[Detalle.VentaD.Codigo]
Carpeta=Detalle
Clave=VentaD.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.BoletosVendidos]
Nombre=BoletosVendidos
Boton=0
Menu=&Ver
NombreDesplegar=Boletos &Vendidos
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaAutoBoleto
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Filtro, <T>AutoBoleto.FacturaID=<T>+Venta:Venta.ID)
VisibleCondicion=General.AutoTransportes

[Acciones.ExcluirISAN]
Nombre=ExcluirISAN
Boton=0
NombreDesplegar=Excluir/Cargar ISAN...
EnMenu=S
TipoAccion=Expresion
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+E
Expresion=Si<BR>  VentaD:VentaD.ExcluirISAN<BR>Entonces<BR>   Si(Confirmacion(<T>� Desea Incluir de Nuevo Este Accesorio en el C�lculo del ISAN ?<T>, BotonSi, BotonNo)=BotonSi, Asigna(VentaD:VentaD.ExcluirISAN, Falso))<BR>Sino<BR>   Si(Precaucion(<T>� Desea Excluir Este Accesorio en el C�lculo del ISAN ?<T>, BotonSi, BotonNo)=BotonSi, Asigna(VentaD:VentaD.ExcluirISAN, Verdadero))<BR>Fin
ActivoCondicion=Venta:Venta.DesglosarImpuesto2 y (VentaD:Art.Tipo<>TipoVIN)
VisibleCondicion=General.Ford y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.P, VTAS.VCR, VTAS.R, VTAS.DCR, VTAS.DR, VTAS.F, VTAS.DC))

[Acciones.VentaDWeb]
Nombre=VentaDWeb
Boton=0
NombreDesplegar=Detalles de Art�culo
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(Info.ID, VentaD:VentaD.ID)<BR>Asigna(Info.Renglon, VentaD:VentaD.Renglon)<BR>Asigna(Info.RenglonSub, VentaD:VentaD.RenglonSub)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>FormaModal(<T>VentaDWeb<T>)
VisibleCondicion=(MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.P))) y ( fnSubMovTipo( <T>VTAS<T>, Venta:Venta.Mov) = <T>VTAS.PWEB<T>)

[Acciones.MovPersonal]
Nombre=MovPersonal
Boton=0
Menu=&Archivo
NombreDesplegar=P&ersonal Involucrado
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPersonal
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Fecha, Venta:Venta.FechaEmision)<BR>Asigna(Info.Estatus, Venta:Venta.Estatus)

[Detalle.VentaD.EnviarA]
Carpeta=Detalle
Clave=VentaD.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaD.ExcluirISAN]
Carpeta=Detalle
Clave=VentaD.ExcluirISAN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+O
NombreDesplegar=P&ol�tica Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Venta:Venta.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Clave, Venta:Venta.Mov)

[Acciones.PoliticaConcepto]
Nombre=PoliticaConcepto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+N
NombreDesplegar=Pol�tica Co&ncepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Venta:Venta.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Concepto, Venta:Venta.Concepto)

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

[Acciones.Participacion]
Nombre=Participacion
Boton=0
Menu=&Edici�n
NombreDesplegar=&Seguros y Participaciones...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaParticipacion
Activo=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)
VisibleCondicion=General.Ford y (MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.F)

[AC]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cr�dito
Clave=AC
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
PermiteEditar=S
CondicionVisible=General.AC y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.C,VTAS.CS,VTAS.P,VTAS.S,VTAS.F,VTAS.EST))

[AC.Venta.LineaCredito]
Carpeta=AC
Clave=Venta.LineaCredito
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.Venta.TipoAmortizacion]
Carpeta=AC
Clave=Venta.TipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.Venta.TipoTasa]
Carpeta=AC
Clave=Venta.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.LC.Descripcion]
Carpeta=AC
Clave=LC.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[AC.LC.VigenciaHasta]
Carpeta=AC
Clave=LC.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[AC.TipoAmortizacion.Descripcion]
Carpeta=AC
Clave=TipoAmortizacion.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[AC.TipoTasa.Descripcion]
Carpeta=AC
Clave=TipoTasa.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[AC.LC.VigenciaDesde]
Carpeta=AC
Clave=LC.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[AC.Venta.Condicion]
Carpeta=AC
Clave=Venta.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.Venta.Vencimiento]
Carpeta=AC
Clave=Venta.Vencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TablaAmortizacion]
Nombre=TablaAmortizacion
Boton=0
Menu=&Ver
NombreDesplegar=Tabla A&mortizaci�n
EnMenu=S
TipoAccion=Expresion
Activo=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+M
GuardarAntes=S
Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Estatus, Venta:Venta.Estatus)<BR>Si(Venta:Venta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar), EjecutarSQL(<T>spTablaAmortizacion :tModulo, :nID, :tUsuario<T>, Info.Modulo, Info.ID, Usuario))<BR>Forma(<T>TablaAmortizacion<T>)
VisibleCondicion=General.AC y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.C,VTAS.CS,VTAS.P,VTAS.S,VTAS.F,VTAS.EST))

[Corrida.Venta.AutoOperador2]
Carpeta=Corrida
Clave=Venta.AutoOperador2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AC.Venta.Comisiones]
Carpeta=AC
Clave=Venta.Comisiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AC.Venta.ComisionesIVA]
Carpeta=AC
Clave=Venta.ComisionesIVA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.TotalComisiones]
Carpeta=AC
Clave=TotalComisiones
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.DescuentoGlobal]
Nombre=DescuentoGlobal
Boton=0
NombreDesplegar=Descuento &Global
EnMenu=S
TipoAccion=Expresion
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+D
Expresion=Asigna(Temp.Monetario, Suma(VentaD:Importe))<BR>Asigna(Info.Importe, Suma(VentaD:DescGlobal))<BR>Si(Forma(<T>EspecificarDescuentoGlobal<T>), Asigna(Venta:Venta.DescuentoGlobal, Info.Importe/Temp.Monetario*100)  Forma.ActualizarTotalizadores)
ActivoCondicion=Usuario.ModificarDescGlobalImporte
VisibleCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.ServicioMatriz]
Nombre=ServicioMatriz
Boton=0
Menu=&Edici�n
NombreDesplegar=Matriz de &Servicios
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ServicioMatrizLista
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+M
Antes=S
DespuesGuardar=S
RefrescarDespues=S
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.ArtVersion, SQL(<T>SELECT Version FROM Art WHERE Articulo=:tArt<T>, Venta:Venta.ServicioArticulo))
VisibleCondicion=(General.Ford o General.Chrysler) y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.CS, VTAS.S))

[Servicio.Venta.ServicioPuntual]
Carpeta=Servicio
Clave=Venta.ServicioPuntual
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VINComponentes]
Nombre=VINComponentes
Boton=0
Menu=&Ver
NombreDesplegar=Componentes del &VIN
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+C
Expresion=Asigna(Info.Bloqueado, Verdadero)<BR>Asigna(Info.VIN, Venta:Venta.ServicioSerie)<BR>Si(Config.VINAccesorioArt, Forma(<T>VINAccesorioArt<T>), Forma(<T>VINAccesorio<T>))
EjecucionCondicion=ConDatos(Venta:Venta.ServicioSerie)
VisibleCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.CS, VTAS.S))

[Acciones.Mapa]
Nombre=Mapa
Boton=0
Menu=&Ver
NombreDesplegar=Mapa
EnMenu=S
TipoAccion=Expresion
GuardarAntes=S
Expresion=PlugIn(<T>InteliMap<T>, <T>Transaccion<T>, <T>Ventas<T>, Venta:Venta.ID)

[Acciones.ActualizarPrecios]
Nombre=ActualizarPrecios
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+F5
NombreDesplegar=Actualizar &Precios
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=EjecutarSQL(<T>spVentaActualizarPrecios :nID<T>, Venta:Venta.ID)
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

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
Expresion=Asigna(Info.Forma, <T>Venta<T>)<BR>Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.Nombre, Venta:Venta.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

[Notas.Venta.AgenteComision]
Carpeta=Notas
Clave=Venta.AgenteComision
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Detalle.VentaD.Posicion]
Carpeta=Detalle
Clave=VentaD.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.TraspasarArticulos]
Nombre=TraspasarArticulos
Boton=0
Menu=&Edici�n
NombreDesplegar=Traspasar Articulos...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaTraspasarArticulos
Activo=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+T
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)
DespuesGuardar=S
VisibleCondicion=General.Ford y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.P, VTAS.S)) y (Venta:Venta.Estatus=EstatusPendiente)

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=0
Menu=&Edici�n
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
RefrescarDespues=S
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID, Falso, Venta:Venta.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>VTAS<T>+Venta:Venta.ID)<BR>  Asigna(Info.Nombre, Venta:Venta.Mov+<T> <T>+Venta:Venta.MovID)<BR>  Asigna(Info.Modulo, <T>VTAS<T>)<BR>  Asigna(Info.Mov, Venta:Venta.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Acciones.ImportarPDT]
Nombre=ImportarPDT
Boton=0
Menu=&Archivo
NombreDesplegar=Importar &PDT...
EnMenu=S
TipoAccion=Expresion
RefrescarDespues=S
GuardarAntes=S
Expresion=PlugIn(<T>PDT<T>, <T>VTAS<T>, Venta:Venta.ID)
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[AC.Venta.TieneTasaEsp]
Carpeta=AC
Clave=Venta.TieneTasaEsp
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[AC.Venta.TasaEsp]
Carpeta=AC
Clave=Venta.TasaEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.Venta.ServicioPoliza]
Carpeta=Servicio
Clave=Venta.ServicioPoliza
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.FormasAnexas]
Nombre=FormasAnexas
Boton=113
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F10
NombreDesplegar=Formas Anexas
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovFormaAnexo
Antes=S
DespuesGuardar=S
Visible=S
Activo=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)

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

[MovEvento]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Eventos
Clave=MovEvento
Filtros=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovEvento
Fuente={Tahoma, 8, Negro, []}
IconosCampo=EventoTipo.Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Asunto<T>
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
CarpetaVisible=S
OtroOrden=S
ListaOrden=MovEvento.Fecha<TAB>(Acendente)
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=MovEvento:MovEvento.Asunto
ListaEnCaptura=(Lista)
FiltroGeneral=MovEvento.Modulo=<T>VTAS<T> AND MovEvento.ModuloID={Venta:Venta.ID}

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
NombreDesplegar=Presentaci�n preliminar
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

[Acciones.FEA]
Nombre=FEA
Boton=0
Menu=&Archivo
NombreDesplegar=Generar &Factura Elect�nica
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
EjecucionConError=S
Expresion=FEA.Generar(General.FEAWebService, General.FEACertificado, Usuario.FEACertificado, Usuario.FEALlave, Venta:Venta.ID)
ActivoCondicion=Venta:Venta.Estatus en (EstatusPendiente, EstatusConcluido)
EjecucionCondicion=SQL(<T>SELECT ConsecutivoFEA FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov<T>, <T>VTAS<T>, Venta:Venta.Mov)<><T><T>
EjecucionMensaje=<T>Este Movimiento no Genera Factura Electr�nica<T>

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
Vista=Venta
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
CondicionVisible=Config.VentaVerDatosOC y (MovTipo(<T>VTAS<T>,Venta:Venta.Mov) noen (VTAS.D,VTAS.DF,VTAS.B,VTAS.DC,VTAS.DCR))

[OC.Venta.OrdenCompra]
Carpeta=OC
Clave=Venta.OrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[OC.Venta.FechaOrdenCompra]
Carpeta=OC
Clave=Venta.FechaOrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[OC.Venta.ReferenciaOrdenCompra]
Carpeta=OC
Clave=Venta.ReferenciaOrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VerComentarios]
Nombre=VerComentarios
Boton=0
Menu=&Ver
NombreDesplegar=&Comentarios
EnMenu=S
TipoAccion=Expresion
Expresion=VerComentario(<T>Comentarios<T>, Venta:Venta.Comentarios)
Activo=S
Visible=S

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
ActivoCondicion=Usuario.EnviarExcel y (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Detalle.VentaD.DescripcionExtra]
Carpeta=Detalle
Clave=VentaD.DescripcionExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.DatosEntrega]
Nombre=DatosEntrega
Boton=0
Menu=&Edici�n
NombreDesplegar=Datos &Entrega...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaEntrega
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Cliente, Venta:Venta.Cliente)

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Caracter�sticas
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
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroAplicaEn=FormaExtraCampo.Grupo
FiltroPredefinido=S
FiltroAutoCampo=FormaExtraCampo.Grupo
FiltroAutoValidar=FormaExtraCampo.Grupo
FiltroAutoOrden=FormaExtraCampo.Orden
FiltroGrupo1=FormaExtraCampo.Grupo
FiltroValida1=FormaExtraCampo.Grupo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>VTAS<T>, <T>{Venta:Venta.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>VTAS{Venta:Venta.ID}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>

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

[Acciones.PresupuestoEsp]
Nombre=PresupuestoEsp
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+P
NombreDesplegar=Presupuesto Especifico
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaDPresupuestoEsp
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=VentaD:VentaD.PresupuestoEsp y ConDatos(VentaD:VentaD.Articulo)
AntesExpresiones=Asigna(Info.PuedeEditar, Venta:Venta.Estatus=EstatusSinAfectar)<BR>Asigna(Info.Importe, VentaD:ImporteTotal)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Renglon, VentaD:VentaD.Renglon)<BR>Asigna(Info.RenglonSub, VentaD:VentaD.RenglonSub)<BR>Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.Concepto, Nulo)
VisibleCondicion=General.PPTO y General.PPTOVentas

[Detalle.VentaD.PresupuestoEsp]
Carpeta=Detalle
Clave=VentaD.PresupuestoEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
Expresion=Asigna(Anexo.Modulo, <T>VTAS<T>)<BR>Asigna(Anexo.ID, Venta:Venta.ID)<BR>Asigna(Anexo.Mov, Venta:Venta.Mov)<BR>Asigna(Anexo.MovID, Venta:Venta.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, Anexo.Mov, Anexo.MovID)
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
Expresion=Asigna(Anexo.Modulo, <T>VTAS<T>)<BR>Asigna(Anexo.ID, Venta:Venta.ID)<BR>Asigna(Anexo.Mov, Venta:Venta.Mov)<BR>Asigna(Anexo.MovID, Venta:Venta.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo.Anexar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, BuscarArchivo(<T><T>, Anexo.Clave+<T>.xml<T>, <T>xml<T>, Anexo.Clave, <T>Formas InfoPath<T>))
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
Expresion=Asigna(Anexo.Modulo, <T>VTAS<T>)<BR>Asigna(Anexo.ID, Venta:Venta.ID)<BR>Asigna(Anexo.Mov, Venta:Venta.Mov)<BR>Asigna(Anexo.MovID, Venta:Venta.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo.Eliminar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo)
ActivoCondicion=MovFormaAnexo:Icono=731

[FormaAnexo]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Formas Anexas
Clave=FormaAnexo
MenuLocal=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovFormaAnexo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Forma Anexa<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaAcciones=(Lista)
ExpAntesRefrescar=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)
IconosNombre=MovFormaAnexo:Nombre

[Notas.Venta.Enganche]
Carpeta=Notas
Clave=Venta.Enganche
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta.FormaPagoTipo]
Carpeta=Ficha
Clave=Venta.FormaPagoTipo
Editar=S
3D=S
Tamano=17
ColorFondo=Blanco

[Detalle.VentaD.PrecioMoneda]
Carpeta=Detalle
Clave=VentaD.PrecioMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.PrecioTipoCambio]
Carpeta=Detalle
Clave=VentaD.PrecioTipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaD.ProveedorRef]
Carpeta=Detalle
Clave=VentaD.ProveedorRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.TransferirA]
Carpeta=Detalle
Clave=VentaD.TransferirA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.Tarima]
Carpeta=Detalle
Clave=VentaD.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Entarimar]
Nombre=Entarimar
Boton=11
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+T
NombreDesplegar=&Entarimar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Si<BR>  Forma(<T>Entarimar<T>)<BR>Entonces<BR>  Forma.ActualizarVista(<T>Detalle<T>) <BR>Fin
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
VisibleCondicion=General.WMS

[Oportunidad]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Oportunidad
Clave=Oportunidad
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaOportunidad
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Venta
LlaveLocal=VentaOportunidad.ID
LlaveMaestra=Venta.ID
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
CondicionVisible=MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.OP

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

[Competidores]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Competidores
Clave=Competidores
OtroOrden=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaCompetidor
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Venta
LlaveLocal=VentaCompetidor.ID
LlaveMaestra=Venta.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=VentaCompetidor.Orden<TAB>(Acendente)
CondicionVisible=MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.OP

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

[CentrosCostos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Centros de costo
Clave=CentrosCostos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
CondicionVisible=Config.ContCentrosCostos y (Config.CentroCostos2Venta o Config.CentroCostos3Venta) y ((Venta:Venta.Estatus <> EstatusConcluido) y (Venta:Venta.Estatus <> EstatusCancelado))

[CentrosCostos.Venta.ContUso2]
Carpeta=CentrosCostos
Clave=Venta.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CentrosCostos.Venta.ContUso3]
Carpeta=CentrosCostos
Clave=Venta.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaD.ContUso2]
Carpeta=Detalle
Clave=VentaD.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaD.ContUso3]
Carpeta=Detalle
Clave=VentaD.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
0=201
1=427
Cliente=117
Nombre=229
RFC=107
Tarima=124
Articulo=118
Descripcion1=184
Cantidad=60
Almacen=90
Posicion=64
Grupo=100
Sucursal=46
2=-2
3=-2
4=-2
5=106
6=62
7=91
8=-2
Serie=189
Importe=85
EstatusNombre=89
Tipo=88
Moneda=64
Saldo=79
SerieLote=139
CentroCostos2=127
Descripcion=435
CentroCostos3=127
CentroCostos=127
Existencia=75
Fecha1=97
Precio=90
Mov=124
MovID=64
FechaEmision=74
Referencia=96
Concepto=94
AnticipoSaldo=96
AnticipoAplicar=91
9=-2
10=-2
11=-2
12=212
13=-2
14=-2
15=-2
16=-2
17=-2
18=-2
19=-2
20=-2
Clave=88
Propiedades=124
Pedido=109
PO=78
Item=40
Cantidad2=61
CantidadPR=69
Ancho=66
PesoR=82
Categoria=121
Fecha=119
Batch=93
Unidad=151

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

[MovImpuesto]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Arrastre
Clave=MovImpuesto
Filtros=S
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovImpuestoMov
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Venta
LlaveLocal=MovImpuestoMov.ModuloID
LlaveMaestra=Venta.ID
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=PersonalizarVista
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
FiltroGeneral=MovImpuestoMov.Modulo = <T>VTAS<T>
CondicionVisible=((Venta:Venta.Estatus = EstatusConcluido) o (Venta:Venta.Estatus = EstatusCancelado)) y  (Config.VisualizarArrastre)

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

[MovImpuesto.MovImpuestoMov.Impuesto2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Impuesto3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Importe1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Importe2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Importe3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Retencion1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Retencion2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Retencion3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.ContUso]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.ContUso2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.ContUso3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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

[Detalle.VentaD.ABC]
Carpeta=Detalle
Clave=VentaD.ABC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.ListaOrden]
(Inicio)=VentaD.Renglon<TAB>(Acendente)
VentaD.Renglon<TAB>(Acendente)=VentaD.RenglonSub<TAB>(Acendente)
VentaD.RenglonSub<TAB>(Acendente)=(Fin)

[Notas.ListaEnCaptura]
(Inicio)=Venta.Observaciones
Venta.Observaciones=Venta.EndosarA
Venta.EndosarA=Venta.ZonaImpuesto
Venta.ZonaImpuesto=Venta.Prioridad
Venta.Prioridad=Venta.Enganche
Venta.Enganche=Venta.AnticiposFacturados
Venta.AnticiposFacturados=Venta.Atencion
Venta.Atencion=Venta.AtencionTelefono
Venta.AtencionTelefono=Venta.Departamento
Venta.Departamento=Venta.AgenteComision
Venta.AgenteComision=Venta.AgenteServicio
Venta.AgenteServicio=AgenteDestino.Nombre
AgenteDestino.Nombre=Venta.Causa
Venta.Causa=Venta.ServicioTipo
Venta.ServicioTipo=Venta.FechaOriginal
Venta.FechaOriginal=Venta.SucursalVenta
Venta.SucursalVenta=Venta.Bonificacion
Venta.Bonificacion=Venta.Clase
Venta.Clase=Venta.Subclase
Venta.Subclase=Venta.VigenciaDesde
Venta.VigenciaDesde=Venta.VigenciaHasta
Venta.VigenciaHasta=Venta.Periodicidad
Venta.Periodicidad=Venta.DesglosarImpuestos
Venta.DesglosarImpuestos=Venta.DesglosarImpuesto2
Venta.DesglosarImpuesto2=Venta.ConVigencia
Venta.ConVigencia=Venta.Extra
Venta.Extra=Venta.ExcluirPlaneacion
Venta.ExcluirPlaneacion=Venta.GenerarOP
Venta.GenerarOP=Venta.Extra1
Venta.Extra1=Venta.AF
Venta.AF=Venta.AFArticulo
Venta.AFArticulo=Venta.AFSerie
Venta.AFSerie=(Fin)

[Gasto.ListaEnCaptura]
(Inicio)=Venta.GastoAcreedor
Venta.GastoAcreedor=Acreedor.Nombre
Acreedor.Nombre=Venta.GastoConcepto
Venta.GastoConcepto=(Fin)

[Contrato.ListaEnCaptura]
(Inicio)=Venta.ContratoDescripcion
Venta.ContratoDescripcion=Venta.ContratoTipo
Venta.ContratoTipo=Venta.ContratoSeguro
Venta.ContratoSeguro=Venta.ContratoValor
Venta.ContratoValor=Venta.ContratoValorMoneda
Venta.ContratoValorMoneda=Venta.ContratoSerie
Venta.ContratoSerie=Venta.ContratoResponsable
Venta.ContratoResponsable=Venta.ContratoVencimiento
Venta.ContratoVencimiento=Venta.Periodicidad
Venta.Periodicidad=Venta.VigenciaDesde
Venta.VigenciaDesde=Venta.VigenciaHasta
Venta.VigenciaHasta=Venta.ConVigencia
Venta.ConVigencia=(Fin)

[AC.ListaEnCaptura]
(Inicio)=Venta.LineaCredito
Venta.LineaCredito=LC.Descripcion
LC.Descripcion=LC.VigenciaDesde
LC.VigenciaDesde=LC.VigenciaHasta
LC.VigenciaHasta=Venta.TipoAmortizacion
Venta.TipoAmortizacion=TipoAmortizacion.Descripcion
TipoAmortizacion.Descripcion=Venta.Condicion
Venta.Condicion=Venta.Vencimiento
Venta.Vencimiento=Venta.TipoTasa
Venta.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=Venta.TieneTasaEsp
Venta.TieneTasaEsp=Venta.TasaEsp
Venta.TasaEsp=Venta.Comisiones
Venta.Comisiones=Venta.ComisionesIVA
Venta.ComisionesIVA=TotalComisiones
TotalComisiones=(Fin)

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

[OC.ListaEnCaptura]
(Inicio)=Venta.OrdenCompra
Venta.OrdenCompra=Venta.FechaOrdenCompra
Venta.FechaOrdenCompra=Venta.ReferenciaOrdenCompra
Venta.ReferenciaOrdenCompra=(Fin)

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

[Corrida.ListaEnCaptura]
(Inicio)=Venta.Espacio
Venta.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.Servicio
Espacio.Servicio=Espacio.Rol
Espacio.Rol=Venta.AutoCorrida
Venta.AutoCorrida=AutoCorrida.Nombre
AutoCorrida.Nombre=Venta.AutoCorridaServicio
Venta.AutoCorridaServicio=Venta.AutoCorridaRol
Venta.AutoCorridaRol=Venta.AutoBoleto
Venta.AutoBoleto=Venta.AutoCorridaRuta
Venta.AutoCorridaRuta=Venta.AutoCorridaOrigen
Venta.AutoCorridaOrigen=Venta.AutoCorridaDestino
Venta.AutoCorridaDestino=Venta.AutoCorridaHora
Venta.AutoCorridaHora=Venta.AutoCorridaKms
Venta.AutoCorridaKms=Venta.AutoCorridaLts
Venta.AutoCorridaLts=Venta.AutoOperador2
Venta.AutoOperador2=Venta.AutoBomba
Venta.AutoBomba=Venta.AutoBombaContador
Venta.AutoBombaContador=Venta.AutoKmsActuales
Venta.AutoKmsActuales=Venta.AutoKms
Venta.AutoKms=(Fin)

[Servicio.ListaEnCaptura]
(Inicio)=Venta.ServicioSerie
Venta.ServicioSerie=Venta.ServicioNumeroEconomico
Venta.ServicioNumeroEconomico=Venta.ServicioPlacas
Venta.ServicioPlacas=Venta.ServicioKms
Venta.ServicioKms=Venta.ServicioArticulo
Venta.ServicioArticulo=ArtDestino.Descripcion1
ArtDestino.Descripcion1=Venta.ServicioPoliza
Venta.ServicioPoliza=Venta.Cliente
Venta.Cliente=Cte.Nombre
Cte.Nombre=Cte.Telefonos
Cte.Telefonos=Venta.ListaPreciosEsp
Venta.ListaPreciosEsp=Venta.ServicioTipo
Venta.ServicioTipo=Venta.ServicioTipoOperacion
Venta.ServicioTipoOperacion=Venta.ServicioTipoOrden
Venta.ServicioTipoOrden=Venta.ServicioFecha
Venta.ServicioFecha=Venta.ServicioAseguradora
Venta.ServicioAseguradora=Venta.ServicioSiniestro
Venta.ServicioSiniestro=Venta.ServicioContrato
Venta.ServicioContrato=Venta.ServicioContratoID
Venta.ServicioContratoID=Venta.ServicioContratoTipo
Venta.ServicioContratoTipo=Venta.ServicioDescripcion
Venta.ServicioDescripcion=Venta.ServicioGarantia
Venta.ServicioGarantia=Venta.ServicioExpress
Venta.ServicioExpress=Venta.ServicioPuntual
Venta.ServicioPuntual=Venta.ServicioDemerito
Venta.ServicioDemerito=Venta.ServicioFlotilla
Venta.ServicioFlotilla=Venta.ServicioRampa
Venta.ServicioRampa=Venta.ServicioDeducible
Venta.ServicioDeducible=Venta.ServicioDeducibleImporte
Venta.ServicioDeducibleImporte=Venta.ServicioIdentificador
Venta.ServicioIdentificador=Venta.ServicioNumero
Venta.ServicioNumero=(Fin)

[Acciones.SurtirTarima]
Nombre=SurtirTarima
Boton=0
Menu=&Edici�n
NombreDesplegar=&Surtir por Tarima
EnMenu=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+S
GuardarAntes=S
Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Almacen, Venta:Venta.Almacen)<BR>Si<BR>  Forma(<T>SurtirTarima<T>)<BR>Entonces<BR>  Forma.ActualizarVista(<T>Detalle<T>) <BR>Fin
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
VisibleCondicion=General.WMS

[Agrupadores.Contrato.MovID]
Carpeta=Agrupadores
Clave=Contrato.MovID
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agrupadores]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agrupadores
Clave=Agrupadores
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
CondicionVisible=General.VerMovAgrupadores

[Agrupadores.Venta.ContratoMov]
Carpeta=Agrupadores
Clave=Venta.ContratoMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agrupadores.Venta.ContratoMovID]
Carpeta=Agrupadores
Clave=Venta.ContratoMovID
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
(Inicio)=Venta.ContratoMov
Venta.ContratoMov=Venta.ContratoMovID
Venta.ContratoMovID=(Fin)

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

[Detalle.VentaD.TipoImpuesto1]
Carpeta=Detalle
Clave=VentaD.TipoImpuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.TipoImpuesto2]
Carpeta=Detalle
Clave=VentaD.TipoImpuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.TipoImpuesto3]
Carpeta=Detalle
Clave=VentaD.TipoImpuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.Impuesto1]
Carpeta=Detalle
Clave=VentaD.Impuesto1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaD.Impuesto2]
Carpeta=Detalle
Clave=VentaD.Impuesto2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Anexo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Anexo Transaccional
Clave=Anexo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
CondicionVisible=(Empresa.EsEcuador) Y (Venta:MovTipo.EcuadorMostrarAnexo EN (<T>Encabezado<T>))

[Anexo.Venta.Establecimiento]
Carpeta=Anexo
Clave=Venta.Establecimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
LineaNueva=N

[Anexo.Venta.PuntoEmision]
Carpeta=Anexo
Clave=Venta.PuntoEmision
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=5
ColorFondo=Blanco
Pegado=S

[Anexo.Venta.SecuencialSRI]
Carpeta=Anexo
Clave=Venta.SecuencialSRI
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
LineaNueva=N
Pegado=S

[Anexo.Venta.AutorizacionSRI]
Carpeta=Anexo
Clave=Venta.AutorizacionSRI
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Anexo.Venta.VigenteA]
Carpeta=Anexo
Clave=Venta.VigenteA
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
LineaNueva=S
Tamano=20
EspacioPrevio=N

[Detalle.VentaD.Establecimiento]
Carpeta=Detalle
Clave=VentaD.Establecimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaD.PuntoEmision]
Carpeta=Detalle
Clave=VentaD.PuntoEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.VentaD.SecuencialSRI]
Carpeta=Detalle
Clave=VentaD.SecuencialSRI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.VentaD.AutorizacionSRI]
Carpeta=Detalle
Clave=VentaD.AutorizacionSRI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.VentaD.VigenteA]
Carpeta=Detalle
Clave=VentaD.VigenteA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaFlexibleD]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Refacturaci�n
Clave=VentaFlexibleD
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaFlexibleD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Venta
LlaveLocal=VentaFlexibleD.ID
LlaveMaestra=Venta.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=VentaFlexibleD.Cliente<BR>Cte.Nombre<BR>VentaFlexibleD.Articulo<BR>Art.Descripcion1<BR>VentaFlexibleD.Cantidad<BR>VentaFlexibleD.Precio<BR>VentaFlexibleD.Importe
ControlRenglon=S
CampoRenglon=VentaFlexibleD.Renglon
CondicionVisible=(Venta:MovTipo.Clave = <T>VTAS.F<T>) Y (Venta:MovTipo.SubClave = <T>FF.FF<T>)

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
(Inicio)=Venta.Establecimiento
Venta.Establecimiento=Venta.PuntoEmision
Venta.PuntoEmision=Venta.SecuencialSRI
Venta.SecuencialSRI=Venta.AutorizacionSRI
Venta.AutorizacionSRI=Venta.VigenteA
Venta.VigenteA=(Fin)

[Detalle.VentaD.Impuesto3]
Carpeta=Detalle
Clave=VentaD.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaD.TipoRetencion1]
Carpeta=Detalle
Clave=VentaD.TipoRetencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.Retencion1]
Carpeta=Detalle
Clave=VentaD.Retencion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaD.TipoRetencion2]
Carpeta=Detalle
Clave=VentaD.TipoRetencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.Retencion2]
Carpeta=Detalle
Clave=VentaD.Retencion2
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaD.TipoRetencion3]
Carpeta=Detalle
Clave=VentaD.TipoRetencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.Retencion3]
Carpeta=Detalle
Clave=VentaD.Retencion3
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122

[Acciones.SorianaRemision]
Nombre=SorianaRemision
Boton=0
Menu=&Edici�n
NombreDesplegar=Remision Soriana
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=SorianaRemision
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Id, Venta:Venta.ID)<BR>Asigna(Info.Estatus,Venta:Venta.Estatus)
VisibleCondicion=SQL(<T>SELECT TipoAddenda FROM CteCFD WHERE Cliente=:tCte<T>,Venta:Venta.Cliente) = <T>CONSOLIDADO SORIANA<T>

[Detalle.SubRetencion1]
Carpeta=Detalle
Clave=SubRetencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SubRetencion2]
Carpeta=Detalle
Clave=SubRetencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SubRetencion3]
Carpeta=Detalle
Clave=SubRetencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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

[CentrosCostos.ListaEnCaptura]
(Inicio)=Venta.ContUso
Venta.ContUso=Venta.ContUso2
Venta.ContUso2=Venta.ContUso3
Venta.ContUso3=(Fin)

[CentrosCostos.Venta.ContUso]
Carpeta=CentrosCostos
Clave=Venta.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
Activo=S
NombreDesplegar=Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion

[Acciones.MESExplorar]
Nombre=MESExplorar
Boton=106
NombreDesplegar=MES Explorar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
EspacioPrevio=S
Expresion=Asigna(Info.Base,SQL(<T>SELECT DB_NAME()<T>))<BR>Asigna(Info.ABC ,SQL(<T>SELECT ISNULL(SerieMES,:tA) FROM MovTipo WHERE Mov = :tMov<T>,<T><T><T><T>,Venta:Venta.Mov))<BR>Asigna(Info.Anuncio,SQL(<T>SELECT ServidorWEB FROM Version<T>))<BR>Asigna(Info.Mensaje,<T>http://<T>+Info.Anuncio+<T>/Pedidos.aspx?DB=IP<T>+Info.Base+<T>&&NumeroPedido=<T>+Venta:Venta.MovID+<T> &&Serie=<T>+Info.ABC )<BR>Browser( Info.Mensaje,Venta:Venta.Mov+Venta:Venta.MovID,verdadero )
ConCondicion=S
EjecucionCondicion=Venta:Venta.Estatus en ( EstatusPendiente, EstatusConcluido)
VisibleCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.P))

[Emida]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Emida
Clave=Emida
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
CondicionVisible=General.InterfazEmida y(fnSubMovTipo(<T>VTAS<T>, Venta:Venta.Mov) =<T>VTAS.NEMIDA<T>)

[Emida.Venta.RecargaTelefono]
Carpeta=Emida
Clave=Venta.RecargaTelefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Emida.Venta.EmidaControlNo]
Carpeta=Emida
Clave=Venta.EmidaControlNo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco

[Emida.Venta.EmidaResponseCode]
Carpeta=Emida
Clave=Venta.EmidaResponseCode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Emida.Venta.EmidaResponseMessage]
Carpeta=Emida
Clave=Venta.EmidaResponseMessage
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=56x3
ColorFondo=Blanco

[Emida.Venta.EmidaTransactionId]
Carpeta=Emida
Clave=Venta.EmidaTransactionId
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
EspacioPrevio=S

[Emida.Venta.EmidaTransactionDateTime]
Carpeta=Emida
Clave=Venta.EmidaTransactionDateTime
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=25

[Detalle.VentaD.RecargaTelefono]
Carpeta=Detalle
Clave=VentaD.RecargaTelefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.VentaD.RecargaConfirmarTelefono]
Carpeta=Detalle
Clave=VentaD.RecargaConfirmarTelefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Venta.PosicionWMS]
Carpeta=Ficha
Clave=Venta.PosicionWMS
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco

[Emida.ListaEnCaptura]
(Inicio)=Venta.RecargaTelefono
Venta.RecargaTelefono=Venta.EmidaControlNo
Venta.EmidaControlNo=Venta.EmidaCarrierControlNo
Venta.EmidaCarrierControlNo=Venta.EmidaResponseCode
Venta.EmidaResponseCode=Venta.EmidaResponseMessage
Venta.EmidaResponseMessage=Venta.EmidaTransactionId
Venta.EmidaTransactionId=Venta.EmidaTransactionDateTime
Venta.EmidaTransactionDateTime=(Fin)

[Emida.Venta.EmidaCarrierControlNo]
Carpeta=Emida
Clave=Venta.EmidaCarrierControlNo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Detalle.VentaD.POSDesGlobal]
Carpeta=Detalle
Clave=VentaD.POSDesGlobal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaD.POSDesLinea]
Carpeta=Detalle
Clave=VentaD.POSDesLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.LDIMovLog]
Nombre=LDIMovLog
Boton=0
NombreDesplegar=LDI Log
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=LDIMovLog
Activo=S
Antes=S
DespuesGuardar=S
Menu=&Ver
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Modulo,<T>VTAS<T>)<BR>Asigna(Info.ID,Venta:Venta.ID)
VisibleCondicion=General.InterfazLDI  y(SQL(<T>SELECT dbo.fnLDIVentaExiste(:nID,:tModulo)<T>,Venta:Venta.ID,<T>VTAS<T>))

[Cobros.Columnas]
0=92
1=107
2=93
3=97
4=153
5=124
6=-2

[Transacciones.Columnas]
Movimiento=77
FormaPago=96
NoTarjeta=83
BancoEmisor=80
Tarjetahabiente=138
FechaExpiracion=88
CodigoAutorizacion=102
FechaFin=116
Importe=70
Total=64

[Acciones.GenerarCFDI]
Nombre=GenerarCFDI
Boton=127
Menu=&Archivo
NombreDesplegar=Generar CFDI
EnMenu=S
TipoAccion=Expresion
EnBarraHerramientas=S
Visible=S
Expresion=Si<BR> Venta:Venta.Estatus=<T>CANCELADO<T><BR>Entonces<BR> ProcesarSQL(<T>DECLARE @Ok int, @OkRef varchar(255) EXEC spCFDICancelacion :tmodulo, :nID, :tEstatus, :tEmpresa, :nSucursal, @Ok OUTPUT, @OkRef OUTPUT SELECT @OkRef<T>, <T>VTAS<T>, Venta:Venta.ID, Venta:Venta.Estatus, Empresa, Sucursal)<BR>Sino<BR>Si SQL(<T>SELECT ISNULL(eDoc, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, Empresa) y(SQL(<T>SELECT ISNULL(CFDFlex, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Entonces<BR>  ProcesarSQL(<T>EXEC spRegenerarCFDFlex :nEstacion, :tEmpresa, :tModulo, :nID, :tEstatus<T>, EstacionTrabajo, Empresa, <T>VTAS<T>, Venta:Venta.ID, Venta:Venta.Estatus)<BR>Sino<BR>  Si Empresa.CFD y SQL(<T>spVerMovTipoCFD :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID)<BR>  Entonces<BR>    Si(no CFD.Generar(<T>VTAS<T>, Venta:Venta.ID),  Forma.ActualizarForma AbortarOperacion)<BR>    Asigna(Afectar.EnviarCFD, SQL(<T>SELECT EnviarAlAfectar FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>, Empresa))<BR>  Fin<BR>    CFD.Confirmar<BR>    Si(Afectar.EnviarCFD, CFD.Enviar(<T>VTAS<T>, Venta:Venta.ID))<BR>Fin<BR>Fin                  <BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=Si<BR> Venta:Venta.Estatus=<T>CANCELADO<T><BR>Entonces<BR>    falso<BR>Sino<BR>(SQL(<T>EXEC xpMostrarAccion :tEmpresa, :tMov, :tID,:tModulo, :tAccion<T>, Empresa, Venta:Venta.Mov, Venta:Venta.ID,<T>VTAS<T>,<T>GENERARCFDI<T>)) y (SQL(<T>spVerMovTipoCFD :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID))<BR>Fin

[Detalle.VentaD.LDIReferencia]
Carpeta=Detalle
Clave=VentaD.LDIReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Venta.Cliente
Venta.Cliente=Cte.Nombre
Cte.Nombre=Venta.Almacen
Venta.Almacen=Venta.FechaEmision
Venta.FechaEmision=Venta.Importe
Venta.Importe=Venta.Saldo
Venta.Saldo=Dias
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

[Ficha.ListaEnCaptura]
(Inicio)=Venta.Mov
Venta.Mov=Venta.MovID
Venta.MovID=Venta.Proyecto
Venta.Proyecto=Venta.UEN
Venta.UEN=Venta.Moneda
Venta.Moneda=Venta.TipoCambio
Venta.TipoCambio=Venta.ServicioContratoTipo
Venta.ServicioContratoTipo=Venta.FechaEmision
Venta.FechaEmision=Venta.FechaRequerida
Venta.FechaRequerida=Venta.HoraRequerida
Venta.HoraRequerida=Venta.FechaOriginal
Venta.FechaOriginal=Venta.Retencion
Venta.Retencion=Venta.Actividad
Venta.Actividad=Venta.Cliente
Venta.Cliente=Cte.Nombre
Cte.Nombre=Cte.RFC
Cte.RFC=Venta.ListaPreciosEsp
Venta.ListaPreciosEsp=Venta.EnviarA
Venta.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Direccion
CteEnviarA.Direccion=CteEnviarA.Clave
CteEnviarA.Clave=Venta.FormaEnvio
Venta.FormaEnvio=Venta.Agente
Venta.Agente=Venta.Almacen
Venta.Almacen=Venta.TVUnidad
Venta.PosicionWMS=Venta.AlmacenDestino
Venta.AlmacenDestino=Venta.Concepto
Venta.Concepto=Venta.Condicion
Venta.Condicion=Venta.Vencimiento
Venta.Vencimiento=Venta.FormaPagoTipo
Venta.FormaPagoTipo=Venta.Descuento
Venta.Descuento=Venta.DescuentoGlobal
Venta.DescuentoGlobal=Venta.Referencia
Venta.Referencia=Venta.OrdenCompra
Venta.OrdenCompra=Venta.Directo
Venta.Directo=Venta.Ancho
Venta.TVUnidad=Venta.PosicionWMS
Venta.Ancho=Venta.PesoRelativo
Venta.PesoRelativo=(Fin)

[Acciones.PDFIntelisis]
Nombre=PDFIntelisis
Boton=0
NombreDesplegar=Generar PDF
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Menu=&Edici�n
Expresion=Asigna(Info.Mensaje,<T>No es posible generar PDF (revisar ruta y configuraci�n)<T>)<BR>Si SQL(<T>spMovReporteIntelisis :tEmpresa, :tModulo, :tMov, :nID, :nAfectar<T>, Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID, 0) Entonces<BR>    Asigna(Info.Reporte, SQL(<T>spMovFormatoIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa,<T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID))<BR>    Asigna(Info.Ruta, SQL(<T>spMovDirectorioIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID))<BR>    Asigna(Info.Valor,Directorio.Verificar(Info.Ruta,1))<BR>      Asigna(Info.Ruta, SQL(<T>spMovRutaIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID))<BR>      ReportePDF(Info.Reporte,Venta:Venta.ID,Info.Ruta)<BR>      EjecutarSQL(<T>spMovEnviarIntelisis :tEmpresa,:tModulo,:tMov,:nID<T>,Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID)<BR>Asigna(Info.Mensaje,<T>Proceso concluido con �xito<T>)<BR>Fin<BR>Informacion(Info.Mensaje)
VisibleCondicion=SQL(<T>spMovReporteIntelisis :tEmpresa, :tModulo, :tMov, :nID, :nAfectar<T>, Empresa, <T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.ID, 0)

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

[Acciones.CFDICliente]
Nombre=CFDICliente
Boton=0
NombreDesplegar=Especificar Cliente Terceros
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S
Menu=&Edici�n
GuardarAntes=S
Expresion=EjecutarSQL(<T>xpCFDVentaDCopiarCliente :nID<T>,Venta:Venta.ID)<BR>Forma(<T>CFDVentaDCte<T>)
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID,Venta:Venta.ID)

[Acciones.CFDIProveedor]
Nombre=CFDIProveedor
Boton=0
Menu=&Edici�n
NombreDesplegar=Especificar Proveedor Terceros
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Antes=S
Expresion=EjecutarSQL(<T>xpCFDVentaDCopiarProvedor :nID<T>,Venta:Venta.ID)<BR>Forma(<T>CFDVentaDProv<T>)
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID,Venta:Venta.ID)

[Acciones.ContParalelaMovDato]
Nombre=ContParalelaMovDato
Boton=0
Menu=&Edici�n
NombreDesplegar=Datos Contabilidad Paralela
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ContParalelaMovDato
Antes=S
ActivoCondicion=Venta:Venta.Estatus en(EstatusPendiente, EstatusConcluido)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)
VisibleCondicion=fnContParalela y(Usuario.CONTPModificarDatosMov)

[Acciones.OfertaLog]
Nombre=OfertaLog
Boton=0
Menu=&Ver
EsDefault=S
NombreDesplegar=Log de Ofertas
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=OfertaLog
Antes=S
ActivoCondicion=SQL(<T>SELECT OfertaAplicaLog FROM EmpresaCFG2 WHERE Empresa = :tEmpresa<T>,Empresa)
AntesExpresiones=Asigna(Info.ID,Venta:Venta.ID)<BR>Asigna(Info.Mov,Venta:Venta.Mov)<BR>Asigna(Info.MovID,Venta:Venta.MovID)
VisibleCondicion=SQL(<T>SELECT Ofer FROM EmpresaGral WHERE Empresa = :tEmpresa<T>,Empresa)

[Acciones.RecalcularPrecios]
Nombre=RecalcularPrecios
Boton=92
Menu=&Archivo
NombreDesplegar=Recal. Precios y % de Utilidad
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
EnMenu=S
Visible=S
ListaAccionesMultiples=(Lista)
ActivoCondicion=((fnSubMovTipo(<T>VTAS<T>, Venta:Venta.Mov)en(<T>VTAS<T>,<T>VTAS.PE<T>)) y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.C)))

[Detalle.VentaD.PorcentajeUtilidad]
Carpeta=Detalle
Clave=VentaD.PorcentajeUtilidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
Efectos=[Negritas]

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
(Inicio)=VentaD.Aplica
VentaD.Aplica=VentaD.AplicaID
VentaD.AplicaID=AplicaNombre
AplicaNombre=VentaD.Codigo
VentaD.Codigo=VentaD.Articulo
VentaD.Articulo=VentaD.SubCuenta
VentaD.SubCuenta=ClaveIdioma
ClaveIdioma=VentaD.SustitutoArticulo
VentaD.SustitutoArticulo=VentaD.SustitutoSubCuenta
VentaD.SustitutoSubCuenta=VentaD.Espacio
VentaD.Espacio=VentaD.Cantidad
VentaD.Cantidad=CantidadNeta
CantidadNeta=PesoTotal
PesoTotal=VolumenTotal
VolumenTotal=VentaD.Unidad
VentaD.Unidad=VentaD.CantidadInventario
VentaD.CantidadInventario=CantidadInvNeta
CantidadInvNeta=Art.Horas
Art.Horas=VentaD.Precio
VentaD.Precio=VentaD.PorcentajeUtilidad
VentaD.PorcentajeUtilidad=VentaD.DescuentoLinea
VentaD.DescuentoLinea=VentaD.DescuentoImporte
VentaD.DescuentoImporte=VentaD.PrecioMoneda
VentaD.PrecioMoneda=VentaD.PrecioTipoCambio
VentaD.PrecioTipoCambio=VentaD.FechaRequerida
VentaD.FechaRequerida=VentaD.HoraRequerida
VentaD.HoraRequerida=VentaD.Instruccion
VentaD.Instruccion=VentaD.ExcluirPlaneacion
VentaD.ExcluirPlaneacion=Importe
Importe=VentaD.PresupuestoEsp
VentaD.PresupuestoEsp=VentaD.ExcluirISAN
VentaD.ExcluirISAN=VentaD.TipoImpuesto1
VentaD.TipoImpuesto1=VentaD.Impuesto1
VentaD.Impuesto1=SubImpuesto1
SubImpuesto1=VentaD.TipoImpuesto2
VentaD.TipoImpuesto2=VentaD.Impuesto2
VentaD.Impuesto2=SubImpuesto2
SubImpuesto2=VentaD.TipoImpuesto3
VentaD.TipoImpuesto3=VentaD.Impuesto3
VentaD.Impuesto3=SubImpuesto3
SubImpuesto3=VentaD.TipoRetencion1
VentaD.TipoRetencion1=VentaD.Retencion1
VentaD.Retencion1=SubRetencion1
SubRetencion1=VentaD.TipoRetencion2
VentaD.TipoRetencion2=VentaD.Retencion2
VentaD.Retencion2=SubRetencion2
SubRetencion2=VentaD.TipoRetencion3
VentaD.TipoRetencion3=VentaD.Retencion3
VentaD.Retencion3=SubRetencion3
SubRetencion3=VentaD.EnviarA
VentaD.EnviarA=VentaD.Almacen
VentaD.Almacen=VentaD.Posicion
VentaD.Posicion=VentaD.Tarima
VentaD.Tarima=VentaD.ContUso
VentaD.ContUso=VentaD.ContUso2
VentaD.ContUso2=VentaD.ContUso3
VentaD.ContUso3=VentaD.ABC
VentaD.ABC=VentaD.Agente
VentaD.Agente=VentaD.AgentesAsignados
VentaD.AgentesAsignados=VentaD.ProveedorRef
VentaD.ProveedorRef=VentaD.AFArticulo
VentaD.AFArticulo=VentaD.AFSerie
VentaD.AFSerie=VentaD.Costo
VentaD.Costo=CostoTotal
CostoTotal=VentaD.Paquete
VentaD.Paquete=VentaD.AutoLocalidad
VentaD.AutoLocalidad=VentaD.UEN
VentaD.UEN=VentaD.DescripcionExtra
VentaD.DescripcionExtra=VentaD.CantidadReservada
VentaD.CantidadReservada=VentaD.CantidadOrdenada
VentaD.CantidadOrdenada=VentaD.CantidadPendiente
VentaD.CantidadPendiente=VentaD.ServicioNumero
VentaD.ServicioNumero=VentaD.Estado
VentaD.Estado=VentaD.CantidadA
VentaD.CantidadA=VentaD.TransferirA
VentaD.TransferirA=VentaD.Establecimiento
VentaD.Establecimiento=VentaD.PuntoEmision
VentaD.PuntoEmision=VentaD.SecuencialSRI
VentaD.SecuencialSRI=VentaD.AutorizacionSRI
VentaD.AutorizacionSRI=VentaD.VigenteA
VentaD.VigenteA=VentaD.POSDesGlobal
VentaD.POSDesGlobal=VentaD.POSDesLinea
VentaD.POSDesLinea=VentaD.RecargaTelefono
VentaD.RecargaTelefono=VentaD.RecargaConfirmarTelefono
VentaD.RecargaConfirmarTelefono=VentaD.LDIReferencia
VentaD.LDIReferencia=VentaD.Cantidad2
VentaD.Cantidad2=VentaD.Unidad2
VentaD.Unidad2=VentaD.Inventario2
VentaD.Inventario2=VentaD.CHPrecio2
VentaD.TelaEtiqueta=VentaD.ColorEtiqueta
VentaD.ColorEtiqueta=VentaD.Quality
VentaD.Quality=VentaD.Pattern
VentaD.Pattern=VentaD.ColorNo
VentaD.ColorNo=VentaD.Variante
VentaD.Variante=(Fin)
VentaD.CHPrecio2=VentaD.TelaEtiqueta

[Detalle.ListaCamposAValidar]
(Inicio)=DescripcionIdioma
DescripcionIdioma=OpcionDesc
OpcionDesc=Art.Unidad
Art.Unidad=Art.Tipo
Art.Tipo=Art.PrecioLista
Art.PrecioLista=Art.PrecioMinimo
Art.PrecioMinimo=(Fin)

[Detalle.ListaAcciones]
(Inicio)=CopiarPendiente
CopiarPendiente=Observaciones
Observaciones=VerPoliticaDetalle
VerPoliticaDetalle=DesglosarCantidadOrdenada
DesglosarCantidadOrdenada=VerOpciones
VerOpciones=AutoBoleto
AutoBoleto=ExcluirISAN
ExcluirISAN=VentaDWeb
VentaDWeb=(Fin)

[Acciones.RecalcularPrecios.Forma]
Nombre=Forma
Boton=0
TipoAccion=Formas
ClaveAccion=VentaCalcularPropEconomica
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=(ConDatos(Info.ID) y ConDatos(Info.Renglon))
EjecucionMensaje=<T>No hay nada que Asignar<T>
EjecucionConError=S

[Acciones.RecalcularPrecios.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Renglon, VentaD:VentaD.Renglon)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)

[Acciones.RecalcularPrecios.Variables]
Nombre=Variables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RecalcularPrecios.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Variables
Variables=Forma
Forma=(Fin)

[Ficha.Venta.TVUnidad]
Carpeta=Ficha
Clave=Venta.TVUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=$00B9FFFF
Pegado=S

[Detalle.VentaD.Cantidad2]
Carpeta=Detalle
Clave=VentaD.Cantidad2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VentaD.Unidad2]
Carpeta=Detalle
Clave=VentaD.Unidad2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.VentaD.Inventario2]
Carpeta=Detalle
Clave=VentaD.Inventario2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Venta.Ancho]
Carpeta=Ficha
Clave=Venta.Ancho
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Venta.PesoRelativo]
Carpeta=Ficha
Clave=Venta.PesoRelativo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaD.TelaEtiqueta]
Carpeta=Detalle
Clave=VentaD.TelaEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Detalle.VentaD.ColorEtiqueta]
Carpeta=Detalle
Clave=VentaD.ColorEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Detalle.VentaD.Quality]
Carpeta=Detalle
Clave=VentaD.Quality
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.VentaD.Pattern]
Carpeta=Detalle
Clave=VentaD.Pattern
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.VentaD.ColorNo]
Carpeta=Detalle
Clave=VentaD.ColorNo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.VentaD.Variante]
Carpeta=Detalle
Clave=VentaD.Variante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[Detalle.VentaD.CHPrecio2]
Carpeta=Detalle
Clave=VentaD.CHPrecio2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CFDVentaDCte.Columnas]
Articulo=154
Cliente=159

















































[Inicia.Columnas]
Material=124
CantMat=64
UnidadMat=79
Almacen=72
LoteAux=99
PedimentoAux=187
VentaUnidad=68
Pendiente=64
Aplicar=64






















































































































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Oportunidad
Oportunidad=Competidores
Competidores=AC
AC=OC
OC=Contrato
Contrato=Corrida
Corrida=Gasto
Gasto=Servicio
Servicio=Notas
Notas=Comentarios
Comentarios=Detalle
Detalle=FormaAnexo
FormaAnexo=MovEvento
MovEvento=FormaExtraValor
FormaExtraValor=CentrosCostos
CentrosCostos=MovImpuesto
MovImpuesto=Agrupadores
Agrupadores=Anexo
Anexo=VentaFlexibleD
VentaFlexibleD=Emida
Emida=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=CopiarLote
CopiarLote=CopiarMeses
CopiarMeses=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=Actualizar
Actualizar=ActualizarPrecios
ActualizarPrecios=MovPersonal
MovPersonal=Evaluaciones
Evaluaciones=Propiedades
Propiedades=Imprimir
Imprimir=RepPantalla
RepPantalla=PlantillasOffice
PlantillasOffice=FormasAnexas
FormasAnexas=Excel
Excel=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Afectar
Afectar=Autorizar
Autorizar=FEA
FEA=Desafectar
Desafectar=Consecutivo
Consecutivo=GenerarCFDI
GenerarCFDI=ModificarAlmacen
ModificarAlmacen=Eliminar
Eliminar=Importar
Importar=ImportarPDT
ImportarPDT=Cancelar
Cancelar=Refacturar
Refacturar=ReasignarUsuario
ReasignarUsuario=ActualizarPoliticasPrecios
ActualizarPoliticasPrecios=ActualizarPrecioMoneda
ActualizarPrecioMoneda=Cambiar Vista Hoja
Cambiar Vista Hoja=CopiarPendientes
CopiarPendientes=CopiarOtros
CopiarOtros=CopiarComentario
CopiarComentario=Embarcar
Embarcar=SubMovimiento
SubMovimiento=AnexarMov
AnexarMov=Campos
Campos=CamposExtras
CamposExtras=DatosEntrega
DatosEntrega=Cobro
Cobro=Totalizar
Totalizar=DescuentoGlobal
DescuentoGlobal=Accesorios
Accesorios=ServicioMatriz
ServicioMatriz=Asistente Articulos
Asistente Articulos=Asistente Codigo Barras
Asistente Codigo Barras=Asistente Codigo Barras (Lote)
Asistente Codigo Barras (Lote)=Entarimar
Entarimar=SurtirTarima
SurtirTarima=Actividades
Actividades=MovActividad
MovActividad=SeriesLotes
SeriesLotes=Sustitutos
Sustitutos=Precio
Precio=PrecioConImpuestos
PrecioConImpuestos=ProrrateoFecha
ProrrateoFecha=ServicioTipoPlantilla
ServicioTipoPlantilla=AnticiposFacturados
AnticiposFacturados=Anexos
Anexos=AnexosDetalle
AnexosDetalle=AgregarEvento
AgregarEvento=Anticipos
Anticipos=TraspasarArticulos
TraspasarArticulos=Tareas
Tareas=Embarque
Embarque=Incentivo
Incentivo=Participacion
Participacion=CteExpress
CteExpress=EditarCliente
EditarCliente=CteEnviarA
CteEnviarA=ArtExpress
ArtExpress=VINExpress
VINExpress=EditarVIN
EditarVIN=VentaOtros
VentaOtros=PresupuestoEsp
PresupuestoEsp=Anterior
Anterior=Siguiente
Siguiente=Catalogos
Catalogos=ArtListaDisponible
ArtListaDisponible=Disponible
Disponible=ArtInfo
ArtInfo=EspacioInfo
EspacioInfo=CteInfo
CteInfo=ProyInfo
ProyInfo=ServicioHist
ServicioHist=VINComponentes
VINComponentes=VentaDReservados
VentaDReservados=ArtAccesorioBuscar
ArtAccesorioBuscar=ArtRefaccionBuscar
ArtRefaccionBuscar=VerPoliticaPrecios
VerPoliticaPrecios=TiempoEntregaSugerido
TiempoEntregaSugerido=Asistente Precios
Asistente Precios=MovImpuesto
MovImpuesto=Boletos
Boletos=BoletosVendidos
BoletosVendidos=Resumen
Resumen=FordOasis
FordOasis=AsesoresDisponible
AsesoresDisponible=Tiempo
Tiempo=VerComentarios
VerComentarios=Politica
Politica=PoliticaConcepto
PoliticaConcepto=Mapa
Mapa=OfertaLog
OfertaLog=MovBitacora
MovBitacora=PedidoPos
PedidoPos=TablaAmortizacion
TablaAmortizacion=RentabilidadContrato
RentabilidadContrato=MovPos
MovPos=MESExplorar
MESExplorar=RecalcularPrecios
RecalcularPrecios=Navegador
Navegador=Cerrar
Cerrar=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=SorianaRemision
SorianaRemision=LDIMovLog
LDIMovLog=PDFIntelisis
PDFIntelisis=CFDICliente
CFDICliente=CFDIProveedor
CFDIProveedor=ContParalelaMovDato
ContParalelaMovDato=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edici�n
&Edici�n=&Ver
&Ver=&Otros
&Otros=(Fin)