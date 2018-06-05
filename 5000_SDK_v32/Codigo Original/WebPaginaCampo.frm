[Forma]
Clave=WebPaginaCampo
Nombre=Personalizar Campos  
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=549
PosicionInicialAncho=896
PosicionInicialIzquierda=555
PosicionInicialArriba=307
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Pagina

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaCampo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=WebPaginaCampo.Campo<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroGeneral=WebPaginaCampo.Pagina=<T>{Info.Pagina}<T>

[Lista.WebPaginaCampo.Campo]
Carpeta=Lista
Clave=WebPaginaCampo.Campo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaCampo.Etiqueta]
Carpeta=Lista
Clave=WebPaginaCampo.Etiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaCampo.Tipo]
Carpeta=Lista
Clave=WebPaginaCampo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaCampo.Formato]
Carpeta=Lista
Clave=WebPaginaCampo.Formato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Campo=294
Etiqueta=264
Tipo=108
Formato=189

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

[Lista.ListaEnCaptura]
(Inicio)=WebPaginaCampo.Campo
WebPaginaCampo.Campo=WebPaginaCampo.Etiqueta
WebPaginaCampo.Etiqueta=WebPaginaCampo.Tipo
WebPaginaCampo.Tipo=WebPaginaCampo.Formato
WebPaginaCampo.Formato=(Fin)
