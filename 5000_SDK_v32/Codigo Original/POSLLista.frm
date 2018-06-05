[Forma]
Clave=POSLLista
Icono=0
Modulos=(Todos)
Nombre=Lista de Movimientos
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Campos
CarpetaPrincipal=Campos
PosicionInicialIzquierda=165
PosicionInicialArriba=15
PosicionInicialAlturaCliente=670
PosicionInicialAncho=1036
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Campos]
Estilo=Iconos
Clave=Campos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSL
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S



BusquedaRapidaControles=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroFechas=S
FiltroFechasCampo=POSL.FechaEmision
BusquedaRapida=S
BusquedaEnLinea=S
MenuLocal=S
ListaAcciones=ImprimirTicket
OtroOrden=S
ListaOrden=(Lista)
FiltroUsuarios=S
FiltroFechasDefault=Hoy
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
IconosSubTitulo=<T>Movimiento<T>
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=POSL:POSL.Mov+<T> <T>+POSL:POSL.MovID
FiltroGeneral=MovTipo.Modulo = <T>POS<T> AND POSL.Estatus <> <T>SINAFECTAR<T>
[Campos.POSL.FechaEmision]
Carpeta=Campos
Clave=POSL.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.POSL.Cliente]
Carpeta=Campos
Clave=POSL.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Campos.POSL.Importe]
Carpeta=Campos
Clave=POSL.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Campos.POSL.Impuestos]
Carpeta=Campos
Clave=POSL.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Campos.Columnas]
Mov=124
MovID=124
FechaEmision=94
Cliente=64
Importe=64
Impuestos=64



0=166
1=105
2=92
3=201
4=77



5=85
6=81
7=94
8=79
9=-2
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





[Campos.Cte.Nombre]
Carpeta=Campos
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Acciones.ImprimirTicket]
Nombre=ImprimirTicket
Boton=0
NombreDesplegar=Preliminar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S










Antes=S
Expresion=Asigna(Info.Reporte, SQL(<T>SELECT TOP 1 ecmi.ReporteImpresora<BR>      FROM EmpresaCfgMovImp ecmi<BR>     WHERE Modulo = :tModulo<BR>       AND Mov = :tMov<BR>       AND Empresa = :tEmpresa<T>, <T>POS<T>, POSL:POSL.Mov, Empresa))<BR>Si<BR> Vacio(Info.Reporte)<BR>Entonces<BR>  Asigna(Info.Reporte,<T>POSTicket<T>)<BR>  EjecutarSQL(<T>spPOSGeneraTicket :nEstacion, :tEmpresa, :nSucursal, :tUsuario, :tID<T>,EstacionTrabajo,Empresa,Sucursal,Usuario,POSL:POSL.ID)<BR>Fin<BR><BR>ReportePantallaModal(Info.Reporte)
AntesExpresiones=Asigna(Info.IDTextoAnterior, POSL:POSL.ID)
[Campos.ImporteTotal]
Carpeta=Campos
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Acciones.Excel]
Nombre=Excel
Boton=67
NombreEnBoton=S
NombreDesplegar=&Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S









Visible=S
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S




































[Campos.Descuento.Porcentaje]
Carpeta=Campos
Clave=Descuento.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
















[Campos.DescuentoImporte]
Carpeta=Campos
Clave=DescuentoImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1










[Campos.POSL.Caja]
Carpeta=Campos
Clave=POSL.Caja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


























[Acciones.FacturarNotas]
Nombre=FacturarNotas
Boton=7
NombreEnBoton=S
NombreDesplegar=&Facturar Notas
GuardarAntes=S
EspacioPrevio=S
TipoAccion=Expresion
Antes=S
DespuesGuardar=S
Visible=S





















































































































ConCondicion=S


Expresion=FormaModal(<T>POSFacturarNotasTemp<T>)<BR>ActualizarForma
ActivoCondicion=(MovTipoEn(<T>POS<T>,POSL:POSL.Mov,(POS.N)))y (no(POSL:POSL.Facturado))  y(POSL:POSL.Importe>=0.0)
EjecucionCondicion=(MovTipoEn(<T>POS<T>,POSL:POSL.Mov,(POS.N)))y (no(POSL:POSL.Facturado))  y(POSL:POSL.Importe>=0.0)
AntesExpresiones=Asigna(Info.IDTextoAnterior, POSL:POSL.ID)
[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107



















[Acciones.Actualizar Forma]
Nombre=Actualizar Forma
Boton=82
NombreEnBoton=S
NombreDesplegar=&Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S






















[Acciones.POSCFDFlexPendiente]
Nombre=POSCFDFlexPendiente
Boton=126
NombreEnBoton=S
NombreDesplegar=Monitor CFD Pendiente
TipoAccion=Formas
ClaveAccion=POSCFDFlexPendiente
Activo=S
Visible=S



EspacioPrevio=S



































































































[Campos.ListaEnCaptura]
(Inicio)=POSL.FechaEmision
POSL.FechaEmision=POSL.Cliente
POSL.Cliente=Cte.Nombre
Cte.Nombre=POSL.Caja
POSL.Caja=Descuento.Porcentaje
Descuento.Porcentaje=DescuentoImporte
DescuentoImporte=POSL.Importe
POSL.Importe=POSL.Impuestos
POSL.Impuestos=ImporteTotal
ImporteTotal=(Fin)

[Campos.ListaOrden]
(Inicio)=POSL.FechaRegistro	(Acendente)
POSL.FechaRegistro	(Acendente)=POSL.Caja	(Acendente)
POSL.Caja	(Acendente)=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Excel
Excel=FacturarNotas
FacturarNotas=Actualizar Forma
Actualizar Forma=POSCFDFlexPendiente
POSCFDFlexPendiente=(Fin)
