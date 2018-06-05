
[Forma]
Clave=ActivoFIndicador
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Indicadores
CarpetaPrincipal=Indicadores
PosicionInicialAlturaCliente=188
PosicionInicialAncho=402
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=519
PosicionInicialArriba=342
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo)
Nombre=Indicadores
[Indicadores]
Estilo=Hoja
Clave=Indicadores
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFIndicador
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S



HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
FiltroGeneral=ActivoFIndicador.ActivoFID = {Info.ID}
[Indicadores.ActivoFIndicador.Indicador]
Carpeta=Indicadores
Clave=ActivoFIndicador.Indicador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Indicadores.ActivoFIndicador.Referencia]
Carpeta=Indicadores
Clave=ActivoFIndicador.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Indicadores.ActivoFIndicador.Lectura]
Carpeta=Indicadores
Clave=ActivoFIndicador.Lectura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro










[Indicadores.Columnas]
Indicador=150
Referencia=131
Lectura=90

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Indicadores.ListaEnCaptura]
(Inicio)=ActivoFIndicador.Indicador
ActivoFIndicador.Indicador=ActivoFIndicador.Referencia
ActivoFIndicador.Referencia=ActivoFIndicador.Lectura
ActivoFIndicador.Lectura=(Fin)

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=EJECUTARSQL(<T>EXEC spMAFPermiteEliminarActivoFTipoIndicador NULL, :nActivoFID, :tIndicador, :tDependeDe, :tModo<T>,ActivoFIndicador:ActivoFIndicador.ActivoFID,ActivoFIndicador:ActivoFIndicador.Indicador,<T>ActivoF<T>,<T>Eliminar<T>)<BR>ActualizarVista
ActivoCondicion=SI(SQL(<T>EXEC spMAFPermiteEliminarActivoFTipoIndicador NULL, :nActivoFID, :tIndicador, :tDependeDe, :tModo<T>,ActivoFIndicador:ActivoFIndicador.ActivoFID,ActivoFIndicador:ActivoFIndicador.Indicador,<T>ActivoF<T>,<T>Preguntar<T>) = 1,Verdadero,Falso)
Visible=S



[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Eliminar
Eliminar=(Fin)
