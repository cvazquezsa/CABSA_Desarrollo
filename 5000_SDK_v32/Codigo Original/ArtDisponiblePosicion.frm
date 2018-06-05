[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S
NombreEnBoton=S

Antes=S
AntesExpresiones=Asigna(Info.Articulo, ArtDisponiblePosicion:ArtDisponibleTarima.Articulo)<BR>Asigna(Info.AlmacenDestino, Info.Almacen)
[Acciones.Detalle]
Nombre=Detalle
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=Detalles
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=
Expresion=Forma(<T>ArtAlmDesglose<T>)
VisibleCondicion=Info.ArtTipo noen (TipoNormal,TipoServicio)


[Existencias]
Estilo=Ficha
Clave=Existencias
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=ArtDisponiblePosicion
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ArtDisponibleTarima.Almacen = <T>{Info.Almacen}<T> AND ArtDisponibleTarima.Tarima = <T>{Info.Tarima}<T> AND ArtDisponibleTarima.Articulo = <T>{Info.Articulo}<T>
[Existencias.Columnas]
Concepto=152
Empresa=77
Articulo=147
Almacen=64
Cantidad=50
0=111
1=82

[Forma]
Clave=ArtDisponiblePosicion
Nombre=e(<T>Disponible de<T>)+<T> <T>+Info.Articulo+<T> - <T>+Info.Almacen
Icono=6
Modulos=(Todos)
ListaCarpetas=Existencias
CarpetaPrincipal=Existencias
PosicionInicialIzquierda=482
PosicionInicialArriba=241
PosicionInicialAltura=143
PosicionInicialAncho=359
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaBloquearAjuste=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=206








Comentarios=Info.Articulo
[Existencias.AlmPos.Posicion]
Carpeta=Existencias
Clave=AlmPos.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Existencias.ArtDisponibleTarima.Tarima]
Carpeta=Existencias
Clave=ArtDisponibleTarima.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Existencias.ArtDisponibleTarima.Disponible]
Carpeta=Existencias
Clave=ArtDisponibleTarima.Disponible
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco









Tamano=15

[Existencias.AlmPos.Descripcion]
Carpeta=Existencias
Clave=AlmPos.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco

[Existencias.AlmPos.Tipo]
Carpeta=Existencias
Clave=AlmPos.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Existencias.AlmPos.Zona]
Carpeta=Existencias
Clave=AlmPos.Zona
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco







[Existencias.AlmPos.Pasillo]
Carpeta=Existencias
Clave=AlmPos.Pasillo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco











[Existencias.ArtDescripcion]
Carpeta=Existencias
Clave=ArtDescripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco






[Acciones.ArtDisponibleTarima]
Nombre=ArtDisponibleTarima
Boton=51
NombreEnBoton=S
NombreDesplegar=Disponible a Nivel &Tarima
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtDisponibleTarima
Activo=S
Visible=S
Antes=S
AntesExpresiones=Si(Vacio(Info.Almacen), Asigna(Info.Almacen, Info.AlmacenDestino), nulo)




































[Existencias.ArtDisponibleTarima.Articulo]
Carpeta=Existencias
Clave=ArtDisponibleTarima.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco












[Existencias.ListaEnCaptura]
(Inicio)=ArtDisponibleTarima.Articulo
ArtDisponibleTarima.Articulo=ArtDescripcion
ArtDescripcion=AlmPos.Posicion
AlmPos.Posicion=AlmPos.Descripcion
AlmPos.Descripcion=AlmPos.Tipo
AlmPos.Tipo=AlmPos.Zona
AlmPos.Zona=AlmPos.Pasillo
AlmPos.Pasillo=ArtDisponibleTarima.Tarima
ArtDisponibleTarima.Tarima=ArtDisponibleTarima.Disponible
ArtDisponibleTarima.Disponible=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=ArtInfo
ArtInfo=ArtDisponibleTarima
ArtDisponibleTarima=(Fin)
