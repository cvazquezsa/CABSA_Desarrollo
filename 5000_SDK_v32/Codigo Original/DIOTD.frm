
[Forma]
Clave=DIOTD
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=DPIVA - Detalle
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=DIOTD
CarpetaPrincipal=DIOTD
PosicionInicialAlturaCliente=520
PosicionInicialAncho=839
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=263
PosicionInicialArriba=85
Comentarios=Info.Anuncio
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

[DIOTD]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=DIOTD
Clave=DIOTD
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOTD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosSubTitulo=<T>Movimiento<T>

ListaEnCaptura=(Lista)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosNombre=DIOTD:Movimiento
FiltroGeneral=DIOTD.EstacionTrabajo = {EstacionTrabajo} AND DIOTD.TipoOperacion = {Info.ID}
[DIOTD.Columnas]
0=108

1=85
2=62
3=108
4=-2
5=78
6=85
7=39
8=72

9=95
10=82
11=104
12=93
13=68
[DIOTD.NumeroPago]
Carpeta=DIOTD
Clave=NumeroPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[DIOTD.DIOTD.Proveedor]
Carpeta=DIOTD
Clave=DIOTD.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[DIOTD.DIOTD.Nombre]
Carpeta=DIOTD
Clave=DIOTD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[DIOTD.DIOTD.FechaEmision]
Carpeta=DIOTD
Clave=DIOTD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[DIOTD.DIOTD.FechaPago]
Carpeta=DIOTD
Clave=DIOTD.FechaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[DIOTD.DIOTD.Importe]
Carpeta=DIOTD
Clave=DIOTD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[DIOTD.DIOTD.Tasa]
Carpeta=DIOTD
Clave=DIOTD.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[DIOTD.DIOTD.IVA]
Carpeta=DIOTD
Clave=DIOTD.IVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Acciones.PersonalizarVista]
Nombre=PersonalizarVista
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=DIOTD
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S






[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=DIOTD
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S




[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=DIOTD
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S








EspacioPrevio=S
[Acciones.Preliminar]
Nombre=Preliminar
Boton=68
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
Carpeta=DIOTD
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S



















[DIOTD.DIOTD.Retencion2]
Carpeta=DIOTD
Clave=DIOTD.Retencion2
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
















[DIOTD.DIOTD.DineroImporte]
Carpeta=DIOTD
Clave=DIOTD.DineroImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[DIOTD.DIOTD.DineroFormaPago]
Carpeta=DIOTD
Clave=DIOTD.DineroFormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[DIOTD.Poliza]
Carpeta=DIOTD
Clave=Poliza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[DIOTD.ListaEnCaptura]
(Inicio)=NumeroPago
NumeroPago=DIOTD.Proveedor
DIOTD.Proveedor=DIOTD.Nombre
DIOTD.Nombre=DIOTD.FechaEmision
DIOTD.FechaEmision=DIOTD.FechaPago
DIOTD.FechaPago=DIOTD.Importe
DIOTD.Importe=DIOTD.Tasa
DIOTD.Tasa=DIOTD.IVA
DIOTD.IVA=DIOTD.Retencion2
DIOTD.Retencion2=MovimientoTesoreria
MovimientoTesoreria=DIOTD.DineroImporte
DIOTD.DineroImporte=DIOTD.DineroFormaPago
DIOTD.DineroFormaPago=Poliza
Poliza=(Fin)

[DIOTD.MovimientoTesoreria]
Carpeta=DIOTD
Clave=MovimientoTesoreria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=PersonalizarVista
PersonalizarVista=(Fin)
