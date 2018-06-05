[Forma]
Clave=hActivoFijo
Nombre=Activos Fijos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=322
PosicionInicialArriba=104
PosicionInicialAltura=600
PosicionInicialAncho=795
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
PosicionSeccion1=43
PosicionSeccion2=92
BarraAyuda=S
MovModulo=AF
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
Totalizadores=S
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.Articulo, Nulo)
PosicionInicialAlturaCliente=613
PosicionSec1=261
PosicionSec2=509

PosicionCol1=309
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hActivoFijo
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=$00F0F0F0
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
PestanaNombre=Datos Generales
Pestana=S
PestanaOtroNombre=S

[Ficha.hActivoFijo.Mov]
Carpeta=Ficha
Clave=hActivoFijo.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

[Ficha.hActivoFijo.MovID]
Carpeta=Ficha
Clave=hActivoFijo.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.hActivoFijo.FechaEmision]
Carpeta=Ficha
Clave=hActivoFijo.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.hActivoFijo.Concepto]
Carpeta=Ficha
Clave=hActivoFijo.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=N
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.hActivoFijo.Proyecto]
Carpeta=Ficha
Clave=hActivoFijo.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco
Pegado=N

[Ficha.hActivoFijo.Moneda]
Carpeta=Ficha
Clave=hActivoFijo.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.hActivoFijo.Referencia]
Carpeta=Ficha
Clave=hActivoFijo.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=N
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.hActivoFijo.Observaciones]
Carpeta=Ficha
Clave=hActivoFijo.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
EspacioPrevio=N

[Ficha.hActivoFijo.Proveedor]
Carpeta=Ficha
Clave=hActivoFijo.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=S
ColorFondo=Blanco

[Ficha.hActivoFijo.Condicion]
Carpeta=Ficha
Clave=hActivoFijo.Condicion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
LineaNueva=N

[Ficha.hActivoFijo.Vencimiento]
Carpeta=Ficha
Clave=hActivoFijo.Vencimiento
Editar=S
3D=S
Tamano=15
EditarConBloqueo=N
ColorFondo=Blanco
ValidaNombre=N

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=hActivoFijoA
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
ListaOrden=hActivoFijo.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=hActivoFijo.FechaEmision
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
FiltroUsuarioDefault=(Todos)
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
FiltroAplicaEn=hActivoFijo.Moneda
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechasCancelacion=hActivoFijo.FechaCancelacion
FiltroSucursales=S

IconosNombre=hActivoFijoA:hActivoFijo.Mov+<T> <T>+hActivoFijoA:hActivoFijo.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=170
1=76

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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(hActivoFijo:hActivoFijo.ID) y (hActivoFijo:hActivoFijo.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, hActivoFijo:hActivoFijo.ID, <T>AF<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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
Vista=hActivoFijoD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=hActivoFijo
LlaveLocal=hActivoFijoD.ID
LlaveMaestra=hActivoFijo.ID
ControlRenglon=S
CampoRenglon=hActivoFijoD.Renglon
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
ValidarCampos=S
ListaCamposAValidar=(Lista)
OtroOrden=S
ListaOrden=(Lista)
HojaFondoGrisAuto=S
PermiteLocalizar=S
CondicionVisible=MovTipoEn(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, (AF.DT, AF.RE, AF.MA, AF.PS, AF.PM, AF.A, AF.D)) o (no hActivoFijo:hActivoFijo.Todo) o (hActivoFijo:hActivoFijo.Estatus<>EstatusSinAfectar) o ((MovTipo(<T>AF<T>, hActivoFijo:hActivoFijo.Mov)=AF.RV) y hActivoFijo:hActivoFijo.ValorMercado)

[Detalle.hActivoFijoD.Importe]
Carpeta=Detalle
Clave=hActivoFijoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Columnas]
Importe=82
Aplica=96
AplicaID=74
AplicaProntoPago=96
Articulo=127
SerieLote=124
Serie=123
Revaluacion=79
Depreciacion=87
NuevoValor=106
Impuestos=66
Observaciones=115
ImporteTotal=89
MesesDepreciados=37
DepreciacionPorcentaje=79
RevaluacionDepreciacion=130
Inflacion=59
ActualizacionCapital=103
ActualizacionGastos=104
ActualizacionDepreciacion=131
Horas=35

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]
Pegado=S

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

Expresion=Afectar(<T>AF<T>, hActivoFijo:hActivoFijo.ID, hActivoFijo:hActivoFijo.Mov, hActivoFijo:hActivoFijo.MovID, <T>Todo<T>, <T><T>, <T>hActivoFijo<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hActivoFijo:hActivoFijo.Usuario) y<BR>(hActivoFijo:hActivoFijo.Estatus en (EstatusSinAfectar, EstatusPendiente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>AF<T>, hActivoFijo:hActivoFijo.Mov, hActivoFijo:hActivoFijo.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(hActivoFijo:hActivoFijo.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (hActivoFijo:hActivoFijo.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>AF<T>, hActivoFijo:hActivoFijo.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, hActivoFijo:hActivoFijo.ID, Verdadero, hActivoFijo:hActivoFijo.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(hActivoFijo:hActivoFijo.MovID) y (hActivoFijo:hActivoFijo.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, hActivoFijo:hActivoFijo.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM hActivoFijo WHERE ID=:nID<T>, hActivoFijo:hActivoFijo.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

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
ListaParametros1=hActivoFijo:hActivoFijo.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, hActivoFijo:hActivoFijo.Estatus), hActivoFijo:hActivoFijo.ID)
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
ListaParametros1=hActivoFijo:hActivoFijo.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, hActivoFijo:hActivoFijo.Mov), hActivoFijo:hActivoFijo.ID)
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
ActivoCondicion=hActivoFijo:hActivoFijo.Estatus en (EstatusSinAfectar, EstatusPendiente)

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
Expresion=Cancelar(<T>AF<T>, hActivoFijo:hActivoFijo.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>AF<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, hActivoFijo:hActivoFijo.Usuario) y ConDatos(hActivoFijo:hActivoFijo.ID) y ConDatos(hActivoFijo:hActivoFijo.MovID) y<BR>(hActivoFijo:hActivoFijo.Estatus<>EstatusCancelado)
AntesExpresiones=Asigna( Afectar.Mov, hActivoFijo:hActivoFijo.Mov ) <BR> Asigna( Afectar.MovID, hActivoFijo:hActivoFijo.MovID )

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
Expresion=Verificar(<T>AF<T>, hActivoFijo:hActivoFijo.ID,hActivoFijo:hActivoFijo.Mov,hActivoFijo:hActivoFijo.MovID)
ActivoCondicion=hActivoFijo:hActivoFijo.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(hActivoFijo:hActivoFijo.Mov)

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=48
ColorFondo=Plata
Efectos=[Negritas]
Pegado=N

[Acciones.Infomacion]
Nombre=Infomacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información del Proveedor
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Si<BR>  ConDatos(hActivoFijo:hActivoFijo.Proveedor) <BR>Entonces<BR>  Si<BR>    (hActivoFijo:Prov.Tipo<><T>Acreedor<T>) o Usuario.VerInfoAcreedores<BR>  Entonces<BR>    Asigna( Info.Proveedor,hActivoFijo:hActivoFijo.Proveedor ) <BR>    Asigna(Info.Origen, <T>AF<T>)<BR>    Forma( <T>ProvInfo<T> )<BR>  Fin<BR>Fin
ActivoCondicion=MovTipoEn(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, (AF.RE, AF.MA, AF.PS, AF.PM))

[Ficha.hActivoFijo.TipoCambio]
Carpeta=Ficha
Clave=hActivoFijo.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco

[Aplica.hActivoFijo.MovAplica]
Carpeta=Aplica
Clave=hActivoFijo.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.hActivoFijo.MovAplicaID]
Carpeta=Aplica
Clave=hActivoFijo.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10

[(Carpeta Abrir).hActivoFijo.Referencia]
Carpeta=(Carpeta Abrir)
Clave=hActivoFijo.Referencia
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

[(Carpeta Abrir).hActivoFijo.Concepto]
Carpeta=(Carpeta Abrir)
Clave=hActivoFijo.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
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
ActivoCondicion=ConDatos(hActivoFijo:hActivoFijo.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)<BR>Asigna(Info.Mov, hActivoFijo:hActivoFijo.Mov)<BR>Asigna(Info.MovID, hActivoFijo:hActivoFijo.MovID)
[Aplica.hActivoFijo.Proveedor]
Carpeta=Aplica
Clave=hActivoFijo.Proveedor
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>AF<T>, hActivoFijo:hActivoFijo.Mov, hActivoFijo:hActivoFijo.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>AF<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>AF<T>, hActivoFijo:hActivoFijo.Mov, hActivoFijo:hActivoFijo.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(hActivoFijo:hActivoFijo.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)<BR>Asigna(Info.Mov, hActivoFijo:hActivoFijo.Mov)<BR>Asigna(Info.Estatus, hActivoFijo:hActivoFijo.Estatus)<BR>Asigna(Info.Situacion, hActivoFijo:hActivoFijo.Situacion)
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
ActivoCondicion=ConfigModulo(<T>AF<T>,<T>Tiempos<T>)=<T>Si<T>
ConCondicion=S
EjecucionCondicion=ConDatos(hActivoFijo:hActivoFijo.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)<BR>Asigna(Info.Mov, hActivoFijo:hActivoFijo.Mov)<BR>Asigna(Info.MovID, hActivoFijo:hActivoFijo.MovID)
Visible=S

[(Carpeta Abrir).hActivoFijo.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=hActivoFijo.FechaEmision
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
ActivoCondicion=ConDatos(hActivoFijoA:hActivoFijo.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.ID, hActivoFijoA:hActivoFijo.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)<BR>Asigna(Info.Usuario, hActivoFijo:hActivoFijo.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(hActivoFijo:hActivoFijo.ID)

[(Carpeta Abrir).ImporteTotal]
Carpeta=(Carpeta Abrir)
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hActivoFijoD.Articulo]
Carpeta=Detalle
Clave=hActivoFijoD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hActivoFijo.Revaluar]
Carpeta=Ficha
Clave=hActivoFijo.Revaluar
Editar=S
3D=S
Tamano=13
ColorFondo=Blanco
Pegado=S

[Ficha.hActivoFijo.Todo]
Carpeta=Ficha
Clave=hActivoFijo.Todo
Editar=S
ValidaNombre=N
3D=S
Tamano=13
ColorFondo=Blanco
LineaNueva=N

[Detalle.hActivoFijoD.Serie]
Carpeta=Detalle
Clave=hActivoFijoD.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hActivoFijoD.Depreciacion]
Carpeta=Detalle
Clave=hActivoFijoD.Depreciacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hActivoFijo.ValorMercado]
Carpeta=Ficha
Clave=hActivoFijo.ValorMercado
Editar=S
ValidaNombre=N
3D=S
Tamano=13
ColorFondo=Blanco
Pegado=S

[Detalle.hActivoFijoD.NuevoValor]
Carpeta=Detalle
Clave=hActivoFijoD.NuevoValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hActivoFijoD.Impuestos]
Carpeta=Detalle
Clave=hActivoFijoD.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.hActivoFijoD.Observaciones]
Carpeta=Detalle
Clave=hActivoFijoD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.ImporteTotal]
Carpeta=Detalle
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Importe<BR>Impuestos<BR>Total
Totalizadores2=Suma(hActivoFijoD:hActivoFijoD.Importe)<BR>Suma(hActivoFijoD:hActivoFijoD.Impuestos)<BR>Suma(hActivoFijoD:ImporteTotal)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CondicionVisible=MovTipoEn(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, (AF.PS, AF.PM)) o (MovTipoEn(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, (AF.RE, AF.MA)) y ((no Config.AFMantenimientoPendiente) o (hActivoFijo:hActivoFijo.Estatus<>EstatusSinAfectar)))
[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Pegado=S

[(Carpeta Totalizadores).Impuestos]
Carpeta=(Carpeta Totalizadores)
Clave=Impuestos
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata

[Ficha.hActivoFijo.FormaPago]
Carpeta=Ficha
Clave=hActivoFijo.FormaPago
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.hActivoFijo.CtaDinero]
Carpeta=Ficha
Clave=hActivoFijo.CtaDinero
Editar=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco
EditarConBloqueo=N

[(Carpeta Abrir).hActivoFijo.Vencimiento]
Carpeta=(Carpeta Abrir)
Clave=hActivoFijo.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hActivoFijoD.MesesDepreciados]
Carpeta=Detalle
Clave=hActivoFijoD.MesesDepreciados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hActivoFijoD.DepreciacionPorcentaje]
Carpeta=Detalle
Clave=hActivoFijoD.DepreciacionPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ActivoFInfo]
Nombre=ActivoFInfo
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=Información del &Activo Fijo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFInfo
Visible=S
ConCondicion=S
EspacioPrevio=S
Antes=S
ActivoCondicion=MovTipoEn(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, (AF.DT, AF.RE, AF.MA, AF.PS, AF.PM, AF.A, AF.D)) o (no hActivoFijo:hActivoFijo.Todo) o (hActivoFijo:hActivoFijo.Estatus<>EstatusSinAfectar) o ((MovTipo(<T>AF<T>, hActivoFijo:hActivoFijo.Mov)=AF.RV) y hActivoFijo:hActivoFijo.ValorMercado)
EjecucionCondicion=ConDatos(hActivoFijoD:hActivoFijoD.Articulo) y ConDatos(hActivoFijoD:hActivoFijoD.Serie)
AntesExpresiones=Asigna(Info.Articulo, hActivoFijoD:hActivoFijoD.Articulo)<BR>Asigna(Info.SerieLote, hActivoFijoD:hActivoFijoD.Serie)

[Detalle.hActivoFijoD.ActualizacionCapital]
Carpeta=Detalle
Clave=hActivoFijoD.ActualizacionCapital
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hActivoFijoD.ActualizacionDepreciacion]
Carpeta=Detalle
Clave=hActivoFijoD.ActualizacionDepreciacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hActivoFijoD.Inflacion]
Carpeta=Detalle
Clave=hActivoFijoD.Inflacion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hActivoFijoD.Horas]
Carpeta=Detalle
Clave=hActivoFijoD.Horas
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.Rama, <T>AF<T>)<BR>Asigna(Info.Fecha, hActivoFijo:hActivoFijo.FechaEmision)<BR>Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hActivoFijo:hActivoFijo.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, hActivoFijo:hActivoFijo.Mov+<T> <T>+hActivoFijo:hActivoFijo.MovID)
RefrescarDespues=S

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
Expresion=CopiarMovimiento(<T>AF<T>, hActivoFijo:hActivoFijo.ID, <T>ActivoFijo<T>)

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
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFijoCampos
Antes=S
RefrescarDespues=S
AntesExpresiones=Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)<BR>Asigna(Info.Mov, hActivoFijo:hActivoFijo.Mov)<BR>Asigna(Info.MovID, hActivoFijo:hActivoFijo.MovID)
VisibleCondicion=hActivoFijo:hActivoFijo.Estatus<>EstatusSinAfectar
ActivoCondicion=no FormaBloqueada

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (hActivoFijo:hActivoFijo.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(hActivoFijo:hActivoFijo.ID),GuardarCambios)
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

[Ficha.hActivoFijo.UEN]
Carpeta=Ficha
Clave=hActivoFijo.UEN
Editar=S
3D=S
Pegado=N
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
EjecucionCondicion=ConDatos(hActivoFijo:hActivoFijo.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, hActivoFijo:hActivoFijo.Proyecto)
Visible=S

[Acciones.Asignar]
Nombre=Asignar
Boton=65
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=A&signar (en Lote)
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ActivoFAsignar
Visible=S
RefrescarDespues=S
Antes=S
DespuesGuardar=S
ActivoCondicion=(hActivoFijo:hActivoFijo.Estatus=EstatusSinAfectar) y <BR>(MovTipoEn(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, (AF.DT, AF.RE, AF.MA, AF.PS, AF.PM, AF.A, AF.D)) o (no hActivoFijo:hActivoFijo.Todo) o (hActivoFijo:hActivoFijo.Estatus<>EstatusSinAfectar) o ((MovTipo(<T>AF<T>, hActivoFijo:hActivoFijo.Mov)=AF.RV) y hActivoFijo:hActivoFijo.ValorMercado))
AntesExpresiones=Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)<BR>Asigna(Info.MovTipo, MovTipo(<T>AF<T>, hActivoFijo:hActivoFijo.Mov))<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Espacio, Nulo)<BR>Si<BR>  MovTipo(<T>AF<T>, hActivoFijo:hActivoFijo.Mov)=AF.D<BR>Entonces<BR>  Si<BR>    ConDatos(hActivoFijo:hActivoFijo.Personal)<BR>  Entonces<BR>    Asigna(Info.Personal, hActivoFijo:hActivoFijo.Personal)<BR>    Asigna(Info.Nombre, hActivoFijo:NombreCompleto)<BR>  Sino<BR>    Asigna(Info.Espacio, hActivoFijo:hActivoFijo.Espacio)<BR>    Asigna(Info.Nombre, hActivoFijo:NombreCompleto)<BR>  Fin<BR>Fin

[Ficha.hActivoFijo.Personal]
Carpeta=Ficha
Clave=hActivoFijo.Personal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
Pegado=N

[Ficha.NombreCompleto]
Carpeta=Ficha
Clave=NombreCompleto
Editar=S
3D=S
Tamano=25
ColorFondo=Plata

[Ficha.hActivoFijo.Espacio]
Carpeta=Ficha
Clave=hActivoFijo.Espacio
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=15
ColorFondo=Blanco

[Ficha.Espacio.Nombre]
Carpeta=Ficha
Clave=Espacio.Nombre
Editar=S
3D=S
Tamano=25
ColorFondo=Plata

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Visible=S
ActivoCondicion=ConDatos(hActivoFijo:hActivoFijo.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.Mov, hActivoFijo:hActivoFijo.Mov)<BR>Asigna(Info.Clave, <T>AF<T>+hActivoFijo:hActivoFijo.ID)<BR>Asigna(Info.Nombre, hActivoFijo:hActivoFijo.Mov+<T> <T>+hActivoFijo:hActivoFijo.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(hActivoFijo:hActivoFijo.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

[Ficha.hActivoFijo.ContUso]
Carpeta=Ficha
Clave=hActivoFijo.ContUso
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco

LineaNueva=S
EspacioPrevio=S
[Ficha.CentroCostos.Descripcion]
Carpeta=Ficha
Clave=CentroCostos.Descripcion
Editar=S
3D=S
Tamano=14
ColorFondo=Plata

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
AntesExpresiones=Asigna(Info.PuedeEditar, hActivoFijo:hActivoFijo.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, hActivoFijo:hActivoFijo.Mov)<BR>Asigna(Info.MovID, hActivoFijo:hActivoFijo.MovID)<BR>Asigna(Info.Proyecto, hActivoFijo:hActivoFijo.Proyecto)<BR>Asigna(Info.UEN, hActivoFijo:hActivoFijo.UEN)<BR>Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, hActivoFijo:hActivoFijo.Proveedor)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
AntesExpresiones=Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)<BR>Asigna(Info.Mov, hActivoFijo:hActivoFijo.Mov)<BR>Asigna(Info.MovID, hActivoFijo:hActivoFijo.MovID)<BR>Asigna(Info.Fecha, hActivoFijo:hActivoFijo.FechaEmision)<BR>Asigna(Info.Estatus, hActivoFijo:hActivoFijo.Estatus)

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
EjecucionCondicion=ConDatos(hActivoFijo:hActivoFijo.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>AF<T>)<BR>Asigna(Info.Clave, hActivoFijo:hActivoFijo.Mov)

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
EjecucionCondicion=ConDatos(hActivoFijo:hActivoFijo.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.Concepto, hActivoFijo:hActivoFijo.Concepto)

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
Expresion=Asigna(Info.Forma, <T>hActivoFijo<T>)<BR>Asigna(Info.Modulo, <T>AF<T>)<BR>Asigna(Info.Mov, hActivoFijo:hActivoFijo.Mov)<BR>Asigna(Info.Nombre, <T>Activos Fijos<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, hActivoFijo:hActivoFijo.ID, Falso, hActivoFijo:hActivoFijo.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>AF<T>+hActivoFijo:hActivoFijo.ID)<BR>  Asigna(Info.Nombre, hActivoFijo:hActivoFijo.Mov+<T> <T>+hActivoFijo:hActivoFijo.MovID)<BR>  Asigna(Info.Modulo, <T>AF<T>)<BR>  Asigna(Info.Mov, hActivoFijo:hActivoFijo.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      hActivoFijo:hActivoFijo.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>AF<T>, <T>{hActivoFijo:hActivoFijo.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>AF{hActivoFijo:hActivoFijo.ID}<T>

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
VerCampo=324
VerValor=307

[Lista.Columnas]
0=243
1=158




CentroCostos3=127
Descripcion=235
CentroCostos2=127
CentroCostos=127
2=-2
3=-2




[Detalle.ListaEnCaptura]
(Inicio)=hActivoFijoD.Articulo
hActivoFijoD.Articulo=hActivoFijoD.Serie
hActivoFijoD.Serie=hActivoFijoD.Observaciones
hActivoFijoD.Observaciones=hActivoFijoD.Horas
hActivoFijoD.Horas=hActivoFijoD.Importe
hActivoFijoD.Importe=hActivoFijoD.Impuestos
hActivoFijoD.Impuestos=ImporteTotal
ImporteTotal=hActivoFijoD.NuevoValor
hActivoFijoD.NuevoValor=hActivoFijoD.MesesDepreciados
hActivoFijoD.MesesDepreciados=hActivoFijoD.Depreciacion
hActivoFijoD.Depreciacion=hActivoFijoD.DepreciacionPorcentaje
hActivoFijoD.DepreciacionPorcentaje=hActivoFijoD.Inflacion
hActivoFijoD.Inflacion=hActivoFijoD.ActualizacionCapital
hActivoFijoD.ActualizacionCapital=hActivoFijoD.ActualizacionDepreciacion
hActivoFijoD.ActualizacionDepreciacion=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ActivoF.Referencia
ActivoF.Referencia=ActivoF.Almacen
ActivoF.Almacen=ActivoF.DepreciacionUltima
ActivoF.DepreciacionUltima=ActivoF.RevaluacionUltima
ActivoF.RevaluacionUltima=(Fin)

[Detalle.ListaOrden]
(Inicio)=hActivoFijoD.Renglon<TAB>(Acendente)
hActivoFijoD.Renglon<TAB>(Acendente)=hActivoFijoD.RenglonSub<TAB>(Acendente)
hActivoFijoD.RenglonSub<TAB>(Acendente)=(Fin)


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



























































[CentroCostos.hActivoFijo.ContUso2]
Carpeta=CentroCostos
Clave=hActivoFijo.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CentroCostos.hActivoFijo.ContUso3]
Carpeta=CentroCostos
Clave=hActivoFijo.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[CentroCostos.Columnas]
ContUso2=124
ContUso3=124

[CentroCostos.ListaEnCaptura]
(Inicio)=hActivoFijo.ContUso2
hActivoFijo.ContUso2=hActivoFijo.ContUso3
hActivoFijo.ContUso3=(Fin)




























































[Ficha.hActivoFijo.ContUso2]
Carpeta=Ficha
Clave=hActivoFijo.ContUso2
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Ficha.CentroCostos2.Descripcion]
Carpeta=Ficha
Clave=CentroCostos2.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=$00F0F0F0

[Ficha.hActivoFijo.ContUso3]
Carpeta=Ficha
Clave=hActivoFijo.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco





[Ficha.CentroCostos3.Descripcion]
Carpeta=Ficha
Clave=CentroCostos3.Descripcion
Editar=S
3D=S
Tamano=14
ColorFondo=$00F0F0F0









[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Impuestos
Impuestos=Total
Total=(Fin)

















































[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
NombreDesplegar=&Sugerir
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
















EspacioPrevio=S









GuardarAntes=S
Antes=S
DespuesGuardar=S






































































































































Expresion=Forma(<T>ActivoFijoSugerir<T>)<BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=Si MovTipoEn(<T>AF<T>, hActivoFijo:hActivoFijo.Mov, (AF.DP, AF.RV))<BR>Entonces<BR>  hActivoFijo:hActivoFijo.Estatus = EstatusSinAfectar y(no hActivoFijo:hActivoFijo.Todo)<BR>Sino<BR>  hActivoFijo:hActivoFijo.Estatus = EstatusSinAfectar<BR>Fin
AntesExpresiones=Asigna(Info.ID, hActivoFijo:hActivoFijo.ID)
[Ficha.ListaEnCaptura]
(Inicio)=hActivoFijo.Mov
hActivoFijo.Mov=hActivoFijo.MovID
hActivoFijo.MovID=hActivoFijo.Proyecto
hActivoFijo.Proyecto=hActivoFijo.UEN
hActivoFijo.UEN=hActivoFijo.Moneda
hActivoFijo.Moneda=hActivoFijo.TipoCambio
hActivoFijo.TipoCambio=hActivoFijo.FechaEmision
hActivoFijo.FechaEmision=hActivoFijo.FormaPago
hActivoFijo.FormaPago=hActivoFijo.CtaDinero
hActivoFijo.CtaDinero=hActivoFijo.Proveedor
hActivoFijo.Proveedor=Prov.Nombre
Prov.Nombre=hActivoFijo.Referencia
hActivoFijo.Referencia=hActivoFijo.Condicion
hActivoFijo.Condicion=hActivoFijo.Vencimiento
hActivoFijo.Vencimiento=hActivoFijo.Concepto
hActivoFijo.Concepto=hActivoFijo.Personal
hActivoFijo.Personal=NombreCompleto
NombreCompleto=hActivoFijo.Observaciones
hActivoFijo.Observaciones=hActivoFijo.Espacio
hActivoFijo.Espacio=Espacio.Nombre
Espacio.Nombre=hActivoFijo.ContUso
hActivoFijo.ContUso=CentroCostos.Descripcion
CentroCostos.Descripcion=hActivoFijo.ContUso2
hActivoFijo.ContUso2=CentroCostos2.Descripcion
CentroCostos2.Descripcion=hActivoFijo.ContUso3
hActivoFijo.ContUso3=CentroCostos3.Descripcion
CentroCostos3.Descripcion=hActivoFijo.Todo
hActivoFijo.Todo=hActivoFijo.Revaluar
hActivoFijo.Revaluar=hActivoFijo.ValorMercado
hActivoFijo.ValorMercado=(Fin)






















[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S








































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=hActivoFijo.FechaEmision
hActivoFijo.FechaEmision=hActivoFijo.Referencia
hActivoFijo.Referencia=hActivoFijo.Concepto
hActivoFijo.Concepto=ImporteTotal
ImporteTotal=hActivoFijo.Vencimiento
hActivoFijo.Vencimiento=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=VIGENTE
VIGENTE=CANCELADO
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
PlantillasOffice=Verificar
Verificar=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Afectar
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=Sugerir
Sugerir=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=Asignar
Asignar=Tareas
Tareas=Anexos
Anexos=Anterior
Anterior=Siguiente
Siguiente=ActivoFInfo
ActivoFInfo=Infomacion
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
