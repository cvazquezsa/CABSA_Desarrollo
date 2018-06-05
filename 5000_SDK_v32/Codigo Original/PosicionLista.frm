[Forma]
Clave=PosicionLista
Nombre=Posiciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
PosicionInicialIzquierda=232
PosicionInicialArriba=35
PosicionInicialAlturaCliente=511
PosicionInicialAncho=815
VentanaPosicionInicial=Centrado
Comentarios=Info.Almacen

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AlmPos
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
FiltroGrupo1=AlmPos.Zona
FiltroValida1=AlmPos.Zona
FiltroGrupo2=AlmPos.Pasillo
FiltroValida2=AlmPos.Pasillo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)

FiltroGeneral=AlmPos.Almacen=<T>{Info.Almacen}<T> {Si(ConDatos(Info.Tipo),<T>AND AlmPos.Tipo=<T>& Comillas(Info.Tipo),<T><T>)}
[Lista.Columnas]
Tipo=106
Descripcion=130
Pasillo=45
Nivel=37
Zona=64
Estatus=54
Posicion=64
Almacen=64
Articulo=101
ArticuloEsp=124

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.AlmPos.Posicion]
Carpeta=Lista
Clave=AlmPos.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.AlmPos.Tipo]
Carpeta=Lista
Clave=AlmPos.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.AlmPos.Descripcion]
Carpeta=Lista
Clave=AlmPos.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.AlmPos.Pasillo]
Carpeta=Lista
Clave=AlmPos.Pasillo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.AlmPos.Nivel]
Carpeta=Lista
Clave=AlmPos.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.AlmPos.Zona]
Carpeta=Lista
Clave=AlmPos.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.AlmPos.Estatus]
Carpeta=Lista
Clave=AlmPos.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.AlmPos.ArticuloEsp]
Carpeta=Lista
Clave=AlmPos.ArticuloEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=AlmPos.Posicion
AlmPos.Posicion=AlmPos.Tipo
AlmPos.Tipo=AlmPos.ArticuloEsp
AlmPos.ArticuloEsp=AlmPos.Pasillo
AlmPos.Pasillo=AlmPos.Nivel
AlmPos.Nivel=AlmPos.Zona
AlmPos.Zona=AlmPos.Descripcion
AlmPos.Descripcion=AlmPos.Estatus
AlmPos.Estatus=(Fin)

[Acciones.Filtrar]
Nombre=Filtrar
Boton=107
NombreDesplegar=(Todas)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Asigna(Info.Tipo,Nulo)<BR>ActualizarForma
Activo=S
Visible=S



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Filtrar
Filtrar=(Fin)
