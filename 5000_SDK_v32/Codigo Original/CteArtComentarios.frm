[Forma]
Clave=CteArtComentarios
Nombre=Comentarios
Icono=17
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=390
PosicionInicialAncho=584
PosicionInicialIzquierda=348
PosicionInicialArriba=300
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Cliente, Info.Articulo, Info.SubCuenta)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCteComentarios
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
ListaEnCaptura=ArtCte.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ArtCte.Articulo=<T>{Info.Articulo}<T> AND ArtCte.SubCuenta=<T>{Info.SubCuenta}<T> AND ArtCte.Cliente=<T>{Info.Cliente}<T>

[Ficha.ArtCte.Comentarios]
Carpeta=Ficha
Clave=ArtCte.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x4
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
