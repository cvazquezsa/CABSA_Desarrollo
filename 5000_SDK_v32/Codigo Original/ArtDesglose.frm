[Forma]
Clave=ArtDesglose
Nombre=<T>Desglose del Artículo por Almacenes<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=84
PosicionInicialArriba=413
PosicionInicialAltura=332
PosicionInicialAncho=826
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
Comentarios=e(<T>Artículo<T>)+<T>: <T>+Info.Articulo
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=372

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
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
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Almacenes
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=20
FiltroGrupo1=Alm.Grupo
FiltroGrupo2=Alm.Almacen
FiltroTodo=S
FiltroAplicaEn=Alm.Grupo
IconosNombre=ArtDesglose:ArtSubDisponible.SubCuenta
FiltroGeneral=ArtSubDisponible.Empresa={Comillas(Empresa)} AND<BR>ArtSubDisponible.Articulo={Comillas(Info.Articulo)}

[Lista.Columnas]
Articulo=124
Almacen=64
SubCuenta=124
Disponible=64
0=85
1=346

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

[Lista.ArtSubDisponible.Almacen]
Carpeta=Lista
Clave=ArtSubDisponible.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Alm.Grupo]
Carpeta=Lista
Clave=Alm.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

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


[Lista.ListaEnCaptura]
(Inicio)=OpcionNom
OpcionNom=ArtSubDisponible.Disponible
ArtSubDisponible.Disponible=ArtSubDisponible.Almacen
ArtSubDisponible.Almacen=Alm.Grupo
Alm.Grupo=(Fin)







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)
