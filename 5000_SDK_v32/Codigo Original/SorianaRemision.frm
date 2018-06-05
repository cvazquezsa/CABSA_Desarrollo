[Forma]
Clave=SorianaRemision
Nombre=SorianaRemision
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=VTAS
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ListaCarpetas=(Lista)
CarpetaPrincipal=SorianaArticulos
PosicionInicialIzquierda=110
PosicionInicialArriba=66
PosicionInicialAlturaCliente=536
PosicionInicialAncho=848
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
EspacioPrevio=S
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
[SorianaArticulos]
Estilo=Hoja
Pestana=S
Clave=SorianaArticulos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SorianaArticulos
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
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
ExpAntesRefrescar=asigna(temp.texto, <T>arts<T> )
ExpAlRefrescar=asigna(temp.texto, <T>arts<T> )
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionEdicion=info.estatus =<T>SINAFECTAR<T>
FiltroGeneral=ID = {Info.ID}
[SorianaArticulos.SorianaArticulos.Proveedor]
Carpeta=SorianaArticulos
Clave=SorianaArticulos.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
[SorianaArticulos.SorianaArticulos.Remision]
Carpeta=SorianaArticulos
Clave=SorianaArticulos.Remision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
[SorianaArticulos.SorianaArticulos.FolioPedido]
Carpeta=SorianaArticulos
Clave=SorianaArticulos.FolioPedido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
[SorianaArticulos.SorianaArticulos.Tienda]
Carpeta=SorianaArticulos
Clave=SorianaArticulos.Tienda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
[SorianaArticulos.SorianaArticulos.Codigo]
Carpeta=SorianaArticulos
Clave=SorianaArticulos.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
[SorianaArticulos.SorianaArticulos.CantidadUnidadCompra]
Carpeta=SorianaArticulos
Clave=SorianaArticulos.CantidadUnidadCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
[SorianaArticulos.SorianaArticulos.CostoNetoUnidadCompra]
Carpeta=SorianaArticulos
Clave=SorianaArticulos.CostoNetoUnidadCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
[SorianaArticulos.SorianaArticulos.PorcentajeIEPS]
Carpeta=SorianaArticulos
Clave=SorianaArticulos.PorcentajeIEPS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
[SorianaArticulos.SorianaArticulos.PorcentajeIVA]
Carpeta=SorianaArticulos
Clave=SorianaArticulos.PorcentajeIVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaArticulos.Columnas]
Proveedor=57
Remision=49
FolioPedido=59
Tienda=38
Codigo=102
CantidadUnidadCompra=117
CostoNetoUnidadCompra=125
PorcentajeIEPS=78
PorcentajeIVA=73

ID=64
[SorianaCajasTarimas]
Estilo=Hoja
Pestana=S
Clave=SorianaCajasTarimas
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SorianaCajasTarimas
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

PermiteEditar=S
ExpAntesRefrescar=asigna(info.titulo, <T>cajas<T>)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionEdicion=info.estatus =<T>SINAFECTAR<T>
FiltroGeneral=ID= {Info.ID}
[SorianaCajasTarimas.SorianaCajasTarimas.Proveedor]
Carpeta=SorianaCajasTarimas
Clave=SorianaCajasTarimas.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaCajasTarimas.SorianaCajasTarimas.Remision]
Carpeta=SorianaCajasTarimas
Clave=SorianaCajasTarimas.Remision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaCajasTarimas.SorianaCajasTarimas.NumeroCajaTarima]
Carpeta=SorianaCajasTarimas
Clave=SorianaCajasTarimas.NumeroCajaTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaCajasTarimas.SorianaCajasTarimas.CodigoBarraCajaTarima]
Carpeta=SorianaCajasTarimas
Clave=SorianaCajasTarimas.CodigoBarraCajaTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaCajasTarimas.SorianaCajasTarimas.SucursalDistribuir]
Carpeta=SorianaCajasTarimas
Clave=SorianaCajasTarimas.SucursalDistribuir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaCajasTarimas.SorianaCajasTarimas.CantidadArticulos]
Carpeta=SorianaCajasTarimas
Clave=SorianaCajasTarimas.CantidadArticulos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaCajasTarimas.Columnas]
Proveedor=124
Remision=124
NumeroCajaTarima=95
CodigoBarraCajaTarima=124
SucursalDistribuir=86
CantidadArticulos=88

ID=64
[Acciones.RecibirCajasTarimas]
Nombre=RecibirCajasTarimas
Boton=67
NombreEnBoton=S
NombreDesplegar=Importar CajasTarimas
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=SorianaCajasTarimas
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S

RefrescarDespues=S
GuardarAntes=S

Activo=S
[SorianaArtCajaTarima]
Estilo=Hoja
Pestana=S
Clave=SorianaArtCajaTarima
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SorianaArtCajaTarima
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
ListaEnCaptura=SorianaArtCajaTarima.Proveedor<BR>SorianaArtCajaTarima.Remision<BR>SorianaArtCajaTarima.FolioPedido<BR>SorianaArtCajaTarima.NumeroCajaTarima<BR>SorianaArtCajaTarima.SucursalDistribuir<BR>SorianaArtCajaTarima.Codigo<BR>SorianaArtCajaTarima.CantidadUnidadCompra
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ID = {Info.ID}
CondicionEdicion=info.estatus =<T>SINAFECTAR<T>
[SorianaArtCajaTarima.SorianaArtCajaTarima.Proveedor]
Carpeta=SorianaArtCajaTarima
Clave=SorianaArtCajaTarima.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaArtCajaTarima.SorianaArtCajaTarima.Remision]
Carpeta=SorianaArtCajaTarima
Clave=SorianaArtCajaTarima.Remision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaArtCajaTarima.SorianaArtCajaTarima.FolioPedido]
Carpeta=SorianaArtCajaTarima
Clave=SorianaArtCajaTarima.FolioPedido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaArtCajaTarima.SorianaArtCajaTarima.NumeroCajaTarima]
Carpeta=SorianaArtCajaTarima
Clave=SorianaArtCajaTarima.NumeroCajaTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaArtCajaTarima.SorianaArtCajaTarima.SucursalDistribuir]
Carpeta=SorianaArtCajaTarima
Clave=SorianaArtCajaTarima.SucursalDistribuir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaArtCajaTarima.SorianaArtCajaTarima.Codigo]
Carpeta=SorianaArtCajaTarima
Clave=SorianaArtCajaTarima.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaArtCajaTarima.SorianaArtCajaTarima.CantidadUnidadCompra]
Carpeta=SorianaArtCajaTarima
Clave=SorianaArtCajaTarima.CantidadUnidadCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaArtCajaTarima.Columnas]
Proveedor=124
Remision=124
FolioPedido=124
NumeroCajaTarima=95
SucursalDistribuir=86
Codigo=124
CantidadUnidadCompra=117

[Acciones.SorianaArtCajaTarima]
Nombre=SorianaArtCajaTarima
Boton=67
NombreEnBoton=S
NombreDesplegar=Importar ArtCajaTarima
RefrescarDespues=S
EnBarraHerramientas=S
Carpeta=SorianaArtCajaTarima
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S
EspacioPrevio=S


[Acciones.RecibirArticulos]
Nombre=RecibirArticulos
Boton=67
NombreEnBoton=S
NombreDesplegar=Importar Articulos
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=SorianaArticulos
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S











[SorianaRemision]
Estilo=Hoja
Pestana=S
Clave=SorianaRemision
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SorianaRemision
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
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionEdicion=info.estatus =<T>SINAFECTAR<T>
ExpAntesRefrescar=asigna(info.titulo, <T>Remision<T>)
FiltroGeneral=ID= {Info.ID}
[SorianaRemision.SorianaRemision.Proveedor]
Carpeta=SorianaRemision
Clave=SorianaRemision.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.Remision]
Carpeta=SorianaRemision
Clave=SorianaRemision.Remision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.Consecutivo]
Carpeta=SorianaRemision
Clave=SorianaRemision.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.FechaRemision]
Carpeta=SorianaRemision
Clave=SorianaRemision.FechaRemision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.Tienda]
Carpeta=SorianaRemision
Clave=SorianaRemision.Tienda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.TipoMoneda]
Carpeta=SorianaRemision
Clave=SorianaRemision.TipoMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.TipoBulto]
Carpeta=SorianaRemision
Clave=SorianaRemision.TipoBulto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.EntregaMercancia]
Carpeta=SorianaRemision
Clave=SorianaRemision.EntregaMercancia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.CumpleReqFiscales]
Carpeta=SorianaRemision
Clave=SorianaRemision.CumpleReqFiscales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.CantidadBultos]
Carpeta=SorianaRemision
Clave=SorianaRemision.CantidadBultos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.Subtotal]
Carpeta=SorianaRemision
Clave=SorianaRemision.Subtotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.Descuentos]
Carpeta=SorianaRemision
Clave=SorianaRemision.Descuentos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.IEPS]
Carpeta=SorianaRemision
Clave=SorianaRemision.IEPS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.IVA]
Carpeta=SorianaRemision
Clave=SorianaRemision.IVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.OtrosImpuestos]
Carpeta=SorianaRemision
Clave=SorianaRemision.OtrosImpuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.Total]
Carpeta=SorianaRemision
Clave=SorianaRemision.Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.CantidadPedidos]
Carpeta=SorianaRemision
Clave=SorianaRemision.CantidadPedidos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.FechaEntregaMercancia]
Carpeta=SorianaRemision
Clave=SorianaRemision.FechaEntregaMercancia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.EmpaqueEnCajas]
Carpeta=SorianaRemision
Clave=SorianaRemision.EmpaqueEnCajas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.EmpaqueEnTarimas]
Carpeta=SorianaRemision
Clave=SorianaRemision.EmpaqueEnTarimas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SorianaRemision.SorianaRemision.CantidadCajasTarimas]
Carpeta=SorianaRemision
Clave=SorianaRemision.CantidadCajasTarimas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[SorianaPedimento]
Estilo=Hoja
Pestana=S
Clave=SorianaPedimento
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SorianaPedimento
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
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

CondicionEdicion=info.estatus =<T>SINAFECTAR<T>
ExpAntesRefrescar=asigna(info.titulo, <T>Pedimento<T>)
FiltroGeneral=ID = {Info.ID}
[SorianaPedimento.SorianaPedimento.Proveedor]
Carpeta=SorianaPedimento
Clave=SorianaPedimento.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaPedimento.SorianaPedimento.Remision]
Carpeta=SorianaPedimento
Clave=SorianaPedimento.Remision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaPedimento.SorianaPedimento.Pedimento]
Carpeta=SorianaPedimento
Clave=SorianaPedimento.Pedimento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaPedimento.SorianaPedimento.Aduana]
Carpeta=SorianaPedimento
Clave=SorianaPedimento.Aduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaPedimento.SorianaPedimento.AgenteAduanal]
Carpeta=SorianaPedimento
Clave=SorianaPedimento.AgenteAduanal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[SorianaPedimento.SorianaPedimento.TipoPedimento]
Carpeta=SorianaPedimento
Clave=SorianaPedimento.TipoPedimento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaPedimento.SorianaPedimento.FechaPedimento]
Carpeta=SorianaPedimento
Clave=SorianaPedimento.FechaPedimento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaPedimento.SorianaPedimento.FechaReciboLaredo]
Carpeta=SorianaPedimento
Clave=SorianaPedimento.FechaReciboLaredo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SorianaPedimento.SorianaPedimento.FechaBillOfLading]
Carpeta=SorianaPedimento
Clave=SorianaPedimento.FechaBillOfLading
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[SorianaPedidos]
Estilo=Hoja
Pestana=S
Clave=SorianaPedidos
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SorianaPedidos
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
CondicionEdicion=info.estatus =<T>SINAFECTAR<T>
ExpAntesRefrescar=asigna(info.titulo, <T>Pedido<T>)
ListaEnCaptura=(Lista)


FiltroGeneral=ID = {Info.ID}
[SorianaPedidos.SorianaPedidos.Proveedor]
Carpeta=SorianaPedidos
Clave=SorianaPedidos.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaPedidos.SorianaPedidos.Remision]
Carpeta=SorianaPedidos
Clave=SorianaPedidos.Remision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaPedidos.SorianaPedidos.FolioPedido]
Carpeta=SorianaPedidos
Clave=SorianaPedidos.FolioPedido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaPedidos.SorianaPedidos.Tienda]
Carpeta=SorianaPedidos
Clave=SorianaPedidos.Tienda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SorianaPedidos.SorianaPedidos.CantidadArticulos]
Carpeta=SorianaPedidos
Clave=SorianaPedidos.CantidadArticulos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[SorianaRemision.Columnas]
Proveedor=124
Remision=124
Consecutivo=64
FechaRemision=94
Tienda=124
TipoMoneda=64
TipoBulto=64
EntregaMercancia=124
CumpleReqFiscales=95
CantidadBultos=76
Subtotal=64
Descuentos=64
IEPS=64
IVA=64
OtrosImpuestos=81
Total=64
CantidadPedidos=84
FechaEntregaMercancia=119
EmpaqueEnCajas=87
EmpaqueEnTarimas=97
CantidadCajasTarimas=111

[SorianaPedimento.Columnas]
Proveedor=124
Remision=124
Pedimento=124
Aduana=124
AgenteAduanal=304
TipoPedimento=124
FechaPedimento=94
FechaReciboLaredo=98
FechaBillOfLading=94

[SorianaPedidos.Columnas]
Proveedor=124
Remision=124
FolioPedido=124
Tienda=124
CantidadArticulos=88


[Acciones.RecibirPedidos]
Nombre=RecibirPedidos
Boton=67
NombreEnBoton=S
NombreDesplegar=Importar Pedidos
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=SorianaPedidos
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S









[Acciones.RecibirPedimento]
Nombre=RecibirPedimento
Boton=67
NombreEnBoton=S
NombreDesplegar=Importar Pedimento
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=SorianaPedimento
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S



[Acciones.RecibirRemision]
Nombre=RecibirRemision
Boton=67
NombreEnBoton=S
NombreDesplegar=Importar Remision
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=SorianaRemision
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S













[SorianaCajasTarimas.ListaEnCaptura]
(Inicio)=SorianaCajasTarimas.Proveedor
SorianaCajasTarimas.Proveedor=SorianaCajasTarimas.Remision
SorianaCajasTarimas.Remision=SorianaCajasTarimas.NumeroCajaTarima
SorianaCajasTarimas.NumeroCajaTarima=SorianaCajasTarimas.CodigoBarraCajaTarima
SorianaCajasTarimas.CodigoBarraCajaTarima=SorianaCajasTarimas.SucursalDistribuir
SorianaCajasTarimas.SucursalDistribuir=SorianaCajasTarimas.CantidadArticulos
SorianaCajasTarimas.CantidadArticulos=(Fin)

[SorianaArticulos.ListaEnCaptura]
(Inicio)=SorianaArticulos.Proveedor
SorianaArticulos.Proveedor=SorianaArticulos.Remision
SorianaArticulos.Remision=SorianaArticulos.FolioPedido
SorianaArticulos.FolioPedido=SorianaArticulos.Tienda
SorianaArticulos.Tienda=SorianaArticulos.Codigo
SorianaArticulos.Codigo=SorianaArticulos.CantidadUnidadCompra
SorianaArticulos.CantidadUnidadCompra=SorianaArticulos.CostoNetoUnidadCompra
SorianaArticulos.CostoNetoUnidadCompra=SorianaArticulos.PorcentajeIEPS
SorianaArticulos.PorcentajeIEPS=SorianaArticulos.PorcentajeIVA
SorianaArticulos.PorcentajeIVA=(Fin)

[SorianaPedidos.ListaEnCaptura]
(Inicio)=SorianaPedidos.Proveedor
SorianaPedidos.Proveedor=SorianaPedidos.Remision
SorianaPedidos.Remision=SorianaPedidos.FolioPedido
SorianaPedidos.FolioPedido=SorianaPedidos.Tienda
SorianaPedidos.Tienda=SorianaPedidos.CantidadArticulos
SorianaPedidos.CantidadArticulos=(Fin)

[SorianaPedimento.ListaEnCaptura]
(Inicio)=SorianaPedimento.Proveedor
SorianaPedimento.Proveedor=SorianaPedimento.Remision
SorianaPedimento.Remision=SorianaPedimento.Pedimento
SorianaPedimento.Pedimento=SorianaPedimento.Aduana
SorianaPedimento.Aduana=SorianaPedimento.AgenteAduanal
SorianaPedimento.AgenteAduanal=SorianaPedimento.TipoPedimento
SorianaPedimento.TipoPedimento=SorianaPedimento.FechaPedimento
SorianaPedimento.FechaPedimento=SorianaPedimento.FechaReciboLaredo
SorianaPedimento.FechaReciboLaredo=SorianaPedimento.FechaBillOfLading
SorianaPedimento.FechaBillOfLading=(Fin)

[SorianaRemision.ListaEnCaptura]
(Inicio)=SorianaRemision.Proveedor
SorianaRemision.Proveedor=SorianaRemision.Remision
SorianaRemision.Remision=SorianaRemision.Consecutivo
SorianaRemision.Consecutivo=SorianaRemision.FechaRemision
SorianaRemision.FechaRemision=SorianaRemision.Tienda
SorianaRemision.Tienda=SorianaRemision.TipoMoneda
SorianaRemision.TipoMoneda=SorianaRemision.TipoBulto
SorianaRemision.TipoBulto=SorianaRemision.EntregaMercancia
SorianaRemision.EntregaMercancia=SorianaRemision.CumpleReqFiscales
SorianaRemision.CumpleReqFiscales=SorianaRemision.CantidadBultos
SorianaRemision.CantidadBultos=SorianaRemision.Subtotal
SorianaRemision.Subtotal=SorianaRemision.Descuentos
SorianaRemision.Descuentos=SorianaRemision.IEPS
SorianaRemision.IEPS=SorianaRemision.IVA
SorianaRemision.IVA=SorianaRemision.OtrosImpuestos
SorianaRemision.OtrosImpuestos=SorianaRemision.Total
SorianaRemision.Total=SorianaRemision.CantidadPedidos
SorianaRemision.CantidadPedidos=SorianaRemision.FechaEntregaMercancia
SorianaRemision.FechaEntregaMercancia=SorianaRemision.EmpaqueEnCajas
SorianaRemision.EmpaqueEnCajas=SorianaRemision.EmpaqueEnTarimas
SorianaRemision.EmpaqueEnTarimas=SorianaRemision.CantidadCajasTarimas
SorianaRemision.CantidadCajasTarimas=(Fin)















[Forma.ListaCarpetas]
(Inicio)=SorianaRemision
SorianaRemision=SorianaPedimento
SorianaPedimento=SorianaPedidos
SorianaPedidos=SorianaArticulos
SorianaArticulos=SorianaCajasTarimas
SorianaCajasTarimas=SorianaArtCajaTarima
SorianaArtCajaTarima=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Aceptar
Aceptar=RecibirRemision
RecibirRemision=RecibirPedimento
RecibirPedimento=RecibirPedidos
RecibirPedidos=RecibirArticulos
RecibirArticulos=RecibirCajasTarimas
RecibirCajasTarimas=SorianaArtCajaTarima
SorianaArtCajaTarima=(Fin)
