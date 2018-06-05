
[Forma]
Clave=SabanaFiltroSucursal
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Sucursales

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=555
PosicionInicialAncho=1060
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=153
PosicionInicialArriba=67
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionCol1=373
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Sucursales
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
Vista=SabanaFiltroSucursal
ListaEnCaptura=Sucursal.Nombre

IconosSeleccionMultiple=S
IconosSubTitulo=<T>Sucursal<T>
IconosSeleccionPorLlave=S
IconosNombreNumerico=S
IconosNombre=SabanaFiltroSucursal.Sucursal
FiltroGeneral=SabanaFiltroSucursal.Estacion = {EstacionTrabajoFija}
[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
0=-2
1=-2

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Antes=S
Visible=S

AntesExpresiones=RegistrarSeleccion( <T>Lista<T> )<BR>Asigna(Temp.Texto, SQL(<T>EXEC spPlanArtSabanaValidar :nEstacion, :nEstacionFija, 2<T>, EstacionTrabajo, EstacionTrabajoFija))<BR>Si<BR>  Temp.Texto = <T>OK<T><BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPlanArtSabana :tEmpresa, :nEstacion, :nEstacion2<T>, Empresa, EstacionTrabajo, EstacionTrabajoFija)<BR>  Si<BR>    SQL(<T>SELECT COUNT(*) FROM Sabana WHERE Estacion = :nEstacion<T>, EstacionTrabajoFija) > 0<BR>  Entonces<BR>      Forma(<T>Sabana<T>)<BR>  Sino<BR>    Informacion(<T>No hay registros para los criterios de busqueda<T>)<BR>  Fin<BR>Sino<BR>  Informacion(Temp.Texto)<BR>Fin
[Acciones.Todo]
Nombre=Todo
Boton=62
NombreEnBoton=S
NombreDesplegar=Seleccionar Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S


[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=63
NombreEnBoton=S
NombreDesplegar=Quitar Seleccion
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S






[General.Columnas]
0=-2
1=-2
2=-2
3=-2

[Detalle.Columnas]
0=-2
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


















































































[Acciones.Actualizar]
Nombre=Actualizar
Boton=18
NombreEnBoton=S
NombreDesplegar=Insertar Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

















Antes=S




































AntesExpresiones=EjecutarSQL(<T>EXEC spSabanaFiltroSucursal :nEstacion, :tGrupo<T>, EstacionTrabajoFija, Info.SucursalGrupo)














[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Todo
Todo=Quitar Seleccion
Quitar Seleccion=Actualizar
Actualizar=(Fin)
