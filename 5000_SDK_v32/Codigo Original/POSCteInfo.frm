
[Forma]
Clave=POSCteInfo
Nombre=<T>Información del <T>+POSCteInfo:Cte.Tipo
Icono=6
Modulos=(Todos)
PosicionInicialIzquierda=1814
PosicionInicialArriba=237
PosicionInicialAltura=454
PosicionInicialAncho=852
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=43
Comentarios=Info.Cliente
Menus=S
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=511
VentanaAjustarZonas=S
PosicionCol1=354

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSWSSolicitudCteInfo :tEmpresa, :tCliente,:tUsuario, :nEstacion, :nSucursal<T>,Empresa,Info.Cliente,Usuario,EstacionTrabajo,Sucursal)
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCteInfo
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30

FiltroGeneral=Cte.Cliente=<T>{Info.Cliente}<T>  
[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
Efectos=[Negritas]

[Ficha.Cte.Telefonos]
Carpeta=Ficha
Clave=Cte.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Cte.Contacto1]
Carpeta=Ficha
Clave=Cte.Contacto1
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

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

[Ficha.EstatusNombre]
Carpeta=Ficha
Clave=EstatusNombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Cte.Categoria]
Carpeta=Ficha
Clave=Cte.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
EspacioPrevio=N

[Ficha.Cte.Familia]
Carpeta=Ficha
Clave=Cte.Familia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Cte.Grupo]
Carpeta=Ficha
Clave=Cte.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
EspacioPrevio=S

[Notas.Cte.Notas]
Carpeta=Notas
Clave=Cte.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41x10
ColorFondo=Plata
ConScroll=S

[Notas.Cte.Mensaje]
Carpeta=Notas
Clave=Cte.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ConScroll=S

[Cxc.Columnas]
0=85
1=71

[Ventas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos ventas
Clave=Ventas
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCteInfo
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)

[Ventas.Columnas]
Cliente=64
Nombre=364
Direccion=1504
Colonia=184
CodigoPostal=69
Poblacion=184
Estado=184
Pais=184
Zona=304
RFC=94
Telefonos=604
Fax=184
PedirTono=64
Contacto1=304
Contacto2=304
eMail1=184
eMail2=184
DirInternet=304
Categoria=1504
Familia=304
Grupo=304
DiaRevision1=71
DiaRevision2=75
HorarioRevision=124
DiaPago1=64
DiaPago2=64
HorarioPago=124
ZonaImpuesto=304
Descuento=304
Moneda=64
ConLimiteCredito=67
LimiteCredito=67
Estatus=94
UltimoCambio=94
Proyecto=304
Agente=64
EnviarA=64
FormaEnvio=304
Condicion=304
AlmacenVtasConsignacion=113
Notas=304
Mensaje=304
Nombre_1=304
Nombre_2=364
EstatusNombre=94

[Ventas.Cte.DiaRevision1]
Carpeta=Ventas
Clave=Cte.DiaRevision1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata

[Ventas.Cte.DiaRevision2]
Carpeta=Ventas
Clave=Cte.DiaRevision2
Editar=S
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S

[Ventas.Cte.HorarioRevision]
Carpeta=Ventas
Clave=Cte.HorarioRevision
Editar=S
ValidaNombre=N
3D=S
Tamano=11
ColorFondo=Plata
Pegado=N

[Ventas.Cte.DiaPago1]
Carpeta=Ventas
Clave=Cte.DiaPago1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata

[Ventas.Cte.DiaPago2]
Carpeta=Ventas
Clave=Cte.DiaPago2
Editar=S
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S

[Ventas.Cte.HorarioPago]
Carpeta=Ventas
Clave=Cte.HorarioPago
Editar=S
ValidaNombre=N
3D=S
Tamano=11
ColorFondo=Plata
Pegado=N

[CxcInfo.Columnas]
0=121
1=35

[VentaPendiente]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ventas pendientes
Clave=VentaPendiente
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSVentaTemp
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroTipo=Automático
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroEstilo=Directorio
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroAplicaEn=POSVentaTemp.Moneda
MenuLocal=S
ListaAcciones=(Lista)
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasNormal=S
IconosConSenales=S

IconosNombre=POSVentaTemp:POSVentaTemp.Mov+<T> <T>+POSVentaTemp:POSVentaTemp.MovID
FiltroGeneral=POSVentaTemp.Empresa=<T>{Empresa}<T> AND<BR>POSVentaTemp.Cliente=<T>{Info.Cliente}<T>    AND<BR>POSVentaTemp.Estacion = {EstacionTrabajo}
CondicionVisible=POSCteInfo:Cte.Tipo<><T>Deudor<T>
[VentaPendiente.Columnas]
0=130
1=81


2=-2
3=132
[Credito]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Política Crédito
Clave=Credito
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCteInfo
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S


FiltroGeneral=POSCteCreditoTemp.Empresa=<T>{Empresa}<T> AND POSCteCredito.Credito=<T>{Cte:Cte.Credito}<T> AND POSCteCreditoTemp.Estacion = {EstacionTrabajo}
CondicionVisible=no CteInfo:Cte.CreditoEspecial
[Credito.Cte.Credito]
Carpeta=Credito
Clave=Cte.Credito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Cte.Direccion]
Carpeta=Ficha
Clave=Cte.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[Ficha.Cte.CodigoPostal]
Carpeta=Ficha
Clave=Cte.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S

[Ficha.Cte.Estado]
Carpeta=Ficha
Clave=Cte.Estado
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata

[Ficha.Cte.Pais]
Carpeta=Ficha
Clave=Cte.Pais
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Plata
Pegado=S

[Ficha.Cte.Colonia]
Carpeta=Ficha
Clave=Cte.Colonia
Editar=S
3D=S
Pegado=N
Tamano=10
ColorFondo=Plata
LineaNueva=S



[Acciones.Salir]
Nombre=Salir
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Ventas.Cte.PedidosParciales]
Carpeta=Ventas
Clave=Cte.PedidosParciales
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20

ColorFondo=Blanco

[Ventas.Cte.Agente]
Carpeta=Ventas
Clave=Cte.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata

[Ventas.Cte.Condicion]
Carpeta=Ventas
Clave=Cte.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata

[Ventas.Cte.Proyecto]
Carpeta=Ventas
Clave=Cte.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata



[VentaVigente]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contratos
Clave=VentaVigente
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSVentaTemp
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=POSVentaTemp.Vencimiento
FiltroFechasDefault=Vigente
FiltroFechasVencimiento=S
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
CarpetaDesActivada=S



IconosNombre=POSVentaTemp:POSVentaTemp.Mov+<T> <T>+POSVentaTemp:POSVentaTemp.MovID
FiltroGeneral=POSVentaTemp.Cliente=<T>{Info.Cliente}<T> AND POSVentaTemp.Estatus=<T>VIGENTE<T> AND  POSVentaTemp.Estacion = {EstacionTrabajo}
[VentaVigente.Columnas]
0=89
1=105



[SoportePendiente.Soporte.FechaEmision]
Carpeta=SoportePendiente
Clave=Soporte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[SoportePendiente.Soporte.Titulo]
Carpeta=SoportePendiente
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[SoportePendiente.Columnas]
0=118
1=81

[SoportePendiente.SoportePendiente.FechaEmision]
Carpeta=SoportePendiente
Clave=SoportePendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[SoportePendiente.SoportePendiente.Titulo]
Carpeta=SoportePendiente
Clave=SoportePendiente.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[SoportePendiente.SoportePendiente.Vencimiento]
Carpeta=SoportePendiente
Clave=SoportePendiente.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


[Soporte.Columnas]
0=121
1=81

[Soporte.Soporte.FechaEmision]
Carpeta=Soporte
Clave=Soporte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Vencimiento]
Carpeta=Soporte
Clave=Soporte.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Titulo]
Carpeta=Soporte
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VigenteProp]
Nombre=VigenteProp
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(POSVentaTemp:POSVentaTemp.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, POSVentaTemp:POSVentaTemp.ID)
[Acciones.SoporteProp]
Nombre=SoporteProp
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(SoporteA:Soporte.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, SoporteA:Soporte.ID)
Visible=S


[CobrosPosfechados]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cobros Posfechados
Clave=CobrosPosfechados
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSCteInfoTemp
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
MenuLocal=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
ListaAcciones=(Lista)
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroAplicaEn=POSCteInfoTemp.Moneda
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=POSCteInfoTemp.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroEstilo=Directorio

IconosNombre=POSCteInfoTemp:POSCteInfoTemp.Mov+<T> <T>+POSCteInfoTemp:POSCteInfoTemp.MovID
FiltroGeneral=POSCteInfoTemp.Mov IN ({MovListaSQL(<T>CXC<T>, CXC.NCP, CXC.DP)}) AND POSCteInfoTemp.Estacion = {EstacionTrabajo}<BR>AND POSCteInfoTemp.Cliente=<T>{Info.Cliente}<T>
CondicionVisible=Config.CxcPosfechados
[PorCobrar]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Por cobrar
Clave=PorCobrar
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSCteInfoTemp
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Mon
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=10
FiltroEstilo=Directorio
FiltroAplicaEn=POSCteInfoTemp.Moneda
FiltroRespetar=S
FiltroTipo=Automático
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=POSCteInfoTemp.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
ListaAcciones=(Lista)
CarpetaVisible=S
FiltroSituacionTodo=S
FiltroListaEstatus=PENDIENTE
FiltroEstatusDefault=PENDIENTE

IconosNombre=POSCteInfoTemp:POSCteInfoTemp.Mov+<T> <T>+POSCteInfoTemp:POSCteInfoTemp.MovID
FiltroGeneral=POSCteInfoTemp.Mov NOT IN ({MovListaSQL(<T>CXC<T>, CXC.NCP, CXC.DP)})  AND POSCteInfoTemp.Estacion = {EstacionTrabajo}  AND<BR>POSCteInfoTemp.Cliente=<T>{Info.Cliente}<T>
[PorCobrar.Dias]
Carpeta=PorCobrar
Clave=Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Totalizador=0

[PorCobrar.Moratorios]
Carpeta=PorCobrar
Clave=Moratorios
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.PosPropiedades]
Nombre=PosPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(fnCxcInfo2:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, fnCxcInfo2:ID)

[PorCobrar.Columnas]
0=109
1=40

2=-2
3=69
4=103
[CobrosPosfechados.Columnas]
0=135
1=82

2=-2
3=-2
[CreditoEspecial]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Crédito Especial
Clave=CreditoEspecial
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCteInfo
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CondicionVisible=CteInfo:Cte.CreditoEspecial
[CreditoEspecial.Cte.CreditoConLimite]
Carpeta=CreditoEspecial
Clave=Cte.CreditoConLimite
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Plata

[CreditoEspecial.Cte.CreditoLimite]
Carpeta=CreditoEspecial
Clave=Cte.CreditoLimite
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CreditoEspecial.Cte.CreditoMoneda]
Carpeta=CreditoEspecial
Clave=Cte.CreditoMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Plata

[CreditoEspecial.Cte.CreditoConDias]
Carpeta=CreditoEspecial
Clave=Cte.CreditoConDias
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Plata

[CreditoEspecial.Cte.CreditoDias]
Carpeta=CreditoEspecial
Clave=Cte.CreditoDias
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Plata

[CreditoEspecial.Cte.CreditoConCondiciones]
Carpeta=CreditoEspecial
Clave=Cte.CreditoConCondiciones
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Plata

[CreditoEspecial.Cte.CreditoCondiciones]
Carpeta=CreditoEspecial
Clave=Cte.CreditoCondiciones
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Plata


[Ficha.Cte.RFC]
Carpeta=Ficha
Clave=Cte.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]


[Embarques.EmbarqueMov.FechaEmision]
Carpeta=Embarques
Clave=EmbarqueMov.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Embarques.Dias]
Carpeta=Embarques
Clave=Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


[Embarques.Venta.FechaEmision]
Carpeta=Embarques
Clave=Venta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Embarques.Venta.EnviarA]
Carpeta=Embarques
Clave=Venta.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Embarques.Venta.FormaEnvio]
Carpeta=Embarques
Clave=Venta.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Embarques.Venta.Moneda]
Carpeta=Embarques
Clave=Venta.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Embarques.Venta.FechaEntrega]
Carpeta=Embarques
Clave=Venta.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Embarques.Columnas]
0=110
1=98

[Embarques.ImporteTotal]
Carpeta=Embarques
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Acciones.EmbarquePropiedades]
Nombre=EmbarquePropiedades
Boton=0
NombreDesplegar=Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(VentaEmbarque:Venta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaEmbarque:Venta.ID)

[Acciones.EmbarcarCampos]
Nombre=EmbarcarCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Embarques
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.CxcCampos]
Nombre=CxcCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=PorCobrar
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Embarques.Venta.EmbarqueEstado]
Carpeta=Embarques
Clave=Venta.EmbarqueEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro


[Habitos.Cxc.FechaEmision]
Carpeta=Habitos
Clave=Cxc.FechaEmision
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Habitos.Cxc.Referencia]
Carpeta=Habitos
Clave=Cxc.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[Habitos.Cxc.Vencimiento]
Carpeta=Habitos
Clave=Cxc.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Habitos.Cxc.FechaConclusion]
Carpeta=Habitos
Clave=Cxc.FechaConclusion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=2

[Habitos.Columnas]
0=106
1=71

[Habitos.DiasEmision]
Carpeta=Habitos
Clave=DiasEmision
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Habitos.ImporteTotal]
Carpeta=Habitos
Clave=ImporteTotal
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.HabitoPropiedades]
Nombre=HabitoPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDAtos(CxcA:Cxc.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, CxcA:Cxc.ID)
Visible=S

[Acciones.HabitoPersonalizar]
Nombre=HabitoPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Habitos.DiasRetraso]
Carpeta=Habitos
Clave=DiasRetraso
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


[CRM]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=CRM
Clave=CRM
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteInfo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[CRM.Cte.Descripcion1]
Carpeta=CRM
Clave=Cte.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion2]
Carpeta=CRM
Clave=Cte.Descripcion2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion3]
Carpeta=CRM
Clave=Cte.Descripcion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion4]
Carpeta=CRM
Clave=Cte.Descripcion4
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion5]
Carpeta=CRM
Clave=Cte.Descripcion5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion6]
Carpeta=CRM
Clave=Cte.Descripcion6
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion7]
Carpeta=CRM
Clave=Cte.Descripcion7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion8]
Carpeta=CRM
Clave=Cte.Descripcion8
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion9]
Carpeta=CRM
Clave=Cte.Descripcion9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion10]
Carpeta=CRM
Clave=Cte.Descripcion10
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion11]
Carpeta=CRM
Clave=Cte.Descripcion11
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion12]
Carpeta=CRM
Clave=Cte.Descripcion12
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion13]
Carpeta=CRM
Clave=Cte.Descripcion13
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion14]
Carpeta=CRM
Clave=Cte.Descripcion14
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion15]
Carpeta=CRM
Clave=Cte.Descripcion15
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion16]
Carpeta=CRM
Clave=Cte.Descripcion16
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion17]
Carpeta=CRM
Clave=Cte.Descripcion17
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion18]
Carpeta=CRM
Clave=Cte.Descripcion18
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion19]
Carpeta=CRM
Clave=Cte.Descripcion19
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[CRM.Cte.Descripcion20]
Carpeta=CRM
Clave=Cte.Descripcion20
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata



[Acciones.VentaPendientePersonalizar]
Nombre=VentaPendientePersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=VentaPendiente
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S





[Seguro.Cte.Aseguradora]
Carpeta=Seguro
Clave=Cte.Aseguradora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Seguro.CteAseguradora.Nombre]
Carpeta=Seguro
Clave=CteAseguradora.Nombre
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Plata

[Seguro.Cte.NombreAsegurado]
Carpeta=Seguro
Clave=Cte.NombreAsegurado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata

[Seguro.Cte.PolizaTipo]
Carpeta=Seguro
Clave=Cte.PolizaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Seguro.Cte.PolizaNumero]
Carpeta=Seguro
Clave=Cte.PolizaNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Seguro.Cte.PolizaReferencia]
Carpeta=Seguro
Clave=Cte.PolizaReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Seguro.Cte.Deducible]
Carpeta=Seguro
Clave=Cte.Deducible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata

[Seguro.Cte.DeducibleMoneda]
Carpeta=Seguro
Clave=Cte.DeducibleMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Seguro.Cte.Coaseguro]
Carpeta=Seguro
Clave=Cte.Coaseguro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata





[Ficha.DisponibleMN]
Carpeta=Ficha
Clave=DisponibleMN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]


[Acciones.CxcPreliminar]
Nombre=CxcPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=PorCobrar
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.CxcImprimir]
Nombre=CxcImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=PorCobrar
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.CxcExcel]
Nombre=CxcExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=PorCobrar
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.PosImprimir]
Nombre=PosImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=CobrosPosfechados
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.PosPreliminar]
Nombre=PosPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=CobrosPosfechados
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.PosExcel]
Nombre=PosExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=CobrosPosfechados
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.EmbarqueImprimir]
Nombre=EmbarqueImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=Embarques
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.EmbarquePreliminar]
Nombre=EmbarquePreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=Embarques
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.EmbarqueExcel]
Nombre=EmbarqueExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=Embarques
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.VentaPendientePropiedades]
Nombre=VentaPendientePropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(POSVentaTemp:POSVentaTemp.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, POSVentaTemp:POSVentaTemp.ID)
[Acciones.VentaPendienteImprimir]
Nombre=VentaPendienteImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=VentaPendiente
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.VentaPendientePreliminar]
Nombre=VentaPendientePreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=VentaPendiente
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.VentaPendienteExcel]
Nombre=VentaPendienteExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=VentaPendiente
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.HabitoImprimir]
Nombre=HabitoImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=Habitos
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.HabitoPreliminar]
Nombre=HabitoPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=Habitos
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.HabitoExcel]
Nombre=HabitoExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=Habitos
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.SoporteImprimir]
Nombre=SoporteImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=Soporte
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.SoportePreliminar]
Nombre=SoportePreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=Soporte
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.SoporteExcel]
Nombre=SoporteExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=Soporte
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.VigenteImprimir]
Nombre=VigenteImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=VentaVigente
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.VigentePreliminar]
Nombre=VigentePreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=VentaVigente
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.VigenteExcel]
Nombre=VigenteExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=VentaVigente
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S







[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=165
VerValor=151










[Soporte.ListaEnCaptura]
(Inicio)=Soporte.FechaEmision
Soporte.FechaEmision=Soporte.Vencimiento
Soporte.Vencimiento=Soporte.Titulo
Soporte.Titulo=(Fin)

[Soporte.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=ALTAPRIORIDAD
ALTAPRIORIDAD=PRIORIDADBAJA
PRIORIDADBAJA=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[Soporte.ListaAcciones]
(Inicio)=SoporteProp
SoporteProp=SoporteImprimir
SoporteImprimir=SoportePreliminar
SoportePreliminar=SoporteExcel
SoporteExcel=(Fin)



[Embarques.ListaEnCaptura]
(Inicio)=Venta.EmbarqueEstado
Venta.EmbarqueEstado=Venta.FechaEmision
Venta.FechaEmision=Venta.FechaEntrega
Venta.FechaEntrega=Venta.EnviarA
Venta.EnviarA=Venta.FormaEnvio
Venta.FormaEnvio=ImporteTotal
ImporteTotal=Venta.Moneda
Venta.Moneda=(Fin)

[Embarques.ListaAcciones]
(Inicio)=EmbarquePropiedades
EmbarquePropiedades=EmbarqueImprimir
EmbarqueImprimir=EmbarquePreliminar
EmbarquePreliminar=EmbarqueExcel
EmbarqueExcel=EmbarcarCampos
EmbarcarCampos=(Fin)

[Habitos.ListaEnCaptura]
(Inicio)=DiasEmision
DiasEmision=DiasRetraso
DiasRetraso=Cxc.FechaEmision
Cxc.FechaEmision=Cxc.Vencimiento
Cxc.Vencimiento=Cxc.FechaConclusion
Cxc.FechaConclusion=ImporteTotal
ImporteTotal=Cxc.Referencia
Cxc.Referencia=(Fin)

[Habitos.ListaAcciones]
(Inicio)=HabitoPropiedades
HabitoPropiedades=HabitoImprimir
HabitoImprimir=HabitoPreliminar
HabitoPreliminar=HabitoExcel
HabitoExcel=HabitoPersonalizar
HabitoPersonalizar=(Fin)


[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)









[Credito.POSCteCreditoTemp.Empresa]
Carpeta=Credito
Clave=POSCteCreditoTemp.Empresa
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Credito.POSCteCreditoTemp.ConCredito]
Carpeta=Credito
Clave=POSCteCreditoTemp.ConCredito
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Credito.POSCteCreditoTemp.ConLimiteCredito]
Carpeta=Credito
Clave=POSCteCreditoTemp.ConLimiteCredito
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco

[Credito.POSCteCreditoTemp.LimiteCredito]
Carpeta=Credito
Clave=POSCteCreditoTemp.LimiteCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Credito.POSCteCreditoTemp.MonedaCredito]
Carpeta=Credito
Clave=POSCteCreditoTemp.MonedaCredito
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Credito.POSCteCreditoTemp.ConDias]
Carpeta=Credito
Clave=POSCteCreditoTemp.ConDias
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco

[Credito.POSCteCreditoTemp.Dias]
Carpeta=Credito
Clave=POSCteCreditoTemp.Dias
Editar=S
LineaNueva=S
3D=S
Tamano=10
ColorFondo=Blanco

[Credito.POSCteCreditoTemp.ConCondiciones]
Carpeta=Credito
Clave=POSCteCreditoTemp.ConCondiciones
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco

[Credito.POSCteCreditoTemp.Condiciones]
Carpeta=Credito
Clave=POSCteCreditoTemp.Condiciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco





[VentaPendiente.POSVentaTemp.FechaEmision]
Carpeta=VentaPendiente
Clave=POSVentaTemp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaPendiente.POSVentaTemp.FechaRequerida]
Carpeta=VentaPendiente
Clave=POSVentaTemp.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaPendiente.POSVentaTemp.Saldo]
Carpeta=VentaPendiente
Clave=POSVentaTemp.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[VentaVigente.POSVentaTemp.FechaEmision]
Carpeta=VentaVigente
Clave=POSVentaTemp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaVigente.POSVentaTemp.Vencimiento]
Carpeta=VentaVigente
Clave=POSVentaTemp.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaVigente.POSVentaTemp.Referencia]
Carpeta=VentaVigente
Clave=POSVentaTemp.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco






























































































[PorCobrar.POSCteInfoTemp.Vencimiento]
Carpeta=PorCobrar
Clave=POSCteInfoTemp.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[PorCobrar.POSCteInfoTemp.Saldo]
Carpeta=PorCobrar
Clave=POSCteInfoTemp.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[CobrosPosfechados.POSCteInfoTemp.FechaEmision]
Carpeta=CobrosPosfechados
Clave=POSCteInfoTemp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CobrosPosfechados.POSCteInfoTemp.Vencimiento]
Carpeta=CobrosPosfechados
Clave=POSCteInfoTemp.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CobrosPosfechados.POSCteInfoTemp.Saldo]
Carpeta=CobrosPosfechados
Clave=POSCteInfoTemp.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Ficha.POSCteInfoTempCalc.SaldoMN]
Carpeta=Ficha
Clave=POSCteInfoTempCalc.SaldoMN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Ficha.POSCteInfoTempCalc.LimiteCreditoMN]
Carpeta=Ficha
Clave=POSCteInfoTempCalc.LimiteCreditoMN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco























[CreditoEspecial.ListaEnCaptura]
(Inicio)=Cte.CreditoConLimite
Cte.CreditoConLimite=Cte.CreditoLimite
Cte.CreditoLimite=Cte.CreditoMoneda
Cte.CreditoMoneda=Cte.CreditoConDias
Cte.CreditoConDias=Cte.CreditoDias
Cte.CreditoDias=Cte.CreditoConCondiciones
Cte.CreditoConCondiciones=Cte.CreditoCondiciones
Cte.CreditoCondiciones=(Fin)

[Ventas.ListaEnCaptura]
(Inicio)=Cte.DiaRevision1
Cte.DiaRevision1=Cte.DiaRevision2
Cte.DiaRevision2=Cte.HorarioRevision
Cte.HorarioRevision=Cte.DiaPago1
Cte.DiaPago1=Cte.DiaPago2
Cte.DiaPago2=Cte.HorarioPago
Cte.HorarioPago=Cte.Agente
Cte.Agente=Cte.Condicion
Cte.Condicion=Cte.Proyecto
Cte.Proyecto=Cte.PedidosParciales
Cte.PedidosParciales=(Fin)

[Seguro.ListaEnCaptura]
(Inicio)=Cte.Aseguradora
Cte.Aseguradora=CteAseguradora.Nombre
CteAseguradora.Nombre=Cte.NombreAsegurado
Cte.NombreAsegurado=Cte.PolizaTipo
Cte.PolizaTipo=Cte.PolizaNumero
Cte.PolizaNumero=Cte.PolizaReferencia
Cte.PolizaReferencia=Cte.Deducible
Cte.Deducible=Cte.DeducibleMoneda
Cte.DeducibleMoneda=Cte.Coaseguro
Cte.Coaseguro=(Fin)





[CRM.ListaEnCaptura]
(Inicio)=Cte.Descripcion1
Cte.Descripcion1=Cte.Descripcion2
Cte.Descripcion2=Cte.Descripcion3
Cte.Descripcion3=Cte.Descripcion4
Cte.Descripcion4=Cte.Descripcion5
Cte.Descripcion5=Cte.Descripcion6
Cte.Descripcion6=Cte.Descripcion7
Cte.Descripcion7=Cte.Descripcion8
Cte.Descripcion8=Cte.Descripcion9
Cte.Descripcion9=Cte.Descripcion10
Cte.Descripcion10=Cte.Descripcion11
Cte.Descripcion11=Cte.Descripcion12
Cte.Descripcion12=Cte.Descripcion13
Cte.Descripcion13=Cte.Descripcion14
Cte.Descripcion14=Cte.Descripcion15
Cte.Descripcion15=Cte.Descripcion16
Cte.Descripcion16=Cte.Descripcion17
Cte.Descripcion17=Cte.Descripcion18
Cte.Descripcion18=Cte.Descripcion19
Cte.Descripcion19=Cte.Descripcion20
Cte.Descripcion20=(Fin)








[Credito.ListaEnCaptura]
(Inicio)=Cte.Credito
Cte.Credito=POSCteCreditoTemp.Empresa
POSCteCreditoTemp.Empresa=POSCteCreditoTemp.ConCredito
POSCteCreditoTemp.ConCredito=POSCteCreditoTemp.ConLimiteCredito
POSCteCreditoTemp.ConLimiteCredito=POSCteCreditoTemp.LimiteCredito
POSCteCreditoTemp.LimiteCredito=POSCteCreditoTemp.MonedaCredito
POSCteCreditoTemp.MonedaCredito=POSCteCreditoTemp.ConDias
POSCteCreditoTemp.ConDias=POSCteCreditoTemp.Dias
POSCteCreditoTemp.Dias=POSCteCreditoTemp.ConCondiciones
POSCteCreditoTemp.ConCondiciones=POSCteCreditoTemp.Condiciones
POSCteCreditoTemp.Condiciones=(Fin)






[VentaPendiente.ListaEnCaptura]
(Inicio)=POSVentaTemp.FechaEmision
POSVentaTemp.FechaEmision=POSVentaTemp.FechaRequerida
POSVentaTemp.FechaRequerida=POSVentaTemp.Saldo
POSVentaTemp.Saldo=(Fin)

[VentaPendiente.FiltroListaEstatus]
(Inicio)=PENDIENTE
PENDIENTE=PROCESAR
PROCESAR=CONFIRMAR
CONFIRMAR=(Fin)

[VentaPendiente.ListaAcciones]
(Inicio)=VentaPendientePropiedades
VentaPendientePropiedades=VentaPendienteImprimir
VentaPendienteImprimir=VentaPendientePreliminar
VentaPendientePreliminar=VentaPendienteExcel
VentaPendienteExcel=VentaPendientePersonalizar
VentaPendientePersonalizar=(Fin)

[VentaVigente.ListaEnCaptura]
(Inicio)=POSVentaTemp.FechaEmision
POSVentaTemp.FechaEmision=POSVentaTemp.Vencimiento
POSVentaTemp.Vencimiento=POSVentaTemp.Referencia
POSVentaTemp.Referencia=(Fin)

[VentaVigente.ListaAcciones]
(Inicio)=VigenteProp
VigenteProp=VigenteImprimir
VigenteImprimir=VigentePreliminar
VigentePreliminar=VigenteExcel
VigenteExcel=(Fin)




[PorCobrar.ListaEnCaptura]
(Inicio)=Dias
Dias=POSCteInfoTemp.Vencimiento
POSCteInfoTemp.Vencimiento=POSCteInfoTemp.Saldo
POSCteInfoTemp.Saldo=Moratorios
Moratorios=(Fin)

[PorCobrar.ListaOrden]
(Inicio)=POSCteInfoTemp.Vencimiento	(Acendente)
POSCteInfoTemp.Vencimiento	(Acendente)=POSCteInfoTemp.Mov	(Acendente)
POSCteInfoTemp.Mov	(Acendente)=POSCteInfoTemp.MovID	(Acendente)
POSCteInfoTemp.MovID	(Acendente)=(Fin)

[PorCobrar.ListaAcciones]
(Inicio)=CxcImprimir
CxcImprimir=CxcPreliminar
CxcPreliminar=CxcExcel
CxcExcel=CxcCampos
CxcCampos=(Fin)














































[Ficha.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=Cte.Direccion
Cte.Direccion=Cte.Colonia
Cte.Colonia=Cte.CodigoPostal
Cte.CodigoPostal=Cte.Estado
Cte.Estado=Cte.Pais
Cte.Pais=Cte.Grupo
Cte.Grupo=EstatusNombre
EstatusNombre=Cte.Telefonos
Cte.Telefonos=Cte.Contacto1
Cte.Contacto1=Cte.Categoria
Cte.Categoria=Cte.Familia
Cte.Familia=Cte.RFC
Cte.RFC=POSCteInfoTempCalc.SaldoMN
POSCteInfoTempCalc.SaldoMN=POSCteInfoTempCalc.LimiteCreditoMN
POSCteInfoTempCalc.LimiteCreditoMN=DisponibleMN
DisponibleMN=(Fin)
































[CobrosPosfechados.ListaEnCaptura]
(Inicio)=POSCteInfoTemp.FechaEmision
POSCteInfoTemp.FechaEmision=POSCteInfoTemp.Vencimiento
POSCteInfoTemp.Vencimiento=POSCteInfoTemp.Saldo
POSCteInfoTemp.Saldo=(Fin)

[CobrosPosfechados.ListaAcciones]
(Inicio)=PosPropiedades
PosPropiedades=PosImprimir
PosImprimir=PosPreliminar
PosPreliminar=PosExcel
PosExcel=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Credito
Credito=CreditoEspecial
CreditoEspecial=Ventas
Ventas=CRM
CRM=PorCobrar
PorCobrar=CobrosPosfechados
CobrosPosfechados=VentaPendiente
VentaPendiente=VentaVigente
VentaVigente=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Salir
Salir=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Ver
&Ver=&Explorar
&Explorar=(Fin)
