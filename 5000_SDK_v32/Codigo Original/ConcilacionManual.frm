[Forma]
Clave=ConcilacionManual
Nombre=Conciliación Manual
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=628
PosicionInicialArriba=342
PosicionInicialAlturaCliente=482
PosicionInicialAncho=663
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.CtaDinero,  MonetarioEnTexto(Info.Cargo), MonetarioEnTexto(Info.Abono))
EsConsultaExclusiva=S

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
IconosNombre=AuxiliarDinero:Dinero.Mov+<T> <T>+AuxiliarDinero:Dinero.MovID
FiltroGeneral=Dinero.Empresa=<T>{Empresa}<T> <BR>AND Dinero.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>)<BR>AND Auxiliar.Cuenta=<T>{Info.CtaDinero}<T> <BR>AND Auxiliar.Conciliado = 0 <BR>AND ROUND(ISNULL(Auxiliar.Cargo, 0.0), {Info.Redondeo}) = ROUND({Vacio(Info.Cargo, 0.0)}, {Info.Redondeo})<BR>AND ROUND(ISNULL(Auxiliar.Abono, 0.0), {Info.Redondeo}) = ROUND({Vacio(Info.Abono, 0.0)}, {Info.Redondeo})

[Lista.Columnas]
0=149
1=95

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

[Lista.Dinero.FechaEmision]
Carpeta=Lista
Clave=Dinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Dinero.Concepto]
Carpeta=Lista
Clave=Dinero.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Dinero.Referencia]
Carpeta=Lista
Clave=Dinero.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Dinero.Importe]
Carpeta=Lista
Clave=Dinero.Importe
Editar=S
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
(Inicio)=Dinero.FechaEmision
Dinero.FechaEmision=Dinero.Concepto
Dinero.Concepto=Dinero.Referencia
Dinero.Referencia=Dinero.Importe
Dinero.Importe=(Fin)
