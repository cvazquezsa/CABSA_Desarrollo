[Forma]
Clave=ServicioTipoPlantilla
Nombre=Plantilla
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=214
PosicionInicialArriba=196
PosicionInicialAlturaCliente=341
PosicionInicialAncho=595
Comentarios=Info.Tipo
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioTipoPlantilla
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=ServicioTipoPlantilla.Orden<TAB>(Acendente)
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroGeneral=ServicioTipoPlantilla.Tipo=<T>{Info.Tipo}<T>

[Lista.ServicioTipoPlantilla.Articulo]
Carpeta=Lista
Clave=ServicioTipoPlantilla.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=

[Lista.ServicioTipoPlantilla.Cantidad]
Carpeta=Lista
Clave=ServicioTipoPlantilla.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Articulo=137
Cantidad=52
Descripcion1=212
Grupo=122
Localidad=90
Nombre=148
SubCuenta=134
Almacen=72
ImporteMaximo=108
AlmacenEsp=105
ListaPreciosEsp=134

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
AntesExpresiones=Forma(<T>ServicioTipoPlantillaOrdenar<T>)
DespuesGuardar=S
Visible=S

[Lista.ServicioTipoPlantilla.SubCuenta]
Carpeta=Lista
Clave=ServicioTipoPlantilla.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

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

[Lista.ServicioTipoPlantilla.AlmacenEsp]
Carpeta=Lista
Clave=ServicioTipoPlantilla.AlmacenEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioTipoPlantilla.ListaPreciosEsp]
Carpeta=Lista
Clave=ServicioTipoPlantilla.ListaPreciosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CambiarVista
CambiarVista=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ServicioTipoPlantilla.Articulo
ServicioTipoPlantilla.Articulo=ServicioTipoPlantilla.SubCuenta
ServicioTipoPlantilla.SubCuenta=ServicioTipoPlantilla.Cantidad
ServicioTipoPlantilla.Cantidad=ServicioTipoPlantilla.AlmacenEsp
ServicioTipoPlantilla.AlmacenEsp=ServicioTipoPlantilla.ListaPreciosEsp
ServicioTipoPlantilla.ListaPreciosEsp=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=(Fin)
