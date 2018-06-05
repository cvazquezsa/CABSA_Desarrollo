
[Forma]
Clave=InvArtUbicacionD
Icono=0
CarpetaPrincipal=Detalle
Modulos=(Todos)
Nombre=Inventarios- Asignar Diferente Ubicación

ListaCarpetas=Detalle
PosicionInicialIzquierda=476
PosicionInicialArriba=242
PosicionInicialAlturaCliente=192
PosicionInicialAncho=365

VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaSiempreAlFrente=S
VentanaExclusiva=S
VentanaExclusivaOpcion=0
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=guardar
VentanaAjustarZonas=S
[ficha.Columnas]
Articulo=124
RID=64
Existencia=64





ID=64
SubCuenta=304
SerieLote=304
Unidad=304
Posicion=64
CantidadA=64
PosicionDestino=78
[ficha.ListaEnCaptura]
(Inicio)=invArtUbicaciones.Articulo
invArtUbicaciones.Articulo=invArtUbicaciones.RID
invArtUbicaciones.RID=invArtUbicaciones.Existencia
invArtUbicaciones.Existencia=(Fin)

[Detalle]
Estilo=Hoja
Clave=Detalle
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvArtUbicacionD
Fuente={Tahoma, 8, Negro, []}
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S


GuardarAlSalir=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=(Lista)
FiltroGeneral=InvArtUbicacionD.RID ={Info.ID}
[Detalle.InvArtUbicacionD.Posicion]
Carpeta=Detalle
Clave=InvArtUbicacionD.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

Color=Negro
[Detalle.InvArtUbicacionD.Cantidad]
Carpeta=Detalle
Clave=InvArtUbicacionD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Color=Negro
[Detalle.Columnas]
Posicion=64
Cantidad=64

RID=64
ID=64
[Lista.Columnas]
0=106
1=276
2=122















[Acciones.guardar]
Nombre=guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S











Antes=S
DespuesGuardar=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.Cantidad2,SQL(<T>exec spValidaCantUbic :nID, :nExisencia<T>,Info.IDR,Info.Cantidad))<BR>Si<BR> Info.Cantidad<Info.Cantidad2<BR>Entonces<BR>  Error(<T>La cantidad asignada excede a la existencia<T>)<BR><BR>Fin


[Detalle.ListaEnCaptura]
(Inicio)=InvArtUbicacionD.Posicion
InvArtUbicacionD.Posicion=InvArtUbicacionD.Cantidad
InvArtUbicacionD.Cantidad=(Fin)
