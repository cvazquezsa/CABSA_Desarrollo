[Forma]
Clave=CuboCampo
Nombre=Campos del Cubo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=498
PosicionInicialArriba=335
PosicionInicialAlturaCliente=493
PosicionInicialAncho=923
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Info.Cubo

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
Vista=CuboCampo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=CuboCampo.Campo<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=CuboCampo.Cubo=<T>{Info.Cubo}<T>

[Lista.CuboCampo.Campo]
Carpeta=Lista
Clave=CuboCampo.Campo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuboCampo.Etiqueta]
Carpeta=Lista
Clave=CuboCampo.Etiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuboCampo.Tipo]
Carpeta=Lista
Clave=CuboCampo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuboCampo.Formato]
Carpeta=Lista
Clave=CuboCampo.Formato
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
Campo=416
Etiqueta=305
Tipo=71
Formato=91

[Lista.ListaEnCaptura]
(Inicio)=CuboCampo.Campo
CuboCampo.Campo=CuboCampo.Etiqueta
CuboCampo.Etiqueta=CuboCampo.Tipo
CuboCampo.Tipo=CuboCampo.Formato
CuboCampo.Formato=(Fin)
