[Forma]
Clave=VentaTouchScreen
Nombre=Ventas Mostrador
Icono=0
Modulos=VTAS
ListaCarpetas=(Lista)
CarpetaPrincipal=Movimiento
PosicionInicialIzquierda=469
PosicionInicialArriba=298
PosicionInicialAltura=443
PosicionInicialAncho=982
EsMovimiento=S
TituloAuto=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=12
DialogoAbrir=S
Totalizadores=S
PosicionSeccion2=90
Menus=S
BarraAyuda=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
MovModulo=VTAS
BarraAyudaBold=S
MovEspecificos=Todos
AutoGuardarEncabezado=S
IniciarAgregando=S
PosicionColumna1=52
PosicionInicialAlturaCliente=568
PosicionSec1=42
PosicionSec2=442
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Positivos, Verdadero)
PosicionCol1=400
PosicionCol2=622
MenuTouchScreen=S
MenuTouchScreenMostrarTeclasFuncion=S
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
Zona=B1
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
ColorFuente=Negro

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=47
ColorFondo=Plata
Efectos=[Negritas]
LineaNueva=N
ValidaNombre=N
Pegado=N
ColorFuente=Negro

[Ficha.Venta.Agente]
Carpeta=Ficha
Clave=Venta.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
Editar=S
3D=S
Tamano=47
ColorFondo=Plata
LineaNueva=N
ValidaNombre=N
ColorFuente=Negro

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
Tamano=80
EspacioPrevio=N

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
Fuente={MS Sans Serif, 10, Negro, []}
VistaMaestra=Venta
LlaveLocal=VentaD.ID
LlaveMaestra=Venta.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaOrden=(Lista)
CarpetaVisible=S
ControlRenglon=S
CampoRenglon=VentaD.Renglon
ControlRenglonID=S
ControlRenglonTipo=S
HojaColoresPorTipo=S
CampoDespliegaTipo=Art.Tipo
ListaEnCaptura=(Lista)
MenuLocal=S
HojaFondoGrisAuto=S
PermiteLocalizar=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
ConFuenteEspecial=S
ListaAcciones=(Lista)
CampoDespliegaTipoOpcion=Art.TipoOpcion

[Detalle.VentaD.Articulo]
Carpeta=Detalle
Clave=VentaD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.Cantidad]
Carpeta=Detalle
Clave=VentaD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.Precio]
Carpeta=Detalle
Clave=VentaD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
IgnoraFlujo=S
ColorFondo=Blanco
ColorFuente=Negro

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
ColorFuente=Negro

[Detalle.Columnas]
Articulo=116
SubCuenta=87
Cantidad=55
Disponible=55
Precio=87
DescTipo=29
Descuento=35
Importe=101
CantidadReservada=57
CantidadPendiente=53
CantidadA=49
DescuentoLinea=34
DescuentoTipo=28
Costo=75
CostoTotal=77
Aplica=73
AplicaID=64
CantidadCancelada=58
CantidadOrdenada=52
CantidadNeta=47
Descripcion1=184
Unidad=55
CantidadInventario=52
Almacen=49

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
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Movimiento
IconosConPaginas=S
ElementosPorPagina=200
IconosEstiloFijo=S
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
BusquedaRespetarControlesNum=S
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
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
MenuLocal=S
ListaAcciones=MovPropiedades
FiltroFechasCancelacion=Venta.FechaCancelacion
IconosNombre=VentaA:Venta.Mov+<T> <T>+VentaA:Venta.MovID

[(Carpeta Abrir).Venta.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Venta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Venta.Cliente]
Carpeta=(Carpeta Abrir)
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=144
1=83

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
Totalizadores1=Importe<BR>Desc<BR>Sub total<BR>Impuestos<BR>Total<BR>Conteo<BR>Sobre Precio
Totalizadores2=Suma(VentaD:Importe)<BR>-Suma(VentaD:DescGlobal)<BR>Suma(VentaD:SubTotal)<BR>Suma(VentaD:Impuesto)<BR>Redondea(Suma(VentaD:ImporteTotal), Config.VentaCobroRedondeoDecimales)-Venta:Venta.AnticiposFacturados-Venta:Venta.Retencion<BR>Conteo(VentaD:VentaD.Articulo)<BR>Suma(VentaD:ImporteSobrePrecio)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)
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
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
TeclaFuncion=F11

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=
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
EnBarraHerramientas=
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=S
Activo=S
Antes=S
AntesExpresiones=Asigna(Venta:Venta.Importe, Suma(VentaD:Importe))<BR>Asigna(Venta:Venta.Impuestos, Suma(VentaD:Impuesto))

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
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
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
ListaParametros1=VentaD:VentaD.Articulo<BR>Venta:Venta.Almacen<BR>VentaD:VentaD.SubCuenta<BR>VentaD:VentaD.Cantidad<BR>VentaD:VentaD.Precio<BR>MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.D,VTAS.DF,VTAS.B,VTAS.DC,VTAS.DCR))<BR>Nulo<BR>MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F, VTAS.FAR,VTAS.FB,VTAS.R,VTAS.SG,VTAS.EG,VTAS.VC,VTAS.VCR))<BR>MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.P,VTAS.N,VTAS.NO,VTAS.NR))<BR>VentaD:Art.Descripcion1<BR>VentaD:Art.Tipo<BR>VentaD:Art.Unidad<BR>VentaD:Art.PrecioLista<BR>VentaD:Art.TipoOpcion<BR>VentaD:Art.Espacios<BR>VentaD:VentaD.FechaRequerida<BR>VentaD:VentaD.HoraRequerida<BR>VentaD:VentaD.Espacio<BR><T>VTAS<T><BR>Venta:Venta.ID<BR>Venta:Venta.Cliente
ListaParametros=S
Visible=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
EspacioPrevio=S
ActivoCondicion=Venta:Venta.Estatus=EstatusSinAfectar

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
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Ultimo
Visible=S
Activo=
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=<T>A&fectar<T>
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
MultipleConOpciones=
ConCondicion=S
Antes=S
TeclaFuncion=F12
Expresion=Si<BR>  (Venta:Venta.Mov=Info.MovProcesar) y (Venta:Venta.Estatus=EstatusSinAfectar)<BR>Entonces<BR>  EjecutarSQL(<T>xpVentaAutoProcesar :nID<T>, Venta:Venta.ID) <BR>Sino<BR>  Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>  Asigna(Afectar.ID, Venta:Venta.ID)<BR>  Asigna(Afectar.Mov, Venta:Venta.Mov)<BR>  Asigna(Afectar.MovID, Venta:Venta.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>  Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, Venta:Venta.Mov))<BR>  Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>  Asigna(Info.Moneda, Venta:Venta.Moneda)<BR>  Asigna(Info.TipoCambio, Venta:Venta.TipoCambio)<BR>  Asigna(Info.Importe, Redondea(Suma(VentaD:Importe)+Suma(VentaD:Impuesto)-Suma(VentaD:DescGlobal)+Suma(VentaD:ImporteSobrePrecio)-(Venta:Venta.AnticiposFacturados+Venta:Venta.Retencion), Config.VentaCobroRedondeoDecimales))<BR>  Si <BR>    (Info.Importe<>0) y<BR>    (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y<BR>    ((MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.N, VTAS.FM)) y (ConDatos(Venta:Venta.MovID) o Config.VentaLiquidaIntegral) y (Venta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>)) o<BR>    (MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.S, VTAS.P, VTAS.VP, VTAS.SD, VTAS.B))  y (Venta:Condicion.ControlAnticipos=<T>Cobrar Pedido<T>)) o<BR>    (MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F, VTAS.FAR, VTAS.FB, VTAS.D, VTAS.DF)) y (Venta:Venta.Vencimiento<=Venta:Venta.FechaEmision) y Config.FacturaCobroIntegrado y (Venta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>) y (Venta:Venta.OrigenTipo<><T>VMOS<T>)))<BR>  Entonces<BR>    Asigna(Info.ID, Venta:Venta.ID)<BR>    Asigna(Info.Cerrado, Falso)<BR>    Asigna(Info.VentaCobroDevolucion, MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.VP, VTAS.SD, VTAS.B, VTAS.D, VTAS.DF)))<BR>    Forma(<T>VentaCobro<T>)<BR>  Sino<BR>    Si <BR>      (Venta:Venta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) o ((MovTipo(<T>VTAS<T>,Venta:Venta.Mov)=VTAS.S) y (Venta:Venta.Estatus=EstatusPorConfirmar))<BR>    Entonces<BR>      Si(Config.CompraVentaSinIVA y (Suma(VentaD:Impuesto)=0.0) y (Suma(VentaD:Importe)>0.0), Si(Confirmacion(<T>Movimiento sin Impuestos<T>+NuevaLinea+<T>¿ Es Correcto ?<T>,BotonSi,BotonNo)=BotonNo,AbortarOperacion))<BR>      Si<BR>        Venta:Venta.Estatus=EstatusPorConfirmar       <BR>      Entonces<BR>        Caso MovTipo(<T>VTAS<T>, Venta:Venta.Mov)<BR>          Es VTAS.S  Entonces Dialogo(<T>GenerarServicioPorConfirmar<T>)<BR>          Es VTAS.CS Entonces Dialogo(<T>GenerarCotizacionServicio<T>)<BR>          Es VTAS.C  Entonces <BR>                     Si (Venta:Venta.OrigenTipo=<T>VTAS<T>) y (MovTipo(<T>VTAS<T>, Venta:Venta.Origen)=VTAS.S)<BR>                       Entonces<BR>                         Asigna(Afectar.Mov, Venta:Venta.Origen)<BR>                         Asigna(Afectar.MovID, Venta:Venta.OrigenID)<BR>                         Asigna(Afectar.ID, SQL(<T>SELECT ID FROM Venta WHERE Empresa = :tEmpresa AND Mov = :tMov AND MovID = :tMovID AND Estatus NOT IN (<T>+Comillas(EstatusSinAfectar)+<T>, <T>+Comillas(EstatusCancelado)+<T>)<T>, Empresa, Afectar.Mov, Afectar.MovID))<BR>                         Dialogo(<T>AfectarServicio<T>)<BR>                       Sino<BR>                         Dialogo(<T>GenerarCotizacion<T>)<BR>                     Fin<BR>          Es VTAS.CO Entonces Dialogo(<T>GenerarContrato<T>)<BR>          Sino Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>        Fin<BR>      Sino<BR>        Si <BR>          Config.Partidas y (MovTipo(<T>VTAS<T>, Venta:Venta.Mov)=VTAS.R)<BR>        Entonces<BR>          Forma(<T>AfectarPartidasRemision<T>)<BR>        Sino<BR>          Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>        Fin<BR>      Fin<BR>    Sino<BR>      Asigna(Afectar.Base, <T>Pendiente<T>)<BR>      Asigna(Afectar.GenerarMov, <T><T>)<BR>      Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>      Caso MovTipo(<T>VTAS<T>, Venta:Venta.Mov)<BR>        Es VTAS.P   Entonces Dialogo(Info.Dialogo)<BR>        Es VTAS.S   Entonces Dialogo(<T>GenerarServicio<T>) <BR>        Es VTAS.R   Entonces Dialogo(<T>GenerarRemision<T>) <BR>        Es VTAS.VCR Entonces Dialogo(<T>GenerarRemisionConsignacion<T>)<BR>        Es VTAS.VC  Entonces Dialogo(<T>GenerarVentaConsignacion<T>)<BR>        Es VTAS.F   Entonces Dialogo(<T>GenerarFactura<T>)<BR>        Es VTAS.FAR Entonces Dialogo(<T>GenerarFactura<T>)<BR>        Es VTAS.FB  Entonces Dialogo(<T>GenerarFactura<T>)<BR>        Es VTAS.FR  Entonces Dialogo(<T>GenerarFacturaRecurrente<T>)<BR>        Es VTAS.SD  Entonces Dialogo(<T>GenerarSolicitudDevolucion<T>)<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Venta:Venta.Usuario) y (Venta:Venta.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusPendiente))
EjecucionCondicion=ConDatos(Venta:Venta.Mov)
AntesExpresiones=Asigna(Info.MovProcesar, ConfigMov.AutoRecaudacion)<BR>Si(General.AdvertirProyectosExpirados, Si(SQL(<T>SELECT COUNT(*) FROM Proy WHERE (Estatus = :tBaja OR FechaFin+1<GETDATE()) AND Proyecto=:tProy<T>, EstatusBaja, Venta:Venta.Proyecto) > 0, Si(Precaucion(<T>Proyecto Expirado<T>, BotonAceptar, BotonCancelar)=BotonCancelar, AbortarOperacion)))<BR>Si<BR>  MovTipo(<T>VTAS<T>, Venta:Venta.Mov)=VTAS.P<BR>Entonces<BR>  Caso Venta:Venta.Mov<BR>    Es ConfigMov.VentaReservacion Entonces Asigna(Info.Dialogo, <T>GenerarReservacion<T>)<BR>    Es ConfigMov.VentaIngreso Entonces Asigna(Info.Dialogo, <T>GenerarVentaIngreso<T>)<BR>  Sino<BR>    Asigna(Info.Dialogo, <T>GenerarPedido<T>)<BR>  Fin<BR>Fin

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnMenu=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S
Antes=S
GuardarAntes=S
Expresion=Si <BR>  (Venta:Venta.Estatus=EstatusPendiente) y MovTipoEn(<T>VTAS<T>,Venta:Venta.Mov,(VTAS.P,VTAS.S))<BR>Entonces<BR>  Asigna(Info.TituloDialogo, <T>Cancelar: <T>+Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Dialogo(<T>CancelarVentaPendiente<T>)<BR>Sino<BR>  Si<BR>    Asigna(Temp.Texto, <T><T>)<BR>    Si <BR>      Config.CancelarFactura<><T>No<T><BR>    Entonces<BR>      Asigna(Temp.Fecha, SQL(<T>SELECT GETDATE()<T>))<BR>      Si<BR>        Info.MovTipo en (VTAS.F, VTAS.FAR)<BR>      Entonces<BR>        Si             <BR>          (Mes(Temp.Fecha) > Mes(Venta:Venta.FechaEmision)) o (Año(Temp.Fecha) > Año(Venta:Venta.FechaEmision)) o ((Config.CancelarFactura=<T>Cambio Dia<T>) y (Dia(Temp.Fecha) > Dia(Venta:Venta.FechaEmision)))<BR>        Entonces<BR>          Asigna(Temp.Texto, <T>Nota: Esta Cancelación va a Generar un Movimiento Contrario.<T>+NuevaLinea+NuevaLinea+NuevaLinea+NuevaLinea+NuevaLinea+NuevaLinea)<BR>        Fin<BR>      Fin<BR>    Fin<BR>    Precaucion(Temp.Texto+<T>¿ Esta seguro que desea cancelar el movimiento ?<T>+NuevaLinea+NuevaLinea+Afectar.Mov+<T> <T>+Afectar.MovID, BotonSi, BotonNo ) = BotonSi<BR> Entonces<BR>    Cancelar(<T>VTAS<T>, Venta:Venta.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>  Fin<BR>Fin
ActivoCondicion=Si<BR>  PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Venta:Venta.Usuario) y ConDatos(Venta:Venta.ID) y ConDatos(Venta:Venta.MovID) y (Vacio(Venta:Venta.CancelacionID) o (MovTipo(<T>VTAS<T>, Venta:Venta.Mov) en (VTAS.D,VTAS.DF,VTAS.B)))<BR>Entonces<BR>  Si<BR>    MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.C,VTAS.CS,VTAS.R,VTAS.P,VTAS.S,VTAS.VC,VTAS.VCR,VTAS.SD))<BR>  Entonces<BR>    Venta:Venta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusPorConfirmar)<BR>  Sino<BR>    Venta:Venta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusProcesar, EstatusRecurrente) o ((Venta:Venta.Estatus=EstatusConcluido) y (MovTipo(<T>VTAS<T>, Venta:Venta.Mov) noen (VTAS.N, VTAS.FM)))<BR>  Fin<BR>Sino<BR>  Falso<BR>Fin
AntesExpresiones=Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, Venta:Venta.ID)<BR>Asigna(Afectar.Mov, Venta:Venta.Mov) <BR>Asigna(Afectar.MovID, Venta:Venta.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>VentaMostrador<T>)

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
ConCondicion=
ActivoCondicion=Vacio(Venta:Venta.MovID) y (Venta:Venta.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Venta:Venta.Usuario)

[Detalle.ColumnasResumen]
Articulo=143
Descripcion1=184
Cantidad=62
Precio=100
DescTipo=27
Descuento=43
Importe=109
Descripcion=258
DescuentoLinea=33
DescuentoTipo=25

[(Carpeta Totalizadores).Sub total]
Carpeta=(Carpeta Totalizadores)
Clave=Sub total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata
Pegado=S
ColorFuente=Negro

[(Carpeta Totalizadores).Impuestos]
Carpeta=(Carpeta Totalizadores)
Clave=Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
Pegado=S
ColorFuente=Negro

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
ColorFuente=Negro

[(Carpeta Abrir).ImporteTotal]
Carpeta=(Carpeta Abrir)
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Venta.FechaRequerida]
Carpeta=(Carpeta Abrir)
Clave=Venta.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Catalogos]
Nombre=Catalogos
Boton=48
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=
NombreDesplegar=&Catálogos
EnBarraHerramientas=
EnMenu=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Catalogos Articulos
ListaParametros1=VentaD:VentaD.Articulo<BR>Venta:Venta.Almacen<BR>VentaD:VentaD.Cantidad
ListaParametros=S
Activo=
Visible=S
ActivoCondicion=Venta:Venta.Estatus=EstatusSinAfectar

[Detalle.VentaD.DescuentoTipo]
Carpeta=Detalle
Clave=VentaD.DescuentoTipo
Editar=S
IgnoraFlujo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.DescuentoLinea]
Carpeta=Detalle
Clave=VentaD.DescuentoLinea
Editar=S
IgnoraFlujo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Disponible]
Nombre=Disponible
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Disponible del Artículo
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna( Info.Origen, <T>VTAS<T>)<BR>Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)<BR>Asigna(Info.ArtTipo, VentaD:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, VentaD:Art.TipoOpcion)<BR>Asigna(Info.Almacen, Venta:Venta.Almacen)<BR>Forma(<T>ArtAlmExistencia<T>)
EjecucionCondicion=ConDatos( VentaD:VentaD.Articulo)

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+I
NombreDesplegar=Información del &Artículo
EnBarraHerramientas=
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=
EjecucionCondicion=ConDatos( VentaD:VentaD.Articulo)
AntesExpresiones=Asigna( Info.Origen, <T>VTAS<T>)<BR>Asigna( Info.Articulo, VentaD:VentaD.Articulo )<BR>Asigna( Info.ArtTipo, VentaD:Art.Tipo)

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
Menu=&Ver
NombreDesplegar=Información del &Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteInfo
ActivoCondicion=Usuario.CteInfo
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EnBarraHerramientas=
EspacioPrevio=
ConCondicion=S
EjecucionCondicion=ConDatos(Venta:Venta.Cliente)
AntesExpresiones=Asigna(Info.Origen, <T>VTAS<T>)<BR>Asigna( Info.Cliente,Venta:Venta.Cliente )

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
Expresion=ReporteImpresora(ReporteMovImpresora(<T>VTAS<T>,Venta:Venta.Mov), Venta:Venta.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.Asistente Precios]
Nombre=Asistente Precios
Boton=0
NombreDesplegar=Asistente Precios
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Precios
ListaParametros1=VentaD:VentaD.Articulo<BR>VentaD:VentaD.SubCuenta<BR>VentaD:Art.Grupo<BR>VentaD:Art.Categoria<BR>VentaD:Art.Familia<BR>VentaD:Art.ABC<BR>VentaD:Art.Fabricante<BR>VentaD:Art.Linea<BR>VentaD:Art.Rama<BR>Venta:Venta.Cliente<BR>Venta:Cte.Grupo<BR>Venta:Cte.Categoria<BR>Venta:Cte.Familia<BR>Venta:Cte.Zona<BR>Venta:Venta.Moneda<BR>Venta:Venta.Condicion<BR>VentaD:VentaD.Almacen<BR>Venta:Venta.Proyecto<BR>Venta:Venta.Agente<BR>Venta:Venta.FormaEnvio<BR>Venta:Venta.Mov<BR>Venta:Venta.ServicioTipo<BR>Venta:Venta.ServicioContratoTipo<BR>VentaD:VentaD.Unidad<BR>Venta:Venta.Empresa<BR>VentaD:VentaD.Cantidad<BR>VentaD:VentaD.Unidad<BR>VentaD:Art.PrecioLista<BR>VentaD:Art.MonedaPrecio<BR>Venta:Venta.TipoCambio<BR>VentaD:VentaD.DescuentoTipo<BR>VentaD:VentaD.DescuentoLinea<BR>Venta:Venta.ListaPreciosEsp<BR>VentaD:Art.Precio2<BR>VentaD:Art.Precio3<BR>VentaD:Art.Precio4<BR>VentaD:Art.Precio5<BR>VentaD:Art.Precio6<BR>VentaD:Art.Precio7<BR>VentaD:Art.Precio8<BR>VentaD:Art.Precio9<BR>VentaD:Art.Precio10<BR>VentaD:VentaD.Precio<BR>VentaD:VentaD.PoliticaPrecios<BR>VentaD:VentaD.PrecioMoneda<BR>VentaD:VentaD.PrecioTipoCambio<BR>Venta:CteEnviarA.Grupo<BR>Venta:CteEnviarA.Categoria<BR>Venta:CteEnviarA.Familia
ListaParametros=S
Activo=S
Visible=S

[Acciones.ActualizarPoliticasPrecios]
Nombre=ActualizarPoliticasPrecios
Boton=0
Menu=&Archivo
NombreDesplegar=&Actualizar Politicas de Precios
EnMenu=S
TipoAccion=Otros
ClaveAccion=Actualizar Politicas Precios y Descuentos
Activo=S
Visible=S
EspacioPrevio=S

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
AntesExpresiones=Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)<BR>Asigna(Info.Mensaje, VentaD:VentaD.PoliticaPrecios)

[Notas.Venta.Prioridad]
Carpeta=Notas
Clave=Venta.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=S
EspacioPrevio=S

[Acciones.Asistente Codigo Barras]
Nombre=Asistente Codigo Barras
Boton=13
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Shift+F7
NombreDesplegar=Asistente Codigos de Barras
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
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=Asistente Codigos de Barras (en Lote)
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Codigo Barras (Lote)
ListaParametros=S
ListaParametros1=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)<BR>Venta:Venta.Estatus=EstatusPendiente<BR>VentaD:VentaD.Cantidad<BR>VentaD:VentaD.CantidadPendiente<BR>VentaD:VentaD.CantidadReservada<BR>VentaD:VentaD.CantidadA<BR>VentaD:VentaD.SubCuenta<BR>VentaD:VentaD.Unidad<BR>VentaD:VentaD.Articulo<BR>Venta:Venta.Cliente<BR>Venta:Venta.Agente<BR>Venta:Venta.Almacen<BR>Nulo<BR>Nulo<BR>Venta:Cte.Idioma<BR>Venta:Venta.ID<BR>Verdadero<BR>Config.CBProcesarLote<BR>MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.DR,VTAS.SG,VTAS.EG,VTAS.D,VTAS.DF,VTAS.B,VTAS.VC,VTAS.VCR,VTAS.DC,VTAS.DCR,VTAS.N,VTAS.NO,VTAS.NR,VTAS.FM,VTAS.CO))<BR>Si(Config.CBDirAlmacen, Venta:Cte.CBDir, <T><T>)
Boton=0
ActivoCondicion=Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)
VisibleCondicion=Config.CB

[(Carpeta Abrir).Venta.Agente]
Carpeta=(Carpeta Abrir)
Clave=Venta.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Venta.Almacen]
Carpeta=(Carpeta Abrir)
Clave=Venta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Localizar]
Nombre=Localizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F3
NombreDesplegar=L&ocalizar...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Localizar
Activo=S
Visible=S

[(Carpeta Abrir).Venta.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Venta.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta.Concepto]
Carpeta=Ficha
Clave=Venta.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posición del Movimiento
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPos
Antes=S
Visible=S
ActivoCondicion=ConDatos(Venta:Venta.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Mov, Venta:Venta.Mov)<BR>Asigna(Info.MovID, Venta:Venta.MovID)

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
Expresion=Asigna(Info.SumaSerieLote, Nulo)<BR>Si<BR>  MovTipo(<T>VTAS<T>, Venta:Venta.Mov) = VTAS.CO<BR>Entonces<BR>  Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>  Si(Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>SerieLoteMovUbicacion<T>), Forma(<T>SerieLoteMovUbicacionInfo<T>))<BR>Sino<BR>  Si <BR>    VentaD:Art.Tipo=TipoVIN<BR>  Entonces<BR>    Si(Venta:Venta.Estatus=EstatusSinAfectar, Forma(<T>VINMov<T>), Forma(<T>VINMovInfo<T>))<BR>  Sino<BR>    Si(Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador), Forma(<T>SerieLoteMov<T>), Forma(<T>SerieLoteMovInfo<T>))<BR>    Si<BR>      Venta:Venta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar) <BR>    Entonces<BR>      Si<BR>        (VentaD:Art.Tipo=TipoPartida) y (Info.SumaSerieLote>0)<BR>      Entonces<BR>        Asigna(Info.Copiar, Verdadero)<BR>        Asigna(Info.Precio, VentaD:VentaD.Precio)<BR>        Asigna(VentaD:VentaD.Cantidad, <BR>          Caso Minusculas(VentaD:VentaD.Unidad)<BR>            Es <T>metros<T> Entonces Info.SumaAlternaSerieLote<BR>            Es <T>yardas<T> Entonces Info.SumaAlternaSerieLote/UnidadFactor(VentaD:VentaD.Unidad)<BR>            Es <T>kilos<T>  Entonces Info.SumaSerieLote<BR>            Es <T>libras<T> Entonces Info.SumaSerieLote/UnidadFactor(VentaD:VentaD.Unidad)<BR>          Sino<BR>            0.0<BR>          Fin)<BR>        Asigna(VentaD:VentaD.Factor, Info.SumaSerieLote/VentaD:VentaD.Cantidad)<BR>        Asigna(VentaD:VentaD.CantidadAlterna, Info.SumaAlternaSerieLote)<BR>        Asigna(Info.Copiar, Falso)<BR>      Sino<BR>        Si<BR>          ConDatos(Info.SumaSerieLote) y (Info.SumaSerieLote<>ABS(VentaD:VentaD.Cantidad))<BR>        Entonces<BR>          Si<BR>            Confirmacion(<T>La Cantidad Difiere con la Selección.<T>+NuevaLinea+NuevaLinea+<T>¿ Desea Actualizar la Cantidad ?<T>,BotonSi, BotonNo)=BotonSi)<BR>          Entonces<BR>            Asigna(VentaD:VentaD.Cantidad, Si(Vacio(VentaD:VentaD.Cantidad, 0.0)<0,-Info.SumaSerieLote, Info.SumaSerieLote))<BR>          Fin<BR>        Fin  <BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Config.SeriesLotesMayoreo y (MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.DR,VTAS.SG,VTAS.EG,VTAS.D,VTAS.DF,VTAS.VC,VTAS.VCR,VTAS.DC,VTAS.DCR,VTAS.N,VTAS.NO,VTAS.NR,VTAS.FM,VTAS.CO)) o ((MovTipo(<T>VTAS<T>, Venta:Venta.Mov)=VTAS.P) y Config.VentaRefSerieLotePedidos))
EjecucionCondicion=VentaD:Art.Tipo en (TipoSerie, TipoVIN, TipoLote) o <BR>((VentaD:Art.Tipo=TipoPartida) y ConDatos(VentaD:VentaD.SubCuenta))
AntesExpresiones=Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.Almacen, Venta:Venta.Almacen)<BR>Asigna(Info.Modulo, <T>VTAS<T>) <BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.RenglonID, VentaD:VentaD.RenglonID)<BR>Asigna(Info.Cantidad, ABS(VentaD:VentaD.Cantidad))<BR>Asigna(Info.ArtTipo, VentaD:Art.Tipo)<BR>Asigna(Info.EsEntrada, MovTipoEn(<T>INV<T>,Venta:Venta.Mov, (VTAS.D, VTAS.DF, VTAS.DC, VTAS.DCR)))<BR>Si(Info.ArtTipo=TipoPartida,Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta), Asigna(Info.SubCuenta, <T><T>))

[Notas.Venta.Opcion]
Carpeta=Notas
Clave=Venta.Opcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Desc]
Carpeta=(Carpeta Totalizadores)
Clave=Desc
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(VentaA:Venta.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaA:Venta.ID)
Visible=S

[Acciones.CteExpress]
Nombre=CteExpress
Boton=60
Menu=&Edición
NombreDesplegar=Agregar &Cliente
EnMenu=S
TipoAccion=Expresion
Visible=S
EnBarraHerramientas=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Alt+F8
Expresion=Asigna(Info.Tipo, <T>Cliente<T>)<BR>Forma(<T>CteExpress<T>)<BR>Asigna(Venta:Venta.Cliente, Info.Cliente)
ActivoCondicion=Usuario.AgregarCteExpress y (Venta:Venta.Estatus=EstatusSinAfectar)

[Detalle.CantidadNeta]
Carpeta=Detalle
Clave=CantidadNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Envio.Venta.EnviarA]
Carpeta=Envio
Clave=Venta.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Envio.CteEnviarA.Nombre]
Carpeta=Envio
Clave=CteEnviarA.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=35
ColorFondo=Plata
Efectos=[Negritas]

[Envio.CteEnviarA.Direccion]
Carpeta=Envio
Clave=CteEnviarA.Direccion
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=35
ColorFondo=Plata

[Envio.Venta.Cliente]
Carpeta=Envio
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=S

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

[Envio.Cte.Direccion]
Carpeta=Envio
Clave=Cte.Direccion
Editar=S
3D=S
Tamano=35
ColorFondo=Plata
Pegado=S

[Envio.Venta.FormaEnvio]
Carpeta=Envio
Clave=Venta.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S

[Acciones.Venta]
Nombre=Venta
Boton=62
NombreDesplegar=Venta
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
Activo=
Antes=S
RefrescarDespues=
ClaveAccion=Refrescar Controles
Carpeta=(Todos)
ActivoCondicion=WizardCBEsDevolucion
AntesExpresiones=WizardCBEsDevolucion(no WizardCBEsDevolucion)
VisibleCondicion=(Venta:Venta.Estatus=EstatusSinAfectar) y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.N, VTAS.FM))

[Acciones.Devolucion]
Nombre=Devolucion
Boton=63
NombreDesplegar=Devolución
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=
Antes=S
RefrescarDespues=
ClaveAccion=Refrescar Controles
Carpeta=(Todos)
ActivoCondicion=no WizardCBEsDevolucion
AntesExpresiones=WizardCBEsDevolucion(no WizardCBEsDevolucion)
VisibleCondicion=(Venta:Venta.Estatus=EstatusSinAfectar) y MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.N, VTAS.FM))

[Acciones.Cobro]
Nombre=Cobro
Boton=64
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=Cobro
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaCobro
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionConError=S
ActivoCondicion=MovTipoEn(<T>VTAS<T>, Venta:Venta.Mov, (VTAS.FM, VTAS.N))
EjecucionCondicion=Asigna(Info.Importe, Suma(VentaD:Importe)+Suma(VentaD:Impuesto)-Suma(VentaD:DescGlobal)+Suma(VentaD:ImporteSobrePrecio))<BR>Info.Importe>0
EjecucionMensaje=<T>Este Movimiento no Tiene Cobro<T>
AntesExpresiones=Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, Venta:Venta.ID)<BR>Asigna(Afectar.Mov, Venta:Venta.Mov)<BR>Asigna(Afectar.MovID, Venta:Venta.MovID)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.Cliente, Venta:Venta.Cliente)<BR>Asigna(Info.Fecha, Venta:Venta.FechaEmision)<BR>Asigna(Info.Moneda, Venta:Venta.Moneda)<BR>Asigna(Info.Cerrado, Venta:Venta.Estatus<>EstatusSinAfectar)

[Notas.Venta.CtaDinero]
Carpeta=Notas
Clave=Venta.CtaDinero
Editar=S
ValidaNombre=S
3D=S
Tamano=20

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

[Movimiento]
Estilo=Ficha
Clave=Movimiento
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
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Movimiento.Venta.Mov]
Carpeta=Movimiento
Clave=Venta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Movimiento.Venta.MovID]
Carpeta=Movimiento
Clave=Venta.MovID
Editar=S
EditarConBloqueo=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
IgnoraFlujo=N

[Ficha.Venta.Descuento]
Carpeta=Ficha
Clave=Venta.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Art.Descripcion1]
Carpeta=Detalle
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Gris
ColorFondo=Blanco

[Ficha.Venta.Moneda]
Carpeta=Ficha
Clave=Venta.Moneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta.TipoCambio]
Carpeta=Ficha
Clave=Venta.TipoCambio
Editar=S
ValidaNombre=N
3D=S
Pegado=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Observaciones]
Nombre=Observaciones
Boton=0
UsaTeclaRapida=S
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
TeclaRapida=Ctrl+O
Expresion=Si(Venta:Venta.Estatus en (EstatusConcluido, EstatusCancelado), Informacion(VentaD:VentaD.DescripcionExtra), Pregunta(VentaD:VentaD.DescripcionExtra))

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Fecha, Venta:Venta.FechaEmision)<BR>Asigna(Info.ID, Venta:Venta.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Venta:Venta.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Venta:Venta.Mov+<T> <T>+Venta:Venta.MovID)
RefrescarDespues=S

[Acciones.RepPan]
Nombre=RepPan
Boton=0
Menu=&Archivo
NombreDesplegar=&Presentación Preliminar
GuardarAntes=S
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=VTAS
ListaParametros1=Venta:Venta.ID
ListaParametros=S
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
NombreDesplegar=&Copiar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F11
GuardarAntes=S
Expresion=CopiarMovimiento(<T>VTAS<T>, Venta:Venta.ID, <T>VentaMostrador<T>)

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

[Detalle.VentaD.Unidad]
Carpeta=Detalle
Clave=VentaD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.CantidadInventario]
Carpeta=Detalle
Clave=VentaD.CantidadInventario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VentaD.Almacen]
Carpeta=Detalle
Clave=VentaD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Autorizar]
Nombre=Autorizar
Boton=0
Menu=&Archivo
NombreDesplegar=A&utorizar
EnMenu=S
TipoAccion=Formas
Antes=S
ClaveAccion=MovAutorizar
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Alt+F12
ActivoCondicion=Vacio(Venta:Venta.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>VentaMostrador<T>)<BR>Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, Venta:Venta.ID)<BR>Asigna(Afectar.Mov, Venta:Venta.Mov)<BR>Asigna(Afectar.MovID, Venta:Venta.MovID)<BR>Asigna(Info.Descripcion, Venta:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(Venta:Venta.Mensaje)

[Ficha.Venta.ListaPreciosEsp]
Carpeta=Ficha
Clave=Venta.ListaPreciosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta.ZonaImpuesto]
Carpeta=Ficha
Clave=Venta.ZonaImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta.EnviarA]
Carpeta=Ficha
Clave=Venta.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteEnviarA.Nombre]
Carpeta=Ficha
Clave=CteEnviarA.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=47
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.VerPoliticasPrecios]
Nombre=VerPoliticasPrecios
Boton=0
NombreDesplegar=&Ver Políticas de Precios Aplicadas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=VerPoliticasPrecios
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, VentaD:VentaD.Articulo)<BR>Asigna(Info.SubCuenta, VentaD:VentaD.SubCuenta)<BR>Asigna(Info.Descripcion, VentaD:Art.Descripcion1)<BR>Asigna(Info.Mensaje, VentaD:VentaD.PoliticaPrecios)
Visible=S

[Acciones.VerOpciones]
Nombre=VerOpciones
Boton=0
NombreDesplegar=&Interpretar Opción
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=VerOpcionesArticulo( VentaD:VentaD.Articulo, VentaD:VentaD.SubCuenta )
ActivoCondicion=ConDatos(VentaD:VentaD.SubCuenta) y (VentaD:Art.TipoOpcion=TipoSi)

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

[Catalogo]
Estilo=Catalogo
Clave=Catalogo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=VentaD
Fuente={Tahoma, 8, Negro, []}
CatalogoActualizarOtraCarpeta=S
CatalogoActualizarCarpeta=Detalle
CatalogoInicial=Venta
CatalogoInicioEsp=1
CarpetaVisible=S

[Forma.ListaCarpetas]
(Inicio)=Movimiento
Movimiento=Catalogo
Catalogo=Detalle
Detalle=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=Imprimir
Imprimir=RepPan
RepPan=Afectar
Afectar=Autorizar
Autorizar=Eliminar
Eliminar=Cancelar
Cancelar=Totalizar
Totalizar=CteExpress
CteExpress=Cobro
Cobro=Catalogos
Catalogos=Asistente Articulos
Asistente Articulos=Asistente Codigo Barras
Asistente Codigo Barras=Asistente Codigo Barras (Lote)
Asistente Codigo Barras (Lote)=SeriesLotes
SeriesLotes=Anexos
Anexos=Anterior
Anterior=Siguiente
Siguiente=Disponible
Disponible=ArtInfo
ArtInfo=CteInfo
CteInfo=VerPoliticaPrecios
VerPoliticaPrecios=ActualizarPoliticasPrecios
ActualizarPoliticasPrecios=Asistente Precios
Asistente Precios=MovPos
MovPos=Cambiar Vista Hoja
Cambiar Vista Hoja=Navegador
Navegador=Venta
Venta=Devolucion
Devolucion=Cerrar
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

[Ficha.ListaEnCaptura]
(Inicio)=Venta.Moneda
Venta.Moneda=Venta.TipoCambio
Venta.TipoCambio=Venta.Cliente
Venta.Cliente=Cte.Nombre
Cte.Nombre=Venta.EnviarA
Venta.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=Venta.Agente
Venta.Agente=Agente.Nombre
Agente.Nombre=Venta.Concepto
Venta.Concepto=Venta.Descuento
Venta.Descuento=Venta.ListaPreciosEsp
Venta.ListaPreciosEsp=Venta.ZonaImpuesto
Venta.ZonaImpuesto=(Fin)

[Detalle.ListaOrden]
(Inicio)=VentaD.Renglon<TAB>(Acendente)
VentaD.Renglon<TAB>(Acendente)=VentaD.RenglonSub<TAB>(Acendente)
VentaD.RenglonSub<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=VentaD.Articulo
VentaD.Articulo=Art.Descripcion1
Art.Descripcion1=VentaD.Cantidad
VentaD.Cantidad=CantidadNeta
CantidadNeta=VentaD.Unidad
VentaD.Unidad=VentaD.CantidadInventario
VentaD.CantidadInventario=VentaD.Precio
VentaD.Precio=VentaD.DescuentoLinea
VentaD.DescuentoLinea=VentaD.DescuentoTipo
VentaD.DescuentoTipo=Importe
Importe=VentaD.Almacen
VentaD.Almacen=(Fin)

[Detalle.ListaAcciones]
(Inicio)=Observaciones
Observaciones=VerPoliticasPrecios
VerPoliticasPrecios=VerOpciones
VerOpciones=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Venta.Cliente
Venta.Cliente=Venta.Agente
Venta.Agente=Venta.Almacen
Venta.Almacen=Venta.Concepto
Venta.Concepto=Venta.FechaEmision
Venta.FechaEmision=Venta.FechaRequerida
Venta.FechaRequerida=ImporteTotal
ImporteTotal=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=PROCESAR
PROCESAR=PENDIENTE
PENDIENTE=RECURRENTE
RECURRENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Desc
Desc=Sub total
Sub total=Impuestos
Impuestos=Total
Total=(Fin)

[Movimiento.ListaEnCaptura]
(Inicio)=Venta.Mov
Venta.Mov=Venta.MovID
Venta.MovID=(Fin)
