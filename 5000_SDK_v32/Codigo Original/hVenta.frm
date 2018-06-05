[Forma]
Clave=hVenta
Nombre=<T>Histórico <T> + Info.ModuloVentasNombre
Icono=0
Modulos=VTAS
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=118
PosicionInicialArriba=86
PosicionInicialAltura=579
PosicionInicialAncho=802
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
PosicionInicialAlturaCliente=561
Totalizadores=S
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Positivos, Verdadero)<BR>Asigna(Info.Paquete, Nulo)<BR>Asigna(Info.RefrescandoPrecio, Falso)
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Aseguradora, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
PosicionSec1=243
PosicionSec2=461
EsConsultaExclusiva=S

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
Vista=hVenta
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

[Ficha.hVenta.Mov]
Carpeta=Ficha
Clave=hVenta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.MovID]
Carpeta=Ficha
Clave=hVenta.MovID
3D=S
Pegado=S
Tamano=11
ColorFondo=Plata
Editar=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.hVenta.Proyecto]
Carpeta=Ficha
Clave=hVenta.Proyecto
Editar=S
ValidaNombre=S
3D=S
Tamano=15
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.Moneda]
Carpeta=Ficha
Clave=hVenta.Moneda
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.FechaEmision]
Carpeta=Ficha
Clave=hVenta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.Almacen]
Carpeta=Ficha
Clave=hVenta.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.Cliente]
Carpeta=Ficha
Clave=hVenta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

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
ColorFuente=Negro

[Ficha.hVenta.Condicion]
Carpeta=Ficha
Clave=hVenta.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.Vencimiento]
Carpeta=Ficha
Clave=hVenta.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.Agente]
Carpeta=Ficha
Clave=hVenta.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Notas.hVenta.Referencia]
Carpeta=Notas
Clave=hVenta.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25

[Notas.hVenta.Observaciones]
Carpeta=Notas
Clave=hVenta.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.Descuento]
Carpeta=Ficha
Clave=hVenta.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.OrdenCompra]
Carpeta=Ficha
Clave=hVenta.OrdenCompra
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.Referencia]
Carpeta=Ficha
Clave=hVenta.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=hVentaD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=hVenta
LlaveLocal=hVentaD.ID
LlaveMaestra=hVenta.ID
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
ControlRenglon=S
CampoRenglon=hVentaD.Renglon
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
ResumenCampos=Articulo<BR>Descripcion<BR>Cantidad<BR>Precio<BR>DescuentoLinea<BR>Importe<BR>Almacen
ResumenVistaMaestra=hVenta
ResumenLlaveMaestra=hVenta.ID
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

[Detalle.hVentaD.Articulo]
Carpeta=Detalle
Clave=hVentaD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.SubCuenta]
Carpeta=Detalle
Clave=hVentaD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Detalle.hVentaD.Cantidad]
Carpeta=Detalle
Clave=hVentaD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.Precio]
Carpeta=Detalle
Clave=hVentaD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
IgnoraFlujo=N
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
Costo=75
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
SubImpuesto1=76
SubImpuesto2=72
SubImpuesto3=66
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

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=hVentaA
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
ListaOrden=hVenta.ID<TAB>(Decendente)
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
FiltroFechasCampo=hVenta.FechaEmision
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
FiltroAplicaEn=hVenta.Moneda
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
BusquedaRespetarControlesNum=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=hVenta.FechaCancelacion
FiltroSucursales=S
FiltroUENsCampo=hVenta.UEN
FiltroAutorizar=S
IconosNombre=hVentaA:hVenta.Mov+<T> <T>+hVentaA:hVenta.MovID
FiltroGeneral={Si(SQL(<T>SELECT ISNULL(Filtrar, 0) FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSub<T>, <T>VTAS<T>, Info.SubModuloVenta), <T>hVenta.SubModulo=<T>+Comillas(Info.SubModuloVenta), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Mov), <T> AND hVenta.Mov=<T>+Comillas(Filtro.Mov), <T><T>)}<BR>{Si<BR>  ConDatos(Filtro.Cliente) y ConDatos(Filtro.Aseguradora)<BR>Entonces<BR>  <T> AND hVenta.Cliente IN (<T>+Comillas(Filtro.Cliente)+<T>, <T>+Comillas(Filtro.Aseguradora)+<T>)<T><BR>Sino<BR>  Si(ConDatos(Filtro.Cliente), <T> AND hVenta.Cliente=<T>+Comillas(Filtro.Cliente), <T><T>)<BR>Fin}

[(Carpeta Abrir).hVenta.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=hVenta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=138
1=69

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
Totalizadores1=Importe<BR>Desc<BR>Sub total<BR>Impuestos<BR>Total<BR>Renglon
Totalizadores2=Suma(hVentaD:Importe)<BR>-Suma(hVentaD:DescGlobal)<BR>Suma(hVentaD:SubTotal)<BR>Suma(hVentaD:Impuesto)<BR>Redondea(Suma(hVentaD:ImporteTotal), Config.VentaCobroRedondeoDecimales)-hVenta:hVenta.AnticiposFacturados-hVenta:hVenta.Retencion<BR>Conteo(hVentaD:hVentaD.Articulo)
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
EjecucionCondicion=ConDatos(hVenta:hVenta.Cliente) y ConDatos(hVenta:hVenta.Almacen)
AntesExpresiones=Asigna(hVenta:hVenta.Importe, Suma(hVentaD:Importe))<BR>Asigna(hVenta:hVenta.Impuestos, Suma(hVentaD:Impuesto))

[Ficha.hVenta.FechaRequerida]
Carpeta=Ficha
Clave=hVenta.FechaRequerida
Editar=S
ValidaNombre=S
3D=S
Tamano=15
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro
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
NombreDesplegar=Asistente Artículos
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=hVentaD:hVentaD.Articulo<BR>hVentaD:hVentaD.Almacen<BR>hVentaD:hVentaD.SubCuenta<BR>hVentaD:hVentaD.Cantidad<BR>hVentaD:hVentaD.Precio<BR>MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.D,VTAS.DF,VTAS.B,VTAS.DC,VTAS.DCR))<BR>Nulo<BR>MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.SG,VTAS.EG,VTAS.VC,VTAS.VCR))<BR>MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.P,VTAS.S,VTAS.PR,VTAS.EST))<BR>hVentaD:Art.Descripcion1<BR>hVentaD:Art.Tipo<BR>hVentaD:Art.Unidad<BR>hVentaD:Art.PrecioLista<BR>hVentaD:Art.TipoOpcion<BR>hVentaD:Art.Espacios<BR>hVentaD:hVentaD.FechaRequerida<BR>hVentaD:hVentaD.HoraRequerida<BR>hVentaD:hVentaD.Espacio<BR><T>VTAS<T><BR>hVenta:hVenta.ID<BR>hVenta:hVenta.Cliente
ListaParametros=S
Visible=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F7
EspacioPrevio=S
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

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
Vista=hVenta
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
CondicionEdicion=Vacio(hVenta:hVenta.AnexoID)

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
Expresion=Si(General.OFER, EjecutarSQL(<T>spOfertaAplicar :nID<T>, hVenta:hVenta.ID))
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Detalle.hVentaD.CantidadA]
Carpeta=Detalle
Clave=hVentaD.CantidadA
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=Si<BR>  Config.VentaActualizarPrecioMoneda y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y SQL(<T>spVentaActualizarPreciosChecar :nID<T>, hVenta:hVenta.ID) <BR>Entonces<BR>  Caso Confirmacion(<T>¿ Desea Actualizar los Precios Otras Monedas ?<T>, BotonSi, BotonNo, BotonCancelar)<BR>    Es BotonSi Entonces EjecutarSQL(<T>spVentaActualizarPrecios :nID<T>, hVenta:hVenta.ID) AbortarOperacion<BR>    Es BotonCancelar Entonces AbortarOperacion<BR>  Fin<BR>Fin<BR><BR>Si(General.OFER, EjecutarSQL(<T>spOfertaAplicar :nID<T>, hVenta:hVenta.ID))<BR>Si<BR>  (hVenta:hVenta.Mov=Info.MovProcesar) y (hVenta:hVenta.Estatus=EstatusSinAfectar)<BR>Entonces<BR>  EjecutarSQL(<T>xpVentaAutoProcesar :nID<T>, hVenta:hVenta.ID)<BR>Sino<BR>  Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>  Asigna(Afectar.ID, hVenta:Venta.ID)<BR>  Asigna(Afectar.Mov, hVenta:hVenta.Mov)<BR>  Asigna(Afectar.MovID, hVenta:hVenta.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>  Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov))<BR>  Asigna(Info.Cliente, hVenta:hVenta.Cliente)<BR>  Asigna(Info.Moneda, hVenta:hVenta.Moneda)<BR>  Asigna(Info.TipoCambio, hVenta:hVenta.TipoCambio)<BR>  Asigna(Info.Importe, Redondea(Suma(hVentaD:Importe)+Suma(hVentaD:Impuesto)-Suma(hVentaD:DescGlobal)-(hVenta:hVenta.AnticiposFacturados+hVenta:hVenta.Retencion), Config.VentaCobroRedondeoDecimales))<BR>  Si <BR>    (Info.Importe<>0) y<BR>    (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y<BR>    ((MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.N, VTAS.FM)) y (ConDatos(hVenta:hVenta.MovID) o Config.VentaLiquidaIntegral) y (hVenta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>)) o<BR>    (MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.P, VTAS.VP, VTAS.SD, VTAS.B))  y (hVenta:Condicion.ControlAnticipos=<T>Cobrar Pedido<T>)) o<BR>    (MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.F, VTAS.FAR, VTAS.FB, VTAS.D, VTAS.DF)) y (hVenta:hVenta.Vencimiento<=hVenta:hVenta.FechaEmision) y Config.FacturaCobroIntegrado y (hVenta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>) y (hVenta:hVenta.OrigenTipo<><T>VMOS<T>)))<BR>  Entonces<BR>    Asigna(Info.ID, hVenta:hVenta.ID)<BR>    Asigna(Info.Cerrado, Falso)<BR>    Asigna(Info.VentaCobroDevolucion, MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.VP, VTAS.SD, VTAS.B, VTAS.D, VTAS.DF)))<BR>    Forma(<T>VentaCobro<T>)<BR>  Sino<BR>    Si <BR>      (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) o ((MovTipo(<T>VTAS<T>,hVenta:hVenta.Mov)=VTAS.S) y (hVenta:hVenta.Estatus=EstatusPorConfirmar))<BR>    Entonces<BR>      Si(Config.CompraVentaSinIVA y (Suma(hVentaD:Impuesto)=0.0) y (Suma(hVentaD:Importe)>0.0), Si(Confirmacion(<T>Movimiento sin Impuestos<T>+NuevaLinea+<T>¿ Es Correcto ?<T>,BotonSi,BotonNo)=BotonNo,AbortarOperacion))<BR><BR>      Si<BR>        Empresa.CFD y SQL(<T>spVerMovTipoCFD :tEmpresa, :tModulo, :tMov<T>, Empresa, Afectar.Modulo, Afectar.Mov)<BR>      Entonces<BR>        EjecutarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, Afectar.Modulo, Afectar.ID, <T>CONSECUTIVO<T>)<BR>        Si(no CFD.Generar(Afectar.Modulo, Afectar.ID), AbortarOperacion)<BR>        Asigna(Afectar.EnviarCFD, SQL(<T>SELECT EnviarAlAfectar FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>, Empresa))<BR>      Fin<BR><BR>      Si<BR>        hVenta:hVenta.Estatus=EstatusPorConfirmar       <BR>      Entonces<BR>        Caso MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)<BR>          Es VTAS.S  Entonces Dialogo(<T>GenerarServicioPorConfirmar<T>)<BR>          Es VTAS.CS Entonces Dialogo(<T>GenerarCotizacionServicio<T>)<BR>          Es VTAS.C  Entonces <BR>                      Si (hVenta:hVenta.OrigenTipo=<T>VTAS<T>) y (MovTipo(<T>VTAS<T>, hVenta:hVenta.Origen)=VTAS.S)<BR>                       Entonces<BR>                         Asigna(Afectar.Mov, hVenta:hVenta.Origen)<BR>                         Asigna(Afectar.MovID, hVenta:hVenta.OrigenID)<BR>                         Asigna(Afectar.ID, SQL(<T>SELECT ID FROM Venta WHERE Empresa = :tEmpresa AND Mov = :tMov AND MovID = :tMovID AND Estatus NOT IN (<T>+Comillas(EstatusSinAfectar)+<T>, <T>+Comillas(EstatusCancelado)+<T>)<T>, Empresa, Afectar.Mov, Afectar.MovID))<BR>                         Dialogo(<T>AfectarServicio<T>)<BR>                       Sino<BR>                         Dialogo(<T>GenerarCotizacion<T>)<BR>                     Fin<BR>          Es VTAS.CO Entonces Dialogo(<T>GenerarContrato<T>)<BR>          Sino Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>        Fin<BR>      Sino<BR>        Si <BR>          Config.Partidas y (MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)=VTAS.R)<BR>        Entonces<BR>          Forma(<T>AfectarPartidasRemision<T>)<BR>        Sino<BR>          Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>        Fin<BR>      Fin<BR><BR>      Si <BR>        Afectar.EnviarCFD<BR>      Entonces<BR>        CFD.Enviar(Afectar.Modulo, Afectar.ID)<BR>      Fin<BR><BR>    Sino<BR>      Asigna(Info.Modulo, <T>VTAS<T>)<BR>      Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>      Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>      Asigna(Afectar.Base, <T>Pendiente<T>)<BR>      Asigna(Afectar.GenerarMov, <T><T>)<BR>      Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>      Si<BR>        (ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T>) y (no MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.F, VTAS.FAR, VTAS.FB)))<BR>      Entonces<BR>        Si <BR>          Forma(<T>GenerarMovFlujo<T>)<BR>        Entonces<BR>          Caso Info.MovGenerar<BR>            Es <T>(Reservar)<T>    Entonces Si(Usuario.Reservar,    Dialogo(<T>Reservar<T>),     Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Desreservar)<T> Entonces Si(Usuario.Desreservar, Dialogo(<T>DesReservar<T>),  Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Asignar)<T>     Entonces Si(Usuario.Asignar,     Dialogo(<T>Asignar<T>),      Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Desasignar)<T>  Entonces Si(Usuario.DesAsignar,  Dialogo(<T>DesAsignar<T>),   Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Facturacion Rapida)<T>          Entonces ProcesarSQL(<T>spFacturacionRapida :nID, :tUsuario, :tEmpresa<T>,    Afectar.ID, Usuario, Empresa)<BR>            Es <T>(Facturacion Rapida Agrupada)<T> Entonces ProcesarSQL(<T>spFacturacionRapida :nID, :tUsuario, :tEmpresa, 1<T>, Afectar.ID, Usuario, Empresa)<BR>            Es <T>(Generar Orden Transferencia)<T><BR>             Entonces<BR>               Si <BR>                 Usuario.PedidoGenerarOT y Dialogo(<T>EstaSeguro<T>)<BR>               Entonces<BR>                 Si<BR>                   Usuario.PedidoGenerarOTAbrir<BR>                 Entonces<BR>                   FormaPos(<T>Inv<T>, SQLEnLista(<T>spPedidoGenerarOT :tEmpresa, :nID, :nSucursal, :tUsuario, :tMov, @VerID = 1<T>, Empresa, hVenta:hVenta.ID, Sucursal, Usuario, ConfigMov.InvOrdenTransferencia))<BR>                 Sino<BR>                   ProcesarSQL(<T>spPedidoGenerarOT :tEmpresa, :nID, :nSucursal, :tUsuario, :tMov<T>, Empresa, hVenta:hVenta.ID, Sucursal, Usuario, ConfigMov.InvOrdenTransferencia)<BR>                 Fin<BR>               Sino<BR>                 Precaucion(<T>No Tiene Acceso<T>)<BR>               Fin<BR>            Sino<BR>              Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>              Asigna(Info.TituloDialogo, <T>Generar <T>+Comillas(Info.MovGenerar)+<T> de <T>+Comillas(Info.Mov))<BR>              Dialogo(<T>GenerarPedidoPendiente<T>)<BR>          Fin<BR>        Fin<BR>      Sino<BR>        Caso MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)<BR>          Es VTAS.PR  Entonces Dialogo(<T>GenerarPresupuestoVentas<T>) <BR>          Es VTAS.P   Entonces Dialogo(Info.Dialogo)<BR>          Es VTAS.S   Entonces Dialogo(<T>GenerarServicio<T>) <BR>          Es VTAS.R   Entonces Dialogo(<T>GenerarRemision<T>) <BR>          Es VTAS.VCR Entonces Dialogo(<T>GenerarRemisionConsignacion<T>)<BR>          Es VTAS.VC  Entonces Dialogo(<T>GenerarVentaConsignacion<T>)<BR>          Es VTAS.F   Entonces Dialogo(<T>GenerarFactura<T>)<BR>          Es VTAS.FAR Entonces Dialogo(<T>GenerarFactura<T>)<BR>          Es VTAS.FB  Entonces Dialogo(<T>GenerarFactura<T>)<BR>          Es VTAS.FR  Entonces Dialogo(<T>GenerarFacturaRecurrente<T>)<BR>          Es VTAS.SD  Entonces Dialogo(<T>GenerarSolicitudDevolucion<T>)<BR>        Fin<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hVenta:hVenta.Usuario) y <BR>(hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusRecurrente)) y<BR>PuedeAvanzarEstatus(<T>VTAS<T>, hVenta:hVenta.Mov, hVenta:hVenta.Estatus, FormaSituacion)
EjecucionCondicion=ConDatos(hVenta:hVenta.Mov) y ConDatos(hVenta:hVenta.Almacen)
AntesExpresiones=Asigna(Info.MovProcesar, ConfigMov.AutoRecaudacion)<BR>Si(General.AdvertirProyectosExpirados, Si(SQL(<T>SELECT COUNT(*) FROM Proy WHERE (Estatus = :tBaja OR FechaFin+1<GETDATE()) AND Proyecto=:tProy<T>, EstatusBaja, hVenta:hVenta.Proyecto) > 0, Si(Precaucion(<T>Proyecto Expirado<T>, BotonAceptar, BotonCancelar)=BotonCancelar, AbortarOperacion)))<BR>Si<BR>  (MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)=VTAS.P) <BR>Entonces<BR>  Si<BR>    General.Autotransportes<BR>  Entonces<BR>    Caso hVenta:hVenta.Mov<BR>      Es ConfigMov.AutoPapeleta Entonces Asigna(Info.Dialogo, <T>GenerarAutoPapeleta<T>)<BR>      Es <T>Orden Mantenimiento<T>  Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenMantenimiento<T>)<BR>      Es <T>Orden Reparacion Int<T> Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenReparacionInt<T>)<BR>      Es <T>Orden Reparacion Ext<T> Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenReparacionExt<T>)<BR>      Es <T>Orden Reparacion Ter<T> Entonces Asigna(Info.Dialogo, <T>GenerarAutoOrdenReparacionTer<T>)<BR>    Sino<BR>      Asigna(Info.Dialogo, <T>GenerarPedido<T>)<BR>    Fin   <BR>  Sino<BR>    Caso hVenta:hVenta.Mov<BR>      Es ConfigMov.VentaReservacion Entonces Asigna(Info.Dialogo, <T>GenerarReservacion<T>)<BR>      Es ConfigMov.VentaIngreso Entonces Asigna(Info.Dialogo, <T>GenerarVentaIngreso<T>)<BR>    Sino<BR>      Asigna(Info.Dialogo, <T>GenerarPedido<T>)<BR>    Fin<BR>  Fin<BR>Fin<BR>Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>VTAS<T>, hVenta:hVenta.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>VTAS<T>, hVenta:hVenta.Mov, hVenta:hVenta.ID, Verdadero, hVenta:hVenta.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>Fin

[Acciones.CopiarPendiente]
Nombre=CopiarPendiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Copiar Pendiente
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(hVentaD:hVentaD.CantidadA,  <BR>hVentaD:hVentaD.CantidadPendiente+hVentaD:hVentaD.CantidadReservada)
ActivoCondicion=hVenta:hVenta.Estatus=EstatusPendiente

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
Expresion=Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, hVenta:hVenta.ID)<BR>Asigna(Afectar.Mov, hVenta:hVenta.Mov) <BR>Asigna(Afectar.MovID, hVenta:hVenta.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov))<BR>Asigna(Info.Estatus, hVenta:hVenta.Estatus)<BR>Si <BR>  (Info.MovTipo en (VTAS.N,VTAS.FM)) y (Info.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))<BR>Entonces<BR>  Asigna(Info.TituloDialogo, <T>Cancelar: <T>+Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Dialogo(<T>CancelarNota<T>)<BR>Sino<BR>  Si <BR>    (Info.Estatus=EstatusPendiente) y (Info.MovTipo en (VTAS.P,VTAS.S))<BR>  Entonces<BR>    Asigna(Info.TituloDialogo, <T>Cancelar: <T>+Afectar.Mov+<T> <T>+Afectar.MovID)<BR>    Dialogo(<T>CancelarVentaPendiente<T>)<BR>  Sino<BR>    Si<BR>      Asigna(Temp.Texto, <T><T>)<BR>      Si <BR>        (Config.CancelarFactura<><T>No<T>) y Vacio(hVenta:hVenta.AnticiposFacturados) y (Info.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))<BR>      Entonces<BR>        Asigna(Temp.Fecha, SQL(<T>SELECT GETDATE()<T>))<BR>        Si<BR>          Info.MovTipo en (VTAS.F, VTAS.FAR)<BR>        Entonces<BR>          Si             <BR>            (Mes(Temp.Fecha) > Mes(hVenta:hVenta.FechaEmision)) o (Año(Temp.Fecha) > Año(hVenta:hVenta.FechaEmision)) o ((Config.CancelarFactura=<T>Cambio Dia<T>) y (Dia(Temp.Fecha) > Dia(hVenta:hVenta.FechaEmision)))<BR>          Entonces<BR>            Asigna(Temp.Texto, <T>Nota: Esta Cancelación va a Generar un Movimiento Contrario.<T>+NuevaLinea+NuevaLinea+NuevaLinea+NuevaLinea+NuevaLinea+NuevaLinea)<BR>          Fin<BR>        Fin<BR>      Fin<BR>      Precaucion(Temp.Texto+<T>¿ Esta seguro que desea cancelar el movimiento ?<T>+NuevaLinea+NuevaLinea+Afectar.Mov+<T> <T>+Afectar.MovID, BotonSi, BotonNo ) = BotonSi<BR>   Entonces<BR>      Cancelar(<T>VTAS<T>, hVenta:hVenta.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, Afectar.FormaCaptura)<BR><BR>      Si<BR>        Empresa.CFD y SQL(<T>spVerMovTipoCFD :tEmpresa, :tModulo, :tMov<T>, Empresa, Afectar.Modulo, Afectar.Mov)<BR>      Entonces<BR>        Si(no CFD.Generar(Afectar.Modulo, Afectar.ID), AbortarOperacion)<BR>        Si(SQL(<T>SELECT EnviarAlAfectar FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>, Empresa), CFD.Enviar(Afectar.Modulo, Afectar.ID))<BR>      Fin<BR><BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Si<BR>  PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, hVenta:hVenta.Usuario) y ConDatos(hVenta:hVenta.ID) y ConDatos(hVenta:hVenta.MovID) y (Vacio(hVenta:hVenta.CancelacionID) o (MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) en (VTAS.D,VTAS.DF,VTAS.B)))<BR>Entonces<BR>  Si<BR>    MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.C,VTAS.CS,VTAS.R,VTAS.P,VTAS.S,VTAS.VC,VTAS.VCR,VTAS.SD))<BR>  Entonces<BR>    hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusPorConfirmar)<BR>  Sino<BR>    hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente, EstatusProcesar, EstatusRecurrente, EstatusConcluido) <BR>  Fin<BR>Sino<BR>  Falso<BR>Fin
AntesExpresiones=Si<BR>  MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) = VTAS.N<BR>Entonces<BR>  Si<BR>    SQL(<T>SELECT COUNT(*) FROM Venta WHERE Empresa=:tEmpresa AND OrigenTipo=:tModulo AND Origen=:tOrigen AND OrigenID=:tOrigenID AND Estatus NOT IN (:tSinAfectar, :tCancelado)<T>, Empresa, <T>VTAS<T>, hVenta:hVenta.Mov, hVenta:hVenta.MovID, <T>SINAFECTAR<T>, <T>CANCELADO<T>)>0 <BR>  Entonces<BR>     Error(<T>Este Movimiento, Ya Fue Cancelado<T>) <BR>     AbortarOperacion<BR>  Fin<BR>Fin

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
ActivoCondicion=Vacio(hVenta:hVenta.MovID) y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, hVenta:hVenta.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Venta WHERE ID=:nID<T>, hVenta:hVenta.ID))
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
ListaParametros1=hVentaD:hVentaD.Articulo<BR>hVenta:hVenta.Almacen<BR>hVentaD:hVentaD.Cantidad
ListaParametros=S
Visible=S
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

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
Expresion=Verificar( <T>VTAS<T>, hVenta:hVenta.ID, hVenta:hVenta.Mov, hVenta:hVenta.MovID )
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(hVenta:hVenta.Mov)

[Detalle.hVentaD.DescuentoLinea]
Carpeta=Detalle
Clave=hVentaD.DescuentoLinea
Editar=S
IgnoraFlujo=N
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
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(Info.Origen, <T>VTAS<T>)<BR>Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>Asigna(Info.Descripcion, hVentaD:Art.Descripcion1)<BR>Asigna(Info.ArtTipo, hVentaD:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, hVentaD:Art.TipoOpcion)<BR>Asigna(Info.Almacen, Si(Config.VentaMultiAlmacen, hVentaD:hVentaD.Almacen, hVenta:hVenta.Almacen))<BR>Forma(<T>ArtAlmExistencia<T>)
EjecucionCondicion=ConDatos( hVentaD:hVentaD.Articulo)

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+I
NombreDesplegar=Información del &Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos( hVentaD:hVentaD.Articulo)
AntesExpresiones=Asigna( Info.Origen, <T>VTAS<T>)<BR>Asigna( Info.Articulo, hVentaD:hVentaD.Articulo )<BR>Asigna( Info.ArtTipo, hVentaD:Art.Tipo)

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
Menu=&Ver
NombreDesplegar=Información del &Cliente
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
EjecucionCondicion=ConDatos(hVenta:hVenta.Cliente)
AntesExpresiones=Asigna(Info.Origen, <T>VTAS<T>)<BR>Asigna( Info.Cliente,hVenta:hVenta.Cliente )

[Ficha.hVenta.AlmacenDestino]
Carpeta=Ficha
Clave=hVenta.AlmacenDestino
Editar=S
3D=S
Tamano=15
ValidaNombre=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.Costo]
Carpeta=Detalle
Clave=hVentaD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CostoTotal]
Carpeta=Detalle
Clave=CostoTotal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
ListaParametros1=hVenta:hVenta.ID
Visible=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(Info.SubModuloVenta, hVenta:hVenta.Mov, hVenta:hVenta.Estatus), hVenta:hVenta.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentación preliminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=hVenta:hVenta.ID
Visible=S
GuardarAntes=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(Info.SubModuloVenta, hVenta:hVenta.Mov, hVenta:hVenta.Estatus), hVenta:hVenta.ID)
ActivoCondicion=Usuario.PreliminarMovs

[Ficha.hVenta.TipoCambio]
Carpeta=Ficha
Clave=hVenta.TipoCambio
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Asistente Precios]
Nombre=Asistente Precios
Boton=0
NombreDesplegar=Asistente Precios
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Precios
ListaParametros1=hVentaD:hVentaD.Articulo<BR>hVentaD:hVentaD.SubCuenta<BR>hVentaD:Art.Grupo<BR>hVentaD:Art.Categoria<BR>hVentaD:Art.Familia<BR>hVentaD:Art.ABC<BR>hVentaD:Art.Fabricante<BR>hVentaD:Art.Linea<BR>hVentaD:Art.Rama<BR>hVenta:hVenta.Cliente<BR>hVenta:Cte.Grupo<BR>hVenta:Cte.Categoria<BR>hVenta:Cte.Familia<BR>hVenta:Cte.Zona<BR>hVenta:hVenta.Moneda<BR>hVenta:hVenta.Condicion<BR>hVentaD:hVentaD.Almacen<BR>hVenta:hVenta.Proyecto<BR>hVenta:hVenta.Agente<BR>hVenta:hVenta.FormaEnvio<BR>hVenta:hVenta.Mov<BR>hVenta:hVenta.ServicioTipo<BR>hVenta:hVenta.ServicioContratoTipo<BR>hVentaD:hVentaD.Unidad<BR>hVenta:hVenta.Empresa<BR>hVentaD:hVentaD.Cantidad<BR>hVentaD:hVentaD.Unidad<BR>hVentaD:Art.PrecioLista<BR>hVentaD:Art.MonedaPrecio<BR>hVenta:hVenta.TipoCambio<BR>hVentaD:hVentaD.DescuentoImporte<BR>hVentaD:hVentaD.DescuentoLinea<BR>hVenta:hVenta.ListaPreciosEsp<BR>hVentaD:Art.Precio2<BR>hVentaD:Art.Precio3<BR>hVentaD:Art.Precio4<BR>hVentaD:Art.Precio5<BR>hVentaD:Art.Precio6<BR>hVentaD:Art.Precio7<BR>hVentaD:Art.Precio8<BR>hVentaD:Art.Precio9<BR>hVentaD:Art.Precio10<BR>hVentaD:hVentaD.Precio<BR>hVentaD:hVentaD.PoliticaPrecios<BR>hVentaD:hVentaD.PrecioMoneda<BR>hVentaD:hVentaD.PrecioTipoCambio<BR>hVenta:CteEnviarA.Grupo<BR>hVenta:CteEnviarA.Categoria<BR>hVenta:CteEnviarA.Familia
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
AntesExpresiones=Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>Asigna(Info.SubCuenta, hVentaD:hVentaD.SubCuenta)<BR>Asigna(Info.Descripcion, hVentaD:Art.Descripcion1)<BR>Asigna(Info.Mensaje, hVentaD:hVentaD.PoliticaPrecios)

[Detalle.hVentaD.Aplica]
Carpeta=Detalle
Clave=hVentaD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.AplicaID]
Carpeta=Detalle
Clave=hVentaD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.Prioridad]
Carpeta=Notas
Clave=hVenta.Prioridad
Editar=S
ValidaNombre=S
3D=S
Tamano=12
LineaNueva=N
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.Directo]
Carpeta=Ficha
Clave=hVenta.Directo
Editar=S
3D=S
Tamano=16
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

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
ListaParametros1=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)<BR>hVenta:hVenta.Estatus=EstatusPendiente<BR>hVentaD:hVentaD.Cantidad<BR>hVentaD:hVentaD.CantidadPendiente<BR>hVentaD:hVentaD.CantidadReservada<BR>hVentaD:hVentaD.CantidadA<BR>hVentaD:hVentaD.SubCuenta<BR>hVentaD:hVentaD.Unidad<BR>hVentaD:hVentaD.Articulo<BR>hVenta:hVenta.Cliente<BR>hVenta:hVenta.Agente<BR>hVenta:hVenta.Almacen<BR>Nulo<BR>Nulo<BR>hVenta:Cte.Idioma<BR>Config.CBPreguntarCantidad<BR>Falso
ActivoCondicion=Config.CB y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente))

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
ListaParametros1=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>hVenta:hVenta.Estatus=EstatusPendiente<BR>hVentaD:hVentaD.Cantidad<BR>hVentaD:hVentaD.CantidadPendiente<BR>hVentaD:hVentaD.CantidadReservada<BR>hVentaD:hVentaD.CantidadA<BR>hVentaD:hVentaD.SubCuenta<BR>hVentaD:hVentaD.Unidad<BR>hVentaD:hVentaD.Articulo<BR>hVenta:hVenta.Cliente<BR>hVenta:hVenta.Agente<BR>hVenta:hVenta.Almacen<BR>Nulo<BR>Nulo<BR>hVenta:Cte.Idioma<BR>hVenta:hVenta.ID<BR>Verdadero<BR>Config.CBProcesarLote<BR>MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.DR,VTAS.SG,VTAS.EG,VTAS.D,VTAS.DF,VTAS.B,VTAS.VC,VTAS.VCR,VTAS.DC,VTAS.DCR,VTAS.N,VTAS.NO,VTAS.NR,VTAS.FM,VTAS.CO))<BR>Si(Config.CBDirAlmacen, hVenta:Cte.CBDir, <T><T>)
Boton=0
GuardarAntes=S
Antes=S
DespuesGuardar=S
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Renglon, hVentaD:hVentaD.Renglon)<BR>Asigna(Info.RenglonSub, hVentaD:hVentaD.RenglonSub)<BR>EjecutarSQL(<T>spProcesarCBInfo :nEst, :tEmp, :tMod, :nID, :nRen, :nSub<T>, EstacionTrabajo, Empresa, <T>VTAS<T>, Info.ID, Info.Renglon, Info.RenglonSub)
VisibleCondicion=Config.CB

[(Carpeta Abrir).hVenta.Almacen]
Carpeta=(Carpeta Abrir)
Clave=hVenta.Almacen
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

[Ficha.hVenta.Concepto]
Carpeta=Ficha
Clave=hVenta.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

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
ActivoCondicion=ConDatos(hVenta:hVenta.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)

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
Expresion=Asigna(Info.SumaSerieLote, Nulo)<BR>Si<BR>  MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) = VTAS.CO<BR>Entonces<BR>  Asigna(Info.Cliente, hVenta:hVenta.Cliente)<BR>  Si(hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>SerieLoteMovUbicacion<T>), Forma(<T>SerieLoteMovUbicacionInfo<T>))<BR>Sino<BR>  Si <BR>    hVentaD:Art.Tipo=TipoVIN<BR>  Entonces<BR>    Si<BR>      hVenta:hVenta.Estatus=EstatusSinAfectar<BR>    Entonces<BR>      Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>      Si(Forma(<T>VINMov<T>), EjecutarSQL(<T>xpVentaVINAsignar :nID, :nRen, :nSub, :tVIN<T>, hVenta:hVenta.ID, hVentaD:hVentaD.Renglon, hVentaD:hVentaD.RenglonSub, Info.VIN))<BR>    Sino<BR>      Forma(<T>VINMovInfo<T>)<BR>    Fin<BR>  Sino<BR>    Si(hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente), Forma(<T>SerieLoteMov<T>), Si(Usuario.ModificarSerieLoteProp, Forma(<T>SerieLoteMovProp<T>), Forma(<T>SerieLoteMovInfo<T>)))<BR>    Si<BR>      hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar) <BR>    Entonces<BR>      Si<BR>        (hVentaD:Art.Tipo=TipoPartida) y (Info.SumaSerieLote>0)<BR>      Entonces<BR>        Asigna(Info.Copiar, Verdadero)<BR>        Asigna(Info.Precio, hVentaD:hVentaD.Precio)<BR>        Asigna(hVentaD:hVentaD.Cantidad, <BR>          Caso Minusculas(hVentaD:hVentaD.Unidad)<BR>            Es <T>metros<T> Entonces Info.SumaAlternaSerieLote<BR>            Es <T>yardas<T> Entonces Info.SumaAlternaSerieLote/UnidadFactor(hVentaD:hVentaD.Unidad)<BR>            Es <T>kilos<T>  Entonces Info.SumaSerieLote<BR>            Es <T>libras<T> Entonces Info.SumaSerieLote/UnidadFactor(hVentaD:hVentaD.Unidad)<BR>          Sino<BR>            0.0<BR>          Fin)<BR>        Asigna(hVentaD:hVentaD.Factor, Info.SumaSerieLote/hVentaD:hVentaD.Cantidad)<BR>        Asigna(hVentaD:hVentaD.CantidadAlterna, Info.SumaAlternaSerieLote)<BR>        Asigna(Info.Copiar, Falso)<BR>      Sino<BR>        Si<BR>          (no Config.MultiUnidades) y ConDatos(Info.SumaSerieLote) y (Info.SumaSerieLote<>ABS(hVentaD:hVentaD.Cantidad)) y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>        Entonces<BR>          Si<BR>            Confirmacion(<T>La Cantidad Difiere con la Selección.<T>+NuevaLinea+NuevaLinea+<T>¿ Desea Actualizar la Cantidad ?<T>,BotonSi, BotonNo)=BotonSi)<BR>          Entonces<BR>            Asigna(hVentaD:hVentaD.Cantidad, Si(Vacio(hVentaD:hVentaD.Cantidad, 0.0)<0,-Info.SumaSerieLote, Info.SumaSerieLote))<BR>          Fin<BR>        Fin  <BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin<BR><BR>Si<BR>  (Info.SubModuloVenta=<T>AUTO<T>) y (hVentaD:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX)) y (Info.SumaSerieLote>0) y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y Usuario.AsistentePrecios<BR>Entonces<BR>  Asigna(Info.Estatus, hVenta:hVenta.Estatus)<BR>  Asigna(Info.Modulo, <T>VTAS<T>)<BR>  Asigna(Info.ID, hVenta:hVenta.ID)<BR>  Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>  Asigna(Info.ArtLinea, hVentaD:Art.Linea)<BR>  Asigna(Info.SubCuenta, hVentaD:hVentaD.SubCuenta)<BR>  Asigna(Info.RenglonID, hVentaD:hVentaD.RenglonID)<BR>  Si<BR>    Forma(<T>AutoBoletoMov<T>)<BR>  Entonces<BR>    Asigna(hVentaD:VentaD.Cantidad, Info.Cantidad)<BR>    Si<BR>      hVentaD:Art.AutoRecaudacion en (<T>Gasto No Reembolsable<T>, <T>Ingreso Costo<T>)<BR>    Entonces<BR>      Asigna(hVentaD:hVentaD.Costo, Info.Importe/Info.Cantidad)<BR>    Sino<BR>      Asigna(hVentaD:hVentaD.Precio, Info.Importe/Info.Cantidad)<BR>      Si(hVentaD:Art.AutoRecaudacion=<T>Gasto<T>, Asigna(hVentaD:hVentaD.Precio, -hVentaD:hVentaD.Precio))<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Config.SeriesLotesMayoreo y (MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.DR,VTAS.SG,VTAS.EG,VTAS.D,VTAS.DF,VTAS.VC,VTAS.VCR,VTAS.DC,VTAS.DCR,VTAS.N,VTAS.NO,VTAS.NR,VTAS.FM,VTAS.CO)) o (MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.C, VTAS.P)) y Config.VentaRefSerieLotePedidos))
EjecucionCondicion=hVentaD:Art.Tipo en (TipoSerie, TipoVIN, TipoLote) o <BR>((hVentaD:Art.Tipo=TipoPartida) y ConDatos(hVentaD:hVentaD.SubCuenta))
AntesExpresiones=Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>Asigna(Info.Almacen, Si(Config.VentaMultiAlmacen, hVentaD:hVentaD.Almacen, hVenta:hVenta.Almacen))<BR>Asigna(Info.AlmTipo, hVenta:Alm.Tipo)<BR>Asigna(Info.Modulo, <T>VTAS<T>) <BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.RenglonID, hVentaD:hVentaD.RenglonID)<BR>Asigna(Info.Factor, hVentaD:hVentaD.Factor)<BR>Asigna(Info.Cantidad, ABS(hVentaD:hVentaD.Cantidad) * UnidadFactor(hVentaD:hVentaD.Unidad, hVentaD:hVentaD.Articulo))<BR>Asigna(Info.Paquete, hVentaD:hVentaD.Paquete)<BR>Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov))<BR>Asigna(Info.ArtTipo, hVentaD:Art.Tipo)<BR>Asigna(Info.EsEntrada, MovTipoEn(<T>INV<T>,hVenta:hVenta.Mov, (VTAS.D, VTAS.DF, VTAS.DC,VTAS.DCR)))<BR>Asigna(Info.Unidad, hVentaD:hVentaD.Unidad)<BR>Asigna(Info.Estatus, hVenta:hVenta.Estatus)<BR>Si(General.Autotransportes, Asigna(Filtro.Espacio, hVenta:hVenta.Espacio))<BR>Si((Info.ArtTipo=TipoPartida) o (hVentaD:Art.TipoOpcion<>TipoNo), Asigna(Info.SubCuenta, hVentaD:hVentaD.SubCuenta), Asigna(Info.SubCuenta, <T><T>))

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=N
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
Tamano=11
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Embarque]
Nombre=Embarque
Boton=69
Menu=&Edición
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
ActivoCondicion=MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.F,VTAS.FAR,VTAS.FC,VTAS.FG,VTAS.FX,VTAS.DFC,VTAS.FB,VTAS.R,VTAS.SG,VTAS.EG,VTAS.VC,VTAS.VCR,VTAS.S)) y (hVenta:hVenta.Estatus<>EstatusCancelado)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.FormaEnvio, hVenta:hVenta.FormaEnvio)

[Acciones.CteExpress]
Nombre=CteExpress
Boton=60
Menu=&Edición
NombreDesplegar=Agregar &Cliente...
EnMenu=S
TipoAccion=Expresion
Visible=S
EnBarraHerramientas=S
UsaTeclaRapida=S
TeclaRapida=Alt+F8
Expresion=Asigna(Info.Tipo, <T>Cliente<T>)<BR>Forma(<T>CteExpress<T>)<BR>Asigna(hVenta:hVenta.Cliente, Info.Cliente)
ActivoCondicion=Usuario.AgregarCteExpress y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Envio.hVenta.EnviarA]
Carpeta=Envio
Clave=hVenta.EnviarA
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

[Envio.hVenta.Cliente]
Carpeta=Envio
Clave=hVenta.Cliente
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

[Envio.hVenta.FormaEnvio]
Carpeta=Envio
Clave=hVenta.FormaEnvio
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
Menu=&Edición
NombreDesplegar=Si(MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.VP, VTAS.SD, VTAS.B)), <T>Devolución...<T>, <T>Cobro...<T>)
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaCobro
Antes=S
DespuesGuardar=S
Activo=S
AntesExpresiones=Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, hVenta:hVenta.ID)<BR>Asigna(Afectar.Mov, hVenta:hVenta.Mov)<BR>Asigna(Afectar.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Cliente, hVenta:hVenta.Cliente)<BR>Asigna(Info.Fecha, hVenta:hVenta.FechaEmision)<BR>Asigna(Info.Moneda, hVenta:hVenta.Moneda)<BR>Asigna(Info.Importe, Redondea(Suma(hVentaD:Importe)+Suma(hVentaD:Impuesto)-Suma(hVentaD:DescGlobal)-(hVenta:hVenta.AnticiposFacturados+hVenta:hVenta.Retencion), Config.VentaCobroRedondeoDecimales))<BR>Asigna(Info.Cerrado, hVenta:hVenta.Estatus<>EstatusSinAfectar)<BR>Asigna(Info.VentaCobroDevolucion, MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.VP, VTAS.SD, VTAS.D, VTAS.DF)))<BR>Asigna(Info.FormaPago, Vacio(Usuario.DefFormaPago, Config.FormaPagoOmision))
VisibleCondicion=((MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.N, VTAS.FM)) y (ConDatos(hVenta:hVenta.MovID) o Config.VentaLiquidaIntegral) y (hVenta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>)) o<BR>(MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.P, VTAS.VP, VTAS.SD, VTAS.B))  y (hVenta:Condicion.ControlAnticipos=<T>Cobrar Pedido<T>)) o<BR>(MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.F,VTAS.FAR, VTAS.FB, VTAS.D, VTAS.DF)) y (hVenta:hVenta.Vencimiento<=hVenta:hVenta.FechaEmision) y Config.FacturaCobroIntegrado y (hVenta:Condicion.ControlAnticipos<><T>Cobrar Pedido<T>)))

[Mostrador.hVenta.Mov]
Carpeta=Mostrador
Clave=hVenta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22

[Mostrador.hVenta.MovID]
Carpeta=Mostrador
Clave=hVenta.MovID
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
Vista=hVenta
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
CondicionEdicion=Vacio(hVenta:hVenta.AnexoID)
CondicionVisible=MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.CS, VTAS.SG, VTAS.EG))

[Servicio.hVenta.ServicioArticulo]
Carpeta=Servicio
Clave=hVenta.ServicioArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioSerie]
Carpeta=Servicio
Clave=hVenta.ServicioSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Servicio.hVenta.ServicioContrato]
Carpeta=Servicio
Clave=hVenta.ServicioContrato
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
EspacioPrevio=N
ColorFuente=Negro

[Servicio.hVenta.ServicioContratoID]
Carpeta=Servicio
Clave=hVenta.ServicioContratoID
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

[Servicio.hVenta.ServicioGarantia]
Carpeta=Servicio
Clave=hVenta.ServicioGarantia
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
NombreDesplegar=Historia Artículo/Serie del Servicio
EnMenu=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Antes=S
EspacioPrevio=S
ActivoCondicion=MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.CS, VTAS.SG, VTAS.EG))
AntesExpresiones=Asigna(Info.Articulo, hVenta:hVenta.ServicioArticulo)<BR>Asigna(Info.SerieLote, hVenta:hVenta.ServicioSerie)<BR>Asigna(Info.SubCuenta, <T><T>)<BR>Asigna(Info.ArtTipo, hVenta:ArtDestino.Tipo)
VisibleCondicion=MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.CS, VTAS.SG, VTAS.EG))

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
TipoAccion=Formas
ClaveAccion=Tarea
Antes=S
Visible=S
DespuesGuardar=S
Activo=S
AntesExpresiones=Asigna(Info.PuedeEditar, hVenta:hVenta.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Cliente, hVenta:hVenta.Cliente)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, hVenta:hVenta.Agente)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, hVenta:hVenta.Proyecto)<BR>Asigna(Info.UEN, hVenta:hVenta.UEN)<BR>Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Reporte, Nulo)

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
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
Antes=S
ActivoCondicion=(ConfigModulo(<T>VTAS<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>PuedeAvanzarSituacion(<T>VTAS<T>, hVenta:hVenta.Mov, hVenta:hVenta.Estatus, FormaSituacion)
AntesExpresiones=Si(Vacio(hVenta:hVenta.ID),GuardarCambios)

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
EjecucionCondicion=ConDatos(hVenta:hVenta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)

[(Carpeta Abrir).hVenta.Cliente]
Carpeta=(Carpeta Abrir)
Clave=hVenta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
ActivoCondicion=ConDatos(hVentaA:hVenta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVentaA:hVenta.ID)

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

[Servicio.hVenta.ServicioContratoTipo]
Carpeta=Servicio
Clave=hVenta.ServicioContratoTipo
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
Menu=&Edición
NombreDesplegar=&Accesorios
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
Expresion=Si(hVenta:hVenta.Estatus en (EstatusConcluido, EstatusCancelado), Forma(<T>ServicioAccesoriosInfo<T>), Forma(<T>ServicioAccesorios<T>))
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)
VisibleCondicion=MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.CS))

[Servicio.hVenta.ServicioDescripcion]
Carpeta=Servicio
Clave=hVenta.ServicioDescripcion
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
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Usuario, hVenta:hVenta.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(hVenta:hVenta.ID)

[Detalle.hVentaD.Paquete]
Carpeta=Detalle
Clave=hVentaD.Paquete
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
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
Expresion=Si(hVenta:hVenta.Estatus en (EstatusConcluido, EstatusCancelado), Informacion(hVentaD:hVentaD.DescripcionExtra), Pregunta(hVentaD:hVentaD.DescripcionExtra))

[Acciones.ArtExpress]
Nombre=ArtExpress
Boton=0
Menu=&Edición
NombreDesplegar=Agregar Artícul&o...
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=Mayús+F8
Expresion=Asigna(Info.Articulo, Nulo)<BR>Forma(<T>ArtExpress<T>)<BR>Si <BR>  ConDatos(Info.Articulo) y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>Entonces<BR>  Asigna(hVentaD:hVentaD.Articulo, Info.Articulo)<BR>Fin
ActivoCondicion=Usuario.AgregarArtExpress y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Acciones.Embarcar]
Nombre=Embarcar
Boton=0
Menu=&Archivo
NombreDesplegar=E&mbarcar...
EnMenu=S
TipoAccion=Expresion
GuardarAntes=S
Expresion=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Estatus, hVenta:hVenta.Estatus)<BR>Dialogo(<T>MovEmbarcar<T>)
ActivoCondicion=hVenta:hVenta.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusSincro, EstatusCancelado) y (no FormaBloqueada)
VisibleCondicion=hVenta:hVenta.Estatus noen (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusSincro, EstatusCancelado) y (no FormaBloqueada)

[Acciones.Importar]
Nombre=Importar
Boton=0
Menu=&Archivo
NombreDesplegar=I&mportar...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=Si<BR>  MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) <> VTAS.CO<BR>Entonces<BR>  ProcesarLista(<T>Importar Movimiento<T>, <T>ImportarInv<T>, <T>Estacion<T>, <T>ID<T>, <T>spImportarInv<T>, EstacionTrabajo & <T>, <T> & Comillas(Empresa) & <T>, <T> & Comillas(<T>VTAS<T>) & <T>, <T> & hVenta:hVenta.ID & <T>, <T> & Sucursal)<BR>Sino<BR>  ProcesarLista(<T>Importar Contrato<T>, <T>ImportarInvArt<T>, <T>Estacion<T>, <T>ID<T>, <T>spImportarInvArt<T>, EstacionTrabajo & <T>, <T> & hVenta:hVenta.ID & <T>, <T> & Sucursal)<BR>Fin
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.ModificarAlmacen]
Nombre=ModificarAlmacen
Boton=0
Menu=&Archivo
NombreDesplegar=Mo&dificar Almacén Pedido...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaModificarAlmacen
Antes=S
ConCondicion=S
ActivoCondicion=((MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)<>VTAS.P) y (hVenta:hVenta.Estatus=EstatusSinAfectar)) o<BR>((hVenta:hVenta.Estatus=EstatusPendiente) y (MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)=VTAS.P) y (no FormaBloqueada))
EjecucionCondicion=(MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)=VTAS.P) o (MovTipo(<T>VTAS<T>, hVentaD:hVentaD.Aplica)=VTAS.P)
AntesExpresiones=Si<BR>  MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)=VTAS.P<BR>Entonces<BR>  Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>  Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>  Asigna(Info.ID, hVenta:hVenta.ID)<BR>Sino<BR>  Asigna(Info.Mov, hVentaD:hVentaD.Aplica)<BR>  Asigna(Info.MovID, hVentaD:hVentaD.AplicaID)<BR>  Asigna(Info.ID, SQL(<T>SELECT ID FROM Venta WHERE Empresa=:tEmpresa AND Mov=:tMov AND MovID=:tMovID AND Estatus=:tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>Fin
VisibleCondicion=Usuario.ModificarAlmacenPedidos

[Detalle.hVentaD.ContUso]
Carpeta=Detalle
Clave=hVentaD.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
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
AntesExpresiones=Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)
VisibleCondicion=(MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) = VTAS.CO) y (hVenta:hVenta.Estatus noen (EstatusSinAfectar, EstatusCancelado))

[Servicio.hVenta.ServicioFecha]
Carpeta=Servicio
Clave=hVenta.ServicioFecha
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
NombreDesplegar=&Lista Artículos Disponibles
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtListaDisponible
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=ConDatos(hVenta:hVenta.Almacen)
EjecucionMensaje=<T>Falta Especificar el Almacén<T>
AntesExpresiones=Asigna(Info.Almacen, hVenta:hVenta.Almacen)<BR>Asigna(Info.Origen, <T>VTAS<T>)

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
ClaveAccion=AnexoMov
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Fecha, hVenta:hVenta.FechaEmision)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hVenta:hVenta.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, hVenta:hVenta.Mov+<T> <T>+hVenta:hVenta.MovID)
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
EjecucionCondicion=ConDatos(hVenta:hVenta.ID) y ConDatos(hVentaD:hVentaD.Articulo)
EjecucionMensaje=Si(Vacio(hVenta:hVenta.ID), <T>Es Necesario Guardar el Movimiento Antes de Ejecutar esta Opción<T>, <T>Falta Indicar el Artículo<T>)
AntesExpresiones=Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Fecha, hVenta:hVenta.FechaEmision)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (hVenta:hVenta.Estatus noen (EstatusCancelado, EstatusConcluido)))<BR>Asigna(Info.Cuenta, hVentaD:hVentaD.Articulo)<BR>Asigna(Info.Descripcion, hVentaD:Art.Descripcion1)

[Acciones.AgregarEvento]
Nombre=AgregarEvento
Boton=0
Menu=&Edición
NombreDesplegar=Agregar E&vento
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacoraAgregar
ConCondicion=S
Visible=S
Antes=S
ActivoCondicion=hVenta:hVenta.Estatus<>EstatusCancelado
EjecucionCondicion=Si(Vacio(hVenta:hVenta.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)

[Acciones.MovBitacora]
Nombre=MovBitacora
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+B
NombreDesplegar=Bitácora
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacora
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=Si(Vacio(hVenta:hVenta.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.PuedeEditar, hVenta:hVenta.Estatus<>EstatusCancelado)

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
ActivoCondicion=ConDatos(hVenta:hVenta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Cuenta, hVenta:hVenta.ID)<BR>Asigna(Info.Descripcion, hVenta:hVenta.Mov+<T> <T>+hVenta:hVenta.MovID)

[(Carpeta Totalizadores).Renglon]
Carpeta=(Carpeta Totalizadores)
Clave=Renglon
Editar=S
LineaNueva=N
Tamano=4
ColorFondo=Plata
ColorFuente=Negro
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
Expresion=Si<BR>  Forma(<T>EspecificarFechas<T>)<BR>Entonces<BR>  Asigna(Info.ID, hVenta:hVenta.ID)<BR>  Asigna(Info.MovTipo, MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov))<BR>  Asigna(Info.Cliente, hVenta:hVenta.Cliente)<BR>  Asigna(Info.EnviarA, hVenta:hVenta.EnviarA)<BR>  Asigna(Info.Nombre, hVenta:Cte.Nombre)<BR>  EjecutarSQL(<T>spVentaCteD :nEstacion, :tEmpresa, :tCliente, :fDel, :fAl<T>, EstacionTrabajo, Empresa, Info.Cliente, Info.FechaD, Info.FechaA)<BR>  Forma(<T>VentaCopiar<T>)<BR>Fin
VisibleCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Ficha.hVenta.EnviarA]
Carpeta=Ficha
Clave=hVenta.EnviarA
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
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=23
ColorFondo=Plata
ColorFuente=Negro
Editar=S
Pegado=N

[Ficha.CteEnviarA.Direccion]
Carpeta=Ficha
Clave=CteEnviarA.Direccion
3D=S
Pegado=S
Tamano=22
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Ficha.hVenta.FormaEnvio]
Carpeta=Ficha
Clave=hVenta.FormaEnvio
ValidaNombre=N
3D=S
Pegado=N
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Ficha.Cte.RFC]
Carpeta=Ficha
Clave=Cte.RFC
3D=S
Tamano=11
ColorFondo=Plata
ColorFuente=Negro
Pegado=S
Editar=S

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
Expresion=CopiarMovimiento(<T>VTAS<T>, hVenta:hVenta.ID, <T>Venta<T>)

[Notas.hVenta.Causa]
Carpeta=Notas
Clave=hVenta.Causa
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N
LineaNueva=S

[Servicio.hVenta.ServicioTipo]
Carpeta=Servicio
Clave=hVenta.ServicioTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.hVenta.FechaOriginal]
Carpeta=Ficha
Clave=hVenta.FechaOriginal
Editar=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Detalle.hVentaD.Unidad]
Carpeta=Detalle
Clave=hVentaD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CantidadNeta]
Carpeta=Detalle
Clave=CantidadNeta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.CantidadReservada]
Carpeta=Detalle
Clave=hVentaD.CantidadReservada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Azul
Efectos=[Negritas]

[Detalle.hVentaD.CantidadOrdenada]
Carpeta=Detalle
Clave=hVentaD.CantidadOrdenada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

[Detalle.hVentaD.CantidadPendiente]
Carpeta=Detalle
Clave=hVentaD.CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00004080
Efectos=[Negritas]

[Detalle.hVentaD.FechaRequerida]
Carpeta=Detalle
Clave=hVentaD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.hVentaD.Instruccion]
Carpeta=Detalle
Clave=hVentaD.Instruccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.PedidoPos]
Nombre=PedidoPos
Boton=0
Menu=&Ver
NombreDesplegar=Posición del Pedido (en Cantidades)
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=PedidoPos
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(hVenta:hVenta.ID)
Antes=S
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)
VisibleCondicion=MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)=VTAS.P

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
EjecucionCondicion=ConDatos(hVentaD:hVentaD.Articulo)
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)
VisibleCondicion=hVenta:hVenta.Estatus<>EstatusSinAfectar

[Detalle.hVentaD.CantidadInventario]
Carpeta=Detalle
Clave=hVentaD.CantidadInventario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.Atencion]
Carpeta=Notas
Clave=hVenta.Atencion
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

[Ficha.hVenta.ServicioContratoTipo]
Carpeta=Ficha
Clave=hVenta.ServicioContratoTipo
Editar=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Campos]
Nombre=Campos
Boton=0
Menu=&Edición
NombreDesplegar=&Campos...
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Expresion=Forma(<T>VentaCampos<T>)
ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)
VisibleCondicion=hVenta:hVenta.Estatus<>EstatusSinAfectar

[Acciones.Consecutivo]
Nombre=Consecutivo
Boton=0
Menu=&Archivo
NombreDesplegar=A&signar Consecutivo
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>VTAS<T>, hVenta:hVenta.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(hVenta:hVenta.MovID)
VisibleCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[Detalle.hVentaD.Almacen]
Carpeta=Detalle
Clave=hVentaD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.Retencion]
Carpeta=Ficha
Clave=hVenta.Retencion
ValidaNombre=S
3D=S
Pegado=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Cliente, hVenta:hVenta.Cliente)<BR>Si(no Forma(<T>VentaCopiarLote<T>),  AbortarOperacion)

[Notas.hVenta.Extra]
Carpeta=Notas
Clave=hVenta.Extra
Editar=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VerOpciones]
Nombre=VerOpciones
Boton=0
NombreDesplegar=&Interpretar Opción
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=VerOpcionesArticulo( hVentaD:hVentaD.Articulo, hVentaD:hVentaD.SubCuenta )
ActivoCondicion=ConDatos(hVentaD:hVentaD.SubCuenta) y (hVentaD:Art.TipoOpcion=TipoSi)

[Detalle.hVentaD.Agente]
Carpeta=Detalle
Clave=hVentaD.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Servicio.hVenta.ServicioIdentificador]
Carpeta=Servicio
Clave=hVenta.ServicioIdentificador
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Notas.hVenta.AtencionTelefono]
Carpeta=Notas
Clave=hVenta.AtencionTelefono
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VINExpress]
Nombre=VINExpress
Boton=0
Menu=&Edición
NombreDesplegar=Agregar &VIN...
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Expresion=Asigna(Info.Articulo, hVenta:hVenta.ServicioArticulo)<BR>Si(Forma(<T>VINExpress<T>), Asigna(hVenta:hVenta.ServicioSerie, Info.SerieLote))
EjecucionCondicion=ConDatos(hVenta:hVenta.ServicioArticulo)
EjecucionMensaje=<T>Es Necesario Indicar el Arículo Servicio<T>
VisibleCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.CS)) y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Detalle.AplicaNombre]
Carpeta=Detalle
Clave=AplicaNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
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
ActivoCondicion=Vacio(hVenta:hVenta.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Venta<T>)<BR>Asigna(Afectar.Modulo, <T>VTAS<T>)<BR>Asigna(Afectar.ID, hVenta:hVenta.ID)<BR>Asigna(Afectar.Mov, hVenta:hVenta.Mov)<BR>Asigna(Afectar.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Descripcion, hVenta:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(hVenta:hVenta.Mensaje)

[Ficha.hVenta.ListaPreciosEsp]
Carpeta=Ficha
Clave=hVenta.ListaPreciosEsp
Editar=S
ValidaNombre=N
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.ZonaImpuesto]
Carpeta=Notas
Clave=hVenta.ZonaImpuesto
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
ColorFuente=Negro

[Notas.hVenta.Departamento]
Carpeta=Notas
Clave=hVenta.Departamento
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).hVenta.Importe]
Carpeta=(Carpeta Abrir)
Clave=hVenta.Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).hVenta.Saldo]
Carpeta=(Carpeta Abrir)
Clave=hVenta.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Moneda, hVenta:hVenta.Moneda)<BR>Asigna(Info.Cliente, hVenta:hVenta.Cliente)<BR>Asigna(Info.EnviarA, hVenta:hVenta.EnviarA)<BR>Forma(<T>VentaPendienteDMultiple<T>)
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

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
AntesExpresiones=Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>Asigna(Info.SubCuenta, hVentaD:hVentaD.SubCuenta)<BR>Asigna(Info.Descripcion, hVentaD:Art.Descripcion1)<BR>Asigna(Info.Mensaje, hVentaD:hVentaD.PoliticaPrecios)

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
AntesExpresiones=Si(Vacio(hVenta:hVenta.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino y Usuario.ModificarSucursalDestino y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y (no FormaBloqueada)

[Notas.hVenta.DesglosarImpuestos]
Carpeta=Notas
Clave=hVenta.DesglosarImpuestos
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.ExcluirPlaneacion]
Carpeta=Notas
Clave=hVenta.ExcluirPlaneacion
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VentaOtros]
Nombre=VentaOtros
Boton=0
Menu=&Edición
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
ActivoCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.CS))
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Estatus, hVenta:hVenta.Estatus)
VisibleCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.CS))

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

[Acciones.Anticipos]
Nombre=Anticipos
Boton=61
Menu=&Edición
NombreDesplegar=Anticipos...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F7
Expresion=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.EnviarA, hVenta:hVenta.EnviarA)<BR>Asigna(Info.Rama, <T>CXC<T>)<BR>Asigna(Info.Cuenta, hVenta:hVenta.Cliente)<BR>Asigna(Info.Agente, hVenta:hVenta.Agente)<BR>Asigna(Info.Moneda, hVenta:hVenta.Moneda)<BR>Asigna(Info.TipoCambio, hVenta:hVenta.TipoCambio)<BR>Asigna(Info.Estatus, hVenta:hVenta.Estatus)<BR>Asigna(Info.PorcentajeImpuesto,  Redondea(Si(hVenta:hVenta.DesglosarImpuesto2, General.DefImpuesto, (Suma(hVentaD:Impuesto)/Suma(hVentaD:SubTotal))*100), 8))<BR>Asigna(Info.Concepto, hVenta:hVenta.Concepto)<BR>Asigna(Info.Proyecto, hVenta:hVenta.Proyecto)<BR>Forma(<T>VentaVerAnticipo<T>)
ActivoCondicion=MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.P, VTAS.S)) y (hVenta:hVenta.Estatus en (EstatusPendiente, EstatusConcluido)) y<BR>(hVenta:Condicion.ControlAnticipos en (<T>Abierto<T>, <T>Plazos<T>, <T>Fecha Requerida<T>))

[Ficha.hVenta.DescuentoGlobal]
Carpeta=Ficha
Clave=hVenta.DescuentoGlobal
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.hVenta.HoraRequerida]
Carpeta=Ficha
Clave=hVenta.HoraRequerida
Editar=S
3D=S
Pegado=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.VigenciaDesde]
Carpeta=Notas
Clave=hVenta.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Notas.hVenta.VigenciaHasta]
Carpeta=Notas
Clave=hVenta.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.ConVigencia]
Carpeta=Notas
Clave=hVenta.ConVigencia
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
Expresion=spAfectar(<T>VTAS<T>, hVenta:hVenta.ID, hVenta:hVenta.Mov, hVenta:hVenta.MovID, <T>Refacturar<T>, <T>Todo<T>, <T><T>, <T>Venta<T>)
ActivoCondicion=Usuario.Refacturar
EjecucionCondicion=Si <BR>  Config.CancelarFactura=<T>Cambio Mes<T><BR>Entonces<BR>  Asigna(Temp.Fecha, SQL(<T>SELECT GETDATE()<T>))<BR>  Si<BR>    (Mes(Temp.Fecha)>Mes(hVenta:hVenta.FechaEmision)) o (Año(Temp.Fecha)>Año(hVenta:hVenta.FechaEmision))<BR>  Entonces<BR>    Falso<BR>  Sino<BR>    Verdadero<BR>  Fin<BR>Sino<BR>  Verdadero<BR>Fin
EjecucionMensaje=<T>No se Puede Refacturar Automáticamente Fuera del Mes<T>
AntesExpresiones=Asigna(Afectar.Mov, hVenta:hVenta.Mov)<BR>Asigna(Afectar.MovID, hVenta:hVenta.MovID)
VisibleCondicion=Usuario.Refacturar y ((MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) en (VTAS.F, VTAS.FAR)) y (hVenta:hVenta.Estatus=EstatusConcluido))

[Notas.hVenta.AnticiposFacturados]
Carpeta=Notas
Clave=hVenta.AnticiposFacturados
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
ColorFuente=Negro

[(Carpeta Abrir).Throughput]
Carpeta=(Carpeta Abrir)
Clave=Throughput
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.DescuentoImporte]
Carpeta=Detalle
Clave=hVentaD.DescuentoImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.Bonificacion]
Carpeta=Notas
Clave=hVenta.Bonificacion
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
ColorFuente=Negro
Pegado=S

[Detalle.ClaveIdioma]
Carpeta=Detalle
Clave=ClaveIdioma
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
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
Expresion=Si<BR>  Usuario.AsistentePrecios<BR>Entonces<BR>  Si(hVentaD:Art.Linea=Config.AutoArtBX, Asigna(Temp.Flotante, 0), Asigna(Temp.Flotante, hVentaD:hVentaD.Cantidad))<BR>  Si<BR>    hVentaD:Art.AutoRecaudacion en (<T>Gasto No Reembolsable<T>, <T>Ingreso Costo<T>)<BR>  Entonces<BR>    ConfirmarImportes(hVentaD:hVentaD.Cantidad, hVentaD:hVentaD.Costo, Usuario.AutoDobleCapturaPrecios y (hVentaD:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX)), <T>Editar Costo<T>, Temp.Flotante)<BR>  Sino<BR>    ConfirmarImportes(hVentaD:hVentaD.Cantidad, hVentaD:hVentaD.Precio, Usuario.AutoDobleCapturaPrecios y (hVentaD:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX)), <T>Editar Precio<T>, Temp.Flotante, hVentaD:Art.AutoRecaudacion=<T>Gasto<T>)<BR>  Fin<BR>Sino<BR>  Asigna(Info.Estatus, hVenta:hVenta.Estatus)<BR>  Asigna(Info.Modulo, <T>VTAS<T>)<BR>  Asigna(Info.ID, hVenta:hVenta.ID)<BR>  Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>  Asigna(Info.ArtLinea, hVentaD:Art.Linea)<BR>  Asigna(Info.SubCuenta, hVentaD:hVentaD.SubCuenta)<BR>  Asigna(Info.RenglonID, hVentaD:hVentaD.RenglonID)<BR>  Si<BR>    Forma(<T>AutoBoletoMov<T>)<BR>  Entonces<BR>    Asigna(hVentaD:hVentaD.Cantidad, Info.Cantidad)<BR>    Si<BR>      hVentaD:Art.AutoRecaudacion en (<T>Gasto No Reembolsable<T>, <T>Ingreso Costo<T>)<BR>    Entonces<BR>      Asigna(hVentaD:hVentaD.Costo, Info.Importe/Info.Cantidad)<BR>    Sino<BR>      Asigna(hVentaD:hVentaD.Precio, Info.Importe/Info.Cantidad)<BR>      Si(hVentaD:Art.AutoRecaudacion=<T>Gasto<T>, Asigna(hVentaD:hVentaD.Precio, -hVentaD:hVentaD.Precio))<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
EjecucionCondicion=(Info.SubModuloVenta=<T>AUTO<T>) y (hVentaD:Art.Linea en (Config.AutoArtBA, Config.AutoArtBX))
VisibleCondicion=General.Autotransportes o Usuario.AsistentePrecios

[Detalle.hVentaD.AutoLocalidad]
Carpeta=Detalle
Clave=hVentaD.AutoLocalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=hVenta
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
CondicionEdicion=Vacio(hVenta:hVenta.AnexoID)
CondicionVisible=Info.SubModuloVenta=<T>AUTO<T>

[Corrida.hVenta.AutoCorrida]
Carpeta=Corrida
Clave=hVenta.AutoCorrida
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

[Corrida.hVenta.AutoBoleto]
Carpeta=Corrida
Clave=hVenta.AutoBoleto
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
Expresion=Caso MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov)<BR>  Es VTAS.P   Entonces EjecutarSQL(<T>spDesAfectarPedido :nID, :tUsuario<T>, hVenta:hVenta.ID, Usuario)<BR>  Es VTAS.S   Entonces EjecutarSQL(<T>spDesAfectarPedido :nID, :tUsuario<T>, hVenta:hVenta.ID, Usuario)<BR>  Es VTAS.FAR Entonces EjecutarSQL(<T>spDesAfectarRecaudacion :nID<T>, hVenta:hVenta.ID)<BR>Sino<BR>  EjecutarSQL(<T>spDesAfectarPresupuesto :tModulo, :tMov, :nID<T>, <T>VTAS<T>, hVenta:hVenta.Mov, hVenta:hVenta.ID)<BR>Fin
ActivoCondicion=Usuario.Desafectar
VisibleCondicion=Usuario.Desafectar y <BR>((MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.P, VTAS.S)) y (hVenta:hVenta.Estatus=EstatusPendiente)) o<BR>(MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.PR, VTAS.FR, VTAS.FAR)) y (hVenta:hVenta.Estatus en (EstatusConcluido, EstatusRecurrente, EstatusBorrador))))

[Notas.hVenta.Periodicidad]
Carpeta=Notas
Clave=hVenta.Periodicidad
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
Menu=&Edición
NombreDesplegar=Anticipos Facturados...
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
Expresion=Si<BR>  Forma(<T>CxcAnticiposPendientes<T>)<BR>Entonces<BR>  Asigna(Temp.Reg, SQL(<T>SELECT SUM(AnticipoAplicar), SUM(AnticipoAplicar*Impuestos/(Importe+Impuestos)) FROM Cxc WHERE AnticipoAplicaModulo=:tModulo AND AnticipoAplicaID=:nID<T>, Info.Modulo, Info.ID))<BR>  Asigna(hVenta:hVenta.AnticiposFacturados, Temp.Reg[1])<BR>  Asigna(hVenta:hVenta.AnticiposImpuestos,  Temp.Reg[2])<BR>Fin
ActivoCondicion=hVenta:hVenta.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Cliente, hVenta:hVenta.Cliente)<BR>Asigna(Info.Nombre, hVenta:Cte.Nombre)
VisibleCondicion=Config.CxcAnticiposFacturados y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.F, VTAS.FAR, VTAS.FB))

[Acciones.CteEnviarA]
Nombre=CteEnviarA
Boton=0
Menu=&Edición
NombreDesplegar=&Sucursales del Cliente...
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteEnviarA
Antes=S
ActivoCondicion=Usuario.AgregarCteExpress y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
AntesExpresiones=Asigna(Info.Cliente, hVenta:hVenta.Cliente)<BR>Asigna(Info.Nombre, hVenta:Cte.Nombre)
VisibleCondicion=Usuario.CteSucursalVenta

[Detalle.hVentaD.SustitutoArticulo]
Carpeta=Detalle
Clave=hVentaD.SustitutoArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sustitutos]
Nombre=Sustitutos
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+S
NombreDesplegar=Sustitutos del Artículo
EnMenu=S
TipoAccion=Formas
ConCondicion=S
ClaveAccion=VentaAsignarSusutitos
Antes=S
GuardarAntes=S
RefrescarDespues=S
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
EjecucionCondicion=hVentaD:Art.Sustitutos
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>Asigna(Info.SubCuenta, hVentaD:hVentaD.SubCuenta)<BR>Asigna(Info.Descripcion, hVentaD:Art.Descripcion1)<BR>Asigna(Info.Almacen, hVentaD:hVentaD.Almacen)<BR>Asigna(Info.Cantidad, hVentaD:hVentaD.Cantidad)<BR>Asigna(Info.Renglon, hVentaD:hVentaD.Renglon)<BR>Asigna(Info.RenglonSub, hVentaD:hVentaD.RenglonSub)<BR>Asigna(Info.RenglonID, hVentaD:hVentaD.RenglonID)
VisibleCondicion=Config.FacturarSustitutos y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.R, VTAS.VCR, VTAS.F))

[Corrida.hVenta.Espacio]
Carpeta=Corrida
Clave=hVenta.Espacio
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

[Ficha.hVenta.UEN]
Carpeta=Ficha
Clave=hVenta.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.UEN]
Carpeta=Detalle
Clave=hVentaD.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Notas.hVenta.Clase]
Carpeta=Notas
Clave=hVenta.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.Subclase]
Carpeta=Notas
Clave=hVenta.Subclase
Editar=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.Espacio]
Carpeta=Detalle
Clave=hVentaD.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Detalle.hVentaD.HoraRequerida]
Carpeta=Detalle
Clave=hVentaD.HoraRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

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
EjecucionCondicion=ConDatos(hVenta:hVenta.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, hVenta:hVenta.Proyecto)
Visible=S

[Acciones.EspacioInfo]
Nombre=EspacioInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del Espacio
EnMenu=S
TipoAccion=Formas
ClaveAccion=EspacioInfo
ConCondicion=S
Antes=S
ActivoCondicion=General.Espacios y Config.VentaEspacioDetalle
EjecucionCondicion=ConDatos(hVentaD:hVentaD.Espacio)
AntesExpresiones=Asigna(Info.Espacio, hVentaD:hVentaD.Espacio)
VisibleCondicion=General.Espacios y Config.VentaEspacioDetalle

[Acciones.ProrrateoFecha]
Nombre=ProrrateoFecha
Boton=0
Menu=&Edición
NombreDesplegar=Prorratear Fecha Requerida
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
GuardarAntes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
Expresion=Si<BR>  Asigna(Info.Periodicidad, <T>Diaria<T>)<BR>  Asigna(Info.Veces, hVentaD:hVentaD.Cantidad)<BR>  Forma(<T>EspecificarPeriodicidad<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spProrrateoFecha :nEstacion, :nTotal, :fFecha, :tPeridicidad, :nVeces<T>, EstacionTrabajo, hVentaD:hVentaD.Cantidad, hVentaD:hVentaD.FechaRequerida, Info.Periodicidad, Info.Veces)<BR>  Si<BR>    Forma(<T>ProrrateoFecha<T>)<BR>  Entonces<BR>    EjecutarSQL(<T>spProrrateoFechaAceptar :nEstacion, :tModulo, :nID, :nRen, :nSub<T>, EstacionTrabajo, <T>VTAS<T>, hVenta:hVenta.ID, hVentaD:hVentaD.Renglon, hVentaD:hVentaD.RenglonSub)<BR>  Fin<BR>Fin
ActivoCondicion=(hVenta:hVenta.Estatus=EstatusSinAfectar) y (MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) en (VTAS.C, VTAS.CS, VTAS.P, VTAS.VP, VTAS.S, VTAS.PR, VTAS.EST)) y Config.VentaDFechaRequerida y General.Espacios
EjecucionCondicion=ConDatos(hVentaD:hVentaD.Articulo)
VisibleCondicion=Config.VentaDFechaRequerida y General.Espacios

[Detalle.CantidadInvNeta]
Carpeta=Detalle
Clave=CantidadInvNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=Si(Confirmacion(<T>¿ Desea Actualizar los Precios Otras Monedas ?<T>, BotonSi, BotonNo) = BotonSi, EjecutarSQL(<T>spVentaActualizarPrecios :nID<T>, hVenta:hVenta.ID))
ActivoCondicion=Config.VentaActualizarPrecioMoneda y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
VisibleCondicion=Config.VentaActualizarPrecioMoneda y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Corrida.hVenta.AutoKms]
Carpeta=Corrida
Clave=hVenta.AutoKms
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Plata
ColorFuente=Negro

[Corrida.hVenta.AutoBomba]
Carpeta=Corrida
Clave=hVenta.AutoBomba
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Corrida.hVenta.AutoBombaContador]
Carpeta=Corrida
Clave=hVenta.AutoBombaContador
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Corrida.hVenta.AutoKmsActuales]
Carpeta=Corrida
Clave=hVenta.AutoKmsActuales
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro

[Corrida.hVenta.AutoCorridaServicio]
Carpeta=Corrida
Clave=hVenta.AutoCorridaServicio
ValidaNombre=S
3D=S
Tamano=21
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.hVenta.AutoCorridaRol]
Carpeta=Corrida
Clave=hVenta.AutoCorridaRol
ValidaNombre=S
3D=S
Tamano=21
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.hVenta.AutoCorridaOrigen]
Carpeta=Corrida
Clave=hVenta.AutoCorridaOrigen
ValidaNombre=S
3D=S
Tamano=11
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.hVenta.AutoCorridaDestino]
Carpeta=Corrida
Clave=hVenta.AutoCorridaDestino
ValidaNombre=S
3D=S
Tamano=11
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.hVenta.AutoCorridaRuta]
Carpeta=Corrida
Clave=hVenta.AutoCorridaRuta
ValidaNombre=S
3D=S
Tamano=11
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.hVenta.AutoCorridaHora]
Carpeta=Corrida
Clave=hVenta.AutoCorridaHora
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.hVenta.AutoCorridaKms]
Carpeta=Corrida
Clave=hVenta.AutoCorridaKms
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Corrida.hVenta.AutoCorridaLts]
Carpeta=Corrida
Clave=hVenta.AutoCorridaLts
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Acciones.ServicioTipoPlantilla]
Nombre=ServicioTipoPlantilla
Boton=0
Menu=&Edición
NombreDesplegar=Sugerir Artículos del Tipo Servicio
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Alt+F2
Expresion=EjecutarSQL(<T>spGenerarServicioTipo :nID, :tEmp, :nSuc, :tAlm, :tLista, :tTipo, :tMoneda, :nTC, :fFecha<T>, hVenta:hVenta.ID, Empresa, Sucursal, hVenta:hVenta.Almacen, hVenta:hVenta.ListaPreciosEsp, hVenta:hVenta.ServicioTipo, hVenta:hVenta.Moneda, hVenta:hVenta.TipoCambio, hVenta:hVenta.FechaRequerida)
ActivoCondicion=hVenta:hVenta.Estatus=EstatusSinAfectar
EjecucionCondicion=ConDatos(hVenta:hVenta.ServicioTipo)
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
Vista=hVenta
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
CondicionVisible=MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) en (VTAS.FG, VTAS.FX)
CondicionEdicion=Vacio(hVenta:hVenta.AnexoID)

[Gasto.hVenta.GastoAcreedor]
Carpeta=Gasto
Clave=hVenta.GastoAcreedor
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

[Gasto.hVenta.GastoConcepto]
Carpeta=Gasto
Clave=hVenta.GastoConcepto
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
Vista=hVenta
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
ListaEnCaptura=hVenta.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S

[Comentarios.hVenta.Comentarios]
Carpeta=Comentarios
Clave=hVenta.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.SustitutoSubCuenta]
Carpeta=Detalle
Clave=hVentaD.SustitutoSubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CopiarComentario]
Nombre=CopiarComentario
Boton=0
Menu=&Archivo
NombreDesplegar=Copiar Comentario...
EnMenu=S
TipoAccion=Expresion
Expresion=Si(Forma(<T>ComentarioLista<T>), Asigna(hVenta:hVenta.Comentarios, Temp.Texto))
Activo=S
VisibleCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Servicio.hVenta.ServicioSiniestro]
Carpeta=Servicio
Clave=hVenta.ServicioSiniestro
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Servicio.hVenta.ServicioPlacas]
Carpeta=Servicio
Clave=hVenta.ServicioPlacas
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
ColorFuente=Negro

[Detalle.SubImpuesto2]
Carpeta=Detalle
Clave=SubImpuesto2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.SubImpuesto3]
Carpeta=Detalle
Clave=SubImpuesto3
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
ActivoCondicion=MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.CS))
EjecucionCondicion=ConDatos(hVenta:hVenta.ServicioSerie)
EjecucionMensaje=<T>Falta Especificar el VIN<T>
AntesExpresiones=Asigna(hVenta:hVenta.FordVisitoOASIS, Verdadero)
VisibleCondicion=General.Ford

[Servicio.hVenta.ServicioKms]
Carpeta=Servicio
Clave=hVenta.ServicioKms
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Servicio.hVenta.Cliente]
Carpeta=Servicio
Clave=hVenta.Cliente
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

[Servicio.hVenta.ListaPreciosEsp]
Carpeta=Servicio
Clave=hVenta.ListaPreciosEsp
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioTipoOrden]
Carpeta=Servicio
Clave=hVenta.ServicioTipoOrden
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioExpress]
Carpeta=Servicio
Clave=hVenta.ServicioExpress
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioTipoOperacion]
Carpeta=Servicio
Clave=hVenta.ServicioTipoOperacion
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
ColorFuente=Negro

[Detalle.hVentaD.Estado]
Carpeta=Detalle
Clave=hVentaD.Estado
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioNumero]
Carpeta=Servicio
Clave=hVenta.ServicioNumero
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioDemerito]
Carpeta=Servicio
Clave=hVenta.ServicioDemerito
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioDeducible]
Carpeta=Servicio
Clave=hVenta.ServicioDeducible
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
Expresion=Si<BR>  Config.VentaDMultiAgente<BR>Entonces<BR>  Asigna(Info.ID, hVenta:hVenta.ID)<BR>  Si(MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.P)) y (hVenta:hVenta.Estatus=EstatusPendiente), Forma(<T>VentaFechaEntrega<T>))<BR>Sino<BR>  Asigna(Info.Fecha, SQL(<T>spSugerirFechaEntrega :tEmp, :nID<T>, Empresa, hVenta:hVenta.ID))<BR>  Informacion(<T>Tiempo Entrega Sugerido: <T>+FechaEnTexto(Info.Fecha, <T>dddd dd/mmm/aaaa<T>))<BR>Fin
ActivoCondicion=hVenta:hVenta.Estatus noen (EstatusConcluido, EstatusCancelado)
VisibleCondicion=MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.C, VTAS.CS, VTAS.S, VTAS.P))

[Notas.hVenta.AgenteServicio]
Carpeta=Notas
Clave=hVenta.AgenteServicio
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
NombreDesplegar=Copiar en Meses...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Antes=S
Visible=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Si(no Forma(<T>MovCopiarMeses<T>),  AbortarOperacion)
DespuesGuardar=S

[Notas.hVenta.FechaOriginal]
Carpeta=Notas
Clave=hVenta.FechaOriginal
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.ServicioNumero]
Carpeta=Detalle
Clave=hVentaD.ServicioNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Notas.hVenta.ServicioTipo]
Carpeta=Notas
Clave=hVenta.ServicioTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.SucursalVenta]
Carpeta=Notas
Clave=hVenta.SucursalVenta
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
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Filtro, <T>AutoBoleto.VentaID=<T>+hVenta:hVenta.ID)
VisibleCondicion=General.AutoTransportes

[Acciones.SubMovimiento]
Nombre=SubMovimiento
Boton=0
Menu=&Archivo
NombreDesplegar=<T>Generar Sub <T>+hVenta:hVenta.Mov
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=CopiarMovimiento(<T>VTAS<T>, hVenta:hVenta.ID, <T>Venta<T>, <T>GENERAR<T>, <T>SUB<T>)
ActivoCondicion=MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.P, VTAS.S, VTAS.SD))
VisibleCondicion=Config.VentaSubMovimientos y (hVenta.Estatus en (EstatusPendiente, EstatusConcluido))

[Acciones.AnexarMov]
Nombre=AnexarMov
Boton=0
Menu=&Archivo
NombreDesplegar=Anexar Movimiento...
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Afectar.GenerarMov, Nulo)<BR>Si<BR>  Forma(<T>AnexarMov<T>)<BR>Entonces<BR>  CopiarMovimiento(Info.Modulo, Info.ID, <T>Venta<T>, <T>GENERAR<T>, <T>SUB<T>, Afectar.GenerarMov)<BR>Fin
VisibleCondicion=Config.VentaAnexarMov y (hVenta.Estatus en (EstatusPendiente, EstatusConcluido))

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
Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.Clave, <T>VTAS<T>+hVenta:hVenta.ID)<BR>Asigna(Info.Nombre, hVenta:hVenta.Mov+<T> <T>+hVenta:hVenta.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(hVenta:hVenta.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Servicio.hVenta.ServicioNumeroEconomico]
Carpeta=Servicio
Clave=hVenta.ServicioNumeroEconomico
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Servicio.hVenta.ServicioAseguradora]
Carpeta=Servicio
Clave=hVenta.ServicioAseguradora
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.AgentesAsignados]
Carpeta=Detalle
Clave=hVentaD.AgentesAsignados
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
EjecucionCondicion=hVentaD:Art.Linea=Config.AutoArtBT
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)
VisibleCondicion=General.Autotransportes y (hVentaD:Art.Linea=Config.AutoArtBT)

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
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>Asigna(Info.SubCuenta, hVentaD:hVentaD.SubCuenta)
VisibleCondicion=Config.BackOrders y (hVenta:hVenta.Estatus=EstatusPendiente) y MovTipoEn(<T>VTAS<T>,hVenta:hVenta.Mov, (VTAS.P, VTAS.S, VTAS.F, VTAS.FAR, VTAS.FC, VTAS.FG, VTAS.FX, VTAS.DFC, VTAS.FB))

[Notas.hVenta.AF]
Carpeta=Notas
Clave=hVenta.AF
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.AFArticulo]
Carpeta=Notas
Clave=hVenta.AFArticulo
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.AFSerie]
Carpeta=Notas
Clave=hVenta.AFSerie
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Detalle.hVentaD.AFArticulo]
Carpeta=Detalle
Clave=hVentaD.AFArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.AFSerie]
Carpeta=Detalle
Clave=hVentaD.AFSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato]
Estilo=Ficha
Pestana=S
Clave=Contrato
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hVenta
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
CondicionVisible=MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) = VTAS.CTO
CondicionEdicion=Vacio(hVenta:hVenta.AnexoID)

[Contrato.hVenta.ContratoTipo]
Carpeta=Contrato
Clave=hVenta.ContratoTipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.hVenta.ContratoDescripcion]
Carpeta=Contrato
Clave=hVenta.ContratoDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.hVenta.ContratoSerie]
Carpeta=Contrato
Clave=hVenta.ContratoSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.hVenta.ContratoValor]
Carpeta=Contrato
Clave=hVenta.ContratoValor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.hVenta.ContratoValorMoneda]
Carpeta=Contrato
Clave=hVenta.ContratoValorMoneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.hVenta.ContratoSeguro]
Carpeta=Contrato
Clave=hVenta.ContratoSeguro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.hVenta.ContratoResponsable]
Carpeta=Contrato
Clave=hVenta.ContratoResponsable
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.hVenta.ConVigencia]
Carpeta=Contrato
Clave=hVenta.ConVigencia
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.hVenta.VigenciaDesde]
Carpeta=Contrato
Clave=hVenta.VigenciaDesde
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Contrato.hVenta.VigenciaHasta]
Carpeta=Contrato
Clave=hVenta.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.hVenta.Periodicidad]
Carpeta=Contrato
Clave=hVenta.Periodicidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Contrato.hVenta.ContratoVencimiento]
Carpeta=Contrato
Clave=hVenta.ContratoVencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.ExcluirPlaneacion]
Carpeta=Detalle
Clave=hVentaD.ExcluirPlaneacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioDeducibleImporte]
Carpeta=Servicio
Clave=hVenta.ServicioDeducibleImporte
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

[Notas.hVenta.GenerarOP]
Carpeta=Notas
Clave=hVenta.GenerarOP
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Notas.hVenta.Extra1]
Carpeta=Notas
Clave=hVenta.Extra1
Editar=S
ValidaNombre=N
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioFlotilla]
Carpeta=Servicio
Clave=hVenta.ServicioFlotilla
Editar=S
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioRampa]
Carpeta=Servicio
Clave=hVenta.ServicioRampa
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actividades]
Nombre=Actividades
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+K
NombreDesplegar=Actividades del Artículo
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
Expresion=Asigna(Info.Minutos, SQL(<T>SELECT (Horas*60)+Minutos FROM ArtSub WHERE Articulo=:tArt AND SubCuenta=:tSub<T>, hVentaD:hVentaD.Articulo, hVentaD:hVentaD.SubCuenta))<BR>Si(hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente), Si(Forma(<T>VentaDAgente<T>), Asigna(hVentaD:hVentaD.AgentesAsignados, Info.Cantidad)), Si(Usuario.Costos, Forma(<T>VentaDAgenteCostoInfo<T>), Forma(<T>VentaDAgenteInfo<T>)))
ActivoCondicion=Config.VentaDMultiAgente
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Renglon, hVentaD:hVentaD.Renglon)<BR>Asigna(Info.RenglonSub, hVentaD:hVentaD.RenglonSub)<BR>Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>Asigna(Info.Descripcion, hVentaD:Art.Descripcion1)<BR>Asigna(Info.Cantidad, hVentaD:hVentaD.Cantidad)<BR>Asigna(Info.Agente, hVentaD:hVentaD.Agente)
VisibleCondicion=Config.VentaDMultiAgente

[Acciones.Incentivo]
Nombre=Incentivo
Boton=0
Menu=&Edición
NombreDesplegar=&Incentivo...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaIncentivo
Activo=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)
VisibleCondicion=General.Ford y (MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) = VTAS.F)

[Notas.hVenta.EndosarA]
Carpeta=Notas
Clave=hVenta.EndosarA
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
NombreDesplegar=Resumén
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaResumen
ActivoCondicion=hVenta:hVenta.Estatus<>EstatusSinAfectar
VisibleCondicion=MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) = VTAS.NR

[Acciones.AsesoresDisponible]
Nombre=AsesoresDisponible
Boton=0
Menu=&Ver
NombreDesplegar=Asesores Disponible
EnMenu=S
TipoAccion=Expresion
Antes=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+D
Expresion=Si(Forma(<T>AsesorDisponible<T>), Asigna(hVenta:hVenta.Agente, Info.Agente))
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
ConCondicion=S
EjecucionCondicion=ConDatos(hVenta:hVenta.FechaRequerida) y ConDatos(hVenta:hVenta.HoraRequerida)
EjecucionMensaje=Si(Vacio(hVenta:hVenta.FechaRequerida), <T>Falta Indicar la Fecha Requerida<T>)<BR>Si(Vacio(hVenta:hVenta.HoraRequerida), <T>Falta Indicar la Hora Requerida<T>)
EjecucionConError=S
AntesExpresiones=Asigna(Info.Fecha, hVenta:hVenta.FechaRequerida)<BR>Asigna(Info.Hora, hVenta:hVenta.HoraRequerida)
VisibleCondicion=General.Ford y (MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) = VTAS.S)

[Acciones.EditarVIN]
Nombre=EditarVIN
Boton=0
Menu=&Edición
NombreDesplegar=Datos VIN...
EnMenu=S
TipoAccion=Formas
ClaveAccion=VINPoliza
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(hVenta:hVenta.ServicioSerie)
AntesExpresiones=Asigna(Info.VIN, hVenta:hVenta.ServicioSerie)
VisibleCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.S, VTAS.CS)) y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Acciones.EditarCliente]
Nombre=EditarCliente
Boton=0
Menu=&Edición
NombreDesplegar=Datos Cliente...
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaCte
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(hVenta:hVenta.Cliente)
AntesExpresiones=Asigna(Info.Cliente, hVenta:hVenta.Cliente)
VisibleCondicion=Usuario.ModificarDatosCliente y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Acciones.PrecioConImpuestos]
Nombre=PrecioConImpuestos
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F6
NombreDesplegar=Precio con Impuestos Incluidos...
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Importe, Redondea((hVentaD:ImporteTotal*100)/(100-hVenta:hVenta.DescuentoGlobal), 2))<BR>Si<BR>  Forma(<T>EspecificarImporte<T>)<BR>Entonces<BR>  Asigna(hVentaD:hVentaD.Precio, Redondea(Info.Importe/(1+(JuntarImpuestos(hVentaD:hVentaD.Impuesto1+hVentaD:hVentaD.Impuesto3, hVentaD:hVentaD.Impuesto2)/100)), 2))<BR>Fin
ActivoCondicion=(no Usuario.BloquearPrecios) y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
VisibleCondicion=no Config.VentaPreciosImpuestoIncluido

[Notas.hVenta.DesglosarImpuesto2]
Carpeta=Notas
Clave=hVenta.DesglosarImpuesto2
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
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)
VisibleCondicion=(hVenta:hVenta.Estatus en (EstatusConcluido, EstatusPendiente, EstatusCancelado, EstatusProcesar)) y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.N, VTAS.NO, VTAS.NR, VTAS.FM, VTAS.F, VTAS.FAR, VTAS.FC, VTAS.FG, VTAS.FX, VTAS.FB, VTAS.D, VTAS.DF, VTAS.B))

[Acciones.MovActividad]
Nombre=MovActividad
Boton=0
Menu=&Edición
NombreDesplegar=Actividades del Movimiento
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+K
Expresion=Si(hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente), Si(Forma(<T>VentaMovActividad<T>), Asigna(hVentaD:hVentaD.AgentesAsignados, Info.Cantidad)), Si(Usuario.Costos, Forma(<T>VentaMovActividadCostoInfo<T>), Forma(<T>VentaMovActividadInfo<T>)))
ActivoCondicion=Config.VentaDMultiAgente
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)
VisibleCondicion=Config.VentaDMultiAgente

[Detalle.hVentaD.Codigo]
Carpeta=Detalle
Clave=hVentaD.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Filtro, <T>AutoBoleto.FacturaID=<T>+hVenta:hVenta.ID)
VisibleCondicion=General.AutoTransportes

[Acciones.ExcluirISAN]
Nombre=ExcluirISAN
Boton=0
NombreDesplegar=Excluir/Cargar ISAN...
EnMenu=S
TipoAccion=Expresion
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+E
Expresion=Si<BR>  hVentaD:hVentaD.ExcluirISAN<BR>Entonces<BR>   Si(Confirmacion(<T>¿ Desea Incluir de Nuevo Este Accesorio en el Cálculo del ISAN ?<T>, BotonSi, BotonNo)=BotonSi, Asigna(hVentaD:hVentaD.ExcluirISAN, Falso))<BR>Sino<BR>   Si(Precaucion(<T>¿ Desea Excluir Este Accesorio en el Cálculo del ISAN ?<T>, BotonSi, BotonNo)=BotonSi, Asigna(hVentaD:hVentaD.ExcluirISAN, Verdadero))<BR>Fin
ActivoCondicion=hVenta:hVenta.DesglosarImpuesto2 y (hVentaD:Art.Tipo<>TipoVIN)
VisibleCondicion=General.Ford y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.P, VTAS.VCR, VTAS.R, VTAS.DCR, VTAS.DR, VTAS.F, VTAS.DC))

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
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Fecha, hVenta:hVenta.FechaEmision)<BR>Asigna(Info.Estatus, hVenta:hVenta.Estatus)

[Detalle.hVentaD.EnviarA]
Carpeta=Detalle
Clave=hVentaD.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hVentaD.ExcluirISAN]
Carpeta=Detalle
Clave=hVentaD.ExcluirISAN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
EjecucionCondicion=ConDatos(hVenta:hVenta.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Clave, hVenta:hVenta.Mov)

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
EjecucionCondicion=ConDatos(hVenta:hVenta.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Concepto, hVenta:hVenta.Concepto)

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
Menu=&Edición
NombreDesplegar=&Seguros y Participaciones...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaParticipacion
Activo=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)
VisibleCondicion=General.Ford y (MovTipo(<T>VTAS<T>, hVenta:hVenta.Mov) = VTAS.F)

[AC]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Crédito
Clave=AC
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hVenta
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
CondicionVisible=General.AC y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.C,VTAS.CS,VTAS.P,VTAS.S,VTAS.F,VTAS.EST))

[AC.hVenta.LineaCredito]
Carpeta=AC
Clave=hVenta.LineaCredito
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.hVenta.TipoAmortizacion]
Carpeta=AC
Clave=hVenta.TipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.hVenta.TipoTasa]
Carpeta=AC
Clave=hVenta.TipoTasa
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

[AC.hVenta.Condicion]
Carpeta=AC
Clave=hVenta.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.hVenta.Vencimiento]
Carpeta=AC
Clave=hVenta.Vencimiento
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
NombreDesplegar=Tabla A&mortización
EnMenu=S
TipoAccion=Expresion
Activo=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+M
GuardarAntes=S
Expresion=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.Estatus, hVenta:hVenta.Estatus)<BR>Si(hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar), EjecutarSQL(<T>spTablaAmortizacion :tModulo, :nID, :tUsuario<T>, Info.Modulo, Info.ID, Usuario))<BR>Forma(<T>TablaAmortizacion<T>)
VisibleCondicion=General.AC y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.C,VTAS.CS,VTAS.P,VTAS.S,VTAS.F,VTAS.EST))

[Corrida.hVenta.AutoOperador2]
Carpeta=Corrida
Clave=hVenta.AutoOperador2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AC.hVenta.Comisiones]
Carpeta=AC
Clave=hVenta.Comisiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AC.hVenta.ComisionesIVA]
Carpeta=AC
Clave=hVenta.ComisionesIVA
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
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+D
Expresion=Asigna(Temp.Monetario, Suma(hVentaD:Importe))<BR>Asigna(Info.Importe, Suma(hVentaD:DescGlobal))<BR>Si(Forma(<T>EspecificarDescuentoGlobal<T>), Asigna(hVenta:hVenta.DescuentoGlobal, Info.Importe/Temp.Monetario*100)  Forma.ActualizarTotalizadores)
ActivoCondicion=Usuario.ModificarDescGlobalImporte
VisibleCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.ServicioMatriz]
Nombre=ServicioMatriz
Boton=0
Menu=&Edición
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
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)<BR>Asigna(Info.ArtVersion, SQL(<T>SELECT Version FROM Art WHERE Articulo=:tArt<T>, hVenta:hVenta.ServicioArticulo))
VisibleCondicion=(General.Ford o General.Chrysler) y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.CS, VTAS.S))

[Servicio.hVenta.ServicioPuntual]
Carpeta=Servicio
Clave=hVenta.ServicioPuntual
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
Expresion=Asigna(Info.Bloqueado, Verdadero)<BR>Asigna(Info.VIN, hVenta:hVenta.ServicioSerie)<BR>Si(Config.VINAccesorioArt, Forma(<T>VINAccesorioArt<T>), Forma(<T>VINAccesorio<T>))
EjecucionCondicion=ConDatos(hVenta:hVenta.ServicioSerie)
VisibleCondicion=Config.VIN y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.CS, VTAS.S))

[Acciones.Mapa]
Nombre=Mapa
Boton=0
Menu=&Ver
NombreDesplegar=Mapa
EnMenu=S
TipoAccion=Expresion
GuardarAntes=S

Expresion=PlugIn(<T>InteliMap<T>, <T>Transaccion<T>, <T>Ventas<T>, hVenta:hVenta.ID)
[Acciones.ActualizarPrecios]
Nombre=ActualizarPrecios
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+F5
NombreDesplegar=Actualizar &Precios
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=EjecutarSQL(<T>spVentaActualizarPrecios :nID<T>, hVenta:hVenta.ID)
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

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
Expresion=Asigna(Info.Forma, <T>Venta<T>)<BR>Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.Nombre, hVenta:hVenta.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

[Notas.hVenta.AgenteComision]
Carpeta=Notas
Clave=hVenta.AgenteComision
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Detalle.hVentaD.Posicion]
Carpeta=Detalle
Clave=hVentaD.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TraspasarArticulos]
Nombre=TraspasarArticulos
Boton=0
Menu=&Edición
NombreDesplegar=Traspasar Articulos...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaTraspasarArticulos
Activo=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+T
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)
DespuesGuardar=S
VisibleCondicion=General.Ford y MovTipoEn(<T>VTAS<T>, hVenta:hVenta.Mov, (VTAS.P, VTAS.S)) y (hVenta:hVenta.Estatus=EstatusPendiente)

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>VTAS<T>, hVenta:hVenta.Mov, hVenta:hVenta.ID, Falso, hVenta:hVenta.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>VTAS<T>+hVenta:hVenta.ID)<BR>  Asigna(Info.Nombre, hVenta:hVenta.Mov+<T> <T>+hVenta:hVenta.MovID)<BR>  Asigna(Info.Modulo, <T>VTAS<T>)<BR>  Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Acciones.ImportarPDT]
Nombre=ImportarPDT
Boton=0
Menu=&Archivo
NombreDesplegar=Importar &PDT...
EnMenu=S
TipoAccion=Expresion
RefrescarDespues=S
GuardarAntes=S
Expresion=PlugIn(<T>PDT<T>, <T>VTAS<T>, hVenta:hVenta.ID)
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[AC.hVenta.TieneTasaEsp]
Carpeta=AC
Clave=hVenta.TieneTasaEsp
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[AC.hVenta.TasaEsp]
Carpeta=AC
Clave=hVenta.TasaEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Servicio.hVenta.ServicioPoliza]
Carpeta=Servicio
Clave=hVenta.ServicioPoliza
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
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)

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
FiltroGeneral=MovEvento.Modulo=<T>VTAS<T> AND MovEvento.ModuloID={hVenta:hVenta.ID}

[MovEvento.Columnas]
0=455
1=70

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

[Acciones.FEA]
Nombre=FEA
Boton=0
Menu=&Archivo
NombreDesplegar=Generar &Factura Electónica
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
EjecucionConError=S
Expresion=FEA.Generar(General.FEAWebService, General.FEACertificado, Usuario.FEACertificado, Usuario.FEALlave, hVenta:hVenta.ID)
ActivoCondicion=hVenta:hVenta.Estatus en (EstatusPendiente, EstatusConcluido)
EjecucionCondicion=SQL(<T>SELECT ConsecutivoFEA FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov<T>, <T>VTAS<T>, hVenta:hVenta.Mov)<><T><T>
EjecucionMensaje=<T>Este Movimiento no Genera Factura Electrónica<T>

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
Vista=hVenta
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
CondicionVisible=Config.VentaVerDatosOC y (MovTipo(<T>VTAS<T>,hVenta:hVenta.Mov) noen (VTAS.D,VTAS.DF,VTAS.B,VTAS.DC,VTAS.DCR))

[OC.hVenta.OrdenCompra]
Carpeta=OC
Clave=hVenta.OrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[OC.hVenta.FechaOrdenCompra]
Carpeta=OC
Clave=hVenta.FechaOrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[OC.hVenta.ReferenciaOrdenCompra]
Carpeta=OC
Clave=hVenta.ReferenciaOrdenCompra
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
Expresion=VerComentario(<T>Comentarios<T>, hVenta:hVenta.Comentarios)
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
ActivoCondicion=Usuario.EnviarExcel y (hVenta:hVenta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Detalle.hVentaD.DescripcionExtra]
Carpeta=Detalle
Clave=hVentaD.DescripcionExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.DatosEntrega]
Nombre=DatosEntrega
Boton=0
Menu=&Edición
NombreDesplegar=Datos &Entrega...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaEntrega
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)

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
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>VTAS<T>, <T>{hVenta:hVenta.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>VTAS{hVenta:hVenta.ID}<T>
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
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+P
NombreDesplegar=Presupuesto Especifico
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaDPresupuestoEsp
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=hVentaD:hVentaD.PresupuestoEsp y ConDatos(hVentaD:hVentaD.Articulo)
AntesExpresiones=Asigna(Info.PuedeEditar, hVenta:hVenta.Estatus=EstatusSinAfectar)<BR>Asigna(Info.Importe, hVentaD:ImporteTotal)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Renglon, hVentaD:hVentaD.Renglon)<BR>Asigna(Info.RenglonSub, hVentaD:hVentaD.RenglonSub)<BR>Asigna(Info.Articulo, hVentaD:hVentaD.Articulo)<BR>Asigna(Info.Concepto, Nulo)
VisibleCondicion=General.PPTO y General.PPTOVentas

[Detalle.hVentaD.PresupuestoEsp]
Carpeta=Detalle
Clave=hVentaD.PresupuestoEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=Asigna(Anexo.Modulo, <T>VTAS<T>)<BR>Asigna(Anexo.ID, hVenta:hVenta.ID)<BR>Asigna(Anexo.Mov, hVenta:hVenta.Mov)<BR>Asigna(Anexo.MovID, hVenta:hVenta.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, Anexo.Mov, Anexo.MovID)
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
Expresion=Asigna(Anexo.Modulo, <T>VTAS<T>)<BR>Asigna(Anexo.ID, hVenta:hVenta.ID)<BR>Asigna(Anexo.Mov, hVenta:hVenta.Mov)<BR>Asigna(Anexo.MovID, hVenta:hVenta.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo.Anexar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, BuscarArchivo(<T><T>, Anexo.Clave+<T>.xml<T>, <T>xml<T>, Anexo.Clave, <T>Formas InfoPath<T>))
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
Expresion=Asigna(Anexo.Modulo, <T>VTAS<T>)<BR>Asigna(Anexo.ID, hVenta:hVenta.ID)<BR>Asigna(Anexo.Mov, hVenta:hVenta.Mov)<BR>Asigna(Anexo.MovID, hVenta:hVenta.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>MovFormaAnexo.Eliminar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo)
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
ExpAntesRefrescar=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, hVenta:hVenta.ID)<BR>Asigna(Info.Mov, hVenta:hVenta.Mov)<BR>Asigna(Info.MovID, hVenta:hVenta.MovID)
IconosNombre=MovFormaAnexo:Nombre

[Notas.hVenta.Enganche]
Carpeta=Notas
Clave=hVenta.Enganche
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hVenta.FormaPagoTipo]
Carpeta=Ficha
Clave=hVenta.FormaPagoTipo
Editar=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro




[Ficha.ListaEnCaptura]
(Inicio)=hVenta.Mov
hVenta.Mov=hVenta.MovID
hVenta.MovID=hVenta.Proyecto
hVenta.Proyecto=hVenta.UEN
hVenta.UEN=hVenta.Moneda
hVenta.Moneda=hVenta.TipoCambio
hVenta.TipoCambio=hVenta.ServicioContratoTipo
hVenta.ServicioContratoTipo=hVenta.FechaEmision
hVenta.FechaEmision=hVenta.FechaRequerida
hVenta.FechaRequerida=hVenta.HoraRequerida
hVenta.HoraRequerida=hVenta.FechaOriginal
hVenta.FechaOriginal=hVenta.Retencion
hVenta.Retencion=hVenta.Cliente
hVenta.Cliente=Cte.Nombre
Cte.Nombre=Cte.RFC
Cte.RFC=hVenta.ListaPreciosEsp
hVenta.ListaPreciosEsp=hVenta.EnviarA
hVenta.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Direccion
CteEnviarA.Direccion=CteEnviarA.Clave
CteEnviarA.Clave=hVenta.FormaEnvio
hVenta.FormaEnvio=hVenta.Agente
hVenta.Agente=hVenta.Almacen
hVenta.Almacen=hVenta.AlmacenDestino
hVenta.AlmacenDestino=hVenta.Concepto
hVenta.Concepto=hVenta.Condicion
hVenta.Condicion=hVenta.Vencimiento
hVenta.Vencimiento=hVenta.FormaPagoTipo
hVenta.FormaPagoTipo=hVenta.Descuento
hVenta.Descuento=hVenta.DescuentoGlobal
hVenta.DescuentoGlobal=hVenta.Referencia
hVenta.Referencia=hVenta.OrdenCompra
hVenta.OrdenCompra=hVenta.Directo
hVenta.Directo=(Fin)

[Detalle.ListaOrden]
(Inicio)=hVentaD.Renglon<TAB>(Acendente)
hVentaD.Renglon<TAB>(Acendente)=hVentaD.RenglonSub<TAB>(Acendente)
hVentaD.RenglonSub<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=hVentaD.Aplica
hVentaD.Aplica=hVentaD.AplicaID
hVentaD.AplicaID=AplicaNombre
AplicaNombre=hVentaD.Codigo
hVentaD.Codigo=hVentaD.Articulo
hVentaD.Articulo=hVentaD.SubCuenta
hVentaD.SubCuenta=ClaveIdioma
ClaveIdioma=hVentaD.SustitutoArticulo
hVentaD.SustitutoArticulo=hVentaD.SustitutoSubCuenta
hVentaD.SustitutoSubCuenta=hVentaD.Cantidad
hVentaD.Cantidad=CantidadNeta
CantidadNeta=hVentaD.Unidad
hVentaD.Unidad=hVentaD.CantidadInventario
hVentaD.CantidadInventario=CantidadInvNeta
CantidadInvNeta=Art.Horas
Art.Horas=hVentaD.Espacio
hVentaD.Espacio=hVentaD.Precio
hVentaD.Precio=hVentaD.DescuentoLinea
hVentaD.DescuentoLinea=hVentaD.DescuentoImporte
hVentaD.DescuentoImporte=hVentaD.FechaRequerida
hVentaD.FechaRequerida=hVentaD.HoraRequerida
hVentaD.HoraRequerida=hVentaD.Instruccion
hVentaD.Instruccion=hVentaD.ExcluirPlaneacion
hVentaD.ExcluirPlaneacion=Importe
Importe=hVentaD.PresupuestoEsp
hVentaD.PresupuestoEsp=hVentaD.ExcluirISAN
hVentaD.ExcluirISAN=SubImpuesto2
SubImpuesto2=SubImpuesto1
SubImpuesto1=SubImpuesto3
SubImpuesto3=hVentaD.EnviarA
hVentaD.EnviarA=hVentaD.Almacen
hVentaD.Almacen=hVentaD.Posicion
hVentaD.Posicion=hVentaD.ContUso
hVentaD.ContUso=hVentaD.Agente
hVentaD.Agente=hVentaD.AgentesAsignados
hVentaD.AgentesAsignados=hVentaD.AFArticulo
hVentaD.AFArticulo=hVentaD.AFSerie
hVentaD.AFSerie=hVentaD.Costo
hVentaD.Costo=CostoTotal
CostoTotal=hVentaD.Paquete
hVentaD.Paquete=hVentaD.AutoLocalidad
hVentaD.AutoLocalidad=hVentaD.UEN
hVentaD.UEN=hVentaD.DescripcionExtra
hVentaD.DescripcionExtra=hVentaD.CantidadReservada
hVentaD.CantidadReservada=hVentaD.CantidadOrdenada
hVentaD.CantidadOrdenada=hVentaD.CantidadPendiente
hVentaD.CantidadPendiente=hVentaD.ServicioNumero
hVentaD.ServicioNumero=hVentaD.Estado
hVentaD.Estado=hVentaD.CantidadA
hVentaD.CantidadA=(Fin)

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
ExcluirISAN=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=hVenta.Cliente
hVenta.Cliente=Cte.Nombre
Cte.Nombre=hVenta.Almacen
hVenta.Almacen=hVenta.FechaEmision
hVenta.FechaEmision=hVenta.Importe
hVenta.Importe=hVenta.Saldo
hVenta.Saldo=Dias
Dias=Throughput
Throughput=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=(por Autorizar)
(por Autorizar)=SINAFECTAR
SINAFECTAR=BORRADOR
BORRADOR=CONFIRMAR
CONFIRMAR=PENDIENTE
PENDIENTE=SINCRO
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

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Desc
Desc=Sub total
Sub total=Impuestos
Impuestos=Total
Total=Renglon
Renglon=(Fin)

[Notas.ListaEnCaptura]
(Inicio)=hVenta.Observaciones
hVenta.Observaciones=hVenta.EndosarA
hVenta.EndosarA=hVenta.ZonaImpuesto
hVenta.ZonaImpuesto=hVenta.Prioridad
hVenta.Prioridad=hVenta.Enganche
hVenta.Enganche=hVenta.AnticiposFacturados
hVenta.AnticiposFacturados=hVenta.Atencion
hVenta.Atencion=hVenta.AtencionTelefono
hVenta.AtencionTelefono=hVenta.Departamento
hVenta.Departamento=hVenta.AgenteComision
hVenta.AgenteComision=hVenta.AgenteServicio
hVenta.AgenteServicio=AgenteDestino.Nombre
AgenteDestino.Nombre=hVenta.Causa
hVenta.Causa=hVenta.ServicioTipo
hVenta.ServicioTipo=hVenta.FechaOriginal
hVenta.FechaOriginal=hVenta.SucursalVenta
hVenta.SucursalVenta=hVenta.Bonificacion
hVenta.Bonificacion=hVenta.Clase
hVenta.Clase=hVenta.Subclase
hVenta.Subclase=hVenta.VigenciaDesde
hVenta.VigenciaDesde=hVenta.VigenciaHasta
hVenta.VigenciaHasta=hVenta.Periodicidad
hVenta.Periodicidad=hVenta.DesglosarImpuestos
hVenta.DesglosarImpuestos=hVenta.DesglosarImpuesto2
hVenta.DesglosarImpuesto2=hVenta.ConVigencia
hVenta.ConVigencia=hVenta.Extra
hVenta.Extra=hVenta.ExcluirPlaneacion
hVenta.ExcluirPlaneacion=hVenta.GenerarOP
hVenta.GenerarOP=hVenta.Extra1
hVenta.Extra1=hVenta.AF
hVenta.AF=hVenta.AFArticulo
hVenta.AFArticulo=hVenta.AFSerie
hVenta.AFSerie=(Fin)

[Servicio.ListaEnCaptura]
(Inicio)=hVenta.ServicioSerie
hVenta.ServicioSerie=hVenta.ServicioNumeroEconomico
hVenta.ServicioNumeroEconomico=hVenta.ServicioPlacas
hVenta.ServicioPlacas=hVenta.ServicioKms
hVenta.ServicioKms=hVenta.ServicioArticulo
hVenta.ServicioArticulo=ArtDestino.Descripcion1
ArtDestino.Descripcion1=hVenta.ServicioPoliza
hVenta.ServicioPoliza=hVenta.Cliente
hVenta.Cliente=Cte.Nombre
Cte.Nombre=Cte.Telefonos
Cte.Telefonos=hVenta.ListaPreciosEsp
hVenta.ListaPreciosEsp=hVenta.ServicioTipo
hVenta.ServicioTipo=hVenta.ServicioTipoOperacion
hVenta.ServicioTipoOperacion=hVenta.ServicioTipoOrden
hVenta.ServicioTipoOrden=hVenta.ServicioFecha
hVenta.ServicioFecha=hVenta.ServicioAseguradora
hVenta.ServicioAseguradora=hVenta.ServicioSiniestro
hVenta.ServicioSiniestro=hVenta.ServicioContrato
hVenta.ServicioContrato=hVenta.ServicioContratoID
hVenta.ServicioContratoID=hVenta.ServicioContratoTipo
hVenta.ServicioContratoTipo=hVenta.ServicioDescripcion
hVenta.ServicioDescripcion=hVenta.ServicioGarantia
hVenta.ServicioGarantia=hVenta.ServicioExpress
hVenta.ServicioExpress=hVenta.ServicioPuntual
hVenta.ServicioPuntual=hVenta.ServicioDemerito
hVenta.ServicioDemerito=hVenta.ServicioFlotilla
hVenta.ServicioFlotilla=hVenta.ServicioRampa
hVenta.ServicioRampa=hVenta.ServicioDeducible
hVenta.ServicioDeducible=hVenta.ServicioDeducibleImporte
hVenta.ServicioDeducibleImporte=hVenta.ServicioIdentificador
hVenta.ServicioIdentificador=hVenta.ServicioNumero
hVenta.ServicioNumero=(Fin)

[Corrida.ListaEnCaptura]
(Inicio)=hVenta.Espacio
hVenta.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.Servicio
Espacio.Servicio=Espacio.Rol
Espacio.Rol=hVenta.AutoCorrida
hVenta.AutoCorrida=AutoCorrida.Nombre
AutoCorrida.Nombre=hVenta.AutoCorridaServicio
hVenta.AutoCorridaServicio=hVenta.AutoCorridaRol
hVenta.AutoCorridaRol=hVenta.AutoBoleto
hVenta.AutoBoleto=hVenta.AutoCorridaRuta
hVenta.AutoCorridaRuta=hVenta.AutoCorridaOrigen
hVenta.AutoCorridaOrigen=hVenta.AutoCorridaDestino
hVenta.AutoCorridaDestino=hVenta.AutoCorridaHora
hVenta.AutoCorridaHora=hVenta.AutoCorridaKms
hVenta.AutoCorridaKms=hVenta.AutoCorridaLts
hVenta.AutoCorridaLts=hVenta.AutoOperador2
hVenta.AutoOperador2=hVenta.AutoBomba
hVenta.AutoBomba=hVenta.AutoBombaContador
hVenta.AutoBombaContador=hVenta.AutoKmsActuales
hVenta.AutoKmsActuales=hVenta.AutoKms
hVenta.AutoKms=(Fin)

[Gasto.ListaEnCaptura]
(Inicio)=hVenta.GastoAcreedor
hVenta.GastoAcreedor=Acreedor.Nombre
Acreedor.Nombre=hVenta.GastoConcepto
hVenta.GastoConcepto=(Fin)

[Contrato.ListaEnCaptura]
(Inicio)=hVenta.ContratoDescripcion
hVenta.ContratoDescripcion=hVenta.ContratoTipo
hVenta.ContratoTipo=hVenta.ContratoSeguro
hVenta.ContratoSeguro=hVenta.ContratoValor
hVenta.ContratoValor=hVenta.ContratoValorMoneda
hVenta.ContratoValorMoneda=hVenta.ContratoSerie
hVenta.ContratoSerie=hVenta.ContratoResponsable
hVenta.ContratoResponsable=hVenta.ContratoVencimiento
hVenta.ContratoVencimiento=hVenta.Periodicidad
hVenta.Periodicidad=hVenta.VigenciaDesde
hVenta.VigenciaDesde=hVenta.VigenciaHasta
hVenta.VigenciaHasta=hVenta.ConVigencia
hVenta.ConVigencia=(Fin)

[AC.ListaEnCaptura]
(Inicio)=hVenta.LineaCredito
hVenta.LineaCredito=LC.Descripcion
LC.Descripcion=LC.VigenciaDesde
LC.VigenciaDesde=LC.VigenciaHasta
LC.VigenciaHasta=hVenta.TipoAmortizacion
hVenta.TipoAmortizacion=TipoAmortizacion.Descripcion
TipoAmortizacion.Descripcion=hVenta.Condicion
hVenta.Condicion=hVenta.Vencimiento
hVenta.Vencimiento=hVenta.TipoTasa
hVenta.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=hVenta.TieneTasaEsp
hVenta.TieneTasaEsp=hVenta.TasaEsp
hVenta.TasaEsp=hVenta.Comisiones
hVenta.Comisiones=hVenta.ComisionesIVA
hVenta.ComisionesIVA=TotalComisiones
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
(Inicio)=hVenta.OrdenCompra
hVenta.OrdenCompra=hVenta.FechaOrdenCompra
hVenta.FechaOrdenCompra=hVenta.ReferenciaOrdenCompra
hVenta.ReferenciaOrdenCompra=(Fin)

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




[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=AC
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
FormaExtraValor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=CopiarLote
CopiarLote=Abrir
Abrir=CopiarMeses
CopiarMeses=Localizar
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
Situacion=Sucursal
Sucursal=Afectar
Afectar=Autorizar
Autorizar=FEA
FEA=Desafectar
Desafectar=Consecutivo
Consecutivo=ModificarAlmacen
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
Asistente Codigo Barras (Lote)=Actividades
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
Mapa=MovBitacora
MovBitacora=PedidoPos
PedidoPos=TablaAmortizacion
TablaAmortizacion=RentabilidadContrato
RentabilidadContrato=MovPos
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
