[Forma]
Clave=PlanPos
Nombre=<T>Posición Artículo - Planeación<T>
Icono=48
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Productos
PosicionInicialIzquierda=135
PosicionInicialArriba=110
PosicionInicialAltura=548
PosicionInicialAncho=753
PosicionColumna1=50
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=48
PosicionColumna2=50
EsConsultaExclusiva=S
Comentarios=Lista(Ver.Articulo, Ver.Descripcion, <T>Almacén: <T>+Ver.Almacen, Si(Ver.Semana<>Nulo, <T>Semana: <T>+Ver.Semana))
ExpresionesAlMostrar=Asigna(Ver.Articulo, Info.Articulo)<BR>Asigna(Ver.Descripcion, Info.Descripcion)<BR>Asigna(Ver.Almacen, Info.Almacen)<BR>Asigna(Ver.ArtTipoOpcion, Info.ArtTipoOpcion)<BR>Asigna(Temp.Reg, SQL(<T>SELECT SeVende, SeCompra, SeProduce FROM Art WHERE Articulo=:tArt<T>, Ver.Articulo))<BR>Asigna(Info.SeVende, Temp.Reg[1])<BR>Asigna(Info.SeCompra, Temp.Reg[2])<BR>Asigna(Info.SeProduce, Temp.Reg[3])<BR>Asigna(Ver.Semana, Nulo)
ExpresionesAlCerrar=Asigna(Ver.Semana, Nulo)

[Origen.Columnas]
0=84
1=63

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

[Acciones.IrD]
Nombre=IrD
Boton=0
NombreDesplegar=&Ir
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
Antes=S
ActivoCondicion=ConDatos(PlanFlujoD:Articulo)
AntesExpresiones=Asigna(Info.Articulo, PlanFlujoD:Articulo)

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata

[(Variables).Info.MovID]
Carpeta=(Variables)
Clave=Info.MovID
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
Pegado=S

[Materiales]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Materiales
Clave=Materiales
Filtros=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=PlanArtFlujoM
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Material<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)
ListaAcciones=(Lista)
FiltroGrupo1=PlanArtFlujo.ProductoAlmacen
FiltroValida1=PlanArtFlujo.ProductoAlmacen
FiltroTodo=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Plan10
FiltroAplicaEn=PlanArtFlujo.ProductoPeriodo
OtroOrden=S
ListaOrden=(Lista)
IconosNombre=PlanArtFlujoM:PlanArtFlujo.Material
FiltroGeneral=PlanArtFlujo.Empresa=<T>{Empresa}<T> AND<BR>PlanArtFlujo.Producto=<T>{Ver.Articulo}<T> AND<BR>PlanArtFlujo.ProductoAlmacen=<T>{Ver.Almacen}<T><BR>{Si(Ver.Semana<>Nulo, <T> AND PlanArtFlujo.ProductoPeriodo=<T>+Ver.Semana, <T><T>)}

[Materiales.PlanArtFlujo.MaterialAlmacen]
Carpeta=Materiales
Clave=PlanArtFlujo.MaterialAlmacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Materiales.PlanArtFlujo.MaterialCantidad]
Carpeta=Materiales
Clave=PlanArtFlujo.MaterialCantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Materiales.Columnas]
0=96
1=172

[Materiales.Material.Descripcion1]
Carpeta=Materiales
Clave=Material.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Productos]
Estilo=Iconos
Clave=Productos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlanArtFlujoP
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Producto<T>
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Productos
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=(Lista)
FiltroAplicaEn=PlanArtFlujo.MaterialPeriodo
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Plan10
FiltroTodo=S
IconosNombre=PlanArtFlujoP:PlanArtFlujo.Producto
FiltroGeneral=PlanArtFlujo.Empresa=<T>{Empresa}<T> AND<BR>PlanArtFlujo.Material=<T>{Ver.Articulo}<T> AND<BR>PlanArtFlujo.MaterialAlmacen=<T>{Ver.Almacen}<T><BR>{Si(Ver.Semana<>Nulo, <T> AND PlanArtFlujo.MaterialPeriodo=<T>+Ver.Semana, <T><T>)}

[Productos.PlanArtFlujo.ProductoAlmacen]
Carpeta=Productos
Clave=PlanArtFlujo.ProductoAlmacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Productos.PlanArtFlujo.ProductoCantidad]
Carpeta=Productos
Clave=PlanArtFlujo.ProductoCantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Productos.Columnas]
0=97
1=168

[Productos.Art.Descripcion1]
Carpeta=Productos
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.IrMaterial]
Nombre=IrMaterial
Boton=0
NombreDesplegar=&Retroceder
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
ActivoCondicion=ConDatos(PlanArtFlujoM:PlanArtFlujo.Material)
AntesExpresiones=Asigna(Ver.Articulo, PlanArtFlujoM:PlanArtFlujo.Material)<BR>Asigna(Ver.Almacen, PlanArtFlujoM:PlanArtFlujo.MaterialAlmacen)<BR>Asigna(Ver.Descripcion, PlanArtFlujoM:Material.Descripcion1)<BR>Asigna(Info.SeVende, PlanArtFlujoM:Material.SeVende)<BR>Asigna(Info.SeCompra, PlanArtFlujoM:Material.SeCompra)<BR>Asigna(Info.SeProduce, PlanArtFlujoM:Material.SeProduce)<BR>Asigna(Ver.Semana, PlanArtFlujoM:PlanArtFlujo.MaterialPeriodo)

[Acciones.PersonalizarM]
Nombre=PersonalizarM
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Materiales
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.PersonalizarP]
Nombre=PersonalizarP
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.PlanMM]
Nombre=PlanMM
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+M
NombreDesplegar=Plan &Material
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanArtAlm
Antes=S
Visible=S
ActivoCondicion=ConDatos(PlanArtFlujoM:PlanArtFlujo.Material)
AntesExpresiones=Asigna(Info.Articulo, PlanArtFlujoM:PlanArtFlujo.Material)<BR>Asigna(Info.Descripcion, PlanArtFlujoM:Material.Descripcion1)<BR>Asigna(Info.ArtTipoOpcion, PlanArtFlujoM:Material.TipoOpcion)<BR>Asigna(Info.Almacen, PlanArtFlujoM:PlanArtFlujo.MaterialAlmacen)

[Acciones.PlanPP]
Nombre=PlanPP
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Plan Producto
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanArtAlm
Antes=S
Visible=S
ActivoCondicion=ConDatos(PlanArtFlujoP:PlanArtFlujo.Producto)
AntesExpresiones=Asigna(Info.Articulo, PlanArtFlujoP:PlanArtFlujo.Producto)<BR>Asigna(Info.Descripcion, PlanArtFlujoP:Art.Descripcion1)<BR>Asigna(Info.ArtTipoOpcion, PlanArtFlujoP:Art.TipoOpcion)<BR>Asigna(Info.Almacen, PlanArtFlujoP:PlanArtFlujo.ProductoAlmacen)

[Acciones.IrProducto]
Nombre=IrProducto
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Avanzar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S
ActivoCondicion=ConDatos(PlanArtFlujoP:PlanArtFlujo.Producto)
AntesExpresiones=Asigna(Ver.Articulo, PlanArtFlujoP:PlanArtFlujo.Producto)<BR>Asigna(Ver.Almacen, PlanArtFlujoP:PlanArtFlujo.ProductoAlmacen)<BR>Asigna(Ver.Descripcion, PlanArtFlujoP:Art.Descripcion1)<BR>Asigna(Info.SeVende, PlanArtFlujoP:Art.SeVende)<BR>Asigna(Info.SeCompra, PlanArtFlujoP:Art.SeCompra)<BR>Asigna(Info.SeProduce, PlanArtFlujoP:Art.SeProduce)<BR>Asigna(Ver.Semana, PlanArtFlujoP:PlanArtFlujo.ProductoPeriodo)

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Ver.Articulo)

[Acciones.Plan]
Nombre=Plan
Boton=88
NombreEnBoton=S
NombreDesplegar=&Plan
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanArtAlm
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo, Ver.Articulo)<BR>Asigna(Info.Descripcion, Ver.Descripcion)<BR>Asigna(Info.Almacen, Ver.Almacen)<BR>Asigna(Info.ArtTipoOpcion, Ver.ArtTipoOpcion)

[Acciones.Retroceder]
Nombre=Retroceder
Boton=24
NombreDesplegar=Retroceder
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(PlanArtFlujoM:PlanArtFlujo.Material)
AntesExpresiones=Asigna(Ver.Articulo, PlanArtFlujoM:PlanArtFlujo.Material)<BR>Asigna(Ver.Almacen, PlanArtFlujoM:PlanArtFlujo.MaterialAlmacen)<BR>Asigna(Ver.Descripcion, PlanArtFlujoM:Material.Descripcion1)<BR>Asigna(Info.SeVende, PlanArtFlujoM:Material.SeVende)<BR>Asigna(Info.SeCompra, PlanArtFlujoM:Material.SeCompra)<BR>Asigna(Info.SeProduce, PlanArtFlujoM:Material.SeProduce)<BR>Asigna(Ver.Semana, PlanArtFlujoM:PlanArtFlujo.MaterialPeriodo)

[Acciones.Avanzar]
Nombre=Avanzar
Boton=25
NombreDesplegar=Avanzar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(PlanArtFlujoP:PlanArtFlujo.Producto)
AntesExpresiones=Asigna(Ver.Articulo, PlanArtFlujoP:PlanArtFlujo.Producto)<BR>Asigna(Ver.Almacen, PlanArtFlujoP:PlanArtFlujo.ProductoAlmacen)<BR>Asigna(Ver.Descripcion, PlanArtFlujoP:Art.Descripcion1)<BR>Asigna(Info.SeVende, PlanArtFlujoP:Art.SeVende)<BR>Asigna(Info.SeCompra, PlanArtFlujoP:Art.SeCompra)<BR>Asigna(Info.SeProduce, PlanArtFlujoP:Art.SeProduce)<BR>Asigna(Ver.Semana, PlanArtFlujoP:PlanArtFlujo.ProductoPeriodo)

[Acciones.porRecibir]
Nombre=porRecibir
Boton=59
NombreDesplegar=por &Recibir
EnBarraHerramientas=S
TipoAccion=Expresion
Antes=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S
Expresion=Si<BR>  Info.SeCompra y Info.SeProduce<BR>Entonces<BR>  Dialogo(<T>porRecibir<T>)<BR>Sino<BR>  Si(Info.SeCompra, Forma(<T>ArtCompraPendiente<T>))<BR>  Si(Info.SeProduce, Forma(<T>ArtProdPendiente<T>))<BR>Fin
ActivoCondicion=Info.SeCompra o Info.SeProduce
AntesExpresiones=Asigna(Info.Articulo, Ver.Articulo)

[Acciones.porSurtir]
Nombre=porSurtir
Boton=58
NombreDesplegar=por &Surtir
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtVentaPendiente
Visible=S
Antes=S
NombreEnBoton=S
ActivoCondicion=Info.SeVende
AntesExpresiones=Asigna(Info.Articulo, Ver.Articulo)

[Productos.PlanArtFlujo.MaterialPeriodo]
Carpeta=Productos
Clave=PlanArtFlujo.MaterialPeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Productos
Productos=Materiales
Materiales=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Retroceder
Retroceder=Avanzar
Avanzar=ArtInfo
ArtInfo=Plan
Plan=porRecibir
porRecibir=porSurtir
porSurtir=(Fin)

[Materiales.ListaEnCaptura]
(Inicio)=Material.Descripcion1
Material.Descripcion1=PlanArtFlujo.MaterialAlmacen
PlanArtFlujo.MaterialAlmacen=PlanArtFlujo.MaterialCantidad
PlanArtFlujo.MaterialCantidad=(Fin)

[Materiales.ListaAcciones]
(Inicio)=IrMaterial
IrMaterial=PlanMM
PlanMM=PersonalizarM
PersonalizarM=(Fin)

[Materiales.ListaOrden]
(Inicio)=PlanArtFlujo.ProductoPeriodo<TAB>(Acendente)
PlanArtFlujo.ProductoPeriodo<TAB>(Acendente)=PlanArtFlujo.Producto<TAB>(Acendente)
PlanArtFlujo.Producto<TAB>(Acendente)=PlanArtFlujo.MaterialPeriodo<TAB>(Acendente)
PlanArtFlujo.MaterialPeriodo<TAB>(Acendente)=PlanArtFlujo.Material<TAB>(Acendente)
PlanArtFlujo.Material<TAB>(Acendente)=(Fin)

[Productos.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=PlanArtFlujo.ProductoAlmacen
PlanArtFlujo.ProductoAlmacen=PlanArtFlujo.ProductoCantidad
PlanArtFlujo.ProductoCantidad=PlanArtFlujo.MaterialPeriodo
PlanArtFlujo.MaterialPeriodo=(Fin)

[Productos.ListaAcciones]
(Inicio)=IrProducto
IrProducto=PlanPP
PlanPP=PersonalizarP
PersonalizarP=(Fin)

[Productos.ListaOrden]
(Inicio)=PlanArtFlujo.MaterialPeriodo<TAB>(Acendente)
PlanArtFlujo.MaterialPeriodo<TAB>(Acendente)=PlanArtFlujo.Material<TAB>(Acendente)
PlanArtFlujo.Material<TAB>(Acendente)=PlanArtFlujo.ProductoPeriodo<TAB>(Acendente)
PlanArtFlujo.ProductoPeriodo<TAB>(Acendente)=PlanArtFlujo.Producto<TAB>(Acendente)
PlanArtFlujo.Producto<TAB>(Acendente)=(Fin)
