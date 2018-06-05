

[Forma]
Clave=WebArtOpcionOrdenar
Icono=48
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Nombre=Ordenar Opciones  Artículo eCommerce
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=544
PosicionInicialArriba=264
PosicionInicialAltura=360
PosicionInicialAncho=512
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
PosicionInicialAlturaCliente=333

VentanaEstadoInicial=Normal
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtOpcion
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
ListaEnCaptura=WebArtOpcion.Nombre
ListaOrden=WebArtOpcion.Orden<TAB>(Acendente)


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=WebArtOpcion:WebArtOpcion.Orden
FiltroGeneral=WebArtOpcion.VariacionID = {Temp.Num}
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

AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>WebArtOpcion.ID<T>)<BR>EjecutarSQL(<T>spOrdenarWeb :nEstacion, :tTabla<T>, EstacionTrabajo, <T>WebArtOpcion<T>)
[Lista.Columnas]
0=49
1=434
2=210






[Lista.WebArtOpcion.Nombre]
Carpeta=Lista
Clave=WebArtOpcion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco







[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)
