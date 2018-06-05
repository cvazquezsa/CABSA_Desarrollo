[Forma]
Clave=ServicioMatriz
Nombre=Servicios
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=214
PosicionInicialArriba=289
PosicionInicialAlturaCliente=418
PosicionInicialAncho=852
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Servicio.Vehiculo, Servicio.Modelo, Servicio.Motor, Servicio.Cilindros, Servicio.Transmision, Servicio.Traccion)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioMatriz
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaMantenerSeleccion=S
FiltroGeneral=ServicioMatriz.Vehiculo=<T>{Servicio.Vehiculo}<T> AND<BR>ServicioMatriz.Modelo={Servicio.Modelo} AND<BR>ServicioMatriz.Motor=<T>{Servicio.Motor}<T> AND<BR>ServicioMatriz.Cilindros={Servicio.Cilindros} AND<BR>ServicioMatriz.Transmision=<T>{Servicio.Transmision}<T> AND<BR>ServicioMatriz.Traccion=<T>{Servicio.Traccion}<T>

[Lista.Columnas]
Vehiculo=103
Modelo=59
Motor=44
Cilindros=49
Transmision=92
Traccion=61
Articulo=123
SubCuenta=111
Unidad=47
Cantidad=50
Estatus=55
Descripcion1=202
PrecioEsp=83
ListaPreciosEsp=113
VigenciaD=77
VigenciaA=74
Paquete=46

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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Lista.ServicioMatriz.Articulo]
Carpeta=Lista
Clave=ServicioMatriz.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatriz.SubCuenta]
Carpeta=Lista
Clave=ServicioMatriz.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.ServicioMatriz.Unidad]
Carpeta=Lista
Clave=ServicioMatriz.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatriz.Cantidad]
Carpeta=Lista
Clave=ServicioMatriz.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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

[Lista.ServicioMatriz.PrecioEsp]
Carpeta=Lista
Clave=ServicioMatriz.PrecioEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatriz.ListaPreciosEsp]
Carpeta=Lista
Clave=ServicioMatriz.ListaPreciosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatriz.VigenciaD]
Carpeta=Lista
Clave=ServicioMatriz.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatriz.VigenciaA]
Carpeta=Lista
Clave=ServicioMatriz.VigenciaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatriz.Paquete]
Carpeta=Lista
Clave=ServicioMatriz.Paquete
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=CambiarVista
CambiarVista=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ServicioMatriz.Articulo
ServicioMatriz.Articulo=Art.Descripcion1
Art.Descripcion1=ServicioMatriz.SubCuenta
ServicioMatriz.SubCuenta=ServicioMatriz.Cantidad
ServicioMatriz.Cantidad=ServicioMatriz.Unidad
ServicioMatriz.Unidad=ServicioMatriz.PrecioEsp
ServicioMatriz.PrecioEsp=ServicioMatriz.ListaPreciosEsp
ServicioMatriz.ListaPreciosEsp=ServicioMatriz.VigenciaD
ServicioMatriz.VigenciaD=ServicioMatriz.VigenciaA
ServicioMatriz.VigenciaA=ServicioMatriz.Paquete
ServicioMatriz.Paquete=(Fin)
