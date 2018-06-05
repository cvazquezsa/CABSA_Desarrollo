[Forma]
Clave=CtaListaCopiar
Nombre=Cuentas
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=150
PosicionInicialArriba=145
PosicionInicialAltura=471
PosicionInicialAncho=724
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Cuenta, Nulo)
PosicionInicialAlturaCliente=444

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=
Zona=A1
Vista=CtaLista
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroArbolClave=CtaLista.Cuenta
FiltroArbolValidar=CtaLista.Descripcion
FiltroArbolRama=CtaLista.Rama
FiltroArbolAcumulativas=CtaLista.EsAcumulativa
FiltroAncho=30
FiltroTipo=Arbol
FiltroEnOrden=S
FiltroTodoNombre=Contabilidad
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTodo=
FiltroTodoFinal=
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
PestanaOtroNombre=S
PestanaNombre=Cuentas
IconosCampo=(sin Icono)
IconosEstilo=Iconos pequeños
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
IconosSubTitulo=Cuenta
FiltroListas=S
FiltroListasRama=CONT
FiltroListasAplicaEn=CtaLista.Cuenta
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S
IconosNombre=Si(CtaLista:CtaLista.Tipo<>TipoEstructura,CtaLista:CtaLista.Cuenta+<T>  <T>)+CtaLista:CtaLista.Descripcion

[Lista.Columnas]
Cuenta=109
Descripcion=213
0=207
1=111

[Acciones.RamaSubir]
Nombre=RamaSubir
Boton=44
NombreDesplegar=Subir un nivel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Rama Subir
Activo=S
Visible=S

[Acciones.Info]
Nombre=Info
Boton=34
NombreDesplegar=Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CtaInfo
Activo=S
Visible=S
Antes=S
EspacioPrevio=S
AntesExpresiones=Asigna( Info.Cuenta, CtaLista:CtaLista.Cuenta )

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Seleccionar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=FormaSeleccion

[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionCondicion=FormaNormal
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Cuenta, CtaLista:CtaLista.Cuenta)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=RamaSubir
RamaSubir=Info
Info=(Fin)
