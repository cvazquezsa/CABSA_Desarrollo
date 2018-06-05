[Forma]
Clave=WebSitioD
Nombre=Contenido del Sitio
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=469
PosicionInicialArriba=246
PosicionInicialAlturaCliente=672
PosicionInicialAncho=981
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Sitio, Info.Nombre)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSitioD
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
OtroOrden=S
ListaOrden=WebSitioD.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
CondicionEdicion=Info.PuedeEditar
FiltroGeneral=WebSitioD.Sitio=<T>{Info.Sitio}<T>

[Lista.Columnas]
Tema=110
Asunto=577
Categoria=115
Grupo=111
Familia=101
Referencia=131
Pagina=122
Nombre=530
EsGrupo=64
Posicion=93
MenuPosicion=93

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(WebSitioD:WebSitioD.Referencia)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Lista.WebSitioD.Referencia]
Carpeta=Lista
Clave=WebSitioD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebSitioD.Pagina]
Carpeta=Lista
Clave=WebSitioD.Pagina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebSitioD.Nombre]
Carpeta=Lista
Clave=WebSitioD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebSitioD.EsGrupo]
Carpeta=Lista
Clave=WebSitioD.EsGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebSitioD.MenuPosicion]
Carpeta=Lista
Clave=WebSitioD.MenuPosicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=WebSitioD.Referencia
WebSitioD.Referencia=WebSitioD.EsGrupo
WebSitioD.EsGrupo=WebSitioD.Pagina
WebSitioD.Pagina=WebSitioD.Nombre
WebSitioD.Nombre=WebSitioD.MenuPosicion
WebSitioD.MenuPosicion=(Fin)
