[Forma]
Clave=CorteC
Nombre=<T>Consecutivos - Cortes Informativos<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=511
PosicionInicialArriba=208
PosicionInicialAltura=300
PosicionInicialAncho=344
Comentarios=Empresa
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=
VentanaEscCerrar=
PosicionInicialAlturaCliente=273

[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CorteC
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
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Sucursal={Sucursal} AND CorteC.Empresa=<T>{Empresa}<T>

[Hoja.CorteC.Mov]
Carpeta=Hoja
Clave=CorteC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.CorteC.Consecutivo]
Carpeta=Hoja
Clave=CorteC.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Hoja.Columnas]
Mov=126
Serie=84
Periodo=43
Ejercicio=47
Consecutivo=99

[Hoja.CorteC.Serie]
Carpeta=Hoja
Clave=CorteC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=CorteC.Mov
CorteC.Mov=CorteC.Serie
CorteC.Serie=CorteC.Consecutivo
CorteC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=CorteC.Mov<TAB>(Acendente)
CorteC.Mov<TAB>(Acendente)=CorteC.Serie<TAB>(Acendente)
CorteC.Serie<TAB>(Acendente)=CorteC.Periodo<TAB>(Acendente)
CorteC.Periodo<TAB>(Acendente)=CorteC.Ejercicio<TAB>(Acendente)
CorteC.Ejercicio<TAB>(Acendente)=(Fin)
