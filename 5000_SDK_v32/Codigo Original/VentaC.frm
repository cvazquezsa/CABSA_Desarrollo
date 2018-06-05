[Forma]
Clave=VentaC
Nombre=<T>Consecutivos - Ventas<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=778
PosicionInicialArriba=446
PosicionInicialAltura=300
PosicionInicialAncho=364
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=
VentanaEscCerrar=
Comentarios=Empresa
PosicionInicialAlturaCliente=273

[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaC
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
FiltroGeneral=Sucursal={Sucursal} AND VentaC.Empresa=<T>{Empresa}<T>

[Hoja.VentaC.Mov]
Carpeta=Hoja
Clave=VentaC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.VentaC.Consecutivo]
Carpeta=Hoja
Clave=VentaC.Consecutivo
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

[Hoja.VentaC.Serie]
Carpeta=Hoja
Clave=VentaC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=VentaC.Mov
VentaC.Mov=VentaC.Serie
VentaC.Serie=VentaC.Consecutivo
VentaC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=VentaC.Mov<TAB>(Acendente)
VentaC.Mov<TAB>(Acendente)=VentaC.Serie<TAB>(Acendente)
VentaC.Serie<TAB>(Acendente)=VentaC.Periodo<TAB>(Acendente)
VentaC.Periodo<TAB>(Acendente)=VentaC.Ejercicio<TAB>(Acendente)
VentaC.Ejercicio<TAB>(Acendente)=(Fin)
