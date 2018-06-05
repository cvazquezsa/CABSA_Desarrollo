
[Forma]
Clave=WebArtOpcion
Icono=0
Modulos=(Todos)
Nombre=Opciones  Artículo eCommerce
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebArtOpcion

ListaCarpetas=WebArtOpcion
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Nombre
ListaAcciones=(Lista)
PosicionInicialIzquierda=565
PosicionInicialArriba=228
PosicionInicialAlturaCliente=471
PosicionInicialAncho=623
VentanaExclusiva=S
VentanaExclusivaOpcion=3
VentanaSinIconosMarco=S
[WebArtOpcion]
Estilo=Hoja
Clave=WebArtOpcion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtOpcion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
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
OtroOrden=S
ListaOrden=WebArtOpcion.Orden<TAB>(Acendente)

PermiteEditar=S
FiltroGeneral=WebArtOpcion.VariacionID = {Temp.Num}
[WebArtOpcion.WebArtOpcion.Nombre]
Carpeta=WebArtOpcion
Clave=WebArtOpcion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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

ConCondicion=S
EjecucionConError=S
EspacioPrevio=S
EjecucionCondicion=Asigna(Info.Clase2, ListaBuscarDuplicados(CampoEnLista(WebArtOpcion:WebArtOpcion.Nombre)))<BR>Vacio(Info.Clase2)
EjecucionMensaje=<T>Nombre: <T>+Info.Clase2+<T> Duplicado<T>
[WebArtOpcion.Columnas]
Orden=64
Nombre=580

OpcionIntelisis=76
Descripcion=64
[Acciones.WebArtOpcionValor]
Nombre=WebArtOpcionValor
Boton=55
NombreEnBoton=S
NombreDesplegar=Detalles
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebArtOpcionValor
Activo=S
Antes=S
DespuesGuardar=S
Visible=S


ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Info.Clase2, ListaBuscarDuplicados(CampoEnLista(SerieLoteMov:SerieLoteMov.SerieLote)))<BR>Vacio(Info.Clase2)
EjecucionMensaje=<T>Nombre: <T>+Info.Clase2+<T> Duplicado<T>
AntesExpresiones=Asigna(Info.IDR,SQL(<T>SELECT ID FROM WebArtOpcion WHERE GUID = :tGUID<T>,WebArtOpcion:WebArtOpcion.GUID))<BR>Asigna(Info.Nombre2,WebArtOpcion:WebArtOpcion.Nombre)<BR>Asigna(Info.Opcion,WebArtOpcion:WebArtOpcion.OpcionIntelisis)<BR>Asigna(Info.GID,WebArtOpcion:WebArtOpcion.ID)
[Acciones.Orden]
Nombre=Orden
Boton=50
NombreEnBoton=S
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
DespuesGuardar=S
Visible=S

ConCondicion=S
EjecucionConError=S
ActivoCondicion=no Info.TieneMovimientos
EjecucionCondicion=Asigna(Info.Clase2, ListaBuscarDuplicados(CampoEnLista(SerieLoteMov:SerieLoteMov.SerieLote)))<BR>Vacio(Info.Clase2)
EjecucionMensaje=<T>Nombre: <T>+Info.Clase2+<T> Duplicado<T>
AntesExpresiones=FormaModal(<T>WebArtOpcionOrdenar<T>)
[Lista.Columnas]
0=49
1=434

[WebArtOpcion.WebArtOpcion.OpcionIntelisis]
Carpeta=WebArtOpcion
Clave=WebArtOpcion.OpcionIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco











[WebArtOpcion.Opcion.Descripcion]
Carpeta=WebArtOpcion
Clave=Opcion.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco






































[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S













NombreEnBoton=S
EspacioPrevio=S

















Expresion=Asigna(Temp.Texto, <T><T>)<BR>Si FormaModal(<T>WebArtRegistroOpcion<T>) Entonces<BR>    Si (Vacio(Temp.Texto, <T><T>) = <T><T>) Entonces<BR>        Informacion(<T>Campo Nombre no puede ser nulo<T>)<BR>    Sino<BR>        EjecutarSQL(<T>EXEC speCommerceRegistroWebArtOpcion :nEstacionTrabajo, :tAccion, :tNombre, :nVariacionID, :nID<T>, EstacionTrabajo, <T>ALTA<T>, Temp.Texto, Info.ID, 0)<BR>        ActualizarForma<BR>    Fin<BR>Fin
ActivoCondicion=no Info.TieneMovimientos
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S



NombreEnBoton=S





















































































































Expresion=EJECUTARSQL(<T>EXEC speCommerceRegistroWebArtOpcion :nEstacionTrabajo, :tAccion, :tNombre, :nVariacionID, :nID<T>, EstacionTrabajo, <T>BAJA<T>, WebArtOpcion:WebArtOpcion.Nombre, Info.ID, WebArtOpcion:WebArtOpcion.ID)<BR>ActualizarForma
ActivoCondicion=no Info.TieneMovimientos
[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S








[WebArtOpcion.ListaEnCaptura]
(Inicio)=WebArtOpcion.Nombre
WebArtOpcion.Nombre=WebArtOpcion.OpcionIntelisis
WebArtOpcion.OpcionIntelisis=Opcion.Descripcion
Opcion.Descripcion=(Fin)

























































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Orden
Orden=WebArtOpcionValor
WebArtOpcionValor=(Fin)
