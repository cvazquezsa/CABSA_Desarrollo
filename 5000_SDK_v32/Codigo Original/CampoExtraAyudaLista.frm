[Forma]
Clave=CampoExtraAyudaLista
Nombre=Ayuda - Lista de Opciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=391
PosicionInicialArriba=272
PosicionInicialAlturaCliente=453
PosicionInicialAncho=498
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
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
Vista=CampoExtraAyudaLista
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
ListaOrden=CampoExtraAyudaLista.Orden<TAB>(Acendente)
HojaTitulos=S
HojaMostrarColumnas=S
FiltroGeneral=CampoExtraAyudaLista.CampoExtra=<T>{Info.CampoExtra}<T>

[Lista.CampoExtraAyudaLista.Opcion]
Carpeta=Lista
Clave=CampoExtraAyudaLista.Opcion
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

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
AntesExpresiones=Forma(<T>CampoExtraAyudaListaOrdenar<T>)
DespuesGuardar=S
Visible=S

[Lista.CampoExtraAyudaLista.Puntos]
Carpeta=Lista
Clave=CampoExtraAyudaLista.Puntos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CampoExtraAyudaLista.Opcion
CampoExtraAyudaLista.Opcion=CampoExtraAyudaLista.Puntos
CampoExtraAyudaLista.Puntos=(Fin)
