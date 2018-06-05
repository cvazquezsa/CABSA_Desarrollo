
[Forma]
Clave=CfgCuentasContablesCtasDinero
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
BarraHerramientas=S
Nombre=&Configuración Cuentas Contables Cuentas Dinero
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaCarpetas=ListaCuentasDinero
CarpetaPrincipal=ListaCuentasDinero
PosicionInicialIzquierda=248
PosicionInicialArriba=122
PosicionInicialAlturaCliente=444
PosicionInicialAncho=869
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
[ListaCuentasDinero]
Estilo=Hoja
Clave=ListaCuentasDinero
Filtros=S
OtroOrden=S
MenuLocal=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCuentasContablesCtasDinero
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S



ListaEnCaptura=(Lista)
ListaOrden=(Lista)
ListaAcciones=EditarCuentasDinero

BusquedaRapidaControles=S
FiltroGrupo1=CtaDinero.Tipo
FiltroValida1=CtaDinero.Tipo
FiltroTodo=S
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
FiltroGeneral={Si Info.Opcion = <T>Todos<T> Entonces <T> 1 = 1 <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>ConCuenta<T> Entonces <T> Cuenta IS NOT NULL AND Cuenta NOT LIKE <T>+Comillas(<T><T>)+<T> <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>SinCuenta<T> Entonces <T> Cuenta IS NULL <T> Sino <T><T> Fin}
[Acciones.EditarCtasDinero.ListaCtasDinero]
Nombre=ListaCtasDinero
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar
Activo=S
Visible=S

[Acciones.EditarCtasDinero.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Informacion(<T>Cuenta para Cta Dineros:<T>+Info.Cuenta)

[ListaCuentasDinero.CtaDinero.CtaDinero]
Carpeta=ListaCuentasDinero
Clave=CtaDinero.CtaDinero
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[ListaCuentasDinero.CtaDinero.Descripcion]
Carpeta=ListaCuentasDinero
Clave=CtaDinero.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[ListaCuentasDinero.CtaDinero.Cuenta]
Carpeta=ListaCuentasDinero
Clave=CtaDinero.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[ListaCuentasDinero.Columnas]
CtaDinero=83
Descripcion=386
Cuenta=103



Tipo=124
[Lista.Columnas]
0=207












[Acciones.EditarCtasDinero.ListaAccionesMultiples]
(Inicio)=ListaCtasDinero
ListaCtasDinero=Actualizar
Actualizar=(Fin)







[Acciones.EditarCuentasDinero]
Nombre=EditarCuentasDinero
Boton=0
NombreDesplegar=&Editar Cuentas Dinero
Multiple=S
EnMenu=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S




[Acciones.EditarCuentasDinero.ListaCuentasDinero]
Nombre=ListaCuentasDinero
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar

[Acciones.EditarCuentasDinero.ActualizarCuentasDinero]
Nombre=ActualizarCuentasDinero
Boton=0
TipoAccion=Expresion

Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas de cuentas dinero<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>CTADINERO<T>,<T>CUENTA<T>,Info.Cuenta,<T><T>)<BR>    ActualizarVista<BR>Fin




[Acciones.EditarCuentasDinero.ListaAccionesMultiples]
(Inicio)=ListaCuentasDinero
ListaCuentasDinero=ActualizarCuentasDinero
ActualizarCuentasDinero=(Fin)









[ListaCuentasDinero.CtaDinero.Tipo]
Carpeta=ListaCuentasDinero
Clave=CtaDinero.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
















[ListaCuentasDinero.ListaEnCaptura]
(Inicio)=CtaDinero.CtaDinero
CtaDinero.CtaDinero=CtaDinero.Descripcion
CtaDinero.Descripcion=CtaDinero.Tipo
CtaDinero.Tipo=CtaDinero.Cuenta
CtaDinero.Cuenta=(Fin)

[ListaCuentasDinero.ListaOrden]
(Inicio)=CtaDinero.CtaDinero	(Acendente)
CtaDinero.CtaDinero	(Acendente)=CtaDinero.Descripcion	(Acendente)
CtaDinero.Descripcion	(Acendente)=(Fin)





[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=ConCuenta
ConCuenta=SinCuenta
SinCuenta=Todos
Todos=(Fin)
