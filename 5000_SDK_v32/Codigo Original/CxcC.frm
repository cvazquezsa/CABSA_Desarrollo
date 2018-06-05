[Forma]
Clave=CxcC
Nombre=<T>Consecutivos - Cuentas por Cobrar<T>
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
PosicionInicialAncho=346
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
Vista=CxcC
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
FiltroGeneral=Sucursal={Sucursal} AND CxcC.Empresa=<T>{Empresa}<T>

[Hoja.CxcC.Mov]
Carpeta=Hoja
Clave=CxcC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.CxcC.Consecutivo]
Carpeta=Hoja
Clave=CxcC.Consecutivo
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
Serie=90
Periodo=43
Ejercicio=47
Consecutivo=99

[Hoja.CxcC.Serie]
Carpeta=Hoja
Clave=CxcC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=CxcC.Mov
CxcC.Mov=CxcC.Serie
CxcC.Serie=CxcC.Consecutivo
CxcC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=CxcC.Mov<TAB>(Acendente)
CxcC.Mov<TAB>(Acendente)=CxcC.Serie<TAB>(Acendente)
CxcC.Serie<TAB>(Acendente)=CxcC.Periodo<TAB>(Acendente)
CxcC.Periodo<TAB>(Acendente)=CxcC.Ejercicio<TAB>(Acendente)
CxcC.Ejercicio<TAB>(Acendente)=(Fin)
