[Forma]
Clave=VINMovMultipleInfo
Nombre=<T>VINs del Movimiento<T>
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=256
PosicionInicialArriba=288
PosicionInicialAltura=441
PosicionInicialAncho=767
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Totalizadores=S
PosicionSeccion1=91
VentanaEscCerrar=S
ExpresionesAlMostrar=Asigna(Info.Propiedades, Nulo)
PosicionInicialAlturaCliente=414

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VINMovMultiple
Fuente={Fixedsys, 9, Negro, []}
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
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
ConFuenteEspecial=S
FiltroGeneral=VINMovMultiple.Empresa   = <T>{Empresa}<T>       AND<BR>VINMovMultiple.Modulo    = <T>{Info.Modulo}<T>   AND<BR>VINMovMultiple.ID        = {Info.ID}         AND<BR>VINMovMultiple.RenglonID = {Info.RenglonID}  AND<BR>VINMovMultiple.Articulo  = <T>{Info.Articulo}<T> AND<BR>VINMovMultiple.SubCuenta = <T>{Info.SubCuenta}<T>

[Lista.VINMovMultiple.SerieLote]
Carpeta=Lista
Clave=VINMovMultiple.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
IgnoraFlujo=S

[Lista.Columnas]
SerieLote=203
Propiedades=124
Cantidad=60
CantidadAlterna=59
Cliente=68
Localizacion=65
Articulo_1=170
NumeroEconomico=107
Placas=86

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total
Totalizadores2=Suma(Redondea(VINMovMultiple:VINMovMultiple.Cantidad, 4)) & <T>/<T> & Redondea(Info.Cantidad, 4)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S
Totalizadores3=

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Acciones.Eliminar.sp]
Nombre=sp
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spSeriesLotesMayoreoLimpiar :tEmpresa, :tModulo, :nID, :nRenglonID, :tArticulo, :tSubCuenta<T>, Empresa, Info.Modulo, Info.ID, Info.RenglonID, Info.Articulo, Info.SubCuenta)

[Acciones.Eliminar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
NombreEnBoton=S
AntesExpresiones=Asigna(Info.SerieLote, VINMovMultiple:VINMovMultiple.SerieLote)

[Acciones.Eliminar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.VIN.Articulo]
Carpeta=Lista
Clave=VIN.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VIN.NumeroEconomico]
Carpeta=Lista
Clave=VIN.NumeroEconomico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VIN.Placas]
Carpeta=Lista
Clave=VIN.Placas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINMovMultiple.Propiedades]
Carpeta=Lista
Clave=VINMovMultiple.Propiedades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=SerieLoteInfo
SerieLoteInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VINMovMultiple.SerieLote
VINMovMultiple.SerieLote=VINMovMultiple.Propiedades
VINMovMultiple.Propiedades=VIN.Articulo
VIN.Articulo=VIN.NumeroEconomico
VIN.NumeroEconomico=VIN.Placas
VIN.Placas=(Fin)
