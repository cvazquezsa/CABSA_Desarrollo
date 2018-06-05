[Forma]
Clave=AutoDescuento
Nombre=Descuentos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=309
PosicionInicialArriba=358
PosicionInicialAlturaCliente=273
PosicionInicialAncho=662
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
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
Vista=AutoDescuento
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
OtroOrden=S
ListaOrden=(Lista)

[Lista.AutoDescuento.Mov]
Carpeta=Lista
Clave=AutoDescuento.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoDescuento.Articulo]
Carpeta=Lista
Clave=AutoDescuento.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoDescuento.MovAjuste]
Carpeta=Lista
Clave=AutoDescuento.MovAjuste
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=122
Articulo=124
MovAjuste=112
Descripcion1=235
Orden=36

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

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.AutoDescuento.Orden]
Carpeta=Lista
Clave=AutoDescuento.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=AutoDescuento.Mov
AutoDescuento.Mov=AutoDescuento.Articulo
AutoDescuento.Articulo=Art.Descripcion1
Art.Descripcion1=AutoDescuento.MovAjuste
AutoDescuento.MovAjuste=AutoDescuento.Orden
AutoDescuento.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=AutoDescuento.Orden<TAB>(Acendente)
AutoDescuento.Orden<TAB>(Acendente)=AutoDescuento.Mov<TAB>(Acendente)
AutoDescuento.Mov<TAB>(Acendente)=(Fin)
