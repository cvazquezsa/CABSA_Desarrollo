[Forma]
Clave=CompraC
Nombre=<T>Consecutivos - Compras<T>
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
PosicionInicialAncho=436
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
Vista=CompraC
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
FiltroGeneral=Sucursal={Sucursal} AND CompraC.Empresa=<T>{Empresa}<T>

[Hoja.CompraC.Mov]
Carpeta=Hoja
Clave=CompraC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.CompraC.Periodo]
Carpeta=Hoja
Clave=CompraC.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.CompraC.Ejercicio]
Carpeta=Hoja
Clave=CompraC.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.CompraC.Consecutivo]
Carpeta=Hoja
Clave=CompraC.Consecutivo
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

[Hoja.CompraC.Serie]
Carpeta=Hoja
Clave=CompraC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=CompraC.Mov
CompraC.Mov=CompraC.Periodo
CompraC.Periodo=CompraC.Ejercicio
CompraC.Ejercicio=CompraC.Serie
CompraC.Serie=CompraC.Consecutivo
CompraC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=CompraC.Mov<TAB>(Acendente)
CompraC.Mov<TAB>(Acendente)=CompraC.Serie<TAB>(Acendente)
CompraC.Serie<TAB>(Acendente)=CompraC.Periodo<TAB>(Acendente)
CompraC.Periodo<TAB>(Acendente)=CompraC.Ejercicio<TAB>(Acendente)
CompraC.Ejercicio<TAB>(Acendente)=(Fin)
