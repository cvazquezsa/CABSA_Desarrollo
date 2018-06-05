
[Forma]
Clave=POSIsyncMonitor
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Isync Monitor

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=70
PosicionInicialArriba=95
PosicionInicialAlturaCliente=630
PosicionInicialAncho=1420
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Refrescar
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSIsyncMonitor
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>BATCH<T>
IconosCambiarOrden=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=POSIsyncMonitor.Batch<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
CarpetaVisible=S

BusquedaRapida=S
BusquedaEnLinea=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ER
IconosNombre=POSIsyncMonitor:POSIsyncMonitor.Batch
[Lista.POSIsyncMonitor.Nodo]
Carpeta=Lista
Clave=POSIsyncMonitor.Nodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.POSIsyncMonitor.Canal]
Carpeta=Lista
Clave=POSIsyncMonitor.Canal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.POSIsyncMonitor.Estatus]
Carpeta=Lista
Clave=POSIsyncMonitor.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.POSIsyncMonitor.ContExtraccion]
Carpeta=Lista
Clave=POSIsyncMonitor.ContExtraccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSIsyncMonitor.ContEnvio]
Carpeta=Lista
Clave=POSIsyncMonitor.ContEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSIsyncMonitor.ContCarga]
Carpeta=Lista
Clave=POSIsyncMonitor.ContCarga
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSIsyncMonitor.EstadoSQL]
Carpeta=Lista
Clave=POSIsyncMonitor.EstadoSQL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.POSIsyncMonitor.CodigoSQL]
Carpeta=Lista
Clave=POSIsyncMonitor.CodigoSQL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSIsyncMonitor.MensajeSQL]
Carpeta=Lista
Clave=POSIsyncMonitor.MensajeSQL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.POSIsyncMonitor.DataFallido]
Carpeta=Lista
Clave=POSIsyncMonitor.DataFallido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSIsyncMonitor.UltimaActualizacion]
Carpeta=Lista
Clave=POSIsyncMonitor.UltimaActualizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSIsyncMonitor.FechaCreacion]
Carpeta=Lista
Clave=POSIsyncMonitor.FechaCreacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=84
1=82
2=82
3=82
4=82
5=82
6=82
7=82
8=82
9=332
10=82
11=82
12=82







13=82
[Acciones.Refrescar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Refrescar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Refrescar]
Nombre=Refrescar
Boton=0
NombreDesplegar=Refrescar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
NombreEnBoton=S
BtnResaltado=S


[Acciones.Refrescar.ListaAccionesMultiples]
(Inicio)=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)







[Lista.POSIsyncMonitor.Batch]
Carpeta=Lista
Clave=POSIsyncMonitor.Batch
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=POSIsyncMonitor.Batch
POSIsyncMonitor.Batch=POSIsyncMonitor.Nodo
POSIsyncMonitor.Nodo=POSIsyncMonitor.Canal
POSIsyncMonitor.Canal=POSIsyncMonitor.Estatus
POSIsyncMonitor.Estatus=POSIsyncMonitor.ContExtraccion
POSIsyncMonitor.ContExtraccion=POSIsyncMonitor.ContEnvio
POSIsyncMonitor.ContEnvio=POSIsyncMonitor.ContCarga
POSIsyncMonitor.ContCarga=POSIsyncMonitor.EstadoSQL
POSIsyncMonitor.EstadoSQL=POSIsyncMonitor.CodigoSQL
POSIsyncMonitor.CodigoSQL=POSIsyncMonitor.MensajeSQL
POSIsyncMonitor.MensajeSQL=POSIsyncMonitor.DataFallido
POSIsyncMonitor.DataFallido=POSIsyncMonitor.UltimaActualizacion
POSIsyncMonitor.UltimaActualizacion=POSIsyncMonitor.FechaCreacion
POSIsyncMonitor.FechaCreacion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=OK
OK=ER
ER=NE
NE=SE
SE=LD
LD=(Fin)
