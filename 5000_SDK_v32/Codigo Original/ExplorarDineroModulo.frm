[Forma]
Clave=ExplorarDineroModulo
Icono=47
Modulos=(Todos)
Nombre=<T>Explorando - Tesoreria - Movimientos<T>
MovModulo=DIN
PosicionInicialAlturaCliente=473
PosicionInicialAncho=952
ListaCarpetas=Lista
CarpetaPrincipal=Lista
EsConsultaExclusiva=S
PosicionInicialIzquierda=1444
PosicionInicialArriba=146
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DineroA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
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
ListaOrden=Dinero.ID<TAB>(Decendente)
FiltroAplicaO=Dinero.CtaDineroDestino
FiltroAplicaEn=Dinero.CtaDinero
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CtaDinero
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todas)
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroSituacion=S
FiltroProyectos=S
FiltroSucursales=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CONCLUIDO
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Dinero.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasCancelacion=Dinero.FechaCancelacion
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaRespetarControles=S
BusquedaEnLinea=S
BusquedaAncho=20
FiltroSituacionTodo=S
FiltroMonedas=S
FiltroMonedasCampo=Dinero.Moneda
BusquedaInicializar=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroUENs=S
FiltroUENsCampo=Dinero.UEN
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CtaDineroCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CtaDineroGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CtaDineroFam
FiltroAplicaEn1=CtaDinero.Categoria
FiltroAplicaEn2=CtaDinero.Grupo
FiltroAplicaEn3=CtaDinero.Familia
FiltroListas=S
FiltroListasRama=DIN
FiltroListasAplicaEn=Dinero.CtaDinero

AnchoTotalizador1=350
TieneTotalizador2=S
IconosNombre=DineroA:Dinero.Mov+<T> <T>+DineroA:Dinero.MovID
Paginacion=S
PaginacionTamano=1000
FiltroGeneral=Dinero.Empresa=<T>{Empresa}<T>
[Lista.Dinero.FechaEmision]
Carpeta=Lista
Clave=Dinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Dinero.Referencia]
Carpeta=Lista
Clave=Dinero.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=128
1=94

2=90
3=60
4=104
5=77
6=98
7=-2
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

[Lista.Dinero.CtaDinero]
Carpeta=Lista
Clave=Dinero.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Dinero.CtaDineroDestino]
Carpeta=Lista
Clave=Dinero.CtaDineroDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Dinero.Concepto]
Carpeta=Lista
Clave=Dinero.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Impresora
ClaveAccion=ExplorarDineroModuloTotal
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T>WHERE <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T><T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=ExplorarDineroModuloTotal
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T>WHERE <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T><T> & Carpeta.FiltroActual( <T>Lista<T> ))
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

[Acciones.CtaDineroInfo]
Nombre=CtaDineroInfo
Boton=34
NombreDesplegar=Cuenta
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CtaDineroInfo
Activo=S
Visible=S
Antes=S
ConCondicion=S

EjecucionCondicion=ConDatos(DineroA:Dinero.CtaDinero)
AntesExpresiones=Asigna(Info.CtaDinero, DineroA:Dinero.CtaDinero)
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
EjecucionCondicion=ConDatos(DineroA:Dinero.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, DineroA:Dinero.ID)
Visible=S




[Lista.ImporteTotalMN]
Carpeta=Lista
Clave=ImporteTotalMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco




[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Paginacion
Activo=S
Visible=S




EspacioPrevio=S
[Acciones.Totales]
Nombre=Totales
Boton=64
NombreEnBoton=S
NombreDesplegar=Totales
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ExplorarDineroModuloTotal
Activo=S
Visible=S





Antes=S





AntesExpresiones=Asigna(Info.Filtro,<T>WHERE <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T><T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Lista.ListaEnCaptura]
(Inicio)=Dinero.FechaEmision
Dinero.FechaEmision=Dinero.Concepto
Dinero.Concepto=Dinero.CtaDinero
Dinero.CtaDinero=Dinero.CtaDineroDestino
Dinero.CtaDineroDestino=Dinero.Referencia
Dinero.Referencia=ImporteTotal
ImporteTotal=ImporteTotalMN
ImporteTotalMN=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=BORRADOR
BORRADOR=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CONCILIADO
CONCILIADO=CANCELADO
CANCELADO=(Fin)











































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=CtaDineroInfo
CtaDineroInfo=MovPropiedades
MovPropiedades=Navegador
Navegador=Totales
Totales=Personalizar
Personalizar=(Fin)
