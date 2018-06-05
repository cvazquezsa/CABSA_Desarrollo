[Forma]
Clave=ExplorarCxcVentaNeta
Nombre=<T>Explorando - Ventas Netas<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=243
PosicionInicialArriba=124
PosicionInicialAltura=468
PosicionInicialAncho=880
BarraHerramientas=S
EsConsultaExclusiva=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=FechaEnTexto(Info.FechaD,<T>dd/mmm/aaaa<T>)+<T> - <T>+FechaEnTexto(Info.FechaA,<T>dd/mmm/aaaa<T>)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes)
PosicionInicialAlturaCliente=441

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcVentaNeta
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cliente<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteFam
FiltroAplicaEn1=Cte.Categoria
FiltroAplicaEn2=Cte.Grupo
FiltroAplicaEn3=Cte.Familia
FiltroAncho=20
FiltroListas=S
FiltroListasRama=CXC
FiltroListasAplicaEn=CxcVentaNeta.Cliente
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroFechasNormal=S
FiltroMonedasCampo=Moneda
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroTodo=S
FiltroTodoFinal=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=CxcVentaNeta.UEN
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Condicion
FiltroAplicaEn4=CxcVentaNeta.Condicion
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S

OtroOrden=S
ListaOrden=CxcVentaNeta.Cliente<TAB>(Acendente)
Paginacion=S
PaginacionTamano=1000
IconosNombre=CxcVentaNeta:CxcVentaNeta.Cliente
[Lista.Nombre]
Carpeta=Lista
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Importe]
Carpeta=Lista
Clave=Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Impuestos]
Carpeta=Lista
Clave=Impuestos
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Total]
Carpeta=Lista
Clave=Total
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=105
1=175

2=-2
3=-2
4=-2
5=-2
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

[Lista.Mov]
Carpeta=Lista
Clave=Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Fechas]
Nombre=Fechas
Boton=53
NombreEnBoton=S
NombreDesplegar=&Fechas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
EjecucionCondicion=Forma(<T>EspecificarFechas<T>)
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

[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=ExplorarCxcVentaNetaTotal
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T>WHERE <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T><T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
TipoAccion=Reportes Impresora
ClaveAccion=ExplorarCxcVentaNetaTotal
Activo=S
Visible=S
EspacioPrevio=S



Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T>WHERE <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T><T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Acciones.Totales]
Nombre=Totales
Boton=64
NombreEnBoton=S
NombreDesplegar=Totales
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ExplorarCxCVentaNetaTotal
Activo=S
Antes=S
Visible=S


AntesExpresiones=Asigna(Info.Filtro,<T>WHERE <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T><T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Paginacion
Activo=S
Visible=S

EspacioPrevio=S







[Lista.ListaEnCaptura]
(Inicio)=Nombre
Nombre=Mov
Mov=Importe
Importe=Impuestos
Impuestos=Total
Total=(Fin)





































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Fechas
Fechas=Navegador
Navegador=Totales
Totales=Mostrar Campos
Mostrar Campos=(Fin)
