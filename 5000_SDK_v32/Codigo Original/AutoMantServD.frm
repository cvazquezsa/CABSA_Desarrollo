[Forma]
Clave=AutoMantServD
Nombre=Artículos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=192
PosicionInicialArriba=181
PosicionInicialAlturaCliente=371
PosicionInicialAncho=639
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Mantenimiento, Info.Tipo, Info.Servicio)

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
Vista=AutoMantServD
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
ListaCamposAValidar=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=AutoMantServD.Mantenimiento=<T>{Info.Mantenimiento}<T> AND<BR>AutoMantServD.Servicio=<T>{Info.Servicio}<T>

[Lista.AutoMantServD.Articulo]
Carpeta=Lista
Clave=AutoMantServD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoMantServD.SubCuenta]
Carpeta=Lista
Clave=AutoMantServD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.AutoMantServD.Cantidad]
Carpeta=Lista
Clave=AutoMantServD.Cantidad
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
Articulo=124
SubCuenta=124
Cantidad=47

[Lista.ListaEnCaptura]
(Inicio)=AutoMantServD.Articulo
AutoMantServD.Articulo=AutoMantServD.SubCuenta
AutoMantServD.SubCuenta=AutoMantServD.Cantidad
AutoMantServD.Cantidad=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Tipo
Art.Tipo=Art.TipoOpcion
Art.TipoOpcion=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=(Fin)
