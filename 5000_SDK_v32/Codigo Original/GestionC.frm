[Forma]
Clave=GestionC
Nombre=<T>Consecutivos - Gestión<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=787
PosicionInicialArriba=445
PosicionInicialAltura=300
PosicionInicialAncho=346
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
Vista=GestionC
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
ListaEnGestion=GestionC.Mov<BR>GestionC.Serie<BR>GestionC.Consecutivo
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
ListaEnCaptura=(Lista)
FiltroGeneral=Sucursal={Sucursal} AND GestionC.Empresa=<T>{Empresa}<T>

[Hoja.GestionC.Mov]
Carpeta=Hoja
Clave=GestionC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.GestionC.Consecutivo]
Carpeta=Hoja
Clave=GestionC.Consecutivo
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
ID=165

[Hoja.GestionC.Serie]
Carpeta=Hoja
Clave=GestionC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaOrden]
(Inicio)=GestionC.Mov<TAB>(Acendente)
GestionC.Mov<TAB>(Acendente)=GestionC.Serie<TAB>(Acendente)
GestionC.Serie<TAB>(Acendente)=GestionC.Periodo<TAB>(Acendente)
GestionC.Periodo<TAB>(Acendente)=GestionC.Ejercicio<TAB>(Acendente)
GestionC.Ejercicio<TAB>(Acendente)=(Fin)

[Hoja.ListaEnCaptura]
(Inicio)=GestionC.Mov
GestionC.Mov=GestionC.Serie
GestionC.Serie=GestionC.Consecutivo
GestionC.Consecutivo=(Fin)
