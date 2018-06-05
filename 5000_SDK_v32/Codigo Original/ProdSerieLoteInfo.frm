[Forma]
Clave=ProdSerieLoteInfo
Nombre=Información de Serie/Lote Producción
Icono=6
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=OP
PosicionInicialAltura=340
PosicionInicialAncho=744
PosicionInicialIzquierda=140
PosicionInicialArriba=210
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=42
PosicionSeccion1=64
PosicionSeccion2=66
Comentarios=Info.SerieLote
PosicionInicialAlturaCliente=313

[Ficha.ProdSerieLote.CantidadOrdenada]
Carpeta=Ficha
Clave=ProdSerieLote.CantidadOrdenada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.ProdSerieLote.CantidadEntrada]
Carpeta=Ficha
Clave=ProdSerieLote.CantidadEntrada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[Ficha.ProdSerieLote.CantidadMerma]
Carpeta=Ficha
Clave=ProdSerieLote.CantidadMerma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.ProdSerieLote.CantidadDesperdicio]
Carpeta=Ficha
Clave=ProdSerieLote.CantidadDesperdicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

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

[Costos]
Estilo=Iconos
Clave=Costos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=ProdSerieLoteCostoAcum
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
PestanaOtroNombre=S
FiltroAplicaEn=ProdSerieLoteCostoAcum.Articulo
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroGrupo1=ProdSerieLoteCostoAcum.Articulo
FiltroValida1=ProdSerieLoteCostoAcum.Articulo
Pestana=S
PestanaNombre=Costos
IconosConSenales=S
FiltroTodo=S
FiltroGrupo2=ProdSerieLoteCostoAcum.SubCuenta
FiltroValida2=ProdSerieLoteCostoAcum.SubCuenta
MenuLocal=S
ListaAcciones=Desglosar
IconosNombre=ProdSerieLoteCostoAcum:ProdSerieLoteCostoAcum.Articulo
FiltroGeneral=ProdSerieLoteCostoAcum.ProdSerieLote=<T>{Info.SerieLote}<T>

[Costos.Columnas]
0=110
1=80

[OP]
Estilo=Iconos
Clave=OP
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdSerieLotePendiente
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
MenuLocal=S
ListaAcciones=InterpretarOpc
PestanaNombre=Orden
Pestana=S
IconosNombre=ProdSerieLotePendiente:ProdSerieLotePendiente.Mov+<T> <T>+ProdSerieLotePendiente:ProdSerieLotePendiente.MovID
FiltroGeneral=ProdSerieLotePendiente.Empresa=<T>{Empresa}<T> AND <BR>ProdSerieLotePendiente.ProdSerieLote=<T>{Info.SerieLote}<T>

[OP.ProdSerieLotePendiente.Ruta]
Carpeta=OP
Clave=ProdSerieLotePendiente.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OP.ProdSerieLotePendiente.Centro]
Carpeta=OP
Clave=ProdSerieLotePendiente.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[OP.ProdSerieLotePendiente.Articulo]
Carpeta=OP
Clave=ProdSerieLotePendiente.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OP.ProdSerieLotePendiente.SubCuenta]
Carpeta=OP
Clave=ProdSerieLotePendiente.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OP.ProdSerieLotePendiente.CantidadPendiente]
Carpeta=OP
Clave=ProdSerieLotePendiente.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[OP.ProdSerieLotePendiente.Unidad]
Carpeta=OP
Clave=ProdSerieLotePendiente.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OP.Columnas]
0=109
1=85

[CostoAcum.ProdSerieLoteCostoAcum.Saldo]
Carpeta=CostoAcum
Clave=ProdSerieLoteCostoAcum.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[CostoAcum.ProdSerieLoteCostoAcum.CostoUnitario]
Carpeta=CostoAcum
Clave=ProdSerieLoteCostoAcum.CostoUnitario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[CostoAcum.Columnas]
0=51
1=39

[Costos.ProdSerieLoteCostoAcum.Saldo]
Carpeta=Costos
Clave=ProdSerieLoteCostoAcum.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Costos.ProdSerieLoteCostoAcum.CostoUnitario]
Carpeta=Costos
Clave=ProdSerieLoteCostoAcum.CostoUnitario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[DesgloseCostos.Columnas]
0=112
1=90

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ProdSerieLoteCosto:Mov.ID)
AntesExpresiones=Asigna(Info.Modulo, ProdSerieLoteCosto:Mov.Modulo)<BR>Asigna(Info.ID, ProdSerieLoteCosto:Mov.ID)

[Ficha.CantidadPendiente]
Carpeta=Ficha
Clave=CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Acciones.InterpretarOpc]
Nombre=InterpretarOpc
Boton=0
NombreDesplegar=Interpretar Opciones
EnMenu=S
TipoAccion=Expresion
Expresion=VerOpcionesArticulo( ProdSerieLotePendiente:ProdSerieLotePendiente.Articulo, ProdSerieLotePendiente:ProdSerieLotePendiente.SubCuenta )
Activo=S
Visible=S

[OP.OpcionDesc]
Carpeta=OP
Clave=OpcionDesc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProdSerieLote.SubCuenta]
Carpeta=Ficha
Clave=ProdSerieLote.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Columnas]
0=112
1=153

[Costos.ProdSerieLoteCostoAcum.SubCuenta]
Carpeta=Costos
Clave=ProdSerieLoteCostoAcum.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Costos.ProdSerieLoteCostoAcum.Moneda]
Carpeta=Costos
Clave=ProdSerieLoteCostoAcum.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[DesgloseCostos.ProdSerieLoteCosto.Articulo]
Carpeta=DesgloseCostos
Clave=ProdSerieLoteCosto.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DesgloseCostos.ProdSerieLoteCosto.SubCuenta]
Carpeta=DesgloseCostos
Clave=ProdSerieLoteCosto.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DesgloseCostos.ProdSerieLoteCosto.Cargo]
Carpeta=DesgloseCostos
Clave=ProdSerieLoteCosto.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[DesgloseCostos.ProdSerieLoteCosto.Abono]
Carpeta=DesgloseCostos
Clave=ProdSerieLoteCosto.Abono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[DesgloseCostos.ProdSerieLoteCosto.Concepto]
Carpeta=DesgloseCostos
Clave=ProdSerieLoteCosto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[DesgloseCostos.ProdSerieLoteCosto.Moneda]
Carpeta=DesgloseCostos
Clave=ProdSerieLoteCosto.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.Descripcion1]
Carpeta=Ficha
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.OpcionDesc]
Carpeta=Ficha
Clave=OpcionDesc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Desglosar]
Nombre=Desglosar
Boton=0
NombreDesplegar=&Desglosar
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProdSerieLoteCostoInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
EjecucionCondicion=ConDatos(ProdSerieLoteCostoAcum:ProdSerieLoteCostoAcum.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ProdSerieLoteCostoAcum:ProdSerieLoteCostoAcum.Articulo)<BR>Asigna(Info.SubCuenta, ProdSerieLoteCostoAcum:ProdSerieLoteCostoAcum.SubCuenta)

[Acciones.Posicion]
Nombre=Posicion
Boton=95
NombreEnBoton=S
NombreDesplegar=&Posición del Lote
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProdSerieLotePos
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=OP
OP=Costos
Costos=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Posicion
Posicion=(Fin)

[Costos.ListaEnCaptura]
(Inicio)=ProdSerieLoteCostoAcum.SubCuenta
ProdSerieLoteCostoAcum.SubCuenta=ProdSerieLoteCostoAcum.Saldo
ProdSerieLoteCostoAcum.Saldo=ProdSerieLoteCostoAcum.CostoUnitario
ProdSerieLoteCostoAcum.CostoUnitario=ProdSerieLoteCostoAcum.Moneda
ProdSerieLoteCostoAcum.Moneda=(Fin)

[OP.ListaEnCaptura]
(Inicio)=ProdSerieLotePendiente.Articulo
ProdSerieLotePendiente.Articulo=ProdSerieLotePendiente.SubCuenta
ProdSerieLotePendiente.SubCuenta=ProdSerieLotePendiente.Ruta
ProdSerieLotePendiente.Ruta=ProdSerieLotePendiente.Centro
ProdSerieLotePendiente.Centro=ProdSerieLotePendiente.CantidadPendiente
ProdSerieLotePendiente.CantidadPendiente=ProdSerieLotePendiente.Unidad
ProdSerieLotePendiente.Unidad=OpcionDesc
OpcionDesc=(Fin)
