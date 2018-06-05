[Forma]
Clave=WebPaginaDoc
Nombre=Documentos de la Página
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=656
PosicionInicialArriba=344
PosicionInicialAlturaCliente=476
PosicionInicialAncho=608
Comentarios=Info.Pagina
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaDoc
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=WebPaginaDoc.Orden<TAB>(Acendente)
FiltroGeneral=WebPaginaDoc.Pagina=<T>{Info.Pagina}<T>

[Lista.WebSitioDoc.Nombre]
Carpeta=Lista
Clave=WebSitioDoc.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.WebPaginaDoc.Orden]
Carpeta=Lista
Clave=WebPaginaDoc.Orden
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
ID=49
Nombre=442
Orden=38
Documento=89

[Lista.WebPaginaDoc.Documento]
Carpeta=Lista
Clave=WebPaginaDoc.Documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=WebPaginaDoc.Documento
WebPaginaDoc.Documento=WebSitioDoc.Nombre
WebSitioDoc.Nombre=WebPaginaDoc.Orden
WebPaginaDoc.Orden=(Fin)
