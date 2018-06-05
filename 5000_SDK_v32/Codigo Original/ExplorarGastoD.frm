[Forma]
Clave=ExplorarGastoD
Icono=47
Modulos=(Todos)
Nombre=<T>Explorando - Gastos Detalle (Filtro Clasificaciones)<T>
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=0
PosicionInicialArriba=194
PosicionInicialAltura=466
PosicionInicialAncho=1270
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=439
Comentarios=Lista(Info.Proveedor, Info.Nombre)

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GastoT
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
FiltroPredefinido=S
FiltroGrupo1=GastoT.ConceptoClase
FiltroValida1=GastoT.ConceptoClase
FiltroAncho=20
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroFechasCampo=GastoT.FechaEmision
FiltroFechasDefault=Este Mes
FiltroMonedasCampo=GastoT.Moneda
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroEstatusDefault=PENDIENTE
FiltroFechasNormal=S
FiltroGrupo2=GastoT.ConceptoSubClase
FiltroValida2=GastoT.ConceptoSubClase
FiltroGrupo3=GastoT.Concepto
FiltroValida3=GastoT.Concepto
FiltroSucursales=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=GastoT.UEN
FiltroUsuarios=S
FiltroUsuarioDefault=(Todos)

AnchoTotalizador1=550
TieneTotalizador2=S
IconosNombre=GastoT:GastoT.Mov+<T> <T>+GastoT:GastoT.MovID
FiltroGeneral=GastoT.Empresa=<T>{Empresa}<T> AND<BR>GastoT.Estatus=<T>CONCLUIDO<T> AND<BR>GastoT.Mov IN ({MovListaSQL(<T>GAS<T>, GAS.G, GAS.GTC, GAS.C, GAS.CCH, GAS.DC, GAS.DG, GAS.OI, GAS.CB, GAS.AB, GAS.EST, GAS.CI)})<BR>{Si(ConDatos(Info.Proveedor), <T> AND GastoT.Acreedor=<T>+Comillas(Info.Proveedor), <T><T>)}
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

[Lista.GastoT.FechaEmision]
Carpeta=Lista
Clave=GastoT.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.GastoT.Vencimiento]
Carpeta=Lista
Clave=GastoT.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.GastoT.Acreedor]
Carpeta=Lista
Clave=GastoT.Acreedor
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

[Lista.GastoT.Concepto]
Carpeta=Lista
Clave=GastoT.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
0=117
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
13=-2
14=-2
[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreDesplegar=Propiedades del Movimiento
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, GastoT:GastoT.ID)
Visible=S

[Acciones.AcreedorInfo]
Nombre=AcreedorInfo
Boton=34
NombreDesplegar=Información del Acreedor/Responsable
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Proveedor, GastoT:GastoT.Acreedor)

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
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Lista.ImporteLineaF]
Carpeta=Lista
Clave=ImporteLineaF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CantidadF]
Carpeta=Lista
Clave=CantidadF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ImpuestosLineaF]
Carpeta=Lista
Clave=ImpuestosLineaF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.RetencionLineaF]
Carpeta=Lista
Clave=RetencionLineaF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TotalLineaF]
Carpeta=Lista
Clave=TotalLineaF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.ImporteLineaFMN]
Carpeta=Lista
Clave=ImporteLineaFMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.ImpuestosLineaFMN]
Carpeta=Lista
Clave=ImpuestosLineaFMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.RetencionLineaFMN]
Carpeta=Lista
Clave=RetencionLineaFMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.TotalLineaFMN]
Carpeta=Lista
Clave=TotalLineaFMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=GastoT.FechaEmision
GastoT.FechaEmision=GastoT.Vencimiento
GastoT.Vencimiento=GastoT.Acreedor
GastoT.Acreedor=Prov.Nombre
Prov.Nombre=GastoT.Concepto
GastoT.Concepto=CantidadF
CantidadF=ImporteLineaF
ImporteLineaF=ImpuestosLineaF
ImpuestosLineaF=RetencionLineaF
RetencionLineaF=TotalLineaF
TotalLineaF=ImporteLineaFMN
ImporteLineaFMN=ImpuestosLineaFMN
ImpuestosLineaFMN=RetencionLineaFMN
RetencionLineaFMN=TotalLineaFMN
TotalLineaFMN=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=MovPropiedades
MovPropiedades=AcreedorInfo
AcreedorInfo=Mostrar Campos
Mostrar Campos=(Fin)
