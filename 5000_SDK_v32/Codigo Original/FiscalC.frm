[Forma]
Clave=FiscalC
Nombre=<T>Consecutivos - Fiscal<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=468
PosicionInicialArriba=246
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
Vista=FiscalC
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
FiltroGeneral=Sucursal={Sucursal} AND FiscalC.Empresa=<T>{Empresa}<T>

[Hoja.FiscalC.Mov]
Carpeta=Hoja
Clave=FiscalC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.FiscalC.Consecutivo]
Carpeta=Hoja
Clave=FiscalC.Consecutivo
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

[Hoja.FiscalC.Serie]
Carpeta=Hoja
Clave=FiscalC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=FiscalC.Mov
FiscalC.Mov=FiscalC.Serie
FiscalC.Serie=FiscalC.Consecutivo
FiscalC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=FiscalC.Mov<TAB>(Acendente)
FiscalC.Mov<TAB>(Acendente)=FiscalC.Serie<TAB>(Acendente)
FiscalC.Serie<TAB>(Acendente)=FiscalC.Periodo<TAB>(Acendente)
FiscalC.Periodo<TAB>(Acendente)=FiscalC.Ejercicio<TAB>(Acendente)
FiscalC.Ejercicio<TAB>(Acendente)=(Fin)
