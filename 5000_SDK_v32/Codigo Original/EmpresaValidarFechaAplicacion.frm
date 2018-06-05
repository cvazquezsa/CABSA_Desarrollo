
[Forma]
Clave=EmpresaValidarFechaAplicacion
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Validar Fechas de Aplicación por Ejercicio y Periodo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Movimientos
CarpetaPrincipal=Movimientos
Comentarios=Info.Empresa
PosicionInicialAlturaCliente=273
PosicionInicialAncho=679
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=343
PosicionInicialArriba=208
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Movimientos]
Estilo=Hoja
Clave=Movimientos
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaValidarFechaAplicacion
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

ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos


FiltroGeneral=EmpresaValidarFechaAplicacion.Empresa = <T>{Info.Empresa}<T>
[Movimientos.EmpresaValidarFechaAplicacion.Modulo]
Carpeta=Movimientos
Clave=EmpresaValidarFechaAplicacion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Movimientos.EmpresaValidarFechaAplicacion.Mov]
Carpeta=Movimientos
Clave=EmpresaValidarFechaAplicacion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Movimientos.EmpresaValidarFechaAplicacion.AplicaModulo]
Carpeta=Movimientos
Clave=EmpresaValidarFechaAplicacion.AplicaModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Movimientos.EmpresaValidarFechaAplicacion.AplicaMov]
Carpeta=Movimientos
Clave=EmpresaValidarFechaAplicacion.AplicaMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Movimientos.Columnas]
Modulo=75
Mov=153
AplicaModulo=88
AplicaMov=168



[Movimientos.ListaEnCaptura]
(Inicio)=EmpresaValidarFechaAplicacion.AplicaModulo
EmpresaValidarFechaAplicacion.AplicaModulo=EmpresaValidarFechaAplicacion.AplicaMov
EmpresaValidarFechaAplicacion.AplicaMov=EmpresaValidarFechaAplicacion.Modulo
EmpresaValidarFechaAplicacion.Modulo=EmpresaValidarFechaAplicacion.Mov
EmpresaValidarFechaAplicacion.Mov=(Fin)

[Movimientos.ListaOrden]
(Inicio)=EmpresaValidarFechaAplicacion.Modulo	(Acendente)
EmpresaValidarFechaAplicacion.Modulo	(Acendente)=EmpresaValidarFechaAplicacion.Mov	(Acendente)
EmpresaValidarFechaAplicacion.Mov	(Acendente)=EmpresaValidarFechaAplicacion.AplicaModulo	(Acendente)
EmpresaValidarFechaAplicacion.AplicaModulo	(Acendente)=EmpresaValidarFechaAplicacion.AplicaMov	(Acendente)
EmpresaValidarFechaAplicacion.AplicaMov	(Acendente)=(Fin)


