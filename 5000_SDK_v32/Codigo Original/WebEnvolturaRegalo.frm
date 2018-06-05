
[Forma]
Clave=WebEnvolturaRegalo
Icono=0
Modulos=(Todos)
Nombre=Envolturas Regalo

ListaCarpetas=WebEnvolturaRegalo
CarpetaPrincipal=WebEnvolturaRegalo
PosicionInicialIzquierda=207
PosicionInicialArriba=355
PosicionInicialAlturaCliente=201
PosicionInicialAncho=1010
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraHerramientas=S
[WebEnvolturaRegalo]
Estilo=Hoja
Clave=WebEnvolturaRegalo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebEnvolturaRegalo
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

PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=WebEnvolturaRegalo.SucursaleCommerce = <T>{Info.Clave}<T>
[WebEnvolturaRegalo.WebEnvolturaRegalo.Nombre]
Carpeta=WebEnvolturaRegalo
Clave=WebEnvolturaRegalo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[WebEnvolturaRegalo.WebEnvolturaRegalo.Precio]
Carpeta=WebEnvolturaRegalo
Clave=WebEnvolturaRegalo.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WebEnvolturaRegalo.WebEnvolturaRegalo.Visible]
Carpeta=WebEnvolturaRegalo
Clave=WebEnvolturaRegalo.Visible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WebEnvolturaRegalo.WebEnvolturaRegalo.PermiteMensaje]
Carpeta=WebEnvolturaRegalo
Clave=WebEnvolturaRegalo.PermiteMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WebEnvolturaRegalo.WebEnvolturaRegalo.Imagen]
Carpeta=WebEnvolturaRegalo
Clave=WebEnvolturaRegalo.Imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[WebEnvolturaRegalo.WebEnvolturaRegalo.Articulo]
Carpeta=WebEnvolturaRegalo
Clave=WebEnvolturaRegalo.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WebEnvolturaRegalo.WebEnvolturaRegalo.SubCuenta]
Carpeta=WebEnvolturaRegalo
Clave=WebEnvolturaRegalo.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[WebEnvolturaRegalo.Columnas]
Nombre=225
Precio=64
Visible=64
PermiteMensaje=80
Imagen=95
EsOmision=64
Articulo=124
SubCuenta=304






[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
EnBarraHerramientas=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S





EspacioPrevio=S







[Acciones.Imagen]
Nombre=Imagen
Boton=62
NombreEnBoton=S
NombreDesplegar=&Agregar Imagen
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S







Antes=S













GuardarAntes=S
Expresion=FormaModal(<T>WebEnvolturaImagenTemp<T>)<BR>ActualizarForma
AntesExpresiones=Asigna(Info.ID, WebEnvolturaRegalo:WebEnvolturaRegalo.ID)
DespuesGuardar=S
[Acciones.Eliminar]
Nombre=Eliminar
Boton=63
NombreEnBoton=S
NombreDesplegar=&Eliminar Imagen
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

































GuardarAntes=S
Expresion=EjecutarSQL(<T>spWebEnvolturaBorrarImagen :nID<T>, WebEnvolturaRegalo:WebEnvolturaRegalo.ID)<BR>ActualizarForma











































[WebEnvolturaRegalo.ListaEnCaptura]
(Inicio)=WebEnvolturaRegalo.Nombre
WebEnvolturaRegalo.Nombre=WebEnvolturaRegalo.Precio
WebEnvolturaRegalo.Precio=WebEnvolturaRegalo.Visible
WebEnvolturaRegalo.Visible=WebEnvolturaRegalo.PermiteMensaje
WebEnvolturaRegalo.PermiteMensaje=WebEnvolturaRegalo.Imagen
WebEnvolturaRegalo.Imagen=WebEnvolturaRegalo.Articulo
WebEnvolturaRegalo.Articulo=WebEnvolturaRegalo.SubCuenta
WebEnvolturaRegalo.SubCuenta=(Fin)









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=Imagen
Imagen=Eliminar
Eliminar=(Fin)
