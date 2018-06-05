[Forma]
Clave=SucursalMovSeguimiento
Nombre=<T>Movimientos Seguimiento Especial, que NO Afecten al Inventario Directamente<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=690
PosicionInicialArriba=445
PosicionInicialAltura=300
PosicionInicialAncho=539
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Sucursal, Info.Descripcion)
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SucursalMovSeguimiento
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
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=SucursalMovSeguimiento.Sucursal={Info.Sucursal}
FiltroRespetar=S
FiltroTipo=General

[Lista.SucursalMovSeguimiento.Modulo]
Carpeta=Lista
Clave=SucursalMovSeguimiento.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SucursalMovSeguimiento.Mov]
Carpeta=Lista
Clave=SucursalMovSeguimiento.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SucursalMovSeguimiento.Seguimiento]
Carpeta=Lista
Clave=SucursalMovSeguimiento.Seguimiento
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=78
Mov=152
Seguimiento=103

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
(Inicio)=SucursalMovSeguimiento.Modulo
SucursalMovSeguimiento.Modulo=SucursalMovSeguimiento.Mov
SucursalMovSeguimiento.Mov=SucursalMovSeguimiento.Seguimiento
SucursalMovSeguimiento.Seguimiento=(Fin)
