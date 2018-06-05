[Forma]
Clave=CentroMovimiento
Nombre=Tiempos Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Centro, Info.Descripcion)
PosicionInicialIzquierda=272
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=432

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CentroMovimiento
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=CentroMovimiento.Centro=<T>{Info.Centro}<T>

[Lista.CentroMovimiento.CentroDestino]
Carpeta=Lista
Clave=CentroMovimiento.CentroDestino
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris
Editar=S

[Lista.Centro.Descripcion]
Carpeta=Lista
Clave=Centro.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CentroMovimiento.Tiempo]
Carpeta=Lista
Clave=CentroMovimiento.Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Columnas]
CentroDestino=112
Descripcion=211
Tiempo=79

[Lista.ListaEnCaptura]
(Inicio)=CentroMovimiento.CentroDestino
CentroMovimiento.CentroDestino=Centro.Descripcion
Centro.Descripcion=CentroMovimiento.Tiempo
CentroMovimiento.Tiempo=(Fin)
