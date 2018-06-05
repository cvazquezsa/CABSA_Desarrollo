[Forma]
Clave=ArtPartidaCte
Nombre=<T>Partidas del Artículo<T>
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=151
PosicionInicialArriba=171
PosicionInicialAltura=426
PosicionInicialAncho=722
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Info.Articulo

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtPartidaCte
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FiltroGrupo1=SerieLote.Almacen
FiltroGrupo2=SerieLote.Cliente
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=30
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
FiltroValida1=SerieLote.Almacen
FiltroValida2=Cte.Nombre
FiltroTodo=S
FiltroTodoFinal=S
ValidarCampos=S
ListaCamposAValidar=Cte.Nombre
HojaFondoGris=S
FiltroGeneral=SerieLote.Empresa=<T>{Empresa}<T> AND <BR>SerieLote.Articulo=<T>{Info.Articulo}<T> AND <BR>ROUND(SerieLote.Existencia, 2)>0

[Lista.SerieLote.SubCuenta]
Carpeta=Lista
Clave=SerieLote.SubCuenta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.SerieLote.SerieLote]
Carpeta=Lista
Clave=SerieLote.SerieLote
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.SerieLote.Existencia]
Carpeta=Lista
Clave=SerieLote.Existencia
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.SerieLote.ExistenciaAlterna]
Carpeta=Lista
Clave=SerieLote.ExistenciaAlterna
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.SerieLote.Cliente]
Carpeta=Lista
Clave=SerieLote.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SerieLote.Localizacion]
Carpeta=Lista
Clave=SerieLote.Localizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
SubCuenta=99
SerieLote=94
Almacen=75
Existencia=61
ExistenciaAlterna=60
Cliente=93
Localizacion=65

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=SerieLote.SubCuenta
SerieLote.SubCuenta=SerieLote.SerieLote
SerieLote.SerieLote=SerieLote.Existencia
SerieLote.Existencia=SerieLote.ExistenciaAlterna
SerieLote.ExistenciaAlterna=SerieLote.Localizacion
SerieLote.Localizacion=SerieLote.Cliente
SerieLote.Cliente=(Fin)
