[Forma]
Clave=WebPaginaParamLista
Nombre=<T>Lista<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Pagina, Info.Parametro)
PosicionInicialAlturaCliente=619
PosicionInicialAncho=755
PosicionInicialIzquierda=582
PosicionInicialArriba=272
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaParamLista
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
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=WebPaginaParamLista.Pagina=<T>{Info.Pagina}<T> AND<BR>WebPaginaParamLista.Parametro=<T>{Info.Parametro}<T>

[Lista.WebPaginaParamLista.Valor]
Carpeta=Lista
Clave=WebPaginaParamLista.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaParamLista.Nombre]
Carpeta=Lista
Clave=WebPaginaParamLista.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaParamLista.Orden]
Carpeta=Lista
Clave=WebPaginaParamLista.Orden
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
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Valor=351
Nombre=327
Orden=38

[Lista.ListaEnCaptura]
(Inicio)=WebPaginaParamLista.Valor
WebPaginaParamLista.Valor=WebPaginaParamLista.Nombre
WebPaginaParamLista.Nombre=WebPaginaParamLista.Orden
WebPaginaParamLista.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=WebPaginaParamLista.Orden<TAB>(Acendente)
WebPaginaParamLista.Orden<TAB>(Acendente)=WebPaginaParamLista.Nombre<TAB>(Acendente)
WebPaginaParamLista.Nombre<TAB>(Acendente)=WebPaginaParamLista.Valor<TAB>(Acendente)
WebPaginaParamLista.Valor<TAB>(Acendente)=(Fin)
