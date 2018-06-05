[Forma]
Clave=GastoDProrrateo
Nombre=Tabla Prorrateo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=356
PosicionInicialAncho=849
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=535
PosicionInicialArriba=384
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Totalizadores=S
PosicionSeccion1=89
Comentarios=Info.Concepto
VentanaEscCerrar=S
PosicionInicialAlturaCliente=395
ExpresionesAlMostrar=Asigna(Info.FechaD, Hoy)<BR>Asigna(Info.FechaA, Hoy)<BR>Si(Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), EjecutarSQL(<T>spGastoDProrrateo :tEmp, :nSucursal, :nID, :nRenglon, :nRenglonSub, :tConcepto, :nImporte, :tCC, :tAuto<T>, Empresa, Sucursal, Info.ID, Info.Renglon, Info.RenglonSub, Info.Concepto, Info.Importe, Info.CentroCostos, Info.Espacio))
PosicionSec1=331

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GastoDProrrateo
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
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
CondicionEdicion=Usuario.GastoModificarProrrateo y (Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
MenuLocal=S
ListaAcciones=Cudrar
FiltroPredefinido1=(sin ordenar)<BR>por %<BR>por Sucursal<BR>por Centro Costos<BR>por Proyecto<BR>por Actividad<BR>por Sucursal / Centro Costos<BR>por Fecha
FiltroPredefinido2=1=1<BR>1=1<BR>1=1<BR>1=1<BR>1=1<BR>1=1<BR>1=1<BR>1=1
FiltroPredefinido3=RenglonID<BR>Porcentaje<BR>SucursalProrrateo, Porcentaje<BR>ContUso, Porcentaje<BR>Proyecto, Porcentaje<BR>Actividad, Porcentaje<BR>SucursalProrrateo, ContUso, Porcentaje<BR>GastoDProrrateo.Fecha, Porcentaje
FiltroEstilo=Directorio

FiltroGeneral=GastoDProrrateo.ID={Info.ID} AND Renglon={Info.Renglon} AND RenglonSub={Info.RenglonSub} AND Concepto=<T>{Info.Concepto}<T>
[Lista.GastoDProrrateo.SucursalProrrateo]
Carpeta=Lista
Clave=GastoDProrrateo.SucursalProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.GastoDProrrateo.Porcentaje]
Carpeta=Lista
Clave=GastoDProrrateo.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Columnas]
SucursalProrrateo=49
Nombre=87
Porcentaje=46
Importe=103
ContUso=99
Proyecto=114
Actividad=92
Espacio=64
VIN=75
Fecha=72

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
EjecucionCondicion=Si<BR>  Redondea(Suma(GastoDProrrateo:GastoDProrrateo.Porcentaje), 4) <> 100<BR>Entonces<BR>  Confirmacion(<T>La Tabla de Prorrateo No Cuadra, Desea Continuar ?<T>, BotonSi, BotonNo) = BotonSi<BR>Sino<BR>  Verdadero<BR>Fin

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
ActivoCondicion=Usuario.GastoModificarProrrateo y (Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
Visible=S

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
Totalizadores1=%<BR>Importe
Totalizadores2=Suma(GastoDProrrateo:GastoDProrrateo.Porcentaje)<BR>Suma(GastoDProrrateo:GastoDProrrateo.Importe)
Totalizadores3=0.00<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.GastoDProrrateo.Importe]
Carpeta=Lista
Clave=GastoDProrrateo.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Totalizadores).%]
Carpeta=(Carpeta Totalizadores)
Clave=%
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Cudrar]
Nombre=Cudrar
Boton=0
UsaTeclaRapida=S
NombreDesplegar=Cudrar
EnMenu=S
TipoAccion=Expresion
Visible=S
TeclaRapida=F5
Expresion=Asigna(GastoDProrrateo:GastoDProrrateo.Porcentaje, 100-Suma(GastoDProrrateo:GastoDProrrateo.Porcentaje))
ActivoCondicion=Usuario.GastoModificarProrrateo y (Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))

[Lista.GastoDProrrateo.ContUso]
Carpeta=Lista
Clave=GastoDProrrateo.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.GastoDProrrateo.Proyecto]
Carpeta=Lista
Clave=GastoDProrrateo.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.GastoDProrrateo.Actividad]
Carpeta=Lista
Clave=GastoDProrrateo.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.GastoDProrrateo.Espacio]
Carpeta=Lista
Clave=GastoDProrrateo.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Importar]
Nombre=Importar
Boton=2
NombreEnBoton=S
NombreDesplegar=&Importar Tabla...
Multiple=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
ListaAccionesMultiples=Procesar Lista<BR>Actualizar Forma

[Acciones.Importar.Procesar Lista]
Nombre=Procesar Lista
Boton=0
TipoAccion=Otros
ClaveAccion=Procesar Lista
ListaParametros=S
Activo=S
Visible=S
ListaParametros1=<T>Importar - Tabla<T><BR><T>ListaSt<T><BR><T>Estacion<T><BR><T>ID<T><BR><T>xpImportarGastoDProrrateo<T><BR>EstacionTrabajo & <T>, <T> & Comillas(Empresa) & <T>, <T> & Comillas(Usuario) & <T>, <T> & Sucursal & <T>, <T> & Info.ID & <T>, <T> & Info.Renglon & <T>, <T> & Info.RenglonSub & <T>, <T> & Comillas(Info.Concepto)

[Acciones.Importar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Lista.GastoDProrrateo.VIN]
Carpeta=Lista
Clave=GastoDProrrateo.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.GastoDProrrateo.Fecha]
Carpeta=Lista
Clave=GastoDProrrateo.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.ProrrateoFechas]
Nombre=ProrrateoFechas
Boton=55
NombreEnBoton=S
NombreDesplegar=Prorrateo por &Fechas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=Si<BR> Forma(<T>GastoDProrrateoFechas<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spGastoDProrrateoFechas :tEmp, :nSucursal, :nID, :nRenglon, :nRenglonSub, :tConcepto, :nImporte, :fFechaD, :fFechaA, :tMetodo<T>, Empresa, Sucursal, Info.ID, Info.Renglon, Info.RenglonSub, Info.Concepto, Info.Importe, Info.FechaD, Info.FechaA, Info.MetodoProrrateo)<BR>  Forma.ActualizarVista <BR>Fin

[Acciones.ProrrateoFechas2]
Nombre=ProrrateoFechas2
Boton=55
NombreDesplegar=Cap&tura Actual
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
NombreEnBoton=S
GuardarAntes=S
Expresion=Si<BR> Forma(<T>GastoDProrrateoFechas2<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spGastoDProrrateoFechas2 :tEmp, :nSucursal, :nID, :nRenglon, :nRenglonSub, :tConcepto, :fFechaD, :fFechaA, :tMetodo<T>, Empresa, Sucursal, Info.ID, Info.Renglon, Info.RenglonSub, Info.Concepto, Info.FechaD, Info.FechaA, Info.MetodoProrrateo)<BR>  Forma.ActualizarVista<BR>Fin
ActivoCondicion=Usuario.GastoModificarProrrateo y (Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))


[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=%
%=Importe
Importe=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=GastoDProrrateo.ContUso
GastoDProrrateo.ContUso=GastoDProrrateo.UEN
GastoDProrrateo.UEN=GastoDProrrateo.VIN
GastoDProrrateo.VIN=GastoDProrrateo.Espacio
GastoDProrrateo.Espacio=GastoDProrrateo.SucursalProrrateo
GastoDProrrateo.SucursalProrrateo=Sucursal.Nombre
Sucursal.Nombre=GastoDProrrateo.Proyecto
GastoDProrrateo.Proyecto=GastoDProrrateo.Actividad
GastoDProrrateo.Actividad=GastoDProrrateo.Fecha
GastoDProrrateo.Fecha=GastoDProrrateo.Porcentaje
GastoDProrrateo.Porcentaje=GastoDProrrateo.Importe
GastoDProrrateo.Importe=(Fin)

[Lista.GastoDProrrateo.UEN]
Carpeta=Lista
Clave=GastoDProrrateo.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Importar
Importar=ProrrateoFechas
ProrrateoFechas=ProrrateoFechas2
ProrrateoFechas2=(Fin)
