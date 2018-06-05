
[Forma]
Clave=SucursalMovBloquearCambio
Icono=0
Modulos=(Todos)
Nombre=Bloquear Cambio Sucursal

ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=Aceptar
Comentarios=Lista(Info.Sucursal,Info.Descripcion)
PosicionInicialIzquierda=505
PosicionInicialArriba=190
PosicionInicialAlturaCliente=328
PosicionInicialAncho=269
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SucursalMovBloquearCambio
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
FiltroGeneral=SucursalMovBloquearCambio.Sucursal = {Info.Sucursal}
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=SucursalMovBloquearCambio.Modulo
SucursalMovBloquearCambio.Modulo=SucursalMovBloquearCambio.Mov
SucursalMovBloquearCambio.Mov=(Fin)

[Lista.SucursalMovBloquearCambio.Modulo]
Carpeta=Lista
Clave=SucursalMovBloquearCambio.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SucursalMovBloquearCambio.Mov]
Carpeta=Lista
Clave=SucursalMovBloquearCambio.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
Modulo=85
Mov=152
