[Forma]
Clave=ArtListaCostos
Nombre=Costos
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=110
PosicionInicialArriba=151
PosicionInicialAltura=459
PosicionInicialAncho=803
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna( Info.Articulo, Nulo )
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=432

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtConCosto
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=25
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=ArtFam
BusquedaRapidaControles=S
FiltroAplicaEn=Art.Familia
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=25
BusquedaEnLinea=S
FiltroTodoFinal=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn3=Art.Familia
ValidarCampos=S
ListaCamposAValidar=(Lista)
PermiteLocalizar=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
HojaIndicador=S
HojaAjustarColumnas=S
FiltroAplicaEn4=Art.Linea
FiltroTodo=S
FiltroGeneral=Art.Tipo<><T>Estructura<T>

[Lista.Columnas]
Articulo=103
Descripcion1=147
PrecioLista=87
UltimoCosto=77
CostoPromedio=79
CostoEstandar=80
CostoReposicion=88
Articulo_1=100
SubCuenta=65
UltimoCostoSinGastos=121

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreEnBoton=S
NombreDesplegar=&Asistente
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Lista Costos
ListaParametros1=ArtConCosto:Art.PrecioLista<BR>ArtConCosto:Art.Precio2<BR>ArtConCosto:Art.Precio3<BR>ArtConCosto:Art.Precio4<BR>ArtConCosto:Art.Precio5<BR>ArtConCosto:Art.Precio6<BR>ArtConCosto:Art.Precio7<BR>ArtConCosto:Art.Precio8<BR>ArtConCosto:Art.Precio9<BR>ArtConCosto:Art.Precio10<BR>ArtConCosto:Art.PrecioMinimo<BR>ArtConCosto:Art.MargenMinimo<BR>ArtConCosto:Art.Margen<BR>ArtConCosto:Art.CostoEstandar<BR>ArtConCosto:Art.CostoReposicion<BR>ArtConCosto:ArtCostoEmpresa.CostoPromedio<BR>ArtConCosto:ArtCostoEmpresa.UltimoCosto
ListaParametros=S
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>Cancelar Cambios<T>
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Articulo]
Carpeta=Lista
Clave=Art.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.CostoEstandar]
Carpeta=Lista
Clave=Art.CostoEstandar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.CostoReposicion]
Carpeta=Lista
Clave=Art.CostoReposicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCostoEmpresa.UltimoCosto]
Carpeta=Lista
Clave=ArtCostoEmpresa.UltimoCosto
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCostoEmpresa.CostoPromedio]
Carpeta=Lista
Clave=ArtCostoEmpresa.CostoPromedio
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asistente
Asistente=Cancelar Cambios
Cancelar Cambios=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Articulo
Art.Articulo=Art.Descripcion1
Art.Descripcion1=Art.CostoEstandar
Art.CostoEstandar=Art.CostoReposicion
Art.CostoReposicion=ArtCostoEmpresa.UltimoCosto
ArtCostoEmpresa.UltimoCosto=ArtCostoEmpresa.CostoPromedio
ArtCostoEmpresa.CostoPromedio=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.ClaveFabricante
Art.ClaveFabricante=Art.PrecioLista
Art.PrecioLista=(Fin)
