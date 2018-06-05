[Forma]
Clave=ArtAlmDesglosePartida
Icono=6
Modulos=(Todos)
Nombre=Existencia
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=232
PosicionInicialArriba=195
PosicionInicialAltura=336
PosicionInicialAncho=559
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Lista(Info.Articulo,e(<T>Almacén<T>)+<T>: <T>+Info.Almacen)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=343

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLote
Fuente={Fixedsys, 9, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todos los colores
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
PestanaOtroNombre=S
PestanaNombre=Partidas
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Opción<T>
ElementosPorPagina=200
FiltroAutoCampo=SerieLote.SubCuenta
FiltroGrupo1=SerieLote.SubCuenta
FiltroTodo=S
FiltroTodoFinal=S
IconosNombre=SerieLote:SerieLote.SubCuenta
FiltroGeneral=SerieLote.Empresa=<T>{Empresa}<T> AND <BR>SerieLote.Articulo=<T>{Info.Articulo}<T> AND<BR>SerieLote.Almacen=<T>{Info.Almacen}<T> AND<BR>SerieLote.Existencia > 0

[Lista.Columnas]
0=82
1=112
SerieLote=163
Propiedades=121
Existencia=62

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
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(SerieLote:SerieLote.SerieLote)
AntesExpresiones=Asigna(Info.SubCuenta, SerieLote:SerieLote.SubCuenta)<BR>Asigna(Info.SerieLote, SerieLote:SerieLote.SerieLote)

[Lista.SerieLote.Existencia]
Carpeta=Lista
Clave=SerieLote.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SerieLote.ExistenciaAlterna]
Carpeta=Lista
Clave=SerieLote.ExistenciaAlterna
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SerieLote.SerieLote]
Carpeta=Lista
Clave=SerieLote.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=SerieLoteInfo
SerieLoteInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SerieLote.SerieLote
SerieLote.SerieLote=SerieLote.Existencia
SerieLote.Existencia=SerieLote.ExistenciaAlterna
SerieLote.ExistenciaAlterna=(Fin)
