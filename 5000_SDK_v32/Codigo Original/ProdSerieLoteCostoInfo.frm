[Forma]
Clave=ProdSerieLoteCostoInfo
Nombre=Desglose de Costos
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=204
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=616
Comentarios=Lista(Info.SerieLote, Info.Articulo, Info.SubCuenta)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdSerieLoteCosto
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=ProdSerieLoteCosto:Mov.Mov+<T> <T>+ProdSerieLoteCosto:Mov.MovID
FiltroGeneral=ProdSerieLoteCosto.Empresa=<T>{Empresa}<T> AND<BR>ProdSerieLoteCosto.ProdSerieLote=<T>{Info.SerieLote}<T> AND<BR>ProdSerieLoteCosto.Articulo=<T>{Info.Articulo}<T> AND<BR>ISNULL(ProdSerieLoteCosto.SubCuenta, <T><T>)=<T>{Info.SubCuenta}<T>

[Lista.ProdSerieLoteCosto.Cargo]
Carpeta=Lista
Clave=ProdSerieLoteCosto.Cargo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdSerieLoteCosto.Abono]
Carpeta=Lista
Clave=ProdSerieLoteCosto.Abono
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdSerieLoteCosto.Concepto]
Carpeta=Lista
Clave=ProdSerieLoteCosto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdSerieLoteCosto.Moneda]
Carpeta=Lista
Clave=ProdSerieLoteCosto.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
0=143
1=134

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentacion preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ProdSerieLoteCosto:Mov.Modulo)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, ProdSerieLoteCosto:Mov.Modulo)<BR>Asigna(Info.ID, ProdSerieLoteCosto:Mov.ID)
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Propiedades
Propiedades=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProdSerieLoteCosto.Cargo
ProdSerieLoteCosto.Cargo=ProdSerieLoteCosto.Abono
ProdSerieLoteCosto.Abono=ProdSerieLoteCosto.Concepto
ProdSerieLoteCosto.Concepto=ProdSerieLoteCosto.Moneda
ProdSerieLoteCosto.Moneda=(Fin)
