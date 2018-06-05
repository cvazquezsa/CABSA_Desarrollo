[Forma]
Clave=EmpresaCfg
Nombre=<T>Configuración Módulos - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Inv
PosicionInicialIzquierda=257
PosicionInicialArriba=34
PosicionInicialAltura=477
PosicionInicialAncho=1021
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraAyuda=S
Comentarios=Info.Empresa
VentanaExclusiva=S
PosicionColumna1=53
CarpetasMultilinea=S
PosicionInicialAlturaCliente=726
PosicionSec1=238

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Info.Valor,SQL(<T>SELECT GastoConceptosInventariables FROM EmpresaCfg2 WHERE Empresa = :tEmpresa<T>,Info.Empresa))
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Inv]
Estilo=Ficha
Clave=Inv
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=4
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
CarpetaVisible=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Inventarios

FiltroGeneral=EmpresaCfg.Empresa=<T>{Info.Empresa}<T>
[Inv.EmpresaCfg.FormaCosteo]
Carpeta=Inv
Clave=EmpresaCfg.FormaCosteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=14
ColorFondo=Blanco

[Inv.EmpresaCfg.TipoCosteo]
Carpeta=Inv
Clave=EmpresaCfg.TipoCosteo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Movimientos.EmpresaCfg.MovReciboPrestamo]
Carpeta=Movimientos
Clave=EmpresaCfg.MovReciboPrestamo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Movimientos.EmpresaCfg.MovCambioPresentacion]
Carpeta=Movimientos
Clave=EmpresaCfg.MovCambioPresentacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Ventas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ventas
Clave=Ventas
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Ventas.EmpresaCfg.PedidosReservar]
Carpeta=Ventas
Clave=EmpresaCfg.PedidosReservar
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
EspacioPrevio=S
ColorFondo=Blanco

[Auto.EmpresaCfg.SeriesLotesAutoOrden]
Carpeta=Auto
Clave=EmpresaCfg.SeriesLotesAutoOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Auto.EmpresaCfg.CxcAplicaAutoOrden]
Carpeta=Auto
Clave=EmpresaCfg.CxcAplicaAutoOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Auto.EmpresaCfg.CxpAplicaAutoOrden]
Carpeta=Auto
Clave=EmpresaCfg.CxpAplicaAutoOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Auto.Columnas]
SeriesLotesAutoOrden=124
CxcAplicaAutoOrden=124
CxpAplicaAutoOrden=124

[Cxp]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=CxP
Clave=Cxp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Compras]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Compras
Clave=Compras
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Default.EmpresaCfg.DefImpuesto]
Carpeta=Default
Clave=EmpresaCfg.DefImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15

[Default.EmpresaCfg.DefUnidad]
Carpeta=Default
Clave=EmpresaCfg.DefUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15

[Inv.EmpresaCfg.CB]
Carpeta=Inv
Clave=EmpresaCfg.CB
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=15
EspacioPrevio=S
ColorFondo=Blanco

[Cont]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contabilidad
Clave=Cont
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Cont.EmpresaCfg.CtaFormato]
Carpeta=Cont
Clave=EmpresaCfg.CtaFormato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Cont.EmpresaCfg.ContMoneda]
Carpeta=Cont
Clave=EmpresaCfg.ContMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=15
Pegado=N
ColorFondo=Blanco

[General.EmpresaCfg.TiposPresupuesto]
Carpeta=General
Clave=EmpresaCfg.TiposPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20

[General.Columnas]
TiposPresupuesto=97

[Cont.EmpresaCfg.ContVerificarPosicion]
Carpeta=Cont
Clave=EmpresaCfg.ContVerificarPosicion
Editar=S
LineaNueva=N
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco

[Cxc]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=CxC
Clave=Cxc
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Ventas.EmpresaCfg.ValidarMargenMinimo]
Carpeta=Ventas
Clave=EmpresaCfg.ValidarMargenMinimo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Inv.EmpresaCfg.SeriesLotesAutoOrden]
Carpeta=Inv
Clave=EmpresaCfg.SeriesLotesAutoOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcAplicaAutoOrden]
Carpeta=Cxc
Clave=EmpresaCfg.CxcAplicaAutoOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxp.EmpresaCfg.CxpAplicaAutoOrden]
Carpeta=Cxp
Clave=EmpresaCfg.CxpAplicaAutoOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[General.EmpresaCfg.EditarConsecutivos]
Carpeta=General
Clave=EmpresaCfg.EditarConsecutivos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[General.EmpresaCfg.EmpresaDinero]
Carpeta=General
Clave=EmpresaCfg.EmpresaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[General.EmpresaCfg.DiasHabiles]
Carpeta=General
Clave=EmpresaCfg.DiasHabiles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S

[Inv.EmpresaCfg.SeriesLotesMayoreo]
Carpeta=Inv
Clave=EmpresaCfg.SeriesLotesMayoreo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco

[Default.EmpresaCfg.DefArtTipo]
Carpeta=Default
Clave=EmpresaCfg.DefArtTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15

[Default.EmpresaCfg.DefCondicion]
Carpeta=Default
Clave=EmpresaCfg.DefCondicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15

[General.EmpresaCfg.EmpresaCont]
Carpeta=General
Clave=EmpresaCfg.EmpresaCont
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[General.EmpresaCfg.ContX]
Carpeta=General
Clave=EmpresaCfg.ContX
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20

[General.EmpresaCfg.ContXAfectar]
Carpeta=General
Clave=EmpresaCfg.ContXAfectar
Editar=S
3D=S
Tamano=20
LineaNueva=S

[Default.EmpresaCfg.DefMoneda]
Carpeta=Default
Clave=EmpresaCfg.DefMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15

[Default.EmpresaCfg.AlmacenTransito]
Carpeta=Default
Clave=EmpresaCfg.AlmacenTransito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=15

[Compras.EmpresaCfg.CompraCostoSugerido]
Carpeta=Compras
Clave=EmpresaCfg.CompraCostoSugerido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[General.EmpresaCfg.ClaveDesarrollo]
Carpeta=General
Clave=EmpresaCfg.ClaveDesarrollo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Ventas.EmpresaCfg.VentaSurtirDemas]
Carpeta=Ventas
Clave=EmpresaCfg.VentaSurtirDemas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcAutoAjuste]
Carpeta=Cxc
Clave=EmpresaCfg.CxcAutoAjuste
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Cxp.EmpresaCfg.CxpAutoAjuste]
Carpeta=Cxp
Clave=EmpresaCfg.CxpAutoAjuste
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Cont.EmpresaCfg.ContVerificarIVA]
Carpeta=Cont
Clave=EmpresaCfg.ContVerificarIVA
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco

[Cont.EmpresaCfg.ContCentrosCostos]
Carpeta=Cont
Clave=EmpresaCfg.ContCentrosCostos
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

[Cont2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Estructura Contable
Clave=Cont2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Cont2.EmpresaCfg.CtaContabilidad]
Carpeta=Cont2
Clave=EmpresaCfg.CtaContabilidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cont2.EmpresaCfg.CtaActivo]
Carpeta=Cont2
Clave=EmpresaCfg.CtaActivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Cont2.EmpresaCfg.CtaPasivo]
Carpeta=Cont2
Clave=EmpresaCfg.CtaPasivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cont2.EmpresaCfg.CtaCapital]
Carpeta=Cont2
Clave=EmpresaCfg.CtaCapital
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cont2.EmpresaCfg.CtaResultados]
Carpeta=Cont2
Clave=EmpresaCfg.CtaResultados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Cont2.EmpresaCfg.CtaOrden]
Carpeta=Cont2
Clave=EmpresaCfg.CtaOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cuentas]
Nombre=Cuentas
Boton=51
NombreDesplegar=Cuentas de Estructura
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CtaEstructura
Activo=S
Visible=S

[Cont2.EmpresaCfg.CtaIngresos]
Carpeta=Cont2
Clave=EmpresaCfg.CtaIngresos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cont2.EmpresaCfg.CtaCostoDirecto]
Carpeta=Cont2
Clave=EmpresaCfg.CtaCostoDirecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfg.CxcFormaCobroDA]
Carpeta=Cxc
Clave=EmpresaCfg.CxcFormaCobroDA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Gastos.EmpresaCfg.GastoDirecto]
Carpeta=Gastos
Clave=EmpresaCfg.GastoDirecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Gastos.EmpresaCfg.GastoAfecta]
Carpeta=Gastos
Clave=EmpresaCfg.GastoAfecta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PV.EmpresaCfg.VentaLiquidaIntegral]
Carpeta=PV
Clave=EmpresaCfg.VentaLiquidaIntegral
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[PV.EmpresaCfg.VentaLiquidaAfecta]
Carpeta=PV
Clave=EmpresaCfg.VentaLiquidaAfecta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Dinero]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Tesorería
Clave=Dinero
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Dinero.EmpresaCfg.ChequesPendientes]
Carpeta=Dinero
Clave=EmpresaCfg.ChequesPendientes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Dinero.EmpresaCfg.eChequesPendientes]
Carpeta=Dinero
Clave=EmpresaCfg.eChequesPendientes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

[Servicios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Servicios
Clave=Servicios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=123
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
FichaEspacioNombresAuto=S

[Servicios.EmpresaCfg.VentaConfirmarServicios]
Carpeta=Servicios
Clave=EmpresaCfg.VentaConfirmarServicios
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Servicios.EmpresaCfg.VentaContratosImpuesto]
Carpeta=Servicios
Clave=EmpresaCfg.VentaContratosImpuesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Servicios.EmpresaCfg.VentaContratosArticulo]
Carpeta=Servicios
Clave=EmpresaCfg.VentaContratosArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Servicios.EmpresaCfg.VentaConfirmarContratos]
Carpeta=Servicios
Clave=EmpresaCfg.VentaConfirmarContratos
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Servicios.EmpresaCfg.InvPrestamosGarantias]
Carpeta=Servicios
Clave=EmpresaCfg.InvPrestamosGarantias
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Inv.EmpresaCfg.Partidas]
Carpeta=Inv
Clave=EmpresaCfg.Partidas
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaDefCantidad]
Carpeta=Ventas
Clave=EmpresaCfg.VentaDefCantidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Inv.EmpresaCfg.InvEntradasSinCosto]
Carpeta=Inv
Clave=EmpresaCfg.InvEntradasSinCosto
Editar=S
LineaNueva=N
3D=S
Tamano=21
ColorFondo=Blanco

[Inv.EmpresaCfg.CBProcesarLote]
Carpeta=Inv
Clave=EmpresaCfg.CBProcesarLote
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco
LineaNueva=S

[Cont.EmpresaCfg.ContTablaINPC]
Carpeta=Cont
Clave=EmpresaCfg.ContTablaINPC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
Pegado=N

[Inv.EmpresaCfg.SeriesImprimirMov]
Carpeta=Inv
Clave=EmpresaCfg.SeriesImprimirMov
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=32
ColorFondo=Blanco

[Servicios.EmpresaCfg.VentaServiciosRequiereTareas]
Carpeta=Servicios
Clave=EmpresaCfg.VentaServiciosRequiereTareas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=30

[Inv.EmpresaCfg.InvPaquetes]
Carpeta=Inv
Clave=EmpresaCfg.InvPaquetes
Editar=S
LineaNueva=N
3D=S
EspacioPrevio=N
Tamano=10
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaPaquetes]
Carpeta=Ventas
Clave=EmpresaCfg.VentaPaquetes
Editar=S
LineaNueva=S
3D=S
Tamano=10
ColorFondo=Blanco
EspacioPrevio=N

[Embarques]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Embarques
Clave=Embarques
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Embarques.EmpresaCfg.EmbarqueAfectarCobros]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueAfectarCobros
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=40

[ActivosF]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Activos Fijos
Clave=ActivosF
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[ActivosF.EmpresaCfg.AFRevaluarDepreciacion]
Carpeta=ActivosF
Clave=EmpresaCfg.AFRevaluarDepreciacion
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
Tamano=35

[ActivosF.EmpresaCfg.AFMantenimientoPendiente]
Carpeta=ActivosF
Clave=EmpresaCfg.AFMantenimientoPendiente
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
Tamano=40

[Inv.EmpresaCfg.ArtFormato]
Carpeta=Inv
Clave=EmpresaCfg.ArtFormato
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas.EmpresaCfg.CteFormato]
Carpeta=Ventas
Clave=EmpresaCfg.CteFormato
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Cont.EmpresaCfg.CentrosCostosFormato]
Carpeta=Cont
Clave=EmpresaCfg.CentrosCostosFormato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Cont.EmpresaCfg.ContCentrosCostosVerificarPos]
Carpeta=Cont
Clave=EmpresaCfg.ContCentrosCostosVerificarPos
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg.AplicarAGastos]
Carpeta=Gastos
Clave=EmpresaCfg.AplicarAGastos
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Cont.EmpresaCfg.ContUsoInv]
Carpeta=Cont
Clave=EmpresaCfg.ContUsoInv
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=N
ColorFondo=Blanco
Tamano=12

[Cont.EmpresaCfg.ContUsoGastos]
Carpeta=Cont
Clave=EmpresaCfg.ContUsoGastos
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=12

[Cont.EmpresaCfg.ContUsoCompras]
Carpeta=Cont
Clave=EmpresaCfg.ContUsoCompras
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=12

[Cont.EmpresaCfg.ContUsoVentas]
Carpeta=Cont
Clave=EmpresaCfg.ContUsoVentas
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=12

[Nomina]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Nomina
Clave=Nomina
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Nomina.EmpresaCfg.NomOmision]
Carpeta=Nomina
Clave=EmpresaCfg.NomOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Nomina.EmpresaCfg.NomBeneficiario]
Carpeta=Nomina
Clave=EmpresaCfg.NomBeneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
EspacioPrevio=N

[Servicios.EmpresaCfg.VentaServiciosTareaOmision]
Carpeta=Servicios
Clave=EmpresaCfg.VentaServiciosTareaOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfg.CompraVentaSinIVA]
Carpeta=Inv
Clave=EmpresaCfg.CompraVentaSinIVA
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Inv.EmpresaCfg.SeriesImprimirProp]
Carpeta=Inv
Clave=EmpresaCfg.SeriesImprimirProp
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco

[Nomina.EmpresaCfg.NomOmisionPeriodo]
Carpeta=Nomina
Clave=EmpresaCfg.NomOmisionPeriodo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Asiste]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Asistencias
Clave=Asiste
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Asiste.EmpresaCfg.AsisteToleraEntrada]
Carpeta=Asiste
Clave=EmpresaCfg.AsisteToleraEntrada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Asiste.EmpresaCfg.AsisteToleraSalida]
Carpeta=Asiste
Clave=EmpresaCfg.AsisteToleraSalida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaPreciosImpuestoIncluido]
Carpeta=Ventas
Clave=EmpresaCfg.VentaPreciosImpuestoIncluido
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=29
ColorFondo=Blanco

[RH]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=RH
Clave=RH
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Ventas.EmpresaCfg.VentaComisionesCobradas]
Carpeta=Ventas
Clave=EmpresaCfg.VentaComisionesCobradas
Editar=S
LineaNueva=N
3D=S
Tamano=18
ColorFondo=Blanco
ValidaNombre=N
EspacioPrevio=N

[Ventas.EmpresaCfg.FacturasPendientes]
Carpeta=Ventas
Clave=EmpresaCfg.FacturasPendientes
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S

[Compras.EmpresaCfg.CompraVerClaveProveedor]
Carpeta=Compras
Clave=EmpresaCfg.CompraVerClaveProveedor
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
EspacioPrevio=N
Tamano=35

[Ventas.EmpresaCfg.VentaLimiteRenFacturas]
Carpeta=Ventas
Clave=EmpresaCfg.VentaLimiteRenFacturas
Editar=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
Pegado=S

[Inv.EmpresaCfg.BackOrders]
Carpeta=Inv
Clave=EmpresaCfg.BackOrders
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
Tamano=12
ColorFondo=Blanco

[Inv.EmpresaCfg.InvFisicoConteo]
Carpeta=Inv
Clave=EmpresaCfg.InvFisicoConteo
Editar=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Ventas.EmpresaCfg.ValidarPrecios]
Carpeta=Ventas
Clave=EmpresaCfg.ValidarPrecios
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcPlazo1]
Carpeta=Cxc
Clave=EmpresaCfg.CxcPlazo1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=10
ColorFondo=Blanco
Pegado=S

[Cxc.EmpresaCfg.CxcPlazo2]
Carpeta=Cxc
Clave=EmpresaCfg.CxcPlazo2
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcPlazo3]
Carpeta=Cxc
Clave=EmpresaCfg.CxcPlazo3
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco
LineaNueva=S

[Cxc.EmpresaCfg.CxcPlazo4]
Carpeta=Cxc
Clave=EmpresaCfg.CxcPlazo4
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco

[Inv.EmpresaCfg.SugerirCostoDev]
Carpeta=Inv
Clave=EmpresaCfg.SugerirCostoDev
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Cxc2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=CxC (2)
Clave=Cxc2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=EmpresaCfg2.Empresa=<T>{Info.Empresa}<T>
[Cxc2.EmpresaCfg2.CxcPosfechados]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcPosfechados
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=N
ValidaNombre=N

[Cxp2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=CxP (2)
Clave=Cxp2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

[Cxp2.EmpresaCfg2.CxpPosfechados]
Carpeta=Cxp2
Clave=EmpresaCfg2.CxpPosfechados
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Ventas2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ventas (2)
Clave=Ventas2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

[Ventas2.EmpresaCfg2.FacturaCobroIntegrado]
Carpeta=Ventas2
Clave=EmpresaCfg2.FacturaCobroIntegrado
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaInstrucciones]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaInstrucciones
Editar=S
LineaNueva=S
3D=S
Tamano=51
ColorFondo=Blanco
EspacioPrevio=N

[Compra2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Compras (2)
Clave=Compra2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

[Cxc2.EmpresaCfg2.CxcAnticiposFacturados]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcAnticiposFacturados
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cxc2.EmpresaCfg2.CxcAplicaManualDef]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcAplicaManualDef
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cxp2.EmpresaCfg2.CxpAplicaManualDef]
Carpeta=Cxp2
Clave=EmpresaCfg2.CxpAplicaManualDef
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaDFechaRequerida]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaDFechaRequerida
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=25

[Inv.EmpresaCfg.BackOrdersNivel]
Carpeta=Inv
Clave=EmpresaCfg.BackOrdersNivel
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
Pegado=N

[Compra2.EmpresaCfg2.CompraRecibirDemas]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraRecibirDemas
Editar=S
LineaNueva=S
3D=S
Tamano=13
ColorFondo=Blanco

[Servicios.EmpresaCfg.AlmacenDestinoEntregaGarantia]
Carpeta=Servicios
Clave=EmpresaCfg.AlmacenDestinoEntregaGarantia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfg.CxpPlazo1]
Carpeta=Cxp
Clave=EmpresaCfg.CxpPlazo1
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Cxp.EmpresaCfg.CxpPlazo2]
Carpeta=Cxp
Clave=EmpresaCfg.CxpPlazo2
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco

[Cxp.EmpresaCfg.CxpPlazo3]
Carpeta=Cxp
Clave=EmpresaCfg.CxpPlazo3
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco
LineaNueva=S

[Cxp.EmpresaCfg.CxpPlazo4]
Carpeta=Cxp
Clave=EmpresaCfg.CxpPlazo4
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco

[MultiUnidades]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Multi Unidades
Clave=MultiUnidades
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=EmpresaCfg2.Empresa=<T>{Info.Empresa}<T>

[MultiUnidades.EmpresaCfg2.MultiUnidades]
Carpeta=MultiUnidades
Clave=EmpresaCfg2.MultiUnidades
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[MultiUnidades.EmpresaCfg2.NivelFactorMultiUnidad]
Carpeta=MultiUnidades
Clave=EmpresaCfg2.NivelFactorMultiUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[MultiUnidades.EmpresaCfg2.CompraFactorDinamico]
Carpeta=MultiUnidades
Clave=EmpresaCfg2.CompraFactorDinamico
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=30

[MultiUnidades.EmpresaCfg2.VentaFactorDinamico]
Carpeta=MultiUnidades
Clave=EmpresaCfg2.VentaFactorDinamico
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=30

[MultiUnidades.EmpresaCfg2.InvFactorDinamico]
Carpeta=MultiUnidades
Clave=EmpresaCfg2.InvFactorDinamico
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=30

[Compras.EmpresaCfg.AutorizarRequisiciones]
Carpeta=Compras
Clave=EmpresaCfg.AutorizarRequisiciones
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=N
Tamano=40
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaDevConsecutivoIndep]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaDevConsecutivoIndep
Editar=S
LineaNueva=N
3D=S
Tamano=45
ColorFondo=Blanco
EspacioPrevio=N

[Compra2.EmpresaCfg2.CompraDevConsecutivoIndep]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraDevConsecutivoIndep
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraBonifConsecutivoIndep]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraBonifConsecutivoIndep
Editar=S
LineaNueva=N
3D=S
Tamano=50
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.FacturasPendientesSerieLote]
Carpeta=Ventas2
Clave=EmpresaCfg2.FacturasPendientesSerieLote
Editar=S
LineaNueva=S
3D=S
Tamano=45
ColorFondo=Blanco

[ActivosF.EmpresaCfg.ContTablaINPC]
Carpeta=ActivosF
Clave=EmpresaCfg.ContTablaINPC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Multimonedas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Multi Monedas
Clave=Multimonedas
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)
PermiteEditar=S
CarpetaDesActivada=S

[Multimonedas.EmpresaCfg2.CxcMonedaCont]
Carpeta=Multimonedas
Clave=EmpresaCfg2.CxcMonedaCont
Editar=S
LineaNueva=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Multimonedas.EmpresaCfg2.AgentMonedaCont]
Carpeta=Multimonedas
Clave=EmpresaCfg2.AgentMonedaCont
Editar=S
LineaNueva=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Multimonedas.EmpresaCfg2.CxpMonedaCont]
Carpeta=Multimonedas
Clave=EmpresaCfg2.CxpMonedaCont
Editar=S
LineaNueva=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.VentaAutoBloqueo]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaAutoBloqueo
Editar=S
LineaNueva=S
3D=S
Tamano=45
ColorFondo=Blanco
EspacioPrevio=S

[Inv.EmpresaCfg.ToleranciaCosto]
Carpeta=Inv
Clave=EmpresaCfg.ToleranciaCosto
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
LineaNueva=N

[Inv.EmpresaCfg.ToleranciaTipoCosto]
Carpeta=Inv
Clave=EmpresaCfg.ToleranciaTipoCosto
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
LineaNueva=S

[Ventas2.EmpresaCfg2.AutoAsignarBackOrders]
Carpeta=Ventas2
Clave=EmpresaCfg2.AutoAsignarBackOrders
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=45
ColorFondo=Blanco

[Prod]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Producción
Clave=Prod
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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
CondicionVisible=General.Prod

[MultiUnidades.EmpresaCfg2.ProdFactorDinamico]
Carpeta=MultiUnidades
Clave=EmpresaCfg2.ProdFactorDinamico
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.VentaMultiAlmacen]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaMultiAlmacen
Editar=S
LineaNueva=N
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=N

[Inv2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Inventarios (2)
Clave=Inv2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=EmpresaCfg2.Empresa=<T>{Info.Empresa}<T>

[Inv2.EmpresaCfg2.InvMultiAlmacen]
Carpeta=Inv2
Clave=EmpresaCfg2.InvMultiAlmacen
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
EspacioPrevio=N

[Inv2.EmpresaCfg2.VIN]
Carpeta=Inv2
Clave=EmpresaCfg2.VIN
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Inv.EmpresaCfg.CosteoNivelSubCuenta]
Carpeta=Inv
Clave=EmpresaCfg.CosteoNivelSubCuenta
Editar=S
LineaNueva=N
3D=S
Tamano=21
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaDevSinAntecedente]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaDevSinAntecedente
Editar=S
LineaNueva=S
3D=S
Tamano=45
ColorFondo=Blanco
EspacioPrevio=N

[Ventas.EmpresaCfg.VentaPrecios]
Carpeta=Ventas
Clave=EmpresaCfg.VentaPrecios
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco

[Inv.EmpresaCfg.CosteoSeries]
Carpeta=Inv
Clave=EmpresaCfg.CosteoSeries
Editar=S
3D=S
Tamano=21
ColorFondo=Blanco

[Inv.EmpresaCfg.CosteoLotes]
Carpeta=Inv
Clave=EmpresaCfg.CosteoLotes
Editar=S
3D=S
Tamano=21
ColorFondo=Blanco

[Inv2.EmpresaCfg2.ValidarLotesCostoDif]
Carpeta=Inv2
Clave=EmpresaCfg2.ValidarLotesCostoDif
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
EspacioPrevio=S

[Prod.EmpresaCfg2.ProdAutoLote]
Carpeta=Prod
Clave=EmpresaCfg2.ProdAutoLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[Inv.EmpresaCfg.ArtRevision]
Carpeta=Inv
Clave=EmpresaCfg.ArtRevision
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdMermaIncluida]
Carpeta=Prod
Clave=EmpresaCfg2.ProdMermaIncluida
Editar=S
LineaNueva=N
3D=S
EspacioPrevio=N
Tamano=50
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdDesperdicioIncluido]
Carpeta=Prod
Clave=EmpresaCfg2.ProdDesperdicioIncluido
Editar=S
LineaNueva=N
3D=S
Tamano=50
ColorFondo=Blanco

[Prod.EmpresaCfg2.Mermas]
Carpeta=Prod
Clave=EmpresaCfg2.Mermas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
Tamano=27
ColorFondo=Blanco

[Prod.EmpresaCfg2.Desperdicios]
Carpeta=Prod
Clave=EmpresaCfg2.Desperdicios
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=27
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaMultiAgente]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaMultiAgente
Editar=S
LineaNueva=N
3D=S
Tamano=25
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdAlmacenMP]
Carpeta=Prod
Clave=EmpresaCfg2.ProdAlmacenMP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=22
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdAutoReservar]
Carpeta=Prod
Clave=EmpresaCfg2.ProdAutoReservar
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdGenerarConsumo]
Carpeta=Prod
Clave=EmpresaCfg2.ProdGenerarConsumo
Editar=S
LineaNueva=S
3D=S
Tamano=27
ColorFondo=Blanco
ValidaNombre=N
EspacioPrevio=N

[ReglaNegocio]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Regla Negocio
Clave=ReglaNegocio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[ReglaNegocio.EmpresaCfg.VentaChecarCredito]
Carpeta=ReglaNegocio
Clave=EmpresaCfg.VentaChecarCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[ReglaNegocio.EmpresaCfg.VentaBloquearMorosos]
Carpeta=ReglaNegocio
Clave=EmpresaCfg.VentaBloquearMorosos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[ReglaNegocio.EmpresaCfg.EmbarqueModificarVencimiento]
Carpeta=ReglaNegocio
Clave=EmpresaCfg.EmbarqueModificarVencimiento
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Inv2.EmpresaCfg2.OpcionMatriz]
Carpeta=Inv2
Clave=EmpresaCfg2.OpcionMatriz
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Embarques.EmpresaCfg.EmbarqueEstadoPendiente]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueEstadoPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Embarques.EmpresaCfg.EmbarqueEstadoTransito]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueEstadoTransito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.VentaBonifConsecutivoIndep]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaBonifConsecutivoIndep
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=45
ColorFondo=Blanco


[Gastos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gastos
Clave=Gastos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

[Gastos.EmpresaCfg2.Gasto2Retenciones]
Carpeta=Gastos
Clave=EmpresaCfg2.Gasto2Retenciones
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoCantidades]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoCantidades
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoCopiarImporte]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoCopiarImporte
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoSolicitudAnticipoImpuesto]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoSolicitudAnticipoImpuesto
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdAfectarConsumo]
Carpeta=Prod
Clave=EmpresaCfg2.ProdAfectarConsumo
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaTEEstandar]
Carpeta=Ventas
Clave=EmpresaCfg.VentaTEEstandar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaTEEstandarTipoDias]
Carpeta=Ventas
Clave=EmpresaCfg.VentaTEEstandarTipoDias
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ValidaNombre=S

[Cxc.EmpresaCfg.CxcDocAutoFolio]
Carpeta=Cxc
Clave=EmpresaCfg.CxcDocAutoFolio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxp.EmpresaCfg.CxpDocAutoFolio]
Carpeta=Cxp
Clave=EmpresaCfg.CxpDocAutoFolio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Plan]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Planeación
Clave=Plan
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

[Plan.EmpresaCfg2.PlanAfectarOrdenesDistribucion]
Carpeta=Plan
Clave=EmpresaCfg2.PlanAfectarOrdenesDistribucion
Editar=S
LineaNueva=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=58

[Prod.EmpresaCfg2.ProdProgramar]
Carpeta=Prod
Clave=EmpresaCfg2.ProdProgramar
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Inv.EmpresaCfg.TransferirDemas]
Carpeta=Inv
Clave=EmpresaCfg.TransferirDemas
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaArtAlmacenEspecifico]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaArtAlmacenEspecifico
Editar=S
LineaNueva=S
3D=S
Tamano=45
ColorFondo=Blanco

[Dinero.EmpresaCfg.Cajeros]
Carpeta=Dinero
Clave=EmpresaCfg.Cajeros
Editar=S
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Blanco
ValidaNombre=S
EspacioPrevio=N

[Plan.EmpresaCfg2.RutaDistribucion]
Carpeta=Plan
Clave=EmpresaCfg2.RutaDistribucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Plan.EmpresaCfg2.RutaDistribucionNivelArticulo]
Carpeta=Plan
Clave=EmpresaCfg2.RutaDistribucionNivelArticulo
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfg.CxcFormaCobroVales]
Carpeta=Cxc
Clave=EmpresaCfg.CxcFormaCobroVales
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Pegado=N
LineaNueva=S

[VentasMostrador]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ventas Mostrador
Clave=VentasMostrador
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[VentasMostrador.EmpresaCfg.VentaLiquidaIntegral]
Carpeta=VentasMostrador
Clave=EmpresaCfg.VentaLiquidaIntegral
Editar=S
LineaNueva=S
3D=S
Tamano=13
ColorFondo=Blanco

[VentasMostrador.EmpresaCfg.NotasBorrador]
Carpeta=VentasMostrador
Clave=EmpresaCfg.NotasBorrador
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

[VentasMostrador.EmpresaCfg.ClienteFacturaVMOS]
Carpeta=VentasMostrador
Clave=EmpresaCfg.ClienteFacturaVMOS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Ventas2.EmpresaCfg2.CodigoCliente]
Carpeta=Ventas2
Clave=EmpresaCfg2.CodigoCliente
Editar=S
LineaNueva=N
3D=S
Tamano=45
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcRecargosConcepto]
Carpeta=Cxc
Clave=EmpresaCfg.CxcRecargosConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcProntoPagoConcepto]
Carpeta=Cxc
Clave=EmpresaCfg.CxcProntoPagoConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Cxp.EmpresaCfg.CxpProntoPagoConcepto]
Carpeta=Cxp
Clave=EmpresaCfg.CxpProntoPagoConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Cxp.EmpresaCfg.CxpRecargosConcepto]
Carpeta=Cxp
Clave=EmpresaCfg.CxpRecargosConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.FormaCobroOmision]
Carpeta=Cxc
Clave=EmpresaCfg.FormaCobroOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.FormaPagoCambio]
Carpeta=Cxc
Clave=EmpresaCfg.FormaPagoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxp.EmpresaCfg.FormaPagoOmision]
Carpeta=Cxp
Clave=EmpresaCfg.FormaPagoOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Cxp.EmpresaCfg.CxpRecorrerVencimiento]
Carpeta=Cxp
Clave=EmpresaCfg.CxpRecorrerVencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Servicios.EmpresaCfg.VentaServiciosAutoOP]
Carpeta=Servicios
Clave=EmpresaCfg.VentaServiciosAutoOP
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N
EspacioPrevio=S

[Compra2.EmpresaCfg2.CompraMultiAlmacen]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraMultiAlmacen
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco

[Dinero.EmpresaCfg.FormaPagoRequerida]
Carpeta=Dinero
Clave=EmpresaCfg.FormaPagoRequerida
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
EspacioPrevio=S
Tamano=50

[Nomina.EmpresaCfg.NomConceptoSDI]
Carpeta=Nomina
Clave=EmpresaCfg.NomConceptoSDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Nomina.EmpresaCfg.NomSugerirSDI]
Carpeta=Nomina
Clave=EmpresaCfg.NomSugerirSDI
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Nomina.EmpresaCfg.NomSugerirAumentoVacaciones]
Carpeta=Nomina
Clave=EmpresaCfg.NomSugerirAumentoVacaciones
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Nomina.EmpresaCfg.NomConceptoAumentoVacaciones]
Carpeta=Nomina
Clave=EmpresaCfg.NomConceptoAumentoVacaciones
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S

[Nomina.EmpresaCfg.NomSugerirDisminuirVacaciones]
Carpeta=Nomina
Clave=EmpresaCfg.NomSugerirDisminuirVacaciones
Editar=S
LineaNueva=N
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco

[Nomina.EmpresaCfg.NomAfectarDisminuirVacaciones]
Carpeta=Nomina
Clave=EmpresaCfg.NomAfectarDisminuirVacaciones
Editar=S
LineaNueva=N
3D=S
ColorFondo=Blanco
Tamano=30

[Nomina.EmpresaCfg.NomConceptoDisminuirVacaciones]
Carpeta=Nomina
Clave=EmpresaCfg.NomConceptoDisminuirVacaciones
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Inv.EmpresaCfg.MonedaCosteo]
Carpeta=Inv
Clave=EmpresaCfg.MonedaCosteo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco

[Inv.EmpresaCfg.MonedaCosteoNivelArticulo]
Carpeta=Inv
Clave=EmpresaCfg.MonedaCosteoNivelArticulo
Editar=S
3D=S
Tamano=29
ColorFondo=Blanco
LineaNueva=S

[Cambios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cambios
Clave=Cambios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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
PermiteEditar=S
CondicionVisible=General.Cambios

[Cambios.EmpresaCfg.CambioOperacionRelevante]
Carpeta=Cambios
Clave=EmpresaCfg.CambioOperacionRelevante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cambios.EmpresaCfg.CambioMonedaRelevante]
Carpeta=Cambios
Clave=EmpresaCfg.CambioMonedaRelevante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cambios.EmpresaCfg.CambioCategoriaRelevante1]
Carpeta=Cambios
Clave=EmpresaCfg.CambioCategoriaRelevante1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cambios.EmpresaCfg.CambioCategoriaRelevante2]
Carpeta=Cambios
Clave=EmpresaCfg.CambioCategoriaRelevante2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compra2.EmpresaCfg2.CompraAutoCargos]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraAutoCargos
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
EspacioPrevio=S

[Cambios.EmpresaCfg.CambioDiasRemesas]
Carpeta=Cambios
Clave=EmpresaCfg.CambioDiasRemesas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfg.CxcDocAnticipoAutoFolio]
Carpeta=Cxc
Clave=EmpresaCfg.CxcDocAnticipoAutoFolio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Pegado=N

[Cxp.EmpresaCfg.CxpDocAnticipoAutoFolio]
Carpeta=Cxp
Clave=EmpresaCfg.CxpDocAnticipoAutoFolio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Pegado=N

[Plan.EmpresaCfg2.PlanSinDemanda]
Carpeta=Plan
Clave=EmpresaCfg2.PlanSinDemanda
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Prod.EmpresaCfg2.ProdTipoMerma]
Carpeta=Prod
Clave=EmpresaCfg2.ProdTipoMerma
Editar=S
LineaNueva=S
3D=S
Tamano=10
ColorFondo=Blanco
ValidaNombre=S
Pegado=N

[Plan.EmpresaCfg2.PlanTESeguridad]
Carpeta=Plan
Clave=EmpresaCfg2.PlanTESeguridad
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.VentaDescuentoImporte]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaDescuentoImporte
Editar=S
LineaNueva=S
3D=S
Tamano=51
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraDescuentoImporte]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraDescuentoImporte
Editar=S
LineaNueva=N
3D=S
Tamano=50
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdAutoCB]
Carpeta=Prod
Clave=EmpresaCfg2.ProdAutoCB
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanLiberarCompra]
Carpeta=Plan
Clave=EmpresaCfg2.PlanLiberarCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Plan.EmpresaCfg2.PlanLiberarProduccion]
Carpeta=Plan
Clave=EmpresaCfg2.PlanLiberarProduccion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Plan.EmpresaCfg2.PlanLiberarDistribucion]
Carpeta=Plan
Clave=EmpresaCfg2.PlanLiberarDistribucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfg.CompraPaquetes]
Carpeta=Compras
Clave=EmpresaCfg.CompraPaquetes
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=N
EspacioPrevio=S

[Ventas2.EmpresaCfg2.VentaBonificacionAuto]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaBonificacionAuto
Editar=S
LineaNueva=S
3D=S
Tamano=45
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanInvSeguridadDias]
Carpeta=Plan
Clave=EmpresaCfg2.PlanInvSeguridadDias
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Plan.EmpresaCfg2.PlanInvSeguridadFactor]
Carpeta=Plan
Clave=EmpresaCfg2.PlanInvSeguridadFactor
Editar=S
LineaNueva=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S
Pegado=N

[Embarques.EmpresaCfg.EmbarqueGenerarGastoTarifas]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueGenerarGastoTarifas
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfg.DineroDesgloseObligatorio]
Carpeta=Dinero
Clave=EmpresaCfg.DineroDesgloseObligatorio
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Dinero.EmpresaCfg.DineroAfectarComision]
Carpeta=Dinero
Clave=EmpresaCfg.DineroAfectarComision
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Cxp2.EmpresaCfg2.CxpAplicacionPagos]
Carpeta=Cxp2
Clave=EmpresaCfg2.CxpAplicacionPagos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaSolicitarPrecios]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaSolicitarPrecios
Editar=S
LineaNueva=N
3D=S
Tamano=45
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraVerClaveIdioma]
Carpeta=Compras
Clave=EmpresaCfg.CompraVerClaveIdioma
Editar=S
LineaNueva=N
3D=S
Tamano=35
ColorFondo=Blanco

[Ventas.EmpresaCfg.CancelarFacturaReservarPedido]
Carpeta=Ventas
Clave=EmpresaCfg.CancelarFacturaReservarPedido
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
EspacioPrevio=S

[Cxc2.EmpresaCfg2.CxcDegloseDef]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcDegloseDef
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Inv.EmpresaCfg.InvVerClaveIdioma]
Carpeta=Inv
Clave=EmpresaCfg.InvVerClaveIdioma
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaVerClaveIdioma]
Carpeta=Ventas
Clave=EmpresaCfg.VentaVerClaveIdioma
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Embarques.EmpresaCfg.EmbarqueAfectarGastoTarifas]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueAfectarGastoTarifas
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Cxp2.EmpresaCfg2.CxpAfectarPagosAutomaticos]
Carpeta=Cxp2
Clave=EmpresaCfg2.CxpAfectarPagosAutomaticos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoValidarPresupuesto]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoValidarPresupuesto
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco

[Cxc2.EmpresaCfg2.CxcDiasMorosidad]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcDiasMorosidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
EspacioPrevio=S

[Cxp2.EmpresaCfg2.CxpDiasMorosidad]
Carpeta=Cxp2
Clave=EmpresaCfg2.CxpDiasMorosidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=5
ColorFondo=Blanco

[Ventas.EmpresaCfg.ComisionBase]
Carpeta=Ventas
Clave=EmpresaCfg.ComisionBase
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=16
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdTransferenciaConcentrada]
Carpeta=Prod
Clave=EmpresaCfg2.ProdTransferenciaConcentrada
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoActividad]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoActividad
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
EspacioPrevio=S

[Gastos.EmpresaCfg2.GastoProyectoDetalle]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoProyectoDetalle
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Nomina.EmpresaCfg.NomAfectarAumentoVacaciones]
Carpeta=Nomina
Clave=EmpresaCfg.NomAfectarAumentoVacaciones
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S

[Cxc2.EmpresaCfg2.CxcCobroImpuestos]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcCobroImpuestos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=N

[Compra2.EmpresaCfg2.CompraSugerirUltimoCostoProv]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraSugerirUltimoCostoProv
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Plan.EmpresaCfg2.ProdPeriodosCorrida]
Carpeta=Plan
Clave=EmpresaCfg2.ProdPeriodosCorrida
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N
Pegado=S

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
Vista=EmpresaCfg2
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

[Fiscal.EmpresaCfg2.FiscalVerIVA]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalVerIVA
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalVentaImpuesto3]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalVentaImpuesto3
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=97
ColorFondo=Plata

[Fiscal.EmpresaCfg2.FiscalCompraImpuesto3]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalCompraImpuesto3
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=97
ColorFondo=Plata

[Plan.EmpresaCfg2.PlanCalcATP]
Carpeta=Plan
Clave=EmpresaCfg2.PlanCalcATP
Editar=S
LineaNueva=N
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Plan.EmpresaCfg2.PlanAbortarPrimerError]
Carpeta=Plan
Clave=EmpresaCfg2.PlanAbortarPrimerError
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Prod.EmpresaCfg2.ProdAfectarConsumoParcial]
Carpeta=Prod
Clave=EmpresaCfg2.ProdAfectarConsumoParcial
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanEstadoOmision]
Carpeta=Plan
Clave=EmpresaCfg2.PlanEstadoOmision
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=N

[Plan.EmpresaCfg2.PlanCorridaOrden]
Carpeta=Plan
Clave=EmpresaCfg2.PlanCorridaOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.EmpresaCfg2.FiscalInicioIVA]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalInicioIVA
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Inv.EmpresaCfg.CBDirAlmacen]
Carpeta=Inv
Clave=EmpresaCfg.CBDirAlmacen
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[RH.EmpresaCfg.NomCCRequerido]
Carpeta=RH
Clave=EmpresaCfg.NomCCRequerido
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Ventas.EmpresaCfg.ComisionEspecial]
Carpeta=Ventas
Clave=EmpresaCfg.ComisionEspecial
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
EspacioPrevio=S

[Ventas.EmpresaCfg.VentaAnticipoCredito]
Carpeta=Ventas
Clave=EmpresaCfg.VentaAnticipoCredito
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraAnticipoCredito]
Carpeta=Compras
Clave=EmpresaCfg.CompraAnticipoCredito
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Cxc2.EmpresaCfg2.CxcComisionCreditos]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcComisionCreditos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Dinero.EmpresaCfg.DineroContX]
Carpeta=Dinero
Clave=EmpresaCfg.DineroContX
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco

[Dinero.EmpresaCfg.DineroControlarSobregiros]
Carpeta=Dinero
Clave=EmpresaCfg.DineroControlarSobregiros
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaLimiteNivelSucursal]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaLimiteNivelSucursal
Editar=S
3D=S
Tamano=45
ColorFondo=Blanco
LineaNueva=S

[Inv2.EmpresaCfg2.InvRegistrarPrecios]
Carpeta=Inv2
Clave=EmpresaCfg2.InvRegistrarPrecios
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Cxc2.EmpresaCfg2.CxcAutoAplicarAnticiposPedidos]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcAutoAplicarAnticiposPedidos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanUnidadDistribucion]
Carpeta=Plan
Clave=EmpresaCfg2.PlanUnidadDistribucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VentasMostrador.EmpresaCfg.VentaSugerirSaldoFavorID]
Carpeta=VentasMostrador
Clave=EmpresaCfg.VentaSugerirSaldoFavorID
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.MargenNivelListaPrecios]
Carpeta=Ventas2
Clave=EmpresaCfg2.MargenNivelListaPrecios
Editar=S
LineaNueva=N
3D=S
Tamano=45
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanISDemanda]
Carpeta=Plan
Clave=EmpresaCfg2.PlanISDemanda
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.FacturarSustitutos]
Carpeta=Ventas2
Clave=EmpresaCfg2.FacturarSustitutos
Editar=S
3D=S
Tamano=17
ColorFondo=Blanco
LineaNueva=S

[Ventas2.EmpresaCfg2.VentaUENDetalle]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaUENDetalle
Editar=S
LineaNueva=N
3D=S
Tamano=15
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoUENDetalle]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoUENDetalle
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanTipoPeriodo]
Carpeta=Plan
Clave=EmpresaCfg2.PlanTipoPeriodo
Editar=S
3D=S
Pegado=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S
LineaNueva=S
EspacioPrevio=S

[Ventas.EmpresaCfg.VentaCobroRedondeoDecimales]
Carpeta=Ventas
Clave=EmpresaCfg.VentaCobroRedondeoDecimales
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.AutoAutorizacionFacturas]
Carpeta=Ventas2
Clave=EmpresaCfg2.AutoAutorizacionFacturas
Editar=S
LineaNueva=S
3D=S
Tamano=45
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaEspacioDetalle]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaEspacioDetalle
Editar=S
LineaNueva=N
3D=S
Tamano=25
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaDHoraRequerida]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaDHoraRequerida
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco
LineaNueva=N

[Compra2.EmpresaCfg2.CompraCostosImpuestoIncluido]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraCostosImpuestoIncluido
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraRetenciones]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraRetenciones
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Retenciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Retenciones
Clave=Retenciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

[Retenciones.EmpresaCfg2.GastoRetencionAcreedor]
Carpeta=Retenciones
Clave=EmpresaCfg2.GastoRetencionAcreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Retenciones.EmpresaCfg2.GastoRetencionConcepto]
Carpeta=Retenciones
Clave=EmpresaCfg2.GastoRetencionConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Retenciones.EmpresaCfg2.GastoRetencion2Acreedor]
Carpeta=Retenciones
Clave=EmpresaCfg2.GastoRetencion2Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Retenciones.EmpresaCfg2.GastoRetencion2Concepto]
Carpeta=Retenciones
Clave=EmpresaCfg2.GastoRetencion2Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Retenciones.Prov.Nombre]
Carpeta=Retenciones
Clave=Prov.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata

[Retenciones.ProvDestino.Nombre]
Carpeta=Retenciones
Clave=ProvDestino.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata

[Cont.EmpresaCfg.ContMovPresupuesto]
Carpeta=Cont
Clave=EmpresaCfg.ContMovPresupuesto
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=37
ColorFondo=Blanco

[Cxc2.EmpresaCfg2.ComisionesCobranza]
Carpeta=Cxc2
Clave=EmpresaCfg2.ComisionesCobranza
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaRenCompletosFactRapida]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaRenCompletosFactRapida
Editar=S
LineaNueva=N
3D=S
Tamano=45
ColorFondo=Blanco

[Inv2.EmpresaCfg2.BloquearOpcionesArtConMovs]
Carpeta=Inv2
Clave=EmpresaCfg2.BloquearOpcionesArtConMovs
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraProveedorRequisicion]
Carpeta=Compras
Clave=EmpresaCfg.CompraProveedorRequisicion
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanMetodo]
Carpeta=Plan
Clave=EmpresaCfg2.PlanMetodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc2.EmpresaCfg2.CxcVerRetencion]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcVerRetencion
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Espacios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Espacios
Clave=Espacios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Espacios.EmpresaCfg.EspaciosNivel]
Carpeta=Espacios
Clave=EmpresaCfg.EspaciosNivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Espacios.EmpresaCfg.EspaciosHoraD]
Carpeta=Espacios
Clave=EmpresaCfg.EspaciosHoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Espacios.EmpresaCfg.EspaciosHoraA]
Carpeta=Espacios
Clave=EmpresaCfg.EspaciosHoraA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Espacios.EmpresaCfg.EspaciosMinutos]
Carpeta=Espacios
Clave=EmpresaCfg.EspaciosMinutos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Espacios.EmpresaCfg.EspaciosBloquearAnteriores]
Carpeta=Espacios
Clave=EmpresaCfg.EspaciosBloquearAnteriores
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Espacios.EmpresaCfg.EspaciosCfg]
Carpeta=Espacios
Clave=EmpresaCfg.EspaciosCfg
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Espacios.EmpresaCfg.EspaciosSobreventa]
Carpeta=Espacios
Clave=EmpresaCfg.EspaciosSobreventa
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.EmpresaFecha]
Nombre=EmpresaFecha
Boton=9
NombreEnBoton=S
NombreDesplegar=&Fechas Válidas
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmpresaFecha
Activo=S
VisibleCondicion=General.Espacios y (EmpresaCfg:EmpresaCfg.EspaciosCfg=<T>Empresa<T>)

[Espacios.EmpresaCfg.EspaciosAsignacion]
Carpeta=Espacios
Clave=EmpresaCfg.EspaciosAsignacion
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ventas.EmpresaCfg.VentaActualizarPrecioMoneda]
Carpeta=Ventas
Clave=EmpresaCfg.VentaActualizarPrecioMoneda
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=N

[Cont.EmpresaCfg.CentroCostosRamas]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostosRamas
Editar=S
LineaNueva=S
3D=S
Tamano=12
ColorFondo=Blanco

[Cont2.EmpresaCfg.CtaGastosOperacion]
Carpeta=Cont2
Clave=EmpresaCfg.CtaGastosOperacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cont2.EmpresaCfg.CtaOtrosGastosProductos]
Carpeta=Cont2
Clave=EmpresaCfg.CtaOtrosGastosProductos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cont2.EmpresaCfg.CtaImpuestos]
Carpeta=Cont2
Clave=EmpresaCfg.CtaImpuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv2.EmpresaCfg2.DecimalesCantidadPendiente]
Carpeta=Inv2
Clave=EmpresaCfg2.DecimalesCantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
EspacioPrevio=S
Pegado=N

[Ventas2.EmpresaCfg2.VentaDMultiAgente]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaDMultiAgente
Editar=S
3D=S
Tamano=28
ColorFondo=Blanco
LineaNueva=S

[Cont.EmpresaCfg.ContMoneda2]
Carpeta=Cont
Clave=EmpresaCfg.ContMoneda2
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraValidarArtProv]
Carpeta=Compras
Clave=EmpresaCfg.CompraValidarArtProv
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Inv.EmpresaCfg.InvConfirmarSolicitudes]
Carpeta=Inv
Clave=EmpresaCfg.InvConfirmarSolicitudes
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoClaseRequerida]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoClaseRequerida
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoAFDetalle]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoAFDetalle
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Auto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Autotransportes
Clave=Auto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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
CondicionVisible=General.Autotransportes

[Auto.EmpresaCfg2.AutoOperadorMaxDescuento]
Carpeta=Auto
Clave=EmpresaCfg2.AutoOperadorMaxDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfg2.AutoArtComision]
Carpeta=Auto
Clave=EmpresaCfg2.AutoArtComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfg2.AutoArtBA]
Carpeta=Auto
Clave=EmpresaCfg2.AutoArtBA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfg2.AutoArtBT]
Carpeta=Auto
Clave=EmpresaCfg2.AutoArtBT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfg2.AutoArtBX]
Carpeta=Auto
Clave=EmpresaCfg2.AutoArtBX
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compra2.EmpresaCfg2.CompraSugerirArtR]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraSugerirArtR
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoAyudaConceptos]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoAyudaConceptos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaDevSeriesSinAntecedente]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaDevSeriesSinAntecedente
Editar=S
LineaNueva=N
3D=S
Tamano=50
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraSugerirUnidadDemanda]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraSugerirUnidadDemanda
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[MultiUnidades.EmpresaCfg2.AutoAjustarArtUnidadFactor]
Carpeta=MultiUnidades
Clave=EmpresaCfg2.AutoAjustarArtUnidadFactor
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.FacturarSustitutosOpciones]
Carpeta=Ventas2
Clave=EmpresaCfg2.FacturarSustitutosOpciones
Editar=S
3D=S
Tamano=27
ColorFondo=Blanco

[Auto.EmpresaCfg2.AutoArtMantExterno]
Carpeta=Auto
Clave=EmpresaCfg2.AutoArtMantExterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VentasMostrador.EmpresaCfg.EstatusFacturaVMOS]
Carpeta=VentasMostrador
Clave=EmpresaCfg.EstatusFacturaVMOS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PC]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Precios y Costos
Clave=PC
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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
CondicionVisible=General.PC

[PC.EmpresaCfg2.PCParcial]
Carpeta=PC
Clave=EmpresaCfg2.PCParcial
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[PC.EmpresaCfg2.PCBaja]
Carpeta=PC
Clave=EmpresaCfg2.PCBaja
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfg.VentaIncentivos]
Carpeta=Ventas
Clave=EmpresaCfg.VentaIncentivos
Editar=S
LineaNueva=N
3D=S
Tamano=29
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanIgnorarDemandaDirecta]
Carpeta=Plan
Clave=EmpresaCfg2.PlanIgnorarDemandaDirecta
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfg2.AutoMultiplesPapeletas]
Carpeta=Auto
Clave=EmpresaCfg2.AutoMultiplesPapeletas
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Plan.EmpresaCfg2.PlanIgnorarZonaCongelada]
Carpeta=Plan
Clave=EmpresaCfg2.PlanIgnorarZonaCongelada
Editar=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=40

[Ventas2.EmpresaCfg2.VentaSubMovimientos]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaSubMovimientos
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaVerImpuesto1]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaVerImpuesto1
Editar=S
LineaNueva=S
3D=S
Tamano=28
ColorFondo=Blanco
EspacioPrevio=S

[Ventas2.EmpresaCfg2.VentaVerImpuesto2]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaVerImpuesto2
Editar=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaVerImpuesto3]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaVerImpuesto3
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Cont.EmpresaCfg.TablaISAN]
Carpeta=Cont
Clave=EmpresaCfg.TablaISAN
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Nomina.EmpresaCfg.NomModificarFechaNomina]
Carpeta=Nomina
Clave=EmpresaCfg.NomModificarFechaNomina
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Nomina.EmpresaCfg.TablaVacaciones]
Carpeta=Nomina
Clave=EmpresaCfg.TablaVacaciones
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfg.SugerirCostoArtServicio]
Carpeta=Inv
Clave=EmpresaCfg.SugerirCostoArtServicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Servicios.EmpresaCfg.VentaServicioSituacionTipo]
Carpeta=Servicios
Clave=EmpresaCfg.VentaServicioSituacionTipo
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Servicios.EmpresaCfg.KmsxMes]
Carpeta=Servicios
Clave=EmpresaCfg.KmsxMes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfg2.AutoAlmacenBX]
Carpeta=Auto
Clave=EmpresaCfg2.AutoAlmacenBX
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[ActivosF.EmpresaCfg.AFConceptoDepreciacion]
Carpeta=ActivosF
Clave=EmpresaCfg.AFConceptoDepreciacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ActivosF.EmpresaCfg.AFAcreedorDepreciacion]
Carpeta=ActivosF
Clave=EmpresaCfg.AFAcreedorDepreciacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N

[Ventas2.EmpresaCfg2.VentaPresupuestosPendientes]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaPresupuestosPendientes
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoValidarPresupuestoCC]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoValidarPresupuestoCC
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraAutoEndoso]
Carpeta=Compras
Clave=EmpresaCfg.CompraAutoEndoso
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=27
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraAutoEndosoEmpresas]
Carpeta=Compras
Clave=EmpresaCfg.CompraAutoEndosoEmpresas
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Cxc2.EmpresaCfg2.CxcSugerirProntoPago]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcSugerirProntoPago
Editar=S
LineaNueva=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.EmpresaCfg.NomDiasDesfasoIncidencias]
Carpeta=Nomina
Clave=EmpresaCfg.NomDiasDesfasoIncidencias
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Prod.EmpresaCfg2.ProdVerPersonal]
Carpeta=Prod
Clave=EmpresaCfg2.ProdVerPersonal
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=27
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdVerTiempo]
Carpeta=Prod
Clave=EmpresaCfg2.ProdVerTiempo
Editar=S
ValidaNombre=N
3D=S
Tamano=27
ColorFondo=Blanco
LineaNueva=S

[Prod.EmpresaCfg2.ProdVerManoObra]
Carpeta=Prod
Clave=EmpresaCfg2.ProdVerManoObra
Editar=S
LineaNueva=S
3D=S
Tamano=27
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdVerMaquila]
Carpeta=Prod
Clave=EmpresaCfg2.ProdVerMaquila
Editar=S
3D=S
Tamano=27
ColorFondo=Blanco
LineaNueva=N

[Prod.EmpresaCfg2.ProdVerIndirectos]
Carpeta=Prod
Clave=EmpresaCfg2.ProdVerIndirectos
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cont.EmpresaCfg.ContMultiSucursal]
Carpeta=Cont
Clave=EmpresaCfg.ContMultiSucursal
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Cont.EmpresaCfg.ContCtaCliente]
Carpeta=Cont
Clave=EmpresaCfg.ContCtaCliente
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Cont.EmpresaCfg.ContCtaProveedor]
Carpeta=Cont
Clave=EmpresaCfg.ContCtaProveedor
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cont.EmpresaCfg.ContCtaAlmacen]
Carpeta=Cont
Clave=EmpresaCfg.ContCtaAlmacen
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=N

[Cont.EmpresaCfg.ContCtaPersonal]
Carpeta=Cont
Clave=EmpresaCfg.ContCtaPersonal
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

[Auto.EmpresaCfg2.AutoOperadorComision]
Carpeta=Auto
Clave=EmpresaCfg2.AutoOperadorComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfg2.AutoKmsMaximos]
Carpeta=Auto
Clave=EmpresaCfg2.AutoKmsMaximos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.VentaAnexarMov]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaAnexarMov
Editar=S
3D=S
Tamano=17
ColorFondo=Blanco

[Cont.EmpresaCfg.ContCtaDinero]
Carpeta=Cont
Clave=EmpresaCfg.ContCtaDinero
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S

[RH.EmpresaCfg.PersonalFormato]
Carpeta=RH
Clave=EmpresaCfg.PersonalFormato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Nomina.EmpresaCfg.NomValidarReferencias]
Carpeta=Nomina
Clave=EmpresaCfg.NomValidarReferencias
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcRecorrerVencimiento]
Carpeta=Cxc
Clave=EmpresaCfg.CxcRecorrerVencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cont.EmpresaCfg.ContNivelPresupuesto]
Carpeta=Cont
Clave=EmpresaCfg.ContNivelPresupuesto
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraProrrateada]
Carpeta=Compras
Clave=EmpresaCfg.CompraProrrateada
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco
EspacioPrevio=S

[Compras.EmpresaCfg.CompraProrrateadaRedondeo]
Carpeta=Compras
Clave=EmpresaCfg.CompraProrrateadaRedondeo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Asiste.EmpresaCfg.AsisteGenerarFaltas]
Carpeta=Asiste
Clave=EmpresaCfg.AsisteGenerarFaltas
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Asiste.EmpresaCfg.AsisteGenerarRetardos]
Carpeta=Asiste
Clave=EmpresaCfg.AsisteGenerarRetardos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Asiste.EmpresaCfg.AsisteGenerarHorasExtras]
Carpeta=Asiste
Clave=EmpresaCfg.AsisteGenerarHorasExtras
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cont.EmpresaCfg.ContCtaFormaPago]
Carpeta=Cont
Clave=EmpresaCfg.ContCtaFormaPago
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cxc2.EmpresaCfg2.CxcEnviarABeneficiario]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcEnviarABeneficiario
Editar=S
LineaNueva=S
3D=S
Tamano=70
ColorFondo=Blanco
ColorFuente=Negro

[Retenciones.EmpresaCfg2.RetencionAlPago]
Carpeta=Retenciones
Clave=EmpresaCfg2.RetencionAlPago
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdVerTurno]
Carpeta=Prod
Clave=EmpresaCfg2.ProdVerTurno
Editar=S
LineaNueva=N
3D=S
Tamano=27
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdVerTiempoMuerto]
Carpeta=Prod
Clave=EmpresaCfg2.ProdVerTiempoMuerto
Editar=S
3D=S
Tamano=27
ColorFondo=Blanco

[Cont.EmpresaCfg.ContCtaArticulo]
Carpeta=Cont
Clave=EmpresaCfg.ContCtaArticulo
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Dinero.EmpresaCfg.DineroAutoFaltanteSobrante]
Carpeta=Dinero
Clave=EmpresaCfg.DineroAutoFaltanteSobrante
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Dinero.EmpresaCfg.FormaPagoEfectivo]
Carpeta=Dinero
Clave=EmpresaCfg.FormaPagoEfectivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoDiversoReferenciaCxp]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoDiversoReferenciaCxp
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcDescContado]
Carpeta=Cxc
Clave=EmpresaCfg.CxcDescContado
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
Tamano=24
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcDescContadoDias]
Carpeta=Cxc
Clave=EmpresaCfg.CxcDescContadoDias
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcDescContadoPorcentaje]
Carpeta=Cxc
Clave=EmpresaCfg.CxcDescContadoPorcentaje
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcValidarDescPPMorosos]
Carpeta=Cxc
Clave=EmpresaCfg.CxcValidarDescPPMorosos
Editar=S
LineaNueva=S
3D=S
Tamano=60
ColorFondo=Blanco

[PC.EmpresaCfg2.PCRecalcPrecioFinVigencia]
Carpeta=PC
Clave=EmpresaCfg2.PCRecalcPrecioFinVigencia
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Cont.EmpresaCfg.CentroCostosValidar]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostosValidar
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Cont.EmpresaCfg.ContPermitirCancelacionOrigen]
Carpeta=Cont
Clave=EmpresaCfg.ContPermitirCancelacionOrigen
Editar=S
3D=S
Tamano=60
ColorFondo=Blanco

[Dinero.EmpresaCfg.DineroFaltanteModulo]
Carpeta=Dinero
Clave=EmpresaCfg.DineroFaltanteModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Ventas.EmpresaCfg.PedidosReservarEsp]
Carpeta=Ventas
Clave=EmpresaCfg.PedidosReservarEsp
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco
ValidaNombre=N

[Acciones.PedidosReservarEsp]
Nombre=PedidosReservarEsp
Boton=30
NombreEnBoton=S
NombreDesplegar=Auto &Reservar - Movimientos Especificos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmpresaPedidosReservarEsp
Activo=S
EspacioPrevio=S
VisibleCondicion=EmpresaCfg:EmpresaCfg.PedidosReservarEsp

[Ventas.EmpresaCfg.CancelarFactura]
Carpeta=Ventas
Clave=EmpresaCfg.CancelarFactura
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Gastos.EmpresaCfg2.GastoAutoCargos]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoAutoCargos
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoBorradorComprobantes]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoBorradorComprobantes
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[VentasMostrador.EmpresaCfg.FormaPagoEfectivo]
Carpeta=VentasMostrador
Clave=EmpresaCfg.FormaPagoEfectivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfg.DineroConciliarPorSucursales]
Carpeta=Dinero
Clave=EmpresaCfg.DineroConciliarPorSucursales
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ventas.EmpresaCfg.PrecioMinimoNivelSucursal]
Carpeta=Ventas
Clave=EmpresaCfg.PrecioMinimoNivelSucursal
Editar=S
3D=S
Tamano=23
ColorFondo=Blanco

[Agent.EmpresaCfg2.AgentAfectarGastos]
Carpeta=Agent
Clave=EmpresaCfg2.AgentAfectarGastos
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=50

[Agent.EmpresaCfg2.AgentMovGastos]
Carpeta=Agent
Clave=EmpresaCfg2.AgentMovGastos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agent.EmpresaCfg2.AgentConceptoGastos]
Carpeta=Agent
Clave=EmpresaCfg2.AgentConceptoGastos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agent]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comisiones
Clave=Agent
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

[Ventas2.EmpresaCfg2.VentaAFDetalle]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaAFDetalle
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco
LineaNueva=N

[Cont.EmpresaCfg.ContToleraciaRedondeo]
Carpeta=Cont
Clave=EmpresaCfg.ContToleraciaRedondeo
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
Pegado=S


[CR]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Caja Registradora
Clave=CR
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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
CondicionVisible=General.CR

[CR.EmpresaCfg.CRClase]
Carpeta=CR
Clave=EmpresaCfg.CRClase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRSubClase]
Carpeta=CR
Clave=EmpresaCfg.CRSubClase
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRFormaPago]
Carpeta=CR
Clave=EmpresaCfg.CRFormaPago
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.VentaRestringida]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaRestringida
Editar=S
3D=S
Tamano=26
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaRestringirArtBloqueados]
Carpeta=Ventas
Clave=EmpresaCfg.VentaRestringirArtBloqueados
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco
LineaNueva=S

[Compras.EmpresaCfg.CompraRestringirArtBloquedos]
Carpeta=Compras
Clave=EmpresaCfg.CompraRestringirArtBloquedos
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco
LineaNueva=S

[Ventas2.EmpresaCfg2.VentaExcluirPlaneacionDetalle]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaExcluirPlaneacionDetalle
Editar=S
LineaNueva=S
3D=S
Tamano=51
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdVolumen]
Carpeta=Prod
Clave=EmpresaCfg2.ProdVolumen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=27
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanAutoGuardarHist]
Carpeta=Plan
Clave=EmpresaCfg2.PlanAutoGuardarHist
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Servicios.EmpresaCfg.VentaServiciosValidarID]
Carpeta=Servicios
Clave=EmpresaCfg.VentaServiciosValidarID
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRCorteCajaCentralMax]
Carpeta=CR
Clave=EmpresaCfg.CRCorteCajaCentralMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[CR.EmpresaCfg.CRValidarCorteSaldoCero]
Carpeta=CR
Clave=EmpresaCfg.CRValidarCorteSaldoCero
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRValidarCorteZSaldoCero]
Carpeta=CR
Clave=EmpresaCfg.CRValidarCorteZSaldoCero
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfg2.GastoBorradorCajaChica]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoBorradorCajaChica
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaLimiteCreditoNivelGrupo]
Carpeta=Ventas
Clave=EmpresaCfg.VentaLimiteCreditoNivelGrupo
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaAnexosAlFacturar]
Carpeta=Ventas
Clave=EmpresaCfg.VentaAnexosAlFacturar
Editar=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraCaducidad]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraCaducidad
Editar=S
LineaNueva=N
3D=S
Tamano=50
ColorFondo=Blanco

[CR.EmpresaCfg.CRAfectarAuto]
Carpeta=CR
Clave=EmpresaCfg.CRAfectarAuto
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRCerrarDiaAuto]
Carpeta=CR
Clave=EmpresaCfg.CRCerrarDiaAuto
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[MultiUnidades.EmpresaCfg2.PrecioNivelUnidad]
Carpeta=MultiUnidades
Clave=EmpresaCfg2.PrecioNivelUnidad
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRValidarFolio]
Carpeta=CR
Clave=EmpresaCfg.CRValidarFolio
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfg.CompraValidarPresupuesto]
Carpeta=Compras
Clave=EmpresaCfg.CompraValidarPresupuesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Cont.EmpresaCfg.ContCuentaCierre]
Carpeta=Cont
Clave=EmpresaCfg.ContCuentaCierre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Auto.EmpresaCfg2.AutoCANAPAT]
Carpeta=Auto
Clave=EmpresaCfg2.AutoCANAPAT
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfg.VentaEndoso]
Carpeta=Ventas
Clave=EmpresaCfg.VentaEndoso
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraAutoEndosoMovs]
Carpeta=Compras
Clave=EmpresaCfg.CompraAutoEndosoMovs
Editar=S
3D=S
Tamano=80
ColorFondo=Blanco
LineaNueva=S

[Gastos.EmpresaCfg2.GastoGenerarAnticiposBorrador]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoGenerarAnticiposBorrador
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalVerIEPS]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalVerIEPS
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Auto.EmpresaCfg2.AutoArtPension]
Carpeta=Auto
Clave=EmpresaCfg2.AutoArtPension
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfg2.AutoMovPension]
Carpeta=Auto
Clave=EmpresaCfg2.AutoMovPension
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tablas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Tablas
Clave=Tablas
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Tablas.EmpresaCfg.ContTablaINPC]
Carpeta=Tablas
Clave=EmpresaCfg.ContTablaINPC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tablas.EmpresaCfg.TablaISAN]
Carpeta=Tablas
Clave=EmpresaCfg.TablaISAN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tablas.EmpresaCfg.TablaISANLujo]
Carpeta=Tablas
Clave=EmpresaCfg.TablaISANLujo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tablas.EmpresaCfg.ImporteISANLujo]
Carpeta=Tablas
Clave=EmpresaCfg.ImporteISANLujo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MultiUnidades.EmpresaCfg2.BloquearCantidadInventario]
Carpeta=MultiUnidades
Clave=EmpresaCfg2.BloquearCantidadInventario
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.VentaValidarFechaRequerida]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaValidarFechaRequerida
Editar=S
LineaNueva=S
3D=S
Tamano=45
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraValidarFechaRequerida]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraValidarFechaRequerida
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraRecibirDemasTolerancia]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraRecibirDemasTolerancia
Editar=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
Pegado=S

[ActivosF.EmpresaCfg.AFSugerirSerieEntrada]
Carpeta=ActivosF
Clave=EmpresaCfg.AFSugerirSerieEntrada
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=35
ColorFondo=Blanco

[ActivosF.EmpresaCfg.AFConsecutivo]
Carpeta=ActivosF
Clave=EmpresaCfg.AFConsecutivo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S

[VentasMostrador.EmpresaCfg.AsignarConsecutivoFacturaVMOS]
Carpeta=VentasMostrador
Clave=EmpresaCfg.AsignarConsecutivoFacturaVMOS
Editar=S
LineaNueva=N
3D=S
Tamano=50
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaDevAutoAplicar]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaDevAutoAplicar
Editar=S
3D=S
Tamano=45
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraDevAutoAplicar]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraDevAutoAplicar
Editar=S
LineaNueva=N
3D=S
Tamano=50
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaAnexarOrdenes]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaAnexarOrdenes
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[Inv2.EmpresaCfg2.InvFrecuenciaABCDiasHabiles]
Carpeta=Inv2
Clave=EmpresaCfg2.InvFrecuenciaABCDiasHabiles
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaPPIndirectos]
Carpeta=Ventas
Clave=EmpresaCfg.VentaPPIndirectos
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Embarques.EmpresaCfg.EmbarqueBaseProrrateo]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueBaseProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfg2.GastoCxc]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoCxc
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Cont.EmpresaCfg.ContUsoDinero]
Carpeta=Cont
Clave=EmpresaCfg.ContUsoDinero
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoValidarPresupuestoFR]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoValidarPresupuestoFR
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco
LineaNueva=S

[Compras.EmpresaCfg.CompraValidarPresupuestoFR]
Carpeta=Compras
Clave=EmpresaCfg.CompraValidarPresupuestoFR
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanBasePresupuesto]
Carpeta=Plan
Clave=EmpresaCfg2.PlanBasePresupuesto
Editar=S
3D=S
Tamano=58
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.VentaEnviarADetalle]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaEnviarADetalle
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaRefSerieLotePedidos]
Carpeta=Ventas
Clave=EmpresaCfg.VentaRefSerieLotePedidos
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S

[Inv2.EmpresaCfg2.VINAccesorioArt]
Carpeta=Inv2
Clave=EmpresaCfg2.VINAccesorioArt
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaLimiteCreditoNivelUEN]
Carpeta=Ventas
Clave=EmpresaCfg.VentaLimiteCreditoNivelUEN
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Inv2.EmpresaCfg2.VINCostoSumaAccesorios]
Carpeta=Inv2
Clave=EmpresaCfg2.VINCostoSumaAccesorios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Inv.EmpresaCfg.CosteoActividades]
Carpeta=Inv
Clave=EmpresaCfg.CosteoActividades
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Inv2.EmpresaCfg2.AlmacenOrigenOT]
Carpeta=Inv2
Clave=EmpresaCfg2.AlmacenOrigenOT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoDiversoSinProrratear]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoDiversoSinProrratear
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.FacturaCobroIntegradoParcial]
Carpeta=Ventas2
Clave=EmpresaCfg2.FacturaCobroIntegradoParcial
Editar=S
3D=S
Tamano=14
ColorFondo=Blanco

[AC]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Administración Créditos
Clave=AC
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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
CondicionVisible=General.AC

[AC.EmpresaCfg.ACFactorcapacidadPago]
Carpeta=AC
Clave=EmpresaCfg.ACFactorcapacidadPago
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
ValidaNombre=S

[Inv.EmpresaCfg.CBPreguntarCantidad]
Carpeta=Inv
Clave=EmpresaCfg.CBPreguntarCantidad
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[AC.EmpresaCfg.ACClienteDevengados]
Carpeta=AC
Clave=EmpresaCfg.ACClienteDevengados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACProveedorDevengados]
Carpeta=AC
Clave=EmpresaCfg.ACProveedorDevengados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfg.VentaVerDescripcionExtra]
Carpeta=Ventas
Clave=EmpresaCfg.VentaVerDescripcionExtra
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraVerDescripcionExtra]
Carpeta=Compras
Clave=EmpresaCfg.CompraVerDescripcionExtra
Editar=S
LineaNueva=S
3D=S
Tamano=35
ColorFondo=Blanco
EspacioPrevio=S

[VentasMostrador.EmpresaCfg.VentaLiquidaIntegralCxc]
Carpeta=VentasMostrador
Clave=EmpresaCfg.VentaLiquidaIntegralCxc
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[AC.EmpresaCfg.ACCobroIntereses]
Carpeta=AC
Clave=EmpresaCfg.ACCobroIntereses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc2.EmpresaCfg2.CxcRecorrerVenceRevisionPago]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcRecorrerVenceRevisionPago
Editar=S
LineaNueva=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[ReglaNegocio.EmpresaCfg.VentaPedidosDisminuyenCredito]
Carpeta=ReglaNegocio
Clave=EmpresaCfg.VentaPedidosDisminuyenCredito
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.FacturarSustitutosPrecios]
Carpeta=Ventas2
Clave=EmpresaCfg2.FacturarSustitutosPrecios
Editar=S
3D=S
Tamano=45
ColorFondo=Blanco

[Dinero.EmpresaCfg.DineroCorteSDPorFormaPago]
Carpeta=Dinero
Clave=EmpresaCfg.DineroCorteSDPorFormaPago
Editar=S
LineaNueva=S
3D=S
Tamano=45
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaTEEstandarRecorrerDomingo]
Carpeta=Ventas
Clave=EmpresaCfg.VentaTEEstandarRecorrerDomingo
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraConcentrarEntrada]
Carpeta=Compras
Clave=EmpresaCfg.CompraConcentrarEntrada
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanRecorrerLiberacion]
Carpeta=Plan
Clave=EmpresaCfg2.PlanRecorrerLiberacion
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfg.CancelarFacturaFecha]
Carpeta=Ventas
Clave=EmpresaCfg.CancelarFacturaFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Retenciones.EmpresaCfg2.GastoRetencion3Acreedor]
Carpeta=Retenciones
Clave=EmpresaCfg2.GastoRetencion3Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Retenciones.EmpresaCfg2.GastoRetencion3Concepto]
Carpeta=Retenciones
Clave=EmpresaCfg2.GastoRetencion3Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.EmpresaCfg2.Gasto3Retenciones]
Carpeta=Gastos
Clave=EmpresaCfg2.Gasto3Retenciones
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Peru]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Perú
Clave=Peru
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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
CondicionVisible=Version.Peru
CarpetaDesActivada=S

[Peru.EmpresaCfg2.PeruRetenciones]
Carpeta=Peru
Clave=EmpresaCfg2.PeruRetenciones
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Peru.EmpresaCfg2.PeruRetencionesTopeExcento]
Carpeta=Peru
Clave=EmpresaCfg2.PeruRetencionesTopeExcento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compra2.EmpresaCfg2.CompraDescuentoCascadaDetalle]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraDescuentoCascadaDetalle
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ventas.EmpresaCfg.CancelarFacturaFisicamente]
Carpeta=Ventas
Clave=EmpresaCfg.CancelarFacturaFisicamente
Editar=N
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Compra2.EmpresaCfg2.ArtDescuentoCompraCascada]
Carpeta=Compra2
Clave=EmpresaCfg2.ArtDescuentoCompraCascada
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco

[Cont.EmpresaCfg.ContMoneda2Auto]
Carpeta=Cont
Clave=EmpresaCfg.ContMoneda2Auto
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Embarques.EmpresaCfg.EmbarqueEliminarDetalle]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueEliminarDetalle
Editar=N
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRVentaDescripcionExtra]
Carpeta=CR
Clave=EmpresaCfg.CRVentaDescripcionExtra
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRVentaPrecio]
Carpeta=CR
Clave=EmpresaCfg.CRVentaPrecio
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRVentaDescuentoLinea]
Carpeta=CR
Clave=EmpresaCfg.CRVentaDescuentoLinea
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRAgente]
Carpeta=CR
Clave=EmpresaCfg.CRAgente
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[CR.EmpresaCfg.CRSoporte]
Carpeta=CR
Clave=EmpresaCfg.CRSoporte
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRInvFisico]
Carpeta=CR
Clave=EmpresaCfg.CRInvFisico
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv2.EmpresaCfg2.InvAjusteCargoAgente]
Carpeta=Inv2
Clave=EmpresaCfg2.InvAjusteCargoAgente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[CR.EmpresaCfg.CRCaja]
Carpeta=CR
Clave=EmpresaCfg.CRCaja
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRCxc]
Carpeta=CR
Clave=EmpresaCfg.CRCxc
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cont.EmpresaCfg.ContUsoCxc]
Carpeta=Cont
Clave=EmpresaCfg.ContUsoCxc
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco

[Cont.EmpresaCfg.ContUsoCxp]
Carpeta=Cont
Clave=EmpresaCfg.ContUsoCxp
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco

[CR.EmpresaCfg.CRSugerirDescuento]
Carpeta=CR
Clave=EmpresaCfg.CRSugerirDescuento
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRSugerirPrecio]
Carpeta=CR
Clave=EmpresaCfg.CRSugerirPrecio
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfg.VentaComisionVariable]
Carpeta=Ventas
Clave=EmpresaCfg.VentaComisionVariable
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[Cont.EmpresaCfg.ContArticulo]
Carpeta=Cont
Clave=EmpresaCfg.ContArticulo
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[VentasMostrador.EmpresaCfg.NConsumoSugerir]
Carpeta=VentasMostrador
Clave=EmpresaCfg.NConsumoSugerir
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco

[VentasMostrador.EmpresaCfg.NConsumoArtDeducible]
Carpeta=VentasMostrador
Clave=EmpresaCfg.NConsumoArtDeducible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[VentasMostrador.EmpresaCfg.NConsumoArtCoAseguro]
Carpeta=VentasMostrador
Clave=EmpresaCfg.NConsumoArtCoAseguro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CR.EmpresaCfg.CRTransferencias]
Carpeta=CR
Clave=EmpresaCfg.CRTransferencias
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfg.CosteoMultipleSimultaneo]
Carpeta=Inv
Clave=EmpresaCfg.CosteoMultipleSimultaneo
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Inv.EmpresaCfg.Posiciones]
Carpeta=Inv
Clave=EmpresaCfg.Posiciones
Editar=S
LineaNueva=S
3D=S
Tamano=10
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoConceptoCxp]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoConceptoCxp
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco
LineaNueva=S

[AC.EmpresaCfg.ACRetencionPF]
Carpeta=AC
Clave=EmpresaCfg.ACRetencionPF
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Inv2.EmpresaCfg2.InvVerDescripcionExtra]
Carpeta=Inv2
Clave=EmpresaCfg2.InvVerDescripcionExtra
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Dinero.EmpresaCfg.DineroAfectarComisionIVA]
Carpeta=Dinero
Clave=EmpresaCfg.DineroAfectarComisionIVA
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaPerdidaAuto]
Carpeta=Ventas
Clave=EmpresaCfg.VentaPerdidaAuto
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraPerdidaAuto]
Carpeta=Compras
Clave=EmpresaCfg.CompraPerdidaAuto
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Embarques.EmpresaCfg.EmbarqueDesembarquesParciales]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueDesembarquesParciales
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[VentasMostrador.EmpresaCfg.NConsumoArtAjusteCobertura]
Carpeta=VentasMostrador
Clave=EmpresaCfg.NConsumoArtAjusteCobertura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Asiste.EmpresaCfg.AsisteJornadasNocturnas]
Carpeta=Asiste
Clave=EmpresaCfg.AsisteJornadasNocturnas
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[CR.EmpresaCfg.CRAcreedor]
Carpeta=CR
Clave=EmpresaCfg.CRAcreedor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACReciprocidad]
Carpeta=AC
Clave=EmpresaCfg.ACReciprocidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfg2.GastoPersonal]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoPersonal
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoProvisionTolerancia]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoProvisionTolerancia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv2.EmpresaCfg2.InvAjusteSaldosMenores]
Carpeta=Inv2
Clave=EmpresaCfg2.InvAjusteSaldosMenores
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraGastoDiversoCxc]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraGastoDiversoCxc
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaDMultiAgenteSugerir]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaDMultiAgenteSugerir
Editar=S
3D=S
Tamano=22
ColorFondo=Blanco

[Importacion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Importación
Clave=Importacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

[Importacion.EmpresaCfg.ImportacionImpuesto1Acreedor]
Carpeta=Importacion
Clave=EmpresaCfg.ImportacionImpuesto1Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Importacion.EmpresaCfg.ImportacionImpuesto1Concepto]
Carpeta=Importacion
Clave=EmpresaCfg.ImportacionImpuesto1Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Importacion.EmpresaCfg.ImportacionImpuesto2Acreedor]
Carpeta=Importacion
Clave=EmpresaCfg.ImportacionImpuesto2Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Importacion.EmpresaCfg.ImportacionImpuesto2Concepto]
Carpeta=Importacion
Clave=EmpresaCfg.ImportacionImpuesto2Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfg.CBSerieLote]
Carpeta=Inv
Clave=EmpresaCfg.CBSerieLote
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[AC.EmpresaCfg.ACAjusteConceptoValorResidual]
Carpeta=AC
Clave=EmpresaCfg.ACAjusteConceptoValorResidual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACAjusteConceptoImpuestoAd]
Carpeta=AC
Clave=EmpresaCfg.ACAjusteConceptoImpuestoAd
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRPrestamoCxc]
Carpeta=CR
Clave=EmpresaCfg.CRPrestamoCxc
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACPlazoDias]
Carpeta=AC
Clave=EmpresaCfg.ACPlazoDias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfg.ExistenciaAlterna]
Carpeta=Inv
Clave=EmpresaCfg.ExistenciaAlterna
Editar=S
LineaNueva=N
3D=S
Tamano=15
ColorFondo=Blanco

[Inv.EmpresaCfg.ExistenciaAlternaSerieLote]
Carpeta=Inv
Clave=EmpresaCfg.ExistenciaAlternaSerieLote
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoAnticipoCxp]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoAnticipoCxp
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Agent.EmpresaCfg2.AgentImpRetencionConcepto]
Carpeta=Agent
Clave=EmpresaCfg2.AgentImpRetencionConcepto
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Plan.EmpresaCfg2.PlanInicio]
Carpeta=Plan
Clave=EmpresaCfg2.PlanInicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Inv2.EmpresaCfg2.CBSugerir]
Carpeta=Inv2
Clave=EmpresaCfg2.CBSugerir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaVerDatosOC]
Carpeta=Ventas
Clave=EmpresaCfg.VentaVerDatosOC
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcDARef]
Carpeta=Cxc
Clave=EmpresaCfg.CxcDARef
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[CR.EmpresaCfg.CRVentaMov]
Carpeta=CR
Clave=EmpresaCfg.CRVentaMov
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRVentaMovID]
Carpeta=CR
Clave=EmpresaCfg.CRVentaMovID
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Cxc2.EmpresaCfg2.CxcDocAutoBorrador]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcDocAutoBorrador
Editar=S
LineaNueva=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Cxp2.EmpresaCfg2.CxpDocAutoBorrador]
Carpeta=Cxp2
Clave=EmpresaCfg2.CxpDocAutoBorrador
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaLimiteRenFacturasVMOS]
Carpeta=Ventas
Clave=EmpresaCfg.VentaLimiteRenFacturasVMOS
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[CR.EmpresaCfg.CRZonaImpuestoNivelCte]
Carpeta=CR
Clave=EmpresaCfg.CRZonaImpuestoNivelCte
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACAcreedorEnDisposiciones]
Carpeta=AC
Clave=EmpresaCfg.ACAcreedorEnDisposiciones
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Compra2.EmpresaCfg2.CompraPresupuestosPendientes]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraPresupuestosPendientes
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Dinero.EmpresaCfg.DineroPagoConciliado]
Carpeta=Dinero
Clave=EmpresaCfg.DineroPagoConciliado
Editar=S
LineaNueva=S
3D=S
Tamano=45
ColorFondo=Blanco

[RH.EmpresaCfg.RHControlPlazas]
Carpeta=RH
Clave=EmpresaCfg.RHControlPlazas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanNivelArtAutoRecalc]
Carpeta=Plan
Clave=EmpresaCfg2.PlanNivelArtAutoRecalc
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro






[Conciliaciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Conciliaciones
Clave=Conciliaciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

[Conciliaciones.EmpresaCfg2.ConcToleranciaDec]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcToleranciaDec
Editar=S
LineaNueva=S
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Conciliaciones.EmpresaCfg2.ConcGastosAuto]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcGastosAuto
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Conciliaciones.EmpresaCfg2.ConcGastosAutoConceptoFijo]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcGastosAutoConceptoFijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Conciliaciones.EmpresaCfg2.ConcRepetirFecha]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcRepetirFecha
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Dinero.EmpresaCfg.DineroValidarMovImpuesto]
Carpeta=Dinero
Clave=EmpresaCfg.DineroValidarMovImpuesto
Editar=S
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Blanco
LineaNueva=S

[AC.EmpresaCfg.ACLineaCreditoExpress]
Carpeta=AC
Clave=EmpresaCfg.ACLineaCreditoExpress
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfg.CreditoTipoAmortizacion]
Carpeta=Credito
Clave=EmpresaCfg.CreditoTipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfg.CreditoTipoTasa]
Carpeta=Credito
Clave=EmpresaCfg.CreditoTipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfg.VentaArrastrarSerieLote]
Carpeta=Ventas
Clave=EmpresaCfg.VentaArrastrarSerieLote
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraAutoEndosoWS]
Carpeta=Compras
Clave=EmpresaCfg.CompraAutoEndosoWS
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraAutoEndosoWSDL]
Carpeta=Compras
Clave=EmpresaCfg.CompraAutoEndosoWSDL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcFormaCobroTarjetas]
Carpeta=Cxc
Clave=EmpresaCfg.CxcFormaCobroTarjetas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcArticuloTarjetasDef]
Carpeta=Cxc
Clave=EmpresaCfg.CxcArticuloTarjetasDef
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcAlmacenTarjetasDef]
Carpeta=Cxc
Clave=EmpresaCfg.CxcAlmacenTarjetasDef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcValidarPrecioTarjetas]
Carpeta=Cxc
Clave=EmpresaCfg.CxcValidarPrecioTarjetas
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaPuntosArtCat]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaPuntosArtCat
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=51
ColorFondo=Blanco




[Nomina.EmpresaCfg.NomDiasMes]
Carpeta=Nomina
Clave=EmpresaCfg.NomDiasMes
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Dinero.EmpresaCfg.DineroInversionIntereses]
Carpeta=Dinero
Clave=EmpresaCfg.DineroInversionIntereses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Ventas.EmpresaCfg.PedidosReservarLineaCompleta]
Carpeta=Ventas
Clave=EmpresaCfg.PedidosReservarLineaCompleta
Editar=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco
Pegado=N

[Cxc.EmpresaCfg.CxcAutoAjusteMov]
Carpeta=Cxc
Clave=EmpresaCfg.CxcAutoAjusteMov
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxp.EmpresaCfg.CxpAutoAjusteMov]
Carpeta=Cxp
Clave=EmpresaCfg.CxpAutoAjusteMov
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PC.EmpresaCfg2.PCListaModificarDetalle]
Carpeta=PC
Clave=EmpresaCfg2.PCListaModificarDetalle
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Inv2.EmpresaCfg2.ArtProvSucursalCompra]
Carpeta=Inv2
Clave=EmpresaCfg2.ArtProvSucursalCompra
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[PC.EmpresaCfg2.PCPrecioNuevoForma]
Carpeta=PC
Clave=EmpresaCfg2.PCPrecioNuevoForma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[PC.EmpresaCfg2.PCSugerir]
Carpeta=PC
Clave=EmpresaCfg2.PCSugerir
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro


[Ofertas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ofertas
Clave=Ofertas
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

CondicionVisible=General.OFER
[Ofertas.EmpresaCfg2.OfertaFechaHora]
Carpeta=Ofertas
Clave=EmpresaCfg2.OfertaFechaHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[AC.EmpresaCfg.CreditoTipoAmortizacion]
Carpeta=AC
Clave=EmpresaCfg.CreditoTipoAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.CreditoTipoTasa]
Carpeta=AC
Clave=EmpresaCfg.CreditoTipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas2.EmpresaCfg2.VentaMonedero]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaMonedero
Editar=S
3D=S
Tamano=28
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Ventas2.EmpresaCfg2.VentaPuntosEnVales]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaPuntosEnVales
Editar=S
3D=S
Tamano=51
ColorFondo=Blanco

[Proyectos.EmpresaCfg.ProyCrearProyecto]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyCrearProyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Proyectos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Proyectos
Clave=Proyectos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

CondicionVisible=General.PM
[Proyectos.EmpresaCfg.ProyAsunto]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Proyectos.EmpresaCfg.ProyFechaRevision]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyFechaRevision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Proyectos.EmpresaCfg.ProyDiasIndicador1]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyDiasIndicador1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Embarques.EmpresaCfg.EmbarqueCobrarDemas]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueCobrarDemas
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Retenciones.EmpresaCfg2.RetencionAlPagoMovImpuesto]
Carpeta=Retenciones
Clave=EmpresaCfg2.RetencionAlPagoMovImpuesto
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ofertas.EmpresaCfg2.OfertaModificarTipo]
Carpeta=Ofertas
Clave=EmpresaCfg2.OfertaModificarTipo
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Proyectos.EmpresaCfg.ProyIndicador1Liberados]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyIndicador1Liberados
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaProveedorRef]
Carpeta=Ventas
Clave=EmpresaCfg.VentaProveedorRef
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas.EmpresaCfg.VentaPrecioMoneda]
Carpeta=Ventas
Clave=EmpresaCfg.VentaPrecioMoneda
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaVerCosto]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaVerCosto
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[PC.EmpresaCfg2.PC_H1]
Carpeta=PC
Clave=EmpresaCfg2.PC_H1
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[PC.EmpresaCfg2.PC_H2]
Carpeta=PC
Clave=EmpresaCfg2.PC_H2
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Proyectos.EmpresaCfg.ProyFasesInformativas]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyFasesInformativas
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaArtEstatus]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaArtEstatus
Editar=S
LineaNueva=S
3D=S
Tamano=28
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaArtSituacion]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaArtSituacion
Editar=S
3D=S
Tamano=22
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoClienteRef]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoClienteRef
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoArticuloRef]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoArticuloRef
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[CR.EmpresaCfg.CRProcesoDistribuido]
Carpeta=CR
Clave=EmpresaCfg.CRProcesoDistribuido
Editar=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[CR.EmpresaCfg.CRServidorOperaciones]
Carpeta=CR
Clave=EmpresaCfg.CRServidorOperaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfg.CRBaseDatosOperaciones]
Carpeta=CR
Clave=EmpresaCfg.CRBaseDatosOperaciones
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfg.CompraAutoEndosoAutoCargos]
Carpeta=Compras
Clave=EmpresaCfg.CompraAutoEndosoAutoCargos
Editar=S
LineaNueva=S
3D=S
Tamano=80
ColorFondo=Blanco

[Conciliaciones.EmpresaCfg2.ConcSugerirDespuesPeriodo]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcSugerirDespuesPeriodo
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Conciliaciones.EmpresaCfg2.ConcNoSugerirImportesDup]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcNoSugerirImportesDup
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Cxp2.EmpresaCfg2.CxpPagarEnLoteEvaluacion]
Carpeta=Cxp2
Clave=EmpresaCfg2.CxpPagarEnLoteEvaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoSugerirCostoEstandar]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoSugerirCostoEstandar
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaEspacioCantidadMetros]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaEspacioCantidadMetros
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoConceptosInventariables]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoConceptosInventariables
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=S
EspacioPrevio=S

[Gastos.EmpresaCfg2.GastoAlmacen]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoAlmacen
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=N
Pegado=S

[Gastos.EmpresaCfg2.GastoInvCopiarMov]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoInvCopiarMov
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Cxp2.EmpresaCfg2.CxpPagoTasa]
Carpeta=Cxp2
Clave=EmpresaCfg2.CxpPagoTasa
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoPresupuestoPendiente]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoPresupuestoPendiente
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalOmitirDepositoAntCxc]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalOmitirDepositoAntCxc
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalOmitirChAntCxp]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalOmitirChAntCxp
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalOmitirPagosChDevCxp]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalOmitirPagosChDevCxp
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalRegAplicaAnticipoCxc]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalRegAplicaAnticipoCxc
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalRegAplicaFacturaCxc]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalRegAplicaFacturaCxc
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalRegAplicaAnticipoCxp]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalRegAplicaAnticipoCxp
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalRegAplicaFacturaCxp]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalRegAplicaFacturaCxp
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalOmitirCobrosChDevCxc]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalOmitirCobrosChDevCxc
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[Fiscal.EmpresaCfg2.FiscalOmitirPagosEndosoCxp]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalOmitirPagosEndosoCxp
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[VentasMostrador.EmpresaCfg.MoverNotasAuto]
Carpeta=VentasMostrador
Clave=EmpresaCfg.MoverNotasAuto
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
EspacioPrevio=S

[AC.EmpresaCfg.ACPermitirMovFechaAnterior]
Carpeta=AC
Clave=EmpresaCfg.ACPermitirMovFechaAnterior
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Conciliaciones.EmpresaCfg2.ConcDiasCargos]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcDiasCargos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Conciliaciones.EmpresaCfg2.ConcDiasAbonos]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcDiasAbonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Conciliaciones.EmpresaCfg2.ConcImportesLejanos]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcImportesLejanos
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Conciliaciones.EmpresaCfg2.ConcTraslaparFecha]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcTraslaparFecha
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfg.DineroConciliarEstatus]
Carpeta=Dinero
Clave=EmpresaCfg.DineroConciliarEstatus
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco

[RH.EmpresaCfg.RHValidarAF]
Carpeta=RH
Clave=EmpresaCfg.RHValidarAF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gestion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gestión
Clave=Gestion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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
ListaEnCaptura=EmpresaCfg.PermiteCompletarEnAvances
CondicionVisible=General.GES

[Gestion.EmpresaCfg.PermiteCompletarEnAvances]
Carpeta=Gestion
Clave=EmpresaCfg.PermiteCompletarEnAvances
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Cont.EmpresaCfg.ContCuentaCuadre]
Carpeta=Cont
Clave=EmpresaCfg.ContCuentaCuadre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Cont.EmpresaCfg.ContToleranciaCuadre]
Carpeta=Cont
Clave=EmpresaCfg.ContToleranciaCuadre
Editar=S
LineaNueva=N
3D=S
Tamano=10
ColorFondo=Blanco
ValidaNombre=S

[Gastos.EmpresaCfg2.GastoRecurso]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoRecurso
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
LineaNueva=S
Tamano=40

[Lista.Columnas]
Fecha=148
Usuario=82
Nombre=304
Sucursal=64
Nombre_1=154
Empresa=69
Articulo=131
Descripcion1=244

[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285

[Acciones.Historico]
Nombre=Historico
Boton=53
NombreDesplegar=Histórico de Cambios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Antes=S
Expresion=Caso   CarpetaActiva(<T>A1<T>)<BR>  Es <T>Inv<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>ReglaNegocio<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Ventas<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>VentasMostrador<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Servicios<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Compras<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Importacion<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Cxc<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Cxp<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Dinero<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Embarques<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>ActivosF<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Nomina<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>RH<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Asiste<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Cont<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Cont2<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Conciliaciones<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Cambios<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Tablas<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>AC<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Proyectos<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>  Es <T>Gestion<T> Entonces Asigna(Info.Tabla,<T>EmpresaCfg<T>)<BR>Sino<BR>  Asigna(Info.Tabla,<T>EmpresaCfg2<T>)<BR>Fin<BR><BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(CarpetaActiva(<T>A1<T>), <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
EjecucionCondicion=ConDatos(EmpresaCfg:EmpresaCfg.Empresa)
AntesExpresiones=Asigna(Info.Nombre,EmpresaCfg:EmpresaCfg.Empresa)

[Cxc2.EmpresaCfg2.CxcGenerarEnBorrador]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcGenerarEnBorrador
Editar=S
LineaNueva=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Cxp2.EmpresaCfg2.CxpGenerarEnBorrador]
Carpeta=Cxp2
Clave=EmpresaCfg2.CxpGenerarEnBorrador
Editar=S
LineaNueva=S
3D=S
Tamano=60
ColorFondo=Blanco

[Cont.EmpresaCfg.CentroCostos2Venta]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos2Venta
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=30

[Cont.EmpresaCfg.CentroCostos2Gasto]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos2Gasto
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=30

[Cont.EmpresaCfg.CentroCostos2Compra]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos2Compra
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=30

[Cont.EmpresaCfg.CentroCostos2VentaD]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos2VentaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=25

[Cont.EmpresaCfg.CentroCostos2GastoD]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos2GastoD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=25

[Cont.EmpresaCfg.CentroCostos2CompraD]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos2CompraD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=25

[Cont.EmpresaCfg.CentroCostos3Venta]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos3Venta
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=30

[Cont.EmpresaCfg.CentroCostos3Gasto]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos3Gasto
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=30

[Cont.EmpresaCfg.CentroCostos3Compra]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos3Compra
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=30

[Cont.EmpresaCfg.CentroCostos3VentaD]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos3VentaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=25

[Cont.EmpresaCfg.CentroCostos3GastoD]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos3GastoD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=25

[Cont.EmpresaCfg.CentroCostos3CompraD]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos3CompraD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=25

[Cont.EmpresaCfg.VisualizarArrastre]
Carpeta=Cont
Clave=EmpresaCfg.VisualizarArrastre
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ValidaNombre=N
EspacioPrevio=S

[Embarques.EmpresaCfg.EmbarqueSugerirCobros]
Carpeta=Embarques
Clave=EmpresaCfg.EmbarqueSugerirCobros
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACFacturarInteresesAlCobro]
Carpeta=AC
Clave=EmpresaCfg.ACFacturarInteresesAlCobro
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACFacturarInteresesMov]
Carpeta=AC
Clave=EmpresaCfg.ACFacturarInteresesMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACFacturarInteresesConcepto]
Carpeta=AC
Clave=EmpresaCfg.ACFacturarInteresesConcepto
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACFacturarMoratoriosMov]
Carpeta=AC
Clave=EmpresaCfg.ACFacturarMoratoriosMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACFacturarMoratoriosConcepto]
Carpeta=AC
Clave=EmpresaCfg.ACFacturarMoratoriosConcepto
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACBonificarQuitasAlCobro]
Carpeta=AC
Clave=EmpresaCfg.ACBonificarQuitasAlCobro
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACBonificarQuitasMov]
Carpeta=AC
Clave=EmpresaCfg.ACBonificarQuitasMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACBonificarQuitasConcepto]
Carpeta=AC
Clave=EmpresaCfg.ACBonificarQuitasConcepto
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACBonificarQuitasMoraMov]
Carpeta=AC
Clave=EmpresaCfg.ACBonificarQuitasMoraMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfg.ACBonificarQuitasMoraConcepto]
Carpeta=AC
Clave=EmpresaCfg.ACBonificarQuitasMoraConcepto
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compra2.EmpresaCfg2.CompraMultiEmpresas]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraMultiEmpresas
Editar=S
3D=S
Tamano=50
ColorFondo=Blanco
LineaNueva=S

[Compra2.EmpresaCfg2.CompraPresupuestosCategoria]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraPresupuestosCategoria
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraABC]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraABC
Editar=S
3D=S
Tamano=50
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoABC]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoABC
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaABC]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaABC
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Cont2.ListaEnCaptura]
(Inicio)=EmpresaCfg.CtaContabilidad
EmpresaCfg.CtaContabilidad=EmpresaCfg.CtaActivo
EmpresaCfg.CtaActivo=EmpresaCfg.CtaPasivo
EmpresaCfg.CtaPasivo=EmpresaCfg.CtaCapital
EmpresaCfg.CtaCapital=EmpresaCfg.CtaResultados
EmpresaCfg.CtaResultados=EmpresaCfg.CtaIngresos
EmpresaCfg.CtaIngresos=EmpresaCfg.CtaCostoDirecto
EmpresaCfg.CtaCostoDirecto=EmpresaCfg.CtaGastosOperacion
EmpresaCfg.CtaGastosOperacion=EmpresaCfg.CtaOtrosGastosProductos
EmpresaCfg.CtaOtrosGastosProductos=EmpresaCfg.CtaImpuestos
EmpresaCfg.CtaImpuestos=EmpresaCfg.CtaOrden
EmpresaCfg.CtaOrden=(Fin)

[Servicios.ListaEnCaptura]
(Inicio)=EmpresaCfg.VentaContratosArticulo
EmpresaCfg.VentaContratosArticulo=EmpresaCfg.VentaContratosImpuesto
EmpresaCfg.VentaContratosImpuesto=EmpresaCfg.VentaConfirmarContratos
EmpresaCfg.VentaConfirmarContratos=EmpresaCfg.AlmacenDestinoEntregaGarantia
EmpresaCfg.AlmacenDestinoEntregaGarantia=EmpresaCfg.VentaConfirmarServicios
EmpresaCfg.VentaConfirmarServicios=EmpresaCfg.InvPrestamosGarantias
EmpresaCfg.InvPrestamosGarantias=EmpresaCfg.VentaServiciosRequiereTareas
EmpresaCfg.VentaServiciosRequiereTareas=EmpresaCfg.VentaServiciosTareaOmision
EmpresaCfg.VentaServiciosTareaOmision=EmpresaCfg.VentaServiciosValidarID
EmpresaCfg.VentaServiciosValidarID=EmpresaCfg.VentaServiciosAutoOP
EmpresaCfg.VentaServiciosAutoOP=EmpresaCfg.VentaServicioSituacionTipo
EmpresaCfg.VentaServicioSituacionTipo=EmpresaCfg.KmsxMes
EmpresaCfg.KmsxMes=(Fin)

[Embarques.ListaEnCaptura]
(Inicio)=EmpresaCfg.EmbarqueEstadoPendiente
EmpresaCfg.EmbarqueEstadoPendiente=EmpresaCfg.EmbarqueEstadoTransito
EmpresaCfg.EmbarqueEstadoTransito=EmpresaCfg.EmbarqueBaseProrrateo
EmpresaCfg.EmbarqueBaseProrrateo=EmpresaCfg.EmbarqueAfectarCobros
EmpresaCfg.EmbarqueAfectarCobros=EmpresaCfg.EmbarqueSugerirCobros
EmpresaCfg.EmbarqueSugerirCobros=EmpresaCfg.EmbarqueCobrarDemas
EmpresaCfg.EmbarqueCobrarDemas=EmpresaCfg.EmbarqueGenerarGastoTarifas
EmpresaCfg.EmbarqueGenerarGastoTarifas=EmpresaCfg.EmbarqueAfectarGastoTarifas
EmpresaCfg.EmbarqueAfectarGastoTarifas=EmpresaCfg.EmbarqueEliminarDetalle
EmpresaCfg.EmbarqueEliminarDetalle=EmpresaCfg.EmbarqueDesembarquesParciales
EmpresaCfg.EmbarqueDesembarquesParciales=(Fin)


[Cxc2.EmpresaCfg2.CxcVerRetencion2]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcVerRetencion2
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S
ValidaNombre=N

[Cxc2.EmpresaCfg2.CxcVerRetencion3]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcVerRetencion3
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S
ValidaNombre=N

[MultiUnidades.ListaEnCaptura]
(Inicio)=EmpresaCfg2.MultiUnidades
EmpresaCfg2.MultiUnidades=EmpresaCfg2.NivelFactorMultiUnidad
EmpresaCfg2.NivelFactorMultiUnidad=EmpresaCfg2.AutoAjustarArtUnidadFactor
EmpresaCfg2.AutoAjustarArtUnidadFactor=EmpresaCfg2.PrecioNivelUnidad
EmpresaCfg2.PrecioNivelUnidad=EmpresaCfg2.CompraFactorDinamico
EmpresaCfg2.CompraFactorDinamico=EmpresaCfg2.VentaFactorDinamico
EmpresaCfg2.VentaFactorDinamico=EmpresaCfg2.InvFactorDinamico
EmpresaCfg2.InvFactorDinamico=EmpresaCfg2.ProdFactorDinamico
EmpresaCfg2.ProdFactorDinamico=EmpresaCfg2.BloquearCantidadInventario
EmpresaCfg2.BloquearCantidadInventario=(Fin)

[Multimonedas.ListaEnCaptura]
(Inicio)=EmpresaCfg2.CxcMonedaCont
EmpresaCfg2.CxcMonedaCont=EmpresaCfg2.AgentMonedaCont
EmpresaCfg2.AgentMonedaCont=EmpresaCfg2.CxpMonedaCont
EmpresaCfg2.CxpMonedaCont=(Fin)

[ReglaNegocio.ListaEnCaptura]
(Inicio)=EmpresaCfg.VentaChecarCredito
EmpresaCfg.VentaChecarCredito=EmpresaCfg.VentaPedidosDisminuyenCredito
EmpresaCfg.VentaPedidosDisminuyenCredito=EmpresaCfg.VentaBloquearMorosos
EmpresaCfg.VentaBloquearMorosos=EmpresaCfg.EmbarqueModificarVencimiento
EmpresaCfg.EmbarqueModificarVencimiento=(Fin)


[Cambios.ListaEnCaptura]
(Inicio)=EmpresaCfg.CambioOperacionRelevante
EmpresaCfg.CambioOperacionRelevante=EmpresaCfg.CambioMonedaRelevante
EmpresaCfg.CambioMonedaRelevante=EmpresaCfg.CambioCategoriaRelevante1
EmpresaCfg.CambioCategoriaRelevante1=EmpresaCfg.CambioCategoriaRelevante2
EmpresaCfg.CambioCategoriaRelevante2=EmpresaCfg.CambioDiasRemesas
EmpresaCfg.CambioDiasRemesas=(Fin)


[Espacios.ListaEnCaptura]
(Inicio)=EmpresaCfg.EspaciosNivel
EmpresaCfg.EspaciosNivel=EmpresaCfg.EspaciosSobreventa
EmpresaCfg.EspaciosSobreventa=EmpresaCfg.EspaciosHoraD
EmpresaCfg.EspaciosHoraD=EmpresaCfg.EspaciosHoraA
EmpresaCfg.EspaciosHoraA=EmpresaCfg.EspaciosMinutos
EmpresaCfg.EspaciosMinutos=EmpresaCfg.EspaciosBloquearAnteriores
EmpresaCfg.EspaciosBloquearAnteriores=EmpresaCfg.EspaciosAsignacion
EmpresaCfg.EspaciosAsignacion=EmpresaCfg.EspaciosCfg
EmpresaCfg.EspaciosCfg=(Fin)

[Auto.ListaEnCaptura]
(Inicio)=EmpresaCfg2.AutoOperadorMaxDescuento
EmpresaCfg2.AutoOperadorMaxDescuento=EmpresaCfg2.AutoOperadorComision
EmpresaCfg2.AutoOperadorComision=EmpresaCfg2.AutoKmsMaximos
EmpresaCfg2.AutoKmsMaximos=EmpresaCfg2.AutoArtComision
EmpresaCfg2.AutoArtComision=EmpresaCfg2.AutoArtPension
EmpresaCfg2.AutoArtPension=EmpresaCfg2.AutoMovPension
EmpresaCfg2.AutoMovPension=EmpresaCfg2.AutoArtMantExterno
EmpresaCfg2.AutoArtMantExterno=EmpresaCfg2.AutoArtBA
EmpresaCfg2.AutoArtBA=EmpresaCfg2.AutoArtBT
EmpresaCfg2.AutoArtBT=EmpresaCfg2.AutoArtBX
EmpresaCfg2.AutoArtBX=EmpresaCfg2.AutoAlmacenBX
EmpresaCfg2.AutoAlmacenBX=EmpresaCfg2.AutoMultiplesPapeletas
EmpresaCfg2.AutoMultiplesPapeletas=EmpresaCfg2.AutoCANAPAT
EmpresaCfg2.AutoCANAPAT=(Fin)

[PC.ListaEnCaptura]
(Inicio)=EmpresaCfg2.PCParcial
EmpresaCfg2.PCParcial=EmpresaCfg2.PCBaja
EmpresaCfg2.PCBaja=EmpresaCfg2.PCRecalcPrecioFinVigencia
EmpresaCfg2.PCRecalcPrecioFinVigencia=EmpresaCfg2.PCSugerir
EmpresaCfg2.PCSugerir=EmpresaCfg2.PCListaModificarDetalle
EmpresaCfg2.PCListaModificarDetalle=EmpresaCfg2.PCPrecioNuevoForma
EmpresaCfg2.PCPrecioNuevoForma=EmpresaCfg2.PC_H1
EmpresaCfg2.PC_H1=EmpresaCfg2.PC_H2
EmpresaCfg2.PC_H2=(Fin)

[Agent.ListaEnCaptura]
(Inicio)=EmpresaCfg2.AgentAfectarGastos
EmpresaCfg2.AgentAfectarGastos=EmpresaCfg2.AgentImpRetencionConcepto
EmpresaCfg2.AgentImpRetencionConcepto=EmpresaCfg2.AgentConceptoGastos
EmpresaCfg2.AgentConceptoGastos=(Fin)

[CR.ListaEnCaptura]
(Inicio)=EmpresaCfg.CRAcreedor
EmpresaCfg.CRAcreedor=EmpresaCfg.CRFormaPago
EmpresaCfg.CRFormaPago=EmpresaCfg.CRClase
EmpresaCfg.CRClase=EmpresaCfg.CRSubClase
EmpresaCfg.CRSubClase=EmpresaCfg.CRCorteCajaCentralMax
EmpresaCfg.CRCorteCajaCentralMax=EmpresaCfg.CRValidarCorteSaldoCero
EmpresaCfg.CRValidarCorteSaldoCero=EmpresaCfg.CRValidarCorteZSaldoCero
EmpresaCfg.CRValidarCorteZSaldoCero=EmpresaCfg.CRValidarFolio
EmpresaCfg.CRValidarFolio=EmpresaCfg.CRProcesoDistribuido
EmpresaCfg.CRProcesoDistribuido=EmpresaCfg.CRServidorOperaciones
EmpresaCfg.CRServidorOperaciones=EmpresaCfg.CRBaseDatosOperaciones
EmpresaCfg.CRBaseDatosOperaciones=EmpresaCfg.CRAfectarAuto
EmpresaCfg.CRAfectarAuto=EmpresaCfg.CRCerrarDiaAuto
EmpresaCfg.CRCerrarDiaAuto=EmpresaCfg.CRPrestamoCxc
EmpresaCfg.CRPrestamoCxc=EmpresaCfg.CRZonaImpuestoNivelCte
EmpresaCfg.CRZonaImpuestoNivelCte=EmpresaCfg.CRVentaDescripcionExtra
EmpresaCfg.CRVentaDescripcionExtra=EmpresaCfg.CRVentaPrecio
EmpresaCfg.CRVentaPrecio=EmpresaCfg.CRVentaDescuentoLinea
EmpresaCfg.CRVentaDescuentoLinea=EmpresaCfg.CRVentaMov
EmpresaCfg.CRVentaMov=EmpresaCfg.CRVentaMovID
EmpresaCfg.CRVentaMovID=EmpresaCfg.CRSugerirPrecio
EmpresaCfg.CRSugerirPrecio=EmpresaCfg.CRSugerirDescuento
EmpresaCfg.CRSugerirDescuento=EmpresaCfg.CRAgente
EmpresaCfg.CRAgente=EmpresaCfg.CRSoporte
EmpresaCfg.CRSoporte=EmpresaCfg.CRInvFisico
EmpresaCfg.CRInvFisico=EmpresaCfg.CRCaja
EmpresaCfg.CRCaja=EmpresaCfg.CRCxc
EmpresaCfg.CRCxc=EmpresaCfg.CRTransferencias
EmpresaCfg.CRTransferencias=(Fin)

[Tablas.ListaEnCaptura]
(Inicio)=EmpresaCfg.ContTablaINPC
EmpresaCfg.ContTablaINPC=EmpresaCfg.TablaISAN
EmpresaCfg.TablaISAN=EmpresaCfg.TablaISANLujo
EmpresaCfg.TablaISANLujo=EmpresaCfg.ImporteISANLujo
EmpresaCfg.ImporteISANLujo=(Fin)

[AC.EmpresaCfg.ACConsiderarInflacionIVA]
Carpeta=AC
Clave=EmpresaCfg.ACConsiderarInflacionIVA
Editar=S
LineaNueva=N
3D=S
Tamano=50
ColorFondo=Blanco

[AC.EmpresaCfg.ACMonedaCalculoInflacionIVA]
Carpeta=AC
Clave=EmpresaCfg.ACMonedaCalculoInflacionIVA
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[AC.ListaEnCaptura]
(Inicio)=EmpresaCfg.ACFactorcapacidadPago
EmpresaCfg.ACFactorcapacidadPago=EmpresaCfg.ACConsiderarInflacionIVA
EmpresaCfg.ACConsiderarInflacionIVA=EmpresaCfg.ACMonedaCalculoInflacionIVA
EmpresaCfg.ACMonedaCalculoInflacionIVA=EmpresaCfg.ACCobroIntereses
EmpresaCfg.ACCobroIntereses=EmpresaCfg.ACClienteDevengados
EmpresaCfg.ACClienteDevengados=EmpresaCfg.ACProveedorDevengados
EmpresaCfg.ACProveedorDevengados=EmpresaCfg.ACRetencionPF
EmpresaCfg.ACRetencionPF=EmpresaCfg.ACReciprocidad
EmpresaCfg.ACReciprocidad=EmpresaCfg.ACAjusteConceptoValorResidual
EmpresaCfg.ACAjusteConceptoValorResidual=EmpresaCfg.ACAjusteConceptoImpuestoAd
EmpresaCfg.ACAjusteConceptoImpuestoAd=EmpresaCfg.ACPlazoDias
EmpresaCfg.ACPlazoDias=EmpresaCfg.ACAcreedorEnDisposiciones
EmpresaCfg.ACAcreedorEnDisposiciones=EmpresaCfg.ACLineaCreditoExpress
EmpresaCfg.ACLineaCreditoExpress=EmpresaCfg.ACPermitirMovFechaAnterior
EmpresaCfg.ACPermitirMovFechaAnterior=EmpresaCfg.CreditoTipoAmortizacion
EmpresaCfg.CreditoTipoAmortizacion=EmpresaCfg.CreditoTipoTasa
EmpresaCfg.CreditoTipoTasa=EmpresaCfg.ACFacturarInteresesAlCobro
EmpresaCfg.ACFacturarInteresesAlCobro=EmpresaCfg.ACFacturarInteresesMov
EmpresaCfg.ACFacturarInteresesMov=EmpresaCfg.ACFacturarInteresesConcepto
EmpresaCfg.ACFacturarInteresesConcepto=EmpresaCfg.ACFacturarMoratoriosMov
EmpresaCfg.ACFacturarMoratoriosMov=EmpresaCfg.ACFacturarMoratoriosConcepto
EmpresaCfg.ACFacturarMoratoriosConcepto=EmpresaCfg.ACBonificarQuitasAlCobro
EmpresaCfg.ACBonificarQuitasAlCobro=EmpresaCfg.ACBonificarQuitasMov
EmpresaCfg.ACBonificarQuitasMov=EmpresaCfg.ACBonificarQuitasConcepto
EmpresaCfg.ACBonificarQuitasConcepto=EmpresaCfg.ACBonificarQuitasMoraMov
EmpresaCfg.ACBonificarQuitasMoraMov=EmpresaCfg.ACBonificarQuitasMoraConcepto
EmpresaCfg.ACBonificarQuitasMoraConcepto=(Fin)

[Peru.ListaEnCaptura]
(Inicio)=EmpresaCfg2.PeruRetenciones
EmpresaCfg2.PeruRetenciones=EmpresaCfg2.PeruRetencionesTopeExcento
EmpresaCfg2.PeruRetencionesTopeExcento=(Fin)

[Importacion.ListaEnCaptura]
(Inicio)=EmpresaCfg.ImportacionImpuesto1Acreedor
EmpresaCfg.ImportacionImpuesto1Acreedor=EmpresaCfg.ImportacionImpuesto1Concepto
EmpresaCfg.ImportacionImpuesto1Concepto=EmpresaCfg.ImportacionImpuesto2Acreedor
EmpresaCfg.ImportacionImpuesto2Acreedor=EmpresaCfg.ImportacionImpuesto2Concepto
EmpresaCfg.ImportacionImpuesto2Concepto=(Fin)

[Conciliaciones.ListaEnCaptura]
(Inicio)=EmpresaCfg2.ConcToleranciaDec
EmpresaCfg2.ConcToleranciaDec=EmpresaCfg2.ConcRepetirFecha
EmpresaCfg2.ConcRepetirFecha=EmpresaCfg2.ConcTraslaparFecha
EmpresaCfg2.ConcTraslaparFecha=EmpresaCfg2.ConcGastosAuto
EmpresaCfg2.ConcGastosAuto=EmpresaCfg2.ConcGastosAutoConceptoFijo
EmpresaCfg2.ConcGastosAutoConceptoFijo=EmpresaCfg2.ConcNoSugerirImportesDup
EmpresaCfg2.ConcNoSugerirImportesDup=EmpresaCfg2.ConcSugerirDespuesPeriodo
EmpresaCfg2.ConcSugerirDespuesPeriodo=EmpresaCfg2.ConcDiasCargos
EmpresaCfg2.ConcDiasCargos=EmpresaCfg2.ConcDiasAbonos
EmpresaCfg2.ConcDiasAbonos=EmpresaCfg2.ConcImportesLejanos
EmpresaCfg2.ConcImportesLejanos=EmpresaCfg2.ConcPolizaGenerar
EmpresaCfg2.ConcPolizaGenerar=(Fin)

[Conciliaciones.EmpresaCfg2.ConcPolizaGenerar]
Carpeta=Conciliaciones
Clave=EmpresaCfg2.ConcPolizaGenerar
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Compra2.EmpresaCfg2.CompraAutoCancelaCotizacion]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraAutoCancelaCotizacion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=50

[Ventas.EmpresaCfg.VentaPerdidaAutoPorcentaje]
Carpeta=Ventas
Clave=EmpresaCfg.VentaPerdidaAutoPorcentaje
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraPerdidaAutoPorcentaje]
Carpeta=Compras
Clave=EmpresaCfg.CompraPerdidaAutoPorcentaje
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[Inv.EmpresaCfg.ToleranciaCostoInferior]
Carpeta=Inv
Clave=EmpresaCfg.ToleranciaCostoInferior
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[Compras.EmpresaCfg.ValidarOrdenCompraTolerancia]
Carpeta=Compras
Clave=EmpresaCfg.ValidarOrdenCompraTolerancia
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
EspacioPrevio=S


[Proyectos.EmpresaCfg.ProyGenerarInvAlAfectar]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyGenerarInvAlAfectar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco

[Proyectos.EmpresaCfg.ProyGenerarInvPorActividad]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyGenerarInvPorActividad
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Proyectos.EmpresaCfg.ProyGenerarInvTiempo]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyGenerarInvTiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Proyectos.EmpresaCfg.ProyGenerarInvTiempoUnidad]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyGenerarInvTiempoUnidad
Editar=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraValidarPresupuestoMov]
Carpeta=Compras
Clave=EmpresaCfg.CompraValidarPresupuestoMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraValidarPresupuestoCC]
Carpeta=Compras
Clave=EmpresaCfg.CompraValidarPresupuestoCC
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraValidarPresupuestoCant]
Carpeta=Compras
Clave=EmpresaCfg.CompraValidarPresupuestoCant
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Plan.EmpresaCfg2.PlanPlanearServicios]
Carpeta=Plan
Clave=EmpresaCfg2.PlanPlanearServicios
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Plan.ListaEnCaptura]
(Inicio)=EmpresaCfg2.PlanMetodo
EmpresaCfg2.PlanMetodo=EmpresaCfg2.PlanNivelArtAutoRecalc
EmpresaCfg2.PlanNivelArtAutoRecalc=EmpresaCfg2.PlanLiberarCompra
EmpresaCfg2.PlanLiberarCompra=EmpresaCfg2.PlanLiberarProduccion
EmpresaCfg2.PlanLiberarProduccion=EmpresaCfg2.PlanLiberarDistribucion
EmpresaCfg2.PlanLiberarDistribucion=EmpresaCfg2.PlanRecorrerLiberacion
EmpresaCfg2.PlanRecorrerLiberacion=EmpresaCfg2.RutaDistribucion
EmpresaCfg2.RutaDistribucion=EmpresaCfg2.RutaDistribucionNivelArticulo
EmpresaCfg2.RutaDistribucionNivelArticulo=EmpresaCfg2.PlanUnidadDistribucion
EmpresaCfg2.PlanUnidadDistribucion=EmpresaCfg2.PlanTESeguridad
EmpresaCfg2.PlanTESeguridad=EmpresaCfg2.PlanAfectarOrdenesDistribucion
EmpresaCfg2.PlanAfectarOrdenesDistribucion=EmpresaCfg2.PlanSinDemanda
EmpresaCfg2.PlanSinDemanda=EmpresaCfg2.PlanISDemanda
EmpresaCfg2.PlanISDemanda=EmpresaCfg2.PlanIgnorarDemandaDirecta
EmpresaCfg2.PlanIgnorarDemandaDirecta=EmpresaCfg2.PlanIgnorarZonaCongelada
EmpresaCfg2.PlanIgnorarZonaCongelada=EmpresaCfg2.PlanAutoGuardarHist
EmpresaCfg2.PlanAutoGuardarHist=EmpresaCfg2.PlanBasePresupuesto
EmpresaCfg2.PlanBasePresupuesto=EmpresaCfg2.PlanPlanearServicios
EmpresaCfg2.PlanPlanearServicios=EmpresaCfg2.PlanTipoPeriodo
EmpresaCfg2.PlanTipoPeriodo=EmpresaCfg2.PlanInicio
EmpresaCfg2.PlanInicio=EmpresaCfg2.PlanEstadoOmision
EmpresaCfg2.PlanEstadoOmision=EmpresaCfg2.ProdPeriodosCorrida
EmpresaCfg2.ProdPeriodosCorrida=EmpresaCfg2.PlanCorridaOrden
EmpresaCfg2.PlanCorridaOrden=EmpresaCfg2.PlanCalcATP
EmpresaCfg2.PlanCalcATP=EmpresaCfg2.PlanAbortarPrimerError
EmpresaCfg2.PlanAbortarPrimerError=EmpresaCfg2.PlanInvSeguridadDias
EmpresaCfg2.PlanInvSeguridadDias=EmpresaCfg2.PlanInvSeguridadFactor
EmpresaCfg2.PlanInvSeguridadFactor=(Fin)

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
Vista=EmpresaCfg
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=4
FichaEspacioNombres=98
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FichaEspacioNombresAuto=S
CondicionVisible=General.WMS
[WMS.EmpresaCfg.WMSSugerirEntarimado]
Carpeta=WMS
Clave=EmpresaCfg.WMSSugerirEntarimado
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco


ValidaNombre=N
Pegado=S
[Ventas2.EmpresaCfg2.VentaCteArtEmpaqueCorrugado]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaCteArtEmpaqueCorrugado
Editar=S
3D=S
Tamano=51
ColorFondo=Blanco



[Ventas2.EmpresaCfg2.VentaVerPesoVolumen]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaVerPesoVolumen
Editar=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaVerRetencion1]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaVerRetencion1
Editar=S
LineaNueva=S
3D=S
Tamano=28
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaVerRetencion2]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaVerRetencion2
Editar=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.VentaVerRetencion3]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaVerRetencion3
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[CP]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Control Presupuestal
Clave=CP
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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

CondicionVisible=General.CP
[CP.EmpresaCfg.CPComprometido2]
Carpeta=CP
Clave=EmpresaCfg.CPComprometido2
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco

[CP.EmpresaCfg.CPDevengado2]
Carpeta=CP
Clave=EmpresaCfg.CPDevengado2
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcIntransferibleTarjeta]
Carpeta=Cxc
Clave=EmpresaCfg.CxcIntransferibleTarjeta
Editar=S
LineaNueva=S
3D=S
Tamano=33
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcCaducidadTarjeta]
Carpeta=Cxc
Clave=EmpresaCfg.CxcCaducidadTarjeta
Editar=S
3D=S
Tamano=29
ColorFondo=Blanco

[Cxc.EmpresaCfg.CxcCaducidadTarjetaFecha]
Carpeta=Cxc
Clave=EmpresaCfg.CxcCaducidadTarjetaFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Pegado=S



[Ofertas.EmpresaCfg2.OfertaNivelOpcion]
Carpeta=Ofertas
Clave=EmpresaCfg2.OfertaNivelOpcion
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=N
[CP.EmpresaCfg.CPClavePresupuestalImpuesto1]
Carpeta=CP
Clave=EmpresaCfg.CPClavePresupuestalImpuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco

[CP.EmpresaCfg.CPClavePresupuestalImpuesto2]
Carpeta=CP
Clave=EmpresaCfg.CPClavePresupuestalImpuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CP.EmpresaCfg.CPClavePresupuestalImpuesto3]
Carpeta=CP
Clave=EmpresaCfg.CPClavePresupuestalImpuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CP.EmpresaCfg.CPSepararImpuestos]
Carpeta=CP
Clave=EmpresaCfg.CPSepararImpuestos
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco
Tamano=30


[MAF]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mantenimiento Activos Fijos
Clave=MAF
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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
CondicionVisible=General.MAF

[MAF.ListaEnCaptura]
(Inicio)=EmpresaCfg2.MAFInspeccionUsuario
EmpresaCfg2.MAFInspeccionUsuario=EmpresaCfg2.MAFServicioMov
EmpresaCfg2.MAFServicioMov=EmpresaCfg2.MAFServicioUsuario
EmpresaCfg2.MAFServicioUsuario=EmpresaCfg2.MAFServicioCliente
EmpresaCfg2.MAFServicioCliente=EmpresaCfg2.MAFServicioConcepto
EmpresaCfg2.MAFServicioConcepto=EmpresaCfg2.MAFServicioTaller
EmpresaCfg2.MAFServicioTaller=(Fin)

[MAF.EmpresaCfg2.MAFInspeccionUsuario]
Carpeta=MAF
Clave=EmpresaCfg2.MAFInspeccionUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MAF.EmpresaCfg2.MAFServicioMov]
Carpeta=MAF
Clave=EmpresaCfg2.MAFServicioMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MAF.EmpresaCfg2.MAFServicioUsuario]
Carpeta=MAF
Clave=EmpresaCfg2.MAFServicioUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MAF.EmpresaCfg2.MAFServicioCliente]
Carpeta=MAF
Clave=EmpresaCfg2.MAFServicioCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MAF.EmpresaCfg2.MAFServicioConcepto]
Carpeta=MAF
Clave=EmpresaCfg2.MAFServicioConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[MAF.EmpresaCfg2.MAFServicioTaller]
Carpeta=MAF
Clave=EmpresaCfg2.MAFServicioTaller
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv2.EmpresaCfg2.InvCostearTransferencias]
Carpeta=Inv2
Clave=EmpresaCfg2.InvCostearTransferencias
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Personal.EmpresaCfg2.PersonalCostoHoraFactor]
Carpeta=Personal
Clave=EmpresaCfg2.PersonalCostoHoraFactor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Asiste.EmpresaCfg.PersonalCostoHoraFactor]
Carpeta=Asiste
Clave=EmpresaCfg.PersonalCostoHoraFactor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Organizacion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Organización
Clave=Organizacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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
ListaEnCaptura=EmpresaCfg.OrganizacionNivelDetalle
CarpetaVisible=S

[Organizacion.EmpresaCfg.OrganizacionNivelDetalle]
Carpeta=Organizacion
Clave=EmpresaCfg.OrganizacionNivelDetalle
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraVerImpuesto1]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraVerImpuesto1
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraVerImpuesto2]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraVerImpuesto2
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraVerImpuesto3]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraVerImpuesto3
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraVerRetencion1]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraVerRetencion1
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraVerRetencion2]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraVerRetencion2
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraVerRetencion3]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraVerRetencion3
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoVerImpuesto1]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoVerImpuesto1
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoVerImpuesto2]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoVerImpuesto2
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoVerImpuesto3]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoVerImpuesto3
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoVerRetencion1]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoVerRetencion1
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoVerRetencion2]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoVerRetencion2
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoVerRetencion3]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoVerRetencion3
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Compras.ListaEnCaptura]
(Inicio)=EmpresaCfg.CompraCostoSugerido
EmpresaCfg.CompraCostoSugerido=EmpresaCfg.CompraValidarPresupuesto
EmpresaCfg.CompraValidarPresupuesto=EmpresaCfg.CompraValidarPresupuestoFR
EmpresaCfg.CompraValidarPresupuestoFR=EmpresaCfg.CompraValidarPresupuestoMov
EmpresaCfg.CompraValidarPresupuestoMov=EmpresaCfg.CompraValidarPresupuestoCC
EmpresaCfg.CompraValidarPresupuestoCC=EmpresaCfg.CompraValidarPresupuestoCant
EmpresaCfg.CompraValidarPresupuestoCant=EmpresaCfg.ValidarOrdenCompraTolerancia
EmpresaCfg.ValidarOrdenCompraTolerancia=EmpresaCfg.CompraCostoConImpuesto
EmpresaCfg.CompraCostoConImpuesto=EmpresaCfg.CompraProveedorRequisicion
EmpresaCfg.CompraProveedorRequisicion=EmpresaCfg.AutorizarRequisiciones
EmpresaCfg.AutorizarRequisiciones=EmpresaCfg.CompraValidarArtProv
EmpresaCfg.CompraValidarArtProv=EmpresaCfg.CompraRestringirArtBloquedos
EmpresaCfg.CompraRestringirArtBloquedos=EmpresaCfg.CompraConcentrarEntrada
EmpresaCfg.CompraConcentrarEntrada=EmpresaCfg.CompraPerdidaAuto
EmpresaCfg.CompraPerdidaAuto=EmpresaCfg.CompraPerdidaAutoPorcentaje
EmpresaCfg.CompraPerdidaAutoPorcentaje=EmpresaCfg.CompraVerDescripcionExtra
EmpresaCfg.CompraVerDescripcionExtra=EmpresaCfg.CompraVerClaveProveedor
EmpresaCfg.CompraVerClaveProveedor=EmpresaCfg.CompraVerClaveIdioma
EmpresaCfg.CompraVerClaveIdioma=EmpresaCfg.CompraProrrateada
EmpresaCfg.CompraProrrateada=EmpresaCfg.CompraProrrateadaRedondeo
EmpresaCfg.CompraProrrateadaRedondeo=EmpresaCfg.CompraPaquetes
EmpresaCfg.CompraPaquetes=EmpresaCfg.CompraAnticipoCredito
EmpresaCfg.CompraAnticipoCredito=EmpresaCfg.CompraAutoEndoso
EmpresaCfg.CompraAutoEndoso=EmpresaCfg.CompraAutoEndosoEmpresas
EmpresaCfg.CompraAutoEndosoEmpresas=EmpresaCfg.CompraAutoEndosoWS
EmpresaCfg.CompraAutoEndosoWS=EmpresaCfg.CompraAutoEndosoWSDL
EmpresaCfg.CompraAutoEndosoWSDL=EmpresaCfg.CompraAutoEndosoAutoCargos
EmpresaCfg.CompraAutoEndosoAutoCargos=EmpresaCfg.CompraAutoEndosoMovs
EmpresaCfg.CompraAutoEndosoMovs=EmpresaCfg.CompraCostearDCporMovimiento
EmpresaCfg.CompraCostearDCporMovimiento=(Fin)

[Compras.EmpresaCfg.CompraCostoConImpuesto]
Carpeta=Compras
Clave=EmpresaCfg.CompraCostoConImpuesto
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoImporteConImpuesto]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoImporteConImpuesto
Editar=S
LineaNueva=N
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco


[RH.EmpresaCfg.RHAutorizarPlazas]
Carpeta=RH
Clave=EmpresaCfg.RHAutorizarPlazas
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraVerImpuesto4]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraVerImpuesto4
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoVerImpuesto4]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoVerImpuesto4
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdSerieLoteDesdeOrden]
Carpeta=Prod
Clave=EmpresaCfg2.ProdSerieLoteDesdeOrden
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=50
ColorFondo=Blanco

[Fiscal.ListaEnCaptura]
(Inicio)=EmpresaCfg2.FiscalVerIVA
EmpresaCfg2.FiscalVerIVA=EmpresaCfg2.FiscalVerIEPS
EmpresaCfg2.FiscalVerIEPS=EmpresaCfg2.FiscalInicioIVA
EmpresaCfg2.FiscalInicioIVA=EmpresaCfg2.FiscalVentaImpuesto3
EmpresaCfg2.FiscalVentaImpuesto3=EmpresaCfg2.FiscalCompraImpuesto3
EmpresaCfg2.FiscalCompraImpuesto3=EmpresaCfg2.FiscalOmitirDepositoAntCxc
EmpresaCfg2.FiscalOmitirDepositoAntCxc=EmpresaCfg2.FiscalOmitirChAntCxp
EmpresaCfg2.FiscalOmitirChAntCxp=EmpresaCfg2.FiscalOmitirCobrosChDevCxc
EmpresaCfg2.FiscalOmitirCobrosChDevCxc=EmpresaCfg2.FiscalOmitirPagosChDevCxp
EmpresaCfg2.FiscalOmitirPagosChDevCxp=EmpresaCfg2.FiscalOmitirPagosEndosoCxp
EmpresaCfg2.FiscalOmitirPagosEndosoCxp=EmpresaCfg2.FiscalRegAplicaAnticipoCxc
EmpresaCfg2.FiscalRegAplicaAnticipoCxc=EmpresaCfg2.FiscalRegAplicaFacturaCxc
EmpresaCfg2.FiscalRegAplicaFacturaCxc=EmpresaCfg2.FiscalRegAplicaAnticipoCxp
EmpresaCfg2.FiscalRegAplicaAnticipoCxp=EmpresaCfg2.FiscalRegAplicaFacturaCxp
EmpresaCfg2.FiscalRegAplicaFacturaCxp=EmpresaCfg2.FiscalGenerarRetenciones
EmpresaCfg2.FiscalGenerarRetenciones=(Fin)

[Fiscal.EmpresaCfg2.FiscalGenerarRetenciones]
Carpeta=Fiscal
Clave=EmpresaCfg2.FiscalGenerarRetenciones
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco

[Guatemala]
Estilo=Ficha
Pestana=S
Clave=Guatemala
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgGT
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfg
LlaveLocal=EmpresaCfgGT.Empresa
LlaveMaestra=EmpresaCfg.Empresa
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
PestanaOtroNombre=S
PestanaNombre=Guatemala
CondicionVisible=Empresa.EsGuatemala

[Guatemala.EmpresaCfgGT.Impuesto1Mov]
Carpeta=Guatemala
Clave=EmpresaCfgGT.Impuesto1Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Guatemala.EmpresaCfgGT.Impuesto1Acreedor]
Carpeta=Guatemala
Clave=EmpresaCfgGT.Impuesto1Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Guatemala.ListaEnCaptura]
(Inicio)=EmpresaCfgGT.Impuesto1Mov
EmpresaCfgGT.Impuesto1Mov=EmpresaCfgGT.Impuesto1Acreedor
EmpresaCfgGT.Impuesto1Acreedor=(Fin)

[Prod.EmpresaCfg2.ProdSerieloteIndicarArrastre]
Carpeta=Prod
Clave=EmpresaCfg2.ProdSerieloteIndicarArrastre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Prod.EmpresaCfg2.ProdValidarSLEntradaProduccion]
Carpeta=Prod
Clave=EmpresaCfg2.ProdValidarSLEntradaProduccion
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Compra2.EmpresaCfg2.CompraVerImpuesto5]
Carpeta=Compra2
Clave=EmpresaCfg2.CompraVerImpuesto5
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GastoVerImpuesto5]
Carpeta=Gastos
Clave=EmpresaCfg2.GastoVerImpuesto5
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GASCIMovEntrada]
Carpeta=Gastos
Clave=EmpresaCfg2.GASCIMovEntrada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.EmpresaCfg2.GASCIMovSalida]
Carpeta=Gastos
Clave=EmpresaCfg2.GASCIMovSalida
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas.ListaEnCaptura]
(Inicio)=EmpresaCfg.VentaPrecios
EmpresaCfg.VentaPrecios=EmpresaCfg.VentaDefCantidad
EmpresaCfg.VentaDefCantidad=EmpresaCfg.CteFormato
EmpresaCfg.CteFormato=EmpresaCfg.VentaLimiteRenFacturas
EmpresaCfg.VentaLimiteRenFacturas=EmpresaCfg.VentaLimiteRenFacturasVMOS
EmpresaCfg.VentaLimiteRenFacturasVMOS=EmpresaCfg.VentaPerdidaAuto
EmpresaCfg.VentaPerdidaAuto=EmpresaCfg.VentaPerdidaAutoPorcentaje
EmpresaCfg.VentaPerdidaAutoPorcentaje=EmpresaCfg.VentaPreciosImpuestoIncluido
EmpresaCfg.VentaPreciosImpuestoIncluido=EmpresaCfg.VentaCobroRedondeoDecimales
EmpresaCfg.VentaCobroRedondeoDecimales=EmpresaCfg.VentaTEEstandar
EmpresaCfg.VentaTEEstandar=EmpresaCfg.VentaTEEstandarRecorrerDomingo
EmpresaCfg.VentaTEEstandarRecorrerDomingo=EmpresaCfg.VentaTEEstandarTipoDias
EmpresaCfg.VentaTEEstandarTipoDias=EmpresaCfg.ValidarPrecios
EmpresaCfg.ValidarPrecios=EmpresaCfg.ValidarMargenMinimo
EmpresaCfg.ValidarMargenMinimo=EmpresaCfg.PrecioMinimoNivelSucursal
EmpresaCfg.PrecioMinimoNivelSucursal=EmpresaCfg.PedidosReservar
EmpresaCfg.PedidosReservar=EmpresaCfg.PedidosReservarEsp
EmpresaCfg.PedidosReservarEsp=EmpresaCfg.PedidosReservarLineaCompleta
EmpresaCfg.PedidosReservarLineaCompleta=EmpresaCfg.FacturasPendientes
EmpresaCfg.FacturasPendientes=EmpresaCfg.VentaLimiteCreditoNivelGrupo
EmpresaCfg.VentaLimiteCreditoNivelGrupo=EmpresaCfg.VentaLimiteCreditoNivelUEN
EmpresaCfg.VentaLimiteCreditoNivelUEN=EmpresaCfg.VentaSurtirDemas
EmpresaCfg.VentaSurtirDemas=EmpresaCfg.VentaPPIndirectos
EmpresaCfg.VentaPPIndirectos=EmpresaCfg.VentaRefSerieLotePedidos
EmpresaCfg.VentaRefSerieLotePedidos=EmpresaCfg.VentaArrastrarSerieLote
EmpresaCfg.VentaArrastrarSerieLote=EmpresaCfg.ComisionEspecial
EmpresaCfg.ComisionEspecial=EmpresaCfg.VentaComisionesCobradas
EmpresaCfg.VentaComisionesCobradas=EmpresaCfg.ComisionBase
EmpresaCfg.ComisionBase=EmpresaCfg.VentaComisionVariable
EmpresaCfg.VentaComisionVariable=EmpresaCfg.CancelarFacturaFecha
EmpresaCfg.CancelarFacturaFecha=EmpresaCfg.CancelarFactura
EmpresaCfg.CancelarFactura=EmpresaCfg.CancelarFacturaFisicamente
EmpresaCfg.CancelarFacturaFisicamente=EmpresaCfg.CancelarFacturaReservarPedido
EmpresaCfg.CancelarFacturaReservarPedido=EmpresaCfg.VentaVerClaveIdioma
EmpresaCfg.VentaVerClaveIdioma=EmpresaCfg.VentaVerDescripcionExtra
EmpresaCfg.VentaVerDescripcionExtra=EmpresaCfg.VentaAnticipoCredito
EmpresaCfg.VentaAnticipoCredito=EmpresaCfg.VentaActualizarPrecioMoneda
EmpresaCfg.VentaActualizarPrecioMoneda=EmpresaCfg.VentaVerDatosOC
EmpresaCfg.VentaVerDatosOC=EmpresaCfg.VentaPaquetes
EmpresaCfg.VentaPaquetes=EmpresaCfg.VentaIncentivos
EmpresaCfg.VentaIncentivos=EmpresaCfg.VentaPrecioMoneda
EmpresaCfg.VentaPrecioMoneda=EmpresaCfg.VentaProveedorRef
EmpresaCfg.VentaProveedorRef=EmpresaCfg.VentaRestringirArtBloqueados
EmpresaCfg.VentaRestringirArtBloqueados=EmpresaCfg.VentaAnexosAlFacturar
EmpresaCfg.VentaAnexosAlFacturar=EmpresaCfg.VentaEndoso
EmpresaCfg.VentaEndoso=EmpresaCfg.VentaMovImpuestoDesdeRemision
EmpresaCfg.VentaMovImpuestoDesdeRemision=(Fin)

[Ventas.EmpresaCfg.VentaMovImpuestoDesdeRemision]
Carpeta=Ventas
Clave=EmpresaCfg.VentaMovImpuestoDesdeRemision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Cxp2.EmpresaCfg2.CXPReferenciaEnAnticiposCP]
Carpeta=Cxp2
Clave=EmpresaCfg2.CXPReferenciaEnAnticiposCP
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=60
ColorFondo=Blanco

[Ventas2.EmpresaCfg2.BloquearFacturaOtraSucursal]
Carpeta=Ventas2
Clave=EmpresaCfg2.BloquearFacturaOtraSucursal
Editar=S
LineaNueva=S
3D=S
Tamano=51
ColorFondo=Blanco

[SAUX]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Servicios Auxiliares
Clave=SAUX
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
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
ListaEnCaptura=EmpresaCfg.SAUXConsumo
CondicionVisible=General.SAUX

[SAUX.EmpresaCfg.SAUXConsumo]
Carpeta=SAUX
Clave=EmpresaCfg.SAUXConsumo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MES]
Estilo=Ficha
Clave=MES
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
PestanaOtroNombre=S
PestanaNombre=MES
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Pestana=S

[MES.Columnas]
IntelMESInterfase=91
IntelMESInterfaseRuta=604

[MES.EmpresaCfg.IntelMESInterfase]
Carpeta=MES
Clave=EmpresaCfg.IntelMESInterfase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MES.EmpresaCfg.IntelMESInterfaseRuta]
Carpeta=MES
Clave=EmpresaCfg.IntelMESInterfaseRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[NOI.EmpresaCfg.TipoEmpleado]
Carpeta=NOI
Clave=EmpresaCfg.TipoEmpleado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[NOI.EmpresaCfg.MovNomina]
Carpeta=NOI
Clave=EmpresaCfg.MovNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[NOI.Columnas]
TipoEmpleado=124
MovNomina=124

[NOI.ListaEnCaptura]
(Inicio)=EmpresaCfg.TipoEmpleado
EmpresaCfg.TipoEmpleado=EmpresaCfg.MovNomina
EmpresaCfg.MovNomina=(Fin)

[Gastos.EmpresaCfg2.GasConceptoMultiple]
Carpeta=Gastos
Clave=EmpresaCfg2.GasConceptoMultiple
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Inv2.EmpresaCfg2.InvValuacionOtraMoneda]
Carpeta=Inv2
Clave=EmpresaCfg2.InvValuacionOtraMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Cxc2.EmpresaCfg2.CxcAnticipoTipoServicio]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcAnticipoTipoServicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=30

[Cxc2.EmpresaCfg2.CxcAnticipoArticuloServicio]
Carpeta=Cxc2
Clave=EmpresaCfg2.CxcAnticipoArticuloServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cont.EmpresaCfg.CentroCostos2AF]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos2AF
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cont.EmpresaCfg.CentroCostos3AF]
Carpeta=Cont
Clave=EmpresaCfg.CentroCostos3AF
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Cont.ListaEnCaptura]
(Inicio)=EmpresaCfg.ContMoneda
EmpresaCfg.ContMoneda=EmpresaCfg.ContMoneda2
EmpresaCfg.ContMoneda2=EmpresaCfg.ContMoneda2Auto
EmpresaCfg.ContMoneda2Auto=EmpresaCfg.ContTablaINPC
EmpresaCfg.ContTablaINPC=EmpresaCfg.TablaISAN
EmpresaCfg.TablaISAN=EmpresaCfg.ContToleraciaRedondeo
EmpresaCfg.ContToleraciaRedondeo=EmpresaCfg.CtaFormato
EmpresaCfg.CtaFormato=EmpresaCfg.ContVerificarPosicion
EmpresaCfg.ContVerificarPosicion=EmpresaCfg.ContCuentaCierre
EmpresaCfg.ContCuentaCierre=EmpresaCfg.ContCuentaCuadre
EmpresaCfg.ContCuentaCuadre=EmpresaCfg.ContToleranciaCuadre
EmpresaCfg.ContToleranciaCuadre=EmpresaCfg.ContVerificarIVA
EmpresaCfg.ContVerificarIVA=EmpresaCfg.ContPermitirCancelacionOrigen
EmpresaCfg.ContPermitirCancelacionOrigen=EmpresaCfg.ContCentrosCostos
EmpresaCfg.ContCentrosCostos=EmpresaCfg.ContUsoInv
EmpresaCfg.ContUsoInv=EmpresaCfg.ContUsoGastos
EmpresaCfg.ContUsoGastos=EmpresaCfg.ContUsoCompras
EmpresaCfg.ContUsoCompras=EmpresaCfg.ContUsoVentas
EmpresaCfg.ContUsoVentas=EmpresaCfg.ContUsoDinero
EmpresaCfg.ContUsoDinero=EmpresaCfg.ContUsoCxc
EmpresaCfg.ContUsoCxc=EmpresaCfg.ContUsoCxp
EmpresaCfg.ContUsoCxp=EmpresaCfg.CentrosCostosFormato
EmpresaCfg.CentrosCostosFormato=EmpresaCfg.ContCentrosCostosVerificarPos
EmpresaCfg.ContCentrosCostosVerificarPos=EmpresaCfg.CentroCostosRamas
EmpresaCfg.CentroCostosRamas=EmpresaCfg.CentroCostosValidar
EmpresaCfg.CentroCostosValidar=EmpresaCfg.CentroCostos2Venta
EmpresaCfg.CentroCostos2Venta=EmpresaCfg.CentroCostos2VentaD
EmpresaCfg.CentroCostos2VentaD=EmpresaCfg.CentroCostos3Venta
EmpresaCfg.CentroCostos3Venta=EmpresaCfg.CentroCostos3VentaD
EmpresaCfg.CentroCostos3VentaD=EmpresaCfg.CentroCostos2Gasto
EmpresaCfg.CentroCostos2Gasto=EmpresaCfg.CentroCostos2GastoD
EmpresaCfg.CentroCostos2GastoD=EmpresaCfg.CentroCostos3Gasto
EmpresaCfg.CentroCostos3Gasto=EmpresaCfg.CentroCostos3GastoD
EmpresaCfg.CentroCostos3GastoD=EmpresaCfg.CentroCostos2Compra
EmpresaCfg.CentroCostos2Compra=EmpresaCfg.CentroCostos2CompraD
EmpresaCfg.CentroCostos2CompraD=EmpresaCfg.CentroCostos3Compra
EmpresaCfg.CentroCostos3Compra=EmpresaCfg.CentroCostos3CompraD
EmpresaCfg.CentroCostos3CompraD=EmpresaCfg.CentroCostos2AF
EmpresaCfg.CentroCostos2AF=EmpresaCfg.CentroCostos3AF
EmpresaCfg.CentroCostos3AF=EmpresaCfg.VisualizarArrastre
EmpresaCfg.VisualizarArrastre=EmpresaCfg.ContMovPresupuesto
EmpresaCfg.ContMovPresupuesto=EmpresaCfg.ContNivelPresupuesto
EmpresaCfg.ContNivelPresupuesto=EmpresaCfg.ContCtaCliente
EmpresaCfg.ContCtaCliente=EmpresaCfg.ContCtaProveedor
EmpresaCfg.ContCtaProveedor=EmpresaCfg.ContCtaPersonal
EmpresaCfg.ContCtaPersonal=EmpresaCfg.ContCtaDinero
EmpresaCfg.ContCtaDinero=EmpresaCfg.ContCtaAlmacen
EmpresaCfg.ContCtaAlmacen=EmpresaCfg.ContCtaFormaPago
EmpresaCfg.ContCtaFormaPago=EmpresaCfg.ContCtaArticulo
EmpresaCfg.ContCtaArticulo=EmpresaCfg.ContMultiSucursal
EmpresaCfg.ContMultiSucursal=EmpresaCfg.ContArticulo
EmpresaCfg.ContArticulo=(Fin)

[Inv2.ListaEnCaptura]
(Inicio)=EmpresaCfg2.VIN
EmpresaCfg2.VIN=EmpresaCfg2.VINAccesorioArt
EmpresaCfg2.VINAccesorioArt=EmpresaCfg2.VINCostoSumaAccesorios
EmpresaCfg2.VINCostoSumaAccesorios=EmpresaCfg2.ArtProvSucursalCompra
EmpresaCfg2.ArtProvSucursalCompra=EmpresaCfg2.InvCostearTransferencias
EmpresaCfg2.InvCostearTransferencias=EmpresaCfg2.ValidarLotesCostoDif
EmpresaCfg2.ValidarLotesCostoDif=EmpresaCfg2.OpcionMatriz
EmpresaCfg2.OpcionMatriz=EmpresaCfg2.InvRegistrarPrecios
EmpresaCfg2.InvRegistrarPrecios=EmpresaCfg2.BloquearOpcionesArtConMovs
EmpresaCfg2.BloquearOpcionesArtConMovs=EmpresaCfg2.InvFrecuenciaABCDiasHabiles
EmpresaCfg2.InvFrecuenciaABCDiasHabiles=EmpresaCfg2.InvMultiAlmacen
EmpresaCfg2.InvMultiAlmacen=EmpresaCfg2.InvVerDescripcionExtra
EmpresaCfg2.InvVerDescripcionExtra=EmpresaCfg2.DecimalesCantidadPendiente
EmpresaCfg2.DecimalesCantidadPendiente=EmpresaCfg2.InvAjusteSaldosMenores
EmpresaCfg2.InvAjusteSaldosMenores=EmpresaCfg2.AlmacenOrigenOT
EmpresaCfg2.AlmacenOrigenOT=EmpresaCfg2.InvAjusteCargoAgente
EmpresaCfg2.InvAjusteCargoAgente=EmpresaCfg2.CBSugerir
EmpresaCfg2.CBSugerir=EmpresaCfg2.InvValuacionOtraMoneda
EmpresaCfg2.InvValuacionOtraMoneda=EmpresaCfg2.INVValidarFechaAplicacion
EmpresaCfg2.INVValidarFechaAplicacion=(Fin)


[Compra2.ListaEnCaptura]
(Inicio)=EmpresaCfg2.CompraRecibirDemas
EmpresaCfg2.CompraRecibirDemas=EmpresaCfg2.CompraRecibirDemasTolerancia
EmpresaCfg2.CompraRecibirDemasTolerancia=EmpresaCfg2.CompraDevConsecutivoIndep
EmpresaCfg2.CompraDevConsecutivoIndep=EmpresaCfg2.CompraBonifConsecutivoIndep
EmpresaCfg2.CompraBonifConsecutivoIndep=EmpresaCfg2.CompraCostosImpuestoIncluido
EmpresaCfg2.CompraCostosImpuestoIncluido=EmpresaCfg2.CompraAutoCargos
EmpresaCfg2.CompraAutoCargos=EmpresaCfg2.CompraSugerirUltimoCostoProv
EmpresaCfg2.CompraSugerirUltimoCostoProv=EmpresaCfg2.CompraRetenciones
EmpresaCfg2.CompraRetenciones=EmpresaCfg2.CompraSugerirArtR
EmpresaCfg2.CompraSugerirArtR=EmpresaCfg2.CompraSugerirUnidadDemanda
EmpresaCfg2.CompraSugerirUnidadDemanda=EmpresaCfg2.CompraCaducidad
EmpresaCfg2.CompraCaducidad=EmpresaCfg2.CompraValidarFechaRequerida
EmpresaCfg2.CompraValidarFechaRequerida=EmpresaCfg2.CompraDevAutoAplicar
EmpresaCfg2.CompraDevAutoAplicar=EmpresaCfg2.ArtDescuentoCompraCascada
EmpresaCfg2.ArtDescuentoCompraCascada=EmpresaCfg2.CompraGastoDiversoCxc
EmpresaCfg2.CompraGastoDiversoCxc=EmpresaCfg2.CompraPresupuestosPendientes
EmpresaCfg2.CompraPresupuestosPendientes=EmpresaCfg2.CompraPresupuestosCategoria
EmpresaCfg2.CompraPresupuestosCategoria=EmpresaCfg2.CompraMultiEmpresas
EmpresaCfg2.CompraMultiEmpresas=EmpresaCfg2.CompraMultiAlmacen
EmpresaCfg2.CompraMultiAlmacen=EmpresaCfg2.CompraDescuentoImporte
EmpresaCfg2.CompraDescuentoImporte=EmpresaCfg2.CompraDescuentoCascadaDetalle
EmpresaCfg2.CompraDescuentoCascadaDetalle=EmpresaCfg2.CompraABC
EmpresaCfg2.CompraABC=EmpresaCfg2.CompraAutoCancelaCotizacion
EmpresaCfg2.CompraAutoCancelaCotizacion=EmpresaCfg2.CompraVerImpuesto1
EmpresaCfg2.CompraVerImpuesto1=EmpresaCfg2.CompraVerImpuesto2
EmpresaCfg2.CompraVerImpuesto2=EmpresaCfg2.CompraVerImpuesto3
EmpresaCfg2.CompraVerImpuesto3=EmpresaCfg2.CompraVerImpuesto4
EmpresaCfg2.CompraVerImpuesto4=EmpresaCfg2.CompraVerImpuesto5
EmpresaCfg2.CompraVerImpuesto5=EmpresaCfg2.CompraVerRetencion1
EmpresaCfg2.CompraVerRetencion1=EmpresaCfg2.CompraVerRetencion2
EmpresaCfg2.CompraVerRetencion2=EmpresaCfg2.CompraVerRetencion3
EmpresaCfg2.CompraVerRetencion3=EmpresaCfg2.COMSValidarFechaAplicacion
EmpresaCfg2.COMSValidarFechaAplicacion=(Fin)


[Dinero2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Tesorería (2)
Clave=Dinero2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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
CarpetaVisible=S
ListaEnCaptura=EmpresaCfg2.DINValidarFechaAplicacion

[Inv2.EmpresaCfg2.INVValidarFechaAplicacion]
Carpeta=Inv2
Clave=EmpresaCfg2.INVValidarFechaAplicacion
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Ventas2.EmpresaCfg2.VTASValidarFechaAplicacion]
Carpeta=Ventas2
Clave=EmpresaCfg2.VTASValidarFechaAplicacion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Compra2.EmpresaCfg2.COMSValidarFechaAplicacion]
Carpeta=Compra2
Clave=EmpresaCfg2.COMSValidarFechaAplicacion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Cxc2.EmpresaCfg2.CXCValidarFechaAplicacion]
Carpeta=Cxc2
Clave=EmpresaCfg2.CXCValidarFechaAplicacion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Cxp2.EmpresaCfg2.CXPValidarFechaAplicacion]
Carpeta=Cxp2
Clave=EmpresaCfg2.CXPValidarFechaAplicacion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Prod.EmpresaCfg2.PRODValidarFechaAplicacion]
Carpeta=Prod
Clave=EmpresaCfg2.PRODValidarFechaAplicacion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Dinero2.EmpresaCfg2.DINValidarFechaAplicacion]
Carpeta=Dinero2
Clave=EmpresaCfg2.DINValidarFechaAplicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Acciones.ValidarFechaAplicacion]
Nombre=ValidarFechaAplicacion
Boton=88
NombreDesplegar=Validar Fecha Aplicación - Movimientos Especificos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmpresaValidarFechaAplicacion
Activo=S
Visible=S

[Gastos2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gastos (2)
Clave=Gastos2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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

[Gastos2.EmpresaCfg2.GASValidarFechaAplicacion]
Carpeta=Gastos2
Clave=EmpresaCfg2.GASValidarFechaAplicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.ListaEnCaptura]
(Inicio)=EmpresaCfg2.Gasto2Retenciones
EmpresaCfg2.Gasto2Retenciones=EmpresaCfg2.Gasto3Retenciones
EmpresaCfg2.Gasto3Retenciones=EmpresaCfg2.GastoAnticipoCxp
EmpresaCfg2.GastoAnticipoCxp=EmpresaCfg2.GastoCantidades
EmpresaCfg2.GastoCantidades=EmpresaCfg2.GastoCopiarImporte
EmpresaCfg2.GastoCopiarImporte=EmpresaCfg2.GastoDiversoReferenciaCxp
EmpresaCfg2.GastoDiversoReferenciaCxp=EmpresaCfg2.GastoSolicitudAnticipoImpuesto
EmpresaCfg2.GastoSolicitudAnticipoImpuesto=EmpresaCfg2.GastoClaseRequerida
EmpresaCfg2.GastoClaseRequerida=EmpresaCfg2.GastoAutoCargos
EmpresaCfg2.GastoAutoCargos=EmpresaCfg2.GastoBorradorComprobantes
EmpresaCfg2.GastoBorradorComprobantes=EmpresaCfg2.GastoBorradorCajaChica
EmpresaCfg2.GastoBorradorCajaChica=EmpresaCfg2.GastoGenerarAnticiposBorrador
EmpresaCfg2.GastoGenerarAnticiposBorrador=EmpresaCfg2.GastoCxc
EmpresaCfg2.GastoCxc=EmpresaCfg2.GastoConceptoCxp
EmpresaCfg2.GastoConceptoCxp=EmpresaCfg2.GasConceptoMultiple
EmpresaCfg2.GasConceptoMultiple=EmpresaCfg2.GastoClienteRef
EmpresaCfg2.GastoClienteRef=EmpresaCfg2.GastoArticuloRef
EmpresaCfg2.GastoArticuloRef=EmpresaCfg2.GastoSugerirCostoEstandar
EmpresaCfg2.GastoSugerirCostoEstandar=EmpresaCfg2.GastoImporteConImpuesto
EmpresaCfg2.GastoImporteConImpuesto=EmpresaCfg2.GastoValidarPresupuesto
EmpresaCfg2.GastoValidarPresupuesto=EmpresaCfg2.GastoValidarPresupuestoCC
EmpresaCfg2.GastoValidarPresupuestoCC=EmpresaCfg2.GastoValidarPresupuestoFR
EmpresaCfg2.GastoValidarPresupuestoFR=EmpresaCfg2.GastoPresupuestoPendiente
EmpresaCfg2.GastoPresupuestoPendiente=EmpresaCfg2.GastoActividad
EmpresaCfg2.GastoActividad=EmpresaCfg2.GastoProyectoDetalle
EmpresaCfg2.GastoProyectoDetalle=EmpresaCfg2.GastoUENDetalle
EmpresaCfg2.GastoUENDetalle=EmpresaCfg2.GastoAFDetalle
EmpresaCfg2.GastoAFDetalle=EmpresaCfg2.GastoPersonal
EmpresaCfg2.GastoPersonal=EmpresaCfg2.GastoRecurso
EmpresaCfg2.GastoRecurso=EmpresaCfg2.GastoABC
EmpresaCfg2.GastoABC=EmpresaCfg2.GastoAyudaConceptos
EmpresaCfg2.GastoAyudaConceptos=EmpresaCfg2.GastoDiversoSinProrratear
EmpresaCfg2.GastoDiversoSinProrratear=EmpresaCfg2.GastoProvisionTolerancia
EmpresaCfg2.GastoProvisionTolerancia=EmpresaCfg2.GastoConceptosInventariables
EmpresaCfg2.GastoConceptosInventariables=EmpresaCfg2.GastoAlmacen
EmpresaCfg2.GastoAlmacen=EmpresaCfg2.GastoInvCopiarMov
EmpresaCfg2.GastoInvCopiarMov=EmpresaCfg2.GASCIMovEntrada
EmpresaCfg2.GASCIMovEntrada=EmpresaCfg2.GASCIMovSalida
EmpresaCfg2.GASCIMovSalida=EmpresaCfg2.GastoVerImpuesto1
EmpresaCfg2.GastoVerImpuesto1=EmpresaCfg2.GastoVerImpuesto2
EmpresaCfg2.GastoVerImpuesto2=EmpresaCfg2.GastoVerImpuesto3
EmpresaCfg2.GastoVerImpuesto3=EmpresaCfg2.GastoVerImpuesto4
EmpresaCfg2.GastoVerImpuesto4=EmpresaCfg2.GastoVerImpuesto5
EmpresaCfg2.GastoVerImpuesto5=EmpresaCfg2.GastoVerRetencion1
EmpresaCfg2.GastoVerRetencion1=EmpresaCfg2.GastoVerRetencion2
EmpresaCfg2.GastoVerRetencion2=EmpresaCfg2.GastoVerRetencion3
EmpresaCfg2.GastoVerRetencion3=(Fin)

[Prod.ListaEnCaptura]
(Inicio)=EmpresaCfg2.ProdAlmacenMP
EmpresaCfg2.ProdAlmacenMP=EmpresaCfg2.ProdAutoLote
EmpresaCfg2.ProdAutoLote=EmpresaCfg2.ProdAutoCB
EmpresaCfg2.ProdAutoCB=EmpresaCfg2.ProdAutoReservar
EmpresaCfg2.ProdAutoReservar=EmpresaCfg2.ProdProgramar
EmpresaCfg2.ProdProgramar=EmpresaCfg2.ProdVolumen
EmpresaCfg2.ProdVolumen=EmpresaCfg2.ProdSerieLoteDesdeOrden
EmpresaCfg2.ProdSerieLoteDesdeOrden=EmpresaCfg2.ProdSerieloteIndicarArrastre
EmpresaCfg2.ProdSerieloteIndicarArrastre=EmpresaCfg2.ProdValidarSLEntradaProduccion
EmpresaCfg2.ProdValidarSLEntradaProduccion=EmpresaCfg2.ProdTransferenciaConcentrada
EmpresaCfg2.ProdTransferenciaConcentrada=EmpresaCfg2.ProdGenerarConsumo
EmpresaCfg2.ProdGenerarConsumo=EmpresaCfg2.ProdAfectarConsumo
EmpresaCfg2.ProdAfectarConsumo=EmpresaCfg2.ProdAfectarConsumoParcial
EmpresaCfg2.ProdAfectarConsumoParcial=EmpresaCfg2.Mermas
EmpresaCfg2.Mermas=EmpresaCfg2.ProdMermaIncluida
EmpresaCfg2.ProdMermaIncluida=EmpresaCfg2.Desperdicios
EmpresaCfg2.Desperdicios=EmpresaCfg2.ProdDesperdicioIncluido
EmpresaCfg2.ProdDesperdicioIncluido=EmpresaCfg2.ProdTipoMerma
EmpresaCfg2.ProdTipoMerma=EmpresaCfg2.ProdVerPersonal
EmpresaCfg2.ProdVerPersonal=EmpresaCfg2.ProdVerTurno
EmpresaCfg2.ProdVerTurno=EmpresaCfg2.ProdVerTiempo
EmpresaCfg2.ProdVerTiempo=EmpresaCfg2.ProdVerTiempoMuerto
EmpresaCfg2.ProdVerTiempoMuerto=EmpresaCfg2.ProdVerManoObra
EmpresaCfg2.ProdVerManoObra=EmpresaCfg2.ProdVerMaquila
EmpresaCfg2.ProdVerMaquila=EmpresaCfg2.ProdVerIndirectos
EmpresaCfg2.ProdVerIndirectos=EmpresaCfg2.PRODValidarFechaAplicacion
EmpresaCfg2.PRODValidarFechaAplicacion=(Fin)


[Cxp.ListaEnCaptura]
(Inicio)=EmpresaCfg.CxpAplicaAutoOrden
EmpresaCfg.CxpAplicaAutoOrden=EmpresaCfg.CxpDocAutoFolio
EmpresaCfg.CxpDocAutoFolio=EmpresaCfg.CxpDocAnticipoAutoFolio
EmpresaCfg.CxpDocAnticipoAutoFolio=EmpresaCfg.CxpAutoAjuste
EmpresaCfg.CxpAutoAjuste=EmpresaCfg.CxpAutoAjusteMov
EmpresaCfg.CxpAutoAjusteMov=EmpresaCfg.CxpProntoPagoConcepto
EmpresaCfg.CxpProntoPagoConcepto=EmpresaCfg.CxpRecargosConcepto
EmpresaCfg.CxpRecargosConcepto=EmpresaCfg.FormaPagoOmision
EmpresaCfg.FormaPagoOmision=EmpresaCfg.CxpRecorrerVencimiento
EmpresaCfg.CxpRecorrerVencimiento=EmpresaCfg.CxpPlazo1
EmpresaCfg.CxpPlazo1=EmpresaCfg.CxpPlazo2
EmpresaCfg.CxpPlazo2=EmpresaCfg.CxpPlazo3
EmpresaCfg.CxpPlazo3=EmpresaCfg.CxpPlazo4
EmpresaCfg.CxpPlazo4=(Fin)


[Dinero.EmpresaCfg.DineroProrrateoMovImpuesto]
Carpeta=Dinero
Clave=EmpresaCfg.DineroProrrateoMovImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ActivosF.EmpresaCfg.AFGenerarGasto]
Carpeta=ActivosF
Clave=EmpresaCfg.AFGenerarGasto
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=20

[ActivosF.EmpresaCfg.AFGenerarGastoCfg]
Carpeta=ActivosF
Clave=EmpresaCfg.AFGenerarGastoCfg
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=S

[ActivosF.ListaEnCaptura]
(Inicio)=EmpresaCfg.AFRevaluarDepreciacion
EmpresaCfg.AFRevaluarDepreciacion=EmpresaCfg.AFMantenimientoPendiente
EmpresaCfg.AFMantenimientoPendiente=EmpresaCfg.AFGenerarGasto
EmpresaCfg.AFGenerarGasto=EmpresaCfg.AFGenerarGastoCfg
EmpresaCfg.AFGenerarGastoCfg=EmpresaCfg.AFAcreedorDepreciacion
EmpresaCfg.AFAcreedorDepreciacion=EmpresaCfg.AFConceptoDepreciacion
EmpresaCfg.AFConceptoDepreciacion=EmpresaCfg.ContTablaINPC
EmpresaCfg.ContTablaINPC=EmpresaCfg.AFSugerirSerieEntrada
EmpresaCfg.AFSugerirSerieEntrada=EmpresaCfg.AFConsecutivo
EmpresaCfg.AFConsecutivo=(Fin)



[Inv.EmpresaCfg.AjustesAutomaticosMES]
Carpeta=Inv
Clave=EmpresaCfg.AjustesAutomaticosMES
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[WMS.EmpresaCfg.WMSLeerPosicionOrigen]
Carpeta=WMS
Clave=EmpresaCfg.WMSLeerPosicionOrigen
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco

Pegado=S
[WMS.EmpresaCfg.WMSDispararReacomodos]
Carpeta=WMS
Clave=EmpresaCfg.WMSDispararReacomodos
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

Pegado=S
[WMS.EmpresaCfg.WMSRotacionArticulo]
Carpeta=WMS
Clave=EmpresaCfg.WMSRotacionArticulo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco

OcultaNombre=N
Pegado=S
[WMS.EmpresaCfg.WMSAndenSurtidoContacto]
Carpeta=WMS
Clave=EmpresaCfg.WMSAndenSurtidoContacto
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

Pegado=S
[WMS.EmpresaCfg.WMSMovilTarea]
Carpeta=WMS
Clave=EmpresaCfg.WMSMovilTarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Pegado=S
[WMS.EmpresaCfg.WMSTipoAcomodador]
Carpeta=WMS
Clave=EmpresaCfg.WMSTipoAcomodador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Pegado=S
[WMS.EmpresaCfg.WMSPermitirReacomodosDomicilio]
Carpeta=WMS
Clave=EmpresaCfg.WMSPermitirReacomodosDomicilio
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

Pegado=S
[WMS.EmpresaCfg.WMSValidarZona]
Carpeta=WMS
Clave=EmpresaCfg.WMSValidarZona
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
























Pegado=S

























































[CP.ListaEnCaptura]
(Inicio)=EmpresaCfg.CPComprometido2
EmpresaCfg.CPComprometido2=EmpresaCfg.CPDevengado2
EmpresaCfg.CPDevengado2=EmpresaCfg.CPSepararImpuestos
EmpresaCfg.CPSepararImpuestos=EmpresaCfg.CPClavePresupuestalImpuesto1
EmpresaCfg.CPClavePresupuestalImpuesto1=EmpresaCfg.CPClavePresupuestalImpuesto2
EmpresaCfg.CPClavePresupuestalImpuesto2=EmpresaCfg.CPClavePresupuestalImpuesto3
EmpresaCfg.CPClavePresupuestalImpuesto3=EmpresaCfg.CPClavePresupuestalRetencion1
EmpresaCfg.CPClavePresupuestalRetencion1=EmpresaCfg.CPClavePresupuestalRetencion2
EmpresaCfg.CPClavePresupuestalRetencion2=EmpresaCfg.CPClavePresupuestalRetencion3
EmpresaCfg.CPClavePresupuestalRetencion3=(Fin)

[CP.EmpresaCfg.CPClavePresupuestalRetencion1]
Carpeta=CP
Clave=EmpresaCfg.CPClavePresupuestalRetencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[CRM.EmpresaCfg2.OPORTTareaEstado]
Carpeta=CRM
Clave=EmpresaCfg2.OPORTTareaEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[CRM.Columnas]
OPORTTareaEstado=184


[CP.EmpresaCfg.CPClavePresupuestalRetencion2]
Carpeta=CP
Clave=EmpresaCfg.CPClavePresupuestalRetencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CP.EmpresaCfg.CPClavePresupuestalRetencion3]
Carpeta=CP
Clave=EmpresaCfg.CPClavePresupuestalRetencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco







[Oportunidades]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Oportunidades
Clave=Oportunidades
Filtros=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfg
LlaveLocal=EmpresaCfg2.Empresa
LlaveMaestra=EmpresaCfg.Empresa
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

ListaEnCaptura=EmpresaCfg2.OPORTTareaEstado


CondicionVisible=General.OPORT
[Oportunidades.EmpresaCfg2.OPORTTareaEstado]
Carpeta=Oportunidades
Clave=EmpresaCfg2.OPORTTareaEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
























[Gastos2.EmpresaCfg2.GASRetencion3Independiente]
Carpeta=Gastos2
Clave=EmpresaCfg2.GASRetencion3Independiente
Editar=S
LineaNueva=N
3D=S
Tamano=25
ColorFondo=Blanco






[Gastos2.ListaEnCaptura]
(Inicio)=EmpresaCfg2.GASRetencion3Independiente
EmpresaCfg2.GASRetencion3Independiente=EmpresaCfg2.GASValidarFechaAplicacion
EmpresaCfg2.GASValidarFechaAplicacion=(Fin)





[Dinero.ListaEnCaptura]
(Inicio)=EmpresaCfg.Cajeros
EmpresaCfg.Cajeros=EmpresaCfg.DineroAutoFaltanteSobrante
EmpresaCfg.DineroAutoFaltanteSobrante=EmpresaCfg.DineroProrrateoMovImpuesto
EmpresaCfg.DineroProrrateoMovImpuesto=EmpresaCfg.DineroControlarSobregiros
EmpresaCfg.DineroControlarSobregiros=EmpresaCfg.ChequesPendientes
EmpresaCfg.ChequesPendientes=EmpresaCfg.eChequesPendientes
EmpresaCfg.eChequesPendientes=EmpresaCfg.DineroConciliarEstatus
EmpresaCfg.DineroConciliarEstatus=EmpresaCfg.FormaPagoRequerida
EmpresaCfg.FormaPagoRequerida=EmpresaCfg.DineroDesgloseObligatorio
EmpresaCfg.DineroDesgloseObligatorio=EmpresaCfg.DineroAfectarComision
EmpresaCfg.DineroAfectarComision=EmpresaCfg.DineroAfectarComisionIVA
EmpresaCfg.DineroAfectarComisionIVA=EmpresaCfg.DineroConciliarPorSucursales
EmpresaCfg.DineroConciliarPorSucursales=EmpresaCfg.DineroCorteSDPorFormaPago
EmpresaCfg.DineroCorteSDPorFormaPago=EmpresaCfg.DineroPagoConciliado
EmpresaCfg.DineroPagoConciliado=EmpresaCfg.DineroValidarMovImpuesto
EmpresaCfg.DineroValidarMovImpuesto=EmpresaCfg.DineroContX
EmpresaCfg.DineroContX=EmpresaCfg.FormaPagoEfectivo
EmpresaCfg.FormaPagoEfectivo=EmpresaCfg.DineroFaltanteModulo
EmpresaCfg.DineroFaltanteModulo=EmpresaCfg.DineroInversionIntereses
EmpresaCfg.DineroInversionIntereses=(Fin)








[VentasMostrador.EmpresaCfg.GenerarNCAlProcesar]
Carpeta=VentasMostrador
Clave=EmpresaCfg.GenerarNCAlProcesar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Cxc.ListaEnCaptura]
(Inicio)=EmpresaCfg.CxcAplicaAutoOrden
EmpresaCfg.CxcAplicaAutoOrden=EmpresaCfg.CxcDocAutoFolio
EmpresaCfg.CxcDocAutoFolio=EmpresaCfg.CxcDocAnticipoAutoFolio
EmpresaCfg.CxcDocAnticipoAutoFolio=EmpresaCfg.CxcAutoAjuste
EmpresaCfg.CxcAutoAjuste=EmpresaCfg.CxcAutoAjusteMov
EmpresaCfg.CxcAutoAjusteMov=EmpresaCfg.CxcProntoPagoConcepto
EmpresaCfg.CxcProntoPagoConcepto=EmpresaCfg.CxcRecargosConcepto
EmpresaCfg.CxcRecargosConcepto=EmpresaCfg.CxcFormaCobroDA
EmpresaCfg.CxcFormaCobroDA=EmpresaCfg.CxcDARef
EmpresaCfg.CxcDARef=EmpresaCfg.CxcFormaCobroVales
EmpresaCfg.CxcFormaCobroVales=EmpresaCfg.CxcFormaCobroTarjetas
EmpresaCfg.CxcFormaCobroTarjetas=EmpresaCfg.CxcArticuloTarjetasDef
EmpresaCfg.CxcArticuloTarjetasDef=EmpresaCfg.CxcAlmacenTarjetasDef
EmpresaCfg.CxcAlmacenTarjetasDef=EmpresaCfg.ArtTarjetaServicio
EmpresaCfg.ArtTarjetaServicio=EmpresaCfg.CxcValidarPrecioTarjetas
EmpresaCfg.CxcValidarPrecioTarjetas=EmpresaCfg.CxcIntransferibleTarjeta
EmpresaCfg.CxcIntransferibleTarjeta=EmpresaCfg.CxcCaducidadTarjeta
EmpresaCfg.CxcCaducidadTarjeta=EmpresaCfg.CxcCaducidadTarjetaFecha
EmpresaCfg.CxcCaducidadTarjetaFecha=EmpresaCfg.FormaPagoCambio
EmpresaCfg.FormaPagoCambio=EmpresaCfg.FormaCobroOmision
EmpresaCfg.FormaCobroOmision=EmpresaCfg.CxcRecorrerVencimiento
EmpresaCfg.CxcRecorrerVencimiento=EmpresaCfg.CxcPlazo1
EmpresaCfg.CxcPlazo1=EmpresaCfg.CxcPlazo2
EmpresaCfg.CxcPlazo2=EmpresaCfg.CxcPlazo3
EmpresaCfg.CxcPlazo3=EmpresaCfg.CxcPlazo4
EmpresaCfg.CxcPlazo4=EmpresaCfg.CxcDescContado
EmpresaCfg.CxcDescContado=EmpresaCfg.CxcDescContadoDias
EmpresaCfg.CxcDescContadoDias=EmpresaCfg.CxcDescContadoPorcentaje
EmpresaCfg.CxcDescContadoPorcentaje=EmpresaCfg.CxcValidarDescPPMorosos
EmpresaCfg.CxcValidarDescPPMorosos=(Fin)

[Cxc.EmpresaCfg.ArtTarjetaServicio]
Carpeta=Cxc
Clave=EmpresaCfg.ArtTarjetaServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Cxc2.EmpresaCfg2.CXCDTotalizarRedondeo]
Carpeta=Cxc2
Clave=EmpresaCfg2.CXCDTotalizarRedondeo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30








[Cxc2.ListaEnCaptura]
(Inicio)=EmpresaCfg2.CxcPosfechados
EmpresaCfg2.CxcPosfechados=EmpresaCfg2.CxcAnticiposFacturados
EmpresaCfg2.CxcAnticiposFacturados=EmpresaCfg2.CxcAnticipoTipoServicio
EmpresaCfg2.CxcAnticipoTipoServicio=EmpresaCfg2.CxcAnticipoArticuloServicio
EmpresaCfg2.CxcAnticipoArticuloServicio=EmpresaCfg2.CxcAplicaManualDef
EmpresaCfg2.CxcAplicaManualDef=EmpresaCfg2.CxcDegloseDef
EmpresaCfg2.CxcDegloseDef=EmpresaCfg2.CxcCobroImpuestos
EmpresaCfg2.CxcCobroImpuestos=EmpresaCfg2.CxcComisionCreditos
EmpresaCfg2.CxcComisionCreditos=EmpresaCfg2.CxcAutoAplicarAnticiposPedidos
EmpresaCfg2.CxcAutoAplicarAnticiposPedidos=EmpresaCfg2.ComisionesCobranza
EmpresaCfg2.ComisionesCobranza=EmpresaCfg2.CxcVerRetencion
EmpresaCfg2.CxcVerRetencion=EmpresaCfg2.CxcVerRetencion2
EmpresaCfg2.CxcVerRetencion2=EmpresaCfg2.CxcVerRetencion3
EmpresaCfg2.CxcVerRetencion3=EmpresaCfg2.CXCDTotalizarRedondeo
EmpresaCfg2.CXCDTotalizarRedondeo=EmpresaCfg2.CXCValidarFechaAplicacion
EmpresaCfg2.CXCValidarFechaAplicacion=(Fin)






[Cxp2.ListaEnCaptura]
(Inicio)=EmpresaCfg2.CxpPosfechados
EmpresaCfg2.CxpPosfechados=EmpresaCfg2.CxpAplicaManualDef
EmpresaCfg2.CxpAplicaManualDef=EmpresaCfg2.CxpAplicacionPagos
EmpresaCfg2.CxpAplicacionPagos=EmpresaCfg2.CxpAfectarPagosAutomaticos
EmpresaCfg2.CxpAfectarPagosAutomaticos=EmpresaCfg2.CxpDocAutoBorrador
EmpresaCfg2.CxpDocAutoBorrador=EmpresaCfg2.CxpPagoTasa
EmpresaCfg2.CxpPagoTasa=EmpresaCfg2.CxpDiasMorosidad
EmpresaCfg2.CxpDiasMorosidad=EmpresaCfg2.CxpGenerarEnBorrador
EmpresaCfg2.CxpGenerarEnBorrador=EmpresaCfg2.CXPDTotalizarRedondeo
EmpresaCfg2.CXPDTotalizarRedondeo=EmpresaCfg2.CxpPagarEnLoteEvaluacion
EmpresaCfg2.CxpPagarEnLoteEvaluacion=EmpresaCfg2.CXPReferenciaEnAnticiposCP
EmpresaCfg2.CXPReferenciaEnAnticiposCP=EmpresaCfg2.CXPValidarFechaAplicacion
EmpresaCfg2.CXPValidarFechaAplicacion=(Fin)

[Cxp2.EmpresaCfg2.CXPDTotalizarRedondeo]
Carpeta=Cxp2
Clave=EmpresaCfg2.CXPDTotalizarRedondeo
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco











































[VentasMostrador.ListaEnCaptura]
(Inicio)=EmpresaCfg.VentaLiquidaIntegral
EmpresaCfg.VentaLiquidaIntegral=EmpresaCfg.VentaLiquidaIntegralCxc
EmpresaCfg.VentaLiquidaIntegralCxc=EmpresaCfg.NotasBorrador
EmpresaCfg.NotasBorrador=EmpresaCfg.VentaSugerirSaldoFavorID
EmpresaCfg.VentaSugerirSaldoFavorID=EmpresaCfg.ClienteFacturaVMOS
EmpresaCfg.ClienteFacturaVMOS=EmpresaCfg.EstatusFacturaVMOS
EmpresaCfg.EstatusFacturaVMOS=EmpresaCfg.AsignarConsecutivoFacturaVMOS
EmpresaCfg.AsignarConsecutivoFacturaVMOS=EmpresaCfg.GenerarNCAlProcesar
EmpresaCfg.GenerarNCAlProcesar=EmpresaCfg.FormaPagoEfectivo
EmpresaCfg.FormaPagoEfectivo=EmpresaCfg.NConsumoSugerir
EmpresaCfg.NConsumoSugerir=EmpresaCfg.NConsumoArtDeducible
EmpresaCfg.NConsumoArtDeducible=EmpresaCfg.NConsumoArtCoAseguro
EmpresaCfg.NConsumoArtCoAseguro=EmpresaCfg.NConsumoArtAjusteCobertura
EmpresaCfg.NConsumoArtAjusteCobertura=EmpresaCfg.MoverNotasAuto
EmpresaCfg.MoverNotasAuto=EmpresaCfg.FacturaGlobalPeriodo
EmpresaCfg.FacturaGlobalPeriodo=(Fin)

[VentasMostrador.EmpresaCfg.FacturaGlobalPeriodo]
Carpeta=VentasMostrador
Clave=EmpresaCfg.FacturaGlobalPeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[WMS.EmpresaCfg.WMSReacomodoSurtido]
Carpeta=WMS
Clave=EmpresaCfg.WMSReacomodoSurtido
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=32



[Inv.ListaEnCaptura]
(Inicio)=EmpresaCfg.FormaCosteo
EmpresaCfg.FormaCosteo=EmpresaCfg.MonedaCosteo
EmpresaCfg.MonedaCosteo=EmpresaCfg.TipoCosteo
EmpresaCfg.TipoCosteo=EmpresaCfg.SugerirCostoDev
EmpresaCfg.SugerirCostoDev=EmpresaCfg.SugerirCostoArtServicio
EmpresaCfg.SugerirCostoArtServicio=EmpresaCfg.MonedaCosteoNivelArticulo
EmpresaCfg.MonedaCosteoNivelArticulo=EmpresaCfg.CosteoNivelSubCuenta
EmpresaCfg.CosteoNivelSubCuenta=EmpresaCfg.InvEntradasSinCosto
EmpresaCfg.InvEntradasSinCosto=EmpresaCfg.CompraVentaSinIVA
EmpresaCfg.CompraVentaSinIVA=EmpresaCfg.ToleranciaTipoCosto
EmpresaCfg.ToleranciaTipoCosto=EmpresaCfg.ToleranciaCosto
EmpresaCfg.ToleranciaCosto=EmpresaCfg.ToleranciaCostoInferior
EmpresaCfg.ToleranciaCostoInferior=EmpresaCfg.CosteoActividades
EmpresaCfg.CosteoActividades=EmpresaCfg.CosteoMultipleSimultaneo
EmpresaCfg.CosteoMultipleSimultaneo=EmpresaCfg.SeriesLotesMayoreo
EmpresaCfg.SeriesLotesMayoreo=EmpresaCfg.CosteoSeries
EmpresaCfg.CosteoSeries=EmpresaCfg.CosteoLotes
EmpresaCfg.CosteoLotes=EmpresaCfg.Partidas
EmpresaCfg.Partidas=EmpresaCfg.SeriesLotesAutoOrden
EmpresaCfg.SeriesLotesAutoOrden=EmpresaCfg.SeriesImprimirMov
EmpresaCfg.SeriesImprimirMov=EmpresaCfg.SeriesImprimirProp
EmpresaCfg.SeriesImprimirProp=EmpresaCfg.CB
EmpresaCfg.CB=EmpresaCfg.CBPreguntarCantidad
EmpresaCfg.CBPreguntarCantidad=EmpresaCfg.CBProcesarLote
EmpresaCfg.CBProcesarLote=EmpresaCfg.CBSerieLote
EmpresaCfg.CBSerieLote=EmpresaCfg.CBDirAlmacen
EmpresaCfg.CBDirAlmacen=EmpresaCfg.InvConfirmarSolicitudes
EmpresaCfg.InvConfirmarSolicitudes=EmpresaCfg.InvVerClaveIdioma
EmpresaCfg.InvVerClaveIdioma=EmpresaCfg.Posiciones
EmpresaCfg.Posiciones=EmpresaCfg.ExistenciaAlterna
EmpresaCfg.ExistenciaAlterna=EmpresaCfg.ExistenciaAlternaSerieLote
EmpresaCfg.ExistenciaAlternaSerieLote=EmpresaCfg.TransferirDemas
EmpresaCfg.TransferirDemas=EmpresaCfg.InvPaquetes
EmpresaCfg.InvPaquetes=EmpresaCfg.ArtRevision
EmpresaCfg.ArtRevision=EmpresaCfg.ArtFormato
EmpresaCfg.ArtFormato=EmpresaCfg.InvFisicoConteo
EmpresaCfg.InvFisicoConteo=EmpresaCfg.BackOrders
EmpresaCfg.BackOrders=EmpresaCfg.BackOrdersNivel
EmpresaCfg.BackOrdersNivel=EmpresaCfg.AjustesAutomaticosMES
EmpresaCfg.AjustesAutomaticosMES=EmpresaCfg.ToleranciaAjuste
EmpresaCfg.ToleranciaAjuste=EmpresaCfg.ReservarSolicitudesFacory
EmpresaCfg.ReservarSolicitudesFacory=(Fin)

[Inv.EmpresaCfg.ToleranciaAjuste]
Carpeta=Inv
Clave=EmpresaCfg.ToleranciaAjuste
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfg.ReservarSolicitudesFacory]
Carpeta=Inv
Clave=EmpresaCfg.ReservarSolicitudesFacory
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco





[ContParalela]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contabilidad Paralela
Clave=ContParalela
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfg2
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


CondicionVisible=fnContParalela y(General.ContabilidadParalela)
[ContParalela.EmpresaCfg2.CONTPConcluirPaquete]
Carpeta=ContParalela
Clave=EmpresaCfg2.CONTPConcluirPaquete
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco








EspacioPrevio=S
[ContParalela.EmpresaCfg2.CONTPMaximoDiasPaquete]
Carpeta=ContParalela
Clave=EmpresaCfg2.CONTPMaximoDiasPaquete
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco










[ContParalela.EmpresaCfg2.CONTPConcluirPolizas]
Carpeta=ContParalela
Clave=EmpresaCfg2.CONTPConcluirPolizas
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=S
















[ContParalela.EmpresaCfg2.CONTPEnLinea]
Carpeta=ContParalela
Clave=EmpresaCfg2.CONTPEnLinea
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=55
ColorFondo=Blanco









[ContParalela.ListaEnCaptura]
(Inicio)=EmpresaCfg2.CONTPEnLinea
EmpresaCfg2.CONTPEnLinea=EmpresaCfg2.CONTPConcluirPaquete
EmpresaCfg2.CONTPConcluirPaquete=EmpresaCfg2.CONTPMaximoDiasPaquete
EmpresaCfg2.CONTPMaximoDiasPaquete=EmpresaCfg2.CONTPConcluirPolizas
EmpresaCfg2.CONTPConcluirPolizas=(Fin)












[RH.ListaEnCaptura]
(Inicio)=EmpresaCfg.RHControlPlazas
EmpresaCfg.RHControlPlazas=EmpresaCfg.RHAutorizarPlazas
EmpresaCfg.RHAutorizarPlazas=EmpresaCfg.PersonalFormato
EmpresaCfg.PersonalFormato=EmpresaCfg.RHValidarAF
EmpresaCfg.RHValidarAF=EmpresaCfg.NomCCRequerido
EmpresaCfg.NomCCRequerido=(Fin)














[Nomina.ListaEnCaptura]
(Inicio)=EmpresaCfg.NomOmision
EmpresaCfg.NomOmision=EmpresaCfg.NomOmisionPeriodo
EmpresaCfg.NomOmisionPeriodo=EmpresaCfg.NomDiasMes
EmpresaCfg.NomDiasMes=EmpresaCfg.NomDiasDesfasoIncidencias
EmpresaCfg.NomDiasDesfasoIncidencias=EmpresaCfg.NomBeneficiario
EmpresaCfg.NomBeneficiario=EmpresaCfg.NomSugerirAumentoVacaciones
EmpresaCfg.NomSugerirAumentoVacaciones=EmpresaCfg.NomSugerirDisminuirVacaciones
EmpresaCfg.NomSugerirDisminuirVacaciones=EmpresaCfg.NomAfectarAumentoVacaciones
EmpresaCfg.NomAfectarAumentoVacaciones=EmpresaCfg.NomAfectarDisminuirVacaciones
EmpresaCfg.NomAfectarDisminuirVacaciones=EmpresaCfg.NomConceptoAumentoVacaciones
EmpresaCfg.NomConceptoAumentoVacaciones=EmpresaCfg.NomConceptoDisminuirVacaciones
EmpresaCfg.NomConceptoDisminuirVacaciones=EmpresaCfg.TablaVacaciones
EmpresaCfg.TablaVacaciones=EmpresaCfg.NomSugerirSDI
EmpresaCfg.NomSugerirSDI=EmpresaCfg.NomConceptoSDI
EmpresaCfg.NomConceptoSDI=EmpresaCfg.NomModificarFechaNomina
EmpresaCfg.NomModificarFechaNomina=EmpresaCfg.NomValidarReferencias
EmpresaCfg.NomValidarReferencias=(Fin)
















[Ofertas.EmpresaCfg2.OfertaAplicaLog]
Carpeta=Ofertas
Clave=EmpresaCfg2.OfertaAplicaLog
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco





Tamano=30















[Ofertas.EmpresaCfg2.OfertaAplicaLogPOS]
Carpeta=Ofertas
Clave=EmpresaCfg2.OfertaAplicaLogPOS
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco







[Ofertas.EmpresaCfg2.OfertaPorPartidaPOS]
Carpeta=Ofertas
Clave=EmpresaCfg2.OfertaPorPartidaPOS
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco



[Ofertas.ListaEnCaptura]
(Inicio)=EmpresaCfg2.OfertaFechaHora
EmpresaCfg2.OfertaFechaHora=EmpresaCfg2.OfertaModificarTipo
EmpresaCfg2.OfertaModificarTipo=EmpresaCfg2.OfertaNivelOpcion
EmpresaCfg2.OfertaNivelOpcion=EmpresaCfg2.OfertaAplicaLog
EmpresaCfg2.OfertaAplicaLog=EmpresaCfg2.OfertaAplicaLogPOS
EmpresaCfg2.OfertaAplicaLogPOS=EmpresaCfg2.OfertaPorPartidaPOS
EmpresaCfg2.OfertaPorPartidaPOS=(Fin)






[Asiste.EmpresaCfg.HorasExtrasCompletas]
Carpeta=Asiste
Clave=EmpresaCfg.HorasExtrasCompletas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco












[Proyectos.EmpresaCfg.ProyEnviarTareaGestion]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyEnviarTareaGestion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Proyectos.EmpresaCfg.ProyTareaEstado]
Carpeta=Proyectos
Clave=EmpresaCfg.ProyTareaEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Proyectos.ListaEnCaptura]
(Inicio)=EmpresaCfg.ProyFasesInformativas
EmpresaCfg.ProyFasesInformativas=EmpresaCfg.ProyAsunto
EmpresaCfg.ProyAsunto=EmpresaCfg.ProyFechaRevision
EmpresaCfg.ProyFechaRevision=EmpresaCfg.ProyDiasIndicador1
EmpresaCfg.ProyDiasIndicador1=EmpresaCfg.ProyIndicador1Liberados
EmpresaCfg.ProyIndicador1Liberados=EmpresaCfg.ProyGenerarInvAlAfectar
EmpresaCfg.ProyGenerarInvAlAfectar=EmpresaCfg.ProyGenerarInvPorActividad
EmpresaCfg.ProyGenerarInvPorActividad=EmpresaCfg.ProyGenerarInvTiempo
EmpresaCfg.ProyGenerarInvTiempo=EmpresaCfg.ProyGenerarInvTiempoUnidad
EmpresaCfg.ProyGenerarInvTiempoUnidad=EmpresaCfg.ProyEnviarTareaGestion
EmpresaCfg.ProyEnviarTareaGestion=EmpresaCfg.ProyTareaEstado
EmpresaCfg.ProyTareaEstado=(Fin)








[Asiste.EmpresaCfg.HerramientaHorasExtra]
Carpeta=Asiste
Clave=EmpresaCfg.HerramientaHorasExtra
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Compras.EmpresaCfg.CompraCostearDCporMovimiento]
Carpeta=Compras
Clave=EmpresaCfg.CompraCostearDCporMovimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco

[WMS.EmpresaCfg.WMSPCKUbicacion]
Carpeta=WMS
Clave=EmpresaCfg.WMSPCKUbicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WMS.EmpresaCfg.WMSPorcentajeMinimoADom]
Carpeta=WMS
Clave=EmpresaCfg.WMSPorcentajeMinimoADom
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WMS.EmpresaCfg.DesentarimarPedido]
Carpeta=WMS
Clave=EmpresaCfg.DesentarimarPedido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[WMS.ListaEnCaptura]
(Inicio)=EmpresaCfg.WMSSugerirEntarimado
EmpresaCfg.WMSSugerirEntarimado=EmpresaCfg.WMSLeerPosicionOrigen
EmpresaCfg.WMSLeerPosicionOrigen=EmpresaCfg.WMSDispararReacomodos
EmpresaCfg.WMSDispararReacomodos=EmpresaCfg.WMSRotacionArticulo
EmpresaCfg.WMSRotacionArticulo=EmpresaCfg.WMSAndenSurtidoContacto
EmpresaCfg.WMSAndenSurtidoContacto=EmpresaCfg.WMSMovilTarea
EmpresaCfg.WMSMovilTarea=EmpresaCfg.WMSTipoAcomodador
EmpresaCfg.WMSTipoAcomodador=EmpresaCfg.WMSValidarZona
EmpresaCfg.WMSValidarZona=EmpresaCfg.WMSReacomodoSurtido
EmpresaCfg.WMSReacomodoSurtido=EmpresaCfg.WMSPermitirReacomodosDomicilio
EmpresaCfg.WMSPermitirReacomodosDomicilio=EmpresaCfg.WMSPCKUbicacion
EmpresaCfg.WMSPCKUbicacion=EmpresaCfg.WMSPorcentajeMinimoADom
EmpresaCfg.WMSPorcentajeMinimoADom=EmpresaCfg.DesentarimarPedido
EmpresaCfg.DesentarimarPedido=(Fin)






[Asiste.EmpresaCfg.AsistDescansolaborado]
Carpeta=Asiste
Clave=EmpresaCfg.AsistDescansolaborado
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30
[Asiste.EmpresaCfg.AsistDiaFestivolaborado]
Carpeta=Asiste
Clave=EmpresaCfg.AsistDiaFestivolaborado
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30
[Asiste.EmpresaCfg.AsistDomingoLaborado]
Carpeta=Asiste
Clave=EmpresaCfg.AsistDomingoLaborado
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30


[Asiste.ListaEnCaptura]
(Inicio)=EmpresaCfg.AsisteToleraEntrada
EmpresaCfg.AsisteToleraEntrada=EmpresaCfg.AsisteToleraSalida
EmpresaCfg.AsisteToleraSalida=EmpresaCfg.PersonalCostoHoraFactor
EmpresaCfg.PersonalCostoHoraFactor=EmpresaCfg.AsisteGenerarFaltas
EmpresaCfg.AsisteGenerarFaltas=EmpresaCfg.AsisteGenerarRetardos
EmpresaCfg.AsisteGenerarRetardos=EmpresaCfg.AsisteGenerarHorasExtras
EmpresaCfg.AsisteGenerarHorasExtras=EmpresaCfg.AsistDescansolaborado
EmpresaCfg.AsistDescansolaborado=EmpresaCfg.AsistDiaFestivolaborado
EmpresaCfg.AsistDiaFestivolaborado=EmpresaCfg.AsistDomingoLaborado
EmpresaCfg.AsistDomingoLaborado=EmpresaCfg.HorasExtrasCompletas
EmpresaCfg.HorasExtrasCompletas=EmpresaCfg.HerramientaHorasExtra
EmpresaCfg.HerramientaHorasExtra=EmpresaCfg.AsisteJornadasNocturnas
EmpresaCfg.AsisteJornadasNocturnas=(Fin)
















[MES.ListaEnCaptura]
(Inicio)=EmpresaCfg.IntelMESInterfase
EmpresaCfg.IntelMESInterfase=EmpresaCfg.IntelMESInterfaseRuta
EmpresaCfg.IntelMESInterfaseRuta=(Fin)







[Retenciones.ListaEnCaptura]
(Inicio)=EmpresaCfg2.RetencionAlPago
EmpresaCfg2.RetencionAlPago=EmpresaCfg2.RetencionAlPagoMovImpuesto
EmpresaCfg2.RetencionAlPagoMovImpuesto=EmpresaCfg2.GastoRetencionAcreedor
EmpresaCfg2.GastoRetencionAcreedor=Prov.Nombre
Prov.Nombre=EmpresaCfg2.GastoRetencionConcepto
EmpresaCfg2.GastoRetencionConcepto=EmpresaCfg2.GastoRetencion2Acreedor
EmpresaCfg2.GastoRetencion2Acreedor=ProvDestino.Nombre
ProvDestino.Nombre=EmpresaCfg2.GastoRetencion2Concepto
EmpresaCfg2.GastoRetencion2Concepto=EmpresaCfg2.GastoRetencion3Acreedor
EmpresaCfg2.GastoRetencion3Acreedor=EmpresaCfg2.GastoRetencion3Concepto
EmpresaCfg2.GastoRetencion3Concepto=EmpresaCfg2.AgruparConceptoSATRetenciones
EmpresaCfg2.AgruparConceptoSATRetenciones=(Fin)

[Retenciones.EmpresaCfg2.AgruparConceptoSATRetenciones]
Carpeta=Retenciones
Clave=EmpresaCfg2.AgruparConceptoSATRetenciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Ventas2.EmpresaCfg2.VentaMonederoA]
Carpeta=Ventas2
Clave=EmpresaCfg2.VentaMonederoA
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco



Tamano=22











[Ventas2.ListaEnCaptura]
(Inicio)=EmpresaCfg2.FacturaCobroIntegrado
EmpresaCfg2.FacturaCobroIntegrado=EmpresaCfg2.FacturaCobroIntegradoParcial
EmpresaCfg2.FacturaCobroIntegradoParcial=EmpresaCfg2.VentaSubMovimientos
EmpresaCfg2.VentaSubMovimientos=EmpresaCfg2.VentaAnexarMov
EmpresaCfg2.VentaAnexarMov=EmpresaCfg2.VentaAnexarOrdenes
EmpresaCfg2.VentaAnexarOrdenes=EmpresaCfg2.VentaDevSinAntecedente
EmpresaCfg2.VentaDevSinAntecedente=EmpresaCfg2.VentaDevSeriesSinAntecedente
EmpresaCfg2.VentaDevSeriesSinAntecedente=EmpresaCfg2.FacturasPendientesSerieLote
EmpresaCfg2.FacturasPendientesSerieLote=EmpresaCfg2.VentaPresupuestosPendientes
EmpresaCfg2.VentaPresupuestosPendientes=EmpresaCfg2.VentaRestringida
EmpresaCfg2.VentaRestringida=EmpresaCfg2.VentaAutoBloqueo
EmpresaCfg2.VentaAutoBloqueo=EmpresaCfg2.AutoAsignarBackOrders
EmpresaCfg2.AutoAsignarBackOrders=EmpresaCfg2.VentaArtAlmacenEspecifico
EmpresaCfg2.VentaArtAlmacenEspecifico=EmpresaCfg2.VentaDevConsecutivoIndep
EmpresaCfg2.VentaDevConsecutivoIndep=EmpresaCfg2.VentaBonifConsecutivoIndep
EmpresaCfg2.VentaBonifConsecutivoIndep=EmpresaCfg2.CodigoCliente
EmpresaCfg2.CodigoCliente=EmpresaCfg2.VentaBonificacionAuto
EmpresaCfg2.VentaBonificacionAuto=EmpresaCfg2.VentaSolicitarPrecios
EmpresaCfg2.VentaSolicitarPrecios=EmpresaCfg2.VentaLimiteNivelSucursal
EmpresaCfg2.VentaLimiteNivelSucursal=EmpresaCfg2.MargenNivelListaPrecios
EmpresaCfg2.MargenNivelListaPrecios=EmpresaCfg2.FacturarSustitutos
EmpresaCfg2.FacturarSustitutos=EmpresaCfg2.FacturarSustitutosOpciones
EmpresaCfg2.FacturarSustitutosOpciones=EmpresaCfg2.FacturarSustitutosPrecios
EmpresaCfg2.FacturarSustitutosPrecios=EmpresaCfg2.AutoAutorizacionFacturas
EmpresaCfg2.AutoAutorizacionFacturas=EmpresaCfg2.VentaRenCompletosFactRapida
EmpresaCfg2.VentaRenCompletosFactRapida=EmpresaCfg2.VentaValidarFechaRequerida
EmpresaCfg2.VentaValidarFechaRequerida=EmpresaCfg2.VentaDevAutoAplicar
EmpresaCfg2.VentaDevAutoAplicar=EmpresaCfg2.VentaVerImpuesto1
EmpresaCfg2.VentaVerImpuesto1=EmpresaCfg2.VentaVerImpuesto2
EmpresaCfg2.VentaVerImpuesto2=EmpresaCfg2.VentaVerImpuesto3
EmpresaCfg2.VentaVerImpuesto3=EmpresaCfg2.VentaVerRetencion1
EmpresaCfg2.VentaVerRetencion1=EmpresaCfg2.VentaVerRetencion2
EmpresaCfg2.VentaVerRetencion2=EmpresaCfg2.VentaVerRetencion3
EmpresaCfg2.VentaVerRetencion3=EmpresaCfg2.VentaVerCosto
EmpresaCfg2.VentaVerCosto=EmpresaCfg2.VentaDMultiAgente
EmpresaCfg2.VentaDMultiAgente=EmpresaCfg2.VentaDMultiAgenteSugerir
EmpresaCfg2.VentaDMultiAgenteSugerir=EmpresaCfg2.VentaMultiAlmacen
EmpresaCfg2.VentaMultiAlmacen=EmpresaCfg2.VentaMultiAgente
EmpresaCfg2.VentaMultiAgente=EmpresaCfg2.VentaUENDetalle
EmpresaCfg2.VentaUENDetalle=EmpresaCfg2.VentaDescuentoImporte
EmpresaCfg2.VentaDescuentoImporte=EmpresaCfg2.VentaEspacioDetalle
EmpresaCfg2.VentaEspacioDetalle=EmpresaCfg2.VentaEspacioCantidadMetros
EmpresaCfg2.VentaEspacioCantidadMetros=EmpresaCfg2.VentaInstrucciones
EmpresaCfg2.VentaInstrucciones=EmpresaCfg2.VentaDFechaRequerida
EmpresaCfg2.VentaDFechaRequerida=EmpresaCfg2.VentaDHoraRequerida
EmpresaCfg2.VentaDHoraRequerida=EmpresaCfg2.VentaExcluirPlaneacionDetalle
EmpresaCfg2.VentaExcluirPlaneacionDetalle=EmpresaCfg2.VentaAFDetalle
EmpresaCfg2.VentaAFDetalle=EmpresaCfg2.VentaEnviarADetalle
EmpresaCfg2.VentaEnviarADetalle=EmpresaCfg2.VentaABC
EmpresaCfg2.VentaABC=EmpresaCfg2.VentaMonedero
EmpresaCfg2.VentaMonedero=EmpresaCfg2.VentaMonederoA
EmpresaCfg2.VentaMonederoA=EmpresaCfg2.VentaPuntosEnVales
EmpresaCfg2.VentaPuntosEnVales=EmpresaCfg2.VentaPuntosArtCat
EmpresaCfg2.VentaPuntosArtCat=EmpresaCfg2.VentaArtEstatus
EmpresaCfg2.VentaArtEstatus=EmpresaCfg2.VentaArtSituacion
EmpresaCfg2.VentaArtSituacion=EmpresaCfg2.VentaCteArtEmpaqueCorrugado
EmpresaCfg2.VentaCteArtEmpaqueCorrugado=EmpresaCfg2.VentaVerPesoVolumen
EmpresaCfg2.VentaVerPesoVolumen=EmpresaCfg2.BloquearFacturaOtraSucursal
EmpresaCfg2.BloquearFacturaOtraSucursal=EmpresaCfg2.VTASValidarFechaAplicacion
EmpresaCfg2.VTASValidarFechaAplicacion=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Inv
Inv=Inv2
Inv2=WMS
WMS=Plan
Plan=Prod
Prod=MultiUnidades
MultiUnidades=ReglaNegocio
ReglaNegocio=Ventas
Ventas=VentasMostrador
VentasMostrador=Ventas2
Ventas2=Servicios
Servicios=Compras
Compras=Compra2
Compra2=Importacion
Importacion=Cxc
Cxc=Cxc2
Cxc2=Cxp
Cxp=Cxp2
Cxp2=Dinero
Dinero=Dinero2
Dinero2=Gastos
Gastos=Gastos2
Gastos2=Embarques
Embarques=ActivosF
ActivosF=Agent
Agent=Nomina
Nomina=RH
RH=Asiste
Asiste=Cont
Cont=Cont2
Cont2=Conciliaciones
Conciliaciones=Multimonedas
Multimonedas=Cambios
Cambios=Fiscal
Fiscal=Tablas
Tablas=Retenciones
Retenciones=Espacios
Espacios=Auto
Auto=PC
PC=Ofertas
Ofertas=CR
CR=AC
AC=Proyectos
Proyectos=Gestion
Gestion=Organizacion
Organizacion=Peru
Peru=CP
CP=MAF
MAF=Guatemala
Guatemala=SAUX
SAUX=MES
MES=Oportunidades
Oportunidades=ContParalela
ContParalela=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cuentas
Cuentas=Historico
Historico=EmpresaFecha
EmpresaFecha=PedidosReservarEsp
PedidosReservarEsp=ValidarFechaAplicacion
ValidarFechaAplicacion=(Fin)
