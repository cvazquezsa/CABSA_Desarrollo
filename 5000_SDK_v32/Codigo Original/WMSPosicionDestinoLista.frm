
[Forma]
Clave=WMSPosicionDestinoLista
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Posición Destino

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=211
PosicionInicialArriba=125
PosicionInicialAlturaCliente=439
PosicionInicialAncho=944
Comentarios=(Info.Almacen+<T> | <T>+Info.Articulo)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
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
CarpetaVisible=S

ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=AlmPos.Tipo
FiltroValida1=AlmPos.Tipo
FiltroTodo=S
FiltroGeneral={<T>AlmPos.Almacen =<T> & Comillas(Info.Almacen)}  {<T> AND AlmPos.ArticuloEsp = <T> & Comillas(Info.Articulo)}
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S

NombreEnBoton=S
GuardarAntes=S
ListaAccionesMultiples=(Lista)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
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

[Lista.AlmPos.ArticuloEsp]
Carpeta=Lista
Clave=AlmPos.ArticuloEsp
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


[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=MostrarCampos
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Lista.Columnas]
Posicion=64
Tipo=100
ArticuloEsp=116
Descripcion=159
Pasillo=64
Nivel=64
Zona=74
Estatus=94










[Acciones.Aceptar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=AlmPos.Posicion
AlmPos.Posicion=AlmPos.Tipo
AlmPos.Tipo=AlmPos.ArticuloEsp
AlmPos.ArticuloEsp=AlmPos.Descripcion
AlmPos.Descripcion=AlmPos.Pasillo
AlmPos.Pasillo=AlmPos.Nivel
AlmPos.Nivel=AlmPos.Zona
AlmPos.Zona=AlmPos.Estatus
AlmPos.Estatus=(Fin)




[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Seleccionar
Seleccionar=Aceptar
Aceptar=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=MostrarCampos
MostrarCampos=(Fin)
