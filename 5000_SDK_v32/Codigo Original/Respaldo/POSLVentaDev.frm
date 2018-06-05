
[Forma]
Clave=POSLVentaDev
Icono=0
Modulos=(Todos)
Nombre=Detalle

ListaCarpetas=Campos
CarpetaPrincipal=Campos
PosicionInicialAlturaCliente=428
PosicionInicialAncho=753
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=353
PosicionInicialArriba=135
VentanaSinIconosMarco=S
VentanaColor=$00804000
ExpresionesAlCerrar=EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen, Temp.Reg[11])<BR>Asigna(Info.CtaCaja,Temp.Reg[18])<BR>Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Campos]
Estilo=Hoja
Clave=Campos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLVenta
Fuente={Segoe UI, 10, Blanco, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Blanco
CampoColorFondo=$00804000
ListaEnCaptura=(Lista)

CarpetaVisible=S

ValidarCampos=S
ListaCamposAValidar=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ControlRenglon=S
CampoRenglon=POSLVenta.Renglon
ExpAlRefrescar=EjecutarSQL( <T>spPOSDescuentoDirecto :ID, :Renglon<T>, POSLVenta:POSLVenta.ID, POSLVenta:POSLVenta.Renglon )
BusquedaRapidaControles=S
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
BusquedaAutoAsterisco=S
BusquedaEnLinea=S
HojaColorFondo=$00804000
FuenteDesplegar={MS Sans Serif, 10, Rojo obscuro, [Negritas]}
FuenteBusqueda={Segoe UI, 10, Blanco, []}
ConFuenteEspecial=S
BarraBotones=S
BarraBtnFuente={Segoe UI, 8, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
ConFuenteBusqueda=S
ListaAccionesBB=(Lista)
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=5
ConFuenteDesplegar=S
FiltroGeneral=POSLVenta.ID = <T>{Info.IDTexto}<T>
[Campos.POSLVenta.Articulo]
Carpeta=Campos
Clave=POSLVenta.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$00804000


Editar=N
ColorFuente=Blanco
[Campos.POSLVenta.Precio]
Carpeta=Campos
Clave=POSLVenta.Precio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=$00804000

ColorFuente=Blanco
[Campos.POSLVenta.DescuentoLinea]
Carpeta=Campos
Clave=POSLVenta.DescuentoLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S


ColorFondo=$00804000
ColorFuente=Blanco
[Campos.Columnas]
Articulo=114
SubCuenta=115
Precio=86
DescuentoLinea=96
Cantidad=79





Descripcion1=245
OpcionDesc=604





Almacen=64
Total=91
Impuestos=64
PrecioConImp=103
CantidadM=104
[Campos.POSLVenta.SubCuenta]
Carpeta=Campos
Clave=POSLVenta.SubCuenta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=$00804000

ColorFuente=Blanco
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
Visible=S







Antes=S
DespuesGuardar=S








Activo=S
Multiple=S
ListaAccionesMultiples=(Lista)
AntesExpresiones=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )
[Acciones.POSLSerieLoteTemp]
Nombre=POSLSerieLoteTemp
Boton=18
NombreEnBoton=S
NombreDesplegar=Series/Lotes
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=POSLSerieLoteTemp
Antes=S
DespuesGuardar=S























































Visible=S






































































ActivoCondicion=POSLVenta:Art.Tipo en (TipoSerie, TipoVIN, TipoLote)
AntesExpresiones=Asigna(Info.Articulo,POSLVenta:POSLVenta.Articulo)<BR>Asigna(Info.IDTexto,POSLVenta:POSLVenta.ID)<BR>Asigna(Info.SubCuenta,POSLVenta:POSLVenta.SubCuenta)<BR>Asigna(Info.Cantidad,POSLVenta:POSLVenta.Cantidad)<BR>Asigna(Info.ArtTipo,POSLVenta:Art.Tipo)<BR>Asigna(Info.RenglonID,POSLVenta:POSLVenta.RenglonID)<BR><BR>EjecutarSQL(<T>spPOSInsertarPOSLSerieLoteTemp :nEstacion,:tID,:nRenglonID<T>,EstacionTrabajo,POSLVenta:POSLVenta.ID,POSLVenta:POSLVenta.RenglonID)
[Campos.POSLVenta.Almacen]
Carpeta=Campos
Clave=POSLVenta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=$00804000





















































ColorFuente=Blanco


[Campos.PrecioConImp]
Carpeta=Campos
Clave=PrecioConImp
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=$00804000









ColorFuente=Blanco
[Acciones.Valida]
Nombre=Valida
Boton=0
EnMenu=S
Activo=S
Visible=S











[Acciones.Guardar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Campos.POSLVenta.Cantidad]
Carpeta=Campos
Clave=POSLVenta.Cantidad
LineaNueva=S
ValidaNombre=S
3D=S















Editar=N



EditarConBloqueo=S



ColorFondo=$00804000



ColorFuente=Blanco
[Campos.POSLVenta.CantidadM]
Carpeta=Campos
Clave=POSLVenta.CantidadM
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=$00804000




ColorFuente=Blanco
[Acciones.Guardar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSInsertaDevolucionP :@ID, :@Mov<T>, POSLVenta:POSLVenta.ID, <T>Nota<T>)<BR>EjecutarSQL(<T>spPOSArtPrecioRecalcular :@ID, :@Estacion<T>, POSLVenta:POSLVenta.ID,  EstacionTrabajo)
[Acciones.Guardar.Aceptar1]
Nombre=Aceptar1
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.Guardar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar1
Aceptar1=(Fin)













































[Acciones.Separador]
Nombre=Separador
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=75
BarraBtnFondo=Plata
BarraBtnPagina=1




[Acciones.Guarda.Expreciones]
Nombre=Expreciones
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSInsertaDevolucionP :@ID, :@Mov<T>, POSLVenta:POSLVenta.ID, <T>Nota<T>)<BR>EjecutarSQL(<T>spPOSArtPrecioRecalcular :@ID, :@Estacion<T>, POSLVenta:POSLVenta.ID,  EstacionTrabajo)
[Acciones.Guarda]
Nombre=Guarda
Boton=0
NombreDesplegar=<T>Aceptar<T>
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

Antes=S
DespuesGuardar=S




edBotonSrc=Seleccionar.png
AntesExpresiones=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )
[Acciones.Guarda.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.POSLSerieLote]
Nombre=POSLSerieLote
Boton=0
NombreDesplegar=<T>Serie/Lotes<T>
GuardarAntes=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=POSLSerieLoteTemp
Antes=S
DespuesGuardar=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

ActivoCondicion=POSLVenta:Art.Tipo en (TipoSerie, TipoVIN, TipoLote)
AntesExpresiones=Asigna(Info.Articulo,POSLVenta:POSLVenta.Articulo)<BR>Asigna(Info.IDTexto,POSLVenta:POSLVenta.ID)<BR>Asigna(Info.SubCuenta,POSLVenta:POSLVenta.SubCuenta)<BR>Asigna(Info.Cantidad,POSLVenta:POSLVenta.Cantidad)<BR>Asigna(Info.ArtTipo,POSLVenta:Art.Tipo)<BR>Asigna(Info.RenglonID,POSLVenta:POSLVenta.RenglonID)<BR><BR>EjecutarSQL(<T>spPOSInsertarPOSLSerieLoteTemp :nEstacion,:tID,:nRenglonID<T>,EstacionTrabajo,POSLVenta:POSLVenta.ID,POSLVenta:POSLVenta.RenglonID)









[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=POSLSerieLoteTemp
POSLSerieLoteTemp=(Fin)












[Acciones.Guarda.ListaAccionesMultiples]
(Inicio)=Expreciones
Expreciones=Aceptar
Aceptar=(Fin)







[Campos.ListaEnCaptura]
(Inicio)=POSLVenta.Articulo
POSLVenta.Articulo=POSLVenta.SubCuenta
POSLVenta.SubCuenta=POSLVenta.Cantidad
POSLVenta.Cantidad=POSLVenta.CantidadM
POSLVenta.CantidadM=POSLVenta.Precio
POSLVenta.Precio=PrecioConImp
PrecioConImp=POSLVenta.DescuentoLinea
POSLVenta.DescuentoLinea=POSLVenta.Almacen
POSLVenta.Almacen=(Fin)

[Campos.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=POSLVenta.Almacen
POSLVenta.Almacen=Art.Tipo
Art.Tipo=(Fin)

[Campos.ListaAccionesBB]
(Inicio)=Separador
Separador=Guarda
Guarda=POSLSerieLote
POSLSerieLote=(Fin)
