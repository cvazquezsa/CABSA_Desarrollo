[Forma]
Clave=WebSucursalImagenDescripcion
Nombre=Descripción
Icono=0
CarpetaPrincipal=WebSucursalImagen
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
ListaCarpetas=WebSucursalImagen
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Sucursal,Info.Nombre)
ListaAcciones=(Lista)
PosicionInicialIzquierda=536
PosicionInicialArriba=193
PosicionInicialAlturaCliente=334
PosicionInicialAncho=500
VentanaEstadoInicial=Normal
[WebSucursalImagen]
Estilo=Ficha
Clave=WebSucursalImagen
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSucursalImagen
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebSucursalImagen.Descripcion
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
AlinearTodaCarpeta=S
PermiteEditar=S
FiltroGeneral=WebSucursalImagen.Sucursal = {Info.sucursal} AND WebSucursalImagen.Nombre = <T>{Info.Nombre}<T>
[WebSucursalImagen.WebSucursalImagen.Descripcion]
Carpeta=WebSucursalImagen
Clave=WebSucursalImagen.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5x10
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
[Acciones.HTML]
Nombre=HTML
Boton=75
NombreEnBoton=S
NombreDesplegar=&Editor HTML
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S

































































Expresion=EditorHTML(WebSucursalImagen:WebSucursalImagen.Descripcion,<T>Mensaje<T>,<T>HTML<T>)<BR>GuardarCambios<BR>EjecutarSQL(<T>spWebSucActualizarHTML :nSuc, :tNombre<T>,Info.Sucursal,Info.Nombre)<BR>ActualizarForma






[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=HTML
HTML=(Fin)
