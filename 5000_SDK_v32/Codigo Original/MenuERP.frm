[Forma]
Clave=MenuERP
Nombre=Intelisis
Icono=67
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Menus=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=407
PosicionInicialArriba=176
PosicionInicialAlturaCliente=513
PosicionInicialAncho=625
ListaAcciones=(Lista)
BarraAyuda=S
BarraAyudaEsp=S
BarraAyuda1=Reexpresa(General.Mensaje1)
BarraAyuda2=Reexpresa(General.Mensaje2)
BarraAyuda3=Reexpresa(General.Mensaje3)
BarraAyuda1Ancho=200
BarraAyuda2Ancho=100
BarraAyuda3Ancho=100
VentanaSiempreAlFrente=S
VentanaBloquearAjuste=S
PosicionSec1=354

MenuPrincipal=(Lista)
[Lista]
Estilo=Ficha
PestanaNombre=Clientes
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[Acciones.Mov.Ventas]
Nombre=Mov.Ventas
Boton=0
Menu=&Procesos
NombreDesplegar=&Ventas
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=Venta
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.SubModuloVenta, <T>VTAS<T>)<BR>Asigna(Info.ModuloVentasNombre, <T>Ventas<T>)

[Acciones.Mov.Cxc]
Nombre=Mov.Cxc
Boton=0
Menu=&Procesos
NombreDesplegar=Cuentas por &Cobrar
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=Cxc
Activo=S
Visible=S

[Acciones.Mov.Dinero]
Nombre=Mov.Dinero
Boton=0
Menu=&Procesos
NombreDesplegar=&Tesoreria
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=Dinero
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Mov.Inventarios]
Nombre=Mov.Inventarios
Boton=0
Menu=&Procesos
NombreDesplegar=&Inventarios
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=Inv
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.SubModuloInv, <T>INV<T>)<BR>Asigna(Info.ModuloInventariosNombre, <T>Inventarios<T>)

[Acciones.Mov.Cxp]
Nombre=Mov.Cxp
Boton=0
Menu=&Procesos
NombreDesplegar=Cuentas por &Pagar
EnMenu=S
TipoAccion=Formas
ClaveAccion=Cxp
Activo=S
Visible=S

[Acciones.Mov.Compras]
Nombre=Mov.Compras
Boton=0
Menu=&Procesos
NombreDesplegar=C&ompras
EnMenu=S
TipoAccion=Formas
ClaveAccion=Compra
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.SubModuloCompra, <T>COMS<T>)<BR>Asigna(Info.ModuloComprasNombre, <T>Compras<T>)

[Acciones.Mov.Salir]
Nombre=Mov.Salir
Boton=0
Menu=&Procesos
NombreDesplegar=&Salir
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Cerrar

[Acciones.Cta.Articulos]
Nombre=Cta.Articulos
Boton=0
Menu=&Cuentas
NombreDesplegar=&Artículos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCtaArticulos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Cta.Clientes]
Nombre=Cta.Clientes
Boton=0
Menu=&Cuentas
NombreDesplegar=&Clientes
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCtaClientes
Activo=S
Visible=S

[Acciones.Cta.Proveedores]
Nombre=Cta.Proveedores
Boton=0
Menu=&Cuentas
NombreDesplegar=&Proveedores
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCtaProveedores
Activo=S
Visible=S

[Acciones.Cta.Almacenes]
Nombre=Cta.Almacenes
Boton=0
Menu=&Cuentas
NombreDesplegar=A&lmacenes
EnMenu=S
TipoAccion=Formas
ClaveAccion=Alm
Activo=S
Visible=S

[Acciones.Cta.Agentes]
Nombre=Cta.Agentes
Boton=0
Menu=&Cuentas
NombreDesplegar=Agen&tes
EnMenu=S
TipoAccion=Formas
ClaveAccion=Agente
Activo=S
Visible=S

[Acciones.Herramienta.Calculadora]
Nombre=Herramienta.Calculadora
Boton=0
Menu=&Herramientas
NombreDesplegar=Ca&lculadora
EnMenu=S
TipoAccion=Otros
ClaveAccion=Calculadora
Activo=S
Visible=S

[Acciones.Herramienta.Calendario]
Nombre=Herramienta.Calendario
Boton=0
Menu=&Herramientas
NombreDesplegar=&Calendario
EnMenu=S
TipoAccion=Otros
ClaveAccion=Calendario
Activo=S
Visible=S

[Acciones.Mov.Contabilidad]
Nombre=Mov.Contabilidad
Boton=0
Menu=&Procesos
NombreDesplegar=Co&ntabilidad
EnMenu=S
TipoAccion=Formas
ClaveAccion=Cont
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Mov.Conciliaciones]
Nombre=Mov.Conciliaciones
Boton=0
Menu=&Procesos
NombreDesplegar=Conciliaciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=Conciliacion
Activo=S
Visible=S

[Acciones.Herramienta.Exportar]
Nombre=Herramienta.Exportar
Boton=0
Menu=&Herramientas
NombreDesplegar=&Exportar datos...
EnMenu=S
TipoAccion=Otros
ClaveAccion=Exportar Datos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Herramienta.Importar]
Nombre=Herramienta.Importar
Boton=0
Menu=&Herramientas
NombreDesplegar=&Importar datos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientasImportar
Activo=S
Visible=S

[Acciones.Rep.Ventas]
Nombre=Rep.Ventas
Boton=0
Menu=&Reportes
NombreDesplegar=&Ventas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepVentas
Activo=S
Visible=S

[Acciones.Exp.Ventas]
Nombre=Exp.Ventas
Boton=0
Menu=&Exploradores
NombreDesplegar=&Ventas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpVentas
Activo=S
Visible=S

[Acciones.Rep.Cxc]
Nombre=Rep.Cxc
Boton=0
NombreDesplegar=Cuentas por &Cobrar
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepCxc
Activo=S
Visible=S
Menu=&Reportes

[Acciones.Exp.Cxc]
Nombre=Exp.Cxc
Boton=0
NombreDesplegar=Cuentas por &Cobrar
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpCxc
Activo=S
Visible=S
Menu=&Exploradores

[Acciones.Rep.Dinero]
Nombre=Rep.Dinero
Boton=0
Menu=&Reportes
NombreDesplegar=&Tesoreria
EnMenu=S
Activo=S
Visible=S
TipoAccion=Dialogos
ClaveAccion=MenuRepDinero

[Acciones.Exp.Dinero]
Nombre=Exp.Dinero
Boton=0
Menu=&Exploradores
NombreDesplegar=&Tesoreria
EnMenu=S
Activo=S
Visible=S
TipoAccion=Dialogos
ClaveAccion=MenuExpDinero

[Acciones.Rep.Inventarios]
Nombre=Rep.Inventarios
Boton=0
Menu=&Reportes
NombreDesplegar=&Inventarios
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepInv
Activo=S
Visible=S

[Acciones.Exp.Inventarios]
Nombre=Exp.Inventarios
Boton=0
Menu=&Exploradores
NombreDesplegar=&Inventarios
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpInv
Activo=S
Visible=S

[Acciones.Rep.Cxp]
Nombre=Rep.Cxp
Boton=0
Menu=&Reportes
NombreDesplegar=Cuentas por &Pagar
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepCxp
Activo=S
Visible=S

[Acciones.Exp.Cxp]
Nombre=Exp.Cxp
Boton=0
Menu=&Exploradores
NombreDesplegar=Cuentas por &Pagar
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpCxp
Activo=S
Visible=S

[Acciones.Rep.Compras]
Nombre=Rep.Compras
Boton=0
Menu=&Reportes
NombreDesplegar=C&ompras
EnMenu=S
Activo=S
Visible=S
TipoAccion=Dialogos
ClaveAccion=MenuRepCompras

[Acciones.Exp.Compras]
Nombre=Exp.Compras
Boton=0
Menu=&Exploradores
NombreDesplegar=C&ompras
EnMenu=S
Activo=S
Visible=S
TipoAccion=Dialogos
ClaveAccion=MenuExpCompras

[Acciones.Rep.Contabilidad]
Nombre=Rep.Contabilidad
Boton=0
Menu=&Reportes
NombreDesplegar=Co&ntabilidad
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepCont
Activo=S
Visible=S

[Acciones.Exp.Contabilidad]
Nombre=Exp.Contabilidad
Boton=0
Menu=&Exploradores
NombreDesplegar=Co&ntabilidad
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpCont
Activo=S
Visible=S

[Acciones.Herramienta.Paginas]
Nombre=Herramienta.Paginas
Boton=0
Menu=&Herramientas
NombreDesplegar=Páginas (&Hojas de Cálculo)
EnMenu=S
TipoAccion=Otros
ClaveAccion=Editor de Paginas
Activo=S
VisibleCondicion=General.AccesoPaginas

[Acciones.Cta.Dinero]
Nombre=Cta.Dinero
Boton=0
Menu=&Cuentas
NombreDesplegar=Cuentas de &Dinero
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCtaDinero
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Herramienta.CambiarUsuario]
Nombre=Herramienta.CambiarUsuario
Boton=0
Menu=&Herramientas
NombreDesplegar=Cam&biar Empresa/Usuario
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Acceso
Activo=S
Visible=S

[Acciones.Herramienta.GenerarPolizas]
Nombre=Herramienta.GenerarPolizas
Boton=0
Menu=&Herramientas
NombreDesplegar=&Generar Pólizas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuGenerarPolizas
Activo=S
Visible=S

[Acciones.Config.GeneradorReportes]
Nombre=Config.GeneradorReportes
Boton=0
Menu=C&onfigurar
NombreDesplegar=Generador de &Reportes
EnMenu=S
TipoAccion=Otros
ClaveAccion=Generador de Reportes
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Config.ConexionContable]
Nombre=Config.ConexionContable
Boton=0
Menu=C&onfigurar
NombreDesplegar=Cone&xión Contable
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuContX
Activo=S
Visible=S

[Acciones.Config.Ventas]
Nombre=Config.Ventas
Boton=0
Menu=C&onfigurar
NombreDesplegar=Ventas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgVentas
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Config.Cxc]
Nombre=Config.Cxc
Boton=0
Menu=C&onfigurar
NombreDesplegar=Cuentas por Cobrar
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgCxc
Activo=S
Visible=S

[Acciones.Config.Cxp]
Nombre=Config.Cxp
Boton=0
Menu=C&onfigurar
NombreDesplegar=Cuentas por Pagar
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgCxp
Activo=S
Visible=S

[Acciones.Config.Gastos]
Nombre=Config.Gastos
Boton=0
Menu=C&onfigurar
NombreDesplegar=Gastos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgGastos
Activo=S
Visible=S

[Acciones.Config.Compras]
Nombre=Config.Compras
Boton=0
Menu=C&onfigurar
NombreDesplegar=Compras
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgCompras
Activo=S
Visible=S

[Acciones.Config.Otros]
Nombre=Config.Otros
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Otros
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgOtros
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Herramienta.EstatusImpresiones]
Nombre=Herramienta.EstatusImpresiones
Boton=0
Menu=&Herramientas
NombreDesplegar=Ver Se&rvidor de Impresiones
EnMenu=S
TipoAccion=Otros
ClaveAccion=Estatus de Impresiones
Activo=S
Visible=S

[Acciones.Rep.Gerenciales]
Nombre=Rep.Gerenciales
Boton=0
Menu=&Reportes
NombreDesplegar=&Gerenciales
EnMenu=S
EspacioPrevio=S
TipoAccion=Dialogos
ClaveAccion=MenuRepGerenciales
Activo=S
Visible=S

[Acciones.Exp.Gerenciales]
Nombre=Exp.Gerenciales
Boton=0
Menu=&Exploradores
NombreDesplegar=&Gerenciales
EnMenu=S
EspacioPrevio=S
TipoAccion=Dialogos
ClaveAccion=MenuExpGerenciales
Activo=S
Visible=S

[Acciones.Mov.Gasto]
Nombre=Mov.Gasto
Boton=0
Menu=&Procesos
NombreDesplegar=&Gastos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Gasto
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.SubModuloGasto, <T>GAS<T>)<BR>Asigna(Info.ModuloGastosNombre, <T>Gastos<T>)

[Acciones.Rep.Gastos]
Nombre=Rep.Gastos
Boton=0
Menu=&Reportes
NombreDesplegar=&Gastos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepGastos
Activo=S
Visible=S

[Acciones.Exp.Gastos]
Nombre=Exp.Gastos
Boton=0
Menu=&Exploradores
NombreDesplegar=&Gastos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpGastos
Activo=S
Visible=S

[Acciones.Config.Servicio]
Nombre=Config.Servicio
Boton=0
Menu=C&onfigurar
NombreDesplegar=Servicios
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgServicio
Activo=S
Visible=S

[Acciones.Herramienta.TraspasarAcumulados]
Nombre=Herramienta.TraspasarAcumulados
Boton=0
Menu=&Herramientas
NombreDesplegar=&Traspasar Acumulados
EnMenu=S
TipoAccion=Formas
ClaveAccion=TraspasarAcumulados
Activo=S
Visible=S

[Acciones.Herramienta.Contabilidad]
Nombre=Herramienta.Contabilidad
Boton=0
Menu=&Herramientas
NombreDesplegar=Co&ntabilidad
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaCont
Activo=S
Visible=S

[Acciones.Herramienta.Cxc]
Nombre=Herramienta.Cxc
Boton=0
Menu=&Herramientas
NombreDesplegar=Cuentas por &Cobrar
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaCxc
Activo=S
Visible=S

[Acciones.Herramienta.Cxp]
Nombre=Herramienta.Cxp
Boton=0
Menu=&Herramientas
NombreDesplegar=Cuentas por &Pagar
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaCxp
Activo=S
Visible=S

[Acciones.Herramienta.VentaMostrador]
Nombre=Herramienta.VentaMostrador
Boton=0
Menu=&Herramientas
NombreDesplegar=Ventas &Mostrador
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientasVentaMostrador
Activo=S
Visible=S

[Acciones.Mov.Servicios]
Nombre=Mov.Servicios
Boton=0
Menu=&Procesos
NombreDesplegar=&Servicios
EnMenu=S
TipoAccion=Formas
ClaveAccion=Venta
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.SubModuloVenta, <T>SERV<T>)<BR>Asigna(Info.ModuloVentasNombre, <T>Servicios<T>)

[Acciones.Rep.Servicio]
Nombre=Rep.Servicio
Boton=0
Menu=&Reportes
NombreDesplegar=&Servicios
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepServicio
Activo=S
Visible=S

[Acciones.Exp.Servicio]
Nombre=Exp.Servicio
Boton=0
Menu=&Exploradores
NombreDesplegar=&Servicios
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpServicio
Activo=S
Visible=S

[Acciones.Mov.Embarque]
Nombre=Mov.Embarque
Boton=0
Menu=&Procesos
NombreDesplegar=&Embarques
EnMenu=S
TipoAccion=Formas
ClaveAccion=Embarque
Activo=S
Visible=S

[Acciones.Config.Embarque]
Nombre=Config.Embarque
Boton=0
Menu=C&onfigurar
NombreDesplegar=Embarques
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgEmbarque
Activo=S
Visible=S

[Acciones.Rep.Embarque]
Nombre=Rep.Embarque
Boton=0
NombreDesplegar=&Embarques
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepEmbarque
Activo=S
Visible=S
Menu=&Reportes

[Acciones.Exp.Embarque]
Nombre=Exp.Embarque
Boton=0
NombreDesplegar=&Embarques
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpEmbarque
Activo=S
Visible=S
Menu=&Exploradores

[Acciones.Cta.ActivoF]
Nombre=Cta.ActivoF
Boton=0
Menu=&Cuentas
NombreDesplegar=Activos &Fijos
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoF
Activo=S
Visible=S

[Acciones.Mov.ActivoFijo]
Nombre=Mov.ActivoFijo
Boton=0
Menu=&Procesos
NombreDesplegar=Activos &Fijos
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFijo
Activo=S
Visible=S

[Acciones.Mov.Nomina]
Nombre=Mov.Nomina
Boton=0
Menu=&Procesos
NombreDesplegar=Nó&mina
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Si(General.NomAuto, Forma(<T>NominaAuto<T>), Forma(<T>Nomina<T>))

[Acciones.Mov.RH]
Nombre=Mov.RH
Boton=0
Menu=&Procesos
NombreDesplegar=Recursos &Humanos
EnMenu=S
TipoAccion=Formas
ClaveAccion=RH
Activo=S
Visible=S

[Acciones.Config.Nomina]
Nombre=Config.Nomina
Boton=0
Menu=C&onfigurar
NombreDesplegar=Nómina
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgNomina
Activo=S
Visible=S

[Acciones.Config.GeneradoNomina]
Nombre=Config.GeneradoNomina
Boton=0
Menu=C&onfigurar
NombreDesplegar=Generador de Nóminas
EnMenu=S
TipoAccion=Formas
ClaveAccion=NomX
Activo=S
Visible=S

[Acciones.Cta.Personal]
Nombre=Cta.Personal
Boton=0
Menu=&Cuentas
NombreDesplegar=P&ersonal
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCtaPersonal
Activo=S
Visible=S

[Acciones.Mov.Asiste]
Nombre=Mov.Asiste
Boton=0
Menu=&Procesos
NombreDesplegar=&Asistencias
EnMenu=S
TipoAccion=Formas
ClaveAccion=Asiste
Activo=S
Visible=S

[Acciones.Herramienta.CerrarDia]
Nombre=Herramienta.CerrarDia
Boton=0
Menu=&Herramientas
NombreDesplegar=Cerrar &Día
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=CerrarDia
Activo=S
VisibleCondicion=General.CerrarDia

[Acciones.Mov.VentaSurtirCB]
Nombre=Mov.VentaSurtirCB
Boton=0
Menu=&Procesos
NombreDesplegar=&Surtir Pedidos
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaSurtirCB
Activo=S
VisibleCondicion=Config.Partidas

[Acciones.Rep.ActivoFijo]
Nombre=Rep.ActivoFijo
Boton=0
Menu=&Reportes
NombreDesplegar=Activos &Fijos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepActivos
Activo=S
Visible=S

[Acciones.Exp.ActivoFijo]
Nombre=Exp.ActivoFijo
Boton=0
Menu=&Exploradores
NombreDesplegar=Activos &Fijos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpActivos
Activo=S
Visible=S

[Acciones.Config.Usuarios]
Nombre=Config.Usuarios
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Usuarios
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgUsuarios
Activo=S
Visible=S

[Acciones.Config.Empresas]
Nombre=Config.Empresas
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Empresas
EnMenu=S
TipoAccion=Formas
ClaveAccion=Empresa
Activo=S
Visible=S

[Acciones.Rep.Nomina]
Nombre=Rep.Nomina
Boton=0
Menu=&Reportes
NombreDesplegar=Nómina
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepNomina
Activo=S
Visible=S

[Acciones.Exp.Nomina]
Nombre=Exp.Nomina
Boton=0
Menu=&Exploradores
NombreDesplegar=Nómina
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpNomina
Activo=S
Visible=S

[Acciones.Herramienta.Venta]
Nombre=Herramienta.Venta
Boton=0
Menu=&Herramientas
NombreDesplegar=&Ventas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientasVenta
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Ayuda.Ayuda]
Nombre=Ayuda.Ayuda
Boton=0
Menu=Ay&uda
NombreDesplegar=&Ayuda
EnMenu=S
TipoAccion=Otros
ClaveAccion=Ayuda
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=F1

[Acciones.Ayuda.Acerca]
Nombre=Ayuda.Acerca
Boton=0
Menu=Ay&uda
NombreDesplegar=&Acerca...
EnMenu=S
EspacioPrevio=S
TipoAccion=Otros
ClaveAccion=Acerca
Activo=S
Visible=S

[Acciones.Config.GeneradorVistasEspeciales]
Nombre=Config.GeneradorVistasEspeciales
Boton=0
Menu=C&onfigurar
NombreDesplegar=Generador de &Vistas Especiales
EnMenu=S
TipoAccion=Otros
ClaveAccion=Vistas Especiales
Activo=S
Visible=S

[Acciones.Cta.VIN]
Nombre=Cta.VIN
Boton=0
Menu=&Cuentas
NombreDesplegar=&VIN
EnMenu=S
TipoAccion=Formas
ClaveAccion=VIN
Activo=S
VisibleCondicion=Config.VIN

[Acciones.Mov.Produccion]
Nombre=Mov.Produccion
Boton=0
Menu=&Procesos
NombreDesplegar=Pro&ducción
EnMenu=S
TipoAccion=Formas
ClaveAccion=Prod
Activo=S
VisibleCondicion=General.Prod

[Acciones.Mov.Planeador]
Nombre=Mov.Planeador
Boton=0
Menu=&Procesos
NombreDesplegar=&Planeador Ordenes
EnMenu=S
TipoAccion=Formas
ClaveAccion=Planeador
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Mov.DevVenta]
Nombre=Mov.DevVenta
Boton=0
Menu=&Procesos
NombreDesplegar=De&voluciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=Venta
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.SubModuloVenta, <T>DVTAS<T>)<BR>Asigna(Info.ModuloVentasNombre, <T>Devoluciones<T>)

[Acciones.Exp.Documentacion]
Nombre=Exp.Documentacion
Boton=0
Menu=&Exploradores
NombreDesplegar=Documentación
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpDoc
Activo=S
Visible=S

[Acciones.Exp.Articulos]
Nombre=Exp.Articulos
Boton=0
Menu=&Exploradores
NombreDesplegar=Artículos
EnMenu=S
EspacioPrevio=S
TipoAccion=Dialogos
ClaveAccion=MenuExpArt
Activo=S
Visible=S

[Acciones.Exp.Clientes]
Nombre=Exp.Clientes
Boton=0
Menu=&Exploradores
NombreDesplegar=&Clientes
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpCte
Activo=S
Visible=S

[Acciones.Exp.CtaDinero]
Nombre=Exp.CtaDinero
Boton=0
Menu=&Exploradores
NombreDesplegar=Cuentas de &Dinero
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarCtaDinero
Activo=S
Visible=S

[Acciones.Exp.Proveedores]
Nombre=Exp.Proveedores
Boton=0
NombreDesplegar=Proveedores
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarProv
Activo=S
Visible=S
Menu=&Exploradores

[Acciones.Exp.Almacenes]
Nombre=Exp.Almacenes
Boton=0
Menu=&Exploradores
NombreDesplegar=Almacenes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarAlm
Activo=S
Visible=S

[Acciones.Exp.Agentes]
Nombre=Exp.Agentes
Boton=0
Menu=&Exploradores
NombreDesplegar=Agentes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarAgente
Activo=S
Visible=S

[Acciones.Exp.Personal]
Nombre=Exp.Personal
Boton=0
Menu=&Exploradores
NombreDesplegar=Personal
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarPersonal
Activo=S
Visible=S

[Acciones.Exp.CtaContables]
Nombre=Exp.CtaContables
Boton=0
NombreDesplegar=Cuentas Co&ntables
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarCta
Activo=S
Visible=S
Menu=&Exploradores

[Acciones.Cta.CentroCostos]
Nombre=Cta.CentroCostos
Boton=0
Menu=&Cuentas
NombreDesplegar=Centros C&ostos
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Si(Config.CentroCostosRamas, Forma(<T>CentroCostosRama<T>), Forma(<T>CentroCostos<T>))

[Acciones.Config.General]
Nombre=Config.General
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Generales
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgGeneral
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Cta.ProdCentro]
Nombre=Cta.ProdCentro
Boton=0
Menu=&Cuentas
NombreDesplegar=&Centros Trabajo
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCtaCentro
Activo=S
VisibleCondicion=General.Prod

[Acciones.Cta.ProdEstacion]
Nombre=Cta.ProdEstacion
Boton=0
Menu=&Cuentas
NombreDesplegar=&Estaciones Trabajo
EnMenu=S
TipoAccion=Formas
ClaveAccion=EstacionT
Activo=S
VisibleCondicion=General.Prod

[Acciones.Cta.ProdRuta]
Nombre=Cta.ProdRuta
Boton=0
Menu=&Cuentas
NombreDesplegar=&Rutas Producción
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProdRuta
Activo=S
VisibleCondicion=General.Prod

[Acciones.Config.Politicas]
Nombre=Config.Politicas
Boton=0
Menu=C&onfigurar
NombreDesplegar=Políticas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgPoliticas
Activo=S
Visible=S

[Acciones.Herramienta.TipoCambio]
Nombre=Herramienta.TipoCambio
Boton=0
Menu=&Herramientas
NombreDesplegar=Tipos de Cambio
EnMenu=S
TipoAccion=Formas
ClaveAccion=MonTipoCambio
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Config.Observaciones]
Nombre=Config.Observaciones
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgObservaciones
Activo=S
Visible=S

[Acciones.Config.Conceptos]
Nombre=Config.Conceptos
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Conceptos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgConceptos
Activo=S
Visible=S

[Acciones.Config.Movimientos]
Nombre=Config.Movimientos
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Tipos de Movimientos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgMovTipo
Activo=S
Visible=S

[Acciones.Config.Situaciones]
Nombre=Config.Situaciones
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Situaciones
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgSituaciones
Activo=S
Visible=S

[Acciones.Config.Consecutivos]
Nombre=Config.Consecutivos
Boton=0
Menu=C&onfigurar
NombreDesplegar=C&onsecutivos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgConsecutivos
Activo=S
Visible=S

[Acciones.Config.Documentacion]
Nombre=Config.Documentacion
Boton=0
Menu=C&onfigurar
NombreDesplegar=Documentación
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=DocRama
Activo=S
Visible=S

[Acciones.Cta.Contables]
Nombre=Cta.Contables
Boton=0
Menu=&Cuentas
NombreDesplegar=Cuentas Co&ntables
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCtaCont
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Herramienta.Dinero]
Nombre=Herramienta.Dinero
Boton=0
Menu=&Herramientas
NombreDesplegar=Tesorería
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaDinero
Activo=S
Visible=S

[Acciones.Rep.Otros]
Nombre=Rep.Otros
Boton=0
Menu=&Reportes
NombreDesplegar=Otros
EnMenu=S
EspacioPrevio=S
TipoAccion=Otros
ClaveAccion=Reportes Especiales del Usuario
Activo=S
Visible=S

[Acciones.Mov.PuntoVenta]
Nombre=Mov.PuntoVenta
Boton=0
Menu=&Procesos
NombreDesplegar=&Punto Venta
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=PlugIn(<T>PV<T>)

[Acciones.Mov.Acceso]
Nombre=Mov.Acceso
Boton=0
Menu=&Procesos
NombreDesplegar=Control Accesos
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=PlugIn(<T>Acceso<T>)

[Acciones.Config.Sucursales]
Nombre=Config.Sucursales
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Sucursales
EnMenu=S
TipoAccion=Formas
ClaveAccion=Sucursal
Activo=S
Visible=S

[Acciones.Config.PC]
Nombre=Config.PC
Boton=0
Menu=C&onfigurar
NombreDesplegar=Precios y Costos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgPC
Activo=S
VisibleCondicion=General.PC

[Acciones.Mov.PC]
Nombre=Mov.PC
Boton=0
Menu=&Procesos
NombreDesplegar=P&recios y Costos
EnMenu=S
TipoAccion=Formas
ClaveAccion=PC
Activo=S
VisibleCondicion=General.PC

[Acciones.Rep.PC]
Nombre=Rep.PC
Boton=0
Menu=&Reportes
NombreDesplegar=P&recios y Costos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepPC
Activo=S
Visible=S

[Acciones.Config.Planeacion]
Nombre=Config.Planeacion
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Planeación
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgPlan
Activo=S
Visible=S

[Acciones.Rep.Art]
Nombre=Rep.Art
Boton=0
Menu=&Reportes
NombreDesplegar=Artículos
EnMenu=S
EspacioPrevio=S
TipoAccion=Dialogos
ClaveAccion=MenuRepArt
Activo=S
Visible=S

[Acciones.Mov.Vales]
Nombre=Mov.Vales
Boton=0
Menu=&Procesos
NombreDesplegar=Vales
EnMenu=S
TipoAccion=Formas
ClaveAccion=Vale
Activo=S
Visible=S

[Acciones.Exp.ValeSerie]
Nombre=Exp.ValeSerie
Boton=0
Menu=&Exploradores
NombreDesplegar=Vales
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarValeSerie
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Mov.Otros]
Nombre=Mov.Otros
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Exp.Otros]
Nombre=Exp.Otros
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
EspacioPrevio=S

[Acciones.Cta.Otros]
Nombre=Cta.Otros
Boton=0
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
EspacioPrevio=S

[Acciones.Herramienta.Otros]
Nombre=Herramienta.Otros
Boton=0
EnMenu=S
TipoAccion=Expresion
Menu=&Herramientas

[Acciones.Exp.Produccion]
Nombre=Exp.Produccion
Boton=0
Menu=&Exploradores
NombreDesplegar=Pro&ducción
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpProd
Activo=S
Visible=S

[Acciones.Exp.Comisiones]
Nombre=Exp.Comisiones
Boton=0
Menu=&Exploradores
NombreDesplegar=Comisiones y Desta&jos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpAgent
Activo=S
Visible=S

[Acciones.Mov.Comisiones]
Nombre=Mov.Comisiones
Boton=0
Menu=&Procesos
NombreDesplegar=Comisiones y Desta&jos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Agent
Activo=S
Visible=S

[Acciones.Rep.Comisiones]
Nombre=Rep.Comisiones
Boton=0
Menu=&Reportes
NombreDesplegar=Comisiones y Desta&jos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepAgent
Activo=S
Visible=S

[Acciones.Herramienta.Inv]
Nombre=Herramienta.Inv
Boton=0
Menu=&Herramientas
NombreDesplegar=&Inventarios
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaInv
Activo=S
Visible=S

[Acciones.Exp.RH]
Nombre=Exp.RH
Boton=0
Menu=&Exploradores
NombreDesplegar=Recursos &Humanos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpRH
Activo=S
Visible=S

[Acciones.Herramienta.Nomina]
Nombre=Herramienta.Nomina
Boton=0
Menu=&Herramientas
NombreDesplegar=Nómina
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaNomina
Activo=S
Visible=S

[Acciones.Exp.Fiscal]
Nombre=Exp.Fiscal
Boton=0
Menu=&Exploradores
NombreDesplegar=&Fiscal
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpFiscal
Activo=S
Visible=S

[Acciones.Cta.Proy]
Nombre=Cta.Proy
Boton=0
Menu=&Cuentas
NombreDesplegar=Pro&yectos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Proy
Activo=S
Visible=S

[Acciones.Mov.AtnClientes]
Nombre=Mov.AtnClientes
Boton=0
Menu=&Procesos
NombreDesplegar=Atención Clientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=Soporte
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.SubModuloST, <T>ST<T>)<BR>Asigna(Info.STNombre, <T>Atención Clientes<T>)

[Acciones.Mov.AtnProveedores]
Nombre=Mov.AtnProveedores
Boton=0
Menu=&Procesos
NombreDesplegar=Atención Proveedores
EnMenu=S
TipoAccion=Formas
ClaveAccion=Soporte
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.SubModuloST, <T>STPRO<T>)<BR>Asigna(Info.STNombre, <T>Atención Proveedores<T>)

[Acciones.Mov.AtnPersonal]
Nombre=Mov.AtnPersonal
Boton=0
NombreDesplegar=Atención Personal
EnMenu=S
TipoAccion=Formas
ClaveAccion=Soporte
Activo=S
Antes=S
Visible=S
Menu=&Procesos
AntesExpresiones=Asigna(Info.SubModuloST, <T>STPER<T>)<BR>Asigna(Info.STNombre, <T>Atención Personal<T>)

[Acciones.Mov.AtnProyectos]
Nombre=Mov.AtnProyectos
Boton=0
Menu=&Procesos
NombreDesplegar=Pro&yectos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Soporte
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.SubModuloST, <T>PROY<T>)<BR>Asigna(Info.STNombre, <T>Proyectos<T>)
VisibleCondicion=no General.PM

[Acciones.Exp.Atn]
Nombre=Exp.Atn
Boton=0
Menu=&Exploradores
NombreDesplegar=&Módulos Atención
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpST
Activo=S
Visible=S

[Acciones.Config.Atn]
Nombre=Config.Atn
Boton=0
Menu=C&onfigurar
NombreDesplegar=Módulos Atención
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgST
Activo=S
Visible=S

[Acciones.Mov.Autotransportes]
Nombre=Mov.Autotransportes
Boton=0
Menu=&Procesos
NombreDesplegar=&Autotransportes
EnMenu=S
TipoAccion=Formas
ClaveAccion=Venta
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.SubModuloVenta, <T>AUTO<T>)<BR>Asigna(Info.ModuloVentasNombre, <T>Autotransportes<T>)
VisibleCondicion=General.Autotransportes

[Acciones.Config.Autotransportes]
Nombre=Config.Autotransportes
Boton=0
Menu=C&onfigurar
NombreDesplegar=Autotransportes
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgAutotransportes
Activo=S
VisibleCondicion=General.Autotransportes

[Acciones.Rep.Asiste]
Nombre=Rep.Asiste
Boton=0
Menu=&Reportes
NombreDesplegar=&Asistencias
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepAsiste
Activo=S
Visible=S

[Acciones.Rep.RH]
Nombre=Rep.RH
Boton=0
Menu=&Reportes
NombreDesplegar=Recursos &Humanos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepRH
Activo=S
Visible=S

[Acciones.Rep.Produccion]
Nombre=Rep.Produccion
Boton=0
Menu=&Reportes
NombreDesplegar=Pro&ducción
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepProd
Activo=S
Visible=S

[Acciones.Config.ContabilidadAutomatica]
Nombre=Config.ContabilidadAutomatica
Boton=0
Menu=C&onfigurar
NombreDesplegar=Contabilidad Automática
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgContAuto
ActivoCondicion=General.ContAuto
VisibleCondicion=General.ContAuto

[Acciones.Mov.ServiciosInternos]
Nombre=Mov.ServiciosInternos
Boton=0
Menu=&Procesos
NombreDesplegar=Servicios Internos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Soporte
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.SubModuloST, <T>SI<T>)<BR>Asigna(Info.STNombre, <T>Servicios Internos<T>)
Visible=S

[Acciones.Cta.Espacio]
Nombre=Cta.Espacio
Boton=0
Menu=&Cuentas
NombreDesplegar=&Espacios
EnMenu=S
TipoAccion=Formas
ClaveAccion=Espacio
Activo=S
VisibleCondicion=General.Espacios

[Acciones.Exp.Proy]
Nombre=Exp.Proy
Boton=0
Menu=&Exploradores
NombreDesplegar=Proyectos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpProy
Activo=S
Visible=S

[Acciones.Exp.Espacios]
Nombre=Exp.Espacios
Boton=0
Menu=&Exploradores
NombreDesplegar=Espacios
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpEspacios
ActivoCondicion=General.Espacios
VisibleCondicion=General.Espacios

[Acciones.Cubo.Ventas]
Nombre=Cubo.Ventas
Boton=0
Menu=C&ubos
NombreDesplegar=&Ventas
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>VTAS<T>)
VisibleCondicion=CuboActivo(<T>VTAS<T>)

[Acciones.Cubo.Cxc]
Nombre=Cubo.Cxc
Boton=0
Menu=C&ubos
NombreDesplegar=Cuentas por &Cobrar
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>CXC<T>)
VisibleCondicion=CuboActivo(<T>CXC<T>)

[Acciones.Cubo.Cxp]
Nombre=Cubo.Cxp
Boton=0
Menu=C&ubos
NombreDesplegar=Cuentas por &Pagar
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>CXP<T>)
VisibleCondicion=CuboActivo(<T>CXP<T>)

[Acciones.Cubo.ActivoFijo]
Nombre=Cubo.ActivoFijo
Boton=0
Menu=C&ubos
NombreDesplegar=Activos &Fijos
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>AF<T>)
VisibleCondicion=CuboActivo(<T>AF<T>)

[Acciones.Cubo.AtnClientes]
Nombre=Cubo.AtnClientes
Boton=0
Menu=C&ubos
NombreDesplegar=Atención Clientes
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>ST_CTE<T>)
VisibleCondicion=CuboActivo(<T>ST_CTE<T>)

[Acciones.Cubo.Embarques]
Nombre=Cubo.Embarques
Boton=0
Menu=C&ubos
NombreDesplegar=&Embarques
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>EMB<T>)
VisibleCondicion=CuboActivo(<T>EMB<T>)

[Acciones.Cubo.Gastos]
Nombre=Cubo.Gastos
Boton=0
Menu=C&ubos
NombreDesplegar=&Gastos
EnMenu=S
TipoAccion=Expresion
Activo=S
EspacioPrevio=S
Expresion=Cubo(<T>GAS<T>)
VisibleCondicion=CuboActivo(<T>GAS<T>)

[Acciones.Cubo.Nomina]
Nombre=Cubo.Nomina
Boton=0
Menu=C&ubos
NombreDesplegar=&Nómina
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>NOM<T>)
VisibleCondicion=CuboActivo(<T>NOM<T>)

[Acciones.Cubo.Tesoreria]
Nombre=Cubo.Tesoreria
Boton=0
Menu=C&ubos
NombreDesplegar=&Tesoreria
EnMenu=S
TipoAccion=Expresion
Activo=S
EspacioPrevio=S
Expresion=Cubo(<T>DIN<T>)
VisibleCondicion=CuboActivo(<T>DIN<T>)

[Acciones.Cubo.FlujoInv]
Nombre=Cubo.FlujoInv
Boton=0
Menu=C&ubos
NombreDesplegar=Flujo Inventario
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>INV_FLUJO<T>)
VisibleCondicion=CuboActivo(<T>INV_FLUJO<T>)

[Acciones.Cta.ConceptoGastos]
Nombre=Cta.ConceptoGastos
Boton=0
Menu=&Cuentas
NombreDesplegar=Conceptos (Gastos)
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoGAS
Activo=S
Visible=S

[Acciones.Herramienta.RespaldarDatos]
Nombre=Herramienta.RespaldarDatos
Boton=0
Menu=&Herramientas
NombreDesplegar=Respaldar Datos...
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=RespaldarDatos

[Acciones.Cubo.Compras]
Nombre=Cubo.Compras
Boton=0
Menu=C&ubos
NombreDesplegar=Compras
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>COMS<T>)
VisibleCondicion=CuboActivo(<T>COMS<T>)

[Acciones.Cubo.Inv]
Nombre=Cubo.Inv
Boton=0
Menu=C&ubos
NombreDesplegar=Inventarios
EnMenu=S
TipoAccion=Expresion
Activo=S
EspacioPrevio=S
Expresion=Cubo(<T>INV<T>)
VisibleCondicion=CuboActivo(<T>INV<T>)

[Acciones.Herramienta.Compras]
Nombre=Herramienta.Compras
Boton=0
Menu=&Herramientas
NombreDesplegar=C&ompras
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaCompras
Activo=S
Visible=S

[Acciones.Mov.Importaciones]
Nombre=Mov.Importaciones
Boton=0
Menu=&Procesos
NombreDesplegar=Importaciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=Compra
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.SubModuloVenta, <T>IMP<T>)<BR>Asigna(Info.ModuloComprasNombre, <T>Importaciones<T>)

[Acciones.Herramienta.Ford]
Nombre=Herramienta.Ford
Boton=0
Menu=&Herramientas
NombreDesplegar=Ford
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=Ford
ActivoCondicion=General.Ford
VisibleCondicion=General.Ford

[Acciones.Cubo.Servicios]
Nombre=Cubo.Servicios
Boton=0
Menu=C&ubos
NombreDesplegar=&Servicios
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>SERV<T>)
VisibleCondicion=CuboActivo(<T>SERV<T>)

[Acciones.Cubo.Personal]
Nombre=Cubo.Personal
Boton=0
Menu=C&ubos
NombreDesplegar=Persona&l
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>PER<T>)
VisibleCondicion=CuboActivo(<T>PER<T>)

[Acciones.Cubo.SerieLote]
Nombre=Cubo.SerieLote
Boton=0
Menu=C&ubos
NombreDesplegar=Series y Lo&tes
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>SL<T>)
VisibleCondicion=CuboActivo(<T>SL<T>)

[Acciones.Cubo.Comisiones]
Nombre=Cubo.Comisiones
Boton=0
Menu=C&ubos
NombreDesplegar=Comisiones y &Destajos
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>AGENT<T>)
VisibleCondicion=CuboActivo(<T>AGENT<T>)

[Acciones.Exp.Autotransportes]
Nombre=Exp.Autotransportes
Boton=0
Menu=&Exploradores
NombreDesplegar=&Autotransportes
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpAuto
Activo=S
VisibleCondicion=General.Autotransportes

[Acciones.Herramienta.Autotransportes]
Nombre=Herramienta.Autotransportes
Boton=0
Menu=&Herramientas
NombreDesplegar=&Autotransportes
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientasAuto
Activo=S
VisibleCondicion=General.Autotransportes

[Acciones.Cubo.Autotransportes]
Nombre=Cubo.Autotransportes
Boton=0
Menu=C&ubos
NombreDesplegar=&Autotransportes
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>AUTO_RESULTADO<T>)
VisibleCondicion=General.Autotransportes y CuboActivo(<T>AUTO_RESULTADO<T>)

[Acciones.Herramienta.RH]
Nombre=Herramienta.RH
Boton=0
Menu=&Herramientas
NombreDesplegar=Recursos &Humanos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaRH
Activo=S
Visible=S

[Acciones.Cubo.Contabilidad]
Nombre=Cubo.Contabilidad
Boton=0
Menu=C&ubos
NombreDesplegar=Co&ntabilidad
EnMenu=S
TipoAccion=Expresion
Activo=S
EspacioPrevio=S
Expresion=Cubo(<T>CONT<T>)
VisibleCondicion=CuboActivo(<T>CONT<T>)

[Acciones.Cubo.Art]
Nombre=Cubo.Art
Boton=0
Menu=C&ubos
NombreDesplegar=Artículos
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Cubo(<T>ART<T>)

[Acciones.Config.Prod]
Nombre=Config.Prod
Boton=0
Menu=C&onfigurar
NombreDesplegar=Producción
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgProd
Activo=S
Visible=S

[Acciones.Herramienta.GenerarArchivo]
Nombre=Herramienta.GenerarArchivo
Boton=0
Menu=&Herramientas
NombreDesplegar=Generar Archivo...
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=GuardarLista(SQLEnLista(<T>xpGenerarArchivo :nEstacion, :tEmp, :nSucursal, :tUsuario<T>, EstacionTrabajo, Empresa, Sucursal, Usuario), <T><T>, <T><T>, <T>txt<T>, <T>Texto<T>, <T>Texto<T>)

[Acciones.Mov.CR]
Nombre=Mov.CR
Boton=0
Menu=&Procesos
NombreDesplegar=Cajas &Registradoras
EnMenu=S
TipoAccion=Formas
ClaveAccion=CR
ActivoCondicion=General.CR
VisibleCondicion=General.CR

[Acciones.Cubo.VIN]
Nombre=Cubo.VIN
Boton=0
NombreDesplegar=VIN
EnMenu=S
TipoAccion=Expresion
Activo=S
Menu=C&ubos
Expresion=Cubo(<T>VIN<T>)
VisibleCondicion=Config.VIN

[Acciones.Cubo.EvaluacionServicio]
Nombre=Cubo.EvaluacionServicio
Boton=0
NombreDesplegar=Evaluación de Servicios
EnMenu=S
TipoAccion=Expresion
Menu=C&ubos
Expresion=Cubo(<T>SERVEVA<T>)
ActivoCondicion=General.Ford
VisibleCondicion=CuboActivo(<T>SERVEVA<T>)

[Acciones.Herramienta.TorreControl]
Nombre=Herramienta.TorreControl
Boton=0
Menu=&Herramientas
NombreDesplegar=&Torre Control
EnMenu=S
TipoAccion=Formas
ClaveAccion=TorreControl
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Cubo.Clientes]
Nombre=Cubo.Clientes
Boton=0
Menu=C&ubos
NombreDesplegar=Clientes
EnMenu=S
TipoAccion=Expresion
Activo=S
EspacioPrevio=S
Expresion=Cubo(<T>CTE<T>)
VisibleCondicion=CuboActivo(<T>CTE<T>)

[Acciones.Cubo.Almacenes]
Nombre=Cubo.Almacenes
Boton=0
Menu=C&ubos
NombreDesplegar=Almacenes
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>ALM<T>)
VisibleCondicion=CuboActivo(<T>ALM<T>)

[Acciones.Cubo.MovimientosProyectos]
Nombre=Cubo.MovimientosProyectos
Boton=0
Menu=C&ubos
NombreDesplegar=Pro&yectos (Movimientos)
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>PROY<T>)
VisibleCondicion=CuboActivo(<T>PROY<T>)

[Acciones.Cubo.Proyectos]
Nombre=Cubo.Proyectos
Boton=0
Menu=C&ubos
NombreDesplegar=Proyectos
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>MPROY<T>)
VisibleCondicion=CuboActivo(<T>MPROY<T>)

[Acciones.Cubo.Proveedores]
Nombre=Cubo.Proveedores
Boton=0
Menu=C&ubos
NombreDesplegar=Proveedores
EnMenu=S
TipoAccion=Expresion
Expresion=Cubo(<T>PROV<T>)
Activo=S
VisibleCondicion=CuboActivo(<T>PROV<T>)

[Acciones.Cubo.Agentes]
Nombre=Cubo.Agentes
Boton=0
Menu=C&ubos
NombreDesplegar=Agentes
EnMenu=S
TipoAccion=Expresion
Expresion=Cubo(<T>MAGENTE<T>)
Activo=S
VisibleCondicion=CuboActivo(<T>MAGENTE<T>)

[Acciones.Cubo.Retardos]
Nombre=Cubo.Retardos
Boton=0
Menu=C&ubos
NombreDesplegar=Retardos
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>RETARDO<T>)
VisibleCondicion=CuboActivo(<T>RETARDO<T>)

[Acciones.Cubo.IVA]
Nombre=Cubo.IVA
Boton=0
Menu=C&ubos
NombreDesplegar=IVA
EnMenu=S
TipoAccion=Expresion
Expresion=Cubo(<T>IVA<T>)
Activo=S
VisibleCondicion=CuboActivo(<T>IVA<T>)

[Acciones.Config.Dinero]
Nombre=Config.Dinero
Boton=0
Menu=C&onfigurar
NombreDesplegar=Tesoreria
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgDinero
Activo=S
Visible=S

[Acciones.Cubo.ConceptosGastos]
Nombre=Cubo.ConceptosGastos
Boton=0
Menu=C&ubos
NombreDesplegar=Conceptos (Gastos)
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Cubo(<T>CPTOGAS<T>)
ActivoCondicion=CuboActivo(<T>CPTOGAS<T>)

[Acciones.Herramienta.Recurrentes]
Nombre=Herramienta.Recurrentes
Boton=0
Menu=&Herramientas
NombreDesplegar=Movimientos Recurrentes
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovRecurrente
Activo=S
Visible=S

[Acciones.Cubo.Cambios]
Nombre=Cubo.Cambios
Boton=0
Menu=C&ubos
NombreDesplegar=Cambios
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Cubo(<T>CAM<T>)
VisibleCondicion=General.Cambios y CuboActivo(<T>CAM<T>)

[Acciones.Exp.CR]
Nombre=Exp.CR
Boton=0
Menu=&Exploradores
NombreDesplegar=Cajas &Registradoras
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpCR
Activo=S
Visible=S

[Acciones.Herramienta.Actividades]
Nombre=Herramienta.Actividades
Boton=0
Menu=&Herramientas
NombreDesplegar=Actividades - Movimientos Pendientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaActividad
Activo=S
Visible=S

[Acciones.Herramienta.ScoreBoard]
Nombre=Herramienta.ScoreBoard
Boton=0
Menu=&Herramientas
NombreDesplegar=Score Board
EnMenu=S
TipoAccion=Expresion
Expresion=PlugIn(<T>SB<T>)
Activo=S
Visible=S

[Acciones.Mov.ControlCalidad]
Nombre=Mov.ControlCalidad
Boton=0
Menu=&Procesos
NombreDesplegar=Control Calidad
EnMenu=S
TipoAccion=Formas
ClaveAccion=Compra
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.SubModuloVenta, <T>CC<T>)<BR>Asigna(Info.ModuloComprasNombre, <T>Control Calidad<T>)

[Acciones.Cubo.CR]
Nombre=Cubo.CR
Boton=0
Menu=C&ubos
NombreDesplegar=Cajas &Registradoras
EnMenu=S
TipoAccion=Expresion
Expresion=Cubo(<T>CR<T>)
ActivoCondicion=General.CR
VisibleCondicion=General.CR y CuboActivo(<T>CR<T>)

[Acciones.Exp.VIN]
Nombre=Exp.VIN
Boton=0
Menu=&Exploradores
NombreDesplegar=Unidades (VINs)
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarVIN
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+U
ActivoCondicion=Config.VIN
VisibleCondicion=Config.VIN

[Acciones.Herramienta.Chrysler]
Nombre=Herramienta.Chrysler
Boton=0
Menu=&Herramientas
NombreDesplegar=Chrysler
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=Chrysler
ActivoCondicion=General.Chrysler
VisibleCondicion=General.Chrysler

[Acciones.Cta.LineasCredito]
Nombre=Cta.LineasCredito
Boton=0
Menu=&Cuentas
NombreDesplegar=Líneas de Crédito
EnMenu=S
TipoAccion=Formas
ClaveAccion=LC
ActivoCondicion=General.AC
VisibleCondicion=General.AC

[Acciones.Cta.TipoAmortizacion]
Nombre=Cta.TipoAmortizacion
Boton=0
Menu=&Cuentas
NombreDesplegar=Tipos de Amortizaciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=TipoAmortizacion
ActivoCondicion=General.AC
VisibleCondicion=General.AC

[Acciones.Cta.TipoTasa]
Nombre=Cta.TipoTasa
Boton=0
Menu=&Cuentas
NombreDesplegar=Tipos de Tasa
EnMenu=S
TipoAccion=Formas
ClaveAccion=TipoTasa
ActivoCondicion=General.AC
VisibleCondicion=General.AC

[Acciones.Herramienta.CabinaMando]
Nombre=Herramienta.CabinaMando
Boton=0
Menu=&Herramientas
NombreDesplegar=Cabina Mando
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=PlugIn(<T>CM<T>)

[Acciones.Herramienta.Prod]
Nombre=Herramienta.Prod
Boton=0
Menu=&Herramientas
NombreDesplegar=&Producción
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientasProd
Activo=S
Visible=S

[Acciones.Cta.Rep]
Nombre=Cta.Rep
Boton=0
Menu=&Cuentas
NombreDesplegar=&Reportes
EnMenu=S
TipoAccion=Formas
ClaveAccion=Rep
Activo=S
Visible=S

[Acciones.Cta.Socio]
Nombre=Cta.Socio
Boton=0
Menu=&Cuentas
NombreDesplegar=&Socios
EnMenu=S
TipoAccion=Formas
ClaveAccion=Socio
Activo=S
Visible=S

[Acciones.Herramienta.Embarques]
Nombre=Herramienta.Embarques
Boton=0
NombreDesplegar=&Embarques
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientasEmbarques
Activo=S
Visible=S
Menu=&Herramientas

[Acciones.Mov.Taller]
Nombre=Mov.Taller
Boton=0
Menu=&Procesos
NombreDesplegar=&Taller
EnMenu=S
TipoAccion=Formas
ClaveAccion=Venta
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.SubModuloVenta, <T>TALL<T>)<BR>Asigna(Info.ModuloVentasNombre, <T>Taller<T>)
Visible=S

[Acciones.Rep.Auditoria]
Nombre=Rep.Auditoria
Boton=0
Menu=&Reportes
NombreDesplegar=&Auditoría
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepAuditoria
Activo=S
Visible=S

[Acciones.Mov.Mermas]
Nombre=Mov.Mermas
Boton=0
Menu=&Procesos
NombreDesplegar=Mermas
EnMenu=S
TipoAccion=Formas
ClaveAccion=Inv
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.SubModuloInv, <T>MERMA<T>)<BR>Asigna(Info.ModuloInventariosNombre, <T>Mermas<T>)

[Acciones.Mov.Mantenimiento]
Nombre=Mov.Mantenimiento
Boton=0
Menu=&Procesos
NombreDesplegar=Mantenimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=Gasto
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.SubModuloGasto, <T>MANT<T>)<BR>Asigna(Info.ModuloGastosNombre, <T>Mantenimiento<T>)

[Acciones.Mov.Capital]
Nombre=Mov.Capital
Boton=0
Menu=&Procesos
NombreDesplegar=Capital
EnMenu=S
TipoAccion=Formas
ClaveAccion=Capital
ActivoCondicion=General.Capital
VisibleCondicion=General.Capital

[Acciones.Config.Capital]
Nombre=Config.Capital
Boton=0
Menu=C&onfigurar
NombreDesplegar=Capital
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgCapital
ActivoCondicion=General.Capital
VisibleCondicion=General.Capital

[Acciones.Herramienta.AdmonCreditos]
Nombre=Herramienta.AdmonCreditos
Boton=0
Menu=&Herramientas
NombreDesplegar=Administración Créditos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaAC
ActivoCondicion=General.AC
VisibleCondicion=General.AC

[Acciones.Herramienta.EnviarCorreo]
Nombre=Herramienta.EnviarCorreo
Boton=0
Menu=&Herramientas
NombreDesplegar=Enviar Correo (en Lotes)
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=EnviarCorreo
Activo=S
Visible=S

[Acciones.Cta.OutlookNombre]
Nombre=Cta.OutlookNombre
Boton=0
Menu=&Cuentas
NombreDesplegar=&Nombres (Outlook)
EnMenu=S
TipoAccion=Formas
ClaveAccion=OutlookNombre
Activo=S
Visible=S

[Acciones.Herramienta.Gastos]
Nombre=Herramienta.Gastos
Boton=0
Menu=&Herramientas
NombreDesplegar=&Gastos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaGasto
Activo=S
Visible=S

[Acciones.Herramienta.CerrarMes]
Nombre=Herramienta.CerrarMes
Boton=0
Menu=&Herramientas
NombreDesplegar=Cerrar &Mes
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=CerrarMes
Activo=S
Visible=S

[Acciones.Mov.Incidencia]
Nombre=Mov.Incidencia
Boton=0
Menu=&Procesos
NombreDesplegar=Incidencias
EnMenu=S
TipoAccion=Formas
ClaveAccion=Incidencia
Activo=S
VisibleCondicion=General.NomAuto

[Acciones.Herramienta.MovMover]
Nombre=Herramienta.MovMover
Boton=0
Menu=&Herramientas
NombreDesplegar=&Mover Movimientos (Operación / Histórico)
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovMover
Activo=S
Visible=S

[Acciones.Config.RH]
Nombre=Config.RH
Boton=0
Menu=C&onfigurar
NombreDesplegar=Recursos Humanos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgRH
Activo=S
Visible=S

[Acciones.Herramienta.Tareas]
Nombre=Herramienta.Tareas
Boton=0
Menu=&Herramientas
NombreDesplegar=&Tareas
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.PuedeEditar, Verdadero))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Forma(<T>Tarea<T>)
Activo=S
Visible=S

[Acciones.Herramienta.Agenda]
Nombre=Herramienta.Agenda
Boton=0
Menu=&Herramientas
NombreDesplegar=Agenda
EnMenu=S
TipoAccion=Expresion
Expresion=PlugIn(<T>Agenda<T>)
Activo=S
Visible=S

[Acciones.Herramienta.Monitor]
Nombre=Herramienta.Monitor
Boton=0
Menu=&Herramientas
NombreDesplegar=Monitor
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaMonitor
Activo=S
Visible=S

[Acciones.Herramienta.Hasp]
Nombre=Herramienta.Hasp
Boton=0
Menu=&Herramientas
NombreDesplegar=&HASP<T>s
EnMenu=S
TipoAccion=Formas
ClaveAccion=Hasp
Activo=S
VisibleCondicion=General.HASP

[Acciones.Herramienta.BusinessPlan]
Nombre=Herramienta.BusinessPlan
Boton=0
Menu=&Herramientas
NombreDesplegar=Business Plan
EnMenu=S
TipoAccion=Dialogos
EspacioPrevio=S
ClaveAccion=BPlan
Activo=S
Visible=S

[Acciones.Mov.Proyectos]
Nombre=Mov.Proyectos
Boton=0
Menu=&Procesos
NombreDesplegar=&Proyectos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Proyecto
Activo=S
VisibleCondicion=General.PM

[Acciones.Cta.Recursos]
Nombre=Cta.Recursos
Boton=0
Menu=&Cuentas
NombreDesplegar=&Recursos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Recurso
Activo=S
Visible=S

[Acciones.Config.Proyectos]
Nombre=Config.Proyectos
Boton=0
Menu=C&onfigurar
NombreDesplegar=Proyectos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgProyectos
Activo=S
VisibleCondicion=General.PM

[Acciones.Mov.Credito]
Nombre=Mov.Credito
Boton=0
Menu=&Procesos
NombreDesplegar=&Crédito
EnMenu=S
TipoAccion=Formas
ClaveAccion=Credito
ActivoCondicion=General.AC
VisibleCondicion=General.AC

[Acciones.Cta.Prospectos]
Nombre=Cta.Prospectos
Boton=0
Menu=&Cuentas
NombreDesplegar=P&rospectos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Prospecto
Activo=S
VisibleCondicion=General.CMP

[Acciones.Config.Campana]
Nombre=Config.Campana
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Campañas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgCampana
Activo=S
VisibleCondicion=General.CMP

[Acciones.Mov.Campana]
Nombre=Mov.Campana
Boton=0
Menu=&Procesos
NombreDesplegar=&Campañas
EnMenu=S
TipoAccion=Formas
ClaveAccion=Campana
Activo=S
EspacioPrevio=S
VisibleCondicion=General.CMP

[Acciones.Rep.Fiscales]
Nombre=Rep.Fiscales
Boton=0
Menu=&Reportes
NombreDesplegar=&Fiscales
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuRepFiscal
Activo=S
Visible=S

[Acciones.Herramienta.MenuVista]
Nombre=Herramienta.MenuVista
Boton=0
Menu=&Herramientas
NombreDesplegar=Menú &Vista
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=PlugIn(<T>MI<T>)
Visible=S

[Acciones.Herramienta.Ticker]
Nombre=Herramienta.Ticker
Boton=0
Menu=&Herramientas
NombreDesplegar=Ticker
EnMenu=S
TipoAccion=Formas
ClaveAccion=MenuTicker
Activo=S
Visible=S

[Acciones.Config.MenuVista]
Nombre=Config.MenuVista
Boton=0
NombreDesplegar=Menus (Vista)
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgMI
Activo=S
Menu=C&onfigurar
Visible=S

[Acciones.Mov.Oferta]
Nombre=Mov.Oferta
Boton=0
Menu=&Procesos
NombreDesplegar=&Ofertas
EnMenu=S
TipoAccion=Formas
ClaveAccion=Oferta
Activo=S
VisibleCondicion=General.OFER

[Acciones.Mov.RSS]
Nombre=Mov.RSS
Boton=0
Menu=&Procesos
NombreDesplegar=&Fuentes (RSS)
EnMenu=S
TipoAccion=Formas
ClaveAccion=RSS
Activo=S
Visible=S

[Acciones.Config.RSS]
Nombre=Config.RSS
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Fuentes (RSS)
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgRSS
Activo=S
Visible=S

[Acciones.Mov.Riesgos]
Nombre=Mov.Riesgos
Boton=0
Menu=&Procesos
NombreDesplegar=&Riesgos
EnMenu=S
TipoAccion=Formas
ClaveAccion=aroRiesgo
Activo=S
EspacioPrevio=S
VisibleCondicion=General.ARO

[Acciones.Hist.Venta]
Nombre=Hist.Venta
Boton=0
Menu=&Historico
NombreDesplegar=&Ventas
EnMenu=S
TipoAccion=Formas
ClaveAccion=hVenta
Activo=S
VisibleCondicion=SQL(<T>SELECT Hist FROM Modulo WHERE Modulo=:tModulo<T>, <T>VTAS<T>)

[Acciones.Hist.Compras]
Nombre=Hist.Compras
Boton=0
Menu=&Historico
NombreDesplegar=C&ompras
EnMenu=S
TipoAccion=Formas
ClaveAccion=hCompra
Activo=S
VisibleCondicion=SQL(<T>SELECT Hist FROM Modulo WHERE Modulo=:tModulo<T>, <T>COMS<T>)

[Acciones.Hist.Inventarios]
Nombre=Hist.Inventarios
Boton=0
Menu=&Historico
NombreDesplegar=&Inventarios
EnMenu=S
TipoAccion=Formas
ClaveAccion=hInv
Activo=S
VisibleCondicion=SQL(<T>SELECT Hist FROM Modulo WHERE Modulo=:tModulo<T>, <T>INV<T>)

[Acciones.Hist.Cxc]
Nombre=Hist.Cxc
Boton=0
Menu=&Historico
NombreDesplegar=&Cuentas por Cobrar
EnMenu=S
TipoAccion=Formas
ClaveAccion=hCxc
Activo=S
VisibleCondicion=SQL(<T>SELECT Hist FROM Modulo WHERE Modulo=:tModulo<T>, <T>CXC<T>)

[Acciones.Hist.Cxp]
Nombre=Hist.Cxp
Boton=0
Menu=&Historico
NombreDesplegar=Cuentas por &Pagar
EnMenu=S
TipoAccion=Formas
ClaveAccion=hCxp
Activo=S
VisibleCondicion=SQL(<T>SELECT Hist FROM Modulo WHERE Modulo=:tModulo<T>, <T>CXP<T>)

[Acciones.Hist.Nomina]
Nombre=Hist.Nomina
Boton=0
Menu=&Historico
NombreDesplegar=&Nómina
EnMenu=S
TipoAccion=Formas
ClaveAccion=hNomina
Activo=S
VisibleCondicion=SQL(<T>SELECT Hist FROM Modulo WHERE Modulo=:tModulo<T>, <T>NOM<T>)

[Acciones.Config.ARO]
Nombre=Config.ARO
Boton=0
Menu=C&onfigurar
NombreDesplegar=Administración Riesgos Operativos
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgARO
Activo=S
VisibleCondicion=General.ARO

[Acciones.Mov.EventosPerdida]
Nombre=Mov.EventosPerdida
Boton=0
Menu=&Procesos
NombreDesplegar=E&ventos Perdida
EnMenu=S
TipoAccion=Formas
ClaveAccion=aroEventoPerdida
Activo=S
VisibleCondicion=General.ARO

[Acciones.Config.Layout]
Nombre=Config.Layout
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Layout<T>s
EnMenu=S
TipoAccion=Formas
ClaveAccion=Layout
Activo=S
Visible=S

[Acciones.Config.FormaVirtual]
Nombre=Config.FormaVirtual
Boton=0
Menu=C&onfigurar
NombreDesplegar=Formas &Virtuales
EnMenu=S
TipoAccion=Formas
ClaveAccion=FormaVirtual
Activo=S
Visible=S

[Acciones.Config.ModuloCentral]
Nombre=Config.ModuloCentral
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Módulo Central
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgModuloCentral
ActivoCondicion=Version.ModuloCentral
VisibleCondicion=Version.ModuloCentral

[Acciones.Config.Ofertas]
Nombre=Config.Ofertas
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Ofertas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgOfertas
Activo=S
Visible=S

[Acciones.Config.BaseDatos]
Nombre=Config.BaseDatos
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Base Datos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Version
Activo=S
Visible=S

[Acciones.Config.Web]
Nombre=Config.Web
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Web
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgWeb
Activo=S
Visible=S

[Acciones.Cta.ProspectoExpress]
Nombre=Cta.ProspectoExpress
Boton=0
Menu=&Cuentas
NombreDesplegar=Prospecto E&xpress
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProspectoExpress
Activo=S
VisibleCondicion=General.CMP

[Acciones.Exp.Anexos]
Nombre=Exp.Anexos
Boton=0
Menu=&Exploradores
NombreDesplegar=Ane&xos
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarAnexos
Activo=S
Visible=S

[Acciones.Cubo.IntegracionContable]
Nombre=Cubo.IntegracionContable
Boton=0
Menu=C&ubos
NombreDesplegar=Integración Contable
EnMenu=S
TipoAccion=Expresion
Expresion=Cubo(<T>IC<T>)
ActivoCondicion=CuboActivo(<T>IC<T>)
Visible=S

[Acciones.Mov.Fiscal]
Nombre=Mov.Fiscal
Boton=0
Menu=&Procesos
NombreDesplegar=&Fiscal
EnMenu=S
TipoAccion=Formas
ClaveAccion=Fiscal
Activo=S
VisibleCondicion=General.Fiscal

[Acciones.Config.Fiscal]
Nombre=Config.Fiscal
Boton=0
Menu=C&onfigurar
NombreDesplegar=&Fiscal
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuCfgFiscal
Activo=S
VisibleCondicion=General.Fiscal

[Acciones.Herramienta.Fiscal]
Nombre=Herramienta.Fiscal
Boton=0
Menu=&Herramientas
NombreDesplegar=&Fiscal
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaFiscal
Activo=S
VisibleCondicion=General.Fiscal

[Acciones.Mov.FormasExtras]
Nombre=Mov.FormasExtras
Boton=0
Menu=&Procesos
NombreDesplegar=&Formas Extras
EnMenu=S
TipoAccion=Formas
ClaveAccion=FormaExtra
Activo=S
Visible=S

[Acciones.Herramienta.SincroSSB]
Nombre=Herramienta.SincroSSB
Boton=0
Menu=&Herramientas
NombreDesplegar=&Sincronización (Service Broker)
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaSincroSSB
ActivoCondicion=SQL(<T>SELECT SincroSSB FROM Version<T>)
Visible=S

[Acciones.Mov.Tarimas]
Nombre=Mov.Tarimas
Boton=0
Menu=&Procesos
NombreDesplegar=&Tarimas
EnMenu=S
TipoAccion=Formas
ClaveAccion=TMA
Activo=S
VisibleCondicion=General.WMS

[Acciones.Web.Paginas]
Nombre=Web.Paginas
Boton=0
Menu=&Web
NombreDesplegar=&Páginas
EnMenu=S
TipoAccion=Formas
ClaveAccion=WebPagina
Activo=S
Visible=S

[Acciones.Web.Sitios]
Nombre=Web.Sitios
Boton=0
Menu=&Web
NombreDesplegar=&Sitios
EnMenu=S
TipoAccion=Formas
ClaveAccion=WebSitio
Activo=S
Visible=S

[Acciones.Web.Usuarios]
Nombre=Web.Usuarios
Boton=0
Menu=&Web
NombreDesplegar=&Usuarios
EnMenu=S
TipoAccion=Formas
ClaveAccion=WebUsuario
Activo=S
Visible=S

[Acciones.Exp.Campana]
Nombre=Exp.Campana
Boton=0
Menu=&Exploradores
NombreDesplegar=&Campañas
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuExpCampana
Activo=S
Visible=S

[Acciones.Mov.Gestion]
Nombre=Mov.Gestion
Boton=0
Menu=&Procesos
NombreDesplegar=&Gestión
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Gestion
Activo=S
VisibleCondicion=General.GES



[Acciones.Cta.CentrosCostos2]
Nombre=Cta.CentrosCostos2
Boton=0
Menu=&Cuentas
NombreDesplegar=Centros C&ostos 2
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si(Config.CentroCostosRamas, Forma(<T>CentroCostos2Rama<T>), Forma(<T>CentroCostos2<T>))

[Acciones.Cta.CentrosCostos3]
Nombre=Cta.CentrosCostos3
Boton=0
Menu=&Cuentas
NombreDesplegar=Centros C&ostos 3
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si(Config.CentroCostosRamas, Forma(<T>CentroCostos3Rama<T>), Forma(<T>CentroCostos3<T>))

[Lista.Columnas]
CentroCostos2=125
Descripcion=243





[Acciones.Herramienta.SincroIS]
Nombre=Herramienta.SincroIS
Boton=0
Menu=&Herramientas
NombreDesplegar=Sincronización (&Intelisis Service)
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MenuHerramientaSincroIS
ActivoCondicion=SQL(<T>SELECT SincroIS FROM Version<T>)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Mov.Ventas
Mov.Ventas=Mov.Autotransportes
Mov.Autotransportes=Mov.PuntoVenta
Mov.PuntoVenta=Mov.Servicios
Mov.Servicios=Mov.VentaSurtirCB
Mov.VentaSurtirCB=Mov.DevVenta
Mov.DevVenta=Mov.CR
Mov.CR=Mov.Embarque
Mov.Embarque=Mov.PC
Mov.PC=Mov.Oferta
Mov.Oferta=Mov.Vales
Mov.Vales=Mov.Gestion
Mov.Gestion=Mov.AtnClientes
Mov.AtnClientes=Mov.RSS
Mov.RSS=Mov.Campana
Mov.Campana=Mov.FormasExtras
Mov.FormasExtras=Mov.Proyectos
Mov.Proyectos=Mov.Dinero
Mov.Dinero=Mov.Credito
Mov.Credito=Mov.Capital
Mov.Capital=Mov.Cxc
Mov.Cxc=Mov.Cxp
Mov.Cxp=Mov.Comisiones
Mov.Comisiones=Mov.Gasto
Mov.Gasto=Mov.Mantenimiento
Mov.Mantenimiento=Mov.Inventarios
Mov.Inventarios=Mov.Tarimas
Mov.Tarimas=Mov.Mermas
Mov.Mermas=Mov.ActivoFijo
Mov.ActivoFijo=Mov.Taller
Mov.Taller=Mov.Compras
Mov.Compras=Mov.Importaciones
Mov.Importaciones=Mov.ControlCalidad
Mov.ControlCalidad=Mov.AtnProveedores
Mov.AtnProveedores=Mov.Planeador
Mov.Planeador=Mov.Produccion
Mov.Produccion=Mov.AtnProyectos
Mov.AtnProyectos=Mov.Nomina
Mov.Nomina=Mov.Incidencia
Mov.Incidencia=Mov.Acceso
Mov.Acceso=Mov.Asiste
Mov.Asiste=Mov.RH
Mov.RH=Mov.AtnPersonal
Mov.AtnPersonal=Mov.ServiciosInternos
Mov.ServiciosInternos=Mov.Contabilidad
Mov.Contabilidad=Mov.Fiscal
Mov.Fiscal=Mov.Conciliaciones
Mov.Conciliaciones=Mov.Riesgos
Mov.Riesgos=Mov.EventosPerdida
Mov.EventosPerdida=Mov.Otros
Mov.Otros=Mov.Salir
Mov.Salir=Hist.Venta
Hist.Venta=Hist.Compras
Hist.Compras=Hist.Inventarios
Hist.Inventarios=Hist.Cxc
Hist.Cxc=Hist.Cxp
Hist.Cxp=Hist.Nomina
Hist.Nomina=Exp.Ventas
Exp.Ventas=Exp.Autotransportes
Exp.Autotransportes=Exp.Servicio
Exp.Servicio=Exp.CR
Exp.CR=Exp.Atn
Exp.Atn=Exp.Campana
Exp.Campana=Exp.Embarque
Exp.Embarque=Exp.Dinero
Exp.Dinero=Exp.Cxc
Exp.Cxc=Exp.Cxp
Exp.Cxp=Exp.Comisiones
Exp.Comisiones=Exp.Gastos
Exp.Gastos=Exp.Inventarios
Exp.Inventarios=Exp.ActivoFijo
Exp.ActivoFijo=Exp.Compras
Exp.Compras=Exp.Produccion
Exp.Produccion=Exp.Nomina
Exp.Nomina=Exp.RH
Exp.RH=Exp.Contabilidad
Exp.Contabilidad=Exp.Fiscal
Exp.Fiscal=Exp.Gerenciales
Exp.Gerenciales=Exp.Articulos
Exp.Articulos=Exp.VIN
Exp.VIN=Exp.Espacios
Exp.Espacios=Exp.Clientes
Exp.Clientes=Exp.Proveedores
Exp.Proveedores=Exp.CtaDinero
Exp.CtaDinero=Exp.Almacenes
Exp.Almacenes=Exp.Agentes
Exp.Agentes=Exp.Personal
Exp.Personal=Exp.CtaContables
Exp.CtaContables=Exp.Proy
Exp.Proy=Exp.ValeSerie
Exp.ValeSerie=Exp.Documentacion
Exp.Documentacion=Exp.Anexos
Exp.Anexos=Exp.Otros
Exp.Otros=Cubo.Ventas
Cubo.Ventas=Cubo.Autotransportes
Cubo.Autotransportes=Cubo.Servicios
Cubo.Servicios=Cubo.EvaluacionServicio
Cubo.EvaluacionServicio=Cubo.AtnClientes
Cubo.AtnClientes=Cubo.CR
Cubo.CR=Cubo.Embarques
Cubo.Embarques=Cubo.Tesoreria
Cubo.Tesoreria=Cubo.Cxc
Cubo.Cxc=Cubo.Cxp
Cubo.Cxp=Cubo.Inv
Cubo.Inv=Cubo.FlujoInv
Cubo.FlujoInv=Cubo.SerieLote
Cubo.SerieLote=Cubo.ActivoFijo
Cubo.ActivoFijo=Cubo.Compras
Cubo.Compras=Cubo.Gastos
Cubo.Gastos=Cubo.Nomina
Cubo.Nomina=Cubo.Retardos
Cubo.Retardos=Cubo.Personal
Cubo.Personal=Cubo.Comisiones
Cubo.Comisiones=Cubo.Contabilidad
Cubo.Contabilidad=Cubo.IntegracionContable
Cubo.IntegracionContable=Cubo.IVA
Cubo.IVA=Cubo.MovimientosProyectos
Cubo.MovimientosProyectos=Cubo.Clientes
Cubo.Clientes=Cubo.Proveedores
Cubo.Proveedores=Cubo.Agentes
Cubo.Agentes=Cubo.Art
Cubo.Art=Cubo.Almacenes
Cubo.Almacenes=Cubo.VIN
Cubo.VIN=Cubo.ConceptosGastos
Cubo.ConceptosGastos=Cubo.Proyectos
Cubo.Proyectos=Cubo.Cambios
Cubo.Cambios=Rep.Ventas
Rep.Ventas=Rep.Servicio
Rep.Servicio=Rep.PC
Rep.PC=Rep.Embarque
Rep.Embarque=Rep.Dinero
Rep.Dinero=Rep.Cxc
Rep.Cxc=Rep.Cxp
Rep.Cxp=Rep.Comisiones
Rep.Comisiones=Rep.Gastos
Rep.Gastos=Rep.Inventarios
Rep.Inventarios=Rep.ActivoFijo
Rep.ActivoFijo=Rep.Compras
Rep.Compras=Rep.Produccion
Rep.Produccion=Rep.Nomina
Rep.Nomina=Rep.Asiste
Rep.Asiste=Rep.RH
Rep.RH=Rep.Contabilidad
Rep.Contabilidad=Rep.Fiscales
Rep.Fiscales=Rep.Gerenciales
Rep.Gerenciales=Rep.Auditoria
Rep.Auditoria=Rep.Art
Rep.Art=Rep.Otros
Rep.Otros=Cta.Clientes
Cta.Clientes=Cta.Proveedores
Cta.Proveedores=Cta.Agentes
Cta.Agentes=Cta.Personal
Cta.Personal=Cta.Recursos
Cta.Recursos=Cta.Prospectos
Cta.Prospectos=Cta.ProspectoExpress
Cta.ProspectoExpress=Cta.Socio
Cta.Socio=Cta.OutlookNombre
Cta.OutlookNombre=Cta.Articulos
Cta.Articulos=Cta.Espacio
Cta.Espacio=Cta.ActivoF
Cta.ActivoF=Cta.Almacenes
Cta.Almacenes=Cta.Rep
Cta.Rep=Cta.VIN
Cta.VIN=Cta.Dinero
Cta.Dinero=Cta.ConceptoGastos
Cta.ConceptoGastos=Cta.CentroCostos
Cta.CentroCostos=Cta.CentrosCostos2
Cta.CentrosCostos2=Cta.CentrosCostos3
Cta.CentrosCostos3=Cta.Proy
Cta.Proy=Cta.ProdEstacion
Cta.ProdEstacion=Cta.ProdCentro
Cta.ProdCentro=Cta.ProdRuta
Cta.ProdRuta=Cta.LineasCredito
Cta.LineasCredito=Cta.TipoTasa
Cta.TipoTasa=Cta.TipoAmortizacion
Cta.TipoAmortizacion=Cta.Contables
Cta.Contables=Cta.Otros
Cta.Otros=Web.Sitios
Web.Sitios=Web.Paginas
Web.Paginas=Web.Usuarios
Web.Usuarios=Herramienta.MenuVista
Herramienta.MenuVista=Herramienta.Ticker
Herramienta.Ticker=Herramienta.Hasp
Herramienta.Hasp=Herramienta.Tareas
Herramienta.Tareas=Herramienta.Agenda
Herramienta.Agenda=Herramienta.Paginas
Herramienta.Paginas=Herramienta.Calculadora
Herramienta.Calculadora=Herramienta.Calendario
Herramienta.Calendario=Herramienta.ScoreBoard
Herramienta.ScoreBoard=Herramienta.CabinaMando
Herramienta.CabinaMando=Herramienta.TipoCambio
Herramienta.TipoCambio=Herramienta.Recurrentes
Herramienta.Recurrentes=Herramienta.EstatusImpresiones
Herramienta.EstatusImpresiones=Herramienta.Monitor
Herramienta.Monitor=Herramienta.RespaldarDatos
Herramienta.RespaldarDatos=Herramienta.MovMover
Herramienta.MovMover=Herramienta.BusinessPlan
Herramienta.BusinessPlan=Herramienta.Venta
Herramienta.Venta=Herramienta.VentaMostrador
Herramienta.VentaMostrador=Herramienta.Autotransportes
Herramienta.Autotransportes=Herramienta.Embarques
Herramienta.Embarques=Herramienta.Dinero
Herramienta.Dinero=Herramienta.Cxc
Herramienta.Cxc=Herramienta.Cxp
Herramienta.Cxp=Herramienta.Gastos
Herramienta.Gastos=Herramienta.Inv
Herramienta.Inv=Herramienta.Prod
Herramienta.Prod=Herramienta.Compras
Herramienta.Compras=Herramienta.AdmonCreditos
Herramienta.AdmonCreditos=Herramienta.Fiscal
Herramienta.Fiscal=Herramienta.Contabilidad
Herramienta.Contabilidad=Herramienta.Nomina
Herramienta.Nomina=Herramienta.RH
Herramienta.RH=Herramienta.Exportar
Herramienta.Exportar=Herramienta.Importar
Herramienta.Importar=Herramienta.GenerarArchivo
Herramienta.GenerarArchivo=Herramienta.GenerarPolizas
Herramienta.GenerarPolizas=Herramienta.SincroSSB
Herramienta.SincroSSB=Herramienta.SincroIS
Herramienta.SincroIS=Herramienta.CerrarDia
Herramienta.CerrarDia=Herramienta.CerrarMes
Herramienta.CerrarMes=Herramienta.TraspasarAcumulados
Herramienta.TraspasarAcumulados=Herramienta.TorreControl
Herramienta.TorreControl=Herramienta.Actividades
Herramienta.Actividades=Herramienta.EnviarCorreo
Herramienta.EnviarCorreo=Herramienta.Ford
Herramienta.Ford=Herramienta.Chrysler
Herramienta.Chrysler=Herramienta.Otros
Herramienta.Otros=Herramienta.CambiarUsuario
Herramienta.CambiarUsuario=Config.Empresas
Config.Empresas=Config.Sucursales
Config.Sucursales=Config.Usuarios
Config.Usuarios=Config.General
Config.General=Config.MenuVista
Config.MenuVista=Config.Politicas
Config.Politicas=Config.Planeacion
Config.Planeacion=Config.Consecutivos
Config.Consecutivos=Config.Movimientos
Config.Movimientos=Config.Situaciones
Config.Situaciones=Config.Conceptos
Config.Conceptos=Config.Observaciones
Config.Observaciones=Config.Documentacion
Config.Documentacion=Config.Layout
Config.Layout=Config.Ventas
Config.Ventas=Config.Servicio
Config.Servicio=Config.PC
Config.PC=Config.Ofertas
Config.Ofertas=Config.Atn
Config.Atn=Config.RSS
Config.RSS=Config.Campana
Config.Campana=Config.Proyectos
Config.Proyectos=Config.Embarque
Config.Embarque=Config.Dinero
Config.Dinero=Config.Capital
Config.Capital=Config.Cxc
Config.Cxc=Config.Cxp
Config.Cxp=Config.Gastos
Config.Gastos=Config.Compras
Config.Compras=Config.Nomina
Config.Nomina=Config.RH
Config.RH=Config.Prod
Config.Prod=Config.Autotransportes
Config.Autotransportes=Config.ARO
Config.ARO=Config.Fiscal
Config.Fiscal=Config.Web
Config.Web=Config.GeneradorReportes
Config.GeneradorReportes=Config.FormaVirtual
Config.FormaVirtual=Config.GeneradorVistasEspeciales
Config.GeneradorVistasEspeciales=Config.GeneradoNomina
Config.GeneradoNomina=Config.ConexionContable
Config.ConexionContable=Config.ContabilidadAutomatica
Config.ContabilidadAutomatica=Config.ModuloCentral
Config.ModuloCentral=Config.BaseDatos
Config.BaseDatos=Config.Otros
Config.Otros=Ayuda.Ayuda
Ayuda.Ayuda=Ayuda.Acerca
Ayuda.Acerca=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Procesos
&Procesos=&Historico
&Historico=&Exploradores
&Exploradores=C&ubos
C&ubos=&Reportes
&Reportes=&Cuentas
&Cuentas=&Web
&Web=&Herramientas
&Herramientas=C&onfigurar
C&onfigurar=Ay&uda
Ay&uda=(Fin)
