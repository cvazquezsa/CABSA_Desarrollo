[Forma]
Clave=AutoCorridaPlantilla
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
PosicionInicialAncho=631
Comentarios=Lista(Info.Corrida, Info.Nombre)
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
Vista=AutoCorridaPlantilla
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=AutoCorridaPlantilla.Orden<TAB>(Acendente)
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroGeneral=AutoCorridaPlantilla.Corrida=<T>{Info.Corrida}<T>

[Lista.AutoCorridaPlantilla.Articulo]
Carpeta=Lista
Clave=AutoCorridaPlantilla.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=

[Lista.AutoCorridaPlantilla.Cantidad]
Carpeta=Lista
Clave=AutoCorridaPlantilla.Cantidad
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
SubCuenta=111
Almacen=99
ImporteMaximo=108

[Lista.AutoCorridaPlantilla.Localidad]
Carpeta=Lista
Clave=AutoCorridaPlantilla.Localidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Forma(<T>AutoCorridaPlantillaOrdenar<T>)
DespuesGuardar=S
Visible=S

[Lista.AutoCorridaPlantilla.SubCuenta]
Carpeta=Lista
Clave=AutoCorridaPlantilla.SubCuenta
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

[Lista.AutoCorridaPlantilla.Almacen]
Carpeta=Lista
Clave=AutoCorridaPlantilla.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoCorridaPlantilla.ImporteMaximo]
Carpeta=Lista
Clave=AutoCorridaPlantilla.ImporteMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CambiarVista
CambiarVista=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AutoCorridaPlantilla.Articulo
AutoCorridaPlantilla.Articulo=AutoCorridaPlantilla.SubCuenta
AutoCorridaPlantilla.SubCuenta=AutoCorridaPlantilla.Cantidad
AutoCorridaPlantilla.Cantidad=AutoCorridaPlantilla.Localidad
AutoCorridaPlantilla.Localidad=AutoCorridaPlantilla.Almacen
AutoCorridaPlantilla.Almacen=AutoCorridaPlantilla.ImporteMaximo
AutoCorridaPlantilla.ImporteMaximo=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=(Fin)
