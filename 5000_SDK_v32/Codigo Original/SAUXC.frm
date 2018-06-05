[Forma]
Clave=SAUXC
Nombre=<T>Consecutivos - SAUX<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=627
PosicionInicialArriba=294
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
Vista=SAUXC
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
FiltroGeneral=Sucursal={Sucursal} AND SAUXC.Empresa=<T>{Empresa}<T>

[Hoja.SAUXC.Mov]
Carpeta=Hoja
Clave=SAUXC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.SAUXC.Consecutivo]
Carpeta=Hoja
Clave=SAUXC.Consecutivo
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

[Hoja.SAUXC.Serie]
Carpeta=Hoja
Clave=SAUXC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=SAUXC.Mov
SAUXC.Mov=SAUXC.Serie
SAUXC.Serie=SAUXC.Consecutivo
SAUXC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=SAUXC.Mov<TAB>(Acendente)
SAUXC.Mov<TAB>(Acendente)=SAUXC.Serie<TAB>(Acendente)
SAUXC.Serie<TAB>(Acendente)=SAUXC.Periodo<TAB>(Acendente)
SAUXC.Periodo<TAB>(Acendente)=SAUXC.Ejercicio<TAB>(Acendente)
SAUXC.Ejercicio<TAB>(Acendente)=(Fin)
