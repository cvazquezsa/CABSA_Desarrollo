[Forma]
Clave=Gasto
Nombre=Info.ModuloGastosNombre
Icono=0
Modulos=GAS
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=235
PosicionInicialArriba=84
PosicionInicialAltura=565
PosicionInicialAncho=896
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
PosicionSeccion1=51
Totalizadores=S
PosicionSeccion2=93
BarraAyuda=S
MovModulo=GAS
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
PosicionColumna2=58
Plantillas=S
PlantillasEstandar=S
PlantillasProrrateo=S
PlantillasClases=Normal
PlantillasExcepciones=(Lista)
CarpetaProrrateo=Detalle
CamposProrrateo=(Lista)
MensajeProrrateo=Importe
PlantillasExcel=S
ExcelCarpetaDestino=Detalle
ExcelColumnas=(Lista)
AutoGuardarEncabezado=S
PosicionInicialAlturaCliente=524
Comentarios=Anexo.Mov+<T> <T>+Anexo.MovID
TituloAutoNombre=S
PosicionSec1=267
PosicionSec2=441
VentanaEstadoInicial=Normal

ExpresionesAlMostrar=Asigna(Info.Fecha, Hoy)<BR>Asigna(Info.Concepto, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>//Asigna(Info.CambioImpuesto, Falso)
ExpresionesAlCerrar=Asigna(Anexo.Modulo, Nulo)<BR>Asigna(Anexo.ID, Nulo)<BR>Asigna(Anexo.Mov, Nulo)<BR>Asigna(Anexo.MovID, Nulo)<BR>Asigna(Filtro.Mov, Nulo)<BR>Asigna(Filtro.Proveedor, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gasto
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=123
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
Pestana=S
PestanaOtroNombre=S
FichaEspacioNombresAuto=S

[Ficha.Gasto.Mov]
Carpeta=Ficha
Clave=Gasto.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[Ficha.Gasto.MovID]
Carpeta=Ficha
Clave=Gasto.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S

[Ficha.Gasto.FechaEmision]
Carpeta=Ficha
Clave=Gasto.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
EspacioPrevio=N
IgnoraFlujo=N
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.Gasto.Proyecto]
Carpeta=Ficha
Clave=Gasto.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco
Pegado=N

[Ficha.Gasto.Moneda]
Carpeta=Ficha
Clave=Gasto.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco

[Ficha.Gasto.Observaciones]
Carpeta=Ficha
Clave=Gasto.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Gasto.Acreedor]
Carpeta=Ficha
Clave=Gasto.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco

[Ficha.Gasto.Condicion]
Carpeta=Ficha
Clave=Gasto.Condicion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
LineaNueva=S
ColorFondo=Blanco
Pegado=N
EspacioPrevio=N

[Ficha.Gasto.Vencimiento]
Carpeta=Ficha
Clave=Gasto.Vencimiento
Editar=S
3D=S
Tamano=20
EditarConBloqueo=N
LineaNueva=N
ColorFondo=Blanco
ValidaNombre=S

[Ficha.Gasto.Importe]
Carpeta=Ficha
Clave=Gasto.Importe
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
EspacioPrevio=N
ColorFondo=Blanco
Pegado=N

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=GastoA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situaci�n)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosConPaginas=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Gasto.ID<TAB>(Decendente)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Gasto.FechaEmision
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
FiltroUsuarios=S
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
FiltroTodoNombre=(Todos)
FiltroNullNombre=(sin proyecto)
FiltroRespetar=S
FiltroTipo=Autom�tico
FiltroAutoValidar=Mon
FiltroAplicaEn=Gasto.Moneda
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=Gasto.FechaCancelacion
FiltroSucursales=S
FiltroProyectos=S

IconosNombre=GastoA:Gasto.Mov+<T> <T>+GastoA:Gasto.MovID
FiltroGeneral={Si(SQL(<T>SELECT ISNULL(Filtrar, 0) FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSub<T>, <T>GAS<T>, Info.SubModuloGasto), <T>Gasto.SubModulo=<T>+Comillas(Info.SubModuloGasto), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Mov), <T>AND Gasto.Mov=<T>+Comillas(Filtro.Mov), <T><T>)}<BR>{Si(ConDatos(Filtro.Proveedor), <T> AND Gasto.Acreedor=<T>+Comillas(Filtro.Proveedor), <T><T>)}<BR>{Si(ConDatos(Anexo.Modulo), <T> AND Gasto.AnexoModulo=<T>+Comillas(Anexo.Modulo)+<T> AND Gasto.AnexoID=<T>+Anexo.ID, <T><T>)}
BusquedaSelCampo=S
[(Carpeta Abrir).Columnas]
0=150
1=89

2=100
3=100
4=100
5=100
6=100
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
Antes=S
ConCondicion=S
EjecucionConError=S

EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Gasto:Gasto.ID) y (Gasto:Gasto.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Gasto:Gasto.ID, <T>GAS<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>ConDatos(Gasto:Gasto.Acreedor)
EjecucionMensaje=<T>Falta Indicar el Acreedor/Responsable<T>
AntesExpresiones=Si<BR>  (Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y (MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA, GAS.SR, GAS.ASC))<BR>Entonces<BR>  Asigna(Gasto:Gasto.Importe,   Suma(GastoD:GastoD.Importe))<BR>  Asigna(Gasto:Gasto.Retencion, Suma(GastoD:RetencionTotal))<BR>  Asigna(Gasto:Gasto.Impuestos, Suma(GastoD:ImpuestoTotal))<BR>Fin
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
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
NombreEnBoton=S

[Ficha.Gasto.FormaPago]
Carpeta=Ficha
Clave=Gasto.FormaPago
Editar=S
ValidaNombre=S
3D=S
Tamano=15
LineaNueva=N
ColorFondo=Blanco

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

[Detalle.GastoD.Importe]
Carpeta=Detalle
Clave=GastoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
EditarConBloqueo=N
ColorFondo=Blanco

[Detalle.GastoD.Aplica]
Carpeta=Detalle
Clave=GastoD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N

[Detalle.GastoD.AplicaID]
Carpeta=Detalle
Clave=GastoD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N

[Detalle.Columnas]
Importe=83
Aplica=96
AplicaID=69
Saldo=89
Vencimiento=102
Concepto=134
Referencia=57
Impuestos=67
Total=77
Fecha=66
Retencion=74
CentroCostos=102
ContUso=73
Retencion2=73
Cantidad=48
Precio=64
Actividad=65
Proyecto=79
Ejercido=78
Disponible=74
Pendiente=74
Espacio=64
UEN=27
AcreedorRef=80
NumeroEconomico=94
AFArticulo=78
AFSerie=79
PorcentajeDeducible=68
Lectura=42
LecturaAnterior=82
Consumo=50
EndosarA=61
VIN=103
Retencion3=70
Provision=64
Personal=64
DepartamentoDetallista=73
PresupuestoEsp=114
Recurso=64
Riesgo=90
CantidadOrdenada=52
CantidadSolicitada=50
CantidadReservada=57
CantidadPendiente=54
ContUso2=124
ContUso3=124
ABC=94

ClavePresupuestal=98
TipoImpuesto1=57
TipoImpuesto2=64
Impuestos2=64
TipoImpuesto3=88
Impuestos3=67
TipoRetencion1=98
TipoRetencion2=98
TipoRetencion3=86
ImporteConImpuesto=99
TipoImpuesto4=81
SustentoComprobante=169
TipoIdentificacion=99
DerechoDevolucion=196
Establecimiento=124
PuntoEmision=85
SecuencialSRI=90
AutorizacionSRI=108
VigenteA=113
SecuenciaRetencion=124
Comprobante=69
FechaContableMov=136
Nombre_6=83
TipoComprobante=128
Impuesto1=64
Impuesto2=64
Impuesto3=67
Impuesto5=64
Ret1=75
Ret2=75
Ret3=75
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
Totalizadores1=Total<BR>Importe<BR>Impuestos<BR>Retencion
Totalizadores2=Suma(GastoD:Total)<BR>Suma(GastoD:GastoD.Importe)<BR>Suma(GastoD:ImpuestoTotal)<BR>Suma(GastoD:RetencionTotal)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total

CondicionVisible=MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA, GAS.SR, GAS.ASC)
[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Plata
Efectos=[Negritas]

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=<T>A&fectar<T>
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
RefrescarDespues=S
GuardarAntes=S
ConCondicion=S
Antes=S
Visible=S
Expresion=Si<BR>  Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>Entonces<BR>  Si<BR>    ConDatos(Gasto:Gasto.MovAplica) o Gasto:Gasto.Multiple<BR>  Entonces<BR>    Asigna(Temp.Monetario, Nulo)                                                <BR>    Si<BR>      Gasto:Gasto.Multiple<BR>    Entonces<BR>      Asigna(Temp.Monetario, SQL(<T>SELECT SUM(g.Saldo) FROM GastoAplica ga, Gasto g WHERE ga.ID = :nID AND g.Empresa = :tEmpresa AND g.Mov = ga.Aplica AND g.MovID = ga.AplicaID<T>, Gasto:Gasto.ID, Empresa))<BR>      Asigna(Temp.Texto, <T>Antecedentes Multiples<T>)<BR>    Sino<BR>      Asigna(Temp.Monetario, SQL(<T>SELECT Saldo FROM Gasto WHERE Empresa = :tEmpresa AND Mov = :tMov AND MovID = :tMovID<T>, Empresa, Gasto:Gasto.MovAplica, Gasto:Gasto.MovAplicaID))<BR>      Asigna(Temp.Texto, Gasto:Gasto.MovAplica+<T> <T>+Gasto:Gasto.MovAplicaID)<BR>    Fin<BR>    Si((Redondea(Temp.Monetario,0) < Redondea(Gasto:Gasto.Importe-Gasto:Gasto.Retencion+Gasto:Gasto.Impuestos, 0) y (Temp.Monetario<>Nulo) y (MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA, GAS.SR, GAS.ASC))),<BR>      Si(Precaucion(Temp.Texto+<T> por <T>+NumEnTexto(Temp.Monetario,<T>#,.00<T>)+NuevaLinea+<T>Excedente de <T>+NumEnTexto(Gasto:Gasto.Importe-Gasto:Gasto.Retencion+Gasto:Gasto.Impuestos-Temp.Monetario,<T>#,.00<T>)+NuevaLinea+NuevaLinea+<T>� Desea Continuar y Generar el Egreso ?<T>,BotonSi, BotonNo)<>BotonSi,AbortarOperacion))<BR>  Fin<BR><BR><BR>  Asigna(Info.Clave, MovTipo(<T>GAS<T>, Gasto:Gasto.Mov))<BR>  Si Info.Clave = <T>GAS.EST<T> Entonces<BR>        Asigna(Info.Dato, SQL(<T>SELECT Subclave FROM MovTipo WHERE Clave LIKE :tClave AND Mov LIKE :tMov<T>,Info.Clave, Gasto:Gasto.Mov))<BR>        Asigna(Info.Concepto, Mayusculas(SQL(<T>SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(:tConcepto, :tA1, :tA2), :tE1, :tE2), :tI1, :tI2), :tO1, :tO2), :tU1, :tU2)<T>,Info.Concepto,<T>�<T>, <T>a<T>, <T>�<T>,<T>e<T>, <T>�<T>, <T>i<T>, <T>�<T>, <T>o<T>, <T>�<T>,<T>u<T>)))<BR>        Caso Info.Dato<BR>            Es <T>GAS.ESTRETSATINT<T> Entonces<BR>                Si Info.Concepto <> <T>INTERESES<T> Entonces<BR>                    Informacion(<T>No esta Indicado el concepto de Intereses<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>                Si (SQL(<T>SELECT Count(Gravado) FROM CFDIRetSATIntereses WHERE ID = :nID<T>,Gasto:Gasto.ID)) = 0 Entonces<BR>                    Informacion(<T>Falta Informaci�n del Complemento Intereses<T>)<BR>                    AbortarOperacion<BR>                Fin                                         <BR>            Es <T>GAS.ESTRETSAT<T> Entonces<BR>                Si Info.Concepto <> <T>DIVIDENDOS<T> Entonces<BR>                    Informacion(<T>No esta Indicado el concepto de Dividendos<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>                Si (SQL(<T>SELECT Count(Gravado) FROM CFDIRetGastoComplemento WHERE ID = :nID<T>,Gasto:Gasto.ID)) = 0 Entonces<BR>                    Informacion(<T>Falta Informaci�n del Complemento Dividendos<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>            Es <T>GAS.ESTRETSATENEJAC<T> Entonces<BR>                Si Info.Concepto <> <T>ENAJENACION DE ACCIONES<T> Entonces<BR>                    Informacion(<T>No esta Indicado el concepto de Enajenacion de Acciones<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>                Si (SQL(<T>SELECT Count(Gravado) FROM CFDIEnajenacionGastoComplemento WHERE ID = :nID<T>,Gasto:Gasto.ID)) = 0 Entonces<BR>                    Informacion(<T>Falta Informaci�n del Complemento Enajenacion de Acciones<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>            Es <T>GAS.INT<T> Entonces<BR>                Si Info.Concepto <> <T>INTERESES<T> Entonces<BR>                    Informacion(<T>No esta indicando el concepto de Intereses<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>                Si SQL(<T>SELECT Count(Gravado) FROM CFDIRetSATIntereses WHERE ID = :nID<T>,Gasto:Gasto.ID) = 0 Entonces<BR>                    Informacion(<T>Falta informaci�n del complemento de Intereses<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>            Es <T>GAS.DIV<T> Entonces<BR>                Si Info.Concepto <> <T>DIVIDENDOS<T> Entonces<BR>                    Informacion(<T>No esta indicando el concepto de Dividendos<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>                Si SQL(<T>SELECT Count(Gravado) FROM CFDIRetGastoComplemento WHERE ID = :nID<T>,Gasto:Gasto.ID) = 0 Entonces<BR>                    Informacion(<T>Falta informaci�n del complemento de Dividendos<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>            Es <T>GAS.ENJ<T> Entonces<BR>                Si Info.Concepto <> <T>ENAJENACION DE ACCIONES<T> Entonces<BR>                    Informacion(<T>No esta indicando el concepto de Enajenacion de Acciones<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>                Si SQL(<T>SELECT Count(Gravado) FROM CFDIEnajenacionGastoComplemento WHERE ID = :nID<T>,Gasto:Gasto.ID) = 0 Entonces<BR>                    Informacion(<T>Falta informaci�n del complemento de Enajenacion de Acciones<T>)<BR>                    AbortarOperacion<BR>                Fin<BR>        Fin<BR>     Fin<BR><BR>  Afectar(<T>GAS<T>, Gasto:Gasto.ID, Gasto:Gasto.Mov, Gasto:Gasto.MovID, <T>Todo<T>, <T><T>, <T>Gasto<T>)<BR>Sino<BR>  Caso Gasto:Gasto.Estatus<BR>    Es EstatusPendiente Entonces<BR>      Asigna(Info.Modulo, <T>GAS<T>)<BR>      Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>      Asigna(Info.MovID, Gasto:Gasto.MovID)<BR>      Asigna(Afectar.Modulo, <T>GAS<T>)<BR>      Asigna(Afectar.ID, Gasto:Gasto.ID)<BR>      Asigna(Afectar.Mov, Gasto:Gasto.Mov)<BR>      Asigna(Afectar.MovID, Gasto:Gasto.MovID)<BR>      Asigna(Afectar.FormaCaptura, <T>Gasto<T>)<BR>      Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>      Si<BR>        ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>      Entonces<BR>        Si <BR>          Forma(<T>GenerarMovFlujo<T>)<BR>        Entonces<BR>          Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>          Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>        Fin<BR>      Sino<BR>        Caso MovTipo(<T>GAS<T>, Gasto:Gasto.Mov)<BR>          Es GAS.S  Entonces Dialogo(<T>GenerarGastoSolicitud<T>)<BR>          Es GAS.P  Entonces Dialogo(<T>GenerarGastoProvision<T>)<BR>          Es GAS.A  Entonces Dialogo(<T>GenerarGastoAnticipo<T>)<BR>          Es GAS.PR Entonces Dialogo(<T>GenerarGastoPresupuesto<T>)<BR>        Fin<BR>      Fin<BR>    Es EstatusRecurrente Entonces<BR>      Asigna(Afectar.ID, Gasto:Gasto.ID)<BR>      Asigna(Afectar.Mov, Gasto:Gasto.Mov)<BR>      Asigna(Afectar.MovID, Gasto:Gasto.MovID)<BR>      Asigna(Afectar.FormaCaptura, <T>Gasto<T>)<BR>      Asigna(Info.TituloDialogo, Gasto:Gasto.Mov+<T> <T>+Gasto:Gasto.MovID)<BR>      Dialogo(<T>GenerarGastoRecurrente<T>)<BR>  Fin<BR>Fin
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Gasto:Gasto.Usuario) y<BR>((Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) o (Gasto:Gasto.Estatus en (EstatusPendiente, EstatusRecurrente))) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.Estatus, FormaSituacion, Usuario) y <BR>Vacio(Anexo.Modulo)
EjecucionCondicion=ConDatos(Gasto:Gasto.Mov)
AntesExpresiones=Si(General.AdvertirProyectosExpirados, Si(SQL(<T>SELECT COUNT(*) FROM Proy WHERE (Estatus = :tBaja OR FechaFin+1<GETDATE()) AND Proyecto=:tProy<T>, EstatusBaja, Gasto:Gasto.Proyecto) > 0, Si(Precaucion(<T>Proyecto Expirado<T>, BotonAceptar, BotonCancelar)=BotonCancelar, AbortarOperacion)))<BR>Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>GAS<T>, Gasto:Gasto.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.ID, Verdadero, Gasto:Gasto.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
[(Carpeta Abrir).ImporteTotal]
Carpeta=(Carpeta Abrir)
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
Totalizador=0
ColorFondo=Blanco

[(Carpeta Abrir).Gasto.Saldo]
Carpeta=(Carpeta Abrir)
Clave=Gasto.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=Si
TeclaRapida=F5
NombreDesplegar=Copiar
EnMenu=Si
TipoAccion=Expresion
Expresion=Asigna( GastoD:GastoD.Importe,GastoD:GastoPendiente.Saldo )
Visible=Si
ActivoCondicion=Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

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
ActivoCondicion=Vacio(Gasto:Gasto.MovID) y (Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Gasto:Gasto.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Gasto WHERE ID=:nID<T>, Gasto:Gasto.ID))
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
ListaParametros1=Gasto:Gasto.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.Estatus), Gasto:Gasto.ID)
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
ListaParametros1=Gasto:Gasto.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.Estatus), Gasto:Gasto.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.Totalizar]
Nombre=Totalizar
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Totalizar
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Ultimo
Visible=
Activo=
ActivoCondicion=Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA, GAS.SR, GAS.ASC)

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
Expresion=Cancelar(<T>GAS<T>, Gasto:Gasto.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>GAS<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Gasto:Gasto.Usuario) y ConDatos(Gasto:Gasto.ID) y ConDatos(Gasto:Gasto.MovID) y<BR>(Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusSincro, EstatusConcluido, EstatusPendiente, EstatusRecurrente))
AntesExpresiones=Asigna( Afectar.Mov, Gasto:Gasto.Mov ) <BR>Asigna( Afectar.MovID, Gasto:Gasto.MovID )

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
RefrescarDespues=S
Expresion=Verificar(<T>GAS<T>, Gasto:Gasto.ID,Gasto:Gasto.Mov,Gasto:Gasto.MovID)
ActivoCondicion=Gasto:Gasto.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Gasto:Gasto.Mov)

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=33
ColorFondo=Plata
Efectos=[Negritas]
Pegado=N

[Acciones.Infomacion]
Nombre=Infomacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Informaci�n del Acreedor
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Visible=S
ClaveAccion=ProvInfo
Antes=S
EjecucionCondicion=ConDatos(Gasto:Gasto.Acreedor)
AntesExpresiones=Asigna(Info.Proveedor, Gasto:Gasto.Acreedor) <BR>Asigna(Info.Origen, <T>GAS<T>)

[Ficha.Gasto.TipoCambio]
Carpeta=Ficha
Clave=Gasto.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco

[Ficha.Gasto.CtaDinero]
Carpeta=Ficha
Clave=Gasto.CtaDinero
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.InfoCtaDinero]
Nombre=InfoCtaDinero
Boton=0
Menu=&Ver
NombreDesplegar=Informaci�n de la Cuenta
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+I
Expresion=Asigna(Info.CtaDinero, Gasto:Gasto.CtaDinero)<BR>Forma(<T>CtaDineroInfo<T>)
ActivoCondicion=(MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.S)) y Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(Gasto:Gasto.CtaDinero)

[Aplica.Gasto.MovAplica]
Carpeta=Aplica
Clave=Gasto.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.Gasto.MovAplicaID]
Carpeta=Aplica
Clave=Gasto.MovAplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Acciones.Localizar]
Nombre=Localizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=May�s+F3
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
NombreDesplegar=&Posici�n del Movimiento
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S

Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(Gasto:Gasto.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)
[(Carpeta Abrir).Gasto.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Gasto.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Desglose.Columnas]
Concepto=132
Referencia=141
Importe=106
Impuestos=101
Total=111
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

[(Carpeta Abrir).Gasto.Vencimiento]
Carpeta=(Carpeta Abrir)
Clave=Gasto.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=10

[Detalle.GastoPendiente.Saldo]
Carpeta=Detalle
Clave=GastoPendiente.Saldo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Gris

[Detalle.GastoPendiente.Vencimiento]
Carpeta=Detalle
Clave=GastoPendiente.Vencimiento
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Gris

[Detalle]
Estilo=Hoja
PestanaNombre=Desglose
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=GastoD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Gasto
LlaveLocal=GastoD.ID
LlaveMaestra=Gasto.ID
ControlRenglon=S
CampoRenglon=GastoD.Renglon
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
PermiteEditar=S
HojaFondoGrisAuto=S
HojaAjustarColumnas=S
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=(Lista)
ValidarCampos=S
ListaCamposAValidar=(Lista)
CondicionVisible=MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA)
[Detalle.GastoD.Concepto]
Carpeta=Detalle
Clave=GastoD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
EditarConBloqueo=S

[Detalle.GastoD.Referencia]
Carpeta=Detalle
Clave=GastoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
EditarConBloqueo=S

[Detalle.GastoD.Impuestos]
Carpeta=Detalle
Clave=GastoD.Impuestos
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.Total]
Carpeta=Detalle
Clave=Total
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Gasto.MovAplica]
Carpeta=Ficha
Clave=Gasto.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.Gasto.MovAplicaID]
Carpeta=Ficha
Clave=Gasto.MovAplicaID
Editar=S
3D=S
Pegado=S
Tamano=8
ColorFondo=Blanco

[Ficha.Gasto.Clase]
Carpeta=Ficha
Clave=Gasto.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.Gasto.SubClase]
Carpeta=Ficha
Clave=Gasto.SubClase
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.Gasto.Saldo]
Carpeta=Ficha
Clave=Gasto.Saldo
Editar=N
ValidaNombre=S
3D=S
Pegado=S
Tamano=17
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Detalle.GastoD.Fecha]
Carpeta=Detalle
Clave=GastoD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.GastoD.Retencion]
Carpeta=Detalle
Clave=GastoD.Retencion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Gasto.TieneRetencion]
Carpeta=Ficha
Clave=Gasto.TieneRetencion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=11
ColorFondo=Blanco

[Ficha.Gasto.Periodicidad]
Carpeta=Ficha
Clave=Gasto.Periodicidad
Editar=S
ValidaNombre=N
3D=S
Tamano=8
Pegado=S
ColorFondo=Blanco

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=&Situaci�n
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Antes=S
Visible=S

GuardarAntes=S
DespuesGuardar=S
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>GAS<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Gasto:Gasto.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.Estatus, Gasto:Gasto.Estatus)<BR>Asigna(Info.Situacion, Gasto:Gasto.Situacion)
[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ActivoCondicion=ConfigModulo(<T>GAS<T>,<T>Tiempos<T>)=<T>Si<T>
ConCondicion=S
EjecucionCondicion=ConDatos(Gasto:Gasto.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)
Visible=S

[(Carpeta Abrir).Gasto.Acreedor]
Carpeta=(Carpeta Abrir)
Clave=Gasto.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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
ActivoCondicion=ConDatos(GastoA:Gasto.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, GastoA:Gasto.ID)

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
NombreDesplegar=&Presentaci�n preliminar
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
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

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
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Usuario, Gasto:Gasto.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Gasto:Gasto.ID)

[Detalle.GastoD.ContUso]
Carpeta=Detalle
Clave=GastoD.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S

[Antecedentes]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Antecedentes
Clave=Antecedentes
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GastoAplica
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Gasto
LlaveLocal=GastoAplica.ID
LlaveMaestra=Gasto.ID
ControlRenglon=S
CampoRenglon=GastoAplica.Renglon
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=(Lista)
CondicionVisible=MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.A, GAS.C, GAS.CCH, GAS.G, GAS.GTC, GAS.GP, GAS.CP, GAS.DG, GAS.DGP, GAS.DA, GAS.SR, GAS.ASC, GAS.OI, GAS.CI)) y Gasto:Gasto.Multiple

[Antecedentes.GastoAplica.Aplica]
Carpeta=Antecedentes
Clave=GastoAplica.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Antecedentes.GastoAplica.AplicaID]
Carpeta=Antecedentes
Clave=GastoAplica.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Antecedentes.GastoPendiente.Saldo]
Carpeta=Antecedentes
Clave=GastoPendiente.Saldo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Antecedentes.GastoPendiente.Vencimiento]
Carpeta=Antecedentes
Clave=GastoPendiente.Vencimiento
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Antecedentes.Columnas]
Aplica=124
AplicaID=65
Saldo=114
Vencimiento=86
Importe=118

[Ficha.Gasto.Multiple]
Carpeta=Ficha
Clave=Gasto.Multiple
Editar=S
LineaNueva=N
3D=S
Tamano=8
ColorFondo=Blanco
Pegado=N

[Antecedentes.GastoAplica.Importe]
Carpeta=Antecedentes
Clave=GastoAplica.Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
Activo=S
Visible=S
EnBarraHerramientas=S
ClaveAccion=AnexoMov
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>GAS<T>)<BR>Asigna(Info.Fecha, Gasto:Gasto.FechaEmision)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Gasto:Gasto.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Gasto:Gasto.Mov+<T> <T>+Gasto:Gasto.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(Gasto:Gasto.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)
Visible=S

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=May�s+F11
NombreDesplegar=&Copiar
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=CopiarMovimiento(<T>GAS<T>, Gasto:Gasto.ID, <T>Gasto<T>)

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

[Detalle.GastoD.Retencion2]
Carpeta=Detalle
Clave=GastoD.Retencion2
Editar=N
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

[Acciones.Campos]
Nombre=Campos
Boton=0
Menu=&Edici�n
NombreDesplegar=&Campos...
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=GastoCampos
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)
VisibleCondicion=Gasto:Gasto.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)

[Ficha.Gasto.FechaRequerida]
Carpeta=Ficha
Clave=Gasto.FechaRequerida
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ValidaNombre=S

[Detalle.GastoD.Cantidad]
Carpeta=Detalle
Clave=GastoD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.GastoD.Precio]
Carpeta=Detalle
Clave=GastoD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Prov.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Gasto:Gasto.ID),GuardarCambios)
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
Menu=&Edici�n
EnMenu=S
TipoAccion=Expresion

Boton=0
NombreDesplegar=Asociar Comprobantes
GuardarAntes=S
EnBarraHerramientas=S
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
Expresion=FormaModal(<T>CFDConcentrado<T>)
AntesExpresiones=Asigna(Info.Modulo,<T>GAS<T>)<BR>Asigna(Info.ID,Gasto:Gasto.ID)<BR>Asigna(Info.Mov,Gasto:Gasto.Mov)<BR>Asigna(Info.MovID,Gasto:Gasto.MovID)<BR>Asigna(Info.Moneda,Gasto:Gasto.Moneda)<BR>Asigna(Info.TipoCambio,Gasto:Gasto.TipoCambio)<BR>Asigna(Info.Estatus,Gasto:Gasto.Estatus)
[Acciones.Otros8]
Nombre=Otros8
Menu=&Edici�n
EnMenu=S
TipoAccion=Expresion

Boton=0
NombreDesplegar=Asociar Comprobantes CFD - CBB
GuardarAntes=S
Expresion=FormaModal(<T>ContSATCFDCBBModulo<T>)
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Id,Gasto:Gasto.Id)<BR>Asigna(Info.Modulo,<T>GAS<T>)
DespuesGuardar=S
VisibleCondicion=SQL(<T>SELECT dbo.fnDesplegarAsociarCompOtros(:nIndicador,:tModulo,:tMov)<T>,1,<T>GAS<T>,Gasto:Gasto.Mov)
[Acciones.Otros9]
Nombre=Otros9
Menu=&Edici�n
EnMenu=S
TipoAccion=Expresion

Boton=0
NombreDesplegar=Asociar Comprobantes Extranjeros
GuardarAntes=S
Expresion=FormaModal(<T>ContSATExtranjeroModulo<T>)
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Id,Gasto:Gasto.Id)<BR>Asigna(Info.Modulo,<T>GAS<T>)
DespuesGuardar=S
VisibleCondicion=SQL(<T>SELECT dbo.fnDesplegarAsociarCompOtros(:nIndicador,:tModulo,:tMov)<T>,2,<T>GAS<T>,Gasto:Gasto.Mov)   
[Acciones.Prorrateo]
Nombre=Prorrateo
Boton=47
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=Tabla &Prorrateo...
EnMenu=S
TipoAccion=Formas
ConCondicion=S
Antes=S
ClaveAccion=GastoDProrrateo
GuardarAntes=S
DespuesGuardar=S

ActivoCondicion=MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.GP, GAS.CP, GAS.DGP, GAS.PRP))
EjecucionCondicion=ConDatos(GastoD:GastoD.Concepto) y MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.GP, GAS.CP, GAS.DGP, GAS.PRP))
AntesExpresiones=Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Renglon, GastoD:GastoD.Renglon)<BR>Asigna(Info.RenglonSub, GastoD:GastoD.RenglonSub)<BR>Asigna(Info.Concepto, GastoD:GastoD.Concepto)<BR>Asigna(Info.Estatus, Gasto:Gasto.Estatus)<BR>Asigna(Info.Importe, GastoD:GastoD.Importe)<BR>Asigna(Info.CentroCostos, GastoD:GastoD.ContUso)<BR>Asigna(Info.Espacio, GastoD:GastoD.Espacio)
VisibleCondicion=MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.GP, GAS.CP, GAS.DGP, GAS.PRP))
[Acciones.Autorizar]
Nombre=Autorizar
Boton=0
Menu=&Archivo
NombreDesplegar=Autorizar
EnMenu=S
TipoAccion=Formas
Antes=S
RefrescarDespues=S
ClaveAccion=MovAutorizar
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Alt+F12
ActivoCondicion=Vacio(Gasto:Gasto.Autorizacion)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Gasto<T>)<BR>Asigna(Afectar.Modulo, <T>GAS<T>)<BR>Asigna(Afectar.ID, Gasto:Gasto.ID)<BR>Asigna(Afectar.Mov, Gasto:Gasto.Mov)<BR>Asigna(Afectar.MovID, Gasto:Gasto.MovID)<BR>Asigna(Info.Descripcion, Gasto:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(Gasto:Gasto.Mensaje)

[Detalle.GastoD.Actividad]
Carpeta=Detalle
Clave=GastoD.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
EditarConBloqueo=S

[Detalle.GastoD.Proyecto]
Carpeta=Detalle
Clave=GastoD.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Gasto.Actividad]
Carpeta=Ficha
Clave=Gasto.Actividad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Pegado=N

[Detalle.Ejercido]
Carpeta=Detalle
Clave=Ejercido
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Rojo obscuro
Efectos=[Negritas]

[Detalle.Disponible]
Carpeta=Detalle
Clave=Disponible
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

[Detalle.Pendiente]
Carpeta=Detalle
Clave=Pendiente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Azul
Efectos=[Negritas]
ColorFondo=Blanco

[Acciones.Desafectar]
Nombre=Desafectar
Boton=0
Menu=&Archivo
NombreDesplegar=Desafectar
RefrescarDespues=S
EnMenu=S
ConfirmarAntes=S
TipoAccion=Expresion
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+F12
Expresion=EjecutarSQL(<T>spDesAfectarPresupuesto :tModulo, :tMov, :nID<T>, <T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.ID)
ActivoCondicion=Usuario.Desafectar
VisibleCondicion=MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.PR, GAS.DPR, GAS.GR)) y (Gasto:Gasto.Estatus en (EstatusConcluido, EstatusRecurrente))

[Acciones.Observaciones]
Nombre=Observaciones
Boton=0
NombreDesplegar=&Observaciones
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
Expresion=Si(Gasto:Gasto.Estatus en (EstatusConcluido, EstatusCancelado), Informacion(GastoD:GastoD.DescripcionExtra), Pregunta(GastoD:GastoD.DescripcionExtra))

[Detalle.GastoD.Espacio]
Carpeta=Detalle
Clave=GastoD.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Gasto.UEN]
Carpeta=Ficha
Clave=Gasto.UEN
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco

[Detalle.GastoD.UEN]
Carpeta=Detalle
Clave=GastoD.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EditarConBloqueo=S

[Acciones.ProyInfo]
Nombre=ProyInfo
Boton=0
Menu=&Ver
NombreDesplegar=Informaci�n del Proyecto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Gasto:Gasto.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, Gasto:Gasto.Proyecto)

[Acciones.LocalProyInfo]
Nombre=LocalProyInfo
Boton=0
NombreDesplegar=Informaci�n del Proyecto
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(GastoD:GastoD.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, GastoD:GastoD.Proyecto)
VisibleCondicion=Config.GastoProyectoDetalle

[Detalle.GastoD.AcreedorRef]
Carpeta=Detalle
Clave=GastoD.AcreedorRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.Espacio.NumeroEconomico]
Carpeta=Detalle
Clave=Espacio.NumeroEconomico
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Ficha.Gasto.AFArticulo]
Carpeta=Ficha
Clave=Gasto.AFArticulo
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
Pegado=S

[Ficha.Gasto.AFSerie]
Carpeta=Ficha
Clave=Gasto.AFSerie
Editar=S
3D=S
Tamano=13
ColorFondo=Blanco
Pegado=N

[Ficha.Gasto.AF]
Carpeta=Ficha
Clave=Gasto.AF
Editar=S
3D=S
Tamano=11
ColorFondo=Blanco

[Detalle.GastoD.AFArticulo]
Carpeta=Detalle
Clave=GastoD.AFArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.GastoD.AFSerie]
Carpeta=Detalle
Clave=GastoD.AFSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.GastoD.PorcentajeDeducible]
Carpeta=Detalle
Clave=GastoD.PorcentajeDeducible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.CopiarMeses]
Nombre=CopiarMeses
Boton=0
Menu=&Archivo
NombreDesplegar=Copiar en el Tiempo...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)<BR>Si(no Forma(<T>MovCopiarMeses<T>),  AbortarOperacion)

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
Vista=Gasto
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
CarpetaVisible=S

[Comentarios.Gasto.Comentarios]
Carpeta=Comentarios
Clave=Gasto.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=104x9
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
Expresion=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.Clave, <T>GAS<T>+Gasto:Gasto.ID)<BR>Asigna(Info.Nombre, Gasto:Gasto.Mov+<T> <T>+Gasto:Gasto.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Gasto:Gasto.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))

[Detalle.GastoD.Lectura]
Carpeta=Detalle
Clave=GastoD.Lectura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Gasto.ConVigencia]
Carpeta=Ficha
Clave=Gasto.ConVigencia
Editar=S
3D=S
Tamano=8
ColorFondo=Blanco

[Ficha.Gasto.VigenciaDesde]
Carpeta=Ficha
Clave=Gasto.VigenciaDesde
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=15
ColorFondo=Blanco

[Ficha.Gasto.VigenciaHasta]
Carpeta=Ficha
Clave=Gasto.VigenciaHasta
Editar=S
ValidaNombre=N
3D=S
Pegado=N
Tamano=15
ColorFondo=Blanco

[Contrato]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos del Contrato
Clave=Contrato
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gasto
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
CondicionVisible=MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) = GAS.CTO

[Contrato.Gasto.ContratoDescripcion]
Carpeta=Contrato
Clave=Gasto.ContratoDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.ContratoTipo]
Carpeta=Contrato
Clave=Gasto.ContratoTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.ContratoSerie]
Carpeta=Contrato
Clave=Gasto.ContratoSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.ContratoValor]
Carpeta=Contrato
Clave=Gasto.ContratoValor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.ContratoValorMoneda]
Carpeta=Contrato
Clave=Gasto.ContratoValorMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.ContratoSeguro]
Carpeta=Contrato
Clave=Gasto.ContratoSeguro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.ContratoResponsable]
Carpeta=Contrato
Clave=Gasto.ContratoResponsable
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.VigenciaDesde]
Carpeta=Contrato
Clave=Gasto.VigenciaDesde
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.VigenciaHasta]
Carpeta=Contrato
Clave=Gasto.VigenciaHasta
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.ConVigencia]
Carpeta=Contrato
Clave=Gasto.ConVigencia
Editar=S
LineaNueva=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.Gasto.Periodicidad]
Carpeta=Contrato
Clave=Gasto.Periodicidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Detalle.GastoD.LecturaAnterior]
Carpeta=Detalle
Clave=GastoD.LecturaAnterior
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.Consumo]
Carpeta=Detalle
Clave=Consumo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Contrato.Gasto.ContratoVencimiento]
Carpeta=Contrato
Clave=Gasto.ContratoVencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.Prioridad]
Carpeta=Ficha
Clave=Gasto.Prioridad
Editar=S
3D=S
Tamano=13
ColorFondo=Blanco
ValidaNombre=N
Pegado=N

[Acciones.BotonCerrar]
Nombre=BotonCerrar
Boton=40
NombreEnBoton=S
NombreDesplegar=&Regresar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
GuardarAntes=S
VisibleCondicion=ConDatos(Anexo.Modulo)

[Detalle.GastoD.EndosarA]
Carpeta=Detalle
Clave=GastoD.EndosarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edici�n
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
AntesExpresiones=Asigna(Info.PuedeEditar, Gasto:Gasto.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)<BR>Asigna(Info.Proyecto, Gasto:Gasto.Proyecto)<BR>Asigna(Info.UEN, Gasto:Gasto.UEN)<BR>Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Gasto:Gasto.Acreedor)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Comentarios.Gasto.Nota]
Carpeta=Comentarios
Clave=Gasto.Nota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=61
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)<BR>Asigna(Info.Fecha, Gasto:Gasto.FechaEmision)<BR>Asigna(Info.Estatus, Gasto:Gasto.Estatus)

[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+O
NombreDesplegar=&Pol�tica
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Gasto:Gasto.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>GAS<T>)<BR>Asigna(Info.Clave, Gasto:Gasto.Mov)

[Detalle.GastoD.VIN]
Carpeta=Detalle
Clave=GastoD.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.GastoD.Retencion3]
Carpeta=Detalle
Clave=GastoD.Retencion3
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
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
Expresion=Asigna(Info.Forma, <T>Gasto<T>)<BR>Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.Nombre, Gasto:Gasto.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

[Acciones.LocalPolitica]
Nombre=LocalPolitica
Boton=0
NombreDesplegar=Ver Pol�tica Co&ncepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=ConceptoPoliticaInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.Concepto, GastoD:GastoD.Concepto)

[Detalle.GastoD.Provision]
Carpeta=Detalle
Clave=GastoD.Provision
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=0
Menu=&Edici�n
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
RefrescarDespues=S
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.ID, Falso, Gasto:Gasto.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>GAS<T>+Gasto:Gasto.ID)<BR>  Asigna(Info.Nombre, Gasto:Gasto.Mov+<T> <T>+Gasto:Gasto.MovID)<BR>  Asigna(Info.Modulo, <T>GAS<T>)<BR>  Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

[Detalle.GastoD.Personal]
Carpeta=Detalle
Clave=GastoD.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.ConceptoExpress]
Nombre=ConceptoExpress
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+F8
NombreDesplegar=&Concepto Express...
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.Modulo, <T>GAS<T>)<BR>Si<BR>  Forma(<T>ConceptoExpress<T>)<BR>Entonces<BR>  Asigna(GastoD:GastoD.Concepto, Info.Concepto)<BR>Fin
ActivoCondicion=Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.PresupuestoInfo]
Nombre=PresupuestoInfo
Boton=0
Menu=&Ver
NombreDesplegar=Presupuesto del Concepto
EnMenu=S
TipoAccion=Formas
ClaveAccion=PresupuestoInfo
Antes=S
UsaTeclaRapida=S
TeclaRapida=May�s+Ctrl+P
ActivoCondicion=General.PPTO
AntesExpresiones=Asigna(Info.Cuenta, SQL(<T>SELECT CuentaPresupuesto FROM Concepto WHERE Modulo=:tModulo AND Concepto=:tConcepto<T>, <T>GAS<T>, GastoD:GastoD.Concepto))<BR>Asigna(Info.Nombre, GastoD:GastoD.Concepto)
VisibleCondicion=General.PPTO

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
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)
DespuesGuardar=S
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
Expresion=ProcesarSQL(<T>spAfectar :tModulo, :nID, :tAccion<T>, <T>GAS<T>, Gasto:Gasto.ID, <T>CONSECUTIVO<T>)
ActivoCondicion=Vacio(Gasto:Gasto.MovID)
VisibleCondicion=Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[Detalle.GastoD.DepartamentoDetallista]
Carpeta=Detalle
Clave=GastoD.DepartamentoDetallista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=E&xcel...
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel y (Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA, GAS.SR, GAS.ASC)

[Acciones.ProvExpress]
Nombre=ProvExpress
Boton=0
NombreDesplegar=&Acreedor Express
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Asigna(Info.Tipo, <T>Acreedor<T>)<BR>Si<BR>  Forma(<T>ProvExpress<T>)<BR>Entonces<BR>  Asigna(GastoD:GastoD.AcreedorRef, Info.Proveedor)<BR>Fin
ActivoCondicion=Usuario.AgregarProvExpress y (Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
VisibleCondicion=MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.CCH, GAS.GTC, GAS.C))

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Caracter�sticas
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
HojaVistaOmision=Autom�tica
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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>GAS<T>, <T>{Gasto:Gasto.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>GAS{Gasto:Gasto.ID}<T>

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

[Detalle.GastoD.PresupuestoEsp]
Carpeta=Detalle
Clave=GastoD.PresupuestoEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.PresupuestoEsp]
Nombre=PresupuestoEsp
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Ctrl+Alt+P
NombreDesplegar=Presupuesto Especifico
EnMenu=S
TipoAccion=Formas
ClaveAccion=GastoDPresupuestoEsp
Activo=S
ConCondicion=S
Antes=S
EjecucionCondicion=GastoD:GastoD.PresupuestoEsp y ConDatos(GastoD:GastoD.Concepto)
AntesExpresiones=Asigna(Info.PuedeEditar, Gasto:Gasto.Estatus=EstatusSinAfectar)<BR>Asigna(Info.Importe, GastoD:Total)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Renglon, GastoD:GastoD.Renglon)<BR>Asigna(Info.RenglonSub, GastoD:GastoD.RenglonSub)<BR>Asigna(Info.Articulo, Nulo)<BR>Asigna(Info.Concepto, GastoD:GastoD.Concepto)
VisibleCondicion=General.PPTO

[Comentarios.Gasto.ClienteRef]
Carpeta=Comentarios
Clave=Gasto.ClienteRef
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios.Gasto.ArticuloRef]
Carpeta=Comentarios
Clave=Gasto.ArticuloRef
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+D
NombreDesplegar=&Disponible
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Origen, <T>INV<T>)<BR>Asigna(Info.Articulo, GastoD:Concepto.Articulo)<BR>Asigna(Info.Descripcion, SQL(<T>SELECT Descripcion1 FROM Art WHERE Articulo=:tArt<T>, GastoD:Concepto.Articulo))<BR>Asigna(Info.ArtTipo, SQL(<T>SELECT Tipo FROM Art WHERE Articulo=:tArt<T>, GastoD:Concepto.Articulo))<BR>Asigna(Info.ArtTipoOpcion, SQL(<T>SELECT TipoOpcion FROM Art WHERE Articulo=:tArt<T>, GastoD:Concepto.Articulo))<BR>Asigna(Info.Almacen, Config.GastoAlmacen)<BR>Forma(<T>ArtAlmExistencia<T>)
ActivoCondicion=Config.GastoConceptosInventariables
ConCondicion=S
EjecucionCondicion=GastoD:Concepto.EsInventariable y ConDatos(GastoD:Concepto.Articulo)
Visible=S

[Detalle.CantidadOrdenada]
Carpeta=Detalle
Clave=CantidadOrdenada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

[Detalle.CantidadReservada]
Carpeta=Detalle
Clave=CantidadReservada
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Azul
Efectos=[Negritas]
ColorFondo=Blanco

[Detalle.CantidadPendiente]
Carpeta=Detalle
Clave=CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=$00004080
Efectos=[Negritas]
ColorFondo=Blanco

[Acciones.DineroDepositosAnticipados]
Nombre=DineroDepositosAnticipados
Boton=0
Menu=&Ver
NombreDesplegar=&Dep�sitos Anticipados Pendientes
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=DineroDepositosAnticipados
Activo=S
Visible=S

[Detalle.GastoD.Recurso]
Carpeta=Detalle
Clave=GastoD.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.Recurso.Nombre]
Carpeta=Detalle
Clave=Recurso.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[CentrosCostos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Centros de costo
Clave=CentrosCostos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gasto
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
CondicionVisible=Config.ContCentrosCostos y (Config.CentroCostos2Gasto o Config.CentroCostos3Gasto) y (Gasto:Gasto.Estatus <> EstatusConcluido) y (Gasto:Gasto.Estatus <> EstatusCancelado)

[CentrosCostos.Gasto.ContUso]
Carpeta=CentrosCostos
Clave=Gasto.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CentrosCostos.Gasto.ContUso2]
Carpeta=CentrosCostos
Clave=Gasto.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CentrosCostos.Gasto.ContUso3]
Carpeta=CentrosCostos
Clave=Gasto.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GastoD.ContUso2]
Carpeta=Detalle
Clave=GastoD.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.GastoD.ContUso3]
Carpeta=Detalle
Clave=GastoD.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
0=252
Proveedor=118
Nombre=300

1=241
2=76
3=103
4=81
5=85
6=156
7=199
8=54
ConceptoFE=304
[MovImpuesto]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Arrastre
Clave=MovImpuesto
Filtros=S
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovImpuestoMov
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Gasto
LlaveLocal=MovImpuestoMov.ModuloID
LlaveMaestra=Gasto.ID
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
ListaAcciones=PersonalizarVista

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
FiltroGeneral=MovImpuestoMov.Modulo = <T>GAS<T>
CondicionVisible=((Gasto:Gasto.Estatus = EstatusConcluido) o (Gasto:Gasto.Estatus = EstatusCancelado)) y (Config.VisualizarArrastre)
[MovImpuesto.MovImpuestoMov.Impuesto1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Impuesto2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Impuesto3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Importe1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Importe2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Importe3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Importe3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Retencion1]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Retencion2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.Retencion3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.ContUso]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.ContUso2]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovImpuesto.MovImpuestoMov.ContUso3]
Carpeta=MovImpuesto
Clave=MovImpuestoMov.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovImpuesto.Columnas]
0=100
1=100

2=100
3=100
4=100
5=100
6=100
7=100
8=100
9=100
10=100
11=100
12=100
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
[Acciones.PersonalizarVista]
Nombre=PersonalizarVista
Boton=0
NombreDesplegar=Personalizar vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Detalle.GastoD.ABC]
Carpeta=Detalle
Clave=GastoD.ABC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Antecedentes.ListaEnCaptura]
(Inicio)=GastoAplica.Aplica
GastoAplica.Aplica=GastoAplica.AplicaID
GastoAplica.AplicaID=GastoAplica.Importe
GastoAplica.Importe=GastoPendiente.Saldo
GastoPendiente.Saldo=GastoPendiente.Vencimiento
GastoPendiente.Vencimiento=(Fin)

[Antecedentes.ListaOrden]
(Inicio)=GastoAplica.Renglon<TAB>(Acendente)
GastoAplica.Renglon<TAB>(Acendente)=GastoAplica.RenglonSub<TAB>(Acendente)
GastoAplica.RenglonSub<TAB>(Acendente)=(Fin)

[Comentarios.ListaEnCaptura]
(Inicio)=Gasto.Comentarios
Gasto.Comentarios=Gasto.Nota
Gasto.Nota=Gasto.ClienteRef
Gasto.ClienteRef=Gasto.ArticuloRef
Gasto.ArticuloRef=(Fin)

[Contrato.ListaEnCaptura]
(Inicio)=Gasto.ContratoDescripcion
Gasto.ContratoDescripcion=Gasto.ContratoTipo
Gasto.ContratoTipo=Gasto.ContratoSeguro
Gasto.ContratoSeguro=Gasto.ContratoValor
Gasto.ContratoValor=Gasto.ContratoValorMoneda
Gasto.ContratoValorMoneda=Gasto.ContratoSerie
Gasto.ContratoSerie=Gasto.ContratoResponsable
Gasto.ContratoResponsable=Gasto.ContratoVencimiento
Gasto.ContratoVencimiento=Gasto.Periodicidad
Gasto.Periodicidad=Gasto.VigenciaDesde
Gasto.VigenciaDesde=Gasto.VigenciaHasta
Gasto.VigenciaHasta=Gasto.ConVigencia
Gasto.ConVigencia=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)

[CentrosCostos.ListaEnCaptura]
(Inicio)=Gasto.ContUso
Gasto.ContUso=Gasto.ContUso2
Gasto.ContUso2=Gasto.ContUso3
Gasto.ContUso3=(Fin)


[Agrupadores]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agrupadores
Clave=Agrupadores
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gasto
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


CondicionVisible=General.VerMovAgrupadores
[Agrupadores.Gasto.ContratoMov]
Carpeta=Agrupadores
Clave=Gasto.ContratoMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agrupadores.Gasto.ContratoMovID]
Carpeta=Agrupadores
Clave=Gasto.ContratoMovID
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro













[Agrupadores.ListaEnCaptura]
(Inicio)=Gasto.ContratoMov
Gasto.ContratoMov=Gasto.ContratoMovID
Gasto.ContratoMovID=(Fin)


































[Detalle.GastoD.ClavePresupuestal]
Carpeta=Detalle
Clave=GastoD.ClavePresupuestal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
















[Acciones.CPReservarFlujo]
Nombre=CPReservarFlujo
Boton=0
Menu=&Edici�n
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+F
NombreDesplegar=Si(Gasto:MovTipo.ReservarCP=<T>Desreservar<T>, <T>Desreservar Flujo...<T>,<T>Reservar Flujo...<T>)
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CPCalMov
Antes=S
DespuesGuardar=S
































































































































































ActivoCondicion=Gasto:MovTipo.ReservarCP en (<T>Si<T>, <T>Desreservar<T>)
AntesExpresiones=Asigna(Info.PuedeEditar, Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))<BR>Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)<BR>Asigna(Info.Ejercicio, A�o(Gasto:Gasto.FechaEmision))<BR>Asigna(Info.ClavePresupuestal, GastoD:GastoD.ClavePresupuestal)<BR>Asigna(Info.Tipo, Si(Gasto:MovTipo.ReservarCP=<T>Desreservar<T>, <T>Reduccion<T>,<T>Ampliacion<T>))<BR>Asigna(Info.Importe, Suma(GastoD:Total)+Suma(GastoD:RetencionTotal))
VisibleCondicion=General.CP
[Detalle.GastoD.TipoImpuesto1]
Carpeta=Detalle
Clave=GastoD.TipoImpuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.GastoD.TipoImpuesto2]
Carpeta=Detalle
Clave=GastoD.TipoImpuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.GastoD.Impuestos2]
Carpeta=Detalle
Clave=GastoD.Impuestos2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.GastoD.TipoImpuesto3]
Carpeta=Detalle
Clave=GastoD.TipoImpuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.GastoD.Impuestos3]
Carpeta=Detalle
Clave=GastoD.Impuestos3
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.GastoD.TipoRetencion1]
Carpeta=Detalle
Clave=GastoD.TipoRetencion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.GastoD.TipoRetencion2]
Carpeta=Detalle
Clave=GastoD.TipoRetencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.GastoD.TipoRetencion3]
Carpeta=Detalle
Clave=GastoD.TipoRetencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




































































































[Detalle.GastoD.ImporteConImpuesto]
Carpeta=Detalle
Clave=GastoD.ImporteConImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




























































































































[Detalle.GastoD.TipoImpuesto4]
Carpeta=Detalle
Clave=GastoD.TipoImpuesto4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

































[Anexo]
Estilo=Ficha
Pestana=S
Clave=Anexo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gasto
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

PestanaOtroNombre=S
PestanaNombre=Anexo Transaccional

CondicionVisible=(Empresa.EsEcuador) Y (Gasto:MovTipo.EcuadorMostrarAnexo EN (<T>Encabezado<T>))
[Anexo.Gasto.TipoComprobante]
Carpeta=Anexo
Clave=Gasto.TipoComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Anexo.Gasto.SustentoComprobante]
Carpeta=Anexo
Clave=Gasto.SustentoComprobante
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Anexo.Gasto.Establecimiento]
Carpeta=Anexo
Clave=Gasto.Establecimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Anexo.Gasto.PuntoEmision]
Carpeta=Anexo
Clave=Gasto.PuntoEmision
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=5
ColorFondo=Blanco

Pegado=S
[Anexo.Gasto.SecuencialSRI]
Carpeta=Anexo
Clave=Gasto.SecuencialSRI
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=S
[Anexo.Gasto.AutorizacionSRI]
Carpeta=Anexo
Clave=Gasto.AutorizacionSRI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Anexo.Gasto.VigenteA]
Carpeta=Anexo
Clave=Gasto.VigenteA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Anexo.Gasto.SecuenciaRetencion]
Carpeta=Anexo
Clave=Gasto.SecuenciaRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

EspacioPrevio=S

[Anexo.Gasto.Comprobante]
Carpeta=Anexo
Clave=Gasto.Comprobante
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Anexo.Gasto.DerechoDevolucion]
Carpeta=Anexo
Clave=Gasto.DerechoDevolucion
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Detalle.GastoD.TipoComprobante]
Carpeta=Detalle
Clave=GastoD.TipoComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.GastoD.SustentoComprobante]
Carpeta=Detalle
Clave=GastoD.SustentoComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Detalle.GastoD.DerechoDevolucion]
Carpeta=Detalle
Clave=GastoD.DerechoDevolucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.GastoD.Establecimiento]
Carpeta=Detalle
Clave=GastoD.Establecimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.GastoD.PuntoEmision]
Carpeta=Detalle
Clave=GastoD.PuntoEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.GastoD.SecuencialSRI]
Carpeta=Detalle
Clave=GastoD.SecuencialSRI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.GastoD.AutorizacionSRI]
Carpeta=Detalle
Clave=GastoD.AutorizacionSRI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.GastoD.VigenteA]
Carpeta=Detalle
Clave=GastoD.VigenteA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.GastoD.SecuenciaRetencion]
Carpeta=Detalle
Clave=GastoD.SecuenciaRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.GastoD.Comprobante]
Carpeta=Detalle
Clave=GastoD.Comprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.GastoD.FechaContableMov]
Carpeta=Detalle
Clave=GastoD.FechaContableMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








































[Detalle.GastoD.Impuesto1]
Carpeta=Detalle
Clave=GastoD.Impuesto1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.GastoD.Impuesto2]
Carpeta=Detalle
Clave=GastoD.Impuesto2
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.GastoD.Impuesto3]
Carpeta=Detalle
Clave=GastoD.Impuesto3
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





































[Detalle.GastoD.EcuadorTipoOperacionGasto]
Carpeta=Detalle
Clave=GastoD.EcuadorTipoOperacionGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[Anexo.ListaEnCaptura]
(Inicio)=Gasto.SustentoComprobante
Gasto.SustentoComprobante=Gasto.DerechoDevolucion
Gasto.DerechoDevolucion=Gasto.TipoComprobante
Gasto.TipoComprobante=Gasto.Establecimiento
Gasto.Establecimiento=Gasto.PuntoEmision
Gasto.PuntoEmision=Gasto.SecuencialSRI
Gasto.SecuencialSRI=Gasto.AutorizacionSRI
Gasto.AutorizacionSRI=Gasto.VigenteA
Gasto.VigenteA=Gasto.SecuenciaRetencion
Gasto.SecuenciaRetencion=Gasto.PuntoEmisionRetencion
Gasto.PuntoEmisionRetencion=Gasto.SecuencialSRIRetencion
Gasto.SecuencialSRIRetencion=Gasto.Comprobante
Gasto.Comprobante=(Fin)

[Anexo.Gasto.PuntoEmisionRetencion]
Carpeta=Anexo
Clave=Gasto.PuntoEmisionRetencion
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco

[Anexo.Gasto.SecuencialSRIRetencion]
Carpeta=Anexo
Clave=Gasto.SecuencialSRIRetencion
Editar=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco























[Detalle.GastoD.Impuesto5]
Carpeta=Detalle
Clave=GastoD.Impuesto5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











































[Detalle.Ret1]
Carpeta=Detalle
Clave=Ret1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.Ret2]
Carpeta=Detalle
Clave=Ret2
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.Ret3]
Carpeta=Detalle
Clave=Ret3
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





























































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

















































[Detalle.ListaEnCaptura]
(Inicio)=GastoD.AcreedorRef
GastoD.AcreedorRef=GastoD.EndosarA
GastoD.EndosarA=GastoD.Concepto
GastoD.Concepto=GastoD.EcuadorTipoOperacionGasto
GastoD.EcuadorTipoOperacionGasto=GastoD.Recurso
GastoD.Recurso=Recurso.Nombre
Recurso.Nombre=GastoD.Personal
GastoD.Personal=GastoD.Fecha
GastoD.Fecha=GastoD.Referencia
GastoD.Referencia=GastoD.Cantidad
GastoD.Cantidad=CantidadReservada
CantidadReservada=CantidadOrdenada
CantidadOrdenada=CantidadPendiente
CantidadPendiente=GastoD.ImporteConImpuesto
GastoD.ImporteConImpuesto=GastoD.Precio
GastoD.Precio=GastoD.Importe
GastoD.Importe=GastoD.Provision
GastoD.Provision=GastoD.PorcentajeDeducible
GastoD.PorcentajeDeducible=Ejercido
Ejercido=Pendiente
Pendiente=Disponible
Disponible=GastoD.TipoImpuesto1
GastoD.TipoImpuesto1=GastoD.Impuesto1
GastoD.Impuesto1=GastoD.Impuestos
GastoD.Impuestos=GastoD.TipoImpuesto2
GastoD.TipoImpuesto2=GastoD.Impuesto2
GastoD.Impuesto2=GastoD.Impuestos2
GastoD.Impuestos2=GastoD.TipoImpuesto3
GastoD.TipoImpuesto3=GastoD.Impuesto3
GastoD.Impuesto3=GastoD.Impuestos3
GastoD.Impuestos3=GastoD.TipoImpuesto4
GastoD.TipoImpuesto4=GastoD.Impuesto5
GastoD.Impuesto5=GastoD.TipoRetencion1
GastoD.TipoRetencion1=Ret1
Ret1=GastoD.Retencion
GastoD.Retencion=GastoD.TipoRetencion2
GastoD.TipoRetencion2=Ret2
Ret2=GastoD.Retencion2
GastoD.Retencion2=GastoD.TipoRetencion3
GastoD.TipoRetencion3=Ret3
Ret3=GastoD.Retencion3
GastoD.Retencion3=Total
Total=GastoD.PresupuestoEsp
GastoD.PresupuestoEsp=GastoD.ContUso
GastoD.ContUso=GastoD.ContUso2
GastoD.ContUso2=GastoD.ContUso3
GastoD.ContUso3=GastoD.ClavePresupuestal
GastoD.ClavePresupuestal=GastoD.ABC
GastoD.ABC=GastoD.VIN
GastoD.VIN=GastoD.Espacio
GastoD.Espacio=Espacio.NumeroEconomico
Espacio.NumeroEconomico=GastoD.Proyecto
GastoD.Proyecto=GastoD.Actividad
GastoD.Actividad=GastoD.UEN
GastoD.UEN=GastoD.AFArticulo
GastoD.AFArticulo=GastoD.AFSerie
GastoD.AFSerie=GastoD.Lectura
GastoD.Lectura=GastoD.LecturaAnterior
GastoD.LecturaAnterior=Consumo
Consumo=GastoD.DepartamentoDetallista
GastoD.DepartamentoDetallista=GastoD.SustentoComprobante
GastoD.SustentoComprobante=GastoD.DerechoDevolucion
GastoD.DerechoDevolucion=GastoD.TipoComprobante
GastoD.TipoComprobante=GastoD.Establecimiento
GastoD.Establecimiento=GastoD.PuntoEmision
GastoD.PuntoEmision=GastoD.SecuencialSRI
GastoD.SecuencialSRI=GastoD.AutorizacionSRI
GastoD.AutorizacionSRI=GastoD.VigenteA
GastoD.VigenteA=GastoD.Comprobante
GastoD.Comprobante=GastoD.FechaContableMov
GastoD.FechaContableMov=GastoD.SecuenciaRetencion
GastoD.SecuenciaRetencion=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=Personal.Nombre
Personal.Nombre=Personal.ApellidoPaterno
Personal.ApellidoPaterno=Personal.ApellidoMaterno
Personal.ApellidoMaterno=(Fin)

[Detalle.ListaOrden]
(Inicio)=GastoD.Renglon	(Acendente)
GastoD.Renglon	(Acendente)=GastoD.RenglonSub	(Acendente)
GastoD.RenglonSub	(Acendente)=(Fin)

[Detalle.ListaAcciones]
(Inicio)=Observaciones
Observaciones=LocalPolitica
LocalPolitica=LocalProyInfo
LocalProyInfo=ProvExpress
ProvExpress=(Fin)





























































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Gasto.Acreedor
Gasto.Acreedor=Prov.Nombre
Prov.Nombre=Gasto.FechaEmision
Gasto.FechaEmision=Gasto.Vencimiento
Gasto.Vencimiento=ImporteTotal
ImporteTotal=Gasto.Saldo
Gasto.Saldo=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=(por Autorizar)
(por Autorizar)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=RECURRENTE
RECURRENTE=CONCLUIDO
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































[MovImpuesto.ListaEnCaptura]
(Inicio)=MovImpuestoMov.Impuesto1
MovImpuestoMov.Impuesto1=MovImpuestoMov.Impuesto2
MovImpuestoMov.Impuesto2=MovImpuestoMov.Impuesto3
MovImpuestoMov.Impuesto3=MovImpuestoMov.Importe1
MovImpuestoMov.Importe1=MovImpuestoMov.Importe2
MovImpuestoMov.Importe2=MovImpuestoMov.Importe3
MovImpuestoMov.Importe3=MovImpuestoMov.Retencion1
MovImpuestoMov.Retencion1=MovImpuestoMov.Retencion2
MovImpuestoMov.Retencion2=MovImpuestoMov.Retencion3
MovImpuestoMov.Retencion3=MovImpuestoMov.ContUso
MovImpuestoMov.ContUso=MovImpuestoMov.ContUso2
MovImpuestoMov.ContUso2=MovImpuestoMov.ContUso3
MovImpuestoMov.ContUso3=(Fin)


[Acciones.ContParalelaMovDato]
Nombre=ContParalelaMovDato
Boton=0
Menu=&Edici�n
NombreDesplegar=Datos Contabilidad Paralela
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ContParalelaMovDato
Antes=S








ActivoCondicion=Gasto:Gasto.Estatus en(EstatusPendiente, EstatusConcluido)
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)
VisibleCondicion=fnContParalela y(Usuario.CONTPModificarDatosMov)










































[Acciones.ActivoFijo]
Nombre=ActivoFijo
Boton=0
Menu=&Edici�n
NombreDesplegar=&Activo Fijo
EnMenu=S
Antes=S



























































































































































































GuardarAntes=S






































































































Visible=S

































































































TipoAccion=Formas
Multiple=S

ListaAccionesMultiples=(Lista)
ActivoCondicion=((Gasto:Gasto.AF) y (Gasto:Gasto.Estatus noen (EstatusCancelado,EstatusConcluido)))
AntesExpresiones=GuardarCambios<BR>Asigna(Info.ID,Gasto:Gasto.ID)<BR>Asigna(Info.Mov,Gasto:Gasto.Mov)<BR>Asigna(Info.MovID,Gasto:Gasto.MovID)<BR>Asigna(Info.Modulo,<T>GAS<T>)<BR>Asigna(Info.Renglon,GastoD:GastoD.Renglon)<BR>Asigna(Info.Estatus,Gasto:Gasto.Estatus)<BR>GuardarCambios  <BR>Asigna(Info.Articulo, SQL(<T>SELECT AFArticulo FROM Gasto WHERE ID = :n<T>,Gasto:Gasto.ID ))<BR>Asigna(Info.Serielote, SQL(<T>SELECT AFSerie FROM Gasto WHERE ID = :n<T>, Gasto:Gasto.ID))<BR>//Asigna(Info.Renglon,)






[Acciones.ActivoFijo.Guardar]
Nombre=Guardar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.ActivoFijo.Forma]
Nombre=Forma
Boton=0
TipoAccion=Formas
ClaveAccion=AuxiliarActivoFijo
Activo=S
ConCondicion=S
EjecucionCondicion=SQL(<T>SELECT COUNT(*) FROM GASTOD WHERE ID = :nID<T>, Gasto:Gasto.ID) >= 1
EjecucionMensaje=<BR><T>Debe agregar al menos un Concepto<T>
EjecucionConError=S
Visible=S

[Acciones.ActivoFijo.ListaAccionesMultiples]
(Inicio)=Guardar
Guardar=Forma
Forma=(Fin)

[Acciones.InfoRet]
Nombre=InfoRet
Boton=0
Menu=&Edici�n
NombreDesplegar=Informaci�n Retenciones
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S


Expresion=Si SQL(<T>SELECT ISNULL(CFDRetencionTimbrado, 0) FROM Gasto WHERE ID = :nID<T>, Gasto:Gasto.ID) = 0<BR>  Entonces<BR>    Forma(<T>CFDIRetGastoComp<T>)<BR>  Sino<BR>    Forma(<T>CFDIRetGastoCompInfo<T>)<BR>Fin
EjecucionCondicion=ConDatos(Gasto:Gasto.ID)
AntesExpresiones=Asigna(Info.ID,Gasto:Gasto.ID)<BR>Asigna(Info.Mov,Gasto:Gasto.Mov)<BR>Asigna(Info.MovID,Gasto:Gasto.MovID)<BR>Asigna(Info.Anuncio, <T><T>)<BR>Asigna(Info.Anuncio, SQL(<T>SELECT TOP 1 CFDIRetSATRetencion.Complemento FROM CFDIRetencionConcepto JOIN CFDIRetSATRetencion ON CFDIRetencionConcepto.CFDIRetClave = CFDIRetSATRetencion.Clave JOIN GastoD ON CFDIRetencionConcepto.Concepto = GastoD.Concepto WHERE GastoD.ID = :nID AND CFDIRetSATRetencion.Complemento IS NOT NULL<T>, GastoD:GastoD.ID))
[Acciones.InfoCompEnajenacionSAT]
Nombre=InfoCompEnajenacionSAT
Boton=0
Menu=&Edici�n
NombreDesplegar=Informaci�n Complemento Enajenaci�n Acciones SAT
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S









































































Expresion=Si<BR>    ConDatos(Info.Concepto) = Falso<BR>Entonces<BR>    Asigna(Info.Concepto, Mayusculas(SQL(<T>SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(concepto, :tA1, :tA2), :tE1, :tE2), :tI1, :tI2), :tO1, :tO2), :tU1, :tU2) FROM GASTOD WHERE ID = :nID<T>,<T>�<T>, <T>a<T>, <T>�<T>,<T>e<T>, <T>�<T>, <T>i<T>, <T>�<T>, <T>o<T>, <T>�<T>,<T>u<T>,Gasto:Gasto.ID)))<BR>Sino<BR>    Si<BR>        Info.Concepto <> <T>ENAJENACION DE ACCIONES<T><BR>    Entonces<BR>            Asigna(Info.Concepto, Mayusculas(SQL(<T>SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(concepto, :tA1, :tA2), :tE1, :tE2), :tI1, :tI2), :tO1, :tO2), :tU1, :tU2) FROM GASTOD WHERE ID = :nID<T>,<T>�<T>, <T>a<T>, <T>�<T>,<T>e<T>, <T>�<T>, <T>i<T>, <T>�<T>, <T>o<T>, <T>�<T>,<T>u<T>,Gasto:Gasto.ID)))<BR>    Fin<BR>Fin<BR>Si<BR>    Info.Concepto = <T>ENAJENACION DE ACCIONES<T><BR>Entonces<BR>    Si<BR>        SQL(<T>SELECT ISNULL(CFDRetencionTimbrado, 0) FROM Gasto WHERE ID = :nID<T>, Gasto:Gasto.ID) = Falso<BR>    Entonces<BR>        Forma(<T>CFDIEnajenacionGastoComplemento<T>)<BR>    Sino<BR>        Forma(<T>CFDIEnajenacionGastoComplementoInfo<T><BR>    Fin<BR>Sino<BR>    Si<BR>        Info.Concepto <> <T>ENAJENACION DE ACCIONES<T><BR>    Entonces<BR>        Error(<T>Funciona �nicamente con el Concepto de Enajenacion de Acciones<T>)<BR>        Si<BR>            ConDatos(Info.Concepto) = Falso<BR>        Entonces<BR>            Asigna(Info.Concepto, Mayusculas(SQL(<T>SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(concepto, :tA1, :tA2), :tE1, :tE2), :tI1, :tI2), :tO1, :tO2), :tU1, :tU2) FROM GASTOD WHERE ID = :nID<T>,<T>�<T>, <T>a<T>, <T>�<T>,<T>e<T>, <T>�<T>, <T>i<T>, <T>�<T>, <T>o<T>, <T>�<T>,<T>u<T>,Gasto:Gasto.ID)))<BR>        Sino<BR>            Si<BR>                Info.Concepto <> <T>ENAJENACION DE ACCIONES<T><BR>            Entonces<BR>                Asigna(Info.Concepto, Mayusculas(SQL(<T>SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(concepto, :tA1, :tA2), :tE1, :tE2), :tI1, :tI2), :tO1, :tO2), :tU1, :tU2) FROM GASTOD WHERE ID = :nID<T>,<T>�<T>, <T>a<T>, <T>�<T>,<T>e<T>, <T>�<T>, <T>i<T>, <T>�<T>, <T>o<T>, <T>�<T>,<T>u<T>,Gasto:Gasto.ID)))<BR>            Fin<BR>        Fin<BR>            Si<BR>                Info.Concepto = <T>ENAJENACION DE ACCIONES<T><BR>            Entonces<BR>                Si<BR>                    SQL(<T>SELECT ISNULL(CFDRetencionTimbrado, 0) FROM Gasto WHERE ID = :nID<T>, Gasto:Gasto.ID) = Falso<BR>                Entonces<BR>                    Forma(<T>CFDIEnajenacionGastoComplemento<T>)<BR>                Sino<BR>                    Forma(<T>CFDIEnajenacionGastoComplementoInfo<T>)<BR>                Fin<BR>            Sino<BR>                Si<BR>                    Info.Concepto <> <T>ENAJENACION DE ACCIONES<T><BR>                Entonces<BR>                    Error(<T>Funciona �nicamente con el Concepto de Enajenacion de Acciones<T>)<BR>                Sino<BR>                    Error(<T>Funciona �nicamente para el Complemento Enajenacion de Acciones<T>)<BR>                Fin<BR>            Fin<BR>                Sino<BR>                    Error(<T>Funciona �nicamente para el Complemento Enajenacion de Acciones<T>)<BR>                Fin<BR>            Fin
AntesExpresiones=Asigna(Info.ID,Gasto:Gasto.ID)<BR>Asigna(Info.Mov,Gasto:Gasto.Mov)<BR>Asigna(Info.MovID,Gasto:Gasto.MovID)<BR>Asigna(Info.Anuncio, <T><T>)<BR>Asigna(Info.Anuncio, SQL(<T>SELECT TOP 1 CFDIRetSATRetencion.Complemento<BR>                          FROM CFDIRetencionConcepto<BR>                          JOIN CFDIRetSATRetencion ON CFDIRetencionConcepto.CFDIRetClave = CFDIRetSATRetencion.Clave<BR>                          JOIN GastoD ON CFDIRetencionConcepto.Concepto = GastoD.Concepto<BR>                          WHERE GastoD.ID = :nID<BR>                          AND CFDIRetSATRetencion.Complemento IS NOT NULL<T>, GastoD:GastoD.ID))
VisibleCondicion=((SQL(<T>SELECT ISNULL(SubClave, :tVacio) FROM MovTipo WHERE Modulo = :tModulo AND Mov = :tMov<T>, <T><T>, <T>GAS<T>, Gasto:Gasto.Mov) = <T>GAS.ESTRETSATENEJAC<T>) o (SQL(<T>SELECT ISNULL(SubClave, :tVacio) FROM MovTipo WHERE Modulo = :tModulo AND Mov = :tMov<T>, <T><T>, <T>GAS<T>, Gasto:Gasto.Mov) = <T>GAS.ENJ<T>)) y (Gasto:Gasto.Estatus en(EstatusSinAfectar, EstatusProcesar, EstatusBorrador, EstatusPendiente, EstatusConcluido))
[Acciones.InfoCompInteresesSAT]
Nombre=InfoCompInteresesSAT
Boton=0
Menu=&Edici�n
NombreDesplegar=Informaci�n Complemento Intereses SAT
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S

















































Expresion=Si<BR>    ConDatos(Info.Concepto) = Falso<BR>Entonces<BR>    Asigna(Info.Concepto, Mayusculas(SQL(<T>SELECT Concepto FROM GASTOD WHERE ID = :nID<T>,Gasto:Gasto.ID)))<BR>Sino<BR>    Si<BR>        Info.Concepto <> <T>INTERESES<T><BR>    Entonces<BR>        Asigna(Info.Concepto, Mayusculas(SQL(<T>SELECT Concepto FROM GASTOD WHERE ID = :nID<T>,Gasto:Gasto.ID)))<BR>    Fin<BR>Fin<BR>Si<BR>    Info.Concepto = <T>INTERESES<T><BR>Entonces<BR>    Si<BR>        SQL(<T>SELECT ISNULL(CFDRetencionTimbrado, 0) FROM Gasto WHERE ID = :nID<T>, Gasto:Gasto.ID) = Falso<BR>    Entonces<BR>        Forma(<T>CFDIRetSATIntereses<T>)<BR>    Sino<BR>        Forma(<T>CFDIRetSATInteresesInfo<T>)<BR>    Fin<BR>Sino<BR>    Si<BR>        Info.Concepto <> <T>INTERESES<T><BR>    Entonces<BR>        Error(<T>Funciona �nicamente con el Concepto de Intereses<T>)<BR>    Sino<BR>        Error(<T>Funciona �nicamente para el Complemento Intereses<T>)<BR>    Fin<BR>Fin
AntesExpresiones=Asigna(Info.ID,Gasto:Gasto.ID)<BR>Asigna(Info.Mov,Gasto:Gasto.Mov)<BR>Asigna(Info.MovID,Gasto:Gasto.MovID)<BR>Asigna(Info.Anuncio, <T><T>)<BR>Asigna(Info.Anuncio, SQL(<T>SELECT TOP 1 CFDIRetSATRetencion.Complemento<BR>                          FROM CFDIRetencionConcepto<BR>                          JOIN CFDIRetSATRetencion ON CFDIRetencionConcepto.CFDIRetClave = CFDIRetSATRetencion.Clave<BR>                          JOIN GastoD ON CFDIRetencionConcepto.Concepto = GastoD.Concepto<BR>                          WHERE GastoD.ID = :nID<BR>                          AND CFDIRetSATRetencion.Complemento IS NOT NULL<T>, GastoD:GastoD.ID))
VisibleCondicion=((SQL(<T>SELECT ISNULL(SubClave, :tVacio) FROM MovTipo WHERE Modulo = :tModulo AND Mov = :tMov<T>, <T><T>, <T>GAS<T>, Gasto:Gasto.Mov) = <T>GAS.ESTRETSATINT<T>) o (SQL(<T>SELECT ISNULL(SubClave, :tVacio) FROM MovTipo WHERE Modulo = :tModulo AND Mov = :tMov<T>, <T><T>, <T>GAS<T>, Gasto:Gasto.Mov) = <T>GAS.INT<T>)) y (Gasto:Gasto.Estatus en(EstatusSinAfectar, EstatusProcesar, EstatusBorrador, EstatusPendiente, EstatusConcluido)))
[Acciones.InfoCompDividendosSAT]
Nombre=InfoCompDividendosSAT
Boton=0
Menu=&Edici�n
NombreDesplegar=Informaci�n Complemento SAT
GuardarAntes=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S

































































































Expresion=Si<BR>    ConDatos(Info.Concepto) = Falso<BR>Entonces<BR>    Asigna(Info.Concepto, Mayusculas(SQL(<T>SELECT Concepto FROM GASTOD WHERE ID = :nID<T>,Gasto:Gasto.ID)))<BR>Sino<BR>    Si<BR>        Info.Concepto <> <T>DIVIDENDOS<T><BR>    Entonces<BR>        Asigna(Info.Concepto, Mayusculas(SQL(<T>SELECT Concepto FROM GASTOD WHERE ID = :nID<T>,Gasto:Gasto.ID)))<BR>    Fin<BR>Fin<BR>Si<BR>    Info.Concepto = <T>DIVIDENDOS<T><BR>Entonces<BR>    Si<BR>        SQL(<T>SELECT ISNULL(CFDRetencionTimbrado, 0) FROM Gasto WHERE ID = :nID<T>, Gasto:Gasto.ID) = Falso<BR>    Entonces<BR>        Forma(<T>CFDIRetGastoComplementoEfectivo<T>)<BR>    Sino<BR>        Forma(<T>CFDIRetGastoComplementoEfectivo<T>)<BR>    Fin<BR>        Sino<BR>            Si<BR>                Info.Concepto <> <T>DIVIDENDOS<T><BR>            Entonces<BR>                Error(<T>Funciona �nicamente con el Concepto de Dividendos<T>)<BR>            Sino<BR>                Error(<T>Funciona �nicamente para el Complemento Dividendo<T>)<BR>            Fin<BR>Fin
AntesExpresiones=Asigna(Info.ID,Gasto:Gasto.ID)<BR>Asigna(Info.Mov,Gasto:Gasto.Mov)<BR>Asigna(Info.MovID,Gasto:Gasto.MovID)<BR>Asigna(Info.Anuncio, <T><T>)<BR>Asigna(Info.Anuncio, SQL(<T>SELECT TOP 1 CFDIRetSATRetencion.Complemento<BR>                          FROM CFDIRetencionConcepto<BR>                          JOIN CFDIRetSATRetencion ON CFDIRetencionConcepto.CFDIRetClave = CFDIRetSATRetencion.Clave<BR>                          JOIN GastoD ON CFDIRetencionConcepto.Concepto = GastoD.Concepto<BR>                          WHERE GastoD.ID = :nID<BR>                          AND CFDIRetSATRetencion.Complemento IS NOT NULL<T>, GastoD:GastoD.ID))
VisibleCondicion=((SQL(<T>SELECT ISNULL(SubClave, :tVacio) FROM MovTipo WHERE Modulo = :tModulo AND Mov = :tMov<T>, <T><T>, <T>GAS<T>, Gasto:Gasto.Mov) = <T>GAS.ESTRETSAT<T>) o (SQL(<T>SELECT ISNULL(SubClave, :tVacio) FROM MovTipo WHERE Modulo = :tModulo AND Mov = :tMov<T>, <T><T>, <T>GAS<T>, Gasto:Gasto.Mov) = <T>GAS.DIV<T>)) y (Gasto:Gasto.Estatus en(EstatusSinAfectar, EstatusProcesar, EstatusBorrador, EstatusPendiente, EstatusConcluido)))





































































































































[Ficha.Gasto.ConceptoFE]
Carpeta=Ficha
Clave=Gasto.ConceptoFE
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco














[Ficha.ListaEnCaptura]
(Inicio)=Gasto.Mov
Gasto.Mov=Gasto.MovID
Gasto.MovID=Gasto.Proyecto
Gasto.Proyecto=Gasto.UEN
Gasto.UEN=Gasto.Moneda
Gasto.Moneda=Gasto.TipoCambio
Gasto.TipoCambio=Gasto.Prioridad
Gasto.Prioridad=Gasto.FechaEmision
Gasto.FechaEmision=Gasto.Periodicidad
Gasto.Periodicidad=Gasto.Actividad
Gasto.Actividad=Gasto.AFArticulo
Gasto.AFArticulo=Gasto.AFSerie
Gasto.AFSerie=Gasto.Acreedor
Gasto.Acreedor=Prov.Nombre
Prov.Nombre=Gasto.FechaRequerida
Gasto.FechaRequerida=Gasto.Observaciones
Gasto.Observaciones=Gasto.CtaDinero
Gasto.CtaDinero=Gasto.FormaPago
Gasto.FormaPago=Gasto.Clase
Gasto.Clase=Gasto.SubClase
Gasto.SubClase=Gasto.Importe
Gasto.Importe=Gasto.Condicion
Gasto.Condicion=Gasto.Vencimiento
Gasto.Vencimiento=Gasto.VigenciaDesde
Gasto.VigenciaDesde=Gasto.VigenciaHasta
Gasto.VigenciaHasta=Gasto.MovAplica
Gasto.MovAplica=Gasto.MovAplicaID
Gasto.MovAplicaID=Gasto.Multiple
Gasto.Multiple=Gasto.TieneRetencion
Gasto.TieneRetencion=Gasto.AF
Gasto.AF=Gasto.ConVigencia
Gasto.ConVigencia=Gasto.Saldo
Gasto.Saldo=Gasto.ConceptoFE
Gasto.ConceptoFE=(Fin)























































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Contrato
Contrato=Antecedentes
Antecedentes=Comentarios
Comentarios=Detalle
Detalle=FormaExtraValor
FormaExtraValor=CentrosCostos
CentrosCostos=MovImpuesto
MovImpuesto=Agrupadores
Agrupadores=Anexo
Anexo=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=MovCopiar
MovCopiar=CopiarMeses
CopiarMeses=Abrir
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
Afectar=Autorizar
Autorizar=Desafectar
Desafectar=Consecutivo
Consecutivo=Eliminar
Eliminar=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=CPReservarFlujo
CPReservarFlujo=Totalizar
Totalizar=Tareas
Tareas=Anexos
Anexos=ConceptoExpress
ConceptoExpress=PresupuestoEsp
PresupuestoEsp=Anterior
Anterior=Siguiente
Siguiente=DineroDepositosAnticipados
DineroDepositosAnticipados=Infomacion
Infomacion=ArtInfo
ArtInfo=InfoCtaDinero
InfoCtaDinero=ProyInfo
ProyInfo=PresupuestoInfo
PresupuestoInfo=Prorrateo
Prorrateo=ActivoFijo
ActivoFijo=Tiempo
Tiempo=Politica
Politica=MovPos
MovPos=ContParalelaMovDato
ContParalelaMovDato=Navegador
Navegador=Cerrar
Cerrar=BotonCerrar
BotonCerrar=InfoRet
InfoRet=InfoCompDividendosSAT
InfoCompDividendosSAT=InfoCompInteresesSAT
InfoCompInteresesSAT=InfoCompEnajenacionSAT
InfoCompEnajenacionSAT=Otros1
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
&Archivo=&Edici�n
&Edici�n=&Ver
&Ver=&Otros
&Otros=(Fin)

[Forma.PlantillasExcepciones]
(Inicio)=Gasto:Gasto.FechaEmision
Gasto:Gasto.FechaEmision=Gasto:Gasto.OrigenTipo
Gasto:Gasto.OrigenTipo=Gasto:Gasto.Origen
Gasto:Gasto.Origen=Gasto:Gasto.OrigenID
Gasto:Gasto.OrigenID=Gasto:Gasto.Poliza
Gasto:Gasto.Poliza=Gasto:Gasto.PolizaID
Gasto:Gasto.PolizaID=Gasto:Gasto.Ejercicio
Gasto:Gasto.Ejercicio=Gasto:Gasto.Periodo
Gasto:Gasto.Periodo=Gasto:Gasto.FechaRegistro
Gasto:Gasto.FechaRegistro=Gasto:Gasto.FechaConclusion
Gasto:Gasto.FechaConclusion=Gasto:Gasto.FechaCancelacion
Gasto:Gasto.FechaCancelacion=Gasto:Gasto.Saldo
Gasto:Gasto.Saldo=Gasto:Gasto.Usuario
Gasto:Gasto.Usuario=Gasto:Gasto.Estatus
Gasto:Gasto.Estatus=GastoD:GastoD.Fecha
GastoD:GastoD.Fecha=(Fin)

[Forma.CamposProrrateo]
(Inicio)=GastoD.Importe
GastoD.Importe=GastoD.Retencion
GastoD.Retencion=GastoD.Retencion2
GastoD.Retencion2=GastoD.Impuestos
GastoD.Impuestos=(Fin)

[Forma.ExcelColumnas]
(Inicio)=GastoD.Fecha
GastoD.Fecha=GastoD.Concepto
GastoD.Concepto=GastoD.Referencia
GastoD.Referencia=GastoD.Cantidad
GastoD.Cantidad=GastoD.Precio
GastoD.Precio=GastoD.Importe
GastoD.Importe=GastoD.Retencion
GastoD.Retencion=GastoD.Retencion2
GastoD.Retencion2=GastoD.Impuestos
GastoD.Impuestos=GastoD.ContUso
GastoD.ContUso=GastoD.Proyecto
GastoD.Proyecto=GastoD.Actividad
GastoD.Actividad=(Fin)
