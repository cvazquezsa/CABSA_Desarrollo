[Forma]
Clave=CompraVerAnticipo
Nombre=e(<T>Anticipos<T>)+<T> - <T>+Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Anticipos
PosicionInicialIzquierda=390
PosicionInicialArriba=356
PosicionInicialAltura=305
PosicionInicialAncho=499
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Cuenta, Info.Moneda)
ListaAcciones=Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaExclusiva=S
PosicionInicialAlturaCliente=278

[Anticipos]
Estilo=Iconos
Clave=Anticipos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Anticipo
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Realizados
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroAplicaEn=Anticipo.Moneda
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
IconosNombre=Anticipo:Anticipo.Mov+<T> <T>+Anticipo:Anticipo.MovID
FiltroGeneral=Anticipo.Empresa=<T>{Empresa}<T> AND<BR>Anticipo.Moneda=<T>{Info.Moneda}<T> AND<BR>Anticipo.Cuenta=<T>{Info.Cuenta}<T> AND<BR>(Anticipo.Referencia = <T>{Info.Mov+<T> <T>+Info.MovID}<T> OR Anticipo.Referencia LIKE <T>{Info.Mov+<T> <T>+Info.MovID}-%<T>) AND<BR>Anticipo.Abono IS NOT NULL AND Anticipo.Cancelado=0

[Anticipos.Anticipo.Abono]
Carpeta=Anticipos
Clave=Anticipo.Abono
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Anticipos.Anticipo.Fecha]
Carpeta=Anticipos
Clave=Anticipo.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Anticipos.Columnas]
0=111
1=118

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

[Anticipos.Anticipo.Referencia]
Carpeta=Anticipos
Clave=Anticipo.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Pendiente]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
Clave=Pendiente
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnticipoPendiente
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Referencia<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroAplicaEn=AnticipoPendiente.Moneda
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
MenuLocal=S
ListaAcciones=Pagar
IconosNombre=AnticipoPendiente:AnticipoPendiente.Referencia
FiltroGeneral=AnticipoPendiente.Empresa=<T>{Empresa}<T> AND<BR>AnticipoPendiente.Moneda=<T>{Info.Moneda}<T> AND<BR>AnticipoPendiente.Cuenta=<T>{Info.Cuenta}<T> AND<BR>(AnticipoPendiente.Referencia = <T>{Info.Mov+<T> <T>+Info.MovID}<T> OR AnticipoPendiente.Referencia LIKE <T>{Info.Mov+<T> <T>+Info.MovID}-%<T>)
CondicionVisible=SQL(<T>SELECT ControlAnticipos FROM Condicion c, Compra v WHERE v.Condicion=c.Condicion AND v.ID=:nID<T>, Info.ID) en (<T>Abierto<T>, <T>Plazos<T>, <T>Fecha Requerida<T>)

[Pendiente.AnticipoPendiente.Saldo]
Carpeta=Pendiente
Clave=AnticipoPendiente.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Pendiente.AnticipoPendiente.Fecha]
Carpeta=Pendiente
Clave=AnticipoPendiente.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Pendiente.Columnas]
0=131
1=112

[Acciones.Pagar]
Nombre=Pagar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=Generar Anticipo
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Usuario.CxpMovExpress
EjecucionCondicion=ConDatos(AnticipoPendiente:AnticipoPendiente.Referencia)
AntesExpresiones=Asigna(Def.Proveedor, Info.Cuenta)<BR>Asigna(Def.Mov, Si(Config.CompraAnticipoCredito, ConfigMov.CxpAnticipoFactura, ConfigMov.CxpAnticipoSaldo))<BR>Asigna(Def.Referencia, AnticipoPendiente:AnticipoPendiente.Referencia)<BR>Asigna(Def.Importe, AnticipoPendiente:AnticipoPendiente.Saldo/(1+(Info.PorcentajeImpuesto/100)))<BR>Asigna(Def.Impuestos, AnticipoPendiente:AnticipoPendiente.Saldo - Def.Importe)<BR>Asigna(Def.Concepto, Info.Concepto)<BR>Asigna(Def.Proyecto, Info.Proyecto)<BR>Asigna(Def.Moneda, Info.Moneda)<BR>Forma(<T>CxpExpress<T>)

[Forma.ListaCarpetas]
(Inicio)=Pendiente
Pendiente=Anticipos
Anticipos=(Fin)

[Anticipos.ListaEnCaptura]
(Inicio)=Anticipo.Referencia
Anticipo.Referencia=Anticipo.Abono
Anticipo.Abono=Anticipo.Fecha
Anticipo.Fecha=(Fin)

[Pendiente.ListaEnCaptura]
(Inicio)=AnticipoPendiente.Saldo
AnticipoPendiente.Saldo=AnticipoPendiente.Fecha
AnticipoPendiente.Fecha=(Fin)
