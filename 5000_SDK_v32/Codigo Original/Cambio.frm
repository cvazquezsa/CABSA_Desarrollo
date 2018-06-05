[Forma]
Clave=Cambio
Nombre=Cambios
Icono=0
Modulos=CAM
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=324
PosicionInicialArriba=127
PosicionInicialAltura=564
PosicionInicialAncho=792
PosicionSeccion1=43
Totalizadores=S
PosicionSeccion2=93
Menus=S
BarraHerramientas=S
BarraAyuda=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DialogoAbrir=S
ListaAcciones=(Lista)
Plantillas=S
PermiteCopiarDoc=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)
ExpresionesAlCerrar=
EsMovimiento=S
Movimientos=
PosicionColumna3=50
PlantillasExcepciones=(Lista)
BarraAyudaBold=S
MovTipo=Todos
VentanaBloquearAjuste=N
VentanaAjustarZonas=
TituloAuto=S
MovModulo=CAM
PosicionInicialAlturaCliente=566
PosicionSec1=236
PosicionSec2=466

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarCambioeoRegistros=S
Zona=A1
Vista=Cambio
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
PestanaNombre=Datos generales

[Ficha.Cambio.Mov]
Carpeta=Ficha
Clave=Cambio.Mov
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cambio.MovID]
Carpeta=Ficha
Clave=Cambio.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=N
IgnoraFlujo=S

[Ficha.Cambio.FechaEmision]
Carpeta=Ficha
Clave=Cambio.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cambio.Referencia]
Carpeta=Ficha
Clave=Cambio.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cambio.Observaciones]
Carpeta=Ficha
Clave=Cambio.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=93
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Hoja
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarCambioeoRegistros=S
Zona=B1
Vista=CambioD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Detalle=S
VistaMaestra=Cambio
LlaveLocal=CambioD.ID
LlaveMaestra=Cambio.ID
CambiorolRenglon=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
HojaSubCta=Si
HojaSubNS=Si
OtroOrden=S
ListaOrden=(Lista)
CambiorolRenglonID=
CambiorolRenglonTipo=
HojaColoresPorTipo=S
CampoDespliegaTipo=Art.Tipo
VistaOmision=ResumTn
HojaVistaOmision=Automática
HojaFondoGrisAuto=S
ControlRenglon=S
CampoRenglon=CambioD.Renglon
PermiteLocalizar=S
HojaAjustarColumnas=S
MenuLocal=S
ListaAcciones=Observaciones

[Detalle.Columnas]
Cantidad=66
Articulo=110
SubCuenta=107
Costo=71
Monto=94
CantidadPendiente=57
CantidadA=64
Disponible=63
Estatus=110
Renglon=64
RenglonID=64
RenglonTipo=54
DisponibleCuenta=75
Cuenta=114
Concepto=146
Debe=99
Haber=90
Descripcion=127
Tipo=57
Instrumento=63
TipoCambio=64
Beneficiario=60
Importe=100
Moneda=61
FormaPago=85
Cobertura=53
Plazo=34
Tasa=64

[(Carpeta Totalizadores)]
Pestana=
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarCambioeoRegistros=S
Zona=C1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Saldo
Totalizadores2=Suma(CambioD:Saldo)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=Saldo

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
ClaveAccion=Documento Nuevo
Visible=S
Activo=S

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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Cambio:Cambio.ID) y (Cambio:Cambio.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Cambio:Cambio.ID, <T>CAM<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarCambioeoRegistros=S
Vista=CambioA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
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
ListaOrden=Cambio.ID<TAB>(Decendente)
PestanaOtroNombre=S
PestanaNombre=movimientos
BusquedaRapidaCambioroles=S
IconosEstiloFijo=S
BusquedaAvanzada=
BusquedaRespetarCambioroles=S
Filtros=S
FiltroMovDef=Devolucion Interna
IconosConPaginas=S
MenuLocal=S
IconosSeleccionUnitaria=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=SINAFECTAR
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Cambio.FechaEmision
FiltroFechasDefault=Hoy
FiltroMovDefault=(Todos)
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControlesNum=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroPredefinido=S
FiltroEstilo=Directorio
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Condicion
FiltroAplicaEn=Cambio.Condicion
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroTodo=S
MostrarConteoRegistros=S
BusquedaRespetarFiltros=S
BusquedaRespetarUsuario=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=Cambio.FechaCancelacion
FiltroSucursales=S

IconosNombre=CambioA:Cambio.Mov+<T> <T>+CambioA:Cambio.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=143
1=99

2=-2
3=-2
4=-2
5=-2
[(Carpeta Abrir).Cambio.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Cambio.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EspacioPrevio=S
ActivoCondicion=Vacio(Cambio:Cambio.MovID) y (Cambio:Cambio.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Cambio:Cambio.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Cambio WHERE ID=:nID<T>, Cambio:Cambio.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
NombreDesplegar=<T>A&fectar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=F12
GuardarAntes=S
RefrescarDespues=S
Antes=S
ConCondicion=S
Expresion=Afectar(<T>CAM<T>, Cambio:Cambio.ID, Cambio:Cambio.Mov, Cambio:Cambio.MovID, <T>Todo<T>, <T><T>, <T>Cambio<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Cambio:Cambio.Usuario) y (Cambio:Cambio.Estatus=EstatusSinAfectar) y (MovTipoEn(<T>CAM<T>, Cambio:Cambio.Mov, (CAM.O, CAM.V, CAM.S)))
EjecucionCondicion=ConDatos(Cambio:Cambio.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Cambio:Cambio.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CAM<T>, Cambio:Cambio.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CAM<T>, Cambio:Cambio.Mov, Cambio:Cambio.ID, Verdadero, Cambio:Cambio.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
DespuesGuardar=S

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
UsaTeclaRapida=S
NombreDesplegar=&Presentación preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Cambio:Cambio.ID
Visible=S
Antes=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(Vacio(ReporteMovPantalla(<T>CAM<T>, Cambio:Cambio.Mov, Cambio:Cambio.Estatus), <T>CambioRecibo<T>))
ActivoCondicion=Usuario.PreliminarMovs
AntesExpresiones=Asigna(Server.ID, Cambio:Cambio.ID)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
NombreDesplegar=&Imprimir...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Cambio:Cambio.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
EspacioPrevio=S
Antes=S
Expresion=ReporteImpresora(Vacio(ReporteMovPantalla(<T>CAM<T>, Cambio:Cambio.Mov, Cambio:Cambio.Estatus), <T>CambioRecibo<T>))
ActivoCondicion=Usuario.ImprimirMovs
AntesExpresiones=Asigna(Server.ID, Cambio:Cambio.ID)

[Acciones.Totalizar]
Nombre=Totalizar
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Totalizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Registro Ultimo
Visible=S
Carpeta=Detalle
ActivoCondicion=Cambio:Cambio.Estatus=EstatusSinAfectar

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
Expresion=Cancelar(<T>CAM<T>, Cambio:Cambio.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Cambio<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Cambio:Cambio.Usuario) y ConDatos(Cambio:Cambio.ID) y ConDatos(Cambio:Cambio.MovID) y<BR>(Cambio:Cambio.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusConcluido))
AntesExpresiones=Asigna(Afectar.Mov, Cambio:Cambio.Mov)<BR>Asigna(Afectar.MovID, Cambio:Cambio.MovID)

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
Expresion=Verificar(<T>CAM<T>, Cambio:Cambio.ID, Cambio:Cambio.Mov, Cambio:Cambio.MovID)
ActivoCondicion=Cambio:Cambio.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Cambio:Cambio.Mov)

[(Carpeta Abrir).Cambio.Condicion]
Carpeta=(Carpeta Abrir)
Clave=Cambio.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.CambioD.Tipo]
Carpeta=Detalle
Clave=CambioD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CambioD.Instrumento]
Carpeta=Detalle
Clave=CambioD.Instrumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CambioD.Monto]
Carpeta=Detalle
Clave=CambioD.Monto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CambioD.TipoCambio]
Carpeta=Detalle
Clave=CambioD.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CambioD.Beneficiario]
Carpeta=Detalle
Clave=CambioD.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Importe]
Carpeta=Detalle
Clave=Importe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Gris
Efectos=[Negritas]
ColorFondo=Blanco

[Ficha.Cambio.Condicion]
Carpeta=Ficha
Clave=Cambio.Condicion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cambio.Cliente]
Carpeta=Ficha
Clave=Cambio.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=33
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Cte.Telefonos]
Carpeta=Ficha
Clave=Cte.Telefonos
Editar=S
3D=S
Tamano=17
ColorFondo=Plata
Pegado=N
ColorFuente=Negro

[Ficha.Cambio.Vencimiento]
Carpeta=Ficha
Clave=Cambio.Vencimiento
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Saldo]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información del &Cliente
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=
TipoAccion=Formas
ClaveAccion=CteInfo
ActivoCondicion=Usuario.CteInfo
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(Cambio:Cambio.Cliente)
AntesExpresiones=Asigna(Info.Cliente, Cambio:Cambio.Cliente)

[Acciones.InstrumentoInfo]
Nombre=InstrumentoInfo
Boton=47
Menu=&Ver
NombreDesplegar=Información del &Instrumento
EnBarraHerramientas=
EnMenu=S
TipoAccion=Formas
Activo=S
Visible=S
UsaTeclaRapida=
ConCondicion=S
Antes=S
ClaveAccion=InstrumentoInfo
EjecucionCondicion=ConDatos(CambioD:CambioD.Instrumento)
AntesExpresiones=Asigna(Info.Instrumento, CambioD:CambioD.Instrumento)

[Acciones.InfoBeneficiario]
Nombre=InfoBeneficiario
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+B
NombreDesplegar=Información del &Beneficiario
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
Activo=S
Visible=S
ClaveAccion=BeneficiarioInfo
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(CambioD:CambioD.Beneficiario)
AntesExpresiones=Asigna(Info.Beneficiario, CambioD:CambioD.Beneficiario)

[Detalle.Instrumento.Descripcion]
Carpeta=Detalle
Clave=Instrumento.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFuente=Gris
ColorFondo=Blanco

[Detalle.Instrumento.Moneda]
Carpeta=Detalle
Clave=Instrumento.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Gris
ColorFondo=Blanco

[Ficha.Cambio.Agente]
Carpeta=Ficha
Clave=Cambio.Agente
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
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
EspacioPrevio=S
TipoAccion=Expresion
Antes=S
Visible=S

Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(Cambio:Cambio.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.ID, Cambio:Cambio.ID)<BR>Asigna(Info.Mov, Cambio:Cambio.Mov)<BR>Asigna(Info.MovID, Cambio:Cambio.MovID)
[Acciones.Posicion]
Nombre=Posicion
Boton=64
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=&Posición
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Si <BR>  Usuario.CambioVerPosicionEmpresa<BR>Entonces <BR>  Forma(<T>ExplorarCambioPosicion<T>)<BR>Sino<BR>  Si(Usuario.CambioVerPosicionSucursal, Forma(<T>ExplorarCambioPosicionSucursal<T>))<BR>Fin

[Acciones.CteExpress]
Nombre=CteExpress
Boton=60
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+C
NombreDesplegar=Agregar &Cliente
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(Info.Tipo, <T>Cliente<T>)<BR>Forma(<T>CteExpress<T>)<BR>Asigna(Cambio:Cambio.Cliente, Info.Cliente)
ActivoCondicion=Usuario.AgregarCteExpress y (Cambio:Cambio.Estatus=EstatusSinAfectar)

[(Carpeta Abrir).Cambio.Cliente]
Carpeta=(Carpeta Abrir)
Clave=Cambio.Cliente
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

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(CambioA:Cambio.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.ID, CambioA:Cambio.ID)

[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Visible=S
EspacioPrevio=S
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

[Acciones.AbrirMostrar]
Nombre=AbrirMostrar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Ficha.Cambio.Ruta]
Carpeta=Ficha
Clave=Cambio.Ruta
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.ID, Cambio:Cambio.ID)<BR>Asigna(Info.Usuario, Cambio:Cambio.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Cambio:Cambio.ID)

[Acciones.Observaciones]
Nombre=Observaciones
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Pregunta(CambioD:CambioD.Observaciones)
ActivoCondicion=Cambio:Cambio.Estatus = EstatusSinAfectar

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
Visible=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>CAM<T>)<BR>Asigna(Info.Fecha, Cambio:Cambio.FechaEmision)<BR>Asigna(Info.ID, Cambio:Cambio.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Cambio:Cambio.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Cambio:Cambio.Mov+<T> <T>+Cambio:Cambio.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Visible=S
Antes=S
ActivoCondicion=ConDatos(Cambio:Cambio.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.ID, Cambio:Cambio.ID)

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
Expresion=CopiarMovimiento(<T>CAM<T>, Cambio:Cambio.ID, <T>Cambio<T>)

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

[Ficha.Cambio.Usuario]
Carpeta=Ficha
Clave=Cambio.Usuario
3D=N
Tamano=10
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
EspacioPrevio=S
ActivoCondicion=Usuario.ModificarSucursalDestino y (Cambio:Cambio.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Cambio:Cambio.ID),GuardarCambios)
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

[Ficha.Cambio.Preocupante]
Carpeta=Ficha
Clave=Cambio.Preocupante
Editar=S
LineaNueva=N
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Cambio.Insusual]
Carpeta=Ficha
Clave=Cambio.Insusual
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Cambio.ParaisoFiscal]
Carpeta=Ficha
Clave=Cambio.ParaisoFiscal
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
Editar=S
EditarConBloqueo=S

[Ficha.Cambio.CiudadRiesgo]
Carpeta=Ficha
Clave=Cambio.CiudadRiesgo
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro
Editar=S
EditarConBloqueo=S

[Ficha.Cambio.Relevante]
Carpeta=Ficha
Clave=Cambio.Relevante
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
Editar=S
EditarConBloqueo=S

[Acciones.VerCambioCoberturaDolar]
Nombre=VerCambioCoberturaDolar
Boton=0
Menu=&Ver
NombreDesplegar=Precios &Dolar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerCambioCoberturaDolar
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D

[(Carpeta Abrir).Cambio.Usuario]
Carpeta=(Carpeta Abrir)
Clave=Cambio.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.PreciosDivisas]
Nombre=PreciosDivisas
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+D
NombreDesplegar=Precios Di&visas
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerCambioDivisas
Activo=S
Visible=S

[Detalle.CambioD.Cobertura]
Carpeta=Detalle
Clave=CambioD.Cobertura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Cambio.ObservacionesNormatividad]
Carpeta=Ficha
Clave=Cambio.ObservacionesNormatividad
Editar=S
EditarConBloqueo=S
3D=S
Tamano=26
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
Expresion=Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.Mov, Cambio:Cambio.Mov)<BR>Asigna(Info.Clave, <T>CAM<T>+Cambio:Cambio.ID)<BR>Asigna(Info.Nombre, Cambio:Cambio.Mov+<T> <T>+Cambio:Cambio.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Cambio:Cambio.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.PuedeEditar, Cambio:Cambio.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Cambio:Cambio.Mov)<BR>Asigna(Info.MovID, Cambio:Cambio.MovID)<BR>Asigna(Info.Proyecto, Cambio:Cambio.Proyecto)<BR>Asigna(Info.UEN, Cambio:Cambio.UEN)<BR>Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.ID, Cambio:Cambio.ID)<BR><BR>Asigna(Info.Cliente, Cambio:Cambio.Cliente)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Cambio:Cambio.Agente)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
AntesExpresiones=Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.ID, Cambio:Cambio.ID)<BR>Asigna(Info.Mov, Cambio:Cambio.Mov)<BR>Asigna(Info.MovID, Cambio:Cambio.MovID)<BR>Asigna(Info.Fecha, Cambio:Cambio.FechaEmision)<BR>Asigna(Info.Estatus, Cambio:Cambio.Estatus)

[Ficha.Cambio.CandidatoInsusual]
Carpeta=Ficha
Clave=Cambio.CandidatoInsusual
Editar=S
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Ficha.Cte.Contacto1]
Carpeta=Ficha
Clave=Cte.Contacto1
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.TC]
Nombre=TC
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Mayús+F8
NombreDesplegar=&Calcular Tipo Cambio
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(CambioD:CambioD.TipoCambio, Abs(Suma(CambioD:Saldo) / CambioD:CambioD.Monto))
ActivoCondicion=Cambio:Cambio.Estatus=EstatusSinAfectar

[Acciones.AnexosCte]
Nombre=AnexosCte
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+F4
NombreDesplegar=Ane&xos del Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Rama,<T>CXC<T>)<BR>Asigna(Info.Cuenta, Cambio:Cambio.Cliente)<BR>Asigna(Info.Descripcion, Cambio:Cte.Nombre)

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>Cambio<T>)<BR>Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.Mov, Cambio:Cambio.Mov)<BR>Asigna(Info.Nombre, Cambio:Cambio.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CAM<T>, Cambio:Cambio.Mov, Cambio:Cambio.ID, Falso, Cambio:Cambio.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CAM<T>+Cambio:Cambio.ID)<BR>  Asigna(Info.Nombre, Cambio:Cambio.Mov+<T> <T>+Cambio:Cambio.MovID)<BR>  Asigna(Info.Modulo, <T>CAM<T>)<BR>  Asigna(Info.Mov, Cambio:Cambio.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Cambio:Cambio.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Acciones.FormasAnexas]
Nombre=FormasAnexas
Boton=113
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F10
NombreDesplegar=Formas
GuardarAntes=S
EnMenu=S
TipoAccion=Formas Anexas
ClaveAccion=MovFormaAnexo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.ID, Cambio:Cambio.ID)<BR>Asigna(Info.Mov, Cambio:Cambio.Mov)<BR>Asigna(Info.MovID, Cambio:Cambio.MovID)
DespuesGuardar=S
Visible=S

[Ficha.Cambio.ClienteEnviarA]
Carpeta=Ficha
Clave=Cambio.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteEnviarA.Nombre]
Carpeta=Ficha
Clave=CteEnviarA.Nombre
Editar=S
3D=S
Tamano=33
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Cambio.FormaEnvio]
Carpeta=Ficha
Clave=Cambio.FormaEnvio
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Embarcar]
Nombre=Embarcar
Boton=0
Menu=&Archivo
NombreDesplegar=E&mbarcar...
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.ID, Cambio:Cambio.ID)<BR>Asigna(Info.Mov, Cambio:Cambio.Mov)<BR>Asigna(Info.MovID, Cambio:Cambio.MovID)<BR>Asigna(Info.Modulo, <T>CAM<T>)<BR>Asigna(Info.Estatus, Cambio:Cambio.Estatus)<BR>Dialogo(<T>MovEmbarcar<T>)
ActivoCondicion=Cambio:Cambio.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusSincro, EstatusCancelado) y (no FormaBloqueada)

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
ActivoCondicion=Usuario.EnviarExcel y (Cambio:Cambio.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CAM<T>, <T>{Cambio:Cambio.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CAM{Cambio:Cambio.ID}<T>

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
VerCampo=360
VerValor=360

[Detalle.CambioD.Plazo]
Carpeta=Detalle
Clave=CambioD.Plazo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CambioD.Tasa]
Carpeta=Detalle
Clave=CambioD.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro




[Ficha.ListaEnCaptura]
(Inicio)=Cambio.Mov
Cambio.Mov=Cambio.MovID
Cambio.MovID=Cambio.Usuario
Cambio.Usuario=Cambio.Cliente
Cambio.Cliente=Cte.Nombre
Cte.Nombre=Cte.Contacto1
Cte.Contacto1=Cte.Telefonos
Cte.Telefonos=Cambio.ClienteEnviarA
Cambio.ClienteEnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=Cambio.FormaEnvio
Cambio.FormaEnvio=Cambio.FechaEmision
Cambio.FechaEmision=Cambio.Condicion
Cambio.Condicion=Cambio.Vencimiento
Cambio.Vencimiento=Cambio.Referencia
Cambio.Referencia=Cambio.Ruta
Cambio.Ruta=Cambio.Agente
Cambio.Agente=Cambio.Observaciones
Cambio.Observaciones=Cambio.Relevante
Cambio.Relevante=Cambio.ParaisoFiscal
Cambio.ParaisoFiscal=Cambio.CiudadRiesgo
Cambio.CiudadRiesgo=Cambio.CandidatoInsusual
Cambio.CandidatoInsusual=Cambio.Insusual
Cambio.Insusual=Cambio.Preocupante
Cambio.Preocupante=Cambio.ObservacionesNormatividad
Cambio.ObservacionesNormatividad=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=CambioD.Tipo
CambioD.Tipo=CambioD.Instrumento
CambioD.Instrumento=Instrumento.Descripcion
Instrumento.Descripcion=Instrumento.Moneda
Instrumento.Moneda=CambioD.Monto
CambioD.Monto=CambioD.Cobertura
CambioD.Cobertura=CambioD.TipoCambio
CambioD.TipoCambio=Importe
Importe=CambioD.Beneficiario
CambioD.Beneficiario=CambioD.Tasa
CambioD.Tasa=CambioD.Plazo
CambioD.Plazo=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=Beneficiario.Nombre
Beneficiario.Nombre=Beneficiario.Info1
Beneficiario.Info1=CambioD.Cobertura
CambioD.Cobertura=CambioD.Observaciones
CambioD.Observaciones=(Fin)

[Detalle.ListaOrden]
(Inicio)=CambioD.Renglon<TAB>(Acendente)
CambioD.Renglon<TAB>(Acendente)=CambioD.RenglonSub<TAB>(Acendente)
CambioD.RenglonSub<TAB>(Acendente)=(Fin)




[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)













[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107

























[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122

































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Cambio.Cliente
Cambio.Cliente=Cte.Nombre
Cte.Nombre=Cambio.FechaEmision
Cambio.FechaEmision=Cambio.Condicion
Cambio.Condicion=Cambio.Usuario
Cambio.Usuario=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=SINCRO
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
AbrirMostrar=(Fin)













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
Localizar=Guardar Cambios
Guardar Cambios=MovPersonal
MovPersonal=Evaluaciones
Evaluaciones=Propiedades
Propiedades=Imprimir
Imprimir=RepPantalla
RepPantalla=PlantillasOffice
PlantillasOffice=FormasAnexas
FormasAnexas=Excel
Excel=Sucursal
Sucursal=Verificar
Verificar=Afectar
Afectar=Embarcar
Embarcar=Eliminar
Eliminar=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=Totalizar
Totalizar=TC
TC=CamposExtras
CamposExtras=Tareas
Tareas=Anexos
Anexos=CteExpress
CteExpress=Siguiente
Siguiente=Anterior
Anterior=Posicion
Posicion=CteInfo
CteInfo=AnexosCte
AnexosCte=InstrumentoInfo
InstrumentoInfo=InfoBeneficiario
InfoBeneficiario=VerCambioCoberturaDolar
VerCambioCoberturaDolar=PreciosDivisas
PreciosDivisas=MovPos
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

[Forma.PlantillasExcepciones]
(Inicio)=Cambio:Cambio.FechaEmision
Cambio:Cambio.FechaEmision=Cambio:Cambio.Proyecto
Cambio:Cambio.Proyecto=(Fin)
