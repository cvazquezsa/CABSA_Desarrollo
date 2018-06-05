[Forma]
Clave=ExplorarCambioDinero
Nombre=<T>Explorando - Tesorería - Saldos<T>
Icono=47
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=249
PosicionInicialArriba=307
PosicionInicialAltura=409
PosicionInicialAncho=781
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=382

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Cuenta(s)
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaDineroConSaldo
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cuenta<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroAutoCampo=(Validaciones Memoria)
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
MenuLocal=S
ListaAcciones=LocalInformacion
FiltroAutoValidar=Mon
FiltroAplicaEn=CtaDineroConSaldo.CuentaMoneda
FiltroGrupo1=(Validaciones Memoria)
FiltroTodo=S
FiltroTodoFinal=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroEmpresas=S
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaAncho=20
BusquedaInicializar=S
BusquedaRespetarControles=S
FiltroMonedasCampo=CtaDineroConSaldo.Moneda
OtroOrden=S
ListaOrden=CtaDineroConSaldo.Saldo<TAB>(Decendente)
FiltroValida1=Mon
FiltroAplicaEn1=CtaDineroConSaldo.CuentaMoneda
IconosNombre=CtaDineroConSaldo:CtaDineroConSaldo.CtaDinero

[Lista.Columnas]
0=80
1=154

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

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreEnBoton=S
NombreDesplegar=&Cuenta
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CtaDineroInfo
Activo=S
Antes=S
Visible=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EnMenu=S
ConCondicion=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(CtaDineroConSaldo:CtaDineroConSaldo.CtaDinero)
AntesExpresiones=Asigna(Info.CtaDinero, CtaDineroConSaldo:CtaDineroConSaldo.CtaDinero)

[Acciones.LocalInformacion]
Nombre=LocalInformacion
Boton=0
NombreDesplegar=&Información de la Cuenta
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaDineroInfo
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CtaDineroConSaldo:CtaDineroConSaldo.CtaDinero)
AntesExpresiones=Asigna(Info.CtaDinero, CtaDineroConSaldo:CtaDineroConSaldo.CtaDinero)

[Lista.SaldoConciliado]
Carpeta=Lista
Clave=SaldoConciliado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
EnBarraHerramientas=S

[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Lista.CtaDineroConSaldo.Saldo]
Carpeta=Lista
Clave=CtaDineroConSaldo.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroConSaldo.PorConciliar]
Carpeta=Lista
Clave=CtaDineroConSaldo.PorConciliar
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroConSaldo.Descripcion]
Carpeta=Lista
Clave=CtaDineroConSaldo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=CtaDineroConSaldo.Descripcion
CtaDineroConSaldo.Descripcion=CtaDineroConSaldo.Saldo
CtaDineroConSaldo.Saldo=SaldoConciliado
SaldoConciliado=CtaDineroConSaldo.PorConciliar
CtaDineroConSaldo.PorConciliar=(Fin)









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Informacion
Informacion=Mostrar Campos
Mostrar Campos=(Fin)
