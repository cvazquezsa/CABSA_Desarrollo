
[Forma]
Clave=MovPosArbol
Icono=0
Modulos=(Todos)
Nombre=Posición del Movimiento

ListaCarpetas=(Lista)
CarpetaPrincipal=Destino
PosicionInicialAlturaCliente=460
PosicionInicialAncho=682
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=277
PosicionInicialArriba=162
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Modulo.Nombre(Info.Modulo),Info.Mov&<T> <T>&Info.MovID)

PosicionSec1=187
[Lista.Columnas]
0=164
1=129
2=124
3=-2





























4=-2



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























































[Lista.ListaEnCaptura]
(Inicio)=MovPos.DModulo
MovPos.DModulo=MovPos.DEstatus
MovPos.DEstatus=(Fin)

[Destino]
Estilo=Iconos
Clave=Destino
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
Zona=B1
Vista=MovPosD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovPos.DEstatus
FiltroPredefinido=S
FiltroArbolClave=MovPos.Clave
FiltroArbolValidar=MovPos.Movimiento
FiltroArbolRama=MovPos.Rama
FiltroArbolAcumulativas=MovPos.EsAcumulativa
TablaIndependiente=MovPos
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
CarpetaVisible=S

FiltroEnOrden=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Destino
MenuLocal=S
ListaAcciones=ExaminarD
IconosNombre=MovPosD:MovPos.Movimiento
FiltroGeneral=MovPos.Estacion = {EstacionTrabajo} AND MovPos.Modulo = {Comillas(Info.Modulo)} AND MovPos.Tipo = <T>DESTINO<T>
[Destino.MovPos.DEstatus]
Carpeta=Destino
Clave=MovPos.DEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Origen]
Estilo=Iconos
Clave=Origen
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=MovPosO
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovPos.DEstatus
FiltroPredefinido=S
FiltroArbolClave=MovPos.Clave
FiltroArbolValidar=MovPos.Movimiento
FiltroArbolRama=MovPos.Rama
FiltroArbolAcumulativas=MovPos.EsAcumulativa
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
CarpetaVisible=S

Pestana=S
PestanaOtroNombre=S
PestanaNombre=Origen
MenuLocal=S
ListaAcciones=ExaminarO
IconosNombre=MovPosO:MovPos.Movimiento
FiltroGeneral=MovPos.Estacion = {EstacionTrabajo} AND MovPos.Modulo = {Comillas(Info.Modulo)} AND MovPos.Tipo = <T>ORIGEN<T>
[Origen.MovPos.DEstatus]
Carpeta=Origen
Clave=MovPos.DEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122








[Acciones.Examinar]
Nombre=Examinar
Boton=68
NombreDesplegar=<T>Examinar<T>&<T> <T>&Info.Mov&<T> <T>&Info.MovID
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S















































Expresion=Asigna(Info.Anuncio, SQL(<T>EXEC spPosicionMovimiento :tModulo, :nID<T>, Info.Modulo, Info.ID))<BR>ReportePantallaModal(Info.Anuncio, Info.ID)
ActivoCondicion=ConDatos(Info.ID) y Usuario.PreliminarMovs
[Acciones.ExaminarO]
Nombre=ExaminarO
Boton=0
NombreDesplegar=&Examinar...
EnMenu=S
TipoAccion=Expresion
Visible=S

Expresion=Asigna(Info.Anuncio, SQL(<T>EXEC spPosicionMovimiento :tModulo, :nID<T>, MovPosO:MovPos.DModulo, MovPosO:MovPos.DID))<BR>ReportePantallaModal(Info.Anuncio, MovPosO:MovPos.DID)
ActivoCondicion=ConDatos(MovPosO:MovPos.DID) y Usuario.PreliminarMovs
[Acciones.ExaminarD]
Nombre=ExaminarD
Boton=0
NombreDesplegar=&Examinar...
EnMenu=S
TipoAccion=Expresion
Visible=S





























Expresion=Asigna(Info.Anuncio, SQL(<T>EXEC spPosicionMovimiento :tModulo, :nID<T>, MovPosD:MovPos.DModulo, MovPosD:MovPos.DID))<BR>ReportePantallaModal(Info.Anuncio, MovPosD:MovPos.DID)
ActivoCondicion=ConDatos(MovPosD:MovPos.DID) y Usuario.PreliminarMovs
[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=<T>Propiedades<T>&<T> <T>&Info.Mov&<T> <T>&Info.MovID
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S







ConCondicion=S










EjecucionCondicion=ConDatos(Info.ID)








[Forma.ListaCarpetas]
(Inicio)=Origen
Origen=Destino
Destino=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Examinar
Examinar=Propiedades
Propiedades=(Fin)
