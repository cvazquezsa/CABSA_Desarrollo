[Forma]
Clave=DineroC
Nombre=<T>Consecutivos - Dinero<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=419
PosicionInicialArriba=362
PosicionInicialAltura=300
PosicionInicialAncho=441
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
Vista=DineroC
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
FiltroGeneral=Sucursal={Sucursal} AND DineroC.Empresa=<T>{Empresa}<T>

[Hoja.DineroC.Mov]
Carpeta=Hoja
Clave=DineroC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.DineroC.Serie]
Carpeta=Hoja
Clave=DineroC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.DineroC.Consecutivo]
Carpeta=Hoja
Clave=DineroC.Consecutivo
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

[Hoja.ListaEnCaptura]
(Inicio)=DineroC.Mov
DineroC.Mov=DineroC.Serie
DineroC.Serie=DineroC.Consecutivo
DineroC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=DineroC.Mov<TAB>(Acendente)
DineroC.Mov<TAB>(Acendente)=DineroC.Serie<TAB>(Acendente)
DineroC.Serie<TAB>(Acendente)=DineroC.Periodo<TAB>(Acendente)
DineroC.Periodo<TAB>(Acendente)=DineroC.Ejercicio<TAB>(Acendente)
DineroC.Ejercicio<TAB>(Acendente)=(Fin)
