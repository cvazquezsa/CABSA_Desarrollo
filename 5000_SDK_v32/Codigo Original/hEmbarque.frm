[Forma]
Clave=hEmbarque
Nombre=hEmbarques
Icono=0
Modulos=hEmbarque
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=1933
PosicionInicialArriba=0
PosicionInicialAltura=549
PosicionInicialAncho=774
PosicionSeccion1=47
PosicionSeccion2=92
Menus=S
BarraHerramientas=S
BarraAyuda=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)
ExpresionesAlCerrar=
EsMovimiento=S
Movimientos=
PosicionColumna3=50
BarraAyudaBold=S
MovTipo=Todos
VentanaBloquearAjuste=N
VentanaAjustarZonas=
TituloAuto=S
MovModulo=EMB
Totalizadores=S
DialogoAbrir=S
PosicionInicialAlturaCliente=511
PosicionSec1=219
PosicionSec2=429

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarEmbarqueeoRegistros=S
Zona=A1
Vista=hEmbarque
Fuente={MS Sans Serif, 8, Negro, []}
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.hEmbarque.Mov]
Carpeta=Ficha
Clave=hEmbarque.Mov
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hEmbarque.MovID]
Carpeta=Ficha
Clave=hEmbarque.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=$00400040
Pegado=S
IgnoraFlujo=S

[Ficha.hEmbarque.Proyecto]
Carpeta=Ficha
Clave=hEmbarque.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
Pegado=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hEmbarque.Concepto]
Carpeta=Ficha
Clave=hEmbarque.Concepto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hEmbarque.FechaEmision]
Carpeta=Ficha
Clave=hEmbarque.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hEmbarque.Referencia]
Carpeta=Ficha
Clave=hEmbarque.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=21
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hEmbarque.Observaciones]
Carpeta=Ficha
Clave=hEmbarque.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=59
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Hoja
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarEmbarqueeoRegistros=S
Zona=B1
Vista=hEmbarqueD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Detalle=S
VistaMaestra=hEmbarque
LlaveLocal=hEmbarqueD.ID
LlaveMaestra=hEmbarque.ID
EmbarquerolRenglon=S
HojaSubCta=Si
HojaSubNS=Si
OtroOrden=S
ListaOrden=hEmbarqueD.Orden<TAB>(Acendente)
EmbarquerolRenglonID=
EmbarquerolRenglonTipo=
HojaColoresPorTipo=S
CampoDespliegaTipo=Art.Tipo
VistaOmision=Resumén
HojaVistaOmision=Automática
HojaFondoGrisAuto=S
PermiteLocalizar=S
PermiteEditar=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
HojaAjustarColumnas=S
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

FiltroGeneral=hEmbarqueD.DesembarqueParcial=0
[Detalle.Columnas]
Cantidad=66
Articulo=110
SubCuenta=107
Costo=71
Importe=86
CantidadPendiente=57
CantidadA=64
Disponible=63
Estatus=110
Renglon=64
RenglonID=64
RenglonTipo=54
DisponibleCuenta=75
Cuenta=114
Concepto=141
Debe=119
Haber=105
Descripcion=177
Accion=49
Mov=76
MovID=67
NombreEnvio=118
Ruta=77
Zona=82
Peso=48
Volumen=49
ImporteTotal=88
Movimiento=91
Observaciones=143
Orden=35
EmbarqueMov=71
Paquetes=50
Entregado=55
FechaEntrega=77
PersonaEntrega=90
PersonaEntregaID=70
Cobrado=64
FormaCobro=73
ImporteCobrado=92
Referencia=85
Fecha=77
Persona=73
PersonaID=69
Forma=55
Estado=71
FechaHora=83
Paquetes_1=64
Causa=255
CxcSaldo=77
MovPorcentaje=25
ImporteEmbarque=93
UEN=24

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarEmbarqueeoRegistros=S
Zona=C1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Peso Disp<BR>Volumen Disp<BR>Importe Total<BR>Paquetes<BR>Total Cobrado<BR>Total Embarque
Totalizadores2=hEmbarque:Vehiculo.Peso-Suma(hEmbarqueD:EmbarqueMov.Peso)<BR>hEmbarque:Vehiculo.Volumen-Suma(hEmbarqueD:EmbarqueMov.Volumen)<BR>Suma(hEmbarqueD:ImporteTotal*hEmbarqueD:EmbarqueMov.TipoCambio)<BR>Suma(hEmbarqueD:hEmbarqueD.Paquetes)<BR>Suma(hEmbarqueD:hEmbarqueD.Importe)<BR>Suma(hEmbarqueD:ImporteEmbarque*hEmbarqueD:EmbarqueMov.TipoCambio)
Totalizadores3=#,.##<BR>#,.##<BR>(Monetario)<BR>#,<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
Visible=S
Activo=S
ClaveAccion=Documento Nuevo

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

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=S
Activo=S
ConCondicion=S
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(hEmbarque:hEmbarque.ID) y (hEmbarque:hEmbarque.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, hEmbarque:hEmbarque.ID, <T>EMB<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarEmbarqueeoRegistros=S
Vista=hEmbarqueA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
OtroOrden=S
ListaEnCaptura=(Lista)
ListaOrden=hEmbarque.ID<TAB>(Decendente)
PestanaOtroNombre=S
PestanaNombre=Embarques
BusquedaRapidaEmbarqueroles=S
BusquedaAvanzada=
BusquedaRespetarEmbarquerolesNum=S
FiltroMovDef=Devolucion Interna
IconosConPaginas=S
MenuLocal=S
IconosSeleccionUnitaria=S
ListaAcciones=(Lista)
PermiteLocalizar=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasCampo=hEmbarque.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroUsuarios=S
FiltroUsuarioDefault=(Usuario)
FiltroFechasCancelacion=hEmbarque.FechaCancelacion
FiltroSucursales=S

IconosNombre=hEmbarqueA:hEmbarque.Mov+<T> <T>+hEmbarqueA:hEmbarque.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=130
1=98

2=-2
3=-2
4=-2
5=-2
6=-2
[(Carpeta Abrir).hEmbarque.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=hEmbarque.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

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

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=<T>E&liminar<T>
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
Visible=S
ClaveAccion=Documento Eliminar
ConCondicion=S
ActivoCondicion=Vacio(hEmbarque:hEmbarque.MovID) y (hEmbarque:hEmbarque.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, hEmbarque:hEmbarque.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM hEmbarque WHERE ID=:nID<T>, hEmbarque:hEmbarque.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
NombreDesplegar=<T>A&fectar<T>
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=F12
GuardarAntes=S
RefrescarDespues=S
ConCondicion=S
EjecucionConError=S
Antes=S
DespuesGuardar=S

Expresion=Afectar(<T>EMB<T>, hEmbarque:hEmbarque.ID, hEmbarque:hEmbarque.Mov, hEmbarque:hEmbarque.MovID, <T>Todo<T>, <T><T>, <T>hEmbarque<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hEmbarque:hEmbarque.Usuario) y<BR>((hEmbarque:hEmbarque.Estatus=EstatusSinAfectar) o (hEmbarque:hEmbarque.Estatus=EstatusPendiente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>EMB<T>, hEmbarque:hEmbarque.Mov, hEmbarque:hEmbarque.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(hEmbarque:hEmbarque.Vehiculo) y ConDatos(hEmbarque:hEmbarque.Mov)
EjecucionMensaje=Si(Vacio(hEmbarque:hEmbarque.Vehiculo), <T>Falta Especificar el Vehículo<T>,<T>Falta Especificar el Movimiento<T>)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (hEmbarque:hEmbarque.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>EMB<T>, hEmbarque:hEmbarque.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>EMB<T>, hEmbarque:hEmbarque.Mov, hEmbarque:hEmbarque.ID, Verdadero, hEmbarque:hEmbarque.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentación preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=hEmbarque:hEmbarque.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>EMB<T>, hEmbarque:hEmbarque.Mov, hEmbarque:hEmbarque.Estatus), hEmbarque:hEmbarque.ID)
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
NombreDesplegar=&Imprimir...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=hEmbarque:hEmbarque.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
EspacioPrevio=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>EMB<T>, hEmbarque:hEmbarque.Mov, hEmbarque:hEmbarque.Estatus), hEmbarque:hEmbarque.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Detalle.ColumnasResumen]
Articulo=117
Descripcion1=223
Cantidad=68
Costo=67
Importe=76
Pendiente=56
Cuenta=132
Descripcion=222
Debe=101
Haber=93

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnMenu=S
TipoAccion=Expresion
Visible=S
ConfirmarAntes=S
DialogoMensaje=MovCancelar
EnBarraHerramientas=S
Antes=S
RefrescarDespues=S
GuardarAntes=S
Expresion=Cancelar(<T>EMB<T>, hEmbarque:hEmbarque.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>hEmbarque<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, hEmbarque:hEmbarque.Usuario) y ConDatos(hEmbarque:hEmbarque.ID) y ConDatos(hEmbarque:hEmbarque.MovID) y<BR>(hEmbarque:hEmbarque.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPendiente, EstatusConcluido))
AntesExpresiones=Asigna(Afectar.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Afectar.MovID, hEmbarque:hEmbarque.MovID)

[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
GuardarAntes=S
ConCondicion=S
EjecucionConError=S
Expresion=Verificar(<T>EMB<T>, hEmbarque:hEmbarque.ID, hEmbarque:hEmbarque.Mov, hEmbarque:hEmbarque.MovID)
ActivoCondicion=hEmbarque:hEmbarque.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(hEmbarque:hEmbarque.Vehiculo)
EjecucionMensaje=<T>Falta Especificar el Vehículo<T>

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
ActivoCondicion=ConDatos(hEmbarque:hEmbarque.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID, hEmbarque:hEmbarque.MovID)
[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S

GuardarAntes=S
DespuesGuardar=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>EMB<T>, hEmbarque:hEmbarque.Mov, hEmbarque:hEmbarque.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>EMB<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>EMB<T>, hEmbarque:hEmbarque.Mov, hEmbarque:hEmbarque.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(hEmbarque:hEmbarque.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.Estatus, hEmbarque:hEmbarque.Estatus)<BR>Asigna(Info.Situacion, hEmbarque:hEmbarque.Situacion)
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
ActivoCondicion=ConfigModulo(<T>EMB<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(hEmbarque:hEmbarque.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID, hEmbarque:hEmbarque.MovID)

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(hEmbarqueA:hEmbarque.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarqueA:hEmbarque.ID)

[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Visible=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Visible=S
Carpeta=(Carpeta Abrir)
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.AbrirExcel]
Nombre=AbrirExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S
Carpeta=(Carpeta Abrir)
ActivoCondicion=Usuario.EnviarExcel

[Acciones.AbrirMostrar]
Nombre=AbrirMostrar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
Carpeta=(Carpeta Abrir)

[Acciones.ReasignarUsuario]
Nombre=ReasignarUsuario
Boton=0
Menu=&Archivo
NombreDesplegar=Reasignar &Usuario...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ReasignarUsuario
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Usuario, hEmbarque:hEmbarque.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(hEmbarque:hEmbarque.ID)

[Ficha.hEmbarque.Vehiculo]
Carpeta=Ficha
Clave=hEmbarque.Vehiculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vehiculo.Descripcion]
Carpeta=Ficha
Clave=Vehiculo.Descripcion
Editar=S
3D=S
Tamano=24
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Vehiculo.Placas]
Carpeta=Ficha
Clave=Vehiculo.Placas
Editar=S
3D=S
Pegado=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro

[Ficha.hEmbarque.Ruta]
Carpeta=Ficha
Clave=hEmbarque.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hEmbarque.Agente]
Carpeta=Ficha
Clave=hEmbarque.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
3D=S
Tamano=33
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[(Carpeta Abrir).hEmbarque.Vehiculo]
Carpeta=(Carpeta Abrir)
Clave=hEmbarque.Vehiculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[(Carpeta Abrir).hEmbarque.Ruta]
Carpeta=(Carpeta Abrir)
Clave=hEmbarque.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[(Carpeta Abrir).hEmbarque.Agente]
Carpeta=(Carpeta Abrir)
Clave=hEmbarque.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).hEmbarque.FechaSalida]
Carpeta=(Carpeta Abrir)
Clave=hEmbarque.FechaSalida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Asignar]
Nombre=Asignar
Boton=55
Menu=&Edición
NombreDesplegar=&Asignar hEmbarques
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
GuardarAntes=S
Antes=S
DespuesGuardar=S
RefrescarDespues=S
UsaTeclaRapida=S
TeclaRapida=F7
EspacioPrevio=S
Visible=S
Expresion=Caso MovTipo(<T>EMB<T>, hEmbarque:hEmbarque.Mov)<BR>  Es EMB.E  Entonces Forma(<T>EmbarqueAsignar<T>)<BR>  Es EMB.OC Entonces Forma(<T>EmbarqueAsignarOC<T>)<BR>Fin
ActivoCondicion=hEmbarque:hEmbarque.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Vehiculo, hEmbarque:hEmbarque.Vehiculo)<BR>Asigna(Info.Ruta, hEmbarque:hEmbarque.Ruta)<BR>Asigna(Info.Peso, hEmbarque:Vehiculo.Peso)<BR>Asigna(Info.Volumen, hEmbarque:Vehiculo.Volumen)<BR>Asigna(Info.AntecedenteID, Nulo)<BR>Asigna(Info.Personal, hEmbarque:hEmbarque.PersonalCobrador)

[Detalle.hEmbarqueD.Observaciones]
Carpeta=Detalle
Clave=hEmbarqueD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Ficha.Vehiculo.Peso]
Carpeta=Ficha
Clave=Vehiculo.Peso
Editar=S
ValidaNombre=N
3D=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=N
Pegado=S

[Ficha.Vehiculo.Volumen]
Carpeta=Ficha
Clave=Vehiculo.Volumen
Editar=S
3D=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=N
Pegado=S

[Detalle.EmbarqueMov.Accion]
Carpeta=Detalle
Clave=EmbarqueMov.Accion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Negro
ColorFondo=Blanco

[Detalle.EmbarqueMov.Zona]
Carpeta=Detalle
Clave=EmbarqueMov.Zona
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.EmbarqueMov.Ruta]
Carpeta=Detalle
Clave=EmbarqueMov.Ruta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Movimiento]
Carpeta=Detalle
Clave=Movimiento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ImporteTotal]
Carpeta=Detalle
Clave=ImporteTotal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hEmbarqueD.Orden]
Carpeta=Detalle
Clave=hEmbarqueD.Orden
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Negro
ColorFondo=Blanco

[(Carpeta Totalizadores).Paquetes]
Carpeta=(Carpeta Totalizadores)
Clave=Paquetes
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=4
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.InfoMov]
Nombre=InfoMov
Boton=57
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+I
NombreDesplegar=&Examinar Movimiento
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
EspacioPrevio=S
Expresion=ReportePantalla(ReporteMovPantalla(hEmbarqueD:EmbarqueMov.Modulo,hEmbarqueD:EmbarqueMov.Mov), hEmbarqueD:EmbarqueMov.ModuloID)
EjecucionCondicion=ConDatos(hEmbarqueD:EmbarqueMov.Modulo) y ConDatos(hEmbarqueD:EmbarqueMov.ModuloID)

[(Carpeta Abrir).hEmbarque.Paquetes]
Carpeta=(Carpeta Abrir)
Clave=hEmbarque.Paquetes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=15

[Detalle.hEmbarqueD.Referencia]
Carpeta=Detalle
Clave=hEmbarqueD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.hEmbarqueD.Persona]
Carpeta=Detalle
Clave=hEmbarqueD.Persona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.hEmbarqueD.PersonaID]
Carpeta=Detalle
Clave=hEmbarqueD.PersonaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.hEmbarqueD.Forma]
Carpeta=Detalle
Clave=hEmbarqueD.Forma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.hEmbarqueD.Importe]
Carpeta=Detalle
Clave=hEmbarqueD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.hEmbarqueD.Estado]
Carpeta=Detalle
Clave=hEmbarqueD.Estado
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hEmbarqueD.FechaHora]
Carpeta=Detalle
Clave=hEmbarqueD.FechaHora
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CopiarImporte]
Nombre=CopiarImporte
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Copiar Importe
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(hEmbarqueD:hEmbarqueD.Importe, Si(hEmbarqueD:EmbarqueMov.Modulo en (<T>VTAS<T>, <T>CXC<T>), hEmbarqueD:CxcSaldo, hEmbarqueD:ImporteTotal))
ActivoCondicion=hEmbarque:hEmbarque.Estatus=EstatusPendiente

[Detalle.hEmbarqueD.Paquetes]
Carpeta=Detalle
Clave=hEmbarqueD.Paquetes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guia]
Nombre=Guia
Boton=69
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=&Guias
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S
Activo=S
Expresion=Si(hEmbarque:hEmbarque.Estatus=EstatusSinAfectar, Forma(<T>Guia<T>), Forma(<T>GuiaInfo<T>))
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID, hEmbarque:hEmbarque.MovID)<BR>Asigna(Info.FormaEnvio, Nulo)

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>EMB<T>)<BR>Asigna(Info.Fecha, hEmbarque:hEmbarque.FechaEmision)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hEmbarque:hEmbarque.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, hEmbarque:hEmbarque.Mov+<T> <T>+hEmbarque:hEmbarque.MovID)
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
GuardarAntes=S
ActivoCondicion=ConDatos(hEmbarque:hEmbarque.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F11
NombreDesplegar=&Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=CopiarMovimiento(<T>EMB<T>, hEmbarque:hEmbarque.ID, <T>Embarque<T>)

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
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmbarqueCampos
Antes=S
GuardarAntes=S
ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID, hEmbarque:hEmbarque.MovID)
DespuesGuardar=S
VisibleCondicion=hEmbarque:hEmbarque.Estatus<>EstatusSinAfectar

[Cxp.hEmbarque.Proveedor]
Carpeta=Cxp
Clave=hEmbarque.Proveedor
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Editar=S
EditarConBloqueo=S

[Cxp.Prov.Nombre]
Carpeta=Cxp
Clave=Prov.Nombre
ValidaNombre=N
3D=S
Tamano=45
ColorFondo=Plata
ColorFuente=Negro
Editar=S
Efectos=[Negritas]

[Cxp.hEmbarque.Importe]
Carpeta=Cxp
Clave=hEmbarque.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Cxp.hEmbarque.Impuestos]
Carpeta=Cxp
Clave=hEmbarque.Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Cxp.hEmbarque.Condicion]
Carpeta=Cxp
Clave=hEmbarque.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S
EspacioPrevio=S

[Cxp.hEmbarque.Vencimiento]
Carpeta=Cxp
Clave=hEmbarque.Vencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Cxp.ImporteTotal]
Carpeta=Cxp
Clave=ImporteTotal
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Cxp.hEmbarque.Moneda]
Carpeta=Cxp
Clave=hEmbarque.Moneda
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Cxp.hEmbarque.TipoCambio]
Carpeta=Cxp
Clave=hEmbarque.TipoCambio
Editar=S
3D=S
Pegado=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Cxp.hEmbarque.CxpReferencia]
Carpeta=Cxp
Clave=hEmbarque.CxpReferencia
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.EmbarqueMovPendientes]
Nombre=EmbarqueMovPendientes
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=Movimientos &Pendientes por Embarcar
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmbarqueMovPendientes
Activo=S
Visible=S
EspacioPrevio=S

[Gastos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gastos
Clave=Gastos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GastoA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
CarpetaVisible=S
Detalle=S
VistaMaestra=hEmbarque
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=Gasto.ID<TAB>(Acendente)
FiltroAplicaEn=Gasto.Moneda
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroEstilo=Directorio
IconosNombre=GastoA:Gasto.Mov+<T> <T>+GastoA:Gasto.MovID
FiltroGeneral=Gasto.Empresa=<T>{Empresa}<T> AND Gasto.AnexoModulo=<T>EMB<T> AND Gasto.AnexoID={hEmbarque:hEmbarque.ID}
CarpetaDesActivada=S

[Gastos.Gasto.Acreedor]
Carpeta=Gastos
Clave=Gasto.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.Prov.Nombre]
Carpeta=Gastos
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.ImporteTotal]
Carpeta=Gastos
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.Columnas]
0=136
1=79

[Acciones.GastosAnexos]
Nombre=GastosAnexos
Boton=64
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F4
NombreDesplegar=Gastos...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Gasto
Antes=S
DespuesGuardar=S
Visible=S
Activo=S
AntesExpresiones=Asigna(Anexo.Modulo, <T>EMB<T>)<BR>Asigna(Anexo.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Anexo.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Anexo.MovID, hEmbarque:hEmbarque.MovID)<BR>Asigna(Anexo.Estatus, hEmbarque:hEmbarque.Estatus)<BR>Asigna(Info.Proveedor, hEmbarque:hEmbarque.Proveedor)<BR>Asigna(Info.Copiar, Verdadero)

[Acciones.GastoImprimir]
Nombre=GastoImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=Gastos
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.GastoPreliminar]
Nombre=GastoPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=Gastos
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.GastoExcel]
Nombre=GastoExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Gastos
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.GastoCampos]
Nombre=GastoCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.GastoPropiedades]
Nombre=GastoPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, GastoA:Gasto.ID)

[Gastos.Gasto.Condicion]
Carpeta=Gastos
Clave=Gasto.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.Gasto.Vencimiento]
Carpeta=Gastos
Clave=Gasto.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.%Costo]
Carpeta=Ficha
Clave=%Costo
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Gastos.Gasto.FechaEmision]
Carpeta=Gastos
Clave=Gasto.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hEmbarque.Proveedor]
Carpeta=Ficha
Clave=hEmbarque.Proveedor
Editar=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (hEmbarque:hEmbarque.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(hEmbarque:hEmbarque.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino

[Detalle.hEmbarqueD.Causa]
Carpeta=Detalle
Clave=hEmbarqueD.Causa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

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

[Detalle.CxcSaldo]
Carpeta=Detalle
Clave=CxcSaldo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.hEmbarque.UEN]
Carpeta=Ficha
Clave=hEmbarque.UEN
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

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
EjecucionCondicion=ConDatos(hEmbarque:hEmbarque.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, hEmbarque:hEmbarque.Proyecto)

[Ficha.hEmbarque.PersonalCobrador]
Carpeta=Ficha
Clave=hEmbarque.PersonalCobrador
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Total Cobrado]
Carpeta=(Carpeta Totalizadores)
Clave=Total Cobrado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]
Pegado=S

[Ficha.hEmbarque.CtaDinero]
Carpeta=Ficha
Clave=hEmbarque.CtaDinero
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Acciones.AsistenteCobro]
Nombre=AsistenteCobro
Boton=12
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=&Asistente...
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmbarqueAsistenteCobro
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=hEmbarque:hEmbarque.Estatus=EstatusPendiente
AntesExpresiones=Asigna(Info.ID, hEmbarque:hEmbarque.ID)

[Acciones.EmbarqueParcial]
Nombre=EmbarqueParcial
Boton=47
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=Embarque Parcial
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S
ConCondicion=S
EjecucionConError=S


Expresion=Si<BR>  hEmbarque:hEmbarque.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>Entonces<BR>  Si(hEmbarqueD:EmbarqueMov.Modulo = <T>VTAS<T>,<BR>    Si(Forma(<T>EmbarqueDArtVentas<T>), Asigna(hEmbarqueD:hEmbarqueD.MovPorcentaje, Info.Porcentaje)))<BR>  Si(hEmbarqueD:EmbarqueMov.Modulo = <T>COMS<T>,<BR>    Si(Forma(<T>EmbarqueDArtCompra<T>), Asigna(hEmbarqueD:hEmbarqueD.MovPorcentaje, Info.Porcentaje)))<BR>Sino<BR>  Si(hEmbarqueD:EmbarqueMov.Modulo = <T>VTAS<T>, Forma(<T>EmbarqueDArtVentasInfo<T>))<BR>  Si(hEmbarqueD:EmbarqueMov.Modulo = <T>COMS<T>, Forma(<T>EmbarqueDArtCompraInfo<T>))<BR>Fin
ActivoCondicion=MovTipo(<T>EMB<T>, hEmbarque:hEmbarque.Mov) = EMB.E
EjecucionCondicion=hEmbarqueD:EmbarqueMov.Modulo en (<T>VTAS<T>, <T>COMS<T>)
EjecucionMensaje=<T>Esta Opción Funciona con Movimientos de Ventas y Compras<T>
AntesExpresiones=Asigna(Info.ID, hEmbarqueD:hEmbarqueD.ID)<BR>Asigna(Info.EmbarqueMov, hEmbarqueD:hEmbarqueD.EmbarqueMov)<BR>Asigna(Info.Mov, hEmbarqueD:EmbarqueMov.Mov)<BR>Asigna(Info.MovID, hEmbarqueD:EmbarqueMov.MovID)
[Detalle.hEmbarqueD.MovPorcentaje]
Carpeta=Detalle
Clave=hEmbarqueD.MovPorcentaje
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.Clave, <T>EMB<T>+hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Nombre, hEmbarque:hEmbarque.Mov+<T> <T>+hEmbarque:hEmbarque.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(hEmbarque:hEmbarque.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Acciones.Consecutivo]
Nombre=Consecutivo
Boton=0
Menu=&Archivo
NombreDesplegar=A&signar Consecutivo
EnMenu=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S
GuardarAntes=S
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>EMB<T>, hEmbarque:hEmbarque.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(hEmbarque:hEmbarque.MovID) y PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hEmbarque:hEmbarque.Usuario)

[Estadisticas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Estadísticas
Clave=Estadisticas
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hEmbarque
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

[Estadisticas.hEmbarque.FechaSalida]
Carpeta=Estadisticas
Clave=hEmbarque.FechaSalida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20
EditarConBloqueo=S

[Estadisticas.hEmbarque.FechaRetorno]
Carpeta=Estadisticas
Clave=hEmbarque.FechaRetorno
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20
EditarConBloqueo=S

[Estadisticas.hEmbarque.KmsSalida]
Carpeta=Estadisticas
Clave=hEmbarque.KmsSalida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20
EditarConBloqueo=S

[Estadisticas.hEmbarque.KmsRetorno]
Carpeta=Estadisticas
Clave=hEmbarque.KmsRetorno
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20
EditarConBloqueo=S



[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tareas
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.PuedeEditar, hEmbarque:hEmbarque.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID, hEmbarque:hEmbarque.MovID)<BR>Asigna(Info.Proyecto, hEmbarque:hEmbarque.Proyecto)<BR>Asigna(Info.UEN, hEmbarque:hEmbarque.UEN)<BR>Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, hEmbarque:Prov.Proveedor)<BR>Asigna(Info.Agente, hEmbarque:hEmbarque.Agente)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Detalle.ImporteEmbarque]
Carpeta=Detalle
Clave=ImporteEmbarque
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Total Embarque]
Carpeta=(Carpeta Totalizadores)
Clave=Total Embarque
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Peso Disp]
Carpeta=(Carpeta Totalizadores)
Clave=Peso Disp
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Volumen Disp]
Carpeta=(Carpeta Totalizadores)
Clave=Volumen Disp
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.EmbarqueMov.UEN]
Carpeta=Detalle
Clave=EmbarqueMov.UEN
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AgregarEvento]
Nombre=AgregarEvento
Boton=56
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=Agregar &Evento
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacoraAgregar
ActivoCondicion=hEmbarque:hEmbarque.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(hEmbarque:hEmbarque.Usuario)
ConCondicion=S
EjecucionCondicion=Si(Vacio(hEmbarque:hEmbarque.ID),  GuardarCambios)<BR>Verdadero
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID, hEmbarque:hEmbarque.MovID)
Visible=S

[Acciones.Bitacora]
Nombre=Bitacora
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+B
NombreDesplegar=Bitácora
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacora
Activo=S
ConCondicion=S
EjecucionCondicion=Si(Vacio(hEmbarque:hEmbarque.ID),  GuardarCambios)<BR>Verdadero
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID, hEmbarque:hEmbarque.MovID)<BR>Asigna(Info.PuedeEditar, hEmbarque:hEmbarque.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(hEmbarque:hEmbarque.Usuario))
Visible=S

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
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID, hEmbarque:hEmbarque.MovID)<BR>Asigna(Info.Fecha, hEmbarque:hEmbarque.FechaEmision)<BR>Asigna(Info.Estatus, hEmbarque:hEmbarque.Estatus)

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
EjecucionCondicion=ConDatos(hEmbarque:hEmbarque.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>EMB<T>)<BR>Asigna(Info.Clave, hEmbarque:hEmbarque.Mov)

[Acciones.PoliticaConcepto]
Nombre=PoliticaConcepto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+N
NombreDesplegar=Política Co&ncepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(hEmbarque:hEmbarque.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.Concepto, hEmbarque:hEmbarque.Concepto)

[Acciones.EliminarPartida]
Nombre=EliminarPartida
Boton=0
NombreDesplegar=E&liminar Partida...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
EspacioPrevio=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spEmbarqueEliminarDetalle :nID, :nOrden<T>, hEmbarqueD:hEmbarqueD.ID, hEmbarqueD:hEmbarqueD.Orden)
ActivoCondicion=hEmbarque:hEmbarque.Estatus=EstatusSinAfectar
Visible=S

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
Expresion=Asigna(Info.Forma, <T>hEmbarque<T>)<BR>Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.Nombre, hEmbarque:hEmbarque.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>EMB<T>, hEmbarque:hEmbarque.Mov, hEmbarque:hEmbarque.ID, Falso, hEmbarque:hEmbarque.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>EMB<T>+hEmbarque:hEmbarque.ID)<BR>  Asigna(Info.Nombre, hEmbarque:hEmbarque.Mov+<T> <T>+hEmbarque:hEmbarque.MovID)<BR>  Asigna(Info.Modulo, <T>EMB<T>)<BR>  Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      hEmbarque:hEmbarque.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.ID, hEmbarque:hEmbarque.ID)<BR>Asigna(Info.Mov, hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID, hEmbarque:hEmbarque.MovID)
DespuesGuardar=S
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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>EMB<T>, <T>{hEmbarque:hEmbarque.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>EMB{hEmbarque:hEmbarque.ID}<T>

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
VerCampo=350
VerValor=350




[Ficha.ListaEnCaptura]
(Inicio)=hEmbarque.Mov
hEmbarque.Mov=hEmbarque.MovID
hEmbarque.MovID=hEmbarque.Proyecto
hEmbarque.Proyecto=hEmbarque.UEN
hEmbarque.UEN=hEmbarque.PersonalCobrador
hEmbarque.PersonalCobrador=hEmbarque.FechaEmision
hEmbarque.FechaEmision=hEmbarque.Vehiculo
hEmbarque.Vehiculo=Vehiculo.Descripcion
Vehiculo.Descripcion=Vehiculo.Placas
Vehiculo.Placas=Vehiculo.Peso
Vehiculo.Peso=Vehiculo.Volumen
Vehiculo.Volumen=hEmbarque.Proveedor
hEmbarque.Proveedor=hEmbarque.Agente
hEmbarque.Agente=Agente.Nombre
Agente.Nombre=hEmbarque.CtaDinero
hEmbarque.CtaDinero=hEmbarque.Ruta
hEmbarque.Ruta=hEmbarque.Referencia
hEmbarque.Referencia=hEmbarque.Concepto
hEmbarque.Concepto=hEmbarque.Observaciones
hEmbarque.Observaciones=%Costo
%Costo=(Fin)




[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Peso Disp
Peso Disp=Volumen Disp
Volumen Disp=Paquetes
Paquetes=Total Embarque
Total Embarque=Total Cobrado
Total Cobrado=(Fin)



[Gastos.ListaEnCaptura]
(Inicio)=Gasto.FechaEmision
Gasto.FechaEmision=Gasto.Acreedor
Gasto.Acreedor=Prov.Nombre
Prov.Nombre=Gasto.Condicion
Gasto.Condicion=Gasto.Vencimiento
Gasto.Vencimiento=ImporteTotal
ImporteTotal=(Fin)

[Gastos.ListaAcciones]
(Inicio)=GastoActualizar
GastoActualizar=GastoPropiedades
GastoPropiedades=GastoImprimir
GastoImprimir=GastoPreliminar
GastoPreliminar=GastoExcel
GastoExcel=GastoCampos
GastoCampos=(Fin)


[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)


























[Acciones.Enrutar]
Nombre=Enrutar
Boton=105
Menu=&Edición
NombreDesplegar=&Enrutar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S







GuardarAntes=S









RefrescarDespues=S









UsaTeclaRapida=S
TeclaRapida=F8
Expresion=EjecutarSQL(<T>spMapaEnrutarEmbarque :nEstacion, :nID<T>, EstacionTrabajo, hEmbarque:hEmbarque.ID)<BR>PlugIn(<T>Mapa<T>, <T>Embarque<T>, <T>Enrutar<T>, hEmbarque:hEmbarque.ID)






























[Lista.Columnas]
Articulo=91
SubCuenta=88
Unidad=45
ImporteTotal=95
Almacen=82
FechaRequerida=85
CantidadPendiente=55
Cantidad=52







0=135
1=192
2=-2
3=-2
4=-2
[Pendientes.Columnas]
0=128
1=61
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2

[Asignado.Columnas]
0=109
1=43
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
















[Detalle.ListaEnCaptura]
(Inicio)=hEmbarqueD.Orden
hEmbarqueD.Orden=EmbarqueMov.Accion
EmbarqueMov.Accion=Movimiento
Movimiento=hEmbarqueD.MovPorcentaje
hEmbarqueD.MovPorcentaje=EmbarqueMov.Zona
EmbarqueMov.Zona=EmbarqueMov.Ruta
EmbarqueMov.Ruta=EmbarqueMov.UEN
EmbarqueMov.UEN=ImporteTotal
ImporteTotal=CxcSaldo
CxcSaldo=ImporteEmbarque
ImporteEmbarque=hEmbarqueD.Paquetes
hEmbarqueD.Paquetes=hEmbarqueD.Observaciones
hEmbarqueD.Observaciones=hEmbarqueD.Estado
hEmbarqueD.Estado=hEmbarqueD.FechaHora
hEmbarqueD.FechaHora=hEmbarqueD.Persona
hEmbarqueD.Persona=hEmbarqueD.PersonaID
hEmbarqueD.PersonaID=hEmbarqueD.Forma
hEmbarqueD.Forma=hEmbarqueD.Importe
hEmbarqueD.Importe=hEmbarqueD.Referencia
hEmbarqueD.Referencia=hEmbarqueD.Causa
hEmbarqueD.Causa=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=EmbarqueMov.NombreEnvio
EmbarqueMov.NombreEnvio=EmbarqueMov.Contacto1
EmbarqueMov.Contacto1=EmbarqueMov.Direccion
EmbarqueMov.Direccion=(Fin)

[Detalle.ListaAcciones]
(Inicio)=CopiarImporte
CopiarImporte=EliminarPartida
EliminarPartida=(Fin)































[Acciones.DetalleMov]
Nombre=DetalleMov
Boton=0
Menu=&Ver
NombreDesplegar=&Detalle por movimiento
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmbarqueDArtMovVCI
Activo=S
Visible=S

ConCondicion=S
EjecucionCondicion=ConDatos(hEmbarque:hEmbarque.Mov)
Antes=S
AntesExpresiones=Asigna(Info.Mov,hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID,hEmbarque:hEmbarque.MovID)<BR>Asigna(Info.ID,hEmbarque:hEmbarque.ID)






























[Acciones.DetalleConcentrado]
Nombre=DetalleConcentrado
Boton=0
Menu=&Ver
NombreDesplegar=&Detalle concentrado
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmbarqueDArtVCI
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Mov,hEmbarque:hEmbarque.Mov)<BR>Asigna(Info.MovID,hEmbarque:hEmbarque.MovID)<BR>Asigna(Info.ID,hEmbarque:hEmbarque.ID)
Visible=S










[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=hEmbarque.FechaEmision
hEmbarque.FechaEmision=hEmbarque.FechaSalida
hEmbarque.FechaSalida=hEmbarque.Vehiculo
hEmbarque.Vehiculo=hEmbarque.Ruta
hEmbarque.Ruta=hEmbarque.Agente
hEmbarque.Agente=hEmbarque.Paquetes
hEmbarque.Paquetes=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirMostrar
AbrirMostrar=EmbarqueMovPendientes
EmbarqueMovPendientes=(Fin)






[Estadisticas.hEmbarque.TempFin]
Carpeta=Estadisticas
Clave=hEmbarque.TempFin
Editar=S
EditarConBloqueo=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Estadisticas.hEmbarque.TempInicio]
Carpeta=Estadisticas
Clave=hEmbarque.TempInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20



[Estadisticas.ListaEnCaptura]
(Inicio)=hEmbarque.FechaSalida
hEmbarque.FechaSalida=hEmbarque.FechaRetorno
hEmbarque.FechaRetorno=hEmbarque.TempInicio
hEmbarque.TempInicio=hEmbarque.TempFin
hEmbarque.TempFin=hEmbarque.KmsSalida
hEmbarque.KmsSalida=hEmbarque.KmsRetorno
hEmbarque.KmsRetorno=(Fin)



















[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Estadisticas
Estadisticas=Gastos
Gastos=Detalle
Detalle=FormaExtraValor
FormaExtraValor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=Abrir
Abrir=Localizar
Localizar=Guardar Cambios
Guardar Cambios=MovPersonal
MovPersonal=Evaluaciones
Evaluaciones=Propiedades
Propiedades=Imprimir
Imprimir=RepPantalla
RepPantalla=PlantillasOffice
PlantillasOffice=FormasAnexas
FormasAnexas=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Afectar
Afectar=Consecutivo
Consecutivo=Eliminar
Eliminar=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=Asignar
Asignar=EmbarqueParcial
EmbarqueParcial=AsistenteCobro
AsistenteCobro=Campos
Campos=CamposExtras
CamposExtras=Tareas
Tareas=Anexos
Anexos=AgregarEvento
AgregarEvento=GastosAnexos
GastosAnexos=Guia
Guia=Anterior
Anterior=Siguiente
Siguiente=InfoMov
InfoMov=ProyInfo
ProyInfo=Bitacora
Bitacora=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
MovPos=Enrutar
Enrutar=Navegador
Navegador=Cerrar
Cerrar=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=DetalleMov
DetalleMov=DetalleConcentrado
DetalleConcentrado=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
