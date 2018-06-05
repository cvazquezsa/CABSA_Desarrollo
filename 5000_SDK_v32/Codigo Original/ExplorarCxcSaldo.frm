[Forma]
Clave=ExplorarCxcSaldo
Nombre=<T>Explorando - Cuentas por Cobrar (Saldos)<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=332
PosicionInicialArriba=100
PosicionInicialAltura=515
PosicionInicialAncho=701
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=488

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcConSaldo
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroListas=S
FiltroListasRama=CXC
FiltroListasAplicaEn=CxcConSaldo.Cliente
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroAplicaEn1=CxcConSaldo.Categoria
FiltroAplicaEn2=CxcConSaldo.Familia
FiltroAplicaEn3=CxcConSaldo.Grupo
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodoFinal=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cliente<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Cliente(s)
MenuLocal=S
ListaAcciones=LocalInformacion
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroMonedas=S
FiltroMonedasCampo=CxcConSaldo.Moneda
OtroOrden=S
ListaOrden=CxcConSaldo.Saldo<TAB>(Decendente)
PermiteLocalizar=S

IconosNombre=CxcConSaldo:CxcConSaldo.Cliente
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=CteTipo
FiltroAplicaEn4=Cte.Tipo
FiltroGeneral=CxcConSaldo.Empresa=<T>{Empresa}<T>
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

[Lista.Columnas]
Cliente=106
Nombre=314
Saldo=106
0=105
1=299

2=-2
[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreEnBoton=S
NombreDesplegar=C&liente
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteInfo
ActivoCondicion=Usuario.CteInfo
Antes=S
Visible=S
ConCondicion=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(CxcConSaldo:CxcConSaldo.Cliente)
AntesExpresiones=Asigna( Info.Cliente, CxcConSaldo:CxcConSaldo.Cliente)

[Acciones.LocalInformacion]
Nombre=LocalInformacion
Boton=0
NombreDesplegar=&Información del Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna( Info.Cliente, CxcConSaldo:CxcConSaldo.Cliente)

[Lista.CxcConSaldo.Nombre]
Carpeta=Lista
Clave=CxcConSaldo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CxcConSaldo.Saldo]
Carpeta=Lista
Clave=CxcConSaldo.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
EspacioPrevio=
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

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

[Acciones.Reporte]
Nombre=Reporte
Boton=68
NombreDesplegar=Reporte
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=RepCxcSaldo
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




[Lista.ListaEnCaptura]
(Inicio)=CxcConSaldo.Nombre
CxcConSaldo.Nombre=CxcConSaldo.Saldo
CxcConSaldo.Saldo=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Reporte
Reporte=Informacion
Informacion=Mostrar Campos
Mostrar Campos=(Fin)
