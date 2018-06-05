[Forma]
Clave=ClaseTarea
Nombre=Tareas por Omisión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Clase, Info.SubClase)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=321
PosicionInicialArriba=302
PosicionInicialAlturaCliente=392
PosicionInicialAncho=638

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ClaseTarea
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
HojaTitulos=S
HojaMostrarColumnas=S
OtroOrden=S
ListaOrden=ClaseTarea.Orden<TAB>(Acendente)
FiltroGeneral=ClaseTarea.Modulo=<T>{Info.Modulo}<T> AND ClaseTarea.Clase=<T>{Info.Clase}<T> AND ClaseTarea.SubClase<BR>{Si(ConDatos(Info.SubClase), <T>=<T>+Comillas(Info.SubClase), <T> IS NOT NULL<T>)}

[Lista.ClaseTarea.Tarea]
Carpeta=Lista
Clave=ClaseTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
Tarea=352
Dias=46
Forzosa=45
Orden=38
Tipo=124

[Lista.ClaseTarea.Dias]
Carpeta=Lista
Clave=ClaseTarea.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseTarea.Forzosa]
Carpeta=Lista
Clave=ClaseTarea.Forzosa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseTarea.Orden]
Carpeta=Lista
Clave=ClaseTarea.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseTarea.Tipo]
Carpeta=Lista
Clave=ClaseTarea.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ClaseTarea.Tarea
ClaseTarea.Tarea=ClaseTarea.Tipo
ClaseTarea.Tipo=ClaseTarea.Dias
ClaseTarea.Dias=ClaseTarea.Forzosa
ClaseTarea.Forzosa=ClaseTarea.Orden
ClaseTarea.Orden=(Fin)
