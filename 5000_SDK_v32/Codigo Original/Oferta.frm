[Forma]
Clave=Oferta
Nombre=<T>Oferta<T>
Icono=0
Modulos=OFER
ListaCarpetas=(Lista)
CarpetaPrOFERipal=Ficha
PosicionInicialIzquierda=276
PosicionInicialArriba=92
PosicionInicialAltura=558
PosicionInicialAncho=751
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
PosicionSeccion1=64
PosicionSeccion2=92
BarraAyuda=S
MovModulo=OFER
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=545
PosicionSec1=235
MenuPrOFERipal=&Archivo<BR>&Edición<BR>&Ver<BR>&Otros
CarpetaPrincipal=Ficha
AutoGuardarEncabezado=S
Totalizadores=S
PosicionSec2=443
ExpresionesAlMostrar=Asigna(Info.Campo, Nulo)

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Oferta
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=100
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
FichaEspacioNombresAuto=S
Pestana=S

[Ficha.Oferta.Mov]
Carpeta=Ficha
Clave=Oferta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

[Ficha.Oferta.MovID]
Carpeta=Ficha
Clave=Oferta.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=7
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.Oferta.FechaEmision]
Carpeta=Ficha
Clave=Oferta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Oferta.Proyecto]
Carpeta=Ficha
Clave=Oferta.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
Pegado=N
EditarConBloqueo=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=OfertaA
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
ListaOrden=Oferta.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Oferta.FechaEmision
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
BusquedaRespetarUsuario=S
BusquedaRespetarControlesNum=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasNormal=S
FiltroFechasCancelacion=Oferta.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S
FiltroUsuarios=S
ListaEnCaptura=(Lista)
BusquedaSelCampo=S
IconosNombre=OfertaA:Oferta.Mov+<T> <T>+OfertaA:Oferta.MovID
[(Carpeta Abrir).Columnas]
0=290
1=190
2=109
3=119
4=83
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=S
Activo=S
Menu=&Archivo
UsaTeclaRapida=S
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Oferta:Oferta.ID) y (Oferta:Oferta.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Oferta:Oferta.ID, <T>OFER<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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
ConCondicion=S
EspacioPrevio=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
Expresion=Si<BR> (Oferta:Oferta.Estatus en (EstatusPendiente))<BR>Entonces<BR>  Asigna(Info.Modulo, <T>OFER<T>)<BR>  Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>  Asigna(Info.MovID, Oferta:Oferta.MovID)<BR>  Si(Forma(<T>GenerarMovFlujo<T>), Generar(<T>OFER<T>, Oferta:Oferta.ID, Oferta:Oferta.Mov, Oferta:Oferta.MovID, <T>Todo<T>, Info.MovGenerar, <T>Oferta<T>))<BR>Sino<BR>  Si<BR>    Oferta:Oferta.Estatus=EstatusSinAfectar<BR>  Entonces<BR>    Afectar(<T>OFER<T>, Oferta:Oferta.ID, Oferta:Oferta.Mov, Oferta:Oferta.MovID, <T>Todo<T>, <T><T>, <T>Oferta<T>)<BR>  Sino<BR>    Asigna(Afectar.Modulo, <T>OFER<T>)<BR>    Asigna(Afectar.Mov, Oferta:Oferta.Mov)<BR>    Asigna(Afectar.MovID, Oferta:Soporte.MovID) <BR>    Asigna(Afectar.ID, Oferta:Oferta.ID)<BR>    Asigna(Info.TituloDialogo, Capital:Oferta.Mov+<T> <T>+Oferta:Oferta.MovID)<BR>    Asigna(Info.Estado, Oferta:Oferta.Estado)<BR>    Dialogo(<T>AfectarOferta<T>)<BR>  Fin<BR>Fin<BR>Asigna(Temp.Personal, Nulo)<BR>Asigna(Temp.NominaConcepto, Nulo)<BR>Asigna(Temp.AcumuladoAnual, Nulo)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Oferta:Oferta.Usuario) y <BR>(Oferta:Oferta.Estatus en (EstatusSinAfectar, EstatusPendiente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>OFER<T>, Oferta:Oferta.Mov, Oferta:Oferta.Estatus, FormaSituacion, Sucursal) y<BR>(Oferta:Oferta.Estatus=EstatusSinAfectar)
EjecucionCondicion=ConDatos(Oferta:Oferta.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Oferta:Oferta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>OFER<T>, Oferta:Oferta.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>OFER<T>, Oferta:Oferta.Mov, Oferta:Oferta.ID, Verdadero, Oferta:Oferta.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EspacioPrevio=S
ActivoCondicion=Vacio(Oferta:Oferta.MovID) y (Oferta:Oferta.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Oferta:Oferta.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Oferta WHERE ID=:nID<T>, Oferta:Oferta.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
UsaTeclaRapida=
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=
TipoAccion=Expresion
ListaParametros1=Oferta:Oferta.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>OFER<T>, Oferta:Oferta.Mov, Oferta:Oferta.Estatus), Oferta:Oferta.ID)
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
ListaParametros1=Oferta:Oferta.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>OFER<T>, Oferta:Oferta.Mov, Oferta:Oferta.Estatus), Oferta:Oferta.ID)
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
Expresion=Cancelar(<T>OFER<T>, Oferta:Oferta.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Oferta<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Oferta:Oferta.Usuario) y ConDatos(Oferta:Oferta.ID) y ConDatos(Oferta:Oferta.MovID) y<BR>((Oferta:Oferta.Estatus en (EstatusSinAfectar, EstatusSincro, EstatusPendiente, EstatusVigente)) o<BR>(Oferta:Oferta.Estatus=EstatusConcluido))
AntesExpresiones=Asigna(Afectar.Mov, Oferta:Oferta.Mov) <BR>Asigna(Afectar.MovID, Oferta:Oferta.MovID)<BR>Asigna(Temp.Personal, Nulo)<BR>Asigna(Temp.NominaConcepto, Nulo)<BR>Asigna(Temp.AcumuladoAnual, Nulo)

[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
EspacioPrevio=S
ConCondicion=S
EnBarraHerramientas=S
Expresion=Verificar(<T>OFER<T>, Oferta:Oferta.ID,Oferta:Oferta.Mov,Oferta:Oferta.MovID)
ActivoCondicion=Oferta:Oferta.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Oferta:Oferta.Mov)

[Aplica.Oferta.MovAplica]
Carpeta=Aplica
Clave=Oferta.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Oferta.MovAplicaID]
Carpeta=Aplica
Clave=Oferta.MovAplicaID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
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
TipoAccion=Expresion
Antes=S
Visible=S
EspacioPrevio=S
Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(Oferta:Oferta.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.MovID, Oferta:Oferta.MovID)
[Aplica.Oferta.Agente]
Carpeta=Aplica
Clave=Oferta.Agente
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>OFER<T>, Oferta:Oferta.Mov, Oferta:Oferta.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>OFER<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>OFER<T>, Oferta:Oferta.Mov, Oferta:Oferta.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Oferta:Oferta.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.Estatus, Oferta:Oferta.Estatus)<BR>Asigna(Info.Situacion, Oferta:Oferta.Situacion)
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
ActivoCondicion=ConfigModulo(<T>OFER<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Oferta:Oferta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.MovID, Oferta:Oferta.MovID)

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

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Impuestos]
Carpeta=(Carpeta Totalizadores)
Clave=Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Retención]
Carpeta=(Carpeta Totalizadores)
Clave=Retención
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

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
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>OFER<T>)<BR>Asigna(Info.Fecha, Oferta:Oferta.FechaEmision)<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Oferta:Oferta.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Oferta:Oferta.Mov+<T> <T>+Oferta:Oferta.MovID)
RefrescarDespues=S

[Acciones.Bitacora]
Nombre=Bitacora
Boton=56
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+B
NombreDesplegar=Bitácora
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovBitacora
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=Si(Vacio(Oferta:Oferta.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.MovID, Oferta:Oferta.MovID)<BR>Asigna(Info.PuedeEditar, Oferta:Oferta.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Oferta:Oferta.Usuario))

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
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Oferta:Oferta.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Oferta:Oferta.Usuario)
EjecucionCondicion=Si(Vacio(Oferta:Oferta.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.MovID, Oferta:Oferta.MovID)

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
ActivoCondicion=ConDatos(Oferta:Oferta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.ID, Oferta:Oferta.ID)

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
Expresion=CopiarMovimiento(<T>OFER<T>, Oferta:Oferta.ID, <T>Oferta<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Oferta:Oferta.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Oferta:Oferta.ID),GuardarCambios)
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

[Detalle.Columnas]
Aplica=97
AplicaID=64
FechaEmision=128
Reporte=136
Tipo=107
Asunto=232
Socio=83
Titulo=86
Cantidad=48
Precio=101
Costo=103
PrecioTotal=104
CostoTotal=93
Folio=42
Movimiento=109
Importe=107
Numero=43
0=49
1=92
Base=124
Usar=124
Redondeo=64
Articulo=124
Monto=48
Campo=118
Valor=127
Obsequio=89
TieneVolumen=45
VolumenTipo=80
Desde=44
Porcentaje=48
PrecioLista=84
PrecioBase=94
MargenImporte=57
MargenPrecioLista=97
MargenPrecio=56
Margen=54
SubCuenta=113
Moneda=89
Unidad=57
UnidadObsequio=94
Factor=64
SubCuentaObsequio=107
[Ficha.Oferta.UEN]
Carpeta=Ficha
Clave=Oferta.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
EditarConBloqueo=S

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
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
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
AntesExpresiones=Asigna(Info.PuedeEditar, Oferta:Oferta.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.MovID, Oferta:Oferta.MovID)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Oferta:Oferta.Proveedor)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Oferta:Oferta.Proyecto)<BR>Asigna(Info.UEN, Oferta:Oferta.UEN)<BR>Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Reporte, Nulo)
[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.Clave, <T>OFER<T>+Oferta:Oferta.ID)<BR>Asigna(Info.Nombre, Oferta:Oferta.Mov+<T> <T>+Oferta:Oferta.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Oferta:Oferta.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.MovID, Oferta:Oferta.MovID)<BR>Asigna(Info.Fecha, Oferta:Oferta.FechaEmision)<BR>Asigna(Info.Estatus, Oferta:Oferta.Estatus)

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
EjecucionCondicion=ConDatos(Oferta:Oferta.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>OFER<T>)<BR>Asigna(Info.Clave, Oferta:Oferta.Mov)

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
EjecucionCondicion=ConDatos(Oferta:Oferta.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.Concepto, Oferta:Oferta.Concepto)

[Detalle]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=OfertaD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Oferta
LlaveLocal=OfertaD.ID
LlaveMaestra=Oferta.ID
CampoColorLetras=Negro
CampoColorFondo=Blanco
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
PermiteEditar=S
MenuLocal=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
ListaEnCaptura=(Lista)
ListaAcciones=Volumen
HojaFondoGrisAuto=S
OtroOrden=S
ListaOrden=OfertaD.Renglon<TAB>(Acendente)
ControlRenglon=S
CampoRenglon=OfertaD.Renglon
CondicionVisible=MovTipo(<T>OFER<T>, Oferta:Oferta.Mov) <> OFER.OG
[Ficha.Oferta.Referencia]
Carpeta=Ficha
Clave=Oferta.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.Oferta.Observaciones]
Carpeta=Ficha
Clave=Oferta.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=84
ColorFondo=Blanco

[Ficha.Oferta.Moneda]
Carpeta=Ficha
Clave=Oferta.Moneda
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Oferta.TipoCambio]
Carpeta=Ficha
Clave=Oferta.TipoCambio
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco
Pegado=S

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
Expresion=Asigna(Info.Forma, <T>Oferta<T>)<BR>Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.Nombre, Oferta:Oferta.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>OFER<T>, Oferta:Oferta.Mov, Oferta:Oferta.ID, Falso, Oferta:Oferta.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>OFER<T>+Oferta:Oferta.ID)<BR>  Asigna(Info.Nombre, Oferta:Oferta.Mov+<T> <T>+Oferta:Oferta.MovID)<BR>  Asigna(Info.Modulo, <T>OFER<T>)<BR>  Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Oferta:Oferta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[(Carpeta Totalizadores).Cantidad Total]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
LineaNueva=S

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
AntesExpresiones=Asigna(Info.Modulo, <T>OFER<T>)<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.MovID, Oferta:Oferta.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (Oferta:Oferta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=Oferta:Oferta.Estatus en (EstatusPendiente, EstatusConcluido, EstatusCancelado)

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>OFER<T>, <T>{Oferta:Oferta.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>OFER{Oferta:Oferta.ID}<T>

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

[(Carpeta Abrir).Oferta.FechaD]
Carpeta=(Carpeta Abrir)
Clave=Oferta.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Oferta.FechaA]
Carpeta=(Carpeta Abrir)
Clave=Oferta.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Oferta.Concepto]
Carpeta=Ficha
Clave=Oferta.Concepto
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Filtro
EnBarraHerramientas=S
EnMenu=S
TipoAccion=formas
ClaveAccion=OfertaFiltro
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
Multiple=S
ListaAccionesMultiples=Filtro
ActivoCondicion=(Oferta:Oferta.Estatus=EstatusSinAfectar) o (Oferta:Oferta.Estatus=EstatusConcluido) o (Oferta:Oferta.Estatus=EstatusVigente)
AntesExpresiones=Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.MovID, Oferta:Oferta.MovID)<BR>Asigna(Info.PuedeEditar, Oferta:Oferta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
[Vigencia]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Vigencia
Clave=Vigencia
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Oferta
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

[Vigencia.Oferta.FechaD]
Carpeta=Vigencia
Clave=Oferta.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Vigencia.Oferta.FechaA]
Carpeta=Vigencia
Clave=Oferta.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Vigencia.Oferta.HoraD]
Carpeta=Vigencia
Clave=Oferta.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Vigencia.Oferta.HoraA]
Carpeta=Vigencia
Clave=Oferta.HoraA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Vigencia.Oferta.DiasEsp]
Carpeta=Vigencia
Clave=Oferta.DiasEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tipo.Oferta.Tipo]
Carpeta=Tipo
Clave=Oferta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tipo.Oferta.Base]
Carpeta=Tipo
Clave=Oferta.Base
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tipo.Oferta.Usar]
Carpeta=Tipo
Clave=Oferta.Usar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tipo.Oferta.Redondear]
Carpeta=Tipo
Clave=Oferta.Redondear
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Tipo.Oferta.Redondeo]
Carpeta=Tipo
Clave=Oferta.Redondeo
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Tipo.Oferta.Monto]
Carpeta=Tipo
Clave=Oferta.Monto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tipo.Oferta.ArticuloObsequio]
Carpeta=Tipo
Clave=Oferta.ArticuloObsequio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
Totalizadores1=Importe Total
Totalizadores2=Suma(OfertaD:OfertaD.Importe)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Importe Total
FichaAlineacionDerecha=S
CondicionVisible=MovTipo(<T>OFER<T>, Oferta:Oferta.Mov) = OFER.OA

[Ficha.Oferta.Tipo]
Carpeta=Ficha
Clave=Oferta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.OfertaD.Articulo]
Carpeta=Detalle
Clave=OfertaD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.OfertaD.Cantidad]
Carpeta=Detalle
Clave=OfertaD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.OfertaD.Porcentaje]
Carpeta=Detalle
Clave=OfertaD.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.OfertaD.Importe]
Carpeta=Detalle
Clave=OfertaD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Oferta.MontoMinimo]
Carpeta=Ficha
Clave=Oferta.MontoMinimo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=N

[Ficha.Oferta.TodasSucursales]
Carpeta=Ficha
Clave=Oferta.TodasSucursales
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Acciones.Sucursales]
Nombre=Sucursales
Boton=16
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Sucursales
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=OfertaSucursalEsp
Visible=S
Antes=S
EspacioPrevio=S
ActivoCondicion=(Oferta:Oferta.Estatus=EstatusSinAfectar) y (no Oferta:Oferta.TodasSucursales)
AntesExpresiones=Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Mov, Oferta:Oferta.Mov)<BR>Asigna(Info.MovID, Oferta:Oferta.MovID)<BR>Asigna(Info.PuedeEditar, Oferta:Oferta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Ficha.Oferta.Forma]
Carpeta=Ficha
Clave=Oferta.Forma
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Oferta.Usar]
Carpeta=Ficha
Clave=Oferta.Usar
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Oferta.TieneVolumen]
Carpeta=Ficha
Clave=Oferta.TieneVolumen
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[Grupal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Oferta Grupal
Clave=Grupal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Oferta
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
CondicionVisible=MovTipo(<T>OFER<T>, Oferta:Oferta.Mov) = OFER.OG
[Grupal.Oferta.Categoria]
Carpeta=Grupal
Clave=Oferta.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.Grupo]
Carpeta=Grupal
Clave=Oferta.Grupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.Familia]
Carpeta=Grupal
Clave=Oferta.Familia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.Linea]
Carpeta=Grupal
Clave=Oferta.Linea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.Fabricante]
Carpeta=Grupal
Clave=Oferta.Fabricante
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.Porcentaje]
Carpeta=Grupal
Clave=Oferta.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.OfertaD.Obsequio]
Carpeta=Detalle
Clave=OfertaD.Obsequio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.OfertaD.Precio]
Carpeta=Detalle
Clave=OfertaD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Volumen]
Nombre=Volumen
Boton=0
NombreDesplegar=&Volumen
EnMenu=S
TipoAccion=Formas
ClaveAccion=OfertaDVol
Antes=S
Visible=S
ActivoCondicion=Oferta:Oferta.TieneVolumen
AntesExpresiones=Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Articulo, OfertaD:OfertaD.Articulo)<BR>Asigna(Info.PuedeEditar, Oferta:Oferta.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Asigna(Info.Usar,Oferta:Oferta.Usar)
GuardarAntes=S
[Acciones.Asignar]
Nombre=Asignar
Boton=65
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=Ar&tículos
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OfertaArtLista
Antes=S
Visible=S
NombreEnBoton=S
DespuesGuardar=S
ActivoCondicion=(MovTipo(<T>OFER<T>, Oferta:Oferta.Mov) noen (OFER.OG, OFER.OM))  y (Oferta:Oferta.Estatus=EstatusSinAfectar)
AntesExpresiones=Asigna(Info.ID, Oferta:Oferta.ID)
[Detalle.Margen]
Carpeta=Detalle
Clave=Margen
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Acciones.AsistenteVolumen]
Nombre=AsistenteVolumen
Boton=12
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F7
NombreDesplegar=&Asistente Volumen
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=OfertaDVol
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=(MovTipo(<T>OFER<T>, Oferta:Oferta.Mov) <> OFER.OG) y (Oferta:Oferta.TieneVolumen) y (Oferta:Oferta.Estatus=EstatusSinAfectar)
AntesExpresiones=Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Usar, Oferta:Oferta.Usar)<BR>Asigna(Info.Articulo,OfertaD:OfertaD.Articulo)
[Grupal.Oferta.Proveedor]
Carpeta=Grupal
Clave=Oferta.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Prov.Nombre]
Carpeta=Grupal
Clave=Prov.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Plata



[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)

[Vigencia.ListaEnCaptura]
(Inicio)=Oferta.FechaD
Oferta.FechaD=Oferta.FechaA
Oferta.FechaA=Oferta.HoraD
Oferta.HoraD=Oferta.HoraA
Oferta.HoraA=Oferta.DiasEsp
Oferta.DiasEsp=(Fin)


[Detalle.OfertaD.SubCuenta]
Carpeta=Detalle
Clave=OfertaD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=$00808040



[Acciones.Filtro.Filtro]
Nombre=Filtro
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si (Oferta:Oferta.Estatus=EstatusSinAfectar)<BR>  Entonces<BR>    Forma(<T>OfertaFiltro<T>)<BR>  Sino<BR>    Si (Oferta:Oferta.Estatus=EstatusConcluido) o (Oferta:Oferta.Estatus=EstatusVigente)<BR>      Entonces<BR>        Forma(<T>OfertaFiltroInfo<T>)<BR>    Fin<BR>Fin




[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S
[Lista.Columnas]
Articulo=131
Descripcion1=244
Unidad=151
[Detalle.OfertaD.Moneda]
Carpeta=Detalle
Clave=OfertaD.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco











































[Ficha.Oferta.Porcentaje]
Carpeta=Ficha
Clave=Oferta.Porcentaje
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=10




[Ficha.Oferta.Obsequio]
Carpeta=Ficha
Clave=Oferta.Obsequio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Oferta.CantidadObsequio]
Carpeta=Ficha
Clave=Oferta.CantidadObsequio
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






Tamano=10
[Acciones.CascadaGrupo]
Nombre=CascadaGrupo
Boton=47
NombreEnBoton=S
NombreDesplegar=&Cascada
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OfertaCascadaGrupo
Antes=S
Visible=S


Menu=&Edición
ActivoCondicion=Oferta:Oferta.GrupoTipo = <T>Cascada<T>
AntesExpresiones=GuardarCambios<BR>Asigna(Info.ID, Oferta:Oferta.ID)<BR>Asigna(Info.Estatus,Oferta:Oferta.Estatus)
[Grupal.Oferta.GrupoTipo]
Carpeta=Grupal
Clave=Oferta.GrupoTipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Ficha.Oferta.Prioridad]
Carpeta=Ficha
Clave=Oferta.Prioridad
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Pegado=S


[Detalle.OfertaD.Unidad]
Carpeta=Detalle
Clave=OfertaD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.OfertaD.UnidadObsequio]
Carpeta=Detalle
Clave=OfertaD.UnidadObsequio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
















[Grupal.Oferta.PrioridadG]
Carpeta=Grupal
Clave=Oferta.PrioridadG
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.CategoriaD]
Carpeta=Grupal
Clave=Oferta.CategoriaD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S
[Grupal.Oferta.GrupoD]
Carpeta=Grupal
Clave=Oferta.GrupoD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.FamiliaD]
Carpeta=Grupal
Clave=Oferta.FamiliaD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.LineaD]
Carpeta=Grupal
Clave=Oferta.LineaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.FabricanteD]
Carpeta=Grupal
Clave=Oferta.FabricanteD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grupal.Oferta.ProveedorD]
Carpeta=Grupal
Clave=Oferta.ProveedorD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[Grupal.Oferta.ABC]
Carpeta=Grupal
Clave=Oferta.ABC
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















[Detalle.OfertaD.Factor]
Carpeta=Detalle
Clave=OfertaD.Factor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco














[Ficha.Oferta.ListaPreciosEsp]
Carpeta=Ficha
Clave=Oferta.ListaPreciosEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco





Pegado=S




[(Carpeta Abrir).Oferta.Prioridad]
Carpeta=(Carpeta Abrir)
Clave=Oferta.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Oferta.Tipo
Oferta.Tipo=Oferta.FechaD
Oferta.FechaD=Oferta.FechaA
Oferta.FechaA=Oferta.Prioridad
Oferta.Prioridad=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=BORRADOR
BORRADOR=PENDIENTE
PENDIENTE=VIGENTE
VIGENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)

[(Carpeta Abrir).Oferta.Tipo]
Carpeta=(Carpeta Abrir)
Clave=Oferta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco










































[Grupal.Oferta.Unidad]
Carpeta=Grupal
Clave=Oferta.Unidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













LineaNueva=S



[Grupal.ListaEnCaptura]
(Inicio)=Oferta.Categoria
Oferta.Categoria=Oferta.Grupo
Oferta.Grupo=Oferta.Familia
Oferta.Familia=Oferta.Linea
Oferta.Linea=Oferta.Fabricante
Oferta.Fabricante=Oferta.ABC
Oferta.ABC=Oferta.Proveedor
Oferta.Proveedor=Prov.Nombre
Prov.Nombre=Oferta.Unidad
Oferta.Unidad=Oferta.Porcentaje
Oferta.Porcentaje=Oferta.GrupoTipo
Oferta.GrupoTipo=Oferta.PrioridadG
Oferta.PrioridadG=Oferta.CategoriaD
Oferta.CategoriaD=Oferta.GrupoD
Oferta.GrupoD=Oferta.FamiliaD
Oferta.FamiliaD=Oferta.LineaD
Oferta.LineaD=Oferta.FabricanteD
Oferta.FabricanteD=Oferta.ProveedorD
Oferta.ProveedorD=(Fin)





























































[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Información Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Antes=S
Visible=S













Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(OfertaD:OfertaD.Articulo)
AntesExpresiones=Asigna(Info.Origen,<T>VTAS<T>)<BR>Asigna(Info.Articulo,OfertaD:OfertaD.Articulo)













[Ficha.Oferta.UnidadObsequio]
Carpeta=Ficha
Clave=Oferta.UnidadObsequio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Oferta.SubCuentaObsequio]
Carpeta=Ficha
Clave=Oferta.SubCuentaObsequio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco








[Ficha.ListaEnCaptura]
(Inicio)=Oferta.Mov
Oferta.Mov=Oferta.MovID
Oferta.MovID=Oferta.Proyecto
Oferta.Proyecto=Oferta.UEN
Oferta.UEN=Oferta.Moneda
Oferta.Moneda=Oferta.TipoCambio
Oferta.TipoCambio=Oferta.FechaEmision
Oferta.FechaEmision=Oferta.Referencia
Oferta.Referencia=Oferta.Concepto
Oferta.Concepto=Oferta.Prioridad
Oferta.Prioridad=Oferta.Observaciones
Oferta.Observaciones=Oferta.Tipo
Oferta.Tipo=Oferta.Forma
Oferta.Forma=Oferta.Usar
Oferta.Usar=Oferta.TieneVolumen
Oferta.TieneVolumen=Oferta.MontoMinimo
Oferta.MontoMinimo=Oferta.TodasSucursales
Oferta.TodasSucursales=Oferta.Porcentaje
Oferta.Porcentaje=Oferta.ListaPreciosEsp
Oferta.ListaPreciosEsp=Oferta.Obsequio
Oferta.Obsequio=Oferta.SubCuentaObsequio
Oferta.SubCuentaObsequio=Oferta.UnidadObsequio
Oferta.UnidadObsequio=Oferta.CantidadObsequio
Oferta.CantidadObsequio=(Fin)











































[Detalle.ListaEnCaptura]
(Inicio)=OfertaD.Articulo
OfertaD.Articulo=OfertaD.SubCuenta
OfertaD.SubCuenta=OfertaD.Cantidad
OfertaD.Cantidad=OfertaD.Unidad
OfertaD.Unidad=OfertaD.Obsequio
OfertaD.Obsequio=OfertaD.SubCuentaObsequio
OfertaD.SubCuentaObsequio=OfertaD.UnidadObsequio
OfertaD.UnidadObsequio=OfertaD.Importe
OfertaD.Importe=OfertaD.Moneda
OfertaD.Moneda=OfertaD.Porcentaje
OfertaD.Porcentaje=OfertaD.Precio
OfertaD.Precio=OfertaD.Factor
OfertaD.Factor=Margen
Margen=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=OfertaD.CostoBase
OfertaD.CostoBase=Art.PrecioLista
Art.PrecioLista=MargenPrecioLista
MargenPrecioLista=Obsequio.Descripcion1
Obsequio.Descripcion1=(Fin)

[Detalle.OfertaD.SubCuentaObsequio]
Carpeta=Detalle
Clave=OfertaD.SubCuentaObsequio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




























[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Grupal
Grupal=Vigencia
Vigencia=Detalle
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
Cancelar=CamposExtras
CamposExtras=Asignar
Asignar=AsistenteVolumen
AsistenteVolumen=CascadaGrupo
CascadaGrupo=Sucursales
Sucursales=Filtro
Filtro=Tareas
Tareas=Anexos
Anexos=AgregarEvento
AgregarEvento=Anterior
Anterior=Siguiente
Siguiente=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=Bitacora
Bitacora=ArtInfo
ArtInfo=MovPos
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
&Ver=(Fin)
