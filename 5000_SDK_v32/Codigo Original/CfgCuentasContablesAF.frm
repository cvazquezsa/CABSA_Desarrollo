
[Forma]
Clave=CfgCuentasContablesAF
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=&Configuracion Cuentas Contables Activo Fijo
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaCarpetas=ListaCuentasActivoFijo
CarpetaPrincipal=ListaCuentasActivoFijo
PosicionInicialIzquierda=349
PosicionInicialArriba=156
PosicionInicialAlturaCliente=383
PosicionInicialAncho=624

ExpresionesAlMostrar=Asigna(Info.Opcion,<T>Todos<T>)
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
NombreDesplegar=&SinCuenta
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
[Acciones.EditarCtasActivoFijo.ListaAccionesMultiples]
(Inicio)=ListaCtasActivos
ListaCtasActivos=Actualizar
Actualizar=(Fin)

[ListaCuentasActivoFijo]
Estilo=Hoja
Clave=ListaCuentasActivoFijo
Filtros=S
OtroOrden=S
MenuLocal=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCuentasContablesAF
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=ActivoFCat.Categoria<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
ListaAcciones=EditarCuentasActivoFijo
CarpetaVisible=S

BusquedaRapidaControles=S
FiltroGrupo1=ActivoFCat.Categoria
FiltroValida1=ActivoFCat.Categoria
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroTodo=S
FiltroGeneral={Si Info.Opcion = <T>Todos<T> Entonces <T> 1 = 1 <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>ConCuenta<T> Entonces <T> Cuenta IS NOT NULL AND Cuenta NOT LIKE <T>+Comillas(<T><T>)+<T> <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>SinCuenta<T> Entonces <T> Cuenta IS NULL OR CUENTA LIKE <T>+Comillas(<T><T>)+<T> <T> Sino <T><T> Fin}
[ListaCuentasActivoFijo.ActivoFCat.Categoria]
Carpeta=ListaCuentasActivoFijo
Clave=ActivoFCat.Categoria
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ListaCuentasActivoFijo.ActivoFCat.Cuenta]
Carpeta=ListaCuentasActivoFijo
Clave=ActivoFCat.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Acciones.EditarCtasActivoFijo.ActualizarCuentasActivoFijo]
Nombre=ActualizarCuentasActivoFijo
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas de activo fijo<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta<T>,<T>ACTIVOFCAT<T>,<T>CUENTA<T>,Info.Cuenta)<BR>    ActualizarVista<BR>Fin
Activo=S
Visible=S

[Acciones.EditarCtasActivoFijo.ListaCuentasActivoFijo]
Nombre=ListaCuentasActivoFijo
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar
Activo=S
Visible=S

[Acciones.EditarCuentasActivoFijo]
Nombre=EditarCuentasActivoFijo
Boton=0
NombreDesplegar=&Editar Cuentas Activo Fijo
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S



[Acciones.EditarCuentasActivoFijo.ListaCuentasActivoFijo]
Nombre=ListaCuentasActivoFijo
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar

[Acciones.EditarCuentasActivoFijo.ActualizarCuentasActivoFijo]
Nombre=ActualizarCuentasActivoFijo
Boton=0
TipoAccion=Expresion




Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas de activo fijo<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>ACTIVOFCAT<T>,<T>CUENTA<T>,Info.Cuenta,<T><T>)<BR><BR>    ActualizarVista<BR>Fin



[Acciones.EditarCuentasActivoFijo.ListaAccionesMultiples]
(Inicio)=ListaCuentasActivoFijo
ListaCuentasActivoFijo=ActualizarCuentasActivoFijo
ActualizarCuentasActivoFijo=(Fin)


[ListaCuentasActivoFijo.Columnas]
Categoria=304
Cuenta=128
















[ListaCuentasActivoFijo.ListaEnCaptura]
(Inicio)=ActivoFCat.Categoria
ActivoFCat.Categoria=ActivoFCat.Cuenta
ActivoFCat.Cuenta=(Fin)





[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=ConCuenta
ConCuenta=SinCuenta
SinCuenta=Todos
Todos=(Fin)
