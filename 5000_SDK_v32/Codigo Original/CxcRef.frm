[Forma]
Clave=CxcRef
Nombre=Cuentas por Cobrar
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=367
PosicionInicialArriba=278
PosicionInicialAlturaCliente=433
PosicionInicialAncho=546
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cliente, Info.Moneda)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcRef
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=CxcRef.Vencimiento<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Cuentas por Cobrar
FiltroAutoCampo=CxcPendienteRef.Mov
FiltroAutoValidar=CxcPendienteRef.Mov
FiltroTodo=S
FiltroTodoFinal=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=CxcRef.Vencimiento
FiltroFechasDefault=Vencido
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ListaEnCaptura=(Lista)
IconosNombre=CxcRef:MovNombre
FiltroGeneral=CxcRef.Empresa=<T>{Empresa}<T> AND<BR>CxcRef.Cliente=<T>{Info.Cliente}<T> AND<BR>CxcRef.Moneda=<T>{Info.Moneda}<T>

[Lista.Columnas]
0=133
1=81

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

[Lista.CxcRef.FechaEmision]
Carpeta=Lista
Clave=CxcRef.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcRef.Vencimiento]
Carpeta=Lista
Clave=CxcRef.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcRef.Saldo]
Carpeta=Lista
Clave=CxcRef.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CxcRef.FechaEmision
CxcRef.FechaEmision=CxcRef.Vencimiento
CxcRef.Vencimiento=CxcRef.Saldo
CxcRef.Saldo=(Fin)
