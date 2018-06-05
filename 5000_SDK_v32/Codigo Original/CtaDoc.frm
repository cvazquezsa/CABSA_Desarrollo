[Forma]
Clave=CtaDoc
Nombre=<T>Cuentas<T>+Si(Info.DocOk, <T> con <T>, <T> sin <T>)+Info.Doc
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=833
PosicionInicialArriba=189
PosicionInicialAltura=471
PosicionInicialAncho=726
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S

PosicionInicialAlturaCliente=444
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=CtaLista
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CtaLista.Descripcion
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroArbolClave=CtaLista.Cuenta
FiltroArbolValidar=CtaLista.Descripcion
FiltroArbolRama=CtaLista.Rama
FiltroArbolAcumulativas=CtaLista.EsAcumulativa
FiltroAncho=30
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Contabilidad
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Cuentas
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
IconosSubTitulo=<T>Cuenta<T>
FiltroListas=S
FiltroListasRama=CONT
FiltroListasAplicaEn=CtaLista.Cuenta
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S
MostrarConteoRegistros=S

OtroOrden=S
ListaOrden=CtaLista.Cuenta<TAB>(Acendente)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CtaCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CtaFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CtaGrupo
FiltroAplicaEn1=CtaLista.Categoria
FiltroAplicaEn2=CtaLista.Familia
FiltroAplicaEn3=CtaLista.Grupo
FiltroTodoFinal=S
IconosNombre=CtaLista:CtaLista.Cuenta
FiltroTodo=S
FiltroGeneral=CtaLista.Tipo<><T>Estructura<T> AND CtaLista.Cuenta {Si(no Info.DocOk, <T>NOT<T>,<T><T>)} IN (SELECT Cuenta FROM DocCta WHERE Rama = <T>{Info.Rama}<T> AND Documento = <T>{Info.Doc}<T>)
[Lista.Columnas]
Cuenta=109
Descripcion=213
0=175
1=292

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

[Lista.CtaLista.Descripcion]
Carpeta=Lista
Clave=CtaLista.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

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

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentacion preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
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

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S





























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Info
Info=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)
