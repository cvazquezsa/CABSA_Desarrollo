
[Forma]
Clave=MovCartaPorte
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Movimientos - Carta Porte

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=214
PosicionInicialArriba=69
PosicionInicialAlturaCliente=550
PosicionInicialAncho=938
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionCol1=713
PosicionSec1=389
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BotonesPanelColor=Negro
[Lista]
Estilo=Iconos
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovCartaPorte
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha



BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaEnLinea=S
BusquedaAutoAsterisco=S
BusquedaAncho=20
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Movimiento
IconosSeleccionPorLlave=S
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
FiltroGrupo1=Sucursal.Nombre
FiltroValida1=Sucursal.Nombre
FiltroGrupo2=Alm.Nombre
FiltroValida2=Alm.Nombre
FiltroGrupo3=Cte.Nombre
FiltroValida3=Cte.Nombre
FiltroTodo=S
ListaAcciones=Reporte
MenuLocal=S
OtroOrden=S
ListaOrden=MovCartaPorte.ModuloID<TAB>(Acendente)
Paginacion=S
PaginacionTamano=15
IconosNombre=MovCartaPorte:Movimiento
FiltroGeneral=MovCartaPorte.Estacion ={EstacionTrabajo}
[Lista.Columnas]
Mov=124
MovID=124
Sucursal=64

0=144
1=241
2=113
3=106





4=94
5=106
6=-2
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S









[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=MovCartaPorteD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=MovCartaPorte
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


[Detalle.MovCartaPorteD.Articulo]
Carpeta=Detalle
Clave=MovCartaPorteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.MovCartaPorteD.Cantidad]
Carpeta=Detalle
Clave=MovCartaPorteD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.MovCartaPorteD.Unidad]
Carpeta=Detalle
Clave=MovCartaPorteD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.MovCartaPorteD.Precio]
Carpeta=Detalle
Clave=MovCartaPorteD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.MovCartaPorteD.Importe]
Carpeta=Detalle
Clave=MovCartaPorteD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Detalle.Columnas]
Articulo=58
Cantidad=64
Unidad=81
Precio=64
Importe=64









DescArt=198

[Lista.MovCartaPorte.Condicion]
Carpeta=Lista
Clave=MovCartaPorte.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MovCartaPorte.FormaPago]
Carpeta=Lista
Clave=MovCartaPorte.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MovCartaPorte.Moneda]
Carpeta=Lista
Clave=MovCartaPorte.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco















[Detalle.DescArt]
Carpeta=Detalle
Clave=DescArt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
































[Acciones.VerMovtos]
Nombre=VerMovtos
Boton=108
NombreDesplegar=Ver Movimientos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S











Expresion=FormaModal(<T>ParCartaPorte<T>)<BR>ActualizarForma
[Acciones.Paginacion]
Nombre=Paginacion
Boton=0
NombreDesplegar=Paginacion
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Paginacion
Activo=S
Visible=S







[Detalle.LlaveLocal]
(Inicio)=MovCartaPorteD.Modulo
MovCartaPorteD.Modulo=MovCartaPorteD.ModuloID
MovCartaPorteD.ModuloID=(Fin)

[Detalle.LlaveMaestra]
(Inicio)=MovCartaPorte.Modulo
MovCartaPorte.Modulo=MovCartaPorte.ModuloID
MovCartaPorte.ModuloID=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=MovCartaPorteD.Articulo
MovCartaPorteD.Articulo=DescArt
DescArt=MovCartaPorteD.Importe
MovCartaPorteD.Importe=MovCartaPorteD.Cantidad
MovCartaPorteD.Cantidad=MovCartaPorteD.Unidad
MovCartaPorteD.Unidad=MovCartaPorteD.Precio
MovCartaPorteD.Precio=(Fin)







[Acciones.ActualizarVista]
Nombre=ActualizarVista
Boton=45
NombreDesplegar=Actualizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S



Carpeta=Lista































[Acciones.CartaPorte.Registrar]
Nombre=Registrar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=RegistrarSeleccionID(<T>Lista<T>)






[Acciones.CartaPorte.Reporte]
Nombre=Reporte
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=CartaPorteVenta
Activo=S
Visible=S






[Acciones.CartaPorteVenta.ListaAccionesMultiples]
(Inicio)=Registrar
Registrar=Reporte
Reporte=(Fin)






[Acciones.CartaPorte.ListaAccionesMultiples]
(Inicio)=Registrar
Registrar=Reporte
Reporte=(Fin)


































[Acciones.Reporte]
Nombre=Reporte
Boton=0
NombreDesplegar=Crear Reporte
TipoAccion=Expresion
Visible=S













EnMenu=S









EnLote=S

































Antes=S
































Expresion=EjecutarSQL(<T>EXEC spCrearRuta :tRuta<T>, MovCartaPorte:MovCartaPorte.Ruta)<BR>Asigna(Info.ID, MovCartaPorte:MovCartaPorte.ModuloID)<BR>Asigna(Info.Modulo, MovCartaPorte:MovCartaPorte.Modulo)<BR>ReportePDF(<T>CartaPorteVenta<T>,MovCartaPorte:MovCartaPorte.ModuloID, MovCartaPorte:MovCartaPorte.Ruta+<T>\<T>+<T>Carta Porte <T>+MovCartaPorte:Movimiento)<BR>EjecutarSQL(<T>EXEC spRepCartaPortePDF :tModulo, :nID, :nSucursal, :tNombre, :tRuta<T>, <T>EMB<T>,MovCartaPorte:Embarque.ID, MovCartaPorte:MovCartaPorte.Sucursal, <T>Carta Porte <T>+MovCartaPorte:Movimiento+<T>.pdf<T>, MovCartaPorte:MovCartaPorte.Ruta+<T>\<T>+<T>Carta Porte <T>+MovCartaPorte:Movimiento+<T>.pdf<T>)
ActivoCondicion=CuantosSeleccionID(<T>Lista<T>) > 0
AntesExpresiones=RegistrarSeleccionID(<T>Lista<T>)
[Observaciones.MovCartaPorte.Observaciones]
Carpeta=Observaciones
Clave=MovCartaPorte.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25x10
ColorFondo=Blanco



[Observaciones.Columnas]
Observaciones=604



















[Observaciones.LlaveLocal]
(Inicio)=MovCartaPorte.Estacion
MovCartaPorte.Estacion=MovCartaPorte.Modulo
MovCartaPorte.Modulo=MovCartaPorte.ModuloID
MovCartaPorte.ModuloID=(Fin)

[Observaciones.LlaveMaestra]
(Inicio)=MovCartaPorte.Estacion
MovCartaPorte.Estacion=MovCartaPorte.Modulo
MovCartaPorte.Modulo=MovCartaPorte.ModuloID
MovCartaPorte.ModuloID=(Fin)
















[Observaciones.Movimiento]
Carpeta=Observaciones
Clave=Movimiento
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco















[Observaciones.ListaEnCaptura]
(Inicio)=Movimiento
Movimiento=MovCartaPorte.Observaciones
MovCartaPorte.Observaciones=(Fin)
























[Lista.Embarque]
Carpeta=Lista
Clave=Embarque
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MovCartaPorte.Observaciones]
Carpeta=Lista
Clave=MovCartaPorte.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco











































































[Lista.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=MovCartaPorte.Condicion
MovCartaPorte.Condicion=MovCartaPorte.FormaPago
MovCartaPorte.FormaPago=MovCartaPorte.Moneda
MovCartaPorte.Moneda=Embarque
Embarque=MovCartaPorte.Observaciones
MovCartaPorte.Observaciones=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=VerMovtos
VerMovtos=Paginacion
Paginacion=ActualizarVista
ActualizarVista=(Fin)
