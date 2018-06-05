[Forma]
Clave=FormaExtraCampoAyudaLista
Nombre=Ayuda - Lista de Opciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=725
PosicionInicialArriba=355
PosicionInicialAlturaCliente=453
PosicionInicialAncho=479
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Nombre

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraCampoAyudaLista
Fuente={Tahoma, 8, Negro, []}
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=FormaExtraCampoAyudaLista.Orden<TAB>(Acendente)
HojaTitulos=S
HojaMostrarColumnas=S
FiltroGeneral=FormaExtraCampoAyudaLista.FormaTipo=<T>{Info.FormaTipo}<T> AND FormaExtraCampoAyudaLista.Campo=<T>{Info.Campo}<T>

[Lista.FormaExtraCampoAyudaLista.Opcion]
Carpeta=Lista
Clave=FormaExtraCampoAyudaLista.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Opcion=405
Puntos=64
Orden=35

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

[Lista.FormaExtraCampoAyudaLista.Orden]
Carpeta=Lista
Clave=FormaExtraCampoAyudaLista.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=FormaExtraCampoAyudaLista.Opcion
FormaExtraCampoAyudaLista.Opcion=FormaExtraCampoAyudaLista.Orden
FormaExtraCampoAyudaLista.Orden=(Fin)
