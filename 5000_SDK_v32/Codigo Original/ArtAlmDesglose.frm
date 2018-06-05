[Forma]
Clave=ArtAlmDesglose
Nombre=Info.Descripcion
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=329
PosicionInicialArriba=335
PosicionInicialAltura=352
PosicionInicialAncho=622
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaSiempreAlFrente=
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaUsoContinuo=
Comentarios=Lista(Info.Articulo, e(<T>Almacén<T>)+<T>: <T>+Info.Almacen)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=327

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtDesglose
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Opción<T>
ElementosPorPagina=200
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Almacenes
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=20
FiltroGrupo1=Alm.Grupo
FiltroGrupo2=Alm.Almacen
FiltroTodo=S
FiltroAplicaEn=Alm.Grupo
MenuLocal=S
ListaAcciones=VerOpcion
IconosNombre=ArtDesglose:ArtSubDisponible.SubCuenta
FiltroGeneral=ArtSubDisponible.Empresa={Comillas(Empresa)}    AND <BR>ArtSubDisponible.Articulo={Comillas(Info.Articulo)} AND<BR>ArtSubDisponible.Almacen={Comillas(Info.Almacen)} AND<BR>ISNULL(ArtSubDisponible.Disponible, 0) <> 0

[Lista.Columnas]
Articulo=124
Almacen=64
SubCuenta=124
Disponible=64
0=79
1=427

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.ArtSubDisponible.Disponible]
Carpeta=Lista
Clave=ArtSubDisponible.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VerOpcion]
Nombre=VerOpcion
Boton=0
NombreDesplegar=&Interpretar Opción
EnMenu=S
TipoAccion=Expresion
Expresion=VerOpcionesArticulo( ArtDesglose:ArtSubDisponible.Articulo, ArtDesglose:ArtSubDisponible.SubCuenta )
ActivoCondicion=ConDatos(ArtDesglose:ArtSubDisponible.SubCuenta)
VisibleCondicion=Info.ArtTipoOpcion=TipoSi

[Lista.OpcionNom]
Carpeta=Lista
Clave=OpcionNom
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.PersonalizarVista]
Nombre=PersonalizarVista
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=PersonalizarVista
PersonalizarVista=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=OpcionNom
OpcionNom=ArtSubDisponible.Disponible
ArtSubDisponible.Disponible=(Fin)
