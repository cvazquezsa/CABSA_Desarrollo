[Forma]
Clave=AlmPos
Nombre=Posiciones del Almacén
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
PosicionInicialIzquierda=484
PosicionInicialArriba=201
PosicionInicialAlturaCliente=306
PosicionInicialAncho=515
Comentarios=Info.Almacen
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionCol1=842
PosicionSec1=409

DialogoAbrir=S
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AlmPos
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
[Lista.AlmPos.Tipo]
Carpeta=Lista
Clave=AlmPos.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EspacioPrevio=S
[Lista.AlmPos.Descripcion]
Carpeta=Lista
Clave=AlmPos.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=47
ColorFondo=Blanco

[Lista.AlmPos.Pasillo]
Carpeta=Lista
Clave=AlmPos.Pasillo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.AlmPos.Nivel]
Carpeta=Lista
Clave=AlmPos.Nivel
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Lista.AlmPos.Zona]
Carpeta=Lista
Clave=AlmPos.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.AlmPos.Estatus]
Carpeta=Lista
Clave=AlmPos.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
AlmPos=64
Tipo=67
Descripcion=138
Pasillo=34
Nivel=30
Zona=59
Estatus=57
Almacen=64
ArticuloEsp=92
Posicion=64
CategoriaEsp=304
GrupoEsp=304
FamiliaEsp=304
Capacidad=103
Fila=31

TipoTarimaEsp=110

Descripcion1=184
Alto=64
Largo=64
Ancho=64
Volumen=64
PesoMaximo=66
[Acciones.Zonas]
Nombre=Zonas
Boton=91
NombreEnBoton=S
NombreDesplegar=&Zonas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PosicionZona
Activo=S
Visible=S

[Lista.AlmPos.Posicion]
Carpeta=Lista
Clave=AlmPos.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Ficha.AlmPos.CategoriaEsp]
Carpeta=Ficha
Clave=AlmPos.CategoriaEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AlmPos.GrupoEsp]
Carpeta=Ficha
Clave=AlmPos.GrupoEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AlmPos.FamiliaEsp]
Carpeta=Ficha
Clave=AlmPos.FamiliaEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AlmPos.Capacidad]
Carpeta=Lista
Clave=AlmPos.Capacidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=15
[Tarimas.Columnas]
0=182
1=87

[Acciones.TarimasPersonalizar]
Nombre=TarimasPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=Tarimas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Tarimas.EstatusNombre]
Carpeta=Tarimas
Clave=EstatusNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TarimaPosicion]
Nombre=TarimaPosicion
Boton=47
NombreEnBoton=S
NombreDesplegar=&Tarimas en la Posición
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TarimaPosicion
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Posicion, AlmPos:AlmPos.Posicion)
Visible=S

[Lista.AlmPos.ArticuloEsp]
Carpeta=Lista
Clave=AlmPos.ArticuloEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.AlmPos.Fila]
Carpeta=Lista
Clave=AlmPos.Fila
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=15
[Lista.ListaOrden]
(Inicio)=AlmPos.Pasillo<TAB>(Acendente)
AlmPos.Pasillo<TAB>(Acendente)=AlmPos.Fila<TAB>(Acendente)
AlmPos.Fila<TAB>(Acendente)=AlmPos.Nivel<TAB>(Acendente)
AlmPos.Nivel<TAB>(Acendente)=(Fin)





[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S

[Acciones.Abrir]
Nombre=Abrir
Boton=2
NombreDesplegar=Abrir
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S




[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
ConCondicion=S


EjecucionCondicion=Si AlmPos:AlmPos.Tipo= <T>Domicilio<T> y (Vacio(AlmPos:AlmPos.ArticuloEsp,<T><T>) = <T><T>)<BR>Entonces<BR> Falso<BR> Error(<T>La posición de Domicilio debe contener un Articulo Específico<T>)<BR>Sino<BR>Si SQL(<T>EXEC spWMSModificarAlmPos :tAlmacen, :tPosicion, :tArticulo<T>, AlmPos:AlmPos.Almacen, AlmPos:AlmPos.Posicion, AlmPos:AlmPos.ArticuloEsp) = 1<BR>Entonces<BR>  Falso<BR>  Error(<T>El Articulo <T> + AlmPos:AlmPos.ArticuloEsp + <T> tiene movimientos pendientes en WMS<T>)<BR>SiNo<BR>  Si (Vacio(AlmPos:AlmPos.TipoRotacion,<T><T>) = <T><T>) y (SQL(<T>SELECT ISNULL(WMSRotacionArticulo,0) FROM EmpresaCFG WHERE Empresa = :tEmpresa<T>,Empresa))<BR>  Entonces<BR>    Falso<BR>    Error(<T>El campo tipo rotación debe de tener un valor<T>)<BR>  Sino<BR>    SI (AlmPos:AlmPos.Tipo = <T>Domicilio<T>)<BR>    Entonces<BR>        SI (AlmPos:AlmPos.Estatus = <T>ALTA<T>) y (SQL(<T>IF EXISTS (SELECT * FROM AlmPos WHERE Almacen = :tAlmacen AND ISNULL(ArticuloEsp, :tEspacio1) = ISNULL(:tArticulo,:tEspacio2) AND Tipo = :tTipo AND Estatus = :tEstatus AND Posicion <> :tPosicion AND ISNULL(:tArticulo,:tEspacio3) <> :tEspacio4) SELECT 1 ELSE SELECT 0<T>, AlmPos:AlmPos.Almacen, <T><T>, AlmPos:AlmPos.ArticuloEsp, <T><T>, AlmPos:AlmPos.Tipo, <T>ALTA<T>, AlmPos:AlmPos.Posicion, AlmPos:AlmPos.ArticuloEsp, <T><T>, <T><T>) = 1)<BR>        Entonces<BR>          Falso<BR>          Error(<T>No se puede tener mas de un Domicilio para el mismo artículo<T>)<BR>        SiNo<BR>          Verdadero<BR>          SI (AlmPos:AlmPos.Estatus = <T>ALTA<T>)y (SQL(<T>IF EXISTS (SELECT * FROM Art WHERE Articulo = :tArticulo AND Tipo = :tTipo AND SerieLoteInfo = :nSerieLoteInfo) SELECT 1 ELSE SELECT 0<T>, AlmPos:AlmPos.ArticuloEsp, <T>SERIE<T>, 0) = 1)<BR>          Entonces<BR>            Falso<BR>            Error(<T>No se puede tener un Domicilio para el artículo tipo SERIE sin Series/Lotes Informativas activada<T>)<BR>          SiNo<BR>            Verdadero<BR>          Fin<BR>        Fin<BR>    SiNo<BR>      Verdadero<BR>    Fin<BR>  Fin<BR>Fin<BR>Fin
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=Eliminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=SQL(<T>IF EXISTS(SELECT * FROM Tarima WHERE Posicion = :tPosicion AND Estatus = :tAlta) OR EXISTS(SELECT * FROM TMA t JOIN TMAD d ON t.ID = d.ID WHERE t.Estatus IN(:tPendiente, :tProcesar) AND d.PosicionDestino = :tPosicion) SELECT 1 ELSE SELECT 0<T>, AlmPos:AlmPos.Posicion, <T>ALTA<T>, <T>PENDIENTE<T>,<T> PROCESAR<T>, AlmPos:AlmPos.Posicion)=0
EjecucionMensaje=<T>No se puede eliminar la posición ya que tiene tarimas asignadas<T>


[Acciones.AlmPosOrdenar]
Nombre=AlmPosOrdenar
Boton=50
NombreDesplegar=Ordenar Posiciones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AlmPosOrdenar
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.Almacen, AlmPos:AlmPos.Almacen)

[Acciones.Navegador Completo (Registros)]
Nombre=Navegador Completo (Registros)
Boton=0
NombreDesplegar=Navegador Completo (Registros)
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S








EspacioPrevio=S
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=AlmPosA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Posición<T>
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroAutoCampo=AlmPos.Zona
FiltroAutoValidar=Zona
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
;FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S

IconosConPaginas=S
FiltroTodoFinal=S
OtroOrden=S
ListaOrden=(Lista)
FiltroAutoCampo=AlmPos.Zona
FiltroArbolClave=AlmPos.Zona
FiltroGrupo1=AlmPos.Zona
FiltroValida1=AlmPos.Zona
PestanaOtroNombre=S
PestanaNombre=Posiciones de Almacenes

IconosNombre=AlmPosA:AlmPos.Posicion
FiltroGeneral=AlmPos.Almacen=<T>{Info.Almacen}<T>
[(Carpeta Abrir).AlmPos.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=AlmPos.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[(Carpeta Abrir).AlmPos.Tipo]
Carpeta=(Carpeta Abrir)
Clave=AlmPos.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Carpeta Abrir).AlmPos.Zona]
Carpeta=(Carpeta Abrir)
Clave=AlmPos.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).AlmPos.ArticuloEsp]
Carpeta=(Carpeta Abrir)
Clave=AlmPos.ArticuloEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[(Carpeta Abrir).Columnas]
0=74
1=82
2=69
3=71
4=-2



[Lista.AlmPos.TipoRotacion]
Carpeta=Lista
Clave=AlmPos.TipoRotacion
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=N
ValidaNombre=S
3D=S
Tamano=47
ColorFondo=Plata

[Lista.AlmPos.Alto]
Carpeta=Lista
Clave=AlmPos.Alto
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

LineaNueva=S
EspacioPrevio=S
[Lista.AlmPos.Largo]
Carpeta=Lista
Clave=AlmPos.Largo
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.AlmPos.Ancho]
Carpeta=Lista
Clave=AlmPos.Ancho
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.AlmPos.Volumen]
Carpeta=Lista
Clave=AlmPos.Volumen
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata

LineaNueva=S
[Lista.AlmPos.PesoMaximo]
Carpeta=Lista
Clave=AlmPos.PesoMaximo
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=AlmPos.Posicion
AlmPos.Posicion=AlmPos.Descripcion
AlmPos.Descripcion=AlmPos.Zona
AlmPos.Zona=AlmPos.Pasillo
AlmPos.Pasillo=AlmPos.Fila
AlmPos.Fila=AlmPos.Nivel
AlmPos.Nivel=AlmPos.Tipo
AlmPos.Tipo=AlmPos.Estatus
AlmPos.Estatus=AlmPos.Capacidad
AlmPos.Capacidad=AlmPos.TipoRotacion
AlmPos.TipoRotacion=AlmPos.ArticuloEsp
AlmPos.ArticuloEsp=Art.Descripcion1
Art.Descripcion1=AlmPos.Alto
AlmPos.Alto=AlmPos.Largo
AlmPos.Largo=AlmPos.Ancho
AlmPos.Ancho=AlmPos.Volumen
AlmPos.Volumen=AlmPos.PesoMaximo
AlmPos.PesoMaximo=(Fin)


[Acciones.CambioDomicilio]
Nombre=CambioDomicilio
Boton=93
NombreDesplegar=Cambiar Domicilio
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S



Antes=S

GuardarAntes=S
EspacioPrevio=S
Expresion=Si Forma(<T>EspecificarPosicion<T>)<BR>Entonces<BR>  Informacion(SQL(<T>EXEC spWMSCambioDomicilio :tAlmacen, :tPosicionActual, :tPosicionDestino<T>, Info.Almacen, Info.Anuncio, Info.Posicion))<BR>  ActualizarVista<BR>  ActualizarForma<BR>Fin
ActivoCondicion=AlmPos:AlmPos.Tipo = <T>Domicilio<T>
AntesExpresiones=Asigna(Info.Almacen, AlmPos:AlmPos.Almacen)<BR>Asigna(Info.Anuncio, AlmPos:AlmPos.Posicion)<BR>Asigna(Info.Tipo, AlmPos:AlmPos.Tipo)






























[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=AlmPos.Descripcion
AlmPos.Descripcion=AlmPos.Tipo
AlmPos.Tipo=AlmPos.Zona
AlmPos.Zona=AlmPos.ArticuloEsp
AlmPos.ArticuloEsp=(Fin)

[(Carpeta Abrir).ListaOrden]
(Inicio)=AlmPos.Orden	(Acendente)
AlmPos.Orden	(Acendente)=AlmPos.Posicion	(Acendente)
AlmPos.Posicion	(Acendente)=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=ALTA
ALTA=BAJA
BAJA=(Todos)
(Todos)=(Fin)





[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Zonas
Zonas=TarimaPosicion
TarimaPosicion=AlmPosOrdenar
AlmPosOrdenar=CambioDomicilio
CambioDomicilio=Navegador Completo (Registros)
Navegador Completo (Registros)=(Fin)
