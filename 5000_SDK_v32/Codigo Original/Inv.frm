[Forma]
Clave=Inv
Nombre=Info.ModuloInventariosNombre
Icono=0
Modulos=INV
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=231
PosicionInicialArriba=71
PosicionInicialAltura=526
PosicionInicialAncho=903
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
PosicionInicialAlturaCliente=557
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Espacio, Nulo)<BR>Asigna(Info.Articulo, Nulo)
TituloAutoNombre=S
PosicionSec1=271
PosicionSec2=443

MenuPrincipal=(Lista)
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=InvA
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
FiltroFechasCampo=Inv.FechaEmision
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
FiltroAplicaEn=Inv.Almacen
FiltroAplicaO=Inv.AlmacenDestino
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todos)
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroGrupo1=(Validaciones Memoria)
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroFechasCancelacion=Inv.FechaCancelacion
FiltroSucursales=S
ListaOrden=Inv.ID<TAB>(Decendente)

IconosNombre=InvA:Inv.Mov+<T> <T>+InvA:Inv.MovID
FiltroGeneral={Si(SQL(<T>SELECT ISNULL(Filtrar, 0) FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSub<T>, <T>INV<T>, Info.SubModuloInv), <T>Inv.SubModulo=<T>+Comillas(Info.SubModuloInv), <T>1=1<T>)}
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=184
1=85
2=-2
3=-2
4=-2
5=-2

[(Carpeta Abrir).Inv.Almacen]
Carpeta=(Carpeta Abrir)
Clave=Inv.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[(Carpeta Abrir).Inv.AlmacenDestino]
Carpeta=(Carpeta Abrir)
Clave=Inv.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[(Carpeta Abrir).Inv.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Inv.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

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

Expresion=Asigna(Afectar.Modulo, <T>INV<T>)<BR>Asigna(Afectar.ID, Inv:Inv.ID)<BR>Asigna(Afectar.Mov, Inv:Inv.Mov)<BR>Asigna(Afectar.MovID, Inv:Inv.MovID)<BR>Asigna(Afectar.Base, <T>Todo<T>)<BR>Asigna(Afectar.GenerarMov, <T><T>)<BR>Asigna(Afectar.FormaCaptura, <T>Inv<T>)<BR>Asigna(Info.MovTipo, MovTipo(<T>INV<T>,Inv:Inv.Mov))<BR>Asigna(Info.Clave, SQL(<T>SELECT TOP 1 SubClave FROM MovTipo WHERE Modulo = :tModulo AND Clave = :tClave AND Mov = :tMov<T>, Afectar.Modulo, Info.MovTipo, Afectar.Mov))<BR>Si(Info.MovTipo=INV.IF, Asigna(Afectar.GenerarMov, ConfigMov.InvAjuste))<BR>Si<BR>  Inv:Inv.Estatus en (EstatusPorConfirmar, EstatusBorrador, EstatusSinAfectar)<BR>Entonces<BR>  Si<BR>    (Info.MovTipo=INV.IF) y (Config.InvFisicoConteo=1)<BR>  Entonces<BR>    Dialogo(<T>AfectarInventarioFisico<T>)<BR>  Sino<BR>    Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>  Fin<BR>Sino<BR>  Si<BR>    Inv:Inv.Estatus=EstatusPendiente<BR>  Entonces<BR>    Asigna(Info.Modulo, <T>INV<T>)<BR>    Asigna(Info.Mov, Inv:Inv.Mov)<BR>    Asigna(Info.MovID, Inv:Inv.MovID)<BR>    Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>    Si<BR>      ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>    Entonces<BR>      Si<BR>        Forma(<T>GenerarMovFlujo<T>)<BR>      Entonces<BR>       Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>       Si//2<BR>          Info.MovTipo en (INV.OI,INV.OT,INV.SOL,INV.SM)<BR>       Entonces<BR>          Caso Info.MovGenerar<BR>            Es <T>(Reservar)<T>    Entonces Si(Usuario.Reservar,    Dialogo(<T>Reservar<T>),     Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Desreservar)<T> Entonces Si(Usuario.Desreservar, Dialogo(<T>DesReservar<T>),  Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Asignar)<T>     Entonces Si(Usuario.Asignar,     Dialogo(<T>Asignar<T>),      Precaucion(<T>No Tiene Acceso<T>))<BR>            Es <T>(Desasignar)<T>  Entonces Si(Usuario.DesAsignar,  Dialogo(<T>DesAsignar<T>),   Precaucion(<T>No Tiene Acceso<T>))<BR>          Sino<BR>           Si<BR>            Dialogo(<T>GenerarInvBase<T>)<BR>           Entonces<BR><BR>            Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>           Fin<BR>          Fin<BR>       Sino<BR>        Si<BR>          Dialogo(<T>GenerarInvBase<T>)<BR>        Entonces<BR><BR>          Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>        Fin<BR>        Fin//2<BR>      Fin<BR>    Sino<BR>      Caso Info.MovTipo<BR>        Es INV.T   Entonces Dialogo(<T>AfectarTransferencia<T>)<BR>        Es INV.SOL Entonces Si(Info.Mov=ConfigMov.InvOrdenEntarimado, Dialogo(<T>GenerarOrdenEntarimado<T>), Dialogo(<T>GenerarSolicitud<T>))<BR>        Es INV.OT  Entonces Dialogo(<T>GenerarOrdenTransferencia<T>)<BR>        Es INV.OI  Entonces Dialogo(<T>GenerarOrdenTraspaso<T>)<BR>        Es INV.TI  Entonces Dialogo(<T>GenerarTransito<T>)<BR>        Es INV.DTI Entonces Dialogo(<T>GenerarTransito<T>)<BR>        Es INV.SM  Entonces<BR>          Si(Info.Clave <> <T>INV.SAUX<T>,Dialogo(<T>GenerarSolicitudMaterial<T>),Dialogo(<T>GenerarSolicitudMaterialServicio<T>))<BR>        Es INV.IF  Entonces<BR>         Si<BR>          (Config.InvFisicoConteo=Inv:Inv.Conteo)<BR>        Entonces<BR>          Dialogo(<T>AfectarInventarioFisico<T>)<BR>        Sino<BR>           Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, Afectar.Base, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>           Asigna(Temp.Texto,SQL(<T>SELECT COUNT(InvD.ID) FROM Inv INNER JOIN InvD ON inv.ID=invd.ID WHERE inv.ID = :tID AND InvD.Cantidad<>InvD.SegundoConteo<T>,Inv:Inv.ID))<BR>           Si<BR>               (Temp.Texto=<T>0<T>)<BR>           Entonces<BR>                Dialogo(<T>AfectarInventarioFisico<T>)<BR>           Fin<BR>        Fin<BR>        Es INV.P   Entonces<BR>          Asigna(Info.TituloDialogo,<T>Recibir Prestamo<T>)<BR>          Asigna(Afectar.GenerarMov, ConfigMov.InvReciboPrestamo)<BR>          Dialogo(<T>GenerarPendiente<T>)<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Inv:Inv.Usuario) y<BR>(Inv:Inv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar, EstatusPendiente))  y<BR>fnPuedeAvanzarEstatus(Empresa, <T>INV<T>, Inv:Inv.Mov, Inv:Inv.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Inv:Inv.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>INV<T>, Inv:Inv.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>INV<T>, Inv:Inv.Mov, Inv:Inv.ID, Verdadero, Inv:Inv.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ListaParametros1=InvD:InvD.Articulo<BR>InvD:InvD.Almacen<BR>InvD:InvD.SubCuenta<BR>InvD:InvD.Cantidad<BR>Nulo<BR>MovTipoEn(<T>INV<T>,Inv:Inv.Mov, (INV.E, INV.EP, INV.EI, INV.R))<BR>Nulo<BR>MovTipoEn(<T>INV<T>,Inv:Inv.Mov, (INV.S, INV.SI, INV.T, INV.P, INV.IF))<BR>Nulo<BR>InvD:Art.Descripcion1<BR>InvD:Art.Tipo<BR>InvD:Art.Unidad<BR>Nulo<BR>InvD:Art.TipoOpcion<BR>Falso<BR>Nulo<BR>Nulo<BR>Nulo<BR><T>INV<T><BR>Inv:Inv.ID<BR>Inv:Inv.Almacen
ListaParametros=S
Visible=S
ActivoCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPendiente)

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
ListaParametros1=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>Inv:Inv.Estatus = EstatusPendiente<BR>InvD:InvD.Cantidad<BR>InvD:InvD.CantidadPendiente<BR>Nulo<BR>InvD:InvD.CantidadA<BR>InvD:InvD.SubCuenta<BR>InvD:InvD.Unidad<BR>InvD:InvD.Articulo<BR>Nulo<BR>Nulo<BR>Inv:Inv.Almacen<BR>Nulo<BR>Nulo<BR>Nulo<BR>Inv:Inv.ID<BR>Verdadero<BR>Config.CBProcesarLote<BR>Verdadero<BR>Si(Config.CBDirAlmacen, Si(MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.OI, INV.OT, INV.T, INV.TI, INV.DTI, INV.SI)), Inv:AlmDestino.CBDir, Inv:Alm.CBDir), <T><T>)
GuardarAntes=S
ActivoCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar) o ((MovTipo(<T>INV<T>, Inv:Inv.Mov) = INV.IF) y (Inv:Inv.Estatus=EstatusPendiente))
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
ListaParametros1=Inv:Inv.Estatus en (EstatusSinAfectar,EstatusPendiente)<BR>Inv:Inv.Estatus=EstatusPendiente<BR>InvD:InvD.Cantidad<BR>InvD:InvD.CantidadPendiente<BR>Nulo<BR>InvD:InvD.CantidadA<BR>InvD:InvD.SubCuenta<BR>InvD:InvD.Unidad<BR>InvD:InvD.Articulo<BR>Nulo<BR>Nulo<BR>Inv:Inv.Almacen<BR>Nulo<BR>Nulo<BR>Inv:AlmDestino.Idioma<BR>Config.CBPreguntarCantidad<BR>Falso
ListaParametros=S
Visible=S
ActivoCondicion=Config.CB y (Inv:Inv.Estatus en (EstatusSinAfectar,EstatusPendiente))

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
Expresion=Si <BR>  (Inv:Inv.Estatus=EstatusPendiente) y (MovTipo(<T>INV<T>,Inv:Inv.Mov) en (INV.SOL, INV.OT, INV.OI, INV.SM))<BR>Entonces<BR>  Asigna(Info.TituloDialogo, <T>Cancelar: <T>+Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Dialogo(<T>CancelarPendiente<T>)<BR>Sino<BR>  Si<BR>    Precaucion(<T>¿ Esta seguro que desea cancelar el movimiento ?<T>+NuevaLinea+NuevaLinea+Afectar.Mov+<T> <T>+Afectar.MovID, BotonSi, BotonNo ) = BotonSi<BR>  Entonces<BR>    Cancelar(<T>INV<T>, Inv:Inv.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Inv<T>)<BR>  Fin<BR>Fin
ActivoCondicion=Si<BR>  PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Inv:Inv.Usuario) y ConDatos(Inv:Inv.ID) y ConDatos(Inv:Inv.MovID)<BR>Entonces<BR>  Si<BR>    MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.P, INV.IF, INV.SOL, INV.OT, INV.OI, INV.TI, INV.SM))<BR>  Entonces<BR>    Inv:Inv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusFueraLinea, EstatusSincro, EstatusPorConfirmar, EstatusPendiente)<BR>  Sino<BR>    Inv:Inv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusFueraLinea, EstatusSincro, EstatusPorConfirmar, EstatusConcluido, EstatusPendiente)<BR>  Fin<BR>Sino<BR>  Falso<BR>Fin
AntesExpresiones=Asigna(Afectar.Modulo, <T>INV<T>)<BR>Asigna(Afectar.ID, Inv:Inv.ID)<BR>Asigna(Afectar.Mov, Inv:Inv.Mov ) <BR>Asigna(Afectar.MovID, Inv:Inv.MovID )

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
ListaParametros1=InvD:InvD.Articulo<BR>Si(MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.EI, Inv:Inv.AlmacenDestino, Inv:Inv.Almacen)<BR>InvD:InvD.Cantidad
ActivoCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPendiente)

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
Expresion=Asigna( InvD:InvD.CantidadA,InvD:InvD.CantidadPendiente )
Visible=S
ActivoCondicion=Inv:Inv.Estatus = EstatusPendiente

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
Expresion=Asigna(Info.Origen, <T>INV<T>)<BR>Asigna(Info.Articulo, InvD:InvD.Articulo)<BR>Asigna(Info.Descripcion, InvD:Art.Descripcion1)<BR>Asigna(Info.ArtTipo, InvD:Art.Tipo)<BR>Asigna(Info.ArtTipoOpcion, InvD:Art.TipoOpcion)<BR>Asigna(Info.Almacen, Si(Config.InvMultiAlmacen y (MovTipo(<T>INV<T>, Inv:Inv.Mov) noen (INV.IF, INV.EI, INV.P, INV.R)), InvD:InvD.Almacen, Si(MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.EI, Inv:Inv.AlmacenDestino, Inv:Inv.Almacen)))<BR>Forma(<T>ArtAlmExistencia<T>)
EjecucionCondicion=ConDatos(InvD:InvD.Articulo)

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
ActivoCondicion=Vacio(Inv:Inv.MovID) y (Inv:Inv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Inv:Inv.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Inv WHERE ID=:nID<T>, Inv:Inv.ID))
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
EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Inv:Inv.ID) y (Inv:Inv.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Inv:Inv.ID, <T>INV<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>ConDatos(Inv:Inv.Almacen)
EjecucionMensaje=<T>Falta Indicar el Almacén<T>
EjecucionConError=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
NombreDesplegar=&Imprimir...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Inv:Inv.ID
Visible=S
Activo=
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
EspacioPrevio=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>INV<T>, Inv:Inv.Mov, Inv:Inv.Estatus), Inv:Inv.ID)
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
EjecucionCondicion=ConDatos(InvD:InvD.Articulo)
AntesExpresiones=Asigna( Info.Articulo, InvD:InvD.Articulo )<BR>Asigna( Info.ArtTipo, InvD:Art.Tipo )<BR>Asigna(Info.Origen, <T>INV<T>)

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
ListaParametros1=Inv:Inv.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>INV<T>, Inv:Inv.Mov, Inv:Inv.Estatus), Inv:Inv.ID)
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
ActivoCondicion=Inv:Inv.Estatus=EstatusSinAfectar

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
Expresion=Asigna(Afectar.Modulo, <T>INV<T>)<BR>Asigna(Afectar.ID, Inv:Inv.ID)<BR>Asigna(Afectar.Mov, Inv:Inv.Mov)<BR>Asigna(Afectar.MovID, Inv:Inv.MovID)<BR>Asigna(Afectar.GenerarMov, Nulo)<BR>Si(MovTipo(<T>INV<T>,Inv:Inv.Mov)=INV.IF, Asigna(Afectar.GenerarMov, ConfigMov.InvAjuste))<BR>Verificar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov)
ActivoCondicion=Inv:Inv.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Inv:Inv.Mov)

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
Totalizadores2=Si(Usuario.Costos y ((MovTipoEn(<T>INV<T>,Inv:Inv.Mov,(INV.E,INV.EP,INV.EI,INV.A,INV.TIS)) o (Inv:Inv.Estatus=EstatusConcluido)) y (no MovTipoEn(<T>INV<T>,Inv:Inv.Mov,(INV.T, INV.TG, INV.P, INV.R, INV.IF))) y (Inv:Alm.Tipo<><T>Garantias<T>)), Suma(InvD:Importe), Nulo)<BR>Conteo(InvD:InvD.Articulo)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CondicionVisible=MovTipo(<T>INV<T>, Inv:Inv.Mov) noen (INV.SOL, INV.OT, INV.OI, INV.TI, INV.DTI, INV.SM, INV.TMA)
[Detalle]
Estilo=Hoja
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=InvD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Detalle=S
VistaMaestra=Inv
LlaveLocal=InvD.ID
LlaveMaestra=Inv.ID
ControlRenglon=S
CampoRenglon=InvD.Renglon
ValidarCampos=S
ListaCamposAValidar=(Lista)
HojaSubCta=Si
HojaSubNS=Si
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=InvD.Renglon<TAB>(Acendente)
ControlRenglonID=S
ControlRenglonTipo=S
HojaColoresPorTipo=S
CampoDespliegaTipo=Art.Tipo
ConResumen=S
ResumenVista=InvR
ResumenLlave=ID
ResumenCampos=(Lista)
VistaOmision=Resumén
ResumenVistaMaestra=Inv
ResumenLlaveMaestra=Inv.ID
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
CarpetaVisible=S

FiltroGeneral={Si((Info.MovTipo=INV.IF) y (Config.InvFisicoConteo=3), <T>Seccion IS NULL AND (Inv.Estatus=<T>+Comillas(EstatusConcluido)+<T> OR InvD.SegundoConteo IS NULL OR InvD.Cantidad<>InvD.SegundoConteo )<T>, <T>Seccion IS NULL<T>)}
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
Tarima=77
FechaCaducidad=94

PosicionDestino=81
PosicionActual=75
PosicionReal=66
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

[Detalle.InvD.Aplica]
Carpeta=Detalle
Clave=InvD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.InvD.AplicaID]
Carpeta=Detalle
Clave=InvD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.InvD.Articulo]
Carpeta=Detalle
Clave=InvD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.InvD.Cantidad]
Carpeta=Detalle
Clave=InvD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.InvD.CantidadA]
Carpeta=Detalle
Clave=InvD.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=S
ColorFondo=Blanco

[Detalle.InvD.CantidadPendiente]
Carpeta=Detalle
Clave=InvD.CantidadPendiente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=$00004080
Efectos=[Negritas]
ColorFondo=Blanco

[Detalle.InvD.Costo]
Carpeta=Detalle
Clave=InvD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=S
ColorFondo=Blanco

[Detalle.InvD.SubCuenta]
Carpeta=Detalle
Clave=InvD.SubCuenta
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
Vista=Inv
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

[Ficha.Inv.Almacen]
Carpeta=Ficha
Clave=Inv.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
Pegado=N
ColorFondo=Blanco

[Ficha.Inv.AlmacenDestino]
Carpeta=Ficha
Clave=Inv.AlmacenDestino
Editar=S
3D=S
Tamano=20
ValidaNombre=S
ColorFondo=Blanco

[Ficha.Inv.AlmacenTransito]
Carpeta=Ficha
Clave=Inv.AlmacenTransito
Editar=S
ValidaNombre=N
3D=S
Tamano=16
Pegado=N
ColorFondo=Blanco

[Ficha.Inv.Concepto]
Carpeta=Ficha
Clave=Inv.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.Inv.Condicion]
Carpeta=Ficha
Clave=Inv.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
Pegado=N
ColorFondo=Blanco

[Ficha.Inv.FechaEmision]
Carpeta=Ficha
Clave=Inv.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EspacioPrevio=S
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Inv.Largo]
Carpeta=Ficha
Clave=Inv.Largo
Editar=S
ValidaNombre=N
3D=S
Tamano=7
ColorFondo=Blanco

[Ficha.Inv.Moneda]
Carpeta=Ficha
Clave=Inv.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
Pegado=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Inv.Mov]
Carpeta=Ficha
Clave=Inv.Mov
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

[Ficha.Inv.MovID]
Carpeta=Ficha
Clave=Inv.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.Inv.Observaciones]
Carpeta=Ficha
Clave=Inv.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco

[Ficha.Inv.Proyecto]
Carpeta=Ficha
Clave=Inv.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
Pegado=N
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Inv.Referencia]
Carpeta=Ficha
Clave=Inv.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.Inv.TipoCambio]
Carpeta=Ficha
Clave=Inv.TipoCambio
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Ficha.Inv.Vencimiento]
Carpeta=Ficha
Clave=Inv.Vencimiento
Editar=S
ValidaNombre=N
3D=S
Tamano=16
Pegado=N
ColorFondo=Blanco

[(Carpeta Abrir).Inv.Referencia]
Carpeta=(Carpeta Abrir)
Clave=Inv.Referencia
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

[(Carpeta Abrir).Inv.Concepto]
Carpeta=(Carpeta Abrir)
Clave=Inv.Concepto
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
ActivoCondicion=ConDatos(Inv:Inv.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)

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

Expresion=Si<BR>  InvD:Art.Tipo=TipoVIN<BR>Entonces<BR>  Si(Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>VINMovMultiple<T>), Forma(<T>VINMovMultipleInfo<T>))<BR>Sino<BR>  Asigna(Info.SumaSerieLote, Nulo)<BR>  Asigna(Info.Articulo, InvD:InvD.Articulo)<BR>  Si MovTipo(<T>INV<T>, Inv:Inv.Mov) en(<T>INV.TMA<T>)       <BR>  Entonces<BR>    Forma(<T>SerieLoteMovInfo<T>)<BR>  Sino<BR>    Si(Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar), Forma(<T>SerieLoteMov<T>), Si(Usuario.ModificarSerieLoteProp, Forma(<T>SerieLoteMovProp<T>), Forma(<T>SerieLoteMovInfo<T>)))<BR>  Fin<BR>  Si<BR>    (no Config.MultiUnidades) y ConDatos(Info.SumaSerieLote) y (Info.SumaSerieLote<>ABS(InvD:InvD.Cantidad)) y (Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))<BR>  Entonces<BR>    Si<BR>      Confirmacion(<T>La Cantidad Difiere con la Selección.<T>+NuevaLinea+NuevaLinea+<T>¿ Desea Actualizar la Cantidad ?<T>,BotonSi, BotonNo)=BotonSi)<BR>    Entonces<BR>      Asigna(InvD:InvD.Cantidad, Si(Vacio(InvD:InvD.Cantidad, 0.0)<0,-Info.SumaSerieLote, Info.SumaSerieLote))<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=MovTipo(<T>INV<T>, Inv:Inv.Mov) noen (INV.SM)) y Config.SeriesLotesMayoreo
EjecucionCondicion=InvD:Art.Tipo en (TipoSerie, TipoVIN, TipoLote) o <BR>((InvD:Art.Tipo=TipoPartida) y ConDatos(InvD:InvD.SubCuenta))
AntesExpresiones=Asigna(Info.Articulo, InvD:InvD.Articulo)<BR>Asigna(Info.Almacen, Si(Config.InvMultiAlmacen y (MovTipo(<T>INV<T>, Inv:Inv.Mov) noen (INV.IF, INV.EI, INV.P, INV.R)), InvD:InvD.Almacen, Si(MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.EI, Inv:Inv.AlmacenDestino, Inv:Inv.Almacen)))<BR>Asigna(Info.AlmTipo, Inv:Alm.Tipo)<BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.RenglonID, InvD:InvD.RenglonID)<BR>Asigna(Info.Cantidad, ABS(InvD:InvD.Cantidad) * UnidadFactor(InvD:InvD.Unidad, InvD:InvD.Articulo))<BR>Asigna(Info.Paquete, InvD:InvD.Paquete)<BR>Asigna(Info.MovTipo, MovTipo(<T>INV<T>, Inv:Inv.Mov))<BR>Asigna(Info.ArtTipo, InvD:Art.Tipo)<BR>Asigna(Info.EsEntrada, MovTipoEn(<T>INV<T>,Inv:Inv.Mov, (INV.E,INV.EP,INV.EI,INV.R)) o ((MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.A) y (InvD:InvD.Cantidad>0)))<BR>Asigna(Info.Unidad, InvD:InvD.Unidad)<BR>Asigna(Info.Estatus, Inv:Inv.Estatus)<BR>Si((Info.ArtTipo=TipoPartida) o (InvD:Art.TipoOpcion<>TipoNo), Asigna(Info.SubCuenta, InvD:InvD.SubCuenta), Asigna(Info.SubCuenta, <T><T>))<BR>Asigna(Info.Tarima, InvD:InvD.Tarima)
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>INV<T>, Inv:Inv.Mov, Inv:Inv.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>INV<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>INV<T>, Inv:Inv.Mov, Inv:Inv.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Inv:Inv.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.Estatus, Inv:Inv.Estatus)<BR>Asigna(Info.Situacion, Inv:Inv.Situacion)
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
ActivoCondicion=ConfigModulo(<T>INV<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Inv:Inv.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(InvA:Inv.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, InvA:Inv.ID)
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
ActivoCondicion=(Inv:Inv.Estatus<>EstatusCancelado) y  MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.S, INV.SI, INV.P, INV.T, INV.TG))
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Asigna(Info.FormaEnvio, Nulo)

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
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Usuario, Inv:Inv.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Inv:Inv.ID)

[Ficha.Inv.FormaEnvio]
Carpeta=Ficha
Clave=Inv.FormaEnvio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.InvD.Paquete]
Carpeta=Detalle
Clave=InvD.Paquete
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Embarcar]
Nombre=Embarcar
Boton=0
Menu=&Archivo
NombreDesplegar=E&mbarcar...
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.Estatus, Inv:Inv.Estatus)<BR>Dialogo(<T>MovEmbarcar<T>)
ActivoCondicion=Inv:Inv.Estatus noen (EstatusSinAfectar, EstatusSincro, EstatusCancelado) y (no FormaBloqueada)

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
ListaParametros1=<T>Importar Movimiento<T><BR><T>ImportarInv<T><BR><T>Estacion<T><BR><T>ID<T><BR><T>spImportarInv<T><BR>EstacionTrabajo & <T>, <T> & Comillas(Empresa) & <T>, <T> & Comillas(<T>INV<T>) & <T>, <T> & Inv:Inv.ID & <T>, <T> & Sucursal
ListaParametros=S
ActivoCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Detalle.InvD.ContUso]
Carpeta=Detalle
Clave=InvD.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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
AntesExpresiones=Asigna(Info.Almacen, Si(MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.EI, Inv:Inv.AlmacenDestino, Inv:Inv.Almacen))<BR>Asigna(Info.Origen, <T>INV<T>)

[Detalle.InvD.CantidadOrdenada]
Carpeta=Detalle
Clave=InvD.CantidadOrdenada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

[Detalle.InvD.CantidadReservada]
Carpeta=Detalle
Clave=InvD.CantidadReservada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Azul
Efectos=[Negritas]

[Ficha.Inv.Directo]
Carpeta=Ficha
Clave=Inv.Directo
Editar=S
ValidaNombre=N
3D=S
Tamano=16
ColorFondo=Blanco

[Detalle.InvD.ArticuloDestino]
Carpeta=Detalle
Clave=InvD.ArticuloDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.Fecha, Inv:Inv.FechaEmision)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Inv:Inv.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Inv:Inv.Mov+<T> <T>+Inv:Inv.MovID)

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
EjecucionCondicion=ConDatos(Inv:Inv.ID) y ConDatos(InvD:InvD.Articulo)
EjecucionMensaje=Si(Vacio(Inv:Inv.ID), <T>Es Necesario Guardar el Movimiento Antes de Ejecutar esta Opción<T>, <T>Falta Indicar el Artículo<T>)
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.Fecha, Inv:Inv.FechaEmision)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Inv:Inv.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Cuenta, InvD:InvD.Articulo)<BR>Asigna(Info.Descripcion, InvD:Art.Descripcion1)

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
ActivoCondicion=ConDatos(Inv:Inv.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)

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
Expresion=CopiarMovimiento(<T>INV<T>, Inv:Inv.ID, <T>Inv<T>)

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

[Detalle.InvD.Unidad]
Carpeta=Detalle
Clave=InvD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=5
ColorFondo=Plata

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]

[Detalle.InvD.CantidadInventario]
Carpeta=Detalle
Clave=InvD.CantidadInventario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
AntesExpresiones=Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)
VisibleCondicion=Inv:Inv.Estatus<>EstatusSinAfectar

[Ficha.Inv.FechaOrigen]
Carpeta=Ficha
Clave=Inv.FechaOrigen
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ValidaNombre=N

[Detalle.InvD.Almacen]
Carpeta=Detalle
Clave=InvD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.InvD.FechaRequerida]
Carpeta=Detalle
Clave=InvD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Inv.FechaRequerida]
Carpeta=Ficha
Clave=Inv.FechaRequerida
Editar=S
ValidaNombre=N
3D=S
Tamano=13
ColorFondo=Blanco

[Detalle.InvD.ProdSerieLote]
Carpeta=Detalle
Clave=InvD.ProdSerieLote
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
Expresion=VerOpcionesArticulo(InvD:InvD.Articulo, InvD:InvD.SubCuenta )
ActivoCondicion=ConDatos(InvD:InvD.SubCuenta) y (InvD:Art.TipoOpcion=TipoSi)

[Detalle.InvD.Tipo]
Carpeta=Detalle
Clave=InvD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.InvD.Merma]
Carpeta=Detalle
Clave=InvD.Merma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.InvD.Desperdicio]
Carpeta=Detalle
Clave=InvD.Desperdicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AplicaNombre]
Carpeta=Detalle
Clave=AplicaNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

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
EjecucionCondicion=ConDatos(InvD:InvD.ProdSerieLote)
AntesExpresiones=Asigna(Info.SerieLote, InvD:InvD.ProdSerieLote)
VisibleCondicion=MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.SM, INV.CM))

[Detalle.InvD.Producto]
Carpeta=Detalle
Clave=InvD.Producto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Rojo obscuro

[Detalle.InvD.SubProducto]
Carpeta=Detalle
Clave=InvD.SubProducto
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Inv:Inv.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
AntesExpresiones=Si(Vacio(Inv:Inv.ID),GuardarCambios)
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

[Ficha.Inv.VerLote]
Carpeta=Ficha
Clave=Inv.VerLote
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco

[Detalle.InvD.Precio]
Carpeta=Detalle
Clave=InvD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
Expresion=Si(Inv:Inv.Estatus=EstatusSinAfectar,Forma(<T>InvGastoDiverso<T>),Forma(<T>InvGastoDiversoInfo<T>))
AntesExpresiones=Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Asigna(Info.Moneda, Inv:Inv.Moneda)<BR>Asigna(Info.TipoCambio, Inv:Inv.TipoCambio)<BR>Asigna(Info.Concepto, Nulo)
VisibleCondicion=MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.EI

[Detalle.InvD.CostoInv]
Carpeta=Detalle
Clave=InvD.CostoInv
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.InvD.Espacio]
Carpeta=Detalle
Clave=InvD.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Inv.UEN]
Carpeta=Ficha
Clave=Inv.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco

[Ficha.Inv.VerDestino]
Carpeta=Ficha
Clave=Inv.VerDestino
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco

[Detalle.InvD.Destino]
Carpeta=Detalle
Clave=InvD.Destino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.InvD.DestinoID]
Carpeta=Detalle
Clave=InvD.DestinoID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.DestinoNombre]
Carpeta=Detalle
Clave=DestinoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

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
Expresion=Asigna(Info.MovTipo, MovTipo(<T>INV<T>, Inv:Inv.Mov))<BR>Asigna(Info.Centro, Nulo)<BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.SeCompra, Verdadero)<BR>Asigna(Info.SeProduce, Verdadero)<BR>Asigna(Info.Almacen, Inv:Inv.AlmacenDestino)<BR>Forma(<T>DemandaPendiente<T>)
ActivoCondicion=(Inv:Inv.Estatus=EstatusSinAfectar) y MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.OT, INV.OI))

[Detalle.InvD.Cliente]
Carpeta=Detalle
Clave=InvD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Inv.Personal]
Carpeta=Ficha
Clave=Inv.Personal
Editar=S
ValidaNombre=N
3D=S
Pegado=N
Tamano=16
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
EjecucionCondicion=ConDatos(Inv:Inv.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Inv:Inv.Proyecto)
Visible=S

[Detalle.CantidadInvNeta]
Carpeta=Detalle
Clave=CantidadInvNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.TraspasarTodo]
Nombre=TraspasarTodo
Boton=0
Menu=&Archivo
NombreDesplegar=Traspasar Todo
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spInvTraspasarTodo :nID, :tEmp, :nSuc, :tAlm<T>, Inv:Inv.ID, Empresa, Sucursal, Inv:Inv.Almacen)
ActivoCondicion=Usuario.TraspasarTodo
VisibleCondicion=MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.T, INV.SI)) y (Inv:Inv.Estatus=EstatusSinAfectar)

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
Expresion=Generar(<T>INV<T>, Inv:Inv.ID, Inv:Inv.Mov, Inv:Inv.MovID, <T>Seleccion<T>, ConfigMov.InvValeDevolucion, <T>Inv<T>)
VisibleCondicion=(Inv:Inv.Mov=ConfigMov.InvValeSalida) y (Inv:Inv.Estatus=EstatusConcluido)

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
ActivoCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Almacen, Inv:Inv.Almacen)

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
Expresion=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.Clave, <T>INV<T>+Inv:Inv.ID)<BR>Asigna(Info.Nombre, Inv:Inv.Mov+<T> <T>+Inv:Inv.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Inv:Inv.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Asigna(Info.Articulo, InvD:InvD.Articulo)<BR>Asigna(Info.SubCuenta, InvD:InvD.SubCuenta)
VisibleCondicion=Config.BackOrders y MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.SOL, INV.OT, INV.OI, INV.SM)) y (Inv:Inv.Estatus=EstatusPendiente)

[Detalle.InvD.SubCuentaDestino]
Carpeta=Detalle
Clave=InvD.SubCuentaDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Detalle.InvD.SegundoConteo]
Carpeta=Detalle
Clave=InvD.SegundoConteo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.UltimoConteo]
Carpeta=Detalle
Clave=UltimoConteo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
AntesExpresiones=Asigna(Info.PuedeEditar, Inv:Inv.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Asigna(Info.Proyecto, Inv:Inv.Proyecto)<BR>Asigna(Info.UEN, Inv:Inv.UEN)<BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
ActivoCondicion=Inv:Inv.Estatus=EstatusSinAfectar
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Almacen, Inv:Inv.Almacen)
VisibleCondicion=MovTipo(<T>INV<T>, Inv:Inv.Mov) = INV.IF

[Detalle.InvD.Codigo]
Carpeta=Detalle
Clave=InvD.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

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
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)
VisibleCondicion=Inv:Inv.Estatus=EstatusConcluido

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

ConCondicion=S
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Asigna(Info.Fecha, Inv:Inv.FechaEmision)<BR>Asigna(Info.Estatus, Inv:Inv.Estatus)
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
Expresion=Asigna(Info.ID, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.AlmD, Inv:Inv.Almacen)<BR>Asigna(Info.AlmA, Inv:Inv.AlmacenDestino)<BR>Si <BR>  Si<BR>    Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)<BR>  Entonces<BR>    Forma(<T>InvTransitosPendientes<T>)<BR>  Sino<BR>    Asigna(Info.Mov, Inv:Inv.Origen) <BR>    Asigna(Info.MovID, Inv:Inv.OrigenID)<BR>    Verdadero<BR>  Fin<BR>Entonces<BR>  Asigna(Info.Modulo, <T>INV<T>)<BR>  Asigna(Info.ID, Inv:Inv.ID)<BR>  Asigna(Info.Cuenta, Nulo)<BR>  Asigna(Info.Fecha, Inv:Inv.FechaEmision)<BR>  Asigna(Afectar.ID, Nulo)<BR>  Asigna(Afectar.ID, SQL(<T>SELECT ID FROM Inv WHERE Empresa=:tEmpresa AND Mov=:tMov AND MovID=:tMovID AND Estatus=:tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>  Forma(<T>MovRecibo<T>)<BR>Fin
AntesExpresiones=Asigna(Info.PuedeEditar, Inv:Inv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))
VisibleCondicion=MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.EI))

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
ActivoCondicion=((MovTipo(<T>INV<T>, Inv:Inv.Mov) noen (INV.OT, INV.OI, INV.SOL)) y (Inv:Inv.Estatus=EstatusSinAfectar)) o<BR>((Inv:Inv.Estatus=EstatusPendiente) y (MovTipo(<T>INV<T>, Inv:Inv.Mov) en (INV.OT, INV.OI, INV.SOL)) y (no FormaBloqueada))
EjecucionCondicion=MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.OT, INV.OI, INV.SOL)) o MovTipoEn(<T>INV<T>, InvD:InvD.Aplica, (INV.OT, INV.OI, INV.SOL))
AntesExpresiones=Si<BR>  MovTipo(<T>INV<T>, Inv:Inv.Mov) en (INV.OT, INV.OI, INV.SOL)<BR>Entonces<BR>  Asigna(Info.Mov, Inv:Inv.Mov)<BR>  Asigna(Info.MovID, Inv:Inv.MovID)<BR>  Asigna(Info.ID, Inv:Inv.ID)<BR>Sino<BR>  Asigna(Info.Mov, InvD:InvD.Aplica)<BR>  Asigna(Info.MovID, InvD:InvD.AplicaID)<BR>  Asigna(Info.ID, SQL(<T>SELECT ID FROM Inv WHERE Empresa=:tEmpresa AND Mov=:tMov AND MovID=:tMovID AND Estatus=:tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>Fin
VisibleCondicion=Usuario.ModificarAlmacenPedidos y MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.OT, INV.OI, INV.SOL))

[Acciones.SugerirArtAlm]
Nombre=SugerirArtAlm
Boton=0
Menu=&Archivo
NombreDesplegar=Sugerir Artículos del Almacén
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>xpInvSugerirArtAlm :nID, :tEmp, :nSuc, :tAlm, :tRef<T>, Inv:Inv.ID, Empresa, Sucursal, Inv:Inv.Almacen, Inv:Inv.Referencia)
ActivoCondicion=Inv:Inv.Estatus=EstatusSinAfectar
VisibleCondicion=MovTipo(<T>INV<T>, Inv:Inv.Mov) = INV.IF

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
EjecucionCondicion=ConDatos(Inv:Inv.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>INV<T>)<BR>Asigna(Info.Clave, Inv:Inv.Mov)

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
EjecucionCondicion=ConDatos(Inv:Inv.Concepto)
AntesExpresiones=Asigna(Info.Concepto, <T>INV<T>)<BR>Asigna(Info.Concepto, Inv:Inv.Concepto)

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
ActivoCondicion=((MovTipo(<T>INV<T>, Inv:Inv.Mov) noen (INV.OT, INV.OI, INV.SOL)) y (Inv:Inv.Estatus=EstatusSinAfectar)) o<BR>((Inv:Inv.Estatus=EstatusPendiente) y (MovTipo(<T>INV<T>, Inv:Inv.Mov) en (INV.OT, INV.OI, INV.SOL)) y (no FormaBloqueada))
EjecucionCondicion=MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.OT, INV.OI, INV.SOL))
AntesExpresiones=Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Asigna(Info.ID, Inv:Inv.ID)
VisibleCondicion=Config.InvMultiAlmacen y<BR>Usuario.ModificarAlmacenPedidos y MovTipoEn(<T>INV<T>, Inv:Inv.Mov, (INV.OT, INV.OI, INV.SOL))

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
EjecucionCondicion=ConDatos(InvD:InvD.Articulo)
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Articulo, InvD:InvD.Articulo)<BR>Asigna(Info.Almacen, InvD:InvD.Almacen)<BR>Asigna(Info.Unidad, InvD:InvD.Unidad)<BR>Asigna(Info.Cantidad, Vacio(InvD:InvD.CantidadPendiente, InvD:InvD.Cantidad))
VisibleCondicion=Usuario.CambioPresentacionExpress

[Acciones.Observaciones]
Nombre=Observaciones
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Expresion
Expresion=Si(Inv:Inv.Estatus en (EstatusConcluido, EstatusCancelado), Informacion(InvD:InvD.DescripcionExtra), Pregunta(InvD:InvD.DescripcionExtra))
Activo=S
Visible=S

[Ficha.Inv.Agente]
Carpeta=Ficha
Clave=Inv.Agente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
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
Expresion=Asigna(Info.Forma, <T>Inv<T>)<BR>Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.Nombre, Inv:Inv.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

[Detalle.InvD.Posicion]
Carpeta=Detalle
Clave=InvD.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.InvD.DescripcionExtra]
Carpeta=Detalle
Clave=InvD.DescripcionExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>INV<T>, Inv:Inv.Mov, Inv:Inv.ID, Falso, Inv:Inv.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>INV<T>+Inv:Inv.ID)<BR>  Asigna(Info.Nombre, Inv:Inv.Mov+<T> <T>+Inv:Inv.MovID)<BR>  Asigna(Info.Modulo, <T>INV<T>)<BR>  Asigna(Info.Mov, Inv:Inv.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Acciones.ImportarPDT]
Nombre=ImportarPDT
Boton=0
Menu=&Archivo
NombreDesplegar=Importar &PDT...
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=PlugIn(<T>PDT<T>, <T>INV<T>, Inv:Inv.ID)
ActivoCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.GastosIndirectos]
Nombre=GastosIndirectos
Boton=0
Menu=&Edición
NombreDesplegar=Gastos Indirectos...
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Si <BR>  Inv:Inv.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)<BR>Entonces<BR>  Forma(<T>MovGastoIndirecto<T>)<BR>Sino<BR>  Forma(<T>MovGastoIndirectoInfo<T>)<BR>Fin
ActivoCondicion=MovTipo(<T>INV<T>, Inv:Inv.Mov) = INV.EP
VisibleCondicion=MovTipo(<T>INV<T>, Inv:Inv.Mov) = INV.EP

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
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Ficha.Inv.Actividad]
Carpeta=Ficha
Clave=Inv.Actividad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
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
HojaFondoGris=S
HojaSinBorde=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>INV<T>, <T>{Inv:Inv.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>INV{Inv:Inv.ID}<T>
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

[Detalle.InvD.Tarima]
Carpeta=Detalle
Clave=InvD.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Entarimar]
Nombre=Entarimar
Boton=11
Menu=&Edición
NombreDesplegar=&Entarimar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
EnBarraHerramientas=S
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+T
Expresion=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Si<BR>  Forma(<T>Entarimar<T>)<BR>Entonces<BR>  Forma.ActualizarVista(<T>Detalle<T>)<BR>  Si<BR>    MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.TMA<BR>  Entonces<BR>    Forma.ActualizarArbol(<T>Tarimas<T>)<BR>    Forma.ActualizarVista(<T>Tarimas<T>)<BR>  Fin<BR>Fin
ActivoCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
VisibleCondicion=General.WMS

[Tarimas]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Tarimas
Clave=Tarimas
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvTMA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=(Lista)
Detalle=S
VistaMaestra=Inv
LlaveLocal=InvD.ID
LlaveMaestra=Inv.ID
FiltroPredefinido1=por Renglon<BR>por Articulo<BR>por Tarima
FiltroGrupo1=InvD.Tarima
FiltroAplicaEn=InvD.Tarima
FiltroValida1=InvD.Tarima
FiltroTodoFinal=S
FiltroPredefinido2=InvD.Seccion=1<BR>InvD.Seccion=1<BR>InvD.Seccion=1
FiltroPredefinido3=InvD.Renglon, InvD.RenglonSub<BR>InvD.Articulo, InvD.SubCuenta<BR>InvD.Tarima, InvD.Articulo, InvD.SubCuenta
IconosNombre=InvTMA:InvD.Articulo
FiltroGeneral=InvD.Seccion=1
CondicionVisible=MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.TMA

[Tarimas.Art.Descripcion1]
Carpeta=Tarimas
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Tarimas.InvD.Cantidad]
Carpeta=Tarimas
Clave=InvD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Tarimas.InvD.Unidad]
Carpeta=Tarimas
Clave=InvD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Tarimas.InvD.Tarima]
Carpeta=Tarimas
Clave=InvD.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Tarimas.Columnas]
0=125
1=229
2=-2
3=-2
4=-2

[Acciones.TarimasVista]
Nombre=TarimasVista
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=Tarimas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.TarimasSeriesLotes]
Nombre=TarimasSeriesLotes
Boton=0
NombreDesplegar=&Series/Lotes del Artículo
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
EspacioPrevio=S
Expresion=Si<BR>  InvTMA:Art.Tipo=TipoVIN<BR>Entonces<BR>  Forma(<T>VINMovMultipleInfo<T>)<BR>Sino<BR>  Asigna(Info.SumaSerieLote, Nulo)<BR>  Asigna(Info.Articulo, InvTMA:InvD.Articulo)<BR>  Forma(<T>SerieLoteMovInfo<T>)<BR>Fin
EjecucionCondicion=InvTMA:Art.Tipo en (TipoSerie, TipoVIN, TipoLote) o<BR>((InvTMA:Art.Tipo=TipoPartida) y ConDatos(InvTMA:InvD.SubCuenta))
AntesExpresiones=Asigna(Info.Articulo, InvTMA:InvD.Articulo)<BR>Asigna(Info.Almacen, Si(Config.InvMultiAlmacen y (MovTipo(<T>INV<T>, Inv:Inv.Mov) noen (INV.IF, INV.EI, INV.P, INV.R)), InvTMA:InvD.Almacen, Si(MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.EI, Inv:Inv.AlmacenDestino, Inv:Inv.Almacen)))<BR>Asigna(Info.AlmTipo, Inv:Alm.Tipo)<BR>Asigna(Info.Modulo, <T>INV<T>) <BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.RenglonID, InvTMA:InvD.RenglonID)<BR>Asigna(Info.Cantidad, ABS(InvTMA:InvD.Cantidad) * UnidadFactor(InvTMA:InvD.Unidad, InvTMA:InvD.Articulo))<BR>Asigna(Info.Paquete, InvTMA:InvD.Paquete)<BR>Asigna(Info.MovTipo, MovTipo(<T>INV<T>, Inv:Inv.Mov))<BR>Asigna(Info.ArtTipo, InvTMA:Art.Tipo)<BR>Asigna(Info.EsEntrada, MovTipoEn(<T>INV<T>,Inv:Inv.Mov, (INV.E,INV.EP,INV.EI,INV.R)) o ((MovTipo(<T>INV<T>, Inv:Inv.Mov)=INV.A) y (InvTMA:InvD.Cantidad>0)))<BR>Asigna(Info.Unidad, InvTMA:InvD.Unidad)<BR>Asigna(Info.Estatus, Inv:Inv.Estatus)<BR>Si((Info.ArtTipo=TipoPartida) o (InvTMA:Art.TipoOpcion<>TipoNo), Asigna(Info.SubCuenta, InvTMA:InvD.SubCuenta), Asigna(Info.SubCuenta, <T><T>))<BR>Asigna(Info.Tarima, InvTMA:InvD.Tarima)


[Detalle.ListaOrden]
(Inicio)=InvD.Renglon<TAB>(Acendente)
InvD.Renglon<TAB>(Acendente)=InvD.RenglonSub<TAB>(Acendente)
InvD.RenglonSub<TAB>(Acendente)=(Fin)


[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)

[Tarimas.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=InvD.Cantidad
InvD.Cantidad=InvD.Unidad
InvD.Unidad=InvD.Tarima
InvD.Tarima=(Fin)

[Tarimas.ListaAcciones]
(Inicio)=TarimasVista
TarimasVista=TarimasSeriesLotes
TarimasSeriesLotes=(Fin)

[Detalle.InvD.FechaCaducidad]
Carpeta=Detalle
Clave=InvD.FechaCaducidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Extraccion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pedimento Extracción
Clave=Extraccion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Inv
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
ListaEnCaptura=Inv.PedimentoExtraccion
CondicionVisible=SQL(<T>SELECT SubClave FROM MovTipo WHERE Modulo = :tModulo AND Mov = :tMov<T>, <T>INV<T>, Inv:Inv.Mov) = <T>INV.EXT<T>

[Extraccion.Inv.PedimentoExtraccion]
Carpeta=Extraccion
Clave=Inv.PedimentoExtraccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.SurtirTarima]
Nombre=SurtirTarima
Boton=0
Menu=&Edición
NombreDesplegar=&Surtir por Tarima
EnMenu=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+S
GuardarAntes=S
Expresion=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Mov, Inv:Inv.Mov)<BR>Asigna(Info.MovID, Inv:Inv.MovID)<BR>Asigna(Info.Almacen, Inv:Inv.Almacen)<BR>Si<BR>  Forma(<T>SurtirTarima<T>)<BR>Entonces<BR>  Forma.ActualizarVista(<T>Detalle<T>) <BR>Fin
ActivoCondicion=Inv:Inv.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
VisibleCondicion=General.WMS

[Lista.Columnas]
Almacen=64
Posicion=64
Tarima=124
Articulo=124
Descripcion1=184
Cantidad=65
Nombre=229
Grupo=100
Sucursal=46
0=125
1=129
2=-2
3=-2

4=-2



Tipo=106
ArticuloEsp=73
Pasillo=45
Nivel=37
Zona=64
Descripcion=130
Estatus=54
SerieLote=162
Existencia=64
Fecha1=97
Descrpcion=181
SubCuenta=76
Unidad=63
PosicionDestino=96
CantidadA=99
Propiedades=127
CantidadAlterna=59
5=-2
6=-2
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




[Ficha.Inv.Motivo]
Carpeta=Ficha
Clave=Inv.Motivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[Ficha.Inv.ReferenciaMES]
Carpeta=Ficha
Clave=Inv.ReferenciaMES
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=26
ColorFondo=Blanco

[Ficha.Inv.PedidoMES]
Carpeta=Ficha
Clave=Inv.PedidoMES
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[Ficha.Inv.PosicionWMS]
Carpeta=Ficha
Clave=Inv.PosicionWMS
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=
ColorFondo=Blanco


































Pegado=N
OcultaNombre=N
[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Total
Total=Conteo
Conteo=(Fin)













[Acciones.Etiquetas]
Nombre=Etiquetas
Boton=42
NombreEnBoton=S
NombreDesplegar=Etiquetas
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=EtiquetaEntarimado
Antes=S
ActivoCondicion=Inv:Inv.Estatus=<T>CONCLUIDO<T>
AntesExpresiones=Asigna(Info.ID, Inv:Inv.ID)
VisibleCondicion=MovTipo( <T>INV<T>, Inv:Inv.Mov ) = <T>INV.TMA<T>


























































































[Ficha.Inv.PosicionDWMS]
Carpeta=Ficha
Clave=Inv.PosicionDWMS
Editar=S
ValidaNombre=N
3D=S
Pegado=N
Tamano=
ColorFondo=Blanco

































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Inv.Almacen
Inv.Almacen=Inv.AlmacenDestino
Inv.AlmacenDestino=Inv.FechaEmision
Inv.FechaEmision=Inv.Referencia
Inv.Referencia=Inv.Concepto
Inv.Concepto=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=PENDIENTE
PENDIENTE=FUERALINEA
FUERALINEA=SINCRO
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










































[Detalle.InvD.PosicionDestino]
Carpeta=Detalle
Clave=InvD.PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



















































[Detalle.InvD.PosicionActual]
Carpeta=Detalle
Clave=InvD.PosicionActual
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.InvD.PosicionReal]
Carpeta=Detalle
Clave=InvD.PosicionReal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

















[Acciones.AsigUbi]
Nombre=AsigUbi
Boton=0
NombreDesplegar=Asignar Ubicación
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S








GuardarAntes=S
Expresion=Asigna(Temp.Texto, InvD:InvD.Articulo)<BR>Asigna(Info.Almacen,Inv:Inv.Almacen)<BR>Asigna(Info.Renglon,InvD:InvD.Renglon)<BR>Asigna(Info.ID,Inv:Inv.ID)<BR>Asigna(Info.Estatus,Inv:Inv.Estatus)<BR>EjecutarSQL(<T>spAsignarUbicaciones :nID, :tAlmacen, :tArticulo, :nRenglon, :tEmpresa<T>,Inv:Inv.ID, Inv:Inv.Almacen,InvD:InvD.Articulo,InvD:InvD.Renglon,Empresa)<BR>Forma(<T>InvArtUbicacion<T>)














[Detalle.ResumenCampos]
(Inicio)=Articulo
Articulo=Descripcion1
Descripcion1=Cantidad
Cantidad=Pendiente
Pendiente=Costo
Costo=Importe
Importe=Almacen
Almacen=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=InvD.ProdSerieLote
InvD.ProdSerieLote=InvD.Producto
InvD.Producto=InvD.SubProducto
InvD.SubProducto=InvD.Aplica
InvD.Aplica=InvD.AplicaID
InvD.AplicaID=AplicaNombre
AplicaNombre=InvD.Destino
InvD.Destino=InvD.DestinoID
InvD.DestinoID=DestinoNombre
DestinoNombre=InvD.Codigo
InvD.Codigo=InvD.Articulo
InvD.Articulo=InvD.SubCuenta
InvD.SubCuenta=InvD.Tarima
InvD.Tarima=InvD.PosicionActual
InvD.PosicionActual=InvD.PosicionReal
InvD.PosicionReal=ClaveIdioma
ClaveIdioma=InvD.ArticuloDestino
InvD.ArticuloDestino=InvD.SubCuentaDestino
InvD.SubCuentaDestino=InvD.Cantidad
InvD.Cantidad=CantidadNeta
CantidadNeta=InvD.SegundoConteo
InvD.SegundoConteo=UltimoConteo
UltimoConteo=InvD.Merma
InvD.Merma=InvD.Desperdicio
InvD.Desperdicio=InvD.Unidad
InvD.Unidad=InvD.CantidadInventario
InvD.CantidadInventario=CantidadInvNeta
CantidadInvNeta=InvD.Precio
InvD.Precio=InvD.Tipo
InvD.Tipo=InvD.FechaRequerida
InvD.FechaRequerida=InvD.Cliente
InvD.Cliente=InvD.Paquete
InvD.Paquete=InvD.CantidadReservada
InvD.CantidadReservada=InvD.CantidadOrdenada
InvD.CantidadOrdenada=InvD.CantidadPendiente
InvD.CantidadPendiente=InvD.Costo
InvD.Costo=InvD.CostoInv
InvD.CostoInv=Importe
Importe=InvD.FechaCaducidad
InvD.FechaCaducidad=InvD.Almacen
InvD.Almacen=InvD.Posicion
InvD.Posicion=InvD.PosicionDestino
InvD.PosicionDestino=InvD.ContUso
InvD.ContUso=InvD.Espacio
InvD.Espacio=InvD.DescripcionExtra
InvD.DescripcionExtra=Espacio.NumeroEconomico
Espacio.NumeroEconomico=InvD.CantidadA
InvD.CantidadA=(Fin)

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
VerOpcion=AsigUbi
AsigUbi=(Fin)






























































[Ficha.Inv.CrossDocking]
Carpeta=Ficha
Clave=Inv.CrossDocking
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









































































































































































Pegado=N















[Ficha.ListaEnCaptura]
(Inicio)=Inv.Mov
Inv.Mov=Inv.MovID
Inv.MovID=Inv.Proyecto
Inv.Proyecto=Inv.UEN
Inv.UEN=Inv.Moneda
Inv.Moneda=Inv.TipoCambio
Inv.TipoCambio=ConteoNombre
ConteoNombre=Inv.FechaEmision
Inv.FechaEmision=Inv.Actividad
Inv.Actividad=Inv.FechaOrigen
Inv.FechaOrigen=Inv.FechaRequerida
Inv.FechaRequerida=Inv.Almacen
Inv.Almacen=Inv.AlmacenDestino
Inv.AlmacenDestino=Inv.PosicionWMS
Inv.PosicionWMS=Inv.PosicionDWMS
Inv.PosicionDWMS=Inv.CrossDocking
Inv.CrossDocking=Inv.Personal
Inv.Personal=Inv.Concepto
Inv.Concepto=Inv.FormaEnvio
Inv.FormaEnvio=Inv.Largo
Inv.Largo=Inv.AlmacenTransito
Inv.AlmacenTransito=Inv.Referencia
Inv.Referencia=Inv.Condicion
Inv.Condicion=Inv.Vencimiento
Inv.Vencimiento=Inv.VerDestino
Inv.VerDestino=Inv.Observaciones
Inv.Observaciones=Inv.Agente
Inv.Agente=Inv.Motivo
Inv.Motivo=Inv.VerLote
Inv.VerLote=Inv.ReferenciaMES
Inv.ReferenciaMES=Inv.PedidoMES
Inv.PedidoMES=Inv.Directo
Inv.Directo=(Fin)

















































































































































































































































































































































































































































[Acciones.RepPendientesSurtido.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.ID, Inv:Inv.ID)<BR>Asigna(Info.Modulo, <T>INV<T>)
Activo=S
Visible=S

[Acciones.RepPendientesSurtido.Variables]
Nombre=Variables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RepPendientesSurtido.Reporte]
Nombre=Reporte
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=RepPendientesSurtido
Activo=S
Visible=S

[Acciones.RepPendientesSurtido]
Nombre=RepPendientesSurtido
Boton=108
NombreDesplegar=&Pendiente de Surtido
Multiple=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Menu=&Edición





















ActivoCondicion=Inv:Inv.Estatus<><T>SINAFECTAR<T>
VisibleCondicion=SQL(<T>EXEC spRepMovPendientesSurtidoExiste :tModulo, :tMov<T>, <T>INV<T>, Inv:Inv.Mov)=1



[Acciones.RepPendientesSurtido.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Variables
Variables=Reporte
Reporte=(Fin)




































































































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalle
Detalle=Tarimas
Tarimas=FormaExtraValor
FormaExtraValor=Extraccion
Extraccion=(Fin)

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
Situacion=WizardSituaciones
WizardSituaciones=Sucursal
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
Asistente Codigo Barras (Lote)=Entarimar
Entarimar=SurtirTarima
SurtirTarima=SeriesLotes
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
ProdSerieLoteInfo=RepPendientesSurtido
RepPendientesSurtido=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
MovPos=Etiquetas
Etiquetas=Navegador
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
