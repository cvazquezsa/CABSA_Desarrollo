
[Forma]
Clave=MesInvTransfer
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Transferencia por Lanzamiento
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=78
PosicionInicialArriba=49
PosicionInicialAlturaCliente=602
PosicionInicialAncho=1210
ListaAcciones=(Lista)
Comentarios=<T>Lanzamiento <T> + MesInvTransfer:MesInvTransfer.Lanzamiento
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MesInvTransfer
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

ListaCamposAValidar=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S


FiltroGeneral=MesInvTransfer.Usuario = <T>{Usuario}<T>
[Lista.MesInvTransfer.Padre]
Carpeta=Lista
Clave=MesInvTransfer.Padre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata


[Lista.MesInvTransfer.Hijo]
Carpeta=Lista
Clave=MesInvTransfer.Hijo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Lista.Art2.Descripcion1]
Carpeta=Lista
Clave=Art2.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

[Lista.MesInvTransfer.Almacen]
Carpeta=Lista
Clave=MesInvTransfer.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.MesInvTransfer.AlmacenD]
Carpeta=Lista
Clave=MesInvTransfer.AlmacenD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.MesInvTransfer.Cantidad]
Carpeta=Lista
Clave=MesInvTransfer.Cantidad
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Lista.MesInvTransfer.CantidadA]
Carpeta=Lista
Clave=MesInvTransfer.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MesInvTransfer.UltimoPrecioCoste]
Carpeta=Lista
Clave=MesInvTransfer.UltimoPrecioCoste
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Lista.MesInvTransfer.PrecioCosteMedio]
Carpeta=Lista
Clave=MesInvTransfer.PrecioCosteMedio
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Lista.MesInvTransfer.UnidMedidaCompra]
Carpeta=Lista
Clave=MesInvTransfer.UnidMedidaCompra
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata

[Lista.MesInvTransfer.UnidMedidaAlmacen]
Carpeta=Lista
Clave=MesInvTransfer.UnidMedidaAlmacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata

[Lista.Columnas]
Padre=114
Descripcion1=142
Hijo=117
Descripcion1_1=130
Almacen=71
AlmacenD=83
Cantidad=46
CantidadA=49
UltimoPrecioCoste=96
PrecioCosteMedio=95
UnidMedidaCompra=114
UnidMedidaAlmacen=115

Nombre=229
Grupo=100
Sucursal=46
Disponible=50
Transferido=58
Tipo=38
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

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S




[Acciones.Lanzamiento]
Nombre=Lanzamiento
Boton=72
NombreDesplegar=Lanzamiento
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S



NombreEnBoton=S
GuardarAntes=S
EspacioPrevio=S
Antes=S
DespuesGuardar=S

























AntesExpresiones=Si(Forma(<T>MesLanzamiento<T>), EjecutarSQL(<T>spMesInvTransferLanzamiento :tE, :tU, :nL<T>, Empresa, Usuario, Info.MesLanzamiento))
[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
AntesExpresiones=ProcesarSQL(<T>spMesInvTransferGenerar :tE, :tU, :nS, :nL<T>, Empresa, usuario, Sucursal, MesInvTransfer:MesInvTransfer.Lanzamiento)
DespuesGuardar=S
Visible=S












[Lista.ArtDestino.Descripcion1]
Carpeta=Lista
Clave=ArtDestino.Descripcion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata









[Acciones.Disponible]
Nombre=Disponible
Boton=47
NombreDesplegar=&Disponible del Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S











Expresion=Asigna(Info.Origen, <T>INV<T>)<BR>Asigna(Info.Articulo, MesInvTransfer:MesInvTransfer.Hijo)<BR>Asigna(Info.Descripcion, MesInvTransfer:Art2.Descripcion1)<BR>Asigna(Info.ArtTipo, MesInvTransfer:Art2.Tipo)<BR>Asigna(Info.ArtTipoOpcion, MesInvTransfer:Art2.TipoOpcion)<BR>Asigna(Info.Almacen, MesInvTransfer:AlmDetalle.Almacen)<BR>Forma(<T>ArtAlmExistencia<T>)







[Lista.ArtDisponible.Disponible]
Carpeta=Lista
Clave=ArtDisponible.Disponible
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Rojo obscuro
















[Lista.MesInvTransfer.Transferido]
Carpeta=Lista
Clave=MesInvTransfer.Transferido
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

ColorFuente=Verde



[Acciones.SerieLote]
Nombre=SerieLote
Boton=18
NombreEnBoton=S
NombreDesplegar=Serie/Lote
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MesInvTransferSerieLote
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S



































EjecucionCondicion=MesInvTransfer:Art2.Tipo en (<T>Serie<T>, <T>Lote<T>)
AntesExpresiones=Asigna(Info.Articulo, MesInvTransfer:Art2.Articulo)<BR>aSIGNA(Info.ID, MesInvTransfer:MesInvTransfer.ID)<BR>Asigna(Info.Almacen, MesInvTransfer:MesInvTransfer.Almacen)<BR>Asigna(Info.Cantidad, MesInvTransfer:MesInvTransfer.CantidadA)











[Lista.ListaEnCaptura]
(Inicio)=MesInvTransfer.Padre
MesInvTransfer.Padre=ArtDestino.Descripcion1
ArtDestino.Descripcion1=MesInvTransfer.Hijo
MesInvTransfer.Hijo=Art2.Descripcion1
Art2.Descripcion1=Art2.Tipo
Art2.Tipo=MesInvTransfer.Almacen
MesInvTransfer.Almacen=MesInvTransfer.AlmacenD
MesInvTransfer.AlmacenD=MesInvTransfer.Cantidad
MesInvTransfer.Cantidad=MesInvTransfer.CantidadA
MesInvTransfer.CantidadA=ArtDisponible.Disponible
ArtDisponible.Disponible=MesInvTransfer.Transferido
MesInvTransfer.Transferido=MesInvTransfer.UltimoPrecioCoste
MesInvTransfer.UltimoPrecioCoste=MesInvTransfer.PrecioCosteMedio
MesInvTransfer.PrecioCosteMedio=MesInvTransfer.UnidMedidaCompra
MesInvTransfer.UnidMedidaCompra=MesInvTransfer.UnidMedidaAlmacen
MesInvTransfer.UnidMedidaAlmacen=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=AlmDetalle.Nombre
AlmDetalle.Nombre=AlmDestino.Nombre
AlmDestino.Nombre=(Fin)

[Lista.Art2.Tipo]
Carpeta=Lista
Clave=Art2.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Lanzamiento
Lanzamiento=Generar
Generar=Disponible
Disponible=SerieLote
SerieLote=(Fin)
