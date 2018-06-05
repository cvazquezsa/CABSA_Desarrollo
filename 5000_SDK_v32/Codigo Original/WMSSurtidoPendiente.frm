
[Forma]
Clave=WMSSurtidoPendiente
Icono=0
Modulos=(Todos)
Nombre=Surtidos Pendientes

ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
PosicionInicialAlturaCliente=189
PosicionInicialAncho=849
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=258
PosicionInicialArriba=250
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaSinIconosMarco=S
[Hoja]
Estilo=Hoja
Clave=Hoja
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSSurtidoPendiente
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PestanaOtroNombre=S

PestanaNombre=Pendientes
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=WMSSurtidoPendiente.Estacion = {EstacionTrabajo}
[Hoja.WMSSurtidoPendiente.Articulo]
Carpeta=Hoja
Clave=WMSSurtidoPendiente.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.WMSSurtidoPendiente.Almacen]
Carpeta=Hoja
Clave=WMSSurtidoPendiente.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Hoja.WMSSurtidoPendiente.Cantidad]
Carpeta=Hoja
Clave=WMSSurtidoPendiente.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.Columnas]
Articulo=124
Almacen=124
Cantidad=80


Descripcion1=184
SubCuenta=143
Movimiento=135
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Execl]
Nombre=Execl
Boton=67
NombreEnBoton=S
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S





[Hoja.Art.Descripcion1]
Carpeta=Hoja
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

























[Hoja.WMSSurtidoPendiente.SubCuenta]
Carpeta=Hoja
Clave=WMSSurtidoPendiente.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

















[Acciones.Posiciones]
Nombre=Posiciones
Boton=51
NombreDesplegar=P&osiciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Asigna(Info.Articulo, WMSSurtidoPendiente:WMSSurtidoPendiente.Articulo)<BR>FormaModal(<T>WMSAlmPosicion<T>)
[Lista.Columnas]
Movimiento=137
Estatus=105
Tarima=121
Articulo=124
Almacen=100






Zona=112
Posicion=127
Tipo=139
ArticuloEsp=124




Cantidad=64

[Acciones.Dispponible]
Nombre=Dispponible
Boton=57
NombreDesplegar=Disponible
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S









EspacioPrevio=S
Expresion=Asigna(Info.Origen, <T>VTAS<T>)<BR>Asigna(Info.Articulo, WMSSurtidoPendiente:WMSSurtidoPendiente.Articulo)<BR>Asigna(Info.Descripcion,  SQL(<T>SELECT Descripcion1 FROM Art WHERE Articulo = :tArticulo<T>,WMSSurtidoPendiente:WMSSurtidoPendiente.Articulo))<BR>Asigna(Info.ArtTipo, SQL(<T>SELECT Tipo FROM Art WHERE Articulo = :tArticulo<T>,WMSSurtidoPendiente:WMSSurtidoPendiente.Articulo))<BR>Asigna(Info.ArtTipoOpcion,  SQL(<T>SELECT TipoOpcion FROM Art WHERE Articulo = :tArticulo<T>,WMSSurtidoPendiente:WMSSurtidoPendiente.Articulo))<BR>Asigna(Info.Almacen, Si(Config.VentaMultiAlmacen, WMSSurtidoPendiente:WMSSurtidoPendiente.Almacen, WMSSurtidoPendiente:WMSSurtidoPendiente.Almacen))<BR>Forma(<T>ArtAlmExistencia<T>)
EjecucionCondicion=ConDatos(WMSSurtidoPendiente:WMSSurtidoPendiente.Articulo)







[Hoja.ListaEnCaptura]
(Inicio)=WMSSurtidoPendiente.Articulo
WMSSurtidoPendiente.Articulo=WMSSurtidoPendiente.SubCuenta
WMSSurtidoPendiente.SubCuenta=Art.Descripcion1
Art.Descripcion1=WMSSurtidoPendiente.Almacen
WMSSurtidoPendiente.Almacen=WMSSurtidoPendiente.Cantidad
WMSSurtidoPendiente.Cantidad=Movimiento
Movimiento=(Fin)

[Hoja.Movimiento]
Carpeta=Hoja
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco











[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Execl
Execl=Dispponible
Dispponible=Posiciones
Posiciones=(Fin)
