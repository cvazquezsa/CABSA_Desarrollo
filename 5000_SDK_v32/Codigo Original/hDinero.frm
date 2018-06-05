[Forma]
Clave=hDinero
Nombre=Movimientos Historicos de Tesorería
Icono=0
Modulos=DIN
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=1912
PosicionInicialArriba=0
PosicionInicialAltura=590
PosicionInicialAncho=816
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
PosicionInicialAlturaCliente=568
PosicionSec1=304
PosicionSec2=480

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
Vista=hDinero
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

[Ficha.hDinero.Mov]
Carpeta=Ficha
Clave=hDinero.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[Ficha.hDinero.MovID]
Carpeta=Ficha
Clave=hDinero.MovID
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
Editar=S
IgnoraFlujo=S

[Ficha.hDinero.Proyecto]
Carpeta=Ficha
Clave=hDinero.Proyecto
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
EditarConBloqueo=N
Pegado=S

[Ficha.hDinero.FechaEmision]
Carpeta=Ficha
Clave=hDinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.hDinero.CtaDinero]
Carpeta=Ficha
Clave=hDinero.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.hDinero.CtaDineroDestino]
Carpeta=Ficha
Clave=hDinero.CtaDineroDestino
Editar=S
ValidaNombre=S
3D=S
Tamano=25
LineaNueva=S
Pegado=N
ColorFondo=Blanco

[Ficha.hDinero.BeneficiarioNombre]
Carpeta=Ficha
Clave=hDinero.BeneficiarioNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
EspacioPrevio=N
ColorFondo=Blanco

[Ficha.hDinero.Concepto]
Carpeta=Ficha
Clave=hDinero.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco
EditarConBloqueo=N

[Ficha.hDinero.Referencia]
Carpeta=Ficha
Clave=hDinero.Referencia
Editar=S
ValidaNombre=S
3D=S
Tamano=25
LineaNueva=S
EditarConBloqueo=N
EspacioPrevio=N
ColorFondo=Blanco

[Ficha.hDinero.Importe]
Carpeta=Ficha
Clave=hDinero.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco

[Ficha.hDinero.Observaciones]
Carpeta=Ficha
Clave=hDinero.Observaciones
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
Vista=hDineroD
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
VistaMaestra=hDinero
LlaveLocal=hDineroD.ID
LlaveMaestra=hDinero.ID
ControlRenglon=S
CampoRenglon=hDineroD.Renglon
ListaOrden=(Lista)
HojaFondoGrisAuto=S
PermiteLocalizar=S
HojaAjustarColumnas=S
ValidarCampos=S
ListaCamposAValidar=(Lista)

CondicionVisible=hDinero:hDinero.ConDesglose o (no hDinero:hDinero.Directo)
[Detalle.hDineroD.Importe]
Carpeta=Detalle
Clave=hDineroD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.hDineroD.Referencia]
Carpeta=Detalle
Clave=hDineroD.Referencia
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
Vista=hDineroA
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
ListaOrden=hDinero.ID<TAB>(Decendente)
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
FiltroFechasCampo=hDinero.FechaEmision
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
FiltroTipo=Múltiple (por grupos)
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
FiltroFechasCancelacion=hDinero.FechaCancelacion
FiltroSucursales=S
FiltroAplicaO=hDinero.CtaDineroDestino
FiltroAplicaEn=hDinero.CtaDinero
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
FiltroListasAplicaEn=hDinero.CtaDinero
FiltroEnOrden=S
FiltroArbol=Cuentas Dinero
FiltroArbolAplica=CtaDinero.Rama

BusquedaSelCampo=S
IconosNombre=hDineroA:hDinero.Mov+<T> <T>+hDineroA:hDinero.MovID
[(Carpeta Abrir).hDinero.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=hDinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).hDinero.CtaDinero]
Carpeta=(Carpeta Abrir)
Clave=hDinero.CtaDinero
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

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
[Detalle.hDineroD.FormaPago]
Carpeta=Detalle
Clave=hDineroD.FormaPago
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
Totalizadores2=Caso  fnSubMovTipo( <T>DIN<T>, hDinero:hDinero.Mov )     Es <T>DIN.AMULTIMONEDA<T> Entonces (Suma(hDineroD:ImporteTipoCambioD)) Es ,<T>DIN.CMULTIMONEDA<T> Entonces (Suma(hDineroD:ImporteTipoCambioD))    ES ,<T>DIN.CPMULTIMONEDA<T> Entonces (Suma(hDineroD:ImporteTipoCambioD)) Sino  Suma( hDineroD:hDineroD.Importe ) Fin
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Importe Total

CondicionVisible=hDinero:hDinero.ConDesglose o (no hDinero:hDinero.Directo)
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

EjecucionCondicion=Si(General.MovConcurrente y ConDatos(hDinero:hDinero.ID) y (hDinero:hDinero.UltimoCambio<>SQL(<T>spMovInfoVerUltimoCambio :nID, :tModulo<T>, hDinero:hDinero.ID, <T>DIN<T>)), Dialogo(<T>MovConcurrente<T>) AbortarOperacion)<BR>(MovTipoEn(<T>DIN<T>,hDinero:hDinero.Mov,(DIN.SD, DIN.SCH)) o ConDatos(hDinero:hDinero.CtaDinero))
EjecucionMensaje=<T>Falta Indicar la Cuenta<T>
AntesExpresiones=Si<BR>  (hDinero:hDinero.ConDesglose o (no hDinero:hDinero.Directo)) y (MovTipo(<T>DIN<T>,hDinero:hDinero.Mov) noen (DIN.CB,DIN.AB))<BR>Entonces<BR> // Asigna(hDinero:hDinero.Importe, Suma(hDineroD:hDineroD.Importe))<BR> Caso  fnSubMovTipo( <T>DIN<T>, hDinero:hDinero.Mov )<BR> Es <T>DIN.AMULTIMONEDA<T> Entonces Asigna(hDinero:hDinero.Importe,Suma(hDineroD:ImporteTipoCambioD))<BR> Es <T>DIN.CMULTIMONEDA<T> Entonces Asigna(hDinero:hDinero.Importe,Suma(hDineroD:ImporteTipoCambioD))<BR> Es <T>DIN.CPMULTIMONEDA<T> Entonces Asigna(hDinero:hDinero.Importe,Suma(hDineroD:ImporteTipoCambioD))<BR> Sino  Asigna(hDinero:hDinero.Importe,Suma( hDineroD:hDineroD.Importe )) Fin<BR>Fin
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

[Ficha.hDinero.Impuestos]
Carpeta=Ficha
Clave=hDinero.Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[Ficha.hDinero.ConDesglose]
Carpeta=Ficha
Clave=hDinero.ConDesglose
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

Expresion=Si<BR>  (hDinero:hDinero.Estatus=EstatusPendiente) y MovTipoEn(<T>DIN<T>, hDinero:hDinero.Mov, (DIN.I, DIN.E, DIN.F, DIN.SD, DIN.SCH, DIN.INV, DIN.TI)))<BR>Entonces<BR>  Asigna(Info.Modulo, <T>DIN<T>)<BR>  Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>  Asigna(Info.MovID, hDinero:hDinero.MovID)<BR>  Asigna(Afectar.Modulo, <T>DIN<T>)<BR>  Asigna(Afectar.ID, hDinero:hDinero.ID)<BR>  Asigna(Afectar.Mov, hDinero:hDinero.Mov)<BR>  Asigna(Afectar.MovID, hDinero:hDinero.MovID)<BR>  Asigna(Afectar.FormaCaptura, <T>Dinero<T>)<BR>  Asigna(Info.TituloDialogo, Afectar.Mov+<T> <T>+Afectar.MovID)<BR>  Si<BR>    ConfigModulo(Info.Modulo, <T>FlujoAbierto<T>) = <T>Si<T><BR>  Entonces<BR>    Si<BR>      Forma(<T>GenerarMovFlujo<T>)<BR>    Entonces<BR>      Asigna(Afectar.GenerarMov, Info.MovGenerar)<BR>      Generar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, Afectar.GenerarMov, Afectar.FormaCaptura)<BR>    Fin<BR>  Sino<BR>    Caso MovTipo(<T>DIN<T>,hDinero:hDinero.Mov)<BR>      Es DIN.I   Entonces Dialogo(<T>GenerarDineroIngreso<T>)<BR>      Es DIN.SD  Entonces Dialogo(<T>GenerarDineroIngreso<T>)<BR>      Es DIN.E   Entonces Dialogo(<T>GenerarDineroEgreso<T>)<BR>      Es DIN.SCH Entonces Dialogo(<T>GenerarDineroEgreso<T>)<BR>      Es DIN.INV Entonces Dialogo(<T>GenerarDineroInversion<T>)<BR>      Es DIN.TI  Entonces Dialogo(<T>GenerarDineroTraspaso<T>)<BR>    Fin<BR>  Fin<BR>Sino<BR>  //MEJORA6013<BR>  Si<BR>    (MovTipo(<T>DIN<T>,hDinero:hDinero.Mov) = DIN.CH) Y (hDinero:hDinero.Estatus = EstatusConcluido) Y (hDinero:hDinero.ChequeDevuelto <> VERDADERO)<BR>  Entonces<BR>    Si Dialogo(<T>ChequeDevueltoEstaSeguro<T>) Entonces<BR>      INFORMACION(SQL(<T>EXEC spDineroChequeDevueltoCxp :nEstacion, :nID, :tUsuario<T>,EstacionTrabajo, hDinero:hDinero.ID, Usuario))<BR>    Fin<BR>  Sino<BR>    Afectar(<T>DIN<T>, hDinero:hDinero.ID, hDinero:hDinero.Mov, hDinero:hDinero.MovID, <T>Todo<T>, <T><T>, <T>Dinero<T>)<BR>    Si<BR>      hDinero:CtaDinero.Tipo=<T>Caja<T><BR>    Entonces<BR>      Asigna(Temp.Texto, SQL(<T>spAlertaCtaDinero :tEmp, :tCta<T>, Empresa, hDinero:hDinero.CtaDinero))<BR>      Si(ConDatos(Temp.Texto), Precaucion(Temp.Texto))<BR>      Si<BR>        ConDatos(hDinero:hDinero.CtaDineroDestino)<BR>      Entonces<BR>        Asigna(Temp.Texto, SQL(<T>spAlertaCtaDinero :tEmp, :tCta<T>, Empresa, hDinero:hDinero.CtaDineroDestino))<BR>        Si(ConDatos(Temp.Texto), Precaucion(Temp.Texto))<BR>      Fin<BR>    Fin<BR>  Fin<BR>Fin
ActivoCondicion=Si  (MovTipo(<T>DIN<T>,hDinero:hDinero.Mov) = <T>DIN.CH<T> )  y (hDinero:hDinero.ContactoTipo = <T>Proveedor<T>)    <BR>Entonces<BR>  Asigna(Info.MovGenerar, SQL(<T>SELECT CxpChequeDevuelto FROM EmpresaCfgMovCxp WHERE Empresa =:tEmpresa<T>,Empresa))<BR>  Asigna(Info.PuedeEditar,Vacio(SQL(<T>SELECT 1 FROM usuarioAcceso WHERE MovsEdicion like :tMovaGenerar AND Usuario =:tUsuario<T>, <T>%Cxp.<T>&Info.MovGenerar&<T>%<T>, Usuario),Falso))<BR>Fin<BR>PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, hDinero:hDinero.Usuario) y<BR>((hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) o<BR> ((hDinero:hDinero.Estatus=EstatusPendiente) y (MovTipo(<T>DIN<T>, hDinero:hDinero.Mov)<>DIN.DA)) o<BR>( ((hDinero:hDinero.Estatus=EstatusConcluido) y (MovTipo(<T>DIN<T>, hDinero:hDinero.Mov)=DIN.CH)) y (hDinero:hDinero.ChequeDevuelto <> VERDADERO) y Info.PuedeEditar))  y<BR>fnPuedeAvanzarEstatus(Empresa, <T>DIN<T>, hDinero:hDinero.Mov, hDinero:hDinero.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(hDinero:hDinero.Mov)
AntesExpresiones=Si(General.AdvertirProyectosExpirados, Si(SQL(<T>SELECT COUNT(*) FROM Proy WHERE (Estatus = :tBaja OR FechaFin+1<GETDATE()) AND Proyecto=:tProy<T>, EstatusBaja, hDinero:hDinero.Proyecto) > 0, Si(Precaucion(<T>Proyecto Expirado<T>, BotonAceptar, BotonCancelar)=BotonCancelar, AbortarOperacion)))<BR>Si<BR>  ConDatos(hDinero:hDinero.CtaDinero) y (MovTipo(<T>DIN<T>, hDinero:hDinero.Mov) = DIN.D) y (hDinero:hDinero.Moneda<>hDinero:CtaDinero.Moneda)<BR>Entonces<BR>  Si<BR>    Confirmacion(<T>La Moneda del <T>+hDinero:hDinero.Mov+<BR>                 <T> Difiere con la Moneda de la Cuenta.<T>+<BR>                  NuevaLinea+<BR>                 <T>El Importe se Va a Convertir a la Moneda de la Cuenta.<T>+<BR>                  NuevaLinea+NuevaLinea+<BR>                 <T>¿ Desea Continuar ?<T>, BotonSi, BotonNo) = BotonNo<BR>  Entonces<BR>    AbortarOperacion<BR>  Fin <BR>Fin<BR>Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>DIN<T>, hDinero:hDinero.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>DIN<T>, hDinero:hDinero.Mov, hDinero:hDinero.ID, Verdadero, hDinero:hDinero.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn
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
ActivoCondicion=Vacio(hDinero:hDinero.MovID) y (hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, hDinero:hDinero.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM hDinero WHERE ID=:nID<T>, hDinero:hDinero.ID))
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
ListaParametros1=hDinero:hDinero.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>DIN<T>, hDinero:hDinero.Mov, hDinero:hDinero.Estatus), hDinero:hDinero.ID)
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
ListaParametros1=hDinero:hDinero.ID
EspacioPrevio=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>DIN<T>, hDinero:hDinero.Mov, hDinero:hDinero.Estatus), hDinero:hDinero.ID)
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
Expresion=Cancelar(<T>DIN<T>, hDinero:hDinero.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Dinero<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, hDinero:hDinero.Usuario) y ConDatos(hDinero:hDinero.ID) y ConDatos(hDinero:hDinero.MovID) y<BR>((hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusSincro, EstatusPendiente)) o ((hDinero:hDinero.Estatus=EstatusConcluido) y (MovTipo(<T>DIN<T>,hDinero:hDinero.Mov) <> DIN.DA)))
AntesExpresiones=Asigna( Afectar.Mov, hDinero:hDinero.Mov ) <BR>Asigna( Afectar.MovID, hDinero:hDinero.MovID )

[Ficha.hDinero.Moneda]
Carpeta=Ficha
Clave=hDinero.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.hDinero.TipoCambio]
Carpeta=Ficha
Clave=hDinero.TipoCambio
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
Expresion=Verificar(<T>DIN<T>, hDinero:hDinero.ID,hDinero:hDinero.Mov,hDinero:hDinero.MovID)
ActivoCondicion=hDinero:hDinero.Estatus en (EstatusSinAfectar,EstatusPorConfirmar,EstatusBorrador)
EjecucionCondicion=ConDatos(hDinero:hDinero.Mov)

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
EjecucionCondicion=ConDatos( hDinero:hDinero.CtaDinero)
AntesExpresiones=Asigna( Info.CtaDinero, hDinero:hDinero.CtaDinero )

[Ficha.hDinero.FechaProgramada]
Carpeta=Ficha
Clave=hDinero.FechaProgramada
Editar=S
ValidaNombre=S
3D=S
Tamano=17
EditarConBloqueo=N
ColorFondo=Blanco

[Ficha.hDinero.Directo]
Carpeta=Ficha
Clave=hDinero.Directo
Editar=S
3D=S
Tamano=17
Pegado=N
ColorFondo=Blanco

[Detalle.hDineroD.Aplica]
Carpeta=Detalle
Clave=hDineroD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.hDineroD.AplicaID]
Carpeta=Detalle
Clave=hDineroD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.hDinero.Saldo]
Carpeta=Ficha
Clave=hDinero.Saldo
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

ActivoCondicion=hDinero:hDinero.ConDesglose y(hDinero:hDinero.Estatus en(EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
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

[(Carpeta Abrir).hDinero.Referencia]
Carpeta=(Carpeta Abrir)
Clave=hDinero.Referencia
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
ActivoCondicion=ConDatos(hDinero:hDinero.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.MovID, hDinero:hDinero.MovID)
[(Carpeta Abrir).hDinero.BeneficiarioNombre]
Carpeta=(Carpeta Abrir)
Clave=hDinero.BeneficiarioNombre
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

[(Carpeta Abrir).hDinero.CtaDineroDestino]
Carpeta=(Carpeta Abrir)
Clave=hDinero.CtaDineroDestino
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

Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>DIN<T>, hDinero:hDinero.Mov, hDinero:hDinero.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>DIN<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>DIN<T>, hDinero:hDinero.Mov, hDinero:hDinero.Estatus, FormaSituacion, Usuario)
AntesExpresiones=Si(Vacio(hDinero:hDinero.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.Estatus, hDinero:hDinero.Estatus)<BR>Asigna(Info.Situacion, hDinero:hDinero.Situacion)
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
EjecucionCondicion=ConDatos(hDinero:hDinero.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.MovID, hDinero:hDinero.MovID)
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
ActivoCondicion=ConDatos(hDineroA:hDinero.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDineroA:hDinero.ID)

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
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.Usuario, hDinero:hDinero.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(hDinero:hDinero.ID)

[(Carpeta Abrir).hDinero.Moneda]
Carpeta=(Carpeta Abrir)
Clave=hDinero.Moneda
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
AntesExpresiones=Asigna(Info.Rama, <T>DIN<T>)<BR>Asigna(Info.Fecha, hDinero:hDinero.FechaEmision)<BR>Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (hDinero:hDinero.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, hDinero:hDinero.Mov+<T> <T>+hDinero:hDinero.MovID)
RefrescarDespues=S

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

Expresion=Caso  fnSubMovTipo( <T>DIN<T>, hDinero:hDinero.Mov )<BR>  Es <T>DIN.CMULTIMONEDA<T> Entonces EjecutarSQL(<T>spDineroSugerirCorteMultimoneda :nSucursal, :nID, :tEmpresa, :tCta<T>, Sucursal, hDinero:hDinero.ID, Empresa, hDinero:hDinero.CtaDinero)<BR>  ES <T>DIN.CPMULTIMONEDA<T> Entonces EjecutarSQL(<T>spDineroSugerirCorteMultimoneda :nSucursal, :nID, :tEmpresa, :tCta<T>, Sucursal, hDinero:hDinero.ID, Empresa, hDinero:hDinero.CtaDinero)<BR>SiNo  <BR>  EjecutarSQL(<T>spDineroSugerirCorte :nSucursal, :nID, :tEmpresa, :tCta, :tMoneda<T>, Sucursal, hDinero:hDinero.ID, Empresa, hDinero:hDinero.CtaDinero, hDinero:hDinero.Moneda)<BR>Fin
ActivoCondicion=MovTipoEn(<T>DIN<T>, hDinero:hDinero.Mov, (DIN.C, DIN.CP, DIN.TC)) y (hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar))
[Ficha.hDinero.FormaPago]
Carpeta=Ficha
Clave=hDinero.FormaPago
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
ActivoCondicion=MovTipoEn(<T>DIN<T>, hDinero:hDinero.Mov, (DIN.C, DIN.CP)) y (hDinero:hDinero.Estatus=EstatusConcluido)
AntesExpresiones=Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.MovID, hDinero:hDinero.MovID)<BR>Asigna(Info.CtaDinero, hDinero:hDinero.CtaDinero)<BR>Asigna(Info.Descripcion, hDinero:CtaDinero.Descripcion)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(hDinero:hDinero.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDinero:hDinero.ID)
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
Expresion=CopiarMovimiento(<T>DIN<T>, hDinero:hDinero.ID, <T>Dinero<T>)

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
AntesExpresiones=Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.MovID, hDinero:hDinero.MovID)
VisibleCondicion=hDinero:hDinero.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[(Carpeta Abrir).hDinero.Saldo]
Carpeta=(Carpeta Abrir)
Clave=hDinero.Saldo
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
Vista=hDinero
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
CondicionVisible=ConDatos(hDinero:hDinero.InstitucionMensaje)

[Institucion.hDinero.Mov]
Carpeta=Institucion
Clave=hDinero.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Plata
ColorFuente=Negro

[Institucion.hDinero.MovID]
Carpeta=Institucion
Clave=hDinero.MovID
Editar=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=8
Pegado=S

[Institucion.hDinero.InstitucionMensaje]
Carpeta=Institucion
Clave=hDinero.InstitucionMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Institucion.hDinero.InstitucionSucursal]
Carpeta=Institucion
Clave=hDinero.InstitucionSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Institucion.hDinero.InstitucionReferencia1]
Carpeta=Institucion
Clave=hDinero.InstitucionReferencia1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Institucion.hDinero.InstitucionReferencia2]
Carpeta=Institucion
Clave=hDinero.InstitucionReferencia2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Institucion.hDinero.FechaEmision]
Carpeta=Institucion
Clave=hDinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Institucion.hDinero.Importe]
Carpeta=Institucion
Clave=hDinero.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Institucion.hDinero.Observaciones]
Carpeta=Institucion
Clave=hDinero.Observaciones
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
ActivoCondicion=Usuario.ModificarSucursalDestino y (hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y (no FormaBloqueada)
Antes=S
AntesExpresiones=Si(Vacio(hDinero:hDinero.ID),GuardarCambios)
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
ActivoCondicion=MovTipoEn(<T>DIN<T>,hDinero:hDinero.Mov, (DIN.T, DIN.TI, DIN.INV, DIN.RET, DIN.TC, DIN.A, DIN.AP, DIN.CP, DIN.C)) y Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(hDinero:hDinero.CtaDineroDestino)
AntesExpresiones=Asigna( Info.CtaDinero, hDinero:hDinero.CtaDineroDestino )
VisibleCondicion=MovTipoEn(<T>DIN<T>,hDinero:hDinero.Mov, (DIN.T, DIN.TI, DIN.INV, DIN.RET, DIN.TC, DIN.A, DIN.AP, DIN.CP, DIN.C))

[Ficha.CtaDinero.Descripcion]
Carpeta=Ficha
Clave=CtaDinero.Descripcion
Editar=S
3D=S
Tamano=31
ColorFondo=Plata

[Ficha.hDineroSaldo.Saldo]
Carpeta=Ficha
Clave=hDineroSaldo.Saldo
Editar=S
3D=S
Tamano=17
ColorFondo=Plata
ColorFuente=Azul marino
Efectos=[Negritas]

[Ficha.hDinero.Cajero]
Carpeta=Ficha
Clave=hDinero.Cajero
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
ActivoCondicion=ConDatos(hDinero:hDinero.Mensaje)
AntesExpresiones=Asigna(Afectar.FormaCaptura, <T>Dinero<T>)<BR>Asigna(Afectar.Modulo, <T>DIN<T>)<BR>Asigna(Afectar.ID, hDinero:hDinero.ID)<BR>Asigna(Afectar.Mov, hDinero:hDinero.Mov)<BR>Asigna(Afectar.MovID, hDinero:hDinero.MovID)<BR>Asigna(Info.Descripcion, hDinero:MensajeLista.Descripcion)
VisibleCondicion=ConDatos(hDinero:hDinero.Mensaje)

[Ficha.hDinero.UEN]
Carpeta=Ficha
Clave=hDinero.UEN
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
EjecucionCondicion=ConDatos(hDinero:hDinero.Proyecto)
Antes=S
AntesExpresiones=Asigna(Info.Proyecto, hDinero:hDinero.Proyecto)
Visible=S

[Ficha.CtaDineroDestino.Moneda]
Carpeta=Ficha
Clave=CtaDineroDestino.Moneda
Editar=S
3D=S
Tamano=10
ColorFondo=Plata

[Ficha.hDinero.TipoCambioDestino]
Carpeta=Ficha
Clave=hDinero.TipoCambioDestino
Editar=S
3D=S
Pegado=S
Tamano=7
ColorFondo=Blanco

[Ficha.hDinero.LeyendaCheque]
Carpeta=Ficha
Clave=hDinero.LeyendaCheque
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
Expresion=Asigna(Info.Importe, hDinero:ImporteTotal)<BR>Asigna(Info.PorcentajeImpuesto, General.DefImpuesto)<BR>Si<BR>  Forma(<T>EspecificarImporteConImpuestos<T>)<BR>Entonces<BR>  Asigna(hDinero:hDinero.Importe,  Redondea(Info.Importe/(1+(Info.PorcentajeImpuesto/100)), 4))<BR>  Asigna(hDinero:hDinero.Impuestos, Info.Importe-hDinero:hDinero.Importe)<BR>Fin
ActivoCondicion=(hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y MovTipoEn(<T>DIN<T>,hDinero:hDinero.Mov,(DIN.CB,DIN.AB))

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=0
Menu=&Archivo
NombreDesplegar=E&valuaciones
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.Clave, <T>DIN<T>+hDinero:hDinero.ID)<BR>Asigna(Info.Nombre, hDinero:hDinero.Mov+<T> <T>+hDinero:hDinero.MovID)<BR>Asigna(Info.Aplica, <T>Movimientos<T>)<BR>Forma(Si(hDinero:hDinero.Estatus en (EstatusConcluido, EstatusCancelado), <T>EvaluacionCalificacionInfo<T>, <T>EvaluacionCalificacion<T>))
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
Expresion=Si(MovTipo(<T>DIN<T>,hDinero:hDinero.Mov) noen (DIN.CB,DIN.AB), Asigna(hDinero:hDinero.Importe, Suma(hDineroD:hDineroD.Importe)))

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
Vista=hDinero
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
CondicionVisible=MovTipoEn(<T>DIN<T>, hDinero:hDinero.Mov, (DIN.CH, DIN.CHE))

[Comision.hDinero.CargoBancario]
Carpeta=Comision
Clave=hDinero.CargoBancario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Comision.hDinero.CargoBancarioIVA]
Carpeta=Comision
Clave=hDinero.CargoBancarioIVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hDinero.Prioridad]
Carpeta=Ficha
Clave=hDinero.Prioridad
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
AntesExpresiones=Asigna(Info.PuedeEditar, hDinero:hDinero.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Nombre, Nulo)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.MovID, hDinero:hDinero.MovID)<BR>Asigna(Info.Proyecto, hDinero:hDinero.Proyecto)<BR>Asigna(Info.UEN, hDinero:hDinero.UEN)<BR>Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDinero:hDinero.ID)<BR><BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, hDinero:hDinero.Cajero)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Reporte, Nulo)

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
Vista=hDinero
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

[Comentarios.hDinero.Comentarios]
Carpeta=Comentarios
Clave=hDinero.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=89x13
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios.hDinero.Nota]
Carpeta=Comentarios
Clave=hDinero.Nota
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
Vista=hDinero
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
CondicionVisible=MovTipoEn(<T>DIN<T>, hDinero:hDinero.Mov, (DIN.INV, DIN.RET))

[Intereses.hDinero.Vencimiento]
Carpeta=Intereses
Clave=hDinero.Vencimiento
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

[Intereses.hDinero.FechaOrigen]
Carpeta=Intereses
Clave=hDinero.FechaOrigen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Intereses.hDinero.Tasa]
Carpeta=Intereses
Clave=hDinero.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Intereses.hDinero.TasaDias]
Carpeta=Intereses
Clave=hDinero.TasaDias
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.hDinero.ContUso]
Carpeta=Ficha
Clave=hDinero.ContUso
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
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.MovID, hDinero:hDinero.MovID)<BR>Asigna(Info.Fecha, hDinero:hDinero.FechaEmision)<BR>Asigna(Info.Estatus, hDinero:hDinero.Estatus)

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
EjecucionCondicion=ConDatos(hDinero:hDinero.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>DIN<T>)<BR>Asigna(Info.Clave, hDinero:hDinero.Mov)

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
EjecucionCondicion=ConDatos(hDinero:hDinero.Concepto)
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.Concepto, hDinero:hDinero.Concepto)

[Comentarios.hDinero.ContactoTipo]
Carpeta=Comentarios
Clave=hDinero.ContactoTipo
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Comentarios.hDinero.Contacto]
Carpeta=Comentarios
Clave=hDinero.Contacto
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Detalle.hDineroD.ContUso]
Carpeta=Detalle
Clave=hDineroD.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Intereses.hDinero.TasaRetencion]
Carpeta=Intereses
Clave=hDinero.TasaRetencion
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
Expresion=Asigna(Info.Forma, <T>Dinero<T>)<BR>Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.Nombre, hDinero:hDinero.Mov)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
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
Vista=hDinero
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
CondicionVisible=MovTipo(<T>DIN<T>, hDinero:hDinero.Mov) = DIN.ACXC

[Cliente.hDinero.Cliente]
Carpeta=Cliente
Clave=hDinero.Cliente
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
Vista=hDinero
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
CondicionVisible=MovTipo(<T>DIN<T>, hDinero:hDinero.Mov) = DIN.ACXP

[Proveedor.hDinero.Proveedor]
Carpeta=Proveedor
Clave=hDinero.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Proveedor.hProv.Nombre]
Carpeta=Proveedor
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=60
ColorFondo=Plata
ColorFuente=Negro

[Cliente.hDinero.ClienteEnviarA]
Carpeta=Cliente
Clave=hDinero.ClienteEnviarA
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
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasMovimiento(<T>DIN<T>, hDinero:hDinero.Mov, hDinero:hDinero.ID, Falso, hDinero:hDinero.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))<BR>Sino<BR>  Asigna(Info.Aplica, <T>Movimiento<T>)<BR>  Asigna(Info.Clave, <T>DIN<T>+hDinero:hDinero.ID)<BR>  Asigna(Info.Nombre, hDinero:hDinero.Mov+<T> <T>+hDinero:hDinero.MovID)<BR>  Asigna(Info.Modulo, <T>DIN<T>)<BR>  Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si<BR>    ConDatos(Info.FormaTipo)<BR>  Entonces<BR>    Si <BR>      hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)<BR>    Entonces<BR>      iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Sino<BR>      iConsulta(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Tiene Definida Ninguna Forma<T>)<BR>  Fin<BR>Fin

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
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.MovID, hDinero:hDinero.MovID)
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
ActivoCondicion=Usuario.EnviarExcel y (hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=hDinero:hDinero.ConDesglose o (no hDinero:hDinero.Directo)

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
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisibleMovimiento(<T>DIN<T>, <T>{hDinero:hDinero.Mov}<T>)) AND FormaExtraValor.Aplica=<T>Movimiento<T> AND FormaExtraValor.AplicaClave=<T>DIN{hDinero:hDinero.ID}<T>

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

[Intereses.hDinero.InteresTipo]
Carpeta=Intereses
Clave=hDinero.InteresTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Intereses.hDinero.Titulo]
Carpeta=Intereses
Clave=hDinero.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Intereses.hDinero.TituloValor]
Carpeta=Intereses
Clave=hDinero.TituloValor
Editar=S
3D=S
Tamano=10
ColorFuente=Negro
ColorFondo=Blanco
ValidaNombre=S
Pegado=S

[Intereses.hDinero.ValorOrigen]
Carpeta=Intereses
Clave=hDinero.ValorOrigen
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Intereses.hDinero.Retencion]
Carpeta=Intereses
Clave=hDinero.Retencion
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
Vista=hDinero
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
CondicionVisible=MovTipo(<T>DIN<T>, hDinero:hDinero.Mov) = DIN.REI

[Titulo.hDinero.Titulo]
Carpeta=Titulo
Clave=hDinero.Titulo
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

[Titulo.hDinero.TituloValor]
Carpeta=Titulo
Clave=hDinero.TituloValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Titulo.hDinero.ValorOrigen]
Carpeta=Titulo
Clave=hDinero.ValorOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.hDineroD.Institucion]
Carpeta=Detalle
Clave=hDineroD.Institucion
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
0=105
1=247

2=-2
CentroCostos=127
Descripcion=186
CentroCostos2=127
CentroCostos3=127
CtaDinero=84
Moneda=65
Beneficiario=277
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
VistaMaestra=hDinero
LlaveLocal=MovImpuestoMov.ModuloID
LlaveMaestra=hDinero.ID
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
CondicionVisible=((hDinero:hDinero.Estatus = EstatusConcluido) o (hDinero:hDinero.Estatus = EstatusCancelado)) y (Config.VisualizarArrastre)
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
[Institucion.ListaEnCaptura]
(Inicio)=hDinero.Mov
hDinero.Mov=hDinero.MovID
hDinero.MovID=hDinero.FechaEmision
hDinero.FechaEmision=hDinero.Importe
hDinero.Importe=hDinero.InstitucionMensaje
hDinero.InstitucionMensaje=hDinero.InstitucionSucursal
hDinero.InstitucionSucursal=hDinero.InstitucionReferencia1
hDinero.InstitucionReferencia1=hDinero.InstitucionReferencia2
hDinero.InstitucionReferencia2=hDinero.Observaciones
hDinero.Observaciones=(Fin)

[Comision.ListaEnCaptura]
(Inicio)=hDinero.CargoBancario
hDinero.CargoBancario=hDinero.CargoBancarioIVA
hDinero.CargoBancarioIVA=(Fin)

[Comentarios.ListaEnCaptura]
(Inicio)=hDinero.Comentarios
hDinero.Comentarios=hDinero.Nota
hDinero.Nota=hDinero.ContactoTipo
hDinero.ContactoTipo=hDinero.Contacto
hDinero.Contacto=(Fin)

[Intereses.ListaEnCaptura]
(Inicio)=hDinero.FechaOrigen
hDinero.FechaOrigen=hDinero.InteresTipo
hDinero.InteresTipo=hDinero.Tasa
hDinero.Tasa=hDinero.TasaDias
hDinero.TasaDias=hDinero.Titulo
hDinero.Titulo=hDinero.TituloValor
hDinero.TituloValor=hDinero.ValorOrigen
hDinero.ValorOrigen=hDinero.Vencimiento
hDinero.Vencimiento=Dias
Dias=InteresBruto
InteresBruto=hDinero.TasaRetencion
hDinero.TasaRetencion=hDinero.Retencion
hDinero.Retencion=InteresNeto
InteresNeto=(Fin)

[Cliente.ListaEnCaptura]
(Inicio)=hDinero.Cliente
hDinero.Cliente=Cte.Nombre
Cte.Nombre=hDinero.ClienteEnviarA
hDinero.ClienteEnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Clave
CteEnviarA.Clave=(Fin)

[Proveedor.ListaEnCaptura]
(Inicio)=hDinero.Proveedor
hDinero.Proveedor=Prov.Nombre
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
(Inicio)=hDinero.Titulo
hDinero.Titulo=Titulo.Nombre
Titulo.Nombre=hDinero.TituloValor
hDinero.TituloValor=hDinero.ValorOrigen
hDinero.ValorOrigen=(Fin)


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


































ActivoCondicion=hDinero:MovTipo.ReservarCP=<T>Desreservar<T>
AntesExpresiones=Asigna(Info.PuedeEditar, hDinero:hDinero.Estatus en (EstatusSinAfectar, EstatusBorrador, EstatusPorConfirmar))<BR>Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, hDinero:hDinero.ID)<BR>Asigna(Info.Mov, hDinero:hDinero.Mov)<BR>Asigna(Info.MovID, hDinero:hDinero.MovID)  <BR>Asigna(Info.Ejercicio, Año(hDinero:hDinero.FechaEmision))<BR>Asigna(Info.ClavePresupuestal, Nulo)<BR>Asigna(Info.Tipo, <T>Reduccion<T>)<BR>Asigna(Info.Importe, hDinero:ImporteTotal)
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
Vista=hDinero
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


CondicionVisible=(Config.ContUsoDinero) Y (Vacio(hDinero:hDinero.OrigenTipo))
[CentrosCostos.hDinero.ContUso]
Carpeta=CentrosCostos
Clave=hDinero.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CentrosCostos.hDinero.ContUso2]
Carpeta=CentrosCostos
Clave=hDinero.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CentrosCostos.hDinero.ContUso3]
Carpeta=CentrosCostos
Clave=hDinero.ContUso3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







[Detalle.hDineroD.ContUso2]
Carpeta=Detalle
Clave=hDineroD.ContUso2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.hDineroD.ContUso3]
Carpeta=Detalle
Clave=hDineroD.ContUso3
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







[Detalle.hDineroD.CtaDinero]
Carpeta=Detalle
Clave=hDineroD.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hDineroD.CtaDineroDestino]
Carpeta=Detalle
Clave=hDineroD.CtaDineroDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.hDineroD.Moneda]
Carpeta=Detalle
Clave=hDineroD.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.hDineroD.TipoCambio]
Carpeta=Detalle
Clave=hDineroD.TipoCambio
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




































































































[Ficha.ListaEnCaptura]
(Inicio)=hDinero.Mov
hDinero.Mov=hDinero.MovID
hDinero.MovID=hDinero.Proyecto
hDinero.Proyecto=hDinero.UEN
hDinero.UEN=hDinero.Moneda
hDinero.Moneda=hDinero.TipoCambio
hDinero.TipoCambio=hDinero.FechaEmision
hDinero.FechaEmision=hDinero.FechaProgramada
hDinero.FechaProgramada=hDinero.Prioridad
hDinero.Prioridad=hDinero.CtaDinero
hDinero.CtaDinero=CtaDinero.Descripcion
CtaDinero.Descripcion=DineroSaldo.Saldo
DineroSaldo.Saldo=hDinero.CtaDineroDestino
hDinero.CtaDineroDestino=CtaDineroDestino.Descripcion
CtaDineroDestino.Descripcion=CtaDineroDestino.Moneda
CtaDineroDestino.Moneda=hDinero.TipoCambioDestino
hDinero.TipoCambioDestino=hDinero.BeneficiarioNombre
hDinero.BeneficiarioNombre=hDinero.LeyendaCheque
hDinero.LeyendaCheque=hDinero.Importe
hDinero.Importe=hDinero.Impuestos
hDinero.Impuestos=ImporteTotal
ImporteTotal=hDinero.Concepto
hDinero.Concepto=hDinero.Cajero
hDinero.Cajero=Agente.Nombre
Agente.Nombre=hDinero.Referencia
hDinero.Referencia=hDinero.FormaPago
hDinero.FormaPago=hDinero.Saldo
hDinero.Saldo=hDinero.Observaciones
hDinero.Observaciones=hDinero.ConDesglose
hDinero.ConDesglose=hDinero.Directo
hDinero.Directo=hDinero.ContUso
hDinero.ContUso=(Fin)

















































































































































































































































































[CentrosCostos.ListaEnCaptura]
(Inicio)=hDinero.ContUso
hDinero.ContUso=hDinero.ContUso2
hDinero.ContUso2=hDinero.ContUso3
hDinero.ContUso3=(Fin)








































[Detalle.ListaEnCaptura]
(Inicio)=hDineroD.Aplica
hDineroD.Aplica=hDineroD.AplicaID
hDineroD.AplicaID=hDineroD.Importe
hDineroD.Importe=hDineroD.FormaPago
hDineroD.FormaPago=hDineroD.Referencia
hDineroD.Referencia=hDineroD.ContUso
hDineroD.ContUso=hDineroD.ContUso2
hDineroD.ContUso2=hDineroD.ContUso3
hDineroD.ContUso3=hDineroD.Institucion
hDineroD.Institucion=hDineroD.CtaDinero
hDineroD.CtaDinero=hDineroD.CtaDineroDestino
hDineroD.CtaDineroDestino=hDineroD.Moneda
hDineroD.Moneda=hDineroD.TipoCambio
hDineroD.TipoCambio=ImporteTipoCambioD
ImporteTipoCambioD=(Fin)

[Detalle.ListaCamposAValidar]
(Inicio)=DineroValidacion.FechaEmision
DineroValidacion.FechaEmision=DineroValidacion.Saldo
DineroValidacion.Saldo=InstitucionFin.Nombre
InstitucionFin.Nombre=(Fin)

[Detalle.ListaOrden]
(Inicio)=hDineroD.Renglon	(Acendente)
hDineroD.Renglon	(Acendente)=hDineroD.RenglonSub	(Acendente)
hDineroD.RenglonSub	(Acendente)=(Fin)





















































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
Vista=hDinero
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

ListaEnCaptura=hDinero.EmidaRequestId

CondicionVisible=General.InterfazEmida
[Emida.hDinero.EmidaRequestId]
Carpeta=Emida
Clave=hDinero.EmidaRequestId
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
(Inicio)=hDinero.CtaDinero
hDinero.CtaDinero=hDinero.CtaDineroDestino
hDinero.CtaDineroDestino=hDinero.Referencia
hDinero.Referencia=hDinero.BeneficiarioNombre
hDinero.BeneficiarioNombre=hDinero.FechaEmision
hDinero.FechaEmision=ImporteTotal
ImporteTotal=hDinero.Saldo
hDinero.Saldo=hDinero.Moneda
hDinero.Moneda=(Fin)

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
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Otros
&Otros=(Fin)
