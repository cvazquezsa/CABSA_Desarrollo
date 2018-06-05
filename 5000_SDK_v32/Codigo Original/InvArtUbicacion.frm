
[Forma]
Clave=InvArtUbicacion
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=Inventarios-  Ubicacion de Articulo

ListaCarpetas=Lista
PosicionInicialIzquierda=226
PosicionInicialArriba=224
PosicionInicialAlturaCliente=338
PosicionInicialAncho=903
VentanaSiempreAlFrente=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
VentanaExclusiva=S
VentanaExclusivaOpcion=0
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaAjustarZonas=S
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=invArtUbicaciones
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Gris
ListaEnCaptura=(Lista)

CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S










MenuLocal=S
ListaAcciones=AsigVarUbic
GuardarAlSalir=S
FiltroGeneral=invArtUbicaciones.Articulo={Comillas(Temp.Texto)} AND   invArtUbicaciones.Renglon={Info.Renglon} AND<BR>invArtUbicaciones.ID=  {Comillas(Info.ID)}
[Lista.Columnas]
Empresa=45
Almacen=64
SerieLote=76
Articulo=124
SubCuenta=76
Unidad=63
Existencia=64
ExistenciaAlterna=87
Posicion=64
Descripcion1=184



























ID=64
CantidadA=99
PosicionDestino=96

0=106
1=276
2=122
RID=64
Renglon=64

[Lista.invArtUbicaciones.Articulo]
Carpeta=Lista
Clave=invArtUbicaciones.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Gris

[Lista.invArtUbicaciones.SubCuenta]
Carpeta=Lista
Clave=invArtUbicaciones.SubCuenta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Gris

[Lista.invArtUbicaciones.SerieLote]
Carpeta=Lista
Clave=invArtUbicaciones.SerieLote
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Gris

[Lista.invArtUbicaciones.Unidad]
Carpeta=Lista
Clave=invArtUbicaciones.Unidad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Gris

[Lista.invArtUbicaciones.Existencia]
Carpeta=Lista
Clave=invArtUbicaciones.Existencia
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Gris

[Lista.invArtUbicaciones.Posicion]
Carpeta=Lista
Clave=invArtUbicaciones.Posicion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Gris

[Lista.invArtUbicaciones.CantidadA]
Carpeta=Lista
Clave=invArtUbicaciones.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.invArtUbicaciones.PosicionDestino]
Carpeta=Lista
Clave=invArtUbicaciones.PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco












[Acciones.AsigVarUbic]
Nombre=AsigVarUbic
Boton=0
NombreDesplegar=Asignas Varias Ubicaciones
EnMenu=S
Activo=S
Visible=S











TipoAccion=Formas
ClaveAccion=InvArtUbicacionD
















Antes=S













AntesExpresiones=Asigna(Info.IDR, invArtUbicaciones:invArtUbicaciones.RID)<BR>Asigna(Info.Cantidad,invArtUbicaciones:invArtUbicaciones.Existencia)
[Acciones.Aceptar.Guardar]
Nombre=Guardar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Aceptar.salir]
Nombre=salir
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Guardar
Guardar=salir
salir=(Fin)



[Acciones.Guardar ]
Nombre=Guardar 
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S





[Lista.invArtUbicaciones.Almacen]
Carpeta=Lista
Clave=invArtUbicaciones.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Gris






































[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S



NombreEnBoton=S



























RefrescarDespues=S




Expresion=EjecutarSQL(<T>spActualizarUbicaciones :nID, :nRenglon,  :tArticulo, :tAlmacen, :tEmpresa<T>,Info.ID,Info.Renglon,Temp.Texto,Info.Almacen,Empresa)<BR> ActualizarVista
ActivoCondicion=info.Estatus <>EstatusConcluido
[Lista.ListaEnCaptura]
(Inicio)=invArtUbicaciones.Articulo
invArtUbicaciones.Articulo=invArtUbicaciones.SubCuenta
invArtUbicaciones.SubCuenta=invArtUbicaciones.SerieLote
invArtUbicaciones.SerieLote=invArtUbicaciones.Unidad
invArtUbicaciones.Unidad=invArtUbicaciones.Existencia
invArtUbicaciones.Existencia=invArtUbicaciones.Posicion
invArtUbicaciones.Posicion=invArtUbicaciones.Almacen
invArtUbicaciones.Almacen=invArtUbicaciones.PosicionDestino
invArtUbicaciones.PosicionDestino=invArtUbicaciones.CantidadA
invArtUbicaciones.CantidadA=(Fin)















[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Actualizar
Actualizar=(Fin)
