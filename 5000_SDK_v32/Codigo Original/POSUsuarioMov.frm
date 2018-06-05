
[Forma]
Clave=POSUsuarioMov
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Movimientos
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=POSUsuarioMov
CarpetaPrincipal=POSUsuarioMov
PosicionInicialIzquierda=478
PosicionInicialArriba=263
PosicionInicialAlturaCliente=273
PosicionInicialAncho=577
Comentarios=Info.Mov
ListaAcciones=Guardar
[POSUsuarioMov]
Estilo=Hoja
Clave=POSUsuarioMov
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSUsuarioMov
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaColorFondo=Plata
FiltroGeneral=POSUsuarioMov.Mov = <T>{Info.Mov}<T>
[POSUsuarioMov.POSUsuarioMov.Usuario]
Carpeta=POSUsuarioMov
Clave=POSUsuarioMov.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[POSUsuarioMov.Columnas]
Usuario=177

Nombre=354
PuedeAutorizar=81
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[POSUsuarioMov.Usuario.Nombre]
Carpeta=POSUsuarioMov
Clave=Usuario.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata



[POSUsuarioMov.ListaEnCaptura]
(Inicio)=POSUsuarioMov.Usuario
POSUsuarioMov.Usuario=Usuario.Nombre
Usuario.Nombre=(Fin)
