[Forma]
Clave=InvCapa
Nombre=Capas de Costos del Artículo
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=351
PosicionInicialArriba=348
PosicionInicialAltura=321
PosicionInicialAncho=577
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
Comentarios=Lista(Info.Articulo, Info.Moneda, Caso Info.Clave Es <T>G<T> Entonces <T>General<T> Es <T>U<T> Entonces <T>UEPS<T> Es <T>P<T> Entonces <T>PEPS<T> Fin)
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=294

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvCapa
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
OtroOrden=S
ListaOrden=InvCapa.Fecha<TAB>(Decendente)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=Movimiento
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Capa(s)
IconosNombre=InvCapa:InvCapa.Mov+<T> <T>+InvCapa:InvCapa.MovID
FiltroGeneral=InvCapa.Sistema=<T>{Info.Clave}<T> AND InvCapa.Empresa={Comillas(Empresa)} AND InvCapa.Articulo={Comillas(Info.Articulo)} AND InvCapa.Activa=1 AND InvCapa.SubCuenta=<T><T>

[Lista.InvCapa.Fecha]
Carpeta=Lista
Clave=InvCapa.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvCapa.Costo]
Carpeta=Lista
Clave=InvCapa.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=0
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=59
Mov=88
MovID=67
Fecha=73
Cantidad=72
Costo=108
Importe=107
0=175
1=76

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=Si
NombreDesplegar=&Cerrar
EnBarraHerramientas=Si
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=Si
Visible=Si

[Lista.CostoTotal]
Carpeta=Lista
Clave=CostoTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvCapa.Existencia]
Carpeta=Lista
Clave=InvCapa.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=InvCapa.Fecha
InvCapa.Fecha=InvCapa.Existencia
InvCapa.Existencia=InvCapa.Costo
InvCapa.Costo=CostoTotal
CostoTotal=(Fin)
