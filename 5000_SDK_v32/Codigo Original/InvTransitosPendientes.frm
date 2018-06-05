[Forma]
Clave=InvTransitosPendientes
Nombre=Transitos Pendientes
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=367
PosicionInicialArriba=239
PosicionInicialAlturaCliente=331
PosicionInicialAncho=753
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Almacen)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvPendientes
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

IconosNombre=InvPendientes:Mov+<T> <T>+InvPendientes:MovID
FiltroGeneral=Inv.Almacen=<T>{Info.AlmD}<T> AND AlmacenDestino=<T>{Info.AlmA}<T> AND mt.Clave=<T>INV.TI<T>
[Lista.Columnas]
0=175
1=185

2=-2
3=-2
[Acciones.SinOrden]
Nombre=SinOrden
Boton=25
NombreEnBoton=S
NombreDesplegar=&Recibir Sin Orden
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.ID, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(InvPendientes:ID)
AntesExpresiones=Asigna(Info.ID, InvPendientes:ID)<BR>Asigna(Info.Mov, InvPendientes:Mov)<BR>Asigna(Info.MovID, InvPendientes:MovID)




[Lista.ListaEnCaptura]
(Inicio)=Inv.Referencia
Inv.Referencia=Inv.Almacen
Inv.Almacen=Inv.AlmacenDestino
Inv.AlmacenDestino=(Fin)

[Lista.Inv.Referencia]
Carpeta=Lista
Clave=Inv.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Inv.Almacen]
Carpeta=Lista
Clave=Inv.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Inv.AlmacenDestino]
Carpeta=Lista
Clave=Inv.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco





[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=SinOrden
SinOrden=(Fin)
