[Forma]
Clave=ArtLineaLista
Nombre=L�neas de Art�culos
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=828
PosicionInicialArriba=423
PosicionInicialAltura=345
PosicionInicialAncho=263
CarpetaPrincipal=Lista
ListaAcciones=Seleccionar
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionInicialAlturaCliente=318

[ArtLinea.Columnas]
Linea=104
Descripcion=304

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtLinea
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ArtLinea.Linea
ListaOrden=ArtLinea.Linea<TAB>(Acendente)
CarpetaVisible=S
HojaAjustarColumnas=S
HojaConfirmarEliminar=S
HojaVistaOmision=Autom�tica

[Lista.ArtLinea.Linea]
Carpeta=Lista
Clave=ArtLinea.Linea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Linea=234
Descripcion=325

[Detalles.ArtLinea.Linea]
Carpeta=Detalles
Clave=ArtLinea.Linea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.ArtLinea.Icono]
Carpeta=Detalles
Clave=ArtLinea.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtLinea:ArtLinea.Linea)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
