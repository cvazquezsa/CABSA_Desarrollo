[Forma]
Clave=ExplorarVentaUtilD
Nombre=<T>Explorado - Utilidades (Nivel Artículo)
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=442
PosicionInicialAncho=1199
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=230
PosicionInicialArriba=203
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=415

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaUtilD
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=1000
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
FiltroPredefinido=S
FiltroAncho=25
FiltroGrupo1=(Validaciones Memoria)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroValida1=ArtCat
FiltroAplicaEn=VentaUtilD.Movimiento
FiltroTodo=S
FiltroTodoFinal=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=VentaUtilD.Articulo
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroFechas=S
FiltroFechasCampo=VentaUtilD.FechaEmision
FiltroFechasDefault=Este Mes
FiltroMonedas=S
FiltroMonedasCampo=VentaUtilD.Moneda
PermiteLocalizar=S
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroSucursales=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=VentaUtilD.UEN

TieneTotalizador2=S
AnchoTotalizador1=500
IconosNombre=VentaUtilD:VentaUtilD.Movimiento
FiltroGeneral=VentaUtilD.Empresa = <T>{Empresa}<T> AND Art.Tipo <> <T>SERVICIO<T>
[Lista.Utilidad]
Carpeta=Lista
Clave=Utilidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.UtilidadPor]
Carpeta=Lista
Clave=UtilidadPor
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
0=136
1=89

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

[Lista.VentaUtilD.Cliente]
Carpeta=Lista
Clave=VentaUtilD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

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

[Lista.VentaUtilD.Articulo]
Carpeta=Lista
Clave=VentaUtilD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=<T>&Movimiento<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(VentaUtilD:VentaUtilD.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaUtilD:VentaUtilD.ID)

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

[Lista.CantidadNeta]
Carpeta=Lista
Clave=CantidadNeta
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CostoNeto]
Carpeta=Lista
Clave=CostoNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ImporteNeto]
Carpeta=Lista
Clave=ImporteNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ComisionNeta]
Carpeta=Lista
Clave=ComisionNeta
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Reporte]
Nombre=Reporte
Boton=68
NombreDesplegar=Reporte
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=RepVentaUtilD
Activo=S
Visible=S
EspacioPrevio=S





[Lista.CostoNetoMN]
Carpeta=Lista
Clave=CostoNetoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.ImporteNetoMN]
Carpeta=Lista
Clave=ImporteNetoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.UtilidadMN]
Carpeta=Lista
Clave=UtilidadMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.ComisionNetaMN]
Carpeta=Lista
Clave=ComisionNetaMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco






[Lista.ListaEnCaptura]
(Inicio)=VentaUtilD.Articulo
VentaUtilD.Articulo=VentaUtilD.Cliente
VentaUtilD.Cliente=CantidadNeta
CantidadNeta=CostoNeto
CostoNeto=ImporteNeto
ImporteNeto=Utilidad
Utilidad=UtilidadPor
UtilidadPor=ComisionNeta
ComisionNeta=CostoNetoMN
CostoNetoMN=ImporteNetoMN
ImporteNetoMN=UtilidadMN
UtilidadMN=ComisionNetaMN
ComisionNetaMN=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Reporte
Reporte=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
