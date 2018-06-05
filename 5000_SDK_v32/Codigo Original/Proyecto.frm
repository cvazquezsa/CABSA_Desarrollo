[Forma]
Clave=Proyecto
Nombre=<T>Proyecto<T>
Icono=0
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=178
PosicionInicialArriba=0
PosicionInicialAltura=581
PosicionInicialAncho=1057
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
MovModulo=PROY
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
PosicionColumna2=77
PosicionInicialAlturaCliente=641
PosicionSec1=253
PosicionSec2=440
PosicionCol2=818
PosicionCol3=426

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.MovID, Nulo)<BR>Asigna(Info.Importe, 0.0)<BR>Asigna(Info.EsNuevo, Falso)<BR>Asigna(Info.ProyectoActividad, Nulo)<BR>Asigna(Info.ProyectoEstado, Nulo)<BR>Asigna(Info.ProyectoRecurso, Nulo)<BR>Asigna(Info.ProyectoAvanceD, Nulo)   <BR>Asigna(Info.ProyectoAvanceA, Nulo)<BR>Asigna(Info.ProyectoFechaInicioD, Nulo)<BR>Asigna(Info.ProyectoFechaInicioA, Nulo)<BR>Asigna(Info.ProyectoFechaConclusionD, Nulo)<BR>Asigna(Info.ProyectoFechaConclusionA, Nulo)
ExpresionesAlCerrar=Asigna(Info.EsNuevo, Falso)<BR>Asigna(Info.ProyectoActividad, Nulo)<BR>Asigna(Info.ProyectoEstado, Nulo)<BR>Asigna(Info.ProyectoRecurso, Nulo)<BR>Asigna(Info.ProyectoAvanceD, Nulo)<BR>Asigna(Info.ProyectoAvanceA, Nulo)<BR>Asigna(Info.ProyectoFechaInicioD, Nulo)<BR>Asigna(Info.ProyectoFechaInicioA, Nulo)<BR>Asigna(Info.ProyectoFechaConclusionD, Nulo)<BR>Asigna(Info.ProyectoFechaConclusionA, Nulo)
PosicionCol1=309
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proyecto
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

[Ficha.Proyecto.Mov]
Carpeta=Ficha
Clave=Proyecto.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ficha.Proyecto.MovID]
Carpeta=Ficha
Clave=Proyecto.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=11
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.Proyecto.FechaEmision]
Carpeta=Ficha
Clave=Proyecto.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=N
IgnoraFlujo=N
ColorFondo=Blanco
Pegado=N

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=ProyectoA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=IndicadorIcono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosConPaginas=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Proyecto.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Proyecto.FechaEmision
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
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroUsuarios=S
FiltroMovs=S
FiltroFechasCancelacion=Proyecto.FechaCancelacion
FiltroSucursales=S

IconosNombre=ProyectoA:Proyecto.Mov+<T> <T>+ProyectoA:Proyecto.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=205
1=76

2=156
3=-2
4=73
5=113
6=-2
7=-2
8=-2
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

EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Proyecto:Proyecto.ID) y (Proyecto:Proyecto.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Proyecto:Proyecto.ID, <T>PROY<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>Verdadero
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
Importe=105
Aplica=96
AplicaID=70
AplicaProntoPago=96
Personal=125
Cantidad=48
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
Concepto=134
Categoria=118
Departamento=122
Puesto=108
Grupo=101
Motivo=153
Calificacion=60
Articulo=84
Actual=99
Anterior=86
Nuevo=91
Diferencia=91
%Diferencia=64
DiferenciaPorcentaje=56
Proyecto=218
Serie=176
Tipo=86
Precio=64
FechaEmision=94
Asunto=159
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
0=155
1=69
Actividad=53
Predecesora=65
DuracionUnidad=39
DuracionDias=50
Comienzo=82
Fin=79
Avance=43
Familia=154
EsFase=29
EstaLiberado=45
EsNuevo=64
Clave=59
Indicador=64
IndicadorNombre=49
RecursosAsignados=174

ClaveIdioma=74
CantidadNeta=49
PesoTotal=50
VolumenTotal=54
Unidad=39
DescuentoLinea=32
Impuesto1=64
SubImpuesto1=74
Impuesto2=42
SubImpuesto2=72
Retencion1=86
SubRetencion1=72
Retencion2=86
SubRetencion2=72
ContUso=73
DescripcionExtra=117
CantidadInventario=54
Costo=75
Impuesto3=64
SubImpuesto3=78
Retencion3=75
FechaRequerida=87
PorcentajeDeducible=68
Impuestos=67
Total=77
2=76
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=51
10=138
11=-2
12=82
13=-2
14=-2
Fecha=66
Lectura=42
LecturaAnterior=82
Consumo=50
Codigo=99
CantidadInvNeta=53
CostoInv=86
GastosPct=51
Ejercido=78
Pendiente=74
Disponible=74
Almacen=69
DescuentoImporte=54
SubCuenta=80
PorcentajeUtilidad=108
Esfuerzo=64
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
Totalizadores2=Conteo(ProyectoD:ProyectoD.Actividad)
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

Expresion=Asigna(Afectar.Modulo, <T>PROY<T>)<BR>Asigna(Afectar.ID, Proyecto:Proyecto.ID)<BR>Asigna(Afectar.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Afectar.MovID, Proyecto:Proyecto.MovID)<BR>Asigna(Afectar.GenerarMov, Nulo)<BR>Asigna(Afectar.FormaCaptura, <T>Proyecto<T>)<BR>Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Info.MovGenerar, Nulo)<BR>Asigna(Info.Estatus, SQL(<T>SELECT Estatus FROM Proyecto WHERE ID=:nID<T>, Proyecto:Proyecto.ID))<BR>Asigna(Info.MovTipo, MovTipo(<T>PROY<T>, Proyecto:Proyecto.Mov))<BR>Si<BR> Info.Estatus=EstatusPendiente<BR>Entonces<BR>    Si<BR>        Info.MovTipo = <T>PROY.PR<T><BR>    Entonces<BR>        Asigna(Info.MovGenerar, <T>Proyecto Servicio<T>)<BR>        Dialogo(<T>GenerarPlanFormal<T>)<BR>    Sino<BR>        Si ((Info.MovTipo = <T>PROY.P<T>) y (Info.Mov = <T>Proyecto Servicio<T>)) Entonces<BR>            Dialogo(<T>GenerarProyectoServicio<T>)<BR>        Sino<BR>            Si<BR>                Precaucion(<T>¿ Esta Seguro que Desea Reestructurar el Movimiento <T>+Afectar.Mov+<T> <T>+Afectar.MovID+<T> ?<T>, BotonSi, BotonNo)=BotonSi<BR>            Entonces<BR>                Generar(<T>PROY<T>, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.Mov, Afectar.FormaCaptura)<BR>            Fin<BR>        Fin<BR>    Fin<BR>Sino<BR>    Si<BR>        Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces                                                                                                 <BR>        ProyectoRecalcular(Proyecto:Proyecto.ID)<BR>        Afectar(<T>PROY<T>, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>        Si (Info.Mov = <T>Proyecto Servicio<T>) o ((Info.Mov = <T>Proyecto Servicio<T>) y ConDatos(Proyecto:Proyecto.ProyectoReestructurar)) Entonces<BR>            EjecutarSQL(<T>EXEC spProyArrastraServicios :nIDAnterior, :tEmpresa, :nSucursal, :nIDNuevo, :tUsuario, :nEstacion<T>,Info.ID, Empresa, Sucursal, Afectar.ID, Usuario, EstacionTrabajo)<BR>        Fin<BR>        Si (Info.Mov = <T>Plan Preliminar<T>) y ConDatos(Proyecto:Proyecto.ProyectoReestructurar) Entonces<BR>            EjecutarSQL(<T>EXEC spProyArrastraServicios :nIDAnterior, :tEmpresa, :nSucursal, :nIDNuevo, :tUsuario, :nEstacion<T>,Info.ID, Empresa, Sucursal, Afectar.ID, Usuario, EstacionTrabajo)<BR>        Fin<BR>    Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Proyecto:Proyecto.Usuario) y<BR>(Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>PROY<T>, Proyecto:Proyecto.Mov, Proyecto:Proyecto.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Proyecto:Proyecto.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>PROY<T>, Proyecto:Proyecto.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>PROY<T>, Proyecto:Proyecto.Mov, Proyecto:Proyecto.ID, Verdadero, Proyecto:Proyecto.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=(Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Proyecto:Proyecto.Usuario)

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Proyecto:Proyecto.ID
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>PROY<T>, Proyecto:Proyecto.Mov, Proyecto:Proyecto.Estatus), Proyecto:Proyecto.ID)
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
ListaParametros1=Proyecto:Proyecto.ID
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>PROY<T>, Proyecto:Proyecto.Mov, Proyecto:Proyecto.Estatus), Proyecto:Proyecto.ID)
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

Expresion=Asigna(Info.Dato, SQL(<T>SELECT Top 1 AnteriorOID FROM ARRASTREPROY WHERE OID = :nID AND OMOV = :tMov AND OMovID = :tMovID<T>,Proyecto:Proyecto.ID,Proyecto:Proyecto.Mov,Proyecto:Proyecto.MovID))<BR>Si ConDatos(Info.Dato) Entonces<BR>    EjecutarSQL(<T>EXEC spProyArrastraServicios :nOID, :tEmpresa, :nSucursal, :nDID, :tUsuario, :nEstacion<T>, Proyecto:Proyecto.ID, Empresa, Sucursal, Info.Dato, Usuario, EstacionTrabajo)<BR>Fin<BR>Cancelar(<T>PROY<T>, Proyecto:Proyecto.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>PROY<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Proyecto:Proyecto.Usuario) y ConDatos(Proyecto:Proyecto.ID) y ConDatos(Proyecto:Proyecto.MovID) y<BR>(Proyecto:Proyecto.Estatus en (EstatusSincro, EstatusPendiente, EstatusVigente))
ConCondicion=S
EjecucionCondicion=Si<BR>   Proyecto:Proyecto.Mov = <T>Plan Preliminar<T><BR>Entonces<BR>  Si<BR>    SQL(<T>SELECT COUNT(*) FROM ProyResultado WHERE Empresa=:tEmpresa AND Proyecto=:tProyecto<T>, Empresa, Proyecto:Proyecto.Proyecto)>0<BR>  Entonces<BR>     Error(<T>Tiene movimientos generados, no es posible cancelar el Movimiento<T>)<BR>     AbortarOperacion<BR>  Fin<BR>Fin
AntesExpresiones=Asigna( Afectar.Mov, Proyecto:Proyecto.Mov ) <BR>Asigna( Afectar.MovID, Proyecto:Proyecto.MovID )
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
Expresion=Verificar(<T>PROY<T>, Proyecto:Proyecto.ID,Proyecto:Proyecto.Mov,Proyecto:Proyecto.MovID)
ActivoCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(Proyecto:Proyecto.Mov)

[Aplica.Proyecto.MovAplica]
Carpeta=Aplica
Clave=Proyecto.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.Proyecto.MovAplicaID]
Carpeta=Aplica
Clave=Proyecto.MovAplicaID
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
ActivoCondicion=ConDatos(Proyecto:Proyecto.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Info.MovID, Proyecto:Proyecto.MovID)
[Aplica.Proyecto.Proveedor]
Carpeta=Aplica
Clave=Proyecto.Proveedor
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
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>PROY<T>, Proyecto:Proyecto.Mov, Proyecto:Proyecto.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>PROY<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>PROY<T>, Proyecto:Proyecto.Mov, Proyecto:Proyecto.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Proyecto:Proyecto.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Info.Estatus, Proyecto:Proyecto.Estatus)<BR>Asigna(Info.Situacion, Proyecto:Proyecto.Situacion)
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
ActivoCondicion=ConfigModulo(<T>PROY<T>,<T>Tiempos<T>)=<T>Si<T>
EjecucionCondicion=ConDatos(Proyecto:Proyecto.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Info.MovID, Proyecto:Proyecto.MovID)

[(Carpeta Abrir).Proyecto.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Proyecto.FechaEmision
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
ActivoCondicion=ConDatos(ProyectoA:Proyecto.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.ID, ProyectoA:Proyecto.ID)
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
AntesExpresiones=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Usuario, Proyecto:Proyecto.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Proyecto:Proyecto.ID)

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
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Rama, <T>PROY<T>)<BR>Asigna(Info.Fecha, Proyecto:Proyecto.FechaEmision)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Proyecto:Proyecto.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Proyecto:Proyecto.Mov+<T> <T>+Proyecto:Proyecto.MovID)
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
ActivoCondicion=ConDatos(Proyecto:Proyecto.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)

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
Expresion=CopiarMovimiento(<T>PROY<T>, Proyecto:Proyecto.ID, <T>Proyecto<T>)

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Proyecto:Proyecto.Estatus=EstatusSinAfectar) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Proyecto:Proyecto.ID),GuardarCambios)
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

[Ficha.Proyecto.UEN]
Carpeta=Ficha
Clave=Proyecto.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco
ValidaNombre=S

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
Expresion=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Info.Clave, <T>PROY<T>+Proyecto:Proyecto.ID)<BR>Asigna(Info.Nombre, Proyecto:Proyecto.Mov+<T> <T>+Proyecto:Proyecto.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Proyecto:Proyecto.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

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
AntesExpresiones=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Info.MovID, Proyecto:Proyecto.MovID)<BR>Asigna(Info.Fecha, Proyecto:Proyecto.FechaEmision)<BR>Asigna(Info.Estatus, Proyecto:Proyecto.Estatus)

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
EjecucionCondicion=ConDatos(Proyecto:Proyecto.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>PROY<T>)<BR>Asigna(Info.Clave, Proyecto:Proyecto.Mov)

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
EjecucionCondicion=ConDatos(Proyecto:Proyecto.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.Concepto, Proyecto:Proyecto.Concepto)

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>PROY<T>)<BR>Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Info.Nombre, Proyecto:Proyecto.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=0
Menu=&Edición
NombreDesplegar=General.CamposExtras+<T>...<T>
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+1

GuardarAntes=S
RefrescarDespues=S
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>PROY<T>, Proyecto:Proyecto.Mov, Proyecto:Proyecto.ID, Falso, Proyecto:Proyecto.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>PROY<T>+Proyecto:Proyecto.ID)<BR>  Asigna(Info.Nombre, Proyecto:Proyecto.Mov+<T> <T>+Proyecto:Proyecto.MovID)<BR>  Asigna(Info.Modulo, <T>PROY<T>)<BR>  Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>  Asigna(Info.Categoria, Nulo)                     <BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR><BR>  Si ConDatos(Temp.Reg) Entonces<BR>      Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>      Si ConDatos(Info.FormaTipo)<BR>      Entonces<BR>        Si Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>        Entonces<BR>          iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>        Sino<BR>          iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>        Fin<BR>      Fin<BR>  Sino<BR>      Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>  Asigna(Info.Aplica, Nulo)<BR>Fin
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
AntesExpresiones=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Info.MovID, Proyecto:Proyecto.MovID)

[Observaciones.ProyectoD.Observaciones]
Carpeta=Observaciones
Clave=ProyectoD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20x10
ColorFondo=Blanco
ColorFuente=Negro

[Observaciones.Columnas]
Observaciones=604

[Acuerdos.ProyectoAcuerdo.Asunto]
Carpeta=Acuerdos
Clave=ProyectoAcuerdo.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acuerdos.ProyectoAcuerdo.Tipo]
Carpeta=Acuerdos
Clave=ProyectoAcuerdo.Tipo
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
Vista=Proyecto
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
ListaEnCaptura=(Lista)
CondicionVisible=Proyecto:Proyecto.ContactoTipo=<T>Cliente<T>

[Cliente.Proyecto.Cliente]
Carpeta=Cliente
Clave=Proyecto.Cliente
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

[Acciones.Info]
Nombre=Info
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S

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
Vista=Proyecto
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
ListaEnCaptura=(Lista)
CondicionVisible=Proyecto:Proyecto.ContactoTipo=<T>Proveedor<T>

[Proveedor.Proyecto.Proveedor]
Carpeta=Proveedor
Clave=Proyecto.Proveedor
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
Vista=Proyecto
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
ListaEnCaptura=(Lista)
CondicionVisible=Proyecto:Proyecto.ContactoTipo=<T>Personal<T>

[Personal.Proyecto.Personal]
Carpeta=Personal
Clave=Proyecto.Personal
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
Vista=Proyecto
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
ListaEnCaptura=(Lista)
CondicionVisible=Proyecto:Proyecto.ContactoTipo=<T>Agente<T>

[Agente.Proyecto.Agente]
Carpeta=Agente
Clave=Proyecto.Agente
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

[Proyecto.Proyecto.Proyecto]
Carpeta=Proyecto
Clave=Proyecto.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Planes.ProyectoPlan.Asunto]
Carpeta=Planes
Clave=ProyectoPlan.Asunto
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

[Planes.ProyectoPlan.Prioridad]
Carpeta=Planes
Clave=ProyectoPlan.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Planes.ProyectoPlan.Vencimiento]
Carpeta=Planes
Clave=ProyectoPlan.Vencimiento
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
Vista=Proyecto
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
ListaEnCaptura=(Lista)
CondicionVisible=Proyecto:Proyecto.ContactoTipo=<T>Prospecto<T>

[Prospecto.Proyecto.Prospecto]
Carpeta=Prospecto
Clave=Proyecto.Prospecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Proyecto.Comienzo]
Carpeta=Ficha
Clave=Proyecto.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
Efectos=[Negritas]

[Ficha.Proyecto.Fin]
Carpeta=Ficha
Clave=Proyecto.Fin
ValidaNombre=S
3D=S
Tamano=20
Pegado=S
Editar=S
ColorFondo=Blanco
Efectos=[Negritas]

[Ficha.Proyecto.Proyecto]
Carpeta=Ficha
Clave=Proyecto.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=22
ColorFondo=Blanco
Pegado=S

[Acciones.Recursos]
Nombre=Recursos
Boton=80
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
NombreDesplegar=&Recursos Asignados
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyectoRecurso
Antes=S
Visible=S
DespuesGuardar=S
EspacioPrevio=S

RefrescarDespues=S
EnBarraHerramientas=S
ActivoCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente)
AntesExpresiones=Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Proyecto, Proyecto:Proyecto.Proyecto)<BR>Asigna(Info.Estatus, Proyecto:Proyecto.Estatus)
[(Carpeta Abrir).Proyecto.Proyecto]
Carpeta=(Carpeta Abrir)
Clave=Proyecto.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).Proyecto.Comienzo]
Carpeta=(Carpeta Abrir)
Clave=Proyecto.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Proyecto.Fin]
Carpeta=(Carpeta Abrir)
Clave=Proyecto.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Proyecto.Supervisor]
Carpeta=Ficha
Clave=Proyecto.Supervisor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
EspacioPrevio=N
EditarConBloqueo=S

[Ficha.Recurso.Nombre]
Carpeta=Ficha
Clave=Recurso.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ValidaNombre=N
Pegado=N

[Ficha.Proyecto.Moneda]
Carpeta=Ficha
Clave=Proyecto.Moneda
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
Pegado=S
ValidaNombre=S

[Ficha.Proyecto.TipoCambio]
Carpeta=Ficha
Clave=Proyecto.TipoCambio
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[OtrosDatos.Proyecto.Prioridad]
Carpeta=OtrosDatos
Clave=Proyecto.Prioridad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[OtrosDatos.Proyecto.DiasHabiles]
Carpeta=OtrosDatos
Clave=Proyecto.DiasHabiles
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[OtrosDatos.Proyecto.HorasDia]
Carpeta=OtrosDatos
Clave=Proyecto.HorasDia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proyecto.MontoEstimado]
Carpeta=OtrosDatos
Clave=Proyecto.MontoEstimado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[OtrosDatos.Proyecto.FechaEstimada]
Carpeta=OtrosDatos
Clave=Proyecto.FechaEstimada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[OtrosDatos.Proyecto.Probabilidad]
Carpeta=OtrosDatos
Clave=Proyecto.Probabilidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actualizar]
Nombre=Actualizar
Boton=92
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S

Expresion=ProyectoRecalcular(Proyecto:Proyecto.ID)<BR>EjecutarSQL(<T>spProyectoDLiberar :nID<T>, Proyecto:Proyecto.ID)
ActivoCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente)
[Prospecto.Prospecto.Nombre]
Carpeta=Prospecto
Clave=Prospecto.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Proyecto.ContactoTipo]
Carpeta=OtrosDatos
Clave=Proyecto.ContactoTipo
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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>PROY<T>, <T>{Proyecto:Proyecto.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>PROY{Proyecto:Proyecto.ID}<T>
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
VerCampo=370
VerValor=370

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

[Acciones.ProyectoDias]
Nombre=ProyectoDias
Boton=53
Menu=&Edición
NombreDesplegar=Días del Proyecto
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
Visible=S
Expresion=Forma(<T>ProyectoDia<T>)<BR>ProyectoRecalcular(Proyecto:Proyecto.ID)
ActivoCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente)
AntesExpresiones=Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Proyecto, Proyecto:Proyecto.Proyecto)<BR>Asigna(Info.FechaD, Nulo)<BR>Asigna(Info.FechaA, Nulo)

[Actividades.Columnas]
0=97
1=234

[Detalle.ProyectoD.Tipo]
Carpeta=Detalle
Clave=ProyectoD.Tipo
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
EjecucionCondicion=ConDatos(ProyectoD:ProyectoD.ID)
AntesExpresiones=Asigna(Info.ID, ProyectoD:ProyectoD.ID)

[Detalle.ProyectoD.Prioridad]
Carpeta=Detalle
Clave=ProyectoD.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProyectoD.Categoria]
Carpeta=Detalle
Clave=ProyectoD.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProyectoD.Grupo]
Carpeta=Detalle
Clave=ProyectoD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProyectoD.Familia]
Carpeta=Detalle
Clave=ProyectoD.Familia
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
EjecucionCondicion=ConDatos(ProyectoD:ProyectoD.Actividad)
AntesExpresiones=Asigna(Info.ID, ProyectoD:ProyectoD.ID)<BR>Asigna(Info.Actividad, ProyectoD:ProyectoD.Actividad)<BR>Asigna(Info.Asunto, ProyectoD:ProyectoD.Asunto)

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
EjecucionCondicion=ConDatos(ProyectoD:ProyectoD.Actividad)
AntesExpresiones=Asigna(Info.ID, ProyectoD:ProyectoD.ID)<BR>Asigna(Info.Actividad, ProyectoD:ProyectoD.Actividad)<BR>Asigna(Info.Asunto, ProyectoD:ProyectoD.Asunto)

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
ActivoCondicion=Proyecto:Proyecto.Estatus = EstatusPendiente
AntesExpresiones=Asigna(Info.ID, Act:ProyectoD.ID)

[Acciones.ActRecursoD]
Nombre=ActRecursoD
Boton=0
NombreDesplegar=&Recursos de la Actividad
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActRecurso
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.ID, Act:ProyectoD.ID)<BR>Asigna(Info.Actividad, Act:ProyectoD.Asunto)
Visible=S

[Acciones.Plantilla]
Nombre=Plantilla
Boton=11
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=Usar &Plantilla...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
EspacioPrevio=S
Expresion=GuardarCambios<BR>Asigna(Info.PlantillaProyecto, Proyecto:MovTipo.PlantillaProyecto)<BR>Asigna(Info.Actividad, Nulo)<BR>Asigna(Info.Reemplazar, <T>Si<T>)<BR>Si<BR>  Si(Proyecto:MovTipo.PlantillaProyectoFija, Verdadero, Forma(<T>EspecificarPlantillaProyecto<T>))<BR>Entonces<BR>  Si<BR>    Dialogo(<T>EstaSeguro<T>)<BR>  Entonces<BR>    Si<BR>      Vacio(Info.Actividad)<BR>    Entonces<BR>      EjecutarSQL(<T>spProyectoNuevo :nEstacion, :nID, :tProceso, :nSucursal, @Reemplazar=:tReemplazar<T>,  EstacionTrabajo, Proyecto:Proyecto.ID, Info.PlantillaProyecto, Sucursal, Info.Reemplazar)<BR>    Sino<BR>      EjecutarSQL(<T>spProyectoNuevo :nEstacion, :nID, :tProceso, :nSucursal, @EsSubPlantilla=1, @Actividad=:tActividad, @Orden=:tOrden, @Reemplazar=:tReemplazar<T>,  EstacionTrabajo , Proyecto:Proyecto.ID, Info.PlantillaProyecto, Sucursal, Info.Actividad, EstructuraEnOrden(Info.Actividad, 5), Info.Reemplazar)<BR>    Fin<BR>    ProyectoRecalcular(Proyecto:Proyecto.ID)<BR>    Forma.ActualizarForma<BR>  Fin<BR>Fin
ActivoCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[Detalle]
Estilo=Hoja
Clave=Detalle
OtroOrden=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ProyectoD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Proyecto
LlaveLocal=ProyectoD.ID
LlaveMaestra=Proyecto.ID
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=ProyectoD.Orden<TAB>(Acendente)
MenuLocal=S
ListaAcciones=(Lista)
CarpetaVisible=S
ValidarCampos=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Actividades

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaCamposAValidar=ProyectoD.RecursosAsignados
FiltroGeneral={Si(ConDatos(Info.Aplica), <T>CASE WHEN LEN(Orden) = 5 THEN Orden ELSE LEFT(Orden, 5) END =<T>+Comillas(Info.Aplica),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoEstado), <T>ProyectoD.Estado=<T>+Comillas(Info.ProyectoEstado),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoRecurso), <T>ProyectoD.RecursosAsignados=<T>+Comillas(Info.ProyectoRecurso),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoAvanceD), <T>ISNULL(ProyectoD.Avance,0)>=<T>+Comillas(Info.ProyectoAvanceD),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoAvanceA), <T>ISNULL(ProyectoD.Avance,0)<=<T>+Comillas(Info.ProyectoAvanceA),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaInicioD), <T>ProyectoD.Comienzo>=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaInicioD)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaInicioA), <T>ProyectoD.Comienzo<=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaInicioA)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaConclusionD), <T>ProyectoD.Fin>=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaConclusionD)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaConclusionA), <T>ProyectoD.Fin<=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaConclusionA)),<T>1=1<T>)}
[Detalle.ProyectoD.Actividad]
Carpeta=Detalle
Clave=ProyectoD.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProyectoD.Predecesora]
Carpeta=Detalle
Clave=ProyectoD.Predecesora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProyectoD.Asunto]
Carpeta=Detalle
Clave=ProyectoD.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.ProyectoD.Duracion]
Carpeta=Detalle
Clave=ProyectoD.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.ProyectoD.DuracionUnidad]
Carpeta=Detalle
Clave=ProyectoD.DuracionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProyectoD.Comienzo]
Carpeta=Detalle
Clave=ProyectoD.Comienzo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.ProyectoD.Fin]
Carpeta=Detalle
Clave=ProyectoD.Fin
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Proyecto.Avance]
Carpeta=Ficha
Clave=Proyecto.Avance
Editar=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Plata
Efectos=[Negritas]
LineaNueva=N
Pegado=S

[(Carpeta Abrir).Proyecto.Avance]
Carpeta=(Carpeta Abrir)
Clave=Proyecto.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[DetalleFicha]
Estilo=Ficha
Clave=DetalleFicha
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=ProyectoD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Proyecto
LlaveLocal=ProyectoD.ID
LlaveMaestra=Proyecto.ID
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral={Si(ConDatos(Info.Aplica), <T>CASE WHEN LEN(Orden) = 5 THEN Orden ELSE LEFT(Orden, 5) END =<T>+Comillas(Info.Aplica),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoEstado), <T>ProyectoD.Estado=<T>+Comillas(Info.ProyectoEstado),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoRecurso), <T>ProyectoD.RecursosAsignados=<T>+Comillas(Info.ProyectoRecurso),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoAvanceD), <T>ISNULL(ProyectoD.Avance,0)>=<T>+Comillas(Info.ProyectoAvanceD),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoAvanceA), <T>ISNULL(ProyectoD.Avance,0)<=<T>+Comillas(Info.ProyectoAvanceA),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaInicioD), <T>ProyectoD.Comienzo>=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaInicioD)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaInicioA), <T>ProyectoD.Comienzo<=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaInicioA)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaConclusionD), <T>ProyectoD.Fin>=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaConclusionD)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaConclusionA), <T>ProyectoD.Fin<=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaConclusionA)),<T>1=1<T>)}
[DetalleFicha.ProyectoD.Tipo]
Carpeta=DetalleFicha
Clave=ProyectoD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[DetalleFicha.ProyectoD.Categoria]
Carpeta=DetalleFicha
Clave=ProyectoD.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[DetalleFicha.ProyectoD.Grupo]
Carpeta=DetalleFicha
Clave=ProyectoD.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[DetalleFicha.ProyectoD.Familia]
Carpeta=DetalleFicha
Clave=ProyectoD.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Edmond.ProyectoD.Duracion]
Carpeta=Edmond
Clave=ProyectoD.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20x20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ComentariosD]
Nombre=ComentariosD
Boton=0
NombreDesplegar=&Comentarios
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyectoDComentarios
Activo=S
Visible=S
Antes=S
DespuesGuardar=S


AntesExpresiones=Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Actividad, ProyectoD:ProyectoD.Actividad)<BR>Asigna(Info.Proyecto, Proyecto:Proyecto.Proyecto)<BR>Asigna(Info.Estatus, Proyecto:Proyecto.Estatus)
[Ficha.Proyecto.ContactoTipo]
Carpeta=Ficha
Clave=Proyecto.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[Detalle.ProyectoD.EsFase]
Carpeta=Detalle
Clave=ProyectoD.EsFase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Detalle.ProyectoD.Avance]
Carpeta=Detalle
Clave=ProyectoD.Avance
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.ProyectoD.Estado]
Carpeta=Detalle
Clave=ProyectoD.Estado
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Proyecto.ConsiderarAvanceActual]
Carpeta=Ficha
Clave=Proyecto.ConsiderarAvanceActual
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=25

[Acciones.FormaAnexa]
Nombre=FormaAnexa
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Datos Adicionales
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Forma(Proyecto:MovTipo.FormaAnexaOmision)
ActivoCondicion=ConDatos(Proyecto:MovTipo.FormaAnexaOmision)
Visible=S

[Proyecto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Proyecto
Clave=Proyecto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proyecto
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
ListaEnCaptura=(Lista)
CondicionVisible=Proyecto:Proyecto.ContactoTipo = <T>Proyecto<T>

[Proyecto.Proy.Descripcion]
Carpeta=Proyecto
Clave=Proy.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=75
ColorFondo=Plata
ColorFuente=Negro
Pegado=N

[Riesgo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Riesgo
Clave=Riesgo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proyecto
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
ListaEnCaptura=(Lista)
CondicionVisible=Proyecto:Proyecto.ContactoTipo = <T>Riesgo<T>

[Riesgo.Proyecto.Riesgo]
Carpeta=Riesgo
Clave=Proyecto.Riesgo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ProyectoD.EstaLiberado]
Carpeta=Detalle
Clave=ProyectoD.EstaLiberado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Proyecto.Proyecto.ProyectoRama]
Carpeta=Proyecto
Clave=Proyecto.ProyectoRama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Proyecto.ProyectoReestructurar]
Carpeta=Ficha
Clave=Proyecto.ProyectoReestructurar
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProyectoD.EsNuevo]
Carpeta=Detalle
Clave=ProyectoD.EsNuevo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Gantt]
Nombre=Gantt
Boton=88
NombreEnBoton=S
Menu=&Ver
NombreDesplegar=&Gantt
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=PlugIn(<T>Gantt<T>, Proyecto:Proyecto.ID)

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
Vista=Proyecto
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
ListaEnCaptura=Proyecto.Comentarios
AlinearTodaCarpeta=S

[Comentarios.Proyecto.Comentarios]
Carpeta=Comentarios
Clave=Proyecto.Comentarios
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

[Ficha.ContactoTipoNombre]
Carpeta=Ficha
Clave=ContactoTipoNombre
Editar=S
3D=S
Pegado=N
Tamano=40
ColorFondo=Plata
Efectos=[Negritas]

[OtrosDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=OtrosDatos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proyecto
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

[OtrosDatos.Proyecto.Referencia]
Carpeta=OtrosDatos
Clave=Proyecto.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proyecto.Concepto]
Carpeta=OtrosDatos
Clave=Proyecto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Proyecto.Observaciones]
Carpeta=OtrosDatos
Clave=Proyecto.Observaciones
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
AntesExpresiones=Asigna(Info.Modulo, <T>PROY<T>)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Mov, Proyecto:Proyecto.Mov)<BR>Asigna(Info.MovID, Proyecto:Proyecto.MovID)

[Ficha.Proyecto.FechaRequerida]
Carpeta=Ficha
Clave=Proyecto.FechaRequerida
Editar=S
3D=S
Tamano=27
ColorFondo=Blanco
ValidaNombre=S
Pegado=S

[Riesgo.aroRiesgo.Nombre]
Carpeta=Riesgo
Clave=aroRiesgo.Nombre
Editar=S
3D=S
Pegado=N
Tamano=75
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ProyectoD.Clave]
Carpeta=Detalle
Clave=ProyectoD.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Riesgo.Proyecto.UEN]
Carpeta=Riesgo
Clave=Proyecto.UEN
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

[Ficha.Recurso.Rol]
Carpeta=Ficha
Clave=Recurso.Rol
Editar=S
3D=S
Tamano=20
ColorFondo=Plata

[OtrosDatos.Proyecto.CalculoInverso]
Carpeta=OtrosDatos
Clave=Proyecto.CalculoInverso
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
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
EjecucionCondicion=ConDatos(Proyecto:Proyecto.ID) y ConDatos(ProyectoD:ProyectoD.Actividad)
EjecucionMensaje=Si(Vacio(Proyecto:Proyecto.ID), <T>Es Necesario Guardar el Movimiento Antes de Ejecutar<T>)
EjecucionConError=S
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>PROY<T>)<BR>Asigna(Info.Fecha, Proyecto:Proyecto.FechaEmision)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Proyecto:Proyecto.Estatus noen (EstatusCancelado, EstatusConcluido)))<BR>Asigna(Info.Cuenta, ProyectoD:ProyectoD.Actividad)<BR>Asigna(Info.Descripcion, ProyectoD:ProyectoD.Asunto)
Visible=S

[OtrosDatos.Proyecto.FechaRevision]
Carpeta=OtrosDatos
Clave=Proyecto.FechaRevision
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Acciones.Resultados]
Nombre=Resultados
Boton=64
Menu=&Ver
NombreDesplegar=&Resultados
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyResultado
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Proyecto:Proyecto.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Proyecto:Proyecto.Proyecto)
Visible=S

[Acciones.Consecutivo]
Nombre=Consecutivo
Boton=0
Menu=&Archivo
NombreDesplegar=A&signar Consecutivo
GuardarAntes=S
RefrescarDespues=S
EnMenu=S
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>PROY<T>, Proyecto:Proyecto.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(Proyecto:Proyecto.MovID)
VisibleCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[Ficha.Proyecto.Descripcion]
Carpeta=Ficha
Clave=Proyecto.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=110
ColorFondo=Blanco

[DetalleFicha.ProyectoD.ComienzoEsp]
Carpeta=DetalleFicha
Clave=ProyectoD.ComienzoEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Detalle.ProyectoD.RecursosAsignados]
Carpeta=Detalle
Clave=ProyectoD.RecursosAsignados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Acciones.MovProy]
Nombre=MovProy
Boton=25
Menu=&Archivo
NombreDesplegar=Generar &Movimientos...
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Antes=S

Visible=S
Expresion=Caso MovTipo(<T>PROY<T>, Proyecto:Proyecto.Mov)<BR>  ES <T>PROY.P<T> Entonces FormaModal(<T>MovProy<T>)<BR>  ES <T>PROY.PR<T> Entonces<BR>      Asigna(Info.ID,Proyecto:Proyecto.ID)<BR>      Dialogo(<T>Pres_y_Mov<T>)<BR>Fin
ActivoCondicion=Usuario.ProyMov y (Proyecto:Proyecto.Estatus en (EstatusPendiente))
AntesExpresiones=Asigna(Info.Proyecto, Proyecto:Proyecto.Proyecto)<BR>Asigna(Info.Actividad, ProyectoD:ProyectoD.Actividad)<BR>Asigna(Info.Nombre, Proyecto:Proyecto.Mov+<T> <T>+Proyecto:Proyecto.MovID)<BR>Asigna(Info.ID, Proyecto:Proyecto.ID)
[Soporte]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Soporte
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=SoporteA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Detalle=S
VistaMaestra=Proyecto
LlaveLocal=Soporte.Empresa
LlaveMaestra=Proyecto.Empresa
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacionTodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Soporte.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasCancelacion=Soporte.FechaCancelacion
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroAplicaEn=Soporte.Estado
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=SoporteEstado
FiltroTodo=S
FiltroEstilo=Directorio
FiltroMovsTodos=S
IconosNombre=Proyecto:Proyecto.Mov+<T> <T>+Proyecto:Proyecto.MovID
FiltroGeneral=dbo.fnProyectoOriginal(Soporte.Proyecto)=dbo.fnProyectoOriginal(<T>{Proyecto:Proyecto.Proyecto}<T>) AND Soporte.Empresa=<T>{Empresa}<T>

[Soporte.Soporte.FechaEmision]
Carpeta=Soporte
Clave=Soporte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Titulo]
Carpeta=Soporte
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.FechaConclusion]
Carpeta=Soporte
Clave=Soporte.FechaConclusion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Vencimiento]
Carpeta=Soporte
Clave=Soporte.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=100

[Soporte.Dias]
Carpeta=Soporte
Clave=Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Atraso]
Carpeta=Soporte
Clave=Atraso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Estado]
Carpeta=Soporte
Clave=Soporte.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Columnas]
0=95
1=180

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
[Acciones.SoportePersonalizar]
Nombre=SoportePersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Soporte
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.SoporteImprimir]
Nombre=SoporteImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=Soporte
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.SoportePreliminar]
Nombre=SoportePreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=Soporte
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.SoporteExcel]
Nombre=SoporteExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Soporte
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[DetalleFicha.ProyectoD.FechaInicio]
Carpeta=DetalleFicha
Clave=ProyectoD.FechaInicio
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[DetalleFicha.ProyectoD.FechaConclusion]
Carpeta=DetalleFicha
Clave=ProyectoD.FechaConclusion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata



[Cliente.ListaEnCaptura]
(Inicio)=Proyecto.Cliente
Proyecto.Cliente=Cte.Nombre
Cte.Nombre=(Fin)

[Proveedor.ListaEnCaptura]
(Inicio)=Proyecto.Proveedor
Proyecto.Proveedor=Prov.Nombre
Prov.Nombre=(Fin)

[Personal.ListaEnCaptura]
(Inicio)=Proyecto.Personal
Proyecto.Personal=PersonalNombre
PersonalNombre=(Fin)

[Agente.ListaEnCaptura]
(Inicio)=Proyecto.Agente
Proyecto.Agente=Agente.Nombre
Agente.Nombre=(Fin)

[Prospecto.ListaEnCaptura]
(Inicio)=Proyecto.Prospecto
Proyecto.Prospecto=Prospecto.Nombre
Prospecto.Nombre=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)




[Proyecto.ListaEnCaptura]
(Inicio)=Proyecto.ProyectoRama
Proyecto.ProyectoRama=Proy.Descripcion
Proy.Descripcion=(Fin)

[Riesgo.ListaEnCaptura]
(Inicio)=Proyecto.Riesgo
Proyecto.Riesgo=aroRiesgo.Nombre
aroRiesgo.Nombre=Proyecto.UEN
Proyecto.UEN=UEN.Nombre
UEN.Nombre=(Fin)

[OtrosDatos.ListaEnCaptura]
(Inicio)=Proyecto.HorasDia
Proyecto.HorasDia=Proyecto.DiasHabiles
Proyecto.DiasHabiles=Proyecto.Prioridad
Proyecto.Prioridad=Proyecto.CalculoInverso
Proyecto.CalculoInverso=Proyecto.MontoEstimado
Proyecto.MontoEstimado=Proyecto.FechaEstimada
Proyecto.FechaEstimada=Proyecto.Probabilidad
Proyecto.Probabilidad=Proyecto.Referencia
Proyecto.Referencia=Proyecto.FechaRevision
Proyecto.FechaRevision=Proyecto.Concepto
Proyecto.Concepto=Proyecto.Observaciones
Proyecto.Observaciones=(Fin)

[Soporte.ListaEnCaptura]
(Inicio)=Soporte.Titulo
Soporte.Titulo=Soporte.FechaEmision
Soporte.FechaEmision=Soporte.FechaConclusion
Soporte.FechaConclusion=Soporte.Vencimiento
Soporte.Vencimiento=Dias
Dias=Atraso
Atraso=Soporte.Estado
Soporte.Estado=(Fin)

[Soporte.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=ALTAPRIORIDAD
ALTAPRIORIDAD=PRIORIDADBAJA
PRIORIDADBAJA=CONCLUIDO
CONCLUIDO=(Fin)

[Soporte.ListaAcciones]
(Inicio)=SoporteImprimir
SoporteImprimir=SoportePreliminar
SoportePreliminar=SoporteExcel
SoporteExcel=SoportePersonalizar
SoportePersonalizar=(Fin)




[Acciones.ArtMaterial]
Nombre=ArtMaterial
Boton=47
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+M
NombreDesplegar=Actividad - Lista de Materiales
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProyectoDArtMaterial
Antes=S
Visible=S






















Activo=S






AntesExpresiones=Asigna(Info.ID,Proyecto:Proyecto.ID)<BR>Asigna(Info.Actividad,ProyectoD:ProyectoD.Actividad)<BR>Asigna(Info.Proyecto,Proyecto:Proyecto.Proyecto)<BR>Asigna(Temp.Logico,ProyectoD:ProyectoD.EsFase)<BR>Asigna(Info.Estatus,Proyecto:Proyecto.Estatus)

























[Acciones.Excel]
Nombre=Excel
Boton=0
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel y (Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
Visible=S
















[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S
















[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Proyecto.FechaEmision
Proyecto.FechaEmision=Proyecto.Proyecto
Proyecto.Proyecto=Proyecto.Comienzo
Proyecto.Comienzo=Proyecto.Fin
Proyecto.Fin=Proyecto.Avance
Proyecto.Avance=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=SINCRO
SINCRO=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=REESTRUCTURADO
REESTRUCTURADO=CANCELADO
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










[Lista.Columnas]
0=-2
1=232
2=-2
3=-2
4=-2




















































Fecha=80
HorasDia=54
Concepto=210
Cliente=117
Nombre=209
RFC=107
Mov=124
Modulo=38
SubTipo=124
Proveedor=124
Articulo=131
Descripcion1=244
Almacen=90
Grupo=100
Sucursal=46
SerieLote=153
Propiedades=124
[Acciones.Filtros]
Nombre=Filtros
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
NombreDesplegar=Aplicar &Filtros
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
RefrescarDespues=S
Expresion=Si(Forma(<T>ProyectoFiltros<T>), ActualizarVista)
AntesExpresiones=Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Proyecto, Proyecto:Proyecto.Proyecto)


[Acciones.LineaBase]
Nombre=LineaBase
Boton=0
Menu=&Edición
NombreDesplegar=&Línea Base
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=LineaBase
Activo=S
ConAutoEjecutar=S
VisibleCondicion=Asigna(Info.Estatus, SQL(<T>SELECT Estatus FROM Proyecto WHERE ID=:nID<T>, Proyecto:Proyecto.ID))<BR>Si (Info.Estatus = EstatusPendiente) y (Proyecto:Proyecto.Mov = <T>Proyecto Servicio<T>) Entonces Verdadero<BR>Sino Falso<BR>Fin
AutoEjecutarExpresion=Asigna(Info.Estatus, SQL(<T>SELECT Estatus FROM Proyecto WHERE ID=:nID<T>, Proyecto:Proyecto.ID))<BR>Si (Info.Estatus = EstatusPendiente) y (Proyecto:Proyecto.Mov = <T>Proyecto Servicio<T>) Entonces<BR>    Asigna(Info.ID,Proyecto:Proyecto.ID)<BR>Fin

[Detalle.ProyectoD.Esfuerzo]
Carpeta=Detalle
Clave=ProyectoD.Esfuerzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S


[Acciones.Asignar]
Nombre=Asignar
Boton=81
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Asignar Actividades
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyectoDAsignar
Antes=S
Visible=S




































ActivoCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente)
AntesExpresiones=Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Proyecto, Proyecto:Proyecto.Proyecto)<BR>Asigna(Info.Estatus, Proyecto:Proyecto.Estatus)
[Acciones.RecursoAsignar]
Nombre=RecursoAsignar
Boton=0
NombreDesplegar=&Asignar Recurso
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S






EspacioPrevio=S
Expresion=Si<BR>  Forma(<T>EspecificarRecursoProyecto<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spProyectoDAsignarAct :ID, :tActividad, :tRecurso, @DesAsignar = 1<T>, ProyectoD:ProyectoD.ID, ProyectoD:ProyectoD.Actividad, Info.ProyRecurso)<BR>  Forma.ActualizarForma<BR>Fin
ActivoCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente)
AntesExpresiones=Asigna(Info.ID, ProyectoD:ProyectoD.ID)<BR>Asigna(Info.Actividad, ProyectoD:ProyectoD.Actividad)
VisibleCondicion=(no ProyectoD:ProyectoD.EsFase) y ((ProyectoD:ProyectoD.Avance < 100) o (ProyectoD:ProyectoD.Estado noen(<T>Completada<T>, <T>Cancelada<T>, <T>Eliminada<T>))) y (no ConDatos(ProyectoD:ProyectoD.IDGestion))
[Acciones.RecursoDesasignar]
Nombre=RecursoDesasignar
Boton=0
NombreDesplegar=&Desasignar Recurso
EnMenu=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
















Expresion=EjecutarSQL(<T>spProyectoDAsignarAct :ID, :tActividad, :tRecurso, :tAccion<T>, ProyectoD:ProyectoD.ID, ProyectoD:ProyectoD.Actividad, Info.Recurso, <T>DESASIGNAR<T>)<BR>Forma.ActualizarForma
ActivoCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente)
VisibleCondicion=(no ProyectoD:ProyectoD.EsFase) y (ConDatos(ProyectoD:ProyectoD.RecursosAsignados)) y ((ProyectoD:ProyectoD.Avance < 100) o (ProyectoD:ProyectoD.Estado noen(<T>Completada<T>, <T>Cancelada<T>, <T>Eliminada<T>))) y (no ConDatos(ProyectoD:ProyectoD.IDGestion))
[Acciones.Gestion]
Nombre=Gestion
Boton=0
NombreDesplegar=Enviar a &Gestión
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S























Expresion=Asigna(Info.Descripcion, SQL(<T>SELECT Comentarios FROM ProyectoD WHERE ID = :nID AND Actividad = :tActividad<T>, ProyectoD:ProyectoD.ID, ProyectoD:ProyectoD.Actividad))<BR>ProcesarSQL(<T>EXEC spProyectoGestionGenerar :nID, :tMov, :tMovID, :tEmpresa, :nSucursal, :tUsuario, :tProyecto, :nUEN, :tObservaciones, :tActividad, :tAsunto, :nPorcentajeAvance, :tComentarios, :tComienzo, :tConclusion, :nIDGestion<T>,<BR>Proyecto:Proyecto.ID, Proyecto:Proyecto.Mov, Proyecto:Proyecto.MovID, Empresa, Sucursal, Usuario, Proyecto:Proyecto.Proyecto, Proyecto:Proyecto.UEN, Proyecto:Proyecto.Observaciones,<BR>ProyectoD:ProyectoD.Actividad, ProyectoD:ProyectoD.Asunto, ProyectoD:ProyectoD.Avance, Info.Descripcion,FechaFormatoServidor(ProyectoD:ProyectoD.Comienzo),FechaFormatoServidor(ProyectoD:ProyectoD.Fin), ProyectoD:ProyectoD.IDGestion)<BR>ActualizarVista<BR>ActualizarForma
VisibleCondicion=Config.ProyEnviarTareaGestion y (no ProyectoD:ProyectoD.EsFase) y (Proyecto:Proyecto.Estatus en (EstatusPendiente)) y (no ConDatos(ProyectoD:ProyectoD.IDGestion)) y ((ProyectoD:ProyectoD.Avance < 100) o (ProyectoD:ProyectoD.Estado noen(<T>Completada<T>, <T>Cancelada<T>, <T>Eliminada<T>))) y ConDatos(ProyectoD:ProyectoD.RecursosAsignados)
[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122

[Agenda.Columnas]
Mov=106
MovID=65
Orden=35
Avance=55
EstatusNombre=84
Asunto=108
FechaA=80
Duracion=49
Espacio=64
Estado=69
Situacion=75

[Para.Columnas]
Usuario=96
Nombre=307
Participacion=78
Respuesta=147
FechaRegistro=113

[Recursos.Columnas]
Recurso=64
Nombre=163
Fecha=73
HoraD=57
HoraA=53
Cantidad=64
Costo=55
CostoTotal=68
Referencia=141

[Bitacora.Columnas]
0=85
1=85
2=-2
3=-2
4=-2
5=-2

[SubMovimientos.Columnas]
0=180
1=93
2=214
3=208
4=-2

[MAFIndicador.Columnas]
Indicador=304
Referencia=201
LecturaAnterior=124







































[Acciones.Consultar]
Nombre=Consultar
Boton=0
NombreDesplegar=&Consultar Actividad
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S











Expresion=Si (ConDatos(ProyectoD:ProyectoD.IDGestion))<BR>Entonces<BR>  FormaPos(<T>ProyectoGestion<T>, ProyectoD:ProyectoD.IDGestion)<BR>  ProyectoRecalcular(Proyecto:Proyecto.ID)<BR> EjecutarSQL(<T>spProyectoDLiberar :nID<T>, Proyecto:Proyecto.ID)<BR>Fin <BR>ActualizarVista<BR>ActualizarForma
VisibleCondicion=Config.ProyEnviarTareaGestion y (no ProyectoD:ProyectoD.EsFase) y (ConDatos(ProyectoD:ProyectoD.IDGestion)) y (ConDatos(ProyectoD:ProyectoD.IDGestion))
[Acciones.Bitacora]
Nombre=Bitacora
Boton=0
NombreDesplegar=&Bitácora
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyectoDBitacora
Activo=S
Antes=S
DespuesGuardar=S

EspacioPrevio=S


















































AntesExpresiones=Asigna(Info.ID, ProyectoD:ProyectoD.ID)<BR>Asigna(Info.Actividad, ProyectoD:ProyectoD.Actividad)
VisibleCondicion=no ProyectoD:ProyectoD.EsFase






















[Competidores.Columnas]
Orden=35
Competidor=237
Producto=148
Importe=88
Moneda=64
Situacion=99
Fecha=83
Observaciones=675

[FormaAnexo.Columnas]
0=121
1=48
2=-2

[MovEvento.Columnas]
0=455
1=70
2=-2
3=-2
4=-2

[MovImpuesto.Columnas]
Impuesto1=64
Impuesto2=64
Impuesto3=72
Importe1=64
Importe2=64
Importe3=64
Retencion1=64
Retencion2=64
Retencion3=64
ContUso=124
ContUso2=124
ContUso3=124

[VentaFlexibleD.Columnas]
Cliente=93
Nombre=207
Articulo=64
Descripcion1=203
Cantidad=64
Precio=64
Importe=64








































[Antecedentes.Columnas]
Aplica=124
AplicaID=65
Importe=118
Saldo=114
Vencimiento=86

































































































































































































































































































































































































[Acciones.GestionMasiva]
Nombre=GestionMasiva
Boton=0
NombreDesplegar=&Enviar Gestión Masiva
EnMenu=S
TipoAccion=Expresion
Activo=S






































































































































































































































Expresion=EjecutarSQL(<T>EXEC spProyectoGestionMasiva :nEstacion, :nIDProyecto<T>, EstacionTrabajo, Proyecto:Proyecto.ID)
VisibleCondicion=Config.ProyEnviarTareaGestion y (Proyecto:Proyecto.Estatus en (EstatusPendiente))
[Acciones.GestionMultiple]
Nombre=GestionMultiple
Boton=0
NombreDesplegar=&Gestión Multiple
EnMenu=S
TipoAccion=Formas
ClaveAccion=GestionMultipleProy





















Activo=S

























Antes=S





AntesExpresiones=Asigna(Info.ID, Proyecto:Proyecto.ID)<BR>Asigna(Info.Proyecto, Proyecto:Proyecto.Proyecto)<BR>Asigna(Info.Estatus, Proyecto:Proyecto.Estatus)
VisibleCondicion=Proyecto:Proyecto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente)







[DetalleFicha.ListaEnCaptura]
(Inicio)=ProyectoD.Tipo
ProyectoD.Tipo=ProyectoD.Categoria
ProyectoD.Categoria=ProyectoD.Grupo
ProyectoD.Grupo=ProyectoD.Familia
ProyectoD.Familia=ProyectoD.ComienzoEsp
ProyectoD.ComienzoEsp=ProyectoD.FechaInicio
ProyectoD.FechaInicio=ProyectoD.FechaConclusion
ProyectoD.FechaConclusion=(Fin)
















[Detalle.ListaEnCaptura]
(Inicio)=ProyectoD.Actividad
ProyectoD.Actividad=ProyectoD.Clave
ProyectoD.Clave=ProyectoD.Asunto
ProyectoD.Asunto=ProyectoD.EsFase
ProyectoD.EsFase=ProyectoD.Duracion
ProyectoD.Duracion=ProyectoD.DuracionUnidad
ProyectoD.DuracionUnidad=ProyectoD.Predecesora
ProyectoD.Predecesora=ProyectoD.Comienzo
ProyectoD.Comienzo=ProyectoD.Fin
ProyectoD.Fin=ProyectoD.RecursosAsignados
ProyectoD.RecursosAsignados=ProyectoD.Avance
ProyectoD.Avance=ProyectoD.Esfuerzo
ProyectoD.Esfuerzo=ProyectoD.Estado
ProyectoD.Estado=ProyectoD.EstaLiberado
ProyectoD.EstaLiberado=ProyectoD.EsNuevo
ProyectoD.EsNuevo=(Fin)

[Detalle.ListaAcciones]
(Inicio)=ComentariosD
ComentariosD=RecursoAsignar
RecursoAsignar=RecursoDesasignar
RecursoDesasignar=Bitacora
Bitacora=Gestion
Gestion=GestionMultiple
GestionMultiple=GestionMasiva
GestionMasiva=Consultar
Consultar=(Fin)

























































































































































































































[InteresadoEn]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Interesado En
Clave=InteresadoEn
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoInteresadoEn
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General



Detalle=S
VistaMaestra=Proyecto
LlaveLocal=ProyectoInteresadoEn.ID
LlaveMaestra=Proyecto.ID
FiltroGeneral=ProyectoInteresadoEn.ID = Proyecto.ID
[InteresadoEn.ProyectoInteresadoEn.Articulo]
Carpeta=InteresadoEn
Clave=ProyectoInteresadoEn.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[InteresadoEn.ProyectoInteresadoEn.Cantidad]
Carpeta=InteresadoEn
Clave=ProyectoInteresadoEn.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[InteresadoEn.ProyectoInteresadoEn.Precio]
Carpeta=InteresadoEn
Clave=ProyectoInteresadoEn.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[InteresadoEn.ProyectoInteresadoEn.Unidad]
Carpeta=InteresadoEn
Clave=ProyectoInteresadoEn.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[InteresadoEn.ProyectoInteresadoEn.CompraRequerida]
Carpeta=InteresadoEn
Clave=ProyectoInteresadoEn.CompraRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Efectos=[Negritas]
[InteresadoEn.Columnas]
Articulo=101
SubCuenta=83
Cantidad=64
Precio=100
Unidad=60
CantidadInventario=113
CompraRequerida=106

















[Acciones.AgregarPropuesta]
Nombre=AgregarPropuesta
Boton=20
Menu=&Archivo
NombreDesplegar=&Agregar Propuesta
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S


























































Expresion=ProcesarSQL(<T>EXEC spProyectoPropuestaAgregar :nID, :tUsuario, :tEmpresa, :nSucursal<T>, Proyecto:Proyecto.ID, Usuario, Empresa, Sucursal )<BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=Proyecto:Proyecto.Estatus en(EstatusPendiente) y (MovTipo(<T>PROY<T>, Proyecto:Proyecto.Mov) en (PROY.PR))
[Propuestas]
Estilo=Iconos
Pestana=S
Clave=Propuestas
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=(Lista)



Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Propuestas
OtroOrden=S
Detalle=S
VistaMaestra=Proyecto
LlaveLocal=Venta.IDProyecto
LlaveMaestra=Proyecto.ID
ListaOrden=Venta.ID<TAB>(Acendente)
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=VentaA:Venta.Mov+<T> <T>+VentaA:Venta.MovID
FiltroGeneral=Venta.IDProyecto IS NOT NULL
[Propuestas.Venta.Cliente]
Carpeta=Propuestas
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Propuestas.Cte.Nombre]
Carpeta=Propuestas
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Propuestas.Venta.Almacen]
Carpeta=Propuestas
Clave=Venta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Propuestas.Venta.FechaEmision]
Carpeta=Propuestas
Clave=Venta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Propuestas.ImporteTotal]
Carpeta=Propuestas
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Propuestas.Columnas]
0=152
1=88
2=232
3=56
4=104
5=126




























[Acciones.ConsultarPropuesta]
Nombre=ConsultarPropuesta
Boton=0
NombreDesplegar=&Consutar Propuesta
EnMenu=S
TipoAccion=Expresion
Expresion=FormaPos(<T>Venta<T>, VentaA:Venta.ID)
Activo=S
Visible=S










[Ficha.Proyecto.Propuesta]
Carpeta=Ficha
Clave=Proyecto.Propuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco





EditarConBloqueo=S



[Ficha.ListaEnCaptura]
(Inicio)=Proyecto.Mov
Proyecto.Mov=Proyecto.MovID
Proyecto.MovID=Proyecto.Proyecto
Proyecto.Proyecto=Proyecto.UEN
Proyecto.UEN=Proyecto.Moneda
Proyecto.Moneda=Proyecto.TipoCambio
Proyecto.TipoCambio=Proyecto.FechaEmision
Proyecto.FechaEmision=Proyecto.FechaRequerida
Proyecto.FechaRequerida=Proyecto.ProyectoReestructurar
Proyecto.ProyectoReestructurar=Proyecto.ContactoTipo
Proyecto.ContactoTipo=ContactoTipoNombre
ContactoTipoNombre=ContactoTipoClave
ContactoTipoClave=Proyecto.Supervisor
Proyecto.Supervisor=Recurso.Nombre
Recurso.Nombre=Recurso.Rol
Recurso.Rol=Proyecto.Comienzo
Proyecto.Comienzo=Proyecto.Fin
Proyecto.Fin=Proyecto.Avance
Proyecto.Avance=Proyecto.ConsiderarAvanceActual
Proyecto.ConsiderarAvanceActual=Proyecto.Descripcion
Proyecto.Descripcion=Proyecto.Propuesta
Proyecto.Propuesta=(Fin)

























[InteresadoEn.ListaEnCaptura]
(Inicio)=ProyectoInteresadoEn.Articulo
ProyectoInteresadoEn.Articulo=ProyectoInteresadoEn.Cantidad
ProyectoInteresadoEn.Cantidad=ProyectoInteresadoEn.Precio
ProyectoInteresadoEn.Precio=ProyectoInteresadoEn.Unidad
ProyectoInteresadoEn.Unidad=ProyectoInteresadoEn.CompraRequerida
ProyectoInteresadoEn.CompraRequerida=(Fin)





























































[Acciones.ActualizarVista]
Nombre=ActualizarVista
Boton=0
NombreDesplegar=&Actualizar Vista
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Propuestas.ListaEnCaptura]
(Inicio)=Venta.Cliente
Venta.Cliente=Cte.Nombre
Cte.Nombre=Venta.Almacen
Venta.Almacen=Venta.FechaEmision
Venta.FechaEmision=ImporteTotal
ImporteTotal=(Fin)

[Propuestas.ListaAcciones]
(Inicio)=ConsultarPropuesta
ConsultarPropuesta=ActualizarVista
ActualizarVista=(Fin)




















































































































































































































































































































































































































































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=OtrosDatos
OtrosDatos=Prospecto
Prospecto=InteresadoEn
InteresadoEn=Propuestas
Propuestas=Cliente
Cliente=Proveedor
Proveedor=Personal
Personal=Agente
Agente=Proyecto
Proyecto=Riesgo
Riesgo=Comentarios
Comentarios=FormaExtraValor
FormaExtraValor=Detalle
Detalle=DetalleFicha
DetalleFicha=Soporte
Soporte=(Fin)

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
Cancelar=Actualizar
Actualizar=Consecutivo
Consecutivo=ReasignarUsuario
ReasignarUsuario=MovProy
MovProy=CamposExtras
CamposExtras=Anexos
Anexos=AnexosDetalle
AnexosDetalle=FormaAnexa
FormaAnexa=Plantilla
Plantilla=Recursos
Recursos=Asignar
Asignar=Contactos
Contactos=ProyectoDias
ProyectoDias=Anterior
Anterior=Siguiente
Siguiente=Gantt
Gantt=Resultados
Resultados=Info
Info=Tiempo
Tiempo=Politica
Politica=PoliticaConcepto
PoliticaConcepto=MovPos
MovPos=ArtMaterial
ArtMaterial=AgregarPropuesta
AgregarPropuesta=Navegador
Navegador=Cerrar
Cerrar=Filtros
Filtros=LineaBase
LineaBase=Otros1
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
