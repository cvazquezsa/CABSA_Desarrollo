[Forma]
Clave=SoporteC
Nombre=<T>Consecutivos - Atención Clientes<T>
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
PosicionInicialAncho=434
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
Vista=SoporteC
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
FiltroGeneral=Sucursal={Sucursal} AND SoporteC.Empresa=<T>{Empresa}<T>

[Hoja.SoporteC.Mov]
Carpeta=Hoja
Clave=SoporteC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.SoporteC.Periodo]
Carpeta=Hoja
Clave=SoporteC.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.SoporteC.Ejercicio]
Carpeta=Hoja
Clave=SoporteC.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.SoporteC.Consecutivo]
Carpeta=Hoja
Clave=SoporteC.Consecutivo
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
Serie=86
Periodo=43
Ejercicio=47
Consecutivo=99

[Hoja.SoporteC.Serie]
Carpeta=Hoja
Clave=SoporteC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=SoporteC.Mov
SoporteC.Mov=SoporteC.Periodo
SoporteC.Periodo=SoporteC.Ejercicio
SoporteC.Ejercicio=SoporteC.Serie
SoporteC.Serie=SoporteC.Consecutivo
SoporteC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=SoporteC.Mov<TAB>(Acendente)
SoporteC.Mov<TAB>(Acendente)=SoporteC.Serie<TAB>(Acendente)
SoporteC.Serie<TAB>(Acendente)=SoporteC.Periodo<TAB>(Acendente)
SoporteC.Periodo<TAB>(Acendente)=SoporteC.Ejercicio<TAB>(Acendente)
SoporteC.Ejercicio<TAB>(Acendente)=(Fin)
