[Forma]
Clave=ArtMaterialHistD
Nombre=<T>Lista Materiales - <T>+Info.Articulo
Icono=6
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion, Info.ArtTipo, Info.Unidad)
PosicionInicialIzquierda=268
PosicionInicialArriba=277
PosicionInicialAltura=469
PosicionInicialAncho=744
PosicionSeccion1=90
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionColumna1=84
Menus=S
PosicionInicialAlturaCliente=442
EsConsultaExclusiva=S
MenuPrincipal=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtMaterialHistD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaNombre=Materiales
HojaAjustarColumnas=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
PestanaOtroNombre=S
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=ArtMaterialHistD.ID={Info.ID}

[Lista.ArtMaterialHistD.Material]
Carpeta=Lista
Clave=ArtMaterialHistD.Material
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtMaterialHistD.SubCuenta]
Carpeta=Lista
Clave=ArtMaterialHistD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.ArtMaterialHistD.Cantidad]
Carpeta=Lista
Clave=ArtMaterialHistD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.ArtMaterialHistD.Unidad]
Carpeta=Lista
Clave=ArtMaterialHistD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtMaterialHistD.Merma]
Carpeta=Lista
Clave=ArtMaterialHistD.Merma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S
NombreEnBoton=S
UsaTeclaRapida=S
TeclaRapida=Alt+F4

[Lista.Columnas]
Material=112
SubCuenta=92
Cantidad=48
Unidad=51
Merma=37
Orden=34
Descripcion1=130
SiOpcion=91
Almacen=77
Explotar=48
Paso=31
CentroTipo=79
Desperdicio=59
Potencia=58
CostoAcumulado=89
Factor=36
Concentracion=60
Descripción=124
Porcentaje=35
Volumen=45

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[Estructura.Columnas]
Estructura=162
Orden=40
Descripcion=289
Categoria=149
Articulo=124

[Formulas.ArtFormula.Formula]
Carpeta=Formulas
Clave=ArtFormula.Formula
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Formulas.Formula.Descripcion]
Carpeta=Formulas
Clave=Formula.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Formulas.Formula.Categoria]
Carpeta=Formulas
Clave=Formula.Categoria
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Formulas.ArtFormula.Orden]
Carpeta=Formulas
Clave=ArtFormula.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Formulas.Columnas]
Formula=144
Descripcion=291
Categoria=168
Orden=38

[Formulas.Estructura.Descripcion]
Carpeta=Formulas
Clave=Estructura.Descripcion
ColorFuente=Plata

[Formulas.Estructura.Categoria]
Carpeta=Formulas
Clave=Estructura.Categoria
ColorFuente=Plata

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ArtProd
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaNombre=Producto
FiltroGeneral=Art.Articulo=<T>{Info.Articulo}<T>

[Lista.ArtMaterialHistD.SiOpcion]
Carpeta=Lista
Clave=ArtMaterialHistD.SiOpcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.ProdCantidad]
Carpeta=Ficha
Clave=Art.ProdCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10
Efectos=[Negritas]

[Estaciones.Columnas]
Estacion=92
Descripcion=195
Orden=47
Tipo=121
Paso=31
EstandarPreparacion=105
EstandarElaboracion=102

[Situaciones.ArtMaterialHistDSituacion.Paso]
Carpeta=Situaciones
Clave=ArtMaterialHistDSituacion.Paso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Situaciones.ArtMaterialHistDSituacion.Situacion]
Carpeta=Situaciones
Clave=ArtMaterialHistDSituacion.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Situaciones.Columnas]
Paso=32
Situacion=294

[Otros.Art.ProdUsuario]
Carpeta=Otros
Clave=Art.ProdUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ruta.ArtRutaAlterna.Orden]
Carpeta=Ruta
Clave=ArtRutaAlterna.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ruta.Columnas]
Descripcion=169
Estacion=86
Tipo=202
Orden=38
Operacion=148
TiempoPreparacion=101
TiempoEjecucion=93
Costo=76
Moneda=56
Unidad=48
Centro=76
UnidadT=48

[Ruta.ArtRutaAlterna.Operacion]
Carpeta=Ruta
Clave=ArtRutaAlterna.Operacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Ruta.ArtRutaAlterna.TiempoPreparacion]
Carpeta=Ruta
Clave=ArtRutaAlterna.TiempoPreparacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ruta.ArtRutaAlterna.TiempoEjecucion]
Carpeta=Ruta
Clave=ArtRutaAlterna.TiempoEjecucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Otros.Art.ProdMovGrupo]
Carpeta=Otros
Clave=Art.ProdMovGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ruta.ArtRutaAlterna.Costo]
Carpeta=Ruta
Clave=ArtRutaAlterna.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ruta.ArtRutaAlterna.Moneda]
Carpeta=Ruta
Clave=ArtRutaAlterna.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ruta.ArtRutaAlterna.Centro]
Carpeta=Ruta
Clave=ArtRutaAlterna.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ruta.ArtRutaAlterna.UnidadT]
Carpeta=Ruta
Clave=ArtRutaAlterna.UnidadT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.ProdOpciones]
Carpeta=Ficha
Clave=Art.ProdOpciones
Editar=S
LineaNueva=N
3D=S
EspacioPrevio=N
Tamano=58
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Rutas.Columnas]
Orden=46
Ruta=152
Descripcion=226
Categoria=214

[RutaAlternas.ArtRutaAlterna.Ruta]
Carpeta=RutaAlternas
Clave=ArtRutaAlterna.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RutaAlternas.ProdRuta.Descripcion]
Carpeta=RutaAlternas
Clave=ProdRuta.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[RutaAlternas.ProdRuta.Categoria]
Carpeta=RutaAlternas
Clave=ProdRuta.Categoria
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[RutaAlternas.ArtRutaAlterna.Orden]
Carpeta=RutaAlternas
Clave=ArtRutaAlterna.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[RutaAlternas.Columnas]
Ruta=124
Descripcion=216
Categoria=164
Orden=38

[Lista.ArtMaterialHistD.CentroTipo]
Carpeta=Lista
Clave=ArtMaterialHistD.CentroTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtMaterialHistD.Desperdicio]
Carpeta=Lista
Clave=ArtMaterialHistD.Desperdicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtMaterialHistD.Orden]
Carpeta=Lista
Clave=ArtMaterialHistD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtMaterialHistD.CostoAcumulado]
Carpeta=Lista
Clave=ArtMaterialHistD.CostoAcumulado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.ProdVerCostoAcumulado]
Carpeta=Ficha
Clave=Art.ProdVerCostoAcumulado
Editar=S
LineaNueva=N
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Acciones.Opciones]
Nombre=Opciones
Boton=8
Menu=&Ver
NombreDesplegar=&Opciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=OpcionInfo
Activo=S
Visible=S
NombreEnBoton=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
EspacioPrevio=S

[Lista.ArtMaterialHistD.Almacen]
Carpeta=Lista
Clave=ArtMaterialHistD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Descripción]
Carpeta=Lista
Clave=Descripción
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Agregar.Copiar]
Nombre=Copiar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spArtMaterialHistDAgregar :tOrigen, :tDestino<T>, Info.ArticuloD, Info.Articulo)

[Acciones.Agregar.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Ficha.Art.ProdVerPorcentaje]
Carpeta=Ficha
Clave=Art.ProdVerPorcentaje
Editar=S
3D=S
Tamano=4
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtMaterialHistD.Porcentaje]
Carpeta=Lista
Clave=ArtMaterialHistD.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtMaterialHistD.Volumen]
Carpeta=Lista
Clave=ArtMaterialHistD.Volumen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información Material
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(ArtMaterialHistD:ArtMaterialHistD.Material)
AntesExpresiones=Asigna(Info.Articulo, ArtMaterialHistD:ArtMaterialHistD.Material)

[Acciones.Desglose]
Nombre=Desglose
Boton=47
NombreEnBoton=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Desglose
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Antes=S
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Si<BR> Info.ArtTipo en (TipoSerie, TipoVIN, TipoLote) y Config.SeriesLotesMayoreo<BR>Entonces<BR>  Forma(<T>ArtAlmDesgloseSerieLote<T>)<BR>Sino<BR>  Si(Info.ArtTipo=TipoPartida,Forma(<T>ArtAlmDesglosePartida<T>),Forma(<T>ArtAlmDesglose<T>))<BR>Fin
EjecucionCondicion=ConDatos(ArtMaterialHistD:ArtMaterialHistD.Material) y (ConDatos(ArtMaterialHistD:ArtMaterialHistD.Material) y (ArtMaterialHistD:Art.Tipo noen (TipoNormal,TipoServicio)) o (ArtMaterialHistD:Art.TipoOpcion<>TipoNo))
AntesExpresiones=Asigna(Info.Articulo, ArtMaterialHistD:ArtMaterialHistD.Material)<BR>Asigna(Info.Almacen, ArtMaterialHistD:ArtMaterialHistD.Almacen)<BR>Asigna(Info.ArtTipo, ArtMaterialHistD:Art.Tipo)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CambiarVista
CambiarVista=Opciones
Opciones=ArtInfo
ArtInfo=Desglose
Desglose=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtMaterialHistD.SiOpcion
ArtMaterialHistD.SiOpcion=Descripción
Descripción=ArtMaterialHistD.Material
ArtMaterialHistD.Material=ArtMaterialHistD.SubCuenta
ArtMaterialHistD.SubCuenta=ArtMaterialHistD.Cantidad
ArtMaterialHistD.Cantidad=ArtMaterialHistD.Unidad
ArtMaterialHistD.Unidad=ArtMaterialHistD.Volumen
ArtMaterialHistD.Volumen=ArtMaterialHistD.Merma
ArtMaterialHistD.Merma=ArtMaterialHistD.Desperdicio
ArtMaterialHistD.Desperdicio=ArtMaterialHistD.Almacen
ArtMaterialHistD.Almacen=ArtMaterialHistD.CentroTipo
ArtMaterialHistD.CentroTipo=ArtMaterialHistD.Orden
ArtMaterialHistD.Orden=ArtMaterialHistD.CostoAcumulado
ArtMaterialHistD.CostoAcumulado=ArtMaterialHistD.Porcentaje
ArtMaterialHistD.Porcentaje=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.Tipo
Art.Tipo=Art.TipoOpcion
Art.TipoOpcion=(Fin)

[Lista.ListaOrden]
(Inicio)=ArtMaterialHistD.Orden<TAB>(Acendente)
ArtMaterialHistD.Orden<TAB>(Acendente)=ArtMaterialHistD.OrdenID<TAB>(Acendente)
ArtMaterialHistD.OrdenID<TAB>(Acendente)=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Art.ProdCantidad
Art.ProdCantidad=Art.ProdOpciones
Art.ProdOpciones=Art.ProdVerCostoAcumulado
Art.ProdVerCostoAcumulado=Art.ProdVerPorcentaje
Art.ProdVerPorcentaje=(Fin)
