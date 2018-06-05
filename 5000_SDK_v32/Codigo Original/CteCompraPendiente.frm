[Forma]
Clave=CteCompraPendiente
Nombre=<T>Compras por Recibir Asignadas al Cliente<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=175
PosicionInicialArriba=237
PosicionInicialAltura=294
PosicionInicialAncho=674
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cliente
VentanaEscCerrar=S
EsConsultaExclusiva=S

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
Vista=CompraPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
FiltroAutoCampo=CompraPendienteD.Proveedor
FiltroAutoValidar=CompraPendienteD.Proveedor
FiltroGrupo1=Proveedor
FiltroValida1=Nombre
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
FiltroPredefinido1=Asignadas<BR>Disponibles
FiltroPredefinido2=CompraPendienteD.Cliente=<T>{Info.Cliente}<T><BR>NULLIF(RTRIM(CompraPendienteD.Cliente), <T><T>) IS NULL AND NULLIF(RTRIM(CompraPendienteD.Origen), <T><T>) IS NULL AND NULLIF(CompraPendienteD.OrigenID, 0) IS NULL
FiltroTodoFinal=S
FiltroPredefinido3=FechaEntrega<BR>FechaEntrega
IconosNombre=CompraPendienteD:CompraPendienteD.Mov+<T> <T>+CompraPendienteD:CompraPendienteD.MovID
FiltroGeneral=CompraPendienteD.Empresa=<T>{Empresa}<T> AND CompraPendienteD.Cliente=<T>{Info.Cliente}<T>

[Lista.CantidadReservada]
Carpeta=Lista
Clave=CantidadReservada
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
0=118
1=80
Mov=103
MovID=65
FechaEmision=75
FechaRequerida=87
Articulo=99
Almacen=68
CantidadPendiente=56

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

[Lista.]
Carpeta=Lista
ColorFondo=Negro

[Lista.CompraPendienteD.FechaEmision]
Carpeta=Lista
Clave=CompraPendienteD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.FechaRequerida]
Carpeta=Lista
Clave=CompraPendienteD.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.Almacen]
Carpeta=Lista
Clave=CompraPendienteD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.Referencia]
Carpeta=Lista
Clave=CompraPendienteD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.FechaEntrega]
Carpeta=Lista
Clave=CompraPendienteD.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendienteD.PendienteFactor]
Carpeta=Lista
Clave=CompraPendienteD.PendienteFactor
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

[Acciones.Peliminar]
Nombre=Peliminar
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


[Lista.ListaEnCaptura]
(Inicio)=CompraPendienteD.Referencia
CompraPendienteD.Referencia=CompraPendienteD.FechaEmision
CompraPendienteD.FechaEmision=CompraPendienteD.FechaEntrega
CompraPendienteD.FechaEntrega=CompraPendienteD.FechaRequerida
CompraPendienteD.FechaRequerida=CompraPendienteD.Almacen
CompraPendienteD.Almacen=CompraPendienteD.PendienteFactor
CompraPendienteD.PendienteFactor=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Peliminar
Peliminar=Excel
Excel=Campos
Campos=(Fin)
