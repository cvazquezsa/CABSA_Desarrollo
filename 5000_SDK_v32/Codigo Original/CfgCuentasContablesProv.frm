
[Forma]
Clave=CfgCuentasContablesProv
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=&Configuración Cuentas Contables Proveedores
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Opcion,<T>Todos<T>)
ListaCarpetas=ListaCuentasProveedores
CarpetaPrincipal=ListaCuentasProveedores
PosicionInicialIzquierda=301
PosicionInicialArriba=121
PosicionInicialAlturaCliente=447
PosicionInicialAncho=764

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
[ListaProveedores.ListaEnCaptura]
(Inicio)=Prov.Proveedor
Prov.Proveedor=Prov.Nombre
Prov.Nombre=Prov.Tipo
Prov.Tipo=Prov.Cuenta
Prov.Cuenta=Prov.CuentaRetencion
Prov.CuentaRetencion=(Fin)

[ListaProveedores.ListaOrden]
(Inicio)=Prov.Proveedor	(Acendente)
Prov.Proveedor	(Acendente)=Prov.Nombre	(Acendente)
Prov.Nombre	(Acendente)=(Fin)







[Acciones.EditarCtasProv.ListaCtasProv]
Nombre=ListaCtasProv
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar
Activo=S
Visible=S

[Acciones.EditarCtasProv.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Expresion=Informacion(<T>Seleccion de cuenta para proveedores:<T>+Info.Cuenta)
Activo=S
Visible=S


[Acciones.EditarCtasProv.ListaAccionesMultiples]
(Inicio)=ListaCtasProv
ListaCtasProv=Actualizar
Actualizar=(Fin)

[ListaCuentasProveedores]
Estilo=Hoja
Clave=ListaCuentasProveedores
Filtros=S
OtroOrden=S
MenuLocal=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCuentasContablesProv
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


BusquedaRapidaControles=S
FiltroGrupo1=Prov.Tipo
FiltroValida1=Prov.Tipo
FiltroTodo=S
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
[ListaCuentasProveedores.Prov.Proveedor]
Carpeta=ListaCuentasProveedores
Clave=Prov.Proveedor
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ListaCuentasProveedores.Prov.Nombre]
Carpeta=ListaCuentasProveedores
Clave=Prov.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[ListaCuentasProveedores.Prov.Tipo]
Carpeta=ListaCuentasProveedores
Clave=Prov.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[ListaCuentasProveedores.Prov.Cuenta]
Carpeta=ListaCuentasProveedores
Clave=Prov.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ListaCuentasProveedores.Prov.CuentaRetencion]
Carpeta=ListaCuentasProveedores
Clave=Prov.CuentaRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.Columnas]
0=207

[ListaCuentasProveedores.Columnas]
Proveedor=73
Nombre=240
Tipo=94
Cuenta=64
CuentaRetencion=95






[Acciones.EditarCuentasProveedores]
Nombre=EditarCuentasProveedores
Boton=0
NombreDesplegar=&Editar Cuentas Proveedores
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S




[Acciones.EditarCuentasProveedores.ListaCuentasProveedores]
Nombre=ListaCuentasProveedores
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar

[Acciones.EditarCuentasProveedores.ActualizarCuentasProveedores]
Nombre=ActualizarCuentasProveedores
Boton=0
TipoAccion=Expresion





Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas de los proveedores<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>PROV<T>,<T>CUENTA<T>,Info.Cuenta,<T><T>)<BR>    ActualizarVista<BR>Fin
[Acciones.EditarCuentasRetencionProveedores]
Nombre=EditarCuentasRetencionProveedores
Boton=0
EnMenu=S
Activo=S
Visible=S

NombreDesplegar=&Editar CuentasRetencion Proveedores
Multiple=S


ListaAccionesMultiples=(Lista)

[Acciones.EditarCuentasRetencionProveedores.ListaCuentasRetencionesProveedores]
Nombre=ListaCuentasRetencionesProveedores
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar
Activo=S
Visible=S

[Acciones.EditarCuentasRetencionProveedores.ActualizarCuentasRetencionesProveedores]
Nombre=ActualizarCuentasRetencionesProveedores
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S








Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas retencion de los proveedores<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>PROV<T>,<T>CUENTARETENCION<T>,Info.Cuenta,<T><T>)<BR>    ActualizarVista<BR>Fin
[Acciones.EditarCuentasProveedores.ListaAccionesMultiples]
(Inicio)=ListaCuentasProveedores
ListaCuentasProveedores=ActualizarCuentasProveedores
ActualizarCuentasProveedores=(Fin)










[Acciones.EditarCuentasRetencionProveedores.ListaAccionesMultiples]
(Inicio)=ListaCuentasRetencionesProveedores
ListaCuentasRetencionesProveedores=ActualizarCuentasRetencionesProveedores
ActualizarCuentasRetencionesProveedores=(Fin)

















[ListaCuentasProveedores.ListaEnCaptura]
(Inicio)=Prov.Proveedor
Prov.Proveedor=Prov.Nombre
Prov.Nombre=Prov.Tipo
Prov.Tipo=Prov.Cuenta
Prov.Cuenta=Prov.CuentaRetencion
Prov.CuentaRetencion=(Fin)

[ListaCuentasProveedores.ListaOrden]
(Inicio)=Prov.Proveedor	(Acendente)
Prov.Proveedor	(Acendente)=Prov.Nombre	(Acendente)
Prov.Nombre	(Acendente)=(Fin)

[ListaCuentasProveedores.ListaAcciones]
(Inicio)=EditarCuentasProveedores
EditarCuentasProveedores=EditarCuentasRetencionProveedores
EditarCuentasRetencionProveedores=(Fin)









[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=ConCuenta
ConCuenta=SinCuenta
SinCuenta=Todos
Todos=(Fin)
