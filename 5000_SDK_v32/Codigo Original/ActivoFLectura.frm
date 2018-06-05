[Forma]
Clave=ActivoFLectura
Nombre=Lecturas del Activo Fijo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=389
PosicionInicialAncho=475
PosicionInicialIzquierda=274
PosicionInicialArriba=172
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Lista(Info.Articulo, Info.SerieLote)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFLectura
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Concepto<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Lecturas
IconosNombre=ActivoFLectura:ActivoFLectura.Concepto
FiltroGeneral=ActivoFLectura.Empresa=<T>{Empresa}<T> <BR>AND ActivoFLectura.Articulo=<T>{Info.Articulo}<T><BR>AND ActivoFLectura.Serie=<T>{Info.SerieLote}<T>

[Lista.ActivoFLectura.Lectura]
Carpeta=Lista
Clave=ActivoFLectura.Lectura
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=270
1=81

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

[Lista.ActivoFLectura.Fecha]
Carpeta=Lista
Clave=ActivoFLectura.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ActivoFLectura.Lectura
ActivoFLectura.Lectura=ActivoFLectura.Fecha
ActivoFLectura.Fecha=(Fin)
