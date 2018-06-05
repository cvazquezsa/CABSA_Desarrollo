[Forma]
Clave=TablaAmortizacionGuia
Nombre=Editar - Tabla Amortización
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=403
PosicionInicialArriba=231
PosicionInicialAlturaCliente=534
PosicionInicialAncho=473
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=93
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Importe, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaAmortizacionGuia
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
OtroOrden=S
ListaOrden=TablaAmortizacionGuia.Vencimiento<TAB>(Acendente)
FiltroGeneral=TablaAmortizacionGuia.Modulo=<T>{Info.Modulo}<T> AND<BR>TablaAmortizacionGuia.ID={Info.ID}

[Lista.Columnas]
Fecha=119
AmortizacionCapital=116
PagarIntereses=88
RevisarTasa=68
Capital=127
Vencimiento=107

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
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(TablaAmortizacionGuia:TablaAmortizacionGuia.Vencimiento)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
AntesExpresiones=EjecutarSQL(<T>spTablaAmortizacion :tModulo, :nID, :tUsuario<T>, Info.Modulo, Info.ID, Usuario)

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
TipoAccion=Ventana
ClaveAccion=Cancelar
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
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
Totalizadores1=Total Amortizaciones
Totalizadores2=Suma(TablaAmortizacionGuia:TablaAmortizacionGuia.Capital)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total Amortizaciones
CarpetaVisible=S

[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
NombreEnBoton=S
NombreDesplegar=&Sugerir
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
GuardarAntes=S
EspacioPrevio=S
AntesExpresiones=EjecutarSQL(<T>spTablaAmortizacionSugerir :tModulo, :nID<T>, Info.Modulo, Info.ID)

[Acciones.Borrar]
Nombre=Borrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Borrar Tabla
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>spTablaAmortizacionEliminar :tModulo, :nID<T>, Info.Modulo, Info.ID)

[Lista.TablaAmortizacionGuia.Capital]
Carpeta=Lista
Clave=TablaAmortizacionGuia.Capital
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaAmortizacionGuia.Vencimiento]
Carpeta=Lista
Clave=TablaAmortizacionGuia.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Total Amortizaciones]
Carpeta=(Carpeta Totalizadores)
Clave=Total Amortizaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.SugerirFijo]
Nombre=SugerirFijo
Boton=20
NombreEnBoton=S
NombreDesplegar=Sugerir (&Importe Fijo)
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
Antes=S
GuardarAntes=S
AntesExpresiones=Si<BR>  Forma(<T>EspecificarImporte<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spTablaAmortizacionSugerir :tModulo, :nID, :nImporteFijo<T>, Info.Modulo, Info.ID, Info.Importe)<BR>Fin

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Borrar
Borrar=Excel
Excel=Sugerir
Sugerir=SugerirFijo
SugerirFijo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TablaAmortizacionGuia.Vencimiento
TablaAmortizacionGuia.Vencimiento=TablaAmortizacionGuia.Capital
TablaAmortizacionGuia.Capital=(Fin)
