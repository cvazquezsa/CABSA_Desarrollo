[Forma]
Clave=CPC
Nombre=<T>Consecutivos - CP<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=788
PosicionInicialArriba=446
PosicionInicialAltura=300
PosicionInicialAncho=344
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
Vista=CPC
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
FiltroGeneral=Sucursal={Sucursal} AND CPC.Empresa=<T>{Empresa}<T>

[Hoja.CPC.Mov]
Carpeta=Hoja
Clave=CPC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.CPC.Consecutivo]
Carpeta=Hoja
Clave=CPC.Consecutivo
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

[Hoja.CPC.Serie]
Carpeta=Hoja
Clave=CPC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=CPC.Mov
CPC.Mov=CPC.Serie
CPC.Serie=CPC.Consecutivo
CPC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=CPC.Mov<TAB>(Acendente)
CPC.Mov<TAB>(Acendente)=CPC.Serie<TAB>(Acendente)
CPC.Serie<TAB>(Acendente)=CPC.Periodo<TAB>(Acendente)
CPC.Periodo<TAB>(Acendente)=CPC.Ejercicio<TAB>(Acendente)
CPC.Ejercicio<TAB>(Acendente)=(Fin)
