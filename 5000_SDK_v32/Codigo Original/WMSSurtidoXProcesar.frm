
[Forma]
Clave=WMSSurtidoXProcesar
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=WMS - Completar Surtidos

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=489
PosicionInicialAncho=815
PosicionInicialIzquierda=205
PosicionInicialArriba=68
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSec1=263
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
ExpresionesAlMostrar= EjecutarSQL(<T>EXEC spWMSValidaTarimaMovSurtido :nEstacion, 1<T>, EstacionTrabajo)
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSSurtidosXProcesar
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S


IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200

IconosSeleccionPorLlave=S
IconosSeleccionMultiple=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General








ListaEnCaptura=(Lista)
MenuLocal=S
ListaAcciones=VerTarimas
IconosNombre=WMSSurtidosXProcesar:Movimiento
FiltroGeneral=Estacion = EstacionTrabajo
[Lista.Columnas]
Movimiento=159
MovOrigen=116
Almacen=64
Articulo=124
SubCuenta=119
Posicion=64
Zona=117
CantidadPicking=79
Tarima=124


0=173
1=163
2=-2
3=-2
4=80
5=-2
6=66
7=97
8=-2
Disponible=64
CantidadA=64
Apartado=64
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S







[Lista.MovOrigen]
Carpeta=Lista
Clave=MovOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Articulo]
Carpeta=Lista
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SubCuenta]
Carpeta=Lista
Clave=SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Zona]
Carpeta=Lista
Clave=Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Posicion]
Carpeta=Lista
Clave=Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Tarima]
Carpeta=Lista
Clave=Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CantidadPicking]
Carpeta=Lista
Clave=CantidadPicking
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Acciones.Procesar]
Nombre=Procesar
Boton=7
NombreEnBoton=S
NombreDesplegar=Procesar
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S





ListaAccionesMultiples=(Lista)
[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=WMSTarimaSurtido
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=WMSSurtidosXProcesar
LlaveLocal=(Lista)

LlaveMaestra=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S






ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=WMSTarimaSurtido.CantidadA > 0
[Acciones.VerTarimas.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=RegistrarSeleccionID( <T>ListaID<T> )<BR>EjecutarSQL(<T>EXEC spWMSSurtidosPendientes :tEmpresa, :nEstacion<T>, Empresa, EstacionTrabajo )<BR>FormaModal(<T>WMSTarimaSurtido<T>)<BR>ActualizarForma
[Acciones.VerTarimas]
Nombre=VerTarimas
Boton=0
NombreDesplegar=&Ver Tarimas
Multiple=S
EnMenu=S
ListaAccionesMultiples=Expresion
Activo=S
Visible=S





[Detalle.WMSTarimaSurtido.Almacen]
Carpeta=Detalle
Clave=WMSTarimaSurtido.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.WMSTarimaSurtido.Articulo]
Carpeta=Detalle
Clave=WMSTarimaSurtido.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.WMSTarimaSurtido.Tarima]
Carpeta=Detalle
Clave=WMSTarimaSurtido.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.WMSTarimaSurtido.SerieLote]
Carpeta=Detalle
Clave=WMSTarimaSurtido.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.WMSTarimaSurtido.CantidadA]
Carpeta=Detalle
Clave=WMSTarimaSurtido.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Detalle.Columnas]
Almacen=64
Articulo=124
Tarima=124
SerieLote=304
CantidadA=64






[Detalle.LlaveLocal]
(Inicio)=WMSTarimaSurtido.Estacion
WMSTarimaSurtido.Estacion=WMSTarimaSurtido.ID
WMSTarimaSurtido.ID=(Fin)

[Detalle.LlaveMaestra]
(Inicio)=Estacion
Estacion=ID
ID=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=WMSTarimaSurtido.Almacen
WMSTarimaSurtido.Almacen=WMSTarimaSurtido.Articulo
WMSTarimaSurtido.Articulo=WMSTarimaSurtido.Tarima
WMSTarimaSurtido.Tarima=WMSTarimaSurtido.SerieLote
WMSTarimaSurtido.SerieLote=WMSTarimaSurtido.CantidadA
WMSTarimaSurtido.CantidadA=(Fin)



















[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=Mostrar Campos
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

























[Acciones.Procesar.Procesar]
Nombre=Procesar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S















Expresion=GuardarCambios<BR>Asigna(Info.Mensaje, SQL(<T>EXEC spWMSValidaTarimaMovSurtido :nEstacion, 0<T>, EstacionTrabajo))<BR>Si<BR>    Info.Mensaje = <T><T><BR>Entonces<BR>    EjecutarSQL(<T>EXEC spWMSRegeneraMovSurtido :nEstacion, :tUsuario<T>, EstacionTrabajo, Usuario)<BR>    EjecutarSQL(<T>EXEC spWMSValidaTarimaMovSurtido :nEstacion, 1<T>, EstacionTrabajo)<BR>    EjecutarSQL(<T>EXEC spWMSSurtidosXProcesar :nEstacion<T>, EstacionTrabajo)<BR>SiNo<BR>    Informacion(Info.Mensaje)<BR>Fin


[Acciones.Procesar.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Procesar.ListaAccionesMultiples]
(Inicio)=Procesar
Procesar=Actualizar
Actualizar=(Fin)
























[Lista.ListaEnCaptura]
(Inicio)=MovOrigen
MovOrigen=Articulo
Articulo=SubCuenta
SubCuenta=Zona
Zona=Posicion
Posicion=Tarima
Tarima=CantidadPicking
CantidadPicking=(Fin)









[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Procesar
Procesar=MostrarCampos
MostrarCampos=(Fin)
