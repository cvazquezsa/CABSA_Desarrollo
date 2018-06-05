[Forma]
Clave=ExplorarCxcCobro
Nombre=<T>Explorando - Cobranza<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=433
PosicionInicialAncho=818
PosicionSeccion1=33
PosicionSeccion2=66
PosicionInicialIzquierda=30
PosicionInicialArriba=174
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=480

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Cobros
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxc
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroFechasCampo=Cxc.FechaEmision
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroMonedasCampo=Cxc.Moneda
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroSucursales=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=Cxc.UEN

AnchoTotalizador1=300
TieneTotalizador2=S
IconosNombre=Cxc:Cxc.Mov+<T> <T>+Cxc:Cxc.MovID
FiltroGeneral=Cxc.Empresa=<T>{Empresa}<T> AND<BR>Cxc.Estatus=<T>CONCLUIDO<T> AND<BR>Cxc.Mov IN ({MovListaSQL(<T>CXC<T>, CXC.C, CXC.A, CXC.AR, CXC.AA)})
[Lista.Cxc.FechaEmision]
Carpeta=Lista
Clave=Cxc.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Cxc.Referencia]
Carpeta=Lista
Clave=Cxc.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Cxc.Cliente]
Carpeta=Lista
Clave=Cxc.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Cxc.FormaCobro]
Carpeta=Lista
Clave=Cxc.FormaCobro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Cxc.CtaDinero]
Carpeta=Lista
Clave=Cxc.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=113
1=81

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=146
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

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=<T>&Movimiento<T>
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(Cxc:Cxc.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.ID, Cxc:Cxc.ID)

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

[Acciones.Enviar a Excel]
Nombre=Enviar a Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
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

[Lista.Cxc.PersonalCobrador]
Carpeta=Lista
Clave=Cxc.PersonalCobrador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



[Lista.ImporteTotalMN]
Carpeta=Lista
Clave=ImporteTotalMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco




[Lista.ListaEnCaptura]
(Inicio)=Cxc.FechaEmision
Cxc.FechaEmision=Cxc.Referencia
Cxc.Referencia=Cxc.Cliente
Cxc.Cliente=Cte.Nombre
Cte.Nombre=Cxc.PersonalCobrador
Cxc.PersonalCobrador=Cxc.FormaCobro
Cxc.FormaCobro=Cxc.CtaDinero
Cxc.CtaDinero=ImporteTotal
ImporteTotal=ImporteTotalMN
ImporteTotalMN=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Enviar a Excel
Enviar a Excel=Propiedades
Propiedades=Mostrar Campos
Mostrar Campos=(Fin)
