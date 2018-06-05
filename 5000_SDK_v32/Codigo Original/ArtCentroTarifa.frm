[Forma]
Clave=ArtCentroTarifa
Nombre=Tarifas Maquila
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion)
PosicionInicialIzquierda=242
PosicionInicialArriba=159
PosicionInicialAlturaCliente=415
PosicionInicialAncho=518
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CentroTarifa
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=$00808040
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
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroGeneral=CentroTarifa.Articulo=<T>{Info.Articulo}<T>

[Lista.CentroTarifa.Centro]
Carpeta=Lista
Clave=CentroTarifa.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CentroTarifa.Costo]
Carpeta=Lista
Clave=CentroTarifa.Costo
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
Centro=140
Descripcion=244
Costo=125
SubCuenta=124

[Lista.CentroTarifa.SubCuenta]
Carpeta=Lista
Clave=CentroTarifa.SubCuenta
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
NombreDesplegar=Cambiar Vista Hoja (Normal-Detalle)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CambiarVista
CambiarVista=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CentroTarifa.Centro
CentroTarifa.Centro=CentroTarifa.SubCuenta
CentroTarifa.SubCuenta=CentroTarifa.Costo
CentroTarifa.Costo=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Centro.Descripcion
Centro.Descripcion=OpcionDesc
OpcionDesc=(Fin)
