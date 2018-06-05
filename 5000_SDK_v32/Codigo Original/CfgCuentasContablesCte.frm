
[Forma]
Clave=CfgCuentasContablesCte
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=&Configuración Cuentas Contables Clientes

ListaCarpetas=ListaCuentasClientes
CarpetaPrincipal=ListaCuentasClientes
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=340
PosicionInicialArriba=114
PosicionInicialAlturaCliente=461
PosicionInicialAncho=686
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
[Acciones.EditaCtasCtes.ListaCtas]
Nombre=ListaCtas
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar
Activo=S
Visible=S

[Acciones.EditaCtasCtes.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Informacion(<T>Cuenta para Actualizar: <T>+Info.Cuenta)<BR>EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta<T>, <T>CTE<T>, <T>CUENTA<T>, Info.Cuenta)<BR>ActualizarForma

[Lista.Columnas]
Cliente=64
Nombre=184
Tipo=94
Cuenta=64
CuentaRetencion=87





0=207
[Lista.ListaEnCaptura]
(Inicio)=Cte.Cliente
Cte.Cliente=Cte.Nombre
Cte.Nombre=Cte.Tipo
Cte.Tipo=Cte.Cuenta
Cte.Cuenta=Cte.CuentaRetencion
Cte.CuentaRetencion=(Fin)

[Lista.ListaOrden]
(Inicio)=Cte.Cliente	(Acendente)
Cte.Cliente	(Acendente)=Cte.Nombre	(Acendente)
Cte.Nombre	(Acendente)=(Fin)










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
[ListaCuentasClientes]
Estilo=Hoja
Clave=ListaCuentasClientes
Filtros=S
OtroOrden=S
MenuLocal=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCuentasContablesCte
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

ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
ListaAcciones=(Lista)
CarpetaVisible=S


FiltroGrupo1=Cte.Tipo
FiltroValida1=Cte.Tipo
FiltroTodo=S
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
FiltroGeneral={Si Info.Opcion = <T>Todos<T> Entonces <T> 1 = 1 <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>ConCuenta<T> Entonces <T> Cuenta IS NOT NULL AND Cuenta NOT LIKE <T>+Comillas(<T><T>)+<T> <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>SinCuenta<T> Entonces <T> Cuenta IS NULL <T> Sino <T><T> Fin}
[ListaCuentasClientes.Cte.Cliente]
Carpeta=ListaCuentasClientes
Clave=Cte.Cliente
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ListaCuentasClientes.Cte.Nombre]
Carpeta=ListaCuentasClientes
Clave=Cte.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[ListaCuentasClientes.Cte.Tipo]
Carpeta=ListaCuentasClientes
Clave=Cte.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[ListaCuentasClientes.Cte.Cuenta]
Carpeta=ListaCuentasClientes
Clave=Cte.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ListaCuentasClientes.Cte.CuentaRetencion]
Carpeta=ListaCuentasClientes
Clave=Cte.CuentaRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[ListaCuentasClientes.Columnas]
Cliente=64
Nombre=184
Tipo=94
Cuenta=64
CuentaRetencion=87

























[Acciones.EditaCtasCtes.ListaAccionesMultiples]
(Inicio)=ListaCtas
ListaCtas=Actualizar
Actualizar=(Fin)


[Acciones.EditaCuentasClientes.ListaAccionesMultiples]
(Inicio)=ListaCtas
ListaCtas=Actualizar
Actualizar=(Fin)


[Acciones.EditarCuentasClientes]
Nombre=EditarCuentasClientes
Boton=0
NombreDesplegar=&Editar Cuentas Clientes
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S








[Acciones.EditarCuentasClientes.ActualizarCuentasClientes]
Nombre=ActualizarCuentasClientes
Boton=0
TipoAccion=Expresion











Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas de los clientes<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>CTE<T>,<T>CUENTA<T>,Info.Cuenta,<T><T>)<BR>    ActualizarVista<BR>Fin
[Acciones.EditarCuentasClientes.ListaCuentasClientes]
Nombre=ListaCuentasClientes
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar


[Acciones.EditarCuentasRetencionClienes.ListaCuentasRetencionClientes]
Nombre=ListaCuentasRetencionClientes
Boton=0
Activo=S
Visible=S

[Acciones.EditarCuentasRetencionClientes]
Nombre=EditarCuentasRetencionClientes
Boton=0
NombreDesplegar=&Editar CuentasRetencion Clientes
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S

[Acciones.EditarCuentasRetencionClientes.ListaCuentasRetencionClientes]
Nombre=ListaCuentasRetencionClientes
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar

[Acciones.EditarCuentasRetencionClientes.ActualizarCuentasRetencionClientes]
Nombre=ActualizarCuentasRetencionClientes
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas retencion de los clientes<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>CTE<T>,<T>CUENTARETENCION<T>,Info.Cuenta,<T><T>)<BR>    ActualizarVista<BR>Fin

[Acciones.EditarCuentasClientes.ListaAccionesMultiples]
(Inicio)=ListaCuentasClientes
ListaCuentasClientes=ActualizarCuentasClientes
ActualizarCuentasClientes=(Fin)





[Acciones.EditarCuentasRetencionClientes.ListaAccionesMultiples]
(Inicio)=ListaCuentasRetencionClientes
ListaCuentasRetencionClientes=ActualizarCuentasRetencionClientes
ActualizarCuentasRetencionClientes=(Fin)

























































[ListaCuentasClientes.ListaEnCaptura]
(Inicio)=Cte.Cliente
Cte.Cliente=Cte.Nombre
Cte.Nombre=Cte.Tipo
Cte.Tipo=Cte.Cuenta
Cte.Cuenta=Cte.CuentaRetencion
Cte.CuentaRetencion=(Fin)

[ListaCuentasClientes.ListaOrden]
(Inicio)=Cte.Cliente	(Acendente)
Cte.Cliente	(Acendente)=Cte.Nombre	(Acendente)
Cte.Nombre	(Acendente)=(Fin)

[ListaCuentasClientes.ListaAcciones]
(Inicio)=EditarCuentasClientes
EditarCuentasClientes=EditarCuentasRetencionClientes
EditarCuentasRetencionClientes=(Fin)









[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=ConCuenta
ConCuenta=SinCuenta
SinCuenta=Todos
Todos=(Fin)
