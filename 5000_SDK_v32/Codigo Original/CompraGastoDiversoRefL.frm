
[Forma]
Clave=CompraGastoDiversoRefL
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Referencias
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
PosicionInicialAncho=344
Comentarios=Info.Concepto
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Referencias
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraGastoDiversoRef
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
ListaEnCaptura=CompraGastoDiversoRef.Referencia
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=CompraGastoDiversoRef.ID = {Info.ID} AND CompraGastoDiversoRef.Concepto = <T>{Info.Concepto}<T> 
[Lista.CompraGastoDiversoRef.Referencia]
Carpeta=Lista
Clave=CompraGastoDiversoRef.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Referencia=304
