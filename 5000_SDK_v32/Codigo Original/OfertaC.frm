[Forma]
Clave=OfertaC
Nombre=<T>Consecutivos - Ofertas<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrOFERipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=742
PosicionInicialArriba=450
PosicionInicialAltura=300
PosicionInicialAncho=436
Comentarios=Empresa
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=
VentanaEscCerrar=
PosicionInicialAlturaCliente=273
CarpetaPrincipal=Hoja

[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OfertaC
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
FiltroGeneral=Sucursal={Sucursal} AND OfertaC.Empresa=<T>{Empresa}<T>

[Hoja.OfertaC.Mov]
Carpeta=Hoja
Clave=OfertaC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.OfertaC.Periodo]
Carpeta=Hoja
Clave=OfertaC.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.OfertaC.Ejercicio]
Carpeta=Hoja
Clave=OfertaC.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.OfertaC.Consecutivo]
Carpeta=Hoja
Clave=OfertaC.Consecutivo
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

[Hoja.OfertaC.Serie]
Carpeta=Hoja
Clave=OfertaC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=OfertaC.Mov
OfertaC.Mov=OfertaC.Periodo
OfertaC.Periodo=OfertaC.Ejercicio
OfertaC.Ejercicio=OfertaC.Serie
OfertaC.Serie=OfertaC.Consecutivo
OfertaC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=OfertaC.Mov<TAB>(Acendente)
OfertaC.Mov<TAB>(Acendente)=OfertaC.Serie<TAB>(Acendente)
OfertaC.Serie<TAB>(Acendente)=OfertaC.Periodo<TAB>(Acendente)
OfertaC.Periodo<TAB>(Acendente)=OfertaC.Ejercicio<TAB>(Acendente)
OfertaC.Ejercicio<TAB>(Acendente)=(Fin)
