[Forma]
Clave=ProcesarRequisicionesCompra
Nombre=Procesar Requisiciones Compra
Icono=24
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=520
PosicionInicialAncho=935
PosicionInicialIzquierda=172
PosicionInicialArriba=235
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Si(no Usuario.CompraGenerarOrdenesAlProcesar, Usuario.DefAgente)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraDRef
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin agente)
FiltroTodoNombre=Todo
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroSucursales=S
FiltroFechasCampo=CompraD.FechaRequerida
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroMonedasCampo=Compra.Moneda
FiltroFechasNombre=&Fecha Requerida
FiltroPredefinido1=por Movimiento<BR>por Artículo<BR>por Fecha Requerida
FiltroPredefinido2=CompraD.Articulo IS NOT NULL<BR>CompraD.Articulo IS NOT NULL<BR>CompraD.Articulo IS NOT NULL
FiltroPredefinido3=CompraD.ID<BR>CompraD.Articulo<BR>CompraD.FechaRequerida
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
MenuLocal=S
ListaAcciones=(Lista)
HojaAjustarColumnas=S
FiltroGrupo1=CompraD.EstadoRef
FiltroGrupo2=CompraD.AgenteRef
FiltroValida1=CompraD.EstadoRef
FiltroValida2=CompraD.AgenteRef
FiltroTodo=S
FiltroGeneral=Compra.Empresa=<T>{Empresa}<T> AND <BR>Compra.Estatus=<T>PENDIENTE<T> AND<BR>CompraD.CantidadPendiente>0 AND<BR>Compra.Mov IN ({MovListaSQL(<T>COMS<T>, COMS.R)})<BR>{Si(no Usuario.CompraGenerarOrdenesAlProcesar, <T> AND CompraD.AgenteRef=<T>+Comillas(Usuario.DefAgente), <T><T>)}

[Lista.CompraD.Articulo]
Carpeta=Lista
Clave=CompraD.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CompraD.SubCuenta]
Carpeta=Lista
Clave=CompraD.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.CompraD.ProveedorRef]
Carpeta=Lista
Clave=CompraD.ProveedorRef
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=84
SubCuenta=102
Cantidad=48
Costo=74
ProveedorRef=56
CantidadNeta=64
CostoUnitario=64
CostoTotal=90
Nombre=142
MovNombre=87
FechaRequerida=85
CantidadPendiente=52
FechaEmision=76
CantidadA=48
CostoAOrdenar=84
AgenteRef=69
Almacen=55
ContUso=74
EstadoRef=60
Unidad=38
DescuentoLinea=41
DefMoneda=43
Importe=75

[Lista.CompraD.Costo]
Carpeta=Lista
Clave=CompraD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Lista.MovNombre]
Carpeta=Lista
Clave=MovNombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=Cambiar Vista Hoja (Normal-Detalle)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

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

[Lista.CompraD.CantidadPendiente]
Carpeta=Lista
Clave=CompraD.CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Rojo obscuro
Efectos=[Negritas]

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Ordenes Autorizadas
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
ConfirmarAntes=S
Multiple=S
ListaAccionesMultiples=SQL<BR>Actualizar
ActivoCondicion=Usuario.CompraGenerarOrdenesAlProcesar

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Proveedor
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CompraDRef:CompraD.ProveedorRef)
Antes=S
AntesExpresiones=Asigna(Info.Proveedor, CompraDRef:CompraD.ProveedorRef)
Visible=S

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Artículo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(CompraDRef:CompraD.Articulo)
AntesExpresiones=Asigna(Info.Articulo, CompraDRef:CompraD.Articulo)

[Lista.CompraD.CantidadA]
Carpeta=Lista
Clave=CompraD.CantidadA
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraD.AgenteRef]
Carpeta=Lista
Clave=CompraD.AgenteRef
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraD.Almacen]
Carpeta=Lista
Clave=CompraD.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Copiar Pendiente
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(CompraDRef:CompraD.CantidadA, CompraDRef:CompraD.CantidadPendiente)
Activo=S
Visible=S

[Acciones.Generar.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spGenerarCOMS_OC :nSuc, :tEmp, :tUsuario, :fFecha, :tMov<T>, Sucursal, Empresa, Usuario, FechaTrabajo, ConfigMov.CompraOrden)

[Acciones.Generar.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.CompraD.EstadoRef]
Carpeta=Lista
Clave=CompraD.EstadoRef
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Lista.CompraD.Unidad]
Carpeta=Lista
Clave=CompraD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.CompraD.DescuentoLinea]
Carpeta=Lista
Clave=CompraD.DescuentoLinea
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Observaciones]
Nombre=Observaciones
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Expresion
Expresion=Pregunta(CompraDRef:CompraD.DescripcionExtra)
Activo=S
Visible=S

[Lista.ProvRef.DefMoneda]
Carpeta=Lista
Clave=ProvRef.DefMoneda
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Importe]
Carpeta=Lista
Clave=Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Generar
Generar=CambiarVista
CambiarVista=ArtInfo
ArtInfo=ProvInfo
ProvInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovNombre
MovNombre=CompraD.Almacen
CompraD.Almacen=CompraD.Articulo
CompraD.Articulo=CompraD.SubCuenta
CompraD.SubCuenta=CompraD.CantidadPendiente
CompraD.CantidadPendiente=CompraD.Unidad
CompraD.Unidad=CompraD.AgenteRef
CompraD.AgenteRef=CompraD.ProveedorRef
CompraD.ProveedorRef=ProvRef.DefMoneda
ProvRef.DefMoneda=CompraD.Costo
CompraD.Costo=CompraD.DescuentoLinea
CompraD.DescuentoLinea=Importe
Importe=CompraD.CantidadA
CompraD.CantidadA=CompraD.EstadoRef
CompraD.EstadoRef=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=Art.Fabricante
Art.Fabricante=CodigoFabricante
CodigoFabricante=AgenteRef.Nombre
AgenteRef.Nombre=ProvRef.Nombre
ProvRef.Nombre=ClaveProveedor
ClaveProveedor=CompraD.DescripcionExtra
CompraD.DescripcionExtra=CompraD.ContUso
CompraD.ContUso=CompraD.FechaRequerida
CompraD.FechaRequerida=(Fin)

[Lista.ListaAcciones]
(Inicio)=Copiar
Copiar=Observaciones
Observaciones=(Fin)
