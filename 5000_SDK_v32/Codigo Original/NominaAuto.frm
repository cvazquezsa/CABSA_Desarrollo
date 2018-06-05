[Forma]
Clave=NominaAuto
Nombre=<T>Nómina<T>
Icono=0
Modulos=NOM
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=422
PosicionInicialArriba=160
PosicionInicialAltura=527
PosicionInicialAncho=756
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
PosicionSeccion1=27
PosicionSeccion2=92
BarraAyuda=S
MovModulo=NOM
PosicionColumna3=50
BarraAyudaBold=S
VentanaBloquearAjuste=N
Totalizadores=S
PosicionInicialAlturaCliente=542
AutoGuardarEncabezado=S
MovEspecificos=Todos
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)
PosicionSec1=144
PosicionSec2=402

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Nomina
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

[Ficha.Nomina.Mov]
Carpeta=Ficha
Clave=Nomina.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Nomina.MovID]
Carpeta=Ficha
Clave=Nomina.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Nomina.FechaEmision]
Carpeta=Ficha
Clave=Nomina.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Nomina.Concepto]
Carpeta=Ficha
Clave=Nomina.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Ficha.Nomina.Proyecto]
Carpeta=Ficha
Clave=Nomina.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.Nomina.Moneda]
Carpeta=Ficha
Clave=Nomina.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Nomina.Observaciones]
Carpeta=Ficha
Clave=Nomina.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=73
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=NominaA
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
ListaOrden=Nomina.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Nomina.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
PestanaOtroNombre=S
PestanaNombre=movimientos a la Nomina
FiltroUsuarioDefault=(Usuario)
FiltroFechasNormal=S
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
Filtros=S
FiltroPredefinido=S
FiltroEstilo=Directorio
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroAutoValidar=Mon
FiltroAplicaEn=Nomina.Moneda
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechasCancelacion=Nomina.FechaCancelacion
FiltroSucursales=S
IconosNombre=NominaA:Nomina.Mov+<T> <T>+NominaA:Nomina.MovID

[(Carpeta Abrir).Columnas]
0=153
1=85

2=-2
3=-2
4=-2
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
UsaTeclaRapida=Si
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar cambios
EnBarraHerramientas=Si
EnMenu=Si
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=Si
Activo=Si

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
EnBarraHerramientas=Si
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Visible=Si
Activo=Si
EspacioPrevio=Si

[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=NominaD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Nomina
LlaveLocal=NominaD.ID
LlaveMaestra=Nomina.ID
ControlRenglon=S
CampoRenglon=NominaD.Renglon
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
OtroOrden=S
ListaOrden=NominaD.Renglon<TAB>(Acendente)
HojaFondoGrisAuto=S
PermiteLocalizar=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
PestanaNombre=Multiples
CarpetaVisible=S
HojaAjustarColumnas=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(Empresa)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=LocalCancelar
ConResumen=S
ResumenVista=NominaR
ResumenLlave=ID
ResumenCampos=(Lista)
ResumenVistaMaestra=Nomina
ResumenLlaveMaestra=Nomina.ID
FiltroGrupo1=NominaD.Personal
FiltroValida1=NominaD.Personal
FiltroAutoCampo=NominaD.Personal
FiltroTodo=S
FiltroTodoFinal=S
FiltroNull=S

FiltroGeneral={Si<BR>  (Nomina:Nomina.Estatus<>EstatusSinAfectar) y MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.N, NOM.NE, NOM.NA, NOM.NC))<BR>Entonces<BR>  Asigna(Temp.Texto, <T><T>)<BR>  Si(no Ver.Estadisticas, Asigna(Temp.Texto, <T>NominaD.Movimiento<><T>+Comillas(<T>Estadistica<T>)))<BR>  Si(ConDatos(Filtro.Personal), Asigna(Temp.Texto, Temp.Texto+Si(ConDatos(Temp.Texto), <T> AND <T>, <T><T>)+<T>NominaD.Personal=<T>+Comillas(Filtro.Personal)))<BR>  Temp.Texto<BR>Fin}
[Detalle.Columnas]
Importe=103
Aplica=96
AplicaID=74
AplicaProntoPago=96
Personal=93
Cantidad=49
Porcentaje=40
Periodos=48
FechaInicio=76
FechaTermino=79
Observaciones=108
CantidadPendiente=53
Saldo=106
Estatus=94
Condicion=99
CtaDinero=83
Variable=95
Activo=35
FechaD=70
FechaA=77
Monto=86
Descripcion=106
Referencia=111
Cuenta=67
Concepto=125
Movimiento=60
FormaPago=61
SueldoPeriodo=75
Beneficiario=88
Horas=49

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
Totalizadores1=Percepciones<BR>Deducciones<BR>Neto
Totalizadores2=Suma(NominaD:Percepcion)<BR>Suma(NominaD:Deduccion)<BR>Suma(NominaD:Percepcion)-Suma(NominaD:Deduccion)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.N, NOM.NA, NOM.NE, NOM.NC))

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

Expresion=Asigna(Afectar.ID, Nomina:Nomina.ID)<BR>Asigna(Afectar.Mov, Nomina:Nomina.Mov)<BR>Asigna(Afectar.Fecha, Nomina:Nomina.FechaOrigen)<BR>Si <BR>  MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.N, NOM.NE))<BR>Entonces<BR>  Si <BR>    Nomina:Nomina.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>  Entonces    <BR>    Forma(<T>NominaGenerar<T>)<BR>    AbortarOperacion<BR>  Sino<BR>    Si(Confirmacion(<T>¿ Esta Seguro que Desea Afectar la Nomina ?<T>,BotonSi, BotonNo)=BotonNo, AbortarOperacion)<BR>  Fin<BR>Fin<BR>Afectar(<T>NOM<T>, Nomina:Nomina.ID, Nomina:Nomina.Mov, Nomina:Nomina.MovID, <T>Todo<T>, <T><T>, <T>Nomina<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Nomina:Nomina.Usuario) y<BR>(Nomina:Nomina.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>NOM<T>, Nomina:Nomina.Mov, Nomina:Nomina.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Nomina:Nomina.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Nomina:Nomina.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>NOM<T>, Nomina:Nomina.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>NOM<T>, Nomina:Nomina.Mov, Nomina:Nomina.ID, Verdadero, Nomina:Nomina.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Nomina:Nomina.MovID) y (Nomina:Nomina.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Nomina:Nomina.Usuario)

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Nomina:Nomina.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=Asigna(Info.MovTipo, MovTipo(<T>NOM<T>, Nomina:Nomina.Mov))<BR>ReportePantalla(ReporteMovPantalla(<T>NOM<T>, Nomina:Nomina.Mov, Nomina:Nomina.Estatus), Nomina:Nomina.ID)
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
ListaParametros1=Nomina:Nomina.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=Asigna(Info.MovTipo, MovTipo(<T>NOM<T>, Nomina:Nomina.Mov))<BR>ReporteImpresora(ReporteMovImpresora(<T>NOM<T>, Nomina:Nomina.Mov, Nomina:Nomina.Estatus), Nomina:Nomina.ID)
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
ActivoCondicion=Nomina:Nomina.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ConfirmarAntes=S
DialogoMensaje=MovCancelar
Antes=S
RefrescarDespues=S
GuardarAntes=S
Expresion=Cancelar(<T>NOM<T>, Nomina:Nomina.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Nomina<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Nomina:Nomina.Usuario) y ConDatos(Nomina:Nomina.ID) y ConDatos(Nomina:Nomina.MovID) y<BR>(Nomina:Nomina.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusSincro, EstatusBorrador, EstatusPendiente, EstatusConcluido, EstatusProcesar, EstatusVigente))
AntesExpresiones=Asigna( Afectar.Mov, Nomina:Nomina.Mov ) <BR>Asigna( Afectar.MovID, Nomina:Nomina.MovID )
VisibleCondicion=(Nomina:Nomina.Estatus<>EstatusConcluido) o MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.N, NOM.NA, NOM.NE, NOM.NC, NOM.DP))

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
Expresion=Verificar(<T>NOM<T>, Nomina:Nomina.ID,Nomina:Nomina.Mov,Nomina:Nomina.MovID)
ActivoCondicion=Nomina:Nomina.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Nomina:Nomina.Mov)

[Acciones.Infomacion]
Nombre=Infomacion
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Información de la Persona
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Visible=S
ClaveAccion=PersonalInfo
Antes=S
EjecucionCondicion=ConDatos(NominaD:NominaD.Personal)
AntesExpresiones=Asigna(Info.Personal, NominaD:NominaD.Personal)

[Ficha.Nomina.TipoCambio]
Carpeta=Ficha
Clave=Nomina.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Nomina.MovAplica]
Carpeta=Aplica
Clave=Nomina.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.Nomina.MovAplicaID]
Carpeta=Aplica
Clave=Nomina.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10

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

[(Carpeta Abrir).Nomina.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Nomina.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posición del Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPos
Antes=S
Visible=S
ActivoCondicion=ConDatos(Nomina:Nomina.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, Nomina:Nomina.ID)<BR>Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>Asigna(Info.MovID, Nomina:Nomina.MovID)

[Aplica.Nomina.Proveedor]
Carpeta=Aplica
Clave=Nomina.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.Prov.Nombre]
Carpeta=Aplica
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=50
ColorFondo=Plata

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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>NOM<T>, Nomina:Nomina.Mov, Nomina:Nomina.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>NOM<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>NOM<T>, Nomina:Nomina.Mov, Nomina:Nomina.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Nomina:Nomina.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, Nomina:Nomina.ID)<BR>Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>Asigna(Info.Estatus, Nomina:Nomina.Estatus)<BR>Asigna(Info.Situacion, Nomina:Nomina.Situacion)
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
ActivoCondicion=ConfigModulo(<T>NOM<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Nomina:Nomina.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, Nomina:Nomina.ID)<BR>Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>Asigna(Info.MovID, Nomina:Nomina.MovID)

[(Carpeta Abrir).Nomina.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Nomina.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(NominaA:Nomina.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, NominaA:Nomina.ID)
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
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, Nomina:Nomina.ID)<BR>Asigna(Info.Usuario, Nomina:Nomina.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Nomina:Nomina.ID)

[Detalle.NominaD.Personal]
Carpeta=Detalle
Clave=NominaD.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.NominaD.Cantidad]
Carpeta=Detalle
Clave=NominaD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.NominaD.Importe]
Carpeta=Detalle
Clave=NominaD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.NominaD.CantidadPendiente]
Carpeta=Detalle
Clave=NominaD.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00004080
Efectos=[Negritas]

[Detalle.NominaD.Saldo]
Carpeta=Detalle
Clave=NominaD.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00004080
Efectos=[Negritas]

[(Carpeta Abrir).Nomina.Observaciones]
Carpeta=(Carpeta Abrir)
Clave=Nomina.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.NominaD.Activo]
Carpeta=Detalle
Clave=NominaD.Activo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Condiciones.Nomina.Personal]
Carpeta=Condiciones
Clave=Nomina.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.NombreCompleto]
Carpeta=Condiciones
Clave=NombreCompleto
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Condiciones.Nomina.Importe]
Carpeta=Condiciones
Clave=Nomina.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Nomina.Saldo]
Carpeta=Condiciones
Clave=Nomina.Saldo
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Condiciones.Nomina.CondicionVeces]
Carpeta=Condiciones
Clave=Nomina.CondicionVeces
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Condiciones.Nomina.CondicionFechaD]
Carpeta=Condiciones
Clave=Nomina.CondicionFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Nomina.CondicionFechaA]
Carpeta=Condiciones
Clave=Nomina.CondicionFechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Nomina.CondicionPorcentaje]
Carpeta=Condiciones
Clave=Nomina.CondicionPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Nomina.CondicionMonto]
Carpeta=Condiciones
Clave=Nomina.CondicionMonto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Nomina.CtaDinero]
Carpeta=Condiciones
Clave=Nomina.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.CtaDinero.Descripcion]
Carpeta=Condiciones
Clave=CtaDinero.Descripcion
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Nomina.Condicion]
Carpeta=Ficha
Clave=Nomina.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Con.Personal.Personal]
Carpeta=Con
Clave=Personal.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Con.Personal.ApellidoPaterno]
Carpeta=Con
Clave=Personal.ApellidoPaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Con.Personal.ApellidoMaterno]
Carpeta=Con
Clave=Personal.ApellidoMaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.NominaD.Monto]
Carpeta=Detalle
Clave=NominaD.Monto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Detalle.NominaD.Porcentaje]
Carpeta=Detalle
Clave=NominaD.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Detalle.NominaD.FechaD]
Carpeta=Detalle
Clave=NominaD.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.NominaD.FechaA]
Carpeta=Detalle
Clave=NominaD.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Desafectar]
Nombre=Desafectar
Boton=0
Menu=&Archivo
NombreDesplegar=<T>&Desafectar<T>
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
ConfirmarAntes=S
DialogoMensaje=MovDesAfectar
TipoAccion=Expresion
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F12
Expresion=DesAfectar(<T>NOM<T>, Nomina:Nomina.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Nomina<T>)
ActivoCondicion=Usuario.Desafectar y MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.P, NOM.D, NOM.C, NOM.CH, NOM.CD, NOM.CDH, NOM.VT)) y (Nomina:Nomina.Estatus = EstatusProcesar)
AntesExpresiones=Asigna(Afectar.Mov, Nomina:Nomina.Mov)<BR>Asigna(Afectar.MovID, Nomina:Nomina.MovID)

[Detalle.NominaD.Referencia]
Carpeta=Detalle
Clave=NominaD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.NominaD.Cuenta]
Carpeta=Detalle
Clave=NominaD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).Nomina.Condicion]
Carpeta=(Carpeta Abrir)
Clave=Nomina.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.NominaD.Movimiento]
Carpeta=Detalle
Clave=NominaD.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.NominaD.Concepto]
Carpeta=Detalle
Clave=NominaD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.NominaD.FormaPago]
Carpeta=Detalle
Clave=NominaD.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.CtaDineroInfo]
Nombre=CtaDineroInfo
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+I
NombreDesplegar=Información de la &Cuenta
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Si<BR>  ConDatos(NominaD:NominaD.Cuenta)<BR>Entonces<BR>  Caso NominaD:NominaD.Modulo<BR>    Es <T>DIN<T> Entonces Asigna(Info.CtaDinero, NominaD:NominaD.Cuenta) Forma(<T>CtaDineroInfo<T>)<BR>    Es <T>CXP<T> Entonces Asigna(Info.Proveedor, NominaD:NominaD.Cuenta) Forma(<T>ProvInfo<T>)<BR>  Fin<BR>Fin
ActivoCondicion=Usuario.CtaDineroInfo

[Ficha.Nomina.PeriodoTipo]
Carpeta=Ficha
Clave=Nomina.PeriodoTipo
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.Nomina.FechaD]
Carpeta=Ficha
Clave=Nomina.FechaD
Editar=N
3D=S
Tamano=15
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.Nomina.FechaA]
Carpeta=Ficha
Clave=Nomina.FechaA
Editar=N
3D=S
Tamano=15
ColorFuente=Negro
ColorFondo=Blanco

[Acciones.Analizar]
Nombre=Analizar
Boton=20
NombreEnBoton=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=A&nalizar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
ClaveAccion=NominaAnalizar
Antes=S
AntesExpresiones=Asigna(Info.ID, Nomina:Nomina.ID)<BR>Asigna(Info.MovTipo, MovTipo(<T>NOM<T>, Nomina:Nomina.Mov))
VisibleCondicion=MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.N, NOM.NE))

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
Visible=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>NOM<T>)<BR>Asigna(Info.Fecha, Nomina:Nomina.FechaEmision)<BR>Asigna(Info.ID, Nomina:Nomina.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Nomina:Nomina.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Nomina:Nomina.Mov+<T> <T>+Nomina:Nomina.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(Nomina:Nomina.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, Nomina:Nomina.ID)
Visible=S

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F11
NombreDesplegar=&Copiar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=CopiarMovimiento(<T>NOM<T>, Nomina:Nomina.ID, <T>Nomina<T>)

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
ClaveAccion=NominaCampos
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.ID, Nomina:Nomina.ID)<BR>Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>Asigna(Info.MovID, Nomina:Nomina.MovID)
VisibleCondicion=Nomina:Nomina.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Nomina:Nomina.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Nomina:Nomina.ID),GuardarCambios)
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

[(Carpeta Totalizadores).Percepciones]
Carpeta=(Carpeta Totalizadores)
Clave=Percepciones
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Deducciones]
Carpeta=(Carpeta Totalizadores)
Clave=Deducciones
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Neto]
Carpeta=(Carpeta Totalizadores)
Clave=Neto
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.SueldoPeriodo]
Carpeta=Detalle
Clave=SueldoPeriodo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.CancelacionParcial]
Nombre=CancelacionParcial
Boton=40
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=Cancelación &Parcial...
EnMenu=S
TipoAccion=Expresion
Activo=S
Expresion=Asigna(Info.Personal, Nulo)<BR>Si <BR>  Forma(<T>EspecificarPersonal<T>)<BR>Entonces<BR>  Informacion(SQL(<T>spNominaCancelacionParcial :tEmpresa, :nSucursal, :tUsuario, :nID, :tPersonal, :fFecha<T>, Empresa, Sucursal, Usuario, Nomina:Nomina.ID, Info.Personal, FechaTrabajo))<BR>Fin
VisibleCondicion=MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.N, NOM.NE)) y (Nomina:Nomina.Estatus=EstatusConcluido)

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
VisibleCondicion=Usuario.EnviarExcel

[Detalle.NominaD.Beneficiario]
Carpeta=Detalle
Clave=NominaD.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha.Nomina.UEN]
Carpeta=Ficha
Clave=Nomina.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
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
EjecucionCondicion=ConDatos(Nomina:Nomina.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Nomina:Nomina.Proyecto)
Visible=S

[Ficha.Nomina.FechaOrigen]
Carpeta=Ficha
Clave=Nomina.FechaOrigen
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.NominaD.Horas]
Carpeta=Detalle
Clave=NominaD.Horas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Acciones.EliminacionParcial]
Nombre=EliminacionParcial
Boton=0
Menu=&Archivo
NombreDesplegar=Eliminación &Parcial...
EnMenu=S
TipoAccion=Expresion
RefrescarDespues=S
Expresion=Asigna(Info.Personal, NominaD:NominaD.Personal)<BR>Si <BR>  Forma(<T>NominaEliminacionParcial<T>)<BR>Entonces<BR>  Si <BR>    Confirmacion(<T>¿ Esta Seguro que desea Eliminar a <T>+Info.Personal+<T> del Borrador ?<T>, BotonSi, BotonNo)=BotonSi<BR>  Entonces<BR>    Informacion(SQL(<T>spNominaEliminacionParcial :tEmpresa, :nSucursal, :tUsuario, :nID, :tPersonal, :fFecha<T>, Empresa, Sucursal, Usuario, Nomina:Nomina.ID, Info.Personal, FechaTrabajo))<BR>  Fin<BR>Fin
ActivoCondicion=Usuario.NominaEliminacionParcial
VisibleCondicion=MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.N, NOM.NE)) y (Nomina:Nomina.Estatus=EstatusBorrador)

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
Expresion=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>Asigna(Info.Clave, <T>NOM<T>+Nomina:Nomina.ID)<BR>Asigna(Info.Nombre, Nomina:Nomina.Mov+<T> <T>+Nomina:Nomina.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Nomina:Nomina.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.PuedeEditar, Nomina:Nomina.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>Asigna(Info.MovID, Nomina:Nomina.MovID)<BR>Asigna(Info.Proyecto, Nomina:Nomina.Proyecto)<BR>Asigna(Info.UEN, Nomina:Nomina.UEN)<BR>Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, Nomina:Nomina.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Acciones.LocalCancelar]
Nombre=LocalCancelar
Boton=0
NombreDesplegar=Cancelar &Línea
RefrescarDespues=S
EnMenu=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Activo=S
Expresion=EjecutarSQL(<T>spNominaCancelarLinea :nID, :nRen<T>, Nomina:Nomina.ID, NominaD:NominaD.Renglon)
VisibleCondicion=(Nomina:Nomina.Estatus=EstatusProcesar) y Usuario.ModificarMovsNominaVigentes

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
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, Nomina:Nomina.ID)<BR>Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>Asigna(Info.MovID, Nomina:Nomina.MovID)<BR>Asigna(Info.Fecha, Nomina:Nomina.FechaEmision)<BR>Asigna(Info.Estatus, Nomina:Nomina.Estatus)

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
EjecucionCondicion=ConDatos(Nomina:Nomina.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>NOM<T>)<BR>Asigna(Info.Clave, Nomina:Nomina.Mov)

[Acciones.PoliticaConcepto]
Nombre=Politica
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
EjecucionCondicion=ConDatos(Nomina:Nomina.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.Concepto, Nomina:Nomina.Concepto)

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
Expresion=Asigna(Info.Forma, <T>NOM<T>)<BR>Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>Asigna(Info.Nombre, <T>Nómina<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>NOM<T>, Nomina:Nomina.Mov, Nomina:Nomina.ID, Falso, Nomina:Nomina.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>NOM<T>+Nomina:Nomina.ID)<BR>  Asigna(Info.Nombre, Nomina:Nomina.Mov+<T> <T>+Nomina:Nomina.MovID)<BR>  Asigna(Info.Modulo, <T>NOM<T>)<BR>  Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Nomina:Nomina.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
Menu=&Ver
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Resumen)
Activo=S
Visible=S

[Detalle.ColumnasResumen]
Personal=100
Concepto=155
Movimiento=119
Referencia=182
Cantidad=56
Importe=98

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
ClaveAccion=MovFormasAnexa
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, Nomina:Nomina.ID)<BR>Asigna(Info.Mov, Nomina:Nomina.Mov)<BR>Asigna(Info.MovID, Nomina:Nomina.MovID)
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
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>NOM<T>, <T>{Nomina:Nomina.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>NOM{Nomina:Nomina.ID}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>

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

[Acciones.Importar]
Nombre=Importar
Boton=24
NombreEnBoton=S
NombreDesplegar=Importar Acumulados
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
RefrescarDespues=S
GuardarAntes=S
Expresion=GuardarCambios <BR>Asigna( info.id, Nomina:Nomina.ID )<BR>FormaModal( <T>NominaImportar<T> ) <BR>Forma.ActualizarForma  <BR>Forma.ActualizarVista
AntesExpresiones=Asigna( info.id,Nomina:Nomina.ID )
VisibleCondicion=((Mayusculas(SQL(<T>SELECT Clave FROM MovTipo WHERE Modulo = :tm AND Mov = :to<T>, <T>NOM<T>, Nomina:Nomina.Mov)) = <T>NOM.NA<T>  ) Y (MAYUSCULAS(Nomina:Nomina.Estatus) = <T>SINAFECTAR<T>))




[Ficha.ListaEnCaptura]
(Inicio)=Nomina.Mov
Nomina.Mov=Nomina.MovID
Nomina.MovID=Nomina.Proyecto
Nomina.Proyecto=Nomina.UEN
Nomina.UEN=Nomina.Moneda
Nomina.Moneda=Nomina.TipoCambio
Nomina.TipoCambio=Nomina.PeriodoTipo
Nomina.PeriodoTipo=Nomina.FechaEmision
Nomina.FechaEmision=Nomina.FechaOrigen
Nomina.FechaOrigen=Nomina.FechaD
Nomina.FechaD=Nomina.FechaA
Nomina.FechaA=Nomina.Concepto
Nomina.Concepto=Nomina.Condicion
Nomina.Condicion=Nomina.Observaciones
Nomina.Observaciones=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Nomina.FechaEmision
Nomina.FechaEmision=Nomina.Concepto
Nomina.Concepto=Nomina.Condicion
Nomina.Condicion=Nomina.Observaciones
Nomina.Observaciones=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=BORRADOR
BORRADOR=PROCESAR
PROCESAR=VIGENTE
VIGENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)



[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Percepciones
Percepciones=Deducciones
Deducciones=Neto
Neto=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)








[Acciones.VerEstadisticas]
Nombre=VerEstadisticas
Boton=107
Menu=&Ver
NombreDesplegar=Es&tadísticas
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
EspacioPrevio=S
NombreEnBoton=S
EnBarraHerramientas=S
AntesExpresiones=Asigna(Ver.Estadisticas, no Ver.Estadisticas)
VisibleCondicion=(Nomina:Nomina.Estatus<>EstatusSinAfectar) y MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.N, NOM.NE, NOM.NA, NOM.NC))










[Acciones.FiltroPersonal]
Nombre=FiltroPersonal
Boton=107
NombreEnBoton=S
Menu=&Ver
NombreDesplegar=&Persona
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
ConCondicion=S
Activo=S
EjecucionCondicion=Forma(<T>EspecificarFiltroPersonal<T>)
VisibleCondicion=(Nomina:Nomina.Estatus<>EstatusSinAfectar) y MovTipoEn(<T>NOM<T>, Nomina:Nomina.Mov, (NOM.N, NOM.NE, NOM.NA, NOM.NC))










[Lista.Columnas]
0=113
1=163
2=-2
3=-2
4=-2



















[Detalle.ResumenCampos]
(Inicio)=Personal
Personal=Concepto
Concepto=Movimiento
Movimiento=Referencia
Referencia=Cantidad
Cantidad=Importe
Importe=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=NominaD.Personal
NominaD.Personal=NominaD.Movimiento
NominaD.Movimiento=NominaD.Importe
NominaD.Importe=SueldoPeriodo
SueldoPeriodo=NominaD.Monto
NominaD.Monto=NominaD.Porcentaje
NominaD.Porcentaje=NominaD.FechaD
NominaD.FechaD=NominaD.FechaA
NominaD.FechaA=NominaD.Cuenta
NominaD.Cuenta=NominaD.FormaPago
NominaD.FormaPago=NominaD.Concepto
NominaD.Concepto=NominaD.Horas
NominaD.Horas=NominaD.Cantidad
NominaD.Cantidad=NominaD.CantidadPendiente
NominaD.CantidadPendiente=NominaD.Beneficiario
NominaD.Beneficiario=NominaD.Referencia
NominaD.Referencia=NominaD.Saldo
NominaD.Saldo=NominaD.Activo
NominaD.Activo=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=NombreCompleto
NombreCompleto=Personal.PeriodoTipo
Personal.PeriodoTipo=Personal.Departamento
Personal.Departamento=EstatusNombre
EstatusNombre=(Fin)










[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S













[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalle
Detalle=FormaExtraValor
FormaExtraValor=(Fin)

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
Afectar=Desafectar
Desafectar=Eliminar
Eliminar=EliminacionParcial
EliminacionParcial=Cancelar
Cancelar=CancelacionParcial
CancelacionParcial=CambiarVista
CambiarVista=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=Tareas
Tareas=Anexos
Anexos=Anterior
Anterior=Siguiente
Siguiente=Infomacion
Infomacion=CtaDineroInfo
CtaDineroInfo=ProyInfo
ProyInfo=Navegador
Navegador=Analizar
Analizar=VerEstadisticas
VerEstadisticas=FiltroPersonal
FiltroPersonal=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
MovPos=Cerrar
Cerrar=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=Importar
Importar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
