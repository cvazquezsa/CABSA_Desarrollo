[Forma]
Clave=ModuloExtra01C
Nombre=<T>Consecutivos - ModuloExtra01<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=467
PosicionInicialArriba=358
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
Vista=ModuloExtra01C
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
FiltroGeneral=Sucursal={Sucursal} AND ModuloExtra01C.Empresa=<T>{Empresa}<T>

[Hoja.ModuloExtra01C.Mov]
Carpeta=Hoja
Clave=ModuloExtra01C.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ModuloExtra01C.Consecutivo]
Carpeta=Hoja
Clave=ModuloExtra01C.Consecutivo
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

[Hoja.ModuloExtra01C.Serie]
Carpeta=Hoja
Clave=ModuloExtra01C.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=ModuloExtra01C.Mov
ModuloExtra01C.Mov=ModuloExtra01C.Serie
ModuloExtra01C.Serie=ModuloExtra01C.Consecutivo
ModuloExtra01C.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=ModuloExtra01C.Mov<TAB>(Acendente)
ModuloExtra01C.Mov<TAB>(Acendente)=ModuloExtra01C.Serie<TAB>(Acendente)
ModuloExtra01C.Serie<TAB>(Acendente)=ModuloExtra01C.Periodo<TAB>(Acendente)
ModuloExtra01C.Periodo<TAB>(Acendente)=ModuloExtra01C.Ejercicio<TAB>(Acendente)
ModuloExtra01C.Ejercicio<TAB>(Acendente)=(Fin)
