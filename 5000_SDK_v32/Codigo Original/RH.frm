[Forma]
Clave=RH
Nombre=<T>Recursos Humanos<T>
Icono=0
Modulos=NOM
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=261
PosicionInicialArriba=0
PosicionInicialAltura=573
PosicionInicialAncho=753
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
PosicionSeccion1=24
PosicionSeccion2=79
BarraAyuda=S
MovModulo=RH
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
PosicionColumna2=54
PosicionInicialAlturaCliente=628
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.Copiar, Falso)
PosicionSec1=149
PosicionCol2=419

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RH
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

[Ficha.RH.Mov]
Carpeta=Ficha
Clave=RH.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RH.MovID]
Carpeta=Ficha
Clave=RH.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.RH.FechaEmision]
Carpeta=Ficha
Clave=RH.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RH.Concepto]
Carpeta=Ficha
Clave=RH.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Ficha.RH.Proyecto]
Carpeta=Ficha
Clave=RH.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.RH.Moneda]
Carpeta=Ficha
Clave=RH.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RH.Observaciones]
Carpeta=Ficha
Clave=RH.Observaciones
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
Vista=RHA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=RH.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=RH.FechaEmision
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
FiltroAplicaEn=RH.Moneda
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroUsuarios=S
FiltroMovs=S
FiltroFechasCancelacion=RH.FechaCancelacion
FiltroSucursales=S

BusquedaSelCampo=S
IconosNombre=RHA:RH.Mov+<T> <T>+RHA:RH.MovID
[(Carpeta Abrir).Columnas]
0=153
1=81

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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(RH:RH.ID) y (RH:RH.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, RH:RH.ID, <T>RH<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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
Vista=RHD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=RH
LlaveLocal=RHD.ID
LlaveMaestra=RH.ID
ControlRenglon=S
CampoRenglon=RHD.Renglon
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
ListaOrden=RHD.Renglon<TAB>(Acendente)
HojaFondoGrisAuto=S
PermiteLocalizar=S
ValidarCampos=S
ListaCamposAValidar=NombreCompleto
PestanaNombre=Multiples
CarpetaVisible=S
HojaMantenerSeleccion=S

[Detalle.Columnas]
Importe=106
Aplica=96
AplicaID=74
AplicaProntoPago=96
Personal=91
Cantidad=51
Porcentaje=40
Periodos=48
FechaInicio=73
FechaTermino=79
Observaciones=113
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
Referencia=98
Concepto=104
TipoContrato=79
PeriodoTipo=80
Jornada=78
TipoSueldo=63
Categoria=118
Departamento=122
Puesto=108
Grupo=101
Motivo=153
Calificacion=60
Incremento=73
SueldoActual=88
SueldoNuevo=88

IDSEConciliado=78
IDSEMensaje=99
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
Totalizadores2=Suma(RHD:RHD.Importe)
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

Expresion=Si<BR>  RH:RH.Estatus=EstatusPendiente<BR>Entonces<BR>  Asigna(Info.Modulo, <T>RH<T>)<BR>  Asigna(Info.Mov, RH:RH.Mov)<BR>  Asigna(Info.MovID, RH:RH.MovID)<BR>  Asigna(Afectar.Modulo, <T>RH<T>)<BR>  Asigna(Afectar.ID, RH:RH.ID)<BR>  Asigna(Afectar.Mov, RH:RH.Mov)<BR>  Asigna(Afectar.MovID, RH:RH.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>RH<T>)<BR>  Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si <BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Caso MovTipo(<T>RH<T>, RH:RH.Mov)<BR>      Es RH.SA   Entonces Dialogo(<T>GenerarRHSolicitudAltas<T>)<BR>      Es RH.SM   Entonces Dialogo(<T>GenerarRHSolicitudModificaciones<T>)<BR>      Es RH.SB   Entonces Dialogo(<T>GenerarRHSolicitudBajas<T>)<BR>      Es RH.SINC Entonces Dialogo(<T>GenerarRHSolicitudIncremento<T>)<BR>      Es RH.INC  Entonces Dialogo(<T>GenerarRHIncremento<T>)<BR>    Fin    <BR>  Fin<BR>Sino<BR>  Afectar(<T>RH<T>, RH:RH.ID, RH:RH.Mov, RH:RH.MovID, <T>Todo<T>, <T><T>, <T>RH<T>)<BR>  Si((Config.RHIDSE) y ((RH:RH.Mov = <T>Altas<T>) o (RH:RH.Mov = <T>Bajas<T>) o ((RH:RH.Mov = <T>Modificaciones<T>) y (Mayusculas(RH:RH.Concepto) = <T>SUELDO<T>))),  IDSE( Config.RHIDSERuta,  Año( RH:RH.FechaEmision ) , Mes(RH:RH.FechaEmision), RH:RH.ID ) )<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, RH:RH.Usuario) y<BR>(RH:RH.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>RH<T>, RH:RH.Mov, RH:RH.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(RH:RH.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (RH:RH.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>RH<T>, RH:RH.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>RH<T>, RH:RH.Mov, RH:RH.ID, Verdadero, RH:RH.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(RH:RH.MovID) y (RH:RH.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, RH:RH.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM RH WHERE ID=:nID<T>, RH:RH.ID))
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
ListaParametros1=RH:RH.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>RH<T>, RH:RH.Mov, RH:RH.Estatus), RH:RH.ID)
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
ListaParametros1=RH:RH.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>RH<T>, RH:RH.Mov, RH:RH.Estatus), RH:RH.ID)
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
ActivoCondicion=RH:RH.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

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
Expresion=Cancelar(<T>RH<T>, RH:RH.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>RH<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, RH:RH.Usuario) y ConDatos(RH:RH.ID) y ConDatos(RH:RH.MovID) y<BR>(RH:RH.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusSincro, EstatusConcluido, EstatusPendiente, EstatusVigente))
AntesExpresiones=Asigna( Afectar.Mov, RH:RH.Mov ) <BR>Asigna( Afectar.MovID, RH:RH.MovID )

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
Expresion=Verificar(<T>RH<T>, RH:RH.ID,RH:RH.Mov,RH:RH.MovID)
ActivoCondicion=RH:RH.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(RH:RH.Mov)

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
EjecucionCondicion=ConDatos(RHD:RHD.Personal)
AntesExpresiones=Asigna(Info.Personal, RHD:RHD.Personal)

[Ficha.RH.TipoCambio]
Carpeta=Ficha
Clave=RH.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.RH.MovAplica]
Carpeta=Aplica
Clave=RH.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.RH.MovAplicaID]
Carpeta=Aplica
Clave=RH.MovAplicaID
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

[(Carpeta Abrir).RH.Concepto]
Carpeta=(Carpeta Abrir)
Clave=RH.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

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
ActivoCondicion=ConDatos(RH:RH.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.ID, RH:RH.ID)<BR>Asigna(Info.Mov, RH:RH.Mov)<BR>Asigna(Info.MovID, RH:RH.MovID)

[Aplica.RH.Proveedor]
Carpeta=Aplica
Clave=RH.Proveedor
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>RH<T>, RH:RH.Mov, RH:RH.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>RH<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>RH<T>, RH:RH.Mov, RH:RH.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(RH:RH.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.ID, RH:RH.ID)<BR>Asigna(Info.Mov, RH:RH.Mov)<BR>Asigna(Info.Estatus, RH:RH.Estatus)<BR>Asigna(Info.Situacion, RH:RH.Situacion)
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
ActivoCondicion=ConfigModulo(<T>RH<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(RH:RH.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.ID, RH:RH.ID)<BR>Asigna(Info.Mov, RH:RH.Mov)<BR>Asigna(Info.MovID, RH:RH.MovID)

[(Carpeta Abrir).RH.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=RH.FechaEmision
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
ActivoCondicion=ConDatos(RHA:RH.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.ID, RHA:RH.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.ID, RH:RH.ID)<BR>Asigna(Info.Usuario, RH:RH.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(RH:RH.ID)

[Detalle.RHD.Personal]
Carpeta=Detalle
Clave=RHD.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Condiciones.RH.Personal]
Carpeta=Condiciones
Clave=RH.Personal
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

[Condiciones.RH.Importe]
Carpeta=Condiciones
Clave=RH.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.RH.Saldo]
Carpeta=Condiciones
Clave=RH.Saldo
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Condiciones.RH.CondicionVeces]
Carpeta=Condiciones
Clave=RH.CondicionVeces
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Condiciones.RH.CondicionFechaD]
Carpeta=Condiciones
Clave=RH.CondicionFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.RH.CondicionFechaA]
Carpeta=Condiciones
Clave=RH.CondicionFechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.RH.CondicionPorcentaje]
Carpeta=Condiciones
Clave=RH.CondicionPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.RH.CondicionMonto]
Carpeta=Condiciones
Clave=RH.CondicionMonto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.RH.CtaDinero]
Carpeta=Condiciones
Clave=RH.CtaDinero
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

[DetalleFicha]
Estilo=Ficha
Clave=DetalleFicha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=RHD
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=3
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
Detalle=S
VistaMaestra=RH
LlaveLocal=RHD.ID
LlaveMaestra=RH.ID
ControlRenglon=S
CampoRenglon=RHD.Renglon
CondicionVisible=MovTipoEn(<T>RH<T>, RH:RH.Mov, (RH.C, RH.SA, RH.A, RH.SM, RH.M))

[DetalleFicha.RHD.TipoContrato]
Carpeta=DetalleFicha
Clave=RHD.TipoContrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.RHD.PeriodoTipo]
Carpeta=DetalleFicha
Clave=RHD.PeriodoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.RHD.Jornada]
Carpeta=DetalleFicha
Clave=RHD.Jornada
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.RHD.TipoSueldo]
Carpeta=DetalleFicha
Clave=RHD.TipoSueldo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[DetalleFicha.RHD.Categoria]
Carpeta=DetalleFicha
Clave=RHD.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.RHD.Departamento]
Carpeta=DetalleFicha
Clave=RHD.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[DetalleFicha.RHD.Puesto]
Carpeta=DetalleFicha
Clave=RHD.Puesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[DetalleFicha.RHD.Grupo]
Carpeta=DetalleFicha
Clave=RHD.Grupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.RHD.Calificacion]
Carpeta=Detalle
Clave=RHD.Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RH.Evaluacion]
Carpeta=Ficha
Clave=RH.Evaluacion
Editar=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.RHD.Observaciones]
Carpeta=Detalle
Clave=RHD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).RH.Evaluacion]
Carpeta=(Carpeta Abrir)
Clave=RH.Evaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[(Carpeta Abrir).RH.Observaciones]
Carpeta=(Carpeta Abrir)
Clave=RH.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha.RH.Referencia]
Carpeta=Ficha
Clave=RH.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.RHD.FechaAntiguedad]
Carpeta=DetalleFicha
Clave=RHD.FechaAntiguedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[DetalleFicha.RHD.FechaAlta]
Carpeta=DetalleFicha
Clave=RHD.FechaAlta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

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
AntesExpresiones=Asigna(Info.Rama, <T>RH<T>)<BR>Asigna(Info.Fecha, RH:RH.FechaEmision)<BR>Asigna(Info.ID, RH:RH.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (RH:RH.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, RH:RH.Mov+<T> <T>+RH:RH.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(RH:RH.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.ID, RH:RH.ID)
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
Expresion=CopiarMovimiento(<T>RH<T>, RH:RH.ID, <T>RH<T>)
Activo=S
Visible=S

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
ClaveAccion=RHCampos
Antes=S
ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.ID, RH:RH.ID)<BR>Asigna(Info.Mov, RH:RH.Mov)<BR>Asigna(Info.MovID, RH:RH.MovID)
VisibleCondicion=RH:RH.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)

[DetalleFicha.RHD.VencimientoContrato]
Carpeta=DetalleFicha
Clave=RHD.VencimientoContrato
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (RH:RH.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(RH:RH.ID),GuardarCambios)
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

[DetalleFicha.RHD.SucursalTrabajo]
Carpeta=DetalleFicha
Clave=RHD.SucursalTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.RHD.SueldoDiario]
Carpeta=DetalleFicha
Clave=RHD.SueldoDiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.RHD.SDI]
Carpeta=DetalleFicha
Clave=RHD.SDI
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.MinimosProfesionales]
Nombre=MinimosProfesionales
Boton=0
NombreDesplegar=Sugerir Minimos &Profesionales con Cambio 
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Menu=&Edición
Expresion=EjecutarSQL(<T>spRHSugerirMinimosProfesionales :nID<T>, RH:RH.ID)
VisibleCondicion=MovTipo(<T>RH<T>, RH:RH.Mov) = RH.M

[Acciones.CalcSueldo]
Nombre=CalcSueldo
Boton=10
Menu=&Edición
NombreDesplegar=&Calcular Sueldo Diario...
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F6

Expresion=Si(Forma(<T>CalcSueldoDiario<T>), Asigna(RHD:RHD.SueldoDiario, Info.Sueldo))
ActivoCondicion=MovTipoEn(<T>RH<T>, RH:RH.Mov, (RH.C, RH.A, RH.M))
AntesExpresiones=Asigna(Info.PeriodoTipo, RHD:RHD.PeriodoTipo)<BR>Asigna(Info.Anos, RHD:AnosCumplidos)<BR>Asigna(Info.Sueldo, Nulo)<BR>Asigna(Info.Personal, RHD:RHD.Personal)
[Ficha.RH.UEN]
Carpeta=Ficha
Clave=RH.UEN
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
EjecucionCondicion=ConDatos(RH:RH.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, RH:RH.Proyecto)
Visible=S

[DetalleFicha.RHD.ReportaA]
Carpeta=DetalleFicha
Clave=RHD.ReportaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ModificarEnLote]
Nombre=ModificarEnLote
Boton=0
Menu=&Edición
NombreDesplegar=Modificar en Lote...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Antes=S
Expresion=Si<BR>  Forma(<T>EspecificarModificarEnLote<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spRHModificarEnLote :tEmpresa, :nID, :nPor, :nImporte, :tRed<T>, Empresa, RH:RH.ID, Info.Porcentaje, Info.Importe, Info.Redondear)<BR>Fin
ActivoCondicion=RH:RH.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.Porcentaje, Nulo)<BR>Asigna(Info.Importe, Nulo)
VisibleCondicion=MovTipo(<T>RH<T>, RH:RH.Mov) = RH.M

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.Mov, RH:RH.Mov)<BR>Asigna(Info.Clave, <T>RH<T>+RH:RH.ID)<BR>Asigna(Info.Nombre, RH:RH.Mov+<T> <T>+RH:RH.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(RH:RH.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

[DetalleFicha.RHD.CentroCostos]
Carpeta=DetalleFicha
Clave=RHD.CentroCostos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.PuedeEditar, RH:RH.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, RH:RH.Mov+<T> <T>+RH:RH.MovID)<BR>Asigna(Info.Proyecto, RH:RH.Proyecto)<BR>Asigna(Info.UEN, RH:RH.UEN)<BR>Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.ID, RH:RH.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)
DespuesGuardar=S
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
AntesExpresiones=Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.ID, RH:RH.ID)<BR>Asigna(Info.Mov, RH:RH.Mov)<BR>Asigna(Info.MovID, RH:RH.MovID)<BR>Asigna(Info.Fecha, RH:RH.FechaEmision)<BR>Asigna(Info.Estatus, RH:RH.Estatus)

[Acciones.Excel]
Nombre=Excel
Boton=0
Menu=&Archivo
NombreDesplegar=Excel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel y (RH:RH.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

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
EjecucionCondicion=ConDatos(RH:RH.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>RH<T>)<BR>Asigna(Info.Clave, RH:RH.Mov)

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
EjecucionCondicion=ConDatos(RH:RH.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.Concepto, RH:RH.Concepto)

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
Expresion=Asigna(Info.Forma, <T>RH<T>)<BR>Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.Mov, RH:RH.Mov)<BR>Asigna(Info.Nombre, <T>Recursos Humanos<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

[Detalle.RHD.Incremento]
Carpeta=Detalle
Clave=RHD.Incremento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>RH<T>, RH:RH.Mov, RH:RH.ID, Falso, RH:RH.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>RH<T>+RH:RH.ID)<BR>  Asigna(Info.Nombre, RH:RH.Mov+<T> <T>+RH:RH.MovID)<BR>  Asigna(Info.Modulo, <T>RH<T>)<BR>  Asigna(Info.Mov, RH:RH.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      RH:RH.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>RH<T>)<BR>Asigna(Info.ID, RH:RH.ID)<BR>Asigna(Info.Mov, RH:RH.Mov)<BR>Asigna(Info.MovID, RH:RH.MovID)
DespuesGuardar=S
Visible=S

[DetalleFicha.RHD.Plaza]
Carpeta=DetalleFicha
Clave=RHD.Plaza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.Plaza.Descripcion]
Carpeta=DetalleFicha
Clave=Plaza.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[DetalleFicha.RHD.SueldoDiarioComplemento]
Carpeta=DetalleFicha
Clave=RHD.SueldoDiarioComplemento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.SueldoDiarioBruto]
Carpeta=DetalleFicha
Clave=SueldoDiarioBruto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.SueldoActual]
Carpeta=Detalle
Clave=SueldoActual
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Detalle.RHD.SueldoNuevo]
Carpeta=Detalle
Clave=RHD.SueldoNuevo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>RH<T>, <T>{RH:RH.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>RH{RH:RH.ID}<T>
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
VerCampo=340
VerValor=340




[Ficha.ListaEnCaptura]
(Inicio)=RH.Mov
RH.Mov=RH.MovID
RH.MovID=RH.Proyecto
RH.Proyecto=RH.UEN
RH.UEN=RH.Moneda
RH.Moneda=RH.TipoCambio
RH.TipoCambio=RH.FechaEmision
RH.FechaEmision=RH.Evaluacion
RH.Evaluacion=RH.Concepto
RH.Concepto=RH.Referencia
RH.Referencia=RH.Observaciones
RH.Observaciones=(Fin)




[DetalleFicha.ListaEnCaptura]
(Inicio)=RHD.Plaza
RHD.Plaza=Plaza.Descripcion
Plaza.Descripcion=RHD.Departamento
RHD.Departamento=RHD.Puesto
RHD.Puesto=RHD.Categoria
RHD.Categoria=RHD.Grupo
RHD.Grupo=RHD.ReportaA
RHD.ReportaA=RHD.CentroCostos
RHD.CentroCostos=RHD.FechaAntiguedad
RHD.FechaAntiguedad=RHD.FechaAlta
RHD.FechaAlta=RHD.TipoContrato
RHD.TipoContrato=RHD.VencimientoContrato
RHD.VencimientoContrato=RHD.PeriodoTipo
RHD.PeriodoTipo=RHD.Jornada
RHD.Jornada=RHD.SucursalTrabajo
RHD.SucursalTrabajo=RHD.TipoSueldo
RHD.TipoSueldo=RHD.SueldoDiario
RHD.SueldoDiario=RHD.SDI
RHD.SDI=RHD.SueldoDiarioComplemento
RHD.SueldoDiarioComplemento=SueldoDiarioBruto
SueldoDiarioBruto=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)
















[Acciones.IDSE]
Nombre=IDSE
Boton=0
NombreDesplegar=Solicitar IDSE
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Visible=S




Menu=&Edición
TeclaFuncion=F4
Antes=S












































































ActivoCondicion=(Config.RHIDSE) y (RH:RH.Estatus noen (EstatusSinAfectar)) y<BR>((RH:RH.Mov = <T>Altas<T>) o (RH:RH.Mov = <T>Bajas<T>) o ((RH:RH.Mov = <T>Modificaciones<T>) y (Mayusculas(RH:RH.Concepto) = <T>SUELDO<T>)))
AntesExpresiones=Si(Config.RHIDSE,  IDSE( Config.RHIDSERuta,  Año( RH:RH.FechaEmision ) , Mes(RH:RH.FechaEmision), RH:RH.ID ) )
[Detalle.RHD.IDSEConciliado]
Carpeta=Detalle
Clave=RHD.IDSEConciliado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.RHD.IDSEMensaje]
Carpeta=Detalle
Clave=RHD.IDSEMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro











[Detalle.ListaEnCaptura]
(Inicio)=RHD.Personal
RHD.Personal=SueldoActual
SueldoActual=RHD.Incremento
RHD.Incremento=RHD.SueldoNuevo
RHD.SueldoNuevo=RHD.Calificacion
RHD.Calificacion=RHD.Observaciones
RHD.Observaciones=RHD.IDSEConciliado
RHD.IDSEConciliado=RHD.IDSEMensaje
RHD.IDSEMensaje=(Fin)









































































[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S













[Lista.Columnas]
0=91
1=267






































































[Acciones.PropRegPatronal]
Nombre=PropRegPatronal
Boton=35
NombreDesplegar=&Propiedades
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PersonalPropValor
Activo=S










Antes=S






ConCondicion=S










































EjecucionCondicion=ConDatos(RHD:Personal.Personal)
AntesExpresiones=Asigna(Info.Rama, <T>PER<T>)<BR>Asigna(Info.Cuenta, RHD:Personal.Personal)<BR>Asigna(Info.Descripcion, RHD:Personal.Nombre + <T> <T> + RHD:Personal.ApellidoPaterno)
VisibleCondicion=Info.SubClave=<T>RH.ARP<T> y SQL(<T>SELECT NivelPersonal FROM PersonalProp WHERE Propiedad = :tPropiedad<T>,<T>Registro Patronal<T>)=Verdadero
[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=RH.FechaEmision
RH.FechaEmision=RH.Concepto
RH.Concepto=RH.Evaluacion
RH.Evaluacion=RH.Observaciones
RH.Observaciones=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=PENDIENTE
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




























[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalle
Detalle=DetalleFicha
DetalleFicha=FormaExtraValor
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
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=CalcSueldo
CalcSueldo=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=IDSE
IDSE=Tareas
Tareas=Anexos
Anexos=ModificarEnLote
ModificarEnLote=MinimosProfesionales
MinimosProfesionales=Anterior
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
Otros9=PropRegPatronal
PropRegPatronal=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
