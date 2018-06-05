[Forma]
Clave=OpcionListaD
Nombre=Detalles de la Lista
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Opcion, Info.Descripcion, Info.Lista)
PosicionInicialIzquierda=327
PosicionInicialArriba=168
PosicionInicialAltura=300
PosicionInicialAncho=376
VentanaExclusiva=S
PosicionInicialAlturaCliente=443

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OpcionListaD
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
FiltroTipo=Predefinido
FiltroPredefinido1=por Número<BR>por Nombre
FiltroPredefinido2=1=1<BR>1=1
FiltroPredefinido3=OpcionListaD.Numero<BR>OpcionD.Nombre
FiltroEstilo=Directorio
HojaAjustarColumnas=S
FiltroGeneral=OpcionListaD.Opcion=<T>{Info.Opcion}<T> AND OpcionListaD.Lista=<T>{Info.Lista}<T>

[Lista.OpcionListaD.Numero]
Carpeta=Lista
Clave=OpcionListaD.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Nombre=290

[Lista.ListaEnCaptura]
(Inicio)=OpcionListaD.Numero
OpcionListaD.Numero=OpcionD.Nombre
OpcionD.Nombre=(Fin)
