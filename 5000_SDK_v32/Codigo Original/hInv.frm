[Forma]
Clave=hInv
Nombre=<T>Histórico <T> + Info.ModuloInventariosNombre
Icono=0
Modulos=INV
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=570
PosicionInicialArriba=309
PosicionInicialAltura=526
PosicionInicialAncho=779
PosicionSeccion1=42
Totalizadores=S
PosicionSeccion2=92
Menus=S
BarraHerramientas=S
BarraAyuda=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DialogoAbrir=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsMovimiento=S
Movimientos=Devolucion Interna<BR>Entrada Diversa<BR>Salida Interna<BR>Salida Diversa<BR>Transferencia<BR>Prestamo<BR>Ajuste<BR>Ajuste Fisico
TituloAuto=S
PosicionColumna3=50
BarraAyudaBold=S
MovTipo=Todos
MovModulo=INV
VentanaBloquearAjuste=N
AutoGuardarEncabezado=S
PosicionInicialAlturaCliente=547
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Espacio, Nulo)<BR>Asigna(Info.Articulo, Nulo)
TituloAutoNombre=S
PosicionSec1=218
PosicionSec2=445
EsConsultaExclusiva=S
MenuPrincipal=(Lista)

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=hInvA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
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
PestanaOtroNombre=S
PestanaNombre=movimientos
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroUsuarios=S
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=hInv.FechaEmision
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechas=S
FiltroFechasDefault=(Todo)
BusquedaAvanzada=
BusquedaRespetarControlesNum=S
BusquedaRespetarFiltros=S
Filtros=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDef=Devolucion Interna
FiltroMovDefault=(Todos)
IconosConPaginas=S
MenuLocal=S
ListaAcciones=(Lista)
IconosSeleccionUnitaria=S
FiltroFechasNormal=S
BusquedaRespetarUsuario=S
FiltroPredefinido=S
FiltroEstilo=Directorio
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Alm
FiltroAplicaEn=hInv.Almacen
FiltroAplicaO=hInv.AlmacenDestino
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todos)
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroGrupo1=(Validaciones Memoria)
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroFechasCancelacion=hInv.FechaCancelacion
FiltroSucursales=S
ListaOrden=hInv.ID<TAB>(Decendente)
IconosNombre=hInvA:hInv.Mov+<T> <T>+hInvA:hInv.MovID
FiltroGeneral={Si(SQL(<T>SELECT ISNULL(Filtrar, 0) FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSub<T>, <T>INV<T>, Info.SubModuloInv), <T>hInv.SubModulo=<T>+Comillas(Info.SubModuloInv), <T>1=1<T>)}

[(Carpeta Abrir).Columnas]
0=184
1=85

[(Carpeta Abrir).hInv.Almacen]
Carpeta=(Carpeta Abrir)
Clave=hInv.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).hInv.AlmacenDestino]
Carpeta=(Carpeta Abrir)
Clave=hInv.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).hInv.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=hInv.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

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
ConCondicion=S
EspacioPrevio=S
Antes=S
DespuesGuardar=S
Expresion=Asigna(Afectar.Modulo, <T>INV<T>)<BR>Asigna(Afectar.ID, hInv:hInv.ID)<BR>Asigna(Afectar.Mov, hInv:hInv.Mov)<BR>Asigna(Afectar.MovID, hInv:hInv.MovID)<BR>Asigna(Afectar.Base, <T>Todo<T>)<BR>Asigna(Afectar.GenerarMov, <T><T>)<BR>Asigna(Afectar.FormaCaptura, <T>Inv<T>)<BR>Asigna(Info.MovTipo, MovTipo(<T>INV<T>,hInv:hInv.Mov))<BR>Si(Info.MovTipo=INV.IF, Asigna(Afectar.GenerarMov, ConfigMov.InvAjuste))<BR>Si <BR>  hInv:hInv.Estatus en (EstatusPorConfirmar, EstatusBorrador, EstatusSinAfectar)<BR>Entonces<BR>  Si <BR>    (Info.MovTipo=INV.IF) y (Config.InvFisicoConteo=1)<BR>  Entonces <BR>    Dialogo(<T>AfectarInventarioFisico<T>)<BR>  Sino<BR>    Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura) <BR>  Fin<BR>Sino<BR>  Si <BR>    hInv:Inv.Estatus=EstatusPendiente <BR>  Entonces  <BR>    Asigna(Info.Modulo, <T>INV<T>)<BR>    Asigna(Info.Mov, hInv:hInv.Mov)<BR>    Asigna(Info.MovID, hInv:hInv.MovID)<BR>    Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>    Si<BR>      ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>    Entonces<BR>      Si <BR>        Forma(<T>GenerarMovFlujo<T>)<BR>      Entonces<BR>        Si<BR>          Dialogo(<T>GenerarInvBase<T>)<BR>        Entonces<BR>          Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>          Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>        Fin<BR>      Fin<BR>    Sino<BR>      Caso Info.MovTipo<BR>        Es INV.T   Entonces Dialogo(<T>AfectarTransferencia<T>)<BR>        Es INV.SOL Entonces Dialogo(<T>GenerarSolicitud<T>)<BR>        Es INV.OT  Entonces Dialogo(<T>GenerarOrdenTransferencia<T>)<BR>        Es INV.OI  Entonces Dialogo(<T>GenerarOrdenTraspaso<T>)<BR>        Es INV.TI  Entonces Dialogo(<T>GenerarTransito<T>)<BR>        Es INV.DTI Entonces Dialogo(<T>GenerarTransito<T>)<BR>        Es INV.SM  Entonces Dialogo(<T>GenerarSolicitudMaterial<T>)<BR>        Es INV.IF  Entonces Si(Config.InvFisicoConteo=hInv:hInv.Conteo, Dialogo(<T>AfectarInventarioFisico<T>), Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura))<BR>        Es INV.P   Entonces<BR>          Asigna(Info.TituloDialogo,<T>Recibir Prestamo<T>) <BR>          Asigna(Afectar.GenerarMov, ConfigMov.InvReciboPrestamo)<BR>          Dialogo(<T>GenerarPendiente<T>) <BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hInv:hInv.Usuario) y <BR>(hInv:hInv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente))  y<BR>PuedeAvanzarEstatus(<T>INV<T>, hInv:hInv.Mov, hInv:hInv.Estatus, FormaSituacion)
EjecucionCondicion=ConDatos(hInv:hInv.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>INV<T>, hInv:hInv.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>INV<T>, hInv:hInv.Mov, hInv:hInv.ID, Verdadero, hInv:hInv.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn

[Acciones.Asistente Articulos]
Nombre=Asistente Articulos
Boton=12
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F7
NombreDesplegar=Asistente &Artículos
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=hInvD:hInvD.Articulo<BR>hInvD:hInvD.Almacen<BR>hInvD:hInvD.SubCuenta<BR>hInvD:hInvD.Cantidad<BR>Nulo<BR>MovTipoEn(<T>INV<T>,hInv:hInv.Mov, (INV.E, INV.EP, INV.EI, INV.R))<BR>Nulo<BR>MovTipoEn(<T>INV<T>,hInv:hInv.Mov, (INV.S, INV.SI, INV.T, INV.P, INV.IF))<BR>Nulo<BR>hInvD:Art.Descripcion1<BR>hInvD:Art.Tipo<BR>hInvD:Art.Unidad<BR>Nulo<BR>hInvD:Art.TipoOpcion<BR>Falso<BR>Nulo<BR>Nulo<BR>Nulo<BR><T>INV<T><BR>hInv:hInv.ID<BR>hInv:hInv.Almacen
ListaParametros=S
Visible=S
ActivoCondicion=hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPendiente)

[Acciones.Asistente Codigo Barras (Lote)]
Nombre=Asistente Codigo Barras (Lote)
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F7
NombreDesplegar=Asistente Códigos de Barras (en Lote)
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Codigo Barras (Lote)
ListaParametros=S
ListaParametros1=hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>hInv:hInv.Estatus = EstatusPendiente<BR>hInvD:hInvD.Cantidad<BR>hInvD:hInvD.CantidadPendiente<BR>Nulo<BR>hInvD:hInvD.CantidadA<BR>hInvD:hInvD.SubCuenta<BR>hInvD:hInvD.Unidad<BR>hInvD:hInvD.Articulo<BR>Nulo<BR>Nulo<BR>hInv:hInv.Almacen<BR>Nulo<BR>Nulo<BR>Nulo<BR>hInv:hInv.ID<BR>Verdadero<BR>Config.CBProcesarLote<BR>Verdadero<BR>Si(Config.CBDirAlmacen, Si(MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.OI, INV.OT, INV.T, INV.TI, INV.DTI, INV.SI)), hInv:AlmDestino.CBDir, hInv:Alm.CBDir), <T><T>)
GuardarAntes=S
ActivoCondicion=hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar) o ((MovTipo(<T>INV<T>, hInv:hInv.Mov) = INV.IF) y (hInv:hInv.Estatus=EstatusPendiente))
VisibleCondicion=Config.CB

[Acciones.Asistente Codigos Barras]
Nombre=Asistente Codigos Barras
Boton=42
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Mayús+F7
NombreDesplegar=Asistente Códigos de &Barras
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Asistente Codigo Barras (1x1)
ListaParametros1=hInv:hInv.Estatus en (EstatusSinAfectar,EstatusPendiente)<BR>hInv:hInv.Estatus=EstatusPendiente<BR>hInvD:hInvD.Cantidad<BR>hInvD:hInvD.CantidadPendiente<BR>Nulo<BR>hInvD:hInvD.CantidadA<BR>hInvD:hInvD.SubCuenta<BR>hInvD:hInvD.Unidad<BR>hInvD:hInvD.Articulo<BR>Nulo<BR>Nulo<BR>hInv:hInv.Almacen<BR>Nulo<BR>Nulo<BR>hInv:AlmDestino.Idioma<BR>Config.CBPreguntarCantidad<BR>Falso
ListaParametros=S
Visible=S
ActivoCondicion=Config.CB y (hInv:hInv.Estatus en (EstatusSinAfectar,EstatusPendiente))

[Acciones.Cambiar Vista Hoja]
Nombre=Cambiar Vista Hoja
Boton=0
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle-Resumen)
Visible=S
Activo=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnMenu=S
TipoAccion=Expresion
Visible=S
EnBarraHerramientas=S
Antes=S
RefrescarDespues=S
GuardarAntes=S
Expresion=Si <BR>  (hInv:hInv.Estatus=EstatusPendiente) y (MovTipo(<T>INV<T>,hInv:hInv.Mov) en (INV.SOL, INV.OT, INV.OI, INV.SM))<BR>Entonces<BR>  Asigna(Info.TituloDialogo, <T>Cancelar: <T>+Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Dialogo(<T>CancelarPendiente<T>)<BR>Sino<BR>  Si<BR>    Precaucion(<T>¿ Esta seguro que desea cancelar el movimiento ?<T>+NuevaLinea+NuevaLinea+Afectar.Mov+<T> <T>+Afectar.MovID, BotonSi, BotonNo ) = BotonSi<BR>  Entonces<BR>    Cancelar(<T>INV<T>, hInv:hInv.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Inv<T>)<BR>  Fin<BR>Fin
ActivoCondicion=Si<BR>  PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, hInv:hInv.Usuario) y ConDatos(hInv:hInv.ID) y ConDatos(hInv:hInv.MovID)<BR>Entonces<BR>  Si<BR>    MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.P, INV.IF, INV.SOL, INV.OT, INV.OI, INV.TI, INV.SM))<BR>  Entonces<BR>    hInv:hInv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusSincro, EstatusPorConfirmar, EstatusPendiente)<BR>  Sino<BR>    hInv:hInv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusSincro, EstatusPorConfirmar, EstatusConcluido, EstatusPendiente)<BR>  Fin<BR>Sino<BR>  Falso<BR>Fin
AntesExpresiones=Asigna(Afectar.Modulo, <T>INV<T>)<BR>Asigna(Afectar.ID, hInv:hInv.ID)<BR>Asigna(Afectar.Mov, hInv:hInv.Mov ) <BR>Asigna(Afectar.MovID, hInv:hInv.MovID )

[Acciones.Catalogos]
Nombre=Catalogos
Boton=48
Menu=&Ver
NombreDesplegar=&Catálogos
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Wizards
ClaveAccion=Catalogos Articulos
ListaParametros=S
Visible=S
ListaParametros1=hInvD:hInvD.Articulo<BR>Si(MovTipo(<T>INV<T>, hInv:hInv.Mov)=INV.EI, hInv:hInv.AlmacenDestino, hInv:hInv.Almacen)<BR>hInvD:hInvD.Cantidad
ActivoCondicion=hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPendiente)

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

[Acciones.Copiar Pendiente]
Nombre=Copiar Pendiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Copiar Pendiente
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna( hInvD:hInvD.CantidadA,hInvD:hInvD.CantidadPendiente )
Visible=S
ActivoCondicion=hInv:hInv.Estatus = EstatusPendiente

[Acciones.Disponible]
Nombre=Disponible
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Disponible del Artículo
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=Asigna(Info.Origen, <T>INV<T>)<BR>Asigna(Info.Articulo, hInvD:hInvD.Articulo)<BR>Asigna(Info.Descripcion, hInvD:Art.Descripcion1)<BR>Asigna(Info.ArtTipo, hInvD:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, hInvD:Art.TipoOpcion)<BR>Asigna(Info.Almacen, Si(Config.InvMultiAlmacen y (MovTipo(<T>INV<T>, hInv:hInv.Mov) noen (INV.IF, INV.EI, INV.P, INV.R)), hInvD:hInvD.Almacen, Si(MovTipo(<T>INV<T>, hInv:hInv.Mov)=INV.EI, hInv:hInv.AlmacenDestino, hInv:hInv.Almacen)))<BR>Forma(<T>ArtAlmExistencia<T>)
EjecucionCondicion=ConDatos(hInvD:hInvD.Articulo)

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
ActivoCondicion=Vacio(hInv:hInv.MovID) y (hInv:hInv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, hInv:hInv.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Inv WHERE ID=:nID<T>, hInv:hInv.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

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
EjecucionCondicion=ConDatos(hInv:hInv.Almacen)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
NombreDesplegar=&Imprimir...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=hInv:hInv.ID
Visible=S
Activo=
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
EspacioPrevio=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>INV<T>, hInv:hInv.Mov, hInv:hInv.Estatus), hInv:hInv.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.Informacion]
Nombre=Informacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+I
NombreDesplegar=&Información del Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(hInvD:hInvD.Articulo)
AntesExpresiones=Asigna( Info.Articulo, hInvD:hInvD.Articulo )<BR>Asigna( Info.ArtTipo, hInvD:Art.Tipo )<BR>Asigna(Info.Origen, <T>INV<T>)

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
ListaParametros1=hInv:hInv.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>hINV<T>, hInv:hInv.Mov, hInv:hInv.Estatus), hInv:hInv.ID)
ActivoCondicion=Usuario.PreliminarMovs

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
Activo=
ActivoCondicion=hInv:hInv.Estatus=EstatusSinAfectar

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
Expresion=Asigna(Afectar.Modulo, <T>INV<T>)<BR>Asigna(Afectar.ID, hInv:hInv.ID)<BR>Asigna(Afectar.Mov, hInv:hInv.Mov)<BR>Asigna(Afectar.MovID, hInv:hInv.MovID)<BR>Asigna(Afectar.GenerarMov, Nulo)<BR>Si(MovTipo(<T>INV<T>,hInv:hInv.Mov)=INV.IF, Asigna(Afectar.GenerarMov, ConfigMov.InvAjuste))<BR>Verificar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov)
ActivoCondicion=hInv:hInv.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(hInv:hInv.Mov)

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
Totalizadores1=Total<BR>Conteo
Totalizadores2=Si(Usuario.Costos y ((MovTipoEn(<T>INV<T>,hInv:hInv.Mov,(INV.E,INV.EP,INV.EI,INV.A,INV.TIS)) o (hInv:hInv.Estatus=EstatusConcluido)) y (no MovTipoEn(<T>INV<T>,hInv:hInv.Mov,(INV.T, INV.TG, INV.P, INV.R, INV.IF))) y (hInv:Alm.Tipo<><T>Garantias<T>)), Suma(hInvD:Importe), Nulo)<BR>Conteo(hInvD:hInvD.Articulo)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=MovTipo(<T>INV<T>, hInv:hInv.Mov) noen (INV.SOL, INV.OT, INV.OI, INV.TI, INV.DTI, INV.SM)

[Detalle]
Estilo=Hoja
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=hInvD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Rojo obscuro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Detalle=S
VistaMaestra=hInv
LlaveLocal=hInvD.ID
LlaveMaestra=hInv.ID
ControlRenglon=S
CampoRenglon=hInvD.Renglon
ValidarCampos=S
ListaCamposAValidar=(Lista)
HojaSubCta=Si
HojaSubNS=Si
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=(Lista)
ControlRenglonID=S
ControlRenglonTipo=S
HojaColoresPorTipo=S
CampoDespliegaTipo=Art.Tipo
ConResumen=S
ResumenVista=InvR
ResumenLlave=ID
ResumenCampos=Articulo<BR>Descripcion1<BR>Cantidad<BR>Pendiente<BR>Costo<BR>Importe<BR>Almacen
VistaOmision=Resumén
ResumenVistaMaestra=hInv
ResumenLlaveMaestra=hInv.ID
HojaVistaOmision=Automática
HojaFondoGrisAuto=S
PermiteLocalizar=S
HojaAjustarColumnas=S
CampoDespliegaTipoOpcion=Art.TipoOpcion
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral={Si((Info.MovTipo=INV.IF) y (Config.InvFisicoConteo=3), <T>(hInv.Estatus=<T>+Comillas(EstatusConcluido)+<T> OR hInvD.SegundoConteo IS NULL OR hInvD.Cantidad<>hInvD.SegundoConteo)<T>, <T><T>)}

[Detalle.Columnas]
Cantidad=51
Articulo=103
SubCuenta=99
Costo=76
Importe=76
CantidadPendiente=54
CantidadA=49
Disponible=63
Estatus=110
Renglon=64
RenglonID=64
RenglonTipo=54
DisponibleCuenta=75
Aplica=115
AplicaID=66
Paquete=46
CentroCostos=108
ContUso=73
CantidadOrdenada=53
CantidadReservada=57
ArticuloDestino=148
SegundoConteo=58
Unidad=53
CantidadInventario=53
CantidadNeta=49
Almacen=67
FechaRequerida=88
ProdSerieLote=60
Grupo=60
Producto=56
SubProducto=56
Tipo=64
Merma=38
Desperdicio=34
AplicaNombre=125
ClaveIdioma=99
Precio=73
CostoInv=85
Espacio=94
Destino=70
DestinoID=63
DestinoNombre=118
Cliente=64
CantidadInvNeta=56
NumeroEconomico=93
SubCuentaDestino=147
UltimoConteo=71
Codigo=86
Posicion=64
DescripcionExtra=223

[Detalle.ColumnasResumen]
Articulo=117
Descripcion1=175
Cantidad=68
Costo=75
Importe=82
Pendiente=56
Almacen=62

[Detalle.Importe]
Carpeta=Detalle
Clave=Importe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.Aplica]
Carpeta=Detalle
Clave=hInvD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.AplicaID]
Carpeta=Detalle
Clave=hInvD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.Articulo]
Carpeta=Detalle
Clave=hInvD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.Cantidad]
Carpeta=Detalle
Clave=hInvD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.CantidadA]
Carpeta=Detalle
Clave=hInvD.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.CantidadPendiente]
Carpeta=Detalle
Clave=hInvD.CantidadPendiente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=$00004080
Efectos=[Negritas]
ColorFondo=Blanco

[Detalle.hInvD.Costo]
Carpeta=Detalle
Clave=hInvD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.SubCuenta]
Carpeta=Detalle
Clave=hInvD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=hInv
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
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Pestana=S

[Ficha.hInv.Almacen]
Carpeta=Ficha
Clave=hInv.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.AlmacenDestino]
Carpeta=Ficha
Clave=hInv.AlmacenDestino
Editar=S
3D=S
Tamano=20
ValidaNombre=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.AlmacenTransito]
Carpeta=Ficha
Clave=hInv.AlmacenTransito
Editar=S
ValidaNombre=N
3D=S
Tamano=16
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.Concepto]
Carpeta=Ficha
Clave=hInv.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Ficha.hInv.Condicion]
Carpeta=Ficha
Clave=hInv.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.FechaEmision]
Carpeta=Ficha
Clave=hInv.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=S
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.Largo]
Carpeta=Ficha
Clave=hInv.Largo
Editar=S
ValidaNombre=N
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.Moneda]
Carpeta=Ficha
Clave=hInv.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
Pegado=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.Mov]
Carpeta=Ficha
Clave=hInv.Mov
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.MovID]
Carpeta=Ficha
Clave=hInv.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro
Pegado=S
IgnoraFlujo=S

[Ficha.hInv.Observaciones]
Carpeta=Ficha
Clave=hInv.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.Proyecto]
Carpeta=Ficha
Clave=hInv.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
Pegado=N
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.Referencia]
Carpeta=Ficha
Clave=hInv.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.TipoCambio]
Carpeta=Ficha
Clave=hInv.TipoCambio
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.Vencimiento]
Carpeta=Ficha
Clave=hInv.Vencimiento
Editar=S
ValidaNombre=N
3D=S
Tamano=16
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).hInv.Referencia]
Carpeta=(Carpeta Abrir)
Clave=hInv.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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

[(Carpeta Abrir).hInv.Concepto]
Carpeta=(Carpeta Abrir)
Clave=hInv.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
ActivoCondicion=ConDatos(hInv:hInv.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)

[Acciones.SeriesLotes]
Nombre=SeriesLotes
Boton=18
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
NombreDesplegar=&Series/Lotes del Artículo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
Expresion=Si <BR>  hInvD:Art.Tipo=TipoVIN<BR>Entonces<BR>  Si(hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>VINMovMultiple<T>), Forma(<T>VINMovMultipleInfo<T>))<BR>Sino<BR>  Asigna(Info.SumaSerieLote, Nulo)<BR>  Asigna(Info.Articulo, hInvD:hInvD.Articulo)<BR>  Si(hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>SerieLoteMov<T>), Si(Usuario.ModificarSerieLoteProp, Forma(<T>SerieLoteMovProp<T>), Forma(<T>SerieLoteMovInfo<T>)))<BR>  Si<BR>    (no Config.MultiUnidades) y ConDatos(Info.SumaSerieLote) y (Info.SumaSerieLote<>ABS(hInvD:hInvD.Cantidad)) y (hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>  Entonces<BR>    Si<BR>      Confirmacion(<T>La Cantidad Difiere con la Selección.<T>+NuevaLinea+NuevaLinea+<T>¿ Desea Actualizar la Cantidad ?<T>,BotonSi, BotonNo)=BotonSi)<BR>    Entonces<BR>      Asigna(hInvD:hInvD.Cantidad, Si(Vacio(hInvD:hInvD.Cantidad, 0.0)<0,-Info.SumaSerieLote, Info.SumaSerieLote))<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=MovTipo(<T>INV<T>, hInv:hInv.Mov) noen (INV.OT, INV.OI, INV.SM, INV.SOL)) y Config.SeriesLotesMayoreo
EjecucionCondicion=hInvD:Art.Tipo en (TipoSerie, TipoVIN, TipoLote) o <BR>((hInvD:Art.Tipo=TipoPartida) y ConDatos(hInvD:hInvD.SubCuenta))
AntesExpresiones=Asigna(Info.Articulo, hInvD:hInvD.Articulo)<BR>Asigna(Info.Almacen, Si(Config.InvMultiAlmacen y (MovTipo(<T>INV<T>, hInv:hInv.Mov) noen (INV.IF, INV.EI, INV.P, INV.R)), hInvD:hInvD.Almacen, Si(MovTipo(<T>INV<T>, hInv:hInv.Mov)=INV.EI, hInv:hInv.AlmacenDestino, hInv:hInv.Almacen)))<BR>Asigna(Info.AlmTipo, hInv:Alm.Tipo)<BR>Asigna(Info.Modulo, <T>INV<T>) <BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.RenglonID, hInvD:hInvD.RenglonID)<BR>Asigna(Info.Cantidad, ABS(hInvD:hInvD.Cantidad) * UnidadFactor(hInvD:hInvD.Unidad, hInvD:hInvD.Articulo))<BR>Asigna(Info.Paquete, hInvD:hInvD.Paquete)<BR>Asigna(Info.MovTipo, MovTipo(<T>INV<T>, hInv:hInv.Mov))<BR>Asigna(Info.ArtTipo, hInvD:Art.Tipo)<BR>Asigna(Info.EsEntrada, MovTipoEn(<T>INV<T>,hInv:hInv.Mov, (INV.E,INV.EP,INV.EI,INV.R)) o ((MovTipo(<T>INV<T>, hInv:hInv.Mov)=INV.A) y (hInvD:hInvD.Cantidad>0)))<BR>Asigna(Info.Unidad, hInvD:hInvD.Unidad)<BR>Asigna(Info.Estatus, hInv:hInv.Estatus)<BR>Si((Info.ArtTipo=TipoPartida) o (hInvD:Art.TipoOpcion<>TipoNo), Asigna(Info.SubCuenta, hInvD:hInvD.SubCuenta), Asigna(Info.SubCuenta, <T><T>))

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Antes=S
Visible=S
ActivoCondicion=(ConfigModulo(<T>INV<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>PuedeAvanzarSituacion(<T>INV<T>, hInv:hInv.Mov, hInv:hInv.Estatus, FormaSituacion)
AntesExpresiones=Si(Vacio(hInv:hInv.ID),GuardarCambios)

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
ActivoCondicion=ConfigModulo(<T>INV<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(hInv:hInv.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(hInvA:hInv.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInvA:hInv.ID)
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

[Acciones.Embarque]
Nombre=Embarque
Boton=69
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=Datos &Embarque...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=GuiaEmbarque
Antes=S
Visible=S
ActivoCondicion=(hInv:hInv.Estatus<>EstatusCancelado) y  MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.S, INV.SI, INV.P, INV.T, INV.TG))
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)<BR>Asigna(Info.FormaEnvio, Nulo)

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
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Usuario, hInv:hInv.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(hInv:hInv.ID)

[Ficha.hInv.FormaEnvio]
Carpeta=Ficha
Clave=hInv.FormaEnvio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.Paquete]
Carpeta=Detalle
Clave=hInvD.Paquete
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Embarcar]
Nombre=Embarcar
Boton=0
Menu=&Archivo
NombreDesplegar=E&mbarcar...
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)<BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.Estatus, hInv:hInv.Estatus)<BR>Dialogo(<T>MovEmbarcar<T>)
ActivoCondicion=hInv:hInv.Estatus noen (EstatusSinAfectar, EstatusSincro, EstatusCancelado) y (no FormaBloqueada)

[Acciones.Importar]
Nombre=Importar
Boton=0
Menu=&Archivo
NombreDesplegar=I&mportar...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Otros
ClaveAccion=Procesar Lista
ListaParametros1=<T>Importar Movimiento<T><BR><T>ImportarInv<T><BR><T>Estacion<T><BR><T>ID<T><BR><T>spImportarInv<T><BR>EstacionTrabajo & <T>, <T> & Comillas(Empresa) & <T>, <T> & Comillas(<T>INV<T>) & <T>, <T> & hInv:hInv.ID & <T>, <T> & Sucursal
ListaParametros=S
ActivoCondicion=hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Detalle.hInvD.ContUso]
Carpeta=Detalle
Clave=hInvD.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Acciones.ArtListaDisponible]
Nombre=ArtListaDisponible
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+L
NombreDesplegar=&Lista Artículos Disponibles
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtListaDisponible
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Almacen, Si(MovTipo(<T>INV<T>, hInv:hInv.Mov)=INV.EI, hInv:hInv.AlmacenDestino, hInv:hInv.Almacen))<BR>Asigna(Info.Origen, <T>INV<T>)

[Detalle.hInvD.CantidadOrdenada]
Carpeta=Detalle
Clave=hInvD.CantidadOrdenada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

[Detalle.hInvD.CantidadReservada]
Carpeta=Detalle
Clave=hInvD.CantidadReservada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Azul
Efectos=[Negritas]

[Ficha.hInv.Directo]
Carpeta=Ficha
Clave=hInv.Directo
Editar=S
ValidaNombre=N
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.ArticuloDestino]
Carpeta=Detalle
Clave=hInvD.ArticuloDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Activo=S
Visible=S
EnBarraHerramientas=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.Fecha, hInv:hInv.FechaEmision)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hInv:hInv.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, hInv:hInv.Mov+<T> <T>+hInv:hInv.MovID)
RefrescarDespues=S

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
Antes=S
Visible=S
EjecucionConError=S
EjecucionCondicion=ConDatos(hInv:hInv.ID) y ConDatos(hInvD:hInvD.Articulo)
EjecucionMensaje=Si(Vacio(hInv:hInv.ID), <T>Es Necesario Guardar el Movimiento Antes de Ejecutar esta Opción<T>, <T>Falta Indicar el Artículo<T>)
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.Fecha, hInv:hInv.FechaEmision)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hInv:hInv.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Cuenta, hInvD:hInvD.Articulo)<BR>Asigna(Info.Descripcion, hInvD:Art.Descripcion1)

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
ActivoCondicion=ConDatos(hInv:hInv.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)

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
Expresion=CopiarMovimiento(<T>INV<T>, hInv:hInv.ID, <T>Inv<T>)

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

[Detalle.hInvD.Unidad]
Carpeta=Detalle
Clave=hInvD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=5
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.hInvD.CantidadInventario]
Carpeta=Detalle
Clave=hInvD.CantidadInventario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Detalle.CantidadNeta]
Carpeta=Detalle
Clave=CantidadNeta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Campos]
Nombre=Campos
Boton=0
Menu=&Edición
NombreDesplegar=&Campos...
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=InvCampos
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)
VisibleCondicion=hInv:hInv.Estatus<>EstatusSinAfectar

[Ficha.hInv.FechaOrigen]
Carpeta=Ficha
Clave=hInv.FechaOrigen
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N

[Detalle.hInvD.Almacen]
Carpeta=Detalle
Clave=hInvD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.FechaRequerida]
Carpeta=Detalle
Clave=hInvD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.FechaRequerida]
Carpeta=Ficha
Clave=hInv.FechaRequerida
Editar=S
ValidaNombre=N
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.ProdSerieLote]
Carpeta=Detalle
Clave=hInvD.ProdSerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Rojo obscuro

[Acciones.VerOpcion]
Nombre=VerOpcion
Boton=0
NombreDesplegar=&Interpretar Opción
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=VerOpcionesArticulo(hInvD:hInvD.Articulo, hInvD:hInvD.SubCuenta )
ActivoCondicion=ConDatos(hInvD:hInvD.SubCuenta) y (hInvD:Art.TipoOpcion=TipoSi)

[Detalle.hInvD.Tipo]
Carpeta=Detalle
Clave=hInvD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.Merma]
Carpeta=Detalle
Clave=hInvD.Merma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.Desperdicio]
Carpeta=Detalle
Clave=hInvD.Desperdicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AplicaNombre]
Carpeta=Detalle
Clave=AplicaNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ProdSerieLoteInfo]
Nombre=ProdSerieLoteInfo
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+L
NombreDesplegar=Información del Lote Producción
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProdSerieLoteInfo
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(hInvD:hInvD.ProdSerieLote)
AntesExpresiones=Asigna(Info.SerieLote, hInvD:hInvD.ProdSerieLote)
VisibleCondicion=MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.SM, INV.CM))

[Detalle.hInvD.Producto]
Carpeta=Detalle
Clave=hInvD.Producto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Rojo obscuro

[Detalle.hInvD.SubProducto]
Carpeta=Detalle
Clave=hInvD.SubProducto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Rojo obscuro

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
Antes=S
ActivoCondicion=Usuario.ModificarSucursalDestino y (hInv:hInv.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
AntesExpresiones=Si(Vacio(hInv:hInv.ID),GuardarCambios)
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

[Detalle.ClaveIdioma]
Carpeta=Detalle
Clave=ClaveIdioma
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.hInv.VerLote]
Carpeta=Ficha
Clave=hInv.VerLote
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.Precio]
Carpeta=Detalle
Clave=hInvD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.GastosDiversos]
Nombre=GastosDiversos
Boton=0
Menu=&Edición
NombreDesplegar=&Gastos Diversos...
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S
DespuesGuardar=S
RefrescarDespues=S
Expresion=Si(hInv:hInv.Estatus=EstatusSinAfectar,Forma(<T>InvGastoDiverso<T>),Forma(<T>InvGastoDiversoInfo<T>))
AntesExpresiones=Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)<BR>Asigna(Info.Moneda, hInv:hInv.Moneda)<BR>Asigna(Info.TipoCambio, hInv:hInv.TipoCambio)<BR>Asigna(Info.Concepto, Nulo)
VisibleCondicion=MovTipo(<T>INV<T>, hInv:hInv.Mov)=INV.EI

[Detalle.hInvD.CostoInv]
Carpeta=Detalle
Clave=hInvD.CostoInv
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.Espacio]
Carpeta=Detalle
Clave=hInvD.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.UEN]
Carpeta=Ficha
Clave=hInv.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.VerDestino]
Carpeta=Ficha
Clave=hInv.VerDestino
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.Destino]
Carpeta=Detalle
Clave=hInvD.Destino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.DestinoID]
Carpeta=Detalle
Clave=hInvD.DestinoID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.DestinoNombre]
Carpeta=Detalle
Clave=DestinoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CopiarPendientes]
Nombre=CopiarPendientes
Boton=55
Menu=&Archivo
NombreDesplegar=Copiar &Pendientes
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
RefrescarDespues=S
UsaTeclaRapida=S
TeclaRapida=F7
Expresion=Asigna(Info.MovTipo, MovTipo(<T>INV<T>, hInv:hInv.Mov))<BR>Asigna(Info.Centro, Nulo)<BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.SeCompra, Verdadero)<BR>Asigna(Info.SeProduce, Verdadero)<BR>Asigna(Info.Almacen, hInv:hInv.AlmacenDestino)<BR>Forma(<T>DemandaPendiente<T>)
ActivoCondicion=(hInv:hInv.Estatus=EstatusSinAfectar) y MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.OT, INV.OI))

[Detalle.hInvD.Cliente]
Carpeta=Detalle
Clave=hInvD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hInv.Personal]
Carpeta=Ficha
Clave=hInv.Personal
Editar=S
ValidaNombre=N
3D=S
Pegado=N
Tamano=16
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
EjecucionCondicion=ConDatos(hInv:hInv.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, hInv:hInv.Proyecto)
Visible=S

[Detalle.CantidadInvNeta]
Carpeta=Detalle
Clave=CantidadInvNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TraspasarTodo]
Nombre=TraspasarTodo
Boton=0
Menu=&Archivo
NombreDesplegar=Traspasar Todo
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spInvTraspasarTodo :nID, :tEmp, :nSuc, :tAlm<T>, hInv:hInv.ID, Empresa, Sucursal, hInv:hInv.Almacen)
ActivoCondicion=Usuario.TraspasarTodo
VisibleCondicion=MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.T, INV.SI)) y (hInv:hInv.Estatus=EstatusSinAfectar)

[Detalle.Espacio.NumeroEconomico]
Carpeta=Detalle
Clave=Espacio.NumeroEconomico
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.GenerarValeDev]
Nombre=GenerarValeDev
Boton=0
Menu=&Archivo
NombreDesplegar=<T>Generar <T>+ConfigMov.InvValeDevolucion+<T> (Cantidad Indicada)<T>
EnMenu=S
TipoAccion=Expresion
Activo=S
GuardarAntes=S
Expresion=Generar(<T>INV<T>, hInv:hInv.ID, hInv:hInv.Mov, hInv:hInv.MovID, <T>Seleccion<T>, ConfigMov.InvValeDevolucion, <T>Inv<T>)
VisibleCondicion=(hInv:hInv.Mov=ConfigMov.InvValeSalida) y (hInv:hInv.Estatus=EstatusConcluido)

[Acciones.AsignarArticulos]
Nombre=AsignarArticulos
Boton=65
Menu=&Edición
NombreDesplegar=Asignar Artículos (en Lote)
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtDisponibleAsignar
Visible=S
Antes=S
DespuesGuardar=S
RefrescarDespues=S
ActivoCondicion=hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Almacen, hInv:hInv.Almacen)

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
Expresion=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.Clave, <T>INV<T>+hInv:hInv.ID)<BR>Asigna(Info.Nombre, hInv:hInv.Mov+<T> <T>+hInv:hInv.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(hInv:hInv.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Acciones.DesglosarCantidadOrdenada]
Nombre=DesglosarCantidadOrdenada
Boton=0
NombreDesplegar=Desglosar Cantidad &Ordenada
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=DesglosarCantidadOrdenada
Antes=S
ActivoCondicion=Usuario.Costos
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)<BR>Asigna(Info.Articulo, hInvD:hInvD.Articulo)<BR>Asigna(Info.SubCuenta, hInvD:hInvD.SubCuenta)
VisibleCondicion=Config.BackOrders y MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.SOL, INV.OT, INV.OI, INV.SM)) y (hInv:hInv.Estatus=EstatusPendiente)

[Detalle.hInvD.SubCuentaDestino]
Carpeta=Detalle
Clave=hInvD.SubCuentaDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Detalle.hInvD.SegundoConteo]
Carpeta=Detalle
Clave=hInvD.SegundoConteo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.UltimoConteo]
Carpeta=Detalle
Clave=UltimoConteo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ConteoNombre]
Carpeta=Ficha
Clave=ConteoNombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=4
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

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
AntesExpresiones=Asigna(Info.PuedeEditar, hInv:hInv.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)<BR>Asigna(Info.Proyecto, hInv:hInv.Proyecto)<BR>Asigna(Info.UEN, hInv:hInv.UEN)<BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Acciones.SugerirABC]
Nombre=SugerirABC
Boton=0
Menu=&Archivo
NombreDesplegar=&Sugerir Conteo Cíclico...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtAlmABCLista
Antes=S
DespuesGuardar=S
RefrescarDespues=S
EspacioPrevio=S
ActivoCondicion=hInv:hInv.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Almacen, hInv:hInv.Almacen)
VisibleCondicion=MovTipo(<T>INV<T>, hInv:hInv.Mov) = INV.IF

[Detalle.hInvD.Codigo]
Carpeta=Detalle
Clave=hInvD.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CB]
Nombre=CB
Boton=0
Menu=&Ver
NombreDesplegar=Códigos Barras
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=CBMov
ListaParametros1=Info.Modulo<BR>Info.ID
ListaParametros=S
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)
VisibleCondicion=hInv:hInv.Estatus=EstatusConcluido

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
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)<BR>Asigna(Info.Fecha, hInv:hInv.FechaEmision)<BR>Asigna(Info.Estatus, hInv:hInv.Estatus)

[Acciones.MovRecibo]
Nombre=MovRecibo
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F8
NombreDesplegar=Asistente &Recepción
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
RefrescarDespues=S
Expresion=Asigna(Info.ID, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.AlmD, hInv:hInv.Almacen)<BR>Asigna(Info.AlmA, hInv:hInv.AlmacenDestino)<BR>Si <BR>  Si<BR>    hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>  Entonces<BR>    Forma(<T>InvTransitosPendientes<T>)<BR>  Sino<BR>    Asigna(Info.Mov, hInv:hInv.Origen) <BR>    Asigna(Info.MovID, hInv:hInv.OrigenID)<BR>    Verdadero<BR>  Fin<BR>Entonces<BR>  Asigna(Info.Modulo, <T>INV<T>)<BR>  Asigna(Info.ID, hInv:hInv.ID)<BR>  Asigna(Info.Cuenta, Nulo)<BR>  Asigna(Info.Fecha, hInv:hInv.FechaEmision)<BR>  Asigna(Afectar.ID, Nulo)<BR>  Asigna(Afectar.ID, SQL(<T>SELECT ID FROM Inv WHERE Empresa=:tEmpresa AND Mov=:tMov AND MovID=:tMovID AND Estatus=:tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>  Forma(<T>MovRecibo<T>)<BR>Fin
AntesExpresiones=Asigna(Info.PuedeEditar, hInv:hInv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))
VisibleCondicion=MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.EI))

[Acciones.ModificarAlmacen]
Nombre=ModificarAlmacen
Boton=0
Menu=&Archivo
NombreDesplegar=Mo&dificar Almacén Orden...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=InvModificarAlmacen
Antes=S
ConCondicion=S
ActivoCondicion=((MovTipo(<T>INV<T>, hInv:hInv.Mov) noen (INV.OT, INV.OI, INV.SOL)) y (hInv:hInv.Estatus=EstatusSinAfectar)) o<BR>((hInv:hInv.Estatus=EstatusPendiente) y (MovTipo(<T>INV<T>, hInv:hInv.Mov) en (INV.OT, INV.OI, INV.SOL)) y (no FormaBloqueada))
EjecucionCondicion=MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.OT, INV.OI, INV.SOL)) o MovTipoEn(<T>INV<T>, hInvD:hInvD.Aplica, (INV.OT, INV.OI, INV.SOL))
AntesExpresiones=Si<BR>  MovTipo(<T>INV<T>, hInv:hInv.Mov) en (INV.OT, INV.OI, INV.SOL)<BR>Entonces<BR>  Asigna(Info.Mov, hInv:hInv.Mov)<BR>  Asigna(Info.MovID, hInv:hInv.MovID)<BR>  Asigna(Info.ID, hInv:hInv.ID)<BR>Sino<BR>  Asigna(Info.Mov, hInvD:hInvD.Aplica)<BR>  Asigna(Info.MovID, hInvD:hInvD.AplicaID)<BR>  Asigna(Info.ID, SQL(<T>SELECT ID FROM Inv WHERE Empresa=:tEmpresa AND Mov=:tMov AND MovID=:tMovID AND Estatus=:tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>Fin
VisibleCondicion=Usuario.ModificarAlmacenPedidos y MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.OT, INV.OI, INV.SOL))

[Acciones.SugerirArtAlm]
Nombre=SugerirArtAlm
Boton=0
Menu=&Archivo
NombreDesplegar=Sugerir Artículos del Almacén
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>xpInvSugerirArtAlm :nID, :tEmp, :nSuc, :tAlm, :tRef<T>, hInv:hInv.ID, Empresa, Sucursal, hInv:hInv.Almacen, hInv:hInv.Referencia)
ActivoCondicion=hInv:hInv.Estatus=EstatusSinAfectar
VisibleCondicion=MovTipo(<T>INV<T>, hInv:hInv.Mov) = INV.IF

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
EjecucionCondicion=ConDatos(hInv:hInv.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.Clave, hInv:hInv.Mov)

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
EjecucionCondicion=ConDatos(hInv:hInv.Concepto)
AntesExpresiones=Asigna(Info.Concepto, <T>INV<T>)<BR>Asigna(Info.Concepto, hInv:hInv.Concepto)

[Acciones.ModificarAlmacenDetalle]
Nombre=ModificarAlmacenDetalle
Boton=0
NombreDesplegar=Modi&ficar Almacén Detalle...
EnMenu=S
TipoAccion=Formas
ClaveAccion=InvModificarAlmacenDetalle
Menu=&Archivo
ConCondicion=S
Antes=S
RefrescarDespues=S
GuardarAntes=S
ActivoCondicion=((MovTipo(<T>INV<T>, hInv:hInv.Mov) noen (INV.OT, INV.OI, INV.SOL)) y (hInv:hInv.Estatus=EstatusSinAfectar)) o<BR>((hInv:hInv.Estatus=EstatusPendiente) y (MovTipo(<T>INV<T>, hInv:hInv.Mov) en (INV.OT, INV.OI, INV.SOL)) y (no FormaBloqueada))
EjecucionCondicion=MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.OT, INV.OI, INV.SOL))
AntesExpresiones=Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)<BR>Asigna(Info.ID, hInv:hInv.ID)
VisibleCondicion=Config.InvMultiAlmacen y<BR>Usuario.ModificarAlmacenPedidos y MovTipoEn(<T>INV<T>, hInv:hInv.Mov, (INV.OT, INV.OI, INV.SOL))

[Acciones.CambioPresentacionExpress]
Nombre=CambioPresentacionExpress
Boton=0
Menu=&Edición
NombreDesplegar=Cambio Presentación Express
EnMenu=S
TipoAccion=Formas
ClaveAccion=CambioPresentacionExpress
Antes=S
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+J
GuardarAntes=S
ActivoCondicion=Usuario.CambioPresentacionExpress
EjecucionCondicion=ConDatos(hInvD:hInvD.Articulo)
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Articulo, hInvD:hInvD.Articulo)<BR>Asigna(Info.Almacen, hInvD:hInvD.Almacen)<BR>Asigna(Info.Unidad, hInvD:hInvD.Unidad)<BR>Asigna(Info.Cantidad, Vacio(hInvD:hInvD.CantidadPendiente, hInvD:hInvD.Cantidad))
VisibleCondicion=Usuario.CambioPresentacionExpress

[Acciones.Observaciones]
Nombre=Observaciones
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Expresion
Expresion=Si(hInv:hInv.Estatus en (EstatusConcluido, EstatusCancelado), Informacion(hInvD:hInvD.DescripcionExtra), Pregunta(hInvD:hInvD.DescripcionExtra))
Activo=S
Visible=S

[Ficha.hInv.Agente]
Carpeta=Ficha
Clave=hInv.Agente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
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
Expresion=Asigna(Info.Forma, <T>Inv<T>)<BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.Nombre, hInv:hInv.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

[Detalle.hInvD.Posicion]
Carpeta=Detalle
Clave=hInvD.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hInvD.DescripcionExtra]
Carpeta=Detalle
Clave=hInvD.DescripcionExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>INV<T>, hInv:hInv.Mov, hInv:hInv.ID, Falso, hInv:hInv.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>INV<T>+hInv:hInv.ID)<BR>  Asigna(Info.Nombre, hInv:hInv.Mov+<T> <T>+hInv:hInv.MovID)<BR>  Asigna(Info.Modulo, <T>INV<T>)<BR>  Asigna(Info.Mov, hInv:hInv.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Acciones.ImportarPDT]
Nombre=ImportarPDT
Boton=0
Menu=&Archivo
NombreDesplegar=Importar &PDT...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=PlugIn(<T>PDT<T>, <T>INV<T>, hInv:hInv.ID)
ActivoCondicion=hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.GastosIndirectos]
Nombre=GastosIndirectos
Boton=0
Menu=&Edición
NombreDesplegar=Gastos Indirectos...
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)<BR>Si <BR>  hInv:hInv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)<BR>Entonces<BR>  Forma(<T>MovGastoIndirecto<T>)<BR>Sino<BR>  Forma(<T>MovGastoIndirectoInfo<T>)<BR>Fin
ActivoCondicion=MovTipo(<T>INV<T>, hInv:hInv.Mov) = INV.EP
VisibleCondicion=MovTipo(<T>INV<T>, hInv:hInv.Mov) = INV.EP

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
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, hInv:hInv.ID)<BR>Asigna(Info.Mov, hInv:hInv.Mov)<BR>Asigna(Info.MovID, hInv:hInv.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (hInv:hInv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Ficha.hInv.Actividad]
Carpeta=Ficha
Clave=hInv.Actividad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>INV<T>, <T>{hInv:hInv.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>INV{hInv:hInv.ID}<T>
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
Excel=Verificar
Verificar=Situacion
Situacion=Sucursal
Sucursal=Afectar
Afectar=GenerarValeDev
GenerarValeDev=ModificarAlmacen
ModificarAlmacen=ModificarAlmacenDetalle
ModificarAlmacenDetalle=Eliminar
Eliminar=Importar
Importar=ImportarPDT
ImportarPDT=SugerirABC
SugerirABC=SugerirArtAlm
SugerirArtAlm=TraspasarTodo
TraspasarTodo=Cancelar
Cancelar=Embarcar
Embarcar=ReasignarUsuario
ReasignarUsuario=Cambiar Vista Hoja
Cambiar Vista Hoja=CopiarPendientes
CopiarPendientes=Campos
Campos=CamposExtras
CamposExtras=Totalizar
Totalizar=AsignarArticulos
AsignarArticulos=Asistente Articulos
Asistente Articulos=Asistente Codigos Barras
Asistente Codigos Barras=MovRecibo
MovRecibo=Asistente Codigo Barras (Lote)
Asistente Codigo Barras (Lote)=SeriesLotes
SeriesLotes=GastosDiversos
GastosDiversos=GastosIndirectos
GastosIndirectos=Tareas
Tareas=Anexos
Anexos=AnexosDetalle
AnexosDetalle=CambioPresentacionExpress
CambioPresentacionExpress=Embarque
Embarque=Anterior
Anterior=Siguiente
Siguiente=Catalogos
Catalogos=ArtListaDisponible
ArtListaDisponible=CB
CB=Disponible
Disponible=Informacion
Informacion=ProyInfo
ProyInfo=ProdSerieLoteInfo
ProdSerieLoteInfo=Tiempo
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

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=hInv.Almacen
hInv.Almacen=hInv.AlmacenDestino
hInv.AlmacenDestino=hInv.FechaEmision
hInv.FechaEmision=hInv.Referencia
hInv.Referencia=hInv.Concepto
hInv.Concepto=(Fin)

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
AbrirExcel=AbrirMostrar
AbrirMostrar=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Total
Total=Conteo
Conteo=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=hInvD.ProdSerieLote
hInvD.ProdSerieLote=hInvD.Producto
hInvD.Producto=hInvD.SubProducto
hInvD.SubProducto=hInvD.Aplica
hInvD.Aplica=hInvD.AplicaID
hInvD.AplicaID=AplicaNombre
AplicaNombre=hInvD.Destino
hInvD.Destino=hInvD.DestinoID
hInvD.DestinoID=DestinoNombre
DestinoNombre=hInvD.Codigo
hInvD.Codigo=hInvD.Articulo
hInvD.Articulo=hInvD.SubCuenta
hInvD.SubCuenta=ClaveIdioma
ClaveIdioma=hInvD.ArticuloDestino
hInvD.ArticuloDestino=hInvD.SubCuentaDestino
hInvD.SubCuentaDestino=hInvD.Cantidad
hInvD.Cantidad=CantidadNeta
CantidadNeta=hInvD.SegundoConteo
hInvD.SegundoConteo=UltimoConteo
UltimoConteo=hInvD.Merma
hInvD.Merma=hInvD.Desperdicio
hInvD.Desperdicio=hInvD.Unidad
hInvD.Unidad=hInvD.CantidadInventario
hInvD.CantidadInventario=CantidadInvNeta
CantidadInvNeta=hInvD.Precio
hInvD.Precio=hInvD.Tipo
hInvD.Tipo=hInvD.FechaRequerida
hInvD.FechaRequerida=hInvD.Cliente
hInvD.Cliente=hInvD.Paquete
hInvD.Paquete=hInvD.CantidadReservada
hInvD.CantidadReservada=hInvD.CantidadOrdenada
hInvD.CantidadOrdenada=hInvD.CantidadPendiente
hInvD.CantidadPendiente=hInvD.Costo
hInvD.Costo=hInvD.CostoInv
hInvD.CostoInv=Importe
Importe=hInvD.Almacen
hInvD.Almacen=hInvD.Posicion
hInvD.Posicion=hInvD.ContUso
hInvD.ContUso=hInvD.Espacio
hInvD.Espacio=hInvD.DescripcionExtra
hInvD.DescripcionExtra=Espacio.NumeroEconomico
Espacio.NumeroEconomico=hInvD.CantidadA
hInvD.CantidadA=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=Art.Tipo
Art.Tipo=Art.UnidadCompra
Art.UnidadCompra=Art.Unidad
Art.Unidad=(Fin)

[Detalle.ListaAcciones]
(Inicio)=Copiar Pendiente
Copiar Pendiente=Observaciones
Observaciones=DesglosarCantidadOrdenada
DesglosarCantidadOrdenada=VerOpcion
VerOpcion=(Fin)

[Detalle.ListaOrden]
(Inicio)=hInvD.Renglon<TAB>(Acendente)
hInvD.Renglon<TAB>(Acendente)=hInvD.RenglonSub<TAB>(Acendente)
hInvD.RenglonSub<TAB>(Acendente)=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=hInv.Mov
hInv.Mov=hInv.MovID
hInv.MovID=hInv.Proyecto
hInv.Proyecto=hInv.UEN
hInv.UEN=hInv.Moneda
hInv.Moneda=hInv.TipoCambio
hInv.TipoCambio=ConteoNombre
ConteoNombre=hInv.FechaEmision
hInv.FechaEmision=hInv.Actividad
hInv.Actividad=hInv.FechaOrigen
hInv.FechaOrigen=hInv.FechaRequerida
hInv.FechaRequerida=hInv.Almacen
hInv.Almacen=hInv.AlmacenDestino
hInv.AlmacenDestino=hInv.Personal
hInv.Personal=hInv.Concepto
hInv.Concepto=hInv.FormaEnvio
hInv.FormaEnvio=hInv.Largo
hInv.Largo=hInv.AlmacenTransito
hInv.AlmacenTransito=hInv.Referencia
hInv.Referencia=hInv.Condicion
hInv.Condicion=hInv.Vencimiento
hInv.Vencimiento=hInv.VerDestino
hInv.VerDestino=hInv.Observaciones
hInv.Observaciones=hInv.Agente
hInv.Agente=hInv.Directo
hInv.Directo=hInv.VerLote
hInv.VerLote=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)
