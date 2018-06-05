
[Forma]
Clave=CompraActivoFijo
Icono=0
Modulos=(Todos)

ListaCarpetas=Detalle
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=258
PosicionInicialArriba=173
PosicionInicialAlturaCliente=343
PosicionInicialAncho=850
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraHerramientas=S
Nombre=Compra Activo Fijo
Comentarios=Lista(Info.Modulo,Info.MovID)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
MovModulo=(Todos)
ExpresionesAlMostrar=EjecutarSQL(<T>spCalculoValorAdquisicionAF :nEstacion, :nIDMov, :nRenglon, :tEmpresa, :tModulo <T>, EstacionTrabajo, Info.ID, Info.Renglon, Empresa, Info.Modulo)<BR>Asigna(Info.Aplica, 0)                   <BR>ActualizarVista(<T>Detalle<T>)
[Detalle]
Estilo=Iconos
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

Detalle=S

Vista=CompraActivoFijo
IconosCampo=AuxiliarActivoFijo.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
PermiteEditar=S
ListaEnCaptura=(Lista)
VistaMaestra=CompraD
LlaveLocal=(Lista)
LlaveMaestra=(Lista)
IconosSubTitulo=<T>Artículo<T>
RefrescarAlEntrar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=CompraActivoFijo:AuxiliarActivoFijo.Articulo
FiltroGeneral=(AuxiliarActivoFijo.Modulo = {comillas(Info.Modulo)}<BR>AND AuxiliarActivoFijo.IDMov = {Info.ID})
[Detalle.Columnas]
Descripcion1=184
OpcionDesc=214
Tipo_1=64
PrecioLista=64
UnidadCompra=133

ProveedorRef=71
ReferenciaExtra=180
Codigo=111
Articulo=98
Cantidad=64
Unidad=57
Costo=64
Factor=64
ProveedorArt=69
ProveedorArtCosto=97
ID=64
Renglon=64
FechaRequerida=94
FechaOrdenar=94
FechaEntrega=94
Categoria=304
SubCuenta=112
Almacen=64
Importe=64
0=97
1=85
2=62
3=124
4=125
5=97
6=110
7=-2
[Detalle.ResumenCampos]
(Inicio)=Articulo
Articulo=Descripcion
Descripcion=Cantidad
Cantidad=Costo
Costo=DescuentoLinea
DescuentoLinea=Importe
Importe=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=Art.Tipo
Art.Tipo=Art.PrecioLista
Art.PrecioLista=Art.UnidadCompra
Art.UnidadCompra=(Fin)













[Acciones.spActivosFijos.RegistrarLista]
Nombre=RegistrarLista
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=RegistrarSeleccionID( <T>Lista<T> )

[Acciones.spActivosFijos.CreaActivoFijo]
Nombre=CreaActivoFijo
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spCalculoValorAdquisicionAF :nEstacion, :nIDMov, :nRenglon, :tEmpresa, :tModulo <T>, EstacionTrabajo, Info.ID, Info.Renglon, Empresa, Info.Modulo)<BR>ActualizarVista(<T>Detalle<T>)
Activo=S
Visible=S



[Acciones.spActivosFijos.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.spActivosFijos.ListaAccionesMultiples]
(Inicio)=RegistrarLista
RegistrarLista=CreaActivoFijo
CreaActivoFijo=Aceptar
Aceptar=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




[Acciones.Aplicar]
Nombre=Aplicar
Boton=7
NombreDesplegar=&Aplicar
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S










NombreEnBoton=S
EspacioPrevio=S







Expresion=EjecutarSQL(<T>spAplicaGastoActivoFijo :tEmpresa, :tModulo, :tIDMov<T>, Empresa, Info.Modulo, Info.ID )<BR>Asigna(Info.Aplica, 1)<BR>ActualizarVista(<T>Detalle<T>)<BR>ActualizarForma
ActivoCondicion=(Info.Estatus <> <T>CANCELADO<T>) y<BR>(Info.Estatus <> <T>CONCLUIDO<T>) y<BR>(Info.Aplica = 0) y<BR>ConDatos(CompraActivoFijo:AuxiliarActivoFijo.ID)
[Detalle.AuxiliarActivoFijo.Serie]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.AuxiliarActivoFijo.Cantidad]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AuxiliarActivoFijo.ValorAdquisicion]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.ValorAdquisicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AuxiliarActivoFijo.ImporteMov]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.ImporteMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AuxiliarActivoFijo.FactorCalculo]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.FactorCalculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AuxiliarActivoFijo.Total]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Detalle.AuxiliarActivoFijo.FechaInicioDepreciacion]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.FechaInicioDepreciacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
















[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



GuardarAntes=S

































































[Detalle.LlaveLocal]
(Inicio)=AuxiliarActivoFijo.IDMov
AuxiliarActivoFijo.IDMov=AuxiliarActivoFijo.Renglon
AuxiliarActivoFijo.Renglon=(Fin)

[Detalle.LlaveMaestra]
(Inicio)=CompraD.ID
CompraD.ID=CompraD.Renglon
CompraD.Renglon=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=AuxiliarActivoFijo.Serie
AuxiliarActivoFijo.Serie=AuxiliarActivoFijo.Cantidad
AuxiliarActivoFijo.Cantidad=AuxiliarActivoFijo.ValorAdquisicion
AuxiliarActivoFijo.ValorAdquisicion=AuxiliarActivoFijo.ImporteMov
AuxiliarActivoFijo.ImporteMov=AuxiliarActivoFijo.Total
AuxiliarActivoFijo.Total=AuxiliarActivoFijo.FactorCalculo
AuxiliarActivoFijo.FactorCalculo=AuxiliarActivoFijo.FechaInicioDepreciacion
AuxiliarActivoFijo.FechaInicioDepreciacion=(Fin)





















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=Aplicar
Aplicar=(Fin)
