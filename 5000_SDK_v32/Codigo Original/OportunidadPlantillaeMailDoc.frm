[Forma]
Clave=OportunidadPlantillaeMailDoc
Icono=240
Modulos=(Todos)
MovModulo=OPORT
Nombre=e(<T>Plantillas eMail Documentación<T>+Si(Info.DocOk, <T> con <T>, <T> sin <T>))+Info.Doc
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=271
PosicionInicialArriba=99
PosicionInicialAlturaCliente=492
PosicionInicialAncho=737
ListaAcciones=(Lista)
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadPlantillaeMailA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Plantilla<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Negro
FiltroPredefinido=S
FiltroGrupo1=OportunidadPlantillaeMail.Categoria
FiltroValida1=OportunidadPlantillaeMail.Categoria
FiltroGrupo2=OportunidadPlantillaeMail.Grupo
FiltroValida2=OportunidadPlantillaeMail.Grupo
FiltroGrupo3=OportunidadPlantillaeMail.Familia
FiltroValida3=OportunidadPlantillaeMail.Familia
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=OportunidadPlantillaeMail.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S

FiltroTodo=S
IconosNombre=OportunidadPlantillaeMailA:OportunidadPlantillaeMail.Plantilla
FiltroGeneral=OportunidadPlantillaeMail.Estatus = <T>Activa<T>
[Lista.Columnas]
0=191


[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S






EspacioPrevio=S
[Acciones.Preeliminar]
Nombre=Preeliminar
Boton=108
NombreDesplegar=&Preeliminar
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
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S








































[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S



















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preeliminar
Preeliminar=Excel
Excel=Campos
Campos=(Fin)
