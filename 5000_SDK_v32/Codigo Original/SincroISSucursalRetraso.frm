
[Forma]
Clave=SincroISSucursalRetraso
Icono=0
CarpetaPrincipal=Lista
BarraHerramientas=S
Modulos=(Todos)
MovModulo=SincroISSucursalRetraso
Nombre=Sincro IS - Retraso
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=273
PosicionInicialAncho=244
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=470
PosicionInicialArriba=294
Comentarios=Lista(Info.Sucursal)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SincroISSucursalRetraso
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

FiltroGeneral=SincroISSucursalRetraso.Sucursal = {Info.Sucursal}
[Lista.SincroISSucursalRetraso.Hora]
Carpeta=Lista
Clave=SincroISSucursalRetraso.Hora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SincroISSucursalRetraso.Retraso]
Carpeta=Lista
Clave=SincroISSucursalRetraso.Retraso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Hora=111
Retraso=94

[Lista.ListaEnCaptura]
(Inicio)=SincroISSucursalRetraso.Hora
SincroISSucursalRetraso.Hora=SincroISSucursalRetraso.Retraso
SincroISSucursalRetraso.Retraso=(Fin)
