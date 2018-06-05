[Forma]
Clave=CompraDProrrateo
Nombre=Tabla Prorrateo - Compras
Icono=0
Modulos=(Todos)
MovModulo=COMS
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=297
PosicionInicialArriba=268
PosicionInicialAlturaCliente=460
PosicionInicialAncho=685
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Articulo, Info.SubCuenta, NumEnTexto(Info.Cantidad, <T>#,.####<T>), Info.Unidad)
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=92
VentanaExclusiva=S
ExpresionesAlMostrar=EjecutarSQL(<T>spCompraProrrateoArt :nEstacion, :tEmp, :nID, :nRenglonID, :tArt, :tSub, :nCantidad<T>, EstacionTrabajo, Empresa, Info.ID, Info.RenglonID, Info.Articulo, Info.SubCuenta, Info.Cantidad)
PosicionSec1=393

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraDProrrateo
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
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=CompraDProrrateo.ID={Info.ID} AND CompraDProrrateo.RenglonID={Info.RenglonID} AND CompraDProrrateo.Articulo=<T>{Info.Articulo}<T> AND ISNULL(CompraDProrrateo.SubCuenta, <T><T>)={Comillas(Info.SubCuenta)}

[Lista.CompraDProrrateo.Almacen]
Carpeta=Lista
Clave=CompraDProrrateo.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Editar=S
Efectos=[Negritas]

[Lista.Alm.Nombre]
Carpeta=Lista
Clave=Alm.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CompraDProrrateo.Cantidad]
Carpeta=Lista
Clave=CompraDProrrateo.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Columnas]
Almacen=101
Nombre=224
Cantidad=51
Sucursal=45
Nombre_1=167
Sucursal_1=45
NombreSucursal=219
NumeroSucursal=47

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
DespuesGuardar=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(CompraDProrrateo:CompraDProrrateo.Almacen)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S
AntesExpresiones=Asigna(Info.Cantidad, Suma(CompraDProrrateo:CompraDProrrateo.Cantidad))

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Cantidad
Totalizadores2=Suma(CompraDProrrateo:CompraDProrrateo.Cantidad)
Totalizadores3=(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Cantidad
CarpetaVisible=S

[(Carpeta Totalizadores).Cantidad]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Lista.NombreSucursal]
Carpeta=Lista
Clave=NombreSucursal
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Recalcular]
Nombre=Recalcular
Boton=92
NombreDesplegar=por &Omisión
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
Antes=S
EspacioPrevio=S
NombreEnBoton=S
AntesExpresiones=EjecutarSQL(<T>spCompraProrrateoArt :nEstacion, :tEmp, :nID, :nRenglonID, :tArt, :tSub, :nCantidad, @Recalc = 1<T>, EstacionTrabajo, Empresa, Info.ID, Info.RenglonID, Info.Articulo, Info.SubCuenta, Info.Cantidad)

[Acciones.Manual]
Nombre=Manual
Boton=57
NombreEnBoton=S
NombreDesplegar=&Manual
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
EjecucionCondicion=Forma(<T>CompraProrrateoManual<T>)
Visible=S

[Lista.NumeroSucursal]
Carpeta=Lista
Clave=NumeroSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Manual
Manual=Recalcular
Recalcular=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CompraDProrrateo.Almacen
CompraDProrrateo.Almacen=Alm.Nombre
Alm.Nombre=NumeroSucursal
NumeroSucursal=NombreSucursal
NombreSucursal=CompraDProrrateo.Cantidad
CompraDProrrateo.Cantidad=(Fin)

[Lista.ListaOrden]
(Inicio)=Alm.Sucursal<TAB>(Acendente)
Alm.Sucursal<TAB>(Acendente)=Alm.SucursalRef<TAB>(Acendente)
Alm.SucursalRef<TAB>(Acendente)=(Fin)
