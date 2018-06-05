[Forma]
Clave=InvSolicitudPendienteD
Nombre=Pendientes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=283
PosicionInicialArriba=295
PosicionInicialAlturaCliente=400
PosicionInicialAncho=713
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaExclusiva=S
ListaAcciones=(Lista)
Comentarios=Info.Almacen

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvSolicitudPendienteD
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
IconosNombre=InvSolicitudPendienteD:InvSolicitudPendienteD.Mov+<T> <T>+InvSolicitudPendienteD:InvSolicitudPendienteD.MovID
FiltroGeneral=InvSolicitudPendienteD.Empresa=<T>{Empresa}<T> AND<BR>InvSolicitudPendienteD.Almacen=<T>{Info.Almacen}<T>

[Lista.InvSolicitudPendienteD.Articulo]
Carpeta=Lista
Clave=InvSolicitudPendienteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvSolicitudPendienteD.FechaRequerida]
Carpeta=Lista
Clave=InvSolicitudPendienteD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=131
1=62

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
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(InvSolicitudPendienteD:InvSolicitudPendienteD.ID)
AntesExpresiones=Asigna(Info.MovID, InvSolicitudPendienteD:InvSolicitudPendienteD.MovID)<BR>Asigna(Info.Articulo, InvSolicitudPendienteD:InvSolicitudPendienteD.Articulo)<BR>Asigna(Info.SubCuenta, InvSolicitudPendienteD:InvSolicitudPendienteD.SubCuenta)<BR>Asigna(Info.CantidadPendiente, InvSolicitudPendienteD:InvSolicitudPendienteD.CantidadPendiente+InvSolicitudPendienteD:InvSolicitudPendienteD.CantidadReservada)<BR>Asigna(Info.CantidadInventario, Info.CantidadPendiente*InvSolicitudPendienteD:InvSolicitudPendienteD.Factor)<BR>Asigna(Info.Unidad, InvSolicitudPendienteD:InvSolicitudPendienteD.Unidad)<BR>Asigna(Info.Copiar, Verdadero)

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

[Lista.InvSolicitudPendienteD.CantidadPendiente]
Carpeta=Lista
Clave=InvSolicitudPendienteD.CantidadPendiente
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
(Inicio)=InvSolicitudPendienteD.Articulo
InvSolicitudPendienteD.Articulo=InvSolicitudPendienteD.CantidadPendiente
InvSolicitudPendienteD.CantidadPendiente=Art.Descripcion1
Art.Descripcion1=InvSolicitudPendienteD.FechaRequerida
InvSolicitudPendienteD.FechaRequerida=(Fin)
