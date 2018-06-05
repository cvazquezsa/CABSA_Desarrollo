[Forma]
Clave=VentaCobro
Nombre=Si(Info.VentaCobroDevolucion, <T>Devolución<T>,<T>Cobro<T>)+<T> - <T>+Afectar.Mov
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAltura=333
PosicionInicialAncho=609
PosicionInicialIzquierda=463
PosicionInicialArriba=131
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=78
Comentarios=Si<BR>  no Info.Cerrado<BR>Entonces<BR>  Si<BR>    Vacio(VentaCobro:VentaCobro.ID)<BR>  Entonces<BR>    Asigna(VentaCobro:VentaCobro.ID, Info.ID)<BR>    Si<BR>      no Info.VentaCobroDevolucion<BR>    Entonces<BR>      Asigna(Temp.Monetario, SQL(<T>spSugerirVentaCobroEfectivo :nID<T>, Afectar.ID))<BR>      Si(Temp.Monetario<0, Asigna(Temp.Monetario, 0.0))<BR>      Si((Temp.Monetario>Info.Importe) y (Info.Importe>0), Asigna(Temp.Monetario, Info.Importe))<BR>      Si<BR>        Temp.Monetario>0.0<BR>      Entonces<BR>        Si<BR>          Confirmacion(<T>Desea Utilizar <T>+MonetarioEnTexto(Temp.Monetario)+<T> del Saldo a Favor<T>, BotonSi, BotonNo) = BotonSi<BR>        Entonces<BR>          Si(Temp.Monetario>0, Asigna(VentaCobro:VentaCobro.DelEfectivo, Temp.Monetario))<BR>        Sino<BR>          Asigna(Temp.Monetario, 0.0)<BR>        Fin<BR>      Fin<BR>    Sino<BR>      Asigna(Temp.Monetario, 0.0)<BR>    Fin<BR>    Asigna(VentaCobro:VentaCobro.Importe1, Info.Importe-Temp.Monetario+VentaCobro:VentaCobro.Redondeo)<BR><BR>  Si(Vacio(Info.FormaPagoTipo), Asigna(VentaCobro:VentaCobro.FormaCobro1, Vacio(Usuario.DefFormaPago, Config.FormaCobroOmision)))<BR>  Asigna(VentaCobro:VentaCobro.CtaDinero, Usuario.DefCtaDinero)<BR>  Asigna(VentaCobro:VentaCobro.Cajero, Usuario.DefCajero)<BR>  Asigna(VentaCobro:VentaCobro.FormaCobroCambio,Config.FormaPagoCambio)<BR> Fin<BR>      <BR>Fin<BR>Lista(Info.Mov,Info.MovID)<BR>//Info.Moneda
Menus=S
PosicionInicialAlturaCliente=512
ExpresionesAlMostrar=Asigna(Info.FormaPagoTipo, SQL(<T>SELECT FormaPagoTipo FROM Venta WHERE ID=:nID<T>, Info.ID))<BR>Asigna(Info.MonederoCBPosicion,0)<BR>Asigna(Info.MonederoCBFormaCobro,nulo)
VentanaEstadoInicial=Normal
VentanaColor=Plata
VentanaExclusivaOpcion=0

MenuPrincipal=(Lista)
[Documentos.VentaCobro.Mov1]
Carpeta=Documentos
Clave=VentaCobro.Mov1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Documentos.VentaCobro.MovID1]
Carpeta=Documentos
Clave=VentaCobro.MovID1
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
Pegado=N

[Documentos.VentaCobro.MovImporte1]
Carpeta=Documentos
Clave=VentaCobro.MovImporte1
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20

[Documentos.VentaCobro.Mov2]
Carpeta=Documentos
Clave=VentaCobro.Mov2
Editar=S
LineaNueva=S
3D=S
Tamano=20

[Documentos.VentaCobro.MovID2]
Carpeta=Documentos
Clave=VentaCobro.MovID2
Editar=S
3D=S
Tamano=10

[Documentos.VentaCobro.MovImporte2]
Carpeta=Documentos
Clave=VentaCobro.MovImporte2
Editar=S
3D=S
Tamano=20

[Documentos.VentaCobro.Mov3]
Carpeta=Documentos
Clave=VentaCobro.Mov3
Editar=S
LineaNueva=S
3D=S
Tamano=20

[Documentos.VentaCobro.MovID3]
Carpeta=Documentos
Clave=VentaCobro.MovID3
Editar=S
3D=S
Tamano=10

[Documentos.VentaCobro.MovImporte3]
Carpeta=Documentos
Clave=VentaCobro.MovImporte3
Editar=S
3D=S
Tamano=20

[Documentos.VentaCobro.Mov4]
Carpeta=Documentos
Clave=VentaCobro.Mov4
Editar=S
LineaNueva=S
3D=S
Tamano=20

[Documentos.VentaCobro.MovID4]
Carpeta=Documentos
Clave=VentaCobro.MovID4
Editar=S
3D=S
Tamano=10

[Documentos.VentaCobro.MovImporte4]
Carpeta=Documentos
Clave=VentaCobro.MovImporte4
Editar=S
3D=S
Tamano=20

[Documentos.VentaCobro.Mov5]
Carpeta=Documentos
Clave=VentaCobro.Mov5
Editar=S
LineaNueva=S
3D=S
Tamano=20

[Documentos.VentaCobro.MovID5]
Carpeta=Documentos
Clave=VentaCobro.MovID5
Editar=S
3D=S
Tamano=10

[Documentos.VentaCobro.MovImporte5]
Carpeta=Documentos
Clave=VentaCobro.MovImporte5
Editar=S
3D=S
Tamano=20

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Visible=S
NombreEnBoton=S
Menu=&Archivo
EnMenu=S
ActivoCondicion=(no Info.Cerrado) y (Vacio(VentaCobro:Venta.Estatus, EstatusSinAfectar) en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Totales.Pendiente]
Carpeta=Totales
Clave=Pendiente
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Plata
ColorFuente=Rojo obscuro
Efectos=[Negritas]

[Totales.TotalLiquidado]
Carpeta=Totales
Clave=TotalLiquidado
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[Totales.CambioPendiente]
Carpeta=Totales
Clave=CambioPendiente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=<T>&Afectar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
EnMenu=S
ClaveAccion=Cerrar
NombreEnBoton=S
EspacioPrevio=S
Multiple=S
ListaAccionesMultiples=(Lista)
ActivoCondicion=(no Info.Cerrado) y (Vacio(VentaCobro:Venta.Estatus, EstatusSinAfectar) en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y (no Usuario.BloquearCobroInmediato)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=Cerra&r
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Ficha]
Estilo=Ficha
PestanaNombre=Efectivo
Clave=Ficha
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaCobro
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Verde
CampoColorFondo=$00E8E8E8
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
CondicionEdicion=(no Info.Cerrado) y (Vacio(VentaCobro:Venta.Estatus, EstatusSinAfectar) en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
FiltroGeneral=VentaCobro.ID = {Info.ID}
BarraBotones=S
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
ListaAccionesBB=(Lista)
BarraBtnPosicion=Arriba
BarraBtnSize=50
BarraBtnSeparacion=5
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=1

[Ficha.VentaCobro.DelEfectivo]
Carpeta=Ficha
Clave=VentaCobro.DelEfectivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=S
ColorFondo=Blanco

[Ficha.VentaCobro.Importe1]
Carpeta=Ficha
Clave=VentaCobro.Importe1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=22
ColorFondo=Blanco

[Ficha.VentaCobro.FormaCobro1]
Carpeta=Ficha
Clave=VentaCobro.FormaCobro1
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Referencia1]
Carpeta=Ficha
Clave=VentaCobro.Referencia1
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Importe2]
Carpeta=Ficha
Clave=VentaCobro.Importe2
Editar=S
LineaNueva=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ficha.VentaCobro.FormaCobro2]
Carpeta=Ficha
Clave=VentaCobro.FormaCobro2
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Referencia2]
Carpeta=Ficha
Clave=VentaCobro.Referencia2
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Importe3]
Carpeta=Ficha
Clave=VentaCobro.Importe3
Editar=S
LineaNueva=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ficha.VentaCobro.FormaCobro3]
Carpeta=Ficha
Clave=VentaCobro.FormaCobro3
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Referencia3]
Carpeta=Ficha
Clave=VentaCobro.Referencia3
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Importe4]
Carpeta=Ficha
Clave=VentaCobro.Importe4
Editar=S
LineaNueva=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ficha.VentaCobro.FormaCobro4]
Carpeta=Ficha
Clave=VentaCobro.FormaCobro4
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Referencia4]
Carpeta=Ficha
Clave=VentaCobro.Referencia4
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Importe5]
Carpeta=Ficha
Clave=VentaCobro.Importe5
Editar=S
LineaNueva=S
3D=S
Tamano=22
ColorFondo=Blanco

[Ficha.VentaCobro.FormaCobro5]
Carpeta=Ficha
Clave=VentaCobro.FormaCobro5
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Referencia5]
Carpeta=Ficha
Clave=VentaCobro.Referencia5
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.Pendiente]
Carpeta=Ficha
Clave=Pendiente
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Rojo obscuro
Efectos=[Negritas]
LineaNueva=N
EspacioPrevio=N

[Ficha.CambioPendiente]
Carpeta=Ficha
Clave=CambioPendiente
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Ficha.Total]
Carpeta=Ficha
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Plata
Efectos=[Negritas]
EspacioPrevio=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
ActivoCondicion=(no Info.Cerrado) y (Vacio(VentaCobro:Venta.Estatus, EstatusSinAfectar) en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))

[Acciones.Vales]
Nombre=Vales
Boton=96
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+L
NombreDesplegar=Va&les
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
Antes=S
Visible=S
NombreEnBoton=S
GuardarAntes=S
DespuesGuardar=S
ClaveAccion=Actualizar Forma
ActivoCondicion=(Info.Importe>0) y (no Info.VentaCobroDevolucion)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Mov, Afectar.Mov)<BR>Asigna(Info.MovID, Afectar.MovID)<BR>Si(Info.Cerrado, Forma(<T>ValeSerieMovInfo<T>), Forma(<T>ValeSerieMov<T>))

[Ficha.VentaCobro.CtaDinero]
Carpeta=Ficha
Clave=VentaCobro.CtaDinero
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Cajero]
Carpeta=Ficha
Clave=VentaCobro.Cajero
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.VentaCobro.Condicion]
Carpeta=Ficha
Clave=VentaCobro.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.VentaCobro.Vencimiento]
Carpeta=Ficha
Clave=VentaCobro.Vencimiento
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
Editar=S

[Acciones.Afectar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
Expresion=Asigna(VentaCobro:VentaCobro.Actualizado, Falso)<BR>GuardarCambios <BR><BR>Si(Usuario.AbrirCajon,Cajon.Abrir)<BR>Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)<BR>  Si SQL(<T>spMovReporteIntelisis :tEmpresa, :tModulo, :tMov, :nID, :nAfectar<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID, 1) Entonces<BR>    Asigna(Info.Reporte, SQL(<T>spMovFormatoIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID))<BR>    Asigna(Info.RutaArchivo, SQL(<T>spMovRutaIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID))<BR>    ReportePDF(Info.Reporte,Afectar.ID,Info.RutaArchivo)<BR>    EjecutarSQL(<T>spMovEnviarIntelisis :tEmpresa,:tModulo,:tMov,:nID<T>,Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID)              <BR>  Fin<BR>Si<BR>  Empresa.CFD y SQL(<T>spVerMovTipoCFD :tEmpresa, :tModulo, :tMov<T>, Empresa, Afectar.Modulo, Afectar.Mov)<BR>Entonces<BR>  Si(no CFD.Generar(Afectar.Modulo, Afectar.ID), AbortarOperacion)<BR>  Asigna(Afectar.EnviarCFD, SQL(<T>SELECT EnviarAlAfectar FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>, Empresa))<BR>Fin<BR><BR>Si<BR>  Afectar.EnviarCFD<BR>Entonces<BR>  CFD.Enviar(Afectar.Modulo, Afectar.ID)<BR>Fin
EjecucionCondicion=SQL(<T>SELECT Estatus FROM Venta WHERE ID=<T>+Info.ID) en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionMensaje=<T>El Movimiento Ya Fué Afectado por Otro Usuario<T>

[Acciones.Afectar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Tarjetas]
Nombre=Tarjetas
Boton=96
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=Tar&jetas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+K
Activo=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.Mov, Afectar.Mov)<BR>Asigna(Info.MovID, Afectar.MovID)<BR>Si(Info.Cerrado, Forma(<T>TarjetaSerieMovInfo<T>), Forma(<T>TarjetaSerieMov<T>))

[Ficha.VentaCobro.FormaCobroCambio]
Carpeta=Ficha
Clave=VentaCobro.FormaCobroCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.CambioPendienteMonEsp]
Carpeta=Ficha
Clave=CambioPendienteMonEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=$00E8E8E8
ColorFuente=$00A00000
Efectos=[Negritas]

[Ficha.CambioTipoCambio]
Carpeta=Ficha
Clave=CambioTipoCambio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=$00E8E8E8
ColorFuente=$00A00000
Efectos=[Negritas]

[Ficha.MovMoneda]
Carpeta=Ficha
Clave=MovMoneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=$00E8E8E8
ColorFuente=Verde
Efectos=[Negritas]

[Ficha.MovTipoCambio]
Carpeta=Ficha
Clave=MovTipoCambio
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=$00E8E8E8
ColorFuente=Verde
Efectos=[Negritas]

[Ficha.MovVenta]
Carpeta=Ficha
Clave=MovVenta
Editar=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=$00E8E8E8
ColorFuente=Verde
Efectos=[Negritas]
LineaNueva=S

[Acciones.MonInfo]
Nombre=MonInfo
Boton=34
NombreDesplegar=&Tipos de Cambio
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MonTipoCambioLista
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=(Lista)
ActivoCondicion=(no Info.Cerrado) y (Vacio(VentaCobro:Venta.Estatus, EstatusSinAfectar) en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador))
VisibleCondicion=(no Info.Cerrado) y (Vacio(VentaCobro:Venta.Estatus, EstatusSinAfectar) en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y(VentaCobro:VentaCobro.TCProcesado1 = Falso) y(VentaCobro:VentaCobro.TCProcesado2 = Falso) y(VentaCobro:VentaCobro.TCProcesado3 = Falso) y(VentaCobro:VentaCobro.TCProcesado4 = Falso) y(VentaCobro:VentaCobro.TCProcesado5 = Falso)

[Acciones.Actualizar.Registro Eliminar]
Nombre=Registro Eliminar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Actualizar.Registro Insertar]
Nombre=Registro Insertar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.Actualizar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Si(Vacio(Info.FormaPagoTipo), Asigna(VentaCobro:VentaCobro.FormaCobro1, Vacio(Usuario.DefFormaPago, Config.FormaCobroOmision)))<BR>  Asigna(VentaCobro:VentaCobro.CtaDinero, Usuario.DefCtaDinero)<BR>  Asigna(VentaCobro:VentaCobro.Cajero, Usuario.DefCajero)<BR>  Asigna(VentaCobro:VentaCobro.FormaCobroCambio,Config.FormaPagoCambio)
Activo=S
Visible=S

[Acciones.Actualizar.ListaAccionesMultiples]
(Inicio)=Registro Eliminar
Registro Eliminar=Registro Insertar
Registro Insertar=Expresion
Expresion=(Fin)

[Acciones.PinPad]
Nombre=PinPad
Boton=46
NombreEnBoton=S
NombreDesplegar=PinPad
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S
DespuesGuardar=S
Multiple=S
ListaAccionesMultiples=(Lista)
AntesExpresiones=Asigna(Temp.Reg, SQL(<T>EXEC spTCObtenerFormasPago :tEmpresa, :tModulo, :nID, :nSucursal, :nEstacion, :tAccion, :nRID, @EnSilencio = 0<T>, Empresa, <T>VTAS<T>, VentaCobro:VentaCobro.ID, Sucursal, EstacionTrabajo, <T>Auth<T>, 0))
VisibleCondicion=General.InterfazTC y(SQL(<T>SELECT dbo.fnTCVentaCobroActivarPinPad(:nID, :tFormaPago1, :tFormaPago2, :tFormaPago3, :tFormaPago4, :tFormaPago5, :nTCProcesado1, :nTCProcesado2, :nTCProcesado3, :nTCProcesado4, :nTCProcesado5)<T>, VentaCobro:VentaCobro.ID, VentaCobro:VentaCobro.FormaCobro1, VentaCobro:VentaCobro.FormaCobro2, VentaCobro:VentaCobro.FormaCobro3, VentaCobro:VentaCobro.FormaCobro4, VentaCobro:VentaCobro.FormaCobro5, VentaCobro:VentaCobro.TCProcesado1, VentaCobro:VentaCobro.TCProcesado2, VentaCobro:VentaCobro.TCProcesado3, VentaCobro:VentaCobro.TCProcesado4, VentaCobro:VentaCobro.TCProcesado5))

[Acciones.PinPad.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Anuncio, SQL(<T>SELECT TCAccion FROM MovTipo JOIN Venta ON MovTipo.Mov = Venta.Mov WHERE MovTipo.Modulo = :tModulo AND Venta.ID = :nID<T>, <T>VTAS<T>, VentaCobro:VentaCobro.ID))<BR><BR>Si Info.Anuncio = <T>Auth<T><BR>Entonces<BR>  Si Dialogo(<T>TCEstaSeguro<T>)<BR>  Entonces<BR>    Asigna(Info.Archivo, SQL(<T>EXEC spTCAfectarPinPad :tEmpresa, :tModulo, :nModuloID, :nSucursal, :tEstacion, :tAccion, :tUsuario, @Generar = 1<T>, Empresa, <T>VTAS<T>, VentaCobro:VentaCobro.ID, Sucursal, EstacionTrabajo, Info.Anuncio, Usuario))<BR>    Si Izquierda(Info.Archivo, 5) <> <T>Error<T><BR>    Entonces<BR>      Ejecutar(Info.Archivo, Verdadero)<BR>      ProcesarSQL(<T>EXEC spTCAfectarPinPad :tEmpresa, :tModulo, :nModuloID, :nSucursal, :tEstacion, :tAccion, :tUsuario<T>, Empresa, <T>VTAS<T>, VentaCobro:VentaCobro.ID, Sucursal, EstacionTrabajo, Info.Anuncio, Usuario)<BR>    Sino<BR>      Error(Info.Archivo)<BR>    Fin<BR>  Fin<BR>Sino<BR>  Forma(<T>TCDevolucion<T>)<BR>Fin

[Acciones.PinPad.Voucher]
Nombre=Voucher
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ActualizarForma<BR>ActualizarVista<BR>Asigna(Info.EventoID, SQL(<T>SELECT RID FROM TCEstacionTransaccion WHERE Empresa = :tEmpresa AND Sucursal = :nSucursal AND Estacion = :nEstacion<T>, Empresa, Sucursal, EstacionTrabajo))<BR><BR>Si ConDatos(Info.EventoID)<BR>Entonces<BR>  ReportePantalla(<T>TCVoucher<T>, Info.EventoID)<BR>Fin

[Acciones.AdministrarCobros]
Nombre=AdministrarCobros
Boton=43
NombreEnBoton=S
NombreDesplegar=Cobros
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
GuardarAntes=S
EspacioPrevio=S
Expresion=Forma(<T>TCVentaCobroAdministrar<T>)<BR>ActualizarVista<BR>ActualizarForma
VisibleCondicion=General.InterfazTC

[Cobros.Columnas]
0=92
1=107
2=93
3=97
4=153
5=124
6=-2

[Ficha.VentaCobro.TCDelEfectivo]
Carpeta=Ficha
Clave=VentaCobro.TCDelEfectivo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco

[Transacciones.Columnas]
Movimiento=77
FormaPago=96
NoTarjeta=83
BancoEmisor=80
Tarjetahabiente=138
FechaExpiracion=88
CodigoAutorizacion=102
FechaFin=116
Importe=70
Total=64

[Ficha.ListaEnCaptura]
(Inicio)=MovVenta
MovVenta=MovMoneda
MovMoneda=MovTipoCambio
MovTipoCambio=VentaCobro.Importe1
VentaCobro.Importe1=VentaCobro.FormaCobro1
VentaCobro.FormaCobro1=VentaCobro.Referencia1
VentaCobro.Referencia1=VentaCobro.Importe2
VentaCobro.Importe2=VentaCobro.FormaCobro2
VentaCobro.FormaCobro2=VentaCobro.Referencia2
VentaCobro.Referencia2=VentaCobro.Importe3
VentaCobro.Importe3=VentaCobro.FormaCobro3
VentaCobro.FormaCobro3=VentaCobro.Referencia3
VentaCobro.Referencia3=VentaCobro.Importe4
VentaCobro.Importe4=VentaCobro.FormaCobro4
VentaCobro.FormaCobro4=VentaCobro.Referencia4
VentaCobro.Referencia4=VentaCobro.Importe5
VentaCobro.Importe5=VentaCobro.FormaCobro5
VentaCobro.FormaCobro5=VentaCobro.Referencia5
VentaCobro.Referencia5=VentaCobro.DelEfectivo
VentaCobro.DelEfectivo=VentaCobro.CtaDinero
VentaCobro.CtaDinero=VentaCobro.Cajero
VentaCobro.Cajero=VentaCobro.TCDelEfectivo
VentaCobro.TCDelEfectivo=VentaCobro.Condicion
VentaCobro.Condicion=VentaCobro.Vencimiento
VentaCobro.Vencimiento=VentaCobro.FormaCobroCambio
VentaCobro.FormaCobroCambio=CambioTipoCambio
CambioTipoCambio=CambioPendienteMonEsp
CambioPendienteMonEsp=Total
Total=Pendiente
Pendiente=CambioPendiente
CambioPendiente=(Fin)

[Acciones.Afectar.LDITicket]
Nombre=LDITicket
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>  General.InterfazLDI<BR>Entonces<BR>  Asigna(Temp.Logico,SQL(<T>spLDITicket :nID, :nEstacion<T>,VentaCobro:VentaCobro.ID,EstacionTrabajo))<BR>  Si(Temp.Logico,ReportePantalla(<T>POSTicketLDI<T>))<BR>Fin

[Acciones.PinPad.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Voucher
Voucher=(Fin)

[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=LDITicket
LDITicket=(Fin)

[Lista.Columnas]
Sucursal=71
FormaPago=125
Cuenta=85



[Acciones.Separador]
Nombre=Separador
Boton=0
NombreDesplegar=Separador
Activo=S
Visible=S
BarraBtnAlto=35
BarraBtnFondo=Plata
EsSeparador=S
BarraBtnAncho=2
BarraBtnPagina=1

[Acciones.ExtraM1]
Nombre=ExtraM1
Boton=0
NombreDesplegar=Monedero 1
TipoAccion=Expresion
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
BarraBtnImgAncho=50
BarraBtnImgAlto=20
edBotonSrc=Monedero.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
Activo=S
GuardarAntes=S
RefrescarDespues=S
Expresion=Asigna(Info.MonederoCBSerie,nulo)<BR>Asigna(Info.MonederoRedimeImp,0.00)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro1,VentaCobro:VentaCobro.ID,Empresa))<BR>Asigna(Info.MonederoCBPosicion,1)<BR>Si<BR>  Info.MonederoCBFormaCobro = <T>SerieTarjetaMovRedimir2<T><BR>Entonces<BR>  FormaModal(<T>SerieTarjetaMovRedimir2<T>)<BR>  ActualizarVista<BR>Fin
VisibleCondicion=Asigna(Info.MonederoCBPosicion,0)<BR>Asigna(Info.MonederoCBFormaCobro,nulo)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro1,VentaCobro:VentaCobro.ID,Empresa))<BR>Si<BR>  ConDatos(Info.MonederoCBFormaCobro)<BR>Entonces<BR>  Asigna(Info.MonederoCBPosicion,1)<BR>  Asigna(Info.MonederoCBID,VentaCobro:VentaCobro.ID)<BR>Fin<BR>(Info.MonederoCBPosicion = 1) y (no VentaCobro:VentaCobro.TCProcesado1)

[Acciones.ExtraM2]
Nombre=ExtraM2
Boton=0
NombreDesplegar=Monedero 2
TipoAccion=Expresion
Activo=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
BarraBtnImgAncho=50
BarraBtnImgAlto=20
edBotonSrc=Monedero.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
GuardarAntes=S
RefrescarDespues=S
Expresion=Asigna(Info.MonederoCBSerie,nulo)<BR>Asigna(Info.MonederoRedimeImp,0.00)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro2,VentaCobro:VentaCobro.ID,Empresa))<BR>Asigna(Info.MonederoCBPosicion,2)<BR>Si<BR>  Info.MonederoCBFormaCobro = <T>SerieTarjetaMovRedimir2<T><BR>Entonces<BR>  FormaModal(<T>SerieTarjetaMovRedimir2<T>)<BR>  ActualizarVista<BR>Fin
VisibleCondicion=Asigna(Info.MonederoCBPosicion,0)<BR>Asigna(Info.MonederoCBFormaCobro,nulo)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro2,VentaCobro:VentaCobro.ID,Empresa))<BR>Si<BR>  ConDatos(Info.MonederoCBFormaCobro)<BR>Entonces<BR>  Asigna(Info.MonederoCBPosicion,2)<BR>Fin<BR>(Info.MonederoCBPosicion = 2) y (no VentaCobro:VentaCobro.TCProcesado2)

[Acciones.ExtraM3]
Nombre=ExtraM3
Boton=0
NombreDesplegar=Monedero 3
TipoAccion=Expresion
Activo=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
BarraBtnImgAncho=50
BarraBtnImgAlto=20
edBotonSrc=Monedero.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
GuardarAntes=S
RefrescarDespues=S
Expresion=Asigna(Info.MonederoCBSerie,nulo)<BR>Asigna(Info.MonederoRedimeImp,0.00)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro3,VentaCobro:VentaCobro.ID,Empresa))<BR>Asigna(Info.MonederoCBPosicion,3)<BR>Si<BR>  Info.MonederoCBFormaCobro = <T>SerieTarjetaMovRedimir2<T><BR>Entonces<BR>  FormaModal(<T>SerieTarjetaMovRedimir2<T>)<BR>  ActualizarVista<BR>Fin
VisibleCondicion=Asigna(Info.MonederoCBPosicion,0)<BR>Asigna(Info.MonederoCBFormaCobro,nulo)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro3,VentaCobro:VentaCobro.ID,Empresa))<BR>Si<BR>  ConDatos(Info.MonederoCBFormaCobro)<BR>Entonces<BR>  Asigna(Info.MonederoCBPosicion,3)<BR>Fin<BR>(Info.MonederoCBPosicion = 3) y (no VentaCobro:VentaCobro.TCProcesado3)

[Acciones.ExtraM4]
Nombre=ExtraM4
Boton=0
NombreDesplegar=Monedero 4
TipoAccion=Expresion
Activo=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
BarraBtnImgAncho=50
BarraBtnImgAlto=20
edBotonSrc=Monedero.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
GuardarAntes=S
RefrescarDespues=S
Expresion=Asigna(Info.MonederoCBSerie,nulo)<BR>Asigna(Info.MonederoRedimeImp,0.00)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro4,VentaCobro:VentaCobro.ID,Empresa))<BR>Asigna(Info.MonederoCBPosicion,4)<BR>Si<BR>  Info.MonederoCBFormaCobro = <T>SerieTarjetaMovRedimir2<T><BR>Entonces<BR>  FormaModal(<T>SerieTarjetaMovRedimir2<T>)<BR>  ActualizarVista<BR>Fin
VisibleCondicion=Asigna(Info.MonederoCBPosicion,0)<BR>Asigna(Info.MonederoCBFormaCobro,nulo)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro4,VentaCobro:VentaCobro.ID,Empresa))<BR>Si<BR>  ConDatos(Info.MonederoCBFormaCobro)<BR>Entonces<BR>  Asigna(Info.MonederoCBPosicion,4)<BR>Fin<BR>(Info.MonederoCBPosicion = 4) y (no VentaCobro:VentaCobro.TCProcesado4)

[Acciones.ExtraM5]
Nombre=ExtraM5
Boton=0
NombreDesplegar=Monedero 5
TipoAccion=Expresion
Activo=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
BarraBtnImgAncho=50
BarraBtnImgAlto=20
edBotonSrc=Monedero.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
GuardarAntes=S
RefrescarDespues=S
Expresion=Asigna(Info.MonederoCBSerie,nulo)<BR>Asigna(Info.MonederoRedimeImp,0.00)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro5,VentaCobro:VentaCobro.ID,Empresa))<BR>Asigna(Info.MonederoCBPosicion,5)<BR>Informacion(Info.MonederoCBFormaCobro)<BR>Si<BR>  Info.MonederoCBFormaCobro = <T>SerieTarjetaMovRedimir2<T><BR>Entonces<BR>  FormaModal(<T>SerieTarjetaMovRedimir2<T>)<BR>  ActualizarVista<BR>Fin
VisibleCondicion=Asigna(Info.MonederoCBPosicion,0)<BR>Asigna(Info.MonederoCBFormaCobro,nulo)<BR>Asigna(Info.MonederoCBFormaCobro,SQL(<T>EXEC spMonederoFormaAnexa :tFormaCobro , :nID, :tEmpresa<T>, VentaCobro:VentaCobro.FormaCobro5,VentaCobro:VentaCobro.ID,Empresa))<BR>Si<BR>  ConDatos(Info.MonederoCBFormaCobro)<BR>Entonces<BR>  Asigna(Info.MonederoCBPosicion,5)<BR>Fin<BR>(Info.MonederoCBPosicion = 5) y (no VentaCobro:VentaCobro.TCProcesado5)

[Ficha.ListaAccionesBB]
(Inicio)=Separador
Separador=ExtraM1
ExtraM1=ExtraM2
ExtraM2=ExtraM3
ExtraM3=ExtraM4
ExtraM4=ExtraM5
ExtraM5=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Afectar
Afectar=Cancelar
Cancelar=Cerrar
Cerrar=Vales
Vales=Tarjetas
Tarjetas=MonInfo
MonInfo=Actualizar
Actualizar=PinPad
PinPad=AdministrarCobros
AdministrarCobros=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=(Fin)