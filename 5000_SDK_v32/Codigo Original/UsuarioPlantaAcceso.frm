[Forma]
Clave=UsuarioPlantaAcceso
Nombre=Plantas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=616
PosicionInicialArriba=256
PosicionInicialAlturaCliente=310
PosicionInicialAncho=358
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Usuario
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioPlantaAcceso
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
PermiteEditar=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=UsuarioPlantaAcceso.Usuario=<T>{Info.Usuario}<T>


[Lista.Columnas]
Sucursal=50
Nombre=239

Clave=73
Descripcion=244
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

















[Lista.ListaEnCaptura]
(Inicio)=UsuarioPlantaAcceso.Clave
UsuarioPlantaAcceso.Clave=PlantaProductiva.Descripcion
PlantaProductiva.Descripcion=(Fin)

[Lista.UsuarioPlantaAcceso.Clave]
Carpeta=Lista
Clave=UsuarioPlantaAcceso.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Lista.PlantaProductiva.Descripcion]
Carpeta=Lista
Clave=PlantaProductiva.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
