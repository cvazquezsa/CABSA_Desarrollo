
[Forma]
Clave=eDocInRutaTabla
Icono=0
CarpetaPrincipal=eDocInRutaTabla
Modulos=(Todos)
Nombre=Tablas
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=eDocInRutaTabla
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Descripcion,Info.Ruta)
PosicionInicialIzquierda=389
PosicionInicialArriba=227
PosicionInicialAlturaCliente=368
PosicionInicialAncho=822
[eDocInRutaTabla]
Estilo=Hoja
Clave=eDocInRutaTabla
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInRutaTabla
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
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

OtroOrden=S
ListaOrden=eDocInModuloOmision.Orden<TAB>(Acendente)
FiltroGeneral=eDocInRutaTabla.eDocIn = <T>{Info.Descripcion}<T> AND<BR>eDocInRutaTabla.Ruta = <T>{Info.Ruta}<T>  AND<BR>eDocInModuloOmision.Modulo = <T>{Info.Modulo}<T>
[eDocInRutaTabla.eDocInRutaTabla.DetalleDe]
Carpeta=eDocInRutaTabla
Clave=eDocInRutaTabla.DetalleDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[eDocInRutaTabla.eDocInRutaTabla.Nodo]
Carpeta=eDocInRutaTabla
Clave=eDocInRutaTabla.Nodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[eDocInRutaTabla.eDocInRutaTabla.NodoNombre]
Carpeta=eDocInRutaTabla
Clave=eDocInRutaTabla.NodoNombre
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

[eDocInRutaTabla.Columnas]
DetalleDe=100
Nodo=239
NodoNombre=296



Tablas=142

[eDocInRutaTabla.eDocInRutaTabla.Tablas]
Carpeta=eDocInRutaTabla
Clave=eDocInRutaTabla.Tablas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.eDocInRutaTablaD]
Nombre=eDocInRutaTablaD
Boton=47
NombreEnBoton=S
NombreDesplegar=Detalle
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=eDocInRutaTablaD
Activo=S
Antes=S
DespuesGuardar=S
Visible=S








EspacioPrevio=S
AntesExpresiones=Asigna(Info.Tabla,eDocInRutaTabla:eDocInRutaTabla.Tablas)<BR>Asigna(Info.Mensaje,eDocInRutaTabla:eDocInRutaTabla.Nodo)<BR>EjecutarSQL(<T>speDocINRutaTablaD :tEdocIn, :tRuta, :tTabla<T>,eDocInRutaTabla:eDocInRutaTabla.eDocIn,eDocInRutaTabla:eDocInRutaTabla.Ruta,eDocInRutaTabla:eDocInRutaTabla.Tablas)<BR>EjecutarSQL(<T>speDocInListarNodosAtributos :nEstacion, :tEdocIn, :tPath<T>,SPID,eDocInRutaTabla:eDocInRutaTabla.eDocIn,eDocInRutaTabla:eDocInRutaTabla.Nodo)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S






























































































[eDocInRutaTabla.ListaEnCaptura]
(Inicio)=eDocInRutaTabla.Tablas
eDocInRutaTabla.Tablas=eDocInRutaTabla.DetalleDe
eDocInRutaTabla.DetalleDe=eDocInRutaTabla.Nodo
eDocInRutaTabla.Nodo=eDocInRutaTabla.NodoNombre
eDocInRutaTabla.NodoNombre=(Fin)





















































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=eDocInRutaTablaD
eDocInRutaTablaD=(Fin)
