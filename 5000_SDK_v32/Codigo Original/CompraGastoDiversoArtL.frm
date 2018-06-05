
[Forma]
Clave=CompraGastoDiversoArtL
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Artículos
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=Cerrar
PosicionInicialIzquierda=433
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=256
Comentarios=Info.Concepto
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Artículos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraGastoDiversoArt
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
ListaEnCaptura=CompraGastoDiversoArt.Articulo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=CompraGastoDiversoArt.ID = {Info.ID} AND CompraGastoDiversoArt.Concepto = <T>{Info.Concepto}<T>
[Lista.CompraGastoDiversoArt.Articulo]
Carpeta=Lista
Clave=CompraGastoDiversoArt.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Articulo=217
