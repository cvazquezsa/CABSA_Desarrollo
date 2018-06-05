[Forma]
Clave=ListaPreciosInfo
Nombre=Listas Precios Específicos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAltura=314
PosicionInicialAncho=336
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=344
PosicionInicialArriba=227

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaPrecios
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
OtroOrden=S
ListaOrden=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ListaPrecios.Lista = {Comillas(Info.Lista)}

[Lista.ListaPrecios.Lista]
Carpeta=Lista
Clave=ListaPrecios.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Cerrar 
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S
GuardarAntes=S

[Lista.Columnas]
Lista=166
Moneda=68
PreciosNetos=72
Nombre=304

[Lista.ListaPrecios.Moneda]
Carpeta=Lista
Clave=ListaPrecios.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaPrecios.PreciosNetos]
Carpeta=Lista
Clave=ListaPrecios.PreciosNetos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ver]
Nombre=Ver
Boton=47
NombreEnBoton=S
NombreDesplegar=&Ver Lista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaPreciosDInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ListaPrecios:ListaPrecios.Lista) y ConDatos(ListaPrecios:ListaPrecios.Moneda)
Antes=S
AntesExpresiones=Asigna(Info.Lista, ListaPrecios:ListaPrecios.Lista)<BR>Asigna(Info.Moneda, ListaPrecios:ListaPrecios.Moneda)<BR>Asigna(Info.TipoCambio, ListaPrecios:Mon.TipoCambio)
DespuesGuardar=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ver
Ver=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ListaPrecios.Lista
ListaPrecios.Lista=ListaPrecios.Moneda
ListaPrecios.Moneda=ListaPrecios.PreciosNetos
ListaPrecios.PreciosNetos=(Fin)

[Lista.ListaOrden]
(Inicio)=ListaPrecios.Lista<TAB>(Acendente)
ListaPrecios.Lista<TAB>(Acendente)=Mon.Orden<TAB>(Acendente)
Mon.Orden<TAB>(Acendente)=(Fin)
