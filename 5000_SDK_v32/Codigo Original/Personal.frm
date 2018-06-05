[Forma]
Clave=Personal
Nombre=Personal
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=471
PosicionInicialArriba=145
PosicionInicialAltura=578
PosicionInicialAncho=665
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
BarraAyuda=S
DialogoAbrir=S
Plantillas=S
PermiteCopiarDoc=S
PlantillasExcepciones=(Lista)
MovModulo=RH
PosicionInicialAlturaCliente=640
PosicionSec1=238
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Tipo,<T>Personal<T>)

MenuPrincipal=(Lista)
[Lista.Personal.Personal]
Carpeta=Lista
Clave=Personal.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Personal=115
NombreCompleto=287
Fecha=148
Usuario=82
Nombre=304
Sucursal=64
Nombre_1=154
Empresa=69
0=84
1=111
2=-2

CentroCostos=127
Descripcion=235
[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S
ConCondicion=S
EjecucionConError=S
GuardarAntes=S
EjecucionCondicion=Si<BR>  Personal:Personal.Confidencial<BR>Entonces<BR>  Asigna(Personal:Personal.ApellidoPaterno, Ofuscar(Personal:Personal.ApellidoPaterno))<BR>  Asigna(Personal:Personal.ApellidoMaterno, Ofuscar(Personal:Personal.ApellidoMaterno))<BR>  Asigna(Personal:Personal.Nombre, Ofuscar(Personal:Personal.Nombre))<BR>Fin<BR>(no Config.NomCCRequerido) o ConDatos(Personal:Personal.CentroCostos)
EjecucionMensaje=<T>Falta Indicar el Centro de Costos<T>
Antes=S
AntesExpresiones=Asigna(Info.Cuenta,Personal:Personal.Personal)<BR>EjecutarSQL(<T>spMESCatalogos :tCatalogo, :tINTCuenta<T>,<T>OperMES<T>,Info.Cuenta)
DespuesGuardar=S
[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalle.Personal.Personal]
Carpeta=Detalle
Clave=Personal.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Personal.ApellidoPaterno]
Carpeta=Detalle
Clave=Personal.ApellidoPaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Personal.ApellidoMaterno]
Carpeta=Detalle
Clave=Personal.ApellidoMaterno
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Personal.Nombre]
Carpeta=Detalle
Clave=Personal.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Personal.Direccion]
Carpeta=Detalle
Clave=Personal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Blanco

[Detalle.Personal.Colonia]
Carpeta=Detalle
Clave=Personal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.Poblacion]
Carpeta=Detalle
Clave=Personal.Poblacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.Estado]
Carpeta=Detalle
Clave=Personal.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.Pais]
Carpeta=Detalle
Clave=Personal.Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Detalle.Personal.CodigoPostal]
Carpeta=Detalle
Clave=Personal.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.Telefono]
Carpeta=Detalle
Clave=Personal.Telefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
EspacioPrevio=N

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+N

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
Menu=&Archivo
EnMenu=S
EspacioPrevio=S

ConCondicion=S
ActivoCondicion=no Personal:Personal.TieneMovimientos
EjecucionCondicion=Forma.ActualizarVista<BR>Forma.ActualizarControles<BR>Si<BR>  Personal:Personal.TieneMovimientos<BR>Entonces<BR>  Error(<T>El personal ya tiene movimientos activos<T> , BotonAceptar  )<BR>Fin
Antes=S
AntesExpresiones=Asigna(Info.Cuenta,Personal:Personal.Personal)<BR>EjecutarSQL(<T>spMESCatalogos :tCatalogo, :tINTCuenta, :nEliminar<T>,<T>OperMES<T>,Info.Cuenta,1)
[Detalle.Personal.Jornada]
Carpeta=Detalle
Clave=Personal.Jornada
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Detalle.Personal.TipoContrato]
Carpeta=Detalle
Clave=Personal.TipoContrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Personal.PeriodoTipo]
Carpeta=Detalle
Clave=Personal.PeriodoTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Detalle.Personal.eMail]
Carpeta=Detalle
Clave=Personal.eMail
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=&Propiedades
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Visible=S
ClaveAccion=PersonalPropValor
Antes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Rama, <T>PER<T>)<BR>Asigna(Info.Cuenta, Personal:Personal.Personal)<BR>Asigna(Info.Descripcion, Personal:NombreCompleto)

[Detalle.Personal.TipoSalario]
Carpeta=Detalle
Clave=Personal.TipoSalario
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.SalarioFijo]
Carpeta=Detalle
Clave=Personal.SalarioFijo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
EspacioPrevio=S

[Detalle.Personal.SalarioVariable]
Carpeta=Detalle
Clave=Personal.SalarioVariable
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=N

[Detalle.Personal.Moneda]
Carpeta=Detalle
Clave=Personal.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
Pegado=N

[Detalle.]
Carpeta=Detalle
ColorFondo=Negro

[RH]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Recursos Humanos
Clave=RH
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[RH.Personal.Personal]
Carpeta=RH
Clave=Personal.Personal
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[RH.NombreCompleto]
Carpeta=RH
Clave=NombreCompleto
Editar=S
3D=S
Tamano=62
ColorFondo=Plata
Efectos=[Negritas]

[RH.Personal.FechaAlta]
Carpeta=RH
Clave=Personal.FechaAlta
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
Editar=S
ColorFondo=Blanco

[RH.Personal.UltimaModificacion]
Carpeta=RH
Clave=Personal.UltimaModificacion
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
Editar=S
ColorFondo=Blanco

[RH.Personal.FechaBaja]
Carpeta=RH
Clave=Personal.FechaBaja
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
Editar=S
ColorFondo=Blanco

[Nomina]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Regla Negocio
Clave=Nomina
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=110
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Nomina.Personal.FormaPago]
Carpeta=Nomina
Clave=Personal.FormaPago
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.CtaDinero]
Carpeta=Nomina
Clave=Personal.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.Afore]
Carpeta=Nomina
Clave=Personal.Afore
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Nomina.Personal.PersonalCuenta]
Carpeta=Nomina
Clave=Personal.PersonalCuenta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Nomina.Personal.PersonalSucursal]
Carpeta=Nomina
Clave=Personal.PersonalSucursal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Prov.Nombre]
Carpeta=Nomina
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Nomina.Personal.Personal]
Carpeta=Nomina
Clave=Personal.Personal
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Nomina.NombreCompleto]
Carpeta=Nomina
Clave=NombreCompleto
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Editar=S

[RH.Personal.Categoria]
Carpeta=RH
Clave=Personal.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
EspacioPrevio=N
ColorFondo=Blanco

[RH.Personal.Departamento]
Carpeta=RH
Clave=Personal.Departamento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=N
ColorFondo=Blanco

[RH.Personal.Grupo]
Carpeta=RH
Clave=Personal.Grupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[RH.Personal.Puesto]
Carpeta=RH
Clave=Personal.Puesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
EspacioPrevio=N
ColorFondo=Blanco

[RH.Personal.Valuacion]
Carpeta=RH
Clave=Personal.Valuacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RH.Personal.NivelAcademico]
Carpeta=RH
Clave=Personal.NivelAcademico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=N

[RH.Personal.ReportaA]
Carpeta=RH
Clave=Personal.ReportaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[RH.NombreReporta]
Carpeta=RH
Clave=NombreReporta
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Editar=S
OcultaNombre=S

[Detalle.Personal.Tipo]
Carpeta=Detalle
Clave=Personal.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]

[RH.Personal.UltimoPago]
Carpeta=RH
Clave=Personal.UltimoPago
ValidaNombre=S
3D=S
Tamano=20
Editar=S
ColorFondo=Blanco

[Evaluacion.RHD.Calificacion]
Carpeta=Evaluacion
Clave=RHD.Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Evaluacion.RHD.Observaciones]
Carpeta=Evaluacion
Clave=RHD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Evaluacion.RH.FechaEmision]
Carpeta=Evaluacion
Clave=RH.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Evaluacion.Evaluacion.Tipo]
Carpeta=Evaluacion
Clave=Evaluacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.EstatusNombre]
Carpeta=Detalle
Clave=EstatusNombre
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[Nomina.CtaDineroDestino.Descripcion]
Carpeta=Nomina
Clave=CtaDineroDestino.Descripcion
Editar=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Detalle.Personal.Registro]
Carpeta=Detalle
Clave=Personal.Registro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Personal.Nacionalidad]
Carpeta=Detalle
Clave=Personal.Nacionalidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.FechaNacimiento]
Carpeta=Detalle
Clave=Personal.FechaNacimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.Sexo]
Carpeta=Detalle
Clave=Personal.Sexo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Detalle.Personal.EstadoCivil]
Carpeta=Detalle
Clave=Personal.EstadoCivil
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S

[Detalle.Personal.Pasaporte]
Carpeta=Detalle
Clave=Personal.Pasaporte
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RH.Personal.FechaAntiguedad]
Carpeta=RH
Clave=Personal.FechaAntiguedad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
Editar=S
ColorFondo=Blanco

[RH.Antiguedad]
Carpeta=RH
Clave=Antiguedad
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Editar=S

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Rama, <T>NOM<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Personal:Personal.Personal)<BR>Asigna(Info.Descripcion, Personal:NombreCompleto)
RefrescarDespues=S

[Detalle.Personal.Registro2]
Carpeta=Detalle
Clave=Personal.Registro2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.Registro3]
Carpeta=Detalle
Clave=Personal.Registro3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Info]
Nombre=Info
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PersonalInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
Antes=S
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)
Visible=S

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Edición
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=EditarDocumentacion(<T>RH<T>, Personal:Personal.Personal, <T>Documentación - <T>+Personal:NombreCompleto)
EjecucionCondicion=ConDatos(Personal:Personal.Personal)

[Acciones.Puesto]
Nombre=Puesto
Boton=0
Menu=&Maestros
NombreDesplegar=&Puestos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Puesto
Visible=S
EspacioPrevio=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[Acciones.Departamento]
Nombre=Departamento
Boton=0
Menu=&Maestros
NombreDesplegar=&Departamentos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Departamento
Visible=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[Acciones.PersonalCat]
Nombre=PersonalCat
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalCat
Visible=S
EspacioPrevio=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[Acciones.PersonalGrupo]
Nombre=PersonalGrupo
Boton=0
Menu=&Maestros
NombreDesplegar=&Grupos
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalGrupo
Visible=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[Acciones.Nacionalidad]
Nombre=Nacionalidad
Boton=0
Menu=&Maestros
NombreDesplegar=&Nacionalidades
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Nacionalidad
Visible=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[Acciones.NivelAcademico]
Nombre=NivelAcademico
Boton=0
Menu=&Maestros
NombreDesplegar=Niveles &Académicos
EnMenu=S
TipoAccion=Formas
ClaveAccion=NivelAcademico
Visible=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[Acciones.PersonalValuacion]
Nombre=PersonalValuacion
Boton=0
Menu=&Maestros
NombreDesplegar=&Valuaciones Laborales
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalValuacion
Visible=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[Acciones.ZonaEconomica]
Nombre=ZonaEconomica
Boton=0
Menu=&Maestros
NombreDesplegar=&Zona Económica
EnMenu=S
TipoAccion=Formas
ClaveAccion=ZonaEconomica
Visible=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Personas
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=PersonalA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
IconosSubTitulo=<T>Clave<T>
ListaEnCaptura=NombreCompleto2
ListaOrden=PersonalA.NombreCompleto<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Departamento
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=Puesto
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=PersonalCat
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=PersonalGrupo
FiltroAplicaEn1=PersonalA.Departamento
FiltroAplicaEn2=PersonalA.Puesto
FiltroAplicaEn3=PersonalA.Categoria
FiltroAplicaEn4=PersonalA.Grupo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroAncho=20
FiltroListas=S
FiltroListasRama=RH
FiltroListasAplicaEn=PersonalA.Personal
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNombre=&Vencimiento
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=BAJA
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ListaAcciones=(Lista)
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroSucursales=S
FiltroFechas=S
FiltroFechasCampo=PersonalA.VencimientoContrato
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=PersonalTipo
FiltroAplicaEn5=PersonalA.Tipo
FiltroEmpresas=S
FiltroIgnorarEmpresas=S

IconosNombre=PersonalA:PersonalA.Personal
[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.preliminar]
Nombre=preliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[(Carpeta Abrir).Columnas]
0=99
1=358

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=Situación
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Visible=S
ActivoCondicion=Usuario.ModificarSituacion

[Nomina.Personal.Registro4]
Carpeta=Nomina
Clave=Personal.Registro4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros4]
Nombre=Otros4
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros5]
Nombre=Otros5
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros8]
Nombre=Otros8
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[RH.Personal.SucursalTrabajo]
Carpeta=RH
Clave=Personal.SucursalTrabajo
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
Editar=S
ColorFondo=Blanco

[Detalle.Personal.LugarNacimiento]
Carpeta=Detalle
Clave=Personal.LugarNacimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.Delegacion]
Carpeta=Detalle
Clave=Personal.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RH.Personal.ConceptoBaja]
Carpeta=RH
Clave=Personal.ConceptoBaja
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Otros.Personal.Personal]
Carpeta=Otros
Clave=Personal.Personal
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Otros.NombreCompleto]
Carpeta=Otros
Clave=NombreCompleto
ValidaNombre=N
3D=S
Tamano=66
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Otros.Personal.NivelAcceso]
Carpeta=Otros
Clave=Personal.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Padre]
Carpeta=Detalle
Clave=Personal.Padre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Detalle.Personal.Madre]
Carpeta=Detalle
Clave=Personal.Madre
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Detalle.Personal.UnidadMedica]
Carpeta=Detalle
Clave=Personal.UnidadMedica
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[RH.Personal.CentroCostos]
Carpeta=RH
Clave=Personal.CentroCostos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N
EspacioPrevio=N

[Acciones.CalcSueldo]
Nombre=CalcSueldo
Boton=10
Menu=&Edición
NombreDesplegar=&Calcular Sueldo Diario...
EnMenu=S
TipoAccion=Expresion
EspacioPrevio=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=F7
GuardarAntes=S

Expresion=Si(Forma(<T>CalcSueldoDiario<T>), Asigna(Personal:Personal.SueldoDiario, Info.Sueldo))
ActivoCondicion=Personal:Personal.Estatus en (EstatusAspirante, EstatusCandidato)
AntesExpresiones=Asigna(Info.PeriodoTipo, Personal:Personal.PeriodoTipo)<BR>Asigna(Info.Anos, Personal:AnosCumplidos)<BR>Asigna(Info.Sueldo, Nulo)<BR>Asigna(Info.Personal, Personal:Personal.Personal)
[Soporte.Soporte.FechaEmision]
Carpeta=Soporte
Clave=Soporte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Vencimiento]
Carpeta=Soporte
Clave=Soporte.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Titulo]
Carpeta=Soporte
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.ZonaEconomica]
Carpeta=Nomina
Clave=Personal.ZonaEconomica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Nomina.Personal.MinimoProfesional]
Carpeta=Nomina
Clave=Personal.MinimoProfesional
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Nomina.MinimosProfesionales.Descripcion]
Carpeta=Nomina
Clave=MinimosProfesionales.Descripcion
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Nomina.Personal.TipoContrato]
Carpeta=Nomina
Clave=Personal.TipoContrato
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Nomina.Personal.PeriodoTipo]
Carpeta=Nomina
Clave=Personal.PeriodoTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Nomina.Personal.SueldoDiario]
Carpeta=Nomina
Clave=Personal.SueldoDiario
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.SDI]
Carpeta=Nomina
Clave=Personal.SDI
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.Moneda]
Carpeta=Nomina
Clave=Personal.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.VencimientoContrato]
Carpeta=Nomina
Clave=Personal.VencimientoContrato
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.Jornada]
Carpeta=Nomina
Clave=Personal.Jornada
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.TipoSueldo]
Carpeta=Nomina
Clave=Personal.TipoSueldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.SueldoMinimoProfesional]
Carpeta=Nomina
Clave=SueldoMinimoProfesional
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Nomina.Personal.Sindicato]
Carpeta=Nomina
Clave=Personal.Sindicato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sindicato]
Nombre=Sindicato
Boton=0
Menu=&Maestros
NombreDesplegar=&Sindicatos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Sindicato
Visible=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[Acciones.PersonalParecidos]
Nombre=PersonalParecidos
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=Parecidos
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalParecidos
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Nombre, Personal:Personal.ApellidoPaterno)<BR>Asigna(Info.Nombre2, Personal:Personal.ApellidoMaterno)

[Nomina.Personal.Vehiculo]
Carpeta=Nomina
Clave=Personal.Vehiculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Vehiculo.Descripcion]
Carpeta=Nomina
Clave=Vehiculo.Descripcion
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Nomina.Vehiculo.Placas]
Carpeta=Nomina
Clave=Vehiculo.Placas
ValidaNombre=S
3D=S
Pegado=N
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[ComisionesEsp]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comisiones Especiales
Clave=ComisionesEsp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CondicionVisible=Config.ComisionEspecial

[ComisionesEsp.Personal.Personal]
Carpeta=ComisionesEsp
Clave=Personal.Personal
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[ComisionesEsp.NombreCompleto]
Carpeta=ComisionesEsp
Clave=NombreCompleto
Editar=S
3D=S
Tamano=56
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[ComisionesEsp.Personal.TablaCobranza]
Carpeta=ComisionesEsp
Clave=Personal.TablaCobranza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[ComisionesEsp.Personal.TablaCobranzaBono]
Carpeta=ComisionesEsp
Clave=Personal.TablaCobranzaBono
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[ComisionesEsp.Personal.TablaCobranzaCascada]
Carpeta=ComisionesEsp
Clave=Personal.TablaCobranzaCascada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[ComisionesEsp.Personal.TablaCobranzaBonoCascada]
Carpeta=ComisionesEsp
Clave=Personal.TablaCobranzaBonoCascada
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[ComisionesEsp.Personal.TablaVentaCascada]
Carpeta=ComisionesEsp
Clave=Personal.TablaVentaCascada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Beneficiarios
Clave=Beneficiarios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Beneficiarios.Personal.Personal]
Carpeta=Beneficiarios
Clave=Personal.Personal
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Beneficiarios.NombreCompleto]
Carpeta=Beneficiarios
Clave=NombreCompleto
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Beneficiarios.Personal.Beneficiario]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=46
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Parentesco]
Carpeta=Beneficiarios
Clave=Personal.Parentesco
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Porcentaje]
Carpeta=Beneficiarios
Clave=Personal.Porcentaje
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Beneficiario2]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario2
Editar=S
LineaNueva=S
3D=S
Tamano=46
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Parentesco2]
Carpeta=Beneficiarios
Clave=Personal.Parentesco2
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Porcentaje2]
Carpeta=Beneficiarios
Clave=Personal.Porcentaje2
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Beneficiario3]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario3
Editar=S
LineaNueva=S
3D=S
Tamano=46
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Parentesco3]
Carpeta=Beneficiarios
Clave=Personal.Parentesco3
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Porcentaje3]
Carpeta=Beneficiarios
Clave=Personal.Porcentaje3
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Hijos]
Carpeta=Detalle
Clave=Personal.Hijos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.Personal.Dependientes]
Carpeta=Detalle
Clave=Personal.Dependientes
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Cubos]
Nombre=Cubos
Boton=100
Menu=&Ver
NombreDesplegar=<T>Cubo Nómina<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Dialogos
Activo=S
ClaveAccion=CuboPersonal
ConCondicion=S
Antes=S

EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)
Visible=S
[Acciones.Alta Express]
Nombre=Alta Express
Boton=7
Menu=&Archivo
NombreDesplegar=Alta Express...
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguroAltaExpress
TipoAccion=Expresion
ConCondicion=S
Visible=S
GuardarAntes=S
RefrescarDespues=S
UsaTeclaRapida=S
TeclaRapida=F12
EjecucionConError=S
Expresion=ProcesarSQL(<T>spRHAltaExpress :tEmp, :nSuc, :tUsr, :tPersonal<T>, Empresa, Sucursal, Usuario, Personal:Personal.Personal)
ActivoCondicion=Personal:Personal.Estatus en (EstatusAspirante, EstatusCandidato) y (no Usuario.BloquearAltaExpressPersonal)
EjecucionCondicion=ConDatos(Personal:Personal.Personal) y ConDatos(Personal:Personal.PeriodoTipo) y<BR>ConDatos(Personal:Personal.FormaPago) y ConDatos(Personal:Personal.CtaDinero) y<BR>ConDatos(Personal:Personal.SueldoDiario) y ConDatos(Personal:Personal.FechaAlta) y<BR>ConDatos(Personal:Personal.FechaAntiguedad)
EjecucionMensaje=<T>Campos Requeridos: Tipo Periodo, Forma Pago, Cuenta Pago, Sueldo Diario, Fecha Alta, Fecha Antiguedad<T>

[RH.Departamento.Descripcion]
Carpeta=RH
Clave=Departamento.Descripcion
Editar=S
LineaNueva=N
Tamano=20
ColorFondo=Plata

[RH.Puesto.Descripcion]
Carpeta=RH
Clave=Puesto.Descripcion
Editar=S
Tamano=41
ColorFondo=Plata

[RH.PersonalCat.Descripcion]
Carpeta=RH
Clave=PersonalCat.Descripcion
Editar=S
Tamano=41
ColorFondo=Plata
LineaNueva=S

[RH.PersonalGrupo.Descripcion]
Carpeta=RH
Clave=PersonalGrupo.Descripcion
Editar=S
Tamano=41
ColorFondo=Plata

[RH.Personal.UEN]
Carpeta=RH
Clave=Personal.UEN
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=103
Menu=&Edición
NombreDesplegar=E&valuaciones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EvaluacionCalificacion
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)<BR>Asigna(Info.Aplica, <T>Personal<T>)<BR>Asigna(Info.Nombre2, Nulo)
Visible=S

[Beneficiarios.Personal.Beneficiario4]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario4
Editar=S
LineaNueva=S
3D=S
Tamano=46
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Parentesco4]
Carpeta=Beneficiarios
Clave=Personal.Parentesco4
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Porcentaje4]
Carpeta=Beneficiarios
Clave=Personal.Porcentaje4
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Beneficiario5]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario5
Editar=S
LineaNueva=S
3D=S
Tamano=46
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Parentesco5]
Carpeta=Beneficiarios
Clave=Personal.Parentesco5
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Porcentaje5]
Carpeta=Beneficiarios
Clave=Personal.Porcentaje5
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Beneficiario6]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario6
Editar=S
LineaNueva=S
3D=S
Tamano=46
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Parentesco6]
Carpeta=Beneficiarios
Clave=Personal.Parentesco6
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Porcentaje6]
Carpeta=Beneficiarios
Clave=Personal.Porcentaje6
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Beneficiario7]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario7
Editar=S
LineaNueva=S
3D=S
Tamano=46
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Parentesco7]
Carpeta=Beneficiarios
Clave=Personal.Parentesco7
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Porcentaje7]
Carpeta=Beneficiarios
Clave=Personal.Porcentaje7
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Beneficiario8]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario8
Editar=S
LineaNueva=S
3D=S
Tamano=46
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Parentesco8]
Carpeta=Beneficiarios
Clave=Personal.Parentesco8
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Porcentaje8]
Carpeta=Beneficiarios
Clave=Personal.Porcentaje8
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.PersonalUltimoPago]
Nombre=PersonalUltimoPago
Boton=0
Menu=&Ver
NombreDesplegar=&Ultimo Pago
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalUltimoPago
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)

[Acciones.Area]
Nombre=Area
Boton=0
Menu=&Maestros
NombreDesplegar=Areas
EnMenu=S
TipoAccion=Formas
ClaveAccion=Area
Visible=S
EspacioPrevio=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[Acciones.Fuente]
Nombre=Fuente
Boton=0
Menu=&Maestros
NombreDesplegar=Fuentes
EnMenu=S
TipoAccion=Formas
ClaveAccion=Fuente
Visible=S
ActivoCondicion=no Usuario.BloquearMaestrosPersonal

[RH.Personal.Area]
Carpeta=RH
Clave=Personal.Area
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[RH.Personal.Fuente]
Carpeta=RH
Clave=Personal.Fuente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RH.Personal.Reclutador]
Carpeta=RH
Clave=Personal.Reclutador
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S

[RH.NombreReclutador]
Carpeta=RH
Clave=NombreReclutador
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
OcultaNombre=S

[Acciones.Sucursales]
Nombre=Sucursales
Boton=0
Menu=&Edición
NombreDesplegar=&Sucursales Asignadas
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalSuc
Activo=S
ConCondicion=S
Antes=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)
VisibleCondicion=Personal:Personal.Tipo en (<T>Encargado<T>, <T>Encargado Zona<T>,<T>Supervisor<T>, <T>Gerente<T>)

[RH.Personal.RecomendadoPor]
Carpeta=RH
Clave=Personal.RecomendadoPor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RH.NombreRecomendadoPor]
Carpeta=RH
Clave=NombreRecomendadoPor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
OcultaNombre=S

[Acciones.PersonalAcceso]
Nombre=PersonalAcceso
Boton=0
Menu=&Edición
NombreDesplegar=Acceso Especifico...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalAcceso
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)
VisibleCondicion=General.NivelAccesoEsp y (Personal:Personal.NivelAcceso=<T>(Especifico)<T>)

[Nomina.Personal.MovNomina]
Carpeta=Nomina
Clave=Personal.MovNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RH.UEN.Nombre]
Carpeta=RH
Clave=UEN.Nombre
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Plata
ValidaNombre=S
OcultaNombre=S

[RH.Sucursal.Nombre]
Carpeta=RH
Clave=Sucursal.Nombre
Editar=S
ValidaNombre=S
OcultaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[RH.CentroCostos.Descripcion]
Carpeta=RH
Clave=CentroCostos.Descripcion
Editar=S
ValidaNombre=S
OcultaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[OtrosDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=OtrosDatos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[OtrosDatos.Personal.Personal]
Carpeta=OtrosDatos
Clave=Personal.Personal
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[OtrosDatos.NombreCompleto]
Carpeta=OtrosDatos
Clave=NombreCompleto
Editar=S
ValidaNombre=N
3D=S
Tamano=62
ColorFondo=Plata
Efectos=[Negritas]

[OtrosDatos.Personal.Cuenta]
Carpeta=OtrosDatos
Clave=Personal.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[OtrosDatos.Cta.Descripcion]
Carpeta=OtrosDatos
Clave=Cta.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata

[OtrosDatos.Personal.CuentaRetencion]
Carpeta=OtrosDatos
Clave=Personal.CuentaRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[OtrosDatos.CtaRetencion.Descripcion]
Carpeta=OtrosDatos
Clave=CtaRetencion.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata

[Acciones.PersonalCfg]
Nombre=PersonalCfg
Boton=0
Menu=&Edición
NombreDesplegar=Deducciones Especiales...
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalCfg
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)

[Beneficiarios.Personal.BeneficiarioNacimiento]
Carpeta=Beneficiarios
Clave=Personal.BeneficiarioNacimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Beneficiarios.Personal.Beneficiario2Nacimiento]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario2Nacimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Beneficiarios.Personal.Beneficiario3Nacimiento]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario3Nacimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Beneficiarios.Personal.Beneficiario4Nacimiento]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario4Nacimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Beneficiarios.Personal.Beneficiario5Nacimiento]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario5Nacimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Beneficiarios.Personal.Beneficiario6Nacimiento]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario6Nacimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Beneficiarios.Personal.Beneficiario7Nacimiento]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario7Nacimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Beneficiarios.Personal.Beneficiario8Nacimiento]
Carpeta=Beneficiarios
Clave=Personal.Beneficiario8Nacimiento
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[OtrosDatos.Personal.Referencia]
Carpeta=OtrosDatos
Clave=Personal.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=35
ColorFondo=Blanco

[OtrosDatos.Personal.ReferenciaDireccion]
Carpeta=OtrosDatos
Clave=Personal.ReferenciaDireccion
Editar=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[OtrosDatos.Personal.ReferenciaTelefono]
Carpeta=OtrosDatos
Clave=Personal.ReferenciaTelefono
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco

[OtrosDatos.Personal.Referencia2]
Carpeta=OtrosDatos
Clave=Personal.Referencia2
Editar=S
LineaNueva=S
3D=S
Tamano=35
ColorFondo=Blanco

[OtrosDatos.Personal.Referencia2Direccion]
Carpeta=OtrosDatos
Clave=Personal.Referencia2Direccion
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco

[OtrosDatos.Personal.Referencia2Telefono]
Carpeta=OtrosDatos
Clave=Personal.Referencia2Telefono
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco

[OtrosDatos.Personal.Referencia3]
Carpeta=OtrosDatos
Clave=Personal.Referencia3
Editar=S
LineaNueva=S
3D=S
Tamano=35
ColorFondo=Blanco

[OtrosDatos.Personal.Referencia3Direccion]
Carpeta=OtrosDatos
Clave=Personal.Referencia3Direccion
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco

[OtrosDatos.Personal.Referencia3Telefono]
Carpeta=OtrosDatos
Clave=Personal.Referencia3Telefono
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco

[Detalle.Personal.Licencia]
Carpeta=Detalle
Clave=Personal.Licencia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.LicenciaVencimiento]
Carpeta=Detalle
Clave=Personal.LicenciaVencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[OtrosDatos.Personal.Cartilla]
Carpeta=OtrosDatos
Clave=Personal.Cartilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[OtrosDatos.Personal.Permiso]
Carpeta=OtrosDatos
Clave=Personal.Permiso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[OtrosDatos.Personal.Cliente]
Carpeta=OtrosDatos
Clave=Personal.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[OtrosDatos.Cte.Nombre]
Carpeta=OtrosDatos
Clave=Cte.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata

[Detalle.Personal.eMailAuto]
Carpeta=Detalle
Clave=Personal.eMailAuto
Editar=S
3D=S
Tamano=22
ColorFondo=Blanco

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Edición
NombreDesplegar=Tareas
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.PuedeEditar, Verdadero)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Personal:Personal.Personal)<BR>Asigna(Info.Proyecto, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Aspiraciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Aspiraciones
Clave=Aspiraciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Aspiraciones.Personal.AspiraSueldo]
Carpeta=Aspiraciones
Clave=Personal.AspiraSueldo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Aspiraciones.Personal.AspiraDepartamento]
Carpeta=Aspiraciones
Clave=Personal.AspiraDepartamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Aspiraciones.Personal.AspiraGrupo]
Carpeta=Aspiraciones
Clave=Personal.AspiraGrupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Aspiraciones.Personal.AspiraPuesto]
Carpeta=Aspiraciones
Clave=Personal.AspiraPuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Aspiraciones.Personal.AspiraCategoria]
Carpeta=Aspiraciones
Clave=Personal.AspiraCategoria
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Aspiraciones.Personal.AspiraFecha]
Carpeta=Aspiraciones
Clave=Personal.AspiraFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Aspiraciones.Personal.Personal]
Carpeta=Aspiraciones
Clave=Personal.Personal
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Aspiraciones.NombreCompleto]
Carpeta=Aspiraciones
Clave=NombreCompleto
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Editar=S

[Acciones.Politica]
Nombre=Politica
Boton=22
Menu=&Edición
NombreDesplegar=Política
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Politica
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+O
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Rama, <T>PER<T>)<BR>Asigna(Info.Clave, Personal:Personal.Personal)

[Acciones.RefCta]
Nombre=RefCta
Boton=110
Menu=&Edición
NombreDesplegar=Referencias
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=RefCta
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>RH<T>)<BR>Asigna(Info.Cuenta, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)
Visible=S

[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.Forma, <T>Personal<T>)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Nombre, <T>Personal<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin

[RH.Personal.Incremento]
Carpeta=RH
Clave=Personal.Incremento
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=104
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
EspacioPrevio=S
Expresion=Si<BR>  General.CamposExtras=<T>Campos Extras<T><BR>Entonces<BR>  CamposExtrasContacto(<T>Personal<T>, Personal:Personal.Tipo, Personal:Personal.Personal)<BR>Sino<BR>  Asigna(Info.Aplica, <T>Personal<T>)<BR>  Asigna(Info.Clave, Personal:Personal.Personal)<BR>  Asigna(Info.Nombre, Personal:NombreCompleto)<BR>  Asigna(Info.Modulo, Nulo)<BR>  Asigna(Info.Mov, Nulo)<BR>  Asigna(Info.Categoria, Personal:Personal.Categoria)<BR>  Asigna(Info.Grupo, Personal:Personal.Grupo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Personal:Personal.Departamento)<BR>  Asigna(Info.Puesto, Personal:Personal.Puesto)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si(ConDatos(Info.FormaTipo), iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre), Informacion(<T>No Tiene Definida Ninguna Forma<T>))<BR>Fin
EjecucionCondicion=ConDatos(Personal:Personal.Personal)

[Acciones.Mensajes]
Nombre=Mensajes
Boton=112
Menu=&Ver
NombreDesplegar=Mensajes
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=OutlookPersonal
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
Antes=S
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)
Visible=S

[OtrosDatos.Personal.EsSocio]
Carpeta=OtrosDatos
Clave=Personal.EsSocio
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=10
ColorFondo=Blanco

[Nomina.Personal.DiasPeriodo]
Carpeta=Nomina
Clave=Personal.DiasPeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RH.Personal.IndemnizacionPct]
Carpeta=RH
Clave=Personal.IndemnizacionPct
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RH.Personal.Proyecto]
Carpeta=RH
Clave=Personal.Proyecto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.DatosAcademicos]
Nombre=DatosAcademicos
Boton=0
Menu=&Edición
NombreDesplegar=Datos Academicos
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalDatosAcademicos
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=GuardarCambios<BR>Asigna(Info.Personal, Personal:Personal.Personal)

[Acciones.DatosLaborales]
Nombre=DatosLaborales
Boton=0
Menu=&Edición
NombreDesplegar=Datos Laborales
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalDatosLaborales
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=GuardarCambios<BR>Asigna(Info.Personal, Personal:Personal.Personal)

[Acciones.PersonalHerman]
Nombre=PersonalHerman
Boton=0
Menu=&Edición
NombreDesplegar=Human Side - Herman
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PersonalHerman
Activo=S
ConCondicion=S
Antes=S

EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=GuardarCambios<BR>Asigna(Info.Personal, Personal:Personal.Personal)
[Acciones.PersonalSpranger]
Nombre=PersonalSpranger
Boton=0
Menu=&Edición
NombreDesplegar=Human Side - Spranger
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalSpranger
Activo=S
ConCondicion=S
Antes=S

EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=GuardarCambios<BR>Asigna(Info.Personal, Personal:Personal.Personal)
[Acciones.PersonalCleaver]
Nombre=PersonalCleaver
Boton=0
Menu=&Edición
NombreDesplegar=Human Side - Cleaver
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalCleaver
Activo=S
ConCondicion=S
Antes=S

EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=GuardarCambios<BR>Asigna(Info.Personal, Personal:Personal.Personal)
[Acciones.PersonalEntrada]
Nombre=PersonalEntrada
Boton=0
Menu=&Edición
NombreDesplegar=Horario &Entrada
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalEntrada
Activo=S
ConCondicion=S
Antes=S

EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)
[RH.Personal.Plaza]
Carpeta=RH
Clave=Personal.Plaza
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[RH.Plaza.Descripcion]
Carpeta=RH
Clave=Plaza.Descripcion
Editar=S
Tamano=20
ColorFondo=Plata
LineaNueva=S

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Características
Clave=FormaExtraValor
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraValor
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaSinBorde=S
HojaFondoGris=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
RefrescarAlEntrar=S
PermiteEditar=S
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisiblePersonal(<T>{Personal:Personal.Categoria}<T>, <T>{Personal:Personal.Grupo}<T>, <T>{Personal:Personal.Departamento}<T>, <T>{Personal:Personal.Puesto}<T>)) AND FormaExtraValor.Aplica=<T>Personal<T> AND FormaExtraValor.AplicaClave=<T>{Personal:Personal.Personal}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>

[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=293
VerValor=296

[Nomina.Personal.SueldoDiarioComplemento]
Carpeta=Nomina
Clave=Personal.SueldoDiarioComplemento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.SueldoDiarioBruto]
Carpeta=Nomina
Clave=SueldoDiarioBruto
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Detalle.Personal.Empresa]
Carpeta=Detalle
Clave=Personal.Empresa
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[OtrosDatos.Personal.NivelAcceso]
Carpeta=OtrosDatos
Clave=Personal.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.DireccionNumero]
Carpeta=Detalle
Clave=Personal.DireccionNumero
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=S
OcultaNombre=N

[Detalle.Personal.DireccionNumeroInt]
Carpeta=Detalle
Clave=Personal.DireccionNumeroInt
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=S
OcultaNombre=N
Pegado=N

[Perfiles]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Perfiles
Clave=Perfiles
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
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

[Perfiles.Personal.EsRecurso]
Carpeta=Perfiles
Clave=Personal.EsRecurso
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=40

[Perfiles.Personal.EsAgente]
Carpeta=Perfiles
Clave=Personal.EsAgente
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=40

[Perfiles.Personal.EsUsuarioWeb]
Carpeta=Perfiles
Clave=Personal.EsUsuarioWeb
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Historico]
Nombre=Historico
Boton=0
Menu=&Ver
EsDefault=S
NombreDesplegar=Histórico de Cambios
EnMenu=S
TipoAccion=Expresion
Visible=S
Activo=S
ConCondicion=S
Antes=S

Expresion=Asigna(Info.Tabla, <T>Personal<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Nombre,Personal:Personal.ApellidoPaterno & <T> <T> & Personal:Personal.ApellidoMaterno & <T> <T> & Personal:Personal.Nombre)
[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285

[OtrosDatos.Personal.Confidencial]
Carpeta=OtrosDatos
Clave=Personal.Confidencial
Editar=S
LineaNueva=S
3D=S
Tamano=12
ColorFondo=Blanco

[(Carpeta Abrir).NombreCompleto2]
Carpeta=(Carpeta Abrir)
Clave=NombreCompleto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Nomina.ListaEnCaptura]
(Inicio)=Personal.Personal
Personal.Personal=NombreCompleto
NombreCompleto=Personal.MovNomina
Personal.MovNomina=Personal.FormaPago
Personal.FormaPago=Personal.PersonalSucursal
Personal.PersonalSucursal=Personal.PersonalCuenta
Personal.PersonalCuenta=Personal.CtaDinero
Personal.CtaDinero=CtaDineroDestino.Descripcion
CtaDineroDestino.Descripcion=Personal.Vehiculo
Personal.Vehiculo=Vehiculo.Descripcion
Vehiculo.Descripcion=Vehiculo.Placas
Vehiculo.Placas=Personal.Registro4
Personal.Registro4=Personal.Afore
Personal.Afore=Prov.Nombre
Prov.Nombre=Personal.Sindicato
Personal.Sindicato=Personal.ZonaEconomica
Personal.ZonaEconomica=Personal.MinimoProfesional
Personal.MinimoProfesional=MinimosProfesionales.Descripcion
MinimosProfesionales.Descripcion=SueldoMinimoProfesional
SueldoMinimoProfesional=Personal.DiasPeriodo
Personal.DiasPeriodo=Personal.PeriodoTipo
Personal.PeriodoTipo=Personal.Jornada
Personal.Jornada=Personal.TipoContrato
Personal.TipoContrato=Personal.VencimientoContrato
Personal.VencimientoContrato=Personal.TipoSueldo
Personal.TipoSueldo=Personal.SueldoDiario
Personal.SueldoDiario=Personal.SDI
Personal.SDI=Personal.Moneda
Personal.Moneda=Personal.SueldoDiarioComplemento
Personal.SueldoDiarioComplemento=SueldoDiarioBruto
SueldoDiarioBruto=(Fin)

[ComisionesEsp.ListaEnCaptura]
(Inicio)=Personal.Personal
Personal.Personal=NombreCompleto
NombreCompleto=Personal.TablaCobranza
Personal.TablaCobranza=Personal.TablaCobranzaBono
Personal.TablaCobranzaBono=Personal.TablaCobranzaCascada
Personal.TablaCobranzaCascada=Personal.TablaCobranzaBonoCascada
Personal.TablaCobranzaBonoCascada=Personal.TablaVentaCascada
Personal.TablaVentaCascada=(Fin)

[Beneficiarios.ListaEnCaptura]
(Inicio)=Personal.Personal
Personal.Personal=NombreCompleto
NombreCompleto=Personal.Beneficiario
Personal.Beneficiario=Personal.Parentesco
Personal.Parentesco=Personal.BeneficiarioNacimiento
Personal.BeneficiarioNacimiento=Personal.Porcentaje
Personal.Porcentaje=Personal.Beneficiario2
Personal.Beneficiario2=Personal.Parentesco2
Personal.Parentesco2=Personal.Beneficiario2Nacimiento
Personal.Beneficiario2Nacimiento=Personal.Porcentaje2
Personal.Porcentaje2=Personal.Beneficiario3
Personal.Beneficiario3=Personal.Parentesco3
Personal.Parentesco3=Personal.Beneficiario3Nacimiento
Personal.Beneficiario3Nacimiento=Personal.Porcentaje3
Personal.Porcentaje3=Personal.Beneficiario4
Personal.Beneficiario4=Personal.Parentesco4
Personal.Parentesco4=Personal.Beneficiario4Nacimiento
Personal.Beneficiario4Nacimiento=Personal.Porcentaje4
Personal.Porcentaje4=Personal.Beneficiario5
Personal.Beneficiario5=Personal.Parentesco5
Personal.Parentesco5=Personal.Beneficiario5Nacimiento
Personal.Beneficiario5Nacimiento=Personal.Porcentaje5
Personal.Porcentaje5=Personal.Beneficiario6
Personal.Beneficiario6=Personal.Parentesco6
Personal.Parentesco6=Personal.Beneficiario6Nacimiento
Personal.Beneficiario6Nacimiento=Personal.Porcentaje6
Personal.Porcentaje6=Personal.Beneficiario7
Personal.Beneficiario7=Personal.Parentesco7
Personal.Parentesco7=Personal.Beneficiario7Nacimiento
Personal.Beneficiario7Nacimiento=Personal.Porcentaje7
Personal.Porcentaje7=Personal.Beneficiario8
Personal.Beneficiario8=Personal.Parentesco8
Personal.Parentesco8=Personal.Beneficiario8Nacimiento
Personal.Beneficiario8Nacimiento=Personal.Porcentaje8
Personal.Porcentaje8=(Fin)


[Aspiraciones.ListaEnCaptura]
(Inicio)=Personal.Personal
Personal.Personal=NombreCompleto
NombreCompleto=Personal.AspiraFecha
Personal.AspiraFecha=Personal.AspiraSueldo
Personal.AspiraSueldo=Personal.AspiraDepartamento
Personal.AspiraDepartamento=Personal.AspiraGrupo
Personal.AspiraGrupo=Personal.AspiraPuesto
Personal.AspiraPuesto=Personal.AspiraCategoria
Personal.AspiraCategoria=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)

[Perfiles.ListaEnCaptura]
(Inicio)=Personal.EsRecurso
Personal.EsRecurso=Personal.EsAgente
Personal.EsAgente=Personal.EsUsuarioWeb
Personal.EsUsuarioWeb=Personal.MES
Personal.MES=(Fin)

[Perfiles.Personal.MES]
Carpeta=Perfiles
Clave=Personal.MES
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Detalle.Personal.EntreCalles]
Carpeta=Detalle
Clave=Personal.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.Plano]
Carpeta=Detalle
Clave=Personal.Plano
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Personal.Observaciones]
Carpeta=Detalle
Clave=Personal.Observaciones
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Mapa]
Nombre=Mapa
Boton=105
Menu=&Ver
NombreDesplegar=&Mapa
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S

Expresion=Mapa.Borrar<BR>Mapa.Agregar(<T>Personal<T>, Personal:Personal.Personal)<BR>PlugIn(<T>Mapa<T>, <T>Personal<T>, <T>Posicionar<T>)
Visible=S
[Acciones.MapaTodos]
Nombre=MapaTodos
Boton=0
NombreDesplegar=Ver Mapa (&Todos)
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Mapa.Borrar<BR>RegistrarListaSt(<T>(Carpeta Abrir)<T>, <T>PersonalA.Personal<T>)<BR>Mapa.AgregarListaSt(<T>Personal<T>)<BR>PlugIn(<T>Mapa<T>, <T>Personal<T>, <T>Posicionar<T>)
[Acciones.MapaSeleccion]
Nombre=MapaSeleccion
Boton=0
NombreDesplegar=Ver Mapa (&Selección)
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Mapa.Borrar<BR>RegistrarListaSt(<T>(Carpeta Abrir)<T>, <T>PersonalA.Personal<T>, Verdadero)<BR>Mapa.AgregarListaSt(<T>Personal<T>)<BR>PlugIn(<T>Mapa<T>, <T>Personal<T>, <T>Posicionar<T>)
[SituacionCta]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Situaciones por Area
Clave=SituacionCta
Filtros=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=SituacionCta
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosSubTitulo=<T>Area<T>
ListaEnCaptura=(Lista)
IconosNombre=SituacionCta:SituacionCta.Area
FiltroGeneral=SituacionCta.Rama=<T>RH<T> AND SituacionCta.Cuenta=<T>{Personal:Personal.Personal}<T>
CondicionVisible=General.SituacionesPorArea

[SituacionCta.SituacionCta.Situacion]
Carpeta=SituacionCta
Clave=SituacionCta.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[SituacionCta.SituacionCta.SituacionFecha]
Carpeta=SituacionCta
Clave=SituacionCta.SituacionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SituacionCta.SituacionCta.SituacionUsuario]
Carpeta=SituacionCta
Clave=SituacionCta.SituacionUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SituacionCta.SituacionCta.SituacionNota]
Carpeta=SituacionCta
Clave=SituacionCta.SituacionNota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[SituacionCta.ListaEnCaptura]
(Inicio)=SituacionCta.Situacion
SituacionCta.Situacion=SituacionCta.SituacionFecha
SituacionCta.SituacionFecha=SituacionCta.SituacionUsuario
SituacionCta.SituacionUsuario=SituacionCta.SituacionNota
SituacionCta.SituacionNota=(Fin)

[Acciones.PersonalCompetencia]
Nombre=PersonalCompetencia
Boton=74
Menu=&Edición
NombreDesplegar=&Competencias...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalCompetencia
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)

[Acciones.Competencia]
Nombre=Competencia
Boton=0
Menu=&Maestros
NombreDesplegar=&Competencias
EnMenu=S
TipoAccion=Formas
ClaveAccion=Competencia
Activo=S
Visible=S



[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos menos uno)
(Todos menos uno)=ASPIRANTE
ASPIRANTE=CANDIDATO
CANDIDATO=ALTA
ALTA=FINIQUITADO
FINIQUITADO=BAJA
BAJA=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=Actualizar
Actualizar=Imprimir
Imprimir=preliminar
preliminar=Excel
Excel=MapaTodos
MapaTodos=MapaSeleccion
MapaSeleccion=Campos
Campos=(Fin)




















[RH.Personal.NominaProrrateo]
Carpeta=RH
Clave=Personal.NominaProrrateo
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco





LineaNueva=S
[Acciones.NominaProrrateo]
Nombre=NominaProrrateo
Boton=0
Menu=&Maestros
NombreDesplegar=Prorrateo Nómina
EnMenu=S
TipoAccion=Formas
ClaveAccion=NominaProrrateo
Activo=S
Visible=S





[Acciones.ProrrateoConcepto]
Nombre=ProrrateoConcepto
Boton=0
Menu=&Maestros
NombreDesplegar=Conceptos Prorrateo
EnMenu=S
TipoAccion=Formas
ClaveAccion=NominaProrrateoConcepto
Activo=S
Visible=S





[RH.ListaEnCaptura]
(Inicio)=Personal.Personal
Personal.Personal=NombreCompleto
NombreCompleto=Personal.ReportaA
Personal.ReportaA=NombreReporta
NombreReporta=Personal.CentroCostos
Personal.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=Personal.Reclutador
Personal.Reclutador=NombreReclutador
NombreReclutador=Personal.SucursalTrabajo
Personal.SucursalTrabajo=Sucursal.Nombre
Sucursal.Nombre=Personal.RecomendadoPor
Personal.RecomendadoPor=NombreRecomendadoPor
NombreRecomendadoPor=Personal.UEN
Personal.UEN=UEN.Nombre
UEN.Nombre=Personal.Area
Personal.Area=Personal.Fuente
Personal.Fuente=Personal.Proyecto
Personal.Proyecto=Personal.NivelAcademico
Personal.NivelAcademico=Personal.Valuacion
Personal.Valuacion=Personal.Incremento
Personal.Incremento=Personal.FechaAntiguedad
Personal.FechaAntiguedad=Antiguedad
Antiguedad=Personal.UltimoPago
Personal.UltimoPago=Personal.IndemnizacionPct
Personal.IndemnizacionPct=Personal.FechaAlta
Personal.FechaAlta=Personal.UltimaModificacion
Personal.UltimaModificacion=Personal.FechaBaja
Personal.FechaBaja=Personal.ConceptoBaja
Personal.ConceptoBaja=Personal.Plaza
Personal.Plaza=Personal.Departamento
Personal.Departamento=Personal.Puesto
Personal.Puesto=Plaza.Descripcion
Plaza.Descripcion=Departamento.Descripcion
Departamento.Descripcion=Puesto.Descripcion
Puesto.Descripcion=Personal.Categoria
Personal.Categoria=Personal.Grupo
Personal.Grupo=PersonalCat.Descripcion
PersonalCat.Descripcion=PersonalGrupo.Descripcion
PersonalGrupo.Descripcion=Personal.NominaProrrateo
Personal.NominaProrrateo=(Fin)






[OtrosDatos.Personal.Contrasena]
Carpeta=OtrosDatos
Clave=Personal.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















[OtrosDatos.ListaEnCaptura]
(Inicio)=Personal.Personal
Personal.Personal=NombreCompleto
NombreCompleto=Personal.NivelAcceso
Personal.NivelAcceso=Personal.Cliente
Personal.Cliente=Cte.Nombre
Cte.Nombre=Personal.Contrasena
Personal.Contrasena=Personal.Cuenta
Personal.Cuenta=Cta.Descripcion
Cta.Descripcion=Personal.CuentaRetencion
Personal.CuentaRetencion=CtaRetencion.Descripcion
CtaRetencion.Descripcion=Personal.Cartilla
Personal.Cartilla=Personal.Permiso
Personal.Permiso=Personal.Referencia
Personal.Referencia=Personal.ReferenciaDireccion
Personal.ReferenciaDireccion=Personal.ReferenciaTelefono
Personal.ReferenciaTelefono=Personal.Referencia2
Personal.Referencia2=Personal.Referencia2Direccion
Personal.Referencia2Direccion=Personal.Referencia2Telefono
Personal.Referencia2Telefono=Personal.Referencia3
Personal.Referencia3=Personal.Referencia3Direccion
Personal.Referencia3Direccion=Personal.Referencia3Telefono
Personal.Referencia3Telefono=Personal.EsSocio
Personal.EsSocio=Personal.Confidencial
Personal.Confidencial=(Fin)



















































[Detalle.Personal.MapaUbicacion]
Carpeta=Detalle
Clave=Personal.MapaUbicacion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco










[Detalle.ListaEnCaptura]
(Inicio)=Personal.Personal
Personal.Personal=Personal.Tipo
Personal.Tipo=EstatusNombre
EstatusNombre=Personal.Empresa
Personal.Empresa=Personal.ApellidoPaterno
Personal.ApellidoPaterno=Personal.ApellidoMaterno
Personal.ApellidoMaterno=Personal.Nombre
Personal.Nombre=Personal.Direccion
Personal.Direccion=Personal.DireccionNumero
Personal.DireccionNumero=Personal.DireccionNumeroInt
Personal.DireccionNumeroInt=Personal.EntreCalles
Personal.EntreCalles=Personal.Plano
Personal.Plano=Personal.Observaciones
Personal.Observaciones=Personal.Delegacion
Personal.Delegacion=Personal.Colonia
Personal.Colonia=Personal.CodigoPostal
Personal.CodigoPostal=Personal.Poblacion
Personal.Poblacion=Personal.Estado
Personal.Estado=Personal.Pais
Personal.Pais=Personal.MapaUbicacion
Personal.MapaUbicacion=Personal.Telefono
Personal.Telefono=Personal.eMail
Personal.eMail=Personal.eMailAuto
Personal.eMailAuto=Personal.Sexo
Personal.Sexo=Personal.Nacionalidad
Personal.Nacionalidad=Personal.FechaNacimiento
Personal.FechaNacimiento=Personal.LugarNacimiento
Personal.LugarNacimiento=Personal.EstadoCivil
Personal.EstadoCivil=Personal.Pasaporte
Personal.Pasaporte=Personal.Licencia
Personal.Licencia=Personal.LicenciaVencimiento
Personal.LicenciaVencimiento=Personal.Hijos
Personal.Hijos=Personal.Dependientes
Personal.Dependientes=Personal.UnidadMedica
Personal.UnidadMedica=Personal.Padre
Personal.Padre=Personal.Madre
Personal.Madre=Personal.Registro
Personal.Registro=Personal.Registro2
Personal.Registro2=Personal.Registro3
Personal.Registro3=(Fin)





[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Beneficiarios
Beneficiarios=RH
RH=Aspiraciones
Aspiraciones=Nomina
Nomina=ComisionesEsp
ComisionesEsp=OtrosDatos
OtrosDatos=Perfiles
Perfiles=FormaExtraValor
FormaExtraValor=SituacionCta
SituacionCta=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar Cambios
Guardar Cambios=Situacion
Situacion=PlantillasOffice
PlantillasOffice=Eliminar
Eliminar=Alta Express
Alta Express=CamposExtras
CamposExtras=PersonalCompetencia
PersonalCompetencia=CalcSueldo
CalcSueldo=Tareas
Tareas=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Anexos
Anexos=Doc
Doc=Politica
Politica=RefCta
RefCta=Sucursales
Sucursales=PersonalAcceso
PersonalAcceso=PersonalCfg
PersonalCfg=PersonalEntrada
PersonalEntrada=Info
Info=Mapa
Mapa=Cubos
Cubos=Mensajes
Mensajes=PersonalParecidos
PersonalParecidos=PersonalUltimoPago
PersonalUltimoPago=Navegador
Navegador=Cerrar
Cerrar=Competencia
Competencia=Puesto
Puesto=Departamento
Departamento=PersonalCat
PersonalCat=PersonalGrupo
PersonalGrupo=Nacionalidad
Nacionalidad=NivelAcademico
NivelAcademico=PersonalValuacion
PersonalValuacion=ZonaEconomica
ZonaEconomica=Sindicato
Sindicato=Area
Area=Fuente
Fuente=DatosAcademicos
DatosAcademicos=DatosLaborales
DatosLaborales=PersonalHerman
PersonalHerman=PersonalSpranger
PersonalSpranger=PersonalCleaver
PersonalCleaver=Historico
Historico=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=NominaProrrateo
NominaProrrateo=ProrrateoConcepto
ProrrateoConcepto=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)

[Forma.PlantillasExcepciones]
(Inicio)=Personal:Personal.SueldoDiario
Personal:Personal.SueldoDiario=Personal:Personal.SDI
Personal:Personal.SDI=Personal:Personal.FechaAlta
Personal:Personal.FechaAlta=Personal:Personal.FechaAntiguedad
Personal:Personal.FechaAntiguedad=Personal:Personal.FechaBaja
Personal:Personal.FechaBaja=Personal:Personal.UltimaModificacion
Personal:Personal.UltimaModificacion=Personal:Personal.VencimientoContrato
Personal:Personal.VencimientoContrato=Personal:Personal.Estatus
Personal:Personal.Estatus=Personal:Personal.UltimoPago
Personal:Personal.UltimoPago=Personal:Personal.TipoSueldo
Personal:Personal.TipoSueldo=Personal:Personal.Departamento
Personal:Personal.Departamento=Personal:Personal.TipoContrato
Personal:Personal.TipoContrato=Personal:Personal.ZonaEconomica
Personal:Personal.ZonaEconomica=Personal:Personal.Grupo
Personal:Personal.Grupo=Personal:Personal.Puesto
Personal:Personal.Puesto=Personal:Personal.PeriodoTipo
Personal:Personal.PeriodoTipo=Personal:Personal.Jornada
Personal:Personal.Jornada=Personal:Personal.Moneda
Personal:Personal.Moneda=Personal:Personal.Categoria
Personal:Personal.Categoria=(Fin)
