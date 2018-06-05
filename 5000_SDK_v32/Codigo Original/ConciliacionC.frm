[Forma]
Clave=ConciliacionC
Nombre=<T>Consecutivos - Conciliaciones<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=422
PosicionInicialArriba=362
PosicionInicialAltura=300
PosicionInicialAncho=436
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
Vista=ConciliacionC
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
FiltroGeneral=Sucursal={Sucursal} AND ConciliacionC.Empresa=<T>{Empresa}<T>

[Hoja.ConciliacionC.Mov]
Carpeta=Hoja
Clave=ConciliacionC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ConciliacionC.Periodo]
Carpeta=Hoja
Clave=ConciliacionC.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ConciliacionC.Ejercicio]
Carpeta=Hoja
Clave=ConciliacionC.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ConciliacionC.Consecutivo]
Carpeta=Hoja
Clave=ConciliacionC.Consecutivo
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
Serie=88
Periodo=43
Ejercicio=47
Consecutivo=99

[Hoja.ConciliacionC.Serie]
Carpeta=Hoja
Clave=ConciliacionC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=ConciliacionC.Mov
ConciliacionC.Mov=ConciliacionC.Periodo
ConciliacionC.Periodo=ConciliacionC.Ejercicio
ConciliacionC.Ejercicio=ConciliacionC.Serie
ConciliacionC.Serie=ConciliacionC.Consecutivo
ConciliacionC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=ConciliacionC.Mov<TAB>(Acendente)
ConciliacionC.Mov<TAB>(Acendente)=ConciliacionC.Serie<TAB>(Acendente)
ConciliacionC.Serie<TAB>(Acendente)=ConciliacionC.Periodo<TAB>(Acendente)
ConciliacionC.Periodo<TAB>(Acendente)=ConciliacionC.Ejercicio<TAB>(Acendente)
ConciliacionC.Ejercicio<TAB>(Acendente)=(Fin)
