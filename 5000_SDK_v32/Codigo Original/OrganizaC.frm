[Forma]
Clave=OrganizaC
Nombre=<T>Consecutivos - Organiza<T>
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
VentanaTipoMarco=Di�logo
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
Vista=OrganizaC
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
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
FiltroGeneral=Sucursal={Sucursal} AND OrganizaC.Empresa=<T>{Empresa}<T>

[Hoja.OrganizaC.Mov]
Carpeta=Hoja
Clave=OrganizaC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.OrganizaC.Consecutivo]
Carpeta=Hoja
Clave=OrganizaC.Consecutivo
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

[Hoja.OrganizaC.Serie]
Carpeta=Hoja
Clave=OrganizaC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=OrganizaC.Mov
OrganizaC.Mov=OrganizaC.Serie
OrganizaC.Serie=OrganizaC.Consecutivo
OrganizaC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=OrganizaC.Mov<TAB>(Acendente)
OrganizaC.Mov<TAB>(Acendente)=OrganizaC.Serie<TAB>(Acendente)
OrganizaC.Serie<TAB>(Acendente)=OrganizaC.Periodo<TAB>(Acendente)
OrganizaC.Periodo<TAB>(Acendente)=OrganizaC.Ejercicio<TAB>(Acendente)
OrganizaC.Ejercicio<TAB>(Acendente)=(Fin)
