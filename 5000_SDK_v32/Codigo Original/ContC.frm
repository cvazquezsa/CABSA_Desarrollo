[Forma]
Clave=ContC
Nombre=<T>Consecutivos - Contabilidad<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=339
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=432
Comentarios=Empresa
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=
VentanaEscCerrar=

[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContC
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
FiltroGeneral=Sucursal={Sucursal} AND ContC.Empresa=<T>{Empresa}<T>

[Hoja.ContC.Mov]
Carpeta=Hoja
Clave=ContC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ContC.Periodo]
Carpeta=Hoja
Clave=ContC.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ContC.Ejercicio]
Carpeta=Hoja
Clave=ContC.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ContC.Consecutivo]
Carpeta=Hoja
Clave=ContC.Consecutivo
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

[Hoja.ContC.Serie]
Carpeta=Hoja
Clave=ContC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=ContC.Mov
ContC.Mov=ContC.Periodo
ContC.Periodo=ContC.Ejercicio
ContC.Ejercicio=ContC.Serie
ContC.Serie=ContC.Consecutivo
ContC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=ContC.Mov<TAB>(Acendente)
ContC.Mov<TAB>(Acendente)=ContC.Serie<TAB>(Acendente)
ContC.Serie<TAB>(Acendente)=ContC.Periodo<TAB>(Acendente)
ContC.Periodo<TAB>(Acendente)=ContC.Ejercicio<TAB>(Acendente)
ContC.Ejercicio<TAB>(Acendente)=(Fin)
