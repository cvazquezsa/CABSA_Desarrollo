[Forma]
Clave=EmpresaCfgCxcVoucher
Nombre=Configuración del Voucher (Cxc)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=476
PosicionInicialArriba=297
PosicionInicialAlturaCliente=420
PosicionInicialAncho=328
Comentarios=Empresa
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgCxcVoucher
Fuente={Tahoma, 8, Negro, []}
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=EmpresaCfgCxcVoucher.Empresa=<T>{Empresa}<T>

[Lista.EmpresaCfgCxcVoucher.Mov]
Carpeta=Lista
Clave=EmpresaCfgCxcVoucher.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgCxcVoucher.MovGenerar]
Carpeta=Lista
Clave=EmpresaCfgCxcVoucher.MovGenerar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Mov=155
MovGenerar=143

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgCxcVoucher.Mov
EmpresaCfgCxcVoucher.Mov=EmpresaCfgCxcVoucher.MovGenerar
EmpresaCfgCxcVoucher.MovGenerar=(Fin)
