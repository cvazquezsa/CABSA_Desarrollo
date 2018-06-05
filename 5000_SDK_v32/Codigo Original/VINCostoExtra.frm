[Forma]
Clave=VINCostoExtra
Nombre=Costos Extras del VIN
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=262
PosicionInicialArriba=201
PosicionInicialAlturaCliente=331
PosicionInicialAncho=500
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Info.SerieLote

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VINCostoExtra
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=VINCostoExtra.CostoExtra
PestanaOtroNombre=S
Filtros=S
IconosNombre=VINCostoExtra:Mov.Mov+<T> <T>+VINCostoExtra:Mov.MovID
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=VINCostoExtra.VIN=<T>{Info.SerieLote}<T> AND<BR>VINCostoExtra.Empresa=<T>{Empresa}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.VINCostoExtra.CostoExtra]
Carpeta=Lista
Clave=VINCostoExtra.CostoExtra
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=212
1=117

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
