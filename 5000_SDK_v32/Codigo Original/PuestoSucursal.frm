[Forma]
Clave=PuestoSucursal
Nombre=Puesto a Nivel Sucursal
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=315
PosicionInicialArriba=239
PosicionInicialAlturaCliente=518
PosicionInicialAncho=649
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Puesto
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
Vista=PuestoSucursal
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
FiltroGeneral=PuestoSucursal.Puesto=<T>{Info.Puesto}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.PuestoSucursal.Sucursal]
Carpeta=Lista
Clave=PuestoSucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PuestoSucursal.SueldoMensual]
Carpeta=Lista
Clave=PuestoSucursal.SueldoMensual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PuestoSucursal.SueldoDef]
Carpeta=Lista
Clave=PuestoSucursal.SueldoDef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Sucursal=47
SueldoDef=133
Nombre=304

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

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=PuestoSucursal.Sucursal
PuestoSucursal.Sucursal=Sucursal.Nombre
Sucursal.Nombre=PuestoSucursal.SueldoMensual
PuestoSucursal.SueldoMensual=PuestoSucursal.SueldoDef
PuestoSucursal.SueldoDef=(Fin)
