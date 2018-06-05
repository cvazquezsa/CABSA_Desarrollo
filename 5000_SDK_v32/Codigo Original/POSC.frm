
[Forma]
Clave=POSC
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Consecutivos POS
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSC
CarpetaPrincipal=POSC
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=282
PosicionInicialArriba=154
PosicionInicialAlturaCliente=513
PosicionInicialAncho=1035
ListaAcciones=Guardar
Comentarios=Empresa
[POSC]
Estilo=Hoja
Clave=POSC
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSC
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

OtroOrden=S
ListaOrden=(Lista)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroGeneral=POSC.Empresa = <T>{Empresa}<T>
BusquedaRapida=S
BusquedaEnLinea=S
[POSC.POSC.Empresa]
Carpeta=POSC
Clave=POSC.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[POSC.POSC.Sucursal]
Carpeta=POSC
Clave=POSC.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSC.Sucursal.Nombre]
Carpeta=POSC
Clave=Sucursal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[POSC.POSC.Mov]
Carpeta=POSC
Clave=POSC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSC.POSC.Prefijo]
Carpeta=POSC
Clave=POSC.Prefijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[POSC.POSC.Consecutivo]
Carpeta=POSC
Clave=POSC.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSC.POSC.Host]
Carpeta=POSC
Clave=POSC.Host
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSC.POSC.FolioD]
Carpeta=POSC
Clave=POSC.FolioD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSC.POSC.FolioA]
Carpeta=POSC
Clave=POSC.FolioA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSC.POSC.noAprobacion]
Carpeta=POSC
Clave=POSC.noAprobacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSC.POSC.fechaAprobacion]
Carpeta=POSC
Clave=POSC.fechaAprobacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSC.Columnas]
Empresa=45
Sucursal=64
Nombre=123
Mov=149
Prefijo=63
Consecutivo=64
Host=41
FolioD=46
FolioA=52
noAprobacion=70
fechaAprobacion=94

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Lista.Columnas]
0=91
1=267





[POSC.ListaEnCaptura]
(Inicio)=POSC.Empresa
POSC.Empresa=POSC.Sucursal
POSC.Sucursal=Sucursal.Nombre
Sucursal.Nombre=POSC.Mov
POSC.Mov=POSC.Prefijo
POSC.Prefijo=POSC.Consecutivo
POSC.Consecutivo=POSC.Host
POSC.Host=POSC.FolioD
POSC.FolioD=POSC.FolioA
POSC.FolioA=POSC.noAprobacion
POSC.noAprobacion=POSC.fechaAprobacion
POSC.fechaAprobacion=(Fin)

[POSC.ListaOrden]
(Inicio)=POSC.Sucursal	(Acendente)
POSC.Sucursal	(Acendente)=POSC.Mov	(Acendente)
POSC.Mov	(Acendente)=(Fin)
