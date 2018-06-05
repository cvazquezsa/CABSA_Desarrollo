[Forma]
Clave=CxpLista
Icono=4
Modulos=(Todos)
Nombre=<T>Movimientos - Cuentas por Pagar<T>
MovModulo=CXP
PosicionInicialAlturaCliente=549
PosicionInicialAncho=972
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=154
PosicionInicialArriba=220
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsConsultaExclusiva=S
Comentarios=Lista(Info.Mov, Info.Estatus, Info.Situacion)
AutoGuardar=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxpA
Fuente={Tahoma, 8, Negro, []}
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
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
PermiteLocalizar=S
ListaOrden=Cxp.ID<TAB>(Decendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todas)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroFechas=S
FiltroProyectos=S
FiltroSucursales=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CONCLUIDO
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Cxp.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasCancelacion=Cxp.FechaCancelacion
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaRespetarControles=S
BusquedaEnLinea=S
BusquedaAncho=20
FiltroSituacionTodo=S
FiltroMonedas=S
FiltroMonedasCampo=Cxp.Moneda
BusquedaInicializar=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroUsuarios=S
IconosNombre=CxpA:Cxp.Mov+<T> <T>+CxpA:Cxp.MovID
FiltroGeneral=Cxp.Mov=<T>{Info.Mov}<T> AND Cxp.Estatus=<T>{Info.Estatus}<T> AND Cxp.Empresa=<T>{Empresa}<T><BR>{Si(ConDatos(Info.Situacion), <T> AND Cxp.Situacion=<T>+Comillas(Info.Situacion), <T><T>)}

[Lista.Cxp.FechaEmision]
Carpeta=Lista
Clave=Cxp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Referencia]
Carpeta=Lista
Clave=Cxp.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=146
1=85

[Lista.Cxp.Concepto]
Carpeta=Lista
Clave=Cxp.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(CxpA:Cxp.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>Cxp<T>)<BR>Asigna(Info.ID, CxpA:Cxp.ID)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Cxp.Proveedor]
Carpeta=Lista
Clave=Cxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Saldo]
Carpeta=Lista
Clave=Cxp.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=34
NombreDesplegar=Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CxpA:Cxp.Proveedor)
Antes=S
AntesExpresiones=Asigna(Info.Proveedor, CxpA:Cxp.Proveedor)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=ProvInfo
ProvInfo=MovPropiedades
MovPropiedades=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cxp.FechaEmision
Cxp.FechaEmision=Cxp.Proveedor
Cxp.Proveedor=Prov.Nombre
Prov.Nombre=Cxp.Referencia
Cxp.Referencia=Cxp.Concepto
Cxp.Concepto=ImporteTotal
ImporteTotal=Cxp.Saldo
Cxp.Saldo=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=BORRADOR
BORRADOR=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)
