
[Forma]
Clave=SurtirTarima
Icono=0
Modulos=(All)
Nombre=Surtir por Tarima

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=627
PosicionInicialArriba=409
PosicionInicialAlturaCliente=348
PosicionInicialAncho=665
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID, Info.Almacen)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaExclusiva=S
ExpresionesAlMostrar=EjecutarSQL(<T>spSurtirTarima :nEstacion, :tEmpresa, :tModulo, :nModuloID, :tMov, :tMovID, :tAccion<T>, EstacionTrabajo, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, <T>SUGERIR<T>)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SurtirTarimaMov
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=SurtirTarimaMov.Estacion={EstacionTrabajo}
[Lista.SurtirTarimaMov.Tarima]
Carpeta=Lista
Clave=SurtirTarimaMov.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SurtirTarimaMov.Articulo]
Carpeta=Lista
Clave=SurtirTarimaMov.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SurtirTarimaMov.SubCuenta]
Carpeta=Lista
Clave=SurtirTarimaMov.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SurtirTarimaMov.Cantidad]
Carpeta=Lista
Clave=SurtirTarimaMov.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SurtirTarimaMov.Unidad]
Carpeta=Lista
Clave=SurtirTarimaMov.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tarima=124
Articulo=118
SubCuenta=90
Cantidad=51
Unidad=61

Descripcion1=184
0=79
1=427
2=-2
Posicion=64
Descripcion=144
Zona=75
Pasillo=34
Fila=31
Nivel=30
Tipo=67
Capacidad=103
Estatus=57
ArticuloEsp=98
Almacen=64
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
AntesExpresiones=Forma.ActualizarVista(<T>Lista<T>) <BR>EjecutarSQL(<T>spSurtirTarima :nEstacion, :tEmpresa, :tModulo, :nModuloID, :tMov, :tMovID, :tAccion<T>, EstacionTrabajo, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, <T>ACEPTAR<T>)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S













[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris






[Lista.SurtirTarimaMov.Posicion]
Carpeta=Lista
Clave=SurtirTarimaMov.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro




























































[Lista.ListaEnCaptura]
(Inicio)=SurtirTarimaMov.Posicion
SurtirTarimaMov.Posicion=SurtirTarimaMov.Tarima
SurtirTarimaMov.Tarima=SurtirTarimaMov.Articulo
SurtirTarimaMov.Articulo=Art.Descripcion1
Art.Descripcion1=SurtirTarimaMov.SubCuenta
SurtirTarimaMov.SubCuenta=SurtirTarimaMov.Cantidad
SurtirTarimaMov.Cantidad=SurtirTarimaMov.Unidad
SurtirTarimaMov.Unidad=(Fin)
















[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Guardar Cambios
Guardar Cambios=Expresion
Expresion=Actualizar Forma
Actualizar Forma=Aceptar
Aceptar=(Fin)

























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=CambiarVista
CambiarVista=(Fin)
