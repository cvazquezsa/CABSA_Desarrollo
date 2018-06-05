[Forma]
Clave=ArtMaterial
Nombre=<T>Lista Materiales - <T>+Info.Articulo
Icono=9
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion, Info.ArtTipo, Info.Unidad)
PosicionInicialIzquierda=382
PosicionInicialArriba=171
PosicionInicialAltura=469
PosicionInicialAncho=839
PosicionSeccion1=92
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionColumna1=81
Menus=S
PosicionInicialAlturaCliente=493
Totalizadores=S
PosicionColumna2=75
PosicionSeccion2=91

PosicionSec1=394
PosicionCol1=676
MenuPrincipal=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtMaterial
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

FiltroGeneral=ArtMaterial.Articulo=<T>{Info.Articulo}<T>
[Lista.ArtMaterial.Material]
Carpeta=Lista
Clave=ArtMaterial.Material
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtMaterial.SubCuenta]
Carpeta=Lista
Clave=ArtMaterial.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.ArtMaterial.Cantidad]
Carpeta=Lista
Clave=ArtMaterial.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]

[Lista.ArtMaterial.Unidad]
Carpeta=Lista
Clave=ArtMaterial.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ArtMaterial.Merma]
Carpeta=Lista
Clave=ArtMaterial.Merma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S
NombreEnBoton=S
GuardarAntes=S

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

Centro=64
LugarConsumo=124
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
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ArtProd
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
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
CondicionVisible=(General.Prod) o (No SQL(<T>SELECT SAUX FROM ART WHERE Articulo = :tArticulo<T>,ArtMaterial:ArtMaterial.Articulo))
[Lista.ArtMaterial.SiOpcion]
Carpeta=Lista
Clave=ArtMaterial.SiOpcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.Art.ProdCantidad]
Carpeta=Ficha
Clave=Art.ProdCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20
Efectos=[Negritas]

[Estaciones.Columnas]
Estacion=92
Descripcion=195
Orden=47
Tipo=121
Paso=31
EstandarPreparacion=105
EstandarElaboracion=102

[Situaciones.ArtMaterialSituacion.Paso]
Carpeta=Situaciones
Clave=ArtMaterialSituacion.Paso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Situaciones.ArtMaterialSituacion.Situacion]
Carpeta=Situaciones
Clave=ArtMaterialSituacion.Situacion
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
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
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

[Lista.ArtMaterial.CentroTipo]
Carpeta=Lista
Clave=ArtMaterial.CentroTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ArtMaterial.Desperdicio]
Carpeta=Lista
Clave=ArtMaterial.Desperdicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtMaterial.Orden]
Carpeta=Lista
Clave=ArtMaterial.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtMaterial.CostoAcumulado]
Carpeta=Lista
Clave=ArtMaterial.CostoAcumulado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.Art.ProdVerCostoAcumulado]
Carpeta=Ficha
Clave=Art.ProdVerCostoAcumulado
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
Pegado=N

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Estructura]
Nombre=Estructura
Boton=16
NombreEnBoton=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=&Estructura Producto
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtEstructuraProducto

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

[Lista.ArtMaterial.Almacen]
Carpeta=Lista
Clave=ArtMaterial.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Descripción]
Carpeta=Lista
Clave=Descripción
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.AsistenteOpcionEspecifica]
Nombre=AsistenteOpcionEspecifica
Boton=0
Menu=&Archivo
NombreDesplegar=Asistente (Opción &Especifica)
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=ArtMaterial:ArtMaterial.Material<BR>ArtMaterial:ArtMaterial.Almacen<BR>ArtMaterial:ArtMaterial.SubCuenta<BR>ArtMaterial:ArtMaterial.Cantidad<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>ArtMaterial:Art.Descripcion1<BR>ArtMaterial:Art.Tipo<BR>ArtMaterial:ArtMaterial.Unidad<BR>Nulo<BR>ArtMaterial:Art.TipoOpcion<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo
ListaParametros=S
Activo=S
Visible=S

[Acciones.AsistenteMaterialOpcional]
Nombre=AsistenteMaterialOpcional
Boton=12
Menu=&Archivo
NombreDesplegar=Asistente (&Material Opcional)
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=ArtMaterial:ArtMaterial.Material<BR>ArtMaterial:ArtMaterial.Almacen<BR>ArtMaterial:ArtMaterial.SiOpcion<BR>ArtMaterial:ArtMaterial.Cantidad<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>ArtMaterial:Art.Descripcion1<BR>ArtMaterial:Art.Tipo<BR>ArtMaterial:ArtMaterial.Unidad<BR>Nulo<BR>ArtMaterial:Art.TipoOpcion<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo
ListaParametros=S
Visible=S

ActivoCondicion=ArtProd:Art.ProdOpciones
[Acciones.Agregar]
Nombre=Agregar
Boton=0
Menu=&Archivo
NombreDesplegar=Agregar &Lista Materiales de Otro Artículo...
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=Copiar<BR>Actualizar
Antes=S
AntesExpresiones=Si(no Forma(<T>EspecificarArticuloD<T>), AbortarOperacion)

[Acciones.Agregar.Copiar]
Nombre=Copiar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spArtMaterialAgregar :tOrigen, :tDestino<T>, Info.ArticuloD, Info.Articulo)

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
Tamano=20
ColorFondo=Blanco
LineaNueva=S

[Lista.ArtMaterial.Porcentaje]
Carpeta=Lista
Clave=ArtMaterial.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtMaterial.Volumen]
Carpeta=Lista
Clave=ArtMaterial.Volumen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S
NombreEnBoton=S

EjecucionCondicion=ConDatos(ArtMaterial:ArtMaterial.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtMaterial:ArtMaterial.Material)
[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Cantidad Total
Totalizadores2=Suma(ArtMaterial:ArtMaterial.Cantidad)
Totalizadores3=(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Cantidad Total
CarpetaVisible=S

[(Carpeta Totalizadores).Cantidad Total]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Hist]
Nombre=Hist
Boton=53
Menu=&Archivo
NombreDesplegar=Bitácora
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtMaterialHist
Activo=S
Visible=S
EspacioPrevio=S





[Lista.ArtMaterial.Centro]
Carpeta=Lista
Clave=ArtMaterial.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco














































[Lista.ListaEnCaptura]
(Inicio)=ArtMaterial.SiOpcion
ArtMaterial.SiOpcion=Descripción
Descripción=ArtMaterial.Material
ArtMaterial.Material=ArtMaterial.SubCuenta
ArtMaterial.SubCuenta=ArtMaterial.Cantidad
ArtMaterial.Cantidad=ArtMaterial.Unidad
ArtMaterial.Unidad=ArtMaterial.Volumen
ArtMaterial.Volumen=ArtMaterial.Merma
ArtMaterial.Merma=ArtMaterial.Desperdicio
ArtMaterial.Desperdicio=ArtMaterial.Almacen
ArtMaterial.Almacen=ArtMaterial.CentroTipo
ArtMaterial.CentroTipo=ArtMaterial.Centro
ArtMaterial.Centro=ArtMaterial.Orden
ArtMaterial.Orden=ArtMaterial.CostoAcumulado
ArtMaterial.CostoAcumulado=ArtMaterial.Porcentaje
ArtMaterial.Porcentaje=ArtMaterial.LugarConsumo
ArtMaterial.LugarConsumo=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.Tipo
Art.Tipo=Art.TipoOpcion
Art.TipoOpcion=(Fin)

[Lista.ListaOrden]
(Inicio)=ArtMaterial.Orden	(Acendente)
ArtMaterial.Orden	(Acendente)=ArtMaterial.OrdenID	(Acendente)
ArtMaterial.OrdenID	(Acendente)=(Fin)

[Lista.ArtMaterial.LugarConsumo]
Carpeta=Lista
Clave=ArtMaterial.LugarConsumo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



























[Ficha.ListaEnCaptura]
(Inicio)=Art.ProdCantidad
Art.ProdCantidad=Art.ProdOpciones
Art.ProdOpciones=Art.ProdVerCostoAcumulado
Art.ProdVerCostoAcumulado=Art.ProdVerPorcentaje
Art.ProdVerPorcentaje=(Fin)










[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Hist
Hist=CambiarVista
CambiarVista=Opciones
Opciones=Agregar
Agregar=AsistenteMaterialOpcional
AsistenteMaterialOpcional=AsistenteOpcionEspecifica
AsistenteOpcionEspecifica=ArtInfo
ArtInfo=Estructura
Estructura=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)
