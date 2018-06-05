[Forma]
Clave=NominaC
Nombre=<T>Consecutivos - Nómina<T>
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
Vista=NominaC
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
FiltroGeneral=Sucursal={Sucursal} AND NominaC.Empresa=<T>{Empresa}<T>

[Hoja.NominaC.Mov]
Carpeta=Hoja
Clave=NominaC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.NominaC.Consecutivo]
Carpeta=Hoja
Clave=NominaC.Consecutivo
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

[Hoja.NominaC.Serie]
Carpeta=Hoja
Clave=NominaC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.NominaC.Ejercicio]
Carpeta=Hoja
Clave=NominaC.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=NominaC.Mov
NominaC.Mov=NominaC.Serie
NominaC.Serie=NominaC.Consecutivo
NominaC.Consecutivo=NominaC.Ejercicio
NominaC.Ejercicio=(Fin)

[Hoja.ListaOrden]
(Inicio)=NominaC.Mov<TAB>(Acendente)
NominaC.Mov<TAB>(Acendente)=NominaC.Serie<TAB>(Acendente)
NominaC.Serie<TAB>(Acendente)=NominaC.Periodo<TAB>(Acendente)
NominaC.Periodo<TAB>(Acendente)=NominaC.Ejercicio<TAB>(Acendente)
NominaC.Ejercicio<TAB>(Acendente)=(Fin)
