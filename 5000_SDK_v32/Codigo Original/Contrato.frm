[Forma]
Clave=Contrato
Nombre=<T>Contrato<T>
Icono=0
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=304
PosicionInicialArriba=74
PosicionInicialAltura=581
PosicionInicialAncho=832
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
PosicionSeccion1=32
PosicionSeccion2=93
BarraAyuda=S
MovModulo=PACTO
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
PosicionColumna2=77
PosicionInicialAlturaCliente=673
PosicionSec1=201
PosicionSec2=605
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.EsNuevo, Falso)
ExpresionesAlCerrar=Asigna(Info.EsNuevo, Falso)
PosicionCol2=731
PosicionCol3=426

Modulos=PACTO
PosicionCol1=309
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Contrato
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
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Pestana=S
PermiteEditar=S

[Ficha.Contrato.Mov]
Carpeta=Ficha
Clave=Contrato.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Contrato.MovID]
Carpeta=Ficha
Clave=Contrato.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=11
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Contrato.FechaEmision]
Carpeta=Ficha
Clave=Contrato.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N





[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=ContratoA
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
ListaOrden=Contrato.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Contrato.Hasta
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
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroUsuarios=S
FiltroMovs=S
FiltroFechasCancelacion=Contrato.FechaCancelacion
FiltroSucursales=S

FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
IconosNombre=ContratoA:Contrato.Mov+<T> <T>+ContratoA:Contrato.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=148
1=83
2=153
3=79
4=76
5=63
6=47
7=46
8=56
9=46

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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Contrato:Contrato.ID) y (Contrato:Contrato.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Contrato:Contrato.ID, <T>PACTO<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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
Importe=106
Aplica=96
AplicaID=74
AplicaProntoPago=96
Personal=125
Cantidad=51
Porcentaje=51
Periodos=48
FechaInicio=73
FechaTermino=79
Observaciones=153
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
Referencia=57
Concepto=104
Categoria=118
Departamento=122
Puesto=108
Grupo=101
Motivo=153
Calificacion=60
Articulo=124
Actual=99
Anterior=86
Nuevo=91
Diferencia=91
%Diferencia=64
DiferenciaPorcentaje=56
Contrato=218
Serie=176
Tipo=86
Precio=104
FechaEmision=94
Asunto=251
Estado=90
Tiempo=40
Prioridad=47
Completada=75
Vencimiento=64
Usuario=66
Duracion=46
Orden=36
Numero=42
Predecedoras=69
TiempoUnidad=37
TieneDetalle=37
0=96
1=347
2=81
3=-2
4=-2
5=-2
6=76
7=84
8=63
Actividad=53
Predecesora=65
DuracionUnidad=39
DuracionDias=50
Desde=82
Hasta=79
Avance=43
Familia=154
EsFase=29
EstaLiberado=45
EsNuevo=64
Clave=59
Indicador=64
IndicadorNombre=49
RecursosAsignados=107

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
Totalizadores1=Conteo
Totalizadores2=Conteo(ContratoD:ContratoD.Actividad)
Totalizadores3=
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Conteo
CarpetaVisible=S
FichaAlineacionDerecha=S

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

Expresion=Asigna(Afectar.Modulo, <T>PACTO<T>)<BR>Asigna(Afectar.ID, Contrato:Contrato.ID)<BR>Asigna(Afectar.Mov, Contrato:Contrato.Mov)<BR>Asigna(Afectar.MovID, Contrato:Contrato.MovID)<BR>Asigna(Afectar.GenerarMov, Nulo)<BR>Asigna(Afectar.FormaCaptura, Contrato:Contrato.Mov)<BR>Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.MovGenerar, Nulo)<BR>Asigna(Info.Estatus, SQL(<T>SELECT Estatus FROM Contrato WHERE ID=:nID<T>, Contrato:Contrato.ID))<BR><BR>Si<BR> Info.Estatus en (EstatusPendiente, EstatusVigente, EstatusVencido, EstatusConcluido)<BR>Entonces<BR>  /*<BR>  Si<BR>    Precaucion(<T>¿ Esta Seguro que Desea Reestructurar el Movimiento <T>+Afectar.Mov+<T> <T>+Afectar.MovID+<T> ?<T>, BotonSi, BotonNo)=BotonSi<BR>  Entonces<BR>    Generar(<T>PACTO<T>, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.Mov, Afectar.FormaCaptura)<BR>    Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>,<T>Contrato<T>,Afectar.FormaCaptura)<BR>  Fin<BR>  */<BR>  Dialogo(<T>GenerarContrato2<T>)<BR>Sino<BR>  /*<BR>  Si Info.Estatus en (EstatusVigente, EstatusConcluido) Entonces<BR>    Si Confirmacion(<T>Desea Renovar Contrato<T>, BotonSi, BotonNo) = BotonSi Entonces<BR>      //ProcesarSQL(<T>EXEC spMovCopiar :nSucursal, :tModulo, :nID, :tUsuario, :tFechaTrabajo, @Sub = 1, @GenerarMov = :tGenerarMov<T>,<BR>      //            Contrato:Contrato.Sucursal, <T>PACTO<T>, Contrato:Contrato.ID, Usuario, FechaTrabajo, <T>Renovacion<T>)<BR>      Asigna(Afectar.GenerarMov, Contrato:Contrato.Mov)<BR>      Generar(<T>PACTO<T>, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR><BR>    Fin<BR>  Fin<BR>  */<BR>  Si<BR>    Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>  Entonces<BR>    //ContratoRecalcular(Contrato:Contrato.ID)<BR>    Afectar(<T>PACTO<T>, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Contrato:Contrato.Usuario) y<BR>(Contrato:Contrato.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente, EstatusVigente, EstatusVencido, EstatusConcluido)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>PACTO<T>, Contrato:Contrato.Mov, Contrato:Contrato.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Contrato:Contrato.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Contrato:Contrato.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>PACTO<T>, Contrato:Contrato.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>PACTO<T>, Contrato:Contrato.Mov, Contrato:Contrato.ID, Verdadero, Contrato:Contrato.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=(Contrato:Contrato.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Contrato:Contrato.Usuario)

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Contrato:Contrato.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>PACTO<T>, Contrato:Contrato.Mov, Contrato:Contrato.Estatus), Contrato:Contrato.ID)
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
ListaParametros1=Contrato:Contrato.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>PACTO<T>, Contrato:Contrato.Mov, Contrato:Contrato.Estatus), Contrato:Contrato.ID)
ActivoCondicion=Usuario.ImprimirMovs


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
Expresion=Cancelar(<T>PACTO<T>, Contrato:Contrato.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>PACTO<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Contrato:Contrato.Usuario) y ConDatos(Contrato:Contrato.ID) y ConDatos(Contrato:Contrato.MovID) y<BR>(Contrato:Contrato.Estatus en (EstatusSincro, EstatusPendiente, EstatusVigente))
AntesExpresiones=Asigna( Afectar.Mov, Contrato:Contrato.Mov ) <BR>Asigna( Afectar.MovID, Contrato:Contrato.MovID )

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
Expresion=Verificar(<T>PACTO<T>, Contrato:Contrato.ID,Contrato:Contrato.Mov,Contrato:Contrato.MovID)
ActivoCondicion=Contrato:Contrato.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(Contrato:Contrato.Mov)


[Aplica.Contrato.MovAplica]
Carpeta=Aplica
Clave=Contrato.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.Contrato.MovAplicaID]
Carpeta=Aplica
Clave=Contrato.MovAplicaID
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
ActivoCondicion=ConDatos(Contrato:Contrato.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.MovID, Contrato:Contrato.MovID)
[Aplica.Contrato.Proveedor]
Carpeta=Aplica
Clave=Contrato.Proveedor
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>PACTO<T>, Contrato:Contrato.Mov, Contrato:Contrato.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>PACTO<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>PACTO<T>, Contrato:Contrato.Mov, Contrato:Contrato.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Contrato:Contrato.ID),GuardarCambios)<BR><BR><BR>Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.Estatus, Contrato:Contrato.Estatus)<BR>Asigna(Info.Situacion, Contrato:Contrato.Situacion)
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
ActivoCondicion=ConfigModulo(<T>PACTO<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Contrato:Contrato.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.MovID, Contrato:Contrato.MovID)

[(Carpeta Abrir).Contrato.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Contrato.FechaEmision
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
ActivoCondicion=ConDatos(ContratoA:Contrato.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.ID, ContratoA:Contrato.ID)
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

AntesExpresiones=Asigna(Info.Rama, <T>PACTO<T>)<BR>Asigna(Info.Fecha, Contrato:Contrato.FechaEmision)<BR>Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Contrato:Contrato.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Contrato:Contrato.Mov+<T> <T>+Contrato:Contrato.MovID)
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
ActivoCondicion=ConDatos(Contrato:Contrato.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.ID, Contrato:Contrato.ID)

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
Expresion=CopiarMovimiento(<T>PACTO<T>, Contrato:Contrato.ID, <T>Contrato<T>)

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Contrato:Contrato.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Contrato:Contrato.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=5
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

Boton=0
NombreDesplegar=Imprimir Documento
Activo=S
Visible=S
Expresion=Forma.ImprimirMemo(<T>Documento<T>, <T>Contrato.Documento<T>)
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

[Ficha.Contrato.UEN]
Carpeta=Ficha
Clave=Contrato.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N

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
Expresion=Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.Clave, <T>PACTO<T>+Contrato:Contrato.ID)<BR>Asigna(Info.Nombre, Contrato:Contrato.Mov+<T> <T>+Contrato:Contrato.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Contrato:Contrato.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))


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
AntesExpresiones=Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.MovID, Contrato:Contrato.MovID)<BR>Asigna(Info.Fecha, Contrato:Contrato.FechaEmision)<BR>Asigna(Info.Estatus, Contrato:Contrato.Estatus)

[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+O
NombreDesplegar=P&olítica Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Contrato:Contrato.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>PACTO<T>)<BR>Asigna(Info.Clave, Contrato:Contrato.Mov)

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
EjecucionCondicion=ConDatos(Contrato:Contrato.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.Concepto, Contrato:Contrato.Concepto)

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>PACTO<T>)<BR>Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.Nombre, Contrato:Contrato.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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

Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>PACTO<T>, Contrato:Contrato.Mov, Contrato:Contrato.ID, Falso, Contrato:Contrato.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>PACTO<T>+Contrato:Contrato.ID)<BR>  Asigna(Info.Nombre, Contrato:Contrato.Mov+<T> <T>+Contrato:Contrato.MovID)<BR>  Asigna(Info.Modulo, <T>PACTO<T>)<BR>  Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Contrato:Contrato.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin
[Acciones.FormasAnexas]
Nombre=FormasAnexas
Boton=34
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F10
NombreDesplegar=Formas Anexas
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovFormaAnexo
Antes=S
DespuesGuardar=S
Visible=S
Activo=S
AntesExpresiones=Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.MovID, Contrato:Contrato.MovID)
[Observaciones.ContratoD.Observaciones]
Carpeta=Observaciones
Clave=ContratoD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20x10
ColorFondo=Blanco
ColorFuente=Negro
[Observaciones.Columnas]
Observaciones=604



[Acuerdos.ContratoAcuerdo.Asunto]
Carpeta=Acuerdos
Clave=ContratoAcuerdo.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro
[Acuerdos.ContratoAcuerdo.Tipo]
Carpeta=Acuerdos
Clave=ContratoAcuerdo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acuerdos.Columnas]
0=49
1=570
2=98

[Cliente]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cliente
Clave=Cliente
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Contrato
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Contrato.Cliente<BR>Cte.Nombre
CondicionVisible=Contrato:Contrato.ContactoTipo=<T>Cliente<T>
[Cliente.Contrato.Cliente]
Carpeta=Cliente
Clave=Contrato.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Cliente.Cte.Nombre]
Carpeta=Cliente
Clave=Cte.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=75
ColorFondo=Plata
ColorFuente=Negro

[Proveedor]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Proveedor
Clave=Proveedor
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Contrato
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
PermiteEditar=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=Contrato.Proveedor<BR>Prov.Nombre
CondicionVisible=Contrato:Contrato.ContactoTipo=<T>Proveedor<T>
[Proveedor.Contrato.Proveedor]
Carpeta=Proveedor
Clave=Contrato.Proveedor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco
[Proveedor.Prov.Nombre]
Carpeta=Proveedor
Clave=Prov.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=75
ColorFondo=Plata
ColorFuente=Negro
[Personal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Personal
Clave=Personal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Contrato
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Contrato.Personal<BR>PersonalNombre
CondicionVisible=Contrato:Contrato.ContactoTipo=<T>Personal<T>
[Personal.Contrato.Personal]
Carpeta=Personal
Clave=Contrato.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Personal.PersonalNombre]
Carpeta=Personal
Clave=PersonalNombre
Editar=S
ValidaNombre=N
3D=S
Tamano=75
ColorFondo=Plata
ColorFuente=Negro
[Agente]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agente
Clave=Agente
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Contrato
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Contrato.Agente<BR>Agente.Nombre
CondicionVisible=Contrato:Contrato.ContactoTipo=<T>Agente<T>
[Agente.Contrato.Agente]
Carpeta=Agente
Clave=Contrato.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Agente.Agente.Nombre]
Carpeta=Agente
Clave=Agente.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=75
ColorFondo=Plata
ColorFuente=Negro
[Contrato.Contrato.Contrato]
Carpeta=Contrato
Clave=Contrato.Contrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro


[Planes.ContratoPlan.Asunto]
Carpeta=Planes
Clave=ContratoPlan.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro


[Planes.Columnas]
0=49
1=501
2=67
3=94

[Planes.ContratoPlan.Prioridad]
Carpeta=Planes
Clave=ContratoPlan.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Planes.ContratoPlan.Vencimiento]
Carpeta=Planes
Clave=ContratoPlan.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Prospecto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Prospecto
Clave=Prospecto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Contrato
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Contrato.Prospecto<BR>Prospecto.Nombre
CondicionVisible=Contrato:Contrato.ContactoTipo=<T>Prospecto<T>
[Prospecto.Contrato.Prospecto]
Carpeta=Prospecto
Clave=Contrato.Prospecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Ficha.Contrato.Desde]
Carpeta=Ficha
Clave=Contrato.Desde
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro
[Ficha.Contrato.Hasta]
Carpeta=Ficha
Clave=Contrato.Hasta
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
Pegado=S
Editar=S
ColorFondo=Blanco

[(Carpeta Abrir).Contrato.Desde]
Carpeta=(Carpeta Abrir)
Clave=Contrato.Desde
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
[(Carpeta Abrir).Contrato.Hasta]
Carpeta=(Carpeta Abrir)
Clave=Contrato.Hasta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Ficha.Contrato.Moneda]
Carpeta=Ficha
Clave=Contrato.Moneda
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S
ValidaNombre=S
[Ficha.Contrato.TipoCambio]
Carpeta=Ficha
Clave=Contrato.TipoCambio
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro
[OtrosDatos.Contrato.Prioridad]
Carpeta=OtrosDatos
Clave=Contrato.Prioridad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N
[OtrosDatos.Contrato.DiasHabiles]
Carpeta=OtrosDatos
Clave=Contrato.DiasHabiles
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S
[OtrosDatos.Contrato.HorasDia]
Carpeta=OtrosDatos
Clave=Contrato.HorasDia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[OtrosDatos.Contrato.MontoEstimado]
Carpeta=OtrosDatos
Clave=Contrato.MontoEstimado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N
[OtrosDatos.Contrato.FechaEstimada]
Carpeta=OtrosDatos
Clave=Contrato.FechaEstimada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
[OtrosDatos.Contrato.Probabilidad]
Carpeta=OtrosDatos
Clave=Contrato.Probabilidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prospecto.Prospecto.Nombre]
Carpeta=Prospecto
Clave=Prospecto.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Plata
ColorFuente=Negro
[OtrosDatos.Contrato.ContactoTipo]
Carpeta=OtrosDatos
Clave=Contrato.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
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
ListaEnCaptura=VerCampo<BR>VerValor
ListaOrden=GrupoOrden<TAB>(Acendente)<BR>FormaExtraCampo.Orden<TAB>(Acendente)
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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>PACTO<T>, <T>{Contrato:Contrato.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>PACTO{Contrato:Contrato.ID}<T>
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
[Detalle.Asunto]
Carpeta=Detalle
Clave=Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Actividades.Columnas]
0=97
1=234
2=102
3=114
[Detalle.ContratoD.Tipo]
Carpeta=Detalle
Clave=ContratoD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.ActDetalle]
Nombre=ActDetalle
Boton=0
NombreDesplegar=&Detalles
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActDetalle
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ContratoD:ContratoD.ID)
AntesExpresiones=Asigna(Info.ID, ContratoD:ContratoD.ID)
[Detalle.ContratoD.Prioridad]
Carpeta=Detalle
Clave=ContratoD.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Detalle.ContratoD.Categoria]
Carpeta=Detalle
Clave=ContratoD.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[Detalle.ContratoD.Grupo]
Carpeta=Detalle
Clave=ContratoD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[Detalle.ContratoD.Familia]
Carpeta=Detalle
Clave=ContratoD.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.Comentarios]
Nombre=Comentarios
Boton=0
NombreDesplegar=&Comentarios
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActComentarios
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(ContratoD:ContratoD.Actividad)
AntesExpresiones=Asigna(Info.ID, ContratoD:ContratoD.ID)<BR>Asigna(Info.Actividad, ContratoD:ContratoD.Actividad)<BR>Asigna(Info.Asunto, ContratoD:ContratoD.Asunto)
[Acciones.RecursosDetalle]
Nombre=RecursosDetalle
Boton=0
NombreDesplegar=&Recursos
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActRecurso
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ContratoD:ContratoD.Actividad)
AntesExpresiones=Asigna(Info.ID, ContratoD:ContratoD.ID)<BR>Asigna(Info.Actividad, ContratoD:ContratoD.Actividad)<BR>Asigna(Info.Asunto, ContratoD:ContratoD.Asunto)
[Acciones.ActDetalle1]
Nombre=ActDetalle1
Boton=0
EsDefault=S
NombreDesplegar=&Detalle
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActDetalle
Visible=S
Antes=S
RefrescarDespues=S
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
ActivoCondicion=Contrato:Contrato.Estatus = EstatusPendiente
AntesExpresiones=Asigna(Info.ID, Act:ContratoD.ID)
[Acciones.ActRecursoD]
Nombre=ActRecursoD
Boton=0
NombreDesplegar=&Recursos de la Actividad
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActRecurso
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.ID, Act:ContratoD.ID)<BR>Asigna(Info.Actividad, Act:ContratoD.Asunto)
Visible=S

[Detalle.ContratoD.Actividad]
Carpeta=Detalle
Clave=ContratoD.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Detalle.ContratoD.Predecesora]
Carpeta=Detalle
Clave=ContratoD.Predecesora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Detalle.ContratoD.Asunto]
Carpeta=Detalle
Clave=ContratoD.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Detalle.ContratoD.Duracion]
Carpeta=Detalle
Clave=ContratoD.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Detalle.ContratoD.DuracionUnidad]
Carpeta=Detalle
Clave=ContratoD.DuracionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ComentariosD]
Nombre=ComentariosD
Boton=0
NombreDesplegar=&Comentarios
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ContratoDComentarios
Activo=S
Visible=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.Actividad, ContratoD:ContratoD.Actividad)<BR>Asigna(Info.Contrato, Contrato:Contrato.Contrato)<BR>Asigna(Info.Estatus, Contrato:Contrato.Estatus)

[Acciones.RecursoD]
Nombre=RecursoD
Boton=0
NombreDesplegar=&Recursos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ContratoDRecurso
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.ID, ContratoD:ContratoD.ID)<BR> Asigna(Info.Actividad, ContratoD:ContratoD.Actividad)

[Ficha.Contrato.ContactoTipo]
Carpeta=Ficha
Clave=Contrato.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comentarios
Clave=Comentarios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Contrato
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
CarpetaVisible=S
ListaEnCaptura=Contrato.Comentarios
AlinearTodaCarpeta=S
[Comentarios.Contrato.Comentarios]
Carpeta=Comentarios
Clave=Contrato.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro
[Ficha.ContactoTipoClave]
Carpeta=Ficha
Clave=ContactoTipoClave
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
[Ficha.ContactoTipoNombre]
Carpeta=Ficha
Clave=ContactoTipoNombre
Editar=S
3D=S
Pegado=N
Tamano=40
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.Contrato.Referencia]
Carpeta=OtrosDatos
Clave=Contrato.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco
ColorFuente=Negro
[OtrosDatos.Contrato.Concepto]
Carpeta=OtrosDatos
Clave=Contrato.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco
ColorFuente=Negro
[OtrosDatos.Contrato.Observaciones]
Carpeta=OtrosDatos
Clave=Contrato.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=110
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.Contactos]
Nombre=Contactos
Boton=74
Menu=&Edición
NombreDesplegar=&Contactos del Movimiento
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovCto
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S

AntesExpresiones=Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.MovID, Contrato:Contrato.MovID)
[Riesgo.aroRiesgo.Nombre]
Carpeta=Riesgo
Clave=aroRiesgo.Nombre
Editar=S
3D=S
Pegado=N
Tamano=75
ColorFondo=Plata
ColorFuente=Negro
[Detalle.ContratoD.Clave]
Carpeta=Detalle
Clave=ContratoD.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Riesgo.Contrato.UEN]
Carpeta=Riesgo
Clave=Contrato.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Riesgo.UEN.Nombre]
Carpeta=Riesgo
Clave=UEN.Nombre
Editar=S
3D=S
Tamano=75
ColorFondo=Plata
ColorFuente=Negro

[Acciones.AnexosDetalle]
Nombre=AnexosDetalle
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F4
NombreDesplegar=Anexos &Detalle
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoMovD
Activo=S
ConCondicion=S
EjecucionConError=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Contrato:Contrato.ID) y ConDatos(ContratoD:ContratoD.Actividad)
EjecucionMensaje=Si(Vacio(Contrato:Contrato.ID), <T>Es Necesario Guardar el Movimiento Antes de Ejecutar<T>)
AntesExpresiones=Asigna(Info.Rama, <T>PACTO<T>)<BR>Asigna(Info.Fecha, Contrato:Contrato.FechaEmision)<BR>Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Contrato:Contrato.Estatus noen (EstatusCancelado, EstatusConcluido)))<BR>Asigna(Info.Cuenta, ContratoD:ContratoD.Actividad)<BR>Asigna(Info.Descripcion, ContratoD:ContratoD.Asunto)
[OtrosDatos.Contrato.FechaRevision]
Carpeta=OtrosDatos
Clave=Contrato.FechaRevision
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Acciones.Consecutivo]
Nombre=Consecutivo
Boton=0
Menu=&Archivo
NombreDesplegar=A&signar Consecutivo
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>PACTO<T>, Contrato:Contrato.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(Contrato:Contrato.MovID)
VisibleCondicion=Contrato:Contrato.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[(Carpeta Abrir).Contrato.Titulo]
Carpeta=(Carpeta Abrir)
Clave=Contrato.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha.Contrato.Titulo]
Carpeta=Ficha
Clave=Contrato.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=105
1=247
Cliente=117
Nombre=293
RFC=107

UEN=44
Tarea=304
[Documento]
Estilo=Ficha
Clave=Documento
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Contrato
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
ListaEnCaptura=Contrato.Documento
CarpetaVisible=S
AlinearTodaCarpeta=S



[Documento.Contrato.Documento]
Carpeta=Documento
Clave=Contrato.Documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=100x2
ColorFondo=Blanco
ColorFuente=Negro

SinRecapitular=S
[Acciones.Fuente]
Nombre=Fuente
Boton=0
Menu=Forma&to
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
NombreDesplegar=&Fuente...
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma.RTF.Fuente(<T>Documento<T>, <T>Contrato.Documento<T>)
[Acciones.AlinearIzquierda]
Nombre=AlinearIzquierda
Boton=0
Menu=Forma&to
NombreDesplegar=Alinear a la &Izquierda
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma.RTF.AlinearIzquierda(<T>Documento<T>, <T>Contrato.Documento<T>)
[Acciones.Centrar]
Nombre=Centrar
Boton=0
Menu=Forma&to
NombreDesplegar=&Centrar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma.RTF.Centrar(<T>Documento<T>, <T>Contrato.Documento<T>)
[Acciones.AlinearDerecha]
Nombre=AlinearDerecha
Boton=0
Menu=Forma&to
NombreDesplegar=Alinear a la &Derecha
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma.RTF.AlinearDerecha(<T>Documento<T>, <T>Contrato.Documento<T>)
[Acciones.ConViñetas]
Nombre=ConViñetas
Boton=0
Menu=Forma&to
NombreDesplegar=Con &Viñetas
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Forma.RTF.ConVinetas(<T>Documento<T>, <T>Contrato.Documento<T>)
[Acciones.SinViñetas]
Nombre=SinViñetas
Boton=0
NombreDesplegar=&Sin Viñetas
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Menu=Forma&to
Expresion=Forma.RTF.SinVinetas(<T>Documento<T>, <T>Contrato.Documento<T>)

[Ficha.Contrato.Proyecto]
Carpeta=Ficha
Clave=Contrato.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

























[Ficha.Contrato.Contrato]
Carpeta=Ficha
Clave=Contrato.Contrato
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

Pegado=N
















LineaNueva=S











[Ficha.ListaEnCaptura]
(Inicio)=Contrato.Mov
Contrato.Mov=Contrato.MovID
Contrato.MovID=Contrato.Proyecto
Contrato.Proyecto=Contrato.UEN
Contrato.UEN=Contrato.Moneda
Contrato.Moneda=Contrato.TipoCambio
Contrato.TipoCambio=Contrato.FechaEmision
Contrato.FechaEmision=Contrato.ContactoTipo
Contrato.ContactoTipo=ContactoTipoNombre
ContactoTipoNombre=ContactoTipoClave
ContactoTipoClave=Contrato.Desde
Contrato.Desde=Contrato.Hasta
Contrato.Hasta=Contrato.Contrato
Contrato.Contrato=Contrato.Titulo
Contrato.Titulo=(Fin)


































































































































































































































[Acciones.Tarea]
Nombre=Tarea
Boton=70
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Tareas
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Visible=S







GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.PuedeEditar, Contrato:Contrato.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Contrato:Contrato.Mov)<BR>Asigna(Info.MovID, Contrato:Contrato.MovID)<BR>Asigna(Info.Cliente, Contrato:Contrato.Cliente)<BR>Asigna(Info.Proveedor, Contrato:Contrato.Proveedor)<BR>Asigna(Info.Agente, Contrato:Contrato.Agente)<BR>Asigna(Info.Personal, Contrato:Contrato.Personal)<BR>Asigna(Info.Prospecto, Contrato:Contrato.Prospecto)<BR>Asigna(Info.Proyecto, Contrato:Contrato.Proyecto)<BR>Asigna(Info.UEN, Contrato:Contrato.UEN)<BR>Asigna(Info.Modulo, <T>PACTO<T>)<BR>Asigna(Info.ID, Contrato:Contrato.ID)<BR>Asigna(Info.Reporte, Nulo)
DespuesGuardar=S









[Bitacora.Columnas]
0=136
1=437
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
(Inicio)=Contrato.Titulo
Contrato.Titulo=Contrato.FechaEmision
Contrato.FechaEmision=Contrato.Desde
Contrato.Desde=Contrato.Hasta
Contrato.Hasta=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=SINCRO
SINCRO=PENDIENTE
PENDIENTE=VIGENTE
VIGENTE=VENCIDO
VENCIDO=CONCLUIDO
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
Ficha=Prospecto
Prospecto=Cliente
Cliente=Proveedor
Proveedor=Personal
Personal=Agente
Agente=Comentarios
Comentarios=FormaExtraValor
FormaExtraValor=Documento
Documento=(Fin)

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
FormasAnexas=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Afectar
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=Consecutivo
Consecutivo=CamposExtras
CamposExtras=Tarea
Tarea=Anexos
Anexos=AnexosDetalle
AnexosDetalle=Contactos
Contactos=Fuente
Fuente=AlinearIzquierda
AlinearIzquierda=Centrar
Centrar=AlinearDerecha
AlinearDerecha=ConViñetas
ConViñetas=SinViñetas
SinViñetas=Anterior
Anterior=Siguiente
Siguiente=Tiempo
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
&Edición=Forma&to
Forma&to=&Ver
&Ver=&Otros
&Otros=(Fin)
