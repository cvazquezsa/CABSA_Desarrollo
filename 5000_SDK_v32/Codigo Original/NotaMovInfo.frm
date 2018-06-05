[Forma]
Clave=NotaMovInfo
Nombre=<T>Comentarios - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=162
PosicionInicialArriba=194
PosicionInicialAltura=379
PosicionInicialAncho=700
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotaMov
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=NotaMov.Comentarios
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroGeneral=NotaMov.Rama=<T>{Info.Rama}<T> AND<BR>NotaMov.ID = {Info.ID}
AlinearTodaCarpeta=S

[Ficha.NotaMov.Comentarios]
Carpeta=Ficha
Clave=NotaMov.Comentarios
Editar=S
LineaNueva=S
3D=S
Tamano=70x15
ColorFondo=Plata
ConScroll=S

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
