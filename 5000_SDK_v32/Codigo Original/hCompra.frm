[Forma]
Clave=hCompra
Icono=0
Modulos=COMS
Nombre=Asigna(Info.SubModuloConFiltro, SQL(<T>SELECT ISNULL(Filtrar, 0) FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSub<T>, <T>COMS<T>, Info.SubModuloCompra))<BR><T>Histórico <T> + Info.ModuloComprasNombre
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
EsMovimiento=S
TituloAuto=S
MovModulo=COMS
PosicionInicialIzquierda=295
PosicionInicialArriba=77
PosicionInicialAltura=549
PosicionInicialAncho=776
BarraAyuda=S
BarraAyudaBold=S
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=52
ListaAcciones=(Lista)
Totalizadores=S
PosicionSeccion2=93
DialogoAbrir=S
AutoGuardarEncabezado=S
PosicionInicialAlturaCliente=535
TituloAutoNombre=S
PosicionSec1=244
PosicionSec2=435
EsConsultaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)
ExpresionesAlCerrar=Asigna(Filtro.Proveedor, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hCompra
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
PermiteEditar=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.hCompra.Mov]
Carpeta=Ficha
Clave=hCompra.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.MovID]
Carpeta=Ficha
Clave=hCompra.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.hCompra.Proyecto]
Carpeta=Ficha
Clave=hCompra.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.Moneda]
Carpeta=Ficha
Clave=hCompra.Moneda
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Ficha.hCompra.TipoCambio]
Carpeta=Ficha
Clave=hCompra.TipoCambio
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.FechaEmision]
Carpeta=Ficha
Clave=hCompra.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=27
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.FechaEntrega]
Carpeta=Ficha
Clave=hCompra.FechaEntrega
Editar=S
ValidaNombre=S
3D=S
Tamano=15
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.Almacen]
Carpeta=Ficha
Clave=hCompra.Almacen
Editar=S
3D=S
Tamano=20
LineaNueva=N
ValidaNombre=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.FechaRequerida]
Carpeta=Ficha
Clave=hCompra.FechaRequerida
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.Proveedor]
Carpeta=Ficha
Clave=hCompra.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=27
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=47
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Ficha.hCompra.Concepto]
Carpeta=Ficha
Clave=hCompra.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=27
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Ficha.hCompra.Referencia]
Carpeta=Ficha
Clave=hCompra.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=27
EspacioPrevio=S
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.Condicion]
Carpeta=Ficha
Clave=hCompra.Condicion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.Vencimiento]
Carpeta=Ficha
Clave=hCompra.Vencimiento
Editar=S
3D=S
Tamano=15
ValidaNombre=S
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.Descuento]
Carpeta=Ficha
Clave=hCompra.Descuento
Editar=S
ValidaNombre=S
3D=S
Tamano=27
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Hoja
Clave=Detalle
OtroOrden=S
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=hCompraD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=(Lista)
CarpetaVisible=S
VistaMaestra=hCompra
LlaveLocal=hCompraD.ID
LlaveMaestra=hCompra.ID
ControlRenglon=S
CampoRenglon=hCompraD.Renglon
ControlRenglonTipo=S
HojaColoresPorTipo=S
CampoDespliegaTipo=Art.Tipo
HojaFondoGrisAuto=S
ValidarCampos=S
ControlRenglonID=S
ListaEnCaptura=(Lista)
ListaCamposAValidar=(Lista)
MenuLocal=S
ListaAcciones=(Lista)
ConResumen=S
ResumenVista=CompraR
ResumenLlave=ID
ResumenCampos=(Lista)
ResumenVistaMaestra=hCompra
ResumenLlaveMaestra=hCompra.ID
PermiteLocalizar=S
HojaAjustarColumnas=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
CampoDespliegaTipoOpcion=Art.TipoOpcion

FiltroGeneral={Si(hCompra:hCompra.Estatus<>EstatusSinAfectar, <T>ISNULL(hCompraD.Cantidad, 0) <> 0<T>)}
[Detalle.hCompraD.Aplica]
Carpeta=Detalle
Clave=hCompraD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.hCompraD.AplicaID]
Carpeta=Detalle
Clave=hCompraD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.hCompraD.FechaEntrega]
Carpeta=Detalle
Clave=hCompraD.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
EditarConBloqueo=S
ColorFondo=Blanco

[Detalle.hCompraD.Almacen]
Carpeta=Detalle
Clave=hCompraD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=S
ColorFondo=Blanco

[Detalle.hCompraD.Articulo]
Carpeta=Detalle
Clave=hCompraD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.hCompraD.SubCuenta]
Carpeta=Detalle
Clave=hCompraD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Detalle.hCompraD.Cantidad]
Carpeta=Detalle
Clave=hCompraD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.hCompraD.Costo]
Carpeta=Detalle
Clave=hCompraD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.hCompraD.DescuentoLinea]
Carpeta=Detalle
Clave=hCompraD.DescuentoLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.Importe]
Carpeta=Detalle
Clave=Importe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.Columnas]
Aplica=88
AplicaID=64
FechaEntrega=77
Almacen=69
Articulo=84
SubCuenta=80
Cantidad=48
Costo=75
DescuentoTipo=30
DescuentoLinea=32
Destino=82
DestinoID=66
Importe=79
DescripcionExtra=117
CantidadPendiente=53
CantidadA=48
FechaRequerida=87
CantidadCancelada=57
CantidadNeta=49
CentroCostos=80
ContUso=92
ReferenciaExtra=152
ClaveProveedor=86
CostoInv=86
Unidad=39
Cliente=80
CantidadInventario=52
AplicaNombre=124
DestinoNombre=129
FechaOrdenar=78
DescuentoImporte=55
Paquete=45
ClaveIdioma=72
ImportacionProveedor=59
ImportacionReferencia=77
CantidadInvNeta=53
FechaCaducidad=69
Codigo=99
Descuento=65
Ejercido=80
Pendiente=77
Disponible=76
ProveedorArt=93
ProveedorArtCosto=71
Posicion=64
Impuesto1=40
ValorAduana=68
Pais=96
ImportacionImpuesto1=37
ImportacionImpuesto2=49
ID1=31
ID2=31
FormaPago=114
PresupuestoEsp=114

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
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
Antes=S
Visible=S
ConCondicion=S
EjecucionConError=S

EjecucionCondicion=MovTipo(<T>COMS<T>, hCompra:hCompra.Mov)=COMS.R) o ConDatos(hCompra:hCompra.Proveedor)
EjecucionMensaje=<T>Falta Indicar el Proveedor<T>
AntesExpresiones=Asigna(hCompra:hCompra.Importe, Suma(hCompraD:Importe))<BR>Asigna(hCompra:hCompra.Impuestos, Suma(hCompraD:Impuesto))
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
Totalizadores1=Importe<BR>Desc<BR>Sub total<BR>Impuestos<BR>Total<BR>Conteo
Totalizadores2=Suma(hCompraD:Importe)<BR>-Suma(hCompraD:DescGlobal)<BR>Suma(hCompraD:SubTotal)<BR>Suma(hCompraD:Impuesto)<BR>Suma(hCompraD:ImporteTotal)<BR>Conteo(hCompraD:hCompraD.Articulo)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=(Usuario.Costos o (MovTipo(<T>COMS<T>,hCompra:hCompra.Mov)=COMS.FL)) y (MovTipo(<T>COMS<T>,hCompra:hCompra.Mov) noen (COMS.OG, COMS.IG, COMS.DG))

[(Carpeta Totalizadores).Sub total]
Carpeta=(Carpeta Totalizadores)
Clave=Sub total
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Impuestos]
Carpeta=(Carpeta Totalizadores)
Clave=Impuestos
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
ListaParametros1=hCompra:hCompra.ID
Visible=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>COMS<T>, hCompra:hCompra.Mov, hCompra:hCompra.Estatus), hCompra:hCompra.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentación preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=hCompra:hCompra.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11

Expresion=ReportePantalla(ReporteMovPantalla(<T>hCOMS<T>, hCompra:hCompra.Mov, hCompra:hCompra.Estatus), hCompra:hCompra.ID)
ActivoCondicion=Usuario.PreliminarMovs
[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
ConCondicion=S
Expresion=Verificar( <T>COMS<T>, hCompra:hCompra.ID, hCompra:hCompra.Mov, hCompra:hCompra.MovID )
ActivoCondicion=hCompra:hCompra.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(hCompra:hCompra.Mov)

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=<T>A&fectar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
RefrescarDespues=S
ConCondicion=S
Antes=S
EspacioPrevio=S
Expresion=Si<BR>  hCompra:Prov.GarantiaCostos y (MovTipo(<T>COMS<T>, hCompra:hCompra.Mov) = COMS.O) y (hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>Entonces<BR>   Si(Confirmacion(<T>Desea Ejecutar la Garantía de Costos<T>, BotonSi, BotonNo)=BotonSi, ProcesarSQL(<T>spCompraGarantiaCostos :nID<T>, hCompra:hCompra.ID))<BR>Fin<BR><BR>Si<BR>  (MovTipo(<T>COMS<T>, hCompra:hCompra.Mov)<>COMS.R) o Config.CompraProveedorRequisicion<BR>Entonces<BR>  Si(Vacio(hCompra:hCompra.Proveedor), Error(<T>Falta Indicar el Proveedor<T>) AbortarOperacion)<BR>Fin<BR><BR>Asigna(Afectar.Modulo, <T>COMS<T>)<BR>Asigna(Afectar.ID, hCompra:hCompra.ID)<BR>Asigna(Afectar.Mov, hCompra:hCompra.Mov)<BR>Asigna(Afectar.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>COMS<T>, hCompra:hCompra.Mov))<BR>Si <BR>  (Info.MovTipo=COMS.C) y (hCompra:hCompra.Estatus=EstatusPorConfirmar)<BR>Entonces<BR>  Dialogo(<T>GenerarCotizacionCompra<T>)<BR>Sino<BR>  Si <BR>    hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPorAutorizarE)<BR>  Entonces<BR>    Si <BR>     (MovTipo(<T>COMS<T>,hCompra:hCompra.Mov) noen (COMS.R, COMS.PR, COMS.EST)) y Vacio(hCompra:hCompra.Proveedor)<BR>    Entonces<BR>     Informacion(<T>Falta Indicar el Proveedor<T>, BotonAceptar) <BR>    Sino<BR>      Si(Config.CompraVentaSinIVA y (Suma(hCompraD:Impuesto)=0.0) y (Suma(hCompraD:Importe)>0.0), Si(Confirmacion(<T>Movimiento sin Impuestos<T>+NuevaLinea+<T>¿ Es Correcto ?<T>,BotonSi,BotonNo)=BotonNo,AbortarOperacion))<BR>      Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Compra<T>)<BR>    Fin<BR>  Sino<BR>    Asigna(Info.Modulo, <T>COMS<T>)<BR>    Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>    Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>    Asigna(Afectar.Base, <T>Pendiente<T>)<BR>    Asigna(Afectar.GenerarMov, <T><T>)<BR>    Asigna(Afectar.FormaCaptura, <T>Compra<T>)<BR>    Si<BR>      ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>    Entonces<BR>      Si <BR>        Forma(<T>GenerarMovFlujo<T>)<BR>      Entonces<BR>        Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>        Asigna(Info.TituloDialogo, <T>Generar <T>+Comillas(Info.MovGenerar)+<T> de <T>+Comillas(Info.Mov))<BR>        Dialogo(<T>GenerarCompraPendiente<T>)<BR>      Fin<BR>    Sino<BR>      Caso Info.MovTipo<BR>        Es COMS.PR Entonces Dialogo(<T>GenerarCompraPresupuesto<T>) <BR>        Es COMS.R  Entonces Dialogo(<T>GenerarRequisicion<T>) <BR>        Es COMS.C  Entonces Dialogo(<T>GenerarCotizacionCompra<T>) <BR>        Es COMS.O  Entonces Dialogo(Info.Dialogo) <BR>        Es COMS.OI Entonces Dialogo(Info.Dialogo) <BR>        Es COMS.OG Entonces Dialogo(<T>GenerarOrdenGarantia<T>) <BR>        Es COMS.IG Entonces Dialogo(<T>GenerarIntercambioGarantia<T>) <BR>        Es COMS.CC Entonces Dialogo(<T>GenerarCompraConsignacion<T>)<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hCompra:hCompra.Usuario) y <BR>((hCompra:hCompra.Estatus en (EstatusSinAfectar,EstatusBorrador,EstatusPorConfirmar,EstatusPendiente)) o<BR>((hCompra:hCompra.Estatus=EstatusPorAutorizarE) y PuedeAutorizarMov(<T>COMS<T>,hCompra:hCompra.Mov))) y<BR>PuedeAvanzarEstatus(<T>COMS<T>, hCompra:hCompra.Mov, hCompra:hCompra.Estatus, FormaSituacion)
EjecucionCondicion=ConDatos(hCompra:hCompra.Mov) y ConDatos(hCompra:hCompra.Almacen)
AntesExpresiones=Si(General.AdvertirProyectosExpirados, Si(SQL(<T>SELECT COUNT(*) FROM Proy WHERE (Estatus = :tBaja OR FechaFin+1<GETDATE()) AND Proyecto=:tProy<T>, EstatusBaja, hCompra:hCompra.Proyecto) > 0, Si(Precaucion(<T>Proyecto Expirado<T>, BotonAceptar, BotonCancelar)=BotonCancelar, AbortarOperacion)))<BR>Asigna(Info.Dialogo, <T>GenerarOrdenCompra<T>)<BR>Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>COMS<T>, hCompra:hCompra.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>COMS<T>, hCompra:hCompra.Mov, hCompra:hCompra.ID, Verdadero, hCompra:hCompra.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn

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
EspacioPrevio=S
ConCondicion=S
EjecucionConError=S

ActivoCondicion=Vacio(hCompra:hCompra.MovID) y (hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, hCompra:hCompra.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Compra WHERE ID=:nID<T>, hCompra:hCompra.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S
GuardarAntes=S

Expresion=Si <BR>  (hCompra:hCompra.Estatus=EstatusPendiente) y MovTipoEn(<T>COMS<T>,hCompra:hCompra.Mov, (COMS.R, COMS.O, COMS.OP, COMS.OG, COMS.OI))<BR>Entonces<BR>  Asigna(Info.TituloDialogo, <T>Cancelar: <T>+Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Dialogo(<T>CancelarPendiente<T>)<BR>Sino<BR>  Si<BR>    Precaucion(<T>¿ Esta seguro que desea cancelar el movimiento ?<T>+NuevaLinea+NuevaLinea+Afectar.Mov+<T> <T>+Afectar.MovID, BotonSi, BotonNo ) = BotonSi<BR>  Entonces<BR>    Cancelar(<T>COMS<T>, hCompra:hCompra.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Compra<T>)<BR>  Fin<BR>Fin
ActivoCondicion=//Si<BR>//  PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, hCompra:hCompra.Usuario) y ConDatos(hCompra:hCompra.ID) y ConDatos(hCompra:hCompra.MovID)<BR>//Entonces<BR>//  Si<BR>//    MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.R,COMS.C,COMS.O,COMS.OG,COMS.OI,COMS.CC))<BR>//  Entonces<BR>//    hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusSincro, EstatusPendiente, EstatusPorConfirmar) y (hCompra:hCompra.OrigenTipo<><T>PROD<T>)<BR>//  Sino<BR>//    hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusSincro, EstatusPendiente, EstatusConcluido)<BR>//  Fin<BR>//Sino<BR>//  Falso<BR>//Fin
AntesExpresiones=Asigna(Afectar.Modulo, <T>COMS<T>)<BR>Asigna(Afectar.ID, hCompra:hCompra.ID)<BR>Asigna(Afectar.Mov, hCompra:hCompra.Mov) <BR>Asigna(Afectar.MovID, hCompra:hCompra.MovID)
[Acciones.Cambiar Vista Hoja]
Nombre=Cambiar Vista Hoja
Boton=0
NombreDesplegar=Cambiar Vista Hoja
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle-Resumen)
Activo=S
Visible=S

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
ActivoCondicion=hCompra:hCompra.Estatus=EstatusSinAfectar

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
ListaParametros1=hCompraD:hCompraD.Articulo<BR>hCompra:hCompra.Almacen<BR>hCompraD:hCompraD.Cantidad
ListaParametros=S
Visible=S
ActivoCondicion=hCompra:hCompra.Estatus=EstatusSinAfectar

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
Activo=S
Visible=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=hCompraA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
BusquedaRapidaControles=S
IconosConPaginas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=hCompra.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
PestanaOtroNombre=S
PestanaNombre=movimientos en compras
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
FiltroAplicaEn=hCompra.Moneda
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=hCompra.FechaCancelacion
FiltroSucursales=S
OtroOrden=S
ListaOrden=hCompra.ID<TAB>(Decendente)
IconosNombre=hCompraA:hCompra.Mov+<T> <T>+hCompraA:hCompra.MovID
FiltroGeneral={Si(Info.SubModuloConFiltro, <T>hCompra.SubModulo=<T>+Comillas(Info.SubModuloCompra), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Mov), <T> AND hCompra.Mov=<T>+Comillas(Filtro.Mov), <T><T>)}<BR>{Si(ConDatos(Filtro.Proveedor), <T> AND hCompra.Proveedor=<T>+Comillas(Filtro.Proveedor), <T><T>)}

[(Carpeta Abrir).hCompra.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=hCompra.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
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

[(Carpeta Abrir).Columnas]
0=155
1=78

2=-2
3=-2
4=-2
5=-2
6=-2
[Notas.hCompra.Observaciones]
Carpeta=Notas
Clave=hCompra.Observaciones
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=65
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Origen.hCompra.OrigenTipo]
Carpeta=Origen
Clave=hCompra.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata

[Origen.hCompra.Origen]
Carpeta=Origen
Clave=hCompra.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Origen.hCompra.OrigenID]
Carpeta=Origen
Clave=hCompra.OrigenID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata

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
Vista=hCompra
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

[Acciones.Asistente Articulos]
Nombre=Asistente Articulos
Boton=12
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F7
NombreDesplegar=Asistente Articulos
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=hCompraD:hCompraD.Articulo<BR>hCompraD:hCompraD.Almacen<BR>hCompraD:hCompraD.SubCuenta<BR>hCompraD:hCompraD.Cantidad<BR>Nulo<BR>MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.F, COMS.FL, COMS.IG, COMS.CC))<BR>MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.C, COMS.O, COMS.OP, COMS.CP, COMS.OG, COMS.OI))<BR>MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.D, COMS.DG, COMS.DC))<BR>Nulo<BR>hCompraD:Art.Descripcion1<BR>hCompraD:Art.Tipo<BR>hCompraD:Art.Unidad<BR>Nulo<BR>hCompraD:Art.TipoOpcion<BR>Falso<BR>Nulo<BR>Nulo<BR>Nulo<BR><T>COMS<T><BR>hCompra:hCompra.ID<BR>hCompra:hCompra.Proveedor
ListaParametros=S
Visible=S
EspacioPrevio=S
ActivoCondicion=hCompra:hCompra.Estatus=EstatusSinAfectar

[Acciones.Disponible]
Nombre=Disponible
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Disponible del Artículo
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(Info.Origen, <T>COMS<T>)<BR>Asigna(Info.Articulo, hCompraD:hCompraD.Articulo )<BR>Asigna(Info.Descripcion, hCompraD:Art.Descripcion1)<BR>Asigna(Info.ArtTipo, hCompraD:Art.Tipo )<BR>Asigna(Info.ArtTipoOpcion, hCompraD:Art.TipoOpcion)<BR>Asigna(Info.Almacen, Si(Config.CompraMultiAlmacen, hCompraD:hCompraD.Almacen, hCompra:hCompra.Almacen))<BR>Forma(<T>ArtAlmExistencia<T>)
EjecucionCondicion=ConDatos(hCompraD:hCompraD.Articulo)

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+I
NombreDesplegar=Información del Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos( hCompraD:hCompraD.Articulo)
AntesExpresiones=Asigna(Info.Origen, <T>COMS<T>)<BR>Asigna(Info.Articulo, hCompraD:hCompraD.Articulo )<BR>Asigna(Info.ArtTipo, hCompraD:Art.Tipo)

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información del Proveedor
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos( hCompra:hCompra.Proveedor)
AntesExpresiones=Asigna(Info.Origen, <T>COMS<T>)<BR>Asigna(Info.Proveedor, hCompra:hCompra.Proveedor)

[Detalle.hCompraD.DescripcionExtra]
Carpeta=Detalle
Clave=hCompraD.DescripcionExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha.hCompra.FormaEnvio]
Carpeta=Ficha
Clave=hCompra.FormaEnvio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hCompraD.CantidadPendiente]
Carpeta=Detalle
Clave=hCompraD.CantidadPendiente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Rojo obscuro
Efectos=[Negritas]
ColorFondo=Blanco

[Detalle.hCompraD.CantidadA]
Carpeta=Detalle
Clave=hCompraD.CantidadA
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Notas.hCompra.Prioridad]
Carpeta=Notas
Clave=hCompra.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[(Carpeta Abrir).hCompra.FechaRequerida]
Carpeta=(Carpeta Abrir)
Clave=hCompra.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hCompra.Directo]
Carpeta=Ficha
Clave=hCompra.Directo
Editar=S
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Acciones.Asistente Codigo Barras]
Nombre=Asistente Codigo Barras
Boton=42
Menu=&Edición
UsaTeclaRapida=S
NombreDesplegar=Asistente Codigos de Barras
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Codigo Barras (1x1)
ListaParametros1=hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)<BR>hCompra:hCompra.Estatus=EstatusPendiente<BR>hCompraD:hCompraD.Cantidad<BR>hCompraD:hCompraD.CantidadPendiente<BR>Nulo<BR>hCompraD:hCompraD.CantidadA<BR>hCompraD:hCompraD.SubCuenta<BR>hCompraD:hCompraD.Unidad<BR>hCompraD:hCompraD.Articulo<BR>Nulo<BR>Nulo<BR>hCompraD:hCompraD.Almacen<BR>hCompra:hCompra.Proveedor<BR>Nulo<BR>hCompra:hCompra.Idioma<BR>Config.CBPreguntarCantidad<BR>Falso
ListaParametros=S
Visible=S
TeclaRapida=Mayús+F7
ActivoCondicion=Config.CB y (hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente))

[Acciones.Asistente Codigo Barras (en Lote)]
Nombre=Asistente Codigo Barras (en Lote)
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=Asistente Codigos de Barras (en Lote)
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Codigo Barras (Lote)
ListaParametros1=hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>hCompra:hCompra.Estatus=EstatusPendiente<BR>hCompraD:hCompraD.Cantidad<BR>hCompraD:hCompraD.CantidadPendiente<BR>Nulo<BR>hCompraD:hCompraD.CantidadA<BR>hCompraD:hCompraD.SubCuenta<BR>hCompraD:hCompraD.Unidad<BR>hCompraD:hCompraD.Articulo<BR>Nulo<BR>Nulo<BR>hCompraD:hCompraD.Almacen<BR>hCompra:hCompra.Proveedor<BR>Nulo<BR>hCompra:Prov.Idioma<BR>hCompra:hCompra.ID<BR>Verdadero<BR>Config.CBProcesarLote<BR>MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.F,COMS.FL,COMS.EG,COMS.EI,COMS.IG,COMS.D,COMS.DG,COMS.CC,COMS.DC))<BR>Si(Config.CBDirAlmacen, hCompra:Alm.CBDir, <T><T>)
ListaParametros=S
GuardarAntes=S
ActivoCondicion=hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=Config.CB

[Acciones.CopiarPendiente]
Nombre=CopiarPendiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Copiar Pendiente
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(hCompraD:hCompraD.CantidadA, hCompraD:hCompraD.CantidadPendiente)
ActivoCondicion=hCompra:hCompra.Estatus=EstatusPendiente

[Detalle.ColumnasResumen]
Articulo=116
Descripcion=294
Cantidad=64
Costo=102
DescuentoTipo=29
DescuentoLinea=37
Importe=104

[(Carpeta Abrir).hCompra.Referencia]
Carpeta=(Carpeta Abrir)
Clave=hCompra.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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

[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posición del Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPos
Antes=S
Visible=S
ActivoCondicion=ConDatos(hCompra:hCompra.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)

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
Expresion=Si <BR>  hCompraD:Art.Tipo=TipoVIN<BR>Entonces<BR>  Si<BR>    hCompra:hCompra.Estatus=EstatusSinAfectar<BR>  Entonces<BR>    Asigna(Info.Costo, Nulo)<BR>    Asigna(Info.Articulo, hCompraD:hCompraD.Articulo)<BR>    Forma(<T>VINMovMultiple<T>)<BR>    Si(ConDatos(Info.Costo), Asigna(hCompraD:hCompraD.Costo, Info.Costo))<BR>  Sino<BR>    Forma(<T>VINMovMultipleInfo<T>)<BR>  Fin<BR>Sino<BR>  Asigna(Info.SumaSerieLote, Nulo)<BR>  Si(hCompra:hCompra.Estatus=EstatusSinAfectar, Forma(<T>SerieLoteMov<T>), Si(Usuario.ModificarSerieLoteProp, Forma(<T>SerieLoteMovProp<T>), Forma(<T>SerieLoteMovInfo<T>)))<BR>  Si<BR>    (no Config.MultiUnidades) y ConDatos(Info.SumaSerieLote) y (Info.SumaSerieLote<>ABS(hCompraD:hCompraD.Cantidad)) y (hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>  Entonces<BR>    Si<BR>      Confirmacion(<T>La Cantidad Difiere con las Partidas.<T>+NuevaLinea+NuevaLinea+<T>¿ Desea Actualizar la Cantidad ?<T>,BotonSi, BotonNo)=BotonSi)<BR>    Entonces<BR>      Asigna(hCompraD:hCompraD.Cantidad, Si(Vacio(hCompraD:hCompraD.Cantidad, 0.0)<0,-Info.SumaSerieLote, Info.SumaSerieLote))<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Config.SeriesLotesMayoreo y MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.F,COMS.FL,COMS.EG,COMS.EI,COMS.IG,COMS.D,COMS.DG,COMS.CC,COMS.DC,COMS.B,COMS.CA,COMS.GX))
EjecucionCondicion=hCompraD:Art.Tipo en (TipoSerie, TipoVIN, TipoLote) o <BR>((hCompraD:Art.Tipo=TipoPartida) y ConDatos(hCompraD:hCompraD.SubCuenta))
AntesExpresiones=Asigna(Info.Articulo, hCompraD:hCompraD.Articulo)<BR>Asigna(Info.Almacen, hCompraD:hCompraD.Almacen)<BR>Asigna(Info.AlmTipo, hCompraD:AlmDetalle.Tipo)<BR>Asigna(Info.Modulo, <T>COMS<T>) <BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.RenglonID, hCompraD:hCompraD.RenglonID)<BR>Asigna(Info.Cantidad, ABS(hCompraD:hCompraD.Cantidad) * UnidadFactor(hCompraD:hCompraD.Unidad, hCompraD:hCompraD.Articulo))<BR>Asigna(Info.Paquete, hCompraD:hCompraD.Paquete)<BR>Asigna(Info.MovTipo, MovTipo(<T>COMS<T>, hCompra:hCompra.Mov))<BR>Asigna(Info.ArtTipo, hCompraD:Art.Tipo)<BR>Asigna(Info.EsEntrada, MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.F,COMS.FL,COMS.EG,COMS.EI,COMS.IG,COMS.CC)) )<BR>Asigna(Info.Unidad, hCompraD:hCompraD.Unidad)<BR>Asigna(Info.Estatus, hCompra:hCompra.Estatus)<BR>Si((Info.ArtTipo=TipoPartida) o (CompraD:Art.TipoOpcion<>TipoNo), Asigna(Info.SubCuenta, hCompraD:hCompraD.SubCuenta), Asigna(Info.SubCuenta, <T><T>))

[Detalle.hCompraD.Destino]
Carpeta=Detalle
Clave=hCompraD.Destino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.hCompraD.DestinoID]
Carpeta=Detalle
Clave=hCompraD.DestinoID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Notas.hCompra.Instruccion]
Carpeta=Notas
Clave=hCompra.Instruccion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Desc]
Carpeta=(Carpeta Totalizadores)
Clave=Desc
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=11
ColorFondo=Plata
ColorFuente=Negro

[Detalle.CantidadNeta]
Carpeta=Detalle
Clave=CantidadNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Antes=S
Visible=S
ActivoCondicion=(ConfigModulo(<T>COMS<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>PuedeAvanzarSituacion(<T>COMS<T>, hCompra:hCompra.Mov, hCompra:hCompra.Estatus, FormaSituacion)
AntesExpresiones=Si(Vacio(hCompra:hCompra.ID),GuardarCambios)

[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=ConfigModulo(<T>COMS<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(hCompra:hCompra.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)

[(Carpeta Abrir).hCompra.Proveedor]
Carpeta=(Carpeta Abrir)
Clave=hCompra.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(hCompraA:hCompra.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompraA:hCompra.ID)
Visible=S

[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Visible=S
ActivoCondicion=Usuario.ImprimirMovs

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

[Acciones.AbrirExcel]
Nombre=AbrirExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Acciones.AbrirMostrar]
Nombre=AbrirMostrar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ReasignarUsuario]
Nombre=ReasignarUsuario
Boton=0
Menu=&Archivo
NombreDesplegar=Reasignar &Usuario...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ReasignarUsuario
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Usuario, hCompra:hCompra.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(hCompra:hCompra.ID)

[Acciones.Observaciones]
Nombre=Observaciones
Boton=0
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
Activo=S
Expresion=Si(hCompra:hCompra.Estatus en (EstatusConcluido, EstatusCancelado), Informacion(hCompraD:hCompraD.DescripcionExtra), Pregunta(hCompraD:hCompraD.DescripcionExtra))
VisibleCondicion=MovTipo(<T>COMS<T>,hCompra:hCompra.Mov) noen (COMS.R, COMS.C)

[Acciones.Importar]
Nombre=Importar
Boton=0
Menu=&Archivo
NombreDesplegar=I&mportar...
EnMenu=S
TipoAccion=Otros
ClaveAccion=Procesar Lista
ListaParametros1=<T>Importar Movimiento<T><BR><T>ImportarInv<T><BR><T>Estacion<T><BR><T>ID<T><BR><T>spImportarInv<T><BR>EstacionTrabajo & <T>, <T> & Comillas(Empresa) & <T>, <T> & Comillas(<T>COMS<T>) & <T>, <T> & hCompra:hCompra.ID & <T>, <T> & Sucursal
ListaParametros=S
GuardarAntes=S
RefrescarDespues=S
ActivoCondicion=hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Detalle.hCompraD.ContUso]
Carpeta=Detalle
Clave=hCompraD.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S

[Acciones.ArtListaDisponible]
Nombre=ArtListaDisponible
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+L
NombreDesplegar=&Lista Artículos Disponibles
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtListaDisponible
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna( Info.Almacen, hCompra:hCompra.Almacen)<BR>Asigna( Info.Origen, <T>COMS<T>)

[Detalle.hCompraD.ReferenciaExtra]
Carpeta=Detalle
Clave=hCompraD.ReferenciaExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
EditarConBloqueo=S

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Activo=S
Antes=S
Visible=S
EnBarraHerramientas=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>COMS<T>)<BR>Asigna(Info.Fecha, hCompra:hCompra.FechaEmision)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hCompra:hCompra.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, hCompra:hCompra.Mov+<T> <T>+hCompra:hCompra.MovID)
RefrescarDespues=S

[Acciones.AnexosDetalle]
Nombre=AnexosDetalle
Boton=0
Menu=&Edición
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
EjecucionCondicion=ConDatos(hCompra:hCompra.ID) y ConDatos(hCompraD:hCompraD.Articulo)
EjecucionMensaje=Si(Vacio(hCompra:hCompra.ID), <T>Es Necesario Guardar el Movimiento Antes de Ejecutar esta Opción<T>, <T>Falta Indicar el Artículo<T>)
AntesExpresiones=Asigna(Info.Rama, <T>COMS<T>)<BR>Asigna(Info.Fecha, hCompra:hCompra.FechaEmision)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hCompra:hCompra.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Cuenta, hCompraD:hCompraD.Articulo)<BR>Asigna(Info.Descripcion, hCompraD:Art.Descripcion1)

[Ficha.hCompra.Agente]
Carpeta=Ficha
Clave=hCompra.Agente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
Menu=&Archivo
NombreDesplegar=&Sugerir...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S
Expresion=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, hCompra:hCompra.Proveedor)<BR>Asigna(Info.Almacen, hCompra:hCompra.Almacen)<BR>EjecutarSQL(<T>spCompraSugerir :nEstacion, :nID, :tCliente, :tProveedor, :tAlmacen<T>, EstacionTrabajo, Info.ID, Info.Cliente, Info.Proveedor, Info.Almacen)<BR>Forma(<T>CompraSugerir<T>)
ActivoCondicion=MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.R, COMS.C, COMS.O, COMS.OP, COMS.OG, COMS.OI)) y (hCompra:hCompra.Estatus=EstatusSinAfectar)

[Detalle.ClaveProveedor]
Carpeta=Detalle
Clave=ClaveProveedor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.AsignarPedimento]
Nombre=AsignarPedimento
Boton=0
Menu=&Edición
NombreDesplegar=Asignar &Pedimentos...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompraPedimento
Antes=S
DespuesGuardar=S
Activo=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)
VisibleCondicion=Config.SeriesLotesMayoreo y (hCompra:hCompra.Estatus en (EstatusSinAfectar,EstatusBorrador)) y MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.F, COMS.FL, COMS.EG, COMS.EI, COMS.CC, COMS.IG))

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
ActivoCondicion=ConDatos(hCompra:hCompra.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)

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

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F11
NombreDesplegar=&Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=CopiarMovimiento(<T>COMS<T>, hCompra:hCompra.ID, <T>Compra<T>)

[Detalle.hCompraD.CostoInv]
Carpeta=Detalle
Clave=hCompraD.CostoInv
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.GastosDiversos]
Nombre=GastosDiversos
Boton=0
Menu=&Edición
NombreDesplegar=&Gastos Diversos...
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S
RefrescarDespues=S
DespuesGuardar=S
Expresion=Si(hCompra:hCompra.Estatus en (EstatusSinAfectar,EstatusBorrador),Forma(<T>CompraGastoDiverso<T>),Forma(<T>CompraGastoDiversoInfo<T>))
AntesExpresiones=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.Moneda, hCompra:hCompra.Moneda)<BR>Asigna(Info.TipoCambio, hCompra:hCompra.TipoCambio)<BR>Asigna(Info.Concepto, Nulo)
VisibleCondicion=MovTipo(<T>COMS<T>, hCompra:hCompra.Mov) en (COMS.EG,COMS.EI,COMS.PR,COMS.OI)

[Detalle.hCompraD.Unidad]
Carpeta=Detalle
Clave=hCompraD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
3D=S
Tamano=4
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[Detalle.hCompraD.Cliente]
Carpeta=Detalle
Clave=hCompraD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
EditarConBloqueo=S

[Acciones.Embarque]
Nombre=Embarque
Boton=69
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=Datos &Embarque...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=GuiaEmbarque
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.D,COMS.DC,COMS.DG)) y (hCompra:hCompra.Estatus<>EstatusCancelado)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.FormaEnvio, hCompra:hCompra.FormaEnvio)

[Acciones.ArtExpress]
Nombre=ArtExpress
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Mayús+F8
NombreDesplegar=Agregar Artícul&o...
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.Articulo, Nulo)<BR>Forma(<T>ArtExpress<T>)<BR>Si <BR>  ConDatos(Info.Articulo) y (hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>Entonces<BR>  Asigna(hCompraD:hCompraD.Articulo, Info.Articulo)<BR>Fin
ActivoCondicion=Usuario.AgregarArtExpress y (hCompra:hCompra.Estatus=EstatusSinAfectar)

[Detalle.hCompraD.CantidadInventario]
Carpeta=Detalle
Clave=hCompraD.CantidadInventario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Prorratear]
Nombre=Prorratear
Boton=0
Menu=&Archivo
NombreDesplegar=Prorratear en Base a &Movimiento...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompraProrratear
Antes=S
Visible=S
RefrescarDespues=S
DespuesGuardar=S
ActivoCondicion=(hCompra:hCompra.Estatus=EstatusSinAfectar) y MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.B, COMS.CA, COMS.GX))
AntesExpresiones=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Moneda, hCompra:hCompra.Moneda)<BR>Asigna(Info.TipoCambio, hCompra:hCompra.TipoCambio)

[Notas.hCompra.Atencion]
Carpeta=Notas
Clave=hCompra.Atencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AbrirLocalizar]
Nombre=AbrirLocalizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

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

[Acciones.Campos]
Nombre=Campos
Boton=0
Menu=&Edición
NombreDesplegar=&Campos...
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompraCampos
ActivoCondicion=no FormaBloqueada
Antes=S
RefrescarDespues=S
AntesExpresiones=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)
VisibleCondicion=hCompra:hCompra.Estatus<>EstatusSinAfectar

[Notas.hCompra.Causa]
Carpeta=Notas
Clave=hCompra.Causa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Detalle.hCompraD.FechaRequerida]
Carpeta=Detalle
Clave=hCompraD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.hCompra.VerDestino]
Carpeta=Ficha
Clave=hCompra.VerDestino
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AplicaNombre]
Carpeta=Detalle
Clave=AplicaNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.DestinoNombre]
Carpeta=Detalle
Clave=DestinoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.CopiarPendientes]
Nombre=CopiarPendientes
Boton=55
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=Copiar &Pendientes
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S
GuardarAntes=S
Expresion=Asigna(Info.MovTipo, MovTipo(<T>COMS<T>, hCompra:hCompra.Mov))<BR>Asigna(Info.Centro, Nulo)<BR>Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.SeCompra, Verdadero)<BR>Asigna(Info.SeProduce, Falso)<BR>Si(hCompra:hCompra.Directo, Forma(<T>DemandaPendiente<T>), Forma(<T>OfertaPendiente<T>))
ActivoCondicion=MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.R, COMS.C, COMS.O, COMS.OP, COMS.CP, COMS.OG, COMS.OI, COMS.F, COMS.FL, COMS.EG, COMS.EI)) y (hCompra:hCompra.Estatus=EstatusSinAfectar)

[Acciones.VerOpcion]
Nombre=VerOpcion
Boton=0
NombreDesplegar=&Interpretar Opción
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=VerOpcionesArticulo(hCompraD:hCompraD.Articulo, hCompraD:hCompraD.SubCuenta)
ActivoCondicion=ConDatos(hCompraD:hCompraD.SubCuenta) y (hCompraD:Art.TipoOpcion=TipoSi)
Visible=S

[(Carpeta Abrir).Prov.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (hCompra:hCompra.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(hCompra:hCompra.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino

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

[Acciones.Anticipo]
Nombre=Anticipo
Boton=61
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F7
NombreDesplegar=Anticipos...
EnMenu=S
TipoAccion=Expresion
Visible=S
EnBarraHerramientas=S
Expresion=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.Cuenta, hCompra:hCompra.Proveedor)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Rama, <T>CXP<T>)<BR>Asigna(Info.Moneda, hCompra:hCompra.Moneda)<BR>Asigna(Info.TipoCambio, hCompra:hCompra.TipoCambio)<BR>Asigna(Info.Concepto, hCompra:hCompra.Concepto)<BR>Asigna(Info.Proyecto, hCompra:hCompra.Proyecto)<BR>Asigna(Info.PorcentajeImpuesto, Redondea((Suma(hCompraD:Impuesto)/Suma(hCompraD:SubTotal))*100, 2))<BR>Forma(<T>CompraVerAnticipo<T>)
ActivoCondicion=(MovTipo(<T>COMS<T>, hCompra:hCompra.Mov) = COMS.O) y (hCompra:hCompra.Estatus=EstatusPendiente)

[Notas.hCompra.ZonaImpuesto]
Carpeta=Notas
Clave=hCompra.ZonaImpuesto
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hCompraD.DescuentoImporte]
Carpeta=Detalle
Clave=hCompraD.DescuentoImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCompraD.Paquete]
Carpeta=Detalle
Clave=hCompraD.Paquete
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.CopiarOtros]
Nombre=CopiarOtros
Boton=0
Menu=&Archivo
NombreDesplegar=Copiar de Otro Movimiento...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompraDAsignar
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Proveedor, hCompra:hCompra.Proveedor)<BR>Asigna(Info.Nombre, hCompra:Prov.Nombre)

[Acciones.GenerarOT]
Nombre=GenerarOT
Boton=0
Menu=&Archivo
NombreDesplegar=Generar Orden Traspaso
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=EjecutarSQL(<T>spCompraGenerarInv :nID, :nSucursal, :tUsuario, :tMov<T>, hCompra:hCompra.ID, Sucursal, Usuario, ConfigMov.InvOrdenTraspaso)<BR>Informacion(<T>Se Genero <T>+Comillas(ConfigMov.InvOrdenTraspaso)+<T> en Inventarios<T>)
VisibleCondicion=MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.F, COMS.FL, COMS.EG,COMS.EI)) y (hCompra:hCompra.Estatus=EstatusConcluido)

[Notas.hCompra.Idioma]
Carpeta=Notas
Clave=hCompra.Idioma
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ClaveIdioma]
Carpeta=Detalle
Clave=ClaveIdioma
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.hCompra.ListaPreciosEsp]
Carpeta=Ficha
Clave=hCompra.ListaPreciosEsp
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hCompraD.ImportacionProveedor]
Carpeta=Detalle
Clave=hCompraD.ImportacionProveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.hCompraD.ImportacionReferencia]
Carpeta=Detalle
Clave=hCompraD.ImportacionReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Embarcar]
Nombre=Embarcar
Boton=0
Menu=&Archivo
NombreDesplegar=E&mbarcar...
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.Estatus, hCompra:hCompra.Estatus)<BR>Dialogo(<T>MovEmbarcar<T>)
ActivoCondicion=hCompra:hCompra.Estatus noen (EstatusSinAfectar,EstatusBorrador, EstatusSincro, EstatusCancelado) y (no FormaBloqueada)
Visible=S

[Acciones.DesafectarPR]
Nombre=DesafectarPR
Boton=0
Menu=&Archivo
NombreDesplegar=Desafectar
RefrescarDespues=S
EnMenu=S
ConfirmarAntes=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F12
Expresion=EjecutarSQL(<T>spDesAfectarPresupuesto :tModulo, :tMov, :nID<T>, <T>COMS<T>, hCompra:hCompra.Mov, hCompra:hCompra.ID)
ActivoCondicion=Usuario.Desafectar
VisibleCondicion=(MovTipo(<T>COMS<T>, hCompra:hCompra.Mov) = COMS.PR) y (hCompra:hCompra.Estatus = EstatusConcluido)

[Acciones.DesafectarOC]
Nombre=DesafectarOC
Boton=0
Menu=&Archivo
NombreDesplegar=<T>&Desafectar<T>
EnMenu=S
ConfirmarAntes=S
DialogoMensaje=MovDesAfectar
TipoAccion=Expresion
Antes=S
RefrescarDespues=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F12
Expresion=DesAfectar(<T>COMS<T>, hCompra:hCompra.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Compra<T>)
ActivoCondicion=Usuario.Desafectar
AntesExpresiones=Asigna(Afectar.Mov, hCompra:hCompra.Mov)<BR>Asigna(Afectar.MovID, hCompra:hCompra.MovID)
VisibleCondicion=(MovTipo(<T>COMS<T>, hCompra:hCompra.Mov)=COMS.O) y (hCompra:hCompra.Estatus=EstatusPendiente)

[Ficha.hCompra.UEN]
Carpeta=Ficha
Clave=hCompra.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Proyectos]
Nombre=Proyectos
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+Y
NombreDesplegar=Pro&yectos
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyAlm
Antes=S
AntesExpresiones=Asigna(Info.Almacen, hCompraD:hCompraD.Almacen)

[Acciones.ProyInfo]
Nombre=ProyInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del Proyecto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(hCompra:hCompra.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, hCompra:hCompra.Proyecto)
Visible=S

[Detalle.CantidadInvNeta]
Carpeta=Detalle
Clave=CantidadInvNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Ford]
Nombre=Ford
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
NombreDesplegar=Conexión con &Ford...
EnMenu=S
EspacioPrevio=S
TipoAccion=Dialogos
ClaveAccion=FordCompras
ActivoCondicion=hCompra:hCompra.Estatus en (EstatusPendiente, EstatusCancelado)
Antes=S
AntesExpresiones=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.Estatus, hCompra:hCompra.Estatus)
VisibleCondicion=General.Ford y (MovTipo(<T>COMS<T>, hCompra:hCompra.Mov) = COMS.O)

[Acciones.TablaProrrateo]
Nombre=TablaProrrateo
Boton=0
Menu=&Edición
NombreDesplegar=Tabla &Prorrateo...
EnMenu=S
TipoAccion=Expresion
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+K
Expresion=Si <BR>  hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>Entonces<BR>  Si(Forma(<T>CompraDProrrateo<T>), Si((hCompraD:hCompraD.Cantidad<>Info.Cantidad) y (Info.Cantidad>0), Asigna(hCompraD:hCompraD.CantidadInventario, Info.Cantidad*hCompraD:hCompraD.CantidadInventario/hCompraD:hCompraD.Cantidad) Asigna(hCompraD:hCompraD.Cantidad, Info.Cantidad)))<BR>Sino<BR>  Forma(<T>CompraDProrrateoInfo<T>)<BR>Fin
ActivoCondicion=MovTipo(<T>COMS<T>, hCompra:hCompra.Mov) = COMS.OP
AntesExpresiones=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.RenglonID, hCompraD:hCompraD.RenglonID)<BR>Asigna(Info.Articulo, hCompraD:hCompraD.Articulo)<BR>Asigna(Info.SubCuenta, hCompraD:hCompraD.SubCuenta)<BR>Asigna(Info.Unidad, hCompraD:hCompraD.Unidad)<BR>Asigna(Info.Cantidad, hCompraD:hCompraD.Cantidad)<BR>Asigna(Info.CantidadInventario, hCompraD:hCompraD.CantidadInventario)
VisibleCondicion=MovTipo(<T>COMS<T>, hCompra:hCompra.Mov) = COMS.OP

[Acciones.ImprimirJuego]
Nombre=ImprimirJuego
Boton=0
Menu=&Archivo
NombreDesplegar=Imprimir Juego...
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=ImprimirCompraProrrateada
Antes=S
ActivoCondicion=(hCompra:hCompra.Estatus = EstatusConcluido) y Usuario.ImprimirMovs
AntesExpresiones=Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)
VisibleCondicion=MovTipo(<T>COMS<T>, hCompra:hCompra.Mov) = COMS.OP

[Acciones.ActualizarZonaImpuestos]
Nombre=ActualizarZonaImpuestos
Boton=0
Menu=&Archivo
NombreDesplegar=Actualizar &Zona Impuestos
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Activo=S
GuardarAntes=S
Expresion=EjecutarSQL(<T>spActualizarZonaImpuestos :tModulo, :nID<T>, <T>COMS<T>, hCompra:hCompra.ID)
VisibleCondicion=hCompra:hCompra.Estatus=EstatusSinAfectar

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.Clave, <T>COMS<T>+hCompra:hCompra.ID)<BR>Asigna(Info.Nombre, hCompra:hCompra.Mov+<T> <T>+hCompra:hCompra.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(hCompra:hCompra.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Detalle.hCompraD.FechaCaducidad]
Carpeta=Detalle
Clave=hCompraD.FechaCaducidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.DetalleEvaluacion]
Nombre=DetalleEvaluacion
Boton=0
NombreDesplegar=E&valuación
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Clave, <T>COMS<T>+hCompra:hCompra.ID+<T>.<T>+hCompraD:hCompraD.RenglonID)<BR>Asigna(Info.Nombre, hCompraD:hCompraD.Articulo+<T> - <T>+hCompraD:Art.Descripcion1)<BR>Asigna(Info.Aplica, <T>Articulos<T>)<BR>Forma(Si(hCompra:hCompra.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Acciones.AsistenteRecepcion]
Nombre=AsistenteRecepcion
Boton=0
Menu=&Edición
NombreDesplegar=Asistente &Recepción
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovCodigo
Antes=S
DespuesGuardar=S
Activo=S
RefrescarDespues=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+F7
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)
VisibleCondicion=(MovTipo(<T>COMS<T>, hCompra:hCompra.Mov) = COMS.O) y (hCompra:hCompra.Estatus=EstatusPendiente)

[Acciones.Autorizar]
Nombre=Autorizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F12
NombreDesplegar=A&utorizar
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovAutorizar
Antes=S
GuardarAntes=S
RefrescarDespues=S
DespuesGuardar=S
ActivoCondicion=Vacio(hCompra:hCompra.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Compra<T>)<BR>Asigna(Afectar.Modulo, <T>COMS<T>)<BR>Asigna(Afectar.ID, hCompra:hCompra.ID)<BR>Asigna(Afectar.Mov, hCompra:hCompra.Mov)<BR>Asigna(Afectar.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.Descripcion, hCompra:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(hCompra:hCompra.Mensaje)

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tareas
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.PuedeEditar, hCompra:hCompra.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.Proyecto, hCompra:hCompra.Proyecto)<BR>Asigna(Info.UEN, hCompra:hCompra.UEN)<BR>Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, hCompra:hCompra.Proveedor)<BR>Asigna(Info.Agente, hCompra:hCompra.Agente)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Notas.hCompra.FormaEntrega]
Carpeta=Notas
Clave=hCompra.FormaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=65
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Agenda]
Nombre=Agenda
Boton=0
Menu=&Archivo
NombreDesplegar=Agen&da...
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovAgenda
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.PuedeEditar, hCompra:hCompra.Estatus en (EstatusSinAfectar,EstatusBorrador, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente))<BR>Asigna(Info.Fecha, hCompra:hCompra.FechaEntrega)

[Acciones.MovRecibo]
Nombre=MovRecibo
Boton=0
Menu=&Edición
NombreDesplegar=Asistente &Recepción
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Ctrl+F8
RefrescarDespues=S
Activo=S
Antes=S
Expresion=Asigna(Info.ID, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Proveedor, hCompra:hCompra.Proveedor)<BR>Asigna(Info.Almacen, hCompra:hCompra.Almacen)<BR>Si <BR>  Si<BR>    hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>  Entonces<BR>    Forma(<T>CompraPendienteProveedor<T>)<BR>  Sino<BR>    Asigna(Info.Mov, hCompra:hCompra.Origen) <BR>    Asigna(Info.MovID, hCompra:hCompra.OrigenID)<BR>    Verdadero<BR>  Fin<BR>Entonces<BR>  Asigna(Info.Modulo, <T>COMS<T>)<BR>  Asigna(Info.ID, hCompra:hCompra.ID)<BR>  Asigna(Info.Cuenta, hCompra:hCompra.Proveedor)<BR>  Asigna(Info.Fecha, hCompra:hCompra.FechaEmision)<BR>  Asigna(Afectar.ID, Nulo)<BR>  Asigna(Afectar.ID, SQL(<T>SELECT ID FROM Compra WHERE Empresa=:tEmpresa AND Mov=:tMov AND MovID=:tMovID AND Estatus=:tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>  Forma(<T>MovRecibo<T>)<BR>Fin
AntesExpresiones=Asigna(Info.PuedeEditar, hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))
VisibleCondicion=MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.F, COMS.FL, COMS.EG, COMS.EI))

[Acciones.MovImpuesto]
Nombre=MovImpuesto
Boton=0
Menu=&Ver
NombreDesplegar=&Impuestos
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovImpuesto
Activo=S
Antes=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)
VisibleCondicion=(hCompra:hCompra.Estatus en (EstatusConcluido, EstatusPendiente, EstatusCancelado)) y MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.F, COMS.FL, COMS.EG, COMS.EI, COMS.D, COMS.B))

[Acciones.ProrratearExistencia]
Nombre=ProrratearExistencia
Boton=0
Menu=&Archivo
NombreDesplegar=Prorratear en Base a &Existencia...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtExistenciaProrratear
Antes=S
Visible=S
DespuesGuardar=S
ActivoCondicion=(hCompra:hCompra.Estatus=EstatusSinAfectar) y MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.B, COMS.CA))
AntesExpresiones=Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Almacen, hCompra:hCompra.Almacen)

[Ficha.hCompra.CancelarPendiente]
Carpeta=Ficha
Clave=hCompra.CancelarPendiente
Editar=S
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hCompraD.Codigo]
Carpeta=Detalle
Clave=hCompraD.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.CB]
Nombre=CB
Boton=0
Menu=&Ver
NombreDesplegar=Códigos Barras
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=CBMov
ListaParametros1=Info.Modulo<BR>Info.ID
ListaParametros=S
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)
VisibleCondicion=hCompra:hCompra.Estatus=EstatusConcluido

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
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>Asigna(Info.Fecha, hCompra:hCompra.FechaEmision)<BR>Asigna(Info.Estatus, hCompra:hCompra.Estatus)

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
EjecucionCondicion=ConDatos(hCompra:hCompra.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>COMS<T>)<BR>Asigna(Info.Clave, hCompra:hCompra.Mov)

[Acciones.PoliticaConcepto]
Nombre=PoliticaConcepto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+N
NombreDesplegar=Política Co&ncepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(hCompra:hCompra.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.Concepto, hCompra:hCompra.Concepto)

[AC]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Crédito
Clave=AC
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hCompra
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
CondicionVisible=General.AC y MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.R, COMS.C, COMS.O, COMS.OP, COMS.OG, COMS.OI, COMS.F, COMS.FL, COMS.EG, COMS.EI))

[AC.hCompra.LineaCredito]
Carpeta=AC
Clave=hCompra.LineaCredito
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

[AC.LC.VigenciaDesde]
Carpeta=AC
Clave=LC.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Tamano=20
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

[AC.hCompra.TipoAmortizacion]
Carpeta=AC
Clave=hCompra.TipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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

[AC.hCompra.TipoTasa]
Carpeta=AC
Clave=hCompra.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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

[AC.hCompra.Condicion]
Carpeta=AC
Clave=hCompra.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.hCompra.Vencimiento]
Carpeta=AC
Clave=hCompra.Vencimiento
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
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+M
NombreDesplegar=Tabla Amortización
EnMenu=S
TipoAccion=Expresion
Activo=S
GuardarAntes=S
Expresion=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)<BR>Si(hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar), EjecutarSQL(<T>spTablaAmortizacion :tModulo, :nID, :tUsuario<T>, Info.Modulo, Info.ID, Usuario))<BR>Forma(<T>TablaAmortizacion<T>)
VisibleCondicion=General.AC y MovTipoEn(<T>COMS<T>, hCompra:hCompra.Mov, (COMS.R, COMS.C, COMS.O, COMS.OP, COMS.OG, COMS.OI, COMS.F, COMS.FL, COMS.EG, COMS.EI))

[AC.hCompra.Comisiones]
Carpeta=AC
Clave=hCompra.Comisiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AC.hCompra.ComisionesIVA]
Carpeta=AC
Clave=hCompra.ComisionesIVA
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

[Detalle.hCompraD.Descuento]
Carpeta=Detalle
Clave=hCompraD.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.Ejercido]
Carpeta=Detalle
Clave=Ejercido
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Rojo obscuro
Efectos=[Negritas]

[Detalle.Pendiente]
Carpeta=Detalle
Clave=Pendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Azul
Efectos=[Negritas]

[Detalle.Disponible]
Carpeta=Detalle
Clave=Disponible
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

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
Expresion=Asigna(Info.Forma, <T>Compra<T>)<BR>Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.Nombre, <T>Compras<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

[Detalle.hCompraD.ProveedorArt]
Carpeta=Detalle
Clave=hCompraD.ProveedorArt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.hCompraD.ProveedorArtCosto]
Carpeta=Detalle
Clave=hCompraD.ProveedorArtCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCompraD.Posicion]
Carpeta=Detalle
Clave=hCompraD.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Notas.hCompra.VIN]
Carpeta=Notas
Clave=hCompra.VIN
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hCompra.AutoCargos]
Carpeta=Notas
Clave=hCompra.AutoCargos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=0
Menu=&Edición
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
RefrescarDespues=S
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>COMS<T>, hCompra:hCompra.Mov, hCompra:hCompra.ID, Falso, hCompra:hCompra.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>COMS<T>+hCompra:hCompra.ID)<BR>  Asigna(Info.Nombre, hCompra:hCompra.Mov+<T> <T>+hCompra:hCompra.MovID)<BR>  Asigna(Info.Modulo, <T>COMS<T>)<BR>  Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Acciones.ImportarPDT]
Nombre=ImportarPDT
Boton=0
Menu=&Archivo
NombreDesplegar=Importar &PDT...
EnMenu=S
TipoAccion=Expresion
GuardarAntes=S
RefrescarDespues=S
Expresion=PlugIn(<T>PDT<T>, <T>COMS<T>, hCompra:hCompra.ID)
ActivoCondicion=hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[AC.hCompra.TieneTasaEsp]
Carpeta=AC
Clave=hCompra.TieneTasaEsp
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[AC.hCompra.TasaEsp]
Carpeta=AC
Clave=hCompra.TasaEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hCompra.Cliente]
Carpeta=Notas
Clave=hCompra.Cliente
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hCompraD.ValorAduana]
Carpeta=Detalle
Clave=hCompraD.ValorAduana
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCompraD.Pais]
Carpeta=Detalle
Clave=hCompraD.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.hCompraD.ImportacionImpuesto1]
Carpeta=Detalle
Clave=hCompraD.ImportacionImpuesto1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCompraD.ImportacionImpuesto2]
Carpeta=Detalle
Clave=hCompraD.ImportacionImpuesto2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hCompraD.ID1]
Carpeta=Detalle
Clave=hCompraD.ID1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Detalle.hCompraD.ID2]
Carpeta=Detalle
Clave=hCompraD.ID2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Detalle.hCompraD.FormaPago]
Carpeta=Detalle
Clave=hCompraD.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

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
ClaveAccion=FormaAnexoMov
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Mov, hCompra:hCompra.Mov)<BR>Asigna(Info.MovID, hCompra:hCompra.MovID)
DespuesGuardar=S
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
ActivoCondicion=Usuario.EnviarExcel y (hCompra:hCompra.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Ficha.hCompra.Actividad]
Carpeta=Ficha
Clave=hCompra.Actividad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
HojaVistaOmision=Automática
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
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>COMS<T>, <T>{hCompra:hCompra.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>COMS{hCompra:hCompra.ID}<T>

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
VerCampo=360
VerValor=360

[Detalle.hCompraD.PresupuestoEsp]
Carpeta=Detalle
Clave=hCompraD.PresupuestoEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.PresupuestoEsp]
Nombre=PresupuestoEsp
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+P
NombreDesplegar=Presupuesto Especifico
EnMenu=S
TipoAccion=Formas
ClaveAccion=CompraDPresupuestoEsp
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=hCompraD:hCompraD.PresupuestoEsp y ConDatos(hCompraD:hCompraD.Articulo)
AntesExpresiones=Asigna(Info.PuedeEditar, hCompra:hCompra.Estatus=EstatusSinAfectar)<BR>Asigna(Info.Importe, hCompraD:ImporteTotal)<BR>Asigna(Info.ID, hCompra:hCompra.ID)<BR>Asigna(Info.Renglon, hCompraD:hCompraD.Renglon)<BR>Asigna(Info.RenglonSub, hCompraD:hCompraD.RenglonSub)<BR>Asigna(Info.Articulo, hCompraD:hCompraD.Articulo)<BR>Asigna(Info.Concepto, Nulo)
VisibleCondicion=General.PPTO




[Ficha.ListaEnCaptura]
(Inicio)=hCompra.Mov
hCompra.Mov=hCompra.MovID
hCompra.MovID=hCompra.Proyecto
hCompra.Proyecto=hCompra.UEN
hCompra.UEN=hCompra.Moneda
hCompra.Moneda=hCompra.TipoCambio
hCompra.TipoCambio=hCompra.FechaEmision
hCompra.FechaEmision=hCompra.Actividad
hCompra.Actividad=hCompra.FechaRequerida
hCompra.FechaRequerida=hCompra.Concepto
hCompra.Concepto=hCompra.Agente
hCompra.Agente=hCompra.FechaEntrega
hCompra.FechaEntrega=hCompra.Proveedor
hCompra.Proveedor=Prov.Nombre
Prov.Nombre=hCompra.ListaPreciosEsp
hCompra.ListaPreciosEsp=hCompra.Descuento
hCompra.Descuento=hCompra.Condicion
hCompra.Condicion=hCompra.Vencimiento
hCompra.Vencimiento=hCompra.Referencia
hCompra.Referencia=hCompra.Almacen
hCompra.Almacen=hCompra.FormaEnvio
hCompra.FormaEnvio=hCompra.Directo
hCompra.Directo=hCompra.VerDestino
hCompra.VerDestino=hCompra.CancelarPendiente
hCompra.CancelarPendiente=(Fin)



[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Desc
Desc=Sub total
Sub total=Impuestos
Impuestos=Total
Total=Conteo
Conteo=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=hCompra.Proveedor
hCompra.Proveedor=Prov.Nombre
Prov.Nombre=hCompra.Referencia
hCompra.Referencia=hCompra.FechaEmision
hCompra.FechaEmision=hCompra.FechaRequerida
hCompra.FechaRequerida=ImporteTotal
ImporteTotal=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=(por Autorizar)
(por Autorizar)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=AUTORIZARE
AUTORIZARE=PENDIENTE
PENDIENTE=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirMostrar
AbrirMostrar=(Fin)

[Notas.ListaEnCaptura]
(Inicio)=hCompra.Observaciones
hCompra.Observaciones=hCompra.Instruccion
hCompra.Instruccion=hCompra.Prioridad
hCompra.Prioridad=hCompra.Atencion
hCompra.Atencion=hCompra.ZonaImpuesto
hCompra.ZonaImpuesto=hCompra.AutoCargos
hCompra.AutoCargos=hCompra.FormaEntrega
hCompra.FormaEntrega=hCompra.Idioma
hCompra.Idioma=hCompra.Cliente
hCompra.Cliente=hCompra.Causa
hCompra.Causa=hCompra.VIN
hCompra.VIN=(Fin)

[AC.ListaEnCaptura]
(Inicio)=hCompra.LineaCredito
hCompra.LineaCredito=LC.Descripcion
LC.Descripcion=LC.VigenciaDesde
LC.VigenciaDesde=LC.VigenciaHasta
LC.VigenciaHasta=hCompra.TipoAmortizacion
hCompra.TipoAmortizacion=TipoAmortizacion.Descripcion
TipoAmortizacion.Descripcion=hCompra.Condicion
hCompra.Condicion=hCompra.Vencimiento
hCompra.Vencimiento=hCompra.TipoTasa
hCompra.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=hCompra.TieneTasaEsp
hCompra.TieneTasaEsp=hCompra.TasaEsp
hCompra.TasaEsp=hCompra.Comisiones
hCompra.Comisiones=hCompra.ComisionesIVA
hCompra.ComisionesIVA=TotalComisiones
TotalComisiones=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)








































































































































[Detalle.ResumenCampos]
(Inicio)=Articulo
Articulo=Descripcion
Descripcion=Cantidad
Cantidad=Costo
Costo=DescuentoLinea
DescuentoLinea=Importe
Importe=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=hCompraD.ImportacionProveedor
hCompraD.ImportacionProveedor=hCompraD.ImportacionReferencia
hCompraD.ImportacionReferencia=hCompraD.Aplica
hCompraD.Aplica=hCompraD.AplicaID
hCompraD.AplicaID=AplicaNombre
AplicaNombre=hCompraD.Destino
hCompraD.Destino=hCompraD.DestinoID
hCompraD.DestinoID=DestinoNombre
DestinoNombre=hCompraD.Codigo
hCompraD.Codigo=hCompraD.Articulo
hCompraD.Articulo=hCompraD.SubCuenta
hCompraD.SubCuenta=ClaveProveedor
ClaveProveedor=ClaveIdioma
ClaveIdioma=hCompraD.Cantidad
hCompraD.Cantidad=CantidadNeta
CantidadNeta=hCompraD.Unidad
hCompraD.Unidad=hCompraD.CantidadInventario
hCompraD.CantidadInventario=CantidadInvNeta
CantidadInvNeta=hCompraD.Costo
hCompraD.Costo=hCompraD.ValorAduana
hCompraD.ValorAduana=hCompraD.CostoInv
hCompraD.CostoInv=hCompraD.Descuento
hCompraD.Descuento=hCompraD.DescuentoLinea
hCompraD.DescuentoLinea=hCompraD.DescuentoImporte
hCompraD.DescuentoImporte=Importe
Importe=hCompraD.PresupuestoEsp
hCompraD.PresupuestoEsp=Ejercido
Ejercido=Pendiente
Pendiente=hCompraD.Pais
hCompraD.Pais=hCompraD.ImportacionImpuesto1
hCompraD.ImportacionImpuesto1=hCompraD.ImportacionImpuesto2
hCompraD.ImportacionImpuesto2=Disponible
Disponible=hCompraD.ProveedorArt
hCompraD.ProveedorArt=hCompraD.ProveedorArtCosto
hCompraD.ProveedorArtCosto=hCompraD.ContUso
hCompraD.ContUso=hCompraD.FechaRequerida
hCompraD.FechaRequerida=hCompraD.FechaEntrega
hCompraD.FechaEntrega=hCompraD.FechaCaducidad
hCompraD.FechaCaducidad=hCompraD.Cliente
hCompraD.Cliente=hCompraD.Almacen
hCompraD.Almacen=hCompraD.Posicion
hCompraD.Posicion=hCompraD.ReferenciaExtra
hCompraD.ReferenciaExtra=hCompraD.DescripcionExtra
hCompraD.DescripcionExtra=hCompraD.Paquete
hCompraD.Paquete=hCompraD.ID1
hCompraD.ID1=hCompraD.ID2
hCompraD.ID2=hCompraD.FormaPago
hCompraD.FormaPago=hCompraD.CantidadPendiente
hCompraD.CantidadPendiente=hCompraD.CantidadA
hCompraD.CantidadA=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=Art.Tipo
Art.Tipo=Art.PrecioLista
Art.PrecioLista=Art.UnidadCompra
Art.UnidadCompra=(Fin)

[Detalle.ListaOrden]
(Inicio)=hCompraD.Renglon	(Acendente)
hCompraD.Renglon	(Acendente)=hCompraD.RenglonSub	(Acendente)
hCompraD.RenglonSub	(Acendente)=(Fin)

[Detalle.ListaAcciones]
(Inicio)=CopiarPendiente
CopiarPendiente=Observaciones
Observaciones=VerOpcion
VerOpcion=Proyectos
Proyectos=DetalleEvaluacion
DetalleEvaluacion=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=AC
AC=Notas
Notas=Detalle
Detalle=FormaExtraValor
FormaExtraValor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=MovPersonal
MovPersonal=Evaluaciones
Evaluaciones=Propiedades
Propiedades=Imprimir
Imprimir=ImprimirJuego
ImprimirJuego=RepPantalla
RepPantalla=PlantillasOffice
PlantillasOffice=FormasAnexas
FormasAnexas=Excel
Excel=Ford
Ford=ActualizarZonaImpuestos
ActualizarZonaImpuestos=Verificar
Verificar=Situacion
Situacion=Sucursal
Sucursal=Afectar
Afectar=Autorizar
Autorizar=DesafectarPR
DesafectarPR=DesafectarOC
DesafectarOC=Eliminar
Eliminar=Importar
Importar=ImportarPDT
ImportarPDT=Prorratear
Prorratear=ProrratearExistencia
ProrratearExistencia=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=Cambiar Vista Hoja
Cambiar Vista Hoja=CopiarPendientes
CopiarPendientes=CopiarOtros
CopiarOtros=Embarcar
Embarcar=Agenda
Agenda=GenerarOT
GenerarOT=Sugerir
Sugerir=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=Asistente Articulos
Asistente Articulos=Asistente Codigo Barras
Asistente Codigo Barras=AsistenteRecepcion
AsistenteRecepcion=MovRecibo
MovRecibo=Asistente Codigo Barras (en Lote)
Asistente Codigo Barras (en Lote)=SeriesLotes
SeriesLotes=TablaProrrateo
TablaProrrateo=AsignarPedimento
AsignarPedimento=GastosDiversos
GastosDiversos=Tareas
Tareas=Anexos
Anexos=AnexosDetalle
AnexosDetalle=Anticipo
Anticipo=ArtExpress
ArtExpress=Embarque
Embarque=PresupuestoEsp
PresupuestoEsp=Anterior
Anterior=Siguiente
Siguiente=Catalogos
Catalogos=ArtListaDisponible
ArtListaDisponible=CB
CB=Disponible
Disponible=ArtInfo
ArtInfo=ProvInfo
ProvInfo=ProyInfo
ProyInfo=MovImpuesto
MovImpuesto=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=TablaAmortizacion
TablaAmortizacion=MovPos
MovPos=Navegador
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
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
