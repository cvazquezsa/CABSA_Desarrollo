[Forma]
Clave=SubModuloLista
Nombre=Sub Módulos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Modulo
ListaAcciones=Seleccionar
PosicionInicialIzquierda=298
PosicionInicialArriba=156
PosicionInicialAlturaCliente=422
PosicionInicialAncho=427
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SubModulo
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=SubModulo.Modulo=<T>{Info.Modulo}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.SubModulo.SubModulo]
Carpeta=Lista
Clave=SubModulo.SubModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SubModulo.Nombre]
Carpeta=Lista
Clave=SubModulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Columnas]
SubModulo=52
Nombre=345

[Lista.ListaEnCaptura]
(Inicio)=SubModulo.SubModulo
SubModulo.SubModulo=SubModulo.Nombre
SubModulo.Nombre=(Fin)
