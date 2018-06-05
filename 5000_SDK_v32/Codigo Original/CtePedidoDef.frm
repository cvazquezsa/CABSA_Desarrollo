[Forma]
Clave=CtePedidoDef
Nombre=Pedido por Omisión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=203
PosicionInicialArriba=153
PosicionInicialAlturaCliente=427
PosicionInicialAncho=617
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Cliente, Info.Nombre)
ListaAcciones=(Lista)
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
Vista=CtePedidoDef
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
FiltroRespetar=S
FiltroTipo=General
ValidarCampos=S
ListaCamposAValidar=OpcionDesc
FiltroGeneral=CtePedidoDef.Cliente=<T>{Info.Cliente}<T>

[Lista.CtePedidoDef.Articulo]
Carpeta=Lista
Clave=CtePedidoDef.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtePedidoDef.SubCuenta]
Carpeta=Lista
Clave=CtePedidoDef.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.CtePedidoDef.Cantidad]
Carpeta=Lista
Clave=CtePedidoDef.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtePedidoDef.Unidad]
Carpeta=Lista
Clave=CtePedidoDef.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=124
SubCuenta=130
Cantidad=47
Unidad=79
Descripcion1=204

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CambiarVista
CambiarVista=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtePedidoDef.Articulo
CtePedidoDef.Articulo=Art.Descripcion1
Art.Descripcion1=CtePedidoDef.SubCuenta
CtePedidoDef.SubCuenta=CtePedidoDef.Cantidad
CtePedidoDef.Cantidad=CtePedidoDef.Unidad
CtePedidoDef.Unidad=(Fin)
