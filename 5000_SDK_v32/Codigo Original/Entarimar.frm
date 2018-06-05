[Forma]
Clave=Entarimar
Nombre=Asistente para Entarimar
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Mov
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=586
PosicionInicialArriba=248
PosicionInicialAlturaCliente=669
PosicionInicialAncho=747
PosicionCol1=476
PosicionSec1=302
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaSiempreAlFrente=S
VentanaExclusiva=S

ExpresionesAlMostrar=EjecutarSQL(<T>spEntarimar :nEstacion, :tEmpresa, :tModulo, :nModuloID, :tMov, :tMovID, :tAccion<T>, EstacionTrabajo, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, <T>SUGERIR<T>)<BR>Asigna(Info.Tarima, Nulo)
[Mov]
Estilo=Hoja
Clave=Mov
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EntarimarMov
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimiento
ValidarCampos=S
ListaCamposAValidar=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
HojaFondoGris=S
MenuLocal=S
ListaAcciones=MovCopiar
FiltroPredefinido1=por Renglon<BR>por Artículo<BR>por Tarima
FiltroPredefinido2=1=1<BR>1=1<BR>1=1
FiltroPredefinido3=Renglon, RenglonSub<BR>Articulo, SubCuenta<BR>Tarima, Articulo, SubCuenta
FiltroEstilo=Directorio

FiltroGeneral=EntarimarMov.Estacion={EstacionTrabajo} AND NULLIF(EntarimarMov.Cantidad, 0.0) IS NOT NULL
[Mov.EntarimarMov.Almacen]
Carpeta=Mov
Clave=EntarimarMov.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Mov.EntarimarMov.Tarima]
Carpeta=Mov
Clave=EntarimarMov.Tarima
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mov.EntarimarMov.Articulo]
Carpeta=Mov
Clave=EntarimarMov.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mov.EntarimarMov.SubCuenta]
Carpeta=Mov
Clave=EntarimarMov.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Mov.EntarimarMov.Cantidad]
Carpeta=Mov
Clave=EntarimarMov.Cantidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Mov.EntarimarMov.Unidad]
Carpeta=Mov
Clave=EntarimarMov.Unidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Mov.EntarimarMov.CantidadA]
Carpeta=Mov
Clave=EntarimarMov.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
DespuesGuardar=S

AntesExpresiones=EjecutarSQL(<T>spEntarimar :nEstacion, :tEmpresa, :tModulo, :nModuloID, :tMov, :tMovID, :tAccion<T>, EstacionTrabajo, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, <T>ACEPTAR<T>)
[Mov.Columnas]
Almacen=91
Tarima=124
Articulo=123
SubCuenta=111
Cantidad=60
Unidad=99
CantidadA=69

[Tarimas]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Tarimas
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=EntarimarTarima
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
FiltroAutoCampo=EntarimarTarima.Tarima
FiltroAutoValidar=EntarimarTarima.Tarima
FiltroAutoOrden=EntarimarTarima.Tarima
IconosSubTitulo=<T>Articulo<T>
FiltroAplicaEn=EntarimarTarima.Tarima
FiltroGrupo1=EntarimarTarima.Tarima
FiltroValida1=EntarimarTarima.Tarima
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=EntarimarTarima.ID<TAB>(Acendente)
FiltroTodo=S
IconosNombre=EntarimarTarima:EntarimarTarima.Articulo
FiltroGeneral=EntarimarTarima.Estacion={EstacionTrabajo}

[Tarimas.EntarimarTarima.Cantidad]
Carpeta=Tarimas
Clave=EntarimarTarima.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Tarimas.EntarimarTarima.Unidad]
Carpeta=Tarimas
Clave=EntarimarTarima.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Tarimas.Columnas]
Almacen=90
Tarima=125
Articulo=124
SubCuenta=112
Cantidad=79
Unidad=98
0=133
1=215

2=-2
3=-2
4=-2
[Acciones.Entarimar]
Nombre=Entarimar
Boton=27
NombreEnBoton=S
NombreDesplegar=En&tarimar Selección
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=Asigna(Info.Almacen, EntarimarMov:EntarimarMov.Almacen)<BR>Si<BR>  Forma(<T>EspecificarTarima<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spEntarimar :nEstacion, :tEmpresa, :tModulo, :nModuloID, :tMov, :tMovID, :tAccion, @Tarima=:tTarima<T>, EstacionTrabajo, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, <T>ENTARIMAR<T>, Info.Tarima)<BR>  Forma.ActualizarVista(<T>Mov<T>)<BR>  Forma.ActualizarArbol(<T>Tarimas<T>)<BR>  Forma.ActualizarVista(<T>Tarimas<T>)<BR>Fin

[Acciones.TarimasPersonalizar]
Nombre=TarimasPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=Tarimas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

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

[Acciones.MovCopiar]
Nombre=MovCopiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Copiar
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(EntarimarMov:EntarimarMov.CantidadA, EntarimarMov:EntarimarMov.Cantidad)
Activo=S
Visible=S

[Tarimas.Art.Descripcion1]
Carpeta=Tarimas
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Tarimas.EntarimarTarima.Tarima]
Carpeta=Tarimas
Clave=EntarimarTarima.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TarimasEliminar]
Nombre=TarimasEliminar
Boton=0
NombreDesplegar=&Eliminar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=EjecutarSQL(<T>spEntarimar :nEstacion, :tEmpresa, :tModulo, :nModuloID, :tMov, :tMovID, :tAccion, @ID=:nID<T>, EstacionTrabajo, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, <T>ELIMINAR<T>, EntarimarTarima:EntarimarTarima.ID)<BR>Forma.ActualizarVista(<T>Tarimas<T>)<BR>Forma.ActualizarVista(<T>Mov<T>)
EjecucionCondicion=ConDatos(EntarimarTarima:EntarimarTarima.ID)

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=54
NombreDesplegar=&Seleccionar Todo
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
Expresion=EjecutarSQL(<T>spEntarimar :nEstacion, :tEmpresa, :tModulo, :nModuloID, :tMov, :tMovID, :tAccion<T>, EstacionTrabajo, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, <T>SELECCIONAR/TODO<T>)<BR>Forma.ActualizarVista(<T>Mov<T>)

[Acciones.Detalles]
Nombre=Detalles
Boton=18
NombreEnBoton=S
NombreDesplegar=&Detalles
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Antes=S
Expresion=Si<BR>  Forma(<T>EntarimarMovSerieLote<T>)<BR>Entonces<BR>  Asigna(EntarimarMov:EntarimarMov.CantidadA, SQL(<T>SELECT SUM(CantidadA) FROM EntarimarMovSerieLote WHERE Estacion=:nEstacion AND RenglonID=:nRenglonID AND Articulo=:tArticulo AND SubCuenta=<T>+Comillas(Info.SubCuenta), EstacionTrabajo, Info.RenglonID, Info.Articulo))<BR>Fin
AntesExpresiones=Asigna(Info.RenglonID, EntarimarMov:EntarimarMov.RenglonID)<BR>Asigna(Info.Articulo, EntarimarMov:EntarimarMov.Articulo)<BR>Asigna(Info.SubCuenta, EntarimarMov:EntarimarMov.SubCuenta)





[Tarimas.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=EntarimarTarima.Cantidad
EntarimarTarima.Cantidad=EntarimarTarima.Unidad
EntarimarTarima.Unidad=EntarimarTarima.Tarima
EntarimarTarima.Tarima=(Fin)

[Tarimas.ListaAcciones]
(Inicio)=TarimasEliminar
TarimasEliminar=TarimasPersonalizar
TarimasPersonalizar=(Fin)









[Mov.ListaEnCaptura]
(Inicio)=EntarimarMov.Articulo
EntarimarMov.Articulo=EntarimarMov.SubCuenta
EntarimarMov.SubCuenta=EntarimarMov.Almacen
EntarimarMov.Almacen=EntarimarMov.Tarima
EntarimarMov.Tarima=EntarimarMov.Cantidad
EntarimarMov.Cantidad=EntarimarMov.Unidad
EntarimarMov.Unidad=EntarimarMov.CantidadA
EntarimarMov.CantidadA=(Fin)

[Mov.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=(Fin)













[Forma.ListaCarpetas]
(Inicio)=Mov
Mov=Tarimas
Tarimas=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Todo
Todo=Entarimar
Entarimar=Detalles
Detalles=CambiarVista
CambiarVista=(Fin)
