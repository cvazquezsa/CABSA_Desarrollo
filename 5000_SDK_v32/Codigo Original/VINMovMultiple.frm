[Forma]
Clave=VINMovMultiple
Nombre=<T>Especificar VINs<T>
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=247
PosicionInicialArriba=291
PosicionInicialAltura=441
PosicionInicialAncho=786
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
Comentarios=Info.Articulo
ExpresionesAlMostrar=Asigna(Info.Propiedades, Nulo)
PosicionInicialAlturaCliente=414

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
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
SerieLote=193
Propiedades=124
Cantidad=60
CantidadAlterna=59
Cliente=68
Localizacion=65
Articulo_1=170
NumeroEconomico=114
Placas=97

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

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Borrar todo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Multiple=S
ConfirmarAntes=S
ListaAccionesMultiples=Cancelar<BR>sp<BR>Actualizar Forma
EspacioPrevio=S

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
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
EjecucionConError=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=Asigna(Info.SerieLote, ListaBuscarDuplicados(CampoEnLista(VINMov:VINMovMultiple.SerieLote)))<BR>Vacio(Info.SerieLote)
EjecucionMensaje=<T>Número: <T>+Info.SerieLote+<T> Duplicado<T>
AntesExpresiones=Asigna(Info.SumaSerieLote, Suma(Redondea(VINMov:VINMovMultiple.Cantidad, 4)))<BR>Asigna(Info.SumaAlternaSerieLote, Suma(Redondea(VINMov:VINMovMultiple.CantidadAlterna, 4)))<BR>Si(General.Ford, Asigna(Info.Costo, SQL(<T>SELECT SUM(v.SubTotalFacturaCompra) FROM SerieLoteMov s, VIN v WHERE s.Empresa=:tEmp AND s.Modulo=:tModulo AND s.ID=:nID AND s.RenglonID=:nRenID AND s.Articulo=:tArt AND s.SerieLote = v.VIN<T>, Empresa, Info.Modulo, Info.ID, Info.RenglonID, Info.Articulo)))

[Lista.VIN.Articulo]
Carpeta=Lista
Clave=VIN.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.VIN]
Nombre=VIN
Boton=1
NombreEnBoton=S
NombreDesplegar=VIN &Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=Si<BR>  Forma(<T>VINExpress<T>)<BR>Entonces<BR>  Asigna(VINMovMultiple:VINMovMultiple.SerieLote, Info.SerieLote)<BR>  Si(ConDatos(Info.SerieLote),  AvanzarCaptura)<BR>Fin
ActivoCondicion=Info.EsEntrada y (Info.Modulo=<T>COMS<T>)

[Lista.VIN.NumeroEconomico]
Carpeta=Lista
Clave=VIN.NumeroEconomico
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Lista.VIN.Placas]
Carpeta=Lista
Clave=VIN.Placas
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

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
Aceptar=VIN
VIN=Eliminar
Eliminar=SerieLoteInfo
SerieLoteInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VINMovMultiple.SerieLote
VINMovMultiple.SerieLote=VINMovMultiple.Propiedades
VINMovMultiple.Propiedades=VIN.Articulo
VIN.Articulo=VIN.NumeroEconomico
VIN.NumeroEconomico=VIN.Placas
VIN.Placas=(Fin)
