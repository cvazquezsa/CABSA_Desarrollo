[Forma]
Clave=CompraProrrateoManual
Nombre=Tabla Prorrateo - Compras (Manual)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=355
PosicionInicialArriba=308
PosicionInicialAlturaCliente=381
PosicionInicialAncho=569
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSeccion1=90
Comentarios=Estacion
VentanaExclusiva=S
ExpresionesAlMostrar=EjecutarSQL(<T>spCompraProrrateoManualEliminar :nEstacion<T>, EstacionTrabajo)
Totalizadores=S
PosicionSec1=317

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodEstacionexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraProrrateoManual
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
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
FiltroGeneral=CompraProrrateoManual.Estacion={EstacionTrabajo}

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
ConCondicion=S
EjecucionConError=S
Antes=S
DespuesGuardar=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(CompraProrrateoManual:CompraProrrateoManual.Grupo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
AntesExpresiones=EjecutarSQL(<T>spCompraProrrateoArt :nEstacion, :tEmp, :nID, :nRenglonID, :tArt, :tSub, :nCantidad, @Manual = 1<T>, EstacionTrabajo, Empresa, Info.ID, Info.RenglonID, Info.Articulo, Info.SubCuenta, Info.Cantidad)

[Lista.Columnas]
Grupo=278
Porcentaje=64
Cantidad=111
CantidadTotal=82
Sucursales=56

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodEstacionexto=S
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
Totalizadores1=Sucursales<BR>Cantidad Total
Totalizadores2=Suma(CompraProrrateoManual:Sucursales)<BR>Suma(CompraProrrateoManual:CantidadTotal)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Totalizadores3=<BR>(Cantidades)

[Lista.CompraProrrateoManual.Grupo]
Carpeta=Lista
Clave=CompraProrrateoManual.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
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

[Lista.CompraProrrateoManual.Cantidad]
Carpeta=Lista
Clave=CompraProrrateoManual.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.CantidadTotal]
Carpeta=Lista
Clave=CantidadTotal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris
Efectos=[Negritas]

[Lista.Sucursales]
Carpeta=Lista
Clave=Sucursales
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris
Efectos=[Negritas]

[(Carpeta Totalizadores).Sucursales]
Carpeta=(Carpeta Totalizadores)
Clave=Sucursales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Cantidad Total]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad Total
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CompraProrrateoManual.Grupo
CompraProrrateoManual.Grupo=Sucursales
Sucursales=CompraProrrateoManual.Cantidad
CompraProrrateoManual.Cantidad=CantidadTotal
CantidadTotal=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Sucursales
Sucursales=Cantidad Total
Cantidad Total=(Fin)
