
[Forma]
Clave=POSCierreDia
Icono=0
CarpetaPrincipal=POSCierreDia
Modulos=(Todos)
Nombre=Cierre Día

ListaCarpetas=POSCierreDia
PosicionInicialAlturaCliente=518
PosicionInicialAncho=540
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=413
PosicionInicialArriba=85
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[POSCierreDia]
Estilo=Iconos
PestanaOtroNombre=S
Clave=POSCierreDia
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCierreDia
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Sucursal<T>
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
MenuLocal=S
IconosNombre=POSCierreDia:Sucursal.Nombre
FiltroGeneral=POSCierreDia.Empresa = <T>{Empresa}<T>
ListaAcciones=(Lista)
[POSCierreDia.POSCierreDia.FechaEmision]
Carpeta=POSCierreDia
Clave=POSCierreDia.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[POSCierreDia.POSCierreDia.Moneda]
Carpeta=POSCierreDia
Clave=POSCierreDia.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[POSCierreDia.Columnas]
0=80
1=137
2=-2




[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Expresion]
Nombre=Expresion
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
























EspacioPrevio=S
Expresion=RegistrarSeleccionID(<T>POSCierreDia<T> )





[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[POSCierreDia.ListaEnCaptura]
(Inicio)=POSCierreDia.FechaEmision
POSCierreDia.FechaEmision=POSCierreDia.Moneda
POSCierreDia.Moneda=(Fin)

[POSCierreDia.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)


























[Lista.Columnas]
Mov=198























































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=(Fin)
