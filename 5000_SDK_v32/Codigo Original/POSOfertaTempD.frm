
[Forma]
Clave=POSOfertaTempD
Icono=0
CarpetaPrincipal=POSOfertaTempD
Modulos=(Todos)
Nombre=Modificar Ofertas Puntos/Importe
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSOfertaTempD
PosicionInicialIzquierda=463
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=673
ListaAcciones=(Lista)
Lista(<T>Monedero: <T>+Info.POSMonedero,<T>Saldo Disponible: $<T>+Info.Disponible)
Comentarios=Lista(<T>Monedero: <T>+Info.POSMonedero,<T>Saldo Disponible: $<T>+Info.Disponible)
[POSOfertaTempD]
Estilo=Hoja
Clave=POSOfertaTempD
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSOfertaTempD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaFondoGris=S
FiltroGeneral=POSOfertaTempD.Estacion = {EstacionTrabajo} AND POSOfertaTempD.IDR = <T>{Info.IDTexto}<T>
[POSOfertaTempD.POSOfertaTempD.Articulo]
Carpeta=POSOfertaTempD
Clave=POSOfertaTempD.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[POSOfertaTempD.POSOfertaTempD.Precio]
Carpeta=POSOfertaTempD
Clave=POSOfertaTempD.Precio
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[POSOfertaTempD.POSOfertaTempD.Puntos]
Carpeta=POSOfertaTempD
Clave=POSOfertaTempD.Puntos
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[POSOfertaTempD.POSOfertaTempD.CantidadO]
Carpeta=POSOfertaTempD
Clave=POSOfertaTempD.CantidadO
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[POSOfertaTempD.POSOfertaTempD.CantidadM]
Carpeta=POSOfertaTempD
Clave=POSOfertaTempD.CantidadM
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSOfertaTempD.PuntosUsar]
Carpeta=POSOfertaTempD
Clave=PuntosUsar
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[POSOfertaTempD.ImporteTotal]
Carpeta=POSOfertaTempD
Clave=ImporteTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[POSOfertaTempD.Columnas]
Articulo=124
Precio=64
Puntos=83
CantidadO=86
CantidadM=101
PuntosUsar=82
ImporteTotal=69

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Condicion,SQL(<T>SELECT dbo.fnPOSValidarImporteMonedero2(:tID,:nEstacion,:nDisponible)<T>,Info.IDTexto,EstacionTrabajo,Info.Disponible))<BR>  Si<BR>    Vacio(Info.Condicion)<BR>  Entonces<BR>    EjecutarSQL(<T>spPOSReInsertarArtOfertaTemp :nEstacion, :tID<T>,EstacionTrabajo,Info.IDTexto)<BR>  SiNo<BR>    Informacion(Info.Condicion)<BR>  Fin
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

ConCondicion=S
EjecucionCondicion=Vacio(Info.Condicion)
EjecucionMensaje=Info.Condicion
EjecucionConError=S
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aplicar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
EspacioPrevio=S





[POSOfertaTempD.ListaEnCaptura]
(Inicio)=POSOfertaTempD.Articulo
POSOfertaTempD.Articulo=POSOfertaTempD.Precio
POSOfertaTempD.Precio=POSOfertaTempD.Puntos
POSOfertaTempD.Puntos=POSOfertaTempD.CantidadO
POSOfertaTempD.CantidadO=POSOfertaTempD.CantidadM
POSOfertaTempD.CantidadM=PuntosUsar
PuntosUsar=ImporteTotal
ImporteTotal=(Fin)














[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Aceptar
Aceptar=(Fin)
