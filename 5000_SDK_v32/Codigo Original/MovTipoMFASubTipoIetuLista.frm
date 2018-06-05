
[Forma]
Clave=MovTipoMFASubTipoIetuLista
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Sub Tipos IETU
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Seleccionar
ListaCarpetas=Datos
CarpetaPrincipal=Datos
PosicionInicialIzquierda=403
PosicionInicialArriba=141
PosicionInicialAlturaCliente=408
PosicionInicialAncho=560
Comentarios=Lista(Info.ID)

[Datos]
Estilo=Hoja
Clave=Datos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFASubTipoIetu
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

Filtros=S
OtroOrden=S

ListaOrden=MovTipoMFASubTipoIetu.SubTipo<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovTipoMFASubTipoIetu.Tipo = {Info.ID}
[Datos.MovTipoMFASubTipoIetu.SubTipo]
Carpeta=Datos
Clave=MovTipoMFASubTipoIetu.SubTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Datos.MovTipoMFASubTipoIetu.Descripcion]
Carpeta=Datos
Clave=MovTipoMFASubTipoIetu.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=150
ColorFondo=Blanco

[Datos.Columnas]
SubTipo=78
Descripcion=426


[Datos.ListaEnCaptura]
(Inicio)=MovTipoMFASubTipoIetu.SubTipo
MovTipoMFASubTipoIetu.SubTipo=MovTipoMFASubTipoIetu.Descripcion
MovTipoMFASubTipoIetu.Descripcion=(Fin)


[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S







[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Excel
Excel=(Fin)
