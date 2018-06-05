
[Forma]
Clave=WMSTarimaDisponible
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=WMS - Tarimas
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=299
PosicionInicialArriba=162
PosicionInicialAlturaCliente=364
PosicionInicialAncho=768
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionCol1=105
Totalizadores=S
PosicionSec1=255
PosicionSec2=96
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
Activo=S
Visible=S

GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSTarimaDisponible
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S

PermiteEditar=S
GuardarAlSalir=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodoFinal=S



FiltroGrupo1=WMSTarimaDisponible.Movimiento
FiltroValida1=WMSTarimaDisponible.Movimiento
ListaEnCaptura=(Lista)
FiltroGrupo2=WMSTarimaDisponible.Articulo
FiltroValida2=WMSTarimaDisponible.Articulo
FiltroGeneral={<T>WMSTarimaDisponible.ID IN (SELECT ID FROM LISTAID WHERE ESTACION =<T>}{EstacionTrabajo}{<T>)<T>}
[Lista.Columnas]
Tarima=77
Articulo=89
Almacen=64
Posicion=64
Disponible=64
CantidadA=64

















Bandera=64

0=51
1=51
2=66
3=64
4=-2

SerieLote=76
SubCuenta=68
Apartado=64
[Acciones.Aceptar.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Aceptar


ConCondicion=S
EjecucionCondicion=Info.Mensaje = <T><T>
[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=MostrarCampos
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
















[Seleccionar.WMSTarimaSurtido.Bandera]
Carpeta=Seleccionar
Clave=WMSTarimaSurtido.Bandera
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco



OcultaNombre=S
EspacioPrevio=N
[Seleccionar.Columnas]
Bandera=64



Tarima=124

[Seleccionar.ListaEnCaptura]
(Inicio)=WMSTarimaSurtido.Bandera
WMSTarimaSurtido.Bandera=WMSTarimaSurtido.Tarima
WMSTarimaSurtido.Tarima=(Fin)














[Seleccionar.LlaveLocal]
(Inicio)=WMSTarimaSurtido.Estacion
WMSTarimaSurtido.Estacion=WMSTarimaSurtido.ID
WMSTarimaSurtido.ID=WMSTarimaSurtido.Empresa
WMSTarimaSurtido.Empresa=WMSTarimaSurtido.Articulo
WMSTarimaSurtido.Articulo=(Fin)

[Seleccionar.LlaveMaestra]
(Inicio)=WMSTarimaSurtido.Estacion
WMSTarimaSurtido.Estacion=WMSTarimaSurtido.ID
WMSTarimaSurtido.ID=WMSTarimaSurtido.Empresa
WMSTarimaSurtido.Empresa=WMSTarimaSurtido.Articulo
WMSTarimaSurtido.Articulo=(Fin)








[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total
Totalizadores2=Redondea(Suma(WMSTarimaDisponible:WMSTarimaDisponible.CantidadA)) & <T>/<T> &Redondea(WMSTarimaDisponible:WMSPedidosSinSurtir.Cantidad)
Totalizadores3=
Totalizadores=S
TotAlCambiar=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S



ListaEnCaptura=Total

TotCarpetaRenglones=Lista
[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata












Efectos=[Negritas]












[Acciones.Aceptar.Validar]
Nombre=Validar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
























Expresion=GuardarCambios<BR>Asigna(Info.Mensaje, SQL(<T>EXEC spWMSValidaTarimaSurtido :nEstacion, 0<T>, EstacionTrabajo))<BR>Si<BR>    Info.Mensaje <> <T><T><BR>Entonces<BR>    ProcesarSQL(<T>EXEC spWMSValidaTarimaSurtido :nEstacion, 0<T>, EstacionTrabajo)<BR>Fin







[Lista.ListaCamposAValidar]
(Inicio)=WMSTarimaDisponible.Almacen
WMSTarimaDisponible.Almacen=WMSTarimaDisponible.Articulo
WMSTarimaDisponible.Articulo=WMSTarimaDisponible.SubCuenta
WMSTarimaDisponible.SubCuenta=WMSTarimaDisponible.Tarima
WMSTarimaDisponible.Tarima=WMSTarimaDisponible.SerieLote
WMSTarimaDisponible.SerieLote=WMSTarimaDisponible.Disponible
WMSTarimaDisponible.Disponible=WMSTarimaDisponible.CantidadA
WMSTarimaDisponible.CantidadA=(Fin)



[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Validar
Validar=Actualizar
Actualizar=(Fin)





































[Detalle.WMSTarimaDisponible.Almacen]
Carpeta=Detalle
Clave=WMSTarimaDisponible.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.Articulo]
Carpeta=Detalle
Clave=WMSTarimaDisponible.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.Tarima]
Carpeta=Detalle
Clave=WMSTarimaDisponible.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.SerieLote]
Carpeta=Detalle
Clave=WMSTarimaDisponible.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.Disponible]
Carpeta=Detalle
Clave=WMSTarimaDisponible.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.WMSTarimaDisponible.CantidadA]
Carpeta=Detalle
Clave=WMSTarimaDisponible.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Detalle.Columnas]
Almacen=64
Articulo=90
Tarima=89
SerieLote=75
Disponible=64
CantidadA=64

[Detalle.ListaEnCaptura]
(Inicio)=WMSTarimaDisponible.Almacen
WMSTarimaDisponible.Almacen=WMSTarimaDisponible.Articulo
WMSTarimaDisponible.Articulo=WMSTarimaDisponible.Tarima
WMSTarimaDisponible.Tarima=WMSTarimaDisponible.SerieLote
WMSTarimaDisponible.SerieLote=WMSTarimaDisponible.Disponible
WMSTarimaDisponible.Disponible=WMSTarimaDisponible.CantidadA
WMSTarimaDisponible.CantidadA=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)







[Lista.WMSTarimaDisponible.Articulo]
Carpeta=Lista
Clave=WMSTarimaDisponible.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.WMSTarimaDisponible.SubCuenta]
Carpeta=Lista
Clave=WMSTarimaDisponible.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSTarimaDisponible.Tarima]
Carpeta=Lista
Clave=WMSTarimaDisponible.Tarima
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.WMSTarimaDisponible.SerieLote]
Carpeta=Lista
Clave=WMSTarimaDisponible.SerieLote
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.WMSTarimaDisponible.Disponible]
Carpeta=Lista
Clave=WMSTarimaDisponible.Disponible
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.WMSTarimaDisponible.CantidadA]
Carpeta=Lista
Clave=WMSTarimaDisponible.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco















[Lista.WMSTarimaDisponible.Apartado]
Carpeta=Lista
Clave=WMSTarimaDisponible.Apartado
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Lista.ListaEnCaptura]
(Inicio)=WMSTarimaDisponible.Articulo
WMSTarimaDisponible.Articulo=WMSTarimaDisponible.SubCuenta
WMSTarimaDisponible.SubCuenta=WMSTarimaDisponible.Tarima
WMSTarimaDisponible.Tarima=WMSTarimaDisponible.SerieLote
WMSTarimaDisponible.SerieLote=WMSTarimaDisponible.Disponible
WMSTarimaDisponible.Disponible=WMSTarimaDisponible.Apartado
WMSTarimaDisponible.Apartado=WMSTarimaDisponible.CantidadA
WMSTarimaDisponible.CantidadA=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=MostrarCampos
MostrarCampos=(Fin)
