[Forma]
Clave=CompraPendienteDLista
Nombre=Si(Info.Proveedor=Nulo,<T>Requisiciones Pendientes<T>,<T>Compras Pendientes del Proveedor<T>)
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=246
PosicionInicialArriba=128
PosicionInicialAltura=309
PosicionInicialAncho=874
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Si(ConDatos(Info.Proveedor),Info.Proveedor,<T><T>), Info.Moneda)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=433

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
ListaEnCaptura=(Lista)
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
OtroOrden=S
ListaOrden=(Lista)
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
BusquedaRapidaControles=S
IconosNombre=CompraPendienteD:Movimiento
FiltroGeneral=CompraPendienteD.Empresa=<T>{Empresa}<T> AND <BR>CompraPendienteD.Proveedor={Si(Vacio(Info.Proveedor), <T>NULL<T>, Comillas(Info.Proveedor))} AND<BR>CompraPendienteD.Moneda=<T>{Info.Moneda}<T>
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

[Lista.Columnas]
0=140
1=88
Mov=109
MovID=64
FechaEmision=77
Articulo=88
CantidadPendiente=55
Costo=80
DescuentoTipo=29
DescuentoLinea=35
SubCuenta=92
ImportePendiente=94
FechaRequerida=88
Referencia=101
Movimiento=137

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
[Lista.CompraPendienteD.CantidadPendiente]
Carpeta=Lista
Clave=CompraPendienteD.CantidadPendiente
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.Costo]
Carpeta=Lista
Clave=CompraPendienteD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.DescuentoLinea]
Carpeta=Lista
Clave=CompraPendienteD.DescuentoLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.SubCuenta]
Carpeta=Lista
Clave=CompraPendienteD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
Antes=S

AntesExpresiones=Asigna( Info.MovID, CompraPendienteD:CompraPendienteD.MovID )<BR>Asigna( Info.Articulo, CompraPendienteD:CompraPendienteD.Articulo ) <BR>Asigna( Info.SubCuenta, CompraPendienteD:CompraPendienteD.SubCuenta )<BR>Asigna( Info.Cantidad, CompraPendienteD:CompraPendienteD.CantidadPendiente ) <BR>Asigna( Info.CantidadPendiente, CompraPendienteD:CompraPendienteD.CantidadPendiente ) <BR>Asigna( Info.Costo, CompraPendienteD:CompraPendienteD.Costo) <BR>Asigna( Info.DescTipo, CompraPendienteD:CompraPendienteD.DescuentoTipo ) <BR>Asigna( Info.Desc, CompraPendienteD:CompraPendienteD.DescuentoLinea )<BR>Asigna( Info.Impuesto1, CompraPendienteD:CompraPendienteD.Impuesto1 )<BR>Asigna( Info.Impuesto2, CompraPendienteD:CompraPendienteD.Impuesto2 )<BR>Asigna( Info.Impuesto3, CompraPendienteD:CompraPendienteD.Impuesto3 )<BR>Asigna( Info.Retencion1, CompraPendienteD:CompraPendienteD.Retencion1 )<BR>Asigna( Info.Retencion2, CompraPendienteD:CompraPendienteD.Retencion2 )<BR>Asigna( Info.FechaD, CompraPendienteD:CompraPendienteD.FechaRequerida )<BR>Asigna( Info.Descripcion, CompraPendienteD:CompraPendienteD.DescripcionExtra )<BR>Asigna( Info.OrigenTipo, CompraPendienteD:CompraPendienteD.DestinoTipo )<BR>Asigna( Info.Origen, CompraPendienteD:CompraPendienteD.Destino )<BR>Asigna( Info.OrigenID, CompraPendienteD:CompraPendienteD.DestinoID )<BR>Asigna( Info.Unidad, CompraPendienteD:CompraPendienteD.Unidad )<BR>Asigna( Info.CantidadInventario, CompraPendienteD:CompraPendienteD.CantidadInventario )<BR>Asigna( Info.CantidadInventarioPendiente, CompraPendienteD:CompraPendienteD.CantidadPendiente*CompraPendienteD:CompraPendienteD.CantidadInventario/CompraPendienteD:CompraPendienteD.Cantidad)<BR>Asigna( Info.Renglon, CompraPendienteD:CompraPendienteD.Renglon)<BR>Asigna( Info.Copiar, Verdadero)
[Lista.ImportePendiente]
Carpeta=Lista
Clave=ImportePendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.RepPan]
Nombre=RepPan
Boton=57
NombreDesplegar=Ver Movimiento
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=COMS
ListaParametros1=CompraPendienteD:CompraPendienteD.ID
ListaParametros=S
Activo=S
Visible=S

[Lista.CompraPendienteD.Articulo]
Carpeta=Lista
Clave=CompraPendienteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.FechaRequerida]
Carpeta=Lista
Clave=CompraPendienteD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.Referencia]
Carpeta=Lista
Clave=CompraPendienteD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

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


[Lista.ListaEnCaptura]
(Inicio)=CompraPendienteD.Articulo
CompraPendienteD.Articulo=CompraPendienteD.SubCuenta
CompraPendienteD.SubCuenta=CompraPendienteD.Referencia
CompraPendienteD.Referencia=CompraPendienteD.FechaRequerida
CompraPendienteD.FechaRequerida=CompraPendienteD.CantidadPendiente
CompraPendienteD.CantidadPendiente=CompraPendienteD.Costo
CompraPendienteD.Costo=CompraPendienteD.DescuentoLinea
CompraPendienteD.DescuentoLinea=ImportePendiente
ImportePendiente=(Fin)

[Lista.ListaOrden]
(Inicio)=CompraPendienteD.FechaRequerida<TAB>(Acendente)
CompraPendienteD.FechaRequerida<TAB>(Acendente)=CompraPendienteD.Articulo<TAB>(Acendente)
CompraPendienteD.Articulo<TAB>(Acendente)=(Fin)





[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=RepPan
RepPan=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)
