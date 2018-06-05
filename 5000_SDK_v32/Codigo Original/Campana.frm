[Forma]
Clave=Campana
Nombre=<T>Campañas<T>
Icono=0
Modulos=CMP
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=297
PosicionInicialArriba=81
PosicionInicialAltura=558
PosicionInicialAncho=772
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
PosicionSeccion1=29
PosicionSeccion2=92
BarraAyuda=S
MovModulo=CMP
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
TituloAutoNombre=S
PosicionInicialAlturaCliente=506
PosicionSec1=177
PosicionCol2=591
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Proveedor, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
PosicionSec2=309

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Campana
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
PestanaNombre=Datos Generales
FichaEspacioNombresAuto=S
Pestana=S
PestanaOtroNombre=S

[Ficha.Campana.Mov]
Carpeta=Ficha
Clave=Campana.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Campana.MovID]
Carpeta=Ficha
Clave=Campana.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Campana.FechaEmision]
Carpeta=Ficha
Clave=Campana.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Campana.Proyecto]
Carpeta=Ficha
Clave=Campana.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
EditarConBloqueo=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=CampanaA
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
ListaOrden=Campana.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Campana.FechaEmision
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
FiltroFechasNormal=S
FiltroFechasCancelacion=Campana.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S
IconosCambiarOrden=S
FiltroEstatus=S
FiltroSituacion=S

BusquedaSelCampo=S
IconosConPaginas=S
IconosNombre=CampanaA:Campana.Mov+<T> <T>+CampanaA:Campana.MovID
[(Carpeta Abrir).Columnas]
0=135
1=88

2=-2
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Campana:Campana.ID) y (Campana:Campana.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Campana:Campana.ID, <T>CMP<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero

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

Expresion=Asigna(Afectar.Modulo, <T>CMP<T>)<BR>Asigna(Afectar.ID, Campana:Campana.ID)<BR>Asigna(Afectar.Mov, Campana:Campana.Mov)<BR>Asigna(Afectar.MovID, Campana:Campana.MovID)<BR>Asigna(Afectar.Base, <T>Todo<T>)<BR>Asigna(Afectar.GenerarMov, <T><T>)<BR>Asigna(Afectar.FormaCaptura, <T>Campana<T>)<BR>Asigna(Info.MovTipo, MovTipo(<T>CMP<T>, Campana:Campana.Mov))<BR>Asigna(Info.TituloDialogo, Campana:Campana.Mov+<T> <T>+Campana:Campana.MovID)<BR>Si<BR> Campana:Campana.Estatus = EstatusPendiente<BR>Entonces<BR>  Si<BR>    Confirmacion(<T>Esta seguro que desea cerrar la Campaña ?<T>, BotonSi, BotonNo) = BotonSi<BR>  Entonces<BR>    Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>  Fin<BR>Sino<BR>  Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Campana:Campana.Usuario) y<BR>(Campana:Campana.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente))  y<BR>fnPuedeAvanzarEstatus(Empresa, <T>CMP<T>, Campana:Campana.Mov, Campana:Campana.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Campana:Campana.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Campana:Campana.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>CMP<T>, Campana:Campana.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>CMP<T>, Campana:Campana.Mov, Campana:Campana.ID, Verdadero, Campana:Campana.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Campana:Campana.MovID) y (Campana:Campana.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Campana:Campana.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Campana WHERE ID=:nID<T>, Campana:Campana.ID))
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
ListaParametros1=Campana:Campana.ID
Visible=S
Activo=
Expresion=ReportePantalla(ReporteMovPantalla(<T>CMP<T>, Campana:Campana.Mov, Campana:Campana.Estatus), Campana:Campana.ID)
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
ListaParametros1=Campana:Campana.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>CMP<T>, Campana:Campana.Mov, Campana:Campana.Estatus), Campana:Campana.ID)
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
Expresion=Cancelar(<T>CMP<T>, Campana:Campana.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Campana<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Campana:Campana.Usuario) y ConDatos(Campana:Campana.ID) y ConDatos(Campana:Campana.MovID) y<BR>((Campana:Campana.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusSincro, EstatusPendiente)) o<BR>(Campana:Campana.Estatus en (EstatusConcluido, EstatusPorConfirmar)))
AntesExpresiones=Asigna(Afectar.Mov, Campana:Campana.Mov) <BR>Asigna(Afectar.MovID, Campana:Campana.MovID)

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
Expresion=Verificar(<T>CMP<T>, Campana:Campana.ID,Campana:Campana.Mov,Campana:Campana.MovID)
ActivoCondicion=Campana:Campana.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Campana:Campana.Mov)

[Aplica.Campana.MovAplica]
Carpeta=Aplica
Clave=Campana.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Aplica.Campana.MovAplicaID]
Carpeta=Aplica
Clave=Campana.MovAplicaID
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
ActivoCondicion=ConDatos(Campana:Campana.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)
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
EspacioPrevio=S

GuardarAntes=S
DespuesGuardar=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>CMP<T>, Campana:Campana.Mov, Campana:Campana.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>CMP<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>CMP<T>, Campana:Campana.Mov, Campana:Campana.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Campana:Campana.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.Estatus, Campana:Campana.Estatus)<BR>Asigna(Info.Situacion, Campana:Campana.Situacion)
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
ActivoCondicion=ConfigModulo(<T>CMP<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Campana:Campana.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)

[(Carpeta Abrir).Campana.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Campana.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=10

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
AntesExpresiones=Asigna(Info.Rama, <T>CMP<T>)<BR>Asigna(Info.Fecha, Campana:Campana.FechaEmision)<BR>Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Campana:Campana.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Campana:Campana.Mov+<T> <T>+Campana:Campana.MovID)
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
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=Si(Vacio(Campana:Campana.ID),  GuardarCambios)<BR>Verdadero
AntesExpresiones=Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)<BR>Asigna(Info.PuedeEditar, Campana:Campana.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Campana:Campana.Usuario))

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
ActivoCondicion=ConDatos(Campana:Campana.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.ID, Campana:Campana.ID)

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
Expresion=CopiarMovimiento(<T>CMP<T>, Campana:Campana.ID, <T>Campana<T>)
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Campana:Campana.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Campana:Campana.ID),GuardarCambios)
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
Aplica=92
AplicaID=64
FechaEmision=128
Reporte=136
Tipo=96
Asunto=232
Socio=83
Titulo=86
Cantidad=50
Precio=101
Costo=103
PrecioTotal=104
CostoTotal=93
Tarima=97
Articulo=106
Unidad=45
Factor=49
Posicion=74
Contenedor=61
CantidadRecogida=94
CantidadEntregada=100
SubCuenta=108
CantidadPendiente=98
AplicaRID=64
PosicionDestino=86
CantidadA=64
Contacto=52
ContactoTipo=75
Nombre=183
Medio=44
Direccion=94
Agente=51
Observaciones=145
Estado=88
Calificacion=58
Organizacion=108
MedioRef=67
Puesto=87
Telefonos=77
eMail=79
Recurso=76
0=142
1=82
ContactoNombre=183
Fecha=72
ContactoSubTipo=67
Usuario=61
Situacion=130
SituacionFecha=78

2=-2
3=-2
4=-2
5=-2
6=-2
[Ficha.Campana.UEN]
Carpeta=Ficha
Clave=Campana.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

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
Expresion=Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.Clave, <T>CMP<T>+Campana:Campana.ID)<BR>Asigna(Info.Nombre, Campana:Campana.Mov+<T> <T>+Campana:Campana.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Campana:Campana.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)<BR>Asigna(Info.Fecha, Campana:Campana.FechaEmision)<BR>Asigna(Info.Estatus, Campana:Campana.Estatus)

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
EjecucionCondicion=ConDatos(Campana:Campana.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>CMP<T>)<BR>Asigna(Info.Clave, Campana:Campana.Mov)

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
EjecucionCondicion=ConDatos(Campana:Campana.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.Concepto, Campana:Campana.Concepto)

[Detalle]
Estilo=Iconos
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CampanaD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Campana
LlaveLocal=CampanaD.ID
LlaveMaestra=Campana.ID
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=ContactoNombre<TAB>(Acendente)
PestanaNombre=Contactos
PestanaOtroNombre=S
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=CampanaD.SituacionFecha
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroUsuarios=S
FiltroUsuarioDefault=(Todos)
IconosCampo=Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CampanaD:ContactoNombre

[Ficha.Campana.Concepto]
Carpeta=Ficha
Clave=Campana.Concepto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Campana.Referencia]
Carpeta=Ficha
Clave=Campana.Referencia
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Campana.Observaciones]
Carpeta=Ficha
Clave=Campana.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=64
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=Asigna(Info.Forma, <T>Campana<T>)<BR>Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.Nombre, Campana:Campana.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>CMP<T>, Campana:Campana.Mov, Campana:Campana.ID, Falso, Campana:Campana.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>CMP<T>+Campana:Campana.ID)<BR>  Asigna(Info.Nombre, Campana:Campana.Mov+<T> <T>+Campana:Campana.MovID)<BR>  Asigna(Info.Modulo, <T>CMP<T>)<BR>  Asigna(Info.Mov, Campana:Campana.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Campana:Campana.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)

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
ActivoCondicion=Usuario.EnviarExcel y (Campana:Campana.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[(Carpeta Abrir).Campana.Asunto]
Carpeta=(Carpeta Abrir)
Clave=Campana.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Ficha.Campana.Asunto]
Carpeta=Ficha
Clave=Campana.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=64
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AgregarContactos]
Nombre=AgregarContactos
Boton=62
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=Agregar &Contactos
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
NombreEnBoton=S
EspacioPrevio=S
ConCondicion=S

EjecucionConError=S
Expresion=Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Clave,MovTipo(<T>CMP<T>, Campana:Campana.Mov))<BR>Asigna(Info.Agente,Campana:Campana.Agente)<BR><BR>Si Info.Agente<> <T><T> Entonces<BR>  Asigna(Temp.Reg, SQL(<T>SELECT ParaProspectos, ParaClientes, ParaProveedores, ParaPersonal, ParaAgentes FROM CampanaTipo WHERE CampanaTipo=:tCampanaTipo<T>, Campana:Campana.CampanaTipo))<BR>  Dialogo(<T>CampanaAgregarContactos<T>)<BR>SINO<BR>   Error(<T>Es necesario seleccionar Agente<T>,BotonAceptar) <BR>FIN
ActivoCondicion=Campana:Campana.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)
EjecucionCondicion=ConDatos(Campana:Campana.Agente)
EjecucionMensaje=<T>Es necesario seleccionar Agente<T>
[Contacto.Campana.Contacto]
Carpeta=Contacto
Clave=Campana.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Contacto.Contacto.NombreCompleto]
Carpeta=Contacto
Clave=Contacto.NombreCompleto
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Campana.Cliente]
Carpeta=Contacto
Clave=Campana.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.Cte.Nombre]
Carpeta=Contacto
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Campana.Proveedor]
Carpeta=Contacto
Clave=Campana.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.Prov.Nombre]
Carpeta=Contacto
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Campana.Personal]
Carpeta=Contacto
Clave=Campana.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.PersonalNombreCompleto]
Carpeta=Contacto
Clave=PersonalNombreCompleto
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Campana.Mov]
Carpeta=Contacto
Clave=Campana.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Campana.MovID]
Carpeta=Contacto
Clave=Campana.MovID
Editar=N
3D=S
Pegado=N
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Contacto.Campana.Proceso]
Carpeta=Contacto
Clave=Campana.Proceso
Editar=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Tareas.Tarea.Estado]
Carpeta=Tareas
Clave=Tarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Tareas.Tarea.Vencimiento]
Carpeta=Tareas
Clave=Tarea.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Tareas.Tarea.Prioridad]
Carpeta=Tareas
Clave=Tarea.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Tareas.Columnas]
Asunto=474
Estado=93
Vencimiento=105
Prioridad=50
0=387
1=36

[Acciones.TareasImprimir]
Nombre=TareasImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.TareasSeleccionar]
Nombre=TareasSeleccionar
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.TareasQuitar]
Nombre=TareasQuitar
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.TareasPreliminar]
Nombre=TareasPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.TareasExcel]
Nombre=TareasExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.TareasPersonalizar]
Nombre=TareasPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Tareas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.TareasAbrir]
Nombre=TareasAbrir
Boton=0
NombreDesplegar=&Abrir
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
RefrescarDespues=S
Expresion=Asigna(Info.TareaID, Tarea:Tarea.ID)<BR>Asigna(Info.PuedeEditar, Campana:Campana.Estatus=EstatusPendiente)<BR>Forma(<T>TareaEditar<T>)
ConCondicion=S
EjecucionCondicion=ConDatos(Tarea:Tarea.ID)

[Tareas.Tarea.Tipo]
Carpeta=Tareas
Clave=Tarea.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TareasCompletar]
Nombre=TareasCompletar
Boton=0
NombreDesplegar=Completar Selección
EnMenu=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Expresion=RegistrarSeleccionID(<T>Tareas<T>)<BR>EjecutarSQL(<T>spTareasCompletarSeleccion :nEstacion<T>, EstacionTrabajo) <BR>Forma.ActualizarVista
Activo=S
Visible=S

[Tareas.Tarea.Fase]
Carpeta=Tareas
Clave=Tarea.Fase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Tareas.Tarea.Orden]
Carpeta=Tareas
Clave=Tarea.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.CampanaD.Nombre]
Carpeta=Contacto
Clave=CampanaD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.CampanaD.Puesto]
Carpeta=Contacto
Clave=CampanaD.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.CampanaD.Organizacion]
Carpeta=Contacto
Clave=CampanaD.Organizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.CampanaD.Telefonos]
Carpeta=Contacto
Clave=CampanaD.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Contacto.CampanaD.eMail]
Carpeta=Contacto
Clave=CampanaD.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Observaciones.CampanaD.Observaciones]
Carpeta=Observaciones
Clave=CampanaD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10x10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>CMP<T>, <T>{Campana:Campana.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>CMP{Campana:Campana.ID}<T>
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
VerCampo=360
VerValor=360

[Ficha.Campana.CampanaTipo]
Carpeta=Ficha
Clave=Campana.CampanaTipo
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
ValidaNombre=S

[Detalle.CampanaD.Calificacion]
Carpeta=Detalle
Clave=CampanaD.Calificacion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Campana.Agente]
Carpeta=Ficha
Clave=Campana.Agente
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
Editar=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[DetalleFicha.CampanaD.Observaciones]
Carpeta=DetalleFicha
Clave=CampanaD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20x10
ColorFondo=Blanco
ColorFuente=Negro

[DetalleFicha.Columnas]
Observaciones=604

[Detalle.ContactoSubTipo]
Carpeta=Detalle
Clave=ContactoSubTipo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.CampanaDEvento.FechaHora]
Carpeta=Lista
Clave=CampanaDEvento.FechaHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaDEvento.Tipo]
Carpeta=Lista
Clave=CampanaDEvento.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaDEvento.Estado]
Carpeta=Lista
Clave=CampanaDEvento.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaDEvento.Fecha]
Carpeta=Lista
Clave=CampanaDEvento.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaDEvento.Observaciones]
Carpeta=Lista
Clave=CampanaDEvento.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
FechaHora=94
Tipo=124
Estado=184
Fecha=94
Observaciones=604

[Detalle.CampanaD.Observaciones]
Carpeta=Detalle
Clave=CampanaD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Acciones.Correo]
Nombre=Correo
Boton=84
Menu=&Edición
NombreDesplegar=Env&iar Correos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CampanaCorreo
Visible=S
GuardarAntes=S
Antes=S
EspacioPrevio=S
ActivoCondicion=Campana:Campana.Estatus=EstatusPendiente
AntesExpresiones=Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)<BR>Asigna(Info.Tipo, Campana:Campana.CampanaTipo)
DespuesGuardar=S

[Detalle.CampanaD.Contacto]
Carpeta=Detalle
Clave=CampanaD.Contacto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Detalle.CampanaD.Situacion]
Carpeta=Detalle
Clave=CampanaD.Situacion
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CampanaD.SituacionFecha]
Carpeta=Detalle
Clave=CampanaD.SituacionFecha
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AsignarUsuarios]
Nombre=AsignarUsuarios
Boton=80
Menu=&Edición
NombreDesplegar=Asignar/Reasignar &Usuarios
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CampanaUsuarioAsignar
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)

[Acciones.DetallePersonalizar]
Nombre=DetallePersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.DetalleEliminar]
Nombre=DetalleEliminar
Boton=0
NombreDesplegar=&Eliminar Contacto
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
RefrescarDespues=S
GuardarAntes=S
Expresion=EjecutarSQL(<T>spCampanaEliminarContacto :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID)
ActivoCondicion=Campana:Campana.Estatus en (EstatusSinAfectar, EstatusPendiente)

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CampanaD
Visible=S
Antes=S
RefrescarDespues=S
ActivoCondicion=Campana:Campana.Estatus en (EstatusPendiente, EstatusConcluido, EstatusCancelado)
AntesExpresiones=Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)<BR>Asigna(Info.Estatus, Campana:Campana.Estatus)<BR>Asigna(Info.Tipo, Campana:Campana.CampanaTipo)

[Acciones.Tarea]
Nombre=Tarea
Boton=70
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tareas
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.PuedeEditar, Campana:Campana.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Campana:Campana.Proyecto)<BR>Asigna(Info.UEN, Campana:Campana.UEN)<BR>Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Reporte, Nulo)
DespuesGuardar=S
Visible=S

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
ActivoCondicion=Campana:Campana.Estatus noen (EstatusConcluido, EstatusCancelado) y PuedeModificar(Campana:Campana.Usuario)
ConCondicion=S
EjecucionCondicion=Si(Vacio(Campana:Campana.ID),  GuardarCambios)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CMP<T>)<BR>Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)
Visible=S

[Ficha.Campana.TieneVigencia]
Carpeta=Ficha
Clave=Campana.TieneVigencia
Editar=S
LineaNueva=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.Campana.FechaD]
Carpeta=Ficha
Clave=Campana.FechaD
Editar=S
3D=S
Pegado=N
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N

[Ficha.Campana.FechaA]
Carpeta=Ficha
Clave=Campana.FechaA
Editar=S
3D=S
Pegado=N
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N

[Acciones.CfgCorreo]
Nombre=CfgCorreo
Boton=45
Menu=&Configuración
NombreDesplegar=&Correos Automáticos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CampanaCfgCorreo
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=Campana:Campana.Estatus en (EstatusSinAfectar, EstatusPendiente)
AntesExpresiones=Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)<BR>Asigna(Info.Tipo, Campana:Campana.CampanaTipo)

[Acciones.CfgSituacion]
Nombre=CfgSituacion
Boton=0
Menu=&Configuración
NombreDesplegar=&Acciones Automáticas
EnMenu=S
TipoAccion=Formas
ClaveAccion=CampanaCfgSituacion
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
ActivoCondicion=Campana:Campana.Estatus en (EstatusSinAfectar, EstatusPendiente)
AntesExpresiones=Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)<BR>Asigna(Info.Tipo, Campana:Campana.CampanaTipo)

[Acciones.ExplorarEncuesta]
Nombre=ExplorarEncuesta
Boton=0
Menu=&Ver
NombreDesplegar=E&xplorar Encuestas
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarCampanaDEncuesta
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Campana:Campana.ID)
AntesExpresiones=Asigna(Info.ID, Campana:Campana.ID)<BR>Asigna(Info.Mov, Campana:Campana.Mov)<BR>Asigna(Info.MovID, Campana:Campana.MovID)<BR>Asigna(Info.Tipo, Campana:Campana.CampanaTipo)

[Acciones.DetalleEvento]
Nombre=DetalleEvento
Boton=0
NombreDesplegar=Agregar E&vento
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.Tipo, Campana:Campana.CampanaTipo)<BR>Asigna(Info.RID, CampanaD:CampanaD.RID)<BR>Asigna(Info.PuedeEditar, Info.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Clave, CampanaD:CampanaD.Contacto)<BR>Asigna(Info.Nombre, CampanaD:ContactoNombre)<BR>Si<BR>  Forma(<T>CampanaEvento<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spCampanaDEventoAceptar :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID)<BR>  Forma.ActualizarVista(<T>Lista<T>)<BR>Fin
ActivoCondicion=Campana:Campana.Estatus noen (EstatusConcluido, EstatusCancelado)
EjecucionCondicion=ConDatos(CampanaD:CampanaD.Contacto)




[Ficha.ListaEnCaptura]
(Inicio)=Campana.Mov
Campana.Mov=Campana.MovID
Campana.MovID=Campana.Proyecto
Campana.Proyecto=Campana.UEN
Campana.UEN=Campana.FechaEmision
Campana.FechaEmision=Campana.Concepto
Campana.Concepto=Campana.Referencia
Campana.Referencia=Campana.CampanaTipo
Campana.CampanaTipo=Campana.Agente
Campana.Agente=Agente.Nombre
Agente.Nombre=Campana.Asunto
Campana.Asunto=Campana.TieneVigencia
Campana.TieneVigencia=Campana.Observaciones
Campana.Observaciones=Campana.FechaD
Campana.FechaD=Campana.FechaA
Campana.FechaA=(Fin)




[Detalle.ListaEnCaptura]
(Inicio)=ContactoSubTipo
ContactoSubTipo=CampanaD.Contacto
CampanaD.Contacto=CampanaD.Situacion
CampanaD.Situacion=CampanaD.SituacionFecha
CampanaD.SituacionFecha=CampanaD.Observaciones
CampanaD.Observaciones=CampanaD.Calificacion
CampanaD.Calificacion=(Fin)

[Detalle.ListaAcciones]
(Inicio)=DetallePersonalizar
DetallePersonalizar=DetalleEliminar
DetalleEliminar=DetalleEvento
DetalleEvento=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)






















[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S
































































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Campana.FechaEmision
Campana.FechaEmision=Campana.Asunto
Campana.Asunto=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)



















[Acciones.Agenda]
Nombre=Agenda
Boton=53
NombreEnBoton=S
Menu=&Edición
TeclaFuncion=F11
NombreDesplegar=&Agenda
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>EXECUTE spPreparaCampanaAM :nEstacion,:nID<T>,EstacionTrabajo,Campana:Campana.ID)<BR>PlugIn(<T>Agenda<T>)
ActivoCondicion=PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Campana:Campana.Usuario)   y (MovTipo(<T>CMP<T>, Campana:Campana.Mov) = <T>CMP.A<T>)  
ConCondicion=S
EjecucionCondicion=(ConDatos(Campana:Campana.Mov)) y (SQL(<T>SELECT TOP 1 ID FROM CampanaD WHERE ID = :nID<T>,Campana:Campana.ID)=Campana:Campana.ID)
EjecucionMensaje=<T>Falta Agregar Contactos<T>
EjecucionConError=S
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
FormasAnexas=Verificar
Verificar=Excel
Excel=Situacion
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
Sucursal=Afectar
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=CamposExtras
CamposExtras=AgregarContactos
AgregarContactos=AsignarUsuarios
AsignarUsuarios=Correo
Correo=CfgCorreo
CfgCorreo=CfgSituacion
CfgSituacion=Detalle
Detalle=Agenda
Agenda=Tarea
Tarea=Anexos
Anexos=AgregarEvento
AgregarEvento=Anterior
Anterior=Siguiente
Siguiente=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=Bitacora
Bitacora=ExplorarEncuesta
ExplorarEncuesta=MovPos
MovPos=Actualizar
Actualizar=Navegador
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
&Otros=&Configuración
&Configuración=(Fin)
