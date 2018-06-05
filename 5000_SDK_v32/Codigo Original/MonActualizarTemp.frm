
[Forma]
Clave=MonActualizarTemp
Icono=0
CarpetaPrincipal=Iconos
Modulos=(Todos)
Nombre=<T>Actualizar Tipos de Cambio<T>

ListaCarpetas=Iconos
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=553
PosicionInicialArriba=277
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spMonConsultarTipoCambio :nEstacionTrabajo<T>, EstacionTrabajo)
[Iconos]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Iconos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MonActualizarTemp
Fuente={Tahoma, 8, Negro, []}
IconosCampo=MonActualizarTemp.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

IconosSubTitulo=<T>Moneda<T>


Filtros=S
IconosNombre=MonActualizarTemp:MonActualizarTemp.Moneda
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=MonActualizarTemp.Estacion={EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[Iconos.MonActualizarTemp.Codigo]
Carpeta=Iconos
Clave=MonActualizarTemp.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Iconos.MonActualizarTemp.TipoCambio]
Carpeta=Iconos
Clave=MonActualizarTemp.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Iconos.MonActualizarTemp.Estatus]
Carpeta=Iconos
Clave=MonActualizarTemp.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco






[Iconos.Columnas]
0=-2
1=-2
2=-2
3=-2












[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=92
NombreEnBoton=S
NombreDesplegar=Actualizar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S

EspacioPrevio=S








ClaveAccion=Aceptar
Antes=S
AntesExpresiones=EjecutarSQL(<T>EXEC spMonActualizarTipoCambio :nEstaciontrabajo<T>, EstacionTrabajo)





































[Iconos.ListaEnCaptura]
(Inicio)=MonActualizarTemp.Codigo
MonActualizarTemp.Codigo=MonActualizarTemp.TipoCambio
MonActualizarTemp.TipoCambio=MonActualizarTemp.Estatus
MonActualizarTemp.Estatus=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Actualizar
Actualizar=(Fin)
