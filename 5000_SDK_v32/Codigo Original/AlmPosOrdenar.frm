[Forma]
Clave=AlmPosOrdenar
Icono=48
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Nombre=Ordenar Posiciones
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=529
PosicionInicialArriba=226
PosicionInicialAltura=360
PosicionInicialAncho=541
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
PosicionInicialAlturaCliente=409

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AlmPos
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Registros
OtroOrden=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
IconosSubTitulo=<T>Orden<T>
IconosCambiarOrden=S
ListaEnCaptura=(Lista)
ListaOrden=(Lista)


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=AlmPos:AlmPos.Orden
FiltroGeneral=AlmPos.Almacen=<T>{Info.Almacen}<T>
[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=3
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Antes=S
Visible=S
NombreDesplegar=&Guardar Nuevo Orden
NombreEnBoton=S

AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>AlmPos.Posicion<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla, :tModulo, :nID, :tCuenta, :tLlave<T>, EstacionTrabajo, <T>AlmPos<T>, <T><T>, 0, <T><T>, Info.Almacen)
[Lista.Columnas]
0=49
1=64







2=74
3=324
[Lista.AlmPos.Almacen]
Carpeta=Lista
Clave=AlmPos.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.AlmPos.Descripcion]
Carpeta=Lista
Clave=AlmPos.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco





[Lista.AlmPos.Posicion]
Carpeta=Lista
Clave=AlmPos.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco








































































[Lista.ListaEnCaptura]
(Inicio)=AlmPos.Almacen
AlmPos.Almacen=AlmPos.Posicion
AlmPos.Posicion=AlmPos.Descripcion
AlmPos.Descripcion=(Fin)

[Lista.ListaOrden]
(Inicio)=AlmPos.Orden	(Acendente)
AlmPos.Orden	(Acendente)=AlmPos.Almacen	(Acendente)
AlmPos.Almacen	(Acendente)=(Fin)

















































[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)
