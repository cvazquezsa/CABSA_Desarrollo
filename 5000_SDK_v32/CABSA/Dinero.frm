[Forma]
Clave=Dinero
Nombre=Movimientos de Tesorería
Icono=0
Modulos=DIN
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=205
PosicionInicialArriba=51
PosicionInicialAltura=590
PosicionInicialAncho=953
EsMovimiento=S
TituloAuto=S
DialogoAbrir=S
PosicionSeccion1=61
Totalizadores=S
PosicionSeccion2=93
BarraAyuda=S
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
MovModulo=DIN
BarraAyudaBold=S
PosicionInicialAlturaCliente=574
PosicionSec1=357
PosicionSec2=450

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Importe, Nulo)<BR>Asigna(Info.tipo,Nulo)
MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Dinero
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
PestanaNombre=Datos Generales

[Ficha.Dinero.Mov]
Carpeta=Ficha
Clave=Dinero.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[Ficha.Dinero.MovID]
Carpeta=Ficha
Clave=Dinero.MovID
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
Editar=S
IgnoraFlujo=S

[Ficha.Dinero.Proyecto]
Carpeta=Ficha
Clave=Dinero.Proyecto
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
EditarConBloqueo=N
Pegado=S

[Ficha.Dinero.FechaEmision]
Carpeta=Ficha
Clave=Dinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Dinero.CtaDinero]
Carpeta=Ficha
Clave=Dinero.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.Dinero.CtaDineroDestino]
Carpeta=Ficha
Clave=Dinero.CtaDineroDestino
Editar=S
ValidaNombre=S
3D=S
Tamano=25
LineaNueva=S
Pegado=N
ColorFondo=Blanco

[Ficha.Dinero.BeneficiarioNombre]
Carpeta=Ficha
Clave=Dinero.BeneficiarioNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
EspacioPrevio=N
ColorFondo=Blanco

[Ficha.Dinero.Concepto]
Carpeta=Ficha
Clave=Dinero.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.Dinero.Referencia]
Carpeta=Ficha
Clave=Dinero.Referencia
Editar=S
ValidaNombre=S
3D=S
Tamano=25
LineaNueva=S
EditarConBloqueo=N
EspacioPrevio=N
ColorFondo=Blanco

[Ficha.Dinero.Importe]
Carpeta=Ficha
Clave=Dinero.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco

[Ficha.Dinero.Observaciones]
Carpeta=Ficha
Clave=Dinero.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco
EditarConBloqueo=N

[Detalle]
Estilo=Hoja
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=DineroD
Fuente={MS Sans Serif, 8, Negro, []}
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
OtroOrden=S
Detalle=S
VistaMaestra=Dinero
LlaveLocal=DineroD.ID
LlaveMaestra=Dinero.ID
ControlRenglon=S
CampoRenglon=DineroD.Renglon
ListaOrden=(Lista)
HojaFondoGrisAuto=S
PermiteLocalizar=S
HojaAjustarColumnas=S
ValidarCampos=S
ListaCamposAValidar=(Lista)

CondicionVisible=Dinero:Dinero.ConDesglose o (no Dinero:Dinero.Directo)
[Detalle.DineroD.Importe]
Carpeta=Detalle
Clave=DineroD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.DineroD.Referencia]
Carpeta=Detalle
Clave=DineroD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=DineroA
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
ListaOrden=Dinero.ID<TAB>(Decendente)
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
FiltroEstatusDefault=PENDIENTE
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Dinero.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroPredefinido=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroTodoNombre=Todo
FiltroNullNombre=Cobros y Pagos
FiltroRespetar=S
FiltroAncho=15
PestanaOtroNombre=S
PestanaNombre=movimientos
FiltroFechasNormal=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CtaDinero
BusquedaRespetarUsuario=S
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarFiltros=S
MenuLocal=S
BusquedaRespetarControlesNum=S
ListaAcciones=(Lista)
FiltroFechasCancelacion=Dinero.FechaCancelacion
FiltroSucursales=S
FiltroAplicaO=Dinero.CtaDineroDestino
FiltroAplicaEn=Dinero.CtaDinero
FiltroValida1=CtaDineroCat
FiltroAplicaEn1=CtaDinero.Categoria
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CtaDineroGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CtaDineroFam
FiltroAplicaEn2=CtaDinero.Grupo
FiltroAplicaEn3=CtaDinero.Familia
FiltroListas=S
FiltroListasRama=DIN
FiltroListasAplicaEn=Dinero.CtaDinero
FiltroEnOrden=S
FiltroArbol=Cuentas Dinero
FiltroArbolAplica=CtaDinero.Rama

IconosNombre=DineroA:Dinero.Mov+<T> <T>+DineroA:Dinero.MovID
BusquedaSelCampo=S
[(Carpeta Abrir).Dinero.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Dinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).Dinero.CtaDinero]
Carpeta=(Carpeta Abrir)
Clave=Dinero.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.Columnas]
Importe=102
Referencia=113
FormaPago=121
Aplica=94
AplicaID=64
ContUso=88
Institucion=83

ContUso2=124
ContUso3=124
CtaDinero=64
CtaDineroDestino=78
Moneda=64
TipoCambio=64
ImporteDetalle=66
ImporteTipoCambioD=154
[(Carpeta Abrir).Columnas]
0=151
1=73

2=50
3=47
4=47
5=47
6=47
7=47
8=47
[Detalle.DineroD.FormaPago]
Carpeta=Detalle
Clave=DineroD.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

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
Totalizadores1=Importe Total
Totalizadores2=Caso  fnSubMovTipo( <T>DIN<T>, Dinero:Dinero.Mov )     Es <T>DIN.AMULTIMONEDA<T> Entonces (Suma(DineroD:ImporteTipoCambioD)) Es ,<T>DIN.CMULTIMONEDA<T> Entonces (Suma(DineroD:ImporteTipoCambioD))    ES ,<T>DIN.CPMULTIMONEDA<T> Entonces (Suma(DineroD:ImporteTipoCambioD)) Sino  Suma( DineroD:DineroD.Importe ) Fin
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Importe Total

CondicionVisible=Dinero:Dinero.ConDesglose o (no Dinero:Dinero.Directo)
[Ficha.ImporteTotal]
Carpeta=Ficha
Clave=ImporteTotal
Editar=S
3D=S
Tamano=17
ColorFondo=Plata
Efectos=[Negritas]

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=Si
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=Si
EnMenu=Si
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=Si
Activo=Si

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
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=S
Activo=S
Antes=S
ConCondicion=S
EjecucionConError=S

EjecucionCondicion=Si(General.MovConcurrente y ConDatos(Dinero:Dinero.ID) y (Dinero:Dinero.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, Dinero:Dinero.ID, <T>DIN<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>(MovTipoEn(<T>DIN<T>,Dinero:Dinero.Mov,(DIN.SD, DIN.SCH)) o ConDatos(Dinero:Dinero.CtaDinero))
EjecucionMensaje=<T>Falta Indicar la Cuenta<T>
AntesExpresiones=Si<BR>  (Dinero:Dinero.ConDesglose o (no Dinero:Dinero.Directo)) y (MovTipo(<T>DIN<T>,Dinero:Dinero.Mov) noen (DIN.CB,DIN.AB))<BR>Entonces<BR> // Asigna(Dinero:Dinero.Importe, Suma(DineroD:DineroD.Importe))<BR> Caso  fnSubMovTipo( <T>DIN<T>, Dinero:Dinero.Mov )<BR> Es <T>DIN.AMULTIMONEDA<T> Entonces Asigna(Dinero:Dinero.Importe,Suma(DineroD:ImporteTipoCambioD))<BR> Es <T>DIN.CMULTIMONEDA<T> Entonces Asigna(Dinero:Dinero.Importe,Suma(DineroD:ImporteTipoCambioD))<BR> Es <T>DIN.CPMULTIMONEDA<T> Entonces Asigna(Dinero:Dinero.Importe,Suma(DineroD:ImporteTipoCambioD))<BR> Sino  Asigna(Dinero:Dinero.Importe,Suma( DineroD:DineroD.Importe )) Fin<BR>Fin
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

[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
Efectos=[Negritas]

[Ficha.Dinero.Impuestos]
Carpeta=Ficha
Clave=Dinero.Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[Ficha.Dinero.ConDesglose]
Carpeta=Ficha
Clave=Dinero.ConDesglose
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=Si
EspacioPrevio=Si
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Visible=Si
Activo=Si

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
Visible=S
GuardarAntes=S
RefrescarDespues=S
ConNombreExp=
ConCondicion=S
Antes=S
DespuesGuardar=S

Expresion=Si<BR>  (Dinero:Dinero.Estatus=EstatusPendiente) y MovTipoEn(<T>DIN<T>, Dinero:Dinero.Mov, (DIN.I, DIN.E, DIN.F, DIN.SD, DIN.SCH, DIN.INV, DIN.TI)))<BR>Entonces<BR>  Asigna(Info.Modulo, <T>DIN<T>)<BR>  Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>  Asigna(Info.MovID, Dinero:Dinero.MovID)<BR>  Asigna(Afectar.Modulo, <T>DIN<T>)<BR>  Asigna(Afectar.ID, Dinero:Dinero.ID)<BR>  Asigna(Afectar.Mov, Dinero:Dinero.Mov)<BR>  Asigna(Afectar.MovID, Dinero:Dinero.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Dinero<T>)<BR>  Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si<BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Caso MovTipo(<T>DIN<T>,Dinero:Dinero.Mov)<BR>      Es DIN.I   Entonces Dialogo(<T>GenerarDineroIngreso<T>)<BR>      Es DIN.SD  Entonces Dialogo(<T>GenerarDineroIngreso<T>)<BR>      Es DIN.E   Entonces Dialogo(<T>GenerarDineroEgreso<T>)<BR>      Es DIN.SCH Entonces Dialogo(<T>GenerarDineroEgreso<T>)<BR>      Es DIN.INV Entonces Dialogo(<T>GenerarDineroInversion<T>)<BR>      Es DIN.TI  Entonces Dialogo(<T>GenerarDineroTraspaso<T>)<BR>    Fin<BR>  Fin<BR>Sino<BR>  //MEJORA6013<BR>  Si<BR>    (MovTipo(<T>DIN<T>,Dinero:Dinero.Mov) = DIN.CH) Y (Dinero:Dinero.Estatus = EstatusConcluido) Y (Dinero:Dinero.ChequeDevuelto <> VERDADERO)<BR>  Entonces<BR>    Si Dialogo(<T>ChequeDevueltoEstaSeguro<T>) Entonces<BR>      INFORMACION(SQL(<T>EXEC spDineroChequeDevueltoCxp :nEstacion, :nID, :tUsuario<T>,EstacionTrabajo, Dinero:Dinero.ID, Usuario))<BR>    Fin<BR>  Sino<BR>    Afectar(<T>DIN<T>, Dinero:Dinero.ID, Dinero:Dinero.Mov, Dinero:Dinero.MovID, <T>Todo<T>, <T><T>, <T>Dinero<T>)<BR>    Si<BR>      Dinero:CtaDinero.Tipo=<T>Caja<T><BR>    Entonces<BR>      Asigna(Temp.Texto, SQL(<T>spAlertaCtaDinero :tEmp, :tCta<T>, Empresa, Dinero:Dinero.CtaDinero))<BR>      Si(ConDatos(Temp.Texto), Precaucion(Temp.Texto))<BR>      Si<BR>        ConDatos(Dinero:Dinero.CtaDineroDestino)<BR>      Entonces<BR>        Asigna(Temp.Texto, SQL(<T>spAlertaCtaDinero :tEmp, :tCta<T>, Empresa, Dinero:Dinero.CtaDineroDestino))<BR>        Si(ConDatos(Temp.Texto), Precaucion(Temp.Texto))<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Si  (MovTipo(<T>DIN<T>,Dinero:Dinero.Mov) = <T>DIN.CH<T> )  y (Dinero:Dinero.ContactoTipo = <T>Proveedor<T>)    <BR>Entonces<BR>  Asigna(Info.MovGenerar, SQL(<T>SELECT CxpChequeDevuelto FROM EmpresaCfgMovCxp WHERE Empresa =:tEmpresa<T>,Empresa))<BR>  Asigna(Info.PuedeEditar,Vacio(SQL(<T>SELECT 1 FROM usuarioAcceso WHERE MovsEdicion like :tMovaGenerar AND Usuario =:tUsuario<T>, <T>%Cxp.<T>&Info.MovGenerar&<T>%<T>, Usuario),Falso))<BR>Fin<BR>PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Dinero:Dinero.Usuario) y<BR>((Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) o<BR> ((Dinero:Dinero.Estatus=EstatusPendiente) y (MovTipo(<T>DIN<T>, Dinero:Dinero.Mov)<>DIN.DA)) o<BR>( ((Dinero:Dinero.Estatus=EstatusConcluido) y (MovTipo(<T>DIN<T>, Dinero:Dinero.Mov)=DIN.CH)) y (Dinero:Dinero.ChequeDevuelto <> VERDADERO) y Info.PuedeEditar))  y<BR>fnPuedeAvanzarEstatus(Empresa, <T>DIN<T>, Dinero:Dinero.Mov, Dinero:Dinero.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(Dinero:Dinero.Mov)
AntesExpresiones=Si(General.AdvertirProyectosExpirados, Si(SQL(<T>SELECT COUNT(*) FROM Proy WHERE (Estatus = :tBaja OR FechaFin+1<GETDATE()) AND Proyecto=:tProy<T>, EstatusBaja, Dinero:Dinero.Proyecto) > 0, Si(Precaucion(<T>Proyecto Expirado<T>, BotonAceptar, BotonCancelar)=BotonCancelar, AbortarOperacion)))<BR>Si<BR>  ConDatos(Dinero:Dinero.CtaDinero) y (MovTipo(<T>DIN<T>, Dinero:Dinero.Mov) = DIN.D) y (Dinero:Dinero.Moneda<>Dinero:CtaDinero.Moneda)<BR>Entonces<BR>  Si<BR>    Confirmacion(<T>La Moneda del <T>+Dinero:Dinero.Mov+<BR>                 <T> Difiere con la Moneda de la Cuenta.<T>+<BR>                  NuevaLinea+<BR>                 <T>El Importe se Va a Convertir a la Moneda de la Cuenta.<T>+<BR>                  NuevaLinea+NuevaLinea+<BR>                 <T>¿ Desea Continuar ?<T>, BotonSi, BotonNo) = BotonNo<BR>  Entonces<BR>    AbortarOperacion<BR>  Fin <BR>Fin<BR>Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>DIN<T>, Dinero:Dinero.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>DIN<T>, Dinero:Dinero.Mov, Dinero:Dinero.ID, Verdadero, Dinero:Dinero.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(Dinero:Dinero.MovID) y (Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Dinero:Dinero.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Dinero WHERE ID=:nID<T>, Dinero:Dinero.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
UsaTeclaRapida=S
NombreDesplegar=&Presentación Preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Dinero:Dinero.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>DIN<T>, Dinero:Dinero.Mov, Dinero:Dinero.Estatus), Dinero:Dinero.ID)
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
Visible=S
GuardarAntes=S
ListaParametros1=Dinero:Dinero.ID
EspacioPrevio=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>DIN<T>, Dinero:Dinero.Mov, Dinero:Dinero.Estatus), Dinero:Dinero.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnBarraHerramientas=S
EnMenu=S
ConfirmarAntes=S
DialogoMensaje=MovCancelar
TipoAccion=Expresion
Visible=S
Antes=S
RefrescarDespues=S
Expresion=Cancelar(<T>DIN<T>, Dinero:Dinero.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Dinero<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Dinero:Dinero.Usuario) y ConDatos(Dinero:Dinero.ID) y ConDatos(Dinero:Dinero.MovID) y<BR>((Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusSincro, EstatusPendiente)) o ((Dinero:Dinero.Estatus=EstatusConcluido) y (MovTipo(<T>DIN<T>,Dinero:Dinero.Mov) <> DIN.DA)))
AntesExpresiones=Asigna( Afectar.Mov, Dinero:Dinero.Mov ) <BR>Asigna( Afectar.MovID, Dinero:Dinero.MovID )

[Ficha.Dinero.Moneda]
Carpeta=Ficha
Clave=Dinero.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Dinero.TipoCambio]
Carpeta=Ficha
Clave=Dinero.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=7
Pegado=S
ColorFondo=Blanco

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
Expresion=Verificar(<T>DIN<T>, Dinero:Dinero.ID,Dinero:Dinero.Mov,Dinero:Dinero.MovID)
ActivoCondicion=Dinero:Dinero.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(Dinero:Dinero.Mov)

[Acciones.Info]
Nombre=Info
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información de la cuenta
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CtaDineroInfo
Visible=S
Antes=S
ConCondicion=S
ActivoCondicion=Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos( Dinero:Dinero.CtaDinero)
AntesExpresiones=Asigna( Info.CtaDinero, Dinero:Dinero.CtaDinero )

[Ficha.Dinero.FechaProgramada]
Carpeta=Ficha
Clave=Dinero.FechaProgramada
Editar=S
ValidaNombre=S
3D=S
Tamano=17
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.Dinero.Directo]
Carpeta=Ficha
Clave=Dinero.Directo
Editar=S
3D=S
Tamano=17
Pegado=N
ColorFondo=Blanco

[Detalle.DineroD.Aplica]
Carpeta=Detalle
Clave=DineroD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.DineroD.AplicaID]
Carpeta=Detalle
Clave=DineroD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.Dinero.Saldo]
Carpeta=Ficha
Clave=Dinero.Saldo
Editar=S
3D=S
Tamano=17
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]
ValidaNombre=N
Pegado=N

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
Multiple=S
ListaAccionesMultiples=(Lista)

ActivoCondicion=Dinero:Dinero.ConDesglose y(Dinero:Dinero.Estatus en(EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
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

[(Carpeta Abrir).Dinero.Referencia]
Carpeta=(Carpeta Abrir)
Clave=Dinero.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).ImporteTotal]
Carpeta=(Carpeta Abrir)
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
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
ActivoCondicion=ConDatos(Dinero:Dinero.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.MovID, Dinero:Dinero.MovID)
[(Carpeta Abrir).Dinero.BeneficiarioNombre]
Carpeta=(Carpeta Abrir)
Clave=Dinero.BeneficiarioNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha.CtaDineroDestino.Descripcion]
Carpeta=Ficha
Clave=CtaDineroDestino.Descripcion
Editar=S
3D=S
Tamano=31
ColorFondo=Plata

[(Carpeta Abrir).Dinero.CtaDineroDestino]
Carpeta=(Carpeta Abrir)
Clave=Dinero.CtaDineroDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

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

Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>DIN<T>, Dinero:Dinero.Mov, Dinero:Dinero.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>DIN<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>DIN<T>, Dinero:Dinero.Mov, Dinero:Dinero.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(Dinero:Dinero.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.Estatus, Dinero:Dinero.Estatus)<BR>Asigna(Info.Situacion, Dinero:Dinero.Situacion)
[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ActivoCondicion=ConfigModulo(<T>DIN<T>,<T>Tiempos<T>)=<T>Si<T>
ConCondicion=S
EjecucionCondicion=ConDatos(Dinero:Dinero.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.MovID, Dinero:Dinero.MovID)
Visible=S

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(DineroA:Dinero.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, DineroA:Dinero.ID)

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
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.Usuario, Dinero:Dinero.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Dinero:Dinero.ID)

[(Carpeta Abrir).Dinero.Moneda]
Carpeta=(Carpeta Abrir)
Clave=Dinero.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

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
RefrescarDespues=S

AntesExpresiones=Asigna(Info.Rama, <T>DIN<T>)<BR>Asigna(Info.Fecha, Dinero:Dinero.FechaEmision)<BR>Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Dinero:Dinero.Estatus noen (EstatusCancelado, EstatusConcluido)) o (fnSubMovTipo(<T>DIN<T>,Dinero:Dinero.Mov)EN(<T>DIN.DISP<T>) y (Dinero:Dinero.Estatus = EstatusConcluido))))<BR>Asigna(Info.Descripcion, Dinero:Dinero.Mov+<T> <T>+Dinero:Dinero.MovID)
[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
Menu=&Archivo
NombreDesplegar=Sugerir
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
RefrescarDespues=S

Expresion=Caso  fnSubMovTipo( <T>DIN<T>, Dinero:Dinero.Mov )<BR>  Es <T>DIN.CMULTIMONEDA<T> Entonces EjecutarSQL(<T>spDineroSugerirCorteMultimoneda :nSucursal, :nID, :tEmpresa, :tCta<T>, Sucursal, Dinero:Dinero.ID, Empresa, Dinero:Dinero.CtaDinero)<BR>  ES <T>DIN.CPMULTIMONEDA<T> Entonces EjecutarSQL(<T>spDineroSugerirCorteMultimoneda :nSucursal, :nID, :tEmpresa, :tCta<T>, Sucursal, Dinero:Dinero.ID, Empresa, Dinero:Dinero.CtaDinero)<BR>SiNo  <BR>  EjecutarSQL(<T>spDineroSugerirCorte :nSucursal, :nID, :tEmpresa, :tCta, :tMoneda<T>, Sucursal, Dinero:Dinero.ID, Empresa, Dinero:Dinero.CtaDinero, Dinero:Dinero.Moneda)<BR>Fin
ActivoCondicion=MovTipoEn(<T>DIN<T>, Dinero:Dinero.Mov, (DIN.C, DIN.CP, DIN.TC)) y (Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
[Ficha.Dinero.FormaPago]
Carpeta=Ficha
Clave=Dinero.FormaPago
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
LineaNueva=N
EditarConBloqueo=N

[Acciones.CorteCaja]
Nombre=CorteCaja
Boton=68
Menu=&Archivo
NombreDesplegar=Reporte
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=CorteCaja
Antes=S
Visible=S
ActivoCondicion=MovTipoEn(<T>DIN<T>, Dinero:Dinero.Mov, (DIN.C, DIN.CP)) y (Dinero:Dinero.Estatus=EstatusConcluido)
AntesExpresiones=Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.MovID, Dinero:Dinero.MovID)<BR>Asigna(Info.CtaDinero, Dinero:Dinero.CtaDinero)<BR>Asigna(Info.Descripcion, Dinero:CtaDinero.Descripcion)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(Dinero:Dinero.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, Dinero:Dinero.ID)
Visible=S

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
NombreDesplegar=&Copiar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F11
GuardarAntes=S
Expresion=CopiarMovimiento(<T>DIN<T>, Dinero:Dinero.ID, <T>Dinero<T>)

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
ClaveAccion=DineroCampos
Antes=S
ActivoCondicion=no FormaBloqueada
AntesExpresiones=Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.MovID, Dinero:Dinero.MovID)
VisibleCondicion=Dinero:Dinero.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[(Carpeta Abrir).Dinero.Saldo]
Carpeta=(Carpeta Abrir)
Clave=Dinero.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Totalizador=1

[Institucion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Institución Financiera
Clave=Institucion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Dinero
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
CondicionVisible=ConDatos(Dinero:Dinero.InstitucionMensaje)

[Institucion.Dinero.Mov]
Carpeta=Institucion
Clave=Dinero.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Plata
ColorFuente=Negro

[Institucion.Dinero.MovID]
Carpeta=Institucion
Clave=Dinero.MovID
Editar=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=8
Pegado=S

[Institucion.Dinero.InstitucionMensaje]
Carpeta=Institucion
Clave=Dinero.InstitucionMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Institucion.Dinero.InstitucionSucursal]
Carpeta=Institucion
Clave=Dinero.InstitucionSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Institucion.Dinero.InstitucionReferencia1]
Carpeta=Institucion
Clave=Dinero.InstitucionReferencia1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Institucion.Dinero.InstitucionReferencia2]
Carpeta=Institucion
Clave=Dinero.InstitucionReferencia2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Institucion.Dinero.FechaEmision]
Carpeta=Institucion
Clave=Dinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Institucion.Dinero.Importe]
Carpeta=Institucion
Clave=Dinero.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Institucion.Dinero.Observaciones]
Carpeta=Institucion
Clave=Dinero.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=40
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(Dinero:Dinero.ID),GuardarCambios)
VisibleCondicion=Usuario.ModificarSucursalDestino

[Acciones.InfoDestino]
Nombre=InfoDestino
Boton=0
Menu=&Ver
NombreDesplegar=Información de la cuenta &destino
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaDineroInfo
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
ActivoCondicion=MovTipoEn(<T>DIN<T>,Dinero:Dinero.Mov, (DIN.T, DIN.TI, DIN.INV, DIN.RET, DIN.TC, DIN.A, DIN.AP, DIN.CP, DIN.C)) y Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(Dinero:Dinero.CtaDineroDestino)
AntesExpresiones=Asigna( Info.CtaDinero, Dinero:Dinero.CtaDineroDestino )
VisibleCondicion=MovTipoEn(<T>DIN<T>,Dinero:Dinero.Mov, (DIN.T, DIN.TI, DIN.INV, DIN.RET, DIN.TC, DIN.A, DIN.AP, DIN.CP, DIN.C))

[Ficha.CtaDinero.Descripcion]
Carpeta=Ficha
Clave=CtaDinero.Descripcion
Editar=S
3D=S
Tamano=31
ColorFondo=Plata

[Ficha.DineroSaldo.Saldo]
Carpeta=Ficha
Clave=DineroSaldo.Saldo
Editar=S
3D=S
Tamano=17
ColorFondo=Plata
ColorFuente=Azul marino
Efectos=[Negritas]

[Ficha.Dinero.Cajero]
Carpeta=Ficha
Clave=Dinero.Cajero
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
Editar=S
3D=S
Tamano=17
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

[Acciones.Autorizar]
Nombre=Autorizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=A&utorizar
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovAutorizar
Antes=S
DespuesGuardar=S
RefrescarDespues=S
ActivoCondicion=ConDatos(Dinero:Dinero.Mensaje)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Dinero<T>)<BR>Asigna(Afectar.Modulo, <T>DIN<T>)<BR>Asigna(Afectar.ID, Dinero:Dinero.ID)<BR>Asigna(Afectar.Mov, Dinero:Dinero.Mov)<BR>Asigna(Afectar.MovID, Dinero:Dinero.MovID)<BR>Asigna(Info.Descripcion, Dinero:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(Dinero:Dinero.Mensaje)

[Ficha.Dinero.UEN]
Carpeta=Ficha
Clave=Dinero.UEN
Editar=S
3D=S
Pegado=S
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
EjecucionCondicion=ConDatos(Dinero:Dinero.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, Dinero:Dinero.Proyecto)
Visible=S

[Ficha.CtaDineroDestino.Moneda]
Carpeta=Ficha
Clave=CtaDineroDestino.Moneda
Editar=S
3D=S
Tamano=10
ColorFondo=Plata

[Ficha.Dinero.TipoCambioDestino]
Carpeta=Ficha
Clave=Dinero.TipoCambioDestino
Editar=S
3D=S
Pegado=S
Tamano=7
ColorFondo=Blanco

[Ficha.Dinero.LeyendaCheque]
Carpeta=Ficha
Clave=Dinero.LeyendaCheque
Editar=S
3D=S
Tamano=17
ColorFondo=Blanco

[Acciones.ImporteConImpuestos]
Nombre=ImporteConImpuestos
Boton=10
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F6
NombreDesplegar=&Importe con Impuestos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.Importe, Dinero:ImporteTotal)<BR>Asigna(Info.PorcentajeImpuesto, General.DefImpuesto)<BR>Si<BR>  Forma(<T>EspecificarImporteConImpuestos<T>)<BR>Entonces<BR>  Asigna(Dinero:Dinero.Importe,  Redondea(Info.Importe/(1+(Info.PorcentajeImpuesto/100)), 4))<BR>  Asigna(Dinero:Dinero.Impuestos, Info.Importe-Dinero:Dinero.Importe)<BR>Fin
ActivoCondicion=(Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y MovTipoEn(<T>DIN<T>,Dinero:Dinero.Mov,(DIN.CB,DIN.AB))

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.Clave, <T>DIN<T>+Dinero:Dinero.ID)<BR>Asigna(Info.Nombre, Dinero:Dinero.Mov+<T> <T>+Dinero:Dinero.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(Dinero:Dinero.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
Activo=S
Visible=S

[Acciones.Totalizar.TotalizarPost]
Nombre=TotalizarPost
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Afectar
Activo=S
Visible=S

[Acciones.Totalizar.TotalizarCopiar]
Nombre=TotalizarCopiar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si(MovTipo(<T>DIN<T>,Dinero:Dinero.Mov) noen (DIN.CB,DIN.AB), Asigna(Dinero:Dinero.Importe, Suma(DineroD:DineroD.Importe)))

[Comision]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comisión Bancaria
Clave=Comision
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Dinero
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
CondicionVisible=MovTipoEn(<T>DIN<T>, Dinero:Dinero.Mov, (DIN.CH, DIN.CHE))

[Comision.Dinero.CargoBancario]
Carpeta=Comision
Clave=Dinero.CargoBancario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Comision.Dinero.CargoBancarioIVA]
Carpeta=Comision
Clave=Dinero.CargoBancarioIVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Dinero.Prioridad]
Carpeta=Ficha
Clave=Dinero.Prioridad
Editar=S
3D=S
Tamano=17
ColorFondo=Blanco

[Acciones.CxcExpress]
Nombre=CxcExpress
Boton=0
Menu=&Edición
NombreDesplegar=Cuenta por &Cobrar Express...
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CxcExpress
Visible=S
ActivoCondicion=Usuario.CxcExpress

[Acciones.CxpExpress]
Nombre=CxpExpress
Boton=0
Menu=&Edición
NombreDesplegar=Cuenta por &Pagar Express...
EnMenu=S
TipoAccion=Formas
ClaveAccion=CxpExpress
ActivoCondicion=Usuario.CxpExpress
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
AntesExpresiones=Asigna(Info.PuedeEditar, Dinero:Dinero.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.MovID, Dinero:Dinero.MovID)<BR>Asigna(Info.Proyecto, Dinero:Dinero.Proyecto)<BR>Asigna(Info.UEN, Dinero:Dinero.UEN)<BR>Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, Dinero:Dinero.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Dinero:Dinero.Cajero)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Acciones.AbrirCxcExpress]
Nombre=AbrirCxcExpress
Boton=0
NombreDesplegar=&Cuenta por Cobrar Express...
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CxcExpress
Visible=S
ActivoCondicion=Usuario.CxcExpress

[Acciones.AbrirCxpExpress]
Nombre=AbrirCxpExpress
Boton=0
NombreDesplegar=Cuenta por &Pagar Express...
EnMenu=S
TipoAccion=Formas
ClaveAccion=CxpExpress
ActivoCondicion=Usuario.CxpExpress
Visible=S

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
Vista=Dinero
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

[Comentarios.Dinero.Comentarios]
Carpeta=Comentarios
Clave=Dinero.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=89x13
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios.Dinero.Nota]
Carpeta=Comentarios
Clave=Dinero.Nota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco
ColorFuente=Negro

[Intereses]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Intereses
Clave=Intereses
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Dinero
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
CondicionVisible=MovTipoEn(<T>DIN<T>, Dinero:Dinero.Mov, (DIN.INV, DIN.RET))

[Intereses.Dinero.Vencimiento]
Carpeta=Intereses
Clave=Dinero.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Intereses.Dias]
Carpeta=Intereses
Clave=Dias
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Intereses.Dinero.FechaOrigen]
Carpeta=Intereses
Clave=Dinero.FechaOrigen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Intereses.Dinero.Tasa]
Carpeta=Intereses
Clave=Dinero.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Intereses.Dinero.TasaDias]
Carpeta=Intereses
Clave=Dinero.TasaDias
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Dinero.ContUso]
Carpeta=Ficha
Clave=Dinero.ContUso
Editar=S
3D=S
Tamano=17
ColorFondo=Blanco

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
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.MovID, Dinero:Dinero.MovID)<BR>Asigna(Info.Fecha, Dinero:Dinero.FechaEmision)<BR>Asigna(Info.Estatus, Dinero:Dinero.Estatus)

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
EjecucionCondicion=ConDatos(Dinero:Dinero.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>DIN<T>)<BR>Asigna(Info.Clave, Dinero:Dinero.Mov)

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
EjecucionCondicion=ConDatos(Dinero:Dinero.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.Concepto, Dinero:Dinero.Concepto)

[Comentarios.Dinero.ContactoTipo]
Carpeta=Comentarios
Clave=Dinero.ContactoTipo
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Comentarios.Dinero.Contacto]
Carpeta=Comentarios
Clave=Dinero.Contacto
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Detalle.DineroD.ContUso]
Carpeta=Detalle
Clave=DineroD.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Intereses.Dinero.TasaRetencion]
Carpeta=Intereses
Clave=Dinero.TasaRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Intereses.InteresBruto]
Carpeta=Intereses
Clave=InteresBruto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Intereses.InteresNeto]
Carpeta=Intereses
Clave=InteresNeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Tamano=25

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Forma, <T>Dinero<T>)<BR>Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.Nombre, Dinero:Dinero.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
Activo=S
Visible=S

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
Vista=Dinero
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
CondicionVisible=MovTipo(<T>DIN<T>, Dinero:Dinero.Mov) = DIN.ACXC

[Cliente.Dinero.Cliente]
Carpeta=Cliente
Clave=Dinero.Cliente
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
3D=S
Tamano=55
ColorFondo=Plata
ColorFuente=Negro

[Proveedor]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Proveedor
Clave=Proveedor
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Dinero
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
CondicionVisible=MovTipo(<T>DIN<T>, Dinero:Dinero.Mov) = DIN.ACXP

[Proveedor.Dinero.Proveedor]
Carpeta=Proveedor
Clave=Dinero.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Proveedor.Prov.Nombre]
Carpeta=Proveedor
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=60
ColorFondo=Plata
ColorFuente=Negro

[Cliente.Dinero.ClienteEnviarA]
Carpeta=Cliente
Clave=Dinero.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cliente.CteEnviarA.Nombre]
Carpeta=Cliente
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=N
3D=S
Tamano=45
ColorFondo=Plata
ColorFuente=Negro

[Cliente.CteEnviarA.Clave]
Carpeta=Cliente
Clave=CteEnviarA.Clave
Editar=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>DIN<T>, Dinero:Dinero.Mov, Dinero:Dinero.ID, Falso, Dinero:Dinero.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>DIN<T>+Dinero:Dinero.ID)<BR>  Asigna(Info.Nombre, Dinero:Dinero.Mov+<T> <T>+Dinero:Dinero.MovID)<BR>  Asigna(Info.Modulo, <T>DIN<T>)<BR>  Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
ClaveAccion=FormaAnexoMov
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.MovID, Dinero:Dinero.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=Dinero:Dinero.ConDesglose o (no Dinero:Dinero.Directo)

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>DIN<T>, <T>{Dinero:Dinero.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>DIN{Dinero:Dinero.ID}<T>

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
VerCampo=313
VerValor=300

[Intereses.Dinero.InteresTipo]
Carpeta=Intereses
Clave=Dinero.InteresTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Intereses.Dinero.Titulo]
Carpeta=Intereses
Clave=Dinero.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Intereses.Dinero.TituloValor]
Carpeta=Intereses
Clave=Dinero.TituloValor
Editar=S
3D=S
Tamano=10
ColorFuente=Negro
ColorFondo=Blanco
ValidaNombre=S
Pegado=S

[Intereses.Dinero.ValorOrigen]
Carpeta=Intereses
Clave=Dinero.ValorOrigen
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Intereses.Dinero.Retencion]
Carpeta=Intereses
Clave=Dinero.Retencion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Titulo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Título
Clave=Titulo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Dinero
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
CondicionVisible=MovTipo(<T>DIN<T>, Dinero:Dinero.Mov) = DIN.REI

[Titulo.Dinero.Titulo]
Carpeta=Titulo
Clave=Dinero.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Titulo.Titulo.Nombre]
Carpeta=Titulo
Clave=Titulo.Nombre
Editar=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Titulo.Dinero.TituloValor]
Carpeta=Titulo
Clave=Dinero.TituloValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Titulo.Dinero.ValorOrigen]
Carpeta=Titulo
Clave=Dinero.ValorOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.DineroD.Institucion]
Carpeta=Detalle
Clave=DineroD.Institucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[DesgloseImpuestos.Columnas]
Impuesto1=64
Impuesto2=64
Impuesto3=72
Importe1=64
Importe2=64
Importe3=64
Retencion1=64
Retencion2=64
Retencion3=64
ContUso=77
ContUso2=124
ContUso3=124

[Lista.Columnas]
0=84
1=111

2=399
CentroCostos=127
Descripcion=186
CentroCostos2=127
CentroCostos3=127
CtaDinero=84
Moneda=65
Beneficiario=277
ConceptoFEFondos=304
ConceptoFE=304
Clasificacion=304
[MovImpuesto]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Arrastre
Clave=MovImpuesto
Filtros=S
Detalle=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovImpuestoMov
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Dinero
LlaveLocal=MovImpuestoMov.ModuloID
LlaveMaestra=Dinero.ID
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
ListaAcciones=PersonalizarVista

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=MovImpuestoMov.Modulo = <T>DIN<T>
CondicionVisible=((Dinero:Dinero.Estatus = EstatusConcluido) o (Dinero:Dinero.Estatus = EstatusCancelado)) y (Config.VisualizarArrastre)
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
0=-2
1=-2




2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2




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
[Institucion.ListaEnCaptura]
(Inicio)=Dinero.Mov
Dinero.Mov=Dinero.MovID
Dinero.MovID=Dinero.FechaEmision
Dinero.FechaEmision=Dinero.Importe
Dinero.Importe=Dinero.InstitucionMensaje
Dinero.InstitucionMensaje=Dinero.InstitucionSucursal
Dinero.InstitucionSucursal=Dinero.InstitucionReferencia1
Dinero.InstitucionReferencia1=Dinero.InstitucionReferencia2
Dinero.InstitucionReferencia2=Dinero.Observaciones
Dinero.Observaciones=(Fin)

[Comision.ListaEnCaptura]
(Inicio)=Dinero.CargoBancario
Dinero.CargoBancario=Dinero.CargoBancarioIVA
Dinero.CargoBancarioIVA=(Fin)

[Comentarios.ListaEnCaptura]
(Inicio)=Dinero.Comentarios
Dinero.Comentarios=Dinero.Nota
Dinero.Nota=Dinero.ContactoTipo
Dinero.ContactoTipo=Dinero.Contacto
Dinero.Contacto=(Fin)

[Intereses.ListaEnCaptura]
(Inicio)=Dinero.FechaOrigen
Dinero.FechaOrigen=Dinero.InteresTipo
Dinero.InteresTipo=Dinero.Tasa
Dinero.Tasa=Dinero.TasaDias
Dinero.TasaDias=Dinero.Titulo
Dinero.Titulo=Dinero.TituloValor
Dinero.TituloValor=Dinero.ValorOrigen
Dinero.ValorOrigen=Dinero.Vencimiento
Dinero.Vencimiento=Dias
Dias=InteresBruto
InteresBruto=Dinero.TasaRetencion
Dinero.TasaRetencion=Dinero.Retencion
Dinero.Retencion=InteresNeto
InteresNeto=(Fin)

[Cliente.ListaEnCaptura]
(Inicio)=Dinero.Cliente
Dinero.Cliente=Cte.Nombre
Cte.Nombre=Dinero.ClienteEnviarA
Dinero.ClienteEnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Clave
CteEnviarA.Clave=(Fin)

[Proveedor.ListaEnCaptura]
(Inicio)=Dinero.Proveedor
Dinero.Proveedor=Prov.Nombre
Prov.Nombre=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)

[Titulo.ListaEnCaptura]
(Inicio)=Dinero.Titulo
Dinero.Titulo=Titulo.Nombre
Titulo.Nombre=Dinero.TituloValor
Dinero.TituloValor=Dinero.ValorOrigen
Dinero.ValorOrigen=(Fin)


[Acciones.CPDesreservarFlujo]
Nombre=CPDesreservarFlujo
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Shift+Ctrl+F
NombreDesplegar=<T>Desreservar Flujo...<T>
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CPCalMov
Antes=S
DespuesGuardar=S


































ActivoCondicion=Dinero:MovTipo.ReservarCP=<T>Desreservar<T>
AntesExpresiones=Asigna(Info.PuedeEditar, Dinero:Dinero.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))<BR>Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, Dinero:Dinero.ID)<BR>Asigna(Info.Mov, Dinero:Dinero.Mov)<BR>Asigna(Info.MovID, Dinero:Dinero.MovID)  <BR>Asigna(Info.Ejercicio, Año(Dinero:Dinero.FechaEmision))<BR>Asigna(Info.ClavePresupuestal, Nulo)<BR>Asigna(Info.Tipo, <T>Reduccion<T>)<BR>Asigna(Info.Importe, Dinero:ImporteTotal)
VisibleCondicion=General.CP









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
Vista=Dinero
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


CondicionVisible=(Config.ContUsoDinero) Y (Vacio(Dinero:Dinero.OrigenTipo))
[CentrosCostos.Dinero.ContUso]
Carpeta=CentrosCostos
Clave=Dinero.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CentrosCostos.Dinero.ContUso2]
Carpeta=CentrosCostos
Clave=Dinero.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CentrosCostos.Dinero.ContUso3]
Carpeta=CentrosCostos
Clave=Dinero.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







[Detalle.DineroD.ContUso2]
Carpeta=Detalle
Clave=DineroD.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.DineroD.ContUso3]
Carpeta=Detalle
Clave=DineroD.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






















[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122







[Detalle.DineroD.CtaDinero]
Carpeta=Detalle
Clave=DineroD.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.DineroD.CtaDineroDestino]
Carpeta=Detalle
Clave=DineroD.CtaDineroDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.DineroD.Moneda]
Carpeta=Detalle
Clave=DineroD.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.DineroD.TipoCambio]
Carpeta=Detalle
Clave=DineroD.TipoCambio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





















[Detalle.ImporteTipoCambioD]
Carpeta=Detalle
Clave=ImporteTipoCambioD
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





































































































[CentrosCostos.ListaEnCaptura]
(Inicio)=Dinero.ContUso
Dinero.ContUso=Dinero.ContUso2
Dinero.ContUso2=Dinero.ContUso3
Dinero.ContUso3=(Fin)








































[Detalle.ListaEnCaptura]
(Inicio)=DineroD.Aplica
DineroD.Aplica=DineroD.AplicaID
DineroD.AplicaID=DineroD.Importe
DineroD.Importe=DineroD.FormaPago
DineroD.FormaPago=DineroD.Referencia
DineroD.Referencia=DineroD.ContUso
DineroD.ContUso=DineroD.ContUso2
DineroD.ContUso2=DineroD.ContUso3
DineroD.ContUso3=DineroD.Institucion
DineroD.Institucion=DineroD.CtaDinero
DineroD.CtaDinero=DineroD.CtaDineroDestino
DineroD.CtaDineroDestino=DineroD.Moneda
DineroD.Moneda=DineroD.TipoCambio
DineroD.TipoCambio=ImporteTipoCambioD
ImporteTipoCambioD=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=DineroValidacion.FechaEmision
DineroValidacion.FechaEmision=DineroValidacion.Saldo
DineroValidacion.Saldo=InstitucionFin.Nombre
InstitucionFin.Nombre=(Fin)

[Detalle.ListaOrden]
(Inicio)=DineroD.Renglon	(Acendente)
DineroD.Renglon	(Acendente)=DineroD.RenglonSub	(Acendente)
DineroD.RenglonSub	(Acendente)=(Fin)





















































[Acciones.Totalizar.ListaAccionesMultiples]
(Inicio)=TotalizarPost
TotalizarPost=TotalizarCopiar
TotalizarCopiar=(Fin)







[Emida]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Emida
Clave=Emida
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Dinero
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

ListaEnCaptura=Dinero.EmidaRequestId

CondicionVisible=General.InterfazEmida
[Emida.Dinero.EmidaRequestId]
Carpeta=Emida
Clave=Dinero.EmidaRequestId
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco












































































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







[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Dinero.CtaDinero
Dinero.CtaDinero=Dinero.CtaDineroDestino
Dinero.CtaDineroDestino=Dinero.Referencia
Dinero.Referencia=Dinero.BeneficiarioNombre
Dinero.BeneficiarioNombre=Dinero.FechaEmision
Dinero.FechaEmision=ImporteTotal
ImporteTotal=Dinero.Saldo
Dinero.Saldo=Dinero.Moneda
Dinero.Moneda=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=(por Autorizar)
(por Autorizar)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=BORRADOR
BORRADOR=PENDIENTE
PENDIENTE=POSFECHADO
POSFECHADO=CONCLUIDO
CONCLUIDO=CONCILIADO
CONCILIADO=CANCELADO
CANCELADO=SINCRO
SINCRO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirCxcExpress
AbrirCxcExpress=AbrirCxpExpress
AbrirCxpExpress=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirMostrar
AbrirMostrar=(Fin)
















[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=0
NombreDesplegar=Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S












[Ficha.Dinero.ConceptoFE]
Carpeta=Ficha
Clave=Dinero.ConceptoFE
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco




















[Ficha.Dinero.ConceptoFEFondos]
Carpeta=Ficha
Clave=Dinero.ConceptoFEFondos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Dinero.ClasificacionConcFEFondos]
Carpeta=Ficha
Clave=Dinero.ClasificacionConcFEFondos
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco















[Ficha.ListaEnCaptura]
(Inicio)=Dinero.Mov
Dinero.Mov=Dinero.MovID
Dinero.MovID=Dinero.Proyecto
Dinero.Proyecto=Dinero.UEN
Dinero.UEN=Dinero.Moneda
Dinero.Moneda=Dinero.TipoCambio
Dinero.TipoCambio=Dinero.FechaEmision
Dinero.FechaEmision=Dinero.FechaProgramada
Dinero.FechaProgramada=Dinero.Prioridad
Dinero.Prioridad=Dinero.CtaDinero
Dinero.CtaDinero=CtaDinero.Descripcion
CtaDinero.Descripcion=DineroSaldo.Saldo
DineroSaldo.Saldo=Dinero.CtaDineroDestino
Dinero.CtaDineroDestino=CtaDineroDestino.Descripcion
CtaDineroDestino.Descripcion=CtaDineroDestino.Moneda
CtaDineroDestino.Moneda=Dinero.TipoCambioDestino
Dinero.TipoCambioDestino=Dinero.BeneficiarioNombre
Dinero.BeneficiarioNombre=Dinero.LeyendaCheque
Dinero.LeyendaCheque=Dinero.Importe
Dinero.Importe=Dinero.Impuestos
Dinero.Impuestos=ImporteTotal
ImporteTotal=Dinero.Concepto
Dinero.Concepto=Dinero.Cajero
Dinero.Cajero=Agente.Nombre
Agente.Nombre=Dinero.Referencia
Dinero.Referencia=Dinero.FormaPago
Dinero.FormaPago=Dinero.Saldo
Dinero.Saldo=Dinero.Observaciones
Dinero.Observaciones=Dinero.ConDesglose
Dinero.ConDesglose=Dinero.Directo
Dinero.Directo=Dinero.ContUso
Dinero.ContUso=Dinero.ConceptoFE
Dinero.ConceptoFE=Dinero.ConceptoFEFondos
Dinero.ConceptoFEFondos=Dinero.ClasificacionConcFEFondos
Dinero.ClasificacionConcFEFondos=(Fin)
















[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Cliente
Cliente=Proveedor
Proveedor=Titulo
Titulo=Intereses
Intereses=Institucion
Institucion=Comision
Comision=Comentarios
Comentarios=Detalle
Detalle=FormaExtraValor
FormaExtraValor=MovImpuesto
MovImpuesto=CentrosCostos
CentrosCostos=Emida
Emida=(Fin)

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
Situacion=Sucursal
Sucursal=Afectar
Afectar=Autorizar
Autorizar=Eliminar
Eliminar=Cancelar
Cancelar=Sugerir
Sugerir=CorteCaja
CorteCaja=ReasignarUsuario
ReasignarUsuario=Campos
Campos=CamposExtras
CamposExtras=CPDesreservarFlujo
CPDesreservarFlujo=Totalizar
Totalizar=Tareas
Tareas=Anexos
Anexos=ImporteConImpuestos
ImporteConImpuestos=CxcExpress
CxcExpress=CxpExpress
CxpExpress=Anterior
Anterior=Siguiente
Siguiente=Info
Info=InfoDestino
InfoDestino=ProyInfo
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
Otros9=WizardSituaciones
WizardSituaciones=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
