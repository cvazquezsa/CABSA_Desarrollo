[Forma]
Clave=ContParalela
Nombre=Contabilidad Paralela
Icono=0
Modulos=CONTP
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=312
PosicionInicialArriba=54
PosicionInicialAltura=531
PosicionInicialAncho=742
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
MovModulo=CONTP
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
PosicionInicialAlturaCliente=581
PosicionSec1=188
PosicionSec2=477

VentanaEstadoInicial=Normal
Totalizadores=S
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalela
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

[Ficha.ContParalela.Mov]
Carpeta=Ficha
Clave=ContParalela.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.ContParalela.MovID]
Carpeta=Ficha
Clave=ContParalela.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.ContParalela.FechaEmision]
Carpeta=Ficha
Clave=ContParalela.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.ContParalela.Concepto]
Carpeta=Ficha
Clave=ContParalela.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=S
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.ContParalela.Proyecto]
Carpeta=Ficha
Clave=ContParalela.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco


[Ficha.ContParalela.Referencia]
Carpeta=Ficha
Clave=ContParalela.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.ContParalela.Observaciones]
Carpeta=Ficha
Clave=ContParalela.Observaciones
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
Vista=ContParalelaA
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
ListaOrden=ContParalela.ID<TAB>(Decendente)
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
FiltroFechasCampo=ContParalela.FechaEmision
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
FiltroAplicaEn=ContParalela.Moneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=ContParalela.FechaCancelacion
FiltroSucursales=S

BusquedaSelCampo=S
IconosNombre=ContParalelaA:ContParalela.Mov+<T> <T>+ContParalelaA:ContParalela.MovID
[(Carpeta Abrir).Columnas]
0=186
1=92

2=-2
3=-2
4=271
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

EjecucionCondicion=Si(General.MovConcurrente y ConDatos(ContParalela:ContParalela.ID) y (ContParalela:ContParalela.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, ContParalela:ContParalela.ID, <T>CONTP<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero
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


[Detalle.Columnas]
Importe=69
Aplica=106
AplicaID=66
AplicaProntoPago=96
Referencia=113
Observaciones=202
ObligacionFiscal=132
Tasa=37
Factor=64
Contacto=64
ContactoTipo=79
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
Cuenta=107
Descripcion=233
Estatus=94
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
Totalizadores1=Debe<BR>Haber
Totalizadores2=Suma(ContParalelaDPoliza:ContParalelaDPoliza.Debe)<BR>Suma(ContParalelaDPoliza:ContParalelaDPoliza.Haber)
Totalizadores3=(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=PolizaD
CampoColorLetras=Negro
CampoColorFondo=Plata

ListaEnCaptura=(Lista)
CondicionVisible=MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.POLIZA)
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

Expresion=Asigna(Afectar.Modulo, <T>CONTP<T>)<BR>Asigna(Afectar.ID, ContParalela:ContParalela.ID)<BR>Asigna(Afectar.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Afectar.MovID, ContParalela:ContParalela.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>CONTP<T>)<BR>Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.ID, ContParalela:ContParalela.ID)<BR>Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Info.MovID, ContParalela:ContParalela.MovID)<BR>Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>Asigna(Info.MovTipo, MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov))<BR>Si<BR>  ContParalela:ContParalela.Estatus=EstatusPendiente<BR>Entonces<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si<BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Si Info.MovTipo en(CONTP.GENERADORPAQ, CONTP.PAQUETE, CONTP.TRANSFORMACION)<BR>    Entonces<BR>      Si Config.CONTPConcluirPaquete = Verdadero<BR>      Entonces<BR>        Si Dialogo(<T>ContParalelaEstaSeguro<T>)<BR>        Entonces<BR>          Afectar(<T>CONTP<T>, ContParalela:ContParalela.ID, ContParalela:ContParalela.Mov, ContParalela:ContParalela.MovID, <T>Todo<T>, <T><T>, <T>ContParalela<T>)<BR>        Fin<BR>      Sino<BR>        Afectar(<T>CONTP<T>, ContParalela:ContParalela.ID, ContParalela:ContParalela.Mov, ContParalela:ContParalela.MovID, <T>Todo<T>, <T><T>, <T>ContParalela<T>)<BR>      Fin<BR>    Fin<BR>  Fin<BR>Sino<BR>  Afectar(<T>CONTP<T>, ContParalela:ContParalela.ID, ContParalela:ContParalela.Mov, ContParalela:ContParalela.MovID, <T>Todo<T>, <T><T>, <T>ContParalela<T>)<BR>Fin<BR><BR>Forma.ActualizarArbol(<T>CuentasRegistradas<T>)<BR>Forma.ActualizarArbol(<T>CuentasActualizadas<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, ContParalela:ContParalela.Usuario) y<BR>((ContParalela:ContParalela.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) o<BR>((ContParalela:ContParalela.Estatus=EstatusPendiente) y <BR>fnPuedeAvanzarEstatus(Empresa, <T>CONTP<T>, ContParalela:ContParalela.Mov, ContParalela:ContParalela.Estatus, FormaSituacion, Usuario)))
EjecucionCondicion=ConDatos(ContParalela:ContParalela.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (ContParalela:ContParalela.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CONTP<T>, ContParalela:ContParalela.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CONTP<T>, ContParalela:ContParalela.Mov, ContParalela:ContParalela.ID, Verdadero, ContParalela:ContParalela.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(ContParalela:ContParalela.MovID) y (ContParalela:ContParalela.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, ContParalela:ContParalela.Usuario)
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM ContParalela WHERE ID=:nID<T>, ContParalela:ContParalela.ID))
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
ListaParametros1=ContParalela:ContParalela.ID
Visible=S
TeclaRapida=Alt+F11

Expresion=ReportePantalla(ReporteMovPantalla(<T>CONTP<T>, ContParalela:ContParalela.Mov, ContParalela:ContParalela.Estatus), ContParalela:ContParalela.ID)
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
ListaParametros1=ContParalela:ContParalela.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S

Expresion=ReporteImpresora(ReporteMovImpresora(<T>CONTP<T>, ContParalela:ContParalela.Mov, ContParalela:ContParalela.Estatus), ContParalela:ContParalela.ID)
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
Expresion=Cancelar(<T>CONTP<T>, ContParalela:ContParalela.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>CONTP<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, ContParalela:ContParalela.Usuario) y ConDatos(ContParalela:ContParalela.ID) y ConDatos(ContParalela:ContParalela.MovID) y<BR>(ContParalela:ContParalela.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPorConfirmar, EstatusConcluido,EstatusPendiente))
AntesExpresiones=Asigna( Afectar.Mov, ContParalela:ContParalela.Mov ) <BR> Asigna( Afectar.MovID, ContParalela:ContParalela.MovID )

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


Expresion=Verificar(<T>CONTP<T>, ContParalela:ContParalela.ID,ContParalela:ContParalela.Mov,ContParalela:ContParalela.MovID)
ActivoCondicion=ContParalela:ContParalela.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(ContParalela:ContParalela.Mov)
[Aplica.ContParalela.MovAplica]
Carpeta=Aplica
Clave=ContParalela.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.ContParalela.MovAplicaID]
Carpeta=Aplica
Clave=ContParalela.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).ContParalela.Referencia]
Carpeta=(Carpeta Abrir)
Clave=ContParalela.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

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

[(Carpeta Abrir).ContParalela.Concepto]
Carpeta=(Carpeta Abrir)
Clave=ContParalela.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

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
ActivoCondicion=ConDatos(ContParalela:ContParalela.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.ID, ContParalela:ContParalela.ID)<BR>Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Info.MovID, ContParalela:ContParalela.MovID)
[Aplica.ContParalela.Agente]
Carpeta=Aplica
Clave=ContParalela.Agente
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>CONTP<T>, ContParalela:ContParalela.Mov, ContParalela:ContParalela.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>CONTP<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>CONTP<T>, ContParalela:ContParalela.Mov, ContParalela:ContParalela.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(ContParalela:ContParalela.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.ID, ContParalela:ContParalela.ID)<BR>Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Info.Estatus, ContParalela:ContParalela.Estatus)<BR>Asigna(Info.Situacion, ContParalela:ContParalela.Situacion)
[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ActivoCondicion=ConfigModulo(<T>CONTP<T>,<T>Tiempos<T>)=<T>Si<T>
ConCondicion=S
EjecucionCondicion=ConDatos(ContParalela:ContParalela.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.ID, ContParalela:ContParalela.ID)<BR>Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Info.MovID, ContParalela:ContParalela.MovID)
Visible=S

[(Carpeta Abrir).ContParalela.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=ContParalela.FechaEmision
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
Antes=S
Visible=S

ActivoCondicion=ConDatos(ContParalelaA:ContParalela.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.ID, ContParalelaA:ContParalela.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.ID, ContParalela:ContParalela.ID)<BR>Asigna(Info.Usuario, ContParalela:ContParalela.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(ContParalela:ContParalela.ID)

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
AntesExpresiones=Asigna(Info.Rama, <T>CONTP<T>)<BR>Asigna(Info.Fecha, ContParalela:ContParalela.FechaEmision)<BR>Asigna(Info.ID, ContParalela:ContParalela.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (ContParalela:ContParalela.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, ContParalela:ContParalela.Mov+<T> <T>+ContParalela:ContParalela.MovID)
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

ActivoCondicion=ConDatos(ContParalela:ContParalela.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.ID, ContParalela:ContParalela.ID)
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

Expresion=CopiarMovimiento(<T>CONTP<T>, ContParalela:ContParalela.ID, <T>ContParalela<T>)
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
ClaveAccion=AgentCampos
ActivoCondicion=no FormaBloqueada
Antes=S
RefrescarDespues=S
AntesExpresiones=Asigna(Info.ID, ContParalela:ContParalela.ID)<BR>Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Info.MovID, ContParalela:ContParalela.MovID)
VisibleCondicion=ContParalela:ContParalela.Estatus<>EstatusSinAfectar

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (ContParalela:ContParalela.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(ContParalela:ContParalela.ID),GuardarCambios)
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

[Ficha.ContParalela.UEN]
Carpeta=Ficha
Clave=ContParalela.UEN
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
EjecucionCondicion=ConDatos(ContParalela:ContParalela.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, ContParalela:ContParalela.Proyecto)

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

Expresion=Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Info.Clave, <T>CONTP<T>+ContParalela:ContParalela.ID)<BR>Asigna(Info.Nombre, ContParalela:ContParalela.Mov+<T> <T>+ContParalela:ContParalela.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(ContParalela:ContParalela.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
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

AntesExpresiones=Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.ID, ContParalela:ContParalela.ID)<BR>Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Info.MovID, ContParalela:ContParalela.MovID)<BR>Asigna(Info.Fecha, ContParalela:ContParalela.FechaEmision)<BR>Asigna(Info.Estatus, ContParalela:ContParalela.Estatus)
[Acciones.ComisionBorrador]
Nombre=ComisionBorrador
Boton=0
Menu=&Ver
NombreDesplegar=Origen de la Comisión...
EnMenu=S
Activo=S
TipoAccion=Formas
Antes=S
AntesExpresiones=Asigna(Info.ID, ContParalela:ContParalela.ID)
VisibleCondicion=ContParalela:ContParalela.Estatus=EstatusBorrador

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
EjecucionCondicion=ConDatos(ContParalela:ContParalela.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CONTP<T>)<BR>Asigna(Info.Clave, ContParalela:ContParalela.Mov)

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
EjecucionCondicion=ConDatos(ContParalela:ContParalela.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.Concepto, ContParalela:ContParalela.Concepto)

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

Expresion=Asigna(Info.Forma, <T>CONTP<T>)<BR>Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Info.Nombre, ContParalela:ContParalela.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CONTP<T>, ContParalela:ContParalela.Mov, ContParalela:ContParalela.ID, Falso, ContParalela:ContParalela.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CONTP<T>+ContParalela:ContParalela.ID)<BR>  Asigna(Info.Nombre, ContParalela:ContParalela.Mov+<T> <T>+ContParalela:ContParalela.MovID)<BR>  Asigna(Info.Modulo, <T>CONTP<T>)<BR>  Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      ContParalela:ContParalela.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>CONTP<T>)<BR>Asigna(Info.ID, ContParalela:ContParalela.ID)<BR>Asigna(Info.Mov, ContParalela:ContParalela.Mov)<BR>Asigna(Info.MovID, ContParalela:ContParalela.MovID)

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel y (ContParalela:ContParalela.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
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

FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CONTP<T>, <T>{ContParalela:ContParalela.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CONTP{ContParalela:ContParalela.ID}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>
[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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
ColorFondo=Blanco
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=296
VerValor=310

[Detalle.]
Carpeta=Detalle
ColorFondo=Negro

[(Carpeta Totalizadores).]
Carpeta=(Carpeta Totalizadores)
ColorFondo=Negro

[Detalle.FiscalD.ObligacionFiscal]
Carpeta=Detalle
Clave=FiscalD.ObligacionFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.FiscalD.Importe]
Carpeta=Detalle
Clave=FiscalD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.FiscalD.Tasa]
Carpeta=Detalle
Clave=FiscalD.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.FiscalD.OtrosImpuestos]
Carpeta=Detalle
Clave=FiscalD.OtrosImpuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.FiscalD.Excento]
Carpeta=Detalle
Clave=FiscalD.Excento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.FiscalD.Deducible]
Carpeta=Detalle
Clave=FiscalD.Deducible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.MovNombre]
Carpeta=Detalle
Clave=MovNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris








[Detalle.FiscalD.TipoImpuesto]
Carpeta=Detalle
Clave=FiscalD.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


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





































[Detalle.CalcNeto]
Carpeta=Detalle
Clave=CalcNeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






















[CtaFiltro]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Filtro
Clave=CtaFiltro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalela
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


CondicionVisible=MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.ENVIARCUENTAS)
[CtaFiltro.ContParalela.CuentaD]
Carpeta=CtaFiltro
Clave=ContParalela.CuentaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[CtaFiltro.ContParalela.CuentaA]
Carpeta=CtaFiltro
Clave=ContParalela.CuentaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco





[Lista.Columnas]
0=94















1=-2
2=-2
3=-2
4=-2
5=-2
Empresa=75
BaseDatosRemota=145
EmpresaRemota=105
[CtaFiltro.ContParalela.Nivel]
Carpeta=CtaFiltro
Clave=ContParalela.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco









[Detalle.ListaEnCaptura]
(Inicio)=ContParalelaD.Cuenta
ContParalelaD.Cuenta=ContParalelaD.Descripcion
ContParalelaD.Descripcion=(Fin)

[CuentasRegistradas]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cuentas Registradas
Clave=CuentasRegistradas
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContParalelaDCtaRegistrada
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ContParalela
LlaveLocal=ContParalelaDCtaRegistrada.ID
LlaveMaestra=ContParalela.ID
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

ListaOrden=ContParalelaDCtaRegistrada.Cuenta<TAB>(Acendente)
FiltroPredefinido1=Registradas<BR>Actualizadas
FiltroPredefinido2=ContParalelaD.CtaEstatus = <T>Registrada<T><BR>ContParalelaD.CtaEstatus = <T>Actualizada<T>
FiltroPredefinido3=1<BR>2
FiltroPredefinido=S
FiltroAutoCampo=ContParalelaD.CtaEstatus
FiltroAutoValidar=ContParalelaD.CtaEstatus
FiltroAutoOrden=ContParalelaD.CtaEstatus
FiltroArbolClave=ContParalelaDCtaRegistrada.Cuenta
FiltroArbolValidar=ContParalelaDCtaRegistrada.Descripcion
FiltroArbolRama=ContParalelaDCtaRegistrada.Rama
FiltroArbolAcumulativas=ContParalelaDCtaRegistrada.EsAcumulativa
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=35
FiltroListas=S
FiltroListasRama=CONT
FiltroRespetar=S
FiltroTipo=Arbol
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

FiltroListasAplicaEn=ContParalelaDCtaRegistrada.Cuenta


CondicionVisible=ContParalela:ContParalela.Estatus en(EstatusConcluido, EstatusCancelado) y(MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.ENVIARCUENTAS, CONTP.RECIBIRCUENTA))
[CuentasActualizadas]
Estilo=Hoja
Pestana=S
Clave=CuentasActualizadas
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContParalelaDCtaActualizada
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

PestanaOtroNombre=S
PestanaNombre=Cuentas Actualizadas
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
Detalle=S
VistaMaestra=ContParalela
LlaveLocal=ContParalelaDCtaActualizada.ID
LlaveMaestra=ContParalela.ID
ListaEnCaptura=(Lista)
ListaOrden=ContParalelaDCtaActualizada.Cuenta<TAB>(Acendente)
FiltroPredefinido=S
FiltroArbolClave=ContParalelaDCtaActualizada.Cuenta
FiltroArbolValidar=ContParalelaDCtaActualizada.Descripcion
FiltroArbolRama=ContParalelaDCtaActualizada.Rama
FiltroArbolAcumulativas=ContParalelaDCtaActualizada.EsAcumulativa
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=35
FiltroListas=S
FiltroListasRama=CONT
FiltroListasAplicaEn=ContParalelaDCtaActualizada.Cuenta
FiltroRespetar=S
FiltroTipo=Arbol
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha


BusquedaRapida=S
BusquedaEnLinea=S
BusquedaAncho=20



CondicionVisible=ContParalela:ContParalela.Estatus en(EstatusConcluido, EstatusCancelado) y(MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.ENVIARCUENTAS, CONTP.RECIBIRCUENTA))
[CuentasRegistradas.Columnas]
Cuenta=105
Descripcion=314

[CuentasActualizadas.Columnas]
Cuenta=105
Descripcion=314
























[CuentasRegistradas.ContParalelaDCtaRegistrada.Cuenta]
Carpeta=CuentasRegistradas
Clave=ContParalelaDCtaRegistrada.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CuentasRegistradas.ContParalelaDCtaRegistrada.Descripcion]
Carpeta=CuentasRegistradas
Clave=ContParalelaDCtaRegistrada.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[CuentasActualizadas.ContParalelaDCtaActualizada.Cuenta]
Carpeta=CuentasActualizadas
Clave=ContParalelaDCtaActualizada.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CuentasActualizadas.ContParalelaDCtaActualizada.Descripcion]
Carpeta=CuentasActualizadas
Clave=ContParalelaDCtaActualizada.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


























[Ficha.ContParalela.BaseDatosOrigen]
Carpeta=Ficha
Clave=ContParalela.BaseDatosOrigen
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.ContParalela.EmpresaOrigen]
Carpeta=Ficha
Clave=ContParalela.EmpresaOrigen
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





















[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden	(Acendente)
GrupoOrden	(Acendente)=FormaExtraCampo.Orden	(Acendente)
FormaExtraCampo.Orden	(Acendente)=(Fin)






















[GeneradorFiltro]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Filtro
Clave=GeneradorFiltro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalela
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
CondicionVisible=MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.GENERADORPAQ)
[PaqueteFiltro]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Filtro
Clave=PaqueteFiltro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalela
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco



FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)
CondicionVisible=MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.PAQUETE, CONTP.RECIBIRPAQUETE)
[CtaFiltro.ListaEnCaptura]
(Inicio)=ContParalela.Nivel
ContParalela.Nivel=ContParalela.CuentaD
ContParalela.CuentaD=ContParalela.CuentaA
ContParalela.CuentaA=(Fin)











[GeneradorFiltro.ContParalela.GeneraEjercicio]
Carpeta=GeneradorFiltro
Clave=ContParalela.GeneraEjercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[GeneradorFiltro.ContParalela.GeneraPeriodo]
Carpeta=GeneradorFiltro
Clave=ContParalela.GeneraPeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15













[PaqueteFiltro.ContParalela.GeneraFechaD]
Carpeta=PaqueteFiltro
Clave=ContParalela.GeneraFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PaqueteFiltro.ContParalela.GeneraFechaA]
Carpeta=PaqueteFiltro
Clave=ContParalela.GeneraFechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







































































[Polizas.Cont.FechaEmision]
Carpeta=Polizas
Clave=Cont.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Polizas.Columnas]
MovimientoCont=128
FechaEmision=104









Moneda=64
TipoCambio=64
OrigenTipo=72
Origen=124
OrigenID=64



0=123
1=96
2=109
3=56
4=84

5=-2
6=-2
[Polizas.Cont.Origen]
Carpeta=Polizas
Clave=Cont.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Polizas.Cont.OrigenID]
Carpeta=Polizas
Clave=Cont.OrigenID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
















[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=Polizas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S










[Polizas.ModuloOrigen]
Carpeta=Polizas
Clave=ModuloOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
















































[RecepcionPoliza.ContParalelaD.PolizaEstatus]
Carpeta=RecepcionPoliza
Clave=ContParalelaD.PolizaEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[RecepcionPoliza.Columnas]
0=92
1=125





[PolizaRegistrada]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pólizas Registradas
Clave=PolizaRegistrada
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContParalelaDPolizaRegistrada
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ContParalela
LlaveLocal=ContParalelaDPolizaRegistrada.ID
LlaveMaestra=ContParalela.ID
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

OtroOrden=S
ListaOrden=ContParalelaDPolizaRegistrada.ID<TAB>(Acendente)
IconosNombre=ContParalelaDPolizaRegistrada:ContParalelaDPolizaRegistrada.ContMov+<T> <T>+ContParalelaDPolizaRegistrada:ContParalelaDPolizaRegistrada.ContMovID
CondicionVisible=ContParalela:ContParalela.Estatus en(EstatusConcluido, EstatusCancelado) y(MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.PAQUETE, CONTP.RECIBIRPAQUETE))
[PolizaRegistrada.ContParalelaDPolizaRegistrada.PolizaEstatus]
Carpeta=PolizaRegistrada
Clave=ContParalelaDPolizaRegistrada.PolizaEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[PolizaNoRegistrada]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pólizas No Registradas
Clave=PolizaNoRegistrada
OtroOrden=S
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContParalelaDPolizaNoRegistrada
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ContParalela
LlaveLocal=ContParalelaDPolizaNoRegistrada.ID
LlaveMaestra=ContParalela.ID
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco







ListaEnCaptura=(Lista)
IconosNombre=ContParalelaDPolizaNoRegistrada:ContParalelaDPolizaNoRegistrada.ContMov+<T> <T>+ContParalelaDPolizaNoRegistrada:ContParalelaDPolizaNoRegistrada.ContMovID
CondicionVisible=ContParalela:ContParalela.Estatus en(EstatusConcluido, EstatusCancelado) y(MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.PAQUETE, CONTP.RECIBIRPAQUETE))
[PolizaRegistrada.Columnas]
0=101
1=119

2=93
3=82
4=135
5=152
[PolizaNoRegistrada.Columnas]
0=100













1=121
2=92
3=89
4=120
5=174
[PolizaNoRegistrada.ContParalelaDPolizaNoRegistrada.PolizaEstatus]
Carpeta=PolizaNoRegistrada
Clave=ContParalelaDPolizaNoRegistrada.PolizaEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


























[PolizaRegistrada.ContParalelaDPolizaRegistrada.ContFechaEmision]
Carpeta=PolizaRegistrada
Clave=ContParalelaDPolizaRegistrada.ContFechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[PolizaRegistrada.ContParalelaDPolizaRegistrada.ContOrigen]
Carpeta=PolizaRegistrada
Clave=ContParalelaDPolizaRegistrada.ContOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[PolizaRegistrada.ContParalelaDPolizaRegistrada.ContOrigenID]
Carpeta=PolizaRegistrada
Clave=ContParalelaDPolizaRegistrada.ContOrigenID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco





[PolizaNoRegistrada.ContParalelaDPolizaNoRegistrada.ContFechaEmision]
Carpeta=PolizaNoRegistrada
Clave=ContParalelaDPolizaNoRegistrada.ContFechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[PolizaNoRegistrada.ContParalelaDPolizaNoRegistrada.ContOrigen]
Carpeta=PolizaNoRegistrada
Clave=ContParalelaDPolizaNoRegistrada.ContOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[PolizaNoRegistrada.ContParalelaDPolizaNoRegistrada.ContOrigenID]
Carpeta=PolizaNoRegistrada
Clave=ContParalelaDPolizaNoRegistrada.ContOrigenID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco





















[PolizaRegistrada.ModuloOrigen]
Carpeta=PolizaRegistrada
Clave=ModuloOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[PolizaNoRegistrada.ModuloOrigen]
Carpeta=PolizaNoRegistrada
Clave=ModuloOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco




























[TransformacionFiltro]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Filtro
Clave=TransformacionFiltro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalela
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


CondicionVisible=MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.TRANSFORMACION, CONTP.CIERRE)
[TransformacionFiltro.ContParalela.GeneraEjercicio]
Carpeta=TransformacionFiltro
Clave=ContParalela.GeneraEjercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[TransformacionFiltro.ContParalela.GeneraPeriodo]
Carpeta=TransformacionFiltro
Clave=ContParalela.GeneraPeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[GeneradorFiltro.ListaEnCaptura]
(Inicio)=ContParalela.GeneraEjercicio
ContParalela.GeneraEjercicio=ContParalela.GeneraPeriodo
ContParalela.GeneraPeriodo=(Fin)





[TransformacionFiltro.ContParalela.GeneraEmpresaOrigen]
Carpeta=TransformacionFiltro
Clave=ContParalela.GeneraEmpresaOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EspacioPrevio=S
[TransformacionFiltro.ContParalelaEmpresa.BaseDatosRemota]
Carpeta=TransformacionFiltro
Clave=ContParalelaEmpresa.BaseDatosRemota
Editar=N
3D=S
Pegado=S
Tamano=20
ColorFondo=$00F0F0F0

Efectos=[Negritas]
[TransformacionFiltro.ContParalelaEmpresa.EmpresaRemota]
Carpeta=TransformacionFiltro
Clave=ContParalelaEmpresa.EmpresaRemota
Editar=N
3D=S
Pegado=S
Tamano=20
ColorFondo=$00F0F0F0

Efectos=[Negritas]





[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=ContParalela.Referencia
ContParalela.Referencia=ContParalela.Concepto
ContParalela.Concepto=ContParalela.FechaEmision
ContParalela.FechaEmision=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=PENDIENTE
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
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)































[PolizaD]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=PolizaD
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContParalelaDPoliza
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ContParalela
LlaveLocal=ContParalelaDPoliza.ID
LlaveMaestra=ContParalela.ID
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
ValidarCampos=S
ListaCamposAValidar=Cta.Descripcion
ListaOrden=ContParalelaDPoliza.Renglon<TAB>(Acendente)
CondicionVisible=MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.POLIZA)
ControlRenglon=S
CampoRenglon=ContParalelaDPoliza.Renglon
[PolizaD.Columnas]
Cuenta=104
Debe=107
Haber=125


















[PolizaD.ContParalelaDPoliza.Cuenta]
Carpeta=PolizaD
Clave=ContParalelaDPoliza.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PolizaD.ContParalelaDPoliza.Debe]
Carpeta=PolizaD
Clave=ContParalelaDPoliza.Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[PolizaD.ContParalelaDPoliza.Haber]
Carpeta=PolizaD
Clave=ContParalelaDPoliza.Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









[(Carpeta Totalizadores).Debe]
Carpeta=(Carpeta Totalizadores)
Clave=Debe
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata

Efectos=[Negritas]
[(Carpeta Totalizadores).Haber]
Carpeta=(Carpeta Totalizadores)
Clave=Haber
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata














Efectos=[Negritas]


[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Debe
Debe=Haber
Haber=(Fin)



















[Acciones.Informacion]
Nombre=Informacion
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información de la Cuenta
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaInfo
Activo=S
ConCondicion=S
Antes=S
EspacioPrevio=S




























EjecucionCondicion=ConDatos(ContParalelaDPoliza:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Cuenta, ContParalelaDPoliza:Cta.Cuenta)<BR>Asigna(Info.Origen, <T>Cont<T>)
VisibleCondicion=MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.POLIZA)




[Ficha.ListaEnCaptura]
(Inicio)=ContParalela.Mov
ContParalela.Mov=ContParalela.MovID
ContParalela.MovID=ContParalela.Proyecto
ContParalela.Proyecto=ContParalela.UEN
ContParalela.UEN=ContParalela.FechaEmision
ContParalela.FechaEmision=ContParalela.Concepto
ContParalela.Concepto=ContParalela.BaseDatosOrigen
ContParalela.BaseDatosOrigen=ContParalela.Referencia
ContParalela.Referencia=ContParalela.EmpresaOrigen
ContParalela.EmpresaOrigen=ContParalela.Observaciones
ContParalela.Observaciones=(Fin)




[CuentasActualizadas.ListaEnCaptura]
(Inicio)=ContParalelaDCtaActualizada.Cuenta
ContParalelaDCtaActualizada.Cuenta=ContParalelaDCtaActualizada.Descripcion
ContParalelaDCtaActualizada.Descripcion=(Fin)





[PolizaD.ListaEnCaptura]
(Inicio)=ContParalelaDPoliza.Cuenta
ContParalelaDPoliza.Cuenta=ContParalelaDPoliza.Debe
ContParalelaDPoliza.Debe=ContParalelaDPoliza.Haber
ContParalelaDPoliza.Haber=(Fin)









[Polizas.ListaEnCaptura]
(Inicio)=Cont.FechaEmision
Cont.FechaEmision=ModuloOrigen
ModuloOrigen=Cont.Origen
Cont.Origen=Cont.OrigenID
Cont.OrigenID=(Fin)

[Polizas.ListaOrden]
(Inicio)=ContParalelaD.ID	(Acendente)
ContParalelaD.ID	(Acendente)=ContParalelaD.Renglon	(Acendente)
ContParalelaD.Renglon	(Acendente)=(Fin)





[PolizaRegistrada.ListaEnCaptura]
(Inicio)=ContParalelaDPolizaRegistrada.PolizaEstatus
ContParalelaDPolizaRegistrada.PolizaEstatus=ContParalelaDPolizaRegistrada.ContFechaEmision
ContParalelaDPolizaRegistrada.ContFechaEmision=ModuloOrigen
ModuloOrigen=ContParalelaDPolizaRegistrada.ContOrigen
ContParalelaDPolizaRegistrada.ContOrigen=ContParalelaDPolizaRegistrada.ContOrigenID
ContParalelaDPolizaRegistrada.ContOrigenID=(Fin)





[PolizaTransformada]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pólizas Transformadas
Clave=PolizaTransformada
OtroOrden=S
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContParalelaDPolizaTransformada
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ContParalela
LlaveLocal=ContParalelaDPolizaTransformada.ID
LlaveMaestra=ContParalela.ID
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


IconosNombre=ContParalelaDPolizaTransformada:ContParalelaDPolizaTransformada.ContMov+<T> <T>+ContParalelaDPolizaTransformada:ContParalelaDPolizaTransformada.ContMovID
CondicionVisible=ContParalela:ContParalela.Estatus en(EstatusConcluido, EstatusCancelado) y(MovTipo(<T>CONTP<T>, ContParalela:ContParalela.Mov) en(CONTP.PAQUETE, CONTP.RECIBIRPAQUETE))
[PolizaTransformada.ContParalelaDPolizaTransformada.PolizaEstatus]
Carpeta=PolizaTransformada
Clave=ContParalelaDPolizaTransformada.PolizaEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[PolizaTransformada.ContParalelaDPolizaTransformada.ContFechaEmision]
Carpeta=PolizaTransformada
Clave=ContParalelaDPolizaTransformada.ContFechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[PolizaTransformada.ModuloOrigen]
Carpeta=PolizaTransformada
Clave=ModuloOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[PolizaTransformada.ContParalelaDPolizaTransformada.ContOrigen]
Carpeta=PolizaTransformada
Clave=ContParalelaDPolizaTransformada.ContOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[PolizaTransformada.ContParalelaDPolizaTransformada.ContOrigenID]
Carpeta=PolizaTransformada
Clave=ContParalelaDPolizaTransformada.ContOrigenID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[PolizaNoRegistrada.ListaEnCaptura]
(Inicio)=ContParalelaDPolizaNoRegistrada.PolizaEstatus
ContParalelaDPolizaNoRegistrada.PolizaEstatus=ContParalelaDPolizaNoRegistrada.ContFechaEmision
ContParalelaDPolizaNoRegistrada.ContFechaEmision=ModuloOrigen
ModuloOrigen=ContParalelaDPolizaNoRegistrada.ContOrigen
ContParalelaDPolizaNoRegistrada.ContOrigen=ContParalelaDPolizaNoRegistrada.ContOrigenID
ContParalelaDPolizaNoRegistrada.ContOrigenID=(Fin)


[PolizaTransformada.Columnas]
0=101
1=117
2=91
3=103
4=144
5=132













[PolizaTransformada.ListaEnCaptura]
(Inicio)=ContParalelaDPolizaTransformada.PolizaEstatus
ContParalelaDPolizaTransformada.PolizaEstatus=ContParalelaDPolizaTransformada.ContFechaEmision
ContParalelaDPolizaTransformada.ContFechaEmision=ModuloOrigen
ModuloOrigen=ContParalelaDPolizaTransformada.ContOrigen
ContParalelaDPolizaTransformada.ContOrigen=ContParalelaDPolizaTransformada.ContOrigenID
ContParalelaDPolizaTransformada.ContOrigenID=(Fin)







[CuentasRegistradas.ListaEnCaptura]
(Inicio)=ContParalelaDCtaRegistrada.Cuenta
ContParalelaDCtaRegistrada.Cuenta=ContParalelaDCtaRegistrada.Descripcion
ContParalelaDCtaRegistrada.Descripcion=(Fin)





















[TransformacionFiltro.ContParalela.GeneraMov]
Carpeta=TransformacionFiltro
Clave=ContParalela.GeneraMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EspacioPrevio=S
[TransformacionFiltro.ContParalela.GeneraMovID]
Carpeta=TransformacionFiltro
Clave=ContParalela.GeneraMovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco











Pegado=S
[PaqueteFiltro.ContParalela.GeneraContMov]
Carpeta=PaqueteFiltro
Clave=ContParalela.GeneraContMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[PaqueteFiltro.ContParalela.GeneraContMovID]
Carpeta=PaqueteFiltro
Clave=ContParalela.GeneraContMovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco





Pegado=S







[PaqueteFiltro.ListaEnCaptura]
(Inicio)=ContParalela.GeneraFechaD
ContParalela.GeneraFechaD=ContParalela.GeneraFechaA
ContParalela.GeneraFechaA=ContParalela.GeneraContMov
ContParalela.GeneraContMov=ContParalela.GeneraContMovID
ContParalela.GeneraContMovID=(Fin)

































































[TransformacionFiltro.ListaEnCaptura]
(Inicio)=ContParalela.GeneraEjercicio
ContParalela.GeneraEjercicio=ContParalela.GeneraPeriodo
ContParalela.GeneraPeriodo=ContParalela.GeneraEmpresaOrigen
ContParalela.GeneraEmpresaOrigen=ContParalelaEmpresa.BaseDatosRemota
ContParalelaEmpresa.BaseDatosRemota=ContParalelaEmpresa.EmpresaRemota
ContParalelaEmpresa.EmpresaRemota=ContParalela.GeneraMov
ContParalela.GeneraMov=ContParalela.GeneraMovID
ContParalela.GeneraMovID=(Fin)









































































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=FormaExtraValor
FormaExtraValor=CtaFiltro
CtaFiltro=GeneradorFiltro
GeneradorFiltro=PaqueteFiltro
PaqueteFiltro=TransformacionFiltro
TransformacionFiltro=CuentasRegistradas
CuentasRegistradas=CuentasActualizadas
CuentasActualizadas=PolizaRegistrada
PolizaRegistrada=PolizaNoRegistrada
PolizaNoRegistrada=PolizaTransformada
PolizaTransformada=PolizaD
PolizaD=(Fin)

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
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=Anterior
Anterior=Siguiente
Siguiente=Informacion
Informacion=Anexos
Anexos=ProyInfo
ProyInfo=ComisionBorrador
ComisionBorrador=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
MovPos=Navegador
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
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
