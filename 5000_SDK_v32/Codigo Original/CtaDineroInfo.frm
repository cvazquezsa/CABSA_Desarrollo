[Forma]
Clave=CtaDineroInfo
Nombre=<T>Información de la Cuenta<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Datos
PosicionInicialIzquierda=324
PosicionInicialArriba=308
PosicionInicialAltura=363
PosicionInicialAncho=631
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.CtaDinero
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionColumna1=42
PosicionSeccion1=50
Menus=S
VentanaBloquearAjuste=N
VentanaExclusiva=S
VentanaEscCerrar=S
ExpresionesAlMostrar=Asigna(Info.Rama, <T>DIN<T>)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=380
MenuPrincipal=(Lista)

[Saldo]
Estilo=Iconos
Clave=Saldo
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=CtaDineroConSaldo
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Saldo
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Moneda
ElementosPorPagina=200
IconosNombre=CtaDineroConSaldo:CtaDineroConSaldo.Moneda
FiltroGeneral=CtaDineroConSaldo.Empresa = <T>{Empresa}<T> AND<BR>CtaDineroConSaldo.CtaDinero = <T>{Info.CtaDinero}<T>

[Saldo.Columnas]
Saldo=143
Moneda=92
0=87
1=113

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
Menu=&Ver

[Datos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Datos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaDinero
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
FiltroGeneral=CtaDinero.CtaDinero=<T>{Info.CtaDinero}<T>

[Notas.CtaDinero.Notas]
Carpeta=Notas
Clave=CtaDinero.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40x9
ColorFondo=Plata

[Notas.CtaDinero.Mensaje]
Carpeta=Notas
Clave=CtaDinero.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata

[ChequePendiente.Columnas]
0=71
1=127

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
Vista=DineroPendiente
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=Movimiento
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
MenuLocal=S
ListaAcciones=MovPropiedadesPendiente
IconosNombre=DineroPendiente:DineroPendiente.Mov+<T> <T>+DineroPendiente:DineroPendiente.MovID
FiltroGeneral=DineroPendiente.Empresa = <T>{Empresa}<T> AND<BR>DineroPendiente.CtaDinero = <T>{Info.CtaDinero}<T>
CondicionVisible=CtaDinero:CtaDinero.Tipo <> <T>Caja<T>

[Pendiente.DineroPendiente.Importe]
Carpeta=Pendiente
Clave=DineroPendiente.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Pendiente.Columnas]
0=148
1=139

[Pendiente.DineroPendiente.Saldo]
Carpeta=Pendiente
Clave=DineroPendiente.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Pendiente.DineroPendiente.FechaProgramada]
Carpeta=Pendiente
Clave=DineroPendiente.FechaProgramada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades de la Cuenta
TipoAccion=Formas
ClaveAccion=PropInfo
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
Menu=&Ver
EnMenu=S
EnBarraHerramientas=S
UsaTeclaRapida=S
TeclaRapida=F11
AntesExpresiones=Asigna(Info.Rama, <T>DIN<T>)<BR>Asigna(Info.Cuenta, Info.CtaDinero)<BR>Asigna(Info.Descripcion, Info.CtaDinero)

[Acciones.Explorar]
Nombre=Explorar
Boton=66
Menu=&Explorar
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=&Movimientos
EnBarraHerramientas=
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=IrModulo(<T>DIN<T>)<BR>IrDireccion(<T>DIN<T>, Info.CtaDinero)

[Acciones.Salir]
Nombre=Salir
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Saldo.SaldoConciliado]
Carpeta=Saldo
Clave=SaldoConciliado
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[PorConciliar]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Movimientos por conciliar
Clave=PorConciliar
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Auxiliar
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
MenuLocal=S
ListaAcciones=MovPropiedadesPorConciliar
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Auxiliar.Fecha
FiltroFechasDefault=Mes Móvil
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroAplicaEn=Auxiliar.Moneda
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroMonedasCampo=Auxiliar.Moneda
IconosNombre=Auxiliar:Auxiliar.Mov+<T> <T>+Auxiliar:Auxiliar.MovID
FiltroGeneral=Auxiliar.Empresa=<T>{Empresa}<T> AND<BR>Auxiliar.Rama=<T>{Info.Rama}<T> AND<BR>Auxiliar.Cuenta {Si(CtaDinero:CtaDinero.Conciliar, <T>=<T>+Comillas(Info.CtaDinero), <T>IS NULL<T>)} AND<BR>Auxiliar.Conciliado = 0
CondicionVisible=CtaDinero:CtaDinero.Conciliar

[PorConciliar.Columnas]
0=114
1=83

[PorConciliar.Auxiliar.Cargo]
Carpeta=PorConciliar
Clave=Auxiliar.Cargo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[PorConciliar.Auxiliar.Abono]
Carpeta=PorConciliar
Clave=Auxiliar.Abono
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[PorConciliar.Auxiliar.EsCancelacion]
Carpeta=PorConciliar
Clave=Auxiliar.EsCancelacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Datos.CtaDinero.NumeroCta]
Carpeta=Datos
Clave=CtaDinero.NumeroCta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Datos.CtaDinero.Moneda]
Carpeta=Datos
Clave=CtaDinero.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Plata
ColorFuente=Negro

[Datos.CtaDinero.CuentaHabiente]
Carpeta=Datos
Clave=CtaDinero.CuentaHabiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[PorConciliar.Auxiliar.Fecha]
Carpeta=PorConciliar
Clave=Auxiliar.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.MovPropiedadesPorConciliar]
Nombre=MovPropiedadesPorConciliar
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, Auxiliar:Auxiliar.Modulo)<BR>Asigna(Info.ID, Auxiliar:Auxiliar.ModuloID)

[Acciones.MovPropiedadesPendiente]
Nombre=MovPropiedadesPendiente
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, DineroPendiente:DineroPendiente.ID)
Visible=S

[Acciones.RepConciliar]
Nombre=RepConciliar
Boton=68
Menu=&Ver
NombreDesplegar=Movimientos por &Conciliar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=CtaDineroConciliar
Activo=S
Antes=S
EspacioPrevio=S
AntesExpresiones=Asigna(info.Rama, <T>DIN<T>)<BR>Asigna(Info.CtaDineroD, Info.CtaDinero)<BR>Asigna(Info.CtaDineroA, Info.CtaDinero)
VisibleCondicion=CtaDinero:CtaDinero.Conciliar

[Datos.CtaDinero.Descripcion]
Carpeta=Datos
Clave=CtaDinero.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Acciones.ConciliarGrupo]
Nombre=ConciliarGrupo
Boton=0
Menu=&Ver
NombreDesplegar=Movimientos por Conciliar (En &Grupos)
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=CtaDineroConciliarGrupo
Activo=S
Antes=S
AntesExpresiones=Asigna(info.Rama, <T>DIN<T>)<BR>Asigna(Info.CtaDineroD, Info.CtaDinero)<BR>Asigna(Info.CtaDineroA, Info.CtaDinero)
VisibleCondicion=CtaDinero:CtaDinero.Conciliar

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>DIN<T>)<BR>Asigna(Info.Cuenta, Info.CtaDinero)<BR>Asigna(Info.Descripcion,Info.CtaDinero)
RefrescarDespues=S

[Posfechados]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Posfechados
Clave=Posfechados
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DineroPosfechado
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=DineroPosfechado.Dias<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Mon
FiltroAplicaEn1=DineroPosfechado.Moneda
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroAplicaEn=DineroPosfechado.Moneda
IconosNombre=DineroPosfechado:DineroPosfechado.Mov+<T> <T>+DineroPosfechado:DineroPosfechado.MovID
FiltroGeneral=DineroPosfechado.Empresa=<T>{Empresa}<T> AND DineroPosfechado.CtaDinero=<T>{Info.CtaDinero}<T>

[Posfechados.DineroPosfechado.FechaProgramada]
Carpeta=Posfechados
Clave=DineroPosfechado.FechaProgramada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Posfechados.DineroPosfechado.Referencia]
Carpeta=Posfechados
Clave=DineroPosfechado.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Posfechados.DineroPosfechado.BeneficiarioNombre]
Carpeta=Posfechados
Clave=DineroPosfechado.BeneficiarioNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Posfechados.DineroPosfechado.Cargo]
Carpeta=Posfechados
Clave=DineroPosfechado.Cargo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Posfechados.DineroPosfechado.Abono]
Carpeta=Posfechados
Clave=DineroPosfechado.Abono
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Posfechados.Columnas]
0=97
1=102

[Acciones.Doc]
Nombre=Doc
Boton=17
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Menu=&Ver
Expresion=VerDocumentacion(<T>DIN<T>, CtaDinero:CtaDinero.CtaDinero, <T>Documentación - <T>+CtaDinero:CtaDinero.Descripcion)
EjecucionCondicion=ConDatos(CtaDinero:CtaDinero.CtaDinero)

[Datos.CtaDinero.BancoSucursal]
Carpeta=Datos
Clave=CtaDinero.BancoSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Saldo.CtaDineroConSaldo.Saldo]
Carpeta=Saldo
Clave=CtaDineroConSaldo.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Saldo.CtaDineroConSaldo.PorConciliar]
Carpeta=Saldo
Clave=CtaDineroConSaldo.PorConciliar
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Cajeros]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cajero Actual
Clave=Cajeros
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaDineroCajero
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cajero<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Agente.Nombre
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=CtaDineroCajero:CtaDineroCajero.Cajero
FiltroGeneral=CtaDineroCajero.CtaDinero=<T>{Info.CtaDinero}<T> AND CtaDineroCajero.Moneda=<T><T>
CondicionVisible=(CtaDinero:CtaDinero.Tipo=<T>Caja<T>) y Config.Cajeros

[Cajeros.Columnas]
0=89
1=338

[Cajeros.Agente.Nombre]
Carpeta=Cajeros
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[PorConciliar.Auxiliar.Moneda]
Carpeta=PorConciliar
Clave=Auxiliar.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Saldo
Saldo=Cajeros
Cajeros=Datos
Datos=PorConciliar
PorConciliar=Pendiente
Pendiente=Posfechados
Posfechados=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Propiedades
Propiedades=Anexos
Anexos=Doc
Doc=RepConciliar
RepConciliar=ConciliarGrupo
ConciliarGrupo=Explorar
Explorar=Salir
Salir=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Ver
&Ver=&Explorar
&Explorar=(Fin)

[Saldo.ListaEnCaptura]
(Inicio)=CtaDineroConSaldo.Saldo
CtaDineroConSaldo.Saldo=SaldoConciliado
SaldoConciliado=CtaDineroConSaldo.PorConciliar
CtaDineroConSaldo.PorConciliar=(Fin)

[Datos.ListaEnCaptura]
(Inicio)=CtaDinero.Descripcion
CtaDinero.Descripcion=CtaDinero.NumeroCta
CtaDinero.NumeroCta=CtaDinero.Moneda
CtaDinero.Moneda=CtaDinero.BancoSucursal
CtaDinero.BancoSucursal=CtaDinero.CuentaHabiente
CtaDinero.CuentaHabiente=(Fin)

[Pendiente.ListaEnCaptura]
(Inicio)=DineroPendiente.Importe
DineroPendiente.Importe=DineroPendiente.Saldo
DineroPendiente.Saldo=DineroPendiente.FechaProgramada
DineroPendiente.FechaProgramada=(Fin)

[PorConciliar.ListaEnCaptura]
(Inicio)=Auxiliar.Fecha
Auxiliar.Fecha=Auxiliar.Cargo
Auxiliar.Cargo=Auxiliar.Abono
Auxiliar.Abono=Auxiliar.EsCancelacion
Auxiliar.EsCancelacion=Auxiliar.Moneda
Auxiliar.Moneda=(Fin)

[PorConciliar.ListaOrden]
(Inicio)=Auxiliar.Fecha<TAB>(Acendente)
Auxiliar.Fecha<TAB>(Acendente)=Auxiliar.ModuloID<TAB>(Acendente)
Auxiliar.ModuloID<TAB>(Acendente)=(Fin)

[Posfechados.ListaEnCaptura]
(Inicio)=DineroPosfechado.FechaProgramada
DineroPosfechado.FechaProgramada=DineroPosfechado.Referencia
DineroPosfechado.Referencia=DineroPosfechado.BeneficiarioNombre
DineroPosfechado.BeneficiarioNombre=DineroPosfechado.Cargo
DineroPosfechado.Cargo=DineroPosfechado.Abono
DineroPosfechado.Abono=(Fin)
