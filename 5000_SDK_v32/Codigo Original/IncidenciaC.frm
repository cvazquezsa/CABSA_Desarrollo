[Forma]
Clave=IncidenciaC
Nombre=<T>Consecutivos - Incidencias<T>
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
Vista=IncidenciaC
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
FiltroGeneral=Sucursal={Sucursal} AND IncidenciaC.Empresa=<T>{Empresa}<T>

[Hoja.IncidenciaC.Mov]
Carpeta=Hoja
Clave=IncidenciaC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.IncidenciaC.Periodo]
Carpeta=Hoja
Clave=IncidenciaC.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.IncidenciaC.Ejercicio]
Carpeta=Hoja
Clave=IncidenciaC.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.IncidenciaC.Consecutivo]
Carpeta=Hoja
Clave=IncidenciaC.Consecutivo
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

[Hoja.IncidenciaC.Serie]
Carpeta=Hoja
Clave=IncidenciaC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=IncidenciaC.Mov
IncidenciaC.Mov=IncidenciaC.Periodo
IncidenciaC.Periodo=IncidenciaC.Ejercicio
IncidenciaC.Ejercicio=IncidenciaC.Serie
IncidenciaC.Serie=IncidenciaC.Consecutivo
IncidenciaC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=IncidenciaC.Mov<TAB>(Acendente)
IncidenciaC.Mov<TAB>(Acendente)=IncidenciaC.Serie<TAB>(Acendente)
IncidenciaC.Serie<TAB>(Acendente)=IncidenciaC.Periodo<TAB>(Acendente)
IncidenciaC.Periodo<TAB>(Acendente)=IncidenciaC.Ejercicio<TAB>(Acendente)
IncidenciaC.Ejercicio<TAB>(Acendente)=(Fin)
