[Forma]
Clave=ReclutaC
Nombre=<T>Consecutivos - Recluta<T>
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
Vista=ReclutaC
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
FiltroGeneral=Sucursal={Sucursal} AND ReclutaC.Empresa=<T>{Empresa}<T>

[Hoja.ReclutaC.Mov]
Carpeta=Hoja
Clave=ReclutaC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ReclutaC.Consecutivo]
Carpeta=Hoja
Clave=ReclutaC.Consecutivo
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

[Hoja.ReclutaC.Serie]
Carpeta=Hoja
Clave=ReclutaC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=ReclutaC.Mov
ReclutaC.Mov=ReclutaC.Serie
ReclutaC.Serie=ReclutaC.Consecutivo
ReclutaC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=ReclutaC.Mov<TAB>(Acendente)
ReclutaC.Mov<TAB>(Acendente)=ReclutaC.Serie<TAB>(Acendente)
ReclutaC.Serie<TAB>(Acendente)=ReclutaC.Periodo<TAB>(Acendente)
ReclutaC.Periodo<TAB>(Acendente)=ReclutaC.Ejercicio<TAB>(Acendente)
ReclutaC.Ejercicio<TAB>(Acendente)=(Fin)
