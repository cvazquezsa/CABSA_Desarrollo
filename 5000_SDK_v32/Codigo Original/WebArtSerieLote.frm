
[Forma]
Clave=WebArtSerieLote
Nombre=Series Lotes
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=636
PosicionInicialArriba=236
PosicionInicialAltura=417
PosicionInicialAncho=328
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Recorta(Info.SubCuenta))
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=390

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLote
Fuente={Fixedsys, 9, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SerieLote.SerieLote
CarpetaVisible=S
ConFuenteEspecial=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
HojaAjustarColumnas=S
ListaOrden=SerieLote.Existencia<TAB>(Decendente)<BR>SerieLote.SerieLote<TAB>(Acendente)
MenuLocal=S
ListaAcciones=SeleccionarTodoLocal
HojaMantenerSeleccion=S

FiltroGeneral=SerieLote.Empresa=<T>{Empresa}<T> AND<BR>SerieLote.Articulo=<T>{Info.ArticuloD}<T> AND<BR>SerieLote.SubCuenta=<T>{Info.SubClase}<T>
[Lista.Columnas]
SerieLote=288
Propiedades=124
Existencia=75
EnExistencia=69
0=164
SubCuenta=108
ExistenciaAlterna=68
ExistenciaActivoFijo=69
Fecha1=97

[Lista.SerieLote.SerieLote]
Carpeta=Lista
Clave=SerieLote.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Antes=S
AntesExpresiones=Asigna( Info.SerieLote, SerieLote:SerieLote.SerieLote )
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S



[Acciones.SeleccionarTodoLocal]
Nombre=SeleccionarTodoLocal
Boton=0
NombreDesplegar=&Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S




[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=SerieLoteInfo
SerieLoteInfo=(Fin)
