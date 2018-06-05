
[Forma]
Clave=ExplorarPCP
Icono=0
Modulos=(Todos)
Nombre=Explorando - Planeación Presupuestal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=189
PosicionInicialArriba=87
PosicionInicialAlturaCliente=460
PosicionInicialAncho=904
ListaAcciones=(Lista)
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PCPT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(por Omisión)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroGrupo1=PCP.Proyecto
FiltroValida1=PCP.Proyecto
FiltroGrupo2=PCP.Mov
FiltroValida2=PCP.Mov
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroNull=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)

BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroProyectos=S
FiltroSucursales=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasCampo=PCP.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroMonedasCampo=PCP.Moneda
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroEstatus=S
IconosConSenales=S
FiltroGrupo3=PCP.Categoria
FiltroValida3=PCP.Categoria
IconosNombre=PCPT:PCP.Mov + <T> <T> + PCPT:PCP.MovID
FiltroGeneral=PCP.Empresa = {Comillas(Empresa)} AND PCP.Estatus IN (<T>PENDIENTE<T>,<T>VIGENTE<T>,<T>COINCLUIDO<T>,<T>CANCELADO<T>)
[Lista.PCP.FechaEmision]
Carpeta=Lista
Clave=PCP.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.PCP.Proyecto]
Carpeta=Lista
Clave=PCP.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.PCP.Categoria]
Carpeta=Lista
Clave=PCP.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco

[Lista.PCPD.CatalogoTipoTipo]
Carpeta=Lista
Clave=PCPD.CatalogoTipoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.PCPD.CatalogoTipoRama]
Carpeta=Lista
Clave=PCPD.CatalogoTipoRama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.PCPD.ClavePresupuestal]
Carpeta=Lista
Clave=PCPD.ClavePresupuestal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.PCPD.ClavePresupuestalNombre]
Carpeta=Lista
Clave=PCPD.ClavePresupuestalNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.PCPD.CatalogoTipo]
Carpeta=Lista
Clave=PCPD.CatalogoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.PCPD.CatalogoClave]
Carpeta=Lista
Clave=PCPD.CatalogoClave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.PCPD.CatalogoNombre]
Carpeta=Lista
Clave=PCPD.CatalogoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.PCPD.CatalogoTechoPresupuesto]
Carpeta=Lista
Clave=PCPD.CatalogoTechoPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.PCPD.ReglaID]
Carpeta=Lista
Clave=PCPD.ReglaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.PCPD.ReglaDescripcion]
Carpeta=Lista
Clave=PCPD.ReglaDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.PCPD.ReglaTipo]
Carpeta=Lista
Clave=PCPD.ReglaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.PCPD.ReglaMascara]
Carpeta=Lista
Clave=PCPD.ReglaMascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.Columnas]
0=121
1=-2
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
15=-2

































[Lista.ListaEnCaptura]
(Inicio)=PCP.FechaEmision
PCP.FechaEmision=PCP.Proyecto
PCP.Proyecto=PCP.Categoria
PCP.Categoria=PCPD.CatalogoTipoTipo
PCPD.CatalogoTipoTipo=PCPD.CatalogoTipoRama
PCPD.CatalogoTipoRama=PCPD.ClavePresupuestal
PCPD.ClavePresupuestal=PCPD.ClavePresupuestalNombre
PCPD.ClavePresupuestalNombre=PCPD.CatalogoTipo
PCPD.CatalogoTipo=PCPD.CatalogoClave
PCPD.CatalogoClave=PCPD.CatalogoNombre
PCPD.CatalogoNombre=PCPD.CatalogoTechoPresupuesto
PCPD.CatalogoTechoPresupuesto=PCPD.ReglaID
PCPD.ReglaID=PCPD.ReglaDescripcion
PCPD.ReglaDescripcion=PCPD.ReglaTipo
PCPD.ReglaTipo=PCPD.ReglaMascara
PCPD.ReglaMascara=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=VIGENTE
VIGENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

NombreEnBoton=S
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


[Acciones.Preeliminar]
Nombre=Preeliminar
Boton=6
NombreDesplegar=&Vista Previa
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=115
NombreDesplegar=Enviar a &Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S




[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreDesplegar=&Movimiento
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
Visible=S














NombreEnBoton=S
AntesExpresiones=Asigna(Info.Modulo, <T>PCP<T>)<BR>Asigna(Info.ID, PCPT:PCP.ID)
[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S



















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preeliminar
Preeliminar=Excel
Excel=MovPropiedades
MovPropiedades=MostrarCampos
MostrarCampos=(Fin)
