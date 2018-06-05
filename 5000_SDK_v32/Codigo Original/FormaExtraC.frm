[Forma]
Clave=FormaExtraC
Nombre=<T>Consecutivos - Formas Extras<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=467
PosicionInicialArriba=362
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
Vista=FormaExtraC
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
FiltroGeneral=Sucursal={Sucursal} AND FormaExtraC.Empresa=<T>{Empresa}<T>

[Hoja.FormaExtraC.Mov]
Carpeta=Hoja
Clave=FormaExtraC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.FormaExtraC.Consecutivo]
Carpeta=Hoja
Clave=FormaExtraC.Consecutivo
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

[Hoja.FormaExtraC.Serie]
Carpeta=Hoja
Clave=FormaExtraC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=FormaExtraC.Mov
FormaExtraC.Mov=FormaExtraC.Serie
FormaExtraC.Serie=FormaExtraC.Consecutivo
FormaExtraC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=FormaExtraC.Mov<TAB>(Acendente)
FormaExtraC.Mov<TAB>(Acendente)=FormaExtraC.Serie<TAB>(Acendente)
FormaExtraC.Serie<TAB>(Acendente)=FormaExtraC.Periodo<TAB>(Acendente)
FormaExtraC.Periodo<TAB>(Acendente)=FormaExtraC.Ejercicio<TAB>(Acendente)
FormaExtraC.Ejercicio<TAB>(Acendente)=(Fin)
