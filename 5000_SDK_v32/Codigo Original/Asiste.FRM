[Forma]
Clave=Asiste
Nombre=<T>Asistencias<T>
Icono=0
Modulos=ASIS
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=361
PosicionInicialArriba=145
PosicionInicialAltura=519
PosicionInicialAncho=718
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
PosicionSeccion1=34
PosicionSeccion2=79
BarraAyuda=S
MovModulo=ASIS
PosicionColumna3=50
BarraAyudaBold=S
PosicionColumna2=60
PosicionInicialAlturaCliente=530
PosicionSec1=176
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.EntradaSalida, <T>Entrada<T>)<BR>Asigna(Info.Referencia, Nulo)

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Asiste
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=81
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

[Ficha.Asiste.Mov]
Carpeta=Ficha
Clave=Asiste.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Asiste.MovID]
Carpeta=Ficha
Clave=Asiste.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Asiste.FechaEmision]
Carpeta=Ficha
Clave=Asiste.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Asiste.Proyecto]
Carpeta=Ficha
Clave=Asiste.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.Asiste.Observaciones]
Carpeta=Ficha
Clave=Asiste.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=59
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
Vista=AsisteA
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
ListaOrden=Asiste.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Asiste.FechaEmision
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
FiltroUsuarioDefault=(Usuario)
FiltroFechasNormal=S
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroUsuarios=S
FiltroMovs=S
FiltroFechasCancelacion=Asiste.FechaCancelacion
FiltroSucursales=S

IconosNombre=AsisteA:Asiste.Mov+<T> <T>+AsisteA:Asiste.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=156
1=85

2=-2
3=-2
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Asiste:Asiste.ID) y (Asiste:Asiste.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Asiste:Asiste.ID, <T>ASIS<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=AsisteD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Asiste
LlaveLocal=AsisteD.ID
LlaveMaestra=Asiste.ID
ControlRenglon=S
CampoRenglon=AsisteD.Renglon
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
ListaOrden=AsisteD.Renglon<TAB>(Acendente)
HojaFondoGrisAuto=S
PermiteLocalizar=S
ValidarCampos=S
ListaCamposAValidar=NombreCompleto
PestanaNombre=Multiples
CarpetaVisible=S
MenuLocal=S
ListaAcciones=Observaciones

[Detalle.Columnas]
Importe=106
Aplica=96
AplicaID=74
AplicaProntoPago=96
Personal=94
Cantidad=50
Porcentaje=40
Periodos=48
FechaInicio=73
FechaTermino=79
Observaciones=126
CantidadPendiente=53
Saldo=106
Estatus=94
Condicion=99
CtaDinero=83
Variable=95
Activo=35
FechaD=97
FechaA=108
Monto=86
Descripcion=106
Referencia=98
Concepto=147
Motivo=191
Calificacion=60
HoraA=50
Duracion=113
Tipo=93
Hora=56
HoraRegistro=60
Minutos=44
Horas=35
Dias=30
Registro=64
HoraD=54
Fecha=72
DiaExtra=51
DiaAusencia=72
MinExtra=59
MinAusencia=73
Proyecto=81
Actividad=72
Costo=79
ActividadEstado=91
ActividadAvance=54
Recurso=76
MovimientoRef=115

Extra=89
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
Totalizadores1=Importe
Totalizadores2=Suma(AsisteD:AsisteD.Importe)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Importe
CarpetaVisible=S

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

Expresion=Asigna(Afectar.ID, Asiste:Asiste.ID)<BR>Asigna(Afectar.Mov, Asiste:Asiste.Mov)<BR>Asigna(Afectar.MovID, Asiste:Asiste.MovID)<BR>Asigna(Afectar.FormaCaptura, <T>Asiste<T>)<BR><BR>Si<BR>  (MovTipo(<T>ASIS<T>, Asiste:Asiste.Mov) = ASIS.C) y (Asiste:Asiste.Estatus = EstatusSinAfectar)<BR>Entonces<BR>  Forma(<T>AsisteGenerarCorte<T>)<BR>Sino<BR>  Si <BR>    MovTipo(<T>ASIS<T>, Asiste:Asiste.Mov) = ASIS.AU <BR>  Entonces <BR>    Dialogo(<T>GenerarAusencia<T>)<BR>  Sino<BR>    Afectar(<T>ASIS<T>, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, Afectar.FormaCaptura)<BR>  Fin<BR>Fin<BR><BR>Si<BR>    (MovTipo(<T>ASIS<T>, Asiste:Asiste.Mov) = ASIS.C) y (Asiste:Asiste.Estatus = EstatusBorrador)<BR>Entonces<BR>    Asigna(Info.ID, Asiste:Asiste.ID)<BR>    ActualizarForma<BR>    Si  SQL(<T>Select AsisteGenerarHorasExtras From EmpresaCfg Where Empresa = :tEmpresa<T>, Empresa ) = Verdadero y<BR>        SQL(<T>Select HerramientaHorasExtra From EmpresaCfg Where Empresa = :tEmpresa<T>, Empresa ) = Verdadero<BR>    Entonces<BR>        FormaModal(<T>AuxAsistenciaHE<T>)<BR>    Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Asiste:Asiste.Usuario) y<BR>(Asiste:Asiste.Estatus en (EstatusSinAfectar, EstatusBorrador)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>ASIS<T>, Asiste:Asiste.Mov, Asiste:Asiste.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Asiste:Asiste.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Asiste:Asiste.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>ASIS<T>, Asiste:Asiste.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>ASIS<T>, Asiste:Asiste.Mov, Asiste:Asiste.ID, Verdadero, Asiste:Asiste.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Asiste:Asiste.MovID) y (Asiste:Asiste.Estatus en (EstatusSinAfectar, EstatusBorrador)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Asiste:Asiste.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Asiste WHERE ID=:nID<T>, Asiste:Asiste.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Asiste:Asiste.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>ASIS<T>, Asiste:Asiste.Mov, Asiste:Asiste.Estatus), Asiste:Asiste.ID)
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
ListaParametros1=Asiste:Asiste.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>ASIS<T>, Asiste:Asiste.Mov, Asiste:Asiste.Estatus), Asiste:Asiste.ID)
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
ActivoCondicion=Asiste:Asiste.Estatus=EstatusSinAfectar

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
Expresion=Cancelar(<T>ASIS<T>, Asiste:Asiste.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>ASIS<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Asiste:Asiste.Usuario) y ConDatos(Asiste:Asiste.ID) y ConDatos(Asiste:Asiste.MovID) y <BR>((Asiste:Asiste.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusProcesar, EstatusBorrador)) o (MovTipoEn(<T>ASIS<T>, Asiste:Asiste.Mov, (ASIS.C, ASIS.RA)) y (Asiste:Asiste.Estatus=EstatusConcluido)))
AntesExpresiones=Asigna( Afectar.Mov, Asiste:Asiste.Mov ) <BR>Asigna( Afectar.MovID, Asiste:Asiste.MovID )

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
Expresion=Verificar(<T>ASIS<T>, Asiste:Asiste.ID,Asiste:Asiste.Mov,Asiste:Asiste.MovID)
ActivoCondicion=Asiste:Asiste.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Asiste:Asiste.Mov)

[Acciones.Infomacion]
Nombre=Infomacion
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información de la Persona
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Visible=S
ClaveAccion=PersonalInfo
EjecucionCondicion=ConDatos(AsisteD:AsisteD.Personal)
Antes=S
AntesExpresiones=Asigna(Info.Personal, AsisteD:AsisteD.Personal)

[Aplica.Asiste.MovAplica]
Carpeta=Aplica
Clave=Asiste.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.Asiste.MovAplicaID]
Carpeta=Aplica
Clave=Asiste.MovAplicaID
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
ActivoCondicion=ConDatos(Asiste:Asiste.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, Asiste:Asiste.ID)<BR>Asigna(Info.Mov, Asiste:Asiste.Mov)<BR>Asigna(Info.MovID, Asiste:Asiste.MovID)
[Aplica.Asiste.Proveedor]
Carpeta=Aplica
Clave=Asiste.Proveedor
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>ASIS<T>, Asiste:Asiste.Mov, Asiste:Asiste.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>ASIS<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>ASIS<T>, Asiste:Asiste.Mov, Asiste:Asiste.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Asiste:Asiste.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, Asiste:Asiste.ID)<BR>Asigna(Info.Mov, Asiste:Asiste.Mov)<BR>Asigna(Info.Estatus, Asiste:Asiste.Estatus)<BR>Asigna(Info.Situacion, Asiste:Asiste.Situacion)
DespuesGuardar=S
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
ActivoCondicion=ConfigModulo(<T>ASIS<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Asiste:Asiste.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, Asiste:Asiste.ID)<BR>Asigna(Info.Mov, Asiste:Asiste.Mov)<BR>Asigna(Info.MovID, Asiste:Asiste.MovID)

[(Carpeta Abrir).Asiste.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Asiste.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(AsisteA:Asiste.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, AsisteA:Asiste.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, Asiste:Asiste.ID)<BR>Asigna(Info.Usuario, Asiste:Asiste.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Asiste:Asiste.ID)

[Detalle.AsisteD.Personal]
Carpeta=Detalle
Clave=AsisteD.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Abrir).Asiste.Observaciones]
Carpeta=(Carpeta Abrir)
Clave=Asiste.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[Condiciones.Asiste.Personal]
Carpeta=Condiciones
Clave=Asiste.Personal
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

[Condiciones.Asiste.Importe]
Carpeta=Condiciones
Clave=Asiste.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Asiste.Saldo]
Carpeta=Condiciones
Clave=Asiste.Saldo
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Condiciones.Asiste.CondicionVeces]
Carpeta=Condiciones
Clave=Asiste.CondicionVeces
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Condiciones.Asiste.CondicionFechaD]
Carpeta=Condiciones
Clave=Asiste.CondicionFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Asiste.CondicionFechaA]
Carpeta=Condiciones
Clave=Asiste.CondicionFechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Asiste.CondicionPorcentaje]
Carpeta=Condiciones
Clave=Asiste.CondicionPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Asiste.CondicionMonto]
Carpeta=Condiciones
Clave=Asiste.CondicionMonto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Asiste.CtaDinero]
Carpeta=Condiciones
Clave=Asiste.CtaDinero
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
Expresion=DesAfectar(<T>ASIS<T>, Asiste:Asiste.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>ASIS<T>)
ActivoCondicion=Usuario.Desafectar y (Asiste:Asiste.Estatus = EstatusProcesar)
AntesExpresiones=Asigna(Afectar.Mov, Asiste:Asiste.Mov)<BR>Asigna(Afectar.MovID, Asiste:Asiste.MovID)

[Detalle.AsisteD.FechaD]
Carpeta=Detalle
Clave=AsisteD.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AsisteD.Registro]
Carpeta=Detalle
Clave=AsisteD.Registro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.AsisteD.HoraRegistro]
Carpeta=Detalle
Clave=AsisteD.HoraRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AsisteD.FechaA]
Carpeta=Detalle
Clave=AsisteD.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AsisteD.HoraD]
Carpeta=Detalle
Clave=AsisteD.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AsisteD.HoraA]
Carpeta=Detalle
Clave=AsisteD.HoraA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Ficha.Asiste.Localidad]
Carpeta=Ficha
Clave=Asiste.Localidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Asiste.Localidad]
Carpeta=(Carpeta Abrir)
Clave=Asiste.Localidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.Asiste.Tipo]
Carpeta=Ficha
Clave=Asiste.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
LineaNueva=N
Pegado=N

[Detalle.AsisteD.Concepto]
Carpeta=Detalle
Clave=AsisteD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.Asiste.FechaD]
Carpeta=Ficha
Clave=Asiste.FechaD
Editar=N
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Asiste.FechaA]
Carpeta=Ficha
Clave=Asiste.FechaA
Editar=N
ValidaNombre=N
3D=S
Tamano=16
ColorFondo=Plata
ColorFuente=Negro

[Detalle.AsisteD.Fecha]
Carpeta=Detalle
Clave=AsisteD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AsisteD.Cantidad]
Carpeta=Detalle
Clave=AsisteD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AsisteD.Tipo]
Carpeta=Detalle
Clave=AsisteD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Asiste.Referencia]
Carpeta=Ficha
Clave=Asiste.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Observaciones]
Nombre=Observaciones
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Expresion
Expresion=Si(Asiste:Asiste.Estatus en (EstatusConcluido, EstatusCancelado), Informacion(AsisteD:AsisteD.Observaciones), Pregunta(AsisteD:AsisteD.Observaciones))
Activo=S
Visible=S

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
ClaveAccion=AnexoMov
Activo=S
Visible=S
Antes=S
EnBarraHerramientas=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>ASIS<T>)<BR>Asigna(Info.Fecha, Asiste:Asiste.FechaEmision)<BR>Asigna(Info.ID, Asiste:Asiste.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Asiste:Asiste.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Asiste:Asiste.Mov+<T> <T>+Asiste:Asiste.MovID)

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
ActivoCondicion=ConDatos(Asiste:Asiste.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, Asiste:Asiste.ID)

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
UsaTeclaRapida=S
TeclaRapida=Mayús+F11
NombreDesplegar=&Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=CopiarMovimiento(<T>ASIS<T>, Asiste:Asiste.ID, <T>Asiste<T>)

[Acciones.AbrirLocalizar]
Nombre=AbrirLocalizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
EspacioPrevio=S

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Asiste:Asiste.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Asiste:Asiste.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0
EspacioPrevio=S

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

[Ficha.Asiste.UEN]
Carpeta=Ficha
Clave=Asiste.UEN
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
EjecucionCondicion=ConDatos(Asiste:Asiste.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Asiste:Asiste.Proyecto)
Visible=S

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.Mov, Asiste:Asiste.Mov)<BR>Asigna(Info.Clave, <T>ASIS<T>+Asiste:Asiste.ID)<BR>Asigna(Info.Nombre, Asiste:Asiste.Mov+<T> <T>+Asiste:Asiste.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Asiste:Asiste.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

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
AntesExpresiones=Asigna(Info.PuedeEditar, Asiste:Asiste.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Asiste:Asiste.Mov)<BR>Asigna(Info.MovID, Asiste:Asiste.MovID)<BR>Asigna(Info.Proyecto, Asiste:Asiste.Proyecto)<BR>Asigna(Info.UEN, Asiste:Asiste.UEN)<BR>Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, Asiste:Asiste.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, Asiste:Asiste.ID)<BR>Asigna(Info.Mov, Asiste:Asiste.Mov)<BR>Asigna(Info.MovID, Asiste:Asiste.MovID)<BR>Asigna(Info.Fecha, Asiste:Asiste.FechaEmision)<BR>Asigna(Info.Estatus, Asiste:Asiste.Estatus)

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
EjecucionCondicion=ConDatos(Asiste:Asiste.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>ASIS<T>)<BR>Asigna(Info.Clave, Asiste:Asiste.Mov)

[Acciones.PoliticaConcepto]
Nombre=PoliticaConcepto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+N
NombreDesplegar=&Política Concepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Asiste:Asiste.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.Concepto, Asiste:Asiste.Concepto)

[Detalle.AsisteD.Proyecto]
Carpeta=Detalle
Clave=AsisteD.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.AsisteD.Actividad]
Carpeta=Detalle
Clave=AsisteD.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.AsisteD.Costo]
Carpeta=Detalle
Clave=AsisteD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>Asiste<T>)<BR>Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.Mov, Asiste:Asiste.Mov)<BR>Asigna(Info.Nombre, Asiste:Asiste.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>ASIS<T>, Asiste:Asiste.Mov, Asiste:Asiste.ID, Falso, Asiste:Asiste.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>ASIS<T>+Asiste:Asiste.ID)<BR>  Asigna(Info.Nombre, Asiste:Asiste.Mov+<T> <T>+Asiste:Asiste.MovID)<BR>  Asigna(Info.Modulo, <T>ASIS<T>)<BR>  Asigna(Info.Mov, Asiste:Asiste.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Asiste:Asiste.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Ficha.Asiste.FechaAplicacion]
Carpeta=Ficha
Clave=Asiste.FechaAplicacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, Asiste:Asiste.ID)<BR>Asigna(Info.Mov, Asiste:Asiste.Mov)<BR>Asigna(Info.MovID, Asiste:Asiste.MovID)
DespuesGuardar=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel y (Asiste:Asiste.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Detalle.AsisteD.ActividadEstado]
Carpeta=Detalle
Clave=AsisteD.ActividadEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.AsisteD.ActividadAvance]
Carpeta=Detalle
Clave=AsisteD.ActividadAvance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AsisteD.Observaciones]
Carpeta=Detalle
Clave=AsisteD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>ASIS<T>, <T>{Asiste:Asiste.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>ASIS{Asiste:Asiste.ID}<T>

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
VerCampo=330
VerValor=330

[Detalle.AsisteD.Recurso]
Carpeta=Detalle
Clave=AsisteD.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.AsisteD.MovimientoRef]
Carpeta=Detalle
Clave=AsisteD.MovimientoRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[Ficha.ListaEnCaptura]
(Inicio)=Asiste.Mov
Asiste.Mov=Asiste.MovID
Asiste.MovID=Asiste.Proyecto
Asiste.Proyecto=Asiste.UEN
Asiste.UEN=Asiste.FechaEmision
Asiste.FechaEmision=Asiste.FechaAplicacion
Asiste.FechaAplicacion=Asiste.Localidad
Asiste.Localidad=Asiste.Tipo
Asiste.Tipo=Asiste.Referencia
Asiste.Referencia=Asiste.FechaD
Asiste.FechaD=Asiste.FechaA
Asiste.FechaA=Asiste.Observaciones
Asiste.Observaciones=(Fin)




[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)









[Detalle.ListaEnCaptura]
(Inicio)=AsisteD.Recurso
AsisteD.Recurso=AsisteD.Personal
AsisteD.Personal=AsisteD.Registro
AsisteD.Registro=AsisteD.FechaD
AsisteD.FechaD=AsisteD.FechaA
AsisteD.FechaA=AsisteD.Fecha
AsisteD.Fecha=AsisteD.HoraRegistro
AsisteD.HoraRegistro=AsisteD.HoraD
AsisteD.HoraD=AsisteD.HoraA
AsisteD.HoraA=AsisteD.Cantidad
AsisteD.Cantidad=AsisteD.Tipo
AsisteD.Tipo=AsisteD.Concepto
AsisteD.Concepto=AsisteD.MovimientoRef
AsisteD.MovimientoRef=AsisteD.Proyecto
AsisteD.Proyecto=AsisteD.Actividad
AsisteD.Actividad=AsisteD.ActividadAvance
AsisteD.ActividadAvance=AsisteD.ActividadEstado
AsisteD.ActividadEstado=AsisteD.Costo
AsisteD.Costo=AsisteD.Observaciones
AsisteD.Observaciones=AsisteD.Extra
AsisteD.Extra=AsisteD.GestionRef
AsisteD.GestionRef=AsisteD.ActividadABCRef
AsisteD.ActividadABCRef=(Fin)

[Detalle.AsisteD.Extra]
Carpeta=Detalle
Clave=AsisteD.Extra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AsisteD.GestionRef]
Carpeta=Detalle
Clave=AsisteD.GestionRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.AsisteD.ActividadABCRef]
Carpeta=Detalle
Clave=AsisteD.ActividadABCRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[Lista.Columnas]
0=106
1=301
2=-2

















































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

























[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Asiste.FechaEmision
Asiste.FechaEmision=Asiste.Localidad
Asiste.Localidad=Asiste.Observaciones
Asiste.Observaciones=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=BORRADOR
BORRADOR=PROCESAR
PROCESAR=CONCLUIDO
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
Eliminar=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=CamposExtras
CamposExtras=Totalizar
Totalizar=Tareas
Tareas=Anexos
Anexos=Anterior
Anterior=Siguiente
Siguiente=Infomacion
Infomacion=ProyInfo
ProyInfo=Tiempo
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

