
[Forma]
Clave=NOIPersonal
Icono=0
Modulos=(Todos)
CarpetaPrincipal=Personal
Nombre=Importar Personal


ListaCarpetas=(Lista)
PosicionInicialAlturaCliente=385
PosicionInicialAncho=1154
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=223
PosicionInicialArriba=218

PosicionSec1=495
Comentarios=Lista( Info.PeriodoTipo,  FechaEnTexto(Info.FechaD, <T>dd/mmm/aaaa<T>)+<T> - <T>+FechaEnTexto(Info.FechaA, <T>dd/mmm/aaaa<T>))
ExpresionesAlMostrar=Asigna(info.Aplica,Nulo)<BR>Asigna(Info.FechaA,Nulo)<BR>Asigna(Info.FechaD,Nulo)<BR>Asigna(Info.PeriodoTipo,Nulo)<BR>Asigna(info.Visible,Nulo)<BR>Asigna(Info.Visible,Nulo)
[NOIDepartamento.ListaEnCaptura]
(Inicio)=NOIDepartamento.Departamento
NOIDepartamento.Departamento=NOIDepartamento.Sucursal
NOIDepartamento.Sucursal=NOIDepartamento.Ok
NOIDepartamento.Ok=NOIDepartamento.OkRef
NOIDepartamento.OkRef=(Fin)





[NOIDepartamento.Columnas]
Departamento=304
Sucursal=64
Ok=64
OkRef=198

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=A&ceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[NOIPuestos.ListaEnCaptura]
(Inicio)=NOIPuestos.Puesto
NOIPuestos.Puesto=NOIPuestos.SueldoRangoMinimo
NOIPuestos.SueldoRangoMinimo=NOIPuestos.SueldoRangoMaximo
NOIPuestos.SueldoRangoMaximo=NOIPuestos.Ok
NOIPuestos.Ok=NOIPuestos.OkRef
NOIPuestos.OkRef=(Fin)






[NOIPuestos.Columnas]
Puesto=304
SueldoRangoMinimo=105
SueldoRangoMaximo=109
Ok=64
OkRef=193









































[NOIPersonal.Columnas]
Personal=64
ApellidoPaterno=64
ApellidoMaterno=110
Nombre=97
Tipo=85
Direccion=134
Colonia=193
Poblacion=130
Estado=127
CodigoPostal=74
Telefono=73
eMail=158
FormaPago=188
CtaDinero=99
PersonalCuenta=66
FechaNacimiento=124
Sexo=94
EstadoCivil=52
ZonaEconomica=69
TipoSueldo=78
SueldoDiario=78
SDI=66
Departamento=64
TipoContrato=184
Puesto=304
PeriodoTipo=304
Jornada=64
Moneda=124
Registro=64
Registro2=184
Registro3=184
FechaAlta=184
FechaBaja=94
Estatus=94
LugarNacimiento=94
Padre=102
Madre=126
UnidadMedica=108
Ok=73
OkRef=64
Verificado=159





















[NOIPersonal2.NOIPersonal.Ok]
Carpeta=NOIPersonal2
Clave=NOIPersonal.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOIPersonal2.NOIPersonal.OkRef]
Carpeta=NOIPersonal2
Clave=NOIPersonal.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[NOIPersonal2.Columnas]
Ok=64
OkRef=604








[Personal]
Estilo=Hoja
Clave=Personal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOIPersonal
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
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Personal
Pestana=S
RefrescarAlEntrar=S
ExpAntesRefrescar=Asigna(Info.Visible,Verdadero)<BR>Forma.ActualizarControles
FiltroGeneral=NOIPersonal.Estacion= {EstacionTrabajo} AND NOIPersonal.Nomina = <T>{Info.Aplica}<T>
[Personal.NOIPersonal.Verificado]
Carpeta=Personal
Clave=NOIPersonal.Verificado
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Personal.NOIPersonal.Personal]
Carpeta=Personal
Clave=NOIPersonal.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Personal.NOIPersonal.ApellidoPaterno]
Carpeta=Personal
Clave=NOIPersonal.ApellidoPaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Personal.NOIPersonal.ApellidoMaterno]
Carpeta=Personal
Clave=NOIPersonal.ApellidoMaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Personal.NOIPersonal.Nombre]
Carpeta=Personal
Clave=NOIPersonal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Personal.NOIPersonal.Tipo]
Carpeta=Personal
Clave=NOIPersonal.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Personal.NOIPersonal.Direccion]
Carpeta=Personal
Clave=NOIPersonal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Personal.NOIPersonal.Colonia]
Carpeta=Personal
Clave=NOIPersonal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Personal.NOIPersonal.Poblacion]
Carpeta=Personal
Clave=NOIPersonal.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Personal.NOIPersonal.Estado]
Carpeta=Personal
Clave=NOIPersonal.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Personal.NOIPersonal.CodigoPostal]
Carpeta=Personal
Clave=NOIPersonal.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Personal.NOIPersonal.Telefono]
Carpeta=Personal
Clave=NOIPersonal.Telefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Personal.NOIPersonal.eMail]
Carpeta=Personal
Clave=NOIPersonal.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Personal.NOIPersonal.FormaPago]
Carpeta=Personal
Clave=NOIPersonal.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Personal.NOIPersonal.CtaDinero]
Carpeta=Personal
Clave=NOIPersonal.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Personal.NOIPersonal.PersonalCuenta]
Carpeta=Personal
Clave=NOIPersonal.PersonalCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Personal.NOIPersonal.FechaNacimiento]
Carpeta=Personal
Clave=NOIPersonal.FechaNacimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Personal.NOIPersonal.Sexo]
Carpeta=Personal
Clave=NOIPersonal.Sexo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Personal.NOIPersonal.EstadoCivil]
Carpeta=Personal
Clave=NOIPersonal.EstadoCivil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Personal.NOIPersonal.ZonaEconomica]
Carpeta=Personal
Clave=NOIPersonal.ZonaEconomica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Personal.NOIPersonal.TipoSueldo]
Carpeta=Personal
Clave=NOIPersonal.TipoSueldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Personal.NOIPersonal.SueldoDiario]
Carpeta=Personal
Clave=NOIPersonal.SueldoDiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Personal.NOIPersonal.SDI]
Carpeta=Personal
Clave=NOIPersonal.SDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Personal.NOIPersonal.Departamento]
Carpeta=Personal
Clave=NOIPersonal.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Personal.NOIPersonal.TipoContrato]
Carpeta=Personal
Clave=NOIPersonal.TipoContrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Personal.NOIPersonal.Puesto]
Carpeta=Personal
Clave=NOIPersonal.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Personal.NOIPersonal.PeriodoTipo]
Carpeta=Personal
Clave=NOIPersonal.PeriodoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Personal.NOIPersonal.Jornada]
Carpeta=Personal
Clave=NOIPersonal.Jornada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Personal.NOIPersonal.Moneda]
Carpeta=Personal
Clave=NOIPersonal.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Personal.NOIPersonal.Registro]
Carpeta=Personal
Clave=NOIPersonal.Registro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Personal.NOIPersonal.Registro2]
Carpeta=Personal
Clave=NOIPersonal.Registro2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Personal.NOIPersonal.Registro3]
Carpeta=Personal
Clave=NOIPersonal.Registro3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Personal.NOIPersonal.FechaAlta]
Carpeta=Personal
Clave=NOIPersonal.FechaAlta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Personal.NOIPersonal.FechaBaja]
Carpeta=Personal
Clave=NOIPersonal.FechaBaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Personal.NOIPersonal.Estatus]
Carpeta=Personal
Clave=NOIPersonal.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Personal.NOIPersonal.LugarNacimiento]
Carpeta=Personal
Clave=NOIPersonal.LugarNacimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Personal.NOIPersonal.Padre]
Carpeta=Personal
Clave=NOIPersonal.Padre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Personal.NOIPersonal.Madre]
Carpeta=Personal
Clave=NOIPersonal.Madre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Personal.NOIPersonal.UnidadMedica]
Carpeta=Personal
Clave=NOIPersonal.UnidadMedica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Nomina Concepto.NOINominaConcepto.NominaConcepto]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.Concepto]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.Movimiento]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.GravaISR]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.GravaISR
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.GravaIMSS]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.GravaIMSS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.GravaImpuestoEstatal]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.GravaImpuestoEstatal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.Modulo]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.Estatus]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.Pais]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.CuentaGrupo]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.CuentaGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.Ok]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina Concepto.NOINominaConcepto.OkRef]
Carpeta=Nomina Concepto
Clave=NOINominaConcepto.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



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
[Nomina Concepto.Columnas]
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




[Departamentos.NOIDepartamento.Departamento]
Carpeta=Departamentos
Clave=NOIDepartamento.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Departamentos.NOIDepartamento.Sucursal]
Carpeta=Departamentos
Clave=NOIDepartamento.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Departamentos.Columnas]
Departamento=304
Sucursal=64




[Puestos.NOIPuestos.Puesto]
Carpeta=Puestos
Clave=NOIPuestos.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Puestos.NOIPuestos.SueldoRangoMinimo]
Carpeta=Puestos
Clave=NOIPuestos.SueldoRangoMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Puestos.NOIPuestos.SueldoRangoMaximo]
Carpeta=Puestos
Clave=NOIPuestos.SueldoRangoMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Puestos.NOIPuestos.Ok]
Carpeta=Puestos
Clave=NOIPuestos.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Puestos.NOIPuestos.OkRef]
Carpeta=Puestos
Clave=NOIPuestos.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco




[Nomina.NOINomina.Tipo]
Carpeta=Nomina
Clave=NOINomina.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Nomina.NOINomina.FechaD]
Carpeta=Nomina
Clave=NOINomina.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.FechaA]
Carpeta=Nomina
Clave=NOINomina.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.Personal]
Carpeta=Nomina
Clave=NOINomina.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Nomina.NOINomina.SueldoDiario]
Carpeta=Nomina
Clave=NOINomina.SueldoDiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.TotalPer]
Carpeta=Nomina
Clave=NOINomina.TotalPer
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.TotalDed]
Carpeta=Nomina
Clave=NOINomina.TotalDed
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.IMSS]
Carpeta=Nomina
Clave=NOINomina.IMSS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.ISPT]
Carpeta=Nomina
Clave=NOINomina.ISPT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.Infonavit]
Carpeta=Nomina
Clave=NOINomina.Infonavit
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.NetoPagado]
Carpeta=Nomina
Clave=NOINomina.NetoPagado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.Ok]
Carpeta=Nomina
Clave=NOINomina.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Nomina.NOINomina.OkRef]
Carpeta=Nomina
Clave=NOINomina.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



[Puestos.Columnas]
Puesto=304
SueldoRangoMinimo=105
SueldoRangoMaximo=109
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

[NOIPersonal2.ListaEnCaptura]
(Inicio)=NOIPersonal.Ok
NOIPersonal.Ok=NOIPersonal.OkRef
NOIPersonal.OkRef=(Fin)

[Departamentos.ListaEnCaptura]
(Inicio)=NOIDepartamento.Departamento
NOIDepartamento.Departamento=NOIDepartamento.Sucursal
NOIDepartamento.Sucursal=(Fin)

[Puestos.ListaEnCaptura]
(Inicio)=NOIPuestos.Puesto
NOIPuestos.Puesto=NOIPuestos.SueldoRangoMinimo
NOIPuestos.SueldoRangoMinimo=NOIPuestos.SueldoRangoMaximo
NOIPuestos.SueldoRangoMaximo=NOIPuestos.Ok
NOIPuestos.Ok=NOIPuestos.OkRef
NOIPuestos.OkRef=(Fin)






[Nomina Concepto.ListaEnCaptura]
(Inicio)=NOINominaConcepto.NominaConcepto
NOINominaConcepto.NominaConcepto=NOINominaConcepto.Concepto
NOINominaConcepto.Concepto=NOINominaConcepto.Movimiento
NOINominaConcepto.Movimiento=NOINominaConcepto.GravaISR
NOINominaConcepto.GravaISR=NOINominaConcepto.GravaIMSS
NOINominaConcepto.GravaIMSS=NOINominaConcepto.GravaImpuestoEstatal
NOINominaConcepto.GravaImpuestoEstatal=NOINominaConcepto.Modulo
NOINominaConcepto.Modulo=NOINominaConcepto.Estatus
NOINominaConcepto.Estatus=NOINominaConcepto.Pais
NOINominaConcepto.Pais=NOINominaConcepto.CuentaGrupo
NOINominaConcepto.CuentaGrupo=NOINominaConcepto.Ok
NOINominaConcepto.Ok=NOINominaConcepto.OkRef
NOINominaConcepto.OkRef=(Fin)


[Nomina.ListaEnCaptura]
(Inicio)=NOINomina.Tipo
NOINomina.Tipo=NOINomina.FechaD
NOINomina.FechaD=NOINomina.FechaA
NOINomina.FechaA=NOINomina.Personal
NOINomina.Personal=NOINomina.SueldoDiario
NOINomina.SueldoDiario=NOINomina.TotalPer
NOINomina.TotalPer=NOINomina.TotalDed
NOINomina.TotalDed=NOINomina.IMSS
NOINomina.IMSS=NOINomina.ISPT
NOINomina.ISPT=NOINomina.Infonavit
NOINomina.Infonavit=NOINomina.NetoPagado
NOINomina.NetoPagado=NOINomina.Ok
NOINomina.Ok=NOINomina.OkRef
NOINomina.OkRef=(Fin)












[NOINominaConcepto.ListaEnCaptura]
(Inicio)=NOINominaConcepto.NominaConcepto
NOINominaConcepto.NominaConcepto=NOINominaConcepto.Concepto
NOINominaConcepto.Concepto=NOINominaConcepto.Movimiento
NOINominaConcepto.Movimiento=NOINominaConcepto.GravaISR
NOINominaConcepto.GravaISR=NOINominaConcepto.GravaIMSS
NOINominaConcepto.GravaIMSS=NOINominaConcepto.GravaImpuestoEstatal
NOINominaConcepto.GravaImpuestoEstatal=NOINominaConcepto.Modulo
NOINominaConcepto.Modulo=NOINominaConcepto.Estatus
NOINominaConcepto.Estatus=NOINominaConcepto.Pais
NOINominaConcepto.Pais=NOINominaConcepto.CuentaGrupo
NOINominaConcepto.CuentaGrupo=NOINominaConcepto.Ok
NOINominaConcepto.Ok=NOINominaConcepto.OkRef
NOINominaConcepto.OkRef=(Fin)

[NOINominaConcepto.NOINominaConcepto.NominaConcepto]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Concepto]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Movimiento]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.GravaISR]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.GravaISR
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.GravaIMSS]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.GravaIMSS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.GravaImpuestoEstatal]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.GravaImpuestoEstatal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Modulo]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Estatus]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Pais]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.CuentaGrupo]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.CuentaGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Ok]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.OkRef]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



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






[NOIPersonal.NOIPersonal.OkRef]
Carpeta=NOIPersonal
Clave=NOIPersonal.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=150
ColorFondo=Blanco



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
[NOIPersonal.ListaEnCaptura]
(Inicio)=NOIPersonal.Ok
NOIPersonal.Ok=NOIPersonal.OkRef
NOIPersonal.OkRef=(Fin)

























[NOINomina]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Nomina
Clave=NOINomina
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOINomina
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
RefrescarAlEntrar=S



GuardarPorRegistro=S
HojaConfirmarEliminar=S
ExpAntesRefrescar=Asigna(Info.Visible,falso)<BR> Forma.ActualizarControles
FiltroGeneral=NOINomina.Estacion= {EstacionTrabajo} AND NOINomina.Nomina = <T>{Info.Aplica}<T>
[NOINomina.NOINomina.Personal]
Carpeta=NOINomina
Clave=NOINomina.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[NOINomina.NOINomina.SueldoDiario]
Carpeta=NOINomina
Clave=NOINomina.SueldoDiario
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINomina.NOINomina.TotalPer]
Carpeta=NOINomina
Clave=NOINomina.TotalPer
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINomina.NOINomina.TotalDed]
Carpeta=NOINomina
Clave=NOINomina.TotalDed
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINomina.NOINomina.IMSS]
Carpeta=NOINomina
Clave=NOINomina.IMSS
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINomina.NOINomina.ISPT]
Carpeta=NOINomina
Clave=NOINomina.ISPT
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINomina.NOINomina.Infonavit]
Carpeta=NOINomina
Clave=NOINomina.Infonavit
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINomina.NOINomina.NetoPagado]
Carpeta=NOINomina
Clave=NOINomina.NetoPagado
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINomina.NOINomina.Ok]
Carpeta=NOINomina
Clave=NOINomina.Ok
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINomina.NOINomina.OkRef]
Carpeta=NOINomina
Clave=NOINomina.OkRef
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco




[Acciones.NOIPuestos]
Nombre=NOIPuestos
Boton=90
NombreEnBoton=S
NombreDesplegar=&Puestos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NOIPuestos



RefrescarDespues=S




EspacioPrevio=S

Activo=S




ConCondicion=S

Antes=S
EjecucionCondicion=CarpetaActiva(<T>A1<T>)=<T>Personal<T>
VisibleCondicion=Info.Visible
[Acciones.NOIDepartamento]
Nombre=NOIDepartamento
Boton=91
NombreEnBoton=S
NombreDesplegar=Depar&tamentos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NOIDepartamento



ConCondicion=S






EspacioPrevio=S
Activo=S
EjecucionCondicion=CarpetaActiva(<T>A1<T>)=<T>Personal<T>
VisibleCondicion=Info.Visible
[Acciones.NOINominaConcepto]
Nombre=NOINominaConcepto
Boton=96
NombreEnBoton=S
NombreDesplegar=C&onceptos Nomina
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NOINominaConcepto
ConCondicion=S











Activo=S




EjecucionCondicion=CarpetaActiva(<T>A1<T>)=<T>NOINomina<T>
VisibleCondicion=Info.visible = Falso
[NOINomina.NOINomina.Nombre]
Carpeta=NOINomina
Clave=NOINomina.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=125
ColorFondo=Blanco






[Acciones.NOINominaD]
Nombre=NOINominaD
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle Nomina
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NOINominaD
Activo=S
Antes=S
DespuesGuardar=S





EspacioPrevio=S
ConCondicion=S

EjecucionCondicion=CarpetaActiva(<T>A1<T>)=<T>NOINomina<T>
AntesExpresiones=Asigna(Info.Personal,NOINomina:NOINomina.Personal)<BR>Asigna(Info.Nombre,NOINomina:NOINomina.Nombre)
VisibleCondicion=Info.visible = Falso
[Acciones.Validar]
Nombre=Validar
Boton=41
NombreEnBoton=S
NombreDesplegar=&Validar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S























EspacioPrevio=S









































































Antes=S
DespuesGuardar=S
RefrescarDespues=S
Expresion=EjecutarSQL(<T>spNOIVerificarPersonal :tEmpresa,:tNomina,:nEstacion<T>,Empresa,Info.Aplica,EstacionTrabajo)<BR> ActualizarForma
AntesExpresiones=SI(CarpetaActiva(<T>A1<T>)=<T>Personal<T>,Asigna(info.Visible,Verdadero),Asigna(Info.Visible,Falso))
[Personal.NOIPersonal.Ok]
Carpeta=Personal
Clave=NOIPersonal.Ok
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Personal.NOIPersonal.OkRef]
Carpeta=Personal
Clave=NOIPersonal.OkRef
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco





























[Acciones.Sugerir]
Nombre=Sugerir
Boton=92
NombreEnBoton=S
NombreDesplegar=&Sugerir
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S



Antes=S
DespuesGuardar=S
Expresion=FormaModal(<T>NOIParamTablaPeriodo<T>)<BR>ActualizarForma
AntesExpresiones=EjecutarSQL(<T>spNOITablaPeriodo :tEmpresa,:nEstacion<T>,Empresa,EstacionTrabajo)
[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Afectar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S











































































































ConfirmarAntes=S
DialogoMensaje=NOIEstaSeguroMov
Expresion=Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.EsNuevo,SQL(<T>SELECT TOP 1 NominaEspecial FROM NOINomina WHERE Estacion = :nEstacion AND Nomina = :tNomina<T>,EstacionTrabajo,Info.Aplica))<BR>Asigna(Info.SeVende,SQL(<T>SELECT dbo.fnNOIValidarImporte(:Empresa,:nEstacion,:tNomina)<T>,NOINomina:NOINomina.EmpresaNOI,EstacionTrabajo,NOINomina:NOINomina.Nomina))<BR>Caso  CarpetaActiva(<T>A1<T>)<BR>  Es <T>NOINomina<T><BR>  Entonces<BR>    Si Info.EsNuevo<BR>      Entonces<BR>        Caso  Info.SeVende<BR>          Es Verdadero Entonces Informacion(<T>Existen Importes Negativos<T>+NuevaLinea+<T>No Se Puede Afectar La Nomina<T>)<BR>        Sino<BR>          FormaModal(<T>NOINominaEspecial<T>)<BR>        Fin<BR>    SiNo<BR>        Caso  Info.SeVende<BR>          Es Verdadero  Entonces Informacion(<T>Existen Importes Negativos<T>+NuevaLinea+<T>No Se Puede Afectar La Nomina<T>)<BR>        Sino<BR>          ProcesarSQL(<T>spNOIGenerarNomina :tEmpresa,:tNomina,:tUsuario,:nEstacion,:tMov<T>,Empresa,Info.Aplica,Usuario,EstacionTrabajo,Nulo)<BR>        Fin<BR>    Fin<BR>Sino<BR>  Caso  Info.SeVende<BR>    Es Verdadero  Entonces Informacion(<T>Existen Importes Negativos<T>+NuevaLinea+<T>No Se Puede Afectar La Nomina<T>)<BR>  Sino<BR>    ProcesarSQL(<T>spNOIGenerarPersonal :tEmpresa,:tNomina,:tUsuario,:nEstacion<T>,Empresa,Info.Aplica,Usuario,EstacionTrabajo)<BR>  Fin<BR>Fin<BR>ActualizarForma

[NOINomina.ListaEnCaptura]
(Inicio)=NOINomina.Personal
NOINomina.Personal=NOINomina.Nombre
NOINomina.Nombre=NOINomina.SueldoDiario
NOINomina.SueldoDiario=NOINomina.TotalPer
NOINomina.TotalPer=NOINomina.TotalDed
NOINomina.TotalDed=NOINomina.IMSS
NOINomina.IMSS=NOINomina.ISPT
NOINomina.ISPT=NOINomina.Infonavit
NOINomina.Infonavit=NOINomina.NetoPagado
NOINomina.NetoPagado=NOINomina.Ok
NOINomina.Ok=NOINomina.OkRef
NOINomina.OkRef=(Fin)

[Personal.ListaEnCaptura]
(Inicio)=NOIPersonal.Verificado
NOIPersonal.Verificado=NOIPersonal.Personal
NOIPersonal.Personal=NOIPersonal.ApellidoPaterno
NOIPersonal.ApellidoPaterno=NOIPersonal.ApellidoMaterno
NOIPersonal.ApellidoMaterno=NOIPersonal.Nombre
NOIPersonal.Nombre=NOIPersonal.Tipo
NOIPersonal.Tipo=NOIPersonal.Direccion
NOIPersonal.Direccion=NOIPersonal.Colonia
NOIPersonal.Colonia=NOIPersonal.Poblacion
NOIPersonal.Poblacion=NOIPersonal.Estado
NOIPersonal.Estado=NOIPersonal.CodigoPostal
NOIPersonal.CodigoPostal=NOIPersonal.Telefono
NOIPersonal.Telefono=NOIPersonal.eMail
NOIPersonal.eMail=NOIPersonal.FormaPago
NOIPersonal.FormaPago=NOIPersonal.CtaDinero
NOIPersonal.CtaDinero=NOIPersonal.PersonalCuenta
NOIPersonal.PersonalCuenta=NOIPersonal.FechaNacimiento
NOIPersonal.FechaNacimiento=NOIPersonal.Sexo
NOIPersonal.Sexo=NOIPersonal.EstadoCivil
NOIPersonal.EstadoCivil=NOIPersonal.ZonaEconomica
NOIPersonal.ZonaEconomica=NOIPersonal.TipoSueldo
NOIPersonal.TipoSueldo=NOIPersonal.SueldoDiario
NOIPersonal.SueldoDiario=NOIPersonal.SDI
NOIPersonal.SDI=NOIPersonal.Departamento
NOIPersonal.Departamento=NOIPersonal.TipoContrato
NOIPersonal.TipoContrato=NOIPersonal.Puesto
NOIPersonal.Puesto=NOIPersonal.PeriodoTipo
NOIPersonal.PeriodoTipo=NOIPersonal.Jornada
NOIPersonal.Jornada=NOIPersonal.Moneda
NOIPersonal.Moneda=NOIPersonal.Registro
NOIPersonal.Registro=NOIPersonal.Registro2
NOIPersonal.Registro2=NOIPersonal.Registro3
NOIPersonal.Registro3=NOIPersonal.FechaAlta
NOIPersonal.FechaAlta=NOIPersonal.FechaBaja
NOIPersonal.FechaBaja=NOIPersonal.Estatus
NOIPersonal.Estatus=NOIPersonal.LugarNacimiento
NOIPersonal.LugarNacimiento=NOIPersonal.Padre
NOIPersonal.Padre=NOIPersonal.Madre
NOIPersonal.Madre=NOIPersonal.UnidadMedica
NOIPersonal.UnidadMedica=NOIPersonal.Ok
NOIPersonal.Ok=NOIPersonal.OkRef
NOIPersonal.OkRef=(Fin)



























































[NOINominaGenerada.Columnas]
0=135



































1=129
[Acciones.Re-Importar]
Nombre=Re-Importar
Boton=82
NombreEnBoton=S
NombreDesplegar=&Re-Importar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S
DespuesGuardar=S







Visible=S




Expresion=FormaModal(<T>NOIParamTablaPeriodo<T>)<BR>ActualizarForma
AntesExpresiones=EjecutarSQL(<T>spNOITablaPeriodo2 :tEmpresa,:nEstacion<T>,Empresa,EstacionTrabajo)












[Acciones.ReActivar]
Nombre=ReActivar
Boton=40
NombreDesplegar=R&e-Activar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

NombreEnBoton=S
GuardarAntes=S
EspacioPrevio=S








Expresion=FormaModal(<T>NOINominaGenerada<T>)












[Forma.ListaCarpetas]
(Inicio)=Personal
Personal=NOINomina
NOINomina=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Sugerir
Sugerir=NOIPuestos
NOIPuestos=NOIDepartamento
NOIDepartamento=NOINominaConcepto
NOINominaConcepto=NOINominaD
NOINominaD=Validar
Validar=Afectar
Afectar=Re-Importar
Re-Importar=ReActivar
ReActivar=(Fin)
