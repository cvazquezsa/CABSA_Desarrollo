[Forma]
Clave=EmpresaCfgMov
Nombre=<T>Movimientos por Omisión - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Inv
PosicionInicialIzquierda=291
PosicionInicialArriba=22
PosicionInicialAltura=588
PosicionInicialAncho=783
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Empresa
VentanaExclusiva=S
CarpetasMultilinea=S
AutoGuardar=S
PosicionInicialAlturaCliente=644

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=Si
NombreDesplegar=&Guardar y cerrar
GuardarAntes=Si
EnBarraHerramientas=Si
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=Si
Visible=Si

[Inv]
Estilo=Ficha
Clave=Inv
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=4
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

FiltroGeneral=EmpresaCfgMov.Empresa={Comillas(Info.Empresa)}
[Movimientos.EmpresaCfgMov.ReciboPrestamo]
Carpeta=Movimientos
Clave=EmpresaCfgMov.ReciboPrestamo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Movimientos.EmpresaCfgMov.CambioPresentacion]
Carpeta=Movimientos
Clave=EmpresaCfgMov.CambioPresentacion
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
Vista=EmpresaCfgMov
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

FiltroGeneral=EmpresaCfgMov.Empresa=<T>{Info.Empresa}<T>
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

[Cxc]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cuentas por cobrar
Clave=Cxc
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Cxp]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cuentas por pagar
Clave=Cxp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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
Vista=EmpresaCfgMov
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

[Default.EmpresaCfg.DefImpuesto]
Carpeta=Default
Clave=EmpresaCfg.DefImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Default.EmpresaCfg.DefUnidad]
Carpeta=Default
Clave=EmpresaCfg.DefUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Compras.EmpresaCfgMov.CompraRequisicion]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraRequisicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraCotizacion]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraCotizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraOrden]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Compras.EmpresaCfgMov.CompraEntrada]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraEntrada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Compras.EmpresaCfgMov.CompraConsignacion]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraConsignacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraDevConsignacion]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraDevConsignacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcFactura]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcFactura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcNCredito]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcNCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Cxp.EmpresaCfgMov.CxpFactura]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpFactura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcCobro]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcCobro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Cxp.EmpresaCfgMov.CxpPago]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Cxc.EmpresaCfgMov.CxcCobroDirecto]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcCobroDirecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpPagoDirecto]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpPagoDirecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraDev]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraDev
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ventas.EmpresaCfgMov.VentaPedido]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaPedido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Ventas.EmpresaCfgMov.VentaFactura]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaFactura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Ventas.EmpresaCfgMov.VentaDev]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaDev
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas.EmpresaCfgMov.VentaConsignacion]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaConsignacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Ventas.EmpresaCfgMov.VentaDevConsignacion]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaDevConsignacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvAjuste]
Carpeta=Inv
Clave=EmpresaCfgMov.InvAjuste
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Inv.EmpresaCfgMov.InvReciboPrestamo]
Carpeta=Inv
Clave=EmpresaCfgMov.InvReciboPrestamo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvCambioPresentacion]
Carpeta=Inv
Clave=EmpresaCfgMov.InvCambioPresentacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Caja.EmpresaCfgMov.CajaIngreso]
Carpeta=Caja
Clave=EmpresaCfgMov.CajaIngreso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Caja.EmpresaCfgMov.CajaEgreso]
Carpeta=Caja
Clave=EmpresaCfgMov.CajaEgreso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

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
Vista=EmpresaCfgMov
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

[Gastos.EmpresaCfgMov.Gasto]
Carpeta=Gastos
Clave=EmpresaCfgMov.Gasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoAnticipo]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoAnticipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoDevolucionAnticipo]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoDevolucionAnticipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoSolicitud]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoSolicitud
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaFacturaNota]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaFacturaNota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Acciones.MovGenera]
Nombre=MovGenera
Boton=30
NombreEnBoton=S
NombreDesplegar=&Excepciones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgMovGenera
Activo=S
Visible=S
EspacioPrevio=S

[Dinero]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Tesorería
Clave=Dinero
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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

[Dinero.EmpresaCfgMov.BancoDeposito]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoDeposito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoDepositoElectronico]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoDepositoElectronico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoCheque]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoCheque
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Dinero.EmpresaCfgMov.BancoChequeElectronico]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoChequeElectronico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoDepositoEnFalso]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoDepositoEnFalso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoChequeDevuelto]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoChequeDevuelto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.CajaIngreso]
Carpeta=Dinero
Clave=EmpresaCfgMov.CajaIngreso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.CajaEgreso]
Carpeta=Dinero
Clave=EmpresaCfgMov.CajaEgreso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas.EmpresaCfgMov.VentaSalidaGarantia]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaSalidaGarantia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcNCreditoProntoPago]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcNCreditoProntoPago
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcNCargo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcNCargo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcDocumento]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcDocumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpDocumento]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpDocumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Cont]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contabilidad
Clave=Cont
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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

[Cont.EmpresaCfgMov.ContCierre]
Carpeta=Cont
Clave=EmpresaCfgMov.ContCierre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaRemision]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaRemision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Ventas.EmpresaCfgMov.VentaDevRemision]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaDevRemision
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Embarques.EmpresaCfgMov.EmbarqueLiquidacion]
Carpeta=Embarques
Clave=EmpresaCfgMov.EmbarqueLiquidacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Embarques.EmpresaCfgMov.EmbarqueDesembarque]
Carpeta=Embarques
Clave=EmpresaCfgMov.EmbarqueDesembarque
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpNomina]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpNomina
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaCotizacion]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaCotizacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Asistencia]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Asistencias
Clave=Asistencia
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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

[Asistencia.EmpresaCfgMov.AsisteAsistencia]
Carpeta=Asistencia
Clave=EmpresaCfgMov.AsisteAsistencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Asistencia.EmpresaCfgMov.AsisteCorte]
Carpeta=Asistencia
Clave=EmpresaCfgMov.AsisteCorte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvSalidaDiversa]
Carpeta=Inv
Clave=EmpresaCfgMov.InvSalidaDiversa
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Inv.EmpresaCfgMov.InvPrestamo]
Carpeta=Inv
Clave=EmpresaCfgMov.InvPrestamo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Inv.EmpresaCfgMov.InvTransferencia]
Carpeta=Inv
Clave=EmpresaCfgMov.InvTransferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Inv.EmpresaCfgMov.InvTransferenciaConsig]
Carpeta=Inv
Clave=EmpresaCfgMov.InvTransferenciaConsig
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Compras.EmpresaCfgMov.CompraIntercambio]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraIntercambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraDevGarantia]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraDevGarantia
Editar=S
LineaNueva=N
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
Vista=EmpresaCfgMov
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

[Agent.EmpresaCfgMov.AgentPago]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Agent.EmpresaCfgMov.AgentPagoNomina]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentPagoNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agent.EmpresaCfgMov.AgentComision]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agent.EmpresaCfgMov.AgentDestajo]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentDestajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agent.EmpresaCfgMov.AgentDevolucion]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentDevolucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraEntradaGastos]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraEntradaGastos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpGastoDiverso]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpGastoDiverso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcCobroPosfechado]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcCobroPosfechado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpPagoPosfechado]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpPagoPosfechado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaEntregaGarantia]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaEntregaGarantia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Compras.EmpresaCfgMov.CompraBonificacion]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraBonificacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=EmpresaCfgMov
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

[Prod.EmpresaCfgMov.ProdOrdenProduccion]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdOrdenProduccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prod.EmpresaCfgMov.ProdEntradaProduccion]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdEntradaProduccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Prod.EmpresaCfgMov.ProdAvance]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdAvance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Prod.EmpresaCfgMov.ProdAvanceCxp]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdAvanceCxp
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prod.EmpresaCfgMov.ProdRetroceso]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdRetroceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prod.EmpresaCfgMov.ProdRetrocesoCxp]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdRetrocesoCxp
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=EmpresaCfgMov
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

[Embarques.EmpresaCfgMov.EmbarqueCxp]
Carpeta=Embarques
Clave=EmpresaCfgMov.EmbarqueCxp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prod.EmpresaCfgMov.ProdConsumoMaterial]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdConsumoMaterial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaCancelacionFactura]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaCancelacionFactura
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoSolicitudDeposito]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoSolicitudDeposito
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoSolicitudCheque]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoSolicitudCheque
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N
EspacioPrevio=S

[Prod.EmpresaCfgMov.ProdOrdenTransferencia]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdOrdenTransferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaPerdida]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaPerdida
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S

[Gastos.EmpresaCfgMov.GastoComprobante]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Agent.EmpresaCfgMov.AgentBonificacion]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentBonificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfgMov.BancoCargoBancario]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoCargoBancario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoAbonoBancario]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoAbonoBancario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxp.EmpresaCfgMov.CxpRetencion]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpRetencion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Inv.EmpresaCfgMov.InvSalidaTraspaso]
Carpeta=Inv
Clave=EmpresaCfgMov.InvSalidaTraspaso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvReciboTraspaso]
Carpeta=Inv
Clave=EmpresaCfgMov.InvReciboTraspaso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N

[Inv.EmpresaCfgMov.InvTransito]
Carpeta=Inv
Clave=EmpresaCfgMov.InvTransito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvTransitoFaltante]
Carpeta=Inv
Clave=EmpresaCfgMov.InvTransitoFaltante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.CajaFaltanteCaja]
Carpeta=Dinero
Clave=EmpresaCfgMov.CajaFaltanteCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Agent.EmpresaCfgMov.AgentFaltanteCaja]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentFaltanteCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvOrdenTransferencia]
Carpeta=Inv
Clave=EmpresaCfgMov.InvOrdenTransferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvOrdenTraspaso]
Carpeta=Inv
Clave=EmpresaCfgMov.InvOrdenTraspaso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcReasignacionAnticipo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcReasignacionAnticipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpReasignacionAnticipo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpReasignacionAnticipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcAnticipo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAnticipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Cxp.EmpresaCfgMov.CxpAnticipo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpAnticipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Cxc.EmpresaCfgMov.CxcVentaVales]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcVentaVales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Cxc.EmpresaCfgMov.CxcAplicacionVales]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAplicacionVales
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Cxc.EmpresaCfgMov.CxcDevolucionVales]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcDevolucionVales
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Ventas.EmpresaCfgMov.VentaNota]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaNota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcObsequioVales]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcObsequioVales
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcContrarecibo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcContrarecibo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcNCargoRecargos]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcNCargoRecargos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvTransitoSobrante]
Carpeta=Inv
Clave=EmpresaCfgMov.InvTransitoSobrante
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoTransferencia]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoTransferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcAjusteRedondeo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAjusteRedondeo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpAjusteRedondeo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpAjusteRedondeo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraEntradaImportacion]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraEntradaImportacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaSolicitudDevolucion]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaSolicitudDevolucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Embarques.EmpresaCfgMov.EmbarqueGastoTarifas]
Carpeta=Embarques
Clave=EmpresaCfgMov.EmbarqueGastoTarifas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RH]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Recursos Humanos
Clave=RH
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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
PermiteEditar=S

[RH.EmpresaCfgMov.RHAltas]
Carpeta=RH
Clave=EmpresaCfgMov.RHAltas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RH.EmpresaCfgMov.RHModificaciones]
Carpeta=RH
Clave=EmpresaCfgMov.RHModificaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RH.EmpresaCfgMov.RHBajas]
Carpeta=RH
Clave=EmpresaCfgMov.RHBajas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Nómina
Clave=Nomina
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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

[Nomina.EmpresaCfgMov.NomAumentoVacaciones]
Carpeta=Nomina
Clave=EmpresaCfgMov.NomAumentoVacaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Nomina.EmpresaCfgMov.NomVacacionesTomadas]
Carpeta=Nomina
Clave=EmpresaCfgMov.NomVacacionesTomadas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcAnticipoSaldo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAnticipoSaldo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpAnticipoSaldo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpAnticipoSaldo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcDevolucion]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcDevolucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcDevolucionSaldo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcDevolucionSaldo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpDevolucion]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpDevolucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpDevolucionSaldo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpDevolucionSaldo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpAplicacion]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpAplicacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcAplicacion]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAplicacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpCargoProveedor]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpCargoProveedor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpCreditoProveedor]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpCreditoProveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpRecargos]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpRecargos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpProntoPago]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpProntoPago
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcDocumentoAnticipo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcDocumentoAnticipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpDocumentoAnticipo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpDocumentoAnticipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.ComprobanteProrrateado]
Carpeta=Gastos
Clave=EmpresaCfgMov.ComprobanteProrrateado
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoProrrateado]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoProrrateado
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Cxp.EmpresaCfgMov.CxpContraRecibo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpContraRecibo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prod.EmpresaCfgMov.ProdCancelacionOrden]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdCancelacionOrden
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpPagare]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpPagare
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpAforo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpAforo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpFactoraje]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpFactoraje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoDev]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoDev
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Gastos.EmpresaCfgMov.GastoDevProrrateada]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoDevProrrateada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpDevRetencion]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpDevRetencion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.CxpGastoDev]
Carpeta=Gastos
Clave=EmpresaCfgMov.CxpGastoDev
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.CxpGastoDevProrrateada]
Carpeta=Gastos
Clave=EmpresaCfgMov.CxpGastoDevProrrateada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaNotaDev]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaNotaDev
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas.EmpresaCfgMov.VentaOrdenSurtido]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaOrdenSurtido
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcAjuste]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAjuste
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpAjuste]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpAjuste
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraLocal]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraLocal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prod.EmpresaCfgMov.ProdOrdenConsumo]
Carpeta=Prod
Clave=EmpresaCfgMov.ProdOrdenConsumo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcConversionCredito]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcConversionCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcConversionCargo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcConversionCargo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpConversionCredito]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpConversionCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpConversionCargo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpConversionCargo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.EmpresaCfgMov.NomCancelacionParcial]
Carpeta=Nomina
Clave=EmpresaCfgMov.NomCancelacionParcial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpCancelacionNomina]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpCancelacionNomina
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraPerdida]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraPerdida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Compras.EmpresaCfgMov.CompraRechazada]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraRechazada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcAnticipoFactura]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAnticipoFactura
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpAnticipoFactura]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpAnticipoFactura
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpImportacion]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpImportacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=EmpresaCfgMov
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

[Auto.EmpresaCfgMov.AutoRecaudacion]
Carpeta=Auto
Clave=EmpresaCfgMov.AutoRecaudacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Auto.EmpresaCfgMov.AutoPapeleta]
Carpeta=Auto
Clave=EmpresaCfgMov.AutoPapeleta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfgMov.AutoMantenimiento]
Carpeta=Auto
Clave=EmpresaCfgMov.AutoMantenimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfgMov.AutoGasto]
Carpeta=Auto
Clave=EmpresaCfgMov.AutoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfgMov.AutoNomina]
Carpeta=Auto
Clave=EmpresaCfgMov.AutoNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcAplicacionSaldo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAplicacionSaldo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoSinComprobante]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoSinComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpCartaCredito]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpCartaCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcFacturaSeguro]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcFacturaSeguro
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaNotaConsumo]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaNotaConsumo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas.EmpresaCfgMov.VentaReservacion]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaReservacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas.EmpresaCfgMov.VentaIngreso]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaIngreso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Compras.EmpresaCfgMov.CompraLicitacion]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraLicitacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvReciboPrevio]
Carpeta=Inv
Clave=EmpresaCfgMov.InvReciboPrevio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxp.EmpresaCfgMov.CxpForwardCompra]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpForwardCompra
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpForwardPorPagar]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpForwardPorPagar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcForwardVenta]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcForwardVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcForwardPorCobrar]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcForwardPorCobrar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AlmacenDef]
Nombre=AlmacenDef
Boton=30
NombreEnBoton=S
NombreDesplegar=&Almacenes por Omisión
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgMovAlmacenDef
Activo=S
Visible=S

[Auto.EmpresaCfgMov.AutoMantenimientoPreventivo]
Carpeta=Auto
Clave=EmpresaCfgMov.AutoMantenimientoPreventivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoCajaChica]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoCajaChica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvValeSalida]
Carpeta=Inv
Clave=EmpresaCfgMov.InvValeSalida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvValeDevolucion]
Carpeta=Inv
Clave=EmpresaCfgMov.InvValeDevolucion
Editar=S
LineaNueva=N
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
Vista=EmpresaCfgMov
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

[PC.EmpresaCfgMov.PCPrecios]
Carpeta=PC
Clave=EmpresaCfgMov.PCPrecios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PC.EmpresaCfgMov.PCCostos]
Carpeta=PC
Clave=EmpresaCfgMov.PCCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PC.EmpresaCfgMov.PCBoletin]
Carpeta=PC
Clave=EmpresaCfgMov.PCBoletin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoDepreciacion]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoDepreciacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfgMov.CajaCorteCaja]
Carpeta=Dinero
Clave=EmpresaCfgMov.CajaCorteCaja
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcEndoso]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcEndoso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpEndoso]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpEndoso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.EmpresaCfgMov.NomIncapacidades]
Carpeta=Nomina
Clave=EmpresaCfgMov.NomIncapacidades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvDevTransito]
Carpeta=Inv
Clave=EmpresaCfgMov.InvDevTransito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Nomina.EmpresaCfgMov.NomFaltas]
Carpeta=Nomina
Clave=EmpresaCfgMov.NomFaltas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvReevaluacion]
Carpeta=Inv
Clave=EmpresaCfgMov.InvReevaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Agent.EmpresaCfgMov.AgentCobro]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentCobro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoAnticipoSinComprobar]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoAnticipoSinComprobar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfgMov.CajaApertura]
Carpeta=Dinero
Clave=EmpresaCfgMov.CajaApertura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.CajaRecoleccion]
Carpeta=Dinero
Clave=EmpresaCfgMov.CajaRecoleccion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.CajaSobranteCaja]
Carpeta=Dinero
Clave=EmpresaCfgMov.CajaSobranteCaja
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CR]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cajas Registradoras
Clave=CR
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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
CondicionVisible=General.CR

[Cxc.EmpresaCfgMov.CxcReevaluacion]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcReevaluacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpReevaluacion]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpReevaluacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfgMov.CajaTransferencia]
Carpeta=Dinero
Clave=EmpresaCfgMov.CajaTransferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Dinero.EmpresaCfgMov.CajaFondoInicial]
Carpeta=Dinero
Clave=EmpresaCfgMov.CajaFondoInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[CR.EmpresaCfgMov.CRCorteCaja]
Carpeta=CR
Clave=EmpresaCfgMov.CRCorteCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfgMov.CRCorteCajaCentral]
Carpeta=CR
Clave=EmpresaCfgMov.CRCorteCajaCentral
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcFaltanteCaja]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcFaltanteCaja
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.EmpresaCfgMov.AutoCancelacionRecaudacion]
Carpeta=Auto
Clave=EmpresaCfgMov.AutoCancelacionRecaudacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agent.EmpresaCfgMov.AgentPagoGastos]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentPagoGastos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoOtrosIngresos]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoOtrosIngresos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Acciones.Recurrentes]
Nombre=Recurrentes
Boton=95
NombreEnBoton=S
NombreDesplegar=Flujo &Recurrentes
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgMovRecurrente
Activo=S
Visible=S

[Acciones.Contratos]
Nombre=Contratos
Boton=95
NombreEnBoton=S
NombreDesplegar=Flujo &Contratos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgMovContrato
Activo=S
Visible=S

[Inv.EmpresaCfgMov.InvSolicitud]
Carpeta=Inv
Clave=EmpresaCfgMov.InvSolicitud
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.DineroReevaluacion]
Carpeta=Dinero
Clave=EmpresaCfgMov.DineroReevaluacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Dinero.EmpresaCfgMov.BancoCargoBancarioIVA]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoCargoBancarioIVA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Compras.EmpresaCfgMov.CompraControlCalidad]
Carpeta=Compras
Clave=EmpresaCfgMov.CompraControlCalidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcCancelacionNomina]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcCancelacionNomina
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcNomina]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcNomina
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoSolicitudRechazada]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoSolicitudRechazada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaPedidoAuto]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaPedidoAuto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ventas.EmpresaCfgMov.VentaConsumo]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaConsumo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcNeteo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcNeteo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpNeteo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpNeteo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcEndosoAFavor]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcEndosoAFavor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpEndosoAFavor]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpEndosoAFavor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaNotaResumen]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaNotaResumen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.EmpresaCfgMov.GastoTCredito]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoTCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cont.EmpresaCfgMov.ContDiario]
Carpeta=Cont
Clave=EmpresaCfgMov.ContDiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.Servicio]
Carpeta=Ventas
Clave=EmpresaCfgMov.Servicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcReevaluacionCredito]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcReevaluacionCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpReevaluacionCredito]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpReevaluacionCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfgMov.DineroRedondeo]
Carpeta=Dinero
Clave=EmpresaCfgMov.DineroRedondeo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcAjusteSaldo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAjusteSaldo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpAjusteSaldo]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpAjusteSaldo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaContrato]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaContrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.DineroInversion]
Carpeta=Dinero
Clave=EmpresaCfgMov.DineroInversion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.DineroRetiroInversion]
Carpeta=Dinero
Clave=EmpresaCfgMov.DineroRetiroInversion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Agent.EmpresaCfgMov.AgentBono]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentBono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaFacturaGasto]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaFacturaGasto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.EmpresaCfgMov.GastoPresupuesto]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaPresupuesto]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcIntereses]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcIntereses
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Cxc.EmpresaCfgMov.CxcIntentoCobro]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcIntentoCobro
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpIntereses]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpIntereses
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcAmortizacion]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.EmpresaCfgMov.CxpAmortizacion]
Carpeta=Cxp
Clave=EmpresaCfgMov.CxpAmortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvSolicitudCancelada]
Carpeta=Inv
Clave=EmpresaCfgMov.InvSolicitudCancelada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S

[Cxc.EmpresaCfgMov.CxcInteresesVencidos]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcInteresesVencidos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cont.EmpresaCfgMov.ContEliminacion]
Carpeta=Cont
Clave=EmpresaCfgMov.ContEliminacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvFisico]
Carpeta=Inv
Clave=EmpresaCfgMov.InvFisico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxc.EmpresaCfgMov.CxcNCreditoVoucher]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcNCreditoVoucher
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxc.EmpresaCfgMov.CxcNCargoVoucher]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcNCargoVoucher
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfgMov.CRNota]
Carpeta=CR
Clave=EmpresaCfgMov.CRNota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfgMov.CRFactura]
Carpeta=CR
Clave=EmpresaCfgMov.CRFactura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agent.EmpresaCfgMov.AgentAjusteInv]
Carpeta=Agent
Clave=EmpresaCfgMov.AgentAjusteInv
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Administración Créditos
Clave=AC
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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
CondicionVisible=General.AC

[AC.EmpresaCfgMov.ACReinversionCxc]
Carpeta=AC
Clave=EmpresaCfgMov.ACReinversionCxc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfgMov.ACReinversionCxp]
Carpeta=AC
Clave=EmpresaCfgMov.ACReinversionCxp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RH.EmpresaCfgMov.RHIncremento]
Carpeta=RH
Clave=EmpresaCfgMov.RHIncremento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfgMov.ACMHIntereses]
Carpeta=AC
Clave=EmpresaCfgMov.ACMHIntereses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfgMov.ACMHInteresesBonificacion]
Carpeta=AC
Clave=EmpresaCfgMov.ACMHInteresesBonificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfgMov.ACMHInteresesDocumento]
Carpeta=AC
Clave=EmpresaCfgMov.ACMHInteresesDocumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PC.EmpresaCfgMov.PCCancelacionPrecios]
Carpeta=PC
Clave=EmpresaCfgMov.PCCancelacionPrecios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoProvision]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoProvision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[AF]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Activos Fijos
Clave=AF
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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

[AF.EmpresaCfgMov.AFDepreciacion]
Carpeta=AF
Clave=EmpresaCfgMov.AFDepreciacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AF.EmpresaCfgMov.AFRevaluacion]
Carpeta=AF
Clave=EmpresaCfgMov.AFRevaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaDevolucionFaltante]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaDevolucionFaltante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvAjusteSaldosMenores]
Carpeta=Inv
Clave=EmpresaCfgMov.InvAjusteSaldosMenores
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Nomina.EmpresaCfgMov.CxcAplicacionNomina]
Carpeta=Nomina
Clave=EmpresaCfgMov.CxcAplicacionNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfgMov.ACAjusteValorResidual]
Carpeta=AC
Clave=EmpresaCfgMov.ACAjusteValorResidual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfgMov.ACAjusteImpuestoAd]
Carpeta=AC
Clave=EmpresaCfgMov.ACAjusteImpuestoAd
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CR.EmpresaCfgMov.CRPrestamoCxc]
Carpeta=CR
Clave=EmpresaCfgMov.CRPrestamoCxc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfgMov.BancoAbonoBancarioIVA]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoAbonoBancarioIVA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[AC.EmpresaCfgMov.ACBajaParcial]
Carpeta=AC
Clave=EmpresaCfgMov.ACBajaParcial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvEstadisticaAjusteMerma]
Carpeta=Inv
Clave=EmpresaCfgMov.InvEstadisticaAjusteMerma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoChequeTraspaso]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoChequeTraspaso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.EmpresaCfgMov.CxpGastoAnticipo]
Carpeta=Gastos
Clave=EmpresaCfgMov.CxpGastoAnticipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Gastos.EmpresaCfgMov.CxpGastoDevAnticipo]
Carpeta=Gastos
Clave=EmpresaCfgMov.CxpGastoDevAnticipo
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Cxc.EmpresaCfgMov.CxcAplicacionNCargo]
Carpeta=Cxc
Clave=EmpresaCfgMov.CxcAplicacionNCargo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Act]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Actividades
Clave=Act
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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
CondicionVisible=Falso

[Act.EmpresaCfgMov.ActActividad]
Carpeta=Act
Clave=EmpresaCfgMov.ActActividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Act.EmpresaCfgMov.ActAvance]
Carpeta=Act
Clave=EmpresaCfgMov.ActAvance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Act.EmpresaCfgMov.ActConclusion]
Carpeta=Act
Clave=EmpresaCfgMov.ActConclusion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Act.EmpresaCfgMov.ActCancelacion]
Carpeta=Act
Clave=EmpresaCfgMov.ActCancelacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Act.EmpresaCfgMov.ActModificacion]
Carpeta=Act
Clave=EmpresaCfgMov.ActModificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Act.EmpresaCfgMov.ActAtraso]
Carpeta=Act
Clave=EmpresaCfgMov.ActAtraso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfgMov.ACDisposicionCxp]
Carpeta=AC
Clave=EmpresaCfgMov.ACDisposicionCxp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfgMov.BancoDepositoAnticipado]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoDepositoAnticipado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.EmpresaCfgMov.GastoCargoBancario]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoCargoBancario
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Gastos.EmpresaCfgMov.GastoAbonoBancario]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoAbonoBancario
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Credito]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Crédito
Clave=Credito
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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

[Credito.EmpresaCfgMov.CreditoDocumentoCxc]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoDocumentoCxc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfgMov.CreditoPrestamoCxc]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoPrestamoCxc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfgMov.CreditoComisiones]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoComisiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfgMov.CreditoDocumentoCxp]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoDocumentoCxp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfgMov.CreditoPrestamoCxp]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoPrestamoCxp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Dinero.EmpresaCfgMov.BancoIntereses]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoIntereses
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.DineroReevaluacionTitulo]
Carpeta=Dinero
Clave=EmpresaCfgMov.DineroReevaluacionTitulo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Credito.EmpresaCfgMov.CreditoDisposicion]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoDisposicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfgMov.CreditoFondeo]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoFondeo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfgMov.CreditoBackToBack]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoBackToBack
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfgMov.CreditoDepositoAnticipado]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoDepositoAnticipado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Credito.EmpresaCfgMov.CreditoFondeoAnticipado]
Carpeta=Credito
Clave=EmpresaCfgMov.CreditoFondeoAnticipado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Proy]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Proyectos
Clave=Proy
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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
[Proy.EmpresaCfgMov.ProyProyecto]
Carpeta=Proy
Clave=EmpresaCfgMov.ProyProyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Proy.EmpresaCfgMov.ProyMitigacion]
Carpeta=Proy
Clave=EmpresaCfgMov.ProyMitigacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvEntradaDiversa]
Carpeta=Inv
Clave=EmpresaCfgMov.InvEntradaDiversa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Cont.EmpresaCfgMov.ContPresupuesto]
Carpeta=Cont
Clave=EmpresaCfgMov.ContPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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
Vista=EmpresaCfgMov
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
CondicionVisible=General.Fiscal

[Acciones.Amortizacion]
Nombre=Amortizacion
Boton=30
NombreEnBoton=S
NombreDesplegar=A&mortizaciones Especificas
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgMovAmortizacion
Visible=S
ActivoCondicion=General.AC

[Fiscal.EmpresaCfgMov.FiscalEmisionAcumulable]
Carpeta=Fiscal
Clave=EmpresaCfgMov.FiscalEmisionAcumulable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.EmpresaCfgMov.FiscalEndosoAcumulable]
Carpeta=Fiscal
Clave=EmpresaCfgMov.FiscalEndosoAcumulable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.EmpresaCfgMov.FiscalFlujoAcumulable]
Carpeta=Fiscal
Clave=EmpresaCfgMov.FiscalFlujoAcumulable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.EmpresaCfgMov.FiscalEmisionDeducible]
Carpeta=Fiscal
Clave=EmpresaCfgMov.FiscalEmisionDeducible
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Fiscal.EmpresaCfgMov.FiscalEndosoDeducible]
Carpeta=Fiscal
Clave=EmpresaCfgMov.FiscalEndosoDeducible
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.EmpresaCfgMov.FiscalFlujoDeducible]
Carpeta=Fiscal
Clave=EmpresaCfgMov.FiscalFlujoDeducible
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.EmpresaCfgMov.FiscalDeclaracion]
Carpeta=Fiscal
Clave=EmpresaCfgMov.FiscalDeclaracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.EmpresaCfgMov.FiscalComplementaria]
Carpeta=Fiscal
Clave=EmpresaCfgMov.FiscalComplementaria
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.EmpresaCfgMov.CxpImpuestosPorPagar]
Carpeta=Fiscal
Clave=EmpresaCfgMov.CxpImpuestosPorPagar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Fiscal.EmpresaCfgMov.CxpImpuestosFavor]
Carpeta=Fiscal
Clave=EmpresaCfgMov.CxpImpuestosFavor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.EmpresaCfgMov.ACGasto]
Carpeta=AC
Clave=EmpresaCfgMov.ACGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Inv.EmpresaCfgMov.InvOrdenEntarimado]
Carpeta=Inv
Clave=EmpresaCfgMov.InvOrdenEntarimado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvEntarimado]
Carpeta=Inv
Clave=EmpresaCfgMov.InvEntarimado
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Gastos.EmpresaCfgMov.GastoConsumo]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoConsumo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Inv.EmpresaCfgMov.InvSolicitudRechazada]
Carpeta=Inv
Clave=EmpresaCfgMov.InvSolicitudRechazada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Inv.EmpresaCfgMov.InvConsumo]
Carpeta=Inv
Clave=EmpresaCfgMov.InvConsumo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Gastos.EmpresaCfgMov.GastoCargoBancarioIVA]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoCargoBancarioIVA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.EmpresaCfgMov.GastoAbonoBancarioIVA]
Carpeta=Gastos
Clave=EmpresaCfgMov.GastoAbonoBancarioIVA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.EmpresaCfgMov.VentaOportunidad]
Carpeta=Ventas
Clave=EmpresaCfgMov.VentaOportunidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero.EmpresaCfgMov.BancoCargoNoIdentificado]
Carpeta=Dinero
Clave=EmpresaCfgMov.BancoCargoNoIdentificado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Cxc.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.CxcFactura
EmpresaCfgMov.CxcFactura=EmpresaCfgMov.CxcFacturaSeguro
EmpresaCfgMov.CxcFacturaSeguro=EmpresaCfgMov.CxcNCargo
EmpresaCfgMov.CxcNCargo=EmpresaCfgMov.CxcNCargoVoucher
EmpresaCfgMov.CxcNCargoVoucher=EmpresaCfgMov.CxcNCargoRecargos
EmpresaCfgMov.CxcNCargoRecargos=EmpresaCfgMov.CxcDocumento
EmpresaCfgMov.CxcDocumento=EmpresaCfgMov.CxcContrarecibo
EmpresaCfgMov.CxcContrarecibo=EmpresaCfgMov.CxcEndoso
EmpresaCfgMov.CxcEndoso=EmpresaCfgMov.CxcFaltanteCaja
EmpresaCfgMov.CxcFaltanteCaja=EmpresaCfgMov.CxcNCredito
EmpresaCfgMov.CxcNCredito=EmpresaCfgMov.CxcNCreditoVoucher
EmpresaCfgMov.CxcNCreditoVoucher=EmpresaCfgMov.CxcNCreditoProntoPago
EmpresaCfgMov.CxcNCreditoProntoPago=EmpresaCfgMov.CxcAplicacion
EmpresaCfgMov.CxcAplicacion=EmpresaCfgMov.CxcAplicacionSaldo
EmpresaCfgMov.CxcAplicacionSaldo=EmpresaCfgMov.CxcDevolucion
EmpresaCfgMov.CxcDevolucion=EmpresaCfgMov.CxcDevolucionSaldo
EmpresaCfgMov.CxcDevolucionSaldo=EmpresaCfgMov.CxcEndosoAFavor
EmpresaCfgMov.CxcEndosoAFavor=EmpresaCfgMov.CxcCancelacionNomina
EmpresaCfgMov.CxcCancelacionNomina=EmpresaCfgMov.CxcAplicacionNCargo
EmpresaCfgMov.CxcAplicacionNCargo=EmpresaCfgMov.CxcAnticipo
EmpresaCfgMov.CxcAnticipo=EmpresaCfgMov.CxcAnticipoSaldo
EmpresaCfgMov.CxcAnticipoSaldo=EmpresaCfgMov.CxcAnticipoFactura
EmpresaCfgMov.CxcAnticipoFactura=EmpresaCfgMov.CxcAjusteSaldo
EmpresaCfgMov.CxcAjusteSaldo=EmpresaCfgMov.CxcReasignacionAnticipo
EmpresaCfgMov.CxcReasignacionAnticipo=EmpresaCfgMov.CxcDocumentoAnticipo
EmpresaCfgMov.CxcDocumentoAnticipo=EmpresaCfgMov.CxcReevaluacionCredito
EmpresaCfgMov.CxcReevaluacionCredito=EmpresaCfgMov.CxcCobro
EmpresaCfgMov.CxcCobro=EmpresaCfgMov.CxcIntentoCobro
EmpresaCfgMov.CxcIntentoCobro=EmpresaCfgMov.CxcCobroPosfechado
EmpresaCfgMov.CxcCobroPosfechado=EmpresaCfgMov.CxcCobroDirecto
EmpresaCfgMov.CxcCobroDirecto=EmpresaCfgMov.CxcNomina
EmpresaCfgMov.CxcNomina=EmpresaCfgMov.CxcVentaVales
EmpresaCfgMov.CxcVentaVales=EmpresaCfgMov.CxcObsequioVales
EmpresaCfgMov.CxcObsequioVales=EmpresaCfgMov.CxcAplicacionVales
EmpresaCfgMov.CxcAplicacionVales=EmpresaCfgMov.CxcDevolucionVales
EmpresaCfgMov.CxcDevolucionVales=EmpresaCfgMov.CxcAjuste
EmpresaCfgMov.CxcAjuste=EmpresaCfgMov.CxcConversionCredito
EmpresaCfgMov.CxcConversionCredito=EmpresaCfgMov.CxcAjusteRedondeo
EmpresaCfgMov.CxcAjusteRedondeo=EmpresaCfgMov.CxcConversionCargo
EmpresaCfgMov.CxcConversionCargo=EmpresaCfgMov.CxcForwardVenta
EmpresaCfgMov.CxcForwardVenta=EmpresaCfgMov.CxcForwardPorCobrar
EmpresaCfgMov.CxcForwardPorCobrar=EmpresaCfgMov.CxcReevaluacion
EmpresaCfgMov.CxcReevaluacion=EmpresaCfgMov.CxcNeteo
EmpresaCfgMov.CxcNeteo=EmpresaCfgMov.CxcAmortizacion
EmpresaCfgMov.CxcAmortizacion=EmpresaCfgMov.CxcIntereses
EmpresaCfgMov.CxcIntereses=EmpresaCfgMov.CxcInteresesVencidos
EmpresaCfgMov.CxcInteresesVencidos=(Fin)

[Cxp.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.CxpFactura
EmpresaCfgMov.CxpFactura=EmpresaCfgMov.CxpImportacion
EmpresaCfgMov.CxpImportacion=EmpresaCfgMov.CxpCargoProveedor
EmpresaCfgMov.CxpCargoProveedor=EmpresaCfgMov.CxpRecargos
EmpresaCfgMov.CxpRecargos=EmpresaCfgMov.CxpGastoDiverso
EmpresaCfgMov.CxpGastoDiverso=EmpresaCfgMov.CxpNomina
EmpresaCfgMov.CxpNomina=EmpresaCfgMov.CxpEndoso
EmpresaCfgMov.CxpEndoso=EmpresaCfgMov.CxpDocumento
EmpresaCfgMov.CxpDocumento=EmpresaCfgMov.CxpContraRecibo
EmpresaCfgMov.CxpContraRecibo=EmpresaCfgMov.CxpAforo
EmpresaCfgMov.CxpAforo=EmpresaCfgMov.CxpPagare
EmpresaCfgMov.CxpPagare=EmpresaCfgMov.CxpFactoraje
EmpresaCfgMov.CxpFactoraje=EmpresaCfgMov.CxpCartaCredito
EmpresaCfgMov.CxpCartaCredito=EmpresaCfgMov.CxpRetencion
EmpresaCfgMov.CxpRetencion=EmpresaCfgMov.CxpDevRetencion
EmpresaCfgMov.CxpDevRetencion=EmpresaCfgMov.CxpCreditoProveedor
EmpresaCfgMov.CxpCreditoProveedor=EmpresaCfgMov.CxpProntoPago
EmpresaCfgMov.CxpProntoPago=EmpresaCfgMov.CxpAplicacion
EmpresaCfgMov.CxpAplicacion=EmpresaCfgMov.CxpCancelacionNomina
EmpresaCfgMov.CxpCancelacionNomina=EmpresaCfgMov.CxpDevolucion
EmpresaCfgMov.CxpDevolucion=EmpresaCfgMov.CxpDevolucionSaldo
EmpresaCfgMov.CxpDevolucionSaldo=EmpresaCfgMov.CxpEndosoAFavor
EmpresaCfgMov.CxpEndosoAFavor=EmpresaCfgMov.CxpAnticipo
EmpresaCfgMov.CxpAnticipo=EmpresaCfgMov.CxpAnticipoSaldo
EmpresaCfgMov.CxpAnticipoSaldo=EmpresaCfgMov.CxpAnticipoFactura
EmpresaCfgMov.CxpAnticipoFactura=EmpresaCfgMov.CxpAjusteSaldo
EmpresaCfgMov.CxpAjusteSaldo=EmpresaCfgMov.CxpReevaluacion
EmpresaCfgMov.CxpReevaluacion=EmpresaCfgMov.CxpReasignacionAnticipo
EmpresaCfgMov.CxpReasignacionAnticipo=EmpresaCfgMov.CxpDocumentoAnticipo
EmpresaCfgMov.CxpDocumentoAnticipo=EmpresaCfgMov.CxpReevaluacionCredito
EmpresaCfgMov.CxpReevaluacionCredito=EmpresaCfgMov.CxpPago
EmpresaCfgMov.CxpPago=EmpresaCfgMov.CxpPagoPosfechado
EmpresaCfgMov.CxpPagoPosfechado=EmpresaCfgMov.CxpPagoDirecto
EmpresaCfgMov.CxpPagoDirecto=EmpresaCfgMov.CxpForwardCompra
EmpresaCfgMov.CxpForwardCompra=EmpresaCfgMov.CxpForwardPorPagar
EmpresaCfgMov.CxpForwardPorPagar=EmpresaCfgMov.CxpAjuste
EmpresaCfgMov.CxpAjuste=EmpresaCfgMov.CxpConversionCredito
EmpresaCfgMov.CxpConversionCredito=EmpresaCfgMov.CxpAjusteRedondeo
EmpresaCfgMov.CxpAjusteRedondeo=EmpresaCfgMov.CxpConversionCargo
EmpresaCfgMov.CxpConversionCargo=EmpresaCfgMov.CxpNeteo
EmpresaCfgMov.CxpNeteo=EmpresaCfgMov.CxpAmortizacion
EmpresaCfgMov.CxpAmortizacion=EmpresaCfgMov.CxpIntereses
EmpresaCfgMov.CxpIntereses=(Fin)

[Compras.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.CompraRequisicion
EmpresaCfgMov.CompraRequisicion=EmpresaCfgMov.CompraLicitacion
EmpresaCfgMov.CompraLicitacion=EmpresaCfgMov.CompraCotizacion
EmpresaCfgMov.CompraCotizacion=EmpresaCfgMov.CompraOrden
EmpresaCfgMov.CompraOrden=EmpresaCfgMov.CompraControlCalidad
EmpresaCfgMov.CompraControlCalidad=EmpresaCfgMov.CompraPerdida
EmpresaCfgMov.CompraPerdida=EmpresaCfgMov.CompraRechazada
EmpresaCfgMov.CompraRechazada=EmpresaCfgMov.CompraEntrada
EmpresaCfgMov.CompraEntrada=EmpresaCfgMov.CompraLocal
EmpresaCfgMov.CompraLocal=EmpresaCfgMov.CompraEntradaGastos
EmpresaCfgMov.CompraEntradaGastos=EmpresaCfgMov.CompraEntradaImportacion
EmpresaCfgMov.CompraEntradaImportacion=EmpresaCfgMov.CompraDev
EmpresaCfgMov.CompraDev=EmpresaCfgMov.CompraBonificacion
EmpresaCfgMov.CompraBonificacion=EmpresaCfgMov.CompraConsignacion
EmpresaCfgMov.CompraConsignacion=EmpresaCfgMov.CompraDevConsignacion
EmpresaCfgMov.CompraDevConsignacion=EmpresaCfgMov.CompraIntercambio
EmpresaCfgMov.CompraIntercambio=EmpresaCfgMov.CompraDevGarantia
EmpresaCfgMov.CompraDevGarantia=(Fin)

[Gastos.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.GastoSolicitud
EmpresaCfgMov.GastoSolicitud=EmpresaCfgMov.GastoSolicitudRechazada
EmpresaCfgMov.GastoSolicitudRechazada=EmpresaCfgMov.GastoAnticipo
EmpresaCfgMov.GastoAnticipo=EmpresaCfgMov.GastoAnticipoSinComprobar
EmpresaCfgMov.GastoAnticipoSinComprobar=EmpresaCfgMov.GastoDevolucionAnticipo
EmpresaCfgMov.GastoDevolucionAnticipo=EmpresaCfgMov.GastoComprobante
EmpresaCfgMov.GastoComprobante=EmpresaCfgMov.ComprobanteProrrateado
EmpresaCfgMov.ComprobanteProrrateado=EmpresaCfgMov.GastoCajaChica
EmpresaCfgMov.GastoCajaChica=EmpresaCfgMov.GastoSinComprobante
EmpresaCfgMov.GastoSinComprobante=EmpresaCfgMov.Gasto
EmpresaCfgMov.Gasto=EmpresaCfgMov.GastoTCredito
EmpresaCfgMov.GastoTCredito=EmpresaCfgMov.GastoProrrateado
EmpresaCfgMov.GastoProrrateado=EmpresaCfgMov.CxpGastoAnticipo
EmpresaCfgMov.CxpGastoAnticipo=EmpresaCfgMov.CxpGastoDevAnticipo
EmpresaCfgMov.CxpGastoDevAnticipo=EmpresaCfgMov.GastoDev
EmpresaCfgMov.GastoDev=EmpresaCfgMov.GastoDevProrrateada
EmpresaCfgMov.GastoDevProrrateada=EmpresaCfgMov.CxpGastoDev
EmpresaCfgMov.CxpGastoDev=EmpresaCfgMov.CxpGastoDevProrrateada
EmpresaCfgMov.CxpGastoDevProrrateada=EmpresaCfgMov.GastoDepreciacion
EmpresaCfgMov.GastoDepreciacion=EmpresaCfgMov.GastoOtrosIngresos
EmpresaCfgMov.GastoOtrosIngresos=EmpresaCfgMov.GastoCargoBancario
EmpresaCfgMov.GastoCargoBancario=EmpresaCfgMov.GastoCargoBancarioIVA
EmpresaCfgMov.GastoCargoBancarioIVA=EmpresaCfgMov.GastoAbonoBancario
EmpresaCfgMov.GastoAbonoBancario=EmpresaCfgMov.GastoAbonoBancarioIVA
EmpresaCfgMov.GastoAbonoBancarioIVA=EmpresaCfgMov.GastoProvision
EmpresaCfgMov.GastoProvision=EmpresaCfgMov.GastoConsumo
EmpresaCfgMov.GastoConsumo=EmpresaCfgMov.GastoPresupuesto
EmpresaCfgMov.GastoPresupuesto=(Fin)


[Cont.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.ContDiario
EmpresaCfgMov.ContDiario=EmpresaCfgMov.ContPresupuesto
EmpresaCfgMov.ContPresupuesto=EmpresaCfgMov.ContEliminacion
EmpresaCfgMov.ContEliminacion=EmpresaCfgMov.ContCierre
EmpresaCfgMov.ContCierre=(Fin)

[Asistencia.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.AsisteAsistencia
EmpresaCfgMov.AsisteAsistencia=EmpresaCfgMov.AsisteCorte
EmpresaCfgMov.AsisteCorte=(Fin)

[Agent.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.AgentComision
EmpresaCfgMov.AgentComision=EmpresaCfgMov.AgentBono
EmpresaCfgMov.AgentBono=EmpresaCfgMov.AgentDestajo
EmpresaCfgMov.AgentDestajo=EmpresaCfgMov.AgentDevolucion
EmpresaCfgMov.AgentDevolucion=EmpresaCfgMov.AgentBonificacion
EmpresaCfgMov.AgentBonificacion=EmpresaCfgMov.AgentFaltanteCaja
EmpresaCfgMov.AgentFaltanteCaja=EmpresaCfgMov.AgentAjusteInv
EmpresaCfgMov.AgentAjusteInv=EmpresaCfgMov.AgentPago
EmpresaCfgMov.AgentPago=EmpresaCfgMov.AgentPagoNomina
EmpresaCfgMov.AgentPagoNomina=EmpresaCfgMov.AgentPagoGastos
EmpresaCfgMov.AgentPagoGastos=EmpresaCfgMov.AgentCobro
EmpresaCfgMov.AgentCobro=(Fin)

[Prod.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.ProdOrdenProduccion
EmpresaCfgMov.ProdOrdenProduccion=EmpresaCfgMov.ProdCancelacionOrden
EmpresaCfgMov.ProdCancelacionOrden=EmpresaCfgMov.ProdOrdenTransferencia
EmpresaCfgMov.ProdOrdenTransferencia=EmpresaCfgMov.ProdOrdenConsumo
EmpresaCfgMov.ProdOrdenConsumo=EmpresaCfgMov.ProdConsumoMaterial
EmpresaCfgMov.ProdConsumoMaterial=EmpresaCfgMov.ProdAvance
EmpresaCfgMov.ProdAvance=EmpresaCfgMov.ProdAvanceCxp
EmpresaCfgMov.ProdAvanceCxp=EmpresaCfgMov.ProdRetroceso
EmpresaCfgMov.ProdRetroceso=EmpresaCfgMov.ProdRetrocesoCxp
EmpresaCfgMov.ProdRetrocesoCxp=EmpresaCfgMov.ProdEntradaProduccion
EmpresaCfgMov.ProdEntradaProduccion=(Fin)

[Embarques.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.EmbarqueCxp
EmpresaCfgMov.EmbarqueCxp=EmpresaCfgMov.EmbarqueGastoTarifas
EmpresaCfgMov.EmbarqueGastoTarifas=(Fin)

[RH.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.RHAltas
EmpresaCfgMov.RHAltas=EmpresaCfgMov.RHModificaciones
EmpresaCfgMov.RHModificaciones=EmpresaCfgMov.RHBajas
EmpresaCfgMov.RHBajas=EmpresaCfgMov.RHIncremento
EmpresaCfgMov.RHIncremento=(Fin)

[Nomina.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.NomFaltas
EmpresaCfgMov.NomFaltas=EmpresaCfgMov.NomIncapacidades
EmpresaCfgMov.NomIncapacidades=EmpresaCfgMov.NomAumentoVacaciones
EmpresaCfgMov.NomAumentoVacaciones=EmpresaCfgMov.NomVacacionesTomadas
EmpresaCfgMov.NomVacacionesTomadas=EmpresaCfgMov.NomCancelacionParcial
EmpresaCfgMov.NomCancelacionParcial=EmpresaCfgMov.CxcAplicacionNomina
EmpresaCfgMov.CxcAplicacionNomina=(Fin)

[Auto.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.AutoPapeleta
EmpresaCfgMov.AutoPapeleta=EmpresaCfgMov.AutoMantenimiento
EmpresaCfgMov.AutoMantenimiento=EmpresaCfgMov.AutoMantenimientoPreventivo
EmpresaCfgMov.AutoMantenimientoPreventivo=EmpresaCfgMov.AutoRecaudacion
EmpresaCfgMov.AutoRecaudacion=EmpresaCfgMov.AutoCancelacionRecaudacion
EmpresaCfgMov.AutoCancelacionRecaudacion=EmpresaCfgMov.AutoGasto
EmpresaCfgMov.AutoGasto=EmpresaCfgMov.AutoNomina
EmpresaCfgMov.AutoNomina=(Fin)

[PC.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.PCPrecios
EmpresaCfgMov.PCPrecios=EmpresaCfgMov.PCCostos
EmpresaCfgMov.PCCostos=EmpresaCfgMov.PCBoletin
EmpresaCfgMov.PCBoletin=EmpresaCfgMov.PCCancelacionPrecios
EmpresaCfgMov.PCCancelacionPrecios=(Fin)

[CR.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.CRCorteCaja
EmpresaCfgMov.CRCorteCaja=EmpresaCfgMov.CRCorteCajaCentral
EmpresaCfgMov.CRCorteCajaCentral=EmpresaCfgMov.CRNota
EmpresaCfgMov.CRNota=EmpresaCfgMov.CRFactura
EmpresaCfgMov.CRFactura=EmpresaCfgMov.CRPrestamoCxc
EmpresaCfgMov.CRPrestamoCxc=(Fin)

[AC.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.ACReinversionCxc
EmpresaCfgMov.ACReinversionCxc=EmpresaCfgMov.ACReinversionCxp
EmpresaCfgMov.ACReinversionCxp=EmpresaCfgMov.ACGasto
EmpresaCfgMov.ACGasto=EmpresaCfgMov.ACMHIntereses
EmpresaCfgMov.ACMHIntereses=EmpresaCfgMov.ACMHInteresesBonificacion
EmpresaCfgMov.ACMHInteresesBonificacion=EmpresaCfgMov.ACMHInteresesDocumento
EmpresaCfgMov.ACMHInteresesDocumento=EmpresaCfgMov.ACAjusteValorResidual
EmpresaCfgMov.ACAjusteValorResidual=EmpresaCfgMov.ACAjusteImpuestoAd
EmpresaCfgMov.ACAjusteImpuestoAd=EmpresaCfgMov.ACBajaParcial
EmpresaCfgMov.ACBajaParcial=EmpresaCfgMov.ACDisposicionCxp
EmpresaCfgMov.ACDisposicionCxp=(Fin)

[AF.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.AFDepreciacion
EmpresaCfgMov.AFDepreciacion=EmpresaCfgMov.AFRevaluacion
EmpresaCfgMov.AFRevaluacion=(Fin)

[Act.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.ActActividad
EmpresaCfgMov.ActActividad=EmpresaCfgMov.ActAvance
EmpresaCfgMov.ActAvance=EmpresaCfgMov.ActConclusion
EmpresaCfgMov.ActConclusion=EmpresaCfgMov.ActCancelacion
EmpresaCfgMov.ActCancelacion=EmpresaCfgMov.ActModificacion
EmpresaCfgMov.ActModificacion=EmpresaCfgMov.ActAtraso
EmpresaCfgMov.ActAtraso=(Fin)

[Credito.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.CreditoDocumentoCxc
EmpresaCfgMov.CreditoDocumentoCxc=EmpresaCfgMov.CreditoPrestamoCxc
EmpresaCfgMov.CreditoPrestamoCxc=EmpresaCfgMov.CreditoComisiones
EmpresaCfgMov.CreditoComisiones=EmpresaCfgMov.CreditoDocumentoCxp
EmpresaCfgMov.CreditoDocumentoCxp=EmpresaCfgMov.CreditoPrestamoCxp
EmpresaCfgMov.CreditoPrestamoCxp=EmpresaCfgMov.CreditoDisposicion
EmpresaCfgMov.CreditoDisposicion=EmpresaCfgMov.CreditoFondeo
EmpresaCfgMov.CreditoFondeo=EmpresaCfgMov.CreditoBackToBack
EmpresaCfgMov.CreditoBackToBack=EmpresaCfgMov.CreditoDepositoAnticipado
EmpresaCfgMov.CreditoDepositoAnticipado=EmpresaCfgMov.CreditoFondeoAnticipado
EmpresaCfgMov.CreditoFondeoAnticipado=(Fin)


[Fiscal.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.FiscalEmisionAcumulable
EmpresaCfgMov.FiscalEmisionAcumulable=EmpresaCfgMov.FiscalEmisionDeducible
EmpresaCfgMov.FiscalEmisionDeducible=EmpresaCfgMov.FiscalEndosoAcumulable
EmpresaCfgMov.FiscalEndosoAcumulable=EmpresaCfgMov.FiscalEndosoDeducible
EmpresaCfgMov.FiscalEndosoDeducible=EmpresaCfgMov.FiscalFlujoAcumulable
EmpresaCfgMov.FiscalFlujoAcumulable=EmpresaCfgMov.FiscalFlujoDeducible
EmpresaCfgMov.FiscalFlujoDeducible=EmpresaCfgMov.FiscalDeclaracion
EmpresaCfgMov.FiscalDeclaracion=EmpresaCfgMov.FiscalComplementaria
EmpresaCfgMov.FiscalComplementaria=EmpresaCfgMov.CxpImpuestosPorPagar
EmpresaCfgMov.CxpImpuestosPorPagar=EmpresaCfgMov.CxpImpuestosFavor
EmpresaCfgMov.CxpImpuestosFavor=(Fin)









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
Vista=EmpresaCfgMov
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
[CP.EmpresaCfgMov.CPAsignacion]
Carpeta=CP
Clave=EmpresaCfgMov.CPAsignacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CP.EmpresaCfgMov.CPOperacion]
Carpeta=CP
Clave=EmpresaCfgMov.CPOperacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro





[GES]
Estilo=Ficha
Pestana=S
Clave=GES
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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
ListaEnCaptura=EmpresaCfgMov.GESTarea

PestanaOtroNombre=S
PestanaNombre=Gestión

CondicionVisible=General.GES
[GES.EmpresaCfgMov.GESTarea]
Carpeta=GES
Clave=EmpresaCfgMov.GESTarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[GES.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.GESTarea
EmpresaCfgMov.GESTarea=EmpresaCfgMov.MAFSolicitudInspeccion
EmpresaCfgMov.MAFSolicitudInspeccion=(Fin)





[MAF]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mantenimiento AF
Clave=MAF
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMov
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
PermiteEditar=S
ListaEnCaptura=EmpresaCfgMov.MAFSolicitudInspeccion
CondicionVisible=General.MAF

[MAF.EmpresaCfgMov.MAFSolicitudInspeccion]
Carpeta=MAF
Clave=EmpresaCfgMov.MAFSolicitudInspeccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro




[CP.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.CPAsignacion
EmpresaCfgMov.CPAsignacion=EmpresaCfgMov.CPOperacion
EmpresaCfgMov.CPOperacion=EmpresaCfgMov.CPReservadoFlujo
EmpresaCfgMov.CPReservadoFlujo=(Fin)

[CP.EmpresaCfgMov.CPReservadoFlujo]
Carpeta=CP
Clave=EmpresaCfgMov.CPReservadoFlujo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro









[RE]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Reclutamiento y Selección
Clave=RE
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovRecluta
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
ListaEnCaptura=(Lista)
Detalle=S
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovRecluta.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa


[PCP]
Estilo=Ficha
Pestana=S
Clave=PCP
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
PestanaOtroNombre=S
PestanaNombre=Planeación Presupuestal
Detalle=S
PermiteEditar=S
Vista=EmpresaCfgMovPCP
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovPCP.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)

CondicionVisible=General.PCP
[PCP.EmpresaCfgMovPCP.PCPPresupuesto]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PCP.EmpresaCfgMovPCP.PCPEstructura]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPEstructura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[PCP.EmpresaCfgMovPCP.PCPEstructuraAprobada]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPEstructuraAprobada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PCP.EmpresaCfgMovPCP.PCPCatalogo]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPCatalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[PCP.EmpresaCfgMovPCP.PCPEliminacionCatalogo]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPEliminacionCatalogo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PCP.EmpresaCfgMovPCP.PCPModificacionCatalogo]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPModificacionCatalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PCP.EmpresaCfgMovPCP.PCPClavePresupuestal]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPClavePresupuestal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[PCP.EmpresaCfgMovPCP.PCPRegla]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPRegla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[PCP.EmpresaCfgMovPCP.PCPEliminacionRegla]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPEliminacionRegla
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PCP.EmpresaCfgMovPCP.PCPEliminacionClave]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPEliminacionClave
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CP2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Control Presupuestal (2)
Clave=CP2
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovCP
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovCP.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=EmpresaCfgMovCP.CPAnteproyecto
PermiteEditar=S
CondicionVisible=General.CP

[CP2.EmpresaCfgMovCP.CPAnteproyecto]
Carpeta=CP2
Clave=EmpresaCfgMovCP.CPAnteproyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Ventas2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ventas (2)
Clave=Ventas2
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovVenta
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovVenta.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
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
[Ventas2.EmpresaCfgMovVenta.VentaBonificacion]
Carpeta=Ventas2
Clave=EmpresaCfgMovVenta.VentaBonificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[Ventas2.EmpresaCfgMovVenta.VentaEstadistica]
Carpeta=Ventas2
Clave=EmpresaCfgMovVenta.VentaEstadistica
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







[Ventas2.ListaEnCaptura]
(Inicio)=EmpresaCfgMovVenta.VentaBonificacion
EmpresaCfgMovVenta.VentaBonificacion=EmpresaCfgMovVenta.VentaEstadistica
EmpresaCfgMovVenta.VentaEstadistica=EmpresaCfgMovVenta.VentaPedidoEstadistico
EmpresaCfgMovVenta.VentaPedidoEstadistico=(Fin)

[Ventas2.EmpresaCfgMovVenta.VentaPedidoEstadistico]
Carpeta=Ventas2
Clave=EmpresaCfgMovVenta.VentaPedidoEstadistico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[RE.ListaEnCaptura]
(Inicio)=EmpresaCfgMovRecluta.REAutorizacionPlaza
EmpresaCfgMovRecluta.REAutorizacionPlaza=EmpresaCfgMovRecluta.REEntrevista
EmpresaCfgMovRecluta.REEntrevista=EmpresaCfgMovRecluta.REContratacion
EmpresaCfgMovRecluta.REContratacion=EmpresaCfgMovRecluta.RERechazoRequisicion
EmpresaCfgMovRecluta.RERechazoRequisicion=EmpresaCfgMovRecluta.RESolicitudEvaluacion
EmpresaCfgMovRecluta.RESolicitudEvaluacion=EmpresaCfgMovRecluta.REEvaluacion
EmpresaCfgMovRecluta.REEvaluacion=(Fin)

[RE.EmpresaCfgMovRecluta.REAutorizacionPlaza]
Carpeta=RE
Clave=EmpresaCfgMovRecluta.REAutorizacionPlaza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RE.EmpresaCfgMovRecluta.REEntrevista]
Carpeta=RE
Clave=EmpresaCfgMovRecluta.REEntrevista
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RE.EmpresaCfgMovRecluta.REContratacion]
Carpeta=RE
Clave=EmpresaCfgMovRecluta.REContratacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RE.EmpresaCfgMovRecluta.RERechazoRequisicion]
Carpeta=RE
Clave=EmpresaCfgMovRecluta.RERechazoRequisicion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RE.EmpresaCfgMovRecluta.RESolicitudEvaluacion]
Carpeta=RE
Clave=EmpresaCfgMovRecluta.RESolicitudEvaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RE.EmpresaCfgMovRecluta.REEvaluacion]
Carpeta=RE
Clave=EmpresaCfgMovRecluta.REEvaluacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[PCP.ListaEnCaptura]
(Inicio)=EmpresaCfgMovPCP.PCPPresupuesto
EmpresaCfgMovPCP.PCPPresupuesto=EmpresaCfgMovPCP.PCPEstructura
EmpresaCfgMovPCP.PCPEstructura=EmpresaCfgMovPCP.PCPEstructuraAprobada
EmpresaCfgMovPCP.PCPEstructuraAprobada=EmpresaCfgMovPCP.PCPCatalogo
EmpresaCfgMovPCP.PCPCatalogo=EmpresaCfgMovPCP.PCPEliminacionCatalogo
EmpresaCfgMovPCP.PCPEliminacionCatalogo=EmpresaCfgMovPCP.PCPModificacionCatalogo
EmpresaCfgMovPCP.PCPModificacionCatalogo=EmpresaCfgMovPCP.PCPClavePresupuestal
EmpresaCfgMovPCP.PCPClavePresupuestal=EmpresaCfgMovPCP.PCPEliminacionClave
EmpresaCfgMovPCP.PCPEliminacionClave=EmpresaCfgMovPCP.PCPRegla
EmpresaCfgMovPCP.PCPRegla=EmpresaCfgMovPCP.PCPEliminacionRegla
EmpresaCfgMovPCP.PCPEliminacionRegla=EmpresaCfgMovPCP.PCPConcluirPresupuesto
EmpresaCfgMovPCP.PCPConcluirPresupuesto=(Fin)

[PCP.EmpresaCfgMovPCP.PCPConcluirPresupuesto]
Carpeta=PCP
Clave=EmpresaCfgMovPCP.PCPConcluirPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Inv.EmpresaCfgMov.InvConsumoMaterial]
Carpeta=Inv
Clave=EmpresaCfgMov.InvConsumoMaterial
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Compras2]
Estilo=Ficha
Pestana=S
Clave=Compras2
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovCompra
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovCompra.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
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
PestanaOtroNombre=S
PestanaNombre=Compras (2)

[Compras2.EmpresaCfgMovCompra.COMSEntradaConsignacion]
Carpeta=Compras2
Clave=EmpresaCfgMovCompra.COMSEntradaConsignacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxp2]
Estilo=Ficha
Pestana=S
Clave=Cxp2
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovCxp
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovCxp.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
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
PestanaOtroNombre=S
PestanaNombre=Cuentas por pagar (2)

[Cxp2.EmpresaCfgMovCxp.CXPEntradaConsignacion]
Carpeta=Cxp2
Clave=EmpresaCfgMovCxp.CXPEntradaConsignacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
Vista=EmpresaCfgMov
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

CondicionVisible=General.SAUX
[SAUX.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.SAUXServicio
EmpresaCfgMov.SAUXServicio=EmpresaCfgMov.SAUXSolicitudServicio
EmpresaCfgMov.SAUXSolicitudServicio=(Fin)

[SAUX.EmpresaCfgMov.SAUXServicio]
Carpeta=SAUX
Clave=EmpresaCfgMov.SAUXServicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SAUX.EmpresaCfgMov.SAUXSolicitudServicio]
Carpeta=SAUX
Clave=EmpresaCfgMov.SAUXSolicitudServicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Cxp2.EmpresaCfgMovCxp.CXPCorteConsignacion]
Carpeta=Cxp2
Clave=EmpresaCfgMovCxp.CXPCorteConsignacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[GES2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gestión (2)
Clave=GES2
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovGes
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovGES.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=EmpresaCfgMovGES.Notificacion

PermiteEditar=S
CondicionVisible=General.GES
[GES2.EmpresaCfgMovGES.Notificacion]
Carpeta=GES2
Clave=EmpresaCfgMovGES.Notificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[Dinero.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.BancoDeposito
EmpresaCfgMov.BancoDeposito=EmpresaCfgMov.BancoSolicitudDeposito
EmpresaCfgMov.BancoSolicitudDeposito=EmpresaCfgMov.BancoDepositoElectronico
EmpresaCfgMov.BancoDepositoElectronico=EmpresaCfgMov.BancoDepositoEnFalso
EmpresaCfgMov.BancoDepositoEnFalso=EmpresaCfgMov.BancoDepositoAnticipado
EmpresaCfgMov.BancoDepositoAnticipado=EmpresaCfgMov.BancoCargoNoIdentificado
EmpresaCfgMov.BancoCargoNoIdentificado=EmpresaCfgMov.BancoCheque
EmpresaCfgMov.BancoCheque=EmpresaCfgMov.BancoSolicitudCheque
EmpresaCfgMov.BancoSolicitudCheque=EmpresaCfgMov.BancoChequeTraspaso
EmpresaCfgMov.BancoChequeTraspaso=EmpresaCfgMov.BancoChequeElectronico
EmpresaCfgMov.BancoChequeElectronico=EmpresaCfgMov.BancoChequeDevuelto
EmpresaCfgMov.BancoChequeDevuelto=EmpresaCfgMov.BancoCargoBancario
EmpresaCfgMov.BancoCargoBancario=EmpresaCfgMov.BancoCargoBancarioIVA
EmpresaCfgMov.BancoCargoBancarioIVA=EmpresaCfgMov.BancoAbonoBancario
EmpresaCfgMov.BancoAbonoBancario=EmpresaCfgMov.BancoAbonoBancarioIVA
EmpresaCfgMov.BancoAbonoBancarioIVA=EmpresaCfgMov.BancoTransferencia
EmpresaCfgMov.BancoTransferencia=EmpresaCfgMov.CajaApertura
EmpresaCfgMov.CajaApertura=EmpresaCfgMov.CajaCorteCaja
EmpresaCfgMov.CajaCorteCaja=EmpresaCfgMov.CajaIngreso
EmpresaCfgMov.CajaIngreso=EmpresaCfgMov.CajaEgreso
EmpresaCfgMov.CajaEgreso=EmpresaCfgMov.CajaFaltanteCaja
EmpresaCfgMov.CajaFaltanteCaja=EmpresaCfgMov.CajaSobranteCaja
EmpresaCfgMov.CajaSobranteCaja=EmpresaCfgMov.CajaFondoInicial
EmpresaCfgMov.CajaFondoInicial=EmpresaCfgMov.CajaTransferencia
EmpresaCfgMov.CajaTransferencia=EmpresaCfgMov.CajaRecoleccion
EmpresaCfgMov.CajaRecoleccion=EmpresaCfgMov.DineroReevaluacion
EmpresaCfgMov.DineroReevaluacion=EmpresaCfgMov.DineroReevaluacionTitulo
EmpresaCfgMov.DineroReevaluacionTitulo=EmpresaCfgMov.DineroRedondeo
EmpresaCfgMov.DineroRedondeo=EmpresaCfgMov.BancoIntereses
EmpresaCfgMov.BancoIntereses=EmpresaCfgMov.DineroInversion
EmpresaCfgMov.DineroInversion=EmpresaCfgMov.DineroRetiroInversion
EmpresaCfgMov.DineroRetiroInversion=(Fin)



[Dinero2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Tesoreria (2)
Clave=Dinero2
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresacfgMovDinero
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

Detalle=S
PermiteEditar=S
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresacfgMovDinero.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
[Dinero2.EmpresacfgMovDinero.CajaAumento]
Carpeta=Dinero2
Clave=EmpresacfgMovDinero.CajaAumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Dinero2.EmpresacfgMovDinero.CajaCorteParc]
Carpeta=Dinero2
Clave=EmpresacfgMovDinero.CajaCorteParc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Dinero2.Columnas]
CajaAumento=124
CajaCorteParc=124






[Dinero2.ListaEnCaptura]
(Inicio)=EmpresacfgMovDinero.CajaAumento
EmpresacfgMovDinero.CajaAumento=EmpresacfgMovDinero.CajaCorteParc
EmpresacfgMovDinero.CajaCorteParc=(Fin)






[Cxp2.EmpresaCfgMovCxp.CXPChequeDevuelto]
Carpeta=Cxp2
Clave=EmpresaCfgMovCxp.CXPChequeDevuelto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





















[CORTE]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cortes de Informacion
Clave=CORTE
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovCorte
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovCorte.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
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

[CORTE.EmpresaCfgMovCorte.CorteImporte]
Carpeta=CORTE
Clave=EmpresaCfgMovCorte.CorteImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CORTE.EmpresaCfgMovCorte.CorteContable]
Carpeta=CORTE
Clave=EmpresaCfgMovCorte.CorteContable
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[CORTE.EmpresaCfgMovCorte.CorteUnidades]
Carpeta=CORTE
Clave=EmpresaCfgMovCorte.CorteUnidades
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S






[CORTE.EmpresaCfgMovCorte.CorteCx]
Carpeta=CORTE
Clave=EmpresaCfgMovCorte.CorteCx
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[CORTE.ListaEnCaptura]
(Inicio)=EmpresaCfgMovCorte.CorteImporte
EmpresaCfgMovCorte.CorteImporte=EmpresaCfgMovCorte.CorteContable
EmpresaCfgMovCorte.CorteContable=EmpresaCfgMovCorte.CorteUnidades
EmpresaCfgMovCorte.CorteUnidades=EmpresaCfgMovCorte.CorteCx
EmpresaCfgMovCorte.CorteCx=(Fin)












[Cxp2.EmpresaCfgMovCxp.CxpInteresMoratorio]
Carpeta=Cxp2
Clave=EmpresaCfgMovCxp.CxpInteresMoratorio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Cxp2.EmpresaCfgMovCxp.CxpDescuentoInflacion]
Carpeta=Cxp2
Clave=EmpresaCfgMovCxp.CxpDescuentoInflacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Cxc2]
Estilo=Ficha
PestanaOtroNombre=S
Clave=Cxc2
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovCxc
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
PestanaNombre=Cuentas por cobrar (2)
Pestana=S
Detalle=S
PermiteEditar=S
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovCxc.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
ListaEnCaptura=EmpresaCfgMovCxc.CxcDescuentoInflacion

[Cxc2.EmpresaCfgMovCxc.CxcDescuentoInflacion]
Carpeta=Cxc2
Clave=EmpresaCfgMovCxc.CxcDescuentoInflacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cxp2.ListaEnCaptura]
(Inicio)=EmpresaCfgMovCxp.CXPEntradaConsignacion
EmpresaCfgMovCxp.CXPEntradaConsignacion=EmpresaCfgMovCxp.CXPCorteConsignacion
EmpresaCfgMovCxp.CXPCorteConsignacion=EmpresaCfgMovCxp.CXPChequeDevuelto
EmpresaCfgMovCxp.CXPChequeDevuelto=EmpresaCfgMovCxp.CxpInteresMoratorio
EmpresaCfgMovCxp.CxpInteresMoratorio=EmpresaCfgMovCxp.CxpDescuentoInflacion
EmpresaCfgMovCxp.CxpDescuentoInflacion=(Fin)




[Inv.EmpresaCfgMov.InvDesentarimado]
Carpeta=Inv
Clave=EmpresaCfgMov.InvDesentarimado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco











[TMA.ListaEnCaptura]
(Inicio)=EmpresaCfgMovWMS.TMASolicitudAcomodo
EmpresaCfgMovWMS.TMASolicitudAcomodo=EmpresaCfgMovWMS.TMAOrdenAcomodo
EmpresaCfgMovWMS.TMAOrdenAcomodo=EmpresaCfgMovWMS.TMASolicitudReacomodo
EmpresaCfgMovWMS.TMASolicitudReacomodo=EmpresaCfgMovWMS.TMAOrdenReacomodo
EmpresaCfgMovWMS.TMAOrdenReacomodo=EmpresaCfgMovWMS.TMAAcomodo
EmpresaCfgMovWMS.TMAAcomodo=EmpresaCfgMovWMS.TMAReacomodo
EmpresaCfgMovWMS.TMAReacomodo=EmpresaCfgMovWMS.TMAOrdenSurtido
EmpresaCfgMovWMS.TMAOrdenSurtido=EmpresaCfgMovWMS.TMASurtidoTransito
EmpresaCfgMovWMS.TMASurtidoTransito=EmpresaCfgMovWMS.TMAOrdenSurtidoPCK
EmpresaCfgMovWMS.TMAOrdenSurtidoPCK=EmpresaCfgMovWMS.TMASurtidoTransitoPCK
EmpresaCfgMovWMS.TMASurtidoTransitoPCK=EmpresaCfgMovWMS.TMASurtido
EmpresaCfgMovWMS.TMASurtido=EmpresaCfgMovWMS.TMASurtidoPerdido
EmpresaCfgMovWMS.TMASurtidoPerdido=(Fin)




[WMS]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=WMS
Clave=WMS
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovWMS
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovWMS.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
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


CondicionVisible=General.WMS
[WMS.EmpresaCfgMovWMS.TMASolicitudAcomodo]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMASolicitudAcomodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMAOrdenAcomodo]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMAOrdenAcomodo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMASolicitudReacomodo]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMASolicitudReacomodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMAOrdenReacomodo]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMAOrdenReacomodo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMAAcomodo]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMAAcomodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMAReacomodo]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMAReacomodo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMAOrdenSurtido]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMAOrdenSurtido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMASurtidoTransito]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMASurtidoTransito
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMAOrdenSurtidoPCK]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMAOrdenSurtidoPCK
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMASurtidoTransitoPCK]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMASurtidoTransitoPCK
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMASurtido]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMASurtido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMASurtidoPerdido]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMASurtidoPerdido
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[OPORT]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Oportunidades
Clave=OPORT
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovOPORT
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


Detalle=S
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovOPORT.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
CondicionVisible=General.OPORT
[OPORT.EmpresaCfgMovOPORT.OPORTOportunidad]
Carpeta=OPORT
Clave=EmpresaCfgMovOPORT.OPORTOportunidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[OPORT.EmpresaCfgMovOPORT.OPORTGenerador]
Carpeta=OPORT
Clave=EmpresaCfgMovOPORT.OPORTGenerador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco












[OPORT.ListaEnCaptura]
(Inicio)=EmpresaCfgMovOPORT.OPORTOportunidad
EmpresaCfgMovOPORT.OPORTOportunidad=EmpresaCfgMovOPORT.OPORTGenerador
EmpresaCfgMovOPORT.OPORTGenerador=(Fin)







[Compras2.ListaEnCaptura]
(Inicio)=EmpresaCfgMovCompra.COMSEntradaConsignacion
EmpresaCfgMovCompra.COMSEntradaConsignacion=EmpresaCfgMovCompra.EntradaMaquila
EmpresaCfgMovCompra.EntradaMaquila=(Fin)

[Compras2.EmpresaCfgMovCompra.EntradaMaquila]
Carpeta=Compras2
Clave=EmpresaCfgMovCompra.EntradaMaquila
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Inv.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.InvSolicitud
EmpresaCfgMov.InvSolicitud=EmpresaCfgMov.InvSolicitudCancelada
EmpresaCfgMov.InvSolicitudCancelada=EmpresaCfgMov.InvSolicitudRechazada
EmpresaCfgMov.InvSolicitudRechazada=EmpresaCfgMov.InvEntradaDiversa
EmpresaCfgMov.InvEntradaDiversa=EmpresaCfgMov.InvSalidaDiversa
EmpresaCfgMov.InvSalidaDiversa=EmpresaCfgMov.InvValeSalida
EmpresaCfgMov.InvValeSalida=EmpresaCfgMov.InvValeDevolucion
EmpresaCfgMov.InvValeDevolucion=EmpresaCfgMov.InvConsumo
EmpresaCfgMov.InvConsumo=EmpresaCfgMov.InvAjuste
EmpresaCfgMov.InvAjuste=EmpresaCfgMov.InvAjusteSaldosMenores
EmpresaCfgMov.InvAjusteSaldosMenores=EmpresaCfgMov.InvFisico
EmpresaCfgMov.InvFisico=EmpresaCfgMov.InvReevaluacion
EmpresaCfgMov.InvReevaluacion=EmpresaCfgMov.InvCambioPresentacion
EmpresaCfgMov.InvCambioPresentacion=EmpresaCfgMov.InvPrestamo
EmpresaCfgMov.InvPrestamo=EmpresaCfgMov.InvReciboPrestamo
EmpresaCfgMov.InvReciboPrestamo=EmpresaCfgMov.InvOrdenTransferencia
EmpresaCfgMov.InvOrdenTransferencia=EmpresaCfgMov.InvTransferencia
EmpresaCfgMov.InvTransferencia=EmpresaCfgMov.InvTransferenciaConsig
EmpresaCfgMov.InvTransferenciaConsig=EmpresaCfgMov.InvOrdenTraspaso
EmpresaCfgMov.InvOrdenTraspaso=EmpresaCfgMov.InvSalidaTraspaso
EmpresaCfgMov.InvSalidaTraspaso=EmpresaCfgMov.InvTransito
EmpresaCfgMov.InvTransito=EmpresaCfgMov.InvReciboTraspaso
EmpresaCfgMov.InvReciboTraspaso=EmpresaCfgMov.InvTransitoFaltante
EmpresaCfgMov.InvTransitoFaltante=EmpresaCfgMov.InvTransitoSobrante
EmpresaCfgMov.InvTransitoSobrante=EmpresaCfgMov.InvDevTransito
EmpresaCfgMov.InvDevTransito=EmpresaCfgMov.InvReciboPrevio
EmpresaCfgMov.InvReciboPrevio=EmpresaCfgMov.InvOrdenEntarimado
EmpresaCfgMov.InvOrdenEntarimado=EmpresaCfgMov.InvEntarimado
EmpresaCfgMov.InvEntarimado=EmpresaCfgMov.InvDesentarimado
EmpresaCfgMov.InvDesentarimado=EmpresaCfgMov.InvEstadisticaAjusteMerma
EmpresaCfgMov.InvEstadisticaAjusteMerma=EmpresaCfgMov.InvConsumoMaterial
EmpresaCfgMov.InvConsumoMaterial=EmpresaCfgMov.InvEntradaProducto
EmpresaCfgMov.InvEntradaProducto=(Fin)

[Inv.EmpresaCfgMov.InvEntradaProducto]
Carpeta=Inv
Clave=EmpresaCfgMov.InvEntradaProducto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[CONTM.ListaEnCaptura]
(Inicio)=EmpresaCfgMovContParalela.CMCentralizarCuentas
EmpresaCfgMovContParalela.CMCentralizarCuentas=EmpresaCfgMovContParalela.CMRecibirCuentas
EmpresaCfgMovContParalela.CMRecibirCuentas=(Fin)







[CONTP]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contabilidad Paralela
Clave=CONTP
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovContParalela
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=EmpresaCfgMov
LlaveLocal=EmpresaCfgMovContParalela.Empresa
LlaveMaestra=EmpresaCfgMov.Empresa
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

[CONTP.EmpresaCfgMovContParalela.CPCentralizarCuentas]
Carpeta=CONTP
Clave=EmpresaCfgMovContParalela.CPCentralizarCuentas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CONTP.EmpresaCfgMovContParalela.CPRecibirCuentas]
Carpeta=CONTP
Clave=EmpresaCfgMovContParalela.CPRecibirCuentas
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[CONTP.EmpresaCfgMovContParalela.CPGeneradorPaq]
Carpeta=CONTP
Clave=EmpresaCfgMovContParalela.CPGeneradorPaq
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CONTP.EmpresaCfgMovContParalela.CPPaquete]
Carpeta=CONTP
Clave=EmpresaCfgMovContParalela.CPPaquete
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CONTP.EmpresaCfgMovContParalela.CPRecepcionPaq]
Carpeta=CONTP
Clave=EmpresaCfgMovContParalela.CPRecepcionPaq
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[CONTP.EmpresaCfgMovContParalela.CPTransformacion]
Carpeta=CONTP
Clave=EmpresaCfgMovContParalela.CPTransformacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CONTP.EmpresaCfgMovContParalela.CPPoliza]
Carpeta=CONTP
Clave=EmpresaCfgMovContParalela.CPPoliza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[CONTP.EmpresaCfgMovContParalela.CPCierrePeriodo]
Carpeta=CONTP
Clave=EmpresaCfgMovContParalela.CPCierrePeriodo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[CONTP.ListaEnCaptura]
(Inicio)=EmpresaCfgMovContParalela.CPCentralizarCuentas
EmpresaCfgMovContParalela.CPCentralizarCuentas=EmpresaCfgMovContParalela.CPRecibirCuentas
EmpresaCfgMovContParalela.CPRecibirCuentas=EmpresaCfgMovContParalela.CPGeneradorPaq
EmpresaCfgMovContParalela.CPGeneradorPaq=EmpresaCfgMovContParalela.CPPaquete
EmpresaCfgMovContParalela.CPPaquete=EmpresaCfgMovContParalela.CPRecepcionPaq
EmpresaCfgMovContParalela.CPRecepcionPaq=EmpresaCfgMovContParalela.CPTransformacion
EmpresaCfgMovContParalela.CPTransformacion=EmpresaCfgMovContParalela.CPPoliza
EmpresaCfgMovContParalela.CPPoliza=EmpresaCfgMovContParalela.CPCierrePeriodo
EmpresaCfgMovContParalela.CPCierrePeriodo=(Fin)





[Proy.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.ProyProyecto
EmpresaCfgMov.ProyProyecto=EmpresaCfgMov.ProyMitigacion
EmpresaCfgMov.ProyMitigacion=EmpresaCfgMov.PlanPreliminar
EmpresaCfgMov.PlanPreliminar=(Fin)

[WMS.ListaEnCaptura]
(Inicio)=EmpresaCfgMovWMS.TMASolicitudAcomodo
EmpresaCfgMovWMS.TMASolicitudAcomodo=EmpresaCfgMovWMS.TMAOrdenAcomodo
EmpresaCfgMovWMS.TMAOrdenAcomodo=EmpresaCfgMovWMS.TMASolicitudReacomodo
EmpresaCfgMovWMS.TMASolicitudReacomodo=EmpresaCfgMovWMS.TMAOrdenReacomodo
EmpresaCfgMovWMS.TMAOrdenReacomodo=EmpresaCfgMovWMS.TMAAcomodo
EmpresaCfgMovWMS.TMAAcomodo=EmpresaCfgMovWMS.TMAReacomodo
EmpresaCfgMovWMS.TMAReacomodo=EmpresaCfgMovWMS.TMAOrdenSurtido
EmpresaCfgMovWMS.TMAOrdenSurtido=EmpresaCfgMovWMS.TMASurtidoTransito
EmpresaCfgMovWMS.TMASurtidoTransito=EmpresaCfgMovWMS.TMAOrdenSurtidoPCK
EmpresaCfgMovWMS.TMAOrdenSurtidoPCK=EmpresaCfgMovWMS.TMASurtidoTransitoPCK
EmpresaCfgMovWMS.TMASurtidoTransitoPCK=EmpresaCfgMovWMS.TMASurtido
EmpresaCfgMovWMS.TMASurtido=EmpresaCfgMovWMS.TMASurtidoPerdido
EmpresaCfgMovWMS.TMASurtidoPerdido=EmpresaCfgMovWMS.TMAOrdenPCKTarima
EmpresaCfgMovWMS.TMAOrdenPCKTarima=EmpresaCfgMovWMS.TMAPCKTarimaTransito
EmpresaCfgMovWMS.TMAPCKTarimaTransito=EmpresaCfgMovWMS.TMAPCKTarima
EmpresaCfgMovWMS.TMAPCKTarima=(Fin)

[WMS.EmpresaCfgMovWMS.TMAOrdenPCKTarima]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMAOrdenPCKTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMAPCKTarimaTransito]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMAPCKTarimaTransito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WMS.EmpresaCfgMovWMS.TMAPCKTarima]
Carpeta=WMS
Clave=EmpresaCfgMovWMS.TMAPCKTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Proy.EmpresaCfgMov.PlanPreliminar]
Carpeta=Proy
Clave=EmpresaCfgMov.PlanPreliminar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Ventas.EmpresaCfgMov.PropuestaEconomica]
Carpeta=Ventas
Clave=EmpresaCfgMov.PropuestaEconomica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S


[Ventas.ListaEnCaptura]
(Inicio)=EmpresaCfgMov.VentaOportunidad
EmpresaCfgMov.VentaOportunidad=EmpresaCfgMov.VentaPresupuesto
EmpresaCfgMov.VentaPresupuesto=EmpresaCfgMov.VentaCotizacion
EmpresaCfgMov.VentaCotizacion=EmpresaCfgMov.VentaPedido
EmpresaCfgMov.VentaPedido=EmpresaCfgMov.VentaOrdenSurtido
EmpresaCfgMov.VentaOrdenSurtido=EmpresaCfgMov.VentaContrato
EmpresaCfgMov.VentaContrato=EmpresaCfgMov.Servicio
EmpresaCfgMov.Servicio=EmpresaCfgMov.VentaReservacion
EmpresaCfgMov.VentaReservacion=EmpresaCfgMov.VentaIngreso
EmpresaCfgMov.VentaIngreso=EmpresaCfgMov.VentaPerdida
EmpresaCfgMov.VentaPerdida=EmpresaCfgMov.VentaPedidoAuto
EmpresaCfgMov.VentaPedidoAuto=EmpresaCfgMov.VentaFactura
EmpresaCfgMov.VentaFactura=EmpresaCfgMov.VentaCancelacionFactura
EmpresaCfgMov.VentaCancelacionFactura=EmpresaCfgMov.VentaFacturaNota
EmpresaCfgMov.VentaFacturaNota=EmpresaCfgMov.VentaSolicitudDevolucion
EmpresaCfgMov.VentaSolicitudDevolucion=EmpresaCfgMov.VentaDev
EmpresaCfgMov.VentaDev=EmpresaCfgMov.VentaDevolucionFaltante
EmpresaCfgMov.VentaDevolucionFaltante=EmpresaCfgMov.VentaRemision
EmpresaCfgMov.VentaRemision=EmpresaCfgMov.VentaDevRemision
EmpresaCfgMov.VentaDevRemision=EmpresaCfgMov.VentaConsignacion
EmpresaCfgMov.VentaConsignacion=EmpresaCfgMov.VentaDevConsignacion
EmpresaCfgMov.VentaDevConsignacion=EmpresaCfgMov.VentaSalidaGarantia
EmpresaCfgMov.VentaSalidaGarantia=EmpresaCfgMov.VentaEntregaGarantia
EmpresaCfgMov.VentaEntregaGarantia=EmpresaCfgMov.VentaNota
EmpresaCfgMov.VentaNota=EmpresaCfgMov.VentaNotaDev
EmpresaCfgMov.VentaNotaDev=EmpresaCfgMov.VentaNotaConsumo
EmpresaCfgMov.VentaNotaConsumo=EmpresaCfgMov.VentaNotaResumen
EmpresaCfgMov.VentaNotaResumen=EmpresaCfgMov.VentaConsumo
EmpresaCfgMov.VentaConsumo=EmpresaCfgMov.VentaFacturaGasto
EmpresaCfgMov.VentaFacturaGasto=EmpresaCfgMov.PropuestaEconomica
EmpresaCfgMov.PropuestaEconomica=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Ventas
Ventas=Ventas2
Ventas2=Compras
Compras=Compras2
Compras2=Inv
Inv=Prod
Prod=Cxc
Cxc=Cxc2
Cxc2=Cxp
Cxp=Cxp2
Cxp2=Dinero
Dinero=Dinero2
Dinero2=Gastos
Gastos=Cont
Cont=Fiscal
Fiscal=Asistencia
Asistencia=Agent
Agent=Embarques
Embarques=Nomina
Nomina=RH
RH=RE
RE=AF
AF=PC
PC=CR
CR=AC
AC=Credito
Credito=Auto
Auto=Act
Act=Proy
Proy=WMS
WMS=CP
CP=CP2
CP2=GES
GES=MAF
MAF=GES2
GES2=PCP
PCP=SAUX
SAUX=CORTE
CORTE=OPORT
OPORT=CONTP
CONTP=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=MovGenera
MovGenera=AlmacenDef
AlmacenDef=Amortizacion
Amortizacion=Recurrentes
Recurrentes=Contratos
Contratos=(Fin)
