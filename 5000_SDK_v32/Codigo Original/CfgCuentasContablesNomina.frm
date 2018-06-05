
[Forma]
Clave=CfgCuentasContablesNomina
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=&Configuración Cuentas Conceptos de Nomina
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=ListaCtasNomina
CarpetaPrincipal=ListaCtasNomina
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=360
PosicionInicialArriba=144
PosicionInicialAlturaCliente=400
PosicionInicialAncho=646
ExpresionesAlMostrar=Asigna(Info.Opcion,<T>Todos<T>)<BR>Asigna(Info.Cuenta,<T><T>)
[ListaCtasNomina]
Estilo=Hoja
Clave=ListaCtasNomina
Filtros=S
OtroOrden=S
MenuLocal=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCuentasContablesNomina
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
FiltroTipo=General
CarpetaVisible=S

HojaAjustarColumnas=S
HojaMantenerSeleccion=S
ListaEnCaptura=(Lista)
ListaOrden=NomXPersonal2.Concepto<TAB>(Acendente)
ListaAcciones=EditarCuentasNomina

BusquedaRapidaControles=S
FiltroGrupo1=NomXPersonal2.Concepto
FiltroValida1=NomXPersonal2.Concepto
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
FiltroGeneral={Si Info.Opcion = <T>Todos<T> Entonces <T> 1 = 1 <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>ConCuenta<T> Entonces <T> CuentaContAuto IS NOT NULL AND CuentaContAuto NOT LIKE <T>+Comillas(<T><T>)+<T> <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>SinCuenta<T> Entonces <T> CuentaContAuto IS NULL OR CuentaContAuto LIKE <T>+Comillas(<T><T>)+<T> <T> Sino <T><T> Fin}
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S


ClaveAccion=Aceptar
GuardarAntes=S
[Acciones.ConCuenta]
Nombre=ConCuenta
Boton=71
NombreEnBoton=S
NombreDesplegar=&Con Cuenta
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S


Antes=S
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
Visible=S



Antes=S



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
[Acciones.EditarCtasNomina.ListaCtasNomina]
Nombre=ListaCtasNomina
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar
Activo=S
Visible=S

[Acciones.EditarCtasNomina.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Expresion=Informacion(<T>Cuenta para Nomina:<T>+Info.Cuenta)
Activo=S
Visible=S


[Acciones.EditarCtasNomina.ListaAccionesMultiples]
(Inicio)=ListaCtasNomina
ListaCtasNomina=Actualizar
Actualizar=(Fin)




[ListaCtasNomina.Columnas]
Concepto=289
CuentaContAuto=112




[Lista.Columnas]
0=207



































[ListaCtasNomina.NomXPersonal2.Concepto]
Carpeta=ListaCtasNomina
Clave=NomXPersonal2.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ListaCtasNomina.NomXPersonal2.CuentaContAuto]
Carpeta=ListaCtasNomina
Clave=NomXPersonal2.CuentaContAuto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


















[Acciones.EditarCuentasNomina.ListaCuentasNomina]
Nombre=ListaCuentasNomina
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar

[Acciones.EditarCuentasNomina.ActualizarCuentasNomina]
Nombre=ActualizarCuentasNomina
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas de nomina<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>NomXPersonal<T>,<T>CuentaContAuto<T>,Info.Cuenta,<T><T>)<BR>    ActualizarVista<BR>Fin

[Acciones.EditarCuentasNomina]
Nombre=EditarCuentasNomina
Boton=0
NombreDesplegar=&Editar Cuentas Nomina
Multiple=S
EnMenu=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
[Acciones.EditarCuentasNomina.ListaAccionesMultiples]
(Inicio)=ListaCuentasNomina
ListaCuentasNomina=ActualizarCuentasNomina
ActualizarCuentasNomina=(Fin)







[ListaCtasNomina.ListaEnCaptura]
(Inicio)=NomXPersonal2.Concepto
NomXPersonal2.Concepto=NomXPersonal2.CuentaContAuto
NomXPersonal2.CuentaContAuto=(Fin)











[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=ConCuenta
ConCuenta=SinCuenta
SinCuenta=Todos
Todos=(Fin)
