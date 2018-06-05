[Forma]
Clave=InvPendientes
Nombre=<T>Pendientes<T>
Icono=0
Modulos=INV
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=508
PosicionInicialArriba=221
PosicionInicialAltura=351
PosicionInicialAncho=264
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
Comentarios=<T>Almacén: <T>+Info.Almacen
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=324

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=InvPendientes
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=Movimiento
ListaEnCaptura=Inv.MovID
PestanaNombre=Movimientos
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30

IconosNombre=InvPendientes:Inv.Mov
FiltroGeneral={Si(Info.MovTipo=INV.R, <T>mt.Clave = <T>+Comillas(INV.P)+<T> AND AlmacenDestino = <T>+Comillas(Info.Almacen), <T>mt.Clave <> <T>+Comillas(INV.P))}

[Lista.Columnas]
0=108
1=84

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
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(InvPendientes:Mov) y ConDatos(InvPendientes:MovID)
AntesExpresiones=Asigna(Info.MovID, InvPendientes:MovID)

[Lista.Inv.MovID]
Carpeta=Lista
Clave=Inv.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
