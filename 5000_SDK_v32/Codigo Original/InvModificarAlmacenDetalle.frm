[Forma]
Clave=InvModificarAlmacenDetalle
Nombre=Modificar Almacén Detalle
Icono=0
Modulos=(Todos)
CarpetaPrincipal=Lista
ListaCarpetas=Lista
PosicionInicialIzquierda=143
PosicionInicialArriba=152
PosicionInicialAltura=117
PosicionInicialAncho=550
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Info.Mov+<T> <T>+Info.MovID
PosicionInicialAlturaCliente=429
ExpresionesAlMostrar=Asigna(Info.Almacen, Nulo)<BR>Asigna(Info.Reservar, Si(Config.PedidosReservar, <T>Si<T>, <T>No<T>))

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar

[Acciones.Afectar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Afectar.Verificar]
Nombre=Verificar
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
Expresion=ProcesarSQL(<T>spModificarAlmacenSolicitudes :nID, :tAlmacen, :tReservar, :nRen, :nSub<T>, Info.ID, Info.Almacen, Info.Reservar, Info.Renglon, Info.RenglonSub)
EjecucionCondicion=SQL(<T>SELECT Almacen FROM Alm WHERE Almacen = :tAlmacen<T>, Info.Almacen) <> Nulo
EjecucionMensaje=<T>El Almacén Indicado No Existe<T>

[Acciones.Afectar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvModificarAlmacenDetalle
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=$00004080
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=InvD.ID={Info.ID} AND ISNULL(InvD.CantidadPendiente, 0)>0 AND InvD.CantidadOrdenada IS NULL AND InvD.CantidadReservada IS NULL

[Lista.InvD.Articulo]
Carpeta=Lista
Clave=InvD.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Lista.InvD.Almacen]
Carpeta=Lista
Clave=InvD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvD.CantidadPendiente]
Carpeta=Lista
Clave=InvD.CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

[Lista.Columnas]
Articulo=120
Descripcion1=221
Almacen=93
CantidadPendiente=83
Nombre=187

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=InvD.Articulo
InvD.Articulo=Art.Descripcion1
Art.Descripcion1=InvD.Almacen
InvD.Almacen=InvD.CantidadPendiente
InvD.CantidadPendiente=(Fin)
