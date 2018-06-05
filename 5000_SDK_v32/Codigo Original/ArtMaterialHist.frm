[Forma]
Clave=ArtMaterialHist
Nombre=Bitácora - Listas de Materiales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=498
PosicionInicialArriba=362
PosicionInicialAlturaCliente=273
PosicionInicialAncho=284
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtMaterialHist
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
FiltroGeneral=ArtMaterialHist.Articulo=<T>{Info.Articulo}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.ArtMaterialHist.FechaD]
Carpeta=Lista
Clave=ArtMaterialHist.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtMaterialHist.FechaA]
Carpeta=Lista
Clave=ArtMaterialHist.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
FechaD=91
FechaA=94

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar...
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.FechaD, SQL(<T>SELECT MAX(FechaA)+1 FROM ArtMaterialHist WHERE Articulo=:tArt<T>, Info.Articulo))<BR>Asigna(Info.FechaA, Hoy)<BR>Si<BR>  Forma(<T>ArtMaterialGuardar<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spArtMaterialHist :tArt, :fFechaD, :fFechaA<T>, Info.Articulo, Info.FechaD, Info.FechaA) <BR>  Forma.ActualizarForma<BR>Fin

[Acciones.Ver]
Nombre=Ver
Boton=57
NombreEnBoton=S
NombreDesplegar=&Ver Lista Materiales
GuardarConfirmar=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtMaterialHistD
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtMaterialHist:ArtMaterialHist.ID)
Antes=S
AntesExpresiones=Asigna(Info.ID, ArtMaterialHist:ArtMaterialHist.ID)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Ver
Ver=Guardar
Guardar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtMaterialHist.FechaD
ArtMaterialHist.FechaD=ArtMaterialHist.FechaA
ArtMaterialHist.FechaA=(Fin)
