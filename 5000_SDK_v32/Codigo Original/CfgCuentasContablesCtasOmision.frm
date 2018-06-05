
[Forma]
Clave=CfgCuentasContablesCtasOmision
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
BarraHerramientas=S
Nombre=&Configuración Cuentas Contables Cuentas por Omisión
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=ListaCtasOmision
CarpetaPrincipal=ListaCtasOmision
ListaAcciones=(Lista)
PosicionInicialIzquierda=372
PosicionInicialArriba=140
PosicionInicialAlturaCliente=409
PosicionInicialAncho=622
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Opcion,<T>Todos<T>)
[ListaCtasOmision]
Estilo=Hoja
Clave=ListaCtasOmision
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCuentasContablesCtasOmision
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
CarpetaVisible=S

Filtros=S
OtroOrden=S
MenuLocal=S
PermiteEditar=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
ListaAcciones=EditarCuentasOmision
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroGrupo1=Modulo.Nombre
FiltroValida1=Modulo.Nombre
FiltroAutoCampo=Modulo.Nombre
FiltroAutoValidar=Modulo.Nombre
BusquedaRapidaControles=S
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
BusquedaRespetarFiltros=S
FiltroTodo=S
ValidarCampos=S
ListaCamposAValidar=Modulo.Nombre
FiltroGeneral={Si Info.Opcion = <T>Todos<T> Entonces <T> 1 = 1 AND MovTipoContAuto2.Cuenta LIKE <T>+Comillas(<T>POR OMISION<T>)+<T> <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>ConCuenta<T> Entonces <T> MovTipoContAuto2.CuentaOmision IS NOT NULL AND MovTipoContAuto2.CuentaOmision NOT LIKE <T>+Comillas(<T><T>)+<BR><T> AND MovTipoContAuto2.Cuenta LIKE <T>+Comillas(<T>POR OMISION<T>)+<T> <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>SinCuenta<T> Entonces <T> (MovTipoContAuto2.CuentaOmision IS NULL OR MovTipoContAuto2.CuentaOmision LIKE <T>+Comillas(<T><T>)+<BR><T>) AND MovTipoContAuto2.Cuenta LIKE <T>+Comillas(<T>POR OMISION<T>)+<T> <T> Sino <T><T> Fin}
[Acciones.EditarCtasOmision.ListaCtasOmision]
Nombre=ListaCtasOmision
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar
Activo=S
Visible=S

[Acciones.EditarCtasOmision.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Expresion=Informacion(<T>Cuenta x omision:<T>+Info.Cuenta)
Activo=S
Visible=S



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
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S


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
[ListaCtasOmision.Columnas]
Nombre=349
CuentaOmision=83





MODULO=82
Modulo=82
[Lista.Columnas]
0=207




[Acciones.EditarCtasOmision.ListaAccionesMultiples]
(Inicio)=ListaCtasOmision
ListaCtasOmision=Actualizar
Actualizar=(Fin)







































[ListaCtasOmision.MovTipoContAuto2.Nombre]
Carpeta=ListaCtasOmision
Clave=MovTipoContAuto2.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ListaCtasOmision.MovTipoContAuto2.CuentaOmision]
Carpeta=ListaCtasOmision
Clave=MovTipoContAuto2.CuentaOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[Acciones.EditarCuentasOmision]
Nombre=EditarCuentasOmision
Boton=0
NombreDesplegar=&Editar Cuentas Omisión
Multiple=S
EnMenu=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S




[Acciones.EditarCuentasOmision.ListaCuentasOmision]
Nombre=ListaCuentasOmision
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar

[Acciones.EditarCuentasOmision.ActualizarCuentasOmision]
Nombre=ActualizarCuentasOmision
Boton=0
TipoAccion=Expresion

Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas de omisión<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>MovTipoContAuto<T>,<T>CuentaOmision<T>,Info.Cuenta,<T> AND CUENTA LIKE <T>+<BR>    Comillas(<T>POR OMISION<T>)+<T> <T>)<BR>    ActualizarVista<BR>Fin




[Acciones.EditarCuentasOmision.ListaAccionesMultiples]
(Inicio)=ListaCuentasOmision
ListaCuentasOmision=ActualizarCuentasOmision
ActualizarCuentasOmision=(Fin)









































































[ListaCtasOmision.ListaEnCaptura]
(Inicio)=MovTipoContAuto2.Nombre
MovTipoContAuto2.Nombre=MovTipoContAuto2.CuentaOmision
MovTipoContAuto2.CuentaOmision=(Fin)

[ListaCtasOmision.ListaOrden]
(Inicio)=MovTipoContAuto2.Nombre	(Acendente)
MovTipoContAuto2.Nombre	(Acendente)=MovTipoContAuto2.MODULO	(Acendente)
MovTipoContAuto2.MODULO	(Acendente)=(Fin)





[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=ConCuenta
ConCuenta=SinCuenta
SinCuenta=Todos
Todos=(Fin)
