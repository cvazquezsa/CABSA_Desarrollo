[Forma]
Clave=CteTarimaChep
Nombre=Tarimas Chep
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=525
PosicionInicialArriba=269
PosicionInicialAltura=350
PosicionInicialAncho=549
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Cliente, Info.Nombre)
ExpresionesAlMostrar=Asigna(Info.Agente, Nulo)
PosicionInicialAlturaCliente=323

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteTarimaChep
Fuente={MS Sans Serif, 8, Negro, []}
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
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=CteTarimaChep.Cliente=<T>{Info.Cliente}<T>
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
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(AgenteCte:AgenteCte.Agente)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Lista.Columnas]
Cliente=116
Nombre=285
Comision=59
Agente=96
Nombre_1=304
Empresa=58



Articulo=124
UnidadVenta=91
TarimaChep=111
CantidadTarima=87
CantidadEstibas=91

Descripcion1=244
[Lista.CteTarimaChep.Articulo]
Carpeta=Lista
Clave=CteTarimaChep.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CteTarimaChep.UnidadVenta]
Carpeta=Lista
Clave=CteTarimaChep.UnidadVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CteTarimaChep.TarimaChep]
Carpeta=Lista
Clave=CteTarimaChep.TarimaChep
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CteTarimaChep.CantidadTarima]
Carpeta=Lista
Clave=CteTarimaChep.CantidadTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CteTarimaChep.CantidadEstibas]
Carpeta=Lista
Clave=CteTarimaChep.CantidadEstibas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=CteTarimaChep.Articulo
CteTarimaChep.Articulo=CteTarimaChep.UnidadVenta
CteTarimaChep.UnidadVenta=CteTarimaChep.TarimaChep
CteTarimaChep.TarimaChep=CteTarimaChep.CantidadTarima
CteTarimaChep.CantidadTarima=CteTarimaChep.CantidadEstibas
CteTarimaChep.CantidadEstibas=(Fin)
