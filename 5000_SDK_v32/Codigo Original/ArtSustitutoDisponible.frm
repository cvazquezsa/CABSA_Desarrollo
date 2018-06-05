[Forma]
Clave=ArtSustitutoDisponible
Nombre=Sustitutos Disponibles
Icono=0
Modulos=(Todos)
MovModulo=Sustituto Disponible
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=182
PosicionInicialArriba=169
PosicionInicialAltura=310
PosicionInicialAncho=659
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion)
PosicionInicialAlturaCliente=395

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtSustitutoDisponible
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Sustituto<T>
ListaEnCaptura=(Lista)
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=ArtSustituto.Orden<TAB>(Acendente)
IconosNombre=ArtSustitutoDisponible:ArtSustituto.Sustituto
FiltroGeneral=ArtSustituto.Articulo=<T>{Info.Articulo}<T> AND ArtDisponible.Almacen=<T>{Info.Almacen}<T>

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtDisponible.Disponible]
Carpeta=Lista
Clave=ArtDisponible.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=129
1=233

[Lista.ArtSustituto.Comentarios]
Carpeta=Lista
Clave=ArtSustituto.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Sustituto, ArtSustitutoDisponible:ArtSustituto.Sustituto)

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
Visible=S
ClaveAccion=ArtInfoCopia
Antes=S
AntesExpresiones=Asigna(Info.ArticuloCopia, ArtSustitutoDisponible:ArtSustituto.Sustituto)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Informacion
Informacion=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ArtDisponible.Disponible
ArtDisponible.Disponible=ArtSustituto.Comentarios
ArtSustituto.Comentarios=(Fin)
