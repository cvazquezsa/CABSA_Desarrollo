
[Forma]
Clave=WebPaginaParamRepeticion
Icono=0
Modulos=(Todos)
Nombre=Grupo de Repeticion

ListaCarpetas=WebPaginaParamRepeticion
CarpetaPrincipal=WebPaginaParamRepeticion
PosicionInicialAlturaCliente=291
PosicionInicialAncho=711
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=291
PosicionInicialArriba=237
[WebPaginaParamRepeticion]
Estilo=Hoja
Clave=WebPaginaParamRepeticion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaParamRepeticion
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=WebPaginaParamRepeticion.Pagina=<T>{Info.Pagina}<T>
[WebPaginaParamRepeticion.WebPaginaParamRepeticion.Nombre]
Carpeta=WebPaginaParamRepeticion
Clave=WebPaginaParamRepeticion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaParamRepeticion.WebPaginaParamRepeticion.Repeticiones]
Carpeta=WebPaginaParamRepeticion
Clave=WebPaginaParamRepeticion.Repeticiones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaParamRepeticion.WebPaginaParamRepeticion.PermiteAgregar]
Carpeta=WebPaginaParamRepeticion
Clave=WebPaginaParamRepeticion.PermiteAgregar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaParamRepeticion.WebPaginaParamRepeticion.SP]
Carpeta=WebPaginaParamRepeticion
Clave=WebPaginaParamRepeticion.SP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro


[WebPaginaParamRepeticion.Columnas]
Nombre=202
Repeticiones=79
PermiteAgregar=93
SP=304

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S



[WebPaginaParamRepeticion.ListaEnCaptura]
(Inicio)=WebPaginaParamRepeticion.Nombre
WebPaginaParamRepeticion.Nombre=WebPaginaParamRepeticion.Repeticiones
WebPaginaParamRepeticion.Repeticiones=WebPaginaParamRepeticion.PermiteAgregar
WebPaginaParamRepeticion.PermiteAgregar=WebPaginaParamRepeticion.SP
WebPaginaParamRepeticion.SP=(Fin)
