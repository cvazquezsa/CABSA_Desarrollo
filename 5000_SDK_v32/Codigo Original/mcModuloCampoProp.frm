[Forma]
Clave=mcModuloCampoProp
Nombre=Catálogo del Campo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Campo
PosicionInicialIzquierda=644
PosicionInicialArriba=393
PosicionInicialAlturaCliente=377
PosicionInicialAncho=631
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
Vista=mcModuloCampoProp
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
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=mcModuloCampoProp.Modulo=<T>{Info.Modulo}<T> AND<BR>mcModuloCampoProp.Campo=<T>{Info.Campo}<T>

[Lista.mcModuloCampoProp.Nodo]
Carpeta=Lista
Clave=mcModuloCampoProp.Nodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
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
Nombre=151
Nodo=451
Propiedad=142

[Lista.mcModuloCampoProp.Propiedad]
Carpeta=Lista
Clave=mcModuloCampoProp.Propiedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=mcModuloCampoProp.Propiedad
mcModuloCampoProp.Propiedad=mcModuloCampoProp.Nodo
mcModuloCampoProp.Nodo=(Fin)
