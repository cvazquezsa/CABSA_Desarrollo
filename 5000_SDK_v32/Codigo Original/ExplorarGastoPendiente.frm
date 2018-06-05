[Forma]
Clave=ExplorarGastoPendiente
Icono=47
Modulos=(Todos)
Nombre=<T>Explorando - Gastos Pendientes<T>
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=0
PosicionInicialArriba=189
PosicionInicialAltura=477
PosicionInicialAncho=1106
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
EsConsultaExclusiva=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=450
Comentarios=Lista(Info.Proveedor, Info.Nombre)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gasto
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)
Filtros=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=16
BusquedaEnLinea=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroEstatus=S
FiltroFechas=S
FiltroMonedas=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasCampo=Gasto.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroMonedasCampo=Gasto.Moneda
PestanaOtroNombre=S
FiltroPredefinido=S
FiltroAncho=16
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=M�ltiple (por Grupos)
FiltroGrupo1=Gasto.Clase
FiltroGrupo2=Gasto.SubClase
FiltroTodo=S
FiltroNull=S
FiltroSucursales=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=Gasto.UEN

AnchoTotalizador1=450
TieneTotalizador2=S
IconosNombre=Gasto:Gasto.Mov+<T> <T>+Gasto:Gasto.MovID
FiltroGeneral=Gasto.Empresa=<T>{Empresa}<T><BR>{Si(ConDatos(Info.Proveedor), <T> AND Gasto.Acreedor=<T>+Comillas(Info.Proveedor), <T><T>)}
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

[Lista.Gasto.FechaEmision]
Carpeta=Lista
Clave=Gasto.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador=0
ColorFondo=Blanco

[Lista.Gasto.Vencimiento]
Carpeta=Lista
Clave=Gasto.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Gasto.Acreedor]
Carpeta=Lista
Clave=Gasto.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
0=115
1=81

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

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreEnBoton=
NombreDesplegar=Propiedades del Movimiento
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)

[Acciones.AcreedorInfo]
Nombre=AcreedorInfo
Boton=34
NombreDesplegar=Informaci�n del Acreedor/Responsable
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Proveedor, Gasto:Gasto.Acreedor)

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
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
NombreDesplegar=Presentaci�n preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Lista.ImporteF]
Carpeta=Lista
Clave=ImporteF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ImpuestosF]
Carpeta=Lista
Clave=ImpuestosF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.RetencionF]
Carpeta=Lista
Clave=RetencionF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SaldoF]
Carpeta=Lista
Clave=SaldoF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.ImporteFMN]
Carpeta=Lista
Clave=ImporteFMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.ImpuestosFMN]
Carpeta=Lista
Clave=ImpuestosFMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.RetencionFMN]
Carpeta=Lista
Clave=RetencionFMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.SaldoFMN]
Carpeta=Lista
Clave=SaldoFMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=Gasto.FechaEmision
Gasto.FechaEmision=Gasto.Vencimiento
Gasto.Vencimiento=Gasto.Acreedor
Gasto.Acreedor=Prov.Nombre
Prov.Nombre=ImporteF
ImporteF=ImpuestosF
ImpuestosF=RetencionF
RetencionF=SaldoF
SaldoF=ImporteFMN
ImporteFMN=ImpuestosFMN
ImpuestosFMN=RetencionFMN
RetencionFMN=SaldoFMN
SaldoFMN=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=PENDIENTE
PENDIENTE=RECURRENTE
RECURRENTE=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=MovPropiedades
MovPropiedades=AcreedorInfo
AcreedorInfo=Mostrar Campos
Mostrar Campos=(Fin)
