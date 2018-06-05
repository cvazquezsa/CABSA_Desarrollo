[Forma]
Clave=AutoRolCargo
Nombre=Cargos Fijos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Rol
ListaAcciones=Aceptar
PosicionInicialIzquierda=223
PosicionInicialArriba=230
PosicionInicialAlturaCliente=273
PosicionInicialAncho=578
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
Vista=AutoRolCargo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
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
FiltroGeneral=AutoRolCargo.Rol=<T>{Info.Rol}<T>

[Lista.AutoRolCargo.Articulo]
Carpeta=Lista
Clave=AutoRolCargo.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris
Editar=S

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.AutoRolCargo.Tipo]
Carpeta=Lista
Clave=AutoRolCargo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoRolCargo.Importe]
Carpeta=Lista
Clave=AutoRolCargo.Importe
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
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Columnas]
Articulo=141
Descripcion1=214
Tipo=83
Importe=108

[Lista.ListaEnCaptura]
(Inicio)=AutoRolCargo.Articulo
AutoRolCargo.Articulo=Art.Descripcion1
Art.Descripcion1=AutoRolCargo.Tipo
AutoRolCargo.Tipo=AutoRolCargo.Importe
AutoRolCargo.Importe=(Fin)
