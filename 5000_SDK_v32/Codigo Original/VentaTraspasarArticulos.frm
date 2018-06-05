[Forma]
Clave=VentaTraspasarArticulos
Nombre=Asistente - Traspasar Artículos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=239
PosicionInicialArriba=375
PosicionInicialAlturaCliente=246
PosicionInicialAncho=802
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Comentarios=Lista(Info.Mov, Info.MovID)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaTraspasarArticulos
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
ListaEnCaptura=(Lista)
ListaCamposAValidar=Art.Descripcion1
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
FiltroGeneral=VentaTraspasarArticulos.ID=<T>{Info.ID}<T> AND <BR>VentaTraspasarArticulos.Estacion={EstacionTrabajo}

[Lista.VentaTraspasarArticulos.Codigo]
Carpeta=Lista
Clave=VentaTraspasarArticulos.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaTraspasarArticulos.Articulo]
Carpeta=Lista
Clave=VentaTraspasarArticulos.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaTraspasarArticulos.Cantidad]
Carpeta=Lista
Clave=VentaTraspasarArticulos.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaTraspasarArticulos.Precio]
Carpeta=Lista
Clave=VentaTraspasarArticulos.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaTraspasarArticulos.Costo]
Carpeta=Lista
Clave=VentaTraspasarArticulos.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaTraspasarArticulos.Accion]
Carpeta=Lista
Clave=VentaTraspasarArticulos.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Procesar]
Nombre=Procesar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
RefrescarDespues=S
Multiple=S
DocNuevo=S
ListaAccionesMultiples=Expresion<BR>Cerrar

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

[Lista.Columnas]
Codigo=144
Articulo=124
Cantidad=49
Precio=90
Costo=96
Almacen=102
Accion=89
Referencia=176

[Acciones.Procesar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>xpVentaTraspasarArticulosProcesar :nID, :nEstacion, :tUsuario, :fFecha<T>, Info.ID,  EstacionTrabajo,  Usuario,  FechaTrabajo)
Activo=S
Visible=S

[Acciones.Procesar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.VentaTraspasarArticulos.Referencia]
Carpeta=Lista
Clave=VentaTraspasarArticulos.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Procesar
Procesar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaTraspasarArticulos.Accion
VentaTraspasarArticulos.Accion=VentaTraspasarArticulos.Codigo
VentaTraspasarArticulos.Codigo=VentaTraspasarArticulos.Articulo
VentaTraspasarArticulos.Articulo=VentaTraspasarArticulos.Cantidad
VentaTraspasarArticulos.Cantidad=VentaTraspasarArticulos.Precio
VentaTraspasarArticulos.Precio=VentaTraspasarArticulos.Costo
VentaTraspasarArticulos.Costo=VentaTraspasarArticulos.Referencia
VentaTraspasarArticulos.Referencia=(Fin)
