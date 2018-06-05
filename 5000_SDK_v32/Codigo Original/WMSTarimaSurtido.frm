
[Forma]
Clave=WMSTarimaSurtido
Icono=0
Modulos=(Todos)
MovModulo=WMSTarimaSurtido
Nombre=WMS - Tarimas Disponibles

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=169
PosicionInicialArriba=142
PosicionInicialAlturaCliente=361
PosicionInicialAncho=904
Totalizadores=S
PosicionSec1=287
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSTarimaSurtido
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=WMSTarimaSurtido.Movimiento
FiltroValida1=WMSTarimaSurtido.Movimiento
FiltroGrupo2=WMSTarimaSurtido.Articulo
FiltroValida2=WMSTarimaSurtido.Articulo
FiltroTodo=S
FiltroTodoFinal=S
FiltroGeneral=WMSTarimaSurtido.Estacion = {EstacionTrabajo}
[Lista.WMSTarimaSurtido.Almacen]
Carpeta=Lista
Clave=WMSTarimaSurtido.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.WMSTarimaSurtido.Posicion]
Carpeta=Lista
Clave=WMSTarimaSurtido.Posicion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.WMSTarimaSurtido.Articulo]
Carpeta=Lista
Clave=WMSTarimaSurtido.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.WMSTarimaSurtido.Tarima]
Carpeta=Lista
Clave=WMSTarimaSurtido.Tarima
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.WMSTarimaSurtido.Disponible]
Carpeta=Lista
Clave=WMSTarimaSurtido.Disponible
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.WMSTarimaSurtido.CantidadA]
Carpeta=Lista
Clave=WMSTarimaSurtido.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Lista.Columnas]
Almacen=64
Posicion=64
Articulo=85
Tarima=111
Disponible=64
CantidadA=64












Apartado=64
SerieLote=122
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
Totalizadores2=Redondea(Suma(WMSTarimaSurtido:WMSTarimaSurtido.CantidadA))
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=Total

TotAlCambiar=S
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

[Acciones.Aceptar.Verificar]
Nombre=Verificar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=GuardarCambios<BR>Asigna(Info.Mensaje, SQL(<T>EXEC spWMSValidaTarimaMovSurtido :nEstacion, 0<T>, EstacionTrabajo))<BR>Si<BR>    Info.Mensaje <> <T><T><BR>Entonces<BR>    ProcesarSQL(<T>EXEC spWMSValidaTarimaMovSurtido :nEstacion, 0<T>, EstacionTrabajo)<BR>Fin



[Acciones.Aceptar.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionCondicion=Info.Mensaje = <T><T>
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Verificar
Verificar=Actualizar
Actualizar=(Fin)


[Lista.WMSTarimaSurtido.Apartado]
Carpeta=Lista
Clave=WMSTarimaSurtido.Apartado
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.WMSTarimaSurtido.SerieLote]
Carpeta=Lista
Clave=WMSTarimaSurtido.SerieLote
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Acciones.MostarCampos]
Nombre=MostarCampos
Boton=45
NombreDesplegar=MostarCampos
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=WMSTarimaSurtido.Almacen
WMSTarimaSurtido.Almacen=WMSTarimaSurtido.Posicion
WMSTarimaSurtido.Posicion=WMSTarimaSurtido.Articulo
WMSTarimaSurtido.Articulo=WMSTarimaSurtido.Tarima
WMSTarimaSurtido.Tarima=WMSTarimaSurtido.SerieLote
WMSTarimaSurtido.SerieLote=WMSTarimaSurtido.Disponible
WMSTarimaSurtido.Disponible=WMSTarimaSurtido.Apartado
WMSTarimaSurtido.Apartado=WMSTarimaSurtido.CantidadA
WMSTarimaSurtido.CantidadA=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=MostarCampos
MostarCampos=(Fin)
