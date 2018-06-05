[Forma]
Clave=ArtPreciosLista
Nombre=<T>Precios del Artículo - <T>+Info.Articulo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=470
PosicionInicialArriba=357
PosicionInicialAltura=302
PosicionInicialAncho=339
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraAcciones=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=275

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=ArtPrecios
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
OtroOrden=S
ListaOrden=ComparativoPrecios.Orden<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Lista<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Precios
IconosNombre=ArtPrecios:ComparativoPrecios.Lista
ListaEnCaptura=(Lista)
FiltroGeneral=Articulo=<T>{Info.Articulo}<T>

[Lista.Columnas]
Articulo=120
Descripcion1=184
SubCuenta=108
Precio=99
Moneda=54
Lista=159
MargenPromedio=87
PreciosNetos=69
0=124
1=114

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=0
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
EnBarraAcciones=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Aceptar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=<T>&Cancelar<T>
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Lista.ComparativoPrecios.Precio]
Carpeta=Lista
Clave=ComparativoPrecios.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ComparativoPrecios.Moneda]
Carpeta=Lista
Clave=ComparativoPrecios.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Precio, ArtPrecios:ComparativoPrecios.Precio)

[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ComparativoPrecios.Precio
ComparativoPrecios.Precio=ComparativoPrecios.Moneda
ComparativoPrecios.Moneda=(Fin)
