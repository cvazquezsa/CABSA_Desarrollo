
[Forma]
Clave=CfgCuentasContablesAlm
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
BarraHerramientas=S
Nombre=&Configuración Cuentas Contables Almacén
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=ListaCuentasAlmacen
CarpetaPrincipal=ListaCuentasAlmacen
PosicionInicialIzquierda=356
PosicionInicialArriba=124
PosicionInicialAlturaCliente=441
PosicionInicialAncho=653

VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


GuardarAntes=S
[Acciones.ConCuenta]
Nombre=ConCuenta
Boton=71
NombreEnBoton=S
NombreDesplegar=&Con Cuenta
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S


EspacioPrevio=S
ActivoCondicion=Info.Opcion <> <T>ConCuenta<T>
AntesExpresiones=Asigna(Info.Opcion,<T>ConCuenta<T>)
[Acciones.SinCuenta]
Nombre=SinCuenta
Boton=71
NombreEnBoton=S
NombreDesplegar=&Sin Cuenta
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S


ActivoCondicion=Info.Opcion <> <T>SinCuenta<T>
AntesExpresiones=Asigna(Info.Opcion,<T>SinCuenta<T>)
[Acciones.Todos]
Nombre=Todos
Boton=71
NombreEnBoton=S
NombreDesplegar=&Todos
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S



ActivoCondicion=Info.Opcion <> <T>Todos<T>
AntesExpresiones=Asigna(Info.Opcion,<T>Todos<T>)
[ListaCuentasAlmacen]
Estilo=Hoja
Clave=ListaCuentasAlmacen
Filtros=S
OtroOrden=S
MenuLocal=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCuentasContablesAlm
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Normal
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
ListaAcciones=EditarCuentasAlmacen
CarpetaVisible=S

BusquedaRapidaControles=S
FiltroGrupo1=Alm.Tipo
FiltroValida1=Alm.Tipo
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroTodo=S
BusquedaRespetarFiltros=S
FiltroGeneral={Si Info.Opcion = <T>Todos<T> Entonces <T> 1 = 1 <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>ConCuenta<T> Entonces <T> Cuenta IS NOT NULL AND Cuenta NOT LIKE <T>+Comillas(<T><T>)+<T> <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>SinCuenta<T> Entonces <T> Cuenta IS NULL <T> Sino <T><T> Fin}
[ListaCuentasAlmacen.Alm.Nombre]
Carpeta=ListaCuentasAlmacen
Clave=Alm.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[ListaCuentasAlmacen.Alm.Cuenta]
Carpeta=ListaCuentasAlmacen
Clave=Alm.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.EditarCtasAlmacen.ListaCtasAlmacen]
Nombre=ListaCtasAlmacen
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar
Activo=S
Visible=S

[Acciones.EditarCtasAlmacen.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Expresion=Informacion(<T>Cuenta para Almacenes:<T>+Info.Cuenta)
Activo=S
Visible=S

[Acciones.EditarCtasAlmacen.ListaAccionesMultiples]
(Inicio)=ListaCtasAlmacen
ListaCtasAlmacen=Actualizar
Actualizar=(Fin)


[Lista.Columnas]
0=207

[ListaCuentasAlmacen.Columnas]
Nombre=267
Cuenta=93




Tipo=100
[Acciones.EditarCuentasAlmacen]
Nombre=EditarCuentasAlmacen
Boton=0
NombreDesplegar=&Editar Cuentas Almacen
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S



[Acciones.EditarCuentasAlmacen.ListaCuentasAlmacen]
Nombre=ListaCuentasAlmacen
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar

[Acciones.EditarCuentasAlmacen.ActualizarCuentasAlmacen]
Nombre=ActualizarCuentasAlmacen
Boton=0
TipoAccion=Expresion

Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas de almacen<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>ALM<T>,<T>CUENTA<T>,Info.Cuenta,<T><T>)<BR>    ActualizarVista<BR>Fin



[Acciones.EditarCuentasAlmacen.ListaAccionesMultiples]
(Inicio)=ListaCuentasAlmacen
ListaCuentasAlmacen=ActualizarCuentasAlmacen
ActualizarCuentasAlmacen=(Fin)




[ListaCuentasAlmacen.Alm.Tipo]
Carpeta=ListaCuentasAlmacen
Clave=Alm.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco






















[ListaCuentasAlmacen.ListaEnCaptura]
(Inicio)=Alm.Nombre
Alm.Nombre=Alm.Tipo
Alm.Tipo=Alm.Cuenta
Alm.Cuenta=(Fin)













[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=ConCuenta
ConCuenta=SinCuenta
SinCuenta=Todos
Todos=(Fin)
