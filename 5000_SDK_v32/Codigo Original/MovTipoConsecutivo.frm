[Forma]
Clave=MovTipoConsecutivo
Nombre=Control Consecutivos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Mov
PosicionInicialIzquierda=341
PosicionInicialArriba=306
PosicionInicialAlturaCliente=385
PosicionInicialAncho=597
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
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
Vista=MovTipoConsecutivo
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
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=MovTipoConsecutivo.Modulo=<T>{Info.Modulo}<T> AND MovTipoConsecutivo.Mov=<T>{Info.Mov}<T> AND MovTipoConsecutivo.Empresa=<T>{Empresa}<T>

[Lista.Columnas]
Campo=304
TipoAyuda=124
Serie=124
ConsecutivoD=81
ConsecutivoA=75
VigenciaD=94
VigenciaA=94
Estatus=94

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

[Lista.MovTipoConsecutivo.Serie]
Carpeta=Lista
Clave=MovTipoConsecutivo.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoConsecutivo.ConsecutivoD]
Carpeta=Lista
Clave=MovTipoConsecutivo.ConsecutivoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoConsecutivo.ConsecutivoA]
Carpeta=Lista
Clave=MovTipoConsecutivo.ConsecutivoA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoConsecutivo.VigenciaD]
Carpeta=Lista
Clave=MovTipoConsecutivo.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoConsecutivo.VigenciaA]
Carpeta=Lista
Clave=MovTipoConsecutivo.VigenciaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoConsecutivo.Estatus]
Carpeta=Lista
Clave=MovTipoConsecutivo.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=MovTipoConsecutivo.Serie
MovTipoConsecutivo.Serie=MovTipoConsecutivo.ConsecutivoD
MovTipoConsecutivo.ConsecutivoD=MovTipoConsecutivo.ConsecutivoA
MovTipoConsecutivo.ConsecutivoA=MovTipoConsecutivo.VigenciaD
MovTipoConsecutivo.VigenciaD=MovTipoConsecutivo.VigenciaA
MovTipoConsecutivo.VigenciaA=MovTipoConsecutivo.Estatus
MovTipoConsecutivo.Estatus=(Fin)

[Lista.ListaOrden]
(Inicio)=MovTipoConsecutivo.Serie<TAB>(Acendente)
MovTipoConsecutivo.Serie<TAB>(Acendente)=MovTipoConsecutivo.ConsecutivoD<TAB>(Acendente)
MovTipoConsecutivo.ConsecutivoD<TAB>(Acendente)=(Fin)
