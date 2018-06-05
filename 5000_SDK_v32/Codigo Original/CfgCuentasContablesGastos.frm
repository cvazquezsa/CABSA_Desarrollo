
[Forma]
Clave=CfgCuentasContablesGastos
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=&Configuración Cuentas Conceptos de Gastos
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaCarpetas=ListaCtasConceptoGastos
CarpetaPrincipal=ListaCtasConceptoGastos
PosicionInicialIzquierda=287
PosicionInicialArriba=124
PosicionInicialAlturaCliente=440
PosicionInicialAncho=791
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
[Acciones.EditarCtasGastos.ListaCtasGastos]
Nombre=ListaCtasGastos
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar
Activo=S
Visible=S

[Acciones.EditarCtasGastos.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Expresion=Informacion(<T>Cuenta para Gastos:<T>+Info.Cuenta)
Activo=S
Visible=S


[Acciones.EditarCtasGastos.ListaAccionesMultiples]
(Inicio)=ListaCtasGastos
ListaCtasGastos=Actualizar
Actualizar=(Fin)

[ListaCtasConceptoGastos]
Estilo=Hoja
Clave=ListaCtasConceptoGastos
Filtros=S
OtroOrden=S
MenuLocal=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCuentasContablesGastos
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

ListaOrden=Concepto2.Concepto<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
ListaAcciones=EditarCuentasConceptoGastos
CarpetaVisible=S





ListaEnCaptura=(Lista)
BusquedaRapidaControles=S
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
FiltroGrupo1=Concepto2.Clase
FiltroValida1=Concepto2.Clase
FiltroTodo=S
FiltroGeneral={Si Info.Opcion = <T>Todos<T> Entonces <T> 1 = 1 AND Clase2.Modulo LIKE <T>+Comillas(<T>GAS<T>)+<T> AND Concepto2.Modulo LIKE <T>+Comillas(<T>GAS<T>)+<T> <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>ConCuenta<T> Entonces <T> Concepto2.Cuenta IS NOT NULL AND Concepto2.Cuenta NOT LIKE <T>+Comillas(<T><T>)+<BR><T> AND Clase2.Modulo LIKE <T>+Comillas(<T>GAS<T>)+<T> AND Concepto2.Modulo LIKE <T>+Comillas(<T>GAS<T>)+<T> <T> Sino <T><T> Fin}<BR>{Si Info.Opcion = <T>SinCuenta<T> Entonces <T> (Concepto2.Cuenta IS NULL OR Concepto2.Cuenta LIKE <T>+Comillas(<T><T>)+<BR><T>) AND Clase2.Modulo LIKE <T>+Comillas(<T>GAS<T>)+<T> AND Concepto2.Modulo LIKE <T>+Comillas(<T>GAS<T>)+<T> <T> Sino <T><T> Fin}
[ListaCtasConceptoGastos.Columnas]
Concepto=304
Clase=183
Cuenta=64











[Acciones.EditarCuentasConceptoGastos]
Nombre=EditarCuentasConceptoGastos
Boton=0
NombreDesplegar=&Editar Cuentas Concepto Gastos
Multiple=S
EnMenu=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

[Acciones.EditarCuentasConceptoGastos.ListaCuentasConceptoGastos]
Nombre=ListaCuentasConceptoGastos
Boton=0
TipoAccion=Formas
ClaveAccion=CtaListaCopiar

[Acciones.EditarCuentasConceptoGastos.ActualizarCuentasConceptoGastos]
Nombre=ActualizarCuentasConceptoGastos
Boton=0
TipoAccion=Expresion


Expresion=Asigna(Info.Mensaje,Precaucion(<T>Se actualizaran todas las cuentas de concepto gastos<BR>que no tengan asignada actualmente una cuenta.<BR>Por la cuenta: <T> + Info.Cuenta + <T><BR>Estas Seguro ?<T>,  BotonAceptar,  BotonCancelar))<BR>Si Info.Mensaje = 2<BR>Entonces<BR>     AbortarOperacion<BR>Fin<BR>Si Info.Mensaje = 1<BR>Entonces<BR>    EjecutarSQL(<T>EXEC spActualizaCtasContables :tTabla, :tCampo, :tCuenta, :tOpcion<T>,<T>CONCEPTO<T>,<T>CUENTA<T>,Info.Cuenta,<T> AND Modulo LIKE <T>+Comillas(<T>GAS<T>)+<T> <T>)<BR>    ActualizarVista<BR>Fin
[ListaCtasConceptoGastos.ListaOrden]
(Inicio)=Concepto.Concepto	(Acendente)
Concepto.Concepto	(Acendente)=Clase2.Clase	(Acendente)
Clase2.Clase	(Acendente)=(Fin)










[ListaCtasConceptoGastos.Concepto2.Concepto]
Carpeta=ListaCtasConceptoGastos
Clave=Concepto2.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ListaCtasConceptoGastos.Concepto2.Cuenta]
Carpeta=ListaCtasConceptoGastos
Clave=Concepto2.Cuenta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Editar=S
[ListaCtasConceptoGastos.Concepto2.Clase]
Carpeta=ListaCtasConceptoGastos
Clave=Concepto2.Clase
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Lista.Columnas]
0=207




















[Acciones.EditarCuentasConceptoGastos.ListaAccionesMultiples]
(Inicio)=ListaCuentasConceptoGastos
ListaCuentasConceptoGastos=ActualizarCuentasConceptoGastos
ActualizarCuentasConceptoGastos=(Fin)









[ListaCtasConceptoGastos.ListaEnCaptura]
(Inicio)=Concepto2.Concepto
Concepto2.Concepto=Concepto2.Clase
Concepto2.Clase=Concepto2.Cuenta
Concepto2.Cuenta=(Fin)

















[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=ConCuenta
ConCuenta=SinCuenta
SinCuenta=Todos
Todos=(Fin)
