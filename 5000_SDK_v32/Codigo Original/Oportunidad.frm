[Forma]
Clave=Oportunidad
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=155
PosicionInicialArriba=12
PosicionInicialAltura=531
PosicionInicialAncho=1028
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DialogoAbrir=S
ListaAcciones=(Lista)
PosicionSeccion1=48
PosicionSeccion2=92
BarraAyuda=S
MovModulo=OPORT
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
PosicionInicialAlturaCliente=614
PosicionSec1=253
PosicionSec2=539

Nombre=<T>Oportunidad<T>
AutoGuardarEncabezado=S
TituloAutoNombre=S
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.RefrescandoPrecio, Falso)
Totalizadores=S
SinTransacciones=S
PosicionCol2=989
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Oportunidad
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Pestana=S

[Ficha.Oportunidad.Mov]
Carpeta=Ficha
Clave=Oportunidad.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Oportunidad.MovID]
Carpeta=Ficha
Clave=Oportunidad.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.Oportunidad.FechaEmision]
Carpeta=Ficha
Clave=Oportunidad.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Oportunidad.Concepto]
Carpeta=Ficha
Clave=Oportunidad.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=S
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.Oportunidad.Proyecto]
Carpeta=Ficha
Clave=Oportunidad.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Oportunidad.Moneda]
Carpeta=Ficha
Clave=Oportunidad.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Oportunidad.Referencia]
Carpeta=Ficha
Clave=Oportunidad.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.Oportunidad.Observaciones]
Carpeta=Ficha
Clave=Oportunidad.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=OportunidadA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosConPaginas=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Oportunidad.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Oportunidad.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
PestanaOtroNombre=S
PestanaNombre=movimientos
FiltroUsuarios=S
FiltroUsuarioDefault=(Todos)
FiltroFechasNormal=S
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroAutoValidar=Mon
FiltroAplicaEn=Oportunidad.Moneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=Oportunidad.FechaCancelacion
FiltroSucursales=S
FiltroMonedas=S
FiltroMonedasCampo=Oportunidad.Moneda

IconosNombre=OportunidadA:Oportunidad.Mov+<T> <T>+OportunidadA:Oportunidad.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=138
1=69

2=156
3=-2
4=-2
5=113
6=72
7=-2
8=-2
9=-2
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=Si
EnMenu=Si
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=Si
Activo=Si
Menu=&Archivo
UsaTeclaRapida=Si
TeclaRapida=Ctrl+N

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Visible=S
Activo=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=S
Activo=S
ConCondicion=S

EjecucionCondicion=Si<BR>  Suma(Oportunidad:Avance)>100<BR>Entonces<BR>      Precaucion( <T>El Porcentaje de Avance Total es Mayor al 100%<T>,  BotonCancelar)<BR>Sino<BR> Si(General.MovConcurrente y ConDatos(Oportunidad:Oportunidad.ID) y (Oportunidad:Oportunidad.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Oportunidad:Oportunidad.ID, <T>OPORT<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>    Verdadero<BR> Fin<BR>Fin
[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Visible=S
Activo=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Visible=S
Activo=S
EspacioPrevio=S


[Detalle.Columnas]
Importe=87
Aplica=106
AplicaID=66
AplicaProntoPago=96
Referencia=57
Observaciones=202
ObligacionFiscal=132
Tasa=37
Factor=64
Contacto=71
ContactoTipo=124
DebeFiscal=82
HaberFiscal=87
OtrosImpuestos=89
Excento=43
Deducible=64
MovNombre=96
Base=69
Neto=95
CalcBase=74
CalcNeto=90

TipoImpuesto=72
Articulo=87
Cantidad=48
Precio=77
DescuentoLinea=36
TipoImpuesto1=70
Impuesto1=35
SubImpuesto1=74
TipoImpuesto2=72
Impuesto2=42
SubImpuesto2=72
TipoImpuesto3=83
Impuesto3=64
SubImpuesto3=76
TipoRetencion1=95
Retencion1=86
SubRetencion1=72
TipoRetencion2=95
Retencion2=86
SubRetencion2=72
TipoRetencion3=84
Retencion3=75
SubRetencion3=64
Costo=76
CostoTotal=77
SubCuenta=80
ID=64
IDGestion=64
Comentarios=304
RID=64
PorcentajeAvance=95
Renglon=64
RenglonSub=64
RenglonID=64
RenglonTipo=63
Tipo=66
Clave=59
Cliente=64
Nombre=184
CantidadPendiente=53
CantidadA=47
CantidadNeta=49
CantidadReservada=57
Actividad=53
Asunto=159
EsFase=29
Duracion=46
DuracionUnidad=39
Predecesora=65
Comienzo=82
Fin=79
RecursosAsignados=174
Avance=43
Estado=90
Unidad=41
CantidadInventario=54
DescuentoImporte=54
ContUso=76
EstaLiberado=45
EsNuevo=64
PorcentajeUtilidad=108
CostoInv=86
GastosPct=51
FechaRequerida=87
Concepto=134
PorcentajeDeducible=68
Impuestos=67
Total=77
CantidadInvNeta=53
Ejercido=80
Pendiente=77
Disponible=76
[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=4
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Importe Oportunidad<BR>Avance
Totalizadores2=Oportunidad:Oportunidad.ImporteOportunidad<BR>Oportunidad:Avance
Totalizadores3=(Monetario)<BR>#.##%
Totalizadores=S
TotCarpetaRenglones=Ficha
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CondicionVisible=MovTipo(<T>OPORT<T>, Oportunidad:Oportunidad.Mov) en(OPORT.O)
[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=<T>A&fectar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S
GuardarAntes=S
ConCondicion=S
EspacioPrevio=S
Antes=S
DespuesGuardar=S

Expresion=Asigna(Afectar.Modulo, <T>OPORT<T>)<BR>Asigna(Afectar.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Afectar.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Afectar.MovID, Oportunidad:Oportunidad.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>Oportunidad<T>)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)<BR>Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>OPORT<T>, Oportunidad:Oportunidad.Mov))<BR>Asigna(Info.Base, <T><T>)<BR>Asigna(Info.FechaA, Oportunidad:Oportunidad.FechaEmision)<BR><BR>Si Info.MovTipo = <T>OPORT.G<T><BR>Entonces<BR>  Si<BR>    Oportunidad:Oportunidad.Estatus=EstatusPendiente<BR>  Entonces<BR>    Si<BR>      ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>    Entonces<BR>      Si<BR>        Forma(<T>GenerarMovFlujo<T>)<BR>      Entonces<BR>        Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>        Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>      Fin<BR>    Sino<BR>      Dialogo(<T>GenerarOportunidadPendiente<T>)<BR>      Forma.DocumentoAbrir<BR>    Fin<BR>  Sino<BR>    //Afectar(<T>OPORT<T>, Oportunidad:Oportunidad.ID, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.MovID, <T>Todo<T>, <T><T>, <T>Oportunidad<T>)<BR>    ProcesarSQL(<T>EXEC spAfectar :tModulo, :nID, :tAccion, :tBase, :tGenerarMov, :tUsuario<T>, <T>OPORT<T>, Oportunidad:Oportunidad.ID, <T>AFECTAR<T>, <T>Todo<T>, <T><T>, Usuario)<BR>  Fin<BR>Sino<BR>  Caso Oportunidad:Oportunidad.Estatus<BR>    Es EstatusSinAfectar   Entonces Asigna(Info.Base, <T>REVISION<T>)<BR>    Es EstatusPorConfirmar Entonces Asigna(Info.Base, <T>REVISION<T>)<BR>    Es EstatusBorrador     Entonces Asigna(Info.Base, <T>REVISION<T>)<BR>    Es EstatusRevision     Entonces Asigna(Info.Base, <T>PENDIENTE<T>)<BR>  Sino<BR>    Dialogo(<T>AfectarOportunidad<T>)                                 <BR>  Fin<BR><BR>  Si Info.Base <> <T><T><BR>  Entonces<BR>    //Afectar(<T>OPORT<T>, Oportunidad:Oportunidad.ID, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.MovID, <T>Todo<T>, Info.Base, <T>Oportunidad<T>)<BR>    ProcesarSQL(<T>EXEC spAfectar :tModulo, :nID, :tAccion, :tBase, :tGenerarMov, :tUsuario<T>, <T>OPORT<T>, Oportunidad:Oportunidad.ID, <T>AFECTAR<T>, <T>Todo<T>, Info.Base, Usuario)<BR>  Fin<BR><BR>  Si Info.Base = <T>POSFECHADO<T><BR>  Entonces<BR>   EjecutarSQL(<T>EXEC spOportunidadPosfechado :nID, :tFecha<T>, Oportunidad:Oportunidad.ID, FechaFormatoServidor(Info.Fecha))<BR>  Fin<BR>  Si Info.Base = <T>RECHAZADO<T>   <BR>  Entonces<BR>    EjecutarSQL(<T>EXEC spOportunidadRechazado :nID, :tCompetidor, :tMotivo<T>, Oportunidad:Oportunidad.ID, Info.OPORTCompetidor, Info.OPORTMotivo)<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Oportunidad:Oportunidad.Usuario) y((Oportunidad:Oportunidad.Estatus en (EstatusRevision, EstatusSinAfectar, EstatusPorConfirmar)) o<BR>((Oportunidad:Oportunidad.Estatus en(EstatusPendiente, EstatusPosfechado)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>OPORT<T>, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.Estatus, FormaSituacion, Usuario)))
EjecucionCondicion=ConDatos(Oportunidad:Oportunidad.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Oportunidad:Oportunidad.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>OPORT<T>, Oportunidad:Oportunidad.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>OPORT<T>, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.ID, Verdadero, Oportunidad:Oportunidad.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>Fin
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
ConCondicion=S
EjecucionConError=S

ActivoCondicion=Vacio(Oportunidad:Oportunidad.MovID) y (Oportunidad:Oportunidad.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Oportunidad:Oportunidad.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Oportunidad WHERE ID=:nID<T>, Oportunidad:Oportunidad.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
UsaTeclaRapida=S
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Oportunidad:Oportunidad.ID
Visible=S
TeclaRapida=Alt+F11

Expresion=ReportePantalla(ReporteMovPantalla(<T>OPORT<T>, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.Estatus), Oportunidad:Oportunidad.ID)
ActivoCondicion=Usuario.PreliminarMovs
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Oportunidad:Oportunidad.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>OPORT<T>, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.Estatus), Oportunidad:Oportunidad.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.Totalizar]
Nombre=Totalizar
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Totalizar
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Ultimo
Visible=S
Activo=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConfirmarAntes=S
DialogoMensaje=MovCancelar
Antes=S
RefrescarDespues=S
GuardarAntes=S

Expresion=Cancelar(<T>OPORT<T>, Oportunidad:Oportunidad.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Oportunidad<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Oportunidad:Oportunidad.Usuario) y ConDatos(Oportunidad:Oportunidad.ID) y ConDatos(Oportunidad:Oportunidad.MovID) y<BR>(Oportunidad:Oportunidad.Estatus en (EstatusRevision, EstatusSinAfectar, EstatusSincro, EstatusPorConfirmar, EstatusConcluido,EstatusPendiente, EstatusPosfechado, EstatusRechazado))
AntesExpresiones=Asigna( Afectar.Mov, Oportunidad:Oportunidad.Mov ) <BR> Asigna( Afectar.MovID, Oportunidad:Oportunidad.MovID )
[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
EspacioPrevio=S
ConCondicion=S

Expresion=Verificar(<T>OPORT<T>, Oportunidad:Oportunidad.ID,Oportunidad:Oportunidad.Mov,Oportunidad:Oportunidad.MovID)
ActivoCondicion=Oportunidad:Oportunidad.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Oportunidad:Oportunidad.Mov)
[Ficha.Oportunidad.TipoCambio]
Carpeta=Ficha
Clave=Oportunidad.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco

[Aplica.Oportunidad.MovAplica]
Carpeta=Aplica
Clave=Oportunidad.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Oportunidad.MovAplicaID]
Carpeta=Aplica
Clave=Oportunidad.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro


[Acciones.Localizar]
Nombre=Localizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F3
NombreDesplegar=L&ocalizar...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Localizar
Activo=S
Visible=S


[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posición del Movimiento
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S

Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(Oportunidad:Oportunidad.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)
[Aplica.Oportunidad.Agente]
Carpeta=Aplica
Clave=Oportunidad.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Agente.Nombre]
Carpeta=Aplica
Clave=Agente.Nombre
Editar=S
3D=S
Tamano=58
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12

GuardarAntes=S
DespuesGuardar=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>OPORT<T>, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>OPORT<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>OPORT<T>, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Oportunidad:Oportunidad.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.Estatus, Oportunidad:Oportunidad.Estatus)<BR>Asigna(Info.Situacion, Oportunidad:Oportunidad.Situacion)
[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ConCondicion=S
Antes=S
Visible=S

ActivoCondicion=ConfigModulo(<T>OPORT<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Oportunidad:Oportunidad.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)
[(Carpeta Abrir).Oportunidad.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Oportunidad.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=50

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(OportunidadA:Oportunidad.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.ID, OportunidadA:Oportunidad.ID)
Visible=S

[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Visible=S
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Visible=S
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.AbrirExcel]
Nombre=AbrirExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Acciones.AbrirCampos]
Nombre=AbrirCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ReasignarUsuario]
Nombre=ReasignarUsuario
Boton=0
Menu=&Archivo
NombreDesplegar=Reasignar &Usuario...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ReasignarUsuario
Antes=S

ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.Usuario, Oportunidad:Oportunidad.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Oportunidad:Oportunidad.ID)
[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
Activo=S
Visible=S
ClaveAccion=AnexoMov
Antes=S
EnBarraHerramientas=S
EspacioPrevio=S
DespuesGuardar=S

AntesExpresiones=Asigna(Info.Rama, <T>OPORT<T>)<BR>Asigna(Info.Fecha, Oportunidad:Oportunidad.FechaEmision)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Oportunidad:Oportunidad.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Oportunidad:Oportunidad.Mov+<T> <T>+Oportunidad:Oportunidad.MovID)
RefrescarDespues=S
[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(Oportunidad:Oportunidad.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)

[Acciones.Anterior]
Nombre=Anterior
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+,
NombreDesplegar=Anterior
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Anterior
Activo=S
Visible=S

[Acciones.Siguiente]
Nombre=Siguiente
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+.
NombreDesplegar=Siguiente
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Siguiente
Activo=S
Visible=S

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
Menu=&Archivo
NombreDesplegar=&Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Shift+F11

Expresion=CopiarMovimiento(<T>OPORT<T>, Oportunidad:Oportunidad.ID, <T>Oportunidad<T>)
[Acciones.AbrirLocalizar]
Nombre=AbrirLocalizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Acciones.AbrirLocalizarSiguiente]
Nombre=AbrirLocalizarSiguiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
Menu=&Edición
NombreDesplegar=&Campos...
EnMenu=S
TipoAccion=Formas
ClaveAccion=OportunidadCampos
Antes=S
RefrescarDespues=S

ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)
VisibleCondicion=Oportunidad:Oportunidad.Estatus<>EstatusSinAfectar
[Acciones.Sucursal]
Nombre=Sucursal
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+U
NombreDesplegar=<T>Sucursal<T>
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Sucursal Destino
Antes=S

ActivoCondicion=Usuario.ModificarSucursalDestino y (Oportunidad:Oportunidad.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
AntesExpresiones=Si(Vacio(Oportunidad:Oportunidad.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino
[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros4]
Nombre=Otros4
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros5]
Nombre=Otros5
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros8]
Nombre=Otros8
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Ficha.Oportunidad.UEN]
Carpeta=Ficha
Clave=Oportunidad.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco

[Acciones.ProyInfo]
Nombre=ProyInfo
Boton=0
Menu=&Ver
NombreDesplegar=Información del Proyecto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Oportunidad:Oportunidad.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, Oportunidad:Oportunidad.Proyecto)

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.Clave, <T>Oportunidad<T>+Oportunidad:Oportunidad.ID)<BR>Asigna(Info.Nombre, Oportunidad:Oportunidad.Mov+<T> <T>+Oportunidad:Oportunidad.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Oportunidad:Oportunidad.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
[Acciones.MovPersonal]
Nombre=MovPersonal
Boton=0
Menu=&Archivo
NombreDesplegar=P&ersonal Involucrado
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPersonal
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S

AntesExpresiones=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)<BR>Asigna(Info.Fecha, Oportunidad:Oportunidad.FechaEmision)<BR>Asigna(Info.Estatus, Oportunidad:Oportunidad.Estatus)
[Acciones.ComisionBorrador]
Nombre=ComisionBorrador
Boton=0
Menu=&Ver
NombreDesplegar=Origen de la Comisión...
EnMenu=S
Activo=S
TipoAccion=Formas
Antes=S
AntesExpresiones=Asigna(Info.ID, Oportunidad:Oportunidad.ID)
VisibleCondicion=Oportunidad:Oportunidad.Estatus=EstatusBorrador

[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+O
NombreDesplegar=P&olítica Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Oportunidad:Oportunidad.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>OPORT<T>)<BR>Asigna(Info.Clave, Oportunidad:Oportunidad.Mov)

[Acciones.PoliticaConcepto]
Nombre=PoliticaConcepto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+N
NombreDesplegar=Política Co&ncepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(Oportunidad:Oportunidad.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.Concepto, Oportunidad:Oportunidad.Concepto)
[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Forma, <T>Oportunidad<T>)<BR>Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.Nombre, Oportunidad:Oportunidad.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=0
Menu=&Edición
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
RefrescarDespues=S

Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>OPORT<T>, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.ID, Falso, Oportunidad:Oportunidad.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>Oportunidad<T>+Oportunidad:Oportunidad.ID)<BR>  Asigna(Info.Nombre, Oportunidad:Oportunidad.Mov+<T> <T>+Oportunidad:Oportunidad.MovID)<BR>  Asigna(Info.Modulo, <T>OPORT<T>)<BR>  Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Oportunidad:Oportunidad.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin
[Acciones.FormasAnexas]
Nombre=FormasAnexas
Boton=113
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F10
NombreDesplegar=Formas Anexas
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovFormaAnexo
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel y (Oportunidad:Oportunidad.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
Visible=S

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Características
Clave=FormaExtraValor
Filtros=S
OtroOrden=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraValor
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroAplicaEn=FormaExtraCampo.Grupo
FiltroPredefinido=S
FiltroAutoCampo=FormaExtraCampo.Grupo
FiltroAutoValidar=FormaExtraCampo.Grupo
FiltroAutoOrden=FormaExtraCampo.Orden
FiltroGrupo1=FormaExtraCampo.Grupo
FiltroValida1=FormaExtraCampo.Grupo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>OPORT<T>, <T>{Oportunidad:Oportunidad.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>Oportunidad{Oportunidad:Oportunidad.ID}<T>

[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Negro
ColorFondo=Plata
IgnoraFlujo=N

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Negro
ColorFondo=Blanco
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=370
VerValor=370

[Detalle.]
Carpeta=Detalle
ColorFondo=Negro

[(Carpeta Totalizadores).]
Carpeta=(Carpeta Totalizadores)
ColorFondo=Negro








[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)



[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122







[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S





































[Ficha.Oportunidad.Agente]
Carpeta=Ficha
Clave=Oportunidad.Agente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Lista.Columnas]
0=168
1=292






























Cliente=117
Nombre=293
RFC=107
Observacion=416
UEN=44
2=-2
Articulo=131
Descripcion1=244
Almacen=90
Grupo=100
Sucursal=46
3=-2
Motivo=239
4=-2
5=-2
[Ficha.Oportunidad.ContactoTipo]
Carpeta=Ficha
Clave=Oportunidad.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S


[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=41
ColorFondo=Blanco

Pegado=S


[Otros]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=Otros
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Oportunidad
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S




[Otros.Oportunidad.NivelInteres]
Carpeta=Otros
Clave=Oportunidad.NivelInteres
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=N
[Otros.Oportunidad.Intermediario]
Carpeta=Otros
Clave=Oportunidad.Intermediario
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[Otros.Oportunidad.Competidor]
Carpeta=Otros
Clave=Oportunidad.Competidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Otros.Oportunidad.Motivo]
Carpeta=Otros
Clave=Oportunidad.Motivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco















[InteresadoEn]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Interesado En
Clave=InteresadoEn
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadInteresadoEn
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Oportunidad
LlaveLocal=OportunidadInteresadoEn.ID
LlaveMaestra=Oportunidad.ID
HojaColoresPorTipo=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

ValidarCampos=S
ListaCamposAValidar=(Lista)
ControlRenglonTipo=S
CampoDespliegaTipo=Art.Tipo
CampoDespliegaTipoOpcion=Art.TipoOpcion
MenuLocal=S
PermiteEditar=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
ControlRenglonID=S
ControlRenglon=S
CampoRenglon=OportunidadInteresadoEn.Renglon
OtroOrden=S
ListaOrden=OportunidadInteresadoEn.Renglon<TAB>(Acendente)
[InteresadoEn.OportunidadInteresadoEn.Articulo]
Carpeta=InteresadoEn
Clave=OportunidadInteresadoEn.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[InteresadoEn.Columnas]
Articulo=101
Descripcion1=164


















Cantidad=64
SubCuenta=304
Precio=100
CantidadInventario=97
PrecioSugerido=75
Unidad=60
CompraRequerida=106
[Propuestas]
Estilo=Iconos
Pestana=S
Clave=Propuestas
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco




Vista=VentaA
PestanaOtroNombre=S
PestanaNombre=Propuestas
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
ListaEnCaptura=(Lista)
OtroOrden=S
Detalle=S
VistaMaestra=Oportunidad
LlaveLocal=Venta.IDOPORT
LlaveMaestra=Oportunidad.ID
ListaOrden=Venta.ID<TAB>(Acendente)
MenuLocal=S
ListaAcciones=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=VentaA:Venta.Mov+<T> <T>+VentaA:Venta.MovID
FiltroGeneral=Venta.IDOPORT IS NOT NULL
CondicionVisible=MovTipo(<T>OPORT<T>, Oportunidad:Oportunidad.Mov) noen(OPORT.SD)
[Competencia]
Estilo=Hoja
Pestana=S
Clave=Competencia
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
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
CarpetaVisible=S




Vista=OportunidadCompetencia
PestanaOtroNombre=S
PestanaNombre=Competencia
Detalle=S
PermiteEditar=S
VistaMaestra=Oportunidad
LlaveLocal=OportunidadCompetencia.ID
LlaveMaestra=Oportunidad.ID
ListaEnCaptura=(Lista)
CondicionEdicion=Oportunidad:Oportunidad.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente, EstatusPosfechado)
[Gestion]
Estilo=Iconos
Pestana=S
Clave=Gestion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S




Vista=GestionA
PestanaOtroNombre=S
PestanaNombre=Gestión
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
IconosSubTitulo=<T>Oportunidad<T>
ListaEnCaptura=(Lista)
Filtros=S
OtroOrden=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=(Lista)
RefrescarAlEntrar=S
IconosNombre=GestionA:Oportunidad.Mov+<T> <T>+GestionA:Oportunidad.MovID
FiltroGeneral=Gestion.OPORTID = {Oportunidad:Oportunidad.ID}
[Comentarios]
Estilo=Ficha
Pestana=S
Clave=Comentarios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Oportunidad
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Oportunidad.Comentarios
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Comentarios
AlinearTodaCarpeta=S
[Comentarios.Oportunidad.Comentarios]
Carpeta=Comentarios
Clave=Oportunidad.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ConScroll=N
SinRecapitular=N
Tamano=
ColorFondo=Blanco









































[Ficha.Oportunidad.Contacto]
Carpeta=Ficha
Clave=Oportunidad.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Competencia.OportunidadCompetencia.Competidor]
Carpeta=Competencia
Clave=OportunidadCompetencia.Competidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

EditarConBloqueo=S
[Competencia.OportunidadCompetencia.NivelInteres]
Carpeta=Competencia
Clave=OportunidadCompetencia.NivelInteres
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

EditarConBloqueo=S
[Competencia.OportunidadCompetencia.Moneda]
Carpeta=Competencia
Clave=OportunidadCompetencia.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

EditarConBloqueo=S
[Competencia.OportunidadCompetencia.ValorPropuesta]
Carpeta=Competencia
Clave=OportunidadCompetencia.ValorPropuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EditarConBloqueo=S
[Competencia.OportunidadCompetencia.Comentarios]
Carpeta=Competencia
Clave=OportunidadCompetencia.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=200
ColorFondo=Blanco




EditarConBloqueo=S
[Competencia.Columnas]
Competidor=147
NivelInteres=125
Moneda=63
ValorPropuesta=92
Comentarios=278








































[Ficha.Oportunidad.Plantilla]
Carpeta=Ficha
Clave=Oportunidad.Plantilla
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





Tamano=20







[(Carpeta Abrir).Oportunidad.Contacto]
Carpeta=(Carpeta Abrir)
Clave=Oportunidad.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).Cte.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
















[NivelInteres.Columnas]
NivelInteres=304































[Competidor.Columnas]
Competidor=304
























[DetalleEtapas.Columnas]
Etapa=106
Actividad=125
Titulo=312
PorcentajeAvance=102









[Acciones.AgregarPropuesta]
Nombre=AgregarPropuesta
Boton=20
Menu=&Archivo
NombreDesplegar=&Agregar Propuesta
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S


































GuardarAntes=S
































































Expresion=ProcesarSQL(<T>EXEC spOportunidadPropuestaAgregar :nID, :tUsuario, :nSucursal, :tPlantilla<T>, Oportunidad:Oportunidad.ID, Usuario, Sucursal, Oportunidad:Oportunidad.Plantilla)<BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=Oportunidad:Oportunidad.Estatus en(EstatusRevision) y(MovTipo(<T>OPORT<T>, Oportunidad:Oportunidad.Mov) en(OPORT.O))
[Propuestas.Columnas]
0=152




1=88
2=232
3=56
4=104
5=126

6=-2
[Propuestas.Venta.Cliente]
Carpeta=Propuestas
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Propuestas.Cte.Nombre]
Carpeta=Propuestas
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Propuestas.Venta.Almacen]
Carpeta=Propuestas
Clave=Venta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Propuestas.Venta.FechaEmision]
Carpeta=Propuestas
Clave=Venta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Propuestas.Venta.Importe]
Carpeta=Propuestas
Clave=Venta.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[Competidores.Columnas]
Orden=35
Competidor=237
Producto=148
Importe=88
Moneda=64
Situacion=99
Fecha=83
Observaciones=675

[FormaAnexo.Columnas]
0=121
1=48
2=-2

[MovEvento.Columnas]
0=455
1=70
2=-2
3=-2
4=-2

[MovImpuesto.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2

Impuesto1=64
Impuesto2=64
Impuesto3=72
Importe1=64
Importe2=64
Importe3=64
Retencion1=64
Retencion2=64
Retencion3=64
ContUso=124
ContUso2=124
ContUso3=124
[VentaFlexibleD.Columnas]
Cliente=93
Nombre=207
Articulo=64
Descripcion1=203
Cantidad=64
Precio=64
Importe=64

[Acciones.ConsultarPropuesta]
Nombre=ConsultarPropuesta
Boton=0
NombreDesplegar=&Consultar Propuesta
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S


Expresion=FormaPos(<T>Venta<T>, VentaA:Venta.ID)
EjecucionCondicion=ConDatos(VentaA:Venta.ID)
[DetalleEtapas.ListaEnCaptura]
(Inicio)=OportunidadD.Etapa
OportunidadD.Etapa=OportunidadD.Actividad
OportunidadD.Actividad=OportunidadD.Titulo
OportunidadD.Titulo=OportunidadD.PorcentajeAvance
OportunidadD.PorcentajeAvance=(Fin)




















[DetallePlantilla.Columnas]
Tipo=78
Clave=215
PorcentajeAvance=113

































[InteresadoEn.OportunidadInteresadoEn.Cantidad]
Carpeta=InteresadoEn
Clave=OportunidadInteresadoEn.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco












[Acciones.Asistente Articulos]
Nombre=Asistente Articulos
Boton=12
NombreDesplegar=Asistente Articulos
EnBarraHerramientas=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=OportunidadInteresadoEn:OportunidadInteresadoEn.Articulo<BR>Oportunidad:Oportunidad.Almacen<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.SubCuenta<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.Cantidad<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.Precio<BR>Falso<BR>Nulo<BR>Verdadero<BR>Nulo<BR>OportunidadInteresadoEn:Art.Descripcion1<BR>OportunidadInteresadoEn:Art.Tipo<BR>OportunidadInteresadoEn:Art.Unidad<BR>OportunidadInteresadoEn:Art.PrecioLista<BR>OportunidadInteresadoEn:Art.TipoOpcion<BR>OportunidadInteresadoEn:Art.Espacios<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.FechaRequerida<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.HoraRequerida<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.Espacio<BR><T>OPORT<T><BR>Oportunidad:Oportunidad.ID<BR>Oportunidad:Oportunidad.Contacto
ListaParametros=S
Visible=S







EspacioPrevio=S





















































































































































ActivoCondicion=Oportunidad:Oportunidad.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
[Ficha.Oportunidad.Almacen]
Carpeta=Ficha
Clave=Oportunidad.Almacen
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[InteresadoEn.OportunidadInteresadoEn.SubCuenta]
Carpeta=InteresadoEn
Clave=OportunidadInteresadoEn.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco










[Acciones.Cambiar Vista Hoja (Normal-Detalle-Resumen)]
Nombre=Cambiar Vista Hoja (Normal-Detalle-Resumen)
Boton=0
NombreDesplegar=Cambiar Vista Hoja (Normal-Detalle-Resumen)
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle-Resumen)
Activo=S
Visible=S







EspacioPrevio=S






































[Detalle.ColumnasResumen]
Articulo=143
Descripcion=238
Cantidad=62
Precio=100
DescuentoLinea=33
Importe=109
Almacen=57







[TipoImpuesto1.Columnas]
0=-2
1=88
2=277
3=-2














































[Acciones.Asistente Precios]
Nombre=Asistente Precios
Boton=0
NombreDesplegar=Asistente Precios
Carpeta=InteresadoEn
TipoAccion=Wizards
ClaveAccion=Asistente Precios
ListaParametros1=OportunidadInteresadoEn:OportunidadInteresadoEn.Articulo<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.SubCuenta<BR>OportunidadInteresadoEn:Art.Grupo<BR>OportunidadInteresadoEn:Art.Categoria<BR>OportunidadInteresadoEn:Art.Familia<BR>OportunidadInteresadoEn:Art.ABC<BR>OportunidadInteresadoEn:Art.Fabricante<BR>OportunidadInteresadoEn:Art.Linea<BR>OportunidadInteresadoEn:Art.Rama<BR>Oportunidad:Oportunidad.Contacto<BR>Oportunidad:Cte.Grupo<BR>Oportunidad:Cte.Categoria<BR>Oportunidad:Cte.Familia<BR>Oportunidad:Cte.Zona<BR>Oportunidad:Oportunidad.Moneda<BR>Oportunidad:Cte.Condicion<BR>Oportunidad:Oportunidad.Almacen<BR>Oportunidad:Oportunidad.Proyecto<BR>Oportunidad:Oportunidad.Agente<BR>Oportunidad:Cte.FormaEnvio<BR>Oportunidad:Oportunidad.Mov<BR>Oportunidad:Oportunidad.ServicioTipo<BR>Oportunidad:Oportunidad.ServicioContratoTipo<BR>OportunidadInteresadoEn:Art.Unidad<BR>Oportunidad:Oportunidad.Empresa<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.Cantidad<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.Unidad<BR>OportunidadInteresadoEn:Art.PrecioLista<BR>OportunidadInteresadoEn:Art.MonedaPrecio<BR>Oportunidad:Oportunidad.TipoCambio<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.DescuentoImporte<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.DescuentoLinea<BR>Oportunidad:Oportunidad.ListaPreciosEsp<BR>OportunidadInteresadoEn:Art.Precio2<BR>OportunidadInteresadoEn:Art.Precio3<BR>OportunidadInteresadoEn:Art.Precio4<BR>OportunidadInteresadoEn:Art.Precio5<BR>OportunidadInteresadoEn:Art.Precio6<BR>OportunidadInteresadoEn:Art.Precio7<BR>OportunidadInteresadoEn:Art.Precio8<BR>OportunidadInteresadoEn:Art.Precio9<BR>OportunidadInteresadoEn:Art.Precio10<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.Precio<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.PoliticaPrecios<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.PrecioMoneda<BR>OportunidadInteresadoEn:OportunidadInteresadoEn.PrecioTipoCambio<BR>Oportunidad:Cte.Grupo<BR>Oportunidad:Cte.Categoria<BR>Oportunidad:Cte.Familia
ListaParametros=S
Activo=S
Visible=S





















































































































































































































[InteresadoEn.OportunidadInteresadoEn.Precio]
Carpeta=InteresadoEn
Clave=OportunidadInteresadoEn.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[Ficha.Oportunidad.ListaPreciosEsp]
Carpeta=Ficha
Clave=Oportunidad.ListaPreciosEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





















[Acciones.Actualizar Politicas Precios y Descuentos]
Nombre=Actualizar Politicas Precios y Descuentos
Boton=0
NombreDesplegar=Actualizar Politicas Precios y Descuentos
TipoAccion=Otros
ClaveAccion=Actualizar Politicas Precios y Descuentos
Activo=S
Visible=S




































[InteresadoEn.OportunidadInteresadoEn.Unidad]
Carpeta=InteresadoEn
Clave=OportunidadInteresadoEn.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[InteresadoEn.OportunidadInteresadoEn.CantidadInventario]
Carpeta=InteresadoEn
Clave=OportunidadInteresadoEn.CantidadInventario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Gestion.Columnas]
ID=0
Empresa=45
FechaEmision=94
UltimoCambio=94
Usuario=64
Estatus=94
Sucursal=64
Comentarios=604
NivelInteres=304
Situacion=304
SituacionFecha=101
SituacionUsuario=101
SituacionNota=604
Moneda=64
ProbCierre=109
Propuesta=64
Competidor=304
Motivo=604
ContactoTipo=304
Mov=124
MovID=124
Proyecto=304
UEN=64
TipoCambio=77
Autorizacion=64
Referencia=304
Observaciones=604
Agente=64
Concepto=304
FechaConclusion=94
FechaCancelacion=94
Ejercicio=64
Periodo=64
OrigenTipo=64
Origen=124
OrigenID=124
Poliza=124
PolizaID=124
GenerarPoliza=70
ContID=64
FechaRegistro=94
Plantilla=124
ImporteAproximado=99
PorcentajeCierre=85
ImportePonderado=94
Intermediario=68
Contacto=64
SucursalOrigen=76
SucursalDestino=80
Almacen=64
RenglonID=64
ListaPreciosEsp=124
ServicioTipo=124
ServicioContratoTipo=124
Plantilla_1=124
Cliente=64
Nombre=184
Zona=304
Categoria=304
Familia=304
Grupo=304
EnviarA=145
FormaEnvio=304
Condicion=304
ListaPrecios=64
ListaPreciosEsp_1=124
Moneda_1=64
TipoCambio_1=64
Almacen_1=34
Nombre_1=124


























































0=117
1=98
2=81
3=312
4=-2


[Ficha.Oportunidad.Propuesta]
Carpeta=Ficha
Clave=Oportunidad.Propuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







EditarConBloqueo=S




[OportunidadPropuestaLista.Columnas]
0=159
1=224















































[DetalleGenerador.OportunidadD.Contacto]
Carpeta=DetalleGenerador
Clave=OportunidadD.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco







EditarConBloqueo=N
[DetalleGenerador.Columnas]
Contacto=125





















[DetallePlantilla.ListaEnCaptura]
(Inicio)=OportunidadD.Tipo
OportunidadD.Tipo=OportunidadD.Clave
OportunidadD.Clave=OportunidadD.PorcentajeAvance
OportunidadD.PorcentajeAvance=(Fin)



















[Detalle.ListaEnCaptura]
(Inicio)=OportunidadD.Tipo
OportunidadD.Tipo=OportunidadD.Contacto
OportunidadD.Contacto=OportunidadD.Clave
OportunidadD.Clave=OportunidadD.PorcentajeAvance
OportunidadD.PorcentajeAvance=OportunidadD.CantidadPendiente
OportunidadD.CantidadPendiente=OportunidadD.CantidadA
OportunidadD.CantidadA=(Fin)










[OPORT.G]
Estilo=Hoja
PestanaOtroNombre=S
Clave=OPORT.G
ValidarCampos=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=OportunidadD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Oportunidad
LlaveLocal=OportunidadD.ID
LlaveMaestra=Oportunidad.ID
ControlRenglonID=S
ControlRenglonTipo=S
HojaColoresPorTipo=S
CampoDespliegaTipo=OportunidadD.RenglonTipo
CampoDespliegaTipoOpcion=OportunidadD.RenglonTipo
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

ListaCamposAValidar=Cte.Nombre
ControlRenglon=S
CampoRenglon=OportunidadD.Renglon

Pestana=S
PestanaNombre=Contactos
OtroOrden=S
ListaOrden=OportunidadD.Renglon<TAB>(Acendente)
CondicionVisible=MovTipo(<T>OPORT<T>, Oportunidad:Oportunidad.Mov) en(OPORT.G) y(Oportunidad:Oportunidad.Estatus en(EstatusSinAfectar, EstatusCancelado, EstatusConcluido))
[OPORT.G.OportunidadD.Tipo]
Carpeta=OPORT.G
Clave=OportunidadD.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[OPORT.G.OportunidadD.Contacto]
Carpeta=OPORT.G
Clave=OportunidadD.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco













[OPORT.G.Columnas]
Tipo=67
Contacto=82

[Oportunidad.G2.Columnas]
Tipo=66
Contacto=72
CantidadPendiente=64
CantidadA=64










































[OPORT.O]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Actividades
Clave=OPORT.O
OtroOrden=S
ValidarCampos=S
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=OportunidadD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Oportunidad
LlaveLocal=OportunidadD.ID
LlaveMaestra=Oportunidad.ID
ControlRenglonTipo=S
HojaColoresPorTipo=S
CampoDespliegaTipo=OportunidadD.RenglonTipo
CampoDespliegaTipoOpcion=OportunidadD.RenglonTipo
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

ListaCamposAValidar=Recurso.Nombre

MenuLocal=S
ListaAcciones=(Lista)
RefrescarAlEntrar=S
CondicionVisible=MovTipo(<T>OPORT<T>, Oportunidad:Oportunidad.Mov) en(OPORT.O, OPORT.SD)
[OPORT.O.OportunidadD.Tipo]
Carpeta=OPORT.O
Clave=OportunidadD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[OPORT.O.OportunidadD.Clave]
Carpeta=OPORT.O
Clave=OportunidadD.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[OPORT.O.OportunidadD.Fecha]
Carpeta=OPORT.O
Clave=OportunidadD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10
EditarConBloqueo=N
[OPORT.O.OportunidadD.PorcentajeAvance]
Carpeta=OPORT.O
Clave=OportunidadD.PorcentajeAvance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EditarConBloqueo=N
[OPORT.O.OportunidadD.Recurso]
Carpeta=OPORT.O
Clave=OportunidadD.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




EditarConBloqueo=N
[OPORT.O.Columnas]
Tipo=103
Clave=143
Fecha=85
PorcentajeAvance=98
Recurso=66


MovGestion=119
Estado=124
IDGestion=64
FechaA=85
[Oportunidad.G2.ListaEnCaptura]
(Inicio)=OportunidadD.Tipo
OportunidadD.Tipo=OportunidadD.Contacto
OportunidadD.Contacto=OportunidadD.CantidadPendiente
OportunidadD.CantidadPendiente=OportunidadD.CantidadA
OportunidadD.CantidadA=(Fin)














[Acciones.ConsultarActividad]
Nombre=ConsultarActividad
Boton=0
NombreDesplegar=Consultar Actividad
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S

















GuardarAntes=S
Expresion=Si no(ConDatos(OportunidadD:OportunidadD.IDGestion))<BR>Entonces<BR>  Si Oportunidad:Oportunidad.Estatus en(EstatusConcluido, EstatusCancelado)<BR>  Entonces<BR>    Forma(<T>OportunidadDInfo<T>)<BR>  Sino<BR>    Forma(<T>OportunidadD<T>)<BR>  Fin<BR>Sino<BR>  FormaPos(<T>OportunidadGestion<T>, OportunidadD:OportunidadD.IDGestion)<BR>Fin<BR><BR>ActualizarVista<BR>ActualizarForma
AntesExpresiones=Asigna(Info.ID, OportunidadD:OportunidadD.ID)<BR>Asigna(Info.Renglon, OportunidadD:OportunidadD.Renglon)<BR>Asigna(Info.RenglonSub, OportunidadD:OportunidadD.RenglonSub)<BR>Asigna(Info.Tipo, OportunidadD:OportunidadD.Tipo)<BR>Asigna(Info.Clave, OportunidadD:OportunidadD.Clave)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)
VisibleCondicion=OportunidadD:OportunidadD.Tipo = <T>Actividad<T>
[Acciones.BitacoraActividad]
Nombre=BitacoraActividad
Boton=0
NombreDesplegar=Bitacora Actividad
EnMenu=S
TipoAccion=Formas
ClaveAccion=OportunidadDBitacora
Activo=S
Antes=S



GuardarAntes=S
AntesExpresiones=Asigna(Info.ID, OportunidadD:OportunidadD.ID)<BR>Asigna(Info.Renglon, OportunidadD:OportunidadD.Renglon)<BR>Asigna(Info.RenglonSub, OportunidadD:OportunidadD.RenglonSub)<BR>Asigna(Info.Tipo, OportunidadD:OportunidadD.Tipo)<BR>Asigna(Info.Clave, OportunidadD:OportunidadD.Clave)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)
VisibleCondicion=OportunidadD:OportunidadD.Tipo = <T>Actividad<T>
[Otros.ListaEnCaptura]
(Inicio)=Oportunidad.NivelInteres
Oportunidad.NivelInteres=Oportunidad.Intermediario
Oportunidad.Intermediario=Oportunidad.PosfechadoHasta
Oportunidad.PosfechadoHasta=Oportunidad.Competidor
Oportunidad.Competidor=Oportunidad.Motivo
Oportunidad.Motivo=(Fin)

[Otros.Oportunidad.PosfechadoHasta]
Carpeta=Otros
Clave=Oportunidad.PosfechadoHasta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco


[Acciones.Gestion]
Nombre=Gestion
Boton=0
NombreDesplegar=Enviar a Gestión
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S


















GuardarAntes=S
Expresion=ProcesarSQL(<T>EXEC spOportunidadGestionGenerar :nID, :tMov, :tMovID, :tEmpresa, :nSucursal, :tUsuario, :tProyecto, :nUEN, :tObservaciones, :nRID, :tTipo, :tClave, :nPorcentajeAvance, :tComentarios, :tFecha, :tFechaA, :tRecurso, :nIDGestion<T>,Oportunidad:Oportunidad.ID, Oportunidad:Oportunidad.Mov, Oportunidad:Oportunidad.MovID, Empresa, Sucursal, Usuario, Oportunidad:Oportunidad.Proyecto, Oportunidad:Oportunidad.UEN, Oportunidad:Oportunidad.Observaciones,OportunidadD:OportunidadD.RID,OportunidadD:OportunidadD.Tipo,OportunidadD:OportunidadD.Clave,OportunidadD:OportunidadD.PorcentajeAvance,OportunidadD:OportunidadD.Comentarios,FechaFormatoServidor(OportunidadD:OportunidadD.Fecha),FechaFormatoServidor(OportunidadD:OportunidadD.FechaA),OportunidadD:OportunidadD.Recurso, OportunidadD:OportunidadD.IDGestion)<BR><BR>Asigna(Info.ID, SQL(<T>SELECT IDGestion FROM OportunidadD WHERE ID = :nID AND Renglon = :nRenglon AND RenglonSub = :nRenglonSub<T>, OportunidadD:OportunidadD.ID, OportunidadD:OportunidadD.Renglon, OportunidadD:OportunidadD.RenglonSub))<BR>FormaPos(<T>OportunidadGestion<T>, Info.ID)<BR>ActualizarVista<BR>ActualizarForma
VisibleCondicion=General.GES y(OportunidadD:OportunidadD.Tipo = <T>Actividad<T>) y(Oportunidad:Oportunidad.Estatus en(EstatusRevision, EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente, EstatusPosfechado))
[OPORT.O.MovGestion]
Carpeta=OPORT.O
Clave=MovGestion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco














[Agenda.Columnas]
Mov=106
MovID=65
Orden=35
Avance=55
EstatusNombre=84
Asunto=108
FechaA=80
Duracion=49
Espacio=64
Estado=69
Situacion=75

[Para.Columnas]
Usuario=96
Nombre=307
Participacion=78
Respuesta=147
FechaRegistro=113

[Recursos.Columnas]
Recurso=64
Nombre=163
Fecha=73
HoraD=57
HoraA=53
Cantidad=64
Costo=55
CostoTotal=68
Referencia=141

[Bitacora.Columnas]
0=85
1=85
2=-2
3=-2
4=-2
5=-2

[SubMovimientos.Columnas]
0=180
1=93
2=214
3=208
4=-2

[MAFIndicador.Columnas]
Indicador=304
Referencia=201
LecturaAnterior=124




























[Gestion.Gestion.FechaEmision]
Carpeta=Gestion
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Acciones.GestionPreliminar]
Nombre=GestionPreliminar
Boton=0
NombreDesplegar=Presentación Preliminar
EnMenu=S
Carpeta=Gestion
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

EspacioPrevio=S
[Acciones.GestionImprimir]
Nombre=GestionImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=Gestion
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.GestionMostrarCampos]
Nombre=GestionMostrarCampos
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=Gestion
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S









EspacioPrevio=S
[Acciones.GestionConsultar]
Nombre=GestionConsultar
Boton=0
NombreDesplegar=Consultar en Gestión
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S
Expresion=FormaPos(<T>Gestion<T>, GestionA:Gestion.ID)










[Gestion.Gestion.Asunto]
Carpeta=Gestion
Clave=Gestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Gestion.Gestion.Avance]
Carpeta=Gestion
Clave=Gestion.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




































































































[Acciones.Autorizar]
Nombre=Autorizar
Boton=0
Menu=&Archivo
NombreDesplegar=A&utorizar
EnMenu=S
TipoAccion=Formas
Antes=S
RefrescarDespues=S
ClaveAccion=MovAutorizar
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Alt+F12








































































ActivoCondicion=Vacio(Oportunidad:Oportunidad.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Oportunidad<T>)<BR>Asigna(Afectar.Modulo, <T>OPORT<T>)<BR>Asigna(Afectar.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Afectar.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Afectar.MovID, Oportunidad:Oportunidad.MovID)<BR>Asigna(Info.Descripcion, Oportunidad:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(Oportunidad:Oportunidad.Mensaje)

[Acciones.ActualizarVista]
Nombre=ActualizarVista
Boton=0
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=ActualizarVista
[Acciones.EliminarActividad]
Nombre=EliminarActividad
Boton=0
NombreDesplegar=Eliminar Actividad
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
ConfirmarAntes=S








Expresion=ProcesarSQL(<T>EXEC spOportunidadActividadEliminar :nID, :nRenglon, :nRenglonSub, :nIDGestion, :tTipo, :tClave, :nPorcentaje<T>, OportunidadD:OportunidadD.ID, OportunidadD:OportunidadD.Renglon, OportunidadD:OportunidadD.RenglonSub, OportunidadD:OportunidadD.IDGestion, OportunidadD:OportunidadD.Tipo, OportunidadD:OportunidadD.Clave, OportunidadD:OportunidadD.PorcentajeAvance)<BR><BR>ActualizarVista<BR>ActualizarForma
AntesExpresiones=Asigna(Info.ID, OportunidadD:OportunidadD.ID)<BR>Asigna(Info.Renglon, OportunidadD:OportunidadD.Renglon)<BR>Asigna(Info.RenglonSub, OportunidadD:OportunidadD.RenglonSub)<BR>Asigna(Info.Tipo, OportunidadD:OportunidadD.Tipo)<BR>Asigna(Info.Clave, OportunidadD:OportunidadD.Clave)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)
VisibleCondicion=Oportunidad:Oportunidad.Estatus en(EstatusRevision, EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente, EstatusPosfechado)
[Acciones.PropuesaPreliminar]
Nombre=PropuesaPreliminar
Boton=0
NombreDesplegar=Presentación Preliminar
EnMenu=S
Carpeta=Propuestas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

EspacioPrevio=S
[Acciones.PropuestaImprimir]
Nombre=PropuestaImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=Propuestas
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.PropuestaCampos]
Nombre=PropuestaCampos
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=Propuestas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

EspacioPrevio=S







[(Carpeta Totalizadores).Importe Oportunidad]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Oportunidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata

























[(Carpeta Abrir).Oportunidad.ImporteOportunidad]
Carpeta=(Carpeta Abrir)
Clave=Oportunidad.ImporteOportunidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









[OPORT.O.OportunidadD.Estado]
Carpeta=OPORT.O
Clave=OportunidadD.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco











EditarConBloqueo=N



[OPORT.O.OportunidadD.FechaA]
Carpeta=OPORT.O
Clave=OportunidadD.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



















[Ficha.Avance]
Carpeta=Ficha
Clave=Avance
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata





Pegado=S




Tamano=8








Efectos=[Negritas]
[(Carpeta Totalizadores).Avance]
Carpeta=(Carpeta Totalizadores)
Clave=Avance
Editar=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata




Pegado=S



[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe Oportunidad
Importe Oportunidad=Avance
Avance=(Fin)












[Acciones.eMail]
Nombre=eMail
Boton=84
NombreEnBoton=S
NombreDesplegar=Enviar Correo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
Visible=S




















































GuardarAntes=S
Antes=S
DespuesGuardar=S









ClaveAccion=OportunidadeMailEnviar




















































































































































ActivoCondicion=Oportunidad:Oportunidad.Estatus en (EstatusRevision, EstatusSincro, EstatusPorConfirmar, EstatusConcluido, EstatusPendiente, EstatusPosfechado, EstatusRechazado)
AntesExpresiones=Asigna(Info.ID, Oportunidad:Oportunidad.ID)<BR>Asigna(Info.OPORTPlantillaeMail, Oportunidad:OportunidadPlantilla.PlantillaeMail)<BR>Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)
[OPORT.G.ListaEnCaptura]
(Inicio)=OportunidadD.Tipo
OportunidadD.Tipo=OportunidadD.Contacto
OportunidadD.Contacto=(Fin)


















































































[OPORT.G2]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contactos
Clave=OPORT.G2
OtroOrden=S
ValidarCampos=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=OportunidadD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Oportunidad
LlaveLocal=OportunidadD.ID
LlaveMaestra=Oportunidad.ID
ControlRenglonTipo=S
HojaColoresPorTipo=S
CampoDespliegaTipo=OportunidadD.RenglonTipo
CampoDespliegaTipoOpcion=OportunidadD.RenglonTipo
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

ListaCamposAValidar=Cte.Nombre
ListaOrden=OportunidadD.Renglon<TAB>(Acendente)
CondicionVisible=MovTipo(<T>OPORT<T>, Oportunidad:Oportunidad.Mov) en(OPORT.G) y(Oportunidad:Oportunidad.Estatus en(EstatusPendiente))
ControlRenglon=S
CampoRenglon=OportunidadD.Renglon
[OPORT.G2.ListaEnCaptura]
(Inicio)=OportunidadD.Tipo
OportunidadD.Tipo=OportunidadD.Contacto
OportunidadD.Contacto=OportunidadD.CantidadPendiente
OportunidadD.CantidadPendiente=OportunidadD.CantidadA
OportunidadD.CantidadA=(Fin)

[OPORT.G2.OportunidadD.Tipo]
Carpeta=OPORT.G2
Clave=OportunidadD.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[OPORT.G2.OportunidadD.Contacto]
Carpeta=OPORT.G2
Clave=OportunidadD.Contacto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[OPORT.G2.OportunidadD.CantidadPendiente]
Carpeta=OPORT.G2
Clave=OportunidadD.CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00004080
Efectos=[Negritas]

[OPORT.G2.OportunidadD.CantidadA]
Carpeta=OPORT.G2
Clave=OportunidadD.CantidadA
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[OPORT.G2.Columnas]
Tipo=70
Contacto=85
CantidadPendiente=74
CantidadA=64




























[Ficha.ListaEnCaptura]
(Inicio)=Oportunidad.Mov
Oportunidad.Mov=Oportunidad.MovID
Oportunidad.MovID=Oportunidad.Proyecto
Oportunidad.Proyecto=Oportunidad.UEN
Oportunidad.UEN=Oportunidad.Moneda
Oportunidad.Moneda=Oportunidad.TipoCambio
Oportunidad.TipoCambio=Oportunidad.FechaEmision
Oportunidad.FechaEmision=Oportunidad.ListaPreciosEsp
Oportunidad.ListaPreciosEsp=Avance
Avance=Oportunidad.Concepto
Oportunidad.Concepto=Oportunidad.Agente
Oportunidad.Agente=Oportunidad.Referencia
Oportunidad.Referencia=Oportunidad.Plantilla
Oportunidad.Plantilla=Oportunidad.Observaciones
Oportunidad.Observaciones=Oportunidad.Almacen
Oportunidad.Almacen=Oportunidad.ContactoTipo
Oportunidad.ContactoTipo=Oportunidad.Contacto
Oportunidad.Contacto=Cte.Nombre
Cte.Nombre=Oportunidad.Propuesta
Oportunidad.Propuesta=(Fin)





























































































































































































































































































[Gestion.MovNombre]
Carpeta=Gestion
Clave=MovNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

















[Gestion.ListaEnCaptura]
(Inicio)=MovNombre
MovNombre=Gestion.FechaEmision
Gestion.FechaEmision=Gestion.Asunto
Gestion.Asunto=Gestion.Avance
Gestion.Avance=(Fin)

[Gestion.ListaAcciones]
(Inicio)=GestionConsultar
GestionConsultar=GestionPreliminar
GestionPreliminar=GestionImprimir
GestionImprimir=GestionMostrarCampos
GestionMostrarCampos=(Fin)






























































































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Oportunidad.FechaEmision
Oportunidad.FechaEmision=Oportunidad.Contacto
Oportunidad.Contacto=Cte.Nombre
Cte.Nombre=Oportunidad.ImporteOportunidad
Oportunidad.ImporteOportunidad=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=POSFECHADO
POSFECHADO=RECHAZADO
RECHAZADO=REVISION
REVISION=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)
















































[Competencia.ListaEnCaptura]
(Inicio)=OportunidadCompetencia.Competidor
OportunidadCompetencia.Competidor=OportunidadCompetencia.NivelInteres
OportunidadCompetencia.NivelInteres=OportunidadCompetencia.Moneda
OportunidadCompetencia.Moneda=OportunidadCompetencia.ValorPropuesta
OportunidadCompetencia.ValorPropuesta=OportunidadCompetencia.Comentarios
OportunidadCompetencia.Comentarios=(Fin)




































[InteresadoEn.OportunidadInteresadoEn.CompraRequerida]
Carpeta=InteresadoEn
Clave=OportunidadInteresadoEn.CompraRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]















































[OPORT.O.ListaEnCaptura]
(Inicio)=OportunidadD.Tipo
OportunidadD.Tipo=OportunidadD.Clave
OportunidadD.Clave=OportunidadD.Fecha
OportunidadD.Fecha=OportunidadD.FechaA
OportunidadD.FechaA=OportunidadD.PorcentajeAvance
OportunidadD.PorcentajeAvance=OportunidadD.Estado
OportunidadD.Estado=OportunidadD.Recurso
OportunidadD.Recurso=MovGestion
MovGestion=(Fin)

[OPORT.O.ListaAcciones]
(Inicio)=ConsultarActividad
ConsultarActividad=BitacoraActividad
BitacoraActividad=EliminarActividad
EliminarActividad=Gestion
Gestion=(Fin)








[Acciones.AgregarPlanPreliminar]
Nombre=AgregarPlanPreliminar
Boton=35
NombreDesplegar=&Agregar Plan Preliminar
EnBarraHerramientas=S
EnMenu=S
Visible=S







Menu=&Archivo
EspacioPrevio=S






TipoAccion=Expresion









































Expresion=ProcesarSQL(<T>EXEC spOportunidadPlanPreliminarAgregar :nID, :tUsuario, :nSucursal, :tPlantilla, :tEmpresa<T>, Oportunidad:Oportunidad.ID, Usuario, Sucursal, Oportunidad:Oportunidad.Plantilla, Empresa)<BR>Forma.ActualizarVista(<T>OportunidadPlanPreliminar<T>)   <BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=Oportunidad:Oportunidad.Estatus en(EstatusRevision) y(MovTipo(<T>OPORT<T>, Oportunidad:Oportunidad.Mov) en(OPORT.SD))
[PlanPreliminar.Mov]
Carpeta=PlanPreliminar
Clave=Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PlanPreliminar.MovID]
Carpeta=PlanPreliminar
Clave=MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[PlanPreliminar.Columnas]
0=227
1=-2

Mov=124
MovID=124




ID=64
Empresa=45
2=-2
3=-2
4=-2
5=-2
[PlanPreliminar]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Plan Preliminar
Clave=PlanPreliminar
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadPlanPreliminar
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco


IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General





MenuLocal=S
ListaAcciones=(Lista)
ExpAntesRefrescar=Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)
RefrescarAlEntrar=S
ExpAlRefrescar=Asigna(Info.Mov, Oportunidad:Oportunidad.Mov)<BR>Asigna(Info.MovID, Oportunidad:Oportunidad.MovID)

ListaEnCaptura=(Lista)
IconosNombre=OportunidadPlanPreliminar:Proyecto.Mov+<T> <T>+OportunidadPlanPreliminar:Proyecto.MovID
FiltroGeneral=Proyecto.OrigenTipo=<T>OPORT<T><BR>AND Proyecto.Origen=<T>{Info.Mov}<T><BR>AND Proyecto.OrigenID=<T>{Info.MovID}<T>
CondicionVisible=MovTipo(<T>OPORT<T>, Oportunidad:Oportunidad.Mov) en(OPORT.SD)
[Soporte.Columnas]
0=95
1=180
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2

[Acciones.Consultar]
Nombre=Consultar
Boton=0
NombreDesplegar=&Plan Preliminar
EnMenu=S
TipoAccion=Expresion
Expresion=FormaPos(<T>Proyecto<T>, OportunidadPlanPreliminar:Proyecto.ID)
Activo=S
Visible=S






















































[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
NombreDesplegar=&Actualizar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=ActualizarVista







[InteresadoEn.ListaEnCaptura]
(Inicio)=OportunidadInteresadoEn.Articulo
OportunidadInteresadoEn.Articulo=OportunidadInteresadoEn.SubCuenta
OportunidadInteresadoEn.SubCuenta=OportunidadInteresadoEn.Cantidad
OportunidadInteresadoEn.Cantidad=OportunidadInteresadoEn.Precio
OportunidadInteresadoEn.Precio=OportunidadInteresadoEn.Unidad
OportunidadInteresadoEn.Unidad=OportunidadInteresadoEn.CantidadInventario
OportunidadInteresadoEn.CantidadInventario=OportunidadInteresadoEn.CompraRequerida
OportunidadInteresadoEn.CompraRequerida=(Fin)

[InteresadoEn.ListaCamposAValidar]
(Inicio)=Art.Tipo
Art.Tipo=Art.Unidad
Art.Unidad=Art.PrecioLista
Art.PrecioLista=Art.Descripcion1
Art.Descripcion1=(Fin)














































[PlanPreliminar.Proyecto.FechaEmision]
Carpeta=PlanPreliminar
Clave=Proyecto.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[PlanPreliminar.Proyecto.ContactoTipo]
Carpeta=PlanPreliminar
Clave=Proyecto.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco











[PlanPreliminar.ListaEnCaptura]
(Inicio)=Proyecto.FechaEmision
Proyecto.FechaEmision=Proyecto.ContactoTipo
Proyecto.ContactoTipo=(Fin)

[PlanPreliminar.ListaAcciones]
(Inicio)=Consultar
Consultar=Actualizar
Actualizar=(Fin)




















































[Propuestas.ListaEnCaptura]
(Inicio)=Venta.Cliente
Venta.Cliente=Cte.Nombre
Cte.Nombre=Venta.Almacen
Venta.Almacen=Venta.FechaEmision
Venta.FechaEmision=Venta.Importe
Venta.Importe=(Fin)

[Propuestas.ListaAcciones]
(Inicio)=ConsultarPropuesta
ConsultarPropuesta=PropuesaPreliminar
PropuesaPreliminar=PropuestaImprimir
PropuestaImprimir=PropuestaCampos
PropuestaCampos=ActualizarVista
ActualizarVista=(Fin)












































































[Antecedentes.Columnas]
Aplica=124
AplicaID=65
Importe=118
Saldo=114
Vencimiento=86
















[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Otros
Otros=InteresadoEn
InteresadoEn=Propuestas
Propuestas=PlanPreliminar
PlanPreliminar=Competencia
Competencia=Gestion
Gestion=Comentarios
Comentarios=FormaExtraValor
FormaExtraValor=OPORT.G
OPORT.G=OPORT.G2
OPORT.G2=OPORT.O
OPORT.O=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=MovPersonal
MovPersonal=Evaluaciones
Evaluaciones=Propiedades
Propiedades=Imprimir
Imprimir=RepPantalla
RepPantalla=PlantillasOffice
PlantillasOffice=FormasAnexas
FormasAnexas=Excel
Excel=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Afectar
Afectar=Autorizar
Autorizar=Eliminar
Eliminar=Cancelar
Cancelar=Cambiar Vista Hoja (Normal-Detalle-Resumen)
Cambiar Vista Hoja (Normal-Detalle-Resumen)=Asistente Articulos
Asistente Articulos=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=Anterior
Anterior=Siguiente
Siguiente=Anexos
Anexos=ProyInfo
ProyInfo=ComisionBorrador
ComisionBorrador=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
MovPos=AgregarPropuesta
AgregarPropuesta=AgregarPlanPreliminar
AgregarPlanPreliminar=eMail
eMail=Navegador
Navegador=Asistente Precios
Asistente Precios=Actualizar Politicas Precios y Descuentos
Actualizar Politicas Precios y Descuentos=Cerrar
Cerrar=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
