
[Forma]
Clave=RutaDistribucionMaxMinOrden
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Ordenar Ruta de Distribución

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=500
PosicionInicialArriba=233
PosicionInicialAlturaCliente=223
PosicionInicialAncho=366
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RutaDistribucionMaxMin
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosCambiarOrden=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

OtroOrden=S
ListaOrden=RutaDistribucionMaxMin.Orden<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=RutaDistribucionMaxMin:RutaDistribucionMaxMin.AlmacenOrigen
IconosSubTitulo=<T>Almacen Orígen<T>
FiltroGeneral=RutaDistribucionMaxMin.AlmacenDestino = {Comillas(Info.Almacen)}

[Lista.Columnas]
0=164

1=173
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
[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S








[Acciones.Aceptar.Ordena]
Nombre=Ordena
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=RegistrarListaSt(<T>Lista<T>,<T>RutaDistribucionMaxMin.AlmacenOrigen<T>)<BR>EjecutarSQL(<T>EXEC spOrdenarPlanRutaDistribucion :nEstacion, :tAlmacen<T>, EstacionTrabajo, Info.Almacen)
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S









[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Ordena
Ordena=Aceptar
Aceptar=(Fin)






[Lista.ListaEnCaptura]
(Inicio)=RutaDistribucionMaxMin.AlmacenOrigen
RutaDistribucionMaxMin.AlmacenOrigen=RutaDistribucionMaxMin.AlmacenDestino
RutaDistribucionMaxMin.AlmacenDestino=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
