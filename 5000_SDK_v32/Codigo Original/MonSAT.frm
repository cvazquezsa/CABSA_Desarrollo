
[Forma]
Clave=MonSAT
Icono=4
BarraHerramientas=S
Modulos=(Todos)
Nombre=Monedas
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=466
PosicionInicialArriba=153
PosicionInicialAlturaCliente=382
PosicionInicialAncho=434
PosicionCol1=208
ListaAcciones=Guardar
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MonSAT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Moneda<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Mon.TipoCambio

CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Lista
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
OtroOrden=S
IconosNombre=MonSAT:Mon.Moneda
ListaOrden=Mon.Orden<TAB>(Acendente)
[Lista.ListaEnCaptura]
(Inicio)=Mon.Nombre
Mon.Nombre=Mon.TipoCambio
Mon.TipoCambio=(Fin)


[Lista.Mon.TipoCambio]
Carpeta=Lista
Clave=Mon.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=86
1=101
2=-2

[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MonSAT
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Detalle.Mon.Moneda]
Carpeta=Detalle
Clave=Mon.Moneda
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Detalle.Mon.Clave]
Carpeta=Detalle
Clave=Mon.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Detalle.ListaEnCaptura]
(Inicio)=Mon.Moneda
Mon.Moneda=Mon.Clave
Mon.Clave=(Fin)




[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)
