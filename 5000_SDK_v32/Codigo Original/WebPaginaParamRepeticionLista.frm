
[Forma]
Clave=WebPaginaParamRepeticionLista
Icono=0
Modulos=(Todos)
Nombre=Grupo de Repeticion

ListaCarpetas=WebPaginaParamRepeticionLista
CarpetaPrincipal=WebPaginaParamRepeticionLista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=273
PosicionInicialAncho=478
VentanaSiempreAlFrente=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=401
PosicionInicialArriba=246
VentanaBloquearAjuste=S
VentanaSinIconosMarco=S
[WebPaginaParamRepeticionLista]
Estilo=Hoja
Clave=WebPaginaParamRepeticionLista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaParamRepeticion
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
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=WebPaginaParamRepeticion.Pagina=<T>{Info.Pagina}<T>
FiltroRespetar=S
FiltroTipo=General
[WebPaginaParamRepeticionLista.WebPaginaParamRepeticion.Nombre]
Carpeta=WebPaginaParamRepeticionLista
Clave=WebPaginaParamRepeticion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaParamRepeticionLista.WebPaginaParamRepeticion.Repeticiones]
Carpeta=WebPaginaParamRepeticionLista
Clave=WebPaginaParamRepeticion.Repeticiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaParamRepeticionLista.WebPaginaParamRepeticion.PermiteAgregar]
Carpeta=WebPaginaParamRepeticionLista
Clave=WebPaginaParamRepeticion.PermiteAgregar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[WebPaginaParamRepeticionLista.Columnas]
Nombre=276
Repeticiones=76
PermiteAgregar=95

[WebPaginaParamRepeticionLista.ListaEnCaptura]
(Inicio)=WebPaginaParamRepeticion.Nombre
WebPaginaParamRepeticion.Nombre=WebPaginaParamRepeticion.Repeticiones
WebPaginaParamRepeticion.Repeticiones=WebPaginaParamRepeticion.PermiteAgregar
WebPaginaParamRepeticion.PermiteAgregar=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S







EspacioPrevio=S
















[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cerrar
Cerrar=(Fin)
