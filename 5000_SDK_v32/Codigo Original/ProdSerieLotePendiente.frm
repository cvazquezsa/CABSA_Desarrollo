[Forma]
Clave=ProdSerieLotePendiente
Nombre=Lotes Pendientes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=158
PosicionInicialArriba=221
PosicionInicialAltura=368
PosicionInicialAncho=710
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=341

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdSerieLotePendiente
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Lote<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Lotes Pendientes
IconosNombre=ProdSerieLotePendiente:ProdSerieLotePendiente.ProdSerieLote
FiltroGeneral=ProdSerieLotePendiente.Empresa=<T>{Empresa}<T>

[Lista.ProdSerieLotePendiente.Articulo]
Carpeta=Lista
Clave=ProdSerieLotePendiente.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdSerieLotePendiente.SubCuenta]
Carpeta=Lista
Clave=ProdSerieLotePendiente.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdSerieLotePendiente.Ruta]
Carpeta=Lista
Clave=ProdSerieLotePendiente.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdSerieLotePendiente.Centro]
Carpeta=Lista
Clave=ProdSerieLotePendiente.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdSerieLotePendiente.Unidad]
Carpeta=Lista
Clave=ProdSerieLotePendiente.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdSerieLotePendiente.CantidadPendiente]
Carpeta=Lista
Clave=ProdSerieLotePendiente.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Columnas]
0=116
1=106

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ProdSerieLotePendiente:ProdSerieLotePendiente.ProdSerieLote)
Antes=S
AntesExpresiones=Asigna(Info.Articulo, ProdSerieLotePendiente:ProdSerieLotePendiente.Articulo)<BR>Asigna(Info.SubCuenta, ProdSerieLotePendiente:ProdSerieLotePendiente.SubCuenta)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProdSerieLotePendiente.Articulo
ProdSerieLotePendiente.Articulo=ProdSerieLotePendiente.SubCuenta
ProdSerieLotePendiente.SubCuenta=ProdSerieLotePendiente.Ruta
ProdSerieLotePendiente.Ruta=ProdSerieLotePendiente.Centro
ProdSerieLotePendiente.Centro=ProdSerieLotePendiente.CantidadPendiente
ProdSerieLotePendiente.CantidadPendiente=ProdSerieLotePendiente.Unidad
ProdSerieLotePendiente.Unidad=(Fin)
