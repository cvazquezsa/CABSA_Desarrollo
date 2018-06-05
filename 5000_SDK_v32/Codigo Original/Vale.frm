[Forma]
Clave=Vale
Nombre=<T>Vales y Tarjetas<T>
Icono=0
Modulos=VALE
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=403
PosicionInicialArriba=111
PosicionInicialAltura=581
PosicionInicialAncho=633
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
PosicionSeccion1=49
PosicionSeccion2=93
BarraAyuda=S
MovModulo=VALE
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
PosicionColumna2=59
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)
Totalizadores=S
PosicionInicialAlturaCliente=598
PosicionSec1=270
PosicionSec2=495

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Vale
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

[Ficha.Vale.Mov]
Carpeta=Ficha
Clave=Vale.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vale.MovID]
Carpeta=Ficha
Clave=Vale.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Vale.FechaEmision]
Carpeta=Ficha
Clave=Vale.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vale.Concepto]
Carpeta=Ficha
Clave=Vale.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Ficha.Vale.Proyecto]
Carpeta=Ficha
Clave=Vale.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.Vale.Moneda]
Carpeta=Ficha
Clave=Vale.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vale.Observaciones]
Carpeta=Ficha
Clave=Vale.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=37
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
Vista=ValeA
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
ListaOrden=Vale.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Vale.FechaEmision
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
FiltroAplicaEn=Vale.Moneda
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroUsuarios=S
FiltroMovs=S
FiltroFechasCancelacion=Vale.FechaCancelacion
FiltroSucursales=S

IconosNombre=ValeA:Vale.Mov+<T> <T>+ValeA:Vale.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=153
1=110

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
Antes=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Vale:Vale.ID) y (Vale:Vale.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Vale:Vale.ID, <T>VALE<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ValeD:ValeD.Serie)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
AntesExpresiones=Asigna(Temp.Num, Conteo(ValeD:ValeD.Serie))<BR>Asigna(Vale:Vale.Cantidad, Si(Temp.Num=0, Nulo, Temp.Num))<BR>Asigna(Vale:Vale.Importe, Si(MovTipo(<T>VALE<T>, Vale:Vale.Mov)=VALE.E, Temp.Num * Vale:Vale.Precio, DisminuyePorcentaje(Suma(ValeD:ValeSerie.Precio), Vale:Vale.DescuentoGlobal)))

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
Vista=ValeD
Fuente={Fixedsys, 9, Negro, []}
VistaMaestra=Vale
LlaveLocal=ValeD.ID
LlaveMaestra=Vale.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
HojaFondoGrisAuto=S
PermiteLocalizar=S
PestanaNombre=Multiples
CarpetaVisible=S
HojaPermiteEliminar=S
HojaPermiteInsertar=S
ListaEnCaptura=(Lista)
HojaAjustarColumnas=S

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
Diferencia=91
%Diferencia=64
DiferenciaPorcentaje=56
Vale=218
Serie=176
Tipo=122
Precio=104
FechaEmision=94

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
Totalizadores1=Conteo<BR>Importe
Totalizadores2=Conteo(ValeD:ValeD.Serie)<BR>Caso MovTipo(<T>VALE<T>, Vale:Vale.Mov)    Es VALE.AMLDI Entonces Suma(ValeD:ValeD.Importe) Es VALE.ACTMLDI Entonces Suma(ValeD:ValeD.Importe)Es VALE.E Entonces Conteo(ValeD:ValeD.Serie) * Vale:Vale.Precio Es VALE.ET Entonces Conteo(ValeD:ValeD.Serie) * Vale:Vale.Precio Es VALE.AT Entonces Suma(ValeD:ValeD.Importe) Sino DisminuyePorcentaje(Suma(ValeD:ValeSerie.Precio), Vale:Vale.DescuentoGlobal) Fin
Totalizadores3= <BR>(Monetario)
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

Expresion=Afectar(<T>VALE<T>, Vale:Vale.ID, Vale:Vale.Mov, Vale:Vale.MovID, <T>Todo<T>, <T><T>, <T>VALE<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Vale:Vale.Usuario) y<BR>(Vale:Vale.Estatus en (EstatusSinAfectar, EstatusPendiente, EstatusVigente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>VALE<T>, Vale:Vale.Mov, Vale:Vale.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Vale:Vale.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Vale:Vale.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>VALE<T>, Vale:Vale.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>VALE<T>, Vale:Vale.Mov, Vale:Vale.ID, Verdadero, Vale:Vale.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Vale:Vale.MovID) y (Vale:Vale.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Vale:Vale.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Vale WHERE ID=:nID<T>, Vale:Vale.ID))
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
ListaParametros1=Vale:Vale.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>VALE<T>, Vale:Vale.Mov, Vale:Vale.Estatus), Vale:Vale.ID)
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
ListaParametros1=Vale:Vale.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>VALE<T>, Vale:Vale.Mov, Vale:Vale.Estatus), Vale:Vale.ID)
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
ActivoCondicion=Vale:Vale.Estatus=EstatusSinAfectar

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
Expresion=Cancelar(<T>VALE<T>, Vale:Vale.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>VALE<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Vale:Vale.Usuario) y ConDatos(Vale:Vale.ID) y ConDatos(Vale:Vale.MovID) y<BR>(Vale:Vale.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusConcluido, EstatusPendiente, EstatusVigente))
AntesExpresiones=Asigna( Afectar.Mov, Vale:Vale.Mov ) <BR>Asigna( Afectar.MovID, Vale:Vale.MovID )

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
Expresion=Verificar(<T>VALE<T>, Vale:Vale.ID,Vale:Vale.Mov,Vale:Vale.MovID)
ActivoCondicion=Vale:Vale.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Vale:Vale.Mov)

[Ficha.Vale.TipoCambio]
Carpeta=Ficha
Clave=Vale.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Vale.MovAplica]
Carpeta=Aplica
Clave=Vale.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.Vale.MovAplicaID]
Carpeta=Aplica
Clave=Vale.MovAplicaID
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

[(Carpeta Abrir).Vale.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Vale.Concepto
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
ActivoCondicion=ConDatos(Vale:Vale.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.ID, Vale:Vale.ID)<BR>Asigna(Info.Mov, Vale:Vale.Mov)<BR>Asigna(Info.MovID, Vale:Vale.MovID)
[Aplica.Vale.Proveedor]
Carpeta=Aplica
Clave=Vale.Proveedor
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>VALE<T>, Vale:Vale.Mov, Vale:Vale.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>VALE<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>VALE<T>, Vale:Vale.Mov, Vale:Vale.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Vale:Vale.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.ID, Vale:Vale.ID)<BR>Asigna(Info.Mov, Vale:Vale.Mov)<BR>Asigna(Info.Estatus, Vale:Vale.Estatus)<BR>Asigna(Info.Situacion, Vale:Vale.Situacion)
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
ActivoCondicion=ConfigModulo(<T>VALE<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Vale:Vale.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.ID, Vale:Vale.ID)<BR>Asigna(Info.Mov, Vale:Vale.Mov)<BR>Asigna(Info.MovID, Vale:Vale.MovID)

[(Carpeta Abrir).Vale.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Vale.FechaEmision
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
ActivoCondicion=ConDatos(ValeA:Vale.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.ID, ValeA:Vale.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.ID, Vale:Vale.ID)<BR>Asigna(Info.Usuario, Vale:Vale.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Vale:Vale.ID)

[Ficha.Vale.Referencia]
Carpeta=Ficha
Clave=Vale.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=31
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
AntesExpresiones=Asigna(Info.Rama, <T>VALE<T>)<BR>Asigna(Info.Fecha, Vale:Vale.FechaEmision)<BR>Asigna(Info.ID, Vale:Vale.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Vale:Vale.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Vale:Vale.Mov+<T> <T>+Vale:Vale.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(Vale:Vale.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.ID, Vale:Vale.ID)
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
Expresion=CopiarMovimiento(<T>VALE<T>, Vale:Vale.ID, <T>VALE<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Vale:Vale.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Vale:Vale.ID),GuardarCambios)
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

[Detalle.ValeD.Serie]
Carpeta=Detalle
Clave=ValeD.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Asistente]
Nombre=Asistente
Boton=12
Menu=&Edición
UsaTeclaRapida=S
NombreDesplegar=Asistente
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Series/Lotes
ListaParametros1=ValeD:ValeD.Serie
ListaParametros=S
Visible=S
TeclaRapida=F7
EspacioPrevio=S
Antes=S
ActivoCondicion=Vale:Vale.Estatus=EstatusSinAfectar
AntesExpresiones=Si<BR>  MovTipoEn(<T>VALE<T>, Vale:Vale.Mov, (VALE.E, VALE.EV, VALE.EO))<BR>Entonces<BR>  Asigna(Info.Mensaje, SQL(<T>SELECT MAX(Serie) FROM ValeSerie<T>))<BR>  Si(ConDatos(Info.Mensaje), Informacion(<T>Ultima Serie Emitida: <T>+Info.Mensaje)))<BR>Fin

[(Carpeta Abrir).Vale.Cantidad]
Carpeta=(Carpeta Abrir)
Clave=Vale.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Totalizador=1

[Ficha.Vale.FechaInicio]
Carpeta=Ficha
Clave=Vale.FechaInicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.Vale.FechaTermino]
Carpeta=Ficha
Clave=Vale.FechaTermino
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.Vale.Cliente]
Carpeta=Ficha
Clave=Vale.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=N

[Ficha.Vale.Agente]
Carpeta=Ficha
Clave=Vale.Agente
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vale.Condicion]
Carpeta=Ficha
Clave=Vale.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vale.Vencimiento]
Carpeta=Ficha
Clave=Vale.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vale.Descuento]
Carpeta=Ficha
Clave=Vale.Descuento
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
ValidaNombre=S

[Ficha.Vale.Tipo]
Carpeta=Ficha
Clave=Vale.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Vale.Tipo]
Carpeta=(Carpeta Abrir)
Clave=Vale.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.ValeSerie.Precio]
Carpeta=Detalle
Clave=ValeSerie.Precio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]

[(Carpeta Abrir).Vale.Importe]
Carpeta=(Carpeta Abrir)
Clave=Vale.Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Vale.DescuentoGlobal]
Carpeta=Ficha
Clave=Vale.DescuentoGlobal
Editar=N
3D=S
Pegado=S
Tamano=6
ColorFuente=Gris
ColorFondo=Blanco

[Acciones.InfoVale]
Nombre=InfoVale
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=Información Vale
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ValeSerieInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ValeD:ValeD.Serie)
AntesExpresiones=Asigna(Info.Vale, ValeD:ValeD.Serie)<BR>Si(ValeD:ValeSerie.TipoTarjeta, Asigna(Rep.Titulo, <T>Información de la Tarjeta<T>), Asigna(Rep.Titulo, <T>Información del Vale<T>))

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información del Cliente
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteInfo
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Usuario.CteInfo y MovTipoEn(<T>VALE<T>, Vale:Vale.Mov, (VALE.V, VALE.D, VALE.EV, VALE.EO, VALE.O))
EjecucionCondicion=ConDatos(Vale:Vale.Cliente)
AntesExpresiones=Asigna(Info.Cliente, Vale:Vale.Cliente)

[Detalle.ValeSerie.Tipo]
Carpeta=Detalle
Clave=ValeSerie.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.Vale.Precio]
Carpeta=Ficha
Clave=Vale.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vale.CtaDinero]
Carpeta=Ficha
Clave=Vale.CtaDinero
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vale.FormaPago]
Carpeta=Ficha
Clave=Vale.FormaPago
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Vale.UEN]
Carpeta=Ficha
Clave=Vale.UEN
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
EjecucionCondicion=ConDatos(Vale:Vale.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Vale:Vale.Proyecto)
Visible=S

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.Mov, Vale:Vale.Mov)<BR>Asigna(Info.Clave, <T>VALE<T>+Vale:Vale.ID)<BR>Asigna(Info.Nombre, Vale:Vale.Mov+<T> <T>+Vale:Vale.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Vale:Vale.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
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
AntesExpresiones=Asigna(Info.PuedeEditar, Vale:Vale.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Vale:Vale.Mov)<BR>Asigna(Info.MovID, Vale:Vale.MovID)<BR>Asigna(Info.Proyecto, Vale:Vale.Proyecto)<BR>Asigna(Info.UEN, Vale:Vale.UEN)<BR>Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.ID, Vale:Vale.ID)<BR><BR>Asigna(Info.Cliente, Vale:Vale.Cliente)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Vale:Vale.Agente)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
AntesExpresiones=Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.ID, Vale:Vale.ID)<BR>Asigna(Info.Mov, Vale:Vale.Mov)<BR>Asigna(Info.MovID, Vale:Vale.MovID)<BR>Asigna(Info.Fecha, Vale:Vale.FechaEmision)<BR>Asigna(Info.Estatus, Vale:Vale.Estatus)

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
EjecucionCondicion=ConDatos(Vale:Vale.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>VALE<T>)<BR>Asigna(Info.Clave, Vale:Vale.Mov)

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
EjecucionCondicion=ConDatos(Vale:Vale.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.Concepto, Vale:Vale.Concepto)

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>Vale<T>)<BR>Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.Mov, Vale:Vale.Mov)<BR>Asigna(Info.Nombre, Vale:Vale.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>VALE<T>, Vale:Vale.Mov, Vale:Vale.ID, Falso, Vale:Vale.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>VALE<T>+Vale:Vale.ID)<BR>  Asigna(Info.Nombre, Vale:Vale.Mov+<T> <T>+Vale:Vale.MovID)<BR>  Asigna(Info.Modulo, <T>VALE<T>)<BR>  Asigna(Info.Mov, Vale:Vale.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Vale:Vale.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>VALE<T>)<BR>Asigna(Info.ID, Vale:Vale.ID)<BR>Asigna(Info.Mov, Vale:Vale.Mov)<BR>Asigna(Info.MovID, Vale:Vale.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (Vale:Vale.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Detalle.ValeD.Importe]
Carpeta=Detalle
Clave=ValeD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Vale.Articulo]
Carpeta=Ficha
Clave=Vale.Articulo
Editar=S
ValidaNombre=N
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.Vale.Almacen]
Carpeta=Ficha
Clave=Vale.Almacen
Editar=S
ValidaNombre=N
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>VALE<T>, <T>{Vale:Vale.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>VALE{Vale:Vale.ID}<T>
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
VerCampo=290
VerValor=290








[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)


[Ficha.Vale.TarjetaDestino]
Carpeta=Ficha
Clave=Vale.TarjetaDestino
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro















[Ficha.ListaEnCaptura]
(Inicio)=Vale.Mov
Vale.Mov=Vale.MovID
Vale.MovID=Vale.Proyecto
Vale.Proyecto=Vale.UEN
Vale.UEN=Vale.Moneda
Vale.Moneda=Vale.TipoCambio
Vale.TipoCambio=Vale.FechaEmision
Vale.FechaEmision=Vale.CtaDinero
Vale.CtaDinero=Vale.FormaPago
Vale.FormaPago=Vale.Cliente
Vale.Cliente=Cte.Nombre
Cte.Nombre=Vale.Agente
Vale.Agente=Vale.Descuento
Vale.Descuento=Vale.DescuentoGlobal
Vale.DescuentoGlobal=Vale.Condicion
Vale.Condicion=Vale.Vencimiento
Vale.Vencimiento=Vale.Tipo
Vale.Tipo=Vale.FechaInicio
Vale.FechaInicio=Vale.Articulo
Vale.Articulo=Vale.Precio
Vale.Precio=Vale.FechaTermino
Vale.FechaTermino=Vale.Almacen
Vale.Almacen=Vale.Concepto
Vale.Concepto=Vale.Referencia
Vale.Referencia=Vale.Observaciones
Vale.Observaciones=Vale.TarjetaDestino
Vale.TarjetaDestino=(Fin)













[Lista.Columnas]
0=172
1=82
2=-2





































Articulo=131
Descripcion1=244
Almacen=90
Nombre=229
Grupo=100
Sucursal=46
[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S













































































































[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122




















































[Detalle.ListaEnCaptura]
(Inicio)=ValeD.Serie
ValeD.Serie=ValeD.Importe
ValeD.Importe=ValeSerie.Tipo
ValeSerie.Tipo=ValeSerie.Precio
ValeSerie.Precio=(Fin)











































[Acciones.LDIMovLog]
Nombre=LDIMovLog
Boton=0
Menu=&Ver
NombreDesplegar=LDI Log
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=LDIMovLog
Activo=S




Antes=S
DespuesGuardar=S
















































AntesExpresiones=Asigna(Info.Modulo,<T>VALE<T>)<BR>Asigna(Info.ID,Vale:Vale.ID)
VisibleCondicion=General.InterfazLDI y(SQL(<T>SELECT dbo.fnLDIVentaExiste(:nID,:tModulo)<T>,Vale:Vale.ID,<T>VALE<T>))












[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Conteo
Conteo=(Fin)































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Vale.FechaEmision
Vale.FechaEmision=Vale.Concepto
Vale.Concepto=Vale.Cantidad
Vale.Cantidad=Vale.Tipo
Vale.Tipo=Vale.Importe
Vale.Importe=(Fin)

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
ReasignarUsuario=Totalizar
Totalizar=Asistente
Asistente=CamposExtras
CamposExtras=Tareas
Tareas=Anexos
Anexos=Anterior
Anterior=Siguiente
Siguiente=CteInfo
CteInfo=InfoVale
InfoVale=ProyInfo
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
Otros9=LDIMovLog
LDIMovLog=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
