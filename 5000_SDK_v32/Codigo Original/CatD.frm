[Forma]
Clave=CatD
Nombre=Páginas del Catálogo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=577
PosicionInicialArriba=344
PosicionInicialAlturaCliente=477
PosicionInicialAncho=766
Comentarios=Info.Catalogo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

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
Vista=CatD
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
ListaOrden=CatD.Orden<TAB>(Acendente)
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
FiltroGeneral=CatD.Catalogo=<T>{Info.Catalogo}<T>

[Lista.CatD.Pagina]
Carpeta=Lista
Clave=CatD.Pagina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CatD.Nombre]
Carpeta=Lista
Clave=CatD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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
Pagina=124
Nombre=604

[Acciones.Cfg]
Nombre=Cfg
Boton=47
NombreEnBoton=S
NombreDesplegar=&Configurar Página
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=Asigna(Info.Pagina, CatD:CatD.Pagina)<BR>Asigna(Info.Nombre, CatD:CatD.Nombre)<BR>ConfigurarCatalogo(Info.Titulo+<T> - <T>+CatD:CatD.Nombre, Info.Catalogo, CatD:CatD.Pagina, <T>CatDBoton<T>, <T>Info.Boton<T>)
EjecucionCondicion=ConDatos(CatD:CatD.Pagina)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cfg
Cfg=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CatD.Pagina
CatD.Pagina=CatD.Nombre
CatD.Nombre=(Fin)
