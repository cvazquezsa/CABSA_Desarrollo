[Forma]
Clave=BPlan
Nombre=e(<T>Business Plan<T>)+<T> - <T>+Modulo.Nombre(Info.Modulo)
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=231
PosicionInicialArriba=214
PosicionInicialAlturaCliente=562
PosicionInicialAncho=818
MovModulo=(Todos)
Comentarios=Lista(Empresa, Modulo.Nombre(Info.Modulo), Info.Ejercicio, Info.Moneda)
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Info.Moneda, Config.ContMoneda)
PosicionSec1=503
PosicionCol1=482
PosicionSec2=497

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=BPlan
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S
PermiteLocalizar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
PermiteEditar=S
FiltroSucursales=S
FiltroUENs=S
FiltroUENsCampo=BPlan.UEN
OtroOrden=S
ListaOrden=BPlan.ID<TAB>(Acendente)
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
FiltroGeneral=BPlan.Modulo = <T>{Info.Modulo}<T> AND<BR>BPlan.Empresa = <T>{Empresa}<T> AND<BR>BPlan.Ejercicio = {Info.Ejercicio} AND<BR>BPlan.Moneda = <T>{Info.Moneda}<T>

[Lista.BPlan.Articulo]
Carpeta=Lista
Clave=BPlan.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.BPlan.Concepto]
Carpeta=Lista
Clave=BPlan.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.BPlan.Personal]
Carpeta=Lista
Clave=BPlan.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=124
Concepto=151
Personal=67
CantidadBase1=64
CantidadBase2=64
CantidadBase3=64
CantidadBase4=64
CantidadBase5=64
CantidadBase6=64
CantidadBase7=64
CantidadBase8=64
CantidadBase9=64
CantidadBase10=64
CantidadBase11=64
CantidadBase12=64
PrecioBase1=64
PrecioBase2=64
PrecioBase3=64
PrecioBase4=64
PrecioBase5=64
PrecioBase6=64
PrecioBase7=64
PrecioBase8=64
PrecioBase9=64
PrecioBase10=64
PrecioBase11=64
PrecioBase12=64
Inc=66
Inc2=64
Inc3=64
Precio=95
Inf=59
Usar=67
Clase=145
SubClase=150
Plaza=99
NombrePersonal=129
Descripcion1=323

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreDesplegar=A&sistente
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
NombreEnBoton=S
ClaveAccion=Actualizar Vista
Antes=S
AntesExpresiones=Caso Info.Modulo<BR>  Es <T>VTAS<T> Entonces Forma(<T>BPlanAsisteInv<T>)<BR>  Es <T>COMS<T> Entonces Forma(<T>BPlanAsisteInv<T>)<BR>  Es <T>GAS<T> Entonces Forma(<T>BPlanAsisteGas<T>)<BR>  Es <T>NOM<T> Entonces Forma(<T>BPlanAsisteNom<T>)<BR>Fin

[Acciones.Base]
Nombre=Base
Boton=7
NombreEnBoton=S
NombreDesplegar=Gererar &Base
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
AntesExpresiones=Si Forma(<T>EspecificarEjercicio<T>)<BR>  Entonces<BR>  Si Confirmacion( <T>¿Esta seguro de Generar la Base del <T> + Info.Ejercicio + <T> para proyectarlo al <T> + (Info.Ejercicio + 1) + <T> en el Módulo de <T> + Modulo.Nombre(Info.Modulo) + <T>?<T>,  BotonSi ,  BotonNo) = BotonSi<BR>    Entonces<BR>      ProcesarSQL(<T>spBPlanGenerarBase :tEmpresa, :tUsuario, :tModulo, :nEjercicio, :tMon<T>, Empresa, Usuario, Info.Modulo, Info.Ejercicio, Info.Moneda)<BR>      Asigna(Info.Ejercicio, Info.Ejercicio + 1)<BR>  Fin<BR>Fin

[Acciones.Ejercicio]
Nombre=Ejercicio
Boton=53
NombreEnBoton=S
NombreDesplegar=Ejercicio
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>EspecificarEjercicio<T>)

[Acciones.Moneda]
Nombre=Moneda
Boton=64
NombreDesplegar=Moneda
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
AntesExpresiones=Forma(<T>EspecificarMoneda<T>)

[Lista.BPlan.Clase]
Carpeta=Lista
Clave=BPlan.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.BPlan.SubClase]
Carpeta=Lista
Clave=BPlan.SubClase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.BPlan.Plaza]
Carpeta=Lista
Clave=BPlan.Plaza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Base]
Estilo=Ficha
Clave=Base
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=BPlan
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Base Vs Presupuesto
PermiteEditar=S

[Base.BPlan.CantidadBase1]
Carpeta=Base
Clave=BPlan.CantidadBase1
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8
Pegado=N
OcultaNombre=N

[Base.BPlan.PrecioBase1]
Carpeta=Base
Clave=BPlan.PrecioBase1
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10
OcultaNombre=S
Pegado=S

[Base.BPlan.CantidadBase2]
Carpeta=Base
Clave=BPlan.CantidadBase2
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase2]
Carpeta=Base
Clave=BPlan.PrecioBase2
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase3]
Carpeta=Base
Clave=BPlan.CantidadBase3
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase3]
Carpeta=Base
Clave=BPlan.PrecioBase3
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase4]
Carpeta=Base
Clave=BPlan.CantidadBase4
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase4]
Carpeta=Base
Clave=BPlan.PrecioBase4
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase5]
Carpeta=Base
Clave=BPlan.CantidadBase5
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase5]
Carpeta=Base
Clave=BPlan.PrecioBase5
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase6]
Carpeta=Base
Clave=BPlan.CantidadBase6
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase6]
Carpeta=Base
Clave=BPlan.PrecioBase6
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase7]
Carpeta=Base
Clave=BPlan.CantidadBase7
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase7]
Carpeta=Base
Clave=BPlan.PrecioBase7
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase8]
Carpeta=Base
Clave=BPlan.CantidadBase8
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase8]
Carpeta=Base
Clave=BPlan.PrecioBase8
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase9]
Carpeta=Base
Clave=BPlan.CantidadBase9
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase9]
Carpeta=Base
Clave=BPlan.PrecioBase9
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase10]
Carpeta=Base
Clave=BPlan.CantidadBase10
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase10]
Carpeta=Base
Clave=BPlan.PrecioBase10
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase11]
Carpeta=Base
Clave=BPlan.CantidadBase11
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase11]
Carpeta=Base
Clave=BPlan.PrecioBase11
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.CantidadBase12]
Carpeta=Base
Clave=BPlan.CantidadBase12
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=8

[Base.BPlan.PrecioBase12]
Carpeta=Base
Clave=BPlan.PrecioBase12
Editar=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NombrePersonal]
Carpeta=Lista
Clave=NombrePersonal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad1]
Carpeta=Proyección
Clave=BPlan.Cantidad1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio1]
Carpeta=Proyección
Clave=BPlan.Precio1
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad2]
Carpeta=Proyección
Clave=BPlan.Cantidad2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio2]
Carpeta=Proyección
Clave=BPlan.Precio2
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad3]
Carpeta=Proyección
Clave=BPlan.Cantidad3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio3]
Carpeta=Proyección
Clave=BPlan.Precio3
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad4]
Carpeta=Proyección
Clave=BPlan.Cantidad4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio4]
Carpeta=Proyección
Clave=BPlan.Precio4
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad5]
Carpeta=Proyección
Clave=BPlan.Cantidad5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio5]
Carpeta=Proyección
Clave=BPlan.Precio5
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad6]
Carpeta=Proyección
Clave=BPlan.Cantidad6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio6]
Carpeta=Proyección
Clave=BPlan.Precio6
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad7]
Carpeta=Proyección
Clave=BPlan.Cantidad7
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio7]
Carpeta=Proyección
Clave=BPlan.Precio7
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad8]
Carpeta=Proyección
Clave=BPlan.Cantidad8
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio8]
Carpeta=Proyección
Clave=BPlan.Precio8
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad9]
Carpeta=Proyección
Clave=BPlan.Cantidad9
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio9]
Carpeta=Proyección
Clave=BPlan.Precio9
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad10]
Carpeta=Proyección
Clave=BPlan.Cantidad10
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio10]
Carpeta=Proyección
Clave=BPlan.Precio10
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad11]
Carpeta=Proyección
Clave=BPlan.Cantidad11
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio11]
Carpeta=Proyección
Clave=BPlan.Precio11
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.BPlan.Cantidad12]
Carpeta=Proyección
Clave=BPlan.Cantidad12
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Proyección.BPlan.Precio12]
Carpeta=Proyección
Clave=BPlan.Precio12
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Proyección.TotalCantidad]
Carpeta=Proyección
Clave=TotalCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Proyección.TotalImporte]
Carpeta=Proyección
Clave=TotalImporte
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Cantidad Total<BR>Importe Total<BR>Cantidad Proyectada<BR>Importe Proyectado
Totalizadores=S
TotCarpetaRenglones=Base
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
Totalizadores2=Suma(BPlan:BPlan.CantidadBase1 + BPlan:BPlan.CantidadBase2 + BPlan:BPlan.CantidadBase3 + BPlan:BPlan.CantidadBase4 + BPlan:BPlan.CantidadBase5 + BPlan:BPlan.CantidadBase6 + BPlan:BPlan.CantidadBase7 + BPlan:BPlan.CantidadBase8 + BPlan:BPlan.CantidadBase9 + BPlan:BPlan.CantidadBase10 + BPlan:BPlan.CantidadBase11 + BPlan:BPlan.CantidadBase12)<BR>Suma((BPlan:BPlan.CantidadBase1*BPlan:BPlan.PrecioBase1) + (BPlan:BPlan.CantidadBase2*BPlan:BPlan.PrecioBase2) + (BPlan:BPlan.CantidadBase3*BPlan:BPlan.PrecioBase3) + (BPlan:BPlan.CantidadBase4*BPlan:BPlan.PrecioBase4) + (BPlan:BPlan.CantidadBase5*BPlan:BPlan.PrecioBase5) + (BPlan:BPlan.CantidadBase6*BPlan:BPlan.PrecioBase6) + (BPlan:BPlan.CantidadBase7*BPlan:BPlan.PrecioBase7) + (BPlan:BPlan.CantidadBase8*BPlan:BPlan.PrecioBase8) + (BPlan:BPlan.CantidadBase9*BPlan:BPlan.PrecioBase9) + (BPlan:BPlan.CantidadBase10*BPlan:BPlan.PrecioBase10) + (BPlan:BPlan.CantidadBase11*BPlan:BPlan.PrecioBase11) + (BPlan:BPlan.CantidadBase12*BPlan:BPlan.PrecioBase12))<BR>Suma(BPlan:BPlan.Cantidad1 + BPlan:BPlan.Cantidad2 + BPlan:BPlan.Cantidad3 + BPlan:BPlan.Cantidad4 + BPlan:BPlan.Cantidad5 + BPlan:BPlan.Cantidad6 + BPlan:BPlan.Cantidad7 + BPlan:BPlan.Cantidad8 + BPlan:BPlan.Cantidad9 + BPlan:BPlan.Cantidad10 + BPlan:BPlan.Cantidad11 + BPlan:BPlan.Cantidad12)<BR>Suma((BPlan:BPlan.Cantidad1*BPlan:BPlan.Precio1) + (BPlan:BPlan.Cantidad2*BPlan:BPlan.Precio2) + (BPlan:BPlan.Cantidad3*BPlan:BPlan.Precio3) + (BPlan:BPlan.Cantidad4*BPlan:BPlan.Precio4) + (BPlan:BPlan.Cantidad5*BPlan:BPlan.Precio5) + (BPlan:BPlan.Cantidad6*BPlan:BPlan.Precio6) + (BPlan:BPlan.Cantidad7*BPlan:BPlan.Precio7) + (BPlan:BPlan.Cantidad8*BPlan:BPlan.Precio8) + (BPlan:BPlan.Cantidad9*BPlan:BPlan.Precio9) + (BPlan:BPlan.Cantidad10*BPlan:BPlan.Precio10) + (BPlan:BPlan.Cantidad11*BPlan:BPlan.Precio11) + (BPlan:BPlan.Cantidad12*BPlan:BPlan.Precio12))
Totalizadores3=(Cantidades)<BR>(Monetario)<BR>(Cantidades)<BR>(Monetario)
TotAlCambiar=S
TotExpresionesEnSumas=S

[Base.BPlan.Cantidad1]
Carpeta=Base
Clave=BPlan.Cantidad1
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad2]
Carpeta=Base
Clave=BPlan.Cantidad2
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad3]
Carpeta=Base
Clave=BPlan.Cantidad3
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad4]
Carpeta=Base
Clave=BPlan.Cantidad4
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad5]
Carpeta=Base
Clave=BPlan.Cantidad5
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad6]
Carpeta=Base
Clave=BPlan.Cantidad6
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad7]
Carpeta=Base
Clave=BPlan.Cantidad7
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad8]
Carpeta=Base
Clave=BPlan.Cantidad8
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad9]
Carpeta=Base
Clave=BPlan.Cantidad9
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad10]
Carpeta=Base
Clave=BPlan.Cantidad10
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad11]
Carpeta=Base
Clave=BPlan.Cantidad11
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Cantidad12]
Carpeta=Base
Clave=BPlan.Cantidad12
Editar=S
OcultaNombre=S
3D=S
Pegado=N
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Base.BPlan.Precio1]
Carpeta=Base
Clave=BPlan.Precio1
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio2]
Carpeta=Base
Clave=BPlan.Precio2
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio3]
Carpeta=Base
Clave=BPlan.Precio3
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio4]
Carpeta=Base
Clave=BPlan.Precio4
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio5]
Carpeta=Base
Clave=BPlan.Precio5
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio6]
Carpeta=Base
Clave=BPlan.Precio6
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio7]
Carpeta=Base
Clave=BPlan.Precio7
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio8]
Carpeta=Base
Clave=BPlan.Precio8
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio9]
Carpeta=Base
Clave=BPlan.Precio9
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio10]
Carpeta=Base
Clave=BPlan.Precio10
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio11]
Carpeta=Base
Clave=BPlan.Precio11
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Base.BPlan.Precio12]
Carpeta=Base
Clave=BPlan.Precio12
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
OcultaNombre=S
Pegado=S
Tamano=10

[Otros]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=Otros
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=BPlan
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Otros.BPlan.Inc]
Carpeta=Otros
Clave=BPlan.Inc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Otros.BPlan.Precio]
Carpeta=Otros
Clave=BPlan.Precio
Editar=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Otros.BPlan.Inc2]
Carpeta=Otros
Clave=BPlan.Inc2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Otros.BPlan.Inf]
Carpeta=Otros
Clave=BPlan.Inf
Editar=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Otros.BPlan.Inc3]
Carpeta=Otros
Clave=BPlan.Inc3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Otros.BPlan.Usar]
Carpeta=Otros
Clave=BPlan.Usar
Editar=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Otros.BPlan.Sucursal]
Carpeta=Otros
Clave=BPlan.Sucursal
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Otros.BPlan.UEN]
Carpeta=Otros
Clave=BPlan.UEN
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spBPlanGenerarPresupuesto :tEmpresa, :tModulo, :nEjercicio, :tUsuario, :tMoneda<T>, Empresa, Info.Modulo, Info.Ejercicio, Usuario, Info.Moneda)
Activo=S
Visible=S

[Otros.BPlan.CentroCostos]
Carpeta=Otros
Clave=BPlan.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Resumen]
Nombre=Resumen
Boton=51
NombreDesplegar=Resumen
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Caso  Info.Modulo<BR>  Es <T>VTAS<T> Entonces Forma(<T>ExplorarBPlanVentaCompra<T>)<BR>  Es <T>COMS<T> Entonces Forma(<T>ExplorarBPlanVentaCompra<T>)<BR>  Es <T>GAS<T> Entonces Forma(<T>ExplorarBPlanGasto<T>)<BR>Fin

[Otros.CentroCostos.Descripcion]
Carpeta=Otros
Clave=CentroCostos.Descripcion
Editar=S
ValidaNombre=N
OcultaNombre=S
3D=S
Tamano=17
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Base
Base=Otros
Otros=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Guardar
Guardar=Ejercicio
Ejercicio=Moneda
Moneda=Base
Base=Asistente
Asistente=Generar
Generar=Resumen
Resumen=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=BPlan.Articulo
BPlan.Articulo=Art.Descripcion1
Art.Descripcion1=BPlan.Clase
BPlan.Clase=BPlan.SubClase
BPlan.SubClase=BPlan.Plaza
BPlan.Plaza=BPlan.Personal
BPlan.Personal=NombrePersonal
NombrePersonal=BPlan.Concepto
BPlan.Concepto=(Fin)

[Base.ListaEnCaptura]
(Inicio)=BPlan.CantidadBase1
BPlan.CantidadBase1=BPlan.PrecioBase1
BPlan.PrecioBase1=BPlan.Cantidad1
BPlan.Cantidad1=BPlan.Precio1
BPlan.Precio1=BPlan.CantidadBase2
BPlan.CantidadBase2=BPlan.PrecioBase2
BPlan.PrecioBase2=BPlan.Cantidad2
BPlan.Cantidad2=BPlan.Precio2
BPlan.Precio2=BPlan.CantidadBase3
BPlan.CantidadBase3=BPlan.PrecioBase3
BPlan.PrecioBase3=BPlan.Cantidad3
BPlan.Cantidad3=BPlan.Precio3
BPlan.Precio3=BPlan.CantidadBase4
BPlan.CantidadBase4=BPlan.PrecioBase4
BPlan.PrecioBase4=BPlan.Cantidad4
BPlan.Cantidad4=BPlan.Precio4
BPlan.Precio4=BPlan.CantidadBase5
BPlan.CantidadBase5=BPlan.PrecioBase5
BPlan.PrecioBase5=BPlan.Cantidad5
BPlan.Cantidad5=BPlan.Precio5
BPlan.Precio5=BPlan.CantidadBase6
BPlan.CantidadBase6=BPlan.PrecioBase6
BPlan.PrecioBase6=BPlan.Cantidad6
BPlan.Cantidad6=BPlan.Precio6
BPlan.Precio6=BPlan.CantidadBase7
BPlan.CantidadBase7=BPlan.PrecioBase7
BPlan.PrecioBase7=BPlan.Cantidad7
BPlan.Cantidad7=BPlan.Precio7
BPlan.Precio7=BPlan.CantidadBase8
BPlan.CantidadBase8=BPlan.PrecioBase8
BPlan.PrecioBase8=BPlan.Cantidad8
BPlan.Cantidad8=BPlan.Precio8
BPlan.Precio8=BPlan.CantidadBase9
BPlan.CantidadBase9=BPlan.PrecioBase9
BPlan.PrecioBase9=BPlan.Cantidad9
BPlan.Cantidad9=BPlan.Precio9
BPlan.Precio9=BPlan.CantidadBase10
BPlan.CantidadBase10=BPlan.PrecioBase10
BPlan.PrecioBase10=BPlan.Cantidad10
BPlan.Cantidad10=BPlan.Precio10
BPlan.Precio10=BPlan.CantidadBase11
BPlan.CantidadBase11=BPlan.PrecioBase11
BPlan.PrecioBase11=BPlan.Cantidad11
BPlan.Cantidad11=BPlan.Precio11
BPlan.Precio11=BPlan.CantidadBase12
BPlan.CantidadBase12=BPlan.PrecioBase12
BPlan.PrecioBase12=BPlan.Cantidad12
BPlan.Cantidad12=BPlan.Precio12
BPlan.Precio12=(Fin)

[Otros.ListaEnCaptura]
(Inicio)=BPlan.Inc
BPlan.Inc=BPlan.Sucursal
BPlan.Sucursal=BPlan.Inc2
BPlan.Inc2=BPlan.UEN
BPlan.UEN=BPlan.Inc3
BPlan.Inc3=BPlan.Inf
BPlan.Inf=BPlan.CentroCostos
BPlan.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=BPlan.Usar
BPlan.Usar=BPlan.Precio
BPlan.Precio=(Fin)
