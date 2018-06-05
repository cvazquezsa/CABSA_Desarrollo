[Forma]
Clave=OpcionListaInfo
Nombre=Listas de la Opción
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=231
PosicionInicialArriba=241
PosicionInicialAltura=285
PosicionInicialAncho=562
VentanaTipoMarco=Chico (Variable)
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Opcion, Info.Descripcion)
PosicionColumna1=52

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OpcionLista
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=OpcionLista.Lista
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaMantenerSeleccion=S
HojaSinBorde=S
HojaMostrarColumnas=S
HojaTitulos=S
FiltroGeneral=OpcionLista.Opcion=<T>{Info.Opcion}<T>

[Lista.OpcionLista.Lista]
Carpeta=Lista
Clave=OpcionLista.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Lista=260

[Detalles]
Estilo=Hoja
Clave=Detalles
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=OpcionListaD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=OpcionLista
LlaveLocal=(Lista)
LlaveMaestra=OpcionLista.Opcion<BR>OpcionLista.Lista
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaSinBorde=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalles.OpcionListaD.Numero]
Carpeta=Detalles
Clave=OpcionListaD.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.Columnas]
Lista=304
Numero=46
Nombre=190

[Detalles.OpcionD.Nombre]
Carpeta=Detalles
Clave=OpcionD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalles
Detalles=(Fin)

[Detalles.LlaveLocal]
(Inicio)=OpcionListaD.Opcion
OpcionListaD.Opcion=OpcionListaD.Lista
OpcionListaD.Lista=(Fin)

[Detalles.ListaEnCaptura]
(Inicio)=OpcionListaD.Numero
OpcionListaD.Numero=OpcionD.Nombre
OpcionD.Nombre=(Fin)
