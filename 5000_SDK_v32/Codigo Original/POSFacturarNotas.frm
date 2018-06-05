
[Forma]
Clave=POSFacturarNotas
Icono=0
Modulos=(Todos)

ListaCarpetas=POSL
CarpetaPrincipal=POSL
PosicionInicialIzquierda=550
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Nombre=Factura
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[POSL]
Estilo=Ficha
Clave=POSL
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSL
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
ListaEnCaptura=(Lista)



Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=POSL.ID = <T>{Temp.Reg5[3]}<T>
[POSL.Cte.Cliente]
Carpeta=POSL
Clave=Cte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[POSL.Cte.Nombre]
Carpeta=POSL
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata

[POSL.ImporteTotal]
Carpeta=POSL
Clave=ImporteTotal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco


[POSL.ConsecutivoMov]
Carpeta=POSL
Clave=ConsecutivoMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Tamano=51





[POSL.POSL.FechaEmision]
Carpeta=POSL
Clave=POSL.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[POSL.ListaEnCaptura]
(Inicio)=ConsecutivoMov
ConsecutivoMov=Cte.Cliente
Cte.Cliente=Cte.Nombre
Cte.Nombre=POSL.FechaEmision
POSL.FechaEmision=ImporteTotal
ImporteTotal=(Fin)

[Acciones.Preliminar]
Nombre=Preliminar
Boton=20
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



NombreEnBoton=S







EspacioPrevio=S
Expresion=Asigna(Info.Reporte, SQL(<T>SELECT TOP 1 ecmi.ReporteImpresora<BR>      FROM EmpresaCfgMovImp ecmi<BR>     WHERE Modulo = :tModulo<BR>       AND Mov = :tMov<BR>       AND Empresa = :tEmpresa<T>, <T>POS<T>, POSL:POSL.Mov, Empresa))<BR>Si<BR> Vacio(Info.Reporte)<BR>Entonces<BR>  Asigna(Info.Reporte,<T>POSTicket<T>)<BR>  EjecutarSQL(<T>spPOSGeneraTicket :nEstacion, :tEmpresa, :nSucursal, :tUsuario, :tID<T>,EstacionTrabajo,Empresa,Sucursal,Usuario,POSL:POSL.ID)<BR>Fin<BR><BR>ReportePantalla(Info.Reporte)
[Acciones.Anexos]
Nombre=Anexos
Boton=77
NombreDesplegar=&Anexos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Activo=S
Antes=S
Visible=S













EspacioPrevio=S
AntesExpresiones=Asigna(Info.Rama, <T>VTAS<T>)<BR>Asigna(Info.Fecha, POSL:POSL.FechaEmision)<BR>Asigna(Info.ID, Temp.Reg5[4])<BR>//Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Venta:Venta.Estatus noen (EstatusCancelado, EstatusConcluido))))
RefrescarDespues=S






























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Preliminar
Preliminar=Anexos
Anexos=(Fin)
