[Forma]
Clave=PC
Nombre=<T>Precios y Costos<T>
Icono=0
Modulos=PC
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=350
PosicionInicialArriba=124
PosicionInicialAltura=564
PosicionInicialAncho=740
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
PosicionSeccion1=39
PosicionSeccion2=93
BarraAyuda=S
MovModulo=PC
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
PosicionColumna2=59
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)
Totalizadores=S
PosicionInicialAlturaCliente=572
PosicionSec1=242
PosicionSec2=468

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PC
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

[Ficha.PC.Mov]
Carpeta=Ficha
Clave=PC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PC.MovID]
Carpeta=Ficha
Clave=PC.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.PC.FechaEmision]
Carpeta=Ficha
Clave=PC.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PC.Concepto]
Carpeta=Ficha
Clave=PC.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Ficha.PC.Proyecto]
Carpeta=Ficha
Clave=PC.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.PC.Moneda]
Carpeta=Ficha
Clave=PC.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PC.Observaciones]
Carpeta=Ficha
Clave=PC.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=66
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
Vista=PCA
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
ListaOrden=PC.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=PC.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=SINAFECTAR
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
FiltroAplicaEn=PC.Moneda
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroUsuarios=S
FiltroMovs=S
FiltroFechasCancelacion=PC.FechaCancelacion
FiltroSucursales=S

IconosNombre=PCA:PC.Mov+<T> <T>+PCA:PC.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=153
1=101

2=-2
3=-2
4=-2
5=-2
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(PC:PC.ID) y (PC:PC.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, PC:PC.ID, <T>PC<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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
Vista=PCD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=PC
LlaveLocal=PCD.ID
LlaveMaestra=PC.ID
ControlRenglon=S
CampoRenglon=PCD.Renglon
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=PCD.Renglon<TAB>(Acendente)
HojaFondoGrisAuto=S
PermiteLocalizar=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
PestanaNombre=Detalle
HojaPermiteEliminar=S
HojaPermiteInsertar=S
CondicionVisible=MovTipo(<T>PC<T>, PC:PC.Mov) <> PC.B

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
Monto=43
Descripcion=106
Referencia=98
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
Diferencia=67
%Diferencia=64
DiferenciaPorcentaje=67
EstatusAlta=28
Baja=60
SubCuenta=121
Unidad=39
ListaModificar=101
SucursalEsp=96
MargenNuevo=55

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
Totalizadores1=Conteo<BR>Diferencia Promedio<BR>%
Totalizadores2=Conteo(PCD:PCD.Articulo)<BR>Promedio(PCD:Diferencia)<BR>Promedio(PCD:DiferenciaPorcentaje)
Totalizadores3=<BR>(Monetario)<BR>0.00
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
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

Expresion=Afectar(<T>PC<T>, PC:PC.ID, PC:PC.Mov, PC:PC.MovID, <T>Todo<T>, <T><T>, <T>PC<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, PC:PC.Usuario) y<BR>(PC:PC.Estatus en (EstatusSinAfectar, EstatusPendiente, EstatusVigente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>PC<T>, PC:PC.Mov, PC:PC.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(PC:PC.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (PC:PC.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>PC<T>, PC:PC.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>PC<T>, PC:PC.Mov, PC:PC.ID, Verdadero, PC:PC.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(PC:PC.MovID) y (PC:PC.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, PC:PC.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM PC WHERE ID=:nID<T>, PC:PC.ID))
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
ListaParametros1=PC:PC.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>PC<T>, PC:PC.Mov, PC:PC.Estatus), PC:PC.ID)
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
ListaParametros1=PC:PC.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>PC<T>, PC:PC.Mov, PC:PC.Estatus), PC:PC.ID)
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
ActivoCondicion=PC:PC.Estatus=EstatusSinAfectar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Antes=S
RefrescarDespues=S
GuardarAntes=S
Expresion=Si<BR>  (PC:PC.Estatus=EstatusConcluido) y (MovTipo(<T>PC<T>, PC:PC.Mov) = PC.P) y (PC:PC.Mov<>ConfigMov.PCCancelacionPrecios)<BR>Entonces<BR>  Asigna(Temp.Texto, Nulo)<BR>  Asigna(Temp.Texto, SQL(<T>SELECT MovID FROM PC WHERE Empresa=:tEmpresa AND Mov=:tMov AND Origen=:tOrigen AND OrigenID=:tOrigenID AND Estatus=:tEstatus<T>, Empresa, ConfigMov.PCCancelacionPrecios, PC:PC.Mov, PC:PC.MovID, EstatusConcluido))<BR>  Si <BR>    Vacio(Temp.Texto)<BR>  Entonces<BR>    Dialogo(<T>PCCancelar<T>)<BR>  Sino<BR>   Informacion(<T>Este Movimiento Ya Fue Cancelado con el Movimiento: <T>+NuevaLinea+NuevaLinea+ConfigMov.PCCancelacionPrecios+<T> <T>+Temp.Texto)<BR>  Fin<BR>Sino<BR>  Si <BR>    Dialogo(<T>MovCancelar<T>)<BR>  Entonces<BR>    Cancelar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, Afectar.FormaCaptura)<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, PC:PC.Usuario) y ConDatos(PC:PC.ID) y ConDatos(PC:PC.MovID) y<BR>(PC:PC.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusConcluido, EstatusPendiente, EstatusVigente))
AntesExpresiones=Asigna(Afectar.Modulo, <T>PC<T>)<BR>Asigna(Afectar.ID, PC:PC.ID)<BR>Asigna(Afectar.Mov, PC:PC.Mov ) <BR>Asigna(Afectar.MovID, PC:PC.MovID )<BR>Asigna(Afectar.FormaCaptura, <T>PC<T>)

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
Expresion=Verificar(<T>PC<T>, PC:PC.ID,PC:PC.Mov,PC:PC.MovID)
ActivoCondicion=PC:PC.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(PC:PC.Mov)

[Acciones.Infomacion]
Nombre=Infomacion
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Información del Artículo
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Visible=S
ClaveAccion=ArtInfo
Antes=S
EjecucionCondicion=ConDatos(PCD:PCD.Articulo)
AntesExpresiones=Asigna(Info.Articulo, PCD:PCD.Articulo)

[Ficha.PC.TipoCambio]
Carpeta=Ficha
Clave=PC.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.PC.MovAplica]
Carpeta=Aplica
Clave=PC.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.PC.MovAplicaID]
Carpeta=Aplica
Clave=PC.MovAplicaID
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

[(Carpeta Abrir).PC.Concepto]
Carpeta=(Carpeta Abrir)
Clave=PC.Concepto
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
TipoAccion=Expresion
Antes=S
Visible=S

Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(PC:PC.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)
[Aplica.PC.Proveedor]
Carpeta=Aplica
Clave=PC.Proveedor
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>PC<T>, PC:PC.Mov, PC:PC.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR> ActualizarVista<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>PC<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>PC<T>, PC:PC.Mov, PC:PC.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(PC:PC.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.Estatus, PC:PC.Estatus)<BR>Asigna(Info.Situacion, PC:PC.Situacion)
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
ActivoCondicion=ConfigModulo(<T>PC<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(PC:PC.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)

[(Carpeta Abrir).PC.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=PC.FechaEmision
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
ActivoCondicion=ConDatos(PCA:PC.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ID, PCA:PC.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Usuario, PC:PC.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(PC:PC.ID)

[Ficha.PC.Referencia]
Carpeta=Ficha
Clave=PC.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

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
AntesExpresiones=Asigna(Info.Rama, <T>PC<T>)<BR>Asigna(Info.Fecha, PC:PC.FechaEmision)<BR>Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (PC:PC.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, PC:PC.Mov+<T> <T>+PC:PC.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(PC:PC.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ID, PC:PC.ID)
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
Expresion=CopiarMovimiento(<T>PC<T>, PC:PC.ID, <T>PC<T>)
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
ClaveAccion=PCCampos
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)
VisibleCondicion=PC:PC.Estatus<>EstatusSinAfectar

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (PC:PC.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(PC:PC.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino

[Detalle.PCD.Articulo]
Carpeta=Detalle
Clave=PCD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PC.ListaModificar]
Carpeta=Ficha
Clave=PC.ListaModificar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.PC.FechaInicio]
Carpeta=Ficha
Clave=PC.FechaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PC.FechaTermino]
Carpeta=Ficha
Clave=PC.FechaTermino
Editar=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PCD.Anterior]
Carpeta=Detalle
Clave=PCD.Anterior
Editar=N
IgnoraFlujo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PCD.Nuevo]
Carpeta=Detalle
Clave=PCD.Nuevo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Diferencia]
Carpeta=Detalle
Clave=Diferencia
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Explorar]
Nombre=Explorar
Boton=0
Menu=&Ver
NombreDesplegar=E&xplorar Movimiento
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerPC
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)
DespuesGuardar=S
Visible=S

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreDesplegar=&Asistente Precios
EnBarraHerramientas=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Lista Precios
ListaParametros1=PCD:Art.PrecioLista<BR>PCD:Art.Precio2<BR>PCD:Art.Precio3<BR>PCD:Art.Precio4<BR>PCD:Art.Precio5<BR>PCD:Art.Precio6<BR>PCD:Art.Precio7<BR>PCD:Art.Precio8<BR>PCD:Art.Precio9<BR>PCD:Art.Precio10<BR>PCD:Art.PrecioMinimo<BR>PCD:Art.MargenMinimo<BR>PCD:Art.Margen<BR>PCD:Art.CostoEstandar<BR>PCD:Art.CostoReposicion<BR>PCD:ArtCosto.CostoPromedio<BR>PCD:ArtCosto.UltimoCosto<BR>PCD:PCD.Nuevo<BR>PC:PC.TipoCambio<BR>PC:PC.TipoCambio<BR>PC:PC.TipoCambio
ListaParametros=S
Visible=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F7
EnMenu=S
GuardarAntes=S
ActivoCondicion=(Config.PCPrecioNuevoForma=<T>Asistente<T>) y (PC:PC.Estatus=EstatusSinAfectar)

[Detalle.DiferenciaPorcentaje]
Carpeta=Detalle
Clave=DiferenciaPorcentaje
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).%]
Carpeta=(Carpeta Totalizadores)
Clave=%
Editar=S
LineaNueva=N
3D=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S
Pegado=S

[(Carpeta Totalizadores).Diferencia Promedio]
Carpeta=(Carpeta Totalizadores)
Clave=Diferencia Promedio
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Abrir).PC.ListaModificar]
Carpeta=(Carpeta Abrir)
Clave=PC.ListaModificar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Carpeta Abrir).PC.FechaInicio]
Carpeta=(Carpeta Abrir)
Clave=PC.FechaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).PC.FechaTermino]
Carpeta=(Carpeta Abrir)
Clave=PC.FechaTermino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Asignar]
Nombre=Asignar
Boton=65
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=&Asignar Artículos (en Lote)
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PCArtLista
Antes=S
DespuesGuardar=S
Visible=S
RefrescarDespues=S
ActivoCondicion=PC:PC.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Lista, PC:PC.ListaModificar)

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

[Ficha.PC.Recalcular]
Carpeta=Ficha
Clave=PC.Recalcular
Editar=S
LineaNueva=N
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
Menu=&Edición
NombreDesplegar=&Sugerir
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConfirmarAntes=S
DialogoMensaje=PCSugerir
Expresion=EjecutarSQL(<T>xpPCSugerir :nID<T>, PC:PC.ID)
ActivoCondicion=Config.PCSugerir y (PC:PC.Estatus=EstatusSinAfectar)

[Ficha.PC.UEN]
Carpeta=Ficha
Clave=PC.UEN
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
EjecucionCondicion=ConDatos(PC:PC.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, PC:PC.Proyecto)
Visible=S

[Ficha.PC.Parcial]
Carpeta=Ficha
Clave=PC.Parcial
Editar=S
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PCD.Baja]
Carpeta=Detalle
Clave=PCD.Baja
Editar=S
IgnoraFlujo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Boletin.PCBoletin.Articulo]
Carpeta=Boletin
Clave=PCBoletin.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Boletin.PCBoletin.PrecioLista]
Carpeta=Boletin
Clave=PCBoletin.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Boletin.PCBoletin.Precio2]
Carpeta=Boletin
Clave=PCBoletin.Precio2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Boletin.PCBoletin.CostoReposicion]
Carpeta=Boletin
Clave=PCBoletin.CostoReposicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Boletin.PCBoletin.Incentivo]
Carpeta=Boletin
Clave=PCBoletin.Incentivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Boletin.PCBoletin.Baja]
Carpeta=Boletin
Clave=PCBoletin.Baja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Boletin.Columnas]
Articulo=118
PrecioLista=102
Precio2=103
CostoReposicion=95
Incentivo=95
Baja=59

[Acciones.Boletin]
Nombre=Boletin
Boton=38
Menu=&Ver
NombreDesplegar=&Boletín
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PCBoletin
Antes=S
ActivoCondicion=(MovTipo(<T>PC<T>, PC:PC.Mov)=PC.B) y (PC:PC.Estatus<>EstatusSinAfectar)
AntesExpresiones=Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)<BR>Asigna(Info.Referencia, PC:PC.Referencia)
VisibleCondicion=(MovTipo(<T>PC<T>, PC:PC.Mov)=PC.B) y (PC:PC.Estatus<>EstatusSinAfectar)

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
Expresion=Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.Clave, <T>PC<T>+PC:PC.ID)<BR>Asigna(Info.Nombre, PC:PC.Mov+<T> <T>+PC:PC.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(PC:PC.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Detalle.PCD.SubCuenta]
Carpeta=Detalle
Clave=PCD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=Cambiar Vista
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S
EspacioPrevio=S

[Detalle.PCD.Unidad]
Carpeta=Detalle
Clave=PCD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.PuedeEditar, PC:PC.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)<BR>Asigna(Info.Proyecto, PC:PC.Proyecto)<BR>Asigna(Info.UEN, PC:PC.UEN)<BR>Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ID, PC:PC.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
AntesExpresiones=Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)<BR>Asigna(Info.Fecha, PC:PC.FechaEmision)<BR>Asigna(Info.Estatus, PC:PC.Estatus)

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
EjecucionCondicion=ConDatos(PC:PC.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>PC<T>)<BR>Asigna(Info.Clave, PC:PC.Mov)

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
EjecucionCondicion=ConDatos(PC:PC.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.Concepto, PC:PC.Concepto)

[Acciones.AsignarSub]
Nombre=AsignarSub
Boton=54
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Mayús+F7
NombreDesplegar=&Asignar Artículos/Opciones (en Lote)
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PCArtSubLista
Visible=S
Antes=S
DespuesGuardar=S
RefrescarDespues=S
ActivoCondicion=PC:PC.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Lista, PC:PC.ListaModificar)

[Acciones.AsignarOpciones]
Nombre=AsignarOpciones
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=&Asignar Opciones del Artículo
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PCArtSub
Visible=S
Antes=S
DespuesGuardar=S
ActivoCondicion=PC:PC.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Lista, PC:PC.ListaModificar)<BR>Asigna(Info.Articulo, PCD:PCD.Articulo)

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>PC<T>)<BR>Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.Nombre, PC:PC.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>PC<T>, PC:PC.Mov, PC:PC.ID, Falso, PC:PC.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>PC<T>+PC:PC.ID)<BR>  Asigna(Info.Nombre, PC:PC.Mov+<T> <T>+PC:PC.MovID)<BR>  Asigna(Info.Modulo, <T>PC<T>)<BR>  Asigna(Info.Mov, PC:PC.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      PC:PC.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>PC<T>)<BR>Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (PC:PC.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=MovTipo(<T>PC<T>, PC:PC.Mov) <> PC.B

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>PC<T>, <T>{PC:PC.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>PC{PC:PC.ID}<T>
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
VerCampo=300
VerValor=300

[Detalle.PCD.ListaModificar]
Carpeta=Detalle
Clave=PCD.ListaModificar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PC.Proveedor]
Carpeta=Ficha
Clave=PC.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=39
ColorFondo=Plata
ColorFuente=Negro

[Detalle.PCD.SucursalEsp]
Carpeta=Detalle
Clave=PCD.SucursalEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PC.Metodo]
Carpeta=Ficha
Clave=PC.Metodo
Editar=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Recalcular]
Nombre=Recalcular
Boton=92
Menu=&Edición
NombreDesplegar=&Recalcular
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F8
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
GuardarAntes=S
RefrescarDespues=S
Expresion=EjecutarSQL(<T>spPCRecalc :nID<T>, PC:PC.ID)
ActivoCondicion=(Config.PCPrecioNuevoForma=<T>Metodos<T>) y (PC:PC.Estatus=EstatusSinAfectar)

[Detalle.PCD.Monto]
Carpeta=Detalle
Clave=PCD.Monto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PC.Monto]
Carpeta=Ficha
Clave=PC.Monto
Editar=S
3D=S
Pegado=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.MargenNuevo]
Carpeta=Detalle
Clave=MargenNuevo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Acciones.ListaModificar]
Nombre=ListaModificar
Boton=0
Menu=&Edición
NombreDesplegar=&Listas a Modificar
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PCListaModificar
Antes=S
DespuesGuardar=S
ActivoCondicion=PC:PC.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)
VisibleCondicion=Config.PCListaModificarDetalle y (MovTipo(<T>PC<T>, PC:PC.Mov) <> PC.B)

[Acciones.Herramienta]
Nombre=Herramienta
Boton=61
Menu=&Edición
NombreDesplegar=&Herramienta Precios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F8
GuardarAntes=S
RefrescarDespues=S
Expresion=Asigna(Info.ID, PC:PC.ID)<BR>Asigna(Info.Mov, PC:PC.Mov)<BR>Asigna(Info.MovID, PC:PC.MovID)<BR>EjecutarSQL(<T>spPC_H2 :nEstacion, :nID, :tAccion<T>, EstacionTrabajo, Info.ID, <T>SUGERIR<T>)<BR>Forma(<T>PC_H2<T>)
ActivoCondicion=Config.PC_H2 y (PC:PC.Estatus=EstatusSinAfectar)




[Ficha.ListaEnCaptura]
(Inicio)=PC.Mov
PC.Mov=PC.MovID
PC.MovID=PC.Proyecto
PC.Proyecto=PC.UEN
PC.UEN=PC.Moneda
PC.Moneda=PC.TipoCambio
PC.TipoCambio=PC.FechaEmision
PC.FechaEmision=PC.Recalcular
PC.Recalcular=PC.Parcial
PC.Parcial=PC.ListaModificar
PC.ListaModificar=PC.Metodo
PC.Metodo=PC.Monto
PC.Monto=PC.FechaInicio
PC.FechaInicio=PC.FechaTermino
PC.FechaTermino=PC.Proveedor
PC.Proveedor=Prov.Nombre
Prov.Nombre=PC.Concepto
PC.Concepto=PC.Referencia
PC.Referencia=PC.Observaciones
PC.Observaciones=(Fin)




[Detalle.ListaEnCaptura]
(Inicio)=PCD.Articulo
PCD.Articulo=PCD.SubCuenta
PCD.SubCuenta=PCD.Unidad
PCD.Unidad=PCD.Anterior
PCD.Anterior=PCD.Monto
PCD.Monto=PCD.Nuevo
PCD.Nuevo=MargenNuevo
MargenNuevo=Diferencia
Diferencia=DiferenciaPorcentaje
DiferenciaPorcentaje=PCD.Baja
PCD.Baja=PCD.ListaModificar
PCD.ListaModificar=PCD.SucursalEsp
PCD.SucursalEsp=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=PCD.CostoBase
PCD.CostoBase=Art.PrecioLista
Art.PrecioLista=MargenPrecioLista
MargenPrecioLista=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Diferencia Promedio
Diferencia Promedio=%
%=Conteo
Conteo=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)













[Lista.Columnas]
Articulo=131
Descripcion1=244

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
(Inicio)=PC.FechaEmision
PC.FechaEmision=PC.ListaModificar
PC.ListaModificar=PC.FechaInicio
PC.FechaInicio=PC.FechaTermino
PC.FechaTermino=PC.Concepto
PC.Concepto=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=VIGENTE
VIGENTE=SINCRO
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
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=CambiarVista
CambiarVista=ListaModificar
ListaModificar=Asignar
Asignar=AsignarSub
AsignarSub=AsignarOpciones
AsignarOpciones=Asistente
Asistente=Sugerir
Sugerir=Recalcular
Recalcular=Herramienta
Herramienta=Tareas
Tareas=Anexos
Anexos=Boletin
Boletin=Anterior
Anterior=Siguiente
Siguiente=Infomacion
Infomacion=ProyInfo
ProyInfo=Explorar
Explorar=Tiempo
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
