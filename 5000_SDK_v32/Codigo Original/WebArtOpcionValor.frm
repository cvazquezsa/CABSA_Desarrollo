
[Forma]
Clave=WebArtOpcionValor
Icono=0
Modulos=(Todos)
Nombre=Detalles  Artículo eCommerce
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebArtOpcionValor

ListaCarpetas=WebArtOpcionValor
PosicionInicialIzquierda=510
PosicionInicialArriba=329
PosicionInicialAlturaCliente=410
PosicionInicialAncho=554
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Nombre,Info.Nombre2)
VentanaSiempreAlFrente=S
VentanaSinIconosMarco=S
[WebArtOpcionValor]
Estilo=Hoja
Clave=WebArtOpcionValor
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtOpcionValor
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
ListaOrden=WebArtOpcionValor.Orden<TAB>(Acendente)

PermiteEditar=S
FiltroGeneral=WebArtOpcionValor.VariacionID = {Temp.Num} AND<BR>WebArtOpcionValor.OpcionID = {Info.IDR}
[WebArtOpcionValor.WebArtOpcionValor.Valor]
Carpeta=WebArtOpcionValor
Clave=WebArtOpcionValor.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[WebArtOpcionValor.Columnas]
Orden=64
Valor=514

NumeroIntelisis=80
Nombre=64
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
EjecucionCondicion=Asigna(Info.Clase3, ListaBuscarDuplicados(CampoEnLista(WebArtOpcionValor:WebArtOpcionValor.Valor)))<BR>Vacio(Info.Clase3)
EjecucionMensaje=<T>Nombre: <T>+Info.Clase3+<T> Duplicado<T>
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
EjecucionCondicion=Asigna(Info.Clase3, ListaBuscarDuplicados(CampoEnLista(SerieLoteMov:SerieLoteMov.SerieLote)))<BR>Vacio(Info.Clase3)
EjecucionMensaje=<T>Nombre: <T>+Info.Clase3+<T> Duplicado<T>
AntesExpresiones=FormaModal(<T>WebArtOpcionValorOrdenar<T>)
[WebArtOpcionValor.WebArtOpcionValor.NumeroIntelisis]
Carpeta=WebArtOpcionValor
Clave=WebArtOpcionValor.NumeroIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
[Acciones.Registro Agregar]
Nombre=Registro Agregar
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
NombreEnBoton=S
Expresion=Asigna(Temp.Texto, <T><T>)<BR>Si FormaModal(<T>WebArtRegistroOpcionValor<T>) Entonces<BR>    Si (Vacio(Temp.Texto, <T><T>) = <T><T>) Entonces<BR>        Informacion(<T>Campo Nombre no puede ser nulo<T>)<BR>    Sino<BR>        EjecutarSQL( <T>EXEC speCommerceRegistroWebArtOpcionValor :nEstacion, :tAccion, :tNombre, :nVariacionID, :nOpcionID, :nID<T>,  EstacionTrabajo, <T>ALTA<T>, Temp.Texto, Info.ID, Info.GID, 0)<BR>        ActualizarForma<BR>    Fin<BR>Fin
ActivoCondicion=no Info.TieneMovimientos
[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S




NombreEnBoton=S
Expresion=EjecutarSQL( <T>EXEC speCommerceRegistroWebArtOpcionValor :nEstacion, :tAccion, :tValor, :nVariacionID, :nOpcionID, :nID<T>,  EstacionTrabajo, <T>BAJA<T>, WebArtOpcionValor:WebArtOpcionValor.Valor, WebArtOpcionValor:WebArtOpcionValor.VariacionID, WebArtOpcionValor:WebArtOpcionValor.OpcionID, WebArtOpcionValor:WebArtOpcionValor.ID)<BR>ActualizarForma
ActivoCondicion=no Info.TieneMovimientos
[WebArtOpcionValor.OpcionD.Nombre]
Carpeta=WebArtOpcionValor
Clave=OpcionD.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

































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












[WebArtOpcionValor.ListaEnCaptura]
(Inicio)=WebArtOpcionValor.Valor
WebArtOpcionValor.Valor=WebArtOpcionValor.NumeroIntelisis
WebArtOpcionValor.NumeroIntelisis=OpcionD.Nombre
OpcionD.Nombre=(Fin)











[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=Registro Agregar
Registro Agregar=Registro Eliminar
Registro Eliminar=Orden
Orden=(Fin)
