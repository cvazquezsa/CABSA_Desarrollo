[Forma]
Clave=NOIParamNominaGenerada
Icono=0
CarpetaPrincipal=NOIParamNominaGenerada
Modulos=(Todos)
Nombre=Cancelar Nomina
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
PosicionInicialIzquierda=688
PosicionInicialArriba=363
PosicionInicialAlturaCliente=95
PosicionInicialAncho=224
ListaCarpetas=NOIParamNominaGenerada
BarraHerramientas=S

PosicionSec1=495
ExpresionesAlMostrar=EjecutarSQL(<T>spNOIBorrarNomina :tEmpresa,:nEstacion<T>,Empresa,EstacionTrabajo)
[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Asigna(Info.Mensaje,SQL(<T>spCEValidarPersonal :tEmpresa<T>,Empresa))<BR><BR>Si<BR>  ConDatos(Info.Mensaje)<BR>Entonces<BR>  Informacion(Info.Mensaje)<BR>  Asigna(Info.FechaD,nulo)<BR>  Asigna(Info.FechaA,nulo)<BR>  Asigna(Info.PeriodoTipo,nulo)<BR>Sino<BR>  EjecutarSQL(<T>spNOIImportarCatalogos :tEmpresa,:tNomina,:nEstacion<T>,Empresa,NOIParamTablaPeriodo:NOIParamTablaPeriodo.Nomina,EstacionTrabajo)<BR>  Asigna(Info.FechaD,NOIParamTablaPeriodo:NOIParamTablaPeriodo.FechaD)<BR>  Asigna(Info.FechaA,NOIParamTablaPeriodo:NOIParamTablaPeriodo.FechaA)<BR>  Asigna(Info.PeriodoTipo,SQL(<T>SELECT TipoPeriodo FROM InterfaseAspelNOI WHERE Empresa = :tEmpresa<T>,Empresa))<BR>  Asigna(Info.Aplica,NOIParamTablaPeriodo:NOIParamTablaPeriodo.Nomina)<BR>Fin
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
GuardarAntes=S
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

EspacioPrevio=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Si(Vacio(NOIParamNominaGenerada:NOIParamNominaGenerada.FechaD),Informacion(<T>Es Necesario <T>))<BR>Si(Vacio(NOIParamNominaGenerada:NOIParamNominaGenerada.ID),Informacion(<T>Es Necesario Asignar Una Fecha De Nomina<T>))
[NOIParamNominaGenerada]
Estilo=Ficha
Clave=NOIParamNominaGenerada
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOIParamNominaGenerada
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
ListaEnCaptura=NOIParamNominaGenerada.FechaA
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=NOIParamNominaGenerada.Estacion = {EstacionTrabajo}
[NOIParamNominaGenerada.NOIParamNominaGenerada.FechaA]
Carpeta=NOIParamNominaGenerada
Clave=NOIParamNominaGenerada.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20







[Departamentos.Columnas]
Departamento=304
Sucursal=64

[Puestos.Columnas]
Puesto=304
SueldoRangoMinimo=105
SueldoRangoMaximo=109
Ok=64
OkRef=604

[NOINominaConcepto.Columnas]
NominaConcepto=85
Concepto=304
Movimiento=124
GravaISR=304
GravaIMSS=304
GravaImpuestoEstatal=304
Modulo=38
Estatus=94
Pais=184
CuentaGrupo=124
Ok=64
OkRef=604

[Personal.Columnas]
Verificado=64
Personal=64
ApellidoPaterno=184
ApellidoMaterno=184
Nombre=184
Tipo=124
Direccion=604
Colonia=184
Poblacion=184
Estado=184
CodigoPostal=94
Telefono=304
eMail=304
FormaPago=304
CtaDinero=66
PersonalCuenta=124
FechaNacimiento=94
Sexo=52
EstadoCivil=124
ZonaEconomica=184
TipoSueldo=124
SueldoDiario=66
SDI=64
Departamento=184
TipoContrato=304
Puesto=304
PeriodoTipo=64
Jornada=124
Moneda=64
Registro=184
Registro2=184
Registro3=184
FechaAlta=94
FechaBaja=94
Estatus=94
LugarNacimiento=304
Padre=304
Madre=304
UnidadMedica=73
Ok=64
OkRef=604

[Nomina.Columnas]
Tipo=121
FechaD=94
FechaA=94
Personal=64
SueldoDiario=64
TotalPer=64
TotalDed=64
IMSS=64
ISPT=64
Infonavit=64
NetoPagado=64
Ok=64
OkRef=155




[NOINomina.Columnas]
Personal=64
Tipo=76
FechaD=94
FechaA=94
SueldoDiario=64
TotalPer=64
TotalDed=64
IMSS=64
ISPT=64
Infonavit=64
NetoPagado=64
Ok=64
OkRef=192


Nombre=185
[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S










[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



















































[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=(Fin)
