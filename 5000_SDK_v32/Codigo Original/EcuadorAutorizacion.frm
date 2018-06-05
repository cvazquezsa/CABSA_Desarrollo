
[Forma]
Clave=EcuadorAutorizacion
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Autorizaciónes Ecuador
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
Comentarios=Lista(Info.ConsecutivoModulo, Info.Mov)
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=443
PosicionInicialAncho=924
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=258
PosicionInicialArriba=215
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EcuadorAutorizacion
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

ListaOrden=(Lista)
PermiteEditar=S
FiltroGeneral=EcuadorAutorizacion.Modulo = {Comillas(Info.ConsecutivoModulo)} AND EcuadorAutorizacion.Mov = {Comillas(Info.Mov)}
[Lista.EcuadorAutorizacion.Empresa]
Carpeta=Lista
Clave=EcuadorAutorizacion.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.EcuadorAutorizacion.Sucursal]
Carpeta=Lista
Clave=EcuadorAutorizacion.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.EcuadorAutorizacion.Serie]
Carpeta=Lista
Clave=EcuadorAutorizacion.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.EcuadorAutorizacion.FolioD]
Carpeta=Lista
Clave=EcuadorAutorizacion.FolioD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EcuadorAutorizacion.FolioA]
Carpeta=Lista
Clave=EcuadorAutorizacion.FolioA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EcuadorAutorizacion.Autorizacion]
Carpeta=Lista
Clave=EcuadorAutorizacion.Autorizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.EcuadorAutorizacion.PuntoEmision]
Carpeta=Lista
Clave=EcuadorAutorizacion.PuntoEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.EcuadorAutorizacion.FechaRegistro]
Carpeta=Lista
Clave=EcuadorAutorizacion.FechaRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.EcuadorAutorizacion.Vigencia]
Carpeta=Lista
Clave=EcuadorAutorizacion.Vigencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Acciones.Aceptar]
Nombre=Aceptar
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
Empresa=51
Nombre=137
Nivel=49
Sucursal=46
Nombre_1=123
Serie=64
FolioD=44
FolioA=48
Autorizacion=73
PuntoEmision=73
FechaRegistro=78
Vigencia=68









Establecimiento=81


[Lista.EcuadorAutorizacion.Establecimiento]
Carpeta=Lista
Clave=EcuadorAutorizacion.Establecimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=EcuadorAutorizacion.Empresa
EcuadorAutorizacion.Empresa=Empresa.Nombre
Empresa.Nombre=EcuadorAutorizacion.Sucursal
EcuadorAutorizacion.Sucursal=Sucursal.Nombre
Sucursal.Nombre=EcuadorAutorizacion.Serie
EcuadorAutorizacion.Serie=EcuadorAutorizacion.FolioD
EcuadorAutorizacion.FolioD=EcuadorAutorizacion.FolioA
EcuadorAutorizacion.FolioA=EcuadorAutorizacion.Establecimiento
EcuadorAutorizacion.Establecimiento=EcuadorAutorizacion.PuntoEmision
EcuadorAutorizacion.PuntoEmision=EcuadorAutorizacion.Autorizacion
EcuadorAutorizacion.Autorizacion=EcuadorAutorizacion.Vigencia
EcuadorAutorizacion.Vigencia=EcuadorAutorizacion.FechaRegistro
EcuadorAutorizacion.FechaRegistro=(Fin)

[Lista.ListaOrden]
(Inicio)=EcuadorAutorizacion.Empresa	(Acendente)
EcuadorAutorizacion.Empresa	(Acendente)=EcuadorAutorizacion.Sucursal	(Acendente)
EcuadorAutorizacion.Sucursal	(Acendente)=EcuadorAutorizacion.Serie	(Acendente)
EcuadorAutorizacion.Serie	(Acendente)=EcuadorAutorizacion.FolioD	(Acendente)
EcuadorAutorizacion.FolioD	(Acendente)=EcuadorAutorizacion.FolioA	(Acendente)
EcuadorAutorizacion.FolioA	(Acendente)=(Fin)
