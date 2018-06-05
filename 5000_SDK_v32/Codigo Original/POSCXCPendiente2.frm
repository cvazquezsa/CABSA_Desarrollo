
[Forma]
Clave=POSCxcPendiente2
Icono=0
CarpetaPrincipal=POSCxcAnticipoTemp
Modulos=(Todos)
Nombre=<T>Pendientes por Cobrar<T>
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSCxcAnticipoTemp
PosicionInicialIzquierda=354
PosicionInicialArriba=192
PosicionInicialAlturaCliente=305
PosicionInicialAncho=657
Comentarios=Lista(Info.Cliente,Info.Nombre)
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Info.Nombre,SQL(<T>SELECT Nombre FROM Cte WHERE Cliente = :tCliente<T>,Info.Cliente))
[POSCxcAnticipoTemp]
Estilo=Iconos
Clave=POSCxcAnticipoTemp
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCxcAnticipoTemp
Fuente={Tahoma, 8, Negro, []}
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
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200






PestanaOtroNombre=S
PestanaNombre=Pendientes Por Cobrar
MenuLocal=S
ListaAcciones=Seleccionar
BusquedaRapidaControles=S
IconosNombre=POSCxcAnticipoTemp:POSCxcAnticipoTemp.Mov+<T> <T>+POSCxcAnticipoTemp:POSCxcAnticipoTemp.MovID
FiltroGeneral=POSCxcAnticipoTemp.Estacion = {EstacionTrabajo}
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=POSCxcAnticipoTemp.FechaEmision
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha


[POSCxcAnticipoTemp.Columnas]
FechaEmision=94
Referencia=173
Concepto=210
AnticipoSaldo=71
Moneda=64
AnticipoAplicar=77


0=209
1=-2
2=140
3=116
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S









































ConfirmarAntes=S
DialogoMensaje=POSCancelarCxcPendiemte
Multiple=S
ListaAccionesMultiples=(Lista)
[POSCxcAnticipoTemp.POSCxcAnticipoTemp.ImporteTotal]
Carpeta=POSCxcAnticipoTemp
Clave=POSCxcAnticipoTemp.ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[POSCxcAnticipoTemp.POSCxcAnticipoTemp.SaldoTotal]
Carpeta=POSCxcAnticipoTemp
Clave=POSCxcAnticipoTemp.SaldoTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Totalizador=1
[POSCxcAnticipoTemp.POSCxcAnticipoTemp.Vencimiento]
Carpeta=POSCxcAnticipoTemp
Clave=POSCxcAnticipoTemp.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









[Acciones.Aceptar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



ConCondicion=S
Expresion=EjecutarSQL(<T>spPOSInsertarReferenciaDevolucion :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :nID, :tIDPOS<T>,Empresa, Sucursal, Usuario, EstacionTrabajo,POSCxcAnticipoTemp:POSCxcAnticipoTemp.ID, Info.IDTexto)<BR>Asigna(Info.Codigo,NULO)
EjecucionCondicion=ConDatos(POSCxcAnticipoTemp:POSCxcAnticipoTemp.Mov) y ConDatos(POSCxcAnticipoTemp:POSCxcAnticipoTemp.MovID)
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Acciones.Seleccionar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSInsertarReferenciaDevolucion :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :nID, :tIDPOS<T>,Empresa, Sucursal, Usuario, EstacionTrabajo,POSCxcAnticipoTemp:POSCxcAnticipoTemp.ID, Info.IDTexto)<BR>Asigna(Info.Codigo,NULO)
[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=0
NombreDesplegar=Seleccionar
Multiple=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S







[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Codigo,SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>,<T>ELIMINAR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
Activo=S
Visible=S

[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar
Cancelar=Expresion
Expresion=(Fin)











[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Seleccionar
Seleccionar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Seleccionar
Seleccionar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[POSCxcAnticipoTemp.ListaEnCaptura]
(Inicio)=POSCxcAnticipoTemp.ImporteTotal
POSCxcAnticipoTemp.ImporteTotal=POSCxcAnticipoTemp.SaldoTotal
POSCxcAnticipoTemp.SaldoTotal=POSCxcAnticipoTemp.Vencimiento
POSCxcAnticipoTemp.Vencimiento=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
