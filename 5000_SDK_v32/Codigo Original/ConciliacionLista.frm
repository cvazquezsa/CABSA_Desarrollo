[Forma]
Clave=ConciliacionLista
Nombre=Movimientos por Conciliar
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=616
PosicionInicialArriba=342
PosicionInicialAlturaCliente=482
PosicionInicialAncho=688
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Info.CtaDinero
EsConsultaExclusiva=S
VentanaExclusiva=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AuxiliarDinero
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Movimientos
IconosSeleccionMultiple=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechas=S
FiltroFechasCampo=Auxiliar.Fecha
FiltroFechasDefault=(Todo)

IconosNombre=AuxiliarDinero:Dinero.Mov+<T> <T>+AuxiliarDinero:Dinero.MovID
FiltroGeneral=Dinero.Empresa=<T>{Empresa}<T><BR>AND Dinero.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>, <T>CONCILIADO<T>)<BR>AND Auxiliar.Cuenta=<T>{Info.CtaDinero}<T><BR>AND Auxiliar.Conciliado = 0 AND Auxiliar.Rama = <T>DIN<T>
[Lista.Columnas]
0=143
1=82

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

[Lista.Dinero.FechaEmision]
Carpeta=Lista
Clave=Dinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Lista.Dinero.Referencia]
Carpeta=Lista
Clave=Dinero.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Dinero.Importe]
Carpeta=Lista
Clave=Dinero.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=RegistrarSeleccionID(<T>Lista<T>)

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a E&xcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
EspacioPrevio=S








[Lista.ListaEnCaptura]
(Inicio)=Dinero.FechaEmision
Dinero.FechaEmision=Dinero.Concepto
Dinero.Concepto=Dinero.Referencia
Dinero.Referencia=Dinero.Importe
Dinero.Importe=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Excel
Excel=Personalizar
Personalizar=(Fin)
