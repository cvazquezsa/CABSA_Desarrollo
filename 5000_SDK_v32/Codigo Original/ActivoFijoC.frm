[Forma]
Clave=ActivoFijoC
Nombre=<T>Consecutivos - Activos Fijos<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=291
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=442
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
Vista=ActivoFijoC
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
FiltroGeneral=Sucursal={Sucursal} AND ActivoFijoC.Empresa=<T>{Empresa}<T>

[Hoja.ActivoFijoC.Mov]
Carpeta=Hoja
Clave=ActivoFijoC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ActivoFijoC.Periodo]
Carpeta=Hoja
Clave=ActivoFijoC.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ActivoFijoC.Ejercicio]
Carpeta=Hoja
Clave=ActivoFijoC.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ActivoFijoC.Consecutivo]
Carpeta=Hoja
Clave=ActivoFijoC.Consecutivo
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
Serie=94
Periodo=43
Ejercicio=47
Consecutivo=99

[Hoja.ActivoFijoC.Serie]
Carpeta=Hoja
Clave=ActivoFijoC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=ActivoFijoC.Mov
ActivoFijoC.Mov=ActivoFijoC.Periodo
ActivoFijoC.Periodo=ActivoFijoC.Ejercicio
ActivoFijoC.Ejercicio=ActivoFijoC.Serie
ActivoFijoC.Serie=ActivoFijoC.Consecutivo
ActivoFijoC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=ActivoFijoC.Mov<TAB>(Acendente)
ActivoFijoC.Mov<TAB>(Acendente)=ActivoFijoC.Serie<TAB>(Acendente)
ActivoFijoC.Serie<TAB>(Acendente)=ActivoFijoC.Periodo<TAB>(Acendente)
ActivoFijoC.Periodo<TAB>(Acendente)=ActivoFijoC.Ejercicio<TAB>(Acendente)
ActivoFijoC.Ejercicio<TAB>(Acendente)=(Fin)
