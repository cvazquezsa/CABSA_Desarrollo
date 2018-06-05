[Forma]
Clave=DesglosarCantidadOrdenada
Nombre=Desglose Cantidad Ordenada
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Compras
PosicionInicialIzquierda=177
PosicionInicialArriba=180
PosicionInicialAlturaCliente=373
PosicionInicialAncho=670
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Lista(Info.Mov, Info.MovID, Info.Articulo, Info.SubCuenta)

[Compras]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Compras Pendientes
Clave=Compras
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraPendienteD
Fuente={Tahoma, 8, Negro, []}
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
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CompraPendienteD:CompraPendienteD.Mov+<T> <T>+CompraPendienteD:CompraPendienteD.MovID
FiltroGeneral=CompraPendienteD.Empresa=<T>{Empresa}<T> AND<BR>CompraPendienteD.DestinoTipo=<T>{Info.Modulo}<T> AND<BR>CompraPendienteD.Destino=<T>{Info.Mov}<T> AND<BR>CompraPendienteD.DestinoID=<T>{Info.MovID}<T> AND<BR>CompraPendienteD.Articulo=<T>{Info.Articulo}<T> AND<BR>ISNULL(CompraPendienteD.SubCuenta, <T><T>)={Comillas(Info.SubCuenta)}

[Compras.CompraPendienteD.Cantidad]
Carpeta=Compras
Clave=CompraPendienteD.Cantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.Unidad]
Carpeta=Compras
Clave=CompraPendienteD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Compras.CompraPendienteD.CantidadPendiente]
Carpeta=Compras
Clave=CompraPendienteD.CantidadPendiente
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Compras.Columnas]
0=140
1=150

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

[Produccion]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Producción Pendiente
Clave=Produccion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdPendienteD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=ProdPendienteD:ProdPendienteD.Mov+<T> <T>+ProdPendienteD:ProdPendienteD.MovID
FiltroGeneral=ProdPendienteD.Empresa=<T>{Empresa}<T> AND<BR>ProdPendienteD.DestinoTipo=<T>{Info.Modulo}<T> AND<BR>ProdPendienteD.Destino=<T>{Info.Mov}<T> AND<BR>ProdPendienteD.DestinoID=<T>{Info.MovID}<T> AND<BR>ProdPendienteD.Articulo=<T>{Info.Articulo}<T> AND<BR>ISNULL(ProdPendienteD.SubCuenta, <T><T>)={Comillas(Info.SubCuenta)}
CondicionVisible=General.Prod

[Produccion.ProdPendienteD.Ruta]
Carpeta=Produccion
Clave=ProdPendienteD.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Produccion.ProdPendienteD.Centro]
Carpeta=Produccion
Clave=ProdPendienteD.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Produccion.ProdPendienteD.Cantidad]
Carpeta=Produccion
Clave=ProdPendienteD.Cantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Produccion.ProdPendienteD.Unidad]
Carpeta=Produccion
Clave=ProdPendienteD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Produccion.ProdPendienteD.CantidadPendiente]
Carpeta=Produccion
Clave=ProdPendienteD.CantidadPendiente
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Produccion.Columnas]
0=132
1=117

[Acciones.CompraImprimir]
Nombre=CompraImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.CompraPreliminar]
Nombre=CompraPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.CompraExcel]
Nombre=CompraExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.CompraPersonalizar]
Nombre=CompraPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ProdImprimir]
Nombre=ProdImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.ProdPreliminar]
Nombre=ProdPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.ProdExcel]
Nombre=ProdExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.ProdPersonalizar]
Nombre=ProdPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Compras
Compras=Produccion
Produccion=(Fin)

[Compras.ListaEnCaptura]
(Inicio)=CompraPendienteD.Cantidad
CompraPendienteD.Cantidad=CompraPendienteD.Unidad
CompraPendienteD.Unidad=CompraPendienteD.CantidadPendiente
CompraPendienteD.CantidadPendiente=(Fin)

[Compras.ListaAcciones]
(Inicio)=CompraImprimir
CompraImprimir=CompraPreliminar
CompraPreliminar=CompraExcel
CompraExcel=CompraPersonalizar
CompraPersonalizar=(Fin)

[Produccion.ListaEnCaptura]
(Inicio)=ProdPendienteD.Ruta
ProdPendienteD.Ruta=ProdPendienteD.Centro
ProdPendienteD.Centro=ProdPendienteD.Cantidad
ProdPendienteD.Cantidad=ProdPendienteD.Unidad
ProdPendienteD.Unidad=ProdPendienteD.CantidadPendiente
ProdPendienteD.CantidadPendiente=(Fin)

[Produccion.ListaAcciones]
(Inicio)=ProdImprimir
ProdImprimir=ProdPreliminar
ProdPreliminar=ProdExcel
ProdExcel=ProdPersonalizar
ProdPersonalizar=(Fin)
