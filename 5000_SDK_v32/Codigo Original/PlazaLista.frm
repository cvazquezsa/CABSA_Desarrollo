[Forma]
Clave=PlazaLista
Nombre=Plazas
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=198
PosicionInicialArriba=108
PosicionInicialAltura=569
PosicionInicialAncho=970
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaBloquearAjuste=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionColumna1=43
PosicionSeccion1=67
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Ult.CtaTipo, Nulo)
PosicionInicialAlturaCliente=516
PosicionSec1=312
ListaAcciones=(Lista)
EsConsultaExclusiva=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Plazas
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Plaza
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=Plaza.Plaza<TAB>(Acendente)
Filtros=S
FiltroGrupo1=Cta.Rama
FiltroAplicaEn=Cta.Cuenta
FiltroTipo=Arbol
FiltroEnOrden=S
FiltroTodoNombre=Contabilidad
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
FiltroValida1=CtaLista.Descripcion
FiltroArbolClave=Plaza.Plaza
FiltroArbolValidar=Plaza.Descripcion
FiltroArbolRama=Plaza.Rama
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=30
BusquedaEnLinea=S
PermiteLocalizar=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Plaza<T>
ElementosPorPagina=200
FiltroArbolAcumulativas=Plaza.EsJefe
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA

IconosNombre=Plaza:Plaza.Plaza
[Detalle.Cta.Cuenta]
Carpeta=Detalle
Clave=Cta.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Cta.Rama]
Carpeta=Detalle
Clave=Cta.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Cta.Descripcion]
Carpeta=Detalle
Clave=Cta.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Cuenta=111
Descripcion=266
Clave=140
Plaza=64
Puesto=105
0=85
1=191

2=114
3=188
[Detalle.CtaLista.Descripcion]
Carpeta=Detalle
Clave=CtaLista.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Plata
IgnoraFlujo=N
ColorFuente=Negro

[Detalle.Cta.EsAcumulativa]
Carpeta=Detalle
Clave=Cta.EsAcumulativa
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Cta.EsAcreedora]
Carpeta=Detalle
Clave=Cta.EsAcreedora
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.Categoria]
Carpeta=Configuracion
Clave=Cta.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.Familia]
Carpeta=Configuracion
Clave=Cta.Familia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.Grupo]
Carpeta=Configuracion
Clave=Cta.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.CentrosCostos]
Carpeta=Configuracion
Clave=Cta.CentrosCostos
Editar=S
LineaNueva=S
3D=S
Tamano=20
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Cta.Tipo]
Carpeta=Detalle
Clave=Cta.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=15
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.CentroCostosOmision]
Carpeta=Configuracion
Clave=Cta.CentroCostosOmision
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Configuracion.Cta.CentroCostosRequerido]
Carpeta=Configuracion
Clave=Cta.CentroCostosRequerido
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Cta.Estatus]
Carpeta=Detalle
Clave=Cta.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.NivelAcceso]
Carpeta=Configuracion
Clave=Cta.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.AjusteInflacionario]
Carpeta=Configuracion
Clave=Cta.AjusteInflacionario
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Detalle.Cta.Bucket]
Carpeta=Detalle
Clave=Cta.Bucket
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.CuadreContable]
Carpeta=Configuracion
Clave=Cta.CuadreContable
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Configuracion.Cta.PresupuestoNivelUEN]
Carpeta=Configuracion
Clave=Cta.PresupuestoNivelUEN
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Cta.CuentaDistribucion]
Carpeta=Detalle
Clave=Cta.CuentaDistribucion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Plaza.Descripcion]
Carpeta=Lista
Clave=Plaza.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.Plaza.Plaza]
Carpeta=Detalle
Clave=Plaza.Plaza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.Descripcion]
Carpeta=Detalle
Clave=Plaza.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.Rama]
Carpeta=Detalle
Clave=Plaza.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.Departamento]
Carpeta=Detalle
Clave=Plaza.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.Puesto]
Carpeta=Detalle
Clave=Plaza.Puesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.VigenciaD]
Carpeta=Detalle
Clave=Plaza.VigenciaD
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.Plaza.VigenciaA]
Carpeta=Detalle
Clave=Plaza.VigenciaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.Plaza.Sueldo]
Carpeta=Detalle
Clave=Plaza.Sueldo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.Plaza.Tipo]
Carpeta=Detalle
Clave=Plaza.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Plaza.Puesto]
Carpeta=Lista
Clave=Plaza.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.Plaza.Departamento]
Carpeta=Lista
Clave=Plaza.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=Plaza.Descripcion
Plaza.Descripcion=Plaza.Puesto
Plaza.Puesto=Plaza.Departamento
Plaza.Departamento=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)







[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=Personalizar
Personalizar=(Fin)
