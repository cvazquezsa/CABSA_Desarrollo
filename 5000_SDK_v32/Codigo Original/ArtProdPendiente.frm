[Forma]
Clave=ArtProdPendiente
Nombre=<T>Produccion por Recibir del Artículo<T>+Si(ConDatos(Info.Almacen), <T> en el Almacén<T>)
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=131
PosicionInicialArriba=195
PosicionInicialAltura=378
PosicionInicialAncho=761
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Almacen, Si(Ver.Semana<>Nulo, e(<T>Semana<T>)+<T>: <T>+Ver.Semana))
VentanaEscCerrar=S
EsConsultaExclusiva=S

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
Vista=ProdPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
FiltroAutoCampo=CompraPendienteD.Proveedor
FiltroAutoValidar=CompraPendienteD.Proveedor
FiltroGrupo1=Proveedor
FiltroValida1=Nombre
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
FiltroPredefinido1=
FiltroPredefinido2=
FiltroTodo=S
FiltroTodoFinal=S
FiltroPredefinido3=
IconosNombre=ProdPendienteD:ProdPendienteD.Mov+<T> <T>+ProdPendienteD:ProdPendienteD.MovID
FiltroGeneral=ProdPendienteD.Empresa=<T>{Empresa}<T> AND <BR>ProdPendienteD.Articulo=<T>{Info.Articulo}<T><BR>{Si(Ver.Semana<>Nulo, <T> AND ProdPendienteD.Semana=<T>+Ver.Semana, <T><T>)}

[Lista.CantidadReservada]
Carpeta=Lista
Clave=CantidadReservada
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
0=136
1=80
Mov=103
MovID=65
FechaEmision=75
FechaRequerida=87
Articulo=99
Almacen=68
CantidadPendiente=56

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

[Lista.]
Carpeta=Lista
ColorFondo=Negro

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
NombreDesplegar=Presentación preliminar
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

[Lista.ProdPendienteD.Referencia]
Carpeta=Lista
Clave=ProdPendienteD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.FechaEmision]
Carpeta=Lista
Clave=ProdPendienteD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.FechaRequerida]
Carpeta=Lista
Clave=ProdPendienteD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.FechaEntrega]
Carpeta=Lista
Clave=ProdPendienteD.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.Ruta]
Carpeta=Lista
Clave=ProdPendienteD.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.Almacen]
Carpeta=Lista
Clave=ProdPendienteD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.CantidadPendiente]
Carpeta=Lista
Clave=ProdPendienteD.CantidadPendiente
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.Centro]
Carpeta=Lista
Clave=ProdPendienteD.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=ProdPendienteD.Referencia
ProdPendienteD.Referencia=ProdPendienteD.FechaEmision
ProdPendienteD.FechaEmision=ProdPendienteD.FechaRequerida
ProdPendienteD.FechaRequerida=ProdPendienteD.FechaEntrega
ProdPendienteD.FechaEntrega=ProdPendienteD.Ruta
ProdPendienteD.Ruta=ProdPendienteD.Centro
ProdPendienteD.Centro=ProdPendienteD.Almacen
ProdPendienteD.Almacen=ProdPendienteD.CantidadPendiente
ProdPendienteD.CantidadPendiente=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)
