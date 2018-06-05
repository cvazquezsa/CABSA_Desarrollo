[Forma]
Clave=ExplorarDineroMov
Nombre=Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=247
PosicionInicialArriba=303
PosicionInicialAltura=411
PosicionInicialAncho=786
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsConsultaExclusiva=S
EsMovimiento=S
MovModulo=(Todos)
TituloAuto=S
MovEspecificos=Todos
PosicionInicialAlturaCliente=384

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Auxiliar
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Auxiliar.Fecha
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CtaDinero
FiltroAplicaEn=Auxiliar.Cuenta
PermiteLocalizar=S
FiltroGrupo1=Auxiliar.Moneda
FiltroTodo=S
FiltroMonedasCampo=Auxiliar.Moneda
FiltroGrupo2=Auxiliar.Cuenta
FiltroTodoFinal=S
FiltroSucursales=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
IconosNombre=Auxiliar:Auxiliar.Mov+<T> <T>+Auxiliar:Auxiliar.MovID
FiltroGeneral=Auxiliar.Empresa = <T>{Empresa}<T> AND<BR>Auxiliar.Rama = <T>{Info.Rama}<T>

[Lista.Auxiliar.Cuenta]
Carpeta=Lista
Clave=Auxiliar.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Auxiliar.Cargo]
Carpeta=Lista
Clave=Auxiliar.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Auxiliar.Abono]
Carpeta=Lista
Clave=Auxiliar.Abono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Auxiliar.Conciliado]
Carpeta=Lista
Clave=Auxiliar.Conciliado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[Lista.Auxiliar.EsCancelacion]
Carpeta=Lista
Clave=Auxiliar.EsCancelacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=140
1=107

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
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
EnMenu=S

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
EnBarraHerramientas=S

[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

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

[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Mostrar Campos
Mostrar Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Auxiliar.Cuenta
Auxiliar.Cuenta=Auxiliar.Cargo
Auxiliar.Cargo=Auxiliar.Abono
Auxiliar.Abono=Auxiliar.Conciliado
Auxiliar.Conciliado=Auxiliar.EsCancelacion
Auxiliar.EsCancelacion=(Fin)
