[Forma]
Clave=ArtOpcionD
Nombre=Lista Opciones Especial
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Opcion, Info.Descripcion, Info.Lista)
PosicionInicialIzquierda=429
PosicionInicialArriba=214
PosicionInicialAltura=300
PosicionInicialAncho=756
VentanaExclusiva=S
PosicionInicialAlturaCliente=293

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtOpcionD
Fuente={MS Sans Serif, 8, Negro, []}
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
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=ArtOpcionD.Numero<TAB>(Acendente)
HojaPermiteInsertar=S

FiltroGeneral=ArtOpcionD.Articulo=<T>{Info.Articulo}<T> AND ArtOpcionD.Opcion=<T>{Info.Opcion}<T>
[Lista.ArtOpcionD.Numero]
Carpeta=Lista
Clave=ArtOpcionD.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OpcionD.Nombre]
Carpeta=Lista
Clave=OpcionD.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Numero=56
Nombre=203

InformacionAdicional=234
Imagen=229
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ActivoCondicion=no ArtOpcionD:ArtOpcionD.TieneMovimientos

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=ArtOpcionD.Numero
ArtOpcionD.Numero=OpcionD.Nombre
OpcionD.Nombre=ArtOpcionD.InformacionAdicional
ArtOpcionD.InformacionAdicional=ArtOpcionD.Imagen
ArtOpcionD.Imagen=(Fin)

[Lista.ArtOpcionD.InformacionAdicional]
Carpeta=Lista
Clave=ArtOpcionD.InformacionAdicional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.ArtOpcionD.Imagen]
Carpeta=Lista
Clave=ArtOpcionD.Imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)
