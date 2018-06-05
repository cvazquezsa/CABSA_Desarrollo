[Forma]
Clave=ArtDesgloseSerieLote
Icono=6
Modulos=(Todos)
Nombre=<T>Desglose del Artículo por Almacenes<T>
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=302
PosicionInicialArriba=296
PosicionInicialAltura=300
PosicionInicialAncho=675
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=e(<T>Artículo<T>)+<T>: <T>+Info.Articulo
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=405

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtDesgloseSerieLote
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Número<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=20
FiltroGrupo1=Alm.Grupo
FiltroGrupo2=Alm.Almacen
FiltroAplicaEn=Alm.Grupo
FiltroEnOrden=S
FiltroTodoNombre=Almacenes
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
FiltroTodo=S
IconosNombre=ArtDesgloseSerieLote:SerieLote.SerieLote
FiltroGeneral=SerieLote.Empresa=<T>{Empresa}<T> AND<BR>SerieLote.Articulo=<T>{Info.Articulo}<T> AND<BR>SerieLote.Existencia>0

[Lista.SerieLote.Almacen]
Carpeta=Lista
Clave=SerieLote.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Alm.Grupo]
Carpeta=Lista
Clave=Alm.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=118
1=88

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

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtDesgloseSerieLote:SerieLote.SerieLote)
AntesExpresiones=Asigna(Info.SerieLote, ArtDesgloseSerieLote:SerieLote.SerieLote)

[Lista.SerieLote.Existencia]
Carpeta=Lista
Clave=SerieLote.Existencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a E&xcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
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

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=SerieLoteInfo
SerieLoteInfo=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SerieLote.Almacen
SerieLote.Almacen=Alm.Grupo
Alm.Grupo=SerieLote.Existencia
SerieLote.Existencia=(Fin)
