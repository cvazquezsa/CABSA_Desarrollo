[Forma]
Clave=ExplorarCxpMov
Nombre=<T>Explorando - Cuentas por Pagar<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=260
PosicionInicialArriba=125
PosicionInicialAltura=465
PosicionInicialAncho=846
EsConsultaExclusiva=S
EsMovimiento=S
TituloAuto=S
MovModulo=CXP
MovEspecificos=Todos
PosicionInicialAlturaCliente=438

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxpExplorar
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroListas=S
FiltroListasRama=CXP
FiltroListasAplicaEn=Prov.Proveedor
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ProvCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ProvFam
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
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Pendientes
MenuLocal=S
ListaAcciones=LocalInformacion
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=CxpInfo.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
OtroOrden=S
ListaOrden=CxpInfo.Vencimiento<TAB>(Acendente)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroAplicaEn1=Prov.Categoria
FiltroAplicaEn2=Prov.Familia
FiltroMonedas=S
FiltroMonedasCampo=CxpInfo.Moneda
PermiteLocalizar=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
BusquedaRespetarControles=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=CxpInfo.UEN

AnchoTotalizador1=300
TieneTotalizador2=S
IconosNombre=CxpExplorar:CxpInfo.Mov+<T> <T>+CxpExplorar:CxpInfo.MovID
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ProvTipo
FiltroAplicaEn3=Prov.Tipo
FiltroGeneral=CxpInfo.Empresa=<T>{Empresa}<T>
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
Proveedor=106
Nombre=314
Saldo=106
0=133
1=83

2=-2
3=-2
4=-2
5=-2
6=76
7=-2
[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreEnBoton=S
NombreDesplegar=&Proveedor
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Antes=S
Visible=S
ConCondicion=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(CxpExplorar:Prov.Proveedor)
AntesExpresiones=Asigna( Info.Proveedor, CxpExplorar:Prov.Proveedor)

[Acciones.LocalInformacion]
Nombre=LocalInformacion
Boton=0
NombreDesplegar=&Información Proveedor
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna( Info.Proveedor, CxpExplorar:Prov.Proveedor)

[Lista.CxpInfo.Referencia]
Carpeta=Lista
Clave=CxpInfo.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CxpInfo.Saldo]
Carpeta=Lista
Clave=CxpInfo.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CxpInfo.Proveedor]
Carpeta=Lista
Clave=CxpInfo.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Dias]
Carpeta=Lista
Clave=Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CxpInfo.FechaEmision]
Carpeta=Lista
Clave=CxpInfo.FechaEmision
Editar=S
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

[Lista.CxpInfo.Vencimiento]
Carpeta=Lista
Clave=CxpInfo.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
TipoAccion=Formas
ClaveAccion=RepCxpPendiente
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

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, CxpExplorar:CxpInfo.ID)



[Lista.SaldoMN]
Carpeta=Lista
Clave=SaldoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco




[Lista.ListaEnCaptura]
(Inicio)=CxpInfo.Proveedor
CxpInfo.Proveedor=CxpInfo.Referencia
CxpInfo.Referencia=CxpInfo.FechaEmision
CxpInfo.FechaEmision=Dias
Dias=CxpInfo.Vencimiento
CxpInfo.Vencimiento=CxpInfo.Saldo
CxpInfo.Saldo=SaldoMN
SaldoMN=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Propiedades
Propiedades=Reporte
Reporte=Informacion
Informacion=Mostrar Campos
Mostrar Campos=(Fin)
