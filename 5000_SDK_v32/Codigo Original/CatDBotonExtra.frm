[Forma]
Clave=CatDBotonExtra
Nombre=Campos Extras del Botón
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Boton, Info.Etiqueta)
PosicionInicialAlturaCliente=371
PosicionInicialAncho=705
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=607
PosicionInicialArriba=396
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CatDBotonExtra
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
ListaOrden=CatDBotonExtra.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroGeneral=CatDBotonExtra.Catalogo=<T>{Info.Catalogo}<T> AND CatDBotonExtra.Boton=<T>{Info.Boton}<T>

[Lista.CatDBotonExtra.Campo]
Carpeta=Lista
Clave=CatDBotonExtra.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CatDBotonExtra.Nombre]
Carpeta=Lista
Clave=CatDBotonExtra.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CatDBotonExtra.Tipo]
Carpeta=Lista
Clave=CatDBotonExtra.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CatDBotonExtra.Orden]
Carpeta=Lista
Clave=CatDBotonExtra.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Campo=235
Nombre=268
Tipo=124
Orden=38

[Lista.ListaEnCaptura]
(Inicio)=CatDBotonExtra.Campo
CatDBotonExtra.Campo=CatDBotonExtra.Nombre
CatDBotonExtra.Nombre=CatDBotonExtra.Tipo
CatDBotonExtra.Tipo=CatDBotonExtra.Orden
CatDBotonExtra.Orden=(Fin)
