
[Forma]
Clave=ContratoLista
Icono=0
CarpetaPrincipal=Lista
Modulos=(All)
MovModulo=PACTO
Nombre=Lista Contratos

ListaCarpetas=Lista
PosicionInicialAlturaCliente=478
PosicionInicialAncho=874
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=283
PosicionInicialArriba=197
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
Comentarios=Lista(Info.MovProcesar,SI(Info.Modulo=<T>VTAS<T>,Info.Cliente,SI(Info.Modulo=<T>COMS<T>,Info.Proveedor,SI(Info.Modulo=<T>GAS<T>,Info.Acreedor,SI(Info.Modulo=<T>CXC<T>,Info.Cliente,Info.Proveedor)))))
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Contrato
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

IconosSubTitulo=<T>Movimiento<T>
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Contrato.FechaEmision
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

FiltroUsuarioDefault=(Todos)
FiltroFechasDefault=(All)
FiltroListaEstatus=VIGENTE
FiltroEstatusDefault=VIGENTE
FiltroEstatus=S
FiltroSituacion=S
FiltroFechas=S
FiltroUsuarios=S
FiltroEmpresas=S
FiltroSucursales=S
IconosNombre=Contrato:Contrato.Mov + <T> <T> + Contrato:Contrato.MovID
FiltroGeneral=Contrato.Mov = <T>{Info.MovProcesar}<T><BR>{SI(Info.Modulo = <T>VTAS<T>,<T> AND Contrato.Cliente = <T> & Comillas(Info.Cliente),<T><T>)}<BR>{SI(Info.Modulo = <T>COMS<T>,<T> AND Contrato.Proveedor = <T> & Comillas(Info.Proveedor),<T><T>)}<BR>{SI(Info.Modulo = <T>GAS<T>,<T> AND Contrato.Proveedor = <T> & Comillas(Info.Acreedor),<T><T>)}<BR>{SI(Info.Modulo = <T>CXC<T>,<T> AND Contrato.Cliente = <T> & Comillas(Info.Cliente),<T><T>)}<BR>{SI(Info.Modulo = <T>CXP<T>,<T> AND Contrato.Proveedor = <T> & Comillas(Info.Proveedor),<T><T>)}
[Lista.Contrato.Empresa]
Carpeta=Lista
Clave=Contrato.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Contrato.Concepto]
Carpeta=Lista
Clave=Contrato.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Contrato.Estatus]
Carpeta=Lista
Clave=Contrato.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Contrato.Situacion]
Carpeta=Lista
Clave=Contrato.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Contrato.Referencia]
Carpeta=Lista
Clave=Contrato.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro


[Lista.Columnas]
0=69
1=-2
2=72
3=-2
4=81
5=85
6=156
7=199



8=54
9=35

[Lista.Contrato.FechaEmision]
Carpeta=Lista
Clave=Contrato.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Contrato.Usuario]
Carpeta=Lista
Clave=Contrato.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro










[Lista.Contrato.Sucursal]
Carpeta=Lista
Clave=Contrato.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


























[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
NombreEnBoton=S















[Lista.ListaEnCaptura]
(Inicio)=Contrato.Empresa
Contrato.Empresa=Contrato.FechaEmision
Contrato.FechaEmision=Contrato.Usuario
Contrato.Usuario=Contrato.Concepto
Contrato.Concepto=Contrato.Estatus
Contrato.Estatus=Contrato.Situacion
Contrato.Situacion=Contrato.Referencia
Contrato.Referencia=Contrato.Sucursal
Contrato.Sucursal=(Fin)
